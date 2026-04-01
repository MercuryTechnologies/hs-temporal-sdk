{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

{- | Temporal.Replay supports replaying a workflow from its event history. Use for troubleshooting and backwards compatibility unit tests.

For example, if a workflow fails, in production, then its history can be downloaded through the UI or CLI and replayed in a debugger as many times as necessary.

Use 'newReplayWorker' to create unit tests that check if workflow changes are backwards compatible. It is important to maintain backwards compatibility to ensure that new deployments are not going to break open workflows.

Histories exported from the Temporal UI or CLI are in protobuf canonical JSON format.
Use 'readHistoryJsonFile' to load these, then feed them to 'runReplayHistoryJson' from
"Temporal.Worker".
-}
module Temporal.Replay (
  readHistoryProtobufFile,
  readHistoryProtobufFileRaw,
  writeHistoryProtobufFile,
  readHistoryJsonFile,
) where

import Control.Exception
import Control.Monad.IO.Class
import qualified Data.ByteString as BS
import Data.ProtoLens
import Proto.Temporal.Api.History.V1.Message


data InvalidHistoryException = InvalidHistoryProtobufException String
  deriving stock (Show, Eq)
  deriving anyclass (Exception)


readHistoryProtobufFile :: MonadIO m => FilePath -> m History
readHistoryProtobufFile fp = liftIO $ do
  res <- decodeMessage <$> BS.readFile fp
  case res of
    Left err -> throwIO $ InvalidHistoryProtobufException err
    Right ok -> pure ok


{- | Read raw protobuf bytes from a history file without decoding through proto-lens.
Pass the result to 'Temporal.Worker.runReplayHistoryProto' along with the workflow ID.
-}
readHistoryProtobufFileRaw :: MonadIO m => FilePath -> m BS.ByteString
readHistoryProtobufFileRaw fp = liftIO $ BS.readFile fp


writeHistoryProtobufFile :: FilePath -> History -> IO ()
writeHistoryProtobufFile fp hist = BS.writeFile fp (encodeMessage hist)


{- | Read a workflow history JSON file exported from the Temporal UI or CLI.
Returns the raw bytes to be passed to 'Temporal.Worker.runReplayHistoryJson'
or 'Temporal.Core.Worker.pushHistoryJson'. The JSON is deserialized on the
Rust side where protobuf canonical JSON is properly supported.
-}
readHistoryJsonFile :: MonadIO m => FilePath -> m BS.ByteString
readHistoryJsonFile fp = liftIO $ BS.readFile fp

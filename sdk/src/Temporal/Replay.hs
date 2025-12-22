{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

{- | Temporal.Replay supports replaying a workflow from its event history. Use for troubleshooting and backwards compatibility unit tests.

For example, if a workflow fails, in production, then its history can be downloaded through the UI or CLI and replayed in a debugger as many times as necessary.

Use 'newReplayWorker' to create unit tests that check if workflow changes are backwards compatible. It is important to maintain backwards compatibility to ensure that new deployments are not going to break open workflows.
-}
module Temporal.Replay (
  readHistoryProtobufFile,
  writeHistoryProtobufFile,
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


writeHistoryProtobufFile :: FilePath -> History -> IO ()
writeHistoryProtobufFile fp hist = BS.writeFile fp (encodeMessage hist)

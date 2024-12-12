{-# LANGUAGE DuplicateRecordFields #-}

module Temporal.Runtime (
  Runtime,
  TelemetryOptions (..),
  Periodicity (..),
  initializeRuntime,
  withRuntime,
  fetchLogs,
  CoreLog (..),
  LogLevel (..),
) where

import Control.Concurrent
import Control.Exception
import Data.Aeson
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import Foreign.C.String
import Foreign.C.Types (CInt)
import Foreign.ForeignPtr
import Foreign.Marshal
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.Storable
import System.IO.Unsafe
import Temporal.Core.CTypes
import Temporal.Internal.FFI


-- | Initialize the Rust runtime and thread-pool.
initializeRuntime :: TelemetryOptions -> IO Runtime
initializeRuntime opts = withCArrayBS (BL.toStrict $ encode opts) $ \optsP ->
  mask_ $ do
    rtP <- initRuntime optsP tryPutMVarPtr
    Runtime <$> newForeignPtr freeRuntime rtP


-- | Access the underlying 'Runtime' pointer for calling out to Rust.
withRuntime :: Runtime -> (Ptr Runtime -> IO a) -> IO a
withRuntime (Runtime rvar) = withForeignPtr rvar


{- | The Rust runtime exports logs to the Haskell runtime. This function fetches
those logs so they can be fed through a logging framework.
-}
fetchLogs :: Runtime -> IO (V.Vector CoreLog)
fetchLogs r = withRuntime r $ \p -> do
  bracket (raw_fetchLogs p) raw_freeLogs $ \clogs -> do
    logs <- peek clogs
    vec <- cArrayToVector cArrayToByteString logs
    V.mapM throwDecodeStrict vec

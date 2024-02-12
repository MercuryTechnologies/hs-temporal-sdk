{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE DuplicateRecordFields #-}
module Temporal.Runtime
  ( Runtime
  , globalRuntime
  , initializeRuntime
  , destroyRuntime
  , withRuntime
  , fetchLogs
  , CoreLog(..)
  , LogLevel(..)
  ) where
import Control.Concurrent
import Control.Exception
import Data.Aeson
import qualified Data.Vector as V
import Foreign.C.Types (CInt)
import Foreign.C.String
import Foreign.ForeignPtr
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.Marshal
import Foreign.Storable
import Temporal.Core.CTypes
import Temporal.Internal.FFI
import System.IO.Unsafe

globalRuntime :: Runtime
globalRuntime = unsafePerformIO initializeRuntime
{-# NOINLINE globalRuntime #-}

-- | Initialize the Rust runtime and thread-pool.
initializeRuntime :: IO Runtime
initializeRuntime = Runtime <$> initRuntime tryPutMVarPtr

destroyRuntime :: Runtime -> IO ()
destroyRuntime (Runtime rvar) = freeRuntime rvar

-- | Access the underlying 'Runtime' pointer for calling out to Rust.
withRuntime :: Runtime -> (Ptr Runtime -> IO a) -> IO a
withRuntime (Runtime rvar) f = f rvar


-- | The Rust runtime exports logs to the Haskell runtime. This function fetches
-- those logs so they can be fed through a logging framework.
fetchLogs :: Runtime -> IO (V.Vector CoreLog)
fetchLogs r = withRuntime r $ \p -> do
  bracket (raw_fetchLogs p) raw_freeLogs $ \clogs -> do
    logs <- peek clogs
    vec <- cArrayToVector cArrayToByteString logs
    V.mapM throwDecodeStrict vec

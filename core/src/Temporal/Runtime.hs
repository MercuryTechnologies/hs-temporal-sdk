module Temporal.Runtime
  ( Runtime
  , globalRuntime
  , initializeRuntime
  , withRuntime
  , fetchLogs
  , CoreLog(..)
  ) where
import Control.Concurrent
import Control.Exception
import qualified Data.Vector as V
import GHC.Conc (newStablePtrPrimMVar, PrimMVar)
import Foreign.C.Types (CInt)
import Foreign.C.String
import Foreign.ForeignPtr
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.Marshal
import Foreign.Storable
import Temporal.Internal.FFI
import System.IO.Unsafe

-- | A handle to the Rust Tokio runtime and thread-pool.
--
-- You almost always should use the 'globalRuntime' value, which is initialized
-- once for the entire process.
newtype Runtime = Runtime { runtime :: MVar (ForeignPtr Runtime) }

type TryPutMVarFFI = FunPtr (Ptr CInt -> Ptr (MVar ()) -> IO ())
foreign import ccall "&hs_try_putmvar" tryPutMVarPtr :: TryPutMVarFFI

foreign import ccall "hs_temporal_init_runtime" initRuntime :: TryPutMVarFFI -> IO (Ptr Runtime)
foreign import ccall "&hs_temporal_free_runtime" freeRuntime :: FunPtr (Ptr Runtime -> IO ())

globalRuntime :: Runtime
globalRuntime = unsafePerformIO initializeRuntime
{-# NOINLINE globalRuntime #-}

-- | Initialize the Rust runtime and thread-pool.
initializeRuntime :: IO Runtime
initializeRuntime = Runtime <$> (newMVar =<< newForeignPtr freeRuntime =<< initRuntime tryPutMVarPtr)

-- | Access the underlying 'Runtime' pointer for calling out to Rust.
withRuntime :: Runtime -> (Ptr Runtime -> IO a) -> IO a
withRuntime (Runtime rvar) f = withMVar rvar $ \r -> withForeignPtr r f

foreign import ccall "hs_temporal_runtime_fetch_logs" raw_fetchLogs :: Ptr Runtime -> IO (Ptr (CArray CCoreLog))
foreign import ccall "hs_temporal_runtime_free_logs" raw_freeLogs :: Ptr (CArray CCoreLog) -> IO ()

-- | The Rust runtime exports logs to the Haskell runtime. This function fetches
-- those logs so they can be fed through a logging framework.
fetchLogs :: Runtime -> IO (V.Vector CoreLog)
fetchLogs r = withRuntime r $ \p -> do
  bracket (raw_fetchLogs p) raw_freeLogs $ \clogs -> do
    logs <- peek clogs
    V.generateM (fromIntegral (cArrayLen logs)) $ \i -> do
      let logSpot = cArrayPtr logs `plusPtr` (i * sizeOf (undefined :: CCoreLog))
      cCoreLog <- peek logSpot
      peekCoreLog cCoreLog

data CCoreLog = CCoreLog
  { cCoreLogLevel :: CString
  , cCoreLogMessage :: CString
  }

instance Storable CCoreLog where
  sizeOf = const (sizeOf (undefined :: CString) + sizeOf (undefined :: CString))
  alignment = const 8
  peek ptr = CCoreLog <$> peekByteOff ptr 0 <*> peekByteOff ptr (sizeOf (undefined :: CString))
  poke ptr (CCoreLog level message) = do
    pokeByteOff ptr 0 level
    pokeByteOff ptr (sizeOf (undefined :: CString)) message

data CoreLog = CoreLog
  { coreLogLevel :: String
  , coreLogMessage :: String
  } deriving (Show, Eq)

peekCoreLog :: CCoreLog -> IO CoreLog
peekCoreLog clog = do
  level <- peekCString (cCoreLogLevel clog)
  message <- peekCString (cCoreLogMessage clog)
  pure $ CoreLog level message

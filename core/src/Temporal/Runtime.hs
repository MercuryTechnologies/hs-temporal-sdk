module Temporal.Runtime
  ( Runtime
  , initializeRuntime
  , withRuntime
  , fetchLogs
  , CoreLog(..)
  ) where
import Control.Concurrent
import Control.Exception
import qualified Data.Vector as V
import GHC.Conc (newStablePtrPrimMVar, PrimMVar)
import Foreign.C.String
import Foreign.ForeignPtr
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.Marshal
import Foreign.Storable
import Temporal.Internal.FFI

newtype Runtime = Runtime { runtime :: ForeignPtr Runtime }

foreign import ccall "hs_temporal_init_runtime" initRuntime :: IO (Ptr Runtime)
foreign import ccall "&hs_temporal_free_runtime" freeRuntime :: FunPtr (Ptr Runtime -> IO ())

initializeRuntime :: IO Runtime
initializeRuntime = Runtime <$> (newForeignPtr freeRuntime =<< initRuntime)

withRuntime :: Runtime -> (Ptr Runtime -> IO a) -> IO a
withRuntime (Runtime r) = withForeignPtr r

foreign import ccall "hs_temporal_runtime_fetch_logs" raw_fetchLogs :: Ptr Runtime -> IO (Ptr (CArray CCoreLog))
foreign import ccall "hs_temporal_runtime_free_logs" raw_freeLogs :: Ptr (CArray CCoreLog) -> IO ()

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

module Temporal.Runtime
  ( Runtime
  , initializeRuntime
  , withRuntime
  ) where
import Control.Concurrent
import Control.Exception
import GHC.Conc (newStablePtrPrimMVar, PrimMVar)
import Foreign.ForeignPtr
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.Marshal
import Foreign.Storable

newtype Runtime = Runtime { runtime :: ForeignPtr Runtime }

foreign import ccall "hs_temporal_init_runtime" initRuntime :: IO (Ptr Runtime)
foreign import ccall "&hs_temporal_free_runtime" freeRuntime :: FunPtr (Ptr Runtime -> IO ())

initializeRuntime :: IO Runtime
initializeRuntime = Runtime <$> (newForeignPtr freeRuntime =<< initRuntime)

withRuntime :: Runtime -> (Ptr Runtime -> IO a) -> IO a
withRuntime (Runtime r) = withForeignPtr r


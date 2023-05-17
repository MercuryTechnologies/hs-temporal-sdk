{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
module Temporal.Internal.FFI where
import Control.Concurrent
import Control.Exception
import Control.Monad
import Data.Coerce
import Data.Proxy
import Data.Word
import Data.Text (Text)
import qualified Data.Text.Foreign as Text
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal.Alloc
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.Storable
import GHC.Conc (newStablePtrPrimMVar, PrimMVar)

class ManagedRustValue r where
  type RustRef r :: *
  type HaskellRep r :: *
  fromRust :: proxy r -> RustRef r -> IO (HaskellRep r)

data RustCStringLen = RustCStringLen
  { rustCStringLenBytes :: CString
  , rustCStringLenLen :: CSize
  }

instance Storable RustCStringLen where
  sizeOf = const (sizeOf (undefined :: CString) + sizeOf (undefined :: CSize))
  alignment = const 8
  peek ptr = RustCStringLen <$> peekByteOff ptr 0 <*> peekByteOff ptr (sizeOf (undefined :: CString))
  poke ptr (RustCStringLen bytes len) = do
    pokeByteOff ptr 0 bytes
    pokeByteOff ptr (sizeOf (undefined :: CString)) len

foreign import ccall "hs_temporal_drop_cstring" rust_drop_cstring :: Ptr RustCStringLen -> IO ()
instance ManagedRustValue RustCStringLen where
  type RustRef RustCStringLen = Ptr RustCStringLen
  type HaskellRep RustCStringLen = Text
  fromRust _ rustPtr = mask_ $ do
    (RustCStringLen bytes len) <- peek rustPtr
    txt <- Text.peekCStringLen (bytes, fromIntegral len)
    rust_drop_cstring rustPtr
    pure txt

newtype TokioResult a = TokioResult (Ptr (RustRef a))

withTokioResult :: (RustRef a ~ Ptr a) => (TokioResult a -> IO b) -> IO b
withTokioResult f = alloca $ \ptr -> do
  poke ptr nullPtr
  f (TokioResult ptr)

peekTokioResult :: (ManagedRustValue a, RustRef a ~ Ptr a) => TokioResult a -> (RustRef a -> IO b) -> IO (Maybe b)
peekTokioResult (TokioResult ptr) f = do
  inner <- peek ptr
  if (inner == nullPtr)
    then return Nothing
    else Just <$> f inner

type TokioCall e a = StablePtr PrimMVar -> Int -> TokioResult e -> TokioResult a -> IO ()

-- Dropping can't be done automatically if the result is returned without async exceptions
-- intervening, because we don't want to drop things like `Client` while they're still in use.
-- So we should return ForeignPtrs for things that need to stay alive, and then we can drop when we're done.
makeTokioAsyncCall :: (ManagedRustValue e, RustRef e ~ Ptr e, ManagedRustValue a, RustRef a ~ Ptr a) 
  => TokioCall e a 
  -> (RustRef e -> IO f)
  -> (RustRef a -> IO b)
  -> IO (Either f b)
makeTokioAsyncCall call readErr readSuccess = mask_ $ do
  mvar <- newEmptyMVar
  sp <- newStablePtrPrimMVar mvar
  withTokioResult $ \errorSlot -> withTokioResult $ \resultSlot -> do
    let peekEither = do
          putStrLn "Peeking error"
          e <- peekTokioResult errorSlot readErr
          case e of
            Nothing -> do
              putStrLn "Peeking result"
              r <- peekTokioResult resultSlot readSuccess
              case r of
                Nothing -> error "Both error and result are null"
                Just r -> return (Right r)
            Just e -> return (Left e)

    (cap, _) <- threadCapability =<< myThreadId
    putStrLn "Calling Rust"
    call sp cap errorSlot resultSlot
    putStrLn "Waiting for result"
    takeMVar mvar `onException`
      forkIO (takeMVar mvar >> void peekEither)
    putStrLn "Got result"
    peekEither

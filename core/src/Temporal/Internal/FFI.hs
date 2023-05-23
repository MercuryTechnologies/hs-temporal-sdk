{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
module Temporal.Internal.FFI where
import Control.Concurrent
import Control.Exception
import Control.Monad
import Data.ByteString (ByteString)
import qualified Data.ByteString as ByteString
import Data.Coerce
import Data.Proxy
import Data.Word
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Foreign as Text
import qualified Data.Vector.Storable as Vector
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal.Alloc
import qualified Foreign.Marshal.Utils as Marshal
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

data CArray a = CArray
  { cArrayPtr :: Ptr a
  , cArrayLen :: CSize
  }

instance Storable a => Storable (CArray a) where
  sizeOf = const (sizeOf (undefined :: Ptr a) + sizeOf (undefined :: CSize))
  alignment = const 8
  peek ptr = CArray <$> peekByteOff ptr 0 <*> peekByteOff ptr (sizeOf (undefined :: CString))
  poke ptr (CArray bytes len) = do
    pokeByteOff ptr 0 bytes
    pokeByteOff ptr (sizeOf (undefined :: CString)) len

withCArray :: Storable a => Vector.Vector a -> (Ptr (CArray a) -> IO b) -> IO b
withCArray v f = Vector.unsafeWith v $ \vPtr ->
  Marshal.with (CArray vPtr (fromIntegral (Vector.length v))) f

withCArrayBS :: ByteString -> (Ptr (CArray Word8) -> IO b) -> IO b
withCArrayBS bs f = ByteString.useAsCStringLen bs $ \(bytes, len) ->
  Marshal.with (CArray (castPtr bytes) (fromIntegral len)) f

withCArrayText :: Text -> (Ptr (CArray Word8) -> IO b) -> IO b
withCArrayText txt f = Text.withCStringLen txt $ \(bytes, len) ->
  Marshal.with (CArray (castPtr bytes) (fromIntegral len)) f


instance ManagedRustValue (CArray Word8) where
  type RustRef (CArray Word8) = Ptr (CArray Word8)
  type HaskellRep (CArray Word8) = ByteString
  fromRust _ rustPtr = mask_ $ do
    (CArray bytes len) <- peek rustPtr
    bs <- ByteString.packCStringLen (castPtr bytes, fromIntegral len)
    rust_drop_byte_array rustPtr
    pure bs

foreign import ccall "hs_temporal_drop_byte_array" rust_drop_byte_array :: Ptr (CArray Word8) -> IO ()
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

-- | Dropping can't be done automatically if the result is returned without async exceptions
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
          e <- peekTokioResult errorSlot readErr
          case e of
            Nothing -> do
              r <- peekTokioResult resultSlot readSuccess
              case r of
                Nothing -> error "Both error and result are null"
                Just r -> return (Right r)
            Just e -> return (Left e)

    (cap, _) <- threadCapability =<< myThreadId
    call sp cap errorSlot resultSlot
    takeMVar mvar `onException`
      forkIO (takeMVar mvar >> void peekEither)
    peekEither

data RpcError = RpcError
  { code :: Word32
  , message :: Text
  , details :: ByteString
  }
  deriving (Show)

-- nb: Alignment for C repr structs is not packed, so the alignment is based on the largest field size.
peekCrpcError :: Ptr RpcError -> IO RpcError 
peekCrpcError ptr = do
  code <- peekByteOff ptr 0
  message <- Text.pack <$> (peekByteOff ptr 8 >>= peekCString)
  details <- peekByteOff ptr 16 >>= \(CArray ptr len) -> ByteString.packCStringLen (ptr, fromIntegral len)
  pure RpcError{..}

foreign import ccall "hs_temporal_drop_rpc_error" rust_drop_rpc_error :: Ptr RpcError -> IO ()

instance ManagedRustValue RpcError where
  type RustRef RpcError = Ptr RpcError
  type HaskellRep RpcError = RpcError
  fromRust _ ptr = mask_ $ do
    err <- peekCrpcError ptr
    rust_drop_rpc_error ptr
    pure err
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
import Foreign.ForeignPtr
import Foreign.StablePtr
import Foreign.Storable
import GHC.Conc (newStablePtrPrimMVar, PrimMVar)
import Data.Kind (Type)
import Temporal.Core.CTypes

withCArray :: Storable a => Vector.Vector a -> (Ptr (CArray a) -> IO b) -> IO b
withCArray v f = Vector.unsafeWith v $ \vPtr ->
  Marshal.with (CArray vPtr (fromIntegral (Vector.length v))) f

withCArrayBS :: ByteString -> (Ptr (CArray Word8) -> IO b) -> IO b
withCArrayBS bs f = ByteString.useAsCStringLen bs $ \(bytes, len) ->
  Marshal.with (CArray (castPtr bytes) (fromIntegral len)) f

withCArrayText :: Text -> (Ptr (CArray Word8) -> IO b) -> IO b
withCArrayText txt f = Text.withCStringLen txt $ \(bytes, len) ->
  Marshal.with (CArray (castPtr bytes) (fromIntegral len)) f

withTokioResult :: TokioResult a -> (Ptr (Ptr a) -> IO b) -> IO b
withTokioResult fp f = withForeignPtr fp $ \ptr -> do
  poke ptr nullPtr
  f ptr

peekTokioResult :: TokioSlot a -> Maybe (FinalizerPtr a) -> IO (Maybe (ForeignPtr a))
peekTokioResult slot mfp = do
  inner <- peek slot
  if (inner == nullPtr)
    then return Nothing
    else Just <$> case mfp of
      Nothing -> newForeignPtr_ inner
      Just fp -> newForeignPtr fp inner

type TokioCall e a = StablePtr PrimMVar -> Int -> TokioSlot e -> TokioSlot a -> IO ()
type TokioSlot a = Ptr (Ptr a)
type TokioResult a = ForeignPtr (Ptr a)

-- | Dropping can't be done automatically if the result is returned without async exceptions
-- intervening, because we don't want to drop things like `Client` while they're still in use.
-- So we should return ForeignPtrs for things that need to stay alive, and then we can drop when we're done.
makeTokioAsyncCall 
  :: TokioCall err res
  -> (Maybe (FinalizerPtr err))
  -> (Maybe (FinalizerPtr res))
  -> IO (Either (ForeignPtr err) (ForeignPtr res))
makeTokioAsyncCall call readErr readSuccess = uninterruptibleMask $ \restore -> do
  mvar <- newEmptyMVar
  sp <- newStablePtrPrimMVar mvar
  errorSlot <- mallocForeignPtr
  resultSlot <- mallocForeignPtr 
  withForeignPtr errorSlot $ \err -> withForeignPtr resultSlot $ \res -> do
    let peekEither = do
          e <- peekTokioResult err readErr
          case e of
            Nothing -> do
              r <- peekTokioResult res readSuccess
              case r of
                Nothing -> error "Both error and result are null"
                Just r -> return (Right r)
            Just e -> return (Left e)

    (cap, _) <- threadCapability =<< myThreadId
    call sp cap err res
    let handleCleanup = forkIO $ do
          takeMVar mvar
          -- We still need to get the result out of the slot and into a ForeignPtr so that we can drop it
          void peekEither
    () <- restore (takeMVar mvar) `onException` handleCleanup
    peekEither


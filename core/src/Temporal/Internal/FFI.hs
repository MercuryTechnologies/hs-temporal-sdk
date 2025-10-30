{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

module Temporal.Internal.FFI where

import Control.Concurrent
import Control.Exception
import Control.Monad
import Data.ByteString (ByteString)
import qualified Data.ByteString as ByteString
import Data.Coerce
import Data.IORef
import Data.Kind (Type)
import Data.Proxy
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Foreign as Text
import qualified Data.Vector.Storable as Vector
import Data.Word
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal.Alloc
import qualified Foreign.Marshal.Utils as Marshal
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.Storable
import GHC.Conc (PrimMVar, newStablePtrPrimMVar)
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


-- | Peek the result from a Tokio slot. Returns the raw pointer or Nothing.
-- The caller is responsible for freeing the pointer using the appropriate drop function.
peekTokioResult :: TokioSlot a -> IO (Maybe (Ptr a))
peekTokioResult slot = do
  inner <- peek slot
  if inner == nullPtr
    then return Nothing
    else return (Just inner)


type TokioCall e a = StablePtr PrimMVar -> Int -> TokioSlot e -> TokioSlot a -> IO ()


type TokioSlot a = Ptr (Ptr a)


-- | Storage for Tokio async operation results
type TokioResult a = Ptr (Ptr a)


{- | Make an async call to Rust via Tokio. Returns raw Ptr that MUST be freed by the caller
using the appropriate drop function.

The caller is responsible for:
1. Calling the appropriate rust_drop* function on the result
2. Not using the pointer after freeing it

IMPORTANT: This is a low-level function. Prefer using makeTokioAsyncCallSafe or
withTokioAsyncCall for automatic memory management and exception safety.
-}
makeTokioAsyncCall
  :: TokioCall err res
  -> IO (Either (Ptr err) (Ptr res))
makeTokioAsyncCall call = bracket
  (do
    errorSlot <- malloc
    resultSlot <- malloc
    poke errorSlot nullPtr
    poke resultSlot nullPtr
    return (errorSlot, resultSlot))
  (\(errorSlot, resultSlot) -> do
    free errorSlot
    free resultSlot)
  (\(errorSlot, resultSlot) -> uninterruptibleMask $ \restore -> do
    mvar <- newEmptyMVar
    sp <- newStablePtrPrimMVar mvar
    (cap, _) <- threadCapability =<< myThreadId
    call sp cap errorSlot resultSlot

    -- Wait for completion
    () <- restore (takeMVar mvar)

    -- Read results before slots are freed
    errPtr <- peek errorSlot
    if errPtr /= nullPtr
      then return (Left errPtr)
      else do
        resPtr <- peek resultSlot
        if resPtr /= nullPtr
          then return (Right resPtr)
          else error "Both error and result are null from Tokio call")


{- | Exception-safe wrapper for Tokio async calls.

This function ensures that Rust-allocated memory is properly freed even if an async
exception occurs during processing. It uses bracket to guarantee cleanup.

Parameters:
  - call: The FFI call to make
  - freeErr: Function to free error pointers
  - freeRes: Function to free result pointers
  - processErr: Function to extract Haskell value from error pointer
  - processRes: Function to extract Haskell value from result pointer
-}
withTokioAsyncCall
  :: TokioCall err res
  -> (Ptr err -> IO ())  -- ^ Free error
  -> (Ptr res -> IO ())  -- ^ Free result
  -> (Ptr err -> IO e)   -- ^ Process error
  -> (Ptr res -> IO a)   -- ^ Process result
  -> IO (Either e a)
withTokioAsyncCall call freeErr freeRes processErr processRes = mask $ \_ -> do
  result <- makeTokioAsyncCall call
  case result of
    Left errPtr ->
      bracket (pure errPtr) freeErr processErr >>= \e -> pure (Left e)
    Right resPtr ->
      bracket (pure resPtr) freeRes processRes >>= \r -> pure (Right r)


{- | Exception-safe wrapper for Tokio async calls that return Either.

Automatically handles cleanup of Rust pointers with exception safety.
Use this instead of makeTokioAsyncCall when you need to process the results.

Example:
  makeTokioAsyncCallSafe
    (raw_someCall ptr)
    rust_dropError
    rust_dropResult
    peekError
    peekResult
-}
makeTokioAsyncCallSafe
  :: TokioCall err res
  -> (Ptr err -> IO ())  -- ^ Free error
  -> (Ptr res -> IO ())  -- ^ Free result
  -> (Ptr err -> IO e)   -- ^ Process error (peek/convert)
  -> (Ptr res -> IO a)   -- ^ Process result (peek/convert)
  -> IO (Either e a)
makeTokioAsyncCallSafe = withTokioAsyncCall

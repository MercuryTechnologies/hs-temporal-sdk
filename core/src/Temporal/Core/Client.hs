{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
module Temporal.Core.Client 
  ( Client
  , connectClient
  , defaultClientConfig
  , ClientConfig(..)
  , ClientTlsConfig(..)
  , ClientRetryConfig(..)
  , call
  , PrimRpcCall
  , RpcCall(..)
  , withClient
  ) where

import Control.Exception
import Data.Aeson
import Data.Aeson.TH
import Data.ByteString (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.ProtoLens.Service.Types
import Data.Proxy
import Data.Text (Text)
import Data.Word
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal
import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.Marshal
import Foreign.Storable
import Temporal.Runtime
import Temporal.Internal.FFI
import qualified Data.ByteString          as BS
import qualified Data.ByteString.Internal as BS
import qualified Data.ByteString          as BL
import qualified Data.Vector.Storable     as V
import Data.ProtoLens.Encoding
import Data.ProtoLens.Service.Types

foreign import ccall "hs_temporal_connect_client" raw_connectClient :: Ptr Runtime -> CString -> TokioCall RustCStringLen Client
foreign import ccall "&hs_temporal_drop_client" raw_freeClient :: FunPtr (Ptr Client -> IO ())

newtype Client = Client { client :: ForeignPtr Client }

withClient :: Client -> (Ptr Client -> IO a) -> IO a
withClient (Client c) = withForeignPtr c

instance ManagedRustValue Client where
  type RustRef Client = Ptr Client
  type HaskellRep Client = Client
  fromRust _ rustPtr = mask_ $ do
    fp <- newForeignPtr raw_freeClient rustPtr
    pure $ Client fp

newtype ByteVector = ByteVector { byteVector :: ByteString }

byteStringToVector :: BS.ByteString -> V.Vector Word8
byteStringToVector bs = vec 
  where
    vec = V.unsafeFromForeignPtr (castForeignPtr fptr) off len
    (fptr, off, len) = BS.toForeignPtr bs

vectorToByteString :: V.Vector Word8 -> BS.ByteString
vectorToByteString vec = BS.fromForeignPtr (castForeignPtr fptr) off len 
  where
    (fptr, off, len) = V.unsafeToForeignPtr vec

instance ToJSON ByteVector where
  toJSON = toJSON . byteStringToVector . byteVector
instance FromJSON ByteVector where
  parseJSON = fmap ByteVector . fmap vectorToByteString . parseJSON

data ClientTlsConfig = ClientTlsConfig
  { serverRootCaCert:: Maybe ByteVector
  , domain:: Maybe Text
  , clientCert:: Maybe ByteVector
  , clientPrivateKey:: Maybe ByteVector
  }
deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientTlsConfig

data ClientRetryConfig = ClientRetryConfig
  { initialIntervalMillis :: Word64
  , randomizationFactor :: Double
  , multiplier :: Double
  , maxIntervalMillis :: Word64
  , maxElapsedTimeMillis :: Maybe Word64
  , maxRetries :: Word64
  }
deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientRetryConfig

data ClientConfig = ClientConfig
  { targetUrl :: Text
  , clientName :: Text
  , clientVersion :: Text
  , metadata :: HashMap Text Text
  , identity :: Text
  , tlsConfig :: Maybe ClientTlsConfig
  , retryConfig :: Maybe ClientRetryConfig
  }
deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientConfig

data RpcCall a = RpcCall
  { req :: a
  , retry :: Bool
  , metadata :: HashMap Text Text
  , timeoutMillis :: Maybe Word64
  }

data ClientConnectionError = ClientConnectionError Text
  deriving (Show)

defaultClientConfig :: ClientConfig
defaultClientConfig = ClientConfig
  { targetUrl = "http://localhost:7233"
  , clientName = "temporal-haskell"
  , clientVersion = "0.0.1"
  , metadata = mempty
  , identity = ""
  , tlsConfig = Nothing
  , retryConfig = Nothing
  }

connectClient :: Runtime -> ClientConfig -> IO (Either ClientConnectionError Client)
connectClient rt conf = withRuntime rt $ \rtPtr -> BS.useAsCString (BL.toStrict $ encode conf) $ \confPtr -> do
  makeTokioAsyncCall 
    (raw_connectClient rtPtr confPtr)
    (\cstrLen -> do
      msg <- fromRust (Proxy :: Proxy RustCStringLen) cstrLen
      pure $ ClientConnectionError msg
    )
    (fmap Client . newForeignPtr raw_freeClient)

type PrimRpcCall = Ptr Client -> Ptr CRpcCall -> TokioCall RpcError (CArray Word8)

-- TODO, this would be better as a pair of vectors instead of a linked list
data HashMapEntries = HashMapEntries
  { key :: CString
  , keyLen :: CSize
  , value :: CString
  , valueLen :: CSize
  , next :: Ptr HashMapEntries
  }

instance Storable HashMapEntries where
  sizeOf _ = 
    sizeOf (undefined :: CString) + 
    sizeOf (undefined :: CSize) + 
    sizeOf (undefined :: CString) + 
    sizeOf (undefined :: CSize) + 
    sizeOf (undefined :: Ptr HashMapEntries)
  alignment _ = 8
  peek ptr = do
    key <- peekByteOff ptr 0
    keyLen <- peekByteOff ptr (sizeOf (undefined :: CString))
    value <- peekByteOff ptr (sizeOf (undefined :: CString) + sizeOf (undefined :: CSize))
    valueLen <- peekByteOff ptr (sizeOf (undefined :: CString) + sizeOf (undefined :: CSize) + sizeOf (undefined :: CString))
    next <- peekByteOff ptr (sizeOf (undefined :: CString) + sizeOf (undefined :: CSize) + sizeOf (undefined :: CString) + sizeOf (undefined :: CSize))
    pure $ HashMapEntries key keyLen value valueLen next
  poke ptr (HashMapEntries key keyLen value valueLen next) = do
    pokeByteOff ptr 0 key
    pokeByteOff ptr (sizeOf (undefined :: CString)) keyLen
    pokeByteOff ptr (sizeOf (undefined :: CString) + sizeOf (undefined :: CSize)) value
    pokeByteOff ptr (sizeOf (undefined :: CString) + sizeOf (undefined :: CSize) + sizeOf (undefined :: CString)) valueLen
    pokeByteOff ptr (sizeOf (undefined :: CString) + sizeOf (undefined :: CSize) + sizeOf (undefined :: CString) + sizeOf (undefined :: CSize)) next

data CRpcCall = CRpcCall
  { rpcCallReq :: Ptr (CArray Word8)
  , rpcCallRetry :: Word8
  , rpcCallMetadata :: Ptr HashMapEntries
  , rpcCallTimeoutMillis :: Ptr Word64
  }

instance Storable CRpcCall where
  sizeOf _ =
    sizeOf (undefined :: Ptr (CArray Word8)) +
    sizeOf (undefined :: Word8) +
    sizeOf (undefined :: Ptr HashMapEntries) +
    sizeOf (undefined :: Ptr Word64)
  alignment _ = 8
  peek ptr = do
    rpcCallReq <- peekByteOff ptr 0
    rpcCallRetry <- peekByteOff ptr (sizeOf (undefined :: Ptr (CArray Word8)))
    rpcCallMetadata <- peekByteOff ptr (sizeOf (undefined :: Ptr (CArray Word8)) + sizeOf (undefined :: Word8))
    rpcCallTimeoutMillis <- peekByteOff ptr (sizeOf (undefined :: Ptr (CArray Word8)) + sizeOf (undefined :: Word8) + sizeOf (undefined :: Ptr HashMapEntries))
    pure $ CRpcCall rpcCallReq rpcCallRetry rpcCallMetadata rpcCallTimeoutMillis
  poke ptr (CRpcCall rpcCallReq rpcCallRetry rpcCallMetadata rpcCallTimeoutMillis) = do
    pokeByteOff ptr 0 rpcCallReq
    pokeByteOff ptr (sizeOf (undefined :: Ptr (CArray Word8))) rpcCallRetry
    pokeByteOff ptr (sizeOf (undefined :: Ptr (CArray Word8)) + sizeOf (undefined :: Word8)) rpcCallMetadata
    pokeByteOff ptr (sizeOf (undefined :: Ptr (CArray Word8)) + sizeOf (undefined :: Word8) + sizeOf (undefined :: Ptr HashMapEntries)) rpcCallTimeoutMillis

-- TODO how should we use mask here?
call :: forall svc t. (HasMethodImpl svc t) => PrimRpcCall -> Client -> MethodInput svc t -> IO (Either RpcError (MethodOutput svc t))
call f (Client c) req = withForeignPtr c $ \cPtr -> do
  let msgBytes = encodeMessage req
  BS.useAsCStringLen msgBytes $ \(msgPtr, msgLen) -> do
    alloca $ \cArrayPtr -> do
      poke cArrayPtr (CArray msgPtr (fromIntegral msgLen))
      let rpcCall = CRpcCall
            { rpcCallReq = castPtr cArrayPtr
            , rpcCallRetry = if False then 0 else 1
            , rpcCallMetadata = nullPtr
            , rpcCallTimeoutMillis = nullPtr
            }
      alloca $ \rpcCallPtr -> do
        poke rpcCallPtr rpcCall
        result <- makeTokioAsyncCall
          (f cPtr rpcCallPtr)
          (\rpcErr -> do
            err <- peekCrpcError rpcErr
            rust_drop_rpc_error rpcErr
            pure err
          )
          (\rp -> do
            fromRust (Proxy @(CArray Word8)) rp)
        pure $ case result of
          Left err -> Left err
          Right r -> Right $ decodeMessageOrDie r
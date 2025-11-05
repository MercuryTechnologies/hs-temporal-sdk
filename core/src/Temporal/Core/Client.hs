{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE PolyKinds #-}

module Temporal.Core.Client (
  -- * Connecting to the server
  Client,
  clientConfig,
  connectClient,
  defaultClientConfig,
  closeClient,
  clientRuntime,
  CoreClient,
  ClientConfig (..),
  ClientTlsConfig (..),
  ByteVector (..),
  ClientRetryConfig (..),
  APIKey (..),

  -- * Making calls to the server

  --
  -- Generally you should not need to use 'call' directly, but instead should
  -- use the supplied functions in 'Temporal.Core.Client.WorkflowService' and
  -- other service modules.
  --
  -- For higher-level access, see the@@temporal-sdk@ package for a more
  -- idiomatic Haskell API.
  call,
  RpcCall (..),
  RpcError (..),
  ClientError (..),

  -- * Primitive access
  CRpcCall,
  TokioCall,
  TokioResult,
  PrimRpcCall,
  -- | Use the underlying Rust client pointer
  withClient,

  -- * Resource-safe wrappers
  bracketClient,
) where

import Control.Concurrent
import Control.Exception
import Control.Monad
import Control.Monad.IO.Class
import Control.Monad.Logger
import Data.Aeson
import Data.Aeson.TH
import Data.ByteString (ByteString)
import qualified Data.ByteString as BL
import qualified Data.ByteString as BS
import qualified Data.ByteString.Internal as BS
import Data.HashMap.Strict (HashMap)
import Data.ProtoLens.Encoding
import Data.ProtoLens.Service.Types
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Vector.Storable as V
import Data.Word
import Foreign.C.String
import Foreign.ForeignPtr (castForeignPtr)
import Foreign.Marshal
import Foreign.Ptr
import Foreign.Storable
import Network.BSD
import System.Posix.Process
import Temporal.Core.CTypes
import Temporal.Internal.FFI
import Temporal.Runtime
import UnliftIO (MonadUnliftIO, withRunInIO)
import qualified UnliftIO
import Data.Proxy
import Debug.Trace
import GHC.TypeLits

foreign import ccall "hs_temporal_connect_client" raw_connectClient :: Ptr Runtime -> CString -> TokioCall (CArray Word8) CoreClient


foreign import ccall "hs_temporal_drop_client" raw_freeClient :: Ptr CoreClient -> IO ()


data ClientConfig = ClientConfig
  { targetUrl :: Text
  , clientName :: Text
  , clientVersion :: Text
  , metadata :: HashMap Text Text
  , identity :: Text
  , tlsConfig :: Maybe ClientTlsConfig
  , retryConfig :: Maybe ClientRetryConfig
  , apiKey :: Maybe APIKey
  }


data ClientTlsConfig = ClientTlsConfig
  { serverRootCaCert :: Maybe ByteVector
  , domain :: Maybe Text
  , clientCert :: Maybe ByteVector
  , clientPrivateKey :: Maybe ByteVector
  }


data ClientRetryConfig = ClientRetryConfig
  { initialIntervalMillis :: Word64
  , randomizationFactor :: Double
  , multiplier :: Double
  , maxIntervalMillis :: Word64
  , maxElapsedTimeMillis :: Maybe Word64
  , maxRetries :: Word64
  }


newtype APIKey = APIKey {unAPIKey :: Text}


instance ToJSON APIKey where
  toJSON (APIKey text) = toJSON text


instance FromJSON APIKey where
  parseJSON = fmap APIKey . parseJSON


{- | A client connection to the Temporal server.

The client is thread-safe and can be shared across threads.

Clients are expensive to create, so you should generally create one per
process and share it across your application..

The client doesn't have an explicit close method, but will be cleaned up
when it is garbage collected.
-}
data Client = Client
  { client :: MVar CoreClient
  , runtime :: Runtime
  , config :: ClientConfig
  }


clientConfig :: Client -> ClientConfig
clientConfig = config


clientRuntime :: Client -> Runtime
clientRuntime = runtime


withClient :: Client -> (Ptr CoreClient -> IO a) -> IO a
withClient (Client cc r _) f =
  withMVar cc $ \(CoreClient c) ->
    withRuntime r $ \_ ->
      f c


newtype ByteVector = ByteVector {byteVector :: ByteString}


-- | Safety: we're handed a 'BS.ByteString' and are converting it directly to
-- a 'V.Vector Word8'; we can use conversion functions that do not take offsets
-- into account.
byteStringToVector :: BS.ByteString -> V.Vector Word8
byteStringToVector bs = V.unsafeFromForeignPtr0 (castForeignPtr fptr) len
  where
    (fptr, len) = BS.toForeignPtr0 bs


-- | Safety: we're handed a 'V.Vector Word8' and are converting it directly to
-- a 'BS.ByteString'; we can use conversion functions that do not take offsets
-- into account.
vectorToByteString :: V.Vector Word8 -> BS.ByteString
vectorToByteString vec = BS.fromForeignPtr0 (castForeignPtr fptr) len
  where
    (fptr, len) = V.unsafeToForeignPtr0 vec


instance ToJSON ByteVector where
  toJSON = toJSON . byteStringToVector . byteVector


instance FromJSON ByteVector where
  parseJSON = fmap (ByteVector . vectorToByteString) . parseJSON


deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientTlsConfig


deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientRetryConfig


deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientConfig


data RpcCall a = RpcCall
  { req :: a
  , retry :: Bool
  , metadata :: HashMap Text Text
  , timeoutMillis :: Maybe Word64
  }


data ClientError
  = ClientConnectionError Text
  | ClientClosedError
  deriving (Show)


instance Exception ClientError


defaultClientConfig :: ClientConfig
defaultClientConfig =
  ClientConfig
    { targetUrl = "http://localhost:7233"
    , clientName = "temporal-haskell"
    , clientVersion = "0.0.1"
    , metadata = mempty
    , identity = ""
    , tlsConfig = Nothing
    , retryConfig = Nothing
    , apiKey = Nothing
    }


defaultClientIdentity :: IO Text
defaultClientIdentity = do
  pid <- getProcessID
  host <- getHostName
  pure (T.pack $ show pid <> "@" <> host)


{- | Connect to the Temporal server using a given runtime.

Throws 'ClientConnectionError' if the connection fails.
-}
connectClient :: (MonadIO m, MonadLogger m, MonadUnliftIO m) => Runtime -> ClientConfig -> m Client
connectClient rt conf = do
  conf' <-
    if identity conf == ""
      then do
        ident <- liftIO defaultClientIdentity
        pure $ conf {identity = ident}
      else pure conf

  clientPtrSlot <- liftIO newEmptyMVar
  withRunInIO $ \runInIO -> do
    forkIO $ runInIO $ do
      liftIO $ withRuntime rt $ \rtPtr -> BS.useAsCString (BL.toStrict $ encode conf') $ \confPtr -> do
        let tryConnect = makeTokioAsyncCall (raw_connectClient rtPtr confPtr)
            go attempt = do
              result <- tryConnect
              case result of
                Left errPtr -> do
                  -- Exception-safe: use bracket to ensure error is freed
                  err <- bracket
                    (pure errPtr)
                    rust_dropByteArray
                    (\ptr -> do
                      errArr <- peek ptr
                      cArrayToText errArr)
                  let err' = "Error connecting to Temporal server: " <> err
                  runInIO $ $(logWarn) err'
                  case retryConfig conf of
                    Nothing -> liftIO $ putMVar clientPtrSlot (throw $ ClientConnectionError err')
                    Just retryConf -> do
                      let delayMillis = fromIntegral (initialIntervalMillis retryConf) * multiplier retryConf ^ attempt
                          delayMicros = delayMillis * 1000
                      if (fmap fromIntegral (maxElapsedTimeMillis retryConf) < Just delayMillis) || (maxRetries retryConf <= attempt)
                        then liftIO $ putMVar clientPtrSlot (throw $ ClientConnectionError err')
                        else do
                          liftIO $ threadDelay $ round delayMicros
                          go (attempt + 1)
                Right clientPtr -> liftIO $ putMVar clientPtrSlot (CoreClient clientPtr)
        go 1
  pure $ Client clientPtrSlot rt conf'


reconnectClient :: (MonadIO m, MonadLogger m, MonadUnliftIO m) => Client -> m ()
reconnectClient (Client clientPtrSlot rt conf) = UnliftIO.mask $ \restore -> do
  (CoreClient oldClientPtr) <- liftIO $ takeMVar clientPtrSlot
  -- Exception-safe: if connectClient fails, restore old client and free it properly
  (Client newClientPtr _ _) <- restore (connectClient rt conf) `UnliftIO.catch`
    (\c -> liftIO $ do
      putMVar clientPtrSlot (throw (c :: ClientError))
      raw_freeClient oldClientPtr  -- Free old client even on failure
      throwIO c)
  liftIO $ do
    -- Success path: free old client and install new one
    raw_freeClient oldClientPtr
    takeMVar newClientPtr >>= putMVar clientPtrSlot


-- | Explicitly close a client connection.
--
-- After calling this, the client must not be used again.
closeClient :: MonadIO m => Client -> m ()
closeClient (Client clientPtrSlot _ _) = liftIO $ mask_ $ do
  (CoreClient clientPtr) <- takeMVar clientPtrSlot
  raw_freeClient clientPtr
  putMVar clientPtrSlot (throw ClientClosedError)


type PrimRpcCall = Ptr CoreClient -> Ptr CRpcCall -> TokioCall CRPCError (CArray Word8)


-- | Make an RPC call through the client.
--
-- This function is async-exception-safe: all Rust allocations are properly
-- freed even if an async exception occurs during processing.
call :: forall svc t. (HasMethodImpl svc t) => PrimRpcCall -> Client -> MethodInput svc t -> IO (Either RpcError (MethodOutput svc t))
call f c req_ = do
  traceIO $ "about to grab client for call: " <> symbolVal (Proxy :: Proxy (Data.ProtoLens.Service.Types.ServiceName svc)) <> " , method:" <> symbolVal (Proxy :: Proxy (MethodName svc t))
  withClient c $ \cPtr -> do
    traceIO $ "client grabbed for call: " <> symbolVal (Proxy :: Proxy (Data.ProtoLens.Service.Types.ServiceName svc)) <> " , method:" <> symbolVal (Proxy :: Proxy (MethodName svc t))
    let msgBytes = encodeMessage req_
    BS.useAsCStringLen msgBytes $ \(msgPtr, msgLen) -> do
      alloca $ \cArrayPtr -> do
        poke cArrayPtr (CArray msgPtr (fromIntegral msgLen))
        let rpcCall =
              CRpcCall
                { rpcCallReq = castPtr cArrayPtr
                , rpcCallRetry = if False then 0 else 1
                , rpcCallMetadata = nullPtr
                , rpcCallTimeoutMillis = nullPtr
                }
        alloca $ \rpcCallPtr -> do
          poke rpcCallPtr rpcCall
          withTokioAsyncCall
            (f cPtr rpcCallPtr)
            rust_drop_rpc_error
            rust_dropByteArray
            (\errPtr -> peek errPtr >>= peekCRPCError)
            (\resultPtr -> do
              arr <- peek resultPtr
              bs <- cArrayToByteString arr
              return (decodeMessageOrDie bs))


-- | Bracket-style wrapper for Client that ensures proper cleanup.
--
-- Example:
--
-- @
-- bracketClient rt clientConfig $ \\client -> do
--   ...
-- @
bracketClient :: (MonadUnliftIO m, MonadLogger m) => Runtime -> ClientConfig -> (Client -> m a) -> m a
bracketClient rt conf = UnliftIO.bracket (connectClient rt conf) closeClient

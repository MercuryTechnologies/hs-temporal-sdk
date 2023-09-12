module Temporal.Codec.Server 
  ( codecServerMiddleware
  , CodecServerConfig(..)
  , CorsResourcePolicy(..)
  , temporalCloudCorsPolicy
  ) where

import Control.Monad.Trans.Except
import Data.Aeson
import qualified Data.ByteString as BS
import Data.Bifunctor
import Data.Text (Text)
import qualified Data.Text.Encoding as Text
import Data.Vector (Vector)
import Network.Wai
import Network.Wai.Middleware.Cors
import Network.HTTP.Types
import Temporal.Workflow (Namespace(..))
import Temporal.Payload

data Body = Body
  { payloads :: Vector Payload
  }

instance ToJSON Body where
  toJSON (Body payloads) = object ["payloads" .= payloads]
  toEncoding (Body payloads) = pairs ("payloads" .= payloads)

instance FromJSON Body where
  parseJSON = withObject "Body" $ \o -> Body <$> o .: "payloads"

type AuthorizationHeaderValue = BS.ByteString

data ErrorResponse = ErrorResponse
  { errorStatus :: Status
  , errorMessage :: String
  }

data CodecServerConfig = CodecServerConfig
  { codecServerDecoder :: {-# UNPACK #-} !(Namespace -> Maybe AuthorizationHeaderValue -> Payload -> ExceptT ErrorResponse IO Payload)
  , codecServerEncoder :: {-# UNPACK #-} !(Namespace -> Maybe AuthorizationHeaderValue -> Payload -> ExceptT ErrorResponse IO Payload)
  , endpointBase :: [Text] -- ^ Path segments
  , corsPolicy :: CorsResourcePolicy
  }

errorResponse :: ErrorResponse -> Response
errorResponse err = responseLBS err.errorStatus respHeaders $ Data.Aeson.encode $ object ["error" .= err.errorMessage]

namespaceHeader :: HeaderName
namespaceHeader = "x-namespace"

streamingDecode :: Request -> ExceptT ErrorResponse IO Body
streamingDecode req = ExceptT ((first (ErrorResponse status500) . eitherDecode') <$> consumeRequestBodyLazy req)

respHeaders :: ResponseHeaders
respHeaders = 
  [ (hContentType, "application/json; charset=utf-8")
  ]

requireNamespaceHeader :: Request -> ExceptT ErrorResponse IO Namespace
requireNamespaceHeader req = case lookup namespaceHeader (requestHeaders req) of
  Nothing -> ExceptT $ pure $ Left $ ErrorResponse status500 "Missing required x-namespace header"
  Just ns -> pure $ Namespace $ Text.decodeUtf8 ns

temporalCloudCorsPolicy :: CorsResourcePolicy
temporalCloudCorsPolicy = simpleCorsResourcePolicy
  { corsOrigins = Just (["https://cloud.temporal.io"], True)
  , corsMethods = [methodGet, methodPost, methodOptions]
  , corsRequestHeaders = [namespaceHeader, hContentType, hAuthorization]
  , corsRequireOrigin = True
  , corsIgnoreFailures = True
  }

codecServerMiddleware 
  :: CodecServerConfig
  -> Middleware
codecServerMiddleware CodecServerConfig{..} = 
  cors (\req -> if isCodecServerEndpoint req then Just corsPolicy else Nothing) . 
  baseMiddleware
  where
    baseMiddleware app req respond = 
      let dispatch 
            | pathInfo req == codecServerEncodeEndpoint = runEncode req respond
            | pathInfo req == codecServerDecodeEndpoint = runDecode req respond
            | otherwise = app req respond
      in dispatch

    codecServerEncodeEndpoint = endpointBase <> ["encode"]
    codecServerDecodeEndpoint = endpointBase <> ["decode"]
    isCodecServerEndpoint req = pathInfo req `elem` [codecServerEncodeEndpoint, codecServerDecodeEndpoint]

    runEncode req respond = do
      let authHeader = lookup hAuthorization $ requestHeaders req
      res <- runExceptT $ do
        ns <- requireNamespaceHeader req
        body <- streamingDecode req
        traverse (codecServerEncoder ns authHeader) $ payloads body
      respond $ case res of
        Left err -> errorResponse err
        Right ok -> responseLBS status200 respHeaders $ Data.Aeson.encode $ Body ok

    runDecode req respond = do
      let authHeader = lookup hAuthorization $ requestHeaders req
      res <- runExceptT $ do
        ns <- requireNamespaceHeader req
        body <- streamingDecode req
        traverse (codecServerDecoder ns authHeader) $ payloads body
      respond $ case res of
        Left err -> errorResponse err
        Right ok -> responseLBS status200 respHeaders $ Data.Aeson.encode $ Body ok

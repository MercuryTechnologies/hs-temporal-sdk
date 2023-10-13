{-# LANGUAGE
  AllowAmbiguousTypes,
  ConstraintKinds,
  DataKinds,
  FunctionalDependencies,
  FlexibleContexts,
  FlexibleInstances,
  GADTs,
  InstanceSigs,
  ImpredicativeTypes,
  PolyKinds,
  MultiParamTypeClasses,
  ScopedTypeVariables,
  RankNTypes,
  TypeOperators,
  TypeFamilies,
  UndecidableInstances,
  TypeApplications 
  #-}
{-# LANGUAGE DefaultSignatures #-}
-- | 
-- Module: Temporal.Payload
-- Description: Payloads are the binary data that is sent to and from the Temporal Server.
--
-- A Payload represents binary data such as input and output from Activities and Workflows. Payloads contain metadata that describe the binary data, such as its data type or other arbitrary values for use by custom encoders/converters.
--
-- When processed through the SDK, the default Data Converter serializes your data/value to a Payload before sending it to the Temporal Server. The default Data Converter processes supported type values to Payloads, and you can create a custom Payload Converter to convert your custom object types.
-- 
-- You can additionally apply custom codecs (such as for encryption or compression) on your Payloads to wrap them into new encoded Payloads.
module Temporal.Payload 
  ( Payload(..)
  , Codec(..)
  , JSON(..)
  , Null(..)
  , Binary(..)
  , Protobuf(..)
  , Zlib(..)
  , zlib
  , applyPayloads
  , Around(..)
  , mkPayloadProcessor
  , addPayloadProcessor
  , PayloadProcessor
  , ApplyPayloads
  , GatherArgs(..)
  , ArgsOf
  , GatherArgsOf
  , ResultOf
  , EncodeResultOf
  , FunctionSupportsCodec
  , FunctionSupportsCodec'
  , (:->:)
  , convertToProtoPayload
  , convertFromProtoPayload
  ) where

import Codec.Compression.Zlib.Internal hiding (Format(..))
import Data.Aeson hiding (encode, decode)
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as C
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.Text.Encoding (encodeUtf8)
import Data.Kind
import Data.ProtoLens (defMessage, Message(..))
import Data.Proxy
import Data.Map.Strict (Map)
import qualified Data.Vector as V
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import Data.Typeable
import GHC.TypeLits
import Lens.Family2
import qualified Proto.Temporal.Api.Common.V1.Message as Proto (Payload)
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Proto (data', metadata)
import Data.ProtoLens.Encoding ( encodeMessage, decodeMessage )
import qualified Data.Text as T
import qualified Data.Text.Encoding as Text
import qualified Data.Text as Text
import Data.ByteString.Base64 (encodeBase64, decodeBase64)

{- * Parameter serialization 

We want to be able to serialize & deserialize the parameters of a function using an arbitrary serialization code. 
We do this by gathering the order of the parameters as a type-level list, then fold over the type level list to 
build a function with the same parameters that outputs a list of serialized params.

To deserialize, we do the inverse– we progressively apply the args of the function by consuming serialized params 
as we go. If there are not enough or too many params, we fail.
-}

-- | We want to be able to serialize & deserialize the parameters of a function using an arbitrary serialization format.
class Codec fmt a where
  -- | Similar to a content-type header, this is a string that identifies the format of the payload.
  -- it will be set on the 'encoding' metadata field of the payload.
  encoding :: fmt -> Proxy a -> ByteString
  messageType :: fmt -> a -> ByteString
  default messageType :: (Typeable a) => fmt -> a -> ByteString
  messageType _ _ = C.pack $ show $ typeRep (Proxy @a)
  encode :: fmt -> a -> IO Payload
  decode :: fmt -> Payload -> IO (Either String a)

insertStandardMetadata :: Codec fmt a => fmt -> a -> Payload -> Payload
insertStandardMetadata fmt x (Payload d m) = Payload d $ m <> Map.fromList
  [ ("encoding", encoding fmt $ pure x)
  , ("messageType", messageType fmt x)
  ]

data JSON = JSON

instance (Typeable a, Aeson.ToJSON a, Aeson.FromJSON a) => Codec JSON a where
  encoding _ _ = "json/plain"
  encode c x = pure $ insertStandardMetadata c x $ Payload (BL.toStrict $ Aeson.encode x) mempty
  decode _ = pure . Aeson.eitherDecodeStrict' . payloadData

data Null = Null

instance Codec Null () where
  encoding _ _ = "binary/null"
  encode c x = pure $ insertStandardMetadata c x $ Payload mempty mempty
  decode _ _ = pure $ Right ()

-- | Direct binary serialization.
--
-- A generalized instance like the one for JSON is not provided because
-- there are many possible binary serialization formats and libraries.
--
-- You can provide a simple version of this instance for your own codebase
-- using something like the cereal package:
--
-- > import Data.Serialize (Serialize)
-- > import qualified Data.Serialize as Serialize
-- > instance {-# OVERLAPPABLE #-} (Typeable a, Serialize a) => Codec Binary a where
-- >   encodingType _ _ = "binary/plain"
-- >   encodePayload _ x = Serialize.encode x
-- >   decode _ = Serialize.decode . inputPayloadData
data Binary = Binary

instance Codec Binary ByteString where
  encoding _ _ = "binary/plain"
  encode c x = pure $ insertStandardMetadata c x $ Payload x mempty
  decode _ = pure . Right . payloadData


data Protobuf = Protobuf

instance (Message a) => Codec Protobuf a where
  messageType _ x = encodeUtf8 $ messageName $ pure x
  encoding _ _ = "binary/protobuf"
  encode c x = pure $ insertStandardMetadata c x $ Payload (encodeMessage x) mempty
  decode _ = pure . decodeMessage . payloadData

data Zlib = Zlib
  { -- | Skip compression when the size of the response body is
    -- below this amount of bytes (default: 860.)
    --
    -- /Setting this option to less than 150 will actually increase/
    -- /the size of outgoing data if its original size is less than 150 bytes/.
    minimumEncodingSize :: Int
  , compressParams :: CompressParams
  , decompressParams :: DecompressParams
  }

zlib :: Zlib
zlib = Zlib 860 defaultCompressParams defaultDecompressParams

instance Codec Zlib Payload where
  encoding _ _ = "binary/zlib"
  -- TODO, if we keep the original compression size, we can allocate the right size buffer for the decompressed data.
  encode Zlib{..} p = if BS.length msg >= minimumEncodingSize && BS.length compressed < BS.length msg
    then pure $ Payload compressed (Map.singleton "encoding" "binary/zlib")
    else pure p
    where
      msg = encodeMessage $ convertToProtoPayload p
      compressed = BL.toStrict $ compress zlibFormat compressParams $ BL.fromStrict p.payloadData
  decode Zlib{..} p = case p.payloadMetadata Map.!? "encoding" of
  -- TODO, use `decompressIO` instead of `decompress`  so we can return the error in the Left case.
    Just "binary/zlib" -> pure $ 
      fmap convertFromProtoPayload $ 
      decodeMessage $ 
      BS.toStrict $ 
      decompress zlibFormat decompressParams $ 
      BL.fromStrict p.payloadData
    _ -> pure $ Right p

-- | A codec that post-processes the payload after encoding and pre-processes before decoding.
--
-- Combining multiple 'PayloadProcessor's will apply them in the order that they are added.
-- For example, if you want to compress and then encrypt, you would add the compression processor
-- first, then the encryption processor.
data PayloadProcessor = PayloadProcessor
  { payloadProcessorEncode :: Payload -> IO Payload
  , payloadProcessorDecode :: Payload -> IO (Either String Payload)
  }
-- TODO, need to make sure to unit test this before using it. The ordering guarantees have me confused.
-- instance Semigroup PayloadProcessor where
--   PayloadProcessor e1 d1 <> PayloadProcessor e2 d2 = PayloadProcessor
--     { PayloadProcessorEncode = 
--     , PayloadProcessorDecode = 
--     }
-- instance Monoid PayloadProcessor where
--   mempty = PayloadProcessor pure (pure . Right)

mkPayloadProcessor :: Codec fmt Payload => fmt -> PayloadProcessor
mkPayloadProcessor fmt = PayloadProcessor
  { payloadProcessorEncode = encode fmt
  , payloadProcessorDecode = decode fmt
  }

addPayloadProcessor :: Codec fmt Payload => fmt -> PayloadProcessor -> PayloadProcessor
addPayloadProcessor fmt PayloadProcessor{..} = PayloadProcessor
  { payloadProcessorEncode = \p -> do
      p' <- payloadProcessorEncode p
      encode fmt p'
  , payloadProcessorDecode = \p -> do
      p' <- decode fmt p
      case p' of
        Left err -> pure $ Left err
        Right ok -> payloadProcessorDecode ok
  }


-- | A codec that uses the base codec for actually encoding and decoding, but
-- supports additional pre- and post-processing. This is useful for adding
-- compression, encryption, or other transformations to an existing codec.
data Around base = Around
  { around :: PayloadProcessor
  , baseCodec :: base
  }


instance (Typeable a, Codec base a) => Codec (Around base) a where
  encoding (Around _ base) = encoding base
  encode (Around p base) x = encode base x >>= payloadProcessorEncode p
  decode (Around p base) x = payloadProcessorDecode p x >>= \case
    Left err -> pure $ Left err
    Right x' -> decode base x'

type family ArgsOf f where
  ArgsOf (arg -> rest) = arg ': ArgsOf rest
  ArgsOf _ = '[]

type family ResultOf (m :: Type -> Type) f where
  ResultOf m (_ -> rest) = ResultOf m rest
  ResultOf m (m result) = result
  ResultOf m result = TypeError ('Text "This function must use the (" ':<>: 'ShowType m ':<>: 'Text ") monad." ':$$: ('Text "Current type: " ':<>: 'ShowType result))

class (Codec codec (ResultOf m f), Typeable (ResultOf m f)) => EncodeResultOf codec (m :: Type -> Type) (f :: Type)
instance (Codec codec (ResultOf m f), Typeable (ResultOf m f)) => EncodeResultOf codec (m :: Type -> Type) (f :: Type)

-- | Construct a function type from a list of argument types and a result type.
type family (:->:) (args :: [Type]) (result :: Type) where
  (:->:) '[] result = result
  (:->:) (arg ': args) result = arg -> (args :->: result)

infixr 0 :->: 

data Payload = Payload
  { payloadData :: ByteString
  , payloadMetadata :: Map Text ByteString
  } deriving stock (Eq, Show)


base64DecodeFromText :: MonadFail m => T.Text -> m ByteString
base64DecodeFromText txt = case decodeBase64 $ Text.encodeUtf8 txt of
  Left err -> fail $ Text.unpack err
  Right ok -> pure ok

instance FromJSON Payload where
  parseJSON = withObject "Payload" $ \o -> do
    rawPayloadData <- o .:? "data"
    rawPayloadMetadata <- o .:? "metadata"
    payloadData <- maybe (pure mempty) base64DecodeFromText rawPayloadData
    payloadMetadata <- maybe (pure mempty) (traverse base64DecodeFromText) rawPayloadMetadata
    pure Payload{..}

instance ToJSON Payload where
  toJSON Payload{..} = object $
    (if payloadData == "" then id else (("data" .= encodeBase64 payloadData):)) $
    (if Map.null payloadMetadata then id else (("metadata" .= fmap encodeBase64 payloadMetadata) :))
    []
  toEncoding Payload{..} = pairs $
    (if payloadData == "" then mempty else ("data" .= encodeBase64 payloadData)) <>
    (if Map.null payloadMetadata then mempty else ("metadata" .= fmap encodeBase64 payloadMetadata))

convertFromProtoPayload :: Proto.Payload -> Payload
convertFromProtoPayload p = Payload (p ^. Proto.data') (p ^. Proto.metadata)

convertToProtoPayload :: Payload -> Proto.Payload
convertToProtoPayload (Payload d m) = defMessage
  & Proto.data' .~ d
  & Proto.metadata .~ m

class ApplyPayloads codec (args :: [Type]) where
  applyPayloads 
    :: codec 
    -> Proxy args 
    -> Proxy result 
    -> (args :->: result)
    -> V.Vector Payload
    -> IO (Either String result)

instance ApplyPayloads codec '[] where
  applyPayloads _ _ _ f _ = pure $ Right f

instance (Codec codec ty, ApplyPayloads codec tys) => ApplyPayloads codec (ty ': tys) where
  applyPayloads codec _ resP f vec = case V.uncons vec of
    Nothing -> pure $ Left "Not enough arguments"
    Just (pl, rest) -> do
      res <- decode codec pl
      case res of
        Right arg -> applyPayloads codec (Proxy @tys) resP (f arg) rest
        Left err -> pure $ Left err

-- | Given a list of function argument types and a codec, produce a function that takes a list of
-- 'Payload's and does something useful with them. This is used to support outbound invocations of
-- child workflows, activities, queries, and signals.
class GatherArgs codec (args :: [Type]) where
  gatherArgs 
    :: Proxy args 
    -> codec 
    -> ([IO Payload] -> [IO Payload]) 
    -> ([IO Payload] -> result)
    -> (args :->: result)

instance (Codec codec arg, GatherArgs codec args) => GatherArgs codec (arg ': args) where
  gatherArgs _ c accum f = \arg ->
    gatherArgs 
      (Proxy @args) 
      c 
      (accum . (encode c arg :))
      f

instance GatherArgs codec '[] where
  gatherArgs _ _ accum f = f $ accum []

class (GatherArgs codec (ArgsOf f)) => GatherArgsOf codec f
instance (GatherArgs codec (ArgsOf f)) => GatherArgsOf codec f

class (GatherArgs codec args, Codec codec result, Typeable result, ApplyPayloads codec args) => FunctionSupportsCodec codec args result
instance (GatherArgs codec args, Codec codec result, Typeable result, ApplyPayloads codec args) => FunctionSupportsCodec codec args result

class (FunctionSupportsCodec codec (ArgsOf f) (ResultOf m f), f ~ (ArgsOf f :->: m (ResultOf m f))) => FunctionSupportsCodec' (m :: Type -> Type) codec f
instance (FunctionSupportsCodec codec (ArgsOf f) (ResultOf m f), f ~ (ArgsOf f :->: m (ResultOf m f))) => FunctionSupportsCodec' m codec f
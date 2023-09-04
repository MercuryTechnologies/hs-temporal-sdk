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
module Temporal.Payload 
  ( RawPayload(..)
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
  , RawPayloadProcessor
  , ApplyPayloads
  , GatherArgs(..)
  , ArgsOf
  , GatherArgsOf(..)
  , ResultOf
  , EncodeResultOf(..)
  , FunctionSupportsCodec
  , FunctionSupportsCodec'
  , (:->:)
  , convertToProtoPayload
  , convertFromProtoPayload
  ) where

import Codec.Compression.Zlib.Internal hiding (Format(..))
import Control.Monad
import Data.Aeson hiding (encode, decode)
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as C
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.Text.Encoding (encodeUtf8)
import Control.Exception (SomeException)
import Data.Functor
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
  encoding :: fmt -> a -> ByteString
  messageType :: fmt -> a -> ByteString
  default messageType :: (Typeable a) => fmt -> a -> ByteString
  messageType _ _ = C.pack $ show $ typeRep (Proxy @a)
  encode :: fmt -> a -> IO RawPayload
  decode :: fmt -> RawPayload -> IO (Either String a)

insertStandardMetadata :: Codec fmt a => fmt -> a -> RawPayload -> RawPayload
insertStandardMetadata fmt x (RawPayload d m) = RawPayload d $ m <> Map.fromList
  [ ("encoding", encoding fmt x)
  , ("messageType", messageType fmt x)
  ]

data JSON = JSON

instance (Typeable a, Aeson.ToJSON a, Aeson.FromJSON a) => Codec JSON a where
  encoding _ _ = "json/plain"
  encode c x = pure $ insertStandardMetadata c x $ RawPayload (BL.toStrict $ Aeson.encode x) mempty
  decode _ = pure . Aeson.eitherDecodeStrict' . inputPayloadData

data Null = Null

instance Codec Null () where
  encoding _ _ = "binary/null"
  encode c x = pure $ insertStandardMetadata c x $ RawPayload mempty mempty
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
  encode c x = pure $ insertStandardMetadata c x $ RawPayload x mempty
  decode _ = pure . Right . inputPayloadData


data Protobuf = Protobuf

instance (Message a) => Codec Protobuf a where
  messageType _ x = encodeUtf8 $ messageName $ pure x
  encoding _ _ = "binary/protobuf"
  encode c x = pure $ insertStandardMetadata c x $ RawPayload (encodeMessage x) mempty
  decode _ = pure . decodeMessage . inputPayloadData

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

instance Codec Zlib RawPayload where
  encoding _ _ = "binary/zlib"
  -- TODO, if we keep the original compression size, we can allocate the right size buffer for the decompressed data.
  encode Zlib{..} p = if BS.length msg >= minimumEncodingSize && BS.length compressed < BS.length msg
    then pure $ RawPayload compressed (Map.singleton "encoding" "binary/zlib")
    else pure p
    where
      msg = encodeMessage $ convertToProtoPayload p
      compressed = BL.toStrict $ compress zlibFormat compressParams $ BL.fromStrict p.inputPayloadData
  decode Zlib{..} p = case p.inputPayloadMetadata Map.!? "encoding" of
  -- TODO, use `decompressIO` instead of `decompress`  so we can return the error in the Left case.
    Just "binary/zlib" -> pure $ 
      fmap convertFromProtoPayload $ 
      decodeMessage $ 
      BS.toStrict $ 
      decompress zlibFormat decompressParams $ 
      BL.fromStrict p.inputPayloadData
    _ -> pure $ Right p

-- | A codec that post-processes the payload after encoding and pre-processes before decoding.
--
-- Combining multiple 'RawPayloadProcessor's will apply them in the order that they are added.
-- For example, if you want to compress and then encrypt, you would add the compression processor
-- first, then the encryption processor.
data RawPayloadProcessor = RawPayloadProcessor
  { rawPayloadProcessorEncode :: RawPayload -> IO RawPayload
  , rawPayloadProcessorDecode :: RawPayload -> IO (Either String RawPayload)
  }
-- TODO, need to make sure to unit test this before using it. The ordering guarantees have me confused.
-- instance Semigroup RawPayloadProcessor where
--   RawPayloadProcessor e1 d1 <> RawPayloadProcessor e2 d2 = RawPayloadProcessor
--     { rawPayloadProcessorEncode = 
--     , rawPayloadProcessorDecode = 
--     }
-- instance Monoid RawPayloadProcessor where
--   mempty = RawPayloadProcessor pure (pure . Right)

mkPayloadProcessor :: Codec fmt RawPayload => fmt -> RawPayloadProcessor
mkPayloadProcessor fmt = RawPayloadProcessor
  { rawPayloadProcessorEncode = encode fmt
  , rawPayloadProcessorDecode = decode fmt
  }

addPayloadProcessor :: Codec fmt RawPayload => fmt -> RawPayloadProcessor -> RawPayloadProcessor
addPayloadProcessor fmt RawPayloadProcessor{..} = RawPayloadProcessor
  { rawPayloadProcessorEncode = \p -> do
      p' <- rawPayloadProcessorEncode p
      encode fmt p'
  , rawPayloadProcessorDecode = \p -> do
      p' <- decode fmt p
      case p' of
        Left err -> pure $ Left err
        Right ok -> rawPayloadProcessorDecode ok
  }


-- | A codec that uses the base codec for actually encoding and decoding, but
-- supports additional pre- and post-processing. This is useful for adding
-- compression, encryption, or other transformations to an existing codec.
data Around base = Around
  { around :: RawPayloadProcessor
  , baseCodec :: base
  }


instance (Typeable a, Codec base a) => Codec (Around base) a where
  encoding (Around _ base) = encoding base
  encode (Around p base) x = encode base x >>= rawPayloadProcessorEncode p
  decode (Around p base) x = rawPayloadProcessorDecode p x >>= \case
    Left err -> pure $ Left err
    Right x -> decode base x

type family ArgsOf f where
  ArgsOf (arg -> rest) = arg ': ArgsOf rest
  ArgsOf result = '[]

type family ResultOf (m :: Type -> Type) f where
  ResultOf m (arg -> rest) = ResultOf m rest
  ResultOf m (m result) = result
  ResultOf m result = TypeError ('Text "This function must use the (" ':<>: 'ShowType m ':<>: 'Text ") monad." :$$: ('Text "Current type: " ':<>: 'ShowType result))

class (Codec codec (ResultOf m f), Typeable (ResultOf m f)) => EncodeResultOf codec (m :: Type -> Type) (f :: Type)
instance (Codec codec (ResultOf m f), Typeable (ResultOf m f)) => EncodeResultOf codec (m :: Type -> Type) (f :: Type)

-- | Construct a function type from a list of argument types and a result type.
type family (:->:) (args :: [Type]) (result :: Type) where
  (:->:) '[] result = result
  (:->:) (arg ': args) result = arg -> (args :->: result)

data RawPayload = RawPayload
  { inputPayloadData :: ByteString
  , inputPayloadMetadata :: Map Text ByteString
  } deriving (Eq, Show)


base64DecodeFromText :: MonadFail m => T.Text -> m ByteString
base64DecodeFromText txt = case decodeBase64 $ Text.encodeUtf8 txt of
  Left err -> fail $ Text.unpack err
  Right ok -> pure ok

instance FromJSON RawPayload where
  parseJSON = withObject "RawPayload" $ \o -> do
    rawPayloadData <- o .:? "data"
    rawPayloadMetadata <- o .:? "metadata"
    inputPayloadData <- maybe (pure mempty) base64DecodeFromText rawPayloadData
    inputPayloadMetadata <- maybe (pure mempty) (traverse base64DecodeFromText) rawPayloadMetadata
    pure RawPayload{..}

instance ToJSON RawPayload where
  toJSON RawPayload{..} = object $
    (if inputPayloadData == "" then id else (("data" .= encodeBase64 inputPayloadData):)) $
    (if Map.null inputPayloadMetadata then id else (("metadata" .= fmap encodeBase64 inputPayloadMetadata) :))
    []
  toEncoding RawPayload{..} = pairs $
    (if inputPayloadData == "" then mempty else ("data" .= encodeBase64 inputPayloadData)) <>
    (if Map.null inputPayloadMetadata then mempty else ("metadata" .= fmap encodeBase64 inputPayloadMetadata))

convertFromProtoPayload :: Proto.Payload -> RawPayload
convertFromProtoPayload p = RawPayload (p ^. Proto.data') (p ^. Proto.metadata)

convertToProtoPayload :: RawPayload -> Proto.Payload
convertToProtoPayload (RawPayload d m) = defMessage
  & Proto.data' .~ d
  & Proto.metadata .~ m

class ApplyPayloads codec (args :: [Type]) where
  applyPayloads 
    :: codec 
    -> Proxy args 
    -> Proxy result 
    -> (args :->: result)
    -> V.Vector RawPayload
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
-- 'RawPayload's and does something useful with them. This is used to support outbound invocations of
-- child workflows, activities, queries, and signals.
class GatherArgs codec (args :: [Type]) where
  gatherArgs 
    :: Proxy args 
    -> codec 
    -> ([IO RawPayload] -> [IO RawPayload]) 
    -> ([IO RawPayload] -> result)
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

class (FunctionSupportsCodec codec (ArgsOf f) (ResultOf m f), f ~ ArgsOf f :->: m (ResultOf m f)) => FunctionSupportsCodec' (m :: Type -> Type) codec f
instance (FunctionSupportsCodec codec (ArgsOf f) (ResultOf m f), f ~ ArgsOf f :->: m (ResultOf m f)) => FunctionSupportsCodec' m codec f
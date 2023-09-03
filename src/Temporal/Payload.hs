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
  , encode
  , Codec(..)
  , JSON(..)
  , Null(..)
  , Binary(..)
  , Protobuf(..)
  , applyPayloads
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

import Data.Aeson hiding (encode, decode)
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as C
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
  encodingType :: fmt -> Proxy a -> ByteString
  messageType :: fmt -> a -> ByteString
  default messageType :: (Typeable a) => fmt -> a -> ByteString
  messageType _ _ = C.pack $ show $ typeRep (Proxy @a)
  encodePayload :: fmt -> a -> IO ByteString
  encodeExtraMetadata :: fmt -> a -> Map Text ByteString
  encodeExtraMetadata = mempty
  decode :: fmt -> RawPayload -> IO (Either String a)

encode :: forall fmt a. Codec fmt a => fmt -> a -> IO RawPayload
encode fmt x = RawPayload <$> encodePayload fmt x <*> pure
  (Map.fromList 
    [ ("encoding", (encodingType fmt (Proxy @a)))
    , ("messageType", messageType fmt x)
    ]
  <> encodeExtraMetadata fmt x)

data JSON = JSON

instance (Typeable a, Aeson.ToJSON a, Aeson.FromJSON a) => Codec JSON a where
  encodingType _ _ = "json/plain"
  encodePayload _ x = pure . BL.toStrict $ Aeson.encode x
  decode _ = pure . Aeson.eitherDecodeStrict' . inputPayloadData


data Null = Null

instance Codec Null () where
  encodingType _ _ = "binary/null"
  encodePayload _ _ = mempty
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
  encodingType _ _ = "binary/plain"
  encodePayload _ x = pure x
  decode _ = pure . Right . inputPayloadData


data Protobuf = Protobuf

instance (Message a) => Codec Protobuf a where
  messageType _ x = encodeUtf8 $ messageName $ pure x
  encodingType _ _ = "binary/protobuf"
  encodePayload _ = pure . encodeMessage
  decode _ = pure . decodeMessage . inputPayloadData

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
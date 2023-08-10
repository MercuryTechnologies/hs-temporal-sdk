{-# OPTIONS_GHC -fplugin=IfSat.Plugin #-}
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
  , defaultCodec
  , JSON(..)
  , Null(..)
  , Binary(..)
  , Protobuf(..)
  , applyPayloads
  , ApplyPayloads
  , GatherArgs(..)
  , ArgsOf
  , ResultOf
  , resultOf
  , wrappedResultOf
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
import Data.Constraint.If
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
  encodePayload :: fmt -> a -> ByteString
  decode :: fmt -> RawPayload -> Either String a

encode :: forall fmt a. Codec fmt a => fmt -> a -> RawPayload
encode fmt x = RawPayload 
  (encodePayload fmt x) 
  (Map.fromList 
    [ ("encoding", (encodingType fmt (Proxy @a)))
    , ("messageType", messageType fmt x)
    ]
  )

data JSON = JSON

instance (Typeable a, Aeson.ToJSON a, Aeson.FromJSON a) => Codec JSON a where
  encodingType _ _ = "json/plain"
  encodePayload _ x = BL.toStrict $ Aeson.encode x
  decode _ = Aeson.eitherDecodeStrict' . inputPayloadData


data Null = Null

instance Codec Null () where
  encodingType _ _ = "binary/null"
  encodePayload _ _ = mempty
  decode _ _ = Right ()

data Binary = Binary

instance Codec Binary ByteString where
  encodingType _ _ = "binary/plain"
  encodePayload _ x = x
  decode _ = Right . inputPayloadData

data Protobuf = Protobuf

instance (Message a) => Codec Protobuf a where
  messageType _ x = encodeUtf8 $ messageName $ pure x
  encodingType _ _ = "binary/protobuf"
  encodePayload _ x = encodeMessage x
  decode _ = decodeMessage . inputPayloadData

data Composite (codecs :: [Type]) where
  CompositeNil :: Composite '[]
  CompositeCons :: codec -> Composite codecs -> Composite (codec ': codecs)

instance TypeError (('ShowType a) ':<>: 'Text " is not supported by any of the provided codecs") => Codec (Composite '[]) a where
  messageType = error "unreachable"
  encodingType = error "unreachable"
  encodePayload = error "unreachable"
  decode _ _ = Left "No recognized codec for this type"

instance (Codec fmt a || Codec (Composite codecs) a) => Codec (Composite (fmt ': codecs)) a where
  messageType fmt = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of CompositeCons codec _ -> messageType codec) 
    (case fmt of CompositeCons _ codecs -> messageType codecs)
  encodingType fmt = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of CompositeCons codec _ -> encodingType codec) 
    (case fmt of CompositeCons _ codecs -> encodingType codecs)
  encodePayload fmt = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of CompositeCons codec _ -> encodePayload codec)
    (case fmt of CompositeCons _ codecs -> encodePayload codecs)
  decode fmt payload = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of 
      CompositeCons codec codecs -> if Just (encodingType codec (Proxy @a)) == payload.inputPayloadMetadata Map.!? "encoding"
        then decode codec payload
        else ifSat @(Codec (Composite codecs) a)
          (decode codecs payload)
          (Left "No codec for this type supports this payload")
    )
    (case fmt of CompositeCons _ codecs -> decode codecs payload)

defaultCodec :: Composite '[Null, Binary, Protobuf, JSON]
defaultCodec = CompositeCons Temporal.Payload.Null $ CompositeCons Binary $ CompositeCons Protobuf $ CompositeCons JSON CompositeNil

type family ArgsOf f where
  ArgsOf (arg -> rest) = arg ': ArgsOf rest
  ArgsOf result = '[]

type family ResultOf (m :: Type -> Type) f where
  ResultOf m (arg -> rest) = ResultOf m rest
  ResultOf m (m result) = result
  ResultOf m result = TypeError ('Text "This function must use the (" ':<>: 'ShowType m ':<>: 'Text ") monad." :$$: ('Text "Current type: " ':<>: 'ShowType result))

resultOf :: forall m f. Proxy m -> f -> Proxy (ResultOf m f)
resultOf _ _ = Proxy

wrappedResultOf :: forall m f. Proxy m -> f -> Proxy (m (ResultOf m f))
wrappedResultOf _ _ = Proxy

-- | Construct a function type from a list of argument types and a result type.
type family (:->:) (args :: [Type]) (result :: Type) where
  (:->:) '[] result = result
  (:->:) (arg ': args) result = arg -> (args :->: result)

data RawPayload = RawPayload
  { inputPayloadData :: ByteString
  , inputPayloadMetadata :: Map Text ByteString
  } deriving (Eq, Show)

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
    -> IO result

instance ApplyPayloads codec '[] where
  applyPayloads _ _ _ f _ = pure f

instance (Codec codec ty, ApplyPayloads codec tys) => ApplyPayloads codec (ty ': tys) where
  applyPayloads codec _ resP f vec = case V.uncons vec of
    Nothing -> error "Not enough arguments"
    Just (pl, rest) -> case decode codec pl of
      Right arg -> applyPayloads codec (Proxy @tys) resP (f arg) rest
      Left err -> error err

-- | Given a list of function argument types and a codec, produce a function that takes a list of
-- 'RawPayload's and does something useful with them. This is used to support outbound invocations of
-- child workflows, activities, queries, and signals.
class GatherArgs codec (args :: [Type]) where
  gatherArgs 
    :: Proxy args 
    -> codec 
    -> ([RawPayload] -> [RawPayload]) 
    -> ([RawPayload] -> result)
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

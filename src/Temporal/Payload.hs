{-# LANGUAGE
  AllowAmbiguousTypes,
  ConstraintKinds,
  DataKinds,
  FunctionalDependencies,
  FlexibleContexts,
  FlexibleInstances,
  GADTs,
  InstanceSigs,
  MultiParamTypeClasses,
  ScopedTypeVariables,
  TypeOperators,
  TypeFamilies,
  UndecidableInstances,
  TypeApplications #-}
module Temporal.Payload 
  ( Payload(..)
  , RawPayload(..)
  , Codec(..)
  , JSON(..)
  , gatherPayloads
  , ToPayloads
  , applyPayloads
  , ApplyPayloads
  , ArgsOf
  , ResultOf
  , BuildArgs
  , convertToProtoPayload
  , convertFromProtoPayload
  ) where

import Data.Aeson hiding (encode, decode)
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as BL
import Control.Exception (SomeException)
import Data.Kind
import Data.ProtoLens (defMessage)
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
{- * Parameter serialization 

We want to be able to serialize & deserialize the parameters of a function using an arbitrary serialization code. 
We do this by gathering the order of the parameters as a type-level list, then fold over the type level list to 
build a function with the same parameters that outputs a list of serialized params.

To deserialize, we do the inverse– we progressively apply the args of the function by consuming serialized params 
as we go. If there are not enough or too many params, we fail.
-}

-- | We want to be able to serialize & deserialize the parameters of a function using an arbitrary serialization format.
class Codec fmt a where
  encode :: fmt -> a -> IO RawPayload
  decode :: fmt -> RawPayload -> IO (Either String a)
  encodeException :: fmt -> SomeException -> IO RawPayload

data JSON = JSON

instance (Aeson.ToJSON a, Aeson.FromJSON a) => Codec JSON a where
  encode _ x = do
    pure $ RawPayload (BL.toStrict $ Aeson.encode x) mempty
  decode _ = pure . Aeson.eitherDecodeStrict' . inputPayloadData
  encodeException fmt e = encode fmt $ object
    [ "message" .= show e
    , "stack_trace" .= ("" :: String)
    ]

data Payload fmt = forall a. (Codec fmt a, Typeable a) => Payload 
  { payloadData :: a
  , payloadMetadata :: Map Text ByteString
  }

type family ArgsOf f where
  ArgsOf (arg -> rest) = arg ': ArgsOf rest
  ArgsOf result = '[]

type family ResultOf (m :: * -> *) f where
  ResultOf m (arg -> rest) = ResultOf m rest
  ResultOf m (m result) = result
  ResultOf m result = TypeError ('Text "This function must use the (" ':<>: 'ShowType m ':<>: 'Text ") monad." :$$: ('Text "Current type: " ':<>: 'ShowType result))

type family BuildArgs (args :: [*]) result where
  BuildArgs '[] result = result
  BuildArgs (arg ': args) result = arg -> BuildArgs args result

class ToPayloads codec (f :: [*]) where
  toPayloadsAp :: Proxy codec -> Proxy f -> ([Payload codec] -> [Payload codec]) -> BuildArgs f [Payload codec]

instance ToPayloads codec '[] where
  toPayloadsAp _ _ f = f []

instance (Codec codec arg, Typeable arg, ToPayloads codec args) => ToPayloads codec (arg ': args) where
  toPayloadsAp p _ f = \arg -> toPayloadsAp p (Proxy @args) ((Payload arg mempty :) . f)

gatherPayloads :: forall fmt f args. (args ~ ArgsOf f, ToPayloads fmt args) => Proxy f -> BuildArgs args [Payload fmt]
gatherPayloads f = toPayloadsAp (Proxy @fmt) (Proxy @args) id

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

class ApplyPayloads fmt f r | f -> r where
  applyPayloads :: fmt -> f -> V.Vector RawPayload -> IO (Either String r)

instance ApplyPayloads fmt f f where
  applyPayloads _ f vec = pure $ if V.null vec
    then Right f
    else Left "Too many arguments"

instance (Codec fmt arg, ApplyPayloads fmt rest r) => ApplyPayloads fmt (arg -> rest) r where
  applyPayloads p f vec = case V.uncons vec of
    Nothing -> pure $ Left "Not enough arguments"
    Just (pl, rest) -> do
      res <- decode p pl
      case res of
        Right arg -> applyPayloads p (f arg) rest
        Left err -> pure $ Left err

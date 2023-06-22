{-# LANGUAGE
  AllowAmbiguousTypes,
  ConstraintKinds,
  DataKinds,
  FunctionalDependencies,
  FlexibleContexts,
  FlexibleInstances,
  GADTs,
  InstanceSigs,
  PolyKinds,
  MultiParamTypeClasses,
  ScopedTypeVariables,
  TypeOperators,
  TypeFamilies,
  UndecidableInstances,
  TypeApplications 
  #-}
module Temporal.Payload 
  ( RawPayload(..)
  , Codec(..)
  , JSON(..)
  , applyPayloads
  , ApplyPayloads
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
import qualified Data.ByteString.Lazy as BL
import Control.Exception (SomeException)
import Data.Functor
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

type family ArgsOf f where
  ArgsOf (arg -> rest) = arg ': ArgsOf rest
  ArgsOf result = '[]

type family ResultOf (m :: * -> *) f where
  ResultOf m (arg -> rest) = ResultOf m rest
  ResultOf m (m result) = result
  ResultOf m result = TypeError ('Text "This function must use the (" ':<>: 'ShowType m ':<>: 'Text ") monad." :$$: ('Text "Current type: " ':<>: 'ShowType result))

resultOf :: forall m f. Proxy m -> f -> Proxy (ResultOf m f)
resultOf _ _ = Proxy

wrappedResultOf :: forall m f. Proxy m -> f -> Proxy (m (ResultOf m f))
wrappedResultOf _ _ = Proxy

-- | Construct a function type from a list of argument types and a result type.
type family (:->:) (args :: [*]) (result :: *) where
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

class ApplyPayloads codec (args :: [*]) result where
  applyPayloads 
    :: codec 
    -> Proxy args 
    -> Proxy result 
    -> (args :->: result)
    -> V.Vector RawPayload
    -> IO result

instance ApplyPayloads codec '[] result where
  applyPayloads _ _ _ f _ = pure f

instance (Codec codec ty, ApplyPayloads codec tys result) => ApplyPayloads codec (ty ': tys) result where
  applyPayloads codec _ _ f vec = case V.uncons vec of
    Nothing -> error "Not enough arguments"
    Just (pl, rest) -> do
      res <- decode codec pl
      case res of
        Right arg -> applyPayloads codec (Proxy @tys) (Proxy @result) (f arg) rest
        Left err -> error err

-- class ApplyPayloads codec f r | f -> r where
--   applyPayloads :: codec -> proxy r -> f -> V.Vector RawPayload -> IO (Either String r)

-- instance ApplyPayloads codec f f where
--   applyPayloads _ _ f vec = pure $ Right f

-- instance (Codec codec arg, ApplyPayloads codec rest r) => ApplyPayloads codec (arg -> rest) r where
--   applyPayloads p resultProof f vec = case V.uncons vec of
--     Nothing -> pure $ Left "Not enough arguments"
--     Just (pl, rest) -> do
--       res <- decode p pl
--       case res of
--         Right arg -> applyPayloads p resultProof (f arg) rest
--         Left err -> pure $ Left err

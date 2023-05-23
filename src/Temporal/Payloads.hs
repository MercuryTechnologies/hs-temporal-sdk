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
module Temporal.Payloads 
  ( Payload(..)
  , InputPayload(..)
  , Codec(..)
  , JSON
  , gatherPayloads
  , ToPayloads
  , applyPayloads
  , ApplyPayloads
  , ArgsOf
  , ResultOf
  , BuildArgs
  ) where

import Data.Aeson hiding (encode, decode)
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as BL
import Data.Kind
import Data.Text (Text)
import Data.Typeable (Typeable)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Typeable
import GHC.TypeLits
import Temporal.Workflow (Workflow)

{- * Parameter serialization 

We want to be able to serialize & deserialize the parameters of a function using an arbitrary serialization code. 
We do this by gathering the order of the parameters as a type-level list, then fold over the type level list to 
build a function with the same parameters that outputs a list of serialized params.

To deserialize, we do the inverse– we progressively apply the args of the function by consuming serialized params 
as we go. If there are not enough or too many params, we fail.
-}

-- | We want to be able to serialize & deserialize the parameters of a function using an arbitrary serialization format.
class Codec fmt a where
  encode :: Proxy fmt -> a -> ByteString
  decode :: Proxy fmt -> ByteString -> Either String a

data JSON

instance (Aeson.ToJSON a, Aeson.FromJSON a) => Codec JSON a where
  encode _ = BL.toStrict . Aeson.encode
  decode _ = Aeson.eitherDecodeStrict'

data Payload fmt = forall a. (Codec fmt a, Typeable a) => Payload 
  { payloadData :: a
  , payloadMetadata :: HashMap Text Text
  }

type family ArgsOf f where
  ArgsOf (arg -> rest) = arg ': ArgsOf rest
  ArgsOf result = '[]

type family ResultOf f where
  ResultOf (arg -> rest) = ResultOf rest
  ResultOf (Workflow env result) = result
  ResultOf result = TypeError ('Text "A workflow definition must use the Workflow monad." :$$: ('Text "Current type: " ':<>: 'ShowType result))

type family BuildArgs (args :: [*]) result where
  BuildArgs '[] result = result
  BuildArgs (arg ': args) result = arg -> BuildArgs args result

class ToPayloads fmt (f :: [*]) where
  toPayloadsAp :: Proxy fmt -> Proxy f -> ([Payload fmt] -> [Payload fmt]) -> BuildArgs f [Payload fmt]

instance ToPayloads fmt '[] where
  toPayloadsAp _ _ f = f []

instance (Codec fmt arg, Typeable arg, ToPayloads fmt args) => ToPayloads fmt (arg ': args) where
  toPayloadsAp p _ f = \arg -> toPayloadsAp p (Proxy @args) ((Payload arg HashMap.empty :) . f)

gatherPayloads :: forall fmt f args. (args ~ ArgsOf f, ToPayloads fmt args) => Proxy f -> BuildArgs args [Payload fmt]
gatherPayloads f = toPayloadsAp (Proxy @fmt) (Proxy @args) id

data InputPayload = InputPayload
  { inputPayloadData :: ByteString
  , inputPayloadMetadata :: HashMap Text Text
  }

class ApplyPayloads fmt f r | f -> r where
  applyPayloads :: Proxy fmt -> f -> [InputPayload] -> Either String r

instance ApplyPayloads fmt f f where
  applyPayloads _ f [] = Right f
  applyPayloads _ _ _ = Left "Too many arguments"

instance (Codec fmt arg, ApplyPayloads fmt rest r) => ApplyPayloads fmt (arg -> rest) r where
  applyPayloads p f (InputPayload bs _ : rest) = case decode p bs of
    Right arg -> applyPayloads p (f arg) rest
    Left err -> Left err
  applyPayloads _ _ _ = Left "Not enough arguments"

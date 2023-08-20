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
  , Composite(..)
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
  encodePayload _ x = x
  decode _ = Right . inputPayloadData


data Protobuf = Protobuf

instance (Message a) => Codec Protobuf a where
  messageType _ x = encodeUtf8 $ messageName $ pure x
  encodingType _ _ = "binary/protobuf"
  encodePayload _ x = encodeMessage x
  decode _ = decodeMessage . inputPayloadData

-- | The 'Composite' codec allows you to combine multiple codecs into one.
--
-- The codecs are tried in order, and the first one that succeeds is used.
-- If none of the codecs succeed, the compile-time error message will indicate
-- the type that didn't satisfy any of the specified codecs.
--
-- This Codec is useful when you want to support multiple serialization formats
-- and choose the best / most performant one for each type.
--
-- Note that this Codec relies upon the 'if-instance' package, which supplies
-- a compiler plugin that allows us to use this. You must add the following
-- pragma to the module that registers your workflow code:
--
-- > {-# OPTIONS_GHC -fplugin=IfSat.Plugin #-}
-- > -- ^ Put this at the top of the module that registers your workflow code.
-- >
-- > let testFn :: Int -> Text -> Bool -> W.Workflow () () (Int, Text, Bool)
-- >     testFn a b c = pure (a, b, c)
-- >     wf = W.provideWorkflow defaultCodec "test" () testFn
-- >     conf = configure () () $ do
-- >       addWorkflow wf
--
-- If you forget to add this pragma, your code will fail to compile with
-- a message like:
--
-- > hs-temporal/test/IntegrationSpec.hs:66:16: error:
-- >    • No instance for (Codec Null ()
-- >                       Data.Constraint.If.|| Codec
-- >                                               (Temporal.Payload.Composite
-- >                                                  '[Binary, Protobuf, JSON])
-- >                                               ())
-- >        arising from a use of ‘W.provideWorkflow’
-- >    • In the expression:
-- >        W.provideWorkflow defaultCodec "test" () testFn
-- >      In an equation for ‘wf’:
-- >          wf = W.provideWorkflow defaultCodec "test" () testFn
-- >      In the expression:
-- >        do taskQueue <- W.TaskQueue <$> uuidText
-- >           let testFn :: W.Workflow () () ()
-- >               testFn = pure ()
-- >               ....
-- >           withWorker conf
-- >             $ do wfId <- uuidText
-- >                  let ...
-- >                  ....
-- >   |
-- >66 |           wf = W.provideWorkflow defaultCodec "test" () testFn
-- >   |                ^^^^^^^^^^^^^^^^^

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
    -> Either String result

instance ApplyPayloads codec '[] where
  applyPayloads _ _ _ f _ = Right f

instance (Codec codec ty, ApplyPayloads codec tys) => ApplyPayloads codec (ty ': tys) where
  applyPayloads codec _ resP f vec = case V.uncons vec of
    Nothing -> Left "Not enough arguments"
    Just (pl, rest) -> case decode codec pl of
      Right arg -> applyPayloads codec (Proxy @tys) resP (f arg) rest
      Left err -> Left err

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

class (GatherArgs codec (ArgsOf f)) => GatherArgsOf codec f
instance (GatherArgs codec (ArgsOf f)) => GatherArgsOf codec f

class (GatherArgs codec args, Codec codec result, Typeable result, ApplyPayloads codec args) => FunctionSupportsCodec codec args result
instance (GatherArgs codec args, Codec codec result, Typeable result, ApplyPayloads codec args) => FunctionSupportsCodec codec args result

class (FunctionSupportsCodec codec (ArgsOf f) (ResultOf m f), f ~ ArgsOf f :->: m (ResultOf m f)) => FunctionSupportsCodec' (m :: Type -> Type) codec f
instance (FunctionSupportsCodec codec (ArgsOf f) (ResultOf m f), f ~ ArgsOf f :->: m (ResultOf m f)) => FunctionSupportsCodec' m codec f
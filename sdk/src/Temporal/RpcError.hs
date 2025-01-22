{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE PartialTypeSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}

module Temporal.RpcError where

import Data.Functor
import Data.Typeable
import Language.Haskell.TH
import Proto.Temporal.Api.Errordetails.V1.Message ()
import Data.Functor ((<&>))
import Data.ByteString (ByteString)
import Data.Map qualified as Map
import Data.ProtoLens.Any (Any)
import Data.ProtoLens.Encoding (decodeMessage)
import Data.ProtoLens.Message (Message (..), Registry, SomeMessageType (..), lookupRegistered, register)
import Data.ProtoLens.TextFormat (showMessage)
import Data.Proxy (Proxy (..))
import Data.Text qualified as T
import DiscoverInstances (SomeDictOf (..), discoverInstances)
import Lens.Family2 ((^.))
import Proto.Rpc.Status
import Unsafe.Coerce (unsafeCoerce)


decodeStatus :: ByteString -> [Either String T.Text]
decodeStatus payload = case decodeMessage @Status payload of
  Left err -> [Left ("failed to decode " <> err)]
  Right status -> (status ^. #details) <&> \(each :: Any) -> do
    case lookupRegistered (each ^. #typeUrl) errorDetailsRegistry of
      Nothing -> Left "couldn't find type URL in registry"
      Just (SomeMessageType (Proxy :: Proxy msg)) -> case decodeMessage @msg (each ^. #value) of
        Left err -> Left ("failed to decode value using registered codec " <> err)
        Right msg -> Right . T.pack $ showMessage msg
  
-- FIXME(jkachmar): Should this whole thing be a TH splice, so that the
-- Registry is generated at compile-time (rather than the dictionary being
-- retrieved at compile-time & the 'Registry' itself having some runtime overhead)?
-- FIXME(jkachmar): This should be in its own module so we can control how many
-- instances are in scope when `discoverInstances` is called.

{- | Set of known message types that can be used as codecs for Temporal error
details (which are serialized as @Data.Protobuf.Any@ values).

Can be used to decode the 'RpcError'@.@'details' field when handling Temporal
errors.
-}
errorDetailsRegistry :: Registry
errorDetailsRegistry =
  foldMap (\(SomeDictOf proxy) -> register proxy) $$(discoverInstances @Message)

-- FIXME(jkachmar): Debugging, to verify that this actually works.
--
-- `Map.keys unsafeRpcErrorMap` ->
--
-- ["coresdk.ActivityHeartbeat","coresdk.ActivityTaskCompletion","coresdk.activity_result.ActivityExecutionResult" ...]`
unsafeErrorDetailsRegistry :: Map.Map T.Text SomeMessageType
unsafeErrorDetailsRegistry = unsafeCoerce errorDetailsRegistry


-- example pulled from error log output when calling `listSearchAttributes`
-- with an invalid `Namespace` argument.
example :: ByteString
example = "\b\ENQ\DC2\ESCNamespace foo is not found.\SUBR\nItype.googleapis.com/temporal.api.errordetails.v1.NamespaceNotFoundFailure\DC2\ENQ\n\ETXfoo"

{- |
Module: Temporal.Operator
Description: Operator API bindings for Temporal.

This module provides bindings for the Temporal Operator API. The Operator API
is used to manage Temporal namespaces, clusters, and other administrative
tasks.
-}
module Temporal.Operator where

import Control.Monad.IO.Class
import Data.Bifunctor (bimap)
import Data.Int (Int64)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map

import Data.Text (Text)
import qualified Data.Vector as V
import qualified Proto.Temporal.Api.Enums.V1.Common as Proto
import qualified Proto.Temporal.Api.Nexus.V1.Message as NexusProto
import qualified Proto.Temporal.Api.Operatorservice.V1.RequestResponse as OperatorProto
import Temporal.Common (Namespace (..), NexusEndpointName (..), TaskQueue (..))
import Temporal.Core.Client
import qualified Temporal.Core.Client.OperatorService as Core
import qualified Temporal.Exception
import Temporal.SearchAttributes (SearchAttributeKey (..))
import Temporal.SearchAttributes.Internal


data IndexedValueType
  = Text
  | Keyword
  | Int
  | Double
  | Bool
  | Datetime
  | KeywordList
  | UnrecognizedIndexedValueType
  deriving stock (Eq, Show)


data SearchAttributes = SearchAttributes
  { customAttributes :: Map SearchAttributeKey IndexedValueType
  , systemAttributes :: Map SearchAttributeKey IndexedValueType
  , storageSchema :: Map Text Text
  }


searchAttributeTypeFromProto :: Proto.IndexedValueType -> IndexedValueType
searchAttributeTypeFromProto = \case
  Proto.IndexedValueType'IndexedValueTypeUnspecified -> UnrecognizedIndexedValueType
  Proto.IndexedValueType'IndexedValueTypeText -> Text
  Proto.IndexedValueType'IndexedValueTypeKeyword -> Keyword
  Proto.IndexedValueType'IndexedValueTypeInt -> Int
  Proto.IndexedValueType'IndexedValueTypeDouble -> Double
  Proto.IndexedValueType'IndexedValueTypeBool -> Bool
  Proto.IndexedValueType'IndexedValueTypeDatetime -> Datetime
  Proto.IndexedValueType'IndexedValueTypeKeywordList -> KeywordList


searchAttributeTypeToProto :: IndexedValueType -> Proto.IndexedValueType
searchAttributeTypeToProto = \case
  UnrecognizedIndexedValueType -> Proto.IndexedValueType'IndexedValueTypeUnspecified
  Text -> Proto.IndexedValueType'IndexedValueTypeText
  Keyword -> Proto.IndexedValueType'IndexedValueTypeKeyword
  Int -> Proto.IndexedValueType'IndexedValueTypeInt
  Double -> Proto.IndexedValueType'IndexedValueTypeDouble
  Bool -> Proto.IndexedValueType'IndexedValueTypeBool
  Datetime -> Proto.IndexedValueType'IndexedValueTypeDatetime
  KeywordList -> Proto.IndexedValueType'IndexedValueTypeKeywordList

searchAttributeEntriesToProto :: Map Text Proto.IndexedValueType -> V.Vector OperatorProto.AddSearchAttributesRequest'SearchAttributesEntry
searchAttributeEntriesToProto =
  V.fromList
    . fmap (\(k, v) -> OperatorProto.AddSearchAttributesRequest'SearchAttributesEntry (Just k) (Just v) [])
    . Map.toList


customAttributesFromProto :: V.Vector OperatorProto.ListSearchAttributesResponse'CustomAttributesEntry -> Map Text Proto.IndexedValueType
customAttributesFromProto =
  V.foldr
    ( \(OperatorProto.ListSearchAttributesResponse'CustomAttributesEntry k v _) acc ->
        case (k, v) of
          (Just key, Just value) -> Map.insert key value acc
          _ -> acc
    )
    Map.empty


systemAttributesFromProto :: V.Vector OperatorProto.ListSearchAttributesResponse'SystemAttributesEntry -> Map Text Proto.IndexedValueType
systemAttributesFromProto =
  V.foldr
    ( \(OperatorProto.ListSearchAttributesResponse'SystemAttributesEntry k v _) acc ->
        case (k, v) of
          (Just key, Just value) -> Map.insert key value acc
          _ -> acc
    )
    Map.empty


storageSchemaFromProto :: V.Vector OperatorProto.ListSearchAttributesResponse'StorageSchemaEntry -> Map Text Text
storageSchemaFromProto =
  V.foldr
    ( \(OperatorProto.ListSearchAttributesResponse'StorageSchemaEntry k v _) acc ->
        case (k, v) of
          (Just key, Just value) -> Map.insert key value acc
          _ -> acc
    )
    Map.empty

listSearchAttributes :: MonadIO m => Client -> Namespace -> m (Either Temporal.Exception.RpcError SearchAttributes)
listSearchAttributes c (Namespace n) = do
  res <- liftIO $ Core.listSearchAttributes c (OperatorProto.ListSearchAttributesRequest (Just n) [])
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError convert res
  where
    convert (OperatorProto.ListSearchAttributesResponse customAttrs systemAttrs schema _) =
      SearchAttributes
        { customAttributes = wrappedKeys $ fmap searchAttributeTypeFromProto $ customAttributesFromProto customAttrs
        , systemAttributes = wrappedKeys $ fmap searchAttributeTypeFromProto $ systemAttributesFromProto systemAttrs
        , storageSchema = storageSchemaFromProto schema
        }


addSearchAttributes :: MonadIO m => Client -> Namespace -> Map SearchAttributeKey IndexedValueType -> m (Either Temporal.Exception.RpcError ())
addSearchAttributes c (Namespace n) newAttrs = do
  if null newAttrs
    then pure $ Right ()
    else do
      res <-
        liftIO $
          Core.addSearchAttributes
            c
            (OperatorProto.AddSearchAttributesRequest (searchAttributeEntriesToProto converted) (Just n) [])
      pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res
  where
    converted = rawKeys $ fmap searchAttributeTypeToProto newAttrs


data NexusEndpoint = NexusEndpoint
  { endpointId :: Text
  , endpointVersion :: Int64
  }
  deriving stock (Eq, Show)


-- | Create a Nexus endpoint that routes to a worker's task queue.
createNexusEndpoint :: MonadIO m => Client -> NexusEndpointName -> Namespace -> TaskQueue -> m (Either Temporal.Exception.RpcError NexusEndpoint)
createNexusEndpoint c (NexusEndpointName name) (Namespace ns) (TaskQueue tq) = do
  res <-
    liftIO $
      Core.createNexusEndpoint
        c
        ( OperatorProto.CreateNexusEndpointRequest
            ( Just $
                NexusProto.EndpointSpec
                  (Just name)
                  Nothing
                  ( Just $
                      NexusProto.EndpointTarget
                        ( Just $
                            NexusProto.EndpointTarget'Variant'Worker $
                              NexusProto.EndpointTarget'Worker (Just ns) (Just tq) []
                        )
                        []
                  )
                  []
            )
            []
        )
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError extractEndpoint res
  where
    extractEndpoint (OperatorProto.CreateNexusEndpointResponse (Just (NexusProto.Endpoint version endpointId _ _ _ _ _)) _) =
      NexusEndpoint
        { endpointId = maybe "" id endpointId
        , endpointVersion = maybe 0 id version
        }
    extractEndpoint _ = NexusEndpoint "" 0


-- | Delete a Nexus endpoint by its ID and version.
deleteNexusEndpoint :: MonadIO m => Client -> NexusEndpoint -> m (Either Temporal.Exception.RpcError ())
deleteNexusEndpoint c ep = do
  res <-
    liftIO $
      Core.deleteNexusEndpoint
        c
        (OperatorProto.DeleteNexusEndpointRequest (Just ep.endpointId) (Just ep.endpointVersion) [])
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res

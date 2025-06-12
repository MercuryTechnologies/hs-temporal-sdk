{- |
Module: Temporal.Operator
Description: Operator API bindings for Temporal.

This module provides bindings for the Temporal Operator API. The Operator API
is used to manage Temporal namespaces, clusters, and other administrative
tasks.
-}
module Temporal.Operator where

import Control.Monad
import Control.Monad.IO.Class
import Data.Bifunctor (bimap)
import Data.Map.Strict (Map)
import Data.ProtoLens (Message (defMessage))
import Data.Text (Text)
import Lens.Family2
import qualified Proto.Temporal.Api.Enums.V1.Common as Proto
import qualified Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields as Proto
import Temporal.Core.Client
import qualified Temporal.Core.Client.OperatorService as Core
import qualified Temporal.Exception
import Temporal.SearchAttributes (SearchAttributeKey (..))
import Temporal.SearchAttributes.Internal
import Temporal.Workflow (Namespace (..))


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
  Proto.INDEXED_VALUE_TYPE_UNSPECIFIED -> UnrecognizedIndexedValueType
  Proto.INDEXED_VALUE_TYPE_TEXT -> Text
  Proto.INDEXED_VALUE_TYPE_KEYWORD -> Keyword
  Proto.INDEXED_VALUE_TYPE_INT -> Int
  Proto.INDEXED_VALUE_TYPE_DOUBLE -> Double
  Proto.INDEXED_VALUE_TYPE_BOOL -> Bool
  Proto.INDEXED_VALUE_TYPE_DATETIME -> Datetime
  Proto.INDEXED_VALUE_TYPE_KEYWORD_LIST -> KeywordList
  (Proto.IndexedValueType'Unrecognized _) -> UnrecognizedIndexedValueType


searchAttributeTypeToProto :: IndexedValueType -> Proto.IndexedValueType
searchAttributeTypeToProto = \case
  UnrecognizedIndexedValueType -> Proto.INDEXED_VALUE_TYPE_UNSPECIFIED
  Text -> Proto.INDEXED_VALUE_TYPE_TEXT
  Keyword -> Proto.INDEXED_VALUE_TYPE_KEYWORD
  Int -> Proto.INDEXED_VALUE_TYPE_INT
  Double -> Proto.INDEXED_VALUE_TYPE_DOUBLE
  Bool -> Proto.INDEXED_VALUE_TYPE_BOOL
  Datetime -> Proto.INDEXED_VALUE_TYPE_DATETIME
  KeywordList -> Proto.INDEXED_VALUE_TYPE_KEYWORD_LIST


listSearchAttributes :: MonadIO m => Client -> Namespace -> m (Either Temporal.Exception.RpcError SearchAttributes)
listSearchAttributes c (Namespace n) = do
  res <- liftIO $ Core.listSearchAttributes c (defMessage & Proto.namespace .~ n)
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError convert res
  where
    convert res =
      SearchAttributes
        { customAttributes = wrappedKeys $ fmap searchAttributeTypeFromProto $ res ^. Proto.customAttributes
        , systemAttributes = wrappedKeys $ fmap searchAttributeTypeFromProto $ res ^. Proto.systemAttributes
        , storageSchema = res ^. Proto.storageSchema
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
            ( defMessage
                & Proto.namespace .~ n
                & Proto.searchAttributes .~ converted
            )
      pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res
  where
    converted = rawKeys $ fmap searchAttributeTypeToProto newAttrs

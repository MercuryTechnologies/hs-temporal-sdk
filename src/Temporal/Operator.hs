-- |
-- Module: Temporal.Operator
-- Description: Operator API bindings for Temporal.
-- 
-- This module provides bindings for the Temporal Operator API. The Operator API
-- is used to manage Temporal namespaces, clusters, and other administrative
-- tasks.
module Temporal.Operator where

import qualified Temporal.Core.Client.OperatorService as Core
import Data.Map.Strict (Map)
import Control.Monad.IO.Class
import Data.Text (Text)
import Temporal.Core.Client
import Temporal.Workflow (Namespace(..))
import qualified Proto.Temporal.Api.Enums.V1.Common as Proto
import qualified Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields as Proto
import Lens.Family2
import Data.ProtoLens (Message(defMessage))
import UnliftIO

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
  { customAttributes :: Map Text IndexedValueType
  , systemAttributes :: Map Text IndexedValueType
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

listSearchAttributes :: MonadIO m => Client -> Namespace -> m (Either RpcError SearchAttributes)
listSearchAttributes c (Namespace n) = do
  res <- liftIO $ Core.listSearchAttributes c (defMessage & Proto.namespace .~ n)
  pure $ fmap convert res
  where
    convert res = SearchAttributes
      { customAttributes = fmap searchAttributeTypeFromProto $ res ^. Proto.customAttributes
      , systemAttributes = fmap searchAttributeTypeFromProto $ res ^. Proto.systemAttributes
      , storageSchema = res ^. Proto.storageSchema 
      }

addSearchAttributes :: MonadIO m => Client -> Namespace -> Map Text IndexedValueType -> m (Either RpcError ())
addSearchAttributes c (Namespace n) newAttrs = do
  res <- liftIO $ Core.addSearchAttributes c 
    ( defMessage 
      & Proto.namespace .~ n
      & Proto.searchAttributes .~ converted
    )
  pure $ fmap (\_ -> ()) res
  where
    converted = fmap searchAttributeTypeToProto newAttrs
{-# LANGUAGE DuplicateRecordFields #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Temporal.Client.Namespace (
  Temporal.Client.Namespace.listNamespaces,
  ListNamespacesRequest (..),
  DescribeNamespaceResponse (..),
  NamespaceFilter (..),
  NamespaceState (..),
  NamespaceInfo (..),
  NamespaceCapabilities (..),
  ArchivalState (..),
  BadBinaryInfo (..),
  BadBinaries (..),
  NamespaceConfig (..),
  NamespaceReplicationConfig (..),
  FailoverStatus (..),
) where

import Conduit
import Control.Monad
import Control.Monad.IO.Class
import qualified Data.ByteString as BS
import Data.Int (Int32, Int64)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import qualified Data.Vector as V
import qualified Proto.Temporal.Api.Enums.V1.Namespace as E
import qualified Proto.Temporal.Api.Namespace.V1.Message as M (
  BadBinaries (BadBinaries),
  BadBinaries'BinariesEntry (BadBinaries'BinariesEntry),
  BadBinaryInfo (BadBinaryInfo),
  NamespaceConfig (NamespaceConfig),
  NamespaceConfig'CustomSearchAttributeAliasesEntry (NamespaceConfig'CustomSearchAttributeAliasesEntry),
  NamespaceFilter (NamespaceFilter),
  NamespaceInfo (NamespaceInfo),
  NamespaceInfo'Capabilities (NamespaceInfo'Capabilities),
  NamespaceInfo'DataEntry (NamespaceInfo'DataEntry),
 )
import qualified Proto.Temporal.Api.Replication.V1.Message as R (
  ClusterReplicationConfig (ClusterReplicationConfig),
  FailoverStatus (FailoverStatus),
  NamespaceReplicationConfig (NamespaceReplicationConfig),
 )
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse as RR (
  DescribeNamespaceResponse (DescribeNamespaceResponse),
  ListNamespacesRequest (ListNamespacesRequest),
  ListNamespacesResponse (ListNamespacesResponse),
 )
import Temporal.Client (HasWorkflowClient (..))
import Temporal.Client.Types
import Temporal.Common
import Temporal.Core.Client.WorkflowService (listNamespaces)
import Temporal.Duration (Duration, durationFromProto)
import Temporal.Exception
import UnliftIO
import Prelude hiding (filter)


namespaceInfoDataFromProto
  :: V.Vector M.NamespaceInfo'DataEntry
  -> Map Text Text
namespaceInfoDataFromProto =
  V.foldr
    ( \(M.NamespaceInfo'DataEntry mKey mValue _) acc ->
        maybe acc (\key -> Map.insert key (fromMaybe "" mValue) acc) mKey
    )
    Map.empty


badBinariesFromProtoEntries
  :: V.Vector M.BadBinaries'BinariesEntry
  -> Map Text BadBinaryInfo
badBinariesFromProtoEntries =
  V.foldr
    ( \(M.BadBinaries'BinariesEntry mKey mValue _) acc ->
        maybe acc (\key -> Map.insert key (badBinaryInfoFromProto (fromMaybe mempty mValue)) acc) mKey
    )
    Map.empty


namespaceConfigAliasesFromProto
  :: V.Vector M.NamespaceConfig'CustomSearchAttributeAliasesEntry
  -> Map Text Text
namespaceConfigAliasesFromProto =
  V.foldr
    ( \(M.NamespaceConfig'CustomSearchAttributeAliasesEntry mKey mValue _) acc ->
        maybe acc (\key -> Map.insert key (fromMaybe "" mValue) acc) mKey
    )
    Map.empty


data NamespaceFilter = NamespaceFilter
  { includeDeleted :: !Bool
  }
  deriving stock (Show, Eq, Ord)


namespaceFilterToProto NamespaceFilter {..} =
  M.NamespaceFilter
    (Just includeDeleted)
    []


data NamespaceState
  = NamespaceStateUnspecified
  | NamespaceStateRegistered
  | NamespaceStateDeprecated
  | NamespaceStateDeleted
  | NamespaceStateUnrecognized
  deriving stock (Show, Eq, Ord)


namespaceStateFromProto :: E.NamespaceState -> NamespaceState
namespaceStateFromProto = \case
  E.NamespaceState'NamespaceStateUnspecified -> NamespaceStateUnspecified
  E.NamespaceState'NamespaceStateRegistered -> NamespaceStateRegistered
  E.NamespaceState'NamespaceStateDeprecated -> NamespaceStateDeprecated
  E.NamespaceState'NamespaceStateDeleted -> NamespaceStateDeleted
  _ -> NamespaceStateUnrecognized


data NamespaceInfo = NamespaceInfo
  { name :: !Text
  , state :: !NamespaceState
  , description :: !Text
  , ownerEmail :: !Text
  , id :: !Text
  , data' :: !(Map Text Text)
  -- ^ A key-value map for any customized purpose.
  , capabilities :: !(Maybe NamespaceCapabilities)
  , supportsSchedules :: !Bool
  }
  deriving stock (Show, Eq, Ord)


namespaceInfoFromProto (M.NamespaceInfo protoName protoState protoDescription protoOwnerEmail protoData protoId protoCapabilities protoSupportsSchedules _) =
  NamespaceInfo
    { name = fromMaybe "" protoName
    , state = namespaceStateFromProto (fromMaybe E.NamespaceState'NamespaceStateUnspecified protoState)
    , description = fromMaybe "" protoDescription
    , ownerEmail = fromMaybe "" protoOwnerEmail
    , id = fromMaybe "" protoId
    , data' = namespaceInfoDataFromProto protoData
    , capabilities = namespaceCapabilitiesFromProto <$> protoCapabilities
    , supportsSchedules = fromMaybe False protoSupportsSchedules
    }


data NamespaceCapabilities = NamespaceCapabilities
  { eagerWorkflowStart :: !Bool
  , syncUpdate :: !Bool
  , asyncUpdate :: !Bool
  }
  deriving stock (Show, Eq, Ord)


namespaceCapabilitiesFromProto (M.NamespaceInfo'Capabilities protoEagerWorkflowStart protoSyncUpdate protoAsyncUpdate _ _ _) =
  NamespaceCapabilities
    { eagerWorkflowStart = fromMaybe False protoEagerWorkflowStart
    , syncUpdate = fromMaybe False protoSyncUpdate
    , asyncUpdate = fromMaybe False protoAsyncUpdate
    }


data ArchivalState
  = ArchivalStateUnspecified
  | ArchivalStateDisabled
  | ArchivalStateEnabled
  | ArchivalStateUnrecognized
  deriving stock (Show, Eq, Ord)


archivalStateFromProto :: E.ArchivalState -> ArchivalState
archivalStateFromProto = \case
  E.ArchivalState'ArchivalStateUnspecified -> ArchivalStateUnspecified
  E.ArchivalState'ArchivalStateDisabled -> ArchivalStateDisabled
  E.ArchivalState'ArchivalStateEnabled -> ArchivalStateEnabled
  _ -> ArchivalStateUnrecognized


data BadBinaryInfo = BadBinaryInfo
  { reason :: !Text
  , operator :: !Text
  , createTime :: !SystemTime
  }
  deriving stock (Show, Eq, Ord)


badBinaryInfoFromProto (M.BadBinaryInfo protoReason protoOperator protoCreateTime _) =
  BadBinaryInfo
    { reason = fromMaybe "" protoReason
    , operator = fromMaybe "" protoOperator
    , createTime = timespecFromTimestamp (fromMaybe mempty protoCreateTime)
    }


data BadBinaries = BadBinaries
  { binaries :: !(Map Text BadBinaryInfo)
  }
  deriving stock (Show, Eq, Ord)


badBinariesFromProto (M.BadBinaries protoBinaries _) =
  BadBinaries
    { binaries = badBinariesFromProtoEntries protoBinaries
    }


data NamespaceConfig = NamespaceConfig
  { workflowExecutionRetentionTtl :: !(Maybe Duration)
  , badBinaries :: !(Maybe BadBinaries)
  , historyArchivalState :: !ArchivalState
  , historyArchivalUri :: !Text
  , visibilityArchivalState :: !ArchivalState
  , visibilityArchivalUri :: !Text
  , customSearchAttributeAliases :: !(Map Text Text)
  }
  deriving stock (Show, Eq, Ord)


namespaceConfigFromProto (M.NamespaceConfig protoWorkflowExecutionRetentionTtl protoBadBinaries protoHistoryArchivalState protoHistoryArchivalUri protoVisibilityArchivalState protoVisibilityArchivalUri protoCustomSearchAttributeAliases _) =
  NamespaceConfig
    { workflowExecutionRetentionTtl = durationFromProto <$> protoWorkflowExecutionRetentionTtl
    , badBinaries = badBinariesFromProto <$> protoBadBinaries
    , historyArchivalState = archivalStateFromProto (fromMaybe E.ArchivalState'ArchivalStateUnspecified protoHistoryArchivalState)
    , historyArchivalUri = fromMaybe "" protoHistoryArchivalUri
    , visibilityArchivalState = archivalStateFromProto (fromMaybe E.ArchivalState'ArchivalStateUnspecified protoVisibilityArchivalState)
    , visibilityArchivalUri = fromMaybe "" protoVisibilityArchivalUri
    , customSearchAttributeAliases = namespaceConfigAliasesFromProto protoCustomSearchAttributeAliases
    }


data ReplicationState
  = ReplicationStateUnspecified
  | ReplicationStateNormal
  | ReplicationStateHandover
  | ReplicationStateUnrecognized
  deriving stock (Show, Eq, Ord)


replicationStateFromProto :: E.ReplicationState -> ReplicationState
replicationStateFromProto = \case
  E.ReplicationState'ReplicationStateUnspecified -> ReplicationStateUnspecified
  E.ReplicationState'ReplicationStateNormal -> ReplicationStateNormal
  E.ReplicationState'ReplicationStateHandover -> ReplicationStateHandover
  _ -> ReplicationStateUnrecognized


data ClusterReplicationConfig = ClusterReplicationConfig
  { clusterName :: !Text
  }
  deriving stock (Show, Eq, Ord)


clusterReplicationConfigFromProto (R.ClusterReplicationConfig protoClusterName _) =
  ClusterReplicationConfig
    { clusterName = fromMaybe "" protoClusterName
    }


data NamespaceReplicationConfig = NamespaceReplicationConfig
  { activeClusterName :: !Text
  , clusters :: !(V.Vector ClusterReplicationConfig)
  , state :: !ReplicationState
  }
  deriving stock (Show, Eq, Ord)


namespaceReplicationConfigFromProto (R.NamespaceReplicationConfig protoActiveClusterName protoClusters protoState _) =
  NamespaceReplicationConfig
    { activeClusterName = fromMaybe "" protoActiveClusterName
    , clusters = clusterReplicationConfigFromProto <$> protoClusters
    , state = replicationStateFromProto (fromMaybe E.ReplicationState'ReplicationStateUnspecified protoState)
    }


data FailoverStatus = FailoverStatus
  { failoverTime :: !SystemTime
  , failoverVersion :: !Int64
  }
  deriving stock (Show, Eq, Ord)


failoverStatusFromProto (R.FailoverStatus protoFailoverTime protoFailoverVersion _) =
  FailoverStatus
    { failoverTime = timespecFromTimestamp (fromMaybe mempty protoFailoverTime)
    , failoverVersion = fromMaybe 0 protoFailoverVersion
    }


data DescribeNamespaceResponse = DescribeNamespaceResponse
  { namespaceInfo :: !NamespaceInfo
  , config :: !NamespaceConfig
  , replicationConfig :: !NamespaceReplicationConfig
  , failoverVersion :: !Int64
  , isGlobalNamespace :: !Bool
  , failoverHistory :: !(V.Vector FailoverStatus)
  }
  deriving stock (Show, Eq, Ord)


describeNamespaceResponseFromProto (RR.DescribeNamespaceResponse protoNamespaceInfo protoConfig protoReplicationConfig protoFailoverVersion protoIsGlobalNamespace protoFailoverHistory _) =
  DescribeNamespaceResponse
    { namespaceInfo = namespaceInfoFromProto (fromMaybe mempty protoNamespaceInfo)
    , config = namespaceConfigFromProto (fromMaybe mempty protoConfig)
    , replicationConfig = namespaceReplicationConfigFromProto (fromMaybe mempty protoReplicationConfig)
    , failoverVersion = fromMaybe 0 protoFailoverVersion
    , isGlobalNamespace = fromMaybe False protoIsGlobalNamespace
    , failoverHistory = failoverStatusFromProto <$> protoFailoverHistory
    }


data ListNamespacesRequest = ListNamespacesRequest
  { filter :: !(Maybe NamespaceFilter)
  , pageSize :: !Int32
  }
  deriving stock (Show, Eq, Ord)


listNamespacesRequestToProto ListNamespacesRequest {..} =
  RR.ListNamespacesRequest
    (Just pageSize)
    Nothing
    (namespaceFilterToProto <$> filter)
    []


-- | Returns the information and configuration for all namespaces.
listNamespaces :: (MonadIO m, HasWorkflowClient m) => ListNamespacesRequest -> ConduitT () DescribeNamespaceResponse m ()
listNamespaces req = do
  client <- askWorkflowClient
  let go reqMsg = do
        res <- liftIO $ Temporal.Core.Client.WorkflowService.listNamespaces client.clientCore reqMsg
        case res of
          Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
          Right (RR.ListNamespacesResponse namespaces nextPageToken _) -> do
            yieldMany $ describeNamespaceResponseFromProto <$> namespaces
            unless (BS.null (fromMaybe "" nextPageToken) || V.null namespaces) do
              let reqMsg' =
                    RR.ListNamespacesRequest
                      Nothing
                      nextPageToken
                      Nothing
                      []
              go reqMsg'
  go $ listNamespacesRequestToProto req

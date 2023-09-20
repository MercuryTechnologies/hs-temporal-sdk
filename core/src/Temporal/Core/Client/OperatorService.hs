{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}
module Temporal.Core.Client.OperatorService where
import Temporal.Core.Client
import Temporal.Internal.FFI
import Proto.Temporal.Api.Operatorservice.V1.RequestResponse
import Proto.Temporal.Api.Operatorservice.V1.Service

foreign import ccall "hs_add_or_update_remote_cluster" hs_add_or_update_remote_cluster :: PrimRpcCall
addOrUpdateRemoteCluster :: Client -> AddOrUpdateRemoteClusterRequest -> IO (Either RpcError AddOrUpdateRemoteClusterResponse)
addOrUpdateRemoteCluster = call @OperatorService @"addOrUpdateRemoteCluster" hs_add_or_update_remote_cluster

foreign import ccall "hs_add_search_attributes" hs_add_search_attributes :: PrimRpcCall
addSearchAttributes :: Client -> AddSearchAttributesRequest -> IO (Either RpcError AddSearchAttributesResponse)
addSearchAttributes = call @OperatorService @"addSearchAttributes" hs_add_search_attributes

foreign import ccall "hs_delete_namespace" hs_delete_namespace :: PrimRpcCall
deleteNamespace :: Client -> DeleteNamespaceRequest -> IO (Either RpcError DeleteNamespaceResponse)
deleteNamespace = call @OperatorService @"deleteNamespace" hs_delete_namespace

foreign import ccall "hs_list_clusters" hs_list_clusters :: PrimRpcCall
listClusters :: Client -> ListClustersRequest -> IO (Either RpcError ListClustersResponse)
listClusters = call @OperatorService @"listClusters" hs_list_clusters

foreign import ccall "hs_list_search_attributes" hs_list_search_attributes :: PrimRpcCall
listSearchAttributes :: Client -> ListSearchAttributesRequest -> IO (Either RpcError ListSearchAttributesResponse)
listSearchAttributes = call @OperatorService @"listSearchAttributes" hs_list_search_attributes

foreign import ccall "hs_remove_remote_cluster" hs_remove_remote_cluster :: PrimRpcCall
removeRemoteCluster :: Client -> RemoveRemoteClusterRequest -> IO (Either RpcError RemoveRemoteClusterResponse)
removeRemoteCluster = call @OperatorService @"removeRemoteCluster" hs_remove_remote_cluster

foreign import ccall "hs_remove_search_attributes" hs_remove_search_attributes :: PrimRpcCall
removeSearchAttributes :: Client -> RemoveSearchAttributesRequest -> IO (Either RpcError RemoveSearchAttributesResponse)
removeSearchAttributes = call @OperatorService @"removeSearchAttributes" hs_remove_search_attributes
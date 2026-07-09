{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module Temporal.Core.Client.OperatorService where

import Proto.Temporal.Api.Operatorservice.V1.RequestResponse
import Temporal.Core.Client


foreign import ccall "hs_add_or_update_remote_cluster" hs_add_or_update_remote_cluster :: PrimRpcCall


addOrUpdateRemoteCluster :: Client -> AddOrUpdateRemoteClusterRequest -> IO (Either RpcError AddOrUpdateRemoteClusterResponse)
addOrUpdateRemoteCluster = call hs_add_or_update_remote_cluster


foreign import ccall "hs_add_search_attributes" hs_add_search_attributes :: PrimRpcCall


addSearchAttributes :: Client -> AddSearchAttributesRequest -> IO (Either RpcError AddSearchAttributesResponse)
addSearchAttributes = call hs_add_search_attributes


foreign import ccall "hs_delete_namespace" hs_delete_namespace :: PrimRpcCall


deleteNamespace :: Client -> DeleteNamespaceRequest -> IO (Either RpcError DeleteNamespaceResponse)
deleteNamespace = call hs_delete_namespace


foreign import ccall "hs_list_clusters" hs_list_clusters :: PrimRpcCall


listClusters :: Client -> ListClustersRequest -> IO (Either RpcError ListClustersResponse)
listClusters = call hs_list_clusters


foreign import ccall "hs_list_search_attributes" hs_list_search_attributes :: PrimRpcCall


listSearchAttributes :: Client -> ListSearchAttributesRequest -> IO (Either RpcError ListSearchAttributesResponse)
listSearchAttributes = call hs_list_search_attributes


foreign import ccall "hs_remove_remote_cluster" hs_remove_remote_cluster :: PrimRpcCall


removeRemoteCluster :: Client -> RemoveRemoteClusterRequest -> IO (Either RpcError RemoveRemoteClusterResponse)
removeRemoteCluster = call hs_remove_remote_cluster


foreign import ccall "hs_remove_search_attributes" hs_remove_search_attributes :: PrimRpcCall


removeSearchAttributes :: Client -> RemoveSearchAttributesRequest -> IO (Either RpcError RemoveSearchAttributesResponse)
removeSearchAttributes = call hs_remove_search_attributes


foreign import ccall "hs_create_nexus_endpoint" hs_create_nexus_endpoint :: PrimRpcCall


createNexusEndpoint :: Client -> CreateNexusEndpointRequest -> IO (Either RpcError CreateNexusEndpointResponse)
createNexusEndpoint = call hs_create_nexus_endpoint


foreign import ccall "hs_delete_nexus_endpoint" hs_delete_nexus_endpoint :: PrimRpcCall


deleteNexusEndpoint :: Client -> DeleteNexusEndpointRequest -> IO (Either RpcError DeleteNexusEndpointResponse)
deleteNexusEndpoint = call hs_delete_nexus_endpoint


foreign import ccall "hs_get_nexus_endpoint" hs_get_nexus_endpoint :: PrimRpcCall


getNexusEndpoint :: Client -> GetNexusEndpointRequest -> IO (Either RpcError GetNexusEndpointResponse)
getNexusEndpoint = call hs_get_nexus_endpoint


foreign import ccall "hs_list_nexus_endpoints" hs_list_nexus_endpoints :: PrimRpcCall


listNexusEndpoints :: Client -> ListNexusEndpointsRequest -> IO (Either RpcError ListNexusEndpointsResponse)
listNexusEndpoints = call hs_list_nexus_endpoints

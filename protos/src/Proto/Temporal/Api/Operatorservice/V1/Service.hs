{- This file was auto-generated from temporal/api/operatorservice/v1/service.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Operatorservice.V1.Service (
        OperatorService(..)
    ) where
import qualified Data.ProtoLens.Runtime.Control.DeepSeq as Control.DeepSeq
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Prism as Data.ProtoLens.Prism
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
import qualified Proto.Google.Api.Annotations
import qualified Proto.Temporal.Api.Operatorservice.V1.RequestResponse
data OperatorService = OperatorService {}
instance Data.ProtoLens.Service.Types.Service OperatorService where
  type ServiceName OperatorService = "OperatorService"
  type ServicePackage OperatorService = "temporal.api.operatorservice.v1"
  type ServiceMethods OperatorService = '["addOrUpdateRemoteCluster",
                                          "addSearchAttributes",
                                          "deleteNamespace",
                                          "listClusters",
                                          "listSearchAttributes",
                                          "removeRemoteCluster",
                                          "removeSearchAttributes"]
  packedServiceDescriptor _
    = "\n\
      \\SIOperatorService\DC2\146\SOH\n\
      \\DC3AddSearchAttributes\DC2;.temporal.api.operatorservice.v1.AddSearchAttributesRequest\SUB<.temporal.api.operatorservice.v1.AddSearchAttributesResponse\"\NUL\DC2\155\SOH\n\
      \\SYNRemoveSearchAttributes\DC2>.temporal.api.operatorservice.v1.RemoveSearchAttributesRequest\SUB?.temporal.api.operatorservice.v1.RemoveSearchAttributesResponse\"\NUL\DC2\205\SOH\n\
      \\DC4ListSearchAttributes\DC2<.temporal.api.operatorservice.v1.ListSearchAttributesRequest\SUB=.temporal.api.operatorservice.v1.ListSearchAttributesResponse\"8\130\211\228\147\STX2\DC20/api/v1/namespaces/{namespace}/search-attributes\DC2\134\SOH\n\
      \\SIDeleteNamespace\DC27.temporal.api.operatorservice.v1.DeleteNamespaceRequest\SUB8.temporal.api.operatorservice.v1.DeleteNamespaceResponse\"\NUL\DC2\161\SOH\n\
      \\CANAddOrUpdateRemoteCluster\DC2@.temporal.api.operatorservice.v1.AddOrUpdateRemoteClusterRequest\SUBA.temporal.api.operatorservice.v1.AddOrUpdateRemoteClusterResponse\"\NUL\DC2\146\SOH\n\
      \\DC3RemoveRemoteCluster\DC2;.temporal.api.operatorservice.v1.RemoveRemoteClusterRequest\SUB<.temporal.api.operatorservice.v1.RemoveRemoteClusterResponse\"\NUL\DC2}\n\
      \\fListClusters\DC24.temporal.api.operatorservice.v1.ListClustersRequest\SUB5.temporal.api.operatorservice.v1.ListClustersResponse\"\NUL"
instance Data.ProtoLens.Service.Types.HasMethodImpl OperatorService "addSearchAttributes" where
  type MethodName OperatorService "addSearchAttributes" = "AddSearchAttributes"
  type MethodInput OperatorService "addSearchAttributes" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.AddSearchAttributesRequest
  type MethodOutput OperatorService "addSearchAttributes" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.AddSearchAttributesResponse
  type MethodStreamingType OperatorService "addSearchAttributes" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl OperatorService "removeSearchAttributes" where
  type MethodName OperatorService "removeSearchAttributes" = "RemoveSearchAttributes"
  type MethodInput OperatorService "removeSearchAttributes" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.RemoveSearchAttributesRequest
  type MethodOutput OperatorService "removeSearchAttributes" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.RemoveSearchAttributesResponse
  type MethodStreamingType OperatorService "removeSearchAttributes" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl OperatorService "listSearchAttributes" where
  type MethodName OperatorService "listSearchAttributes" = "ListSearchAttributes"
  type MethodInput OperatorService "listSearchAttributes" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.ListSearchAttributesRequest
  type MethodOutput OperatorService "listSearchAttributes" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.ListSearchAttributesResponse
  type MethodStreamingType OperatorService "listSearchAttributes" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl OperatorService "deleteNamespace" where
  type MethodName OperatorService "deleteNamespace" = "DeleteNamespace"
  type MethodInput OperatorService "deleteNamespace" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.DeleteNamespaceRequest
  type MethodOutput OperatorService "deleteNamespace" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.DeleteNamespaceResponse
  type MethodStreamingType OperatorService "deleteNamespace" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl OperatorService "addOrUpdateRemoteCluster" where
  type MethodName OperatorService "addOrUpdateRemoteCluster" = "AddOrUpdateRemoteCluster"
  type MethodInput OperatorService "addOrUpdateRemoteCluster" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.AddOrUpdateRemoteClusterRequest
  type MethodOutput OperatorService "addOrUpdateRemoteCluster" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.AddOrUpdateRemoteClusterResponse
  type MethodStreamingType OperatorService "addOrUpdateRemoteCluster" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl OperatorService "removeRemoteCluster" where
  type MethodName OperatorService "removeRemoteCluster" = "RemoveRemoteCluster"
  type MethodInput OperatorService "removeRemoteCluster" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.RemoveRemoteClusterRequest
  type MethodOutput OperatorService "removeRemoteCluster" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.RemoveRemoteClusterResponse
  type MethodStreamingType OperatorService "removeRemoteCluster" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl OperatorService "listClusters" where
  type MethodName OperatorService "listClusters" = "ListClusters"
  type MethodInput OperatorService "listClusters" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.ListClustersRequest
  type MethodOutput OperatorService "listClusters" = Proto.Temporal.Api.Operatorservice.V1.RequestResponse.ListClustersResponse
  type MethodStreamingType OperatorService "listClusters" = 'Data.ProtoLens.Service.Types.NonStreaming
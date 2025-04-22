{- This file was auto-generated from temporal/api/common/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Common.V1.Message_Fields where
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
import qualified Proto.Google.Protobuf.Duration
import qualified Proto.Google.Protobuf.Empty
import qualified Proto.Temporal.Api.Enums.V1.Common
import qualified Proto.Temporal.Api.Enums.V1.EventType
import qualified Proto.Temporal.Api.Enums.V1.Reset
backoffCoefficient ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "backoffCoefficient" a) =>
  Lens.Family2.LensLike' f s a
backoffCoefficient
  = Data.ProtoLens.Field.field @"backoffCoefficient"
batchJob ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "batchJob" a) =>
  Lens.Family2.LensLike' f s a
batchJob = Data.ProtoLens.Field.field @"batchJob"
buildId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "buildId" a) =>
  Lens.Family2.LensLike' f s a
buildId = Data.ProtoLens.Field.field @"buildId"
currentRunOnly ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "currentRunOnly" a) =>
  Lens.Family2.LensLike' f s a
currentRunOnly = Data.ProtoLens.Field.field @"currentRunOnly"
data' ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "data'" a) =>
  Lens.Family2.LensLike' f s a
data' = Data.ProtoLens.Field.field @"data'"
deploymentSeriesName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "deploymentSeriesName" a) =>
  Lens.Family2.LensLike' f s a
deploymentSeriesName
  = Data.ProtoLens.Field.field @"deploymentSeriesName"
encodingType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "encodingType" a) =>
  Lens.Family2.LensLike' f s a
encodingType = Data.ProtoLens.Field.field @"encodingType"
eventId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "eventId" a) =>
  Lens.Family2.LensLike' f s a
eventId = Data.ProtoLens.Field.field @"eventId"
eventRef ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "eventRef" a) =>
  Lens.Family2.LensLike' f s a
eventRef = Data.ProtoLens.Field.field @"eventRef"
eventType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "eventType" a) =>
  Lens.Family2.LensLike' f s a
eventType = Data.ProtoLens.Field.field @"eventType"
fields ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "fields" a) =>
  Lens.Family2.LensLike' f s a
fields = Data.ProtoLens.Field.field @"fields"
firstWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "firstWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
firstWorkflowTask = Data.ProtoLens.Field.field @"firstWorkflowTask"
header ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "header" a) =>
  Lens.Family2.LensLike' f s a
header = Data.ProtoLens.Field.field @"header"
indexedFields ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "indexedFields" a) =>
  Lens.Family2.LensLike' f s a
indexedFields = Data.ProtoLens.Field.field @"indexedFields"
initialInterval ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "initialInterval" a) =>
  Lens.Family2.LensLike' f s a
initialInterval = Data.ProtoLens.Field.field @"initialInterval"
internal ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "internal" a) =>
  Lens.Family2.LensLike' f s a
internal = Data.ProtoLens.Field.field @"internal"
jobId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "jobId" a) =>
  Lens.Family2.LensLike' f s a
jobId = Data.ProtoLens.Field.field @"jobId"
key ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "key" a) =>
  Lens.Family2.LensLike' f s a
key = Data.ProtoLens.Field.field @"key"
lastWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
lastWorkflowTask = Data.ProtoLens.Field.field @"lastWorkflowTask"
maximumAttempts ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maximumAttempts" a) =>
  Lens.Family2.LensLike' f s a
maximumAttempts = Data.ProtoLens.Field.field @"maximumAttempts"
maximumInterval ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maximumInterval" a) =>
  Lens.Family2.LensLike' f s a
maximumInterval = Data.ProtoLens.Field.field @"maximumInterval"
maybe'batchJob ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'batchJob" a) =>
  Lens.Family2.LensLike' f s a
maybe'batchJob = Data.ProtoLens.Field.field @"maybe'batchJob"
maybe'buildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'buildId" a) =>
  Lens.Family2.LensLike' f s a
maybe'buildId = Data.ProtoLens.Field.field @"maybe'buildId"
maybe'eventRef ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'eventRef" a) =>
  Lens.Family2.LensLike' f s a
maybe'eventRef = Data.ProtoLens.Field.field @"maybe'eventRef"
maybe'firstWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'firstWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
maybe'firstWorkflowTask
  = Data.ProtoLens.Field.field @"maybe'firstWorkflowTask"
maybe'initialInterval ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'initialInterval" a) =>
  Lens.Family2.LensLike' f s a
maybe'initialInterval
  = Data.ProtoLens.Field.field @"maybe'initialInterval"
maybe'internal ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'internal" a) =>
  Lens.Family2.LensLike' f s a
maybe'internal = Data.ProtoLens.Field.field @"maybe'internal"
maybe'lastWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastWorkflowTask
  = Data.ProtoLens.Field.field @"maybe'lastWorkflowTask"
maybe'maximumInterval ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'maximumInterval" a) =>
  Lens.Family2.LensLike' f s a
maybe'maximumInterval
  = Data.ProtoLens.Field.field @"maybe'maximumInterval"
maybe'nexus ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'nexus" a) =>
  Lens.Family2.LensLike' f s a
maybe'nexus = Data.ProtoLens.Field.field @"maybe'nexus"
maybe'reference ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'reference" a) =>
  Lens.Family2.LensLike' f s a
maybe'reference = Data.ProtoLens.Field.field @"maybe'reference"
maybe'target ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'target" a) =>
  Lens.Family2.LensLike' f s a
maybe'target = Data.ProtoLens.Field.field @"maybe'target"
maybe'value ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'value" a) =>
  Lens.Family2.LensLike' f s a
maybe'value = Data.ProtoLens.Field.field @"maybe'value"
maybe'variant ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'variant" a) =>
  Lens.Family2.LensLike' f s a
maybe'variant = Data.ProtoLens.Field.field @"maybe'variant"
maybe'workflowEvent ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowEvent" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowEvent
  = Data.ProtoLens.Field.field @"maybe'workflowEvent"
maybe'workflowTaskId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowTaskId" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowTaskId
  = Data.ProtoLens.Field.field @"maybe'workflowTaskId"
metadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "metadata" a) =>
  Lens.Family2.LensLike' f s a
metadata = Data.ProtoLens.Field.field @"metadata"
name ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "name" a) =>
  Lens.Family2.LensLike' f s a
name = Data.ProtoLens.Field.field @"name"
namespace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "namespace" a) =>
  Lens.Family2.LensLike' f s a
namespace = Data.ProtoLens.Field.field @"namespace"
nexus ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "nexus" a) =>
  Lens.Family2.LensLike' f s a
nexus = Data.ProtoLens.Field.field @"nexus"
nonRetryableErrorTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "nonRetryableErrorTypes" a) =>
  Lens.Family2.LensLike' f s a
nonRetryableErrorTypes
  = Data.ProtoLens.Field.field @"nonRetryableErrorTypes"
nonfirstLocalActivityExecutionAttempts ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "nonfirstLocalActivityExecutionAttempts" a) =>
  Lens.Family2.LensLike' f s a
nonfirstLocalActivityExecutionAttempts
  = Data.ProtoLens.Field.field
      @"nonfirstLocalActivityExecutionAttempts"
payloads ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "payloads" a) =>
  Lens.Family2.LensLike' f s a
payloads = Data.ProtoLens.Field.field @"payloads"
priorityKey ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "priorityKey" a) =>
  Lens.Family2.LensLike' f s a
priorityKey = Data.ProtoLens.Field.field @"priorityKey"
resetReapplyExcludeTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resetReapplyExcludeTypes" a) =>
  Lens.Family2.LensLike' f s a
resetReapplyExcludeTypes
  = Data.ProtoLens.Field.field @"resetReapplyExcludeTypes"
resetReapplyType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resetReapplyType" a) =>
  Lens.Family2.LensLike' f s a
resetReapplyType = Data.ProtoLens.Field.field @"resetReapplyType"
runId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "runId" a) =>
  Lens.Family2.LensLike' f s a
runId = Data.ProtoLens.Field.field @"runId"
url ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "url" a) =>
  Lens.Family2.LensLike' f s a
url = Data.ProtoLens.Field.field @"url"
useVersioning ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "useVersioning" a) =>
  Lens.Family2.LensLike' f s a
useVersioning = Data.ProtoLens.Field.field @"useVersioning"
value ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "value" a) =>
  Lens.Family2.LensLike' f s a
value = Data.ProtoLens.Field.field @"value"
vec'nonRetryableErrorTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'nonRetryableErrorTypes" a) =>
  Lens.Family2.LensLike' f s a
vec'nonRetryableErrorTypes
  = Data.ProtoLens.Field.field @"vec'nonRetryableErrorTypes"
vec'payloads ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'payloads" a) =>
  Lens.Family2.LensLike' f s a
vec'payloads = Data.ProtoLens.Field.field @"vec'payloads"
vec'resetReapplyExcludeTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'resetReapplyExcludeTypes" a) =>
  Lens.Family2.LensLike' f s a
vec'resetReapplyExcludeTypes
  = Data.ProtoLens.Field.field @"vec'resetReapplyExcludeTypes"
workflowEvent ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowEvent" a) =>
  Lens.Family2.LensLike' f s a
workflowEvent = Data.ProtoLens.Field.field @"workflowEvent"
workflowId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowId" a) =>
  Lens.Family2.LensLike' f s a
workflowId = Data.ProtoLens.Field.field @"workflowId"
workflowTaskId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowTaskId" a) =>
  Lens.Family2.LensLike' f s a
workflowTaskId = Data.ProtoLens.Field.field @"workflowTaskId"
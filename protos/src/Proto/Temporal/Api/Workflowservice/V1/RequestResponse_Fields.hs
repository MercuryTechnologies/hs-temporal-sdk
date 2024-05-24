{- This file was auto-generated from temporal/api/workflowservice/v1/request_response.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields where
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Batch.V1.Message
import qualified Proto.Temporal.Api.Command.V1.Message
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.BatchOperation
import qualified Proto.Temporal.Api.Enums.V1.Common
import qualified Proto.Temporal.Api.Enums.V1.FailedCause
import qualified Proto.Temporal.Api.Enums.V1.Namespace
import qualified Proto.Temporal.Api.Enums.V1.Query
import qualified Proto.Temporal.Api.Enums.V1.Reset
import qualified Proto.Temporal.Api.Enums.V1.TaskQueue
import qualified Proto.Temporal.Api.Enums.V1.Update
import qualified Proto.Temporal.Api.Enums.V1.Workflow
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Api.Filter.V1.Message
import qualified Proto.Temporal.Api.History.V1.Message
import qualified Proto.Temporal.Api.Namespace.V1.Message
import qualified Proto.Temporal.Api.Nexus.V1.Message
import qualified Proto.Temporal.Api.Protocol.V1.Message
import qualified Proto.Temporal.Api.Query.V1.Message
import qualified Proto.Temporal.Api.Replication.V1.Message
import qualified Proto.Temporal.Api.Schedule.V1.Message
import qualified Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata
import qualified Proto.Temporal.Api.Taskqueue.V1.Message
import qualified Proto.Temporal.Api.Update.V1.Message
import qualified Proto.Temporal.Api.Version.V1.Message
import qualified Proto.Temporal.Api.Workflow.V1.Message
activeClusterName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activeClusterName" a) =>
  Lens.Family2.LensLike' f s a
activeClusterName = Data.ProtoLens.Field.field @"activeClusterName"
activityFailureIncludeHeartbeat ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityFailureIncludeHeartbeat" a) =>
  Lens.Family2.LensLike' f s a
activityFailureIncludeHeartbeat
  = Data.ProtoLens.Field.field @"activityFailureIncludeHeartbeat"
activityId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityId" a) =>
  Lens.Family2.LensLike' f s a
activityId = Data.ProtoLens.Field.field @"activityId"
activityTaskQueuePartitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityTaskQueuePartitions" a) =>
  Lens.Family2.LensLike' f s a
activityTaskQueuePartitions
  = Data.ProtoLens.Field.field @"activityTaskQueuePartitions"
activityTasks ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityTasks" a) =>
  Lens.Family2.LensLike' f s a
activityTasks = Data.ProtoLens.Field.field @"activityTasks"
activityType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityType" a) =>
  Lens.Family2.LensLike' f s a
activityType = Data.ProtoLens.Field.field @"activityType"
addCompatibleRedirectRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "addCompatibleRedirectRule" a) =>
  Lens.Family2.LensLike' f s a
addCompatibleRedirectRule
  = Data.ProtoLens.Field.field @"addCompatibleRedirectRule"
addNewBuildIdInNewDefaultSet ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "addNewBuildIdInNewDefaultSet" a) =>
  Lens.Family2.LensLike' f s a
addNewBuildIdInNewDefaultSet
  = Data.ProtoLens.Field.field @"addNewBuildIdInNewDefaultSet"
addNewCompatibleBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "addNewCompatibleBuildId" a) =>
  Lens.Family2.LensLike' f s a
addNewCompatibleBuildId
  = Data.ProtoLens.Field.field @"addNewCompatibleBuildId"
apiMode ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "apiMode" a) =>
  Lens.Family2.LensLike' f s a
apiMode = Data.ProtoLens.Field.field @"apiMode"
archived ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "archived" a) =>
  Lens.Family2.LensLike' f s a
archived = Data.ProtoLens.Field.field @"archived"
assignmentRules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "assignmentRules" a) =>
  Lens.Family2.LensLike' f s a
assignmentRules = Data.ProtoLens.Field.field @"assignmentRules"
attempt ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "attempt" a) =>
  Lens.Family2.LensLike' f s a
attempt = Data.ProtoLens.Field.field @"attempt"
backlogCountHint ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "backlogCountHint" a) =>
  Lens.Family2.LensLike' f s a
backlogCountHint = Data.ProtoLens.Field.field @"backlogCountHint"
binaryChecksum ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "binaryChecksum" a) =>
  Lens.Family2.LensLike' f s a
binaryChecksum = Data.ProtoLens.Field.field @"binaryChecksum"
buildIdBasedVersioning ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "buildIdBasedVersioning" a) =>
  Lens.Family2.LensLike' f s a
buildIdBasedVersioning
  = Data.ProtoLens.Field.field @"buildIdBasedVersioning"
buildIdReachability ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "buildIdReachability" a) =>
  Lens.Family2.LensLike' f s a
buildIdReachability
  = Data.ProtoLens.Field.field @"buildIdReachability"
buildIds ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "buildIds" a) =>
  Lens.Family2.LensLike' f s a
buildIds = Data.ProtoLens.Field.field @"buildIds"
callbacks ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "callbacks" a) =>
  Lens.Family2.LensLike' f s a
callbacks = Data.ProtoLens.Field.field @"callbacks"
cancelRequested ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cancelRequested" a) =>
  Lens.Family2.LensLike' f s a
cancelRequested = Data.ProtoLens.Field.field @"cancelRequested"
cancellationOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cancellationOperation" a) =>
  Lens.Family2.LensLike' f s a
cancellationOperation
  = Data.ProtoLens.Field.field @"cancellationOperation"
capabilities ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "capabilities" a) =>
  Lens.Family2.LensLike' f s a
capabilities = Data.ProtoLens.Field.field @"capabilities"
cause ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "cause" a) =>
  Lens.Family2.LensLike' f s a
cause = Data.ProtoLens.Field.field @"cause"
closeTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "closeTime" a) =>
  Lens.Family2.LensLike' f s a
closeTime = Data.ProtoLens.Field.field @"closeTime"
clusterId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "clusterId" a) =>
  Lens.Family2.LensLike' f s a
clusterId = Data.ProtoLens.Field.field @"clusterId"
clusterName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "clusterName" a) =>
  Lens.Family2.LensLike' f s a
clusterName = Data.ProtoLens.Field.field @"clusterName"
clusters ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "clusters" a) =>
  Lens.Family2.LensLike' f s a
clusters = Data.ProtoLens.Field.field @"clusters"
commands ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "commands" a) =>
  Lens.Family2.LensLike' f s a
commands = Data.ProtoLens.Field.field @"commands"
commitBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "commitBuildId" a) =>
  Lens.Family2.LensLike' f s a
commitBuildId = Data.ProtoLens.Field.field @"commitBuildId"
compatibleRedirectRules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "compatibleRedirectRules" a) =>
  Lens.Family2.LensLike' f s a
compatibleRedirectRules
  = Data.ProtoLens.Field.field @"compatibleRedirectRules"
completeOperationCount ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "completeOperationCount" a) =>
  Lens.Family2.LensLike' f s a
completeOperationCount
  = Data.ProtoLens.Field.field @"completeOperationCount"
completedType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "completedType" a) =>
  Lens.Family2.LensLike' f s a
completedType = Data.ProtoLens.Field.field @"completedType"
completionCallbacks ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "completionCallbacks" a) =>
  Lens.Family2.LensLike' f s a
completionCallbacks
  = Data.ProtoLens.Field.field @"completionCallbacks"
config ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "config" a) =>
  Lens.Family2.LensLike' f s a
config = Data.ProtoLens.Field.field @"config"
conflictToken ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "conflictToken" a) =>
  Lens.Family2.LensLike' f s a
conflictToken = Data.ProtoLens.Field.field @"conflictToken"
continuedFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "continuedFailure" a) =>
  Lens.Family2.LensLike' f s a
continuedFailure = Data.ProtoLens.Field.field @"continuedFailure"
control ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "control" a) =>
  Lens.Family2.LensLike' f s a
control = Data.ProtoLens.Field.field @"control"
count ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "count" a) =>
  Lens.Family2.LensLike' f s a
count = Data.ProtoLens.Field.field @"count"
countGroupByExecutionStatus ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "countGroupByExecutionStatus" a) =>
  Lens.Family2.LensLike' f s a
countGroupByExecutionStatus
  = Data.ProtoLens.Field.field @"countGroupByExecutionStatus"
cronSchedule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cronSchedule" a) =>
  Lens.Family2.LensLike' f s a
cronSchedule = Data.ProtoLens.Field.field @"cronSchedule"
currentAttemptScheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "currentAttemptScheduledTime" a) =>
  Lens.Family2.LensLike' f s a
currentAttemptScheduledTime
  = Data.ProtoLens.Field.field @"currentAttemptScheduledTime"
data' ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "data'" a) =>
  Lens.Family2.LensLike' f s a
data' = Data.ProtoLens.Field.field @"data'"
deleteAssignmentRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "deleteAssignmentRule" a) =>
  Lens.Family2.LensLike' f s a
deleteAssignmentRule
  = Data.ProtoLens.Field.field @"deleteAssignmentRule"
deleteBadBinary ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "deleteBadBinary" a) =>
  Lens.Family2.LensLike' f s a
deleteBadBinary = Data.ProtoLens.Field.field @"deleteBadBinary"
deleteCompatibleRedirectRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "deleteCompatibleRedirectRule" a) =>
  Lens.Family2.LensLike' f s a
deleteCompatibleRedirectRule
  = Data.ProtoLens.Field.field @"deleteCompatibleRedirectRule"
deletionOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "deletionOperation" a) =>
  Lens.Family2.LensLike' f s a
deletionOperation = Data.ProtoLens.Field.field @"deletionOperation"
description ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "description" a) =>
  Lens.Family2.LensLike' f s a
description = Data.ProtoLens.Field.field @"description"
details ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "details" a) =>
  Lens.Family2.LensLike' f s a
details = Data.ProtoLens.Field.field @"details"
eagerWorkflowStart ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "eagerWorkflowStart" a) =>
  Lens.Family2.LensLike' f s a
eagerWorkflowStart
  = Data.ProtoLens.Field.field @"eagerWorkflowStart"
eagerWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "eagerWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
eagerWorkflowTask = Data.ProtoLens.Field.field @"eagerWorkflowTask"
encodedFailureAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "encodedFailureAttributes" a) =>
  Lens.Family2.LensLike' f s a
encodedFailureAttributes
  = Data.ProtoLens.Field.field @"encodedFailureAttributes"
endTime ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "endTime" a) =>
  Lens.Family2.LensLike' f s a
endTime = Data.ProtoLens.Field.field @"endTime"
error ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "error" a) =>
  Lens.Family2.LensLike' f s a
error = Data.ProtoLens.Field.field @"error"
errorMessage ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "errorMessage" a) =>
  Lens.Family2.LensLike' f s a
errorMessage = Data.ProtoLens.Field.field @"errorMessage"
execution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "execution" a) =>
  Lens.Family2.LensLike' f s a
execution = Data.ProtoLens.Field.field @"execution"
executionConfig ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "executionConfig" a) =>
  Lens.Family2.LensLike' f s a
executionConfig = Data.ProtoLens.Field.field @"executionConfig"
executionFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "executionFilter" a) =>
  Lens.Family2.LensLike' f s a
executionFilter = Data.ProtoLens.Field.field @"executionFilter"
executions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "executions" a) =>
  Lens.Family2.LensLike' f s a
executions = Data.ProtoLens.Field.field @"executions"
existingCompatibleBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "existingCompatibleBuildId" a) =>
  Lens.Family2.LensLike' f s a
existingCompatibleBuildId
  = Data.ProtoLens.Field.field @"existingCompatibleBuildId"
failoverHistory ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "failoverHistory" a) =>
  Lens.Family2.LensLike' f s a
failoverHistory = Data.ProtoLens.Field.field @"failoverHistory"
failoverVersion ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "failoverVersion" a) =>
  Lens.Family2.LensLike' f s a
failoverVersion = Data.ProtoLens.Field.field @"failoverVersion"
failure ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "failure" a) =>
  Lens.Family2.LensLike' f s a
failure = Data.ProtoLens.Field.field @"failure"
failureOperationCount ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "failureOperationCount" a) =>
  Lens.Family2.LensLike' f s a
failureOperationCount
  = Data.ProtoLens.Field.field @"failureOperationCount"
failures ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "failures" a) =>
  Lens.Family2.LensLike' f s a
failures = Data.ProtoLens.Field.field @"failures"
firstExecutionRunId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "firstExecutionRunId" a) =>
  Lens.Family2.LensLike' f s a
firstExecutionRunId
  = Data.ProtoLens.Field.field @"firstExecutionRunId"
force ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "force" a) =>
  Lens.Family2.LensLike' f s a
force = Data.ProtoLens.Field.field @"force"
forceCreateNewWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "forceCreateNewWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
forceCreateNewWorkflowTask
  = Data.ProtoLens.Field.field @"forceCreateNewWorkflowTask"
groupValues ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "groupValues" a) =>
  Lens.Family2.LensLike' f s a
groupValues = Data.ProtoLens.Field.field @"groupValues"
groups ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "groups" a) =>
  Lens.Family2.LensLike' f s a
groups = Data.ProtoLens.Field.field @"groups"
header ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "header" a) =>
  Lens.Family2.LensLike' f s a
header = Data.ProtoLens.Field.field @"header"
heartbeatDetails ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "heartbeatDetails" a) =>
  Lens.Family2.LensLike' f s a
heartbeatDetails = Data.ProtoLens.Field.field @"heartbeatDetails"
heartbeatTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "heartbeatTimeout" a) =>
  Lens.Family2.LensLike' f s a
heartbeatTimeout = Data.ProtoLens.Field.field @"heartbeatTimeout"
history ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "history" a) =>
  Lens.Family2.LensLike' f s a
history = Data.ProtoLens.Field.field @"history"
historyArchivalState ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "historyArchivalState" a) =>
  Lens.Family2.LensLike' f s a
historyArchivalState
  = Data.ProtoLens.Field.field @"historyArchivalState"
historyArchivalUri ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "historyArchivalUri" a) =>
  Lens.Family2.LensLike' f s a
historyArchivalUri
  = Data.ProtoLens.Field.field @"historyArchivalUri"
historyEventFilterType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "historyEventFilterType" a) =>
  Lens.Family2.LensLike' f s a
historyEventFilterType
  = Data.ProtoLens.Field.field @"historyEventFilterType"
historyShardCount ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "historyShardCount" a) =>
  Lens.Family2.LensLike' f s a
historyShardCount = Data.ProtoLens.Field.field @"historyShardCount"
id ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "id" a) =>
  Lens.Family2.LensLike' f s a
id = Data.ProtoLens.Field.field @"id"
identity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "identity" a) =>
  Lens.Family2.LensLike' f s a
identity = Data.ProtoLens.Field.field @"identity"
includeTaskQueueStatus ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "includeTaskQueueStatus" a) =>
  Lens.Family2.LensLike' f s a
includeTaskQueueStatus
  = Data.ProtoLens.Field.field @"includeTaskQueueStatus"
info ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "info" a) =>
  Lens.Family2.LensLike' f s a
info = Data.ProtoLens.Field.field @"info"
initialPatch ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "initialPatch" a) =>
  Lens.Family2.LensLike' f s a
initialPatch = Data.ProtoLens.Field.field @"initialPatch"
input ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "input" a) =>
  Lens.Family2.LensLike' f s a
input = Data.ProtoLens.Field.field @"input"
insertAssignmentRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "insertAssignmentRule" a) =>
  Lens.Family2.LensLike' f s a
insertAssignmentRule
  = Data.ProtoLens.Field.field @"insertAssignmentRule"
internalErrorDifferentiation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "internalErrorDifferentiation" a) =>
  Lens.Family2.LensLike' f s a
internalErrorDifferentiation
  = Data.ProtoLens.Field.field @"internalErrorDifferentiation"
isGlobalNamespace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isGlobalNamespace" a) =>
  Lens.Family2.LensLike' f s a
isGlobalNamespace = Data.ProtoLens.Field.field @"isGlobalNamespace"
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
keys ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "keys" a) =>
  Lens.Family2.LensLike' f s a
keys = Data.ProtoLens.Field.field @"keys"
lastCompletionResult ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastCompletionResult" a) =>
  Lens.Family2.LensLike' f s a
lastCompletionResult
  = Data.ProtoLens.Field.field @"lastCompletionResult"
lastHeartbeatDetails ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastHeartbeatDetails" a) =>
  Lens.Family2.LensLike' f s a
lastHeartbeatDetails
  = Data.ProtoLens.Field.field @"lastHeartbeatDetails"
majorVersionSets ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "majorVersionSets" a) =>
  Lens.Family2.LensLike' f s a
majorVersionSets = Data.ProtoLens.Field.field @"majorVersionSets"
makeSetDefault ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "makeSetDefault" a) =>
  Lens.Family2.LensLike' f s a
makeSetDefault = Data.ProtoLens.Field.field @"makeSetDefault"
maxOperationsPerSecond ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maxOperationsPerSecond" a) =>
  Lens.Family2.LensLike' f s a
maxOperationsPerSecond
  = Data.ProtoLens.Field.field @"maxOperationsPerSecond"
maxSets ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "maxSets" a) =>
  Lens.Family2.LensLike' f s a
maxSets = Data.ProtoLens.Field.field @"maxSets"
maximumPageSize ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maximumPageSize" a) =>
  Lens.Family2.LensLike' f s a
maximumPageSize = Data.ProtoLens.Field.field @"maximumPageSize"
maybe'activityType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'activityType" a) =>
  Lens.Family2.LensLike' f s a
maybe'activityType
  = Data.ProtoLens.Field.field @"maybe'activityType"
maybe'addCompatibleRedirectRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'addCompatibleRedirectRule" a) =>
  Lens.Family2.LensLike' f s a
maybe'addCompatibleRedirectRule
  = Data.ProtoLens.Field.field @"maybe'addCompatibleRedirectRule"
maybe'addNewBuildIdInNewDefaultSet ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'addNewBuildIdInNewDefaultSet" a) =>
  Lens.Family2.LensLike' f s a
maybe'addNewBuildIdInNewDefaultSet
  = Data.ProtoLens.Field.field @"maybe'addNewBuildIdInNewDefaultSet"
maybe'addNewCompatibleBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'addNewCompatibleBuildId" a) =>
  Lens.Family2.LensLike' f s a
maybe'addNewCompatibleBuildId
  = Data.ProtoLens.Field.field @"maybe'addNewCompatibleBuildId"
maybe'cancellationOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'cancellationOperation" a) =>
  Lens.Family2.LensLike' f s a
maybe'cancellationOperation
  = Data.ProtoLens.Field.field @"maybe'cancellationOperation"
maybe'capabilities ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'capabilities" a) =>
  Lens.Family2.LensLike' f s a
maybe'capabilities
  = Data.ProtoLens.Field.field @"maybe'capabilities"
maybe'closeTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'closeTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'closeTime = Data.ProtoLens.Field.field @"maybe'closeTime"
maybe'commitBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'commitBuildId" a) =>
  Lens.Family2.LensLike' f s a
maybe'commitBuildId
  = Data.ProtoLens.Field.field @"maybe'commitBuildId"
maybe'config ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'config" a) =>
  Lens.Family2.LensLike' f s a
maybe'config = Data.ProtoLens.Field.field @"maybe'config"
maybe'continuedFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'continuedFailure" a) =>
  Lens.Family2.LensLike' f s a
maybe'continuedFailure
  = Data.ProtoLens.Field.field @"maybe'continuedFailure"
maybe'currentAttemptScheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'currentAttemptScheduledTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'currentAttemptScheduledTime
  = Data.ProtoLens.Field.field @"maybe'currentAttemptScheduledTime"
maybe'deleteAssignmentRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'deleteAssignmentRule" a) =>
  Lens.Family2.LensLike' f s a
maybe'deleteAssignmentRule
  = Data.ProtoLens.Field.field @"maybe'deleteAssignmentRule"
maybe'deleteCompatibleRedirectRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'deleteCompatibleRedirectRule" a) =>
  Lens.Family2.LensLike' f s a
maybe'deleteCompatibleRedirectRule
  = Data.ProtoLens.Field.field @"maybe'deleteCompatibleRedirectRule"
maybe'deletionOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'deletionOperation" a) =>
  Lens.Family2.LensLike' f s a
maybe'deletionOperation
  = Data.ProtoLens.Field.field @"maybe'deletionOperation"
maybe'details ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'details" a) =>
  Lens.Family2.LensLike' f s a
maybe'details = Data.ProtoLens.Field.field @"maybe'details"
maybe'eagerWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'eagerWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
maybe'eagerWorkflowTask
  = Data.ProtoLens.Field.field @"maybe'eagerWorkflowTask"
maybe'endTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'endTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'endTime = Data.ProtoLens.Field.field @"maybe'endTime"
maybe'error ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'error" a) =>
  Lens.Family2.LensLike' f s a
maybe'error = Data.ProtoLens.Field.field @"maybe'error"
maybe'execution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'execution" a) =>
  Lens.Family2.LensLike' f s a
maybe'execution = Data.ProtoLens.Field.field @"maybe'execution"
maybe'executionConfig ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'executionConfig" a) =>
  Lens.Family2.LensLike' f s a
maybe'executionConfig
  = Data.ProtoLens.Field.field @"maybe'executionConfig"
maybe'executionFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'executionFilter" a) =>
  Lens.Family2.LensLike' f s a
maybe'executionFilter
  = Data.ProtoLens.Field.field @"maybe'executionFilter"
maybe'failure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'failure" a) =>
  Lens.Family2.LensLike' f s a
maybe'failure = Data.ProtoLens.Field.field @"maybe'failure"
maybe'filters ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'filters" a) =>
  Lens.Family2.LensLike' f s a
maybe'filters = Data.ProtoLens.Field.field @"maybe'filters"
maybe'header ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'header" a) =>
  Lens.Family2.LensLike' f s a
maybe'header = Data.ProtoLens.Field.field @"maybe'header"
maybe'heartbeatDetails ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'heartbeatDetails" a) =>
  Lens.Family2.LensLike' f s a
maybe'heartbeatDetails
  = Data.ProtoLens.Field.field @"maybe'heartbeatDetails"
maybe'heartbeatTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'heartbeatTimeout" a) =>
  Lens.Family2.LensLike' f s a
maybe'heartbeatTimeout
  = Data.ProtoLens.Field.field @"maybe'heartbeatTimeout"
maybe'history ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'history" a) =>
  Lens.Family2.LensLike' f s a
maybe'history = Data.ProtoLens.Field.field @"maybe'history"
maybe'info ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'info" a) =>
  Lens.Family2.LensLike' f s a
maybe'info = Data.ProtoLens.Field.field @"maybe'info"
maybe'initialPatch ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'initialPatch" a) =>
  Lens.Family2.LensLike' f s a
maybe'initialPatch
  = Data.ProtoLens.Field.field @"maybe'initialPatch"
maybe'input ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'input" a) =>
  Lens.Family2.LensLike' f s a
maybe'input = Data.ProtoLens.Field.field @"maybe'input"
maybe'insertAssignmentRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'insertAssignmentRule" a) =>
  Lens.Family2.LensLike' f s a
maybe'insertAssignmentRule
  = Data.ProtoLens.Field.field @"maybe'insertAssignmentRule"
maybe'lastCompletionResult ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastCompletionResult" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastCompletionResult
  = Data.ProtoLens.Field.field @"maybe'lastCompletionResult"
maybe'lastHeartbeatDetails ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastHeartbeatDetails" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastHeartbeatDetails
  = Data.ProtoLens.Field.field @"maybe'lastHeartbeatDetails"
maybe'memo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'memo" a) =>
  Lens.Family2.LensLike' f s a
maybe'memo = Data.ProtoLens.Field.field @"maybe'memo"
maybe'mergeSets ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'mergeSets" a) =>
  Lens.Family2.LensLike' f s a
maybe'mergeSets = Data.ProtoLens.Field.field @"maybe'mergeSets"
maybe'meteringMetadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'meteringMetadata" a) =>
  Lens.Family2.LensLike' f s a
maybe'meteringMetadata
  = Data.ProtoLens.Field.field @"maybe'meteringMetadata"
maybe'namespaceFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'namespaceFilter" a) =>
  Lens.Family2.LensLike' f s a
maybe'namespaceFilter
  = Data.ProtoLens.Field.field @"maybe'namespaceFilter"
maybe'namespaceInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'namespaceInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'namespaceInfo
  = Data.ProtoLens.Field.field @"maybe'namespaceInfo"
maybe'operation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'operation" a) =>
  Lens.Family2.LensLike' f s a
maybe'operation = Data.ProtoLens.Field.field @"maybe'operation"
maybe'outcome ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'outcome" a) =>
  Lens.Family2.LensLike' f s a
maybe'outcome = Data.ProtoLens.Field.field @"maybe'outcome"
maybe'patch ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'patch" a) =>
  Lens.Family2.LensLike' f s a
maybe'patch = Data.ProtoLens.Field.field @"maybe'patch"
maybe'pendingWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'pendingWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
maybe'pendingWorkflowTask
  = Data.ProtoLens.Field.field @"maybe'pendingWorkflowTask"
maybe'promoteBuildIdWithinSet ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'promoteBuildIdWithinSet" a) =>
  Lens.Family2.LensLike' f s a
maybe'promoteBuildIdWithinSet
  = Data.ProtoLens.Field.field @"maybe'promoteBuildIdWithinSet"
maybe'promoteSetByBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'promoteSetByBuildId" a) =>
  Lens.Family2.LensLike' f s a
maybe'promoteSetByBuildId
  = Data.ProtoLens.Field.field @"maybe'promoteSetByBuildId"
maybe'query ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'query" a) =>
  Lens.Family2.LensLike' f s a
maybe'query = Data.ProtoLens.Field.field @"maybe'query"
maybe'queryRejected ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'queryRejected" a) =>
  Lens.Family2.LensLike' f s a
maybe'queryRejected
  = Data.ProtoLens.Field.field @"maybe'queryRejected"
maybe'queryResult ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'queryResult" a) =>
  Lens.Family2.LensLike' f s a
maybe'queryResult = Data.ProtoLens.Field.field @"maybe'queryResult"
maybe'replaceAssignmentRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'replaceAssignmentRule" a) =>
  Lens.Family2.LensLike' f s a
maybe'replaceAssignmentRule
  = Data.ProtoLens.Field.field @"maybe'replaceAssignmentRule"
maybe'replaceCompatibleRedirectRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'replaceCompatibleRedirectRule" a) =>
  Lens.Family2.LensLike' f s a
maybe'replaceCompatibleRedirectRule
  = Data.ProtoLens.Field.field @"maybe'replaceCompatibleRedirectRule"
maybe'replicationConfig ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'replicationConfig" a) =>
  Lens.Family2.LensLike' f s a
maybe'replicationConfig
  = Data.ProtoLens.Field.field @"maybe'replicationConfig"
maybe'request ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'request" a) =>
  Lens.Family2.LensLike' f s a
maybe'request = Data.ProtoLens.Field.field @"maybe'request"
maybe'resetOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'resetOperation" a) =>
  Lens.Family2.LensLike' f s a
maybe'resetOperation
  = Data.ProtoLens.Field.field @"maybe'resetOperation"
maybe'response ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'response" a) =>
  Lens.Family2.LensLike' f s a
maybe'response = Data.ProtoLens.Field.field @"maybe'response"
maybe'result ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'result" a) =>
  Lens.Family2.LensLike' f s a
maybe'result = Data.ProtoLens.Field.field @"maybe'result"
maybe'retryPolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'retryPolicy" a) =>
  Lens.Family2.LensLike' f s a
maybe'retryPolicy = Data.ProtoLens.Field.field @"maybe'retryPolicy"
maybe'rule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'rule" a) =>
  Lens.Family2.LensLike' f s a
maybe'rule = Data.ProtoLens.Field.field @"maybe'rule"
maybe'schedule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'schedule" a) =>
  Lens.Family2.LensLike' f s a
maybe'schedule = Data.ProtoLens.Field.field @"maybe'schedule"
maybe'scheduleToCloseTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'scheduleToCloseTimeout" a) =>
  Lens.Family2.LensLike' f s a
maybe'scheduleToCloseTimeout
  = Data.ProtoLens.Field.field @"maybe'scheduleToCloseTimeout"
maybe'scheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'scheduledTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'scheduledTime
  = Data.ProtoLens.Field.field @"maybe'scheduledTime"
maybe'sdkMetadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'sdkMetadata" a) =>
  Lens.Family2.LensLike' f s a
maybe'sdkMetadata = Data.ProtoLens.Field.field @"maybe'sdkMetadata"
maybe'searchAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'searchAttributes" a) =>
  Lens.Family2.LensLike' f s a
maybe'searchAttributes
  = Data.ProtoLens.Field.field @"maybe'searchAttributes"
maybe'signalInput ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'signalInput" a) =>
  Lens.Family2.LensLike' f s a
maybe'signalInput = Data.ProtoLens.Field.field @"maybe'signalInput"
maybe'signalOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'signalOperation" a) =>
  Lens.Family2.LensLike' f s a
maybe'signalOperation
  = Data.ProtoLens.Field.field @"maybe'signalOperation"
maybe'startTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'startTime = Data.ProtoLens.Field.field @"maybe'startTime"
maybe'startTimeFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startTimeFilter" a) =>
  Lens.Family2.LensLike' f s a
maybe'startTimeFilter
  = Data.ProtoLens.Field.field @"maybe'startTimeFilter"
maybe'startToCloseTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startToCloseTimeout" a) =>
  Lens.Family2.LensLike' f s a
maybe'startToCloseTimeout
  = Data.ProtoLens.Field.field @"maybe'startToCloseTimeout"
maybe'startWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'startWorkflow
  = Data.ProtoLens.Field.field @"maybe'startWorkflow"
maybe'startedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startedTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'startedTime = Data.ProtoLens.Field.field @"maybe'startedTime"
maybe'statusFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'statusFilter" a) =>
  Lens.Family2.LensLike' f s a
maybe'statusFilter
  = Data.ProtoLens.Field.field @"maybe'statusFilter"
maybe'stickyAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'stickyAttributes" a) =>
  Lens.Family2.LensLike' f s a
maybe'stickyAttributes
  = Data.ProtoLens.Field.field @"maybe'stickyAttributes"
maybe'taskQueue ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'taskQueue" a) =>
  Lens.Family2.LensLike' f s a
maybe'taskQueue = Data.ProtoLens.Field.field @"maybe'taskQueue"
maybe'taskQueueMetadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'taskQueueMetadata" a) =>
  Lens.Family2.LensLike' f s a
maybe'taskQueueMetadata
  = Data.ProtoLens.Field.field @"maybe'taskQueueMetadata"
maybe'taskQueueStatus ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'taskQueueStatus" a) =>
  Lens.Family2.LensLike' f s a
maybe'taskQueueStatus
  = Data.ProtoLens.Field.field @"maybe'taskQueueStatus"
maybe'terminationOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'terminationOperation" a) =>
  Lens.Family2.LensLike' f s a
maybe'terminationOperation
  = Data.ProtoLens.Field.field @"maybe'terminationOperation"
maybe'typeFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'typeFilter" a) =>
  Lens.Family2.LensLike' f s a
maybe'typeFilter = Data.ProtoLens.Field.field @"maybe'typeFilter"
maybe'updateInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'updateInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'updateInfo = Data.ProtoLens.Field.field @"maybe'updateInfo"
maybe'updateRef ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'updateRef" a) =>
  Lens.Family2.LensLike' f s a
maybe'updateRef = Data.ProtoLens.Field.field @"maybe'updateRef"
maybe'updateWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'updateWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'updateWorkflow
  = Data.ProtoLens.Field.field @"maybe'updateWorkflow"
maybe'value ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'value" a) =>
  Lens.Family2.LensLike' f s a
maybe'value = Data.ProtoLens.Field.field @"maybe'value"
maybe'versionInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'versionInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'versionInfo = Data.ProtoLens.Field.field @"maybe'versionInfo"
maybe'versions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'versions" a) =>
  Lens.Family2.LensLike' f s a
maybe'versions = Data.ProtoLens.Field.field @"maybe'versions"
maybe'waitPolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'waitPolicy" a) =>
  Lens.Family2.LensLike' f s a
maybe'waitPolicy = Data.ProtoLens.Field.field @"maybe'waitPolicy"
maybe'workerVersion ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workerVersion" a) =>
  Lens.Family2.LensLike' f s a
maybe'workerVersion
  = Data.ProtoLens.Field.field @"maybe'workerVersion"
maybe'workerVersionCapabilities ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workerVersionCapabilities" a) =>
  Lens.Family2.LensLike' f s a
maybe'workerVersionCapabilities
  = Data.ProtoLens.Field.field @"maybe'workerVersionCapabilities"
maybe'workerVersionStamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workerVersionStamp" a) =>
  Lens.Family2.LensLike' f s a
maybe'workerVersionStamp
  = Data.ProtoLens.Field.field @"maybe'workerVersionStamp"
maybe'workflowExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowExecution" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowExecution
  = Data.ProtoLens.Field.field @"maybe'workflowExecution"
maybe'workflowExecutionInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowExecutionInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowExecutionInfo
  = Data.ProtoLens.Field.field @"maybe'workflowExecutionInfo"
maybe'workflowExecutionRetentionPeriod ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowExecutionRetentionPeriod" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowExecutionRetentionPeriod
  = Data.ProtoLens.Field.field
      @"maybe'workflowExecutionRetentionPeriod"
maybe'workflowExecutionTaskQueue ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowExecutionTaskQueue" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowExecutionTaskQueue
  = Data.ProtoLens.Field.field @"maybe'workflowExecutionTaskQueue"
maybe'workflowExecutionTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowExecutionTimeout" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowExecutionTimeout
  = Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout"
maybe'workflowRunTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowRunTimeout" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowRunTimeout
  = Data.ProtoLens.Field.field @"maybe'workflowRunTimeout"
maybe'workflowStartDelay ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowStartDelay" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowStartDelay
  = Data.ProtoLens.Field.field @"maybe'workflowStartDelay"
maybe'workflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowTask" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowTask
  = Data.ProtoLens.Field.field @"maybe'workflowTask"
maybe'workflowTaskTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowTaskTimeout" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowTaskTimeout
  = Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout"
maybe'workflowType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowType" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowType
  = Data.ProtoLens.Field.field @"maybe'workflowType"
memo ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "memo" a) =>
  Lens.Family2.LensLike' f s a
memo = Data.ProtoLens.Field.field @"memo"
mergeSets ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "mergeSets" a) =>
  Lens.Family2.LensLike' f s a
mergeSets = Data.ProtoLens.Field.field @"mergeSets"
messages ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "messages" a) =>
  Lens.Family2.LensLike' f s a
messages = Data.ProtoLens.Field.field @"messages"
meteringMetadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "meteringMetadata" a) =>
  Lens.Family2.LensLike' f s a
meteringMetadata = Data.ProtoLens.Field.field @"meteringMetadata"
namespace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "namespace" a) =>
  Lens.Family2.LensLike' f s a
namespace = Data.ProtoLens.Field.field @"namespace"
namespaceFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "namespaceFilter" a) =>
  Lens.Family2.LensLike' f s a
namespaceFilter = Data.ProtoLens.Field.field @"namespaceFilter"
namespaceInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "namespaceInfo" a) =>
  Lens.Family2.LensLike' f s a
namespaceInfo = Data.ProtoLens.Field.field @"namespaceInfo"
namespaces ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "namespaces" a) =>
  Lens.Family2.LensLike' f s a
namespaces = Data.ProtoLens.Field.field @"namespaces"
newBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "newBuildId" a) =>
  Lens.Family2.LensLike' f s a
newBuildId = Data.ProtoLens.Field.field @"newBuildId"
nextPageToken ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "nextPageToken" a) =>
  Lens.Family2.LensLike' f s a
nextPageToken = Data.ProtoLens.Field.field @"nextPageToken"
operationInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operationInfo" a) =>
  Lens.Family2.LensLike' f s a
operationInfo = Data.ProtoLens.Field.field @"operationInfo"
operationType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operationType" a) =>
  Lens.Family2.LensLike' f s a
operationType = Data.ProtoLens.Field.field @"operationType"
operations ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operations" a) =>
  Lens.Family2.LensLike' f s a
operations = Data.ProtoLens.Field.field @"operations"
outcome ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "outcome" a) =>
  Lens.Family2.LensLike' f s a
outcome = Data.ProtoLens.Field.field @"outcome"
ownerEmail ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "ownerEmail" a) =>
  Lens.Family2.LensLike' f s a
ownerEmail = Data.ProtoLens.Field.field @"ownerEmail"
pageSize ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "pageSize" a) =>
  Lens.Family2.LensLike' f s a
pageSize = Data.ProtoLens.Field.field @"pageSize"
patch ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "patch" a) =>
  Lens.Family2.LensLike' f s a
patch = Data.ProtoLens.Field.field @"patch"
pendingActivities ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "pendingActivities" a) =>
  Lens.Family2.LensLike' f s a
pendingActivities = Data.ProtoLens.Field.field @"pendingActivities"
pendingChildren ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "pendingChildren" a) =>
  Lens.Family2.LensLike' f s a
pendingChildren = Data.ProtoLens.Field.field @"pendingChildren"
pendingNexusOperations ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "pendingNexusOperations" a) =>
  Lens.Family2.LensLike' f s a
pendingNexusOperations
  = Data.ProtoLens.Field.field @"pendingNexusOperations"
pendingWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "pendingWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
pendingWorkflowTask
  = Data.ProtoLens.Field.field @"pendingWorkflowTask"
persistenceStore ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "persistenceStore" a) =>
  Lens.Family2.LensLike' f s a
persistenceStore = Data.ProtoLens.Field.field @"persistenceStore"
pollers ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "pollers" a) =>
  Lens.Family2.LensLike' f s a
pollers = Data.ProtoLens.Field.field @"pollers"
previousStartedEventId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "previousStartedEventId" a) =>
  Lens.Family2.LensLike' f s a
previousStartedEventId
  = Data.ProtoLens.Field.field @"previousStartedEventId"
primarySetBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "primarySetBuildId" a) =>
  Lens.Family2.LensLike' f s a
primarySetBuildId = Data.ProtoLens.Field.field @"primarySetBuildId"
promoteBuildIdWithinSet ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "promoteBuildIdWithinSet" a) =>
  Lens.Family2.LensLike' f s a
promoteBuildIdWithinSet
  = Data.ProtoLens.Field.field @"promoteBuildIdWithinSet"
promoteNamespace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "promoteNamespace" a) =>
  Lens.Family2.LensLike' f s a
promoteNamespace = Data.ProtoLens.Field.field @"promoteNamespace"
promoteSetByBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "promoteSetByBuildId" a) =>
  Lens.Family2.LensLike' f s a
promoteSetByBuildId
  = Data.ProtoLens.Field.field @"promoteSetByBuildId"
queries ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "queries" a) =>
  Lens.Family2.LensLike' f s a
queries = Data.ProtoLens.Field.field @"queries"
query ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "query" a) =>
  Lens.Family2.LensLike' f s a
query = Data.ProtoLens.Field.field @"query"
queryRejectCondition ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "queryRejectCondition" a) =>
  Lens.Family2.LensLike' f s a
queryRejectCondition
  = Data.ProtoLens.Field.field @"queryRejectCondition"
queryRejected ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "queryRejected" a) =>
  Lens.Family2.LensLike' f s a
queryRejected = Data.ProtoLens.Field.field @"queryRejected"
queryResult ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "queryResult" a) =>
  Lens.Family2.LensLike' f s a
queryResult = Data.ProtoLens.Field.field @"queryResult"
queryResults ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "queryResults" a) =>
  Lens.Family2.LensLike' f s a
queryResults = Data.ProtoLens.Field.field @"queryResults"
rawHistory ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "rawHistory" a) =>
  Lens.Family2.LensLike' f s a
rawHistory = Data.ProtoLens.Field.field @"rawHistory"
reachability ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "reachability" a) =>
  Lens.Family2.LensLike' f s a
reachability = Data.ProtoLens.Field.field @"reachability"
reason ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "reason" a) =>
  Lens.Family2.LensLike' f s a
reason = Data.ProtoLens.Field.field @"reason"
replaceAssignmentRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "replaceAssignmentRule" a) =>
  Lens.Family2.LensLike' f s a
replaceAssignmentRule
  = Data.ProtoLens.Field.field @"replaceAssignmentRule"
replaceCompatibleRedirectRule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "replaceCompatibleRedirectRule" a) =>
  Lens.Family2.LensLike' f s a
replaceCompatibleRedirectRule
  = Data.ProtoLens.Field.field @"replaceCompatibleRedirectRule"
replicationConfig ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "replicationConfig" a) =>
  Lens.Family2.LensLike' f s a
replicationConfig = Data.ProtoLens.Field.field @"replicationConfig"
reportPollers ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "reportPollers" a) =>
  Lens.Family2.LensLike' f s a
reportPollers = Data.ProtoLens.Field.field @"reportPollers"
reportTaskReachability ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "reportTaskReachability" a) =>
  Lens.Family2.LensLike' f s a
reportTaskReachability
  = Data.ProtoLens.Field.field @"reportTaskReachability"
request ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "request" a) =>
  Lens.Family2.LensLike' f s a
request = Data.ProtoLens.Field.field @"request"
requestEagerExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "requestEagerExecution" a) =>
  Lens.Family2.LensLike' f s a
requestEagerExecution
  = Data.ProtoLens.Field.field @"requestEagerExecution"
requestId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "requestId" a) =>
  Lens.Family2.LensLike' f s a
requestId = Data.ProtoLens.Field.field @"requestId"
resetHistoryEventId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resetHistoryEventId" a) =>
  Lens.Family2.LensLike' f s a
resetHistoryEventId
  = Data.ProtoLens.Field.field @"resetHistoryEventId"
resetOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resetOperation" a) =>
  Lens.Family2.LensLike' f s a
resetOperation = Data.ProtoLens.Field.field @"resetOperation"
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
response ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "response" a) =>
  Lens.Family2.LensLike' f s a
response = Data.ProtoLens.Field.field @"response"
responses ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "responses" a) =>
  Lens.Family2.LensLike' f s a
responses = Data.ProtoLens.Field.field @"responses"
result ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "result" a) =>
  Lens.Family2.LensLike' f s a
result = Data.ProtoLens.Field.field @"result"
retryPolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "retryPolicy" a) =>
  Lens.Family2.LensLike' f s a
retryPolicy = Data.ProtoLens.Field.field @"retryPolicy"
returnNewWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "returnNewWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
returnNewWorkflowTask
  = Data.ProtoLens.Field.field @"returnNewWorkflowTask"
rule ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "rule" a) =>
  Lens.Family2.LensLike' f s a
rule = Data.ProtoLens.Field.field @"rule"
ruleIndex ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "ruleIndex" a) =>
  Lens.Family2.LensLike' f s a
ruleIndex = Data.ProtoLens.Field.field @"ruleIndex"
runId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "runId" a) =>
  Lens.Family2.LensLike' f s a
runId = Data.ProtoLens.Field.field @"runId"
schedule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "schedule" a) =>
  Lens.Family2.LensLike' f s a
schedule = Data.ProtoLens.Field.field @"schedule"
scheduleId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "scheduleId" a) =>
  Lens.Family2.LensLike' f s a
scheduleId = Data.ProtoLens.Field.field @"scheduleId"
scheduleToCloseTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "scheduleToCloseTimeout" a) =>
  Lens.Family2.LensLike' f s a
scheduleToCloseTimeout
  = Data.ProtoLens.Field.field @"scheduleToCloseTimeout"
scheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "scheduledTime" a) =>
  Lens.Family2.LensLike' f s a
scheduledTime = Data.ProtoLens.Field.field @"scheduledTime"
schedules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "schedules" a) =>
  Lens.Family2.LensLike' f s a
schedules = Data.ProtoLens.Field.field @"schedules"
sdkMetadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "sdkMetadata" a) =>
  Lens.Family2.LensLike' f s a
sdkMetadata = Data.ProtoLens.Field.field @"sdkMetadata"
searchAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "searchAttributes" a) =>
  Lens.Family2.LensLike' f s a
searchAttributes = Data.ProtoLens.Field.field @"searchAttributes"
secondarySetBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "secondarySetBuildId" a) =>
  Lens.Family2.LensLike' f s a
secondarySetBuildId
  = Data.ProtoLens.Field.field @"secondarySetBuildId"
securityToken ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "securityToken" a) =>
  Lens.Family2.LensLike' f s a
securityToken = Data.ProtoLens.Field.field @"securityToken"
serverVersion ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "serverVersion" a) =>
  Lens.Family2.LensLike' f s a
serverVersion = Data.ProtoLens.Field.field @"serverVersion"
signalAndQueryHeader ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signalAndQueryHeader" a) =>
  Lens.Family2.LensLike' f s a
signalAndQueryHeader
  = Data.ProtoLens.Field.field @"signalAndQueryHeader"
signalInput ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signalInput" a) =>
  Lens.Family2.LensLike' f s a
signalInput = Data.ProtoLens.Field.field @"signalInput"
signalName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signalName" a) =>
  Lens.Family2.LensLike' f s a
signalName = Data.ProtoLens.Field.field @"signalName"
signalOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signalOperation" a) =>
  Lens.Family2.LensLike' f s a
signalOperation = Data.ProtoLens.Field.field @"signalOperation"
skipArchival ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "skipArchival" a) =>
  Lens.Family2.LensLike' f s a
skipArchival = Data.ProtoLens.Field.field @"skipArchival"
skipGenerateWorkflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "skipGenerateWorkflowTask" a) =>
  Lens.Family2.LensLike' f s a
skipGenerateWorkflowTask
  = Data.ProtoLens.Field.field @"skipGenerateWorkflowTask"
sourceBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "sourceBuildId" a) =>
  Lens.Family2.LensLike' f s a
sourceBuildId = Data.ProtoLens.Field.field @"sourceBuildId"
stage ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "stage" a) =>
  Lens.Family2.LensLike' f s a
stage = Data.ProtoLens.Field.field @"stage"
startTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startTime" a) =>
  Lens.Family2.LensLike' f s a
startTime = Data.ProtoLens.Field.field @"startTime"
startTimeFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startTimeFilter" a) =>
  Lens.Family2.LensLike' f s a
startTimeFilter = Data.ProtoLens.Field.field @"startTimeFilter"
startToCloseTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startToCloseTimeout" a) =>
  Lens.Family2.LensLike' f s a
startToCloseTimeout
  = Data.ProtoLens.Field.field @"startToCloseTimeout"
startWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startWorkflow" a) =>
  Lens.Family2.LensLike' f s a
startWorkflow = Data.ProtoLens.Field.field @"startWorkflow"
started ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "started" a) =>
  Lens.Family2.LensLike' f s a
started = Data.ProtoLens.Field.field @"started"
startedEventId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startedEventId" a) =>
  Lens.Family2.LensLike' f s a
startedEventId = Data.ProtoLens.Field.field @"startedEventId"
startedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startedTime" a) =>
  Lens.Family2.LensLike' f s a
startedTime = Data.ProtoLens.Field.field @"startedTime"
state ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "state" a) =>
  Lens.Family2.LensLike' f s a
state = Data.ProtoLens.Field.field @"state"
statusFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "statusFilter" a) =>
  Lens.Family2.LensLike' f s a
statusFilter = Data.ProtoLens.Field.field @"statusFilter"
stickyAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "stickyAttributes" a) =>
  Lens.Family2.LensLike' f s a
stickyAttributes = Data.ProtoLens.Field.field @"stickyAttributes"
supportedClients ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "supportedClients" a) =>
  Lens.Family2.LensLike' f s a
supportedClients = Data.ProtoLens.Field.field @"supportedClients"
supportsSchedules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "supportsSchedules" a) =>
  Lens.Family2.LensLike' f s a
supportsSchedules = Data.ProtoLens.Field.field @"supportsSchedules"
targetBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "targetBuildId" a) =>
  Lens.Family2.LensLike' f s a
targetBuildId = Data.ProtoLens.Field.field @"targetBuildId"
taskQueue ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueue" a) =>
  Lens.Family2.LensLike' f s a
taskQueue = Data.ProtoLens.Field.field @"taskQueue"
taskQueueMetadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueueMetadata" a) =>
  Lens.Family2.LensLike' f s a
taskQueueMetadata = Data.ProtoLens.Field.field @"taskQueueMetadata"
taskQueueStatus ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueueStatus" a) =>
  Lens.Family2.LensLike' f s a
taskQueueStatus = Data.ProtoLens.Field.field @"taskQueueStatus"
taskQueueType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueueType" a) =>
  Lens.Family2.LensLike' f s a
taskQueueType = Data.ProtoLens.Field.field @"taskQueueType"
taskQueueTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueueTypes" a) =>
  Lens.Family2.LensLike' f s a
taskQueueTypes = Data.ProtoLens.Field.field @"taskQueueTypes"
taskQueues ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueues" a) =>
  Lens.Family2.LensLike' f s a
taskQueues = Data.ProtoLens.Field.field @"taskQueues"
taskToken ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskToken" a) =>
  Lens.Family2.LensLike' f s a
taskToken = Data.ProtoLens.Field.field @"taskToken"
terminationOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "terminationOperation" a) =>
  Lens.Family2.LensLike' f s a
terminationOperation
  = Data.ProtoLens.Field.field @"terminationOperation"
totalOperationCount ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "totalOperationCount" a) =>
  Lens.Family2.LensLike' f s a
totalOperationCount
  = Data.ProtoLens.Field.field @"totalOperationCount"
typeFilter ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "typeFilter" a) =>
  Lens.Family2.LensLike' f s a
typeFilter = Data.ProtoLens.Field.field @"typeFilter"
updateInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "updateInfo" a) =>
  Lens.Family2.LensLike' f s a
updateInfo = Data.ProtoLens.Field.field @"updateInfo"
updateRef ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "updateRef" a) =>
  Lens.Family2.LensLike' f s a
updateRef = Data.ProtoLens.Field.field @"updateRef"
updateWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "updateWorkflow" a) =>
  Lens.Family2.LensLike' f s a
updateWorkflow = Data.ProtoLens.Field.field @"updateWorkflow"
upsertMemo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "upsertMemo" a) =>
  Lens.Family2.LensLike' f s a
upsertMemo = Data.ProtoLens.Field.field @"upsertMemo"
value ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "value" a) =>
  Lens.Family2.LensLike' f s a
value = Data.ProtoLens.Field.field @"value"
vec'activityTaskQueuePartitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'activityTaskQueuePartitions" a) =>
  Lens.Family2.LensLike' f s a
vec'activityTaskQueuePartitions
  = Data.ProtoLens.Field.field @"vec'activityTaskQueuePartitions"
vec'activityTasks ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'activityTasks" a) =>
  Lens.Family2.LensLike' f s a
vec'activityTasks = Data.ProtoLens.Field.field @"vec'activityTasks"
vec'assignmentRules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'assignmentRules" a) =>
  Lens.Family2.LensLike' f s a
vec'assignmentRules
  = Data.ProtoLens.Field.field @"vec'assignmentRules"
vec'buildIdReachability ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'buildIdReachability" a) =>
  Lens.Family2.LensLike' f s a
vec'buildIdReachability
  = Data.ProtoLens.Field.field @"vec'buildIdReachability"
vec'buildIds ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'buildIds" a) =>
  Lens.Family2.LensLike' f s a
vec'buildIds = Data.ProtoLens.Field.field @"vec'buildIds"
vec'callbacks ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'callbacks" a) =>
  Lens.Family2.LensLike' f s a
vec'callbacks = Data.ProtoLens.Field.field @"vec'callbacks"
vec'clusters ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'clusters" a) =>
  Lens.Family2.LensLike' f s a
vec'clusters = Data.ProtoLens.Field.field @"vec'clusters"
vec'commands ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'commands" a) =>
  Lens.Family2.LensLike' f s a
vec'commands = Data.ProtoLens.Field.field @"vec'commands"
vec'compatibleRedirectRules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'compatibleRedirectRules" a) =>
  Lens.Family2.LensLike' f s a
vec'compatibleRedirectRules
  = Data.ProtoLens.Field.field @"vec'compatibleRedirectRules"
vec'completionCallbacks ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'completionCallbacks" a) =>
  Lens.Family2.LensLike' f s a
vec'completionCallbacks
  = Data.ProtoLens.Field.field @"vec'completionCallbacks"
vec'executions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'executions" a) =>
  Lens.Family2.LensLike' f s a
vec'executions = Data.ProtoLens.Field.field @"vec'executions"
vec'failoverHistory ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'failoverHistory" a) =>
  Lens.Family2.LensLike' f s a
vec'failoverHistory
  = Data.ProtoLens.Field.field @"vec'failoverHistory"
vec'failures ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'failures" a) =>
  Lens.Family2.LensLike' f s a
vec'failures = Data.ProtoLens.Field.field @"vec'failures"
vec'groupValues ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'groupValues" a) =>
  Lens.Family2.LensLike' f s a
vec'groupValues = Data.ProtoLens.Field.field @"vec'groupValues"
vec'groups ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'groups" a) =>
  Lens.Family2.LensLike' f s a
vec'groups = Data.ProtoLens.Field.field @"vec'groups"
vec'majorVersionSets ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'majorVersionSets" a) =>
  Lens.Family2.LensLike' f s a
vec'majorVersionSets
  = Data.ProtoLens.Field.field @"vec'majorVersionSets"
vec'messages ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'messages" a) =>
  Lens.Family2.LensLike' f s a
vec'messages = Data.ProtoLens.Field.field @"vec'messages"
vec'namespaces ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'namespaces" a) =>
  Lens.Family2.LensLike' f s a
vec'namespaces = Data.ProtoLens.Field.field @"vec'namespaces"
vec'operationInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'operationInfo" a) =>
  Lens.Family2.LensLike' f s a
vec'operationInfo = Data.ProtoLens.Field.field @"vec'operationInfo"
vec'operations ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'operations" a) =>
  Lens.Family2.LensLike' f s a
vec'operations = Data.ProtoLens.Field.field @"vec'operations"
vec'pendingActivities ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'pendingActivities" a) =>
  Lens.Family2.LensLike' f s a
vec'pendingActivities
  = Data.ProtoLens.Field.field @"vec'pendingActivities"
vec'pendingChildren ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'pendingChildren" a) =>
  Lens.Family2.LensLike' f s a
vec'pendingChildren
  = Data.ProtoLens.Field.field @"vec'pendingChildren"
vec'pendingNexusOperations ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'pendingNexusOperations" a) =>
  Lens.Family2.LensLike' f s a
vec'pendingNexusOperations
  = Data.ProtoLens.Field.field @"vec'pendingNexusOperations"
vec'pollers ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'pollers" a) =>
  Lens.Family2.LensLike' f s a
vec'pollers = Data.ProtoLens.Field.field @"vec'pollers"
vec'rawHistory ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'rawHistory" a) =>
  Lens.Family2.LensLike' f s a
vec'rawHistory = Data.ProtoLens.Field.field @"vec'rawHistory"
vec'resetReapplyExcludeTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'resetReapplyExcludeTypes" a) =>
  Lens.Family2.LensLike' f s a
vec'resetReapplyExcludeTypes
  = Data.ProtoLens.Field.field @"vec'resetReapplyExcludeTypes"
vec'responses ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'responses" a) =>
  Lens.Family2.LensLike' f s a
vec'responses = Data.ProtoLens.Field.field @"vec'responses"
vec'schedules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'schedules" a) =>
  Lens.Family2.LensLike' f s a
vec'schedules = Data.ProtoLens.Field.field @"vec'schedules"
vec'startTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'startTime" a) =>
  Lens.Family2.LensLike' f s a
vec'startTime = Data.ProtoLens.Field.field @"vec'startTime"
vec'taskQueueTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'taskQueueTypes" a) =>
  Lens.Family2.LensLike' f s a
vec'taskQueueTypes
  = Data.ProtoLens.Field.field @"vec'taskQueueTypes"
vec'taskQueues ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'taskQueues" a) =>
  Lens.Family2.LensLike' f s a
vec'taskQueues = Data.ProtoLens.Field.field @"vec'taskQueues"
vec'workflowTaskQueuePartitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'workflowTaskQueuePartitions" a) =>
  Lens.Family2.LensLike' f s a
vec'workflowTaskQueuePartitions
  = Data.ProtoLens.Field.field @"vec'workflowTaskQueuePartitions"
versionInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "versionInfo" a) =>
  Lens.Family2.LensLike' f s a
versionInfo = Data.ProtoLens.Field.field @"versionInfo"
versions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "versions" a) =>
  Lens.Family2.LensLike' f s a
versions = Data.ProtoLens.Field.field @"versions"
versionsInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "versionsInfo" a) =>
  Lens.Family2.LensLike' f s a
versionsInfo = Data.ProtoLens.Field.field @"versionsInfo"
visibilityArchivalState ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "visibilityArchivalState" a) =>
  Lens.Family2.LensLike' f s a
visibilityArchivalState
  = Data.ProtoLens.Field.field @"visibilityArchivalState"
visibilityArchivalUri ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "visibilityArchivalUri" a) =>
  Lens.Family2.LensLike' f s a
visibilityArchivalUri
  = Data.ProtoLens.Field.field @"visibilityArchivalUri"
visibilityQuery ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "visibilityQuery" a) =>
  Lens.Family2.LensLike' f s a
visibilityQuery = Data.ProtoLens.Field.field @"visibilityQuery"
visibilityStore ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "visibilityStore" a) =>
  Lens.Family2.LensLike' f s a
visibilityStore = Data.ProtoLens.Field.field @"visibilityStore"
waitNewEvent ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "waitNewEvent" a) =>
  Lens.Family2.LensLike' f s a
waitNewEvent = Data.ProtoLens.Field.field @"waitNewEvent"
waitPolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "waitPolicy" a) =>
  Lens.Family2.LensLike' f s a
waitPolicy = Data.ProtoLens.Field.field @"waitPolicy"
workerVersion ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workerVersion" a) =>
  Lens.Family2.LensLike' f s a
workerVersion = Data.ProtoLens.Field.field @"workerVersion"
workerVersionCapabilities ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workerVersionCapabilities" a) =>
  Lens.Family2.LensLike' f s a
workerVersionCapabilities
  = Data.ProtoLens.Field.field @"workerVersionCapabilities"
workerVersionStamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workerVersionStamp" a) =>
  Lens.Family2.LensLike' f s a
workerVersionStamp
  = Data.ProtoLens.Field.field @"workerVersionStamp"
workflowExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowExecution" a) =>
  Lens.Family2.LensLike' f s a
workflowExecution = Data.ProtoLens.Field.field @"workflowExecution"
workflowExecutionInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowExecutionInfo" a) =>
  Lens.Family2.LensLike' f s a
workflowExecutionInfo
  = Data.ProtoLens.Field.field @"workflowExecutionInfo"
workflowExecutionRetentionPeriod ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowExecutionRetentionPeriod" a) =>
  Lens.Family2.LensLike' f s a
workflowExecutionRetentionPeriod
  = Data.ProtoLens.Field.field @"workflowExecutionRetentionPeriod"
workflowExecutionTaskQueue ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowExecutionTaskQueue" a) =>
  Lens.Family2.LensLike' f s a
workflowExecutionTaskQueue
  = Data.ProtoLens.Field.field @"workflowExecutionTaskQueue"
workflowExecutionTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowExecutionTimeout" a) =>
  Lens.Family2.LensLike' f s a
workflowExecutionTimeout
  = Data.ProtoLens.Field.field @"workflowExecutionTimeout"
workflowId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowId" a) =>
  Lens.Family2.LensLike' f s a
workflowId = Data.ProtoLens.Field.field @"workflowId"
workflowIdConflictPolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowIdConflictPolicy" a) =>
  Lens.Family2.LensLike' f s a
workflowIdConflictPolicy
  = Data.ProtoLens.Field.field @"workflowIdConflictPolicy"
workflowIdReusePolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowIdReusePolicy" a) =>
  Lens.Family2.LensLike' f s a
workflowIdReusePolicy
  = Data.ProtoLens.Field.field @"workflowIdReusePolicy"
workflowNamespace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowNamespace" a) =>
  Lens.Family2.LensLike' f s a
workflowNamespace = Data.ProtoLens.Field.field @"workflowNamespace"
workflowRunTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowRunTimeout" a) =>
  Lens.Family2.LensLike' f s a
workflowRunTimeout
  = Data.ProtoLens.Field.field @"workflowRunTimeout"
workflowStartDelay ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowStartDelay" a) =>
  Lens.Family2.LensLike' f s a
workflowStartDelay
  = Data.ProtoLens.Field.field @"workflowStartDelay"
workflowTask ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowTask" a) =>
  Lens.Family2.LensLike' f s a
workflowTask = Data.ProtoLens.Field.field @"workflowTask"
workflowTaskFinishEventId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowTaskFinishEventId" a) =>
  Lens.Family2.LensLike' f s a
workflowTaskFinishEventId
  = Data.ProtoLens.Field.field @"workflowTaskFinishEventId"
workflowTaskQueuePartitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowTaskQueuePartitions" a) =>
  Lens.Family2.LensLike' f s a
workflowTaskQueuePartitions
  = Data.ProtoLens.Field.field @"workflowTaskQueuePartitions"
workflowTaskTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowTaskTimeout" a) =>
  Lens.Family2.LensLike' f s a
workflowTaskTimeout
  = Data.ProtoLens.Field.field @"workflowTaskTimeout"
workflowType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowType" a) =>
  Lens.Family2.LensLike' f s a
workflowType = Data.ProtoLens.Field.field @"workflowType"

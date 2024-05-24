{- This file was auto-generated from temporal/api/workflow/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Workflow.V1.Message_Fields where
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Common
import qualified Proto.Temporal.Api.Enums.V1.Workflow
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Api.Taskqueue.V1.Message
activityId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityId" a) =>
  Lens.Family2.LensLike' f s a
activityId = Data.ProtoLens.Field.field @"activityId"
activityType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityType" a) =>
  Lens.Family2.LensLike' f s a
activityType = Data.ProtoLens.Field.field @"activityType"
assignedBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "assignedBuildId" a) =>
  Lens.Family2.LensLike' f s a
assignedBuildId = Data.ProtoLens.Field.field @"assignedBuildId"
attempt ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "attempt" a) =>
  Lens.Family2.LensLike' f s a
attempt = Data.ProtoLens.Field.field @"attempt"
autoResetPoints ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "autoResetPoints" a) =>
  Lens.Family2.LensLike' f s a
autoResetPoints = Data.ProtoLens.Field.field @"autoResetPoints"
binaryChecksum ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "binaryChecksum" a) =>
  Lens.Family2.LensLike' f s a
binaryChecksum = Data.ProtoLens.Field.field @"binaryChecksum"
buildId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "buildId" a) =>
  Lens.Family2.LensLike' f s a
buildId = Data.ProtoLens.Field.field @"buildId"
callback ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "callback" a) =>
  Lens.Family2.LensLike' f s a
callback = Data.ProtoLens.Field.field @"callback"
cancellationInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cancellationInfo" a) =>
  Lens.Family2.LensLike' f s a
cancellationInfo = Data.ProtoLens.Field.field @"cancellationInfo"
closeTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "closeTime" a) =>
  Lens.Family2.LensLike' f s a
closeTime = Data.ProtoLens.Field.field @"closeTime"
createTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "createTime" a) =>
  Lens.Family2.LensLike' f s a
createTime = Data.ProtoLens.Field.field @"createTime"
cronSchedule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cronSchedule" a) =>
  Lens.Family2.LensLike' f s a
cronSchedule = Data.ProtoLens.Field.field @"cronSchedule"
defaultWorkflowTaskTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "defaultWorkflowTaskTimeout" a) =>
  Lens.Family2.LensLike' f s a
defaultWorkflowTaskTimeout
  = Data.ProtoLens.Field.field @"defaultWorkflowTaskTimeout"
endpoint ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "endpoint" a) =>
  Lens.Family2.LensLike' f s a
endpoint = Data.ProtoLens.Field.field @"endpoint"
execution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "execution" a) =>
  Lens.Family2.LensLike' f s a
execution = Data.ProtoLens.Field.field @"execution"
executionDuration ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "executionDuration" a) =>
  Lens.Family2.LensLike' f s a
executionDuration = Data.ProtoLens.Field.field @"executionDuration"
executionTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "executionTime" a) =>
  Lens.Family2.LensLike' f s a
executionTime = Data.ProtoLens.Field.field @"executionTime"
expirationTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "expirationTime" a) =>
  Lens.Family2.LensLike' f s a
expirationTime = Data.ProtoLens.Field.field @"expirationTime"
expireTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "expireTime" a) =>
  Lens.Family2.LensLike' f s a
expireTime = Data.ProtoLens.Field.field @"expireTime"
firstWorkflowTaskCompletedId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "firstWorkflowTaskCompletedId" a) =>
  Lens.Family2.LensLike' f s a
firstWorkflowTaskCompletedId
  = Data.ProtoLens.Field.field @"firstWorkflowTaskCompletedId"
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
historyLength ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "historyLength" a) =>
  Lens.Family2.LensLike' f s a
historyLength = Data.ProtoLens.Field.field @"historyLength"
historySizeBytes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "historySizeBytes" a) =>
  Lens.Family2.LensLike' f s a
historySizeBytes = Data.ProtoLens.Field.field @"historySizeBytes"
inheritedBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "inheritedBuildId" a) =>
  Lens.Family2.LensLike' f s a
inheritedBuildId = Data.ProtoLens.Field.field @"inheritedBuildId"
initiatedId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "initiatedId" a) =>
  Lens.Family2.LensLike' f s a
initiatedId = Data.ProtoLens.Field.field @"initiatedId"
input ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "input" a) =>
  Lens.Family2.LensLike' f s a
input = Data.ProtoLens.Field.field @"input"
lastAttemptCompleteTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastAttemptCompleteTime" a) =>
  Lens.Family2.LensLike' f s a
lastAttemptCompleteTime
  = Data.ProtoLens.Field.field @"lastAttemptCompleteTime"
lastAttemptFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastAttemptFailure" a) =>
  Lens.Family2.LensLike' f s a
lastAttemptFailure
  = Data.ProtoLens.Field.field @"lastAttemptFailure"
lastFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastFailure" a) =>
  Lens.Family2.LensLike' f s a
lastFailure = Data.ProtoLens.Field.field @"lastFailure"
lastHeartbeatTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastHeartbeatTime" a) =>
  Lens.Family2.LensLike' f s a
lastHeartbeatTime = Data.ProtoLens.Field.field @"lastHeartbeatTime"
lastIndependentlyAssignedBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastIndependentlyAssignedBuildId" a) =>
  Lens.Family2.LensLike' f s a
lastIndependentlyAssignedBuildId
  = Data.ProtoLens.Field.field @"lastIndependentlyAssignedBuildId"
lastStartedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastStartedTime" a) =>
  Lens.Family2.LensLike' f s a
lastStartedTime = Data.ProtoLens.Field.field @"lastStartedTime"
lastWorkerIdentity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastWorkerIdentity" a) =>
  Lens.Family2.LensLike' f s a
lastWorkerIdentity
  = Data.ProtoLens.Field.field @"lastWorkerIdentity"
lastWorkerVersionStamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastWorkerVersionStamp" a) =>
  Lens.Family2.LensLike' f s a
lastWorkerVersionStamp
  = Data.ProtoLens.Field.field @"lastWorkerVersionStamp"
maximumAttempts ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maximumAttempts" a) =>
  Lens.Family2.LensLike' f s a
maximumAttempts = Data.ProtoLens.Field.field @"maximumAttempts"
maybe'activityType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'activityType" a) =>
  Lens.Family2.LensLike' f s a
maybe'activityType
  = Data.ProtoLens.Field.field @"maybe'activityType"
maybe'assignedBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'assignedBuildId" a) =>
  Lens.Family2.LensLike' f s a
maybe'assignedBuildId
  = Data.ProtoLens.Field.field @"maybe'assignedBuildId"
maybe'autoResetPoints ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'autoResetPoints" a) =>
  Lens.Family2.LensLike' f s a
maybe'autoResetPoints
  = Data.ProtoLens.Field.field @"maybe'autoResetPoints"
maybe'callback ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'callback" a) =>
  Lens.Family2.LensLike' f s a
maybe'callback = Data.ProtoLens.Field.field @"maybe'callback"
maybe'cancellationInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'cancellationInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'cancellationInfo
  = Data.ProtoLens.Field.field @"maybe'cancellationInfo"
maybe'closeTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'closeTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'closeTime = Data.ProtoLens.Field.field @"maybe'closeTime"
maybe'createTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'createTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'createTime = Data.ProtoLens.Field.field @"maybe'createTime"
maybe'defaultWorkflowTaskTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'defaultWorkflowTaskTimeout" a) =>
  Lens.Family2.LensLike' f s a
maybe'defaultWorkflowTaskTimeout
  = Data.ProtoLens.Field.field @"maybe'defaultWorkflowTaskTimeout"
maybe'execution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'execution" a) =>
  Lens.Family2.LensLike' f s a
maybe'execution = Data.ProtoLens.Field.field @"maybe'execution"
maybe'executionDuration ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'executionDuration" a) =>
  Lens.Family2.LensLike' f s a
maybe'executionDuration
  = Data.ProtoLens.Field.field @"maybe'executionDuration"
maybe'executionTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'executionTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'executionTime
  = Data.ProtoLens.Field.field @"maybe'executionTime"
maybe'expirationTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'expirationTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'expirationTime
  = Data.ProtoLens.Field.field @"maybe'expirationTime"
maybe'expireTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'expireTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'expireTime = Data.ProtoLens.Field.field @"maybe'expireTime"
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
maybe'input ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'input" a) =>
  Lens.Family2.LensLike' f s a
maybe'input = Data.ProtoLens.Field.field @"maybe'input"
maybe'lastAttemptCompleteTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastAttemptCompleteTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastAttemptCompleteTime
  = Data.ProtoLens.Field.field @"maybe'lastAttemptCompleteTime"
maybe'lastAttemptFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastAttemptFailure" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastAttemptFailure
  = Data.ProtoLens.Field.field @"maybe'lastAttemptFailure"
maybe'lastFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastFailure" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastFailure = Data.ProtoLens.Field.field @"maybe'lastFailure"
maybe'lastHeartbeatTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastHeartbeatTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastHeartbeatTime
  = Data.ProtoLens.Field.field @"maybe'lastHeartbeatTime"
maybe'lastIndependentlyAssignedBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastIndependentlyAssignedBuildId" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastIndependentlyAssignedBuildId
  = Data.ProtoLens.Field.field
      @"maybe'lastIndependentlyAssignedBuildId"
maybe'lastStartedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastStartedTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastStartedTime
  = Data.ProtoLens.Field.field @"maybe'lastStartedTime"
maybe'lastWorkerVersionStamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastWorkerVersionStamp" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastWorkerVersionStamp
  = Data.ProtoLens.Field.field @"maybe'lastWorkerVersionStamp"
maybe'memo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'memo" a) =>
  Lens.Family2.LensLike' f s a
maybe'memo = Data.ProtoLens.Field.field @"maybe'memo"
maybe'mostRecentWorkerVersionStamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'mostRecentWorkerVersionStamp" a) =>
  Lens.Family2.LensLike' f s a
maybe'mostRecentWorkerVersionStamp
  = Data.ProtoLens.Field.field @"maybe'mostRecentWorkerVersionStamp"
maybe'nextAttemptScheduleTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'nextAttemptScheduleTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'nextAttemptScheduleTime
  = Data.ProtoLens.Field.field @"maybe'nextAttemptScheduleTime"
maybe'originalScheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'originalScheduledTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'originalScheduledTime
  = Data.ProtoLens.Field.field @"maybe'originalScheduledTime"
maybe'parentExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'parentExecution" a) =>
  Lens.Family2.LensLike' f s a
maybe'parentExecution
  = Data.ProtoLens.Field.field @"maybe'parentExecution"
maybe'registrationTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'registrationTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'registrationTime
  = Data.ProtoLens.Field.field @"maybe'registrationTime"
maybe'requestedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'requestedTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'requestedTime
  = Data.ProtoLens.Field.field @"maybe'requestedTime"
maybe'retryPolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'retryPolicy" a) =>
  Lens.Family2.LensLike' f s a
maybe'retryPolicy = Data.ProtoLens.Field.field @"maybe'retryPolicy"
maybe'rootExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'rootExecution" a) =>
  Lens.Family2.LensLike' f s a
maybe'rootExecution
  = Data.ProtoLens.Field.field @"maybe'rootExecution"
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
maybe'searchAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'searchAttributes" a) =>
  Lens.Family2.LensLike' f s a
maybe'searchAttributes
  = Data.ProtoLens.Field.field @"maybe'searchAttributes"
maybe'startTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'startTime = Data.ProtoLens.Field.field @"maybe'startTime"
maybe'startedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startedTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'startedTime = Data.ProtoLens.Field.field @"maybe'startedTime"
maybe'taskQueue ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'taskQueue" a) =>
  Lens.Family2.LensLike' f s a
maybe'taskQueue = Data.ProtoLens.Field.field @"maybe'taskQueue"
maybe'trigger ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'trigger" a) =>
  Lens.Family2.LensLike' f s a
maybe'trigger = Data.ProtoLens.Field.field @"maybe'trigger"
maybe'type' ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'type'" a) =>
  Lens.Family2.LensLike' f s a
maybe'type' = Data.ProtoLens.Field.field @"maybe'type'"
maybe'useWorkflowBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'useWorkflowBuildId" a) =>
  Lens.Family2.LensLike' f s a
maybe'useWorkflowBuildId
  = Data.ProtoLens.Field.field @"maybe'useWorkflowBuildId"
maybe'variant ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'variant" a) =>
  Lens.Family2.LensLike' f s a
maybe'variant = Data.ProtoLens.Field.field @"maybe'variant"
maybe'workflowClosed ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowClosed" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowClosed
  = Data.ProtoLens.Field.field @"maybe'workflowClosed"
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
mostRecentWorkerVersionStamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "mostRecentWorkerVersionStamp" a) =>
  Lens.Family2.LensLike' f s a
mostRecentWorkerVersionStamp
  = Data.ProtoLens.Field.field @"mostRecentWorkerVersionStamp"
nextAttemptScheduleTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "nextAttemptScheduleTime" a) =>
  Lens.Family2.LensLike' f s a
nextAttemptScheduleTime
  = Data.ProtoLens.Field.field @"nextAttemptScheduleTime"
operation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operation" a) =>
  Lens.Family2.LensLike' f s a
operation = Data.ProtoLens.Field.field @"operation"
operationId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operationId" a) =>
  Lens.Family2.LensLike' f s a
operationId = Data.ProtoLens.Field.field @"operationId"
originalScheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "originalScheduledTime" a) =>
  Lens.Family2.LensLike' f s a
originalScheduledTime
  = Data.ProtoLens.Field.field @"originalScheduledTime"
parentClosePolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "parentClosePolicy" a) =>
  Lens.Family2.LensLike' f s a
parentClosePolicy = Data.ProtoLens.Field.field @"parentClosePolicy"
parentExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "parentExecution" a) =>
  Lens.Family2.LensLike' f s a
parentExecution = Data.ProtoLens.Field.field @"parentExecution"
parentNamespaceId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "parentNamespaceId" a) =>
  Lens.Family2.LensLike' f s a
parentNamespaceId = Data.ProtoLens.Field.field @"parentNamespaceId"
points ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "points" a) =>
  Lens.Family2.LensLike' f s a
points = Data.ProtoLens.Field.field @"points"
registrationTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "registrationTime" a) =>
  Lens.Family2.LensLike' f s a
registrationTime = Data.ProtoLens.Field.field @"registrationTime"
requestedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "requestedTime" a) =>
  Lens.Family2.LensLike' f s a
requestedTime = Data.ProtoLens.Field.field @"requestedTime"
resettable ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resettable" a) =>
  Lens.Family2.LensLike' f s a
resettable = Data.ProtoLens.Field.field @"resettable"
retryPolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "retryPolicy" a) =>
  Lens.Family2.LensLike' f s a
retryPolicy = Data.ProtoLens.Field.field @"retryPolicy"
rootExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "rootExecution" a) =>
  Lens.Family2.LensLike' f s a
rootExecution = Data.ProtoLens.Field.field @"rootExecution"
runId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "runId" a) =>
  Lens.Family2.LensLike' f s a
runId = Data.ProtoLens.Field.field @"runId"
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
searchAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "searchAttributes" a) =>
  Lens.Family2.LensLike' f s a
searchAttributes = Data.ProtoLens.Field.field @"searchAttributes"
service ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "service" a) =>
  Lens.Family2.LensLike' f s a
service = Data.ProtoLens.Field.field @"service"
startTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startTime" a) =>
  Lens.Family2.LensLike' f s a
startTime = Data.ProtoLens.Field.field @"startTime"
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
stateTransitionCount ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "stateTransitionCount" a) =>
  Lens.Family2.LensLike' f s a
stateTransitionCount
  = Data.ProtoLens.Field.field @"stateTransitionCount"
status ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "status" a) =>
  Lens.Family2.LensLike' f s a
status = Data.ProtoLens.Field.field @"status"
taskQueue ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueue" a) =>
  Lens.Family2.LensLike' f s a
taskQueue = Data.ProtoLens.Field.field @"taskQueue"
trigger ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "trigger" a) =>
  Lens.Family2.LensLike' f s a
trigger = Data.ProtoLens.Field.field @"trigger"
type' ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "type'" a) =>
  Lens.Family2.LensLike' f s a
type' = Data.ProtoLens.Field.field @"type'"
useWorkflowBuildId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "useWorkflowBuildId" a) =>
  Lens.Family2.LensLike' f s a
useWorkflowBuildId
  = Data.ProtoLens.Field.field @"useWorkflowBuildId"
vec'points ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'points" a) =>
  Lens.Family2.LensLike' f s a
vec'points = Data.ProtoLens.Field.field @"vec'points"
workflowClosed ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowClosed" a) =>
  Lens.Family2.LensLike' f s a
workflowClosed = Data.ProtoLens.Field.field @"workflowClosed"
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
workflowIdReusePolicy ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowIdReusePolicy" a) =>
  Lens.Family2.LensLike' f s a
workflowIdReusePolicy
  = Data.ProtoLens.Field.field @"workflowIdReusePolicy"
workflowRunTimeout ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowRunTimeout" a) =>
  Lens.Family2.LensLike' f s a
workflowRunTimeout
  = Data.ProtoLens.Field.field @"workflowRunTimeout"
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
workflowTypeName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowTypeName" a) =>
  Lens.Family2.LensLike' f s a
workflowTypeName = Data.ProtoLens.Field.field @"workflowTypeName"

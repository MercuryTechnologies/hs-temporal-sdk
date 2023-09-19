{- This file was auto-generated from temporal/sdk/core/workflow_activation/workflow_activation.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields where
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
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Workflow
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.Common.Common
arguments ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "arguments" a) =>
  Lens.Family2.LensLike' f s a
arguments = Data.ProtoLens.Field.field @"arguments"
attempt ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "attempt" a) =>
  Lens.Family2.LensLike' f s a
attempt = Data.ProtoLens.Field.field @"attempt"
availableInternalFlags ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "availableInternalFlags" a) =>
  Lens.Family2.LensLike' f s a
availableInternalFlags
  = Data.ProtoLens.Field.field @"availableInternalFlags"
cancelWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cancelWorkflow" a) =>
  Lens.Family2.LensLike' f s a
cancelWorkflow = Data.ProtoLens.Field.field @"cancelWorkflow"
cancelled ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cancelled" a) =>
  Lens.Family2.LensLike' f s a
cancelled = Data.ProtoLens.Field.field @"cancelled"
cause ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "cause" a) =>
  Lens.Family2.LensLike' f s a
cause = Data.ProtoLens.Field.field @"cause"
continueAsNewSuggested ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "continueAsNewSuggested" a) =>
  Lens.Family2.LensLike' f s a
continueAsNewSuggested
  = Data.ProtoLens.Field.field @"continueAsNewSuggested"
continuedFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "continuedFailure" a) =>
  Lens.Family2.LensLike' f s a
continuedFailure = Data.ProtoLens.Field.field @"continuedFailure"
continuedFromExecutionRunId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "continuedFromExecutionRunId" a) =>
  Lens.Family2.LensLike' f s a
continuedFromExecutionRunId
  = Data.ProtoLens.Field.field @"continuedFromExecutionRunId"
continuedInitiator ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "continuedInitiator" a) =>
  Lens.Family2.LensLike' f s a
continuedInitiator
  = Data.ProtoLens.Field.field @"continuedInitiator"
cronSchedule ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cronSchedule" a) =>
  Lens.Family2.LensLike' f s a
cronSchedule = Data.ProtoLens.Field.field @"cronSchedule"
cronScheduleToScheduleInterval ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cronScheduleToScheduleInterval" a) =>
  Lens.Family2.LensLike' f s a
cronScheduleToScheduleInterval
  = Data.ProtoLens.Field.field @"cronScheduleToScheduleInterval"
details ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "details" a) =>
  Lens.Family2.LensLike' f s a
details = Data.ProtoLens.Field.field @"details"
failed ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "failed" a) =>
  Lens.Family2.LensLike' f s a
failed = Data.ProtoLens.Field.field @"failed"
failure ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "failure" a) =>
  Lens.Family2.LensLike' f s a
failure = Data.ProtoLens.Field.field @"failure"
fireTimer ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "fireTimer" a) =>
  Lens.Family2.LensLike' f s a
fireTimer = Data.ProtoLens.Field.field @"fireTimer"
firstExecutionRunId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "firstExecutionRunId" a) =>
  Lens.Family2.LensLike' f s a
firstExecutionRunId
  = Data.ProtoLens.Field.field @"firstExecutionRunId"
headers ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "headers" a) =>
  Lens.Family2.LensLike' f s a
headers = Data.ProtoLens.Field.field @"headers"
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
identity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "identity" a) =>
  Lens.Family2.LensLike' f s a
identity = Data.ProtoLens.Field.field @"identity"
input ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "input" a) =>
  Lens.Family2.LensLike' f s a
input = Data.ProtoLens.Field.field @"input"
isReplaying ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isReplaying" a) =>
  Lens.Family2.LensLike' f s a
isReplaying = Data.ProtoLens.Field.field @"isReplaying"
jobs ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "jobs" a) =>
  Lens.Family2.LensLike' f s a
jobs = Data.ProtoLens.Field.field @"jobs"
key ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "key" a) =>
  Lens.Family2.LensLike' f s a
key = Data.ProtoLens.Field.field @"key"
lastCompletionResult ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastCompletionResult" a) =>
  Lens.Family2.LensLike' f s a
lastCompletionResult
  = Data.ProtoLens.Field.field @"lastCompletionResult"
maybe'cancelWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'cancelWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'cancelWorkflow
  = Data.ProtoLens.Field.field @"maybe'cancelWorkflow"
maybe'cancelled ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'cancelled" a) =>
  Lens.Family2.LensLike' f s a
maybe'cancelled = Data.ProtoLens.Field.field @"maybe'cancelled"
maybe'continuedFailure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'continuedFailure" a) =>
  Lens.Family2.LensLike' f s a
maybe'continuedFailure
  = Data.ProtoLens.Field.field @"maybe'continuedFailure"
maybe'cronScheduleToScheduleInterval ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'cronScheduleToScheduleInterval" a) =>
  Lens.Family2.LensLike' f s a
maybe'cronScheduleToScheduleInterval
  = Data.ProtoLens.Field.field
      @"maybe'cronScheduleToScheduleInterval"
maybe'failed ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'failed" a) =>
  Lens.Family2.LensLike' f s a
maybe'failed = Data.ProtoLens.Field.field @"maybe'failed"
maybe'failure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'failure" a) =>
  Lens.Family2.LensLike' f s a
maybe'failure = Data.ProtoLens.Field.field @"maybe'failure"
maybe'fireTimer ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'fireTimer" a) =>
  Lens.Family2.LensLike' f s a
maybe'fireTimer = Data.ProtoLens.Field.field @"maybe'fireTimer"
maybe'lastCompletionResult ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastCompletionResult" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastCompletionResult
  = Data.ProtoLens.Field.field @"maybe'lastCompletionResult"
maybe'memo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'memo" a) =>
  Lens.Family2.LensLike' f s a
maybe'memo = Data.ProtoLens.Field.field @"maybe'memo"
maybe'notifyHasPatch ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'notifyHasPatch" a) =>
  Lens.Family2.LensLike' f s a
maybe'notifyHasPatch
  = Data.ProtoLens.Field.field @"maybe'notifyHasPatch"
maybe'parentWorkflowInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'parentWorkflowInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'parentWorkflowInfo
  = Data.ProtoLens.Field.field @"maybe'parentWorkflowInfo"
maybe'queryWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'queryWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'queryWorkflow
  = Data.ProtoLens.Field.field @"maybe'queryWorkflow"
maybe'removeFromCache ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'removeFromCache" a) =>
  Lens.Family2.LensLike' f s a
maybe'removeFromCache
  = Data.ProtoLens.Field.field @"maybe'removeFromCache"
maybe'resolveActivity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'resolveActivity" a) =>
  Lens.Family2.LensLike' f s a
maybe'resolveActivity
  = Data.ProtoLens.Field.field @"maybe'resolveActivity"
maybe'resolveChildWorkflowExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'resolveChildWorkflowExecution" a) =>
  Lens.Family2.LensLike' f s a
maybe'resolveChildWorkflowExecution
  = Data.ProtoLens.Field.field @"maybe'resolveChildWorkflowExecution"
maybe'resolveChildWorkflowExecutionStart ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'resolveChildWorkflowExecutionStart" a) =>
  Lens.Family2.LensLike' f s a
maybe'resolveChildWorkflowExecutionStart
  = Data.ProtoLens.Field.field
      @"maybe'resolveChildWorkflowExecutionStart"
maybe'resolveRequestCancelExternalWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'resolveRequestCancelExternalWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'resolveRequestCancelExternalWorkflow
  = Data.ProtoLens.Field.field
      @"maybe'resolveRequestCancelExternalWorkflow"
maybe'resolveSignalExternalWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'resolveSignalExternalWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'resolveSignalExternalWorkflow
  = Data.ProtoLens.Field.field @"maybe'resolveSignalExternalWorkflow"
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
maybe'searchAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'searchAttributes" a) =>
  Lens.Family2.LensLike' f s a
maybe'searchAttributes
  = Data.ProtoLens.Field.field @"maybe'searchAttributes"
maybe'signalWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'signalWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'signalWorkflow
  = Data.ProtoLens.Field.field @"maybe'signalWorkflow"
maybe'startTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'startTime = Data.ProtoLens.Field.field @"maybe'startTime"
maybe'startWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startWorkflow" a) =>
  Lens.Family2.LensLike' f s a
maybe'startWorkflow
  = Data.ProtoLens.Field.field @"maybe'startWorkflow"
maybe'status ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'status" a) =>
  Lens.Family2.LensLike' f s a
maybe'status = Data.ProtoLens.Field.field @"maybe'status"
maybe'succeeded ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'succeeded" a) =>
  Lens.Family2.LensLike' f s a
maybe'succeeded = Data.ProtoLens.Field.field @"maybe'succeeded"
maybe'timestamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'timestamp" a) =>
  Lens.Family2.LensLike' f s a
maybe'timestamp = Data.ProtoLens.Field.field @"maybe'timestamp"
maybe'updateRandomSeed ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'updateRandomSeed" a) =>
  Lens.Family2.LensLike' f s a
maybe'updateRandomSeed
  = Data.ProtoLens.Field.field @"maybe'updateRandomSeed"
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
maybe'workflowExecutionExpirationTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowExecutionExpirationTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowExecutionExpirationTime
  = Data.ProtoLens.Field.field
      @"maybe'workflowExecutionExpirationTime"
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
memo ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "memo" a) =>
  Lens.Family2.LensLike' f s a
memo = Data.ProtoLens.Field.field @"memo"
message ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "message" a) =>
  Lens.Family2.LensLike' f s a
message = Data.ProtoLens.Field.field @"message"
notifyHasPatch ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "notifyHasPatch" a) =>
  Lens.Family2.LensLike' f s a
notifyHasPatch = Data.ProtoLens.Field.field @"notifyHasPatch"
parentWorkflowInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "parentWorkflowInfo" a) =>
  Lens.Family2.LensLike' f s a
parentWorkflowInfo
  = Data.ProtoLens.Field.field @"parentWorkflowInfo"
patchId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "patchId" a) =>
  Lens.Family2.LensLike' f s a
patchId = Data.ProtoLens.Field.field @"patchId"
queryId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "queryId" a) =>
  Lens.Family2.LensLike' f s a
queryId = Data.ProtoLens.Field.field @"queryId"
queryType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "queryType" a) =>
  Lens.Family2.LensLike' f s a
queryType = Data.ProtoLens.Field.field @"queryType"
queryWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "queryWorkflow" a) =>
  Lens.Family2.LensLike' f s a
queryWorkflow = Data.ProtoLens.Field.field @"queryWorkflow"
randomnessSeed ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "randomnessSeed" a) =>
  Lens.Family2.LensLike' f s a
randomnessSeed = Data.ProtoLens.Field.field @"randomnessSeed"
reason ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "reason" a) =>
  Lens.Family2.LensLike' f s a
reason = Data.ProtoLens.Field.field @"reason"
removeFromCache ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "removeFromCache" a) =>
  Lens.Family2.LensLike' f s a
removeFromCache = Data.ProtoLens.Field.field @"removeFromCache"
resolveActivity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resolveActivity" a) =>
  Lens.Family2.LensLike' f s a
resolveActivity = Data.ProtoLens.Field.field @"resolveActivity"
resolveChildWorkflowExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resolveChildWorkflowExecution" a) =>
  Lens.Family2.LensLike' f s a
resolveChildWorkflowExecution
  = Data.ProtoLens.Field.field @"resolveChildWorkflowExecution"
resolveChildWorkflowExecutionStart ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resolveChildWorkflowExecutionStart" a) =>
  Lens.Family2.LensLike' f s a
resolveChildWorkflowExecutionStart
  = Data.ProtoLens.Field.field @"resolveChildWorkflowExecutionStart"
resolveRequestCancelExternalWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resolveRequestCancelExternalWorkflow" a) =>
  Lens.Family2.LensLike' f s a
resolveRequestCancelExternalWorkflow
  = Data.ProtoLens.Field.field
      @"resolveRequestCancelExternalWorkflow"
resolveSignalExternalWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resolveSignalExternalWorkflow" a) =>
  Lens.Family2.LensLike' f s a
resolveSignalExternalWorkflow
  = Data.ProtoLens.Field.field @"resolveSignalExternalWorkflow"
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
runId ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "runId" a) =>
  Lens.Family2.LensLike' f s a
runId = Data.ProtoLens.Field.field @"runId"
searchAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "searchAttributes" a) =>
  Lens.Family2.LensLike' f s a
searchAttributes = Data.ProtoLens.Field.field @"searchAttributes"
seq ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "seq" a) =>
  Lens.Family2.LensLike' f s a
seq = Data.ProtoLens.Field.field @"seq"
signalName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signalName" a) =>
  Lens.Family2.LensLike' f s a
signalName = Data.ProtoLens.Field.field @"signalName"
signalWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signalWorkflow" a) =>
  Lens.Family2.LensLike' f s a
signalWorkflow = Data.ProtoLens.Field.field @"signalWorkflow"
startTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startTime" a) =>
  Lens.Family2.LensLike' f s a
startTime = Data.ProtoLens.Field.field @"startTime"
startWorkflow ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startWorkflow" a) =>
  Lens.Family2.LensLike' f s a
startWorkflow = Data.ProtoLens.Field.field @"startWorkflow"
succeeded ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "succeeded" a) =>
  Lens.Family2.LensLike' f s a
succeeded = Data.ProtoLens.Field.field @"succeeded"
timestamp ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "timestamp" a) =>
  Lens.Family2.LensLike' f s a
timestamp = Data.ProtoLens.Field.field @"timestamp"
updateRandomSeed ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "updateRandomSeed" a) =>
  Lens.Family2.LensLike' f s a
updateRandomSeed = Data.ProtoLens.Field.field @"updateRandomSeed"
value ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "value" a) =>
  Lens.Family2.LensLike' f s a
value = Data.ProtoLens.Field.field @"value"
vec'arguments ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'arguments" a) =>
  Lens.Family2.LensLike' f s a
vec'arguments = Data.ProtoLens.Field.field @"vec'arguments"
vec'availableInternalFlags ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'availableInternalFlags" a) =>
  Lens.Family2.LensLike' f s a
vec'availableInternalFlags
  = Data.ProtoLens.Field.field @"vec'availableInternalFlags"
vec'details ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'details" a) =>
  Lens.Family2.LensLike' f s a
vec'details = Data.ProtoLens.Field.field @"vec'details"
vec'input ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'input" a) =>
  Lens.Family2.LensLike' f s a
vec'input = Data.ProtoLens.Field.field @"vec'input"
vec'jobs ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'jobs" a) =>
  Lens.Family2.LensLike' f s a
vec'jobs = Data.ProtoLens.Field.field @"vec'jobs"
workflowExecutionExpirationTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowExecutionExpirationTime" a) =>
  Lens.Family2.LensLike' f s a
workflowExecutionExpirationTime
  = Data.ProtoLens.Field.field @"workflowExecutionExpirationTime"
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
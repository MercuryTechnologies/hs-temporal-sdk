{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Common where
import Control.Concurrent.Async hiding (cancel)
import qualified Control.Concurrent.Async as Async
import Control.Concurrent.MVar
import Control.Concurrent.STM
import Control.Exception
import Control.Monad
import Control.Monad.IO.Class
import Data.Hashable (Hashable)
import Data.Text (Text)
import Data.Int (Int32)
import Data.ProtoLens
import Data.String
import Data.Vector (Vector)
import Lens.Family2
import qualified Proto.Google.Protobuf.Duration as Duration
import qualified Proto.Google.Protobuf.Duration_Fields as Duration
import qualified Proto.Google.Protobuf.Timestamp as Timestamp
import qualified Proto.Google.Protobuf.Timestamp_Fields as Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Api.Enums.V1.Workflow as Workflow
import qualified System.Clock as Clock

-- | This is generally the name of the function itself
newtype WorkflowType = WorkflowType { rawWorkflowType :: Text }
  deriving (Eq, Ord, Show, Hashable, IsString)
newtype WorkflowId = WorkflowId { rawWorkflowId :: Text }
  deriving (Eq, Ord, Show, Hashable, IsString)
newtype Namespace = Namespace { rawNamespace :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype RunId = RunId { rawRunId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype PatchId = PatchId { rawPatchId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype TaskQueue = TaskQueue { rawTaskQueue :: Text }
  deriving (Eq, Ord, Show, Hashable)
-- | Unique identifier for an activity within a workflow.
newtype ActivityId = ActivityId { rawActivityId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype SignalId = SignalId { rawSignalId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype TimerId = TimerId { rawTimerId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype CancellationId = CancellationId { rawCancellationId :: Text }
  deriving (Eq, Ord, Show, Hashable)

timespecFromDuration :: Duration.Duration -> Clock.TimeSpec
timespecFromDuration d = Clock.TimeSpec
  { Clock.sec = d ^. Duration.seconds
  , Clock.nsec = fromIntegral (d ^. Duration.nanos)
  }

timespecToDuration :: Clock.TimeSpec -> Duration.Duration
timespecToDuration ts = defMessage
  & Duration.seconds .~ Clock.sec ts
  & Duration.nanos .~ fromIntegral (Clock.nsec ts)

timespecFromTimestamp :: Timestamp.Timestamp -> Clock.TimeSpec
timespecFromTimestamp ts = Clock.TimeSpec
  { Clock.sec = ts ^. Timestamp.seconds
  , Clock.nsec = fromIntegral (ts ^. Timestamp.nanos)
  }

timespecToTimestamp :: Clock.TimeSpec -> Timestamp.Timestamp
timespecToTimestamp ts = defMessage
  & Timestamp.seconds .~ Clock.sec ts
  & Timestamp.nanos .~ fromIntegral (Clock.nsec ts)

data RetryPolicy = RetryPolicy
  { initialInterval :: Clock.TimeSpec
  , backoffCoefficient :: Double
  , maximumInterval :: Maybe Clock.TimeSpec
  , maximumAttempts :: Int32
  , nonRetryableErrorTypes :: Vector Text
  }

retryPolicyToProto :: RetryPolicy -> Message.RetryPolicy
retryPolicyToProto (RetryPolicy initialInterval backoffCoefficient maximumInterval maximumAttempts nonRetryableErrorTypes) = 
  -- Using a full destructure here to make sure we don't miss any new fields later. ^
  defMessage
    & Message.initialInterval .~ timespecToDuration initialInterval
    & Message.backoffCoefficient .~ backoffCoefficient
    & Message.maybe'maximumInterval .~ fmap timespecToDuration maximumInterval
    & Message.maximumAttempts .~ maximumAttempts
    & Message.vec'nonRetryableErrorTypes .~ nonRetryableErrorTypes

retryPolicyFromProto :: Message.RetryPolicy -> RetryPolicy
retryPolicyFromProto p = RetryPolicy
  { initialInterval = timespecFromDuration (p ^. Message.initialInterval)
  , backoffCoefficient = p ^. Message.backoffCoefficient
  , maximumInterval = fmap timespecFromDuration (p ^. Message.maybe'maximumInterval)
  , maximumAttempts = p ^. Message.maximumAttempts
  , nonRetryableErrorTypes = p ^. Message.vec'nonRetryableErrorTypes
  }

data WorkflowIdReusePolicy
  = WorkflowIdReusePolicyUnspecified
  | WorkflowIdReusePolicyAllowDuplicate
  | WorkflowIdReusePolicyAllowDuplicateFailedOnly
  | WorkflowIdReusePolicyRejectDuplicate
  | WorkflowIdReusePolicyTerminateIfRunning
  deriving (Eq, Ord, Show, Enum, Bounded)

workflowIdReusePolicyToProto :: WorkflowIdReusePolicy -> Workflow.WorkflowIdReusePolicy
workflowIdReusePolicyToProto = \case
  WorkflowIdReusePolicyUnspecified -> Workflow.WORKFLOW_ID_REUSE_POLICY_UNSPECIFIED
  WorkflowIdReusePolicyAllowDuplicate -> Workflow.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE
  WorkflowIdReusePolicyAllowDuplicateFailedOnly -> Workflow.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE_FAILED_ONLY
  WorkflowIdReusePolicyRejectDuplicate -> Workflow.WORKFLOW_ID_REUSE_POLICY_REJECT_DUPLICATE
  WorkflowIdReusePolicyTerminateIfRunning -> Workflow.WORKFLOW_ID_REUSE_POLICY_TERMINATE_IF_RUNNING

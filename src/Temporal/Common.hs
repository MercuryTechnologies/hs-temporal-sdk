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
import Data.ByteString (ByteString)
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

-- | A Workflow Id is a customizable, application-level identifier for a Workflow Execution that is unique to an Open Workflow Execution within a Namespace.
newtype WorkflowId = WorkflowId { rawWorkflowId :: Text }
  deriving (Eq, Ord, Show, Hashable, IsString)

-- | A Namespace is a unit of isolation within the Temporal Platform
newtype Namespace = Namespace { rawNamespace :: Text }
  deriving (Eq, Ord, Show, Hashable)

-- | A Run Id is a globally unique, platform-level identifier for a Workflow Execution.
newtype RunId = RunId { rawRunId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype PatchId = PatchId { rawPatchId :: Text }
  deriving (Eq, Ord, Show, Hashable)

-- | A Task Queue is a first-in, first-out queue that a Worker Process polls for Tasks.
newtype TaskQueue = TaskQueue { rawTaskQueue :: Text }
  deriving (Eq, Ord, Show, Hashable)

-- | A unique identifier for an Activity Execution.
newtype ActivityId = ActivityId { rawActivityId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype ScheduleId = ScheduleId { rawScheduleId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype SignalId = SignalId { rawSignalId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype TimerId = TimerId { rawTimerId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype CancellationId = CancellationId { rawCancellationId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype QueryId = QueryId { rawQueryId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype TaskToken = TaskToken { rawTaskToken :: ByteString }
  deriving (Eq, Show, Ord, Hashable)

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

-- | A Retry Policy is a collection of attributes that instructs the Temporal Server how to retry a failure of a Workflow Execution or an Activity Task Execution.
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

{- | A Workflow Id Reuse Policy determines whether a Workflow Execution is allowed to spawn with a particular Workflow Id, 
if that Workflow Id has been used with a previous, and now Closed, Workflow Execution.

It is not possible for a new Workflow Execution to spawn with the same Workflow Id as another Open Workflow Execution, 
regardless of the Workflow Id Reuse Policy. In some cases, an attempt to spawn a Workflow Execution with a Workflow Id
that is the same as the Id of a currently Open Workflow Execution results in a Workflow execution already started error.
-}
data WorkflowIdReusePolicy
  = WorkflowIdReusePolicyUnspecified
  | WorkflowIdReusePolicyAllowDuplicate
  -- ^ The Workflow Execution is allowed to exist regardless of the Closed status of a previous Workflow Execution with 
  -- the same Workflow Id. This is currently the default policy, if one is not specified. 
  -- Use this when it is OK to have a Workflow Execution with the same Workflow Id as a previous, 
  -- but now Closed, Workflow Execution.
  | WorkflowIdReusePolicyAllowDuplicateFailedOnly
  -- ^ The Workflow Execution is allowed to exist only if a previous Workflow Execution with the same Workflow Id does not 
  -- have a Completed status. Use this policy when there is a need to re-execute a Failed, Timed Out, Terminated or 
  -- Cancelled Workflow Execution and guarantee that the Completed Workflow Execution will not be re-executed.
  | WorkflowIdReusePolicyRejectDuplicate
  -- ^ The Workflow Execution cannot exist if a previous Workflow Execution has the same Workflow Id, regardless of the 
  -- Closed status. Use this when there can only be one Workflow Execution per Workflow Id within a Namespace for 
  -- the given retention period.
  | WorkflowIdReusePolicyTerminateIfRunning
  -- ^ Specifies that if a Workflow Execution with the same Workflow Id is already running, 
  -- it should be terminated and a new Workflow Execution with the same Workflow Id should be started. 
  -- This policy allows for only one Workflow Execution with a specific Workflow Id to be running at any given time.
  deriving (Eq, Ord, Show, Enum, Bounded)

workflowIdReusePolicyToProto :: WorkflowIdReusePolicy -> Workflow.WorkflowIdReusePolicy
workflowIdReusePolicyToProto = \case
  WorkflowIdReusePolicyUnspecified -> Workflow.WORKFLOW_ID_REUSE_POLICY_UNSPECIFIED
  WorkflowIdReusePolicyAllowDuplicate -> Workflow.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE
  WorkflowIdReusePolicyAllowDuplicateFailedOnly -> Workflow.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE_FAILED_ONLY
  WorkflowIdReusePolicyRejectDuplicate -> Workflow.WORKFLOW_ID_REUSE_POLICY_REJECT_DUPLICATE
  WorkflowIdReusePolicyTerminateIfRunning -> Workflow.WORKFLOW_ID_REUSE_POLICY_TERMINATE_IF_RUNNING

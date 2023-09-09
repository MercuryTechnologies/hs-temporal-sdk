{-# LANGUAGE DuplicateRecordFields #-}
module Temporal.Workflow.Types where

import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Word (Word32)
import Data.Time.Clock.System (SystemTime)
import Temporal.Common
import Temporal.Duration
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.Common.TimeoutType
import Data.Vector (Vector)
import Temporal.Activity.Types
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow

data Info = Info
  { historyLength :: {-# UNPACK #-} !Word32
  , attempt :: {-# UNPACK #-} !Int
  , continuedRunId :: Maybe RunId
  , cronSchedule :: Maybe Text
  , executionTimeout :: Maybe Duration
  , headers :: Map Text RawPayload
  , namespace :: Namespace
  , parent :: Maybe ParentInfo
  , rawMemo :: Map Text RawPayload
  , retryPolicy :: Maybe RetryPolicy
  , runId :: RunId
  , runTimeout :: Maybe Duration
  , searchAttributes :: Map Text SearchAttributeType
  , startTime :: SystemTime
  , taskQueue :: TaskQueue
  , taskTimeout :: Duration
  , workflowId :: WorkflowId
  , workflowType :: WorkflowType
  }

data StartActivityOptions = StartActivityOptions
  { activityId :: Maybe ActivityId
  , taskQueue :: Maybe TaskQueue
  , timeout :: TimeoutType
  , scheduleToStartTimeout :: Maybe Duration
  , heartbeatTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , cancellationType :: ActivityCancellationType
  , headers :: Map Text RawPayload -- TODO payloads
  , disableEagerExecution :: Bool
  }

defaultStartActivityOptions :: TimeoutType -> StartActivityOptions
defaultStartActivityOptions t = StartActivityOptions
  { activityId = Nothing
  , taskQueue = Nothing
  , timeout = t
  , scheduleToStartTimeout = Nothing
  , heartbeatTimeout = Nothing
  , retryPolicy = Nothing
  , cancellationType = ActivityCancellationTryCancel
  , headers = mempty
  , disableEagerExecution = False
  }

-- TODO default to WaitCancellationCompleted per protobuf docs
{- |
Defines how the workflow will wait (or not) for cancellation of the 
activity to be confirmed.
-}
data ActivityCancellationType 
  = ActivityCancellationTryCancel 
  -- ^ Initiate a cancellation request and immediately report cancellation to the workflow.
  | ActivityCancellationWaitCancellationCompleted 
  -- ^ Wait for activity cancellation completion. Note that activity must heartbeat to receive a
  -- cancellation notification. This can block the cancellation for a long time if activity
  -- doesn't heartbeat or chooses to ignore the cancellation request.
  | ActivityCancellationAbandon
  -- ^ Do not request cancellation of the activity and immediately report cancellation to the
  -- workflow

data ExecuteActivityInput = ExecuteActivityInput
  { activityArgs :: Vector RawPayload
  , activityHeaders :: Map Text RawPayload
  , activityInfo :: ActivityInfo
  }

-- | Controls at which point to report back when a child workflow is cancelled.
data ChildWorkflowCancellationType 
  = ChildWorkflowCancellationAbandon 
  -- ^  Do not request cancellation of the child workflow if already scheduled
  | ChildWorkflowCancellationTryCancel 
  -- ^ Initiate a cancellation request and immediately report cancellation to the parent workflow
  | ChildWorkflowCancellationWaitCancellationCompleted 
  -- ^ Wait for child cancellation completion.
  | ChildWorkflowCancellationWaitCancellationRequested
  -- ^ Request cancellation of the child and wait for confirmation that the request was received.

childWorkflowCancellationTypeToProto :: ChildWorkflowCancellationType -> ChildWorkflow.ChildWorkflowCancellationType
childWorkflowCancellationTypeToProto ChildWorkflowCancellationAbandon = ChildWorkflow.ABANDON
childWorkflowCancellationTypeToProto ChildWorkflowCancellationTryCancel = ChildWorkflow.TRY_CANCEL
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationCompleted = ChildWorkflow.WAIT_CANCELLATION_COMPLETED
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationRequested = ChildWorkflow.WAIT_CANCELLATION_REQUESTED

-- | Used by the service to determine the fate of a child workflow
-- in case its parent is closed.
data ParentClosePolicy 
  = ParentClosePolicyUnspecified 
  -- ^ Lets the server set the default.
  | ParentClosePolicyTerminate 
  -- ^ Terminate the child workflow.
  | ParentClosePolicyAbandon 
  -- ^ Do not terminate the child workflow. The child workflow continues to run.
  | ParentClosePolicyRequestCancel
  -- ^ Request cancellation on the child workflow.

parentClosePolicyToProto :: ParentClosePolicy -> ChildWorkflow.ParentClosePolicy
parentClosePolicyToProto ParentClosePolicyUnspecified = ChildWorkflow.PARENT_CLOSE_POLICY_UNSPECIFIED
parentClosePolicyToProto ParentClosePolicyTerminate = ChildWorkflow.PARENT_CLOSE_POLICY_TERMINATE
parentClosePolicyToProto ParentClosePolicyAbandon = ChildWorkflow.PARENT_CLOSE_POLICY_ABANDON
parentClosePolicyToProto ParentClosePolicyRequestCancel = ChildWorkflow.PARENT_CLOSE_POLICY_REQUEST_CANCEL

data StartChildWorkflowOptions = StartChildWorkflowOptions 
  { cancellationType :: ChildWorkflowCancellationType
  , parentClosePolicy :: ParentClosePolicy
  , executionTimeout :: Maybe Duration
  , runTimeout :: Maybe Duration
  , taskTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , cronSchedule :: Maybe Text
  , initialMemo :: Map Text RawPayload
  , searchAttributes :: Map Text SearchAttributeType 
  , headers :: Map Text RawPayload
  , workflowIdReusePolicy :: WorkflowIdReusePolicy
  }

defaultChildWorkflowOptions :: StartChildWorkflowOptions
defaultChildWorkflowOptions = StartChildWorkflowOptions
  { cancellationType = ChildWorkflowCancellationAbandon
  , parentClosePolicy = ParentClosePolicyUnspecified
  , executionTimeout = Nothing
  , runTimeout = Nothing
  , taskTimeout = Nothing
  , retryPolicy = Nothing
  , cronSchedule = Nothing
  , initialMemo = mempty
  , searchAttributes = mempty
  , headers = mempty
  , workflowIdReusePolicy = WorkflowIdReusePolicyUnspecified
  }

data ContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue :: Maybe TaskQueue
  , runTimeout :: Maybe Duration
  , taskTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , memo :: Map Text RawPayload
  , searchAttributes :: Map Text SearchAttributeType
  , headers :: Map Text RawPayload
  }

defaultContinueAsNewOptions :: ContinueAsNewOptions
defaultContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue = Nothing
  , runTimeout = Nothing
  , taskTimeout = Nothing
  , retryPolicy = Nothing
  , memo = mempty
  , searchAttributes = mempty
  , headers = mempty
  }

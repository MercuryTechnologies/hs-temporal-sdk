{-# LANGUAGE DuplicateRecordFields #-}

module Temporal.Workflow.Types where

import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.These
import Data.Time.Clock.System (SystemTime)
import Data.Vector (Vector)
import Data.Word (Word32)
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import Temporal.Activity.Types
import Temporal.Common
import Temporal.Common.TimeoutType
import Temporal.Duration
import Temporal.Payload
import Temporal.SearchAttributes


data Info = Info
  { historyLength :: {-# UNPACK #-} !Word32
  , attempt :: {-# UNPACK #-} !Int
  , continuedRunId :: !(Maybe RunId)
  , cronSchedule :: !(Maybe Text)
  , executionTimeout :: !(Maybe Duration)
  , headers :: !(Map Text Payload)
  , namespace :: !Namespace
  , parent :: !(Maybe ParentInfo)
  , rawMemo :: !(Map Text Payload)
  , retryPolicy :: !(Maybe RetryPolicy)
  , runId :: !RunId
  , runTimeout :: !(Maybe Duration)
  , searchAttributes :: !(Map Text SearchAttributeType)
  , startTime :: !SystemTime
  , taskQueue :: !TaskQueue
  , taskTimeout :: !Duration
  , workflowId :: !WorkflowId
  , workflowType :: !WorkflowType
  , continueAsNewSuggested :: !Bool
  }


data StartActivityOptions = StartActivityOptions
  { activityId :: Maybe ActivityId
  -- ^ The identifier for an Activity Execution. The identifier can be generated by the system, or it can be provided by the Workflow code that spawns the Activity Execution. The identifier is unique among the open Activity Executions of a Workflow Run. (A single Workflow Run may reuse an Activity Id if an earlier Activity Execution with the same Id has closed.)
  --
  -- An Activity Id can be used to complete the Activity asynchronously.
  , taskQueue :: Maybe TaskQueue
  , timeout :: These StartToClose ScheduleToClose
  , scheduleToStartTimeout :: Maybe Duration
  -- ^ A Schedule-To-Start Timeout is the maximum amount of time that is allowed from when an Activity Task is scheduled (that is, placed in a Task Queue) to when a Worker starts (that is, picks up from the Task Queue) that Activity Task. In other words, it's a limit for how long an Activity Task can be enqueued.
  , heartbeatTimeout :: Maybe Duration
  -- ^ A Heartbeat Timeout is the maximum time between Activity Heartbeats. If this timeout is reached, the Activity Task fails and a retry occurs if a Retry Policy dictates it.
  , retryPolicy :: Maybe RetryPolicy
  -- ^ A Retry Policy works in cooperation with the timeouts to provide fine controls to optimize the execution experience.
  --
  -- A Retry Policy is a collection of attributes that instructs the Temporal Server how to retry a failure of a Workflow Execution or an Activity Task Execution. (Retry Policies do not apply to Workflow Task Executions, which always retry indefinitely.)
  , cancellationType :: ActivityCancellationType
  , headers :: Map Text Payload
  , disableEagerExecution :: Bool
  -- ^ If true, will disable eager activity execution. Eager activity execution is an optimization on some servers that sends activities back to the same worker as the calling workflow if they can run there. This setting is experimental and may be removed in a future release.
  }


class StartActivityTimeoutOption a where
  toStartActivityTimeoutOption :: a -> These StartToClose ScheduleToClose


instance StartActivityTimeoutOption (These StartToClose ScheduleToClose) where
  toStartActivityTimeoutOption = id


instance StartActivityTimeoutOption StartToClose where
  toStartActivityTimeoutOption = This


instance StartActivityTimeoutOption ScheduleToClose where
  toStartActivityTimeoutOption = That


instance StartActivityTimeoutOption (StartToClose, ScheduleToClose) where
  toStartActivityTimeoutOption (s, sc) = These s sc


instance StartActivityTimeoutOption (ScheduleToClose, StartToClose) where
  toStartActivityTimeoutOption (sc, s) = These s sc


instance StartActivityTimeoutOption (Either StartToClose ScheduleToClose) where
  toStartActivityTimeoutOption = either This That


defaultStartActivityOptions :: StartActivityTimeoutOption timeout => timeout -> StartActivityOptions
defaultStartActivityOptions t =
  StartActivityOptions
    { activityId = Nothing
    , taskQueue = Nothing
    , timeout = toStartActivityTimeoutOption t
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
  = -- | Initiate a cancellation request and immediately report cancellation to the workflow.
    ActivityCancellationTryCancel
  | -- | Wait for activity cancellation completion. Note that activity must heartbeat to receive a
    -- cancellation notification. This can block the cancellation for a long time if activity
    -- doesn't heartbeat or chooses to ignore the cancellation request.
    ActivityCancellationWaitCancellationCompleted
  | -- | Do not request cancellation of the activity and immediately report cancellation to the
    -- workflow
    ActivityCancellationAbandon


data ExecuteActivityInput = ExecuteActivityInput
  { activityArgs :: Vector Payload
  , activityHeaders :: Map Text Payload
  , activityInfo :: ActivityInfo
  }


-- | Controls at which point to report back when a child workflow is cancelled.
data ChildWorkflowCancellationType
  = -- |  Do not request cancellation of the child workflow if already scheduled
    ChildWorkflowCancellationAbandon
  | -- | Initiate a cancellation request and immediately report cancellation to the parent workflow
    ChildWorkflowCancellationTryCancel
  | -- | Wait for child cancellation completion.
    ChildWorkflowCancellationWaitCancellationCompleted
  | -- | Request cancellation of the child and wait for confirmation that the request was received.
    ChildWorkflowCancellationWaitCancellationRequested


childWorkflowCancellationTypeToProto :: ChildWorkflowCancellationType -> ChildWorkflow.ChildWorkflowCancellationType
childWorkflowCancellationTypeToProto ChildWorkflowCancellationAbandon = ChildWorkflow.ABANDON
childWorkflowCancellationTypeToProto ChildWorkflowCancellationTryCancel = ChildWorkflow.TRY_CANCEL
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationCompleted = ChildWorkflow.WAIT_CANCELLATION_COMPLETED
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationRequested = ChildWorkflow.WAIT_CANCELLATION_REQUESTED


{- | Used by the service to determine the fate of a child workflow
in case its parent is closed.
-}
data ParentClosePolicy
  = -- | Lets the server set the default.
    ParentClosePolicyUnspecified
  | -- | Terminate the child workflow.
    ParentClosePolicyTerminate
  | -- | Do not terminate the child workflow. The child workflow continues to run.
    ParentClosePolicyAbandon
  | -- | Request cancellation on the child workflow.
    ParentClosePolicyRequestCancel


parentClosePolicyToProto :: ParentClosePolicy -> ChildWorkflow.ParentClosePolicy
parentClosePolicyToProto ParentClosePolicyUnspecified = ChildWorkflow.PARENT_CLOSE_POLICY_UNSPECIFIED
parentClosePolicyToProto ParentClosePolicyTerminate = ChildWorkflow.PARENT_CLOSE_POLICY_TERMINATE
parentClosePolicyToProto ParentClosePolicyAbandon = ChildWorkflow.PARENT_CLOSE_POLICY_ABANDON
parentClosePolicyToProto ParentClosePolicyRequestCancel = ChildWorkflow.PARENT_CLOSE_POLICY_REQUEST_CANCEL


data StartChildWorkflowOptions = StartChildWorkflowOptions
  { cancellationType :: ChildWorkflowCancellationType
  , parentClosePolicy :: ParentClosePolicy
  , timeoutOptions :: TimeoutOptions
  , retryPolicy :: Maybe RetryPolicy
  , cronSchedule :: Maybe Text
  , initialMemo :: Map Text Payload
  , searchAttributes :: Map Text SearchAttributeType
  , headers :: Map Text Payload
  , workflowIdReusePolicy :: WorkflowIdReusePolicy
  , workflowId :: Maybe WorkflowId
  , taskQueue :: Maybe TaskQueue
  }


defaultChildWorkflowOptions :: StartChildWorkflowOptions
defaultChildWorkflowOptions =
  StartChildWorkflowOptions
    { cancellationType = ChildWorkflowCancellationAbandon
    , parentClosePolicy = ParentClosePolicyUnspecified
    , timeoutOptions =
        TimeoutOptions
          { executionTimeout = Nothing
          , runTimeout = Nothing
          , taskTimeout = Nothing
          }
    , retryPolicy = Nothing
    , cronSchedule = Nothing
    , initialMemo = mempty
    , searchAttributes = mempty
    , headers = mempty
    , workflowIdReusePolicy = WorkflowIdReusePolicyUnspecified
    , workflowId = Nothing
    , taskQueue = Nothing
    }


data ContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue :: Maybe TaskQueue
  , runTimeout :: Maybe Duration
  , taskTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , memo :: Map Text Payload
  , searchAttributes :: Map Text SearchAttributeType
  , headers :: Map Text Payload
  }
  deriving stock (Show)


defaultContinueAsNewOptions :: ContinueAsNewOptions
defaultContinueAsNewOptions =
  ContinueAsNewOptions
    { taskQueue = Nothing
    , runTimeout = Nothing
    , taskTimeout = Nothing
    , retryPolicy = Nothing
    , memo = mempty
    , searchAttributes = mempty
    , headers = mempty
    }

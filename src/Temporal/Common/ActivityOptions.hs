{-# language DuplicateRecordFields #-}
module Temporal.Common.ActivityOptions where
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import Data.Vector (Vector)
import Data.Word
import Temporal.Common
import Temporal.Common.TimeoutType
import Temporal.Duration
import Temporal.Payload

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

data ActivityInfo = ActivityInfo
  { workflowNamespace :: Namespace
  , workflowType :: WorkflowType
  , workflowId :: WorkflowId
  , runId :: RunId
  , activityId :: ActivityId
  , activityType :: Text
  , headerFields :: Map Text RawPayload
  -- input
  , heartbeatDetails :: Vector RawPayload
  , scheduledTime :: SystemTime
  , currentAttemptScheduledTime :: SystemTime
  , startedTime :: SystemTime
  , attempt :: Word32
  -- TODO, are we in charge of honoring these timeouts?
  -- Or does the server send cancel requests if we don't?
  , scheduleToCloseTimeout :: Maybe Duration
  , startToCloseTimeout :: Maybe Duration
  , heartbeatTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , isLocal :: Bool
  , taskToken :: TaskToken
  }
module Temporal.Common.ActivityOptions where
import Temporal.Common
import Temporal.Common.TimeoutType
import Temporal.Duration
import Data.Map.Strict (Map)
import Temporal.Payload
import Data.Text (Text)

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

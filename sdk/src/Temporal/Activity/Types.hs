module Temporal.Activity.Types where

import Data.Map (Map)
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import Data.Vector (Vector)
import Data.Word (Word32)
import Temporal.Common
import Temporal.Duration
import Temporal.Payload


{- | 'ActivityInfo' provides information about the currently executing activity.

It can be used for logging, introspection, etc.
-}
data ActivityInfo = ActivityInfo
  { workflowNamespace :: Namespace
  , workflowType :: WorkflowType
  , workflowId :: WorkflowId
  , runId :: RunId
  , activityId :: ActivityId
  , activityType :: Text
  , headerFields :: Map Text Payload
  , -- input
    heartbeatDetails :: Vector Payload
  , scheduledTime :: SystemTime
  , currentAttemptScheduledTime :: SystemTime
  , startedTime :: SystemTime
  , attempt :: Word32
  , -- TODO, are we in charge of honoring these timeouts?
    -- Or does the server send cancel requests if we don't?
    scheduleToCloseTimeout :: Maybe Duration
  , startToCloseTimeout :: Maybe Duration
  , heartbeatTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , isLocal :: Bool
  , taskToken :: TaskToken
  }
  deriving stock (Show, Eq)

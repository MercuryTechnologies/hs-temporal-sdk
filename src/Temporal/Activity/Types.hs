module Temporal.Activity.Types where
import Data.Text (Text)
import Data.Word (Word32)
import Temporal.Common
import Temporal.Payload
import Data.Map (Map)
import Data.Vector (Vector)
import Data.Time.Clock.System (SystemTime)
import Temporal.Duration

data ActivityInfo = ActivityInfo
  { workflowNamespace :: Namespace
  , workflowType :: WorkflowType
  , workflowId :: WorkflowId
  , runId :: RunId
  , activityId :: ActivityId
  , activityType :: Text
  , headerFields :: Map Text Payload
  -- input
  , heartbeatDetails :: Vector Payload
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

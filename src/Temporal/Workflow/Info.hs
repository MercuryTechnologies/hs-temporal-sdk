module Temporal.Workflow.Info where
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Word (Word32)
import Data.Time.Clock.System (SystemTime)
import Temporal.Common
import Temporal.Common.ActivityOptions
import Temporal.Duration
import Temporal.Payload
import Temporal.SearchAttributes

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

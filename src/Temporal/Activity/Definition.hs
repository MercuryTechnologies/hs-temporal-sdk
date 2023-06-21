module Temporal.Activity.Definition where
import Control.Monad.Reader
import Data.ByteString (ByteString)
import Data.Hashable (Hashable(..))
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Vector (Vector)
import Data.Word (Word32)
import Temporal.Common
import Temporal.Payload
import Temporal.Core.Worker (Worker)
import System.Clock (TimeSpec(..))
import UnliftIO

-- | An activity is a unit of work that is executed by a worker. It is a specialized function call
-- that can be executed one or more times, and can be cancelled while it is running.
newtype Activity env a = Activity { unActivity :: ReaderT (Worker, ActivityInfo, env) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadUnliftIO)

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
  , scheduledTime :: TimeSpec
  , currentAttemptScheduledTime :: TimeSpec
  , startedTime :: TimeSpec
  , attempt :: Word32
  -- TODO, are we in charge of honoring these timeouts?
  -- Or does the server send cancel requests if we don't?
  , scheduleToCloseTimeout :: Maybe TimeSpec
  , startToCloseTimeout :: Maybe TimeSpec
  , heartbeatTimeout :: Maybe TimeSpec
  , retryPolicy :: Maybe RetryPolicy
  , isLocal :: Bool
  , taskToken :: TaskToken
  }

askActivityInfo :: Activity env ActivityInfo
askActivityInfo = Activity $ asks (\(_, info, _) -> info)

askActivityWorker :: Activity env Worker
askActivityWorker = Activity $ asks (\(worker, _, _) -> worker)

instance MonadReader env (Activity env) where
  ask = Activity $ asks (\(_, _, x) -> x)
  local f (Activity m) = Activity $ local (\(w, info, x) -> (w, info, f x)) m

newtype TaskToken = TaskToken { rawTaskToken :: ByteString }
  deriving (Eq, Show, Ord, Hashable)
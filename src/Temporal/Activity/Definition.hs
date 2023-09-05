module Temporal.Activity.Definition where
import Control.Applicative
import Control.Monad.Catch
import Control.Monad
import Control.Monad.Error.Class
import Control.Monad.Fix
import Control.Monad.Reader
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Vector (Vector)
import Data.Word (Word32)
import Temporal.Common
import Temporal.Payload
import Temporal.Core.Client (Client)
import Temporal.Core.Worker (Worker, getWorkerClient)
import UnliftIO
import Data.Time.Clock.System (SystemTime)
import Temporal.Duration (Duration)

data ActivityEnv env = ActivityEnv
  { activityWorker :: Worker
  , activityInfo :: ActivityInfo
  , activityEnv :: env
  }

-- | An activity is a unit of work that is executed by a worker. It is a specialized function call
-- that can be executed one or more times, and can be cancelled while it is running.
newtype Activity env a = Activity { unActivity :: ReaderT (ActivityEnv env) IO a }
  deriving 
    ( Functor
    , Applicative
    , Alternative
    , Monad
    , MonadFail
    , MonadFix
    , MonadError IOException
    , MonadIO
    , MonadPlus
    , MonadUnliftIO
    , MonadThrow
    , MonadCatch
    , MonadMask
    )

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

askActivityInfo :: Activity env ActivityInfo
askActivityInfo = Activity $ asks (.activityInfo)

askActivityWorker :: Activity env Worker
askActivityWorker = Activity $ asks (.activityWorker)

askActivityClient :: Activity env Client
askActivityClient = Activity $ asks (getWorkerClient . (.activityWorker))

instance MonadReader env (Activity env) where
  ask = Activity $ asks (.activityEnv)
  local f (Activity m) = Activity $ local (\a -> a { activityEnv = f $ activityEnv a }) m

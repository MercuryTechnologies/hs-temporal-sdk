module Temporal.Activity.Definition where
import Control.Applicative
import Control.Monad.Error.Class
import Control.Monad.Reader
import Data.ByteString (ByteString)
import Data.Hashable (Hashable(..))
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Vector (Vector)
import Data.Word (Word32)
import Temporal.Common
import Temporal.Payload
import Temporal.Core.Client (Client)
import Temporal.Core.Worker (Worker, getWorkerClient)
import System.Clock (TimeSpec(..))
import UnliftIO

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
askActivityInfo = Activity $ asks (.activityInfo)

askActivityWorker :: Activity env Worker
askActivityWorker = Activity $ asks (.activityWorker)

askActivityClient :: Activity env Client
askActivityClient = Activity $ asks (getWorkerClient . (.activityWorker))

instance MonadReader env (Activity env) where
  ask = Activity $ asks (.activityEnv)
  local f (Activity m) = Activity $ local (\a -> a { activityEnv = f $ activityEnv a }) m

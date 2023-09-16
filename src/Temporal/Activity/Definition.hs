module Temporal.Activity.Definition where
import Control.Applicative
import Control.Monad.Catch
import Control.Monad
import Control.Monad.Error.Class
import Control.Monad.Fix
import Control.Monad.Reader
import Data.Kind
import Data.Text (Text)
import Data.Vector (Vector)
import Temporal.Payload
import Temporal.Core.Client (Client)
import Temporal.Core.Worker (Worker, getWorkerClient, WorkerType(Real))
import UnliftIO
import Temporal.Activity.Types
import Temporal.Workflow.Types
import Temporal.Client.Types

data ValidActivityFunction env = forall codec f. 
  ( f ~ (ArgsOf f :->: Activity env (ResultOf (Activity env) f))
  , FunctionSupportsCodec codec (ArgsOf f) (ResultOf (Activity env) f)
  ) => 
  ValidActivityFunction 
    codec 
    f
    (f -> Vector Payload -> IO (Either String (Activity env (ResultOf (Activity env) f))))

class HasActivityDefinition a where
  type ActivityDefinitionEnv a :: Type
  activityDefinition :: a -> ActivityDefinition (ActivityDefinitionEnv a)

instance HasActivityDefinition (ActivityDefinition env) where
  type ActivityDefinitionEnv (ActivityDefinition env) = env
  activityDefinition = id

data ActivityDefinition env = ActivityDefinition
  { activityName :: Text
  , activityRun :: ActivityEnv env -> ExecuteActivityInput -> IO (Either String Payload)
  }

data ActivityEnv env = ActivityEnv
  { activityWorker :: Worker 'Real
  , activityInfo :: ActivityInfo
  , activityClientInterceptors :: ClientInterceptors
  , activityEnv :: env
  }

-- | An activity is a unit of work that is executed by a worker. It is a specialized function call
-- that can be executed one or more times, and can be cancelled while it is running.
newtype Activity env a = Activity { unActivity :: ReaderT (ActivityEnv env) IO a }
  deriving newtype
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

runActivity :: ActivityEnv env -> Activity env a -> IO a
runActivity env (Activity m) = runReaderT m env

askActivityInfo :: Activity env ActivityInfo
askActivityInfo = Activity $ asks (.activityInfo)

askActivityWorker :: Activity env (Worker 'Real)
askActivityWorker = Activity $ asks (.activityWorker)

-- | The Activity monad provides access to the underlying Temporal client
-- since it is very common for an Activity to interact with other Workflows.
--
-- A common use-case is to use 'Temporal.Client.signal' to signal another Workflow
-- from an Activity.
--
-- Using the provided client ensures that a consistent set of interceptors are used
-- for all relevant actions.
askActivityClient :: Activity env Client
askActivityClient = Activity $ asks (getWorkerClient . (.activityWorker))

instance MonadReader env (Activity env) where
  ask = Activity $ asks (.activityEnv)
  local f (Activity m) = Activity $ local (\a -> a { activityEnv = f $ activityEnv a }) m


data ActivityCancelReason
  = GoneFromServer
  -- ^ The activity no longer exists on the server (may already be completed or its workflow
  -- may be completed).
  | CancelRequested
  -- ^ The was explicitly cancelled.
  | Timeout
  -- ^ Activity timeout caused the activity to marked cancelled.
  | WorkerShutdown
  -- ^ The worker the activity is running is shutting down.
  | HeartbeatRecordFailure
  -- ^ Failed to record heartbeat. This usually only happens if the payload converter fails.
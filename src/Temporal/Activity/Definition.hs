module Temporal.Activity.Definition where
import Control.Applicative
import Control.Monad.Catch
import Control.Monad
import Control.Monad.Error.Class
import Control.Monad.Fix
import Control.Monad.Reader
import Data.HashMap.Strict (HashMap)
import Data.Kind
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
    (f -> Vector RawPayload -> IO (Either String (Activity env (ResultOf (Activity env) f))))

class HasActivityDefinition a where
  type ActivityDefinitionEnv a :: Type
  activityDefinition :: a -> ActivityDefinition (ActivityDefinitionEnv a)

instance HasActivityDefinition (ActivityDefinition env) where
  type ActivityDefinitionEnv (ActivityDefinition env) = env
  activityDefinition = id

data ActivityDefinition env = ActivityDefinition
  { activityName :: Text
  , activityRun :: ActivityEnv env -> ExecuteActivityInput -> IO (Either String RawPayload)
  }

data ActivityEnv env = ActivityEnv
  { activityWorker :: Worker
  , activityInfo :: ActivityInfo
  , activityClientInterceptors :: ClientInterceptors
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

runActivity :: ActivityEnv env -> Activity env a -> IO a
runActivity env (Activity m) = runReaderT m env

askActivityInfo :: Activity env ActivityInfo
askActivityInfo = Activity $ asks (.activityInfo)

askActivityWorker :: Activity env Worker
askActivityWorker = Activity $ asks (.activityWorker)

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
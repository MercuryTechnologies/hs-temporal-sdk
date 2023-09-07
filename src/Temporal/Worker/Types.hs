{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Worker.Types where
import Control.Applicative (liftA2, Alternative(..))
import qualified Control.Monad.Catch as Catch
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.ProtoLens
import Data.Hashable (Hashable(..))
import Data.Proxy
import Data.HashMap.Strict (HashMap)
import Data.Kind
import Data.Map.Strict (Map)
import Data.Set (Set)
import Data.Text (Text)
import qualified Data.Text as T
import Data.Vector (Vector)
import Data.Word (Word32)
import GHC.Stack (CallStack, callStack, popCallStack)
import GHC.TypeLits
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
  ( ResolveActivity
  , ResolveChildWorkflowExecution
  , ResolveSignalExternalWorkflow
  , ResolveRequestCancelExternalWorkflow
  )
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  , WorkflowCommand'Variant(..)
  )
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import Proto.Temporal.Api.Common.V1.Message (Memo)
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import Temporal.Common
import Temporal.Coroutine
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import Temporal.Internal.JobPool (SomeAsync)
import Temporal.SearchAttributes
import System.Random.Stateful (StatefulGen(..), RandomGenM(..), FrozenGen(..))
import qualified Temporal.Core.Client as C
import UnliftIO hiding (race)
import RequireCallStack
import Text.Printf
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import Data.Time.Clock.System (SystemTime)
import Temporal.Duration (Duration)
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Definition (WorkflowDefinition)
import Temporal.Workflow.Worker (WorkflowWorker)
import Temporal.Activity.Definition (ActivityDefinition)
import Temporal.Activity.Worker (ActivityWorker)
import Temporal.Interceptor

data WorkerConfig activityEnv = WorkerConfig
  { deadlockTimeout :: Maybe Int
  , wfDefs :: HashMap Text WorkflowDefinition
  , actEnv :: activityEnv
  , actDefs :: HashMap Text (ActivityDefinition activityEnv)
  , coreConfig :: Core.WorkerConfig
  , interceptorConfig :: Interceptors
  }


data Worker activityEnv = Worker
  { workerCore :: Core.Worker
  , workerTaskQueue :: TaskQueue
  , workerConfig :: WorkerConfig activityEnv
  , workerLogFn :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workerWorkflowState :: WorkflowWorker
  , workerActivityState :: ActivityWorker activityEnv
  }

newtype WorkerM activityEnv a = WorkerM { unWorkerM :: ReaderT (Worker activityEnv) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (Worker activityEnv), MonadUnliftIO)

instance MonadLogger (WorkerM activityEnv) where
  monadLoggerLog loc src level msg = do
    worker <- ask
    liftIO $ worker.workerLogFn loc src level (toLogStr msg)

instance MonadLoggerIO (WorkerM activityEnv) where
  askLoggerIO = do
    worker <- ask
    pure worker.workerLogFn



-- | Values that were blocking waiting for an activation, and have now
-- been unblocked.  The worker adds these to a queue ('activationResults') using
-- 'putResult'; the scheduler collects them from the queue and unblocks
-- the relevant computations.
data ActivationResult = forall a. ActivationResult
  (ResultVal a)
  !(IVar a)

runWorkerM :: Worker actEnv -> WorkerM actEnv a -> IO a
runWorkerM worker m = runReaderT (unWorkerM m) worker

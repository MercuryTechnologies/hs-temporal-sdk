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
import Control.Monad.Logger
import Control.Monad.Reader
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)
import Temporal.Common
import qualified Temporal.Core.Worker as Core
import UnliftIO hiding (race)
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Definition (WorkflowDefinition)
import Temporal.Workflow.Worker (WorkflowWorker)
import Temporal.Activity.Definition (ActivityDefinition)
import Temporal.Activity.Worker (ActivityWorker)
import Temporal.Exception (ApplicationFailureHandler)
import Temporal.Interceptor
import Temporal.Core.Worker (InactiveForReplay)

data WorkerConfig activityEnv = WorkerConfig
  { deadlockTimeout :: Maybe Int
  , wfDefs :: HashMap Text WorkflowDefinition
  , actEnv :: activityEnv
  , actDefs :: HashMap Text (ActivityDefinition activityEnv)
  , coreConfig :: Core.WorkerConfig
  , interceptorConfig :: Interceptors
  , applicationErrorConverters :: [ApplicationFailureHandler]
  , logger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  }

data Worker (ty :: Core.WorkerType) activityEnv = Worker
  { workerCore :: Core.Worker ty
  , workerTaskQueue :: TaskQueue
  , workerConfig :: WorkerConfig activityEnv
  , workerLogFn :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workflowWorker :: WorkflowWorker
  , activityWorker :: InactiveForReplay ty (ActivityWorker activityEnv)
  }

newtype WorkerM ty activityEnv a = WorkerM { unWorkerM :: ReaderT (Worker ty activityEnv) IO a }
  deriving newtype (Functor, Applicative, Monad, MonadIO, MonadReader (Worker ty activityEnv), MonadUnliftIO)

instance MonadLogger (WorkerM ty activityEnv) where
  monadLoggerLog loc src level msg = do
    worker <- ask
    liftIO $ worker.workerLogFn loc src level (toLogStr msg)

instance MonadLoggerIO (WorkerM ty activityEnv) where
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

runWorkerM :: Worker ty actEnv -> WorkerM ty actEnv a -> IO a
runWorkerM worker m = runReaderT (unWorkerM m) worker

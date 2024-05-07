{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DuplicateRecordFields #-}
-- |
-- Module: Temporal.Worker
-- Description: Define and manage Temporal workers for executing workflows and activities.
--
-- Temporal workers are responsible for executing workflows and activities by polling
-- the Temporal service for tasks in specific task queues. This module provides
-- types and functions for defining and configuring Temporal workers, including
-- both workflow and activity workers.
--
-- Types and functions for configuring workers, adding workflows and activities,
-- and setting worker options are included in this module.
--
-- Note: workers only poll from a single task queue. If you need to poll from
-- multiple task queues, you will need to start multiple workers. Multiple workers
-- may run in the same process.
module Temporal.Worker 
  ( Temporal.Worker.Worker
  , startWorker
  , waitWorker
  , shutdown
  , linkWorker
  , pollWorkerSTM
  , waitWorkerSTM
  -- * Configuration
  , WorkerConfig(..)
  , Definitions(..)
  , ToDefinitions(..)
  , ConfigM
  , configure
  -- * Replay
  --
  -- A replay worker is a worker that is used to replay a workflow execution.
  -- It is not used for real-world execution of workflows, but is used to
  -- replay a workflow execution from history. This is useful for test suites,
  -- as it allows you to ensure that changes to your workflow code do not
  -- break determinism.
  , startReplayWorker
  , Core.HistoryPusher
  , Core.pushHistory
  , Core.closeHistory
  -- ** Worker options
  , HasWorkflowDefinition(..)
  , HasActivityDefinition(..)
  , addErrorConverter
  , setLogger
  , setTracerProvider
  , setNamespace
  , setTaskQueue
  , setBuildId
  , setIdentity
  , setMaxCachedWorkflows
  , setMaxOutstandingWorkflowTasks
  , setMaxOutstandingActivities
  , setMaxOutstandingLocalActivities
  , setMaxConcurrentWorkflowTaskPolls
  , setNonstickyToStickyPollRatio
  , setMaxConcurrentActivityTaskPolls
  , setNoRemoteActivities
  , setStickyQueueScheduleToStartTimeoutMillis
  , setMaxHeartbeatThrottleIntervalMillis
  , setDefaultHeartbeatThrottleIntervalMillis
  , setMaxActivitiesPerSecond
  , setMaxTaskQueueActivitiesPerSecond
  , setGracefulShutdownPeriodMillis
  , addInterceptors
  , setPayloadProcessor
  , WorkflowId(..)
  ) where
import UnliftIO
import Control.Concurrent
import Control.Monad
import Control.Monad.Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.State
import Data.HashMap.Strict (HashMap)
import Data.Either (lefts)
import Data.Foldable
import OpenTelemetry.Trace.Core hiding (inSpan)
import qualified OpenTelemetry.Trace.Core as OT
import OpenTelemetry.Trace.Monad
import Temporal.Common
import Temporal.Core.Client
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Activity.Definition
import qualified Temporal.Activity.Worker as Activity
import Temporal.Payload (PayloadProcessor(..))
import Temporal.Worker.Types
import Temporal.Workflow.Definition
import qualified Temporal.Workflow.Worker as Workflow
import Data.Text (Text)
import qualified Data.Text as T
import Data.Word
import qualified Data.HashMap.Strict as HashMap
import Temporal.Interceptor
import Temporal.Common.Async
import Temporal.Core.Worker (InactiveForReplay)
import Temporal.Runtime
import RequireCallStack
import System.IO.Unsafe

newtype ConfigM actEnv a = ConfigM { unConfigM :: State (WorkerConfig actEnv) a }
  deriving newtype (Functor, Applicative, Monad)

instance Semigroup a => Semigroup (ConfigM actEnv a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (ConfigM actEnv a) where
  mempty = pure mempty

------------------------------------------------------------------------------------
-- Configuration

-- TODO, it would be nice to expose an inert Tracer Provider in hs-opentelemetry-api
inertTracerProvider :: TracerProvider
inertTracerProvider = unsafePerformIO $ createTracerProvider [] emptyTracerProviderOptions
{-# NOINLINE inertTracerProvider #-}

-- | Turn a configuration block into the final configuration.
configure :: ToDefinitions actEnv defs => actEnv -> defs -> ConfigM actEnv () -> WorkerConfig actEnv
configure actEnv defs = flip execState defaultConfig . unConfigM
  where 
    defaultConfig = let (Definitions wfDefs actDefs) = toDefinitions defs in WorkerConfig
      { coreConfig = Core.defaultWorkerConfig
      , deadlockTimeout = Just 1000000
      , interceptorConfig = mempty
      , applicationErrorConverters = standardApplicationFailureHandlers
      , logger = \_ _ _ _ -> pure ()
      , tracerProvider = inertTracerProvider
      , payloadProcessor = PayloadProcessor pure (pure . Right)
      , ..
      }

data Definitions env = Definitions
  { workflowDefinitions :: {-# UNPACK #-} !(HashMap Text WorkflowDefinition)
  , activityDefinitions :: {-# UNPACK #-} !(HashMap Text (ActivityDefinition env))
  }

instance Semigroup (Definitions env) where
  (Definitions w1 a1) <> (Definitions w2 a2) = Definitions (w1 <> w2) (a1 <> a2)

instance Monoid (Definitions env) where
  mempty = Definitions mempty mempty

instance ToDefinitions env (Definitions env) where
  toDefinitions = id

class ToDefinitions env f where
  toDefinitions :: f -> Definitions env

instance ToDefinitions env WorkflowDefinition where
  toDefinitions wf = Definitions (HashMap.singleton (workflowName wf) wf) mempty

instance ToDefinitions env (ProvidedWorkflow f) where
  toDefinitions wf = toDefinitions wf.definition

instance ToDefinitions env (ActivityDefinition env) where
  toDefinitions act = Definitions mempty (HashMap.singleton (activityName act) act)

instance ToDefinitions env (ProvidedActivity env f) where
  toDefinitions act = toDefinitions act.definition

instance (ToDefinitions env _1, ToDefinitions env _2) => ToDefinitions env (_1, _2) where
  toDefinitions (a, b) = toDefinitions a <> toDefinitions b

instance (ToDefinitions env _1, ToDefinitions env _2, ToDefinitions env _3) => ToDefinitions env (_1, _2, _3) where
  toDefinitions (a, b, c) = toDefinitions a <> toDefinitions b <> toDefinitions c

instance (ToDefinitions env _1, ToDefinitions env _2, ToDefinitions env _3, ToDefinitions env _4) => ToDefinitions env (_1, _2, _3, _4) where
  toDefinitions (a, b, c, d) = toDefinitions a <> toDefinitions b <> toDefinitions c <> toDefinitions d

instance (ToDefinitions env _1, ToDefinitions env _2, ToDefinitions env _3, ToDefinitions env _4, ToDefinitions env _5) => ToDefinitions env (_1, _2, _3, _4, _5) where
  toDefinitions (a, b, c, d, e) = toDefinitions a <> toDefinitions b <> toDefinitions c <> toDefinitions d <> toDefinitions e

instance (ToDefinitions env _1, ToDefinitions env _2, ToDefinitions env _3, ToDefinitions env _4, ToDefinitions env _5, ToDefinitions env _6) => ToDefinitions env (_1, _2, _3, _4, _5, _6) where
  toDefinitions (a, b, c, d, e, f) = toDefinitions a <> toDefinitions b <> toDefinitions c <> toDefinitions d <> toDefinitions e <> toDefinitions f

addInterceptors :: Interceptors -> ConfigM actEnv ()
addInterceptors i = ConfigM $ modify' $ \conf -> conf
  { interceptorConfig = i <> interceptorConfig conf
  }

addErrorConverter :: (Exception e) => (e -> ApplicationFailure) -> ConfigM actEnv ()
addErrorConverter f = ConfigM $ modify' $ \conf -> conf
  { applicationErrorConverters = ApplicationFailureHandler f : applicationErrorConverters conf
  }

modifyCore :: (Core.WorkerConfig -> Core.WorkerConfig) -> ConfigM actEnv ()
modifyCore f = ConfigM $ modify' $ \conf -> conf
  { coreConfig = f (coreConfig conf)
  }

-- | The namespace that all workflows and activities will be 
-- registered in for this worker.
--
-- If you need to register workflows and activities in multiple namespaces,
-- you will need to start multiple workers. Multiple workers may run in the
-- same process.
setNamespace :: Namespace -> ConfigM actEnv ()
setNamespace (Namespace ns) = modifyCore $ \conf -> conf
  { Core.namespace = ns
  }

-- | A temporal worker, whether polling for workflows or activities, does so by polling a specific "Task Queue".
--
-- Any time there is a new activity task or workflow task that needs to be performed by a worker, it'll be queued in a specific task queue.
setTaskQueue :: TaskQueue -> ConfigM actEnv ()
setTaskQueue (TaskQueue tq) = modifyCore $ \conf -> conf
  { Core.taskQueue = tq
  }

-- | A string that should be unique to the exact worker code/binary being executed.
--
-- This is used to uniquely identify the worker's code for a handful of purposes, 
-- including the worker versioning feature if you have opted into that with useVersioning. 
-- It will also populate the binaryChecksum field on older servers.
--
-- N.B. this is not the same as the worker's identity, which is a string that identifies
-- the worker instance. The identity is used to identify the worker instance in logs and
-- in the Temporal UI. The buildId is used to identify the exact version of the code and
-- its dependencies. In e.g. Nix, the executable path in the Nix store would be a useful 
-- buildId.
setBuildId :: Text -> ConfigM actEnv ()
setBuildId bid = modifyCore $ \conf -> conf
  { Core.buildId = bid
  }

setIdentity :: Text -> ConfigM actEnv ()
setIdentity ident = modifyCore $ \conf -> conf
  { Core.identityOverride = Just ident
  }

setMaxCachedWorkflows :: Word64 -> ConfigM actEnv ()
setMaxCachedWorkflows n = modifyCore $ \conf -> conf
  { Core.maxCachedWorkflows = n
  }

setMaxOutstandingWorkflowTasks :: Word64 -> ConfigM actEnv ()
setMaxOutstandingWorkflowTasks n = modifyCore $ \conf -> conf
  { Core.maxOutstandingWorkflowTasks = n
  }

setMaxOutstandingActivities :: Word64 -> ConfigM actEnv ()
setMaxOutstandingActivities n = modifyCore $ \conf -> conf
  { Core.maxOutstandingActivities = n
  }

setMaxOutstandingLocalActivities :: Word64 -> ConfigM actEnv ()
setMaxOutstandingLocalActivities n = modifyCore $ \conf -> conf
  { Core.maxOutstandingLocalActivities = n
  }

setMaxConcurrentWorkflowTaskPolls :: Word64 -> ConfigM actEnv ()
setMaxConcurrentWorkflowTaskPolls n = modifyCore $ \conf -> conf
  { Core.maxConcurrentWorkflowTaskPolls = n
  }

setNonstickyToStickyPollRatio :: Float -> ConfigM actEnv ()
setNonstickyToStickyPollRatio n = modifyCore $ \conf -> conf
  { Core.nonstickyToStickyPollRatio = n
  }

-- | Maximum number of Activity tasks to poll concurrently.
--
-- Increase this setting if your Worker is failing to fill in all 
-- of its maxConcurrentActivityTaskExecutions slots despite a 
-- backlog of Activity Tasks in the Task Queue (ie. due to network latency). 
-- Can't be higher than maxConcurrentActivityTaskExecutions.
setMaxConcurrentActivityTaskPolls :: Word64 -> ConfigM actEnv ()
setMaxConcurrentActivityTaskPolls n = modifyCore $ \conf -> conf
  { Core.maxConcurrentActivityTaskPolls = n
  }

setNoRemoteActivities :: Bool -> ConfigM actEnv ()
setNoRemoteActivities n = modifyCore $ \conf -> conf
  { Core.noRemoteActivities = n
  }

-- | How long a workflow task is allowed to sit on the sticky queue before it is timed out and moved to the non-sticky queue where it may be picked up by any worker.
setStickyQueueScheduleToStartTimeoutMillis :: Word64 -> ConfigM actEnv ()
setStickyQueueScheduleToStartTimeoutMillis n = modifyCore $ \conf -> conf
  { Core.stickyQueueScheduleToStartTimeoutMillis = n
  }

-- | Longest interval for throttling activity heartbeats
setMaxHeartbeatThrottleIntervalMillis :: Word64 -> ConfigM actEnv ()
setMaxHeartbeatThrottleIntervalMillis n = modifyCore $ \conf -> conf
  { Core.maxHeartbeatThrottleIntervalMillis = n
  }

-- Default interval for throttling activity heartbeats in case 
-- ActivityOptions.heartbeat_timeout is unset. 
-- When the timeout is set in the ActivityOptions, 
-- throttling is set to @heartbeat_timeout * 0.8@.
setDefaultHeartbeatThrottleIntervalMillis :: Word64 -> ConfigM actEnv ()
setDefaultHeartbeatThrottleIntervalMillis n = modifyCore $ \conf -> conf
  { Core.defaultHeartbeatThrottleIntervalMillis = n
  }

-- | Limits the number of Activities per second that this Worker will process. 
-- (Does not limit the number of Local Activities.) The Worker will not poll for 
-- new Activities if by doing so it might receive and execute an Activity which 
-- would cause it to exceed this limit. Must be a positive number.
--
-- If unset, no rate limiting will be applied to Worker's Activities. (tctl task-queue describe will display the absence of a limit as 100,000.)
setMaxActivitiesPerSecond :: Double -> ConfigM actEnv ()
setMaxActivitiesPerSecond n = modifyCore $ \conf -> conf
  { Core.maxActivitiesPerSecond = Just n
  }

-- | Sets the maximum number of activities per second the task queue will dispatch, controlled server-side. Note that this only takes effect upon an activity poll request. 
-- If multiple workers on the same queue have different values set, they will thrash with the last poller winning.
--
-- If unset, no rate limiting will be applied to the task queue.
setMaxTaskQueueActivitiesPerSecond :: Double -> ConfigM actEnv ()
setMaxTaskQueueActivitiesPerSecond n = modifyCore $ \conf -> conf
  { Core.maxTaskQueueActivitiesPerSecond = Just n
  }

-- | Time to wait for pending tasks to drain after shutdown was requested.
--
-- In-flight activities will be cancelled after this period and their current 
-- attempt will be resolved as failed if they confirm cancellation 
-- (by throwing a CancelledFailure or AbortError).
setGracefulShutdownPeriodMillis :: Word64 -> ConfigM actEnv ()
setGracefulShutdownPeriodMillis n = modifyCore $ \conf -> conf
  { Core.gracefulShutdownPeriodMillis = n
  }

-- | Set the logger for the worker. This is used to log messages from the worker.
setLogger :: (Loc -> LogSource -> Control.Monad.Logger.LogLevel -> LogStr -> IO ()) -> ConfigM actEnv ()
setLogger f = ConfigM $ modify' $ \conf -> conf
  { logger = f
  }

-- | Set the tracer provider for the worker. This is used to trace the worker's internal activity.
setTracerProvider :: TracerProvider -> ConfigM actEnv ()
setTracerProvider tp = ConfigM $ modify' $ \conf -> conf
  { tracerProvider = tp
  }

setPayloadProcessor :: PayloadProcessor -> ConfigM actEnv ()
setPayloadProcessor p = ConfigM $ modify' $ \conf -> conf
  { payloadProcessor = p
  }

------------------------------------------------------------------------------------

-- | A Worker is responsible for polling a Task Queue, dequeueing a Task, executing 
-- your code in response to a Task, and responding to the Temporal Cluster with the results.
--
-- Worker Processes are external to a Temporal Cluster. Temporal Application developers are 
-- responsible for developing Worker Programs and operating Worker Processes. Said another way, 
-- the Temporal Cluster (including the Temporal Cloud) doesn't execute any of your code 
-- (Workflow and Activity Definitions) on Temporal Cluster machines. The Cluster is solely 
-- responsible for orchestrating State Transitions and providing Tasks to the next available 
-- Worker Entity.
--
-- A Worker Process can be both a Workflow Worker Process and an Activity Worker Process. 
-- Haskell the ability to have multiple Worker Entities in a single Worker Process. 
--
-- A single Worker Entity can listen to only a single Task Queue. But if a Worker Process has multiple Worker Entities, the Worker Process could be listening to multiple Task Queues.
data Worker = forall ty. Worker
  { workerType :: Core.SWorkerType ty 
  , workerWorkflowLoop :: Async ()
  , workerActivityLoop :: InactiveForReplay ty (Async ())
  , workerCore :: Core.Worker ty
  , workerTracer :: Tracer
  }

startReplayWorker :: (MonadUnliftIO m, MonadCatch m) => Runtime -> WorkerConfig actEnv -> m (Temporal.Worker.Worker, Core.HistoryPusher)
startReplayWorker rt conf = provideCallStack $ runWorkerContext conf $ do
  $(logDebug) "Starting worker"
  (workerCore, replay) <- either throwIO pure =<< liftIO (Core.newReplayWorker rt conf.coreConfig)
  $(logDebug) "Instantiated core"
  runningWorkflows <- newTVarIO mempty
  let workerWorkflowFunctions = conf.wfDefs
      workerTaskQueue = TaskQueue $ Core.taskQueue conf.coreConfig
      workerInboundInterceptors = conf.interceptorConfig.workflowInboundInterceptors
      workerOutboundInterceptors = conf.interceptorConfig.workflowOutboundInterceptors
      workerDeadlockTimeout = conf.deadlockTimeout
      workerClient = error "Cannot use workflow client in replay worker"
      workerErrorConverters = conf.applicationErrorConverters
      processor = conf.payloadProcessor
      workflowWorker = Workflow.WorkflowWorker{..}
      workerActivityLoop = error "Cannot use activity worker in replay worker"
      workerType = Core.SReplay
      workerTracer = makeTracer conf.tracerProvider (InstrumentationLibrary "hs-temporal-sdk" "0.0.1.0") tracerOptions
  workerWorkflowLoop <- asyncLabelled (T.unpack $ T.concat [ "temporal/worker/workflow/", Core.namespace conf.coreConfig, "/", Core.taskQueue conf.coreConfig ]) $ do
    $(logDebug) "Starting workflow worker loop"
    Workflow.execute workflowWorker 
      `UnliftIO.finally` $(logDebug) "Exiting workflow worker loop"
  pure (Temporal.Worker.Worker{..}, replay)

traced :: WorkerConfig env -> ReaderT Tracer m a -> m a
traced conf m = runReaderT m $ makeTracer 
  conf.tracerProvider 
  (InstrumentationLibrary "hs-temporal-sdk" "0.0.1.0") 
  tracerOptions

runWorkerContext :: WorkerConfig conf -> WorkerContextM m a -> m a
runWorkerContext conf (WorkerContextM m) = flip runLoggingT conf.logger $ traced conf m

newtype WorkerContextM m a = WorkerContextM (ReaderT Tracer (LoggingT m) a)
  deriving newtype (Functor, Applicative, Monad, MonadIO, MonadUnliftIO, MonadLogger, MonadLoggerIO, MonadCatch, MonadThrow)

instance Monad m => MonadTracer (WorkerContextM m) where
  getTracer = WorkerContextM ask

startWorker :: (MonadUnliftIO m, MonadCatch m) => Client -> WorkerConfig actEnv -> m Temporal.Worker.Worker
startWorker client conf = provideCallStack $ runWorkerContext conf $ inSpan "startWorker" defaultSpanArguments $ do
  workerCore <- inSpan "Core.newWorker" defaultSpanArguments 
    (either throwIO pure =<< liftIO (Core.newWorker client conf.coreConfig))
  runningWorkflows <- newTVarIO mempty
  runningActivities <- newTVarIO mempty
  let errorConverters = mkAnnotatedHandlers conf.applicationErrorConverters
      workerWorkflowFunctions = conf.wfDefs
      workerTaskQueue = TaskQueue $ Core.taskQueue conf.coreConfig
      workerInboundInterceptors = conf.interceptorConfig.workflowInboundInterceptors
      workerOutboundInterceptors = conf.interceptorConfig.workflowOutboundInterceptors
      workerDeadlockTimeout = conf.deadlockTimeout
      workerErrorConverters = errorConverters
      processor = conf.payloadProcessor
      workflowWorker = Workflow.WorkflowWorker{..}
      initialEnv = conf.actEnv
      definitions = conf.actDefs
      activityInboundInterceptors = conf.interceptorConfig.activityInboundInterceptors
      activityOutboundInterceptors = conf.interceptorConfig.activityOutboundInterceptors
      clientInterceptors = conf.interceptorConfig.clientInterceptors
      activityErrorConverters = errorConverters
      payloadProcessor = conf.payloadProcessor
      activityWorker = Activity.ActivityWorker{..}
      workerClient = client
      workerTracer = makeTracer conf.tracerProvider (InstrumentationLibrary "hs-temporal-sdk" "0.0.1.0") tracerOptions
  let workerType = Core.SReal
  -- logs <- liftIO $ fetchLogs globalRuntime
  -- forM_ logs $ \l -> case l.level of
  --   Trace -> $(logDebug) l.message
  --   Debug -> $(logDebug) l.message
  --   Info -> $(logInfo) l.message
  --   Warn -> $(logWarn) l.message
  --   Error -> $(logError) l.message
  workerWorkflowLoop <- asyncLabelled (T.unpack $ T.concat [ "temporal/worker/workflow/", Core.namespace conf.coreConfig, "/", Core.taskQueue conf.coreConfig ]) $ do
    $(logDebug) "Starting workflow worker loop"
    Workflow.execute workflowWorker
      `UnliftIO.finally` $(logDebug) "Exiting workflow worker loop"
  workerActivityLoop <- asyncLabelled (T.unpack $ T.concat [ "temporal/worker/activity/", Core.namespace conf.coreConfig, "/", Core.taskQueue conf.coreConfig ]) $ do 
    $(logDebug) "Starting activity worker loop"
    Activity.execute activityWorker
      `UnliftIO.finally` $(logDebug) "Exiting activity worker loop"
  pure Temporal.Worker.Worker{..}

-- | Wait for a worker to exit. This waits for both the workflow and activity loops to complete.
--
-- Any exceptions thrown by the workflow or activity loops will be rethrown.
--
-- This function is generally not needed, as 'shutdown' will wait for the worker to exit.
waitWorker :: (MonadIO m) => Temporal.Worker.Worker -> m ()
waitWorker (Temporal.Worker.Worker{workerType, workerWorkflowLoop, workerActivityLoop}) = do
  case workerType of
    Core.SReal -> do
      wfRes <- waitCatch workerWorkflowLoop
      actRes <- waitCatch workerActivityLoop
      for_ (lefts [wfRes, actRes]) throwIO
    Core.SReplay -> do
      _ <- wait workerWorkflowLoop
      pure ()
  -- logs <- liftIO $ fetchLogs globalRuntime
  -- forM_ logs $ \l -> do
  --   $(logInfo) $ Text.pack $ show l


-- | Link a worker to the current thread. This will cause uncaught worker exceptions to be rethrown in the current thread.
--
-- If the worker has both workflow and activity definitions registered, this will link both the workflow and activity loops.
-- If one of the loops fails, the worker will initiate graceful shutdown (but not block) before rethrowing the exception.
linkWorker :: Temporal.Worker.Worker -> IO ()
linkWorker Temporal.Worker.Worker{workerCore, workerType, workerWorkflowLoop, workerActivityLoop} = do
  tid <- myThreadId
  void $ forkIOLabelled (T.unpack $ T.concat [ "temporal/worker/link/", Core.namespace c, "/", Core.taskQueue c ]) $ do
    let errorClause :: SomeException -> IO ()
        errorClause e = do
          Core.initiateShutdown workerCore
          Control.Concurrent.throwTo tid e
    case workerType of
      Core.SReal ->  do
        eeRes <- race (waitCatch workerWorkflowLoop) (waitCatch workerActivityLoop)
        case eeRes of
          Left (Left e) -> errorClause e
          Right (Left e) -> errorClause e
          _ -> pure ()
      Core.SReplay -> do
        eRes <- waitCatch workerWorkflowLoop
        case eRes of
          Left e -> errorClause e
          _ -> pure ()
  where
    c = Core.getWorkerConfig workerCore


pollWorkerSTM :: Temporal.Worker.Worker -> STM (Maybe (Either SomeException ()))
pollWorkerSTM Temporal.Worker.Worker{workerType, workerWorkflowLoop, workerActivityLoop} = do
  case workerType of
    Core.SReal -> do
      wfRes <- pollSTM workerWorkflowLoop
      actRes <- pollSTM workerActivityLoop
      pure $ case (wfRes, actRes) of
        (Just (Left e), _) -> Just (Left e)
        (_, Just (Left e)) -> Just (Left e)
        (Just (Right ()), Just (Right ())) -> Just (Right ())
        _ -> Nothing
    Core.SReplay -> pollSTM workerWorkflowLoop

waitWorkerSTM :: Temporal.Worker.Worker -> STM ()
waitWorkerSTM Temporal.Worker.Worker{workerType, workerWorkflowLoop, workerActivityLoop} = do
  case workerType of
    Core.SReal -> do
      waitSTM workerWorkflowLoop
      waitSTM workerActivityLoop
    Core.SReplay -> waitSTM workerWorkflowLoop

-- | Shut down a worker. This will initiate a graceful shutdown of the worker, waiting for all
-- in-flight tasks to complete before finalizing the shutdown.
shutdown :: (MonadUnliftIO m) => Temporal.Worker.Worker -> m ()
shutdown worker@Temporal.Worker.Worker{workerCore, workerTracer} = OT.inSpan workerTracer "shutdown" defaultSpanArguments $ UnliftIO.mask $ \restore -> do
  OT.inSpan workerTracer "initiateShutdown" defaultSpanArguments $ liftIO $ Core.initiateShutdown workerCore

  OT.inSpan workerTracer "waitWorker" defaultSpanArguments $ restore $ waitWorker worker

  err' <- OT.inSpan workerTracer "finalizeShutdown" defaultSpanArguments $ liftIO $ Core.finalizeShutdown workerCore
  case err' of
    Left err -> throwIO err
    Right () -> pure ()

  -- logs <- liftIO $ fetchLogs globalRuntime
  -- forM_ logs $ \l -> do
  --   $(logInfo) $ Text.pack $ show l

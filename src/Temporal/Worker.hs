{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DuplicateRecordFields #-}
module Temporal.Worker 
  ( Temporal.Worker.Worker
  , startWorker
  , waitWorker
  , shutdown
  -- * Configuration
  , WorkerConfig(..)
  , ToConfig(..)
  , ConfigM
  , configure
  -- ** Worker options
  , HasWorkflowDefinition(..)
  , addWorkflow
  , HasActivityDefinition(..)
  , addActivity
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
  ) where
import UnliftIO.Exception
import UnliftIO
import Control.Monad

import Control.Applicative
import Control.Monad.Logger
import Control.Monad.State

import Temporal.Common
import Temporal.Core.Client
import qualified Temporal.Core.Worker as Core
import Temporal.Internal.JobPool
import Temporal.Activity (ProvidedActivity(..))
import Temporal.Activity.Definition
import qualified Temporal.Activity.Worker as Activity
import Temporal.Worker.Types
import Temporal.Workflow.Definition
import Temporal.Workflow.WorkflowInstance
import qualified Temporal.Workflow.Worker as Workflow
import Temporal.WorkflowInstance

import Data.ByteString (ByteString)
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Time.Clock (UTCTime)
import Data.Vector (Vector)
import qualified Data.Vector as V
import Data.Int
import Data.IORef
import Data.Word
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe

import Lens.Family2
import Lens.Family2.Stock
import Data.ProtoLens
import Data.ProtoLens.Combinators
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as CommonProto
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import Temporal.Duration (seconds)
import Temporal.Interceptor

-- | A utility class to convert a value into a 'WorkerConfig' using the 'ConfigM' monad.
--
-- This is useful for defining a 'WorkerConfig' in a modular way.
--
-- See 'Temporal.Generic.defsToConfig' as an example.
class ToConfig env a where
  toConfig :: a -> ConfigM env ()

newtype ConfigM actEnv a = ConfigM { unConfigM :: State (WorkerConfig actEnv) a }
  deriving (Functor, Applicative, Monad)

instance Semigroup a => Semigroup (ConfigM actEnv a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (ConfigM actEnv a) where
  mempty = pure mempty

------------------------------------------------------------------------------------
-- Configuration

-- | Turn a configuration block into the final configuration.
configure :: actEnv -> ConfigM actEnv () -> WorkerConfig actEnv
configure actEnv = flip execState defaultConfig . unConfigM
  where
    defaultConfig = WorkerConfig
      { wfDefs = mempty
      , actDefs = mempty
      , coreConfig = Core.defaultWorkerConfig
      , deadlockTimeout = Just 1000000
      , interceptorConfig = Interceptors
        { workflowInboundInterceptors = WorkflowInboundInterceptor { executeWorkflow = \info next -> next info }
        , workflowOutboundInterceptors = WorkflowOutboundInterceptor
          { scheduleActivity = \ty info next -> next ty info
          }
        , activityInboundInterceptors = ActivityInboundInterceptor
        , activityOutboundInterceptors = ActivityOutboundInterceptor
        }
      , ..
      }

addInterceptors :: Interceptors -> ConfigM actEnv ()
addInterceptors i = ConfigM $ modify' $ \conf -> conf
  { interceptorConfig = i <> interceptorConfig conf
  }

-- | Register a 'Workflow' with the worker.
addWorkflow :: HasWorkflowDefinition def => def -> ConfigM actEnv ()
addWorkflow hasDef = ConfigM $ modify' $ \conf -> conf
  { wfDefs = HashMap.insert (workflowName def) def (wfDefs conf) 
  }
  where
    def = workflowDefinition hasDef

-- | Register an 'Activity' with the worker.
addActivity :: HasActivityDefinition def => def -> ConfigM (ActivityDefinitionEnv def) ()
addActivity def = ConfigM $ modify' $ \conf -> conf
  { actDefs = HashMap.insert 
      act.activityName 
      act
      conf.actDefs
  }
  where
    act = activityDefinition def

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

------------------------------------------------------------------------------------

defaultRetryPolicy :: RetryPolicy
defaultRetryPolicy = RetryPolicy
  { initialInterval = seconds 1
  , backoffCoefficient = 2
  , maximumInterval = Nothing
  , maximumAttempts = 0
  , nonRetryableErrorTypes = mempty
  }

data Worker = Worker
  { workerWorkflowLoop :: Async ()
  , workerActivityLoop :: Async ()
  , workerCore :: Core.Worker
  }

startWorker :: (MonadLoggerIO m, MonadUnliftIO m) => Client -> WorkerConfig actEnv -> m Temporal.Worker.Worker
startWorker client conf = do
  $(logDebug) "Starting worker"
  workerCore <- either throwIO pure =<< liftIO (Core.newWorker client conf.coreConfig)
  $(logDebug) "Instantiated core"
  runningWorkflows <- newTVarIO mempty
  runningActivities <- newTVarIO mempty
  workerLogFn <- askLoggerIO
  let workerWorkflowFunctions = conf.wfDefs
      workerConfig = conf
      workerTaskQueue = TaskQueue $ Core.taskQueue conf.coreConfig
      workflowWorker = Workflow.WorkflowWorker{..}

      initialEnv = conf.actEnv
      definitions = conf.actDefs
      activityWorker = Activity.ActivityWorker{..}
      worker = Temporal.Worker.Types.Worker{..}
      workerClient = client

  workerWorkflowLoop <- async $ do
    $(logDebug) "Starting workflow worker loop"
    Workflow.execute workflowWorker
    $(logDebug) "Exiting workflow worker loop"
  workerActivityLoop <- async $ do 
    $(logDebug) "Starting activity worker loop"
    liftIO $ Activity.execute activityWorker
    $(logDebug) "Exiting activity worker loop"
  pure Temporal.Worker.Worker{..}

waitWorker :: MonadIO m => Temporal.Worker.Worker -> m ()
waitWorker worker = void $ do
  link2 (workerWorkflowLoop worker) (workerActivityLoop worker)
  _ <- waitCatch (workerWorkflowLoop worker)
  _ <- waitCatch (workerActivityLoop worker)
  pure ()

shutdown :: MonadIO m => Temporal.Worker.Worker -> m ()
shutdown worker = liftIO $ do
  Core.initiateShutdown worker.workerCore

  waitWorker worker

  err' <- Core.finalizeShutdown worker.workerCore
  case err' of
    Left err -> throwIO err
    Right () -> pure ()

{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
module Temporal.Worker 
  ( Temporal.Worker.Worker
  , startWorker
  , waitWorker
  , shutdown
  , WorkerConfig
  , ConfigM
  , configure
  , addWorkflow
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
  ) where
import UnliftIO.Exception
import UnliftIO
import Control.Monad

import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.IO.Class

import Temporal.Common
import Temporal.Core.Client
import Temporal.Exception
import qualified Temporal.Core.Worker as Core
import Temporal.Internal.JobPool
import qualified Temporal.Activity.Worker as Activity
import Temporal.Worker.Types
import Temporal.Workflow.Unsafe
import Temporal.Workflow.WorkflowDefinition
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
import qualified System.Clock as Clock

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


-- mkConfig 
--   :: Core.WorkerConfig
--   -> wfEnv 
--   -> [OpaqueWorkflow WorkflowDefinition wfEnv]
--   -> actEnv
--   -> [ActivityDefinition actEnv]
--   -> WorkerConfig wfEnv actEnv
-- mkConfig core wfEnv wfDefs actEnv actDefs = WorkerConfig 
--   (Just 2000000) 
--   wfEnv
--   (HashMap.fromList $ fmap (\def -> (workflowName def, def)) wfDefs)
--   actEnv
--   (HashMap.fromList $ fmap (\def -> (activityName def, def)) actDefs)
--   core

newtype ConfigM wfEnv actEnv a = ConfigM { unConfigM :: State (WorkerConfig wfEnv actEnv) a }
  deriving (Functor, Applicative, Monad)

------------------------------------------------------------------------------------
-- Configuration

configure :: wfEnv -> actEnv -> ConfigM wfEnv actEnv () -> WorkerConfig wfEnv actEnv
configure wfEnv actEnv = flip execState defaultConfig . unConfigM
  where
    defaultConfig = WorkerConfig
      { wfDefs = mempty
      , actDefs = mempty
      , coreConfig = Core.defaultWorkerConfig
      , deadlockTimeout = Nothing
      , ..
      }

addWorkflow :: WorkflowDefinition env st -> ConfigM env actEnv ()
addWorkflow def = ConfigM $ modify' $ \conf -> conf
  { wfDefs = HashMap.insert (workflowName def) (OpaqueWorkflow def) (wfDefs conf) 
  }

addActivity :: ActivityDefinition env -> ConfigM wfEnv env ()
addActivity def = ConfigM $ modify' $ \conf -> conf
  { actDefs = HashMap.insert (activityName def) def (actDefs conf)
  }

modifyCore :: (Core.WorkerConfig -> Core.WorkerConfig) -> ConfigM wfEnv actEnv ()
modifyCore f = ConfigM $ modify' $ \conf -> conf
  { coreConfig = f (coreConfig conf)
  }

setNamespace :: Text -> ConfigM wfEnv actEnv ()
setNamespace ns = modifyCore $ \conf -> conf
  { Core.namespace = ns
  }

setTaskQueue :: Text -> ConfigM wfEnv actEnv ()
setTaskQueue tq = modifyCore $ \conf -> conf
  { Core.taskQueue = tq
  }

setBuildId :: Text -> ConfigM wfEnv actEnv ()
setBuildId bid = modifyCore $ \conf -> conf
  { Core.buildId = bid
  }

setIdentity :: Text -> ConfigM wfEnv actEnv ()
setIdentity ident = modifyCore $ \conf -> conf
  { Core.identityOverride = Just ident
  }

setMaxCachedWorkflows :: Word64 -> ConfigM wfEnv actEnv ()
setMaxCachedWorkflows n = modifyCore $ \conf -> conf
  { Core.maxCachedWorkflows = n
  }

setMaxOutstandingWorkflowTasks :: Word64 -> ConfigM wfEnv actEnv ()
setMaxOutstandingWorkflowTasks n = modifyCore $ \conf -> conf
  { Core.maxOutstandingWorkflowTasks = n
  }

setMaxOutstandingActivities :: Word64 -> ConfigM wfEnv actEnv ()
setMaxOutstandingActivities n = modifyCore $ \conf -> conf
  { Core.maxOutstandingActivities = n
  }

setMaxOutstandingLocalActivities :: Word64 -> ConfigM wfEnv actEnv ()
setMaxOutstandingLocalActivities n = modifyCore $ \conf -> conf
  { Core.maxOutstandingLocalActivities = n
  }

setMaxConcurrentWorkflowTaskPolls :: Word64 -> ConfigM wfEnv actEnv ()
setMaxConcurrentWorkflowTaskPolls n = modifyCore $ \conf -> conf
  { Core.maxConcurrentWorkflowTaskPolls = n
  }

setNonstickyToStickyPollRatio :: Float -> ConfigM wfEnv actEnv ()
setNonstickyToStickyPollRatio n = modifyCore $ \conf -> conf
  { Core.nonstickyToStickyPollRatio = n
  }

setMaxConcurrentActivityTaskPolls :: Word64 -> ConfigM wfEnv actEnv ()
setMaxConcurrentActivityTaskPolls n = modifyCore $ \conf -> conf
  { Core.maxConcurrentActivityTaskPolls = n
  }

setNoRemoteActivities :: Bool -> ConfigM wfEnv actEnv ()
setNoRemoteActivities n = modifyCore $ \conf -> conf
  { Core.noRemoteActivities = n
  }

setStickyQueueScheduleToStartTimeoutMillis :: Word64 -> ConfigM wfEnv actEnv ()
setStickyQueueScheduleToStartTimeoutMillis n = modifyCore $ \conf -> conf
  { Core.stickyQueueScheduleToStartTimeoutMillis = n
  }

setMaxHeartbeatThrottleIntervalMillis :: Word64 -> ConfigM wfEnv actEnv ()
setMaxHeartbeatThrottleIntervalMillis n = modifyCore $ \conf -> conf
  { Core.maxHeartbeatThrottleIntervalMillis = n
  }

setDefaultHeartbeatThrottleIntervalMillis :: Word64 -> ConfigM wfEnv actEnv ()
setDefaultHeartbeatThrottleIntervalMillis n = modifyCore $ \conf -> conf
  { Core.defaultHeartbeatThrottleIntervalMillis = n
  }

setMaxActivitiesPerSecond :: Double -> ConfigM wfEnv actEnv ()
setMaxActivitiesPerSecond n = modifyCore $ \conf -> conf
  { Core.maxActivitiesPerSecond = Just n
  }

setMaxTaskQueueActivitiesPerSecond :: Double -> ConfigM wfEnv actEnv ()
setMaxTaskQueueActivitiesPerSecond n = modifyCore $ \conf -> conf
  { Core.maxTaskQueueActivitiesPerSecond = Just n
  }

setGracefulShutdownPeriodMillis :: Word64 -> ConfigM wfEnv actEnv ()
setGracefulShutdownPeriodMillis n = modifyCore $ \conf -> conf
  { Core.gracefulShutdownPeriodMillis = n
  }

------------------------------------------------------------------------------------

defaultRetryPolicy :: RetryPolicy
defaultRetryPolicy = RetryPolicy
  { initialInterval = Clock.TimeSpec 1 0
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

startWorker :: forall m wfEnv actEnv. (MonadLoggerIO m, MonadUnliftIO m) => Client -> WorkerConfig wfEnv actEnv -> m Temporal.Worker.Worker
startWorker client conf = do
  $(logDebug) "Starting worker"
  workerCore <- either throwIO pure =<< liftIO (Core.newWorker client conf.coreConfig)
  $(logDebug) "Instantiated core"
  runningWorkflows <- newTMVarIO mempty
  deadlockedWorkflows <- newTVarIO mempty
  runningActivities <- newMVar mempty
  workerLogFn <- askLoggerIO
  let workerWorkflowFunctions = conf.wfDefs
      workerConfig = conf
      workerTaskQueue = Core.taskQueue conf.coreConfig
      workerEnv = conf.wfEnv
      workerWorkflowState = WorkflowWorker{..}

      initialEnv = conf.actEnv
      definitions = conf.actDefs
      workerActivityState = ActivityWorker{..}
      worker = Temporal.Worker.Types.Worker{..}

  workerWorkflowLoop <- async $ do
    $(logDebug) "Starting workflow worker loop"
    liftIO $ Workflow.execute worker
  workerActivityLoop <- async $ do 
    $(logDebug) "Starting activity worker loop"
    liftIO $ Activity.execute worker
  pure Temporal.Worker.Worker{..}

waitWorker :: MonadIO m => Temporal.Worker.Worker -> m ()
waitWorker worker = void $ do
  -- TODO these need to account for expected PollShutdown calls
  wait (workerWorkflowLoop worker)
  wait (workerActivityLoop worker)

shutdown :: MonadIO m => Temporal.Worker.Worker -> m ()
shutdown worker = liftIO $ do
  Core.initiateShutdown worker.workerCore

  _ <- waitCatch worker.workerWorkflowLoop
  _ <- waitCatch worker.workerActivityLoop

  err' <- Core.finalizeShutdown worker.workerCore
  case err' of
    Left err -> throwIO err
    Right () -> pure ()

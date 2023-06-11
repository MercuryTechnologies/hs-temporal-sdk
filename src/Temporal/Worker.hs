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
  , mkConfig
  , WorkerConfig(..)
  ) where
import UnliftIO.Exception
import UnliftIO
import Control.Monad

import Control.Monad.Logger
import Control.Monad.Reader
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


mkConfig 
  :: Core.WorkerConfig
  -> wfEnv 
  -> HashMap Text (OpaqueWorkflow WorkflowDefinition wfEnv) 
  -> actEnv
  -> [ActivityDefinition actEnv]
  -> WorkerConfig wfEnv actEnv
mkConfig core wfEnv wfDefs actEnv actDefs = WorkerConfig 
  (Just 2000000) 
  wfEnv
  wfDefs
  actEnv
  (HashMap.fromList $ fmap (\def -> (activityName def, def)) actDefs)
  core

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
  wait (workerWorkflowLoop worker)
  wait (workerActivityLoop worker)

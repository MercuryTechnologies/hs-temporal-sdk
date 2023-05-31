{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
module Temporal.Worker 
  ( WorkflowWorker
  , withWorker
  , mkConfig
  , WorkflowWorkerConfig(..)
  ) where
import UnliftIO.Exception
import UnliftIO
import Control.Monad

import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.IO.Class

import Temporal.Common
import Temporal.Core.Client
import qualified Temporal.Core.Worker as Core
import Temporal.Internal.JobPool
import Temporal.Workflow.Unsafe
import Temporal.Workflow.WorkflowDefinition
import Temporal.Workflow.WorkflowInstance
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

data WorkflowWorkerConfig env = WorkflowWorkerConfig
  { deadlockTimeout :: Maybe Int
  , jobPool :: Maybe JobPool
  , configEnv :: env
  , workflowDefinitions :: HashMap Text (WorkflowDefinition env)
  , coreConfig :: Core.WorkerConfig
  }

mkConfig 
  :: Core.WorkerConfig
  -> env 
  -> HashMap Text (WorkflowDefinition env) 
  -> WorkflowWorkerConfig env
mkConfig core e defs = WorkflowWorkerConfig (Just 2000000) Nothing e defs core

data WorkflowWorker env = WorkflowWorker
  { workerCore :: Core.Worker
  , workerTaskQueue :: Text
  -- Function name -> workflow
  , workerWorkflowFunctions :: HashMap Text (WorkflowDefinition env)
  , runningWorkflows :: TMVar (HashMap RunId (WorkflowInstance env))
  , deadlockedWorkflows :: TVar (HashMap RunId SomeAsync)
  -- , workerActivityFunctions :: HashMap Text (SomeActivity env)
  -- , workerTaskTokensToCancels :: HashMap TaskToken CancellationToken
  , workerEnv :: env
  , workerJobPool :: JobPool
  , workerConfig :: WorkflowWorkerConfig env
  , workerLogFn :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  }

newtype WorkerM env a = WorkerM { unWorkerM :: ReaderT (WorkflowWorker env) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (WorkflowWorker env), MonadUnliftIO)

instance MonadLogger (WorkerM env) where
  monadLoggerLog loc src level msg = do
    worker <- ask
    liftIO $ worker.workerLogFn loc src level (toLogStr msg)

instance MonadLoggerIO (WorkerM env) where
  askLoggerIO = do
    worker <- ask
    pure worker.workerLogFn

runWorkerM :: WorkflowWorker env -> WorkerM env a -> IO a
runWorkerM worker m = runReaderT (unWorkerM m) worker

pollWorkflowActivation :: WorkerM env (Either Core.WorkerError Core.WorkflowActivation)
pollWorkflowActivation = do
  worker <- ask
  liftIO $ Core.pollWorkflowActivation worker.workerCore

queueAsyncWorkerTask :: WorkerM env a -> WorkerM env ()
queueAsyncWorkerTask task = void $ async task
  -- TODO job pool stuff maybe doesn't work
  -- do
  -- worker <- ask
  -- liftIO $ enqueueJob_ worker.workerJobPool $ runWorkerM worker task

upsertWorkflowInstance :: RunId -> WorkflowInstance env -> WorkerM env (WorkflowInstance env)
upsertWorkflowInstance r inst = do
  worker <- ask
  liftIO $ atomically $ do
    workflows <- takeTMVar worker.runningWorkflows
    case HashMap.lookup r workflows of
      Nothing -> do
        let workflows' = HashMap.insert r inst workflows
        putTMVar worker.runningWorkflows workflows'
        pure inst
      Just existingInstance -> do
        putTMVar worker.runningWorkflows workflows
        pure existingInstance



-- | Execute this worker until poller shutdown or failure. If there is a failure, this may
-- need to be called a second time after shutdown initiated to ensure workflow activations
-- are drained.
--
-- The Async handle only completes successfully on poller shutdown.
withWorker :: forall m env a. (MonadLoggerIO m, MonadUnliftIO m) => Client -> WorkflowWorkerConfig env -> (Async () -> m a) -> m a
withWorker client conf f = do
  $(logDebug) "Starting worker"
  withAsync go f
  where
    withSomeJobPool :: forall a. (JobPool -> IO a) -> IO a
    withSomeJobPool f = case conf.jobPool of
      Nothing -> withJobPool (JobPoolOptions Nothing "temporal_workflow_activation_") f
      Just jobPool -> f jobPool
    go :: m ()
    go = withRunInIO $ \run -> withSomeJobPool $ \workerJobPool -> run $ do
      $(logDebug) "Got pool"
      workerCore <- either throwIO pure =<< liftIO (Core.newWorker client conf.coreConfig)
      $(logDebug) "Instantiated core"
      runningWorkflows <- newTMVarIO mempty
      deadlockedWorkflows <- newTVarIO mempty
      workerLogFn <- askLoggerIO
      let -- workerTaskQueue = conf.taskQueue
          workerWorkflowFunctions = conf.workflowDefinitions
          workerConfig = conf
          workerEnv = conf.configEnv
          workerTaskQueue = Core.taskQueue conf.coreConfig
          worker = WorkflowWorker{..}
      $(logDebug) "Starting worker loop"
      withAsync (liftIO $ execute worker) $ \workflowLoop -> do
        wait workflowLoop
        -- withAsync (activityLoop worker) $ \activityLoop -> do
          -- waitEitherCancel workflowLoop activityLoop
          -- cancel worker
          -- wait worker

execute :: WorkflowWorker env -> IO ()
execute worker = runWorkerM worker $ do
  let activationPoller = forever $ do
        $(logDebug) "Polling for activation"
        eActivation <- pollWorkflowActivation
        case eActivation of
          -- TODO would be nice to shut down more gracefully
          (Left s@(Core.WorkerError Core.PollShutdown _)) -> do
            $(logDebug) "Polling for activation failed"
            throwIO s
          (Left err) -> $(logError) $ Text.pack $ show err
          (Right activation) -> do
            $(logDebug) $ Text.pack ("Got activation " ++ show activation) 
            queueAsyncWorkerTask $ handleActivation activation
        
  activationPoller 
  deadlocks <- atomically $ readTVar $ deadlockedWorkflows worker
  when (not $ null deadlocks) $ do
    -- TODO proper logging
    $(logWarn) $ Text.pack ("Deadlocked workflows: " ++ show (HashMap.keys deadlocks))

nonEmptyString :: Text -> Maybe Text
nonEmptyString t = if Text.null t then Nothing else Just t

defaultRetryPolicy :: RetryPolicy
defaultRetryPolicy = RetryPolicy
  { initialInterval = Clock.TimeSpec 1 0
  , backoffCoefficient = 2
  , maximumInterval = Nothing
  , maximumAttempts = 0
  , nonRetryableErrorTypes = mempty
  }

retryPolicyFromProto :: Message.RetryPolicy -> RetryPolicy
retryPolicyFromProto p = RetryPolicy
  { initialInterval = maybe (initialInterval defaultRetryPolicy) timespecFromDuration (p ^. Message.maybe'initialInterval)
  , backoffCoefficient = p ^. Message.backoffCoefficient
  , maximumInterval = maybe (maximumInterval defaultRetryPolicy) (Just . timespecFromDuration) (p ^. Message.maybe'maximumInterval)
  , maximumAttempts = p ^. Message.maximumAttempts
  , nonRetryableErrorTypes = p ^. Message.vec'nonRetryableErrorTypes
  }

handleActivation :: Core.WorkflowActivation -> WorkerM env ()
handleActivation activation = do
  $(logDebug) "Handling activation"
  worker <- ask
  {-
  Run jobs
  -}
  completion <- if shouldRun
    then do
      $(logDebug) "Running workflow"
      inst <- createOrFetchWorkflowInstance
      $(logDebug) "Creates instance"
      -- This deadlock code seems suspect, but really it's because the workflow code
      -- shouldn't be able to block indefinitely on a single thread before returning
      -- a result. If it does, it's a bug in the workflow code.
      --
      -- Other languages have a custom run loop that yields, but we aren't doing that (yet?)
      -- I want to understand if the RTS itself is sufficient for this.
      completionHandle <- async $ do
        $(logDebug) "About to activate"
        liftIO $ activate inst activation
      mCompletion <- case worker.workerConfig.deadlockTimeout of
        Nothing -> do
          $(logDebug) "Waiting forever for completion"
          Just <$> wait completionHandle
        -- TODO ensure timeout is in microseconds
        Just microsecs -> do
          $(logDebug) "Waiting for completion"
          timeout microsecs $ wait completionHandle
      let eResult = case mCompletion of
            -- TODO show correct timeout value
            Nothing -> Left $ RuntimeError "Potential deadlock detected for workflow" --  <> show (activation ^. Activation.runId) <> " in namespace " <> show (activation ^. Activation.namespace) <> ". Workflow didn't yield within " <> show 1 <> " seconds.")
            Just result -> Right result
      case eResult of
        Left err -> do
          $(logDebug) "Workflow failure"
          -- TODO there are lots of fields on this failureProto that we probably want to fill in
          let failureProto = defMessage
                -- & Activation.message .~ (Text.pack $ show err)
              completionMessage = defMessage
                & Completion.runId .~ activation ^. Activation.runId
                & Completion.failed .~ failureProto
          pure completionMessage
        Right ok -> do
          $(logDebug) $ Text.pack ("Workflow completion: " ++ show ok)
          pure ok 
    else do
      $(logDebug) "Workflow does not need to run."
      pure $ defMessage 
        & Completion.runId .~ activation ^. Activation.runId
        & Completion.successful .~ defMessage

  $(logDebug) (Text.pack $ show completion)
  eCompletionResult <- liftIO $ Core.completeWorkflowActivation worker.workerCore completion
  -- Crash the worker
  case eCompletionResult of
    -- TODO should we shut down more gracefully before escaping?
    Left err -> do
      $(logError) $ Text.pack $ show err
      throwIO err
    Right () -> $(logDebug) "Completed workflow activation"

  removeEvictedWorkflowInstances

  where
    shouldRun :: Bool
    shouldRun = moreThanOneJob || not removeFromCacheJob
      where 
        jobs = activation ^. Activation.vec'jobs
        removeFromCacheJob = V.any (\j -> isJust (j ^. Activation.maybe'removeFromCache)) jobs
        moreThanOneJob = V.length jobs > 1
    -- Job signaling that a workflow should be removed from the cache
    -- mRemoveJob = findthing (jobs . maybe'variant_ . just_ . _WorkflowActivationJob'RemoveFromCache) activation
    activationStartWorkflowJobs :: Vector (WorkflowActivationJob, StartWorkflow)
    activationStartWorkflowJobs = V.mapMaybe 
      (\rawJob -> 
        case rawJob ^. Activation.maybe'variant of
          Just (WorkflowActivationJob'StartWorkflow startWorkflow) -> Just (rawJob, startWorkflow)
          _ -> Nothing
      )
      (activation ^. Activation.vec'jobs)

    createOrFetchWorkflowInstance :: WorkerM env (WorkflowInstance env)
    createOrFetchWorkflowInstance = do
      worker <- ask
      runningWorkflows_ <- atomically $ readTMVar worker.runningWorkflows
      case HashMap.lookup (RunId $ activation ^. Activation.runId) runningWorkflows_ of
        Just inst -> pure inst
        Nothing -> do
          vExistingInstance <- forM activationStartWorkflowJobs $ \(job, startWorkflow) -> do
            let runId_ = RunId $ activation ^. CommonProto.runId
                parentProto = startWorkflow ^. Activation.maybe'parentWorkflowInfo
                parentInfo = case parentProto of
                  Nothing -> Nothing
                  Just parent -> Just ParentInfo
                    { parentNamespace = Namespace $ parent ^. CommonProto.namespace
                    , parentRunId = RunId $ parent ^. CommonProto.runId
                    , parentWorkflowId = WorkflowId $ parent ^. CommonProto.workflowId
                    }
                workflowInfo = Info
                  { attempt = fromIntegral $ startWorkflow ^. Activation.attempt
                  , taskQueue = TaskQueue $ worker.workerTaskQueue
                  , workflowId = WorkflowId $ startWorkflow ^. Activation.workflowId
                  , workflowType = startWorkflow ^. Activation.workflowType . to WorkflowType
                  , continuedRunId = fmap RunId $ startWorkflow ^. Activation.continuedFromExecutionRunId . to nonEmptyString
                  , cronSchedule = startWorkflow ^. Activation.cronSchedule . to nonEmptyString
                  , taskTimeout = startWorkflow ^. Activation.workflowTaskTimeout . to timespecFromDuration
                  , executionTimeout = fmap timespecFromDuration $ startWorkflow ^. Activation.maybe'workflowExecutionTimeout
                  , namespace = Namespace $ Core.namespace $ Core.getWorkerConfig worker.workerCore
                  , parent = parentInfo
                  -- TODO
                  , headers = mempty
                  -- , rawMemo :: what is this
                  , retryPolicy = retryPolicyFromProto <$> startWorkflow ^. Activation.maybe'retryPolicy
                  , runId = RunId $ activation ^. CommonProto.runId
                  , runTimeout = fmap timespecFromDuration $ startWorkflow ^. Activation.maybe'workflowRunTimeout
                  -- , searchAttributes =
                  , startTime = timespecFromTimestamp $ 
                      fromMaybe 
                        (activation ^. Activation.timestamp) 
                        (startWorkflow ^. Activation.maybe'startTime)
                  }
            case HashMap.lookup (startWorkflow ^. Activation.workflowType) worker.workerWorkflowFunctions of 
              Nothing -> throwIO $ RuntimeError "No workflow definition found"
              Just definition -> do
                inst <- create workflowInfo definition
                upsertWorkflowInstance runId_ inst
          case vExistingInstance V.!? 0 of
            Nothing -> throwIO $ RuntimeError "No workflow definition found"
            Just inst -> pure inst
      
    removeEvictedWorkflowInstances :: WorkerM env ()
    removeEvictedWorkflowInstances = forM_ (activation ^. Activation.vec'jobs) $ \job -> do
      case job ^. Activation.maybe'variant of
        Just (WorkflowActivationJob'RemoveFromCache removeFromCache) -> do
          worker <- ask
          let runId_ = RunId $ activation ^. CommonProto.runId
          -- TODO figure out if there's anything we need to do to the WorkflowInstance before removing it
          join $ atomically $ do
            currentWorkflows <- takeTMVar worker.runningWorkflows
            putTMVar worker.runningWorkflows $ HashMap.delete runId_ currentWorkflows
            case HashMap.lookup runId_ currentWorkflows of
              Nothing -> pure $ $(logDebug) $ Text.pack ("Eviction request on an unknown workflow with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
              Just _ -> pure $ $(logDebug) $ Text.pack ("Evicting workflow instance with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
        _ -> pure ()


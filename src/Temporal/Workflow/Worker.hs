{-# LANGUAGE TemplateHaskell #-}
module Temporal.Workflow.Worker where

import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Vector as V
import Temporal.Common
import qualified Temporal.Core.Client as C
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Workflow.Internal.Monad
import Temporal.Payload
import Temporal.Workflow.Definition
import Temporal.WorkflowInstance
import Temporal.SearchAttributes.Internal
import UnliftIO
import Lens.Family2
import Data.ProtoLens
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as CommonProto
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import Temporal.Duration (durationFromProto)
import Temporal.Core.Worker (InactiveForReplay)

data WorkflowWorker = forall ty. WorkflowWorker
  { workerWorkflowFunctions :: HashMap Text WorkflowDefinition
  , runningWorkflows :: TVar (HashMap RunId WorkflowInstance)
  , workerClient :: InactiveForReplay ty C.Client
  , workerCore :: Core.Worker ty
  , workerInboundInterceptors :: WorkflowInboundInterceptor
  , workerOutboundInterceptors :: WorkflowOutboundInterceptor
  , workerDeadlockTimeout :: Maybe Int
  , workerTaskQueue :: TaskQueue
  , workerErrorConverters :: [ApplicationFailureHandler]
  }

pollWorkflowActivation :: (MonadLoggerIO m) => ReaderT WorkflowWorker m (Either Core.WorkerError Core.WorkflowActivation)
pollWorkflowActivation = do
  WorkflowWorker{workerCore} <- ask
  liftIO $ Core.pollWorkflowActivation workerCore

upsertWorkflowInstance :: (MonadLoggerIO m) => RunId -> WorkflowInstance -> ReaderT WorkflowWorker m WorkflowInstance
upsertWorkflowInstance r inst = do
  worker <- ask
  liftIO $ atomically $ do
    workflows <- readTVar worker.runningWorkflows
    case HashMap.lookup r workflows of
      Nothing -> do
        let workflows' = HashMap.insert r inst workflows
        writeTVar worker.runningWorkflows workflows'
        pure inst
      Just existingInstance -> do
        writeTVar worker.runningWorkflows workflows
        pure existingInstance



-- | Execute this worker until poller shutdown or failure. If there is a failure, this may
-- need to be called a second time after shutdown initiated to ensure workflow activations
-- are drained.
--
-- The Async handle only completes successfully on poller shutdown.

execute :: (MonadLoggerIO m, MonadUnliftIO m) => WorkflowWorker -> m ()
execute worker = flip runReaderT worker $ do
  $(logInfo) "Starting workflow worker"
  go

  where
    go = do
      $(logDebug) "Polling for activation"
      eActivation <- pollWorkflowActivation
      case eActivation of
        -- TODO should we do anything else on shutdown?
        (Left (Core.WorkerError Core.PollShutdown _)) -> do
          $(logDebug) "Poller shutting down"
          runningWorkflows <- readTVarIO worker.runningWorkflows
          mapM_ (cancel <=< readIORef . executionThread) runningWorkflows
        (Left err) -> do
          $(logError) $ Text.pack $ show err
          go
        (Right activation) -> do
          $(logDebug) $ Text.pack ("Got activation " <> show activation) 
          -- We want to handle activations as fast as possible, so we don't want to block
          -- on dispatching jobs.
          _ <- async $ handleActivation activation
          go
      

handleActivation :: forall m. (MonadLoggerIO m) => Core.WorkflowActivation -> ReaderT WorkflowWorker m ()
handleActivation activation = do
  $(logDebug) ("Handling activation: RunId " <> Text.pack (show (activation ^. Activation.runId)))
  forM_ (activation ^. Activation.jobs) $ \job -> do
    $(logDebug) ("Job: " <> Text.pack (show job))
  WorkflowWorker{workerCore} <- ask

  {-
  Run jobs
  -}
  if shouldRun
    then do
      mInst <- createOrFetchWorkflowInstance
      case mInst of
        Nothing -> do
          $logInfo "No workflow definition found"
          let failureProto = defMessage
                & Completion.failure .~ 
                  ( defMessage 
                    & F.message .~ "No workflow definition found"
                    & F.applicationFailureInfo .~ 
                      ( defMessage 
                        & F.type' .~ "NotFound"
                        & F.nonRetryable .~ False
                      )
                  )
              completionMessage = defMessage
                & Completion.runId .~ (activation ^. Activation.runId)
                & Completion.failed .~ failureProto
          
          liftIO (Core.completeWorkflowActivation workerCore completionMessage >>= either throwIO pure)
        Just inst -> do
          let withoutStart = filter (\job -> not $ isJust (job ^. Activation.maybe'startWorkflow)) (activation ^. Activation.jobs)
          case withoutStart of
            [] -> pure ()
            otherJobs -> writeChan inst.activationChannel (activation & Activation.jobs .~ otherJobs)
    else do
      $(logDebug) "Workflow does not need to run."
      let completionMessage = defMessage 
            & Completion.runId .~ activation ^. Activation.runId
            & Completion.successful .~ defMessage
      liftIO (Core.completeWorkflowActivation workerCore completionMessage >>= either throwIO pure)

  removeEvictedWorkflowInstances

  where
    shouldRun :: Bool
    shouldRun = moreThanOneJob || not removeFromCacheJob
      where 
        jobs = activation ^. Activation.vec'jobs
        removeFromCacheJob = V.any (\j -> isJust (j ^. Activation.maybe'removeFromCache)) jobs
        moreThanOneJob = V.length jobs > 1

    activationStartWorkflowJobs :: V.Vector (WorkflowActivationJob, StartWorkflow)
    activationStartWorkflowJobs = V.mapMaybe 
      (\rawJob -> 
        case rawJob ^. Activation.maybe'variant of
          Just (WorkflowActivationJob'StartWorkflow startWorkflow) -> Just (rawJob, startWorkflow)
          _ -> Nothing
      )
      (activation ^. Activation.vec'jobs)

    createOrFetchWorkflowInstance :: ReaderT WorkflowWorker m (Maybe WorkflowInstance)
    createOrFetchWorkflowInstance = do
      worker@WorkflowWorker{workerCore} <- ask
      runningWorkflows_ <- atomically $ readTVar worker.runningWorkflows
      case HashMap.lookup (RunId $ activation ^. Activation.runId) runningWorkflows_ of
        Just inst -> pure $ Just inst
        Nothing -> do
          vExistingInstance <- forM activationStartWorkflowJobs $ \(_job, startWorkflow) -> do
            searchAttrs <- liftIO $ do
              decodedAttrs <- startWorkflow ^. Activation.searchAttributes . Message.indexedFields . to searchAttributesFromProto
              either (throwIO . ValueError) pure decodedAttrs
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
                  { historyLength = activation ^. Activation.historyLength
                  , attempt = fromIntegral $ startWorkflow ^. Activation.attempt
                  , taskQueue = worker.workerTaskQueue
                  , workflowId = WorkflowId $ startWorkflow ^. Activation.workflowId
                  , workflowType = startWorkflow ^. Activation.workflowType . to WorkflowType
                  , continuedRunId = fmap RunId $ startWorkflow ^. Activation.continuedFromExecutionRunId . to nonEmptyString
                  , cronSchedule = startWorkflow ^. Activation.cronSchedule . to nonEmptyString
                  , taskTimeout = startWorkflow ^. Activation.workflowTaskTimeout . to durationFromProto
                  , executionTimeout = fmap durationFromProto $ startWorkflow ^. Activation.maybe'workflowExecutionTimeout
                  , namespace = Namespace $ Core.namespace $ Core.getWorkerConfig workerCore
                  , parent = parentInfo
                  , headers = startWorkflow ^. Activation.headers . to (fmap convertFromProtoPayload)
                  , rawMemo = startWorkflow ^. Activation.memo . Message.fields . to (fmap convertFromProtoPayload)
                  , searchAttributes = searchAttrs
                  , retryPolicy = retryPolicyFromProto <$> startWorkflow ^. Activation.maybe'retryPolicy
                  , runId = RunId $ activation ^. CommonProto.runId
                  , runTimeout = fmap durationFromProto $ startWorkflow ^. Activation.maybe'workflowRunTimeout
                  , startTime = timespecFromTimestamp $ 
                      fromMaybe 
                        (activation ^. Activation.timestamp) 
                        (startWorkflow ^. Activation.maybe'startTime)
                  }
            case HashMap.lookup (startWorkflow ^. Activation.workflowType) worker.workerWorkflowFunctions of 
              Nothing -> pure Nothing
              Just (WorkflowDefinition _ f) -> do
                inst <- create
                  (\wf -> do
                    putStrLn "Complete activation"
                    Core.completeWorkflowActivation workerCore wf
                  )
                  f
                  worker.workerDeadlockTimeout
                  worker.workerErrorConverters
                  worker.workerInboundInterceptors
                  worker.workerOutboundInterceptors
                  workflowInfo 
                  startWorkflow
                liftIO $ addStackTraceHandler inst
                Just <$> upsertWorkflowInstance runId_ inst
          pure $ join (vExistingInstance V.!? 0)
      
    removeEvictedWorkflowInstances :: ReaderT WorkflowWorker m ()
    removeEvictedWorkflowInstances = forM_ (activation ^. Activation.vec'jobs) $ \job -> do
      case job ^. Activation.maybe'variant of
        Just (WorkflowActivationJob'RemoveFromCache removeFromCache) -> do
          worker <- ask
          let runId_ = RunId $ activation ^. CommonProto.runId
          join $ atomically $ do
            currentWorkflows <- readTVar worker.runningWorkflows
            writeTVar worker.runningWorkflows $ HashMap.delete runId_ currentWorkflows
            case HashMap.lookup runId_ currentWorkflows of
              Nothing -> pure $ $(logDebug) $ Text.pack ("Eviction request on an unknown workflow with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
              Just wf -> do
                pure $ do
                  cancel =<< readIORef wf.executionThread
                  $(logDebug) $ Text.pack ("Evicting workflow instance with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
        _ -> pure ()

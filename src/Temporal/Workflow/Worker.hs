{-# LANGUAGE TemplateHaskell #-}
module Temporal.Workflow.Worker where

import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe
import qualified Data.Text as Text
import qualified Data.Vector as V
import Temporal.Common
import Temporal.Core.Client
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Internal.JobPool
import Temporal.Worker.Types
import Temporal.WorkflowInstance
import Temporal.Workflow.Unsafe
import UnliftIO
import Lens.Family2
import Lens.Family2.Stock
import Data.ProtoLens
import Data.ProtoLens.Combinators
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as CommonProto
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Completion
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import qualified Proto.Temporal.Api.Failure.V1.Message as F
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F

pollWorkflowActivation :: WorkerM wfEnv actEnv (Either Core.WorkerError Core.WorkflowActivation)
pollWorkflowActivation = do
  worker <- ask
  liftIO $ Core.pollWorkflowActivation worker.workerCore

upsertWorkflowInstance :: RunId -> WorkflowInstance wfEnv st -> WorkerM wfEnv actEnv (OpaqueWorkflow WorkflowInstance wfEnv)
upsertWorkflowInstance r inst = do
  worker <- ask
  liftIO $ atomically $ do
    workflows <- readTVar worker.workerWorkflowState.runningWorkflows
    case HashMap.lookup r workflows of
      Nothing -> do
        let opaque = OpaqueWorkflow inst
        let workflows' = HashMap.insert r opaque workflows
        writeTVar worker.workerWorkflowState.runningWorkflows workflows'
        pure opaque
      Just existingInstance -> do
        writeTVar worker.workerWorkflowState.runningWorkflows workflows
        pure existingInstance



-- | Execute this worker until poller shutdown or failure. If there is a failure, this may
-- need to be called a second time after shutdown initiated to ensure workflow activations
-- are drained.
--
-- The Async handle only completes successfully on poller shutdown.

execute :: Worker wfEnv actEnv -> IO ()
execute worker = runWorkerM worker $ do
  $(logInfo) "Starting workflow worker"
  go

  where
    go = do
      $(logDebug) "Polling for activation"
      eActivation <- pollWorkflowActivation
      case eActivation of
        -- TODO should we do anything else on shutdown?
        (Left s@(Core.WorkerError Core.PollShutdown _)) -> do
          $(logInfo) "Poller shutting down"
        (Left err) -> do
          $(logError) $ Text.pack $ show err
          go
        (Right activation) -> do
          $(logDebug) $ Text.pack ("Got activation " <> show activation) 
          _ <- async $ handleActivation activation
          go
      

handleActivation :: Core.WorkflowActivation -> WorkerM wfEnv actEnv ()
handleActivation activation = do
  $(logDebug) ("Handling activation: RunId " <> Text.pack (show (activation ^. Activation.runId)))
  forM_ (activation ^. Activation.jobs) $ \job -> do
    $(logDebug) ("Job: " <> Text.pack (show job))
  worker <- ask

  {-
  Run jobs
  -}
  if shouldRun
    then do
      $(logDebug) "Running workflow"
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
          
          liftIO (Core.completeWorkflowActivation worker.workerCore completionMessage >>= either throwIO pure)
        Just (OpaqueWorkflow inst) -> do
          -- This deadlock code seems suspect, but really it's because the workflow code
          -- shouldn't be able to block indefinitely on a single thread before returning
          -- a result. If it does, it's a bug in the workflow code.
          $(logDebug) "About to activate"
          completion <- liftIO $ UnliftIO.try $ activate worker inst activation

          case completion of
            Left (SomeException err) -> do
              $(logDebug) ("Workflow failure: " <> Text.pack (show err))
              -- TODO there are lots of fields on this failureProto that we probably want to fill in
              let innerFailure :: F.Failure
                  innerFailure = defMessage & F.message .~ (Text.pack $ show err)

                  failureProto :: Completion.Failure
                  failureProto = defMessage & Completion.failure .~ innerFailure
                    
                  completionMessage = defMessage
                    & Completion.runId .~ (activation ^. Activation.runId)
                    & Completion.failed .~ failureProto
              liftIO (Core.completeWorkflowActivation worker.workerCore completionMessage >>= either throwIO pure)
            Right ok -> do
              -- The workflow is in charge of flushing completions in the regular case
              -- when it needs to.
              pure () 
    else do
      $(logDebug) "Workflow does not need to run."
      let completionMessage = defMessage 
            & Completion.runId .~ activation ^. Activation.runId
            & Completion.successful .~ defMessage
      liftIO (Core.completeWorkflowActivation worker.workerCore completionMessage >>= either throwIO pure)

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

    createOrFetchWorkflowInstance :: WorkerM wfEnv actEnv (Maybe (OpaqueWorkflow WorkflowInstance wfEnv))
    createOrFetchWorkflowInstance = do
      worker <- ask
      runningWorkflows_ <- atomically $ readTVar worker.workerWorkflowState.runningWorkflows
      case HashMap.lookup (RunId $ activation ^. Activation.runId) runningWorkflows_ of
        Just inst -> pure $ Just inst
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
                  { historyLength = activation ^. Activation.historyLength
                  , attempt = fromIntegral $ startWorkflow ^. Activation.attempt
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
                  -- TODO
                  , rawMemo = mempty
                  -- TODO
                  , searchAttributes = mempty
                  , retryPolicy = retryPolicyFromProto <$> startWorkflow ^. Activation.maybe'retryPolicy
                  , runId = RunId $ activation ^. CommonProto.runId
                  , runTimeout = fmap timespecFromDuration $ startWorkflow ^. Activation.maybe'workflowRunTimeout
                  , startTime = timespecFromTimestamp $ 
                      fromMaybe 
                        (activation ^. Activation.timestamp) 
                        (startWorkflow ^. Activation.maybe'startTime)
                  }
            case HashMap.lookup (startWorkflow ^. Activation.workflowType) worker.workerWorkflowState.workerWorkflowFunctions of 
              Nothing -> pure Nothing
              Just (OpaqueWorkflow definition) -> do
                inst <- create 
                  (\wf -> do
                    putStrLn "Complete activation"
                    Core.completeWorkflowActivation worker.workerCore wf
                  )
                  workflowInfo 
                  worker.workerWorkflowState.workerEnv 
                  definition
                Just <$> upsertWorkflowInstance runId_ inst
          pure $ join (vExistingInstance V.!? 0)
      
    removeEvictedWorkflowInstances :: WorkerM wfEnv actEnv ()
    removeEvictedWorkflowInstances = forM_ (activation ^. Activation.vec'jobs) $ \job -> do
      case job ^. Activation.maybe'variant of
        Just (WorkflowActivationJob'RemoveFromCache removeFromCache) -> do
          worker <- ask
          let runId_ = RunId $ activation ^. CommonProto.runId
          join $ atomically $ do
            currentWorkflows <- readTVar worker.workerWorkflowState.runningWorkflows
            writeTVar worker.workerWorkflowState.runningWorkflows $ HashMap.delete runId_ currentWorkflows
            case HashMap.lookup runId_ currentWorkflows of
              Nothing -> pure $ $(logDebug) $ Text.pack ("Eviction request on an unknown workflow with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
              Just (OpaqueWorkflow wf) -> pure $ do
                mTask <- readIORef wf.workflowPrimaryTask
                mapM_ cancel mTask
                $(logDebug) $ Text.pack ("Evicting workflow instance with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
        _ -> pure ()

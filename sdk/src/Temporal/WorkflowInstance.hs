{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

module Temporal.WorkflowInstance (
  WorkflowInstance,
  Info (..),
  create,
  activate,
  addCommand,
  nextActivitySequence,
  nextChildWorkflowSequence,
  nextExternalCancelSequence,
  nextExternalSignalSequence,
  nextTimerSequence,
  nextConditionSequence,
  addStackTraceHandler,
) where

import Control.Applicative
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader


#if __GLASGOW_HASKELL__ < 910
import Data.Foldable (foldl')
#endif
import Data.Functor.Identity
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens
import Data.Proxy
import Data.Set (Set)
import qualified Data.Set as Set
import qualified Data.Text as Text
import Data.Time.Clock.System (SystemTime (..))
import Data.Vault.Strict (Vault)
import Data.Vector (Vector)
import qualified Data.Vector as V
import GHC.Stack (HasCallStack, emptyCallStack)
import Lens.Family2
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow (
  StartChildWorkflowExecutionFailedCause (..),
 )
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation (
  CancelWorkflow,
  DoUpdate,
  FireTimer,
  InitializeWorkflow,
  NotifyHasPatch,
  QueryWorkflow,
  ResolveActivity,
  ResolveChildWorkflowExecution,
  ResolveChildWorkflowExecutionStart,
  ResolveChildWorkflowExecutionStart'Status (..),
  ResolveRequestCancelExternalWorkflow,
  ResolveSignalExternalWorkflow,
  SignalWorkflow,
  UpdateRandomSeed,
  WorkflowActivation,
  WorkflowActivationJob,
  WorkflowActivationJob'Variant (..),
 )
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Completion
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import RequireCallStack (provideCallStack)
import System.Random (mkStdGen)
import Temporal.Common
import qualified Temporal.Common.Logging as Logging
import qualified Temporal.Core.Worker as Core
import Temporal.Coroutine
import Temporal.Duration
import Temporal.Exception
import qualified Temporal.Exception as Err
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.Eval (ActivationResult (..), SuspendableWorkflowExecution, injectWorkflowSignalOrUpdate, runWorkflow)
import Temporal.Workflow.Internal.Instance
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Types
import UnliftIO


create
  :: (HasCallStack, MonadLoggerIO m)
  => (Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  -> (Vector Payload -> IO (Either String (Workflow Payload)))
  -> Maybe Int
  -- ^ deadlock timeout in seconds
  -> [ApplicationFailureHandler]
  -> WorkflowInboundInterceptor
  -> WorkflowOutboundInterceptor
  -> Vault
  -> PayloadProcessor
  -> Info
  -> InitializeWorkflow
  -> m WorkflowInstance
create
  workflowCompleteActivation
  workflowFn
  workflowDeadlockTimeout
  errorConverters
  inboundInterceptor
  outboundInterceptor
  workflowVault
  payloadProcessor
  info
  start = do
    Logging.logDebug "Instantiating workflow instance"
    workflowInstanceLogger <- askLoggerIO
    workflowRandomnessSeed <- WorkflowGenM <$> newIORef (mkStdGen 0)
    workflowNotifiedPatches <- newIORef mempty
    workflowMemoizedPatches <- newIORef mempty
    workflowSequences <-
      newIORef
        Sequences
          { externalCancel = 1
          , childWorkflow = 1
          , externalSignal = 1
          , timer = 1
          , activity = 1
          , condition = 1
          , varId = 1
          }
    workflowTime <- newIORef $ MkSystemTime 0 0
    workflowIsReplaying <- newIORef False
    workflowSequenceMaps <- newTVarIO $ SequenceMaps mempty mempty mempty mempty mempty mempty
    workflowCommands <- newTVarIO $ Reversed []
    workflowSignalHandlers <- newIORef mempty
    workflowCallStack <- newIORef emptyCallStack
    workflowQueryHandlers <- newIORef mempty
    workflowUpdateHandlers <- newIORef mempty
    workflowInstanceInfo <- newIORef info
    workflowInstanceContinuationEnv <- ContinuationEnv <$> newIORef JobNil
    workflowCancellationVar <- newIVar
    activationChannel <- newTQueueIO
    executionThread <- newIORef (error "Workflow thread not yet started")
    -- The execution thread is funny because it needs access to the instance, but the instance
    -- needs access to the execution thread. It's a bit of a circular dependency, but
    -- pretty innocuous since writing to the executionThread var happens before anything else
    -- is allowed to interact with the instance.
    let inst = WorkflowInstance {..}
    workerThread <- liftIO $ async $ runInstanceM inst $ do
      Logging.logDebug "Start workflow execution thread"
      exec <- setUpWorkflowExecution start
      res <- liftIO $ inboundInterceptor.executeWorkflow exec $ \exec' -> runInstanceM inst $ runTopLevel $ do
        Logging.logDebug "Executing workflow"
        wf <- applyStartWorkflow exec' workflowFn
        runWorkflowToCompletion wf
      Logging.logDebug "Workflow execution completed"
      addCommand =<< convertExitVariantToCommand res
      flushCommands
      Logging.logDebug "Handling leftover queries"
      handleQueriesAfterCompletion
    -- If we have an exception crash the workflow thread, then we need to throw to the worker too,
    -- otherwise it will just hang forever.
    link workerThread
    writeIORef executionThread workerThread
    pure inst


runWorkflowToCompletion :: HasCallStack => SuspendableWorkflowExecution Payload -> InstanceM Payload
runWorkflowToCompletion wf = do
  inst <- ask
  let completeStep :: Await [ActivationResult] (SuspendableWorkflowExecution Payload) -> InstanceM (SuspendableWorkflowExecution Payload)
      completeStep suspension = do
        Logging.logDebug "Awaiting activation results from workflow"
        -- If the workflow is blocked, then we necessarily have to signal the temporal-core
        -- that we are stuck. Once we get unstuck (e.g. something is in the activation channel)
        -- then we can resume the workflow.
        --
        -- There are a few cases like singalWithStart where a workflow will reach a blocking
        -- state, but we aren't actually ready to flush the commands yet. So, we read
        -- from the activation channel and resume the workflow until the channel is emptied.
        --
        -- Once we're blocked in that way, then we should flush the commands and wait for
        -- the next activation(s?).
        activation <- join $ atomically $ do
          mActivition <- tryReadTQueue inst.activationChannel
          case mActivition of
            Nothing -> do
              pure $ do
                flushCommands
                atomically $ readTQueue inst.activationChannel
            Just act -> pure $ pure act
        fmap runIdentity $ activate activation $ Identity suspension
  supplyM completeStep wf


{- | This runs indefinitely, handling queries that come in after the workflow has completed.

Termination occurs when we receive an eviction signal from Temporal. At that point,
the thread has 'cancel' called on it, which breaks us out of the loop.

TODO perhaps we need to ensure that any any completed queries have added their commands
to the command queue before we exit this loop?
-}
handleQueriesAfterCompletion :: InstanceM ()
handleQueriesAfterCompletion = forever $ do
  w <- ask
  activation <- atomically . readTQueue =<< asks activationChannel
  completion <- UnliftIO.try $ activate activation Proxy

  case completion of
    Left err -> do
      Logging.logDebug ("Workflow failure: " <> Text.pack (show err))
      let appFailure = mkApplicationFailure err w.errorConverters
          enrichedApplicationFailure = applicationFailureToFailureProto appFailure

          failureProto :: Completion.Failure
          failureProto = defMessage & Completion.failure .~ enrichedApplicationFailure

          completionMessage =
            defMessage
              & Completion.runId .~ (activation ^. Activation.runId)
              & Completion.failed .~ failureProto
      inst <- ask
      liftIO (inst.workflowCompleteActivation completionMessage >>= either throwIO pure)
    Right Proxy -> do
      -- At this point, the workflow isn't running, so we can always flush the commands.
      flushCommands


{- | This is a special query handler that is added to every workflow instance.

It allows the Temporal UI to query the current call stack to see what is currently happening
in the workflow.
-}
addStackTraceHandler :: WorkflowInstance -> IO ()
addStackTraceHandler inst = do
  let specialHandler _ _ _ = do
        cs <- readIORef inst.workflowCallStack
        Right <$> Temporal.Payload.encode JSON (Text.pack $ Temporal.Exception.prettyCallStack cs)
  modifyIORef' inst.workflowQueryHandlers (HashMap.insert (Just "__stack_trace") specialHandler)


-- This should never raise an exception, but instead catch all exceptions
-- and set as completion failure.
activate
  :: Functor f
  => WorkflowActivation
  -> f (Await [ActivationResult] (SuspendableWorkflowExecution Payload))
  -> InstanceM (f (SuspendableWorkflowExecution Payload))
activate act suspension = do
  inst <- ask
  info <- atomicModifyIORef' inst.workflowInstanceInfo $ \info ->
    let info' =
          info
            { historyLength = act ^. Activation.historyLength
            , continueAsNewSuggested = act ^. Activation.continueAsNewSuggested
            }
    in (info', info')
  let completionBase = defMessage & Completion.runId .~ rawRunId info.runId
  writeIORef inst.workflowTime (act ^. Activation.timestamp . to timespecFromTimestamp)
  writeIORef inst.workflowIsReplaying (act ^. Activation.isReplaying)
  eResult <- case inst.workflowDeadlockTimeout of
    Nothing -> applyJobs (act ^. Activation.vec'jobs) suspension
    Just timeoutDuration -> do
      res <- UnliftIO.timeout timeoutDuration $ applyJobs (act ^. Activation.vec'jobs) suspension
      case res of
        Nothing -> do
          Logging.logError "Deadlock detected"
          pure $ Left $ toException $ LogicBug WorkflowActivationDeadlock
        Just res' -> pure res'
  -- TODO: Can the completion send both successful commands and a failure
  -- message at the same time? In theory we can make partial progress on
  -- a workflow, but still fail at some point?
  case eResult of
    Left err -> do
      Logging.logWarn "Failed activation on workflow" -- <> toLogStr (show $ workflowType info) <> " with ID " <> toLogStr (workflowId info) <> " and run ID " <> toLogStr (runId info))
      -- TODO, failures should have source / stack trace info
      -- TODO, convert failure type using a supplied payload converter
      let failure =
            defMessage
              & Completion.failure .~ (defMessage & Failure.message .~ Text.pack (show err))
          completion =
            completionBase
              & Completion.failed .~ failure
      liftIO (inst.workflowCompleteActivation completion >>= either throwIO pure)
      -- I think it's morally okay to crash the worker thread here.
      throwIO err
    Right f -> pure f


-- | This gives us the basic state for a workflow instance prior to initial evaluation.
setUpWorkflowExecution :: InitializeWorkflow -> InstanceM ExecuteWorkflowInput
setUpWorkflowExecution initializeWorkflow = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ initializeWorkflow ^. Activation.randomnessSeed)
  writeIORef inst.workflowTime (initializeWorkflow ^. Activation.startTime . to timespecFromTimestamp)
  info <- readIORef inst.workflowInstanceInfo

  pure $
    ExecuteWorkflowInput
      { executeWorkflowInputType = initializeWorkflow ^. Activation.workflowType
      , executeWorkflowInputArgs = fmap convertFromProtoPayload (initializeWorkflow ^. Command.vec'arguments)
      , executeWorkflowInputHeaders = fmap convertFromProtoPayload (initializeWorkflow ^. Activation.headers)
      , executeWorkflowInputInfo = info
      }


applyStartWorkflow :: ExecuteWorkflowInput -> (Vector Payload -> IO (Either String (Workflow Payload))) -> InstanceM (SuspendableWorkflowExecution Payload)
applyStartWorkflow execInput workflowFn = do
  inst <- ask
  let executeWorkflowBase input = runInstanceM inst $ do
        Logging.logInfo $
          Text.concat
            [ "Starting workflow: "
            , "namespace="
            , rawNamespace input.executeWorkflowInputInfo.namespace
            , " "
            , "taskQueue="
            , rawTaskQueue input.executeWorkflowInputInfo.taskQueue
            , " "
            , "workflowType="
            , input.executeWorkflowInputType
            , " "
            , "workflowId="
            , rawWorkflowId input.executeWorkflowInputInfo.workflowId
            ]
        eAct <- liftIO (workflowFn =<< processorDecodePayloads inst.payloadProcessor input.executeWorkflowInputArgs)
        case eAct of
          Left msg -> do
            Logging.logError $ Text.pack ("Failed to decode workflow arguments: " <> msg)
            throwIO (ValueError msg)
          Right act -> do
            Logging.logDebug "Calling runWorkflow"
            pure (runWorkflow act)

  liftIO $ executeWorkflowBase execInput


applyUpdateRandomSeed :: UpdateRandomSeed -> InstanceM ()
applyUpdateRandomSeed updateRandomSeed = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ updateRandomSeed ^. Activation.randomnessSeed)


applyQueryWorkflow :: HasCallStack => QueryWorkflow -> InstanceM ()
applyQueryWorkflow queryWorkflow = do
  inst <- ask
  handles <- readIORef inst.workflowQueryHandlers
  Logging.logDebug $ Text.pack ("Applying query: " <> show (queryWorkflow ^. Activation.queryType))
  let processor = inst.payloadProcessor
  args <- processorDecodePayloads processor (fmap convertFromProtoPayload (queryWorkflow ^. Command.vec'arguments))
  let baseInput =
        HandleQueryInput
          { handleQueryId = QueryId (queryWorkflow ^. Activation.queryId)
          , handleQueryInputType = queryWorkflow ^. Activation.queryType
          , handleQueryInputArgs = args
          , handleQueryInputHeaders = fmap convertFromProtoPayload (queryWorkflow ^. Activation.headers)
          }
  res <- liftIO $ inst.inboundInterceptor.handleQuery baseInput $ \input -> do
    let handlerOrDefault =
          HashMap.lookup (Just input.handleQueryInputType) handles
            <|> HashMap.lookup Nothing handles
    case handlerOrDefault of
      Nothing -> do
        pure $ Left $ toException $ QueryNotFound $ Text.unpack input.handleQueryInputType
      Just h ->
        liftIO $
          h
            input.handleQueryId
            input.handleQueryInputArgs
            input.handleQueryInputHeaders
  cmd <- case res of
    Left err ->
      -- TODO, more useful error message
      pure $
        defMessage
          & Command.failed
            .~ ( defMessage
                  & F.message .~ Text.pack (show err)
               )
    Right ok -> do
      res' <- liftIO $ payloadProcessorEncode processor ok
      pure $
        defMessage
          & Command.queryId .~ rawQueryId baseInput.handleQueryId
          & Command.succeeded
            .~ ( defMessage
                  & Command.response .~ convertToProtoPayload res'
               )
  addCommand $ defMessage & Command.respondToQuery .~ cmd


applySignalWorkflow :: SignalWorkflow -> Workflow ()
applySignalWorkflow signalWorkflow = join $ do
  Workflow $ \_ -> do
    inst <- ask
    handlers <- readIORef inst.workflowSignalHandlers
    let handlerOrDefault =
          HashMap.lookup (Just (signalWorkflow ^. Activation.signalName)) handlers
            <|> HashMap.lookup Nothing handlers
    case handlerOrDefault of
      Nothing -> pure $ Done $ do
        Logging.logWarn $ Text.pack ("No signal handler found for signal: " <> show (signalWorkflow ^. Activation.signalName))
        pure ()
      Just handler -> do
        eInputs <- UnliftIO.try $ processorDecodePayloads inst.payloadProcessor (fmap convertFromProtoPayload (signalWorkflow ^. Command.vec'input))
        case eInputs of
          Left err -> pure $ Throw err
          Right args -> pure $ Done $ do
            Logging.logDebug $ Text.pack ("Applying signal handler for signal: " <> show (signalWorkflow ^. Activation.signalName))
            handler args


applyDoUpdateWorkflow :: DoUpdate -> Workflow ()
applyDoUpdateWorkflow doUpdate = provideCallStack do
  (validator, updateAction) <- ilift do
    inst <- ask
    handlers <- readIORef inst.workflowUpdateHandlers
    let handlerAndValidatorOrDefault =
          HashMap.lookup (Just (doUpdate ^. Activation.name)) handlers
            <|> HashMap.lookup Nothing handlers
    case handlerAndValidatorOrDefault of
      Nothing -> do
        let errMessage = Text.pack ("No update handler found for update: " <> show (doUpdate ^. Activation.name))
        let err = mkApplicationFailure (toException $ UpdateNotFound errMessage) inst.errorConverters
        Logging.logWarn errMessage
        let cmd =
              defMessage
                & Command.updateResponse
                  .~ ( defMessage
                        & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                        & Command.rejected .~ applicationFailureToFailureProto err
                     )
        addCommand cmd
        pure (pure False, error "This should never happen")
      Just WorkflowUpdateImplementation {..} -> do
        updateArgs <- UnliftIO.try $ processorDecodePayloads inst.payloadProcessor (fmap convertFromProtoPayload (doUpdate ^. Activation.vec'input))
        let runValidator = doUpdate ^. Activation.runValidator
            updateId = UpdateId $ doUpdate ^. Activation.id
            updateHeaders = fmap convertFromProtoPayload (doUpdate ^. Activation.headers)
        case updateArgs of
          Left err ->
            pure
              ( do
                  addCommand $
                    defMessage
                      & Command.updateResponse
                        .~ ( defMessage
                              & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                              & Command.rejected .~ applicationFailureToFailureProto (mkApplicationFailure err inst.errorConverters)
                           )
                  pure False
              , error "Error processing update args"
              )
          Right args -> do
            let baseInput =
                  HandleUpdateInput
                    { handleUpdateId = updateId
                    , handleUpdateInputType = doUpdate ^. Activation.name
                    , handleUpdateInputArgs = args
                    , handleUpdateInputHeaders = updateHeaders
                    }
            let runUpdate = inst.inboundInterceptor.handleUpdate baseInput $ \input ->
                  updateImplementation input.handleUpdateId input.handleUpdateInputArgs input.handleUpdateInputHeaders
            pure $
              if runValidator
                then
                  ( do
                      eValidatorResult <- case updateValidationImplementation of
                        Nothing -> pure $ Right ()
                        Just f -> do
                          eResult <- UnliftIO.try $
                            liftIO $
                              inst.inboundInterceptor.validateUpdate baseInput $ \input ->
                                unValidation $ f input.handleUpdateId input.handleUpdateInputArgs input.handleUpdateInputHeaders
                          pure $ join eResult
                      case eValidatorResult of
                        Left err -> do
                          addCommand $
                            defMessage
                              & Command.updateResponse
                                .~ ( defMessage
                                      & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                                      & Command.rejected .~ applicationFailureToFailureProto (mkApplicationFailure err inst.errorConverters)
                                   )
                          pure False
                        Right () -> do
                          addCommand $
                            defMessage
                              & Command.updateResponse
                                .~ ( defMessage
                                      & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                                      & Command.accepted .~ defMessage
                                   )
                          pure True
                  , runUpdate
                  )
                else
                  ( do
                      addCommand $
                        defMessage
                          & Command.updateResponse
                            .~ ( defMessage
                                  & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                                  & Command.accepted .~ defMessage
                               )
                      pure True
                  , runUpdate
                  )
  runAction <- ilift validator
  when runAction $ do
    ePayload <- Temporal.Workflow.Internal.Monad.try updateAction
    Logging.logDebug "we executed the update!"
    Workflow $ \_env -> do
      inst <- ask
      case ePayload of
        Left err -> do
          Logging.logDebug "gonna send an update rejected message!"
          addCommand $
            defMessage
              & Command.updateResponse
                .~ ( defMessage
                      & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                      & Command.rejected .~ applicationFailureToFailureProto (mkApplicationFailure err inst.errorConverters)
                   )
          pure $ Throw err
        Right payload -> do
          Logging.logDebug "gonna send an update completed message!"
          payload' <- liftIO $ payloadProcessorEncode inst.payloadProcessor payload
          addCommand $
            defMessage
              & Command.updateResponse
                .~ ( defMessage
                      & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                      & Command.completed .~ convertToProtoPayload payload'
                   )
          pure $ Done ()


applyNotifyHasPatch :: NotifyHasPatch -> InstanceM ()
applyNotifyHasPatch notifyHasPatch = do
  inst <- ask
  let patches :: IORef (Set PatchId)
      patches = inst.workflowNotifiedPatches
  atomicModifyIORef' patches $ \patchSet -> (Set.insert (notifyHasPatch ^. Activation.patchId . to PatchId) patchSet, ())


data PendingJob
  = PendingJobResolveActivity ResolveActivity
  | PendingJobResolveChildWorkflowExecutionStart ResolveChildWorkflowExecutionStart
  | PendingJobResolveChildWorkflowExecution ResolveChildWorkflowExecution
  | PendingJobResolveSignalExternalWorkflow ResolveSignalExternalWorkflow
  | PendingJobResolveRequestCancelExternalWorkflow ResolveRequestCancelExternalWorkflow
  | PendingJobFireTimer FireTimer
  | PendingWorkflowCancellation CancelWorkflow


data JobGroups = JobGroups
  { patchNotifications :: !(InstanceM ())
  , updateWorkflows :: ![Workflow ()]
  , signalWorkflows :: ![Workflow ()]
  , queryWorkflows :: !(InstanceM ())
  , resolutions :: ![PendingJob]
  , otherJobs :: !(InstanceM ())
  }


applyJobs
  :: Functor f
  => Vector WorkflowActivationJob
  -- We use the functor here because we need to call applyJobs both before and after a workflow has completed.
  -- During workflow execution, identity is the functor, but after a workflow has completed, Proxy is the functor
  -- since we don't actually have any continuation to run.
  -> f (Await [ActivationResult] (SuspendableWorkflowExecution Payload))
  -> InstanceM (Either SomeException (f (SuspendableWorkflowExecution Payload)))
applyJobs jobs fAwait = UnliftIO.try $ do
  Logging.logDebug $ Text.pack ("Applying jobs: " <> show jobs)
  let JobGroups {..} = jobGroups
  patchNotifications
  queryWorkflows
  otherJobs
  activationResults <- applyResolutions resolutions
  let activations = activationResults
  pure $
    ( \(Await wf) ->
        -- If we don't have any activations or signals, then no useful state could have changed.
        -- This happens when we receive non-resolving jobs like queries. If we reactivate
        -- the workflow, it will just block again, which we don't want, because it confuses
        -- the SDK core's state machine.

        case activations of
          [] -> case updateWorkflows ++ signalWorkflows of
            [] -> suspend (Await wf)
            jobs -> do
              lift (mapM_ injectWorkflowSignalOrUpdate jobs) *> wf []
          _ -> case updateWorkflows ++ signalWorkflows of
            [] -> wf activations
            jobs -> lift (mapM_ injectWorkflowSignalOrUpdate jobs) *> wf activations
            {- TODO: we need to run the signal workflows without messing up ContinuationEnv: runWorkflow signalWorkflows -}
    )
      <$> fAwait
  where
    jobGroups =
      V.foldr
        ( \job jobGroups -> case job ^. Activation.maybe'variant of
            Just (WorkflowActivationJob'NotifyHasPatch n) -> jobGroups {patchNotifications = applyNotifyHasPatch n *> jobGroups.patchNotifications}
            Just (WorkflowActivationJob'SignalWorkflow sig) -> jobGroups {signalWorkflows = applySignalWorkflow sig : jobGroups.signalWorkflows}
            Just (WorkflowActivationJob'QueryWorkflow q) -> jobGroups {queryWorkflows = applyQueryWorkflow q *> jobGroups.queryWorkflows}
            -- We collect these in bulk and resolve them in one go by pushing them into the completed queue. This reactivates the suspended workflow
            -- and it tries to execute further.
            Just (WorkflowActivationJob'FireTimer r) -> jobGroups {resolutions = PendingJobFireTimer r : jobGroups.resolutions}
            Just (WorkflowActivationJob'ResolveActivity r) -> jobGroups {resolutions = PendingJobResolveActivity r : jobGroups.resolutions}
            Just (WorkflowActivationJob'ResolveChildWorkflowExecutionStart r) -> jobGroups {resolutions = PendingJobResolveChildWorkflowExecutionStart r : jobGroups.resolutions}
            Just (WorkflowActivationJob'ResolveChildWorkflowExecution r) -> jobGroups {resolutions = PendingJobResolveChildWorkflowExecution r : jobGroups.resolutions}
            Just (WorkflowActivationJob'ResolveSignalExternalWorkflow r) -> jobGroups {resolutions = PendingJobResolveSignalExternalWorkflow r : jobGroups.resolutions}
            Just (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow r) -> jobGroups {resolutions = PendingJobResolveRequestCancelExternalWorkflow r : jobGroups.resolutions}
            Just (WorkflowActivationJob'UpdateRandomSeed updateRandomSeed) -> jobGroups {otherJobs = jobGroups.otherJobs *> applyUpdateRandomSeed updateRandomSeed}
            Just (WorkflowActivationJob'CancelWorkflow cancelWorkflow) -> jobGroups {resolutions = PendingWorkflowCancellation cancelWorkflow : jobGroups.resolutions}
            -- By the time we get here, the workflow should already be running.
            Just (WorkflowActivationJob'InitializeWorkflow _initializeWorkflow) -> jobGroups
            -- Handled in the worker.
            Just (WorkflowActivationJob'RemoveFromCache _removeFromCache) -> jobGroups
            Just (WorkflowActivationJob'DoUpdate u) -> jobGroups {updateWorkflows = applyDoUpdateWorkflow u : jobGroups.updateWorkflows}
            Just (WorkflowActivationJob'ResolveNexusOperation _) -> error "ResolveNexusOperation not yet implemented"
            Just (WorkflowActivationJob'ResolveNexusOperationStart _) -> error "ResolveNexusOperationStart not yet implemented"
            Nothing -> E.throw $ RuntimeError "Uncrecognized workflow activation job variant"
        )
        ( JobGroups
            { patchNotifications = pure ()
            , updateWorkflows = []
            , signalWorkflows = []
            , queryWorkflows = pure ()
            , resolutions = []
            , otherJobs = pure ()
            }
        )
        jobs


applyResolutions :: [PendingJob] -> InstanceM [ActivationResult]
applyResolutions [] = pure []
applyResolutions rs = do
  inst <- ask
  atomically $ do
    sequenceMaps <- readTVar inst.workflowSequenceMaps
    let makeCompletion :: ([ActivationResult], SequenceMaps) -> PendingJob -> ([ActivationResult], SequenceMaps)
        makeCompletion (!completions, !sequenceMaps') pj = case pj of
          PendingJobResolveActivity msg -> do
            let existingIVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.activities
            case existingIVar of
              Nothing ->
                E.throw $ RuntimeError "Activity handle not found"
              Just existing ->
                ( ActivationResult (Ok msg) existing : completions
                , sequenceMaps'
                    { activities = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.activities
                    }
                )
          PendingJobResolveChildWorkflowExecutionStart msg -> do
            let existingHandle = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
            case existingHandle of
              Nothing ->
                E.throw $ RuntimeError "Child workflow not found"
              Just (SomeChildWorkflowHandle existing) -> case msg ^. Activation.maybe'status of
                Nothing ->
                  E.throw $ RuntimeError "Child workflow start did not have a known status"
                Just status -> case status of
                  ResolveChildWorkflowExecutionStart'Succeeded succeeded ->
                    ( ActivationResult (Ok ()) existing.startHandle
                        : ActivationResult (Ok (succeeded ^. Activation.runId . to RunId)) existing.firstExecutionRunId
                        : completions
                    , sequenceMaps'
                    )
                  ResolveChildWorkflowExecutionStart'Failed failed ->
                    let updatedMaps =
                          sequenceMaps'
                            { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                            }
                    in case failed ^. Activation.cause of
                        START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS ->
                          let failure :: forall v. ResultVal v
                              failure =
                                ThrowWorkflow $
                                  toException $
                                    WorkflowAlreadyStarted
                                      { workflowAlreadyStartedWorkflowId = WorkflowId (failed ^. Activation.workflowId)
                                      , workflowAlreadyStartedWorkflowType = WorkflowType (failed ^. Activation.workflowType)
                                      }
                          in ( ActivationResult failure existing.startHandle
                                : ActivationResult failure existing.firstExecutionRunId
                                : completions
                             , updatedMaps
                             )
                        _ ->
                          ( ActivationResult
                              (ThrowInternal $ toException $ RuntimeError ("Unknown child workflow start failure: " <> show (failed ^. Activation.cause)))
                              existing.startHandle
                              : completions
                          , updatedMaps
                          )
                  ResolveChildWorkflowExecutionStart'Cancelled _cancelled ->
                    ( ActivationResult (Ok ()) existing.startHandle
                        : ActivationResult (ThrowWorkflow $ toException ChildWorkflowCancelled) existing.firstExecutionRunId
                        : ActivationResult (ThrowWorkflow $ toException ChildWorkflowCancelled) existing.resultHandle
                        : completions
                    , sequenceMaps'
                        { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                        }
                    )
          PendingWorkflowCancellation _ -> (ActivationResult (Ok ()) inst.workflowCancellationVar : completions, sequenceMaps')
          PendingJobResolveChildWorkflowExecution msg -> do
            let existingHandle = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
            case existingHandle of
              Nothing -> E.throw $ RuntimeError "Child Workflow Execution not found"
              Just (SomeChildWorkflowHandle h) ->
                ( ActivationResult (Ok msg) h.resultHandle : completions
                , sequenceMaps'
                    { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                    }
                )
          PendingJobResolveSignalExternalWorkflow msg -> do
            let mresVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalSignals
            case mresVar of
              Nothing -> E.throw $ RuntimeError "External Signal IVar for sequence not found"
              Just resVar ->
                ( ActivationResult (Ok msg) resVar : completions
                , sequenceMaps'
                    { externalSignals = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalSignals
                    }
                )
          PendingJobResolveRequestCancelExternalWorkflow msg -> do
            let mresVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalCancels
            case mresVar of
              Nothing -> E.throw $ RuntimeError "External Cancel IVar for sequence not found"
              Just resVar ->
                ( ActivationResult (Ok msg) resVar : completions
                , sequenceMaps'
                    { externalCancels = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalCancels
                    }
                )
          PendingJobFireTimer msg -> do
            let existingIVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.timers
            case existingIVar of
              Nothing -> E.throw $ RuntimeError "Timer not found"
              Just existing ->
                ( ActivationResult (Ok ()) existing : completions
                , sequenceMaps'
                    { timers = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.timers
                    }
                )

    let (newCompletions, updatedSequenceMaps) = foldl' makeCompletion ([], sequenceMaps) rs
    writeTVar inst.workflowSequenceMaps updatedSequenceMaps
    pure newCompletions


convertExitVariantToCommand :: WorkflowExitVariant Payload -> InstanceM Command.WorkflowCommand
convertExitVariantToCommand variant = do
  inst <- ask
  let processor = inst.payloadProcessor
  case variant of
    WorkflowExitSuccess result -> do
      result' <- liftIO $ payloadProcessorEncode processor result
      pure $
        defMessage
          & Command.completeWorkflowExecution .~ (defMessage & Command.result .~ convertToProtoPayload result')
    WorkflowExitContinuedAsNew (ContinueAsNewException {..}) -> do
      i <- readIORef inst.workflowInstanceInfo
      searchAttrs <-
        liftIO $
          searchAttributesToProto
            ( if continueAsNewOptions.searchAttributes == mempty
                then i.searchAttributes
                else continueAsNewOptions.searchAttributes
            )
      args <- processorEncodePayloads processor continueAsNewArguments
      hdrs <- processorEncodePayloads processor continueAsNewOptions.headers
      memo <- processorEncodePayloads processor continueAsNewOptions.memo
      pure $
        defMessage
          & Command.continueAsNewWorkflowExecution
            .~ ( defMessage
                  & Command.workflowType .~ rawWorkflowType continueAsNewWorkflowType
                  & Command.taskQueue .~ maybe "" rawTaskQueue continueAsNewOptions.taskQueue
                  & Command.vec'arguments .~ fmap convertToProtoPayload args
                  & Command.maybe'retryPolicy .~ (retryPolicyToProto <$> continueAsNewOptions.retryPolicy)
                  & Command.searchAttributes .~ searchAttrs
                  & Command.headers .~ fmap convertToProtoPayload hdrs
                  & Command.memo .~ fmap convertToProtoPayload memo
                  & Command.maybe'workflowTaskTimeout .~ (durationToProto <$> continueAsNewOptions.taskTimeout)
                  & Command.maybe'workflowRunTimeout .~ (durationToProto <$> continueAsNewOptions.runTimeout)
               )
    WorkflowExitCancelled WorkflowCancelRequested -> do
      pure $ defMessage & Command.cancelWorkflowExecution .~ defMessage
    WorkflowExitFailed e | Just (actFailure :: ActivityFailure) <- fromException e -> do
      let appFailure = actFailure.cause
          enrichedApplicationFailure =
            defMessage
              & F.message .~ actFailure.message
              & F.source .~ "hs-temporal-sdk"
              & F.activityFailureInfo .~ actFailure.original
              & F.stackTrace .~ actFailure.stack
              & F.cause
                .~ ( defMessage
                      & F.message .~ appFailure.message
                      & F.source .~ "hs-temporal-sdk"
                      & F.stackTrace .~ appFailure.stack
                      & F.applicationFailureInfo
                        .~ ( defMessage
                              & F.type' .~ Err.type' appFailure
                              & F.nonRetryable .~ Err.nonRetryable appFailure
                           )
                   )
      pure $
        defMessage
          & Command.failWorkflowExecution
            .~ ( defMessage
                  & Command.failure .~ enrichedApplicationFailure
               )
    WorkflowExitFailed e -> do
      w <- ask
      let appFailure = mkApplicationFailure e w.errorConverters
          enrichedApplicationFailure = applicationFailureToFailureProto appFailure
      pure $
        defMessage
          & Command.failWorkflowExecution
            .~ ( defMessage
                  & Command.failure .~ enrichedApplicationFailure
               )


-- Note: this is intended to exclusively handle top-level workflow execution.
--
-- Don't use elsewhere.
runTopLevel :: InstanceM Payload -> InstanceM (WorkflowExitVariant Payload)
runTopLevel m = do
  (WorkflowExitSuccess <$> m)
    `catches` [ Handler $ \e@(ContinueAsNewException {}) -> pure $ WorkflowExitContinuedAsNew e
              , Handler $ \WorkflowCancelRequested -> do
                  pure $ WorkflowExitCancelled WorkflowCancelRequested
              , Handler $ \(e :: SomeException) -> do
                  pure $ WorkflowExitFailed e
              ]

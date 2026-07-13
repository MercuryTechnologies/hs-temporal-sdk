{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}

module Temporal.WorkflowInstance (
  WorkflowInstance,
  Info (..),
  RootExecution (..),
  create,
  activate,
  addCommand,
  nextActivitySequence,
  nextChildWorkflowSequence,
  nextExternalCancelSequence,
  nextExternalSignalSequence,
  nextTimerSequence,
  nextConditionSequence,
  nextNexusOperationSequence,
  addBuiltinQueryHandlers,
) where

import Control.Applicative
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import qualified Data.Aeson as Aeson


#if __GLASGOW_HASKELL__ < 910
import Data.Foldable (foldl')
#endif
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe (mapMaybe)
import Data.Monoid (Endo (..))
import Data.ProtoLens
import Data.Set (Set)
import qualified Data.Set as Set
import qualified Data.HashSet as HashSet
import qualified Data.Text as Text
import Data.Time.Clock.System (SystemTime (..))
import Data.Vault.Strict (Vault)
import Data.Vector (Vector)
import qualified Data.Vector as V
import Data.Version (showVersion)
import GHC.Stack (HasCallStack, emptyCallStack, getCallStack)
import qualified GHC.Stack
import Lens.Family2
import Paths_temporal_sdk (version)
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
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
  ResolveNexusOperation,
  ResolveNexusOperationStart,
  ResolveNexusOperationStart'Status (..),
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
import Temporal.Duration
import Temporal.Exception
import qualified Temporal.Exception as Err
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.Eval (awaitActivationVia, injectWorkflowSignalOrUpdate, rethrowAsyncExceptions, runWorkflow)
import Temporal.Workflow.Internal.DelimCC (newPromptTag, prompt)
import Temporal.Workflow.Internal.Instance
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Types
import UnliftIO


create
  :: (HasCallStack, MonadLoggerIO m)
  => (Vector Payload -> IO (Either String (Workflow Payload)))
  -> Maybe Int
  -- ^ deadlock timeout in microseconds
  -> [ApplicationFailureHandler]
  -> WorkflowInboundInterceptor
  -> WorkflowOutboundInterceptor
  -> Vault
  -> PayloadProcessor
  -> Info
  -> InitializeWorkflow
  -> m WorkflowInstance
create
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
          , nexusOperation = 1
          }
    workflowTime <- newIORef $ MkSystemTime 0 0
    workflowIsReplaying <- newIORef False
    workflowKnownFlags <- newIORef mempty
    workflowSequenceMaps <- newIORef $ SequenceMaps mempty mempty mempty mempty mempty mempty mempty
    workflowCommands <- newIORef $ Reversed []
    workflowSignalHandlers <- newIORef mempty
    workflowBufferedSignals <- newIORef mempty
    workflowCallStack <- newIORef emptyCallStack
    workflowIVarCounter <- newIORef 1
    workflowBlockedStacks <- newIORef mempty
    workflowQueryHandlers <- newIORef mempty
    workflowUpdateHandlers <- newIORef mempty
    workflowInstanceInfo <- newIORef info
    workflowInstanceContinuationEnv <- ContinuationEnv <$> newIORef JobNil
    workflowCancellationVar <- newIVar
    executionState <- newEmptyMVar
    let inst = WorkflowInstance {..}
    -- Runs setup and the workflow to its first suspension. The prompt wraps
    -- the interceptor and runTopLevel so suspensions capture their frames.
    let startRun = runInstanceM inst $ do
          Logging.logDebug "Starting workflow execution"
          exec <- setUpWorkflowExecution start
          tag <- liftIO newPromptTag
          liftIO $
            prompt tag $
              fmap RunDone $
                inboundInterceptor.executeWorkflow exec $ \exec' -> runInstanceM inst $ runTopLevel $ do
                  Logging.logDebug "Executing workflow"
                  wf <- applyStartWorkflow exec' workflowFn
                  runWorkflow (awaitActivationVia tag) wf
    putMVar executionState (ExecNotStarted startRun)
    pure inst


{- | Advance a run by exactly one activation, returning the completion for the
worker to send.

The 'executionState' 'MVar' is the per-run lock: a run's activations are
serialised by taking it. A fault during the step (deadlock, or an internal
error) poisons the run and yields a failed completion in-band; genuine async
exceptions (worker shutdown) are re-raised.
-}
activate :: HasCallStack => WorkflowInstance -> WorkflowActivation -> IO Core.WorkflowActivationCompletion
activate inst act = runInstanceM inst $ UnliftIO.mask $ \restore -> do
  -- 'mask' keeps the state MVar refilled even under an async exception;
  -- 'restore' leaves the step itself interruptible (the deadlock timeout).
  st <- takeMVar inst.executionState
  eRes <- UnliftIO.try $ restore $ deadlockGuarded $ advance act st
  case eRes of
    Right (completion, st') -> do
      putMVar inst.executionState st'
      pure completion
    Left err -> do
      putMVar inst.executionState (ExecPoisoned err)
      rethrowAsyncExceptions err
      Logging.logWarn ("Failed activation: " <> Text.pack (show err))
      buildFailedCompletion err


-- | Advance the paused run one activation forward.
advance
  :: WorkflowActivation
  -> ExecState (WorkflowExitVariant Payload)
  -> InstanceM (Core.WorkflowActivationCompletion, ExecState (WorkflowExitVariant Payload))
advance act st = case st of
  ExecNotStarted start -> stepStatus act =<< liftIO start
  ExecPaused k -> stepStatus act (RunBlocked k)
  -- Run already finished; apply the activation's jobs (post-completion
  -- queries) and flush without resuming.
  ExecDone -> applyJobsOnly act ExecDone
  ExecPoisoned err -> (,ExecPoisoned err) <$> buildFailedCompletion err


-- | Step the run given its current status and this activation's jobs.
stepStatus
  :: WorkflowActivation
  -> RunStatus (WorkflowExitVariant Payload)
  -> InstanceM (Core.WorkflowActivationCompletion, ExecState (WorkflowExitVariant Payload))
stepStatus act (RunDone exit) = do
  _ <- applyJobs' act
  addCommand =<< convertExitVariantToCommand exit
  (,ExecDone) <$> drainCommands
stepStatus act (RunBlocked k) = do
  (results, sigUpdateJobs) <- applyJobs' act
  case (results, sigUpdateJobs) of
    -- A query-only activation resolves nothing and delivers no handlers;
    -- resuming would just block again and desync core's state machine, so
    -- leave the run suspended and flush the query response.
    ([], []) -> (,ExecPaused k) <$> drainCommands
    _ -> do
      mapM_ injectWorkflowSignalOrUpdate sigUpdateJobs
      finalize =<< liftIO (k results)


-- | Park the resumed run or, if it finished, emit its exit command.
finalize
  :: RunStatus (WorkflowExitVariant Payload)
  -> InstanceM (Core.WorkflowActivationCompletion, ExecState (WorkflowExitVariant Payload))
finalize (RunBlocked k) = (,ExecPaused k) <$> drainCommands
finalize (RunDone exit) = do
  addCommand =<< convertExitVariantToCommand exit
  (,ExecDone) <$> drainCommands


-- | Apply the activation's jobs on a completed run and flush, without
-- resuming.
applyJobsOnly
  :: WorkflowActivation
  -> ExecState (WorkflowExitVariant Payload)
  -> InstanceM (Core.WorkflowActivationCompletion, ExecState (WorkflowExitVariant Payload))
applyJobsOnly act st = do
  _ <- applyJobs' act
  (,st) <$> drainCommands


-- | Apply an activation's jobs, re-raising a job-application failure so the
-- caller poisons the run.
applyJobs' :: WorkflowActivation -> InstanceM ([ActivationResult], [Workflow ()])
applyJobs' act = either throwIO pure =<< stepActivation act


-- | Run the workflow step under the deadlock timeout, if one is configured.
--
-- The timeout wraps the whole step, however it only catches steps that
-- reach a safepoint: an async 'timeout' cannot interrupt a tight non-suspending
-- loop in workflow code, so a genuine CPU-bound deadlock is not detected here
-- (see the pending deadlock spec).
deadlockGuarded :: InstanceM a -> InstanceM a
deadlockGuarded m = do
  inst <- ask
  case inst.workflowDeadlockTimeout of
    Nothing -> m
    Just micros ->
      UnliftIO.timeout micros m >>= \case
        Just a -> pure a
        Nothing -> do
          Logging.logError "Deadlock detected"
          throwIO (LogicBug WorkflowActivationDeadlock)


-- | Build a failed activation completion from an exception.
buildFailedCompletion :: SomeException -> InstanceM Core.WorkflowActivationCompletion
buildFailedCompletion err = do
  inst <- ask
  info <- readIORef inst.workflowInstanceInfo
  let appFailure = mkApplicationFailure err inst.errorConverters
      failureProto :: Completion.Failure
      failureProto = defMessage & Completion.failure .~ applicationFailureToFailureProto appFailure
  pure $
    defMessage
      & Completion.runId .~ rawRunId info.runId
      & Completion.failed .~ failureProto


isBuiltinQuery :: Text.Text -> Bool
isBuiltinQuery name =
  "__stack_trace" == name
    || "__enhanced_stack_trace" == name
    || "__temporal_workflow_metadata" == name
    || "__temporal_" `Text.isPrefixOf` name


{- | Register built-in query handlers on a workflow instance.

These are the special queries that all Temporal SDKs provide:

  * @__stack_trace@ — returns a human-readable call stack (used by the Temporal UI)
  * @__enhanced_stack_trace@ — returns structured stack trace with SDK info
  * @__temporal_workflow_metadata@ — returns the workflow type and registered handler definitions
-}
addBuiltinQueryHandlers :: WorkflowInstance -> IO ()
addBuiltinQueryHandlers inst = do
  modifyIORef' inst.workflowQueryHandlers $ \handlers ->
    HashMap.insert (Just "__stack_trace") stackTraceHandler
      . HashMap.insert (Just "__enhanced_stack_trace") enhancedStackTraceHandler
      . HashMap.insert (Just "__temporal_workflow_metadata") workflowMetadataHandler
      $ handlers
  where
    stackTraceHandler _ _ _ = do
      stacks <- readIORef inst.workflowBlockedStacks
      formatted <- case HashMap.elems stacks of
        [] -> do
          cs <- readIORef inst.workflowCallStack
          pure $ Text.pack $ Temporal.Exception.prettyCallStack cs
        css ->
          pure $ Text.intercalate "\n\n" $ fmap (Text.pack . Temporal.Exception.prettyCallStack) css
      Right <$> Temporal.Payload.encode JSON formatted

    enhancedStackTraceHandler _ _ _ = do
      blockedStacks <- readIORef inst.workflowBlockedStacks
      css <- case HashMap.elems blockedStacks of
        [] -> do
          cs <- readIORef inst.workflowCallStack
          pure [cs]
        xs -> pure xs
      let stacksJson = fmap (\cs -> Aeson.object ["locations" Aeson..= fmap stackFrameToJSON (getCallStack cs)]) css
          stackObj =
            Aeson.object
              [ "sdk" Aeson..= Aeson.object ["name" Aeson..= ("haskell" :: Text.Text), "version" Aeson..= sdkVersion]
              , "stacks" Aeson..= stacksJson
              , "sources" Aeson..= Aeson.object []
              ]
      Right <$> Temporal.Payload.encode JSON stackObj

    stackFrameToJSON (fnName, srcLoc) =
      Aeson.object
        [ "file_path" Aeson..= GHC.Stack.srcLocFile srcLoc
        , "function_name" Aeson..= fnName
        , "line" Aeson..= GHC.Stack.srcLocStartLine srcLoc
        , "column" Aeson..= GHC.Stack.srcLocStartCol srcLoc
        , "internal_code" Aeson..= False
        ]

    workflowMetadataHandler _ _ _ = do
      wfInfo <- readIORef inst.workflowInstanceInfo
      queryHandlers <- readIORef inst.workflowQueryHandlers
      signalHandlers <- readIORef inst.workflowSignalHandlers
      updateHandlers <- readIORef inst.workflowUpdateHandlers
      let queryDefs = handlerDefsFromKeys queryHandlers
          signalDefs = handlerDefsFromKeys signalHandlers
          updateDefs = handlerDefsFromKeys updateHandlers
          metadataObj =
            Aeson.object
              [ "definition"
                  Aeson..= Aeson.object
                    [ "type" Aeson..= rawWorkflowType wfInfo.workflowType
                    , "queryDefinitions" Aeson..= queryDefs
                    , "signalDefinitions" Aeson..= signalDefs
                    , "updateDefinitions" Aeson..= updateDefs
                    ]
              ]
      Right <$> Temporal.Payload.encode JSON metadataObj

    handlerDefsFromKeys :: HashMap.HashMap (Maybe Text.Text) v -> [Aeson.Value]
    handlerDefsFromKeys m =
      mapMaybe
        (fmap (\name -> Aeson.object ["name" Aeson..= name]))
        (HashMap.keys m)

    sdkVersion :: Text.Text
    sdkVersion = Text.pack (showVersion version)


-- | Update instance state from the activation and apply its jobs.
--
-- Callers decide whether to resume the run or send a completion.
stepActivation
  :: WorkflowActivation
  -> InstanceM (Either SomeException ([ActivationResult], [Workflow ()]))
stepActivation act = do
  inst <- ask
  modifyIORef' inst.workflowInstanceInfo $ \info ->
    info
      { historyLength = act ^. Activation.historyLength
      , continueAsNewSuggested = act ^. Activation.continueAsNewSuggested
      }
  writeIORef inst.workflowTime (act ^. Activation.timestamp . to timespecFromTimestamp)
  writeIORef inst.workflowIsReplaying (act ^. Activation.isReplaying)
  modifyIORef' inst.workflowKnownFlags (HashSet.union (HashSet.fromList (act ^. Activation.availableInternalFlags)))
  applyJobs (act ^. Activation.vec'jobs)


-- | This gives us the basic state for a workflow instance prior to initial evaluation.
setUpWorkflowExecution :: InitializeWorkflow -> InstanceM ExecuteWorkflowInput
setUpWorkflowExecution initializeWorkflow = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ initializeWorkflow ^. Activation.randomnessSeed)
  writeIORef inst.workflowTime (initializeWorkflow ^. Activation.startTime . to timespecFromTimestamp)
  info <- readIORef inst.workflowInstanceInfo

  -- Headers deliberately bypass the payload processor: no Temporal SDK
  -- (including this one's client paths) encodes headers with the payload
  -- codec, and running e.g. tracing headers through an asymmetric processor
  -- corrupts them.
  let hdrs = fmap convertFromProtoPayload (initializeWorkflow ^. Activation.headers)
  pure $
    ExecuteWorkflowInput
      { executeWorkflowInputType = WorkflowType (initializeWorkflow ^. Activation.workflowType)
      , executeWorkflowInputArgs = fmap convertFromProtoPayload (initializeWorkflow ^. Command.vec'arguments)
      , executeWorkflowInputHeaders = hdrs
      , executeWorkflowInputInfo = info
      }


applyStartWorkflow :: ExecuteWorkflowInput -> (Vector Payload -> IO (Either String (Workflow Payload))) -> InstanceM (Workflow Payload)
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
            , rawWorkflowType input.executeWorkflowInputType
            , " "
            , "workflowId="
            , rawWorkflowId input.executeWorkflowInputInfo.workflowId
            ]
        eAct <- liftIO (workflowFn =<< processorDecodePayloads inst.payloadProcessor input.executeWorkflowInputArgs)
        case eAct of
          Left msg -> do
            Logging.logError $ Text.pack ("Failed to decode workflow arguments: " <> msg)
            throwIO (ValueError msg)
          Right act -> pure act

  liftIO $ executeWorkflowBase execInput


applyUpdateRandomSeed :: UpdateRandomSeed -> InstanceM ()
applyUpdateRandomSeed updateRandomSeed = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ updateRandomSeed ^. Activation.randomnessSeed)


applyQueryWorkflow :: HasCallStack => QueryWorkflow -> InstanceM ()
applyQueryWorkflow queryWorkflow = do
  inst <- ask
  instInfo <- readIORef inst.workflowInstanceInfo
  handles <- readIORef inst.workflowQueryHandlers
  Logging.logDebug $ Text.pack ("Applying query: " <> show (queryWorkflow ^. Activation.queryType))
  let processor = inst.payloadProcessor
  args <- processorDecodePayloads processor (fmap convertFromProtoPayload (queryWorkflow ^. Command.vec'arguments))
  -- Headers deliberately bypass the payload processor (see setUpWorkflowExecution).
  let hdrs = fmap convertFromProtoPayload (queryWorkflow ^. Activation.headers)
  let baseInput =
        HandleQueryInput
          { handleQueryId = QueryId (queryWorkflow ^. Activation.queryId)
          , handleQueryInputType = queryWorkflow ^. Activation.queryType
          , handleQueryInputArgs = args
          , handleQueryInputHeaders = hdrs
          , handleQueryWorkflowInfo = instInfo
          }
      lookupHandler input =
        let handlerOrDefault =
              HashMap.lookup (Just input.handleQueryInputType) handles
                <|> HashMap.lookup Nothing handles
        in case handlerOrDefault of
            Nothing -> do
              pure $ Left $ toException $ QueryNotFound $ Text.unpack input.handleQueryInputType
            Just h ->
              liftIO $
                h
                  input.handleQueryId
                  input.handleQueryInputArgs
                  input.handleQueryInputHeaders
  res <-
    if isBuiltinQuery (queryWorkflow ^. Activation.queryType)
      then liftIO $ lookupHandler baseInput
      else liftIO $ inst.inboundInterceptor.handleQuery baseInput lookupHandler
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
    let signalName = signalWorkflow ^. Activation.signalName
        handlerOrDefault =
          HashMap.lookup (Just signalName) handlers
            <|> HashMap.lookup Nothing handlers
    -- Decode inputs first - we need them whether we have a handler or are buffering
    eInputs <- UnliftIO.try $ processorDecodePayloads inst.payloadProcessor (fmap convertFromProtoPayload (signalWorkflow ^. Command.vec'input))
    case eInputs of
      Left err -> throwWorkflow err
      Right args -> do
        -- Headers deliberately bypass the payload processor (see setUpWorkflowExecution).
        let signalHeaders = fmap convertFromProtoPayload (signalWorkflow ^. Activation.headers)
        case handlerOrDefault of
          Nothing -> do
            -- Buffer the signal (and its headers) until a handler is registered (matching TypeScript SDK behavior)
            -- Uses Endo for O(1) append (diff-list style), maintaining FIFO order
            -- flip (<>) ensures old signals come before new: old <> new
            Logging.logDebug $ Text.pack ("Buffering signal (no handler registered yet): " <> show signalName)
            liftIO $
              modifyIORef' inst.workflowBufferedSignals $
                HashMap.insertWith (flip (<>)) signalName (Endo ((args, signalHeaders) :))
            pure $ pure ()
          Just handler -> do
            instInfo <- readIORef inst.workflowInstanceInfo
            let input =
                  HandleSignalInput
                    { handleSignalInputType = signalName
                    , handleSignalInputArgs = args
                    , handleSignalInputHeaders = signalHeaders
                    , handleSignalWorkflowInfo = instInfo
                    }
            pure $ do
              Logging.logDebug $ Text.pack ("Applying signal handler for signal: " <> show signalName)
              inst.inboundInterceptor.handleSignal input $ \input' ->
                handler input'.handleSignalInputArgs


applyDoUpdateWorkflow :: DoUpdate -> Workflow ()
applyDoUpdateWorkflow doUpdate = provideCallStack do
  (validator, updateAction) <- ilift do
    inst <- ask
    instInfo <- readIORef inst.workflowInstanceInfo
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
        -- Headers deliberately bypass the payload processor (see setUpWorkflowExecution).
        let updateHeaders = fmap convertFromProtoPayload (doUpdate ^. Activation.headers)
        let runValidator = doUpdate ^. Activation.runValidator
            updateId = UpdateId $ doUpdate ^. Activation.id
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
                    , handleUpdateWorkflowInfo = instInfo
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
          throwWorkflow err
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
          pure ()


applyNotifyHasPatch :: NotifyHasPatch -> InstanceM ()
applyNotifyHasPatch notifyHasPatch = do
  inst <- ask
  let patches :: IORef (Set PatchId)
      patches = inst.workflowNotifiedPatches
  modifyIORef' patches $ Set.insert (notifyHasPatch ^. Activation.patchId . to PatchId)


data PendingJob
  = PendingJobResolveActivity ResolveActivity
  | PendingJobResolveChildWorkflowExecutionStart ResolveChildWorkflowExecutionStart
  | PendingJobResolveChildWorkflowExecution ResolveChildWorkflowExecution
  | PendingJobResolveSignalExternalWorkflow ResolveSignalExternalWorkflow
  | PendingJobResolveRequestCancelExternalWorkflow ResolveRequestCancelExternalWorkflow
  | PendingJobFireTimer FireTimer
  | PendingWorkflowCancellation CancelWorkflow
  | PendingJobResolveNexusOperationStart ResolveNexusOperationStart
  | PendingJobResolveNexusOperation ResolveNexusOperation


data JobGroups = JobGroups
  { patchNotifications :: !(InstanceM ())
  , updateWorkflows :: ![Workflow ()]
  , signalWorkflows :: ![Workflow ()]
  , queryWorkflows :: !(InstanceM ())
  , resolutions :: ![PendingJob]
  , otherJobs :: !(InstanceM ())
  }


-- | Run an activation's jobs, returning resolved results plus pending
-- signal/update handlers (updates before signals).
applyJobs
  :: Vector WorkflowActivationJob
  -> InstanceM (Either SomeException ([ActivationResult], [Workflow ()]))
applyJobs jobs = UnliftIO.try $ do
  Logging.logDebug $ Text.pack ("Applying jobs: " <> show jobs)
  let JobGroups {..} = getJobGroups
  patchNotifications
  queryWorkflows
  otherJobs
  activationResults <- applyResolutions resolutions
  pure (activationResults, updateWorkflows ++ signalWorkflows)
  where
    getJobGroups =
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
            Just (WorkflowActivationJob'ResolveNexusOperation r) -> jobGroups {resolutions = PendingJobResolveNexusOperation r : jobGroups.resolutions}
            Just (WorkflowActivationJob'ResolveNexusOperationStart r) -> jobGroups {resolutions = PendingJobResolveNexusOperationStart r : jobGroups.resolutions}
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
  sequenceMaps <- readIORef inst.workflowSequenceMaps
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
        PendingJobResolveNexusOperationStart msg -> do
          let existingHandles = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.nexusOperations
          case existingHandles of
            Nothing -> E.throw $ RuntimeError "Nexus operation not found for start resolution"
            Just handles -> case msg ^. Activation.maybe'status of
              Nothing -> E.throw $ RuntimeError "Nexus operation start had no status"
              Just (ResolveNexusOperationStart'OperationToken token) ->
                ( ActivationResult (Ok (NexusOperationStartedAsync token)) handles.nexusStartHandle : completions
                , sequenceMaps'
                )
              Just (ResolveNexusOperationStart'StartedSync _) ->
                ( ActivationResult (Ok NexusOperationStartedSync) handles.nexusStartHandle : completions
                , sequenceMaps'
                )
              Just (ResolveNexusOperationStart'Failed failure) ->
                ( ActivationResult (ThrowWorkflow $ toException $ NexusOperationStartFailed (failure ^. Activation.message)) handles.nexusStartHandle
                    : ActivationResult (ThrowWorkflow $ toException $ NexusOperationStartFailed (failure ^. Activation.message)) handles.nexusResultHandle
                    : completions
                , sequenceMaps'
                    { nexusOperations = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.nexusOperations
                    }
                )
        PendingJobResolveNexusOperation msg -> do
          let existingHandles = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.nexusOperations
          case existingHandles of
            Nothing -> E.throw $ RuntimeError "Nexus operation not found for result resolution"
            Just handles -> case msg ^. Activation.maybe'result of
              Nothing -> E.throw $ RuntimeError "Nexus operation resolution had no result"
              Just result ->
                ( ActivationResult (Ok result) handles.nexusResultHandle : completions
                , sequenceMaps'
                    { nexusOperations = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.nexusOperations
                    }
                )

  let (newCompletions, updatedSequenceMaps) = foldl' makeCompletion ([], sequenceMaps) rs
  writeIORef inst.workflowSequenceMaps updatedSequenceMaps
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
                  & Command.headers .~ fmap convertToProtoPayload continueAsNewOptions.headers
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

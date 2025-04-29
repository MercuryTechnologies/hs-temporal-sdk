{-# LANGUAGE TemplateHaskell #-}

module Temporal.Workflow.Worker where

import qualified Control.Exception.Annotated as Ann
import Control.Monad
import Control.Monad.Catch (MonadCatch)
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.Trans.Resource (closeInternalState)
import Data.Functor
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe
import Data.ProtoLens
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Vault.Strict (Vault)
import qualified Data.Vector as V
import Lens.Family2
import OpenTelemetry.Context.ThreadLocal
import OpenTelemetry.Trace.Core hiding (inSpan, inSpan')
import OpenTelemetry.Trace.Monad
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as CommonProto
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Completion
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import RequireCallStack
import Temporal.Common
import Temporal.Common.Async
import qualified Temporal.Core.Client as C
import Temporal.Core.Worker (InactiveForReplay)
import qualified Temporal.Core.Worker as Core
import Temporal.Duration (durationFromProto)
import qualified Temporal.Exception as Err
import Temporal.Interceptor
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.Definition
import Temporal.Workflow.Instance
import Temporal.Workflow.Monad hiding (try)
import Temporal.WorkflowInstance
import UnliftIO


data EvictionWithRunID = EvictionWithRunID
  { runId :: RunId
  , eviction :: RemoveFromCache
  }
  deriving stock (Show)


data WorkflowWorker = forall ty.
  Core.KnownWorkerType ty =>
  WorkflowWorker
  { workerWorkflowFunctions :: {-# UNPACK #-} !(HashMap Text WorkflowDefinition)
  , runningWorkflows :: {-# UNPACK #-} !(TVar (HashMap RunId RunningWorkflow))
  , workerClient :: InactiveForReplay ty C.Client
  , workerCore :: Core.Worker ty
  , workerInboundInterceptors :: {-# UNPACK #-} !WorkflowInboundInterceptor
  , workerOutboundInterceptors :: {-# UNPACK #-} !WorkflowOutboundInterceptor
  , workerDeadlockTimeout :: Maybe Int
  , workerTaskQueue :: TaskQueue
  , workerErrorConverters :: [Err.ApplicationFailureHandler]
  , processor :: {-# UNPACK #-} !PayloadProcessor
  , workerEvictionEmitter :: {-# UNPACK #-} !(TChan EvictionWithRunID)
  , workerVault :: {-# UNPACK #-} !Vault
  }


pollWorkflowActivation :: (MonadLoggerIO m) => ReaderT WorkflowWorker m (Either Core.WorkerError Core.WorkflowActivation)
pollWorkflowActivation = do
  WorkflowWorker {workerCore} <- ask
  liftIO $ Core.pollWorkflowActivation workerCore


registerRunningWorkflow :: (MonadLoggerIO m) => RunId -> RunningWorkflow -> ReaderT WorkflowWorker m ()
registerRunningWorkflow r inst = do
  worker <- ask
  atomically $ modifyTVar' worker.runningWorkflows (HashMap.insert r inst)


-- | Execute an action repeatedly as long as it returns True.
whileM_ :: (Monad m) => m Bool -> m ()
whileM_ p = go
  where
    go = do
      x <- p
      when x go


{- | Execute this worker until poller shutdown or failure. If there is a failure, this may
need to be called a second time after shutdown initiated to ensure workflow activations
are drained.

The Async handle only completes successfully on poller shutdown.
-}
execute :: (MonadLoggerIO m, MonadUnliftIO m, MonadCatch m, MonadTracer m, RequireCallStack) => WorkflowWorker -> m ()
execute worker@WorkflowWorker {workerCore} = flip runReaderT worker $ do
  $(logDebug) "Starting workflow worker"
  whileM_ go
  where
    c = Core.getWorkerConfig workerCore
    go = inSpan' "Workflow activation step" defaultSpanArguments $ \s -> do
      $(logDebug) "Polling for workflow activation"
      -- logs <- liftIO $ fetchLogs globalRuntime
      -- forM_ logs $ \l -> case l.level of
      --   Trace -> $(logDebug) l.message
      --   Debug -> $(logDebug) l.message
      --   Temporal.Runtime.Info -> $(logInfo) l.message
      --   Warn -> $(logWarn) l.message
      --   Error -> $(logError) l.message
      eActivation <- pollWorkflowActivation
      case eActivation of
        -- TODO should we do anything else on shutdown?
        (Left (Core.WorkerError Core.PollShutdown _)) -> do
          $(logDebug) "Poller shutting down"
          runningWorkflows <- readTVarIO worker.runningWorkflows
          mapM_ shutdownRunningWorkflow runningWorkflows
          pure False
        (Left err) -> do
          $(logError) $ Text.pack $ show err
          recordException s mempty Nothing err
          pure True
        (Right activation) -> do
          $(logDebug) $ Text.pack ("Got activation " <> show activation)
          -- We want to handle activations as fast as possible, so we don't want to block
          -- on dispatching jobs. We link the activator thread to the run-loop so that any
          -- unhandled exceptions in that logic aren't ignored.
          -- activationCtxt <- getContext
          -- activator <- asyncLabelled (Text.unpack $ Text.concat ["temporal/worker/workflow/activate", Core.namespace c, "/", Core.taskQueue c]) $ do
          --   _ <- attachContext activationCtxt
          --   $(logDebug) "Activator async finished"
          -- link activator
          handleActivation activation
          pure True


handleActivation :: forall m. (MonadUnliftIO m, MonadLoggerIO m, MonadCatch m, MonadTracer m) => Core.WorkflowActivation -> ReaderT WorkflowWorker m ()
handleActivation activation = inSpan' "handleActivation" (defaultSpanArguments {attributes = HashMap.fromList [("temporal.activation.run_id", toAttribute $ activation ^. Activation.runId)]}) $ \_s -> do
  $(logDebug) ("Handling activation: RunId " <> Text.pack (show (activation ^. Activation.runId)))
  forM_ (activation ^. Activation.jobs) $ \job -> do
    $(logDebug) ("Job: " <> Text.pack (show job))
  WorkflowWorker {workerCore} <- ask
  {-
  Run jobs
  -}
  if shouldRun
    then do
      mInst <- createOrFetchRunningWorkflow
      forM_ mInst $ \wf -> do
        let withoutStart = filter (\job -> isNothing (job ^. Activation.maybe'startWorkflow)) (activation ^. Activation.jobs)
        atomically $ writeTQueue wf.runningWorkflowRuntime.workflowRuntimeInstance.activationChannel (activation & Activation.jobs .~ withoutStart)
    else do
      $(logDebug) "Workflow does not need to run."
      let completionMessage =
            defMessage
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

    activationInitializeWorkflowJobs :: V.Vector (WorkflowActivationJob, InitializeWorkflow)
    activationInitializeWorkflowJobs =
      V.mapMaybe
        ( \rawJob ->
            case rawJob ^. Activation.maybe'variant of
              Just (WorkflowActivationJob'InitializeWorkflow initializeWorkflow) -> Just (rawJob, initializeWorkflow)
              _ -> Nothing
        )
        (activation ^. Activation.vec'jobs)

    createOrFetchRunningWorkflow :: ReaderT WorkflowWorker m (Maybe RunningWorkflow)
    createOrFetchRunningWorkflow = inSpan' "createOrFetchRunningWorkflow" (defaultSpanArguments {attributes = HashMap.fromList [("temporal.activation.run_id", toAttribute $ activation ^. Activation.runId)]}) $ \s -> do
      worker@WorkflowWorker {workerCore} <- ask
      runningWorkflows_ <- atomically $ readTVar worker.runningWorkflows
      case HashMap.lookup (RunId $ activation ^. Activation.runId) runningWorkflows_ of
        Just inst -> do
          addAttribute s "temporal.workflow.worker.instance_state" ("existing" :: Text)
          pure $ Just inst
        Nothing -> do
          addAttribute s "temporal.workflow.worker.instance_state" ("new" :: Text)
          vExistingInstance <- forM activationInitializeWorkflowJobs $ \(_job, initializeWorkflow) -> do
            addAttribute s "temporal.workflow.type" (initializeWorkflow ^. Activation.workflowType)
            ePayloads <- Ann.try $ do
              searchAttrs <- liftIO $ do
                decodedAttrs <- initializeWorkflow ^. Activation.searchAttributes . Message.indexedFields . to searchAttributesFromProto
                either (throwIO . ValueError) pure decodedAttrs
              hdrs <- processorDecodePayloads worker.processor (startWorkflow ^. Activation.headers . to (fmap convertFromProtoPayload))
              memo <- processorDecodePayloads worker.processor (startWorkflow ^. Activation.memo . Message.fields . to (fmap convertFromProtoPayload))
              payloads <- processorDecodePayloads worker.processor (startWorkflow ^. Activation.vec'arguments . to (fmap convertFromProtoPayload))

              pure (searchAttrs, hdrs, memo, payloads)
            case ePayloads of
              Left err -> do
                let appFailure = Err.mkApplicationFailure err worker.workerErrorConverters
                    enrichedApplicationFailure =
                      defMessage
                        & F.message .~ appFailure.message
                        & F.source .~ "hs-temporal-sdk"
                        & F.stackTrace .~ appFailure.stack
                        & F.applicationFailureInfo
                          .~ ( defMessage
                                & F.type' .~ Err.type' appFailure
                                & F.nonRetryable .~ Err.nonRetryable appFailure
                             )
                    failureProto :: Completion.Failure
                    failureProto = defMessage & Completion.failure .~ enrichedApplicationFailure

                    completionMessage =
                      defMessage
                        & Completion.runId .~ (activation ^. Activation.runId)
                        & Completion.failed .~ failureProto
                liftIO $ Core.completeWorkflowActivation workerCore completionMessage
                pure Nothing
              Right (searchAttrs, hdrs, memo, payloads) -> do
                let runId_ = RunId $ activation ^. CommonProto.runId
                    parentProto = initializeWorkflow ^. Activation.maybe'parentWorkflowInfo
                    parentInfo =
                      parentProto <&> \parent ->
                        ParentInfo
                          { parentNamespace = Namespace $ parent ^. CommonProto.namespace
                          , parentRunId = RunId $ parent ^. CommonProto.runId
                          , parentWorkflowId = WorkflowId $ parent ^. CommonProto.workflowId
                          }
                    workflowInfo =
                      Temporal.WorkflowInstance.Info
                        { historyLength = activation ^. Activation.historyLength
                        , attempt = fromIntegral $ initializeWorkflow ^. Activation.attempt
                        , taskQueue = worker.workerTaskQueue
                        , workflowId = WorkflowId $ initializeWorkflow ^. Activation.workflowId
                        , workflowType = initializeWorkflow ^. Activation.workflowType . to WorkflowType
                        , continuedRunId = fmap RunId $ initializeWorkflow ^. Activation.continuedFromExecutionRunId . to nonEmptyString
                        , cronSchedule = initializeWorkflow ^. Activation.cronSchedule . to nonEmptyString
                        , taskTimeout = initializeWorkflow ^. Activation.workflowTaskTimeout . to durationFromProto
                        , executionTimeout = fmap durationFromProto $ initializeWorkflow ^. Activation.maybe'workflowExecutionTimeout
                        , namespace = Namespace $ Core.namespace $ Core.getWorkerConfig workerCore
                        , parent = parentInfo
                        , headers = hdrs
                        , rawMemo = memo
                        , searchAttributes = searchAttrs
                        , retryPolicy = retryPolicyFromProto <$> initializeWorkflow ^. Activation.maybe'retryPolicy
                        , runId = RunId $ activation ^. CommonProto.runId
                        , runTimeout = fmap durationFromProto $ initializeWorkflow ^. Activation.maybe'workflowRunTimeout
                        , startTime =
                            timespecFromTimestamp $
                              fromMaybe
                                (activation ^. Activation.timestamp)
                                (initializeWorkflow ^. Activation.maybe'startTime)
                        , continueAsNewSuggested = False
                        }
                case HashMap.lookup (initializeWorkflow ^. Activation.workflowType) worker.workerWorkflowFunctions of
                  Nothing -> do
                    setStatus s (Error "No workflow definition found")
                    $logInfo "No workflow definition found"
                    let failureProto =
                          defMessage
                            & Completion.failure
                              .~ ( defMessage
                                    & F.message .~ "No workflow definition found"
                                    & F.applicationFailureInfo
                                      .~ ( defMessage
                                            & F.type' .~ "NotFound"
                                            & F.nonRetryable .~ False
                                         )
                                 )
                        completionMessage =
                          defMessage
                            & Completion.runId .~ (activation ^. Activation.runId)
                            & Completion.failed .~ failureProto
                    liftIO (Core.completeWorkflowActivation workerCore completionMessage >>= either throwIO pure)
                    pure Nothing
                  Just (WorkflowDefinition _ f) -> do
                    inst <-
                      create
                        (Core.completeWorkflowActivation workerCore)
                        worker.workerDeadlockTimeout
                        worker.workerErrorConverters
                        worker.workerInboundInterceptors
                        worker.workerOutboundInterceptors
                        worker.workerVault
                        worker.processor
                        workflowInfo

                    liftIO $ addStackTraceHandler inst

                    wf <- runWorkflow inst $ f payloads
                    registerRunningWorkflow runId_ wf

                    pure $ Just wf
          pure $ join (vExistingInstance V.!? 0)

    removeEvictedWorkflowInstances :: ReaderT WorkflowWorker m ()
    removeEvictedWorkflowInstances = forM_ (activation ^. Activation.vec'jobs) $ \job -> do
      case job ^. Activation.maybe'variant of
        Just (WorkflowActivationJob'RemoveFromCache removeFromCache) -> do
          let spanAttrs =
                HashMap.fromList
                  [ ("temporal.workflow.worker.instance_state", toAttribute ("evicted" :: Text))
                  , ("temporal.activation.run_id", toAttribute $ activation ^. CommonProto.runId)
                  ]
          inSpan' "removeEvictedWorkflowInstance" (defaultSpanArguments {attributes = spanAttrs}) $ \s -> do
            worker <- ask
            let runId_ = RunId $ activation ^. CommonProto.runId
            join $ atomically $ do
              currentWorkflows <- readTVar worker.runningWorkflows
              writeTVar worker.runningWorkflows $ HashMap.delete runId_ currentWorkflows
              writeTChan worker.workerEvictionEmitter EvictionWithRunID {runId = runId_, eviction = removeFromCache}
              case HashMap.lookup runId_ currentWorkflows of
                Nothing -> do
                  let msg = Text.pack ("Eviction request on an unknown workflow with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
                  pure $ do
                    setStatus s $ Error msg
                    $(logDebug) msg
                Just wf -> do
                  pure $ do
                    $(logDebug) $ Text.pack ("Evicting workflow instance with run ID " ++ show runId_ ++ ", message: " ++ show (removeFromCache ^. Activation.message))
                    shutdownRunningWorkflow wf
                    $(logDebug) ("Evicted workflow instance with run ID " <> Text.pack (show runId_))
        _ -> $(logDebug) "Nothing to evict this time"

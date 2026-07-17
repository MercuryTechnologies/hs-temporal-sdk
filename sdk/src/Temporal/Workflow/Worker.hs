module Temporal.Workflow.Worker where

import qualified Control.Exception.Annotated as Ann
import Control.Monad
import Control.Monad.Catch (MonadCatch)
import Control.Monad.Logger
import Control.Monad.Reader
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import qualified Data.Map.Strict as Map
import Data.Maybe
import Proto.Decode (decodeMessage)
import Proto.Encode (encodeMessage)
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Vault.Strict (Vault)
import qualified Data.Vector as V
import qualified Focus
import Lens.Family2
import qualified ListT
import OpenTelemetry.Context.ThreadLocal
import OpenTelemetry.Trace.Core hiding (inSpan, inSpan')
import OpenTelemetry.Trace.Monad
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import Proto.Temporal.Api.Common.V1.Message (WorkflowExecution (..))
import qualified Proto.Temporal.Api.Failure.V1.Message as FailureMsg
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as CommonProto
import Proto.Temporal.Sdk.Core.Common.Common (NamespacedWorkflowExecution (..))
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Completion
import RequireCallStack
import qualified StmContainers.Map as StmMap
import Temporal.Common
import Temporal.Common.Async
import qualified Temporal.Common.Logging as Logging
import qualified Temporal.Core.Client as C
import Temporal.Core.Worker (InactiveForReplay)
import qualified Temporal.Core.Worker as Core
import Temporal.Duration (durationFromProto)
import qualified Temporal.Exception as Err
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.Definition
import Temporal.Workflow.Internal.Monad hiding (try)
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
  , runningWorkflows :: {-# UNPACK #-} !(StmMap.Map RunId WorkflowInstance)
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


upsertWorkflowInstance :: (MonadLoggerIO m) => RunId -> WorkflowInstance -> ReaderT WorkflowWorker m WorkflowInstance
upsertWorkflowInstance r inst = do
  worker <- ask
  liftIO $ atomically $ do
    let modifier =
          \case
            Nothing ->
              Just inst
            Just exists ->
              Just exists

    StmMap.focus (Focus.alter modifier >> Focus.lookupWithDefault inst) r worker.runningWorkflows


-- | Execute an action repeatedly as long as it returns True.
whileM_ :: (Monad m) => m Bool -> m ()
whileM_ p = go
  where
    go = do
      x <- p
      when x go


activationHeaderEntriesToMap :: V.Vector a -> (a -> Maybe Text) -> (a -> Maybe Message.Payload) -> Map.Map Text Message.Payload
activationHeaderEntriesToMap entries getKey getValue =
  V.foldr
    ( \entry acc -> case (getKey entry, getValue entry) of
        (Just key, Just value) -> Map.insert key value acc
        _ -> acc
    )
    Map.empty
    entries


{- | Execute this worker until poller shutdown or failure. If there is a failure, this may
need to be called a second time after shutdown initiated to ensure workflow activations
are drained.

The Async handle only completes successfully on poller shutdown.
-}
execute :: (MonadLoggerIO m, MonadUnliftIO m, MonadCatch m, MonadTracer m, RequireCallStack) => WorkflowWorker -> m ()
execute worker@WorkflowWorker {workerCore} = flip runReaderT worker $ do
  Logging.logDebug "Starting workflow worker"
  whileM_ go
  where
    c = Core.getWorkerConfig workerCore
    go = inSpan' "Workflow activation step" defaultSpanArguments $ \s -> do
      -- logs <- liftIO $ fetchLogs globalRuntime
      -- forM_ logs $ \l -> case l.level of
      --   Trace -> Logging.logDebug l.message
      --   Debug -> Logging.logDebug l.message
      --   Temporal.Runtime.Info -> Logging.logInfo l.message
      --   Warn -> Logging.logWarn l.message
      --   Error -> Logging.logError l.message
      eActivation <- pollWorkflowActivation
      case eActivation of
        -- TODO should we do anything else on shutdown?
        (Left (Core.WorkerError Core.PollShutdown _)) -> do
          Logging.logDebug "Poller shutting down"
          runningWorkflows <- liftIO $ ListT.toList $ StmMap.listTNonAtomic $ worker.runningWorkflows
          mapConcurrently_ (cancel <=< readIORef . executionThread . snd) runningWorkflows
          pure False
        (Left err) -> do
          Logging.logError $ Text.pack $ show err
          recordException s mempty Nothing err
          pure True
        (Right activation) -> do
          Logging.logDebug $ Text.pack ("Got activation " <> show activation)
          -- We want to handle activations as fast as possible, so we don't want to block
          -- on dispatching jobs. We link the activator thread to the run-loop so that any
          -- unhandled exceptions in that logic aren't ignored.
          activationCtxt <- getContext
          activator <- asyncLabelled (Text.unpack $ Text.concat ["temporal/worker/workflow/activate", Core.namespace c, "/", Core.taskQueue c]) $ do
            _ <- attachContext activationCtxt
            handleActivation activation
          link activator
          pure True


handleActivation :: forall m. (MonadUnliftIO m, MonadLoggerIO m, MonadCatch m, MonadTracer m) => Core.WorkflowActivation -> ReaderT WorkflowWorker m ()
handleActivation activation = inSpan' "handleActivation" (defaultSpanArguments {attributes = HashMap.fromList [("temporal.activation.run_id", toAttribute $ fromMaybe "" activation.runId)]}) $ \_s -> do
  Logging.logDebug ("Handling activation: RunId " <> Text.pack (show (fromMaybe "" activation.runId)))
  forM_ (activation.jobs) $ \job -> do
    Logging.logDebug ("Job: " <> Text.pack (show job))
  WorkflowWorker {workerCore} <- ask
  {-
  Run jobs
  -}
  if shouldRun
    then do
      mInst <- createOrFetchWorkflowInstance
      forM_ mInst $ \inst -> do
        let withoutStart = V.filter (\job -> case job.variant of Just (WorkflowActivationJob'Variant'InitializeWorkflow _) -> False; _ -> True) activation.jobs
        unless (V.null withoutStart) $
          atomically $ writeTQueue inst.activationChannel (activation { jobs = withoutStart })
    else do
      Logging.logDebug "Workflow does not need to run."
      let completionMessage =
            Completion.WorkflowActivationCompletion
              (Just $ fromMaybe "" activation.runId)
              (Just $ Completion.WorkflowActivationCompletion'Status'Successful mempty)
              []
      liftIO (Core.completeWorkflowActivation workerCore completionMessage >>= either throwIO pure)

  removeEvictedWorkflowInstances
  where
    shouldRun :: Bool
    shouldRun = moreThanOneJob || not removeFromCacheJob
      where
        jobs = activation.jobs
        removeFromCacheJob = V.any (\j -> case j.variant of Just (WorkflowActivationJob'Variant'RemoveFromCache _) -> True; _ -> False) jobs
        moreThanOneJob = V.length jobs > 1

    activationInitializeWorkflowJobs :: V.Vector (WorkflowActivationJob, InitializeWorkflow)
    activationInitializeWorkflowJobs =
      V.mapMaybe
        ( \rawJob ->
            case rawJob.variant of
              Just (WorkflowActivationJob'Variant'InitializeWorkflow initializeWorkflow) -> Just (rawJob, initializeWorkflow)
              _ -> Nothing
        )
        (activation.jobs)

    createOrFetchWorkflowInstance :: ReaderT WorkflowWorker m (Maybe WorkflowInstance)
    createOrFetchWorkflowInstance = inSpan' "createOrFetchWorkflowInstance" (defaultSpanArguments {attributes = HashMap.fromList [("temporal.activation.run_id", toAttribute $ fromMaybe "" activation.runId)]}) $ \s -> do
      worker@WorkflowWorker {workerCore} <- ask
      minst <- atomically $ StmMap.lookup (RunId $ fromMaybe "" activation.runId) worker.runningWorkflows
      case minst of
        Just inst -> do
          addAttribute s "temporal.workflow.worker.instance_state" ("existing" :: Text)
          pure $ Just inst
        Nothing -> do
          addAttribute s "temporal.workflow.worker.instance_state" ("new" :: Text)
          vExistingInstance <- forM activationInitializeWorkflowJobs $ \(_job, initializeWorkflow) -> do
            addAttribute s "temporal.workflow.type" (fromMaybe "" initializeWorkflow.workflowType)
            ePayloads <- Ann.try $ do
              searchAttrs <- liftIO $ do
                decodedAttrs <- searchAttributesFromProto (activationHeaderEntriesToMap (maybe V.empty (.indexedFields) initializeWorkflow.searchAttributes) (.key) (.value))
                either (throwIO . ValueError) pure decodedAttrs
              hdrs <- processorTryDecodePayloads worker.processor (fmap convertFromProtoPayload (activationHeaderEntriesToMap initializeWorkflow.headers (.key) (.value)))
              memo <- processorDecodePayloads worker.processor (fmap convertFromProtoPayload (activationHeaderEntriesToMap (maybe V.empty (.fields) initializeWorkflow.memo) (.key) (.value)))
              pure (searchAttrs, hdrs, memo)
            case ePayloads of
              Left err -> do
                let appFailure = Err.mkApplicationFailure err worker.workerErrorConverters
                    enrichedApplicationFailure = Err.applicationFailureToFailureProto appFailure
                    failureProto :: Completion.Failure
                    failureProto = Completion.Failure (Just enrichedApplicationFailure) Nothing []

                    completionMessage =
                      Completion.WorkflowActivationCompletion
                        (Just $ fromMaybe "" activation.runId)
                        (Just $ Completion.WorkflowActivationCompletion'Status'Failed failureProto)
                        []
                _ <- liftIO $ Core.completeWorkflowActivation workerCore completionMessage
                pure Nothing
              Right (searchAttrs, hdrs, memo) -> do
                let runId_ = RunId $ fromMaybe "" activation.runId
                    parentProto = initializeWorkflow.parentWorkflowInfo
                    parentInfo = case parentProto of
                      Nothing -> Nothing
                      Just parent ->
                        Just
                          ParentInfo
                            { parentNamespace = Namespace $ fromMaybe "" parent.namespace
                            , parentRunId = RunId $ fromMaybe "" parent.runId
                            , parentWorkflowId = WorkflowId $ fromMaybe "" parent.workflowId
                            }
                    rootExec = do
                      rootWf <- initializeWorkflow.rootWorkflow
                      let rWfId = fromMaybe "" rootWf.workflowId
                          rRunId = fromMaybe "" rootWf.runId
                      if Text.null rWfId then Nothing
                      else Just RootExecution
                        { rootWorkflowId = WorkflowId rWfId
                        , rootRunId = RunId rRunId
                        }
                    workflowInfo =
                      Temporal.WorkflowInstance.Info
                        { historyLength = fromMaybe 0 activation.historyLength
                        , attempt = fromIntegral $ fromMaybe 0 initializeWorkflow.attempt
                        , buildId = Core.buildId $ Core.getWorkerConfig workerCore
                        , taskQueue = worker.workerTaskQueue
                        , workflowId = WorkflowId $ fromMaybe "" initializeWorkflow.workflowId
                        , workflowType = WorkflowType $ fromMaybe "" initializeWorkflow.workflowType
                        , continuedRunId = fmap RunId $ nonEmptyString (fromMaybe "" initializeWorkflow.continuedFromExecutionRunId)
                        , continuedFailure = initializeWorkflow.continuedFailure
                        , cronSchedule = nonEmptyString (fromMaybe "" initializeWorkflow.cronSchedule)
                        , taskTimeout = durationFromProto (fromMaybe mempty initializeWorkflow.workflowTaskTimeout)
                        , executionTimeout = fmap durationFromProto $ initializeWorkflow.workflowExecutionTimeout
                        , firstExecutionRunId = RunId $ fromMaybe "" initializeWorkflow.firstExecutionRunId
                        , namespace = Namespace $ Core.namespace $ Core.getWorkerConfig workerCore
                        , parent = parentInfo
                        , headers = hdrs
                        , rawMemo = memo
                        , searchAttributes = searchAttrs
                        , retryPolicy = retryPolicyFromProto <$> initializeWorkflow.retryPolicy
                        , rootExecution = rootExec
                        , runId = RunId $ fromMaybe "" activation.runId
                        , runTimeout = fmap durationFromProto $ initializeWorkflow.workflowRunTimeout
                        , startTime =
                            timespecFromTimestamp $
                              fromMaybe
                                (fromMaybe mempty activation.timestamp)
                                initializeWorkflow.startTime
                        , continueAsNewSuggested = False
                        }
                case HashMap.lookup (fromMaybe "" initializeWorkflow.workflowType) worker.workerWorkflowFunctions of
                  Nothing -> do
                    setStatus s (Error "No workflow definition found")
                    Logging.logInfo "No workflow definition found"
                    let notFoundFailure =
                          FailureMsg.Failure
                            (Just "No workflow definition found")
                            Nothing
                            Nothing
                            Nothing
                            Nothing
                            ( Just $
                                FailureMsg.Failure'FailureInfo'ApplicationFailureInfo $
                                  FailureMsg.ApplicationFailureInfo (Just "NotFound") (Just False) Nothing Nothing Nothing []
                            )
                            []
                        failureProto = Completion.Failure (Just notFoundFailure) Nothing []
                        completionMessage =
                          Completion.WorkflowActivationCompletion
                            (Just $ fromMaybe "" activation.runId)
                            (Just $ Completion.WorkflowActivationCompletion'Status'Failed failureProto)
                            []
                    liftIO (Core.completeWorkflowActivation workerCore completionMessage >>= either throwIO pure)
                    pure Nothing
                  Just (WorkflowDefinition _ f) -> do
                    inst <-
                      create
                        ( \wf -> do
                            Core.completeWorkflowActivation workerCore wf
                        )
                        f
                        worker.workerDeadlockTimeout
                        worker.workerErrorConverters
                        worker.workerInboundInterceptors
                        worker.workerOutboundInterceptors
                        worker.workerVault
                        worker.processor
                        workflowInfo
                        initializeWorkflow
                    liftIO $ addBuiltinQueryHandlers inst
                    Just <$> upsertWorkflowInstance runId_ inst
          pure $ join (vExistingInstance V.!? 0)

    removeEvictedWorkflowInstances :: ReaderT WorkflowWorker m ()
    removeEvictedWorkflowInstances = forM_ (activation.jobs) $ \job -> do
      case job.variant of
        Just (WorkflowActivationJob'Variant'RemoveFromCache removeFromCache) -> do
          let spanAttrs =
                HashMap.fromList
                  [ ("temporal.workflow.worker.instance_state", toAttribute ("evicted" :: Text))
                  , ("temporal.activation.run_id", toAttribute $ fromMaybe "" activation.runId)
                  ]
          inSpan' "removeEvictedWorkflowInstance" (defaultSpanArguments {attributes = spanAttrs}) $ \s -> do
            worker <- ask
            let runId_ = RunId $ fromMaybe "" activation.runId
            join $ atomically $ do
              mworkflow <- StmMap.focus Focus.lookupAndDelete runId_ worker.runningWorkflows
              writeTChan worker.workerEvictionEmitter EvictionWithRunID {runId = runId_, eviction = removeFromCache}
              case mworkflow of
                Nothing -> do
                  let msg = Text.pack ("Eviction request on an unknown workflow with run ID " ++ show runId_ ++ ", message: " ++ show (fromMaybe "" removeFromCache.message))
                  pure $ do
                    setStatus s $ Error msg
                    Logging.logDebug msg
                Just wf -> do
                  pure $ do
                    cancel =<< readIORef wf.executionThread
                    Logging.logDebug $ Text.pack ("Evicting workflow instance with run ID " ++ show runId_ ++ ", message: " ++ show (fromMaybe "" removeFromCache.message))
        _ -> pure ()

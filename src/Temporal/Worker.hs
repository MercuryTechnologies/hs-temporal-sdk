{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
module Temporal.Worker 
  ( WorkflowWorker
  , withWorker
  ) where
import Control.Concurrent.Async
-- TODO replace with something else faster maybe
import Control.Concurrent.Chan
import Data.ByteString (ByteString)
import UnliftIO.Exception
import Control.Monad
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import qualified Data.Vector as V
import Data.Int
import Data.IORef
import Data.Word
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe
import Temporal.Core.Client
import qualified Temporal.Core.Worker as Core
import Temporal.Internal.JobPool
import Temporal.Workflow
import qualified Proto.Temporal.Api.Common.V1.Message as Proto
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Proto
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as CommonProto
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Proto
import qualified Proto.Google.Protobuf.Duration as Duration
import qualified Proto.Google.Protobuf.Duration_Fields as Duration
import qualified Proto.Google.Protobuf.Timestamp as Timestamp
import qualified Proto.Google.Protobuf.Timestamp_Fields as Timestamp
import Lens.Family2
import Lens.Family2.Stock
import Data.ProtoLens.Combinators
import Data.Vector (Vector)
import qualified Data.Vector as Vector
import qualified System.Clock as Clock

import Temporal.Workflow.WorkflowDefinition

newtype WorkflowId = WorkflowId Text
newtype Namespace = Namespace Text
newtype RunId = RunId Text
newtype TaskQueue = TaskQueue Text

data WorkflowWorker env = WorkflowWorker
  { workerCore :: Core.Worker
  , workerTaskQueue :: Text
  -- Function name -> workflow
  , workerWorkflowFunctions :: HashMap Text (WorkflowDefinition env)
  , runningWorkflows :: IORef (HashMap RunId SomeAsync)
  , deadlockedWorkflows :: IORef (HashMap RunId SomeAsync)
  -- , workerActivityFunctions :: HashMap Text (SomeActivity env)
  -- , workerTaskTokensToCancels :: HashMap TaskToken CancellationToken
  }

-- | Execute this worker until poller shutdown or failure. If there is a failure, this may
-- need to be called a second time after shutdown initiated to ensure workflow activations
-- are drained.
--
-- The Async handle only completes successfully on poller shutdown.
withWorker :: Client -> Core.WorkerConfig -> env -> (Async () -> IO a) -> IO a
withWorker client conf env f = do
  completions <- newChan
  withAsync go f
  where
    go = do
      worker <- either throwIO pure =<< Core.newWorker client conf
      withAsync (workflowActivationLoop worker) $ \workflowLoop -> do
        wait workflowLoop
        -- withAsync (activityLoop worker) $ \activityLoop -> do
          -- waitEitherCancel workflowLoop activityLoop
          -- cancel worker
          -- wait worker

execute :: WorkflowWorker env -> IO (Async ())
execute worker = async $ do
  let activationPoller = withJobPool (JobPoolOptions Nothing "temporal_workflow_activation_") $ \jobPool -> forever $ do
        eActivation <- Core.pollWorkflowActivation worker
        case eActivation of
          -- TODO would be nice to shut down more gracefully
          (Left s@(Core.WorkerError Core.PollShutdown _)) -> throwIO s
          (Left err) -> print err
          (Right activation) -> do
            void $ enqueueJob jobPool $ handleActivation worker activation
        
  activationPoller 
  deadlocks <- readIORef $ deadlockedWorkflows worker
  when (not $ null deadlocks) $ do
    -- TODO proper logging
    putStrLn ("[WARN] Deadlocked workflows: " ++ show (HashMap.keys deadlocks))
















-- | Errors that are an issue with the worker itself, not the workflow
--
-- These errors should cause the worker to exit, and imply an issue with the
-- SDK itself.
data RuntimeError = RuntimeError Text
  deriving (Show)
instance Exception RuntimeError

data ApplicationError 
  = WorkflowNotFound Text
  deriving (Show)
instance Exception ApplicationError

data ParentInfo = ParentInfo
  { parentNamespace :: Namespace
  , parentRunId :: RunId
  , parentWorkflowId :: WorkflowId
  }

data RetryPolicy = RetryPolicy
  { initialInterval :: Clock.TimeSpec
  , backoffCoefficient :: Double
  , maximumInterval :: Maybe Clock.TimeSpec
  , maximumAttempts :: Int32
  , nonRetryableErrorTypes :: [Text]
  }

timespecFromDuration :: Duration.Duration -> Clock.TimeSpec
timespecFromDuration d = Clock.TimeSpec
  { Clock.sec = d ^. Duration.seconds
  , Clock.nsec = fromIntegral (d ^. Duration.nanos)
  }

timespecFromTimestamp :: Timestamp.Timestamp -> Clock.TimeSpec
timespecFromTimestamp ts = Clock.TimeSpec
  { Clock.sec = ts ^. Timestamp.seconds
  , Clock.nsec = fromIntegral (ts ^. Timestamp.nanos)
  }

defaultRetryPolicy :: RetryPolicy
defaultRetryPolicy = RetryPolicy
  { initialInterval = Clock.TimeSpec 1 0
  , backoffCoefficient = 2
  , maximumInterval = Nothing
  , maximumAttempts = 0
  , nonRetryableErrorTypes = []
  }

retryPolicyFromProto :: Proto.RetryPolicy -> RetryPolicy
retryPolicyFromProto p = RetryPolicy
  { initialInterval = maybe (initialInterval defaultRetryPolicy) timespecFromDuration (p ^. Proto.maybe'initialInterval)
  , backoffCoefficient = p ^. Proto.backoffCoefficient
  , maximumInterval = maybe (maximumInterval defaultRetryPolicy) (Just . timespecFromDuration) (p ^. Proto.maybe'maximumInterval)
  , maximumAttempts = p ^. Proto.maximumAttempts
  , nonRetryableErrorTypes = p ^. Proto.nonRetryableErrorTypes
  }

data WorkflowInfo = WorkflowInfo
  { attempt :: Int
  , continuedRunId :: RunId
  , cronSchedule :: Text
  -- , headers
  , executionTimeout :: Maybe Clock.TimeSpec
  , namespace :: Namespace
  , parent :: Maybe ParentInfo
  -- , rawMemo :: 
  , retryPolicy :: Maybe RetryPolicy
  , runId :: RunId
  , runTimeout :: Maybe Clock.TimeSpec
  -- TODO convert from proto
  , searchAttributes :: Proto.SearchAttributes
  , startTime :: Clock.TimeSpec
  , taskQueue :: TaskQueue
  , taskTimeout :: Clock.TimeSpec
  , workflowId :: WorkflowId
  , workflowType :: Text
  }

handleActivation :: Core.Worker -> Core.WorkflowActivation -> IO ()
handleActivation worker activation = do
  pure ()
  {-
  Run jobs
  -}
  void $ createWorkflowRunners
  where
    -- Job signaling that a workflow should be removed from the cache
    -- mRemoveJob = findthing (jobs . maybe'variant_ . just_ . _WorkflowActivationJob'RemoveFromCache) activation
    activationStartWorkflowJobs :: Vector (WorkflowActivationJob, StartWorkflow)
    activationStartWorkflowJobs = Vector.mapMaybe 
      (\rawJob -> 
        case rawJob ^. Proto.maybe'variant of
          Just (WorkflowActivationJob'StartWorkflow startWorkflow) -> Just (rawJob, startWorkflow)
          _ -> Nothing
      )
      (activation ^. Proto.vec'jobs)
    createWorkflowRunners = forM activationStartWorkflowJobs $ \(job, startWorkflow) -> do
      let parentProto = startWorkflow ^. Proto.maybe'parentWorkflowInfo
          parentInfo = case parentProto of
            Nothing -> Nothing
            Just parent -> Just ParentInfo
              { parentNamespace = Namespace $ parent ^. CommonProto.namespace
              , parentRunId = RunId $ parent ^. CommonProto.runId
              , parentWorkflowId = WorkflowId $ parent ^. CommonProto.workflowId
              }
          workflowInfo = WorkflowInfo
            { attempt = fromIntegral $ startWorkflow ^. Proto.attempt
            , continuedRunId = RunId $ startWorkflow ^. Proto.continuedFromExecutionRunId
            , cronSchedule = startWorkflow ^. Proto.cronSchedule
            , executionTimeout = fmap timespecFromDuration $ startWorkflow ^. Proto.maybe'workflowExecutionTimeout
            , namespace = Namespace $ Core.namespace $ Core.getWorkerConfig worker
            , parent = parentInfo
            -- , rawMemo ::
            , retryPolicy = retryPolicyFromProto <$> startWorkflow ^. Proto.maybe'retryPolicy
            , runId = RunId $ activation ^. CommonProto.runId
            , runTimeout = fmap timespecFromDuration $ startWorkflow ^. Proto.maybe'workflowRunTimeout
            -- , searchAttributes =
            , startTime = timespecFromTimestamp $ fromMaybe (activation ^. Proto.timestamp) (startWorkflow ^. Proto.maybe'startTime)

            }
      pure ()
          -- TODO
          



applyJobs :: Core.Worker -> Vector WorkflowActivationJob -> IO ()
applyJobs worker jobs = do
  result <- try $ do
    mapM_ applyActivationJob patchNotifications
    mapM_ applyActivationJob signalWorkflows
    mapM_ applyActivationJob queryWorkflows
    mapM_ applyActivationJob otherJobs
  -- TODO Python SDK mentions checking conditions, but I don't know what that means in this context
  pure ()

  where
    (patchNotifications, signalWorkflows, queryWorkflows, otherJobs) = Vector.foldr 
      (\job (patchNotifications, signalWorkflows, queryWorkflows, otherJobs) -> case job ^. Proto.maybe'variant of
        Just (WorkflowActivationJob'NotifyHasPatch _) -> (job : patchNotifications, signalWorkflows, queryWorkflows, otherJobs)
        Just (WorkflowActivationJob'SignalWorkflow _) -> (patchNotifications, job : signalWorkflows, queryWorkflows, otherJobs)
        Just (WorkflowActivationJob'QueryWorkflow _) -> (patchNotifications, signalWorkflows, job : queryWorkflows, otherJobs)
        _ -> (patchNotifications, signalWorkflows, queryWorkflows, job : otherJobs)
      )
      ([], [], [], [])
      jobs

applyActivationJob :: WorkflowActivationJob -> IO ()
applyActivationJob job = case job ^. Proto.maybe'variant of
  Nothing -> throwIO $ RuntimeError "Uncrecognized workflow activation job variant"
  Just variant_ -> case variant_ of
    WorkflowActivationJob'StartWorkflow startWorkflow	-> applyStartWorkflow startWorkflow
    WorkflowActivationJob'FireTimer fireTimer	-> applyFireTimer fireTimer
    WorkflowActivationJob'UpdateRandomSeed updateRandomSeed	-> applyUpdateRandomSeed updateRandomSeed
    WorkflowActivationJob'QueryWorkflow queryWorkflow	-> applyQueryWorkflow queryWorkflow
    WorkflowActivationJob'CancelWorkflow cancelWorkflow	-> applyCancelWorkflow cancelWorkflow
    WorkflowActivationJob'SignalWorkflow signalWorkflow	-> applySignalWorkflow signalWorkflow
    WorkflowActivationJob'ResolveActivity resolveActivity -> applyResolveActivity resolveActivity	 
    WorkflowActivationJob'NotifyHasPatch notifyHasPatch	-> applyNotifyHasPatch notifyHasPatch
    WorkflowActivationJob'ResolveChildWorkflowExecutionStart resolveChildWorkflowExecutionStart	-> applyResolveChildWorkflowExecutionStart resolveChildWorkflowExecutionStart
    WorkflowActivationJob'ResolveChildWorkflowExecution resolveChildWorkflowExecution	-> applyResolveChildWorkflowExecution resolveChildWorkflowExecution
    WorkflowActivationJob'ResolveSignalExternalWorkflow resolveSignalExternalWorkflow	-> applyResolveSignalExternalWorkflow resolveSignalExternalWorkflow
    WorkflowActivationJob'ResolveRequestCancelExternalWorkflow resolveRequestCancelExternalWorkflow	-> applyResolveRequestCancelExternalWorkflow resolveRequestCancelExternalWorkflow
    -- Ignore, handled elsewhere
    WorkflowActivationJob'RemoveFromCache removeFromCache -> pure ()

applyStartWorkflow :: StartWorkflow -> IO ()
applyStartWorkflow startWorkflow = do
  pure ()

applyFireTimer :: FireTimer -> IO ()
applyFireTimer fireTimer = do
  pure ()

applyUpdateRandomSeed :: UpdateRandomSeed -> IO ()
applyUpdateRandomSeed updateRandomSeed = do
  pure ()

applyQueryWorkflow :: QueryWorkflow -> IO ()
applyQueryWorkflow queryWorkflow = do
  pure ()

applyCancelWorkflow :: CancelWorkflow -> IO ()
applyCancelWorkflow cancelWorkflow = do
  pure ()

applySignalWorkflow :: SignalWorkflow -> IO ()
applySignalWorkflow signalWorkflow = do
  pure ()

applyResolveActivity :: ResolveActivity -> IO ()
applyResolveActivity resolveActivity = do
  pure ()

applyNotifyHasPatch :: NotifyHasPatch -> IO ()
applyNotifyHasPatch notifyHasPatch = do
  pure ()

applyResolveChildWorkflowExecutionStart :: ResolveChildWorkflowExecutionStart -> IO ()
applyResolveChildWorkflowExecutionStart resolveChildWorkflowExecutionStart = do
  pure ()

applyResolveChildWorkflowExecution :: ResolveChildWorkflowExecution -> IO ()
applyResolveChildWorkflowExecution resolveChildWorkflowExecution = do
  pure ()

applyResolveSignalExternalWorkflow :: ResolveSignalExternalWorkflow -> IO ()
applyResolveSignalExternalWorkflow resolveSignalExternalWorkflow = do
  pure ()

applyResolveRequestCancelExternalWorkflow :: ResolveRequestCancelExternalWorkflow -> IO ()
applyResolveRequestCancelExternalWorkflow resolveRequestCancelExternalWorkflow = do
  pure ()



  {-
      -- withAsync (workflowActivationHandler activation) $ \handler -> do
      --   eResult <- waitError handler
      --   case eResult of
      --     Left err -> do
      --       -- TODO worker exit, I think
      --       print err
      --     Right ok -> do
      --       _ <- enqueueJob jobPool $ do
              -- * Actually run the workflow, timeout if it takes too long
              -- * handle errors
              --    * set completion failure on parent
              --    * serialize failure for sending to server
              -- * create completion protobuf
              --    * set runId on it
              --    * encode the completion
              -- * send completion to server (completeWorkflowActivation)
                      # If there is a remove-from-cache job, do so
  if remove_job
    if act.run_id in self._running_workflows
      logger.debug(
        "Evicting workflow with run ID %s, message: %s",
        act.run_id,
        remove_job.remove_from_cache.message,
      )
      del self._running_workflows[act.run_id]
    else
      logger.debug(
        "Eviction request on unknown workflow with run ID %s, message: %s",
        act.run_id,
        remove_job.remove_from_cache.message,
      )
    -- If we are failing on eviction, set the error and shutdown the
    -- entire worker
    if self._on_eviction_hook is not None
      try
        self._on_eviction_hook(act.run_id, remove_job.remove_from_cache)
      except Exception as e
        self._throw_after_activation = e
        logger.debug("Shutting down worker on eviction")
        self._bridge_worker().initiate_shutdown()

data WorkflowExitValue a
  = WorkflowContinueAsNew ContinueAsNewWorkflowExecution
  | WorkflowCancelled
  | WorkflowEvicted
  | WorkflowNormal a

data ActivityExitValue a
  = ActivityWillCompleteAsync
  | ActivityNormal a

data CancellableId
  = Timer Word32
  | Activity Word32
  | LocalActivity Word32
  | ChildWorkflow Word32
  | SignalExternalWorkflow Word32
  -- seqnuum, execution, only_child
  | ExternalWorkflow Word32 NamespacedWorkflowExecution Bool
-}
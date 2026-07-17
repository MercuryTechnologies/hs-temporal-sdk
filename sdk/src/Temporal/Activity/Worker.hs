{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}

module Temporal.Activity.Worker where

import Control.Exception.Annotated
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Bifunctor
import Data.Foldable (fold)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import qualified Data.Map.Strict as Map
import Data.Maybe (fromMaybe)
import Proto.Decode (decodeMessage)
import Proto.Encode (encodeMessage)
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime (..))
import qualified Data.Text as T
import qualified Data.Vector as V
import qualified ListT
import qualified Proto.Temporal.Api.Common.V1.Message as P
import qualified Proto.Temporal.Api.Failure.V1.Message as F
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult as AR
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask as AT
import qualified Proto.Temporal.Sdk.Core.CoreInterface as C
import qualified StmContainers.Map as StmMap
import Temporal.Activity.Definition
import Temporal.Activity.Types
import Temporal.Common
import Temporal.Common.Async
import qualified Temporal.Common.Logging as Logging
import qualified Temporal.Core.Worker as Core
import Temporal.Duration (durationFromProto)
import Temporal.Exception
import Temporal.Interceptor
import Temporal.Payload
import UnliftIO
import UnliftIO.Concurrent (threadDelay)


data ActivityWorker env = ActivityWorker
  { activityEnv :: {-# UNPACK #-} !(IORef env)
  , definitions :: {-# UNPACK #-} !(HashMap Text (ActivityDefinition env))
  , runningActivities :: {-# UNPACK #-} !(StmMap.Map TaskToken (Async ()))
  , workerCore :: {-# UNPACK #-} !(Core.Worker 'Core.Real)
  , activityInboundInterceptors :: {-# UNPACK #-} !(ActivityInboundInterceptor env)
  , activityOutboundInterceptors :: {-# UNPACK #-} !(ActivityOutboundInterceptor env)
  , clientInterceptors :: {-# UNPACK #-} !ClientInterceptors
  , activityErrorConverters :: {-# UNPACK #-} ![ApplicationFailureHandler]
  , payloadProcessor :: {-# UNPACK #-} !PayloadProcessor
  }


notifyShutdown :: MonadUnliftIO m => ActivityWorker env -> m ()
notifyShutdown worker = do
  let shutdownGracePeriod = fromIntegral (Core.gracefulShutdownPeriodMillis $ Core.getWorkerConfig worker.workerCore)
  -- TODO logging here
  when (shutdownGracePeriod > 0) $ do
    threadDelay (shutdownGracePeriod * 1000)
  running <- liftIO $ ListT.toList $ StmMap.listTNonAtomic $ worker.runningActivities
  forConcurrently_ running $ \thread -> cancelWith (snd thread) WorkerShutdown


newtype ActivityWorkerM env m a = ActivityWorkerM {unActivityWorkerM :: ReaderT (ActivityWorker env) m a}
  deriving newtype
    ( Functor
    , Applicative
    , Monad
    , MonadIO
    , MonadReader (ActivityWorker env)
    , MonadUnliftIO
    , MonadLogger
    , MonadLoggerIO
    )


runActivityWorker :: (MonadUnliftIO m, MonadLogger m) => ActivityWorker env -> ActivityWorkerM env m a -> m a
runActivityWorker w m = runReaderT (unActivityWorkerM m) w


execute :: (MonadUnliftIO m, MonadLogger m) => ActivityWorker actEnv -> m ()
execute worker = withRunInIO $ \runInIO -> do
  -- NOTE: The poll loop /must/ recurse in a concrete type (in this case that's
  -- 'IO', but it could be a concrete transformer stack) as opposed to the
  -- polymorphic 'm' that this function is constrained by.
  --
  -- Recursing in 'm' means that GHC can't specialize binds, which results in
  -- a space leak per iteration; in this case that gives us an unbounded space
  -- leak roughly proportional to the number of activity tasks handled by this
  -- worker.
  --
  -- Pinning the type to 'IO' and dispatching the task's work to whatever its
  -- 'm' is via 'runInIO' eliminates the space leak.
  let go = do
        eTask <- Core.pollActivityTask worker.workerCore
        case eTask of
          Left (Core.WorkerError Core.PollShutdown _) -> pure ()
          Left e -> do
            runInIO $ Logging.logError (T.pack $ show e)
            throwIO e
          Right task ->
            runInIO (runActivityWorker worker $ applyActivityTask task) *> go
  go


activityInfoFromProto :: MonadIO m => TaskToken -> TaskQueue -> AT.Start -> ActivityWorkerM actEnv m ActivityInfo
activityInfoFromProto tt tq msg = do
  w <- ask
  let rawHdrs =
        foldMap
          (\entry ->
              case (entry.key, entry.value) of
                (Just key, Just value) -> Map.singleton key (convertFromProtoPayload value)
                _ -> mempty
          )
          msg.headerFields
  hdrs <- processorTryDecodePayloads w.payloadProcessor rawHdrs
  heartbeats <- processorDecodePayloads w.payloadProcessor (fmap convertFromProtoPayload msg.heartbeatDetails)
  heartbeatsRef <- newIORef heartbeats
  let workflowExecution = fold msg.workflowExecution
  pure $
    ActivityInfo
      { workflowNamespace = Namespace $ fold msg.workflowNamespace
      , workflowType = WorkflowType $ fold msg.workflowType
      , workflowId = WorkflowId $ fold workflowExecution.workflowId
      , runId = RunId $ fold workflowExecution.runId
      , activityId = ActivityId $ fold msg.activityId
      , activityType = fold msg.activityType
      , headerFields = hdrs
      , rawHeartbeatDetails = heartbeatsRef
      , scheduledTime = maybe (MkSystemTime 0 0) timespecFromTimestamp msg.scheduledTime
      , currentAttemptScheduledTime = maybe (MkSystemTime 0 0) timespecFromTimestamp msg.currentAttemptScheduledTime
      , startedTime = maybe (MkSystemTime 0 0) timespecFromTimestamp msg.startedTime
      , attempt = fromMaybe 0 msg.attempt
      , scheduleToCloseTimeout = fmap durationFromProto msg.scheduleToCloseTimeout
      , startToCloseTimeout = fmap durationFromProto msg.startToCloseTimeout
      , heartbeatTimeout = fmap durationFromProto msg.heartbeatTimeout
      , retryPolicy = fmap retryPolicyFromProto msg.retryPolicy
      , isLocal = fromMaybe False msg.isLocal
      , taskToken = tt
      , taskQueue = tq
      }


{- | Signal to the Temporal worker that the activity will be completed asynchronously (out of band).

In order to complete the activity once it has been moved to async, use 'Temporal.Client.AsyncActivity.complete', 'Temporal.Client.AsyncActivity.fail', or 'Temporal.Client.AsyncActivity.reportCancellation'.

Note: Under the hood, this throws a 'CompleteAsync' exception, which is caught and handled by the Temporal worker.

Make sure that your own code does not swallow or rewrap this exception, otherwise the activity will fail instead
of signalling that it will be completed asynchronously.
-}
completeAsync :: MonadIO m => m ()
completeAsync = throwIO CompleteAsync


applyActivityTask :: (MonadUnliftIO m, MonadLogger m) => AT.ActivityTask -> ActivityWorkerM actEnv m ()
applyActivityTask task = case task.variant of
  Nothing -> throwIO $ RuntimeError "Activity task has no variant or an unknown variant"
  Just (AT.ActivityTask'Variant'Start msg) -> applyActivityTaskStart task tt msg
  Just (AT.ActivityTask'Variant'Cancel msg) -> applyActivityTaskCancel tt msg
  where
    tt = TaskToken $ fromMaybe "" task.taskToken


requireActivityNotRunning :: MonadUnliftIO m => TaskToken -> ActivityWorkerM actEnv m () -> ActivityWorkerM actEnv m ()
requireActivityNotRunning tt m = do
  w <- ask
  running <- atomically $ StmMap.lookup tt w.runningActivities
  case running of
    Just _ -> throwIO $ RuntimeError "Activity task already running"
    Nothing -> m


-- TODO, where should async exception masking happen?
applyActivityTaskStart :: (MonadUnliftIO m, MonadLogger m) => AT.ActivityTask -> TaskToken -> AT.Start -> ActivityWorkerM actEnv m ()
applyActivityTaskStart _tsk tt msg = do
  w <- ask
  let c = Core.getWorkerConfig w.workerCore
      tq = Core.taskQueue c
  info <- activityInfoFromProto tt (TaskQueue tq) msg
  Logging.logInfo $
    T.concat
      [ "Starting activity: "
      , "namespace="
      , Core.namespace c
      , " "
      , "taskQueue="
      , Core.taskQueue c
      , " "
      , "workflowType="
      , rawWorkflowType info.workflowType
      , " "
      , "workflowId="
      , rawWorkflowId info.workflowId
      , " "
      , "activityType="
      , info.activityType
      , " "
      , "activityId="
      , rawActivityId info.activityId
      ]
  requireActivityNotRunning tt $ do
    args <- processorDecodePayloads w.payloadProcessor (fmap convertFromProtoPayload msg.input)
    env <- readIORef w.activityEnv
    let
      actEnv =
        ActivityEnv
          info
          w.clientInterceptors
          w.payloadProcessor
          (Core.recordActivityHeartbeat w.workerCore)
          (Core.getWorkerConfig w.workerCore)
          (Core.getWorkerClient w.workerCore)
      input =
        ExecuteActivityInput
          args
          info.headerFields
          info
    -- We mask here to ensure that the activity is definitely registered
    -- before we start running it. This is important because we need to be able to cancel
    -- it later if the orchestrator requests it.
    mask_ $ do
      syncPoint <- newEmptyMVar
      runningActivity <- asyncLabelled (T.unpack $ T.concat ["temporal/worker/activity/start/", Core.namespace c, "/", Core.taskQueue c]) $ do
        (ef :: Either SomeException (Either String Payload)) <- liftIO $ UnliftIO.trySyncOrAsync $ do
          w.activityInboundInterceptors.executeActivity env input $ \env' input' -> do
            case HashMap.lookup info.activityType w.definitions of
              Nothing -> throwIO $ RuntimeError ("Activity type not found: " <> T.unpack info.activityType)
              Just ActivityDefinition {..} ->
                runReaderT (unActivity $ activityRun input') (actEnv env')
                  `finally` (takeMVar syncPoint *> atomically (StmMap.delete tt w.runningActivities))
        completionMsg <- case ef >>= first (toException . ValueError) of
          Left err@(SomeException _wrappedErr) -> do
            Logging.logDebug (T.pack (show err))
            let appFailure = mkApplicationFailure err w.activityErrorConverters
                enrichedApplicationFailure = applicationFailureToFailureProto appFailure
            pure $
              C.ActivityTaskCompletion
                (Just (rawTaskToken tt))
                (Just $ case fromException err of
                  Just (_cancelled :: ActivityCancelReason) ->
                    AR.ActivityExecutionResult
                      ( Just $
                          AR.ActivityExecutionResult'Status'Cancelled $
                            AR.Cancellation
                              (Just $
                                F.Failure
                                  (Just "Activity cancelled")
                                  Nothing
                                  Nothing
                                  Nothing
                                  Nothing
                                  (Just $ F.Failure'FailureInfo'CanceledFailureInfo $ F.CanceledFailureInfo Nothing [])
                                  [])
                              []
                      )
                      []
                  Nothing ->
                    AR.ActivityExecutionResult
                      (Just $ AR.ActivityExecutionResult'Status'Failed $ AR.Failure (Just enrichedApplicationFailure) [])
                      [])
                []
          Right ok -> do
            Logging.logDebug "Got activity result"
            ok' <- liftIO $ payloadProcessorEncode w.payloadProcessor ok
            pure $
              C.ActivityTaskCompletion
                (Just (rawTaskToken tt))
                (Just $
                  AR.ActivityExecutionResult
                    (Just $ AR.ActivityExecutionResult'Status'Completed $ AR.Success (Just (convertToProtoPayload ok')) [])
                    [])
                []
        Logging.logDebug ("Activity completion message: " <> T.pack (show completionMsg))
        Logging.logInfo $
          T.concat
            [ "Completed activity: "
            , "namespace="
            , Core.namespace c
            , " "
            , "taskQueue="
            , Core.taskQueue c
            , " "
            , "workflowType="
            , rawWorkflowType info.workflowType
            , " "
            , "workflowId="
            , rawWorkflowId info.workflowId
            , " "
            , "activityType="
            , info.activityType
            , " "
            , "activityId="
            , rawActivityId info.activityId
            , " "
            , "status="
            , statusFromCompletion completionMsg
            ]
        completionResult <- liftIO $ Core.completeActivityTask w.workerCore completionMsg
        case completionResult of
          Left err -> throwIO err
          Right _ -> pure ()

      atomically $ StmMap.insert runningActivity tt w.runningActivities
      -- We should only be throwing this exception if the activity has a logical error
      -- that is an internal error to the Temporal worker. If the activity throws an
      -- exception, that should be caught and fed to completeActivityTask.
      --
      -- We use link here to kill the worker thread if the activity throws an exception.
      link runningActivity
      putMVar syncPoint ()
  where
    statusFromCompletion :: C.ActivityTaskCompletion -> Text
    statusFromCompletion completionMsg = case completionMsg.result of
      Just result -> case result.status of
        Just status -> case status of
          AR.ActivityExecutionResult'Status'Completed _ -> "success"
          AR.ActivityExecutionResult'Status'Failed _ -> "failed"
          AR.ActivityExecutionResult'Status'Cancelled _ -> "cancelled"
          AR.ActivityExecutionResult'Status'WillCompleteAsync _ -> "will-complete-async"
        Nothing -> "unknown"
      Nothing -> "unknown"


applyActivityTaskCancel :: (MonadUnliftIO m, MonadLogger m) => TaskToken -> AT.Cancel -> ActivityWorkerM actEnv m ()
applyActivityTaskCancel tt msg = do
  w <- ask
  Logging.logDebug $ "Cancelling activity: " <> T.pack (show tt)
  running <- atomically $ StmMap.lookup tt w.runningActivities
  let cancelReason = case msg.reason of
        Just AT.ActivityCancelReason'NotFound -> NotFound
        Just AT.ActivityCancelReason'Cancelled -> CancelRequested
        Just AT.ActivityCancelReason'TimedOut -> Timeout
        Just AT.ActivityCancelReason'WorkerShutdown -> WorkerShutdown
        -- TODO: PAUSED and RESET need dedicated ActivityCancelReason constructors (follow-up)
        _ -> UnknownCancellationReason
  forM_ running $ \a ->
    cancelWith a cancelReason `finally` atomically (StmMap.delete tt w.runningActivities)

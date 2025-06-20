{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell #-}

module Temporal.Activity.Worker where

import Control.Exception.Annotated
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Bifunctor
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens
import Data.Text (Text)
import qualified Data.Text as T
import Lens.Family2
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as P
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as AR
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask as AT
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields as AT
import qualified Proto.Temporal.Sdk.Core.CoreInterface_Fields as C
import Temporal.Activity.Definition
import Temporal.Activity.Types
import Temporal.Common
import Temporal.Common.Async
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
  , runningActivities :: {-# UNPACK #-} !(TVar (HashMap TaskToken (Async ())))
  , workerCore :: {-# UNPACK #-} !(Core.Worker 'Core.Real)
  , activityInboundInterceptors :: {-# UNPACK #-} !(ActivityInboundInterceptor env)
  , activityOutboundInterceptors :: {-# UNPACK #-} !(ActivityOutboundInterceptor env)
  , clientInterceptors :: {-# UNPACK #-} !ClientInterceptors
  , activityErrorConverters :: {-# UNPACK #-} ![ApplicationFailureHandler]
  , payloadProcessor :: {-# UNPACK #-} !PayloadProcessor
  }


notifyShutdown :: MonadIO m => ActivityWorker env -> m ()
notifyShutdown worker = do
  let shutdownGracePeriod = fromIntegral (Core.gracefulShutdownPeriodMillis $ Core.getWorkerConfig worker.workerCore)
  -- TODO logging here
  when (shutdownGracePeriod > 0) $ do
    threadDelay (shutdownGracePeriod * 1000)
  running <- readTVarIO worker.runningActivities
  forM_ running $ \thread -> cancelWith thread WorkerShutdown


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
execute worker = runActivityWorker worker go
  where
    go = do
      eTask <- liftIO $ Core.pollActivityTask worker.workerCore
      case eTask of
        Left (Core.WorkerError Core.PollShutdown _) -> do
          pure ()
        Left e -> do
          $logError (T.pack (show e))
          throwIO e
        Right task -> do
          applyActivityTask task
          go


activityInfoFromProto :: MonadIO m => TaskToken -> AT.Start -> ActivityWorkerM actEnv m ActivityInfo
activityInfoFromProto tt msg = do
  w <- ask
  hdrs <- processorDecodePayloads w.payloadProcessor (fmap convertFromProtoPayload (msg ^. AT.headerFields))
  heartbeats <- processorDecodePayloads w.payloadProcessor (fmap convertFromProtoPayload (msg ^. AT.vec'heartbeatDetails))
  heartbeatsRef <- newIORef heartbeats
  pure $
    ActivityInfo
      { workflowNamespace = Namespace $ msg ^. AT.workflowNamespace
      , workflowType = WorkflowType $ msg ^. AT.workflowType
      , workflowId = WorkflowId $ msg ^. AT.workflowExecution . P.workflowId
      , runId = RunId $ msg ^. AT.workflowExecution . P.runId
      , activityId = ActivityId $ msg ^. AT.activityId
      , activityType = msg ^. AT.activityType
      , headerFields = hdrs
      , rawHeartbeatDetails = heartbeatsRef
      , scheduledTime = msg ^. AT.scheduledTime . to timespecFromTimestamp
      , currentAttemptScheduledTime = msg ^. AT.currentAttemptScheduledTime . to timespecFromTimestamp
      , startedTime = msg ^. AT.startedTime . to timespecFromTimestamp
      , attempt = msg ^. AT.attempt
      , scheduleToCloseTimeout = fmap durationFromProto (msg ^. AT.maybe'scheduleToCloseTimeout)
      , startToCloseTimeout = fmap durationFromProto (msg ^. AT.maybe'startToCloseTimeout)
      , heartbeatTimeout = fmap durationFromProto (msg ^. AT.maybe'heartbeatTimeout)
      , retryPolicy = fmap retryPolicyFromProto (msg ^. AT.maybe'retryPolicy)
      , isLocal = msg ^. AT.isLocal
      , taskToken = tt
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
applyActivityTask task = case task ^. AT.maybe'variant of
  Nothing -> throwIO $ RuntimeError "Activity task has no variant or an unknown variant"
  Just (AT.ActivityTask'Start msg) -> applyActivityTaskStart task tt msg
  Just (AT.ActivityTask'Cancel msg) -> applyActivityTaskCancel tt msg
  where
    tt = TaskToken $ task ^. AT.taskToken


requireActivityNotRunning :: MonadUnliftIO m => TaskToken -> ActivityWorkerM actEnv m () -> ActivityWorkerM actEnv m ()
requireActivityNotRunning tt m = do
  w <- ask
  running <- readTVarIO w.runningActivities
  case HashMap.lookup tt running of
    Just _ -> throwIO $ RuntimeError "Activity task already running"
    Nothing -> m


-- TODO, where should async exception masking happen?
applyActivityTaskStart :: (MonadUnliftIO m, MonadLogger m) => AT.ActivityTask -> TaskToken -> AT.Start -> ActivityWorkerM actEnv m ()
applyActivityTaskStart tsk tt msg = do
  w <- ask
  $logDebug $ "Starting activity: " <> T.pack (show tsk)
  requireActivityNotRunning tt $ do
    info <- activityInfoFromProto tt msg
    args <- processorDecodePayloads w.payloadProcessor (fmap convertFromProtoPayload (msg ^. AT.vec'input))
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
      let c = Core.getWorkerConfig w.workerCore
      runningActivity <- asyncLabelled (T.unpack $ T.concat ["temporal/worker/activity/start/", Core.namespace c, "/", Core.taskQueue c]) $ do
        (ef :: Either SomeException (Either String Payload)) <- liftIO $ UnliftIO.trySyncOrAsync $ do
          w.activityInboundInterceptors.executeActivity env input $ \env' input' -> do
            case HashMap.lookup info.activityType w.definitions of
              Nothing -> throwIO $ RuntimeError ("Activity type not found: " <> T.unpack info.activityType)
              Just ActivityDefinition {..} ->
                activityRun (actEnv env') input'
                  `finally` (takeMVar syncPoint *> atomically (modifyTVar' w.runningActivities (HashMap.delete tt)))
        completionMsg <- case ef >>= first (toException . ValueError) of
          Left err@(SomeException _wrappedErr) -> do
            $logDebug (T.pack (show err))
            let appFailure = mkApplicationFailure err w.activityErrorConverters
                enrichedApplicationFailure = applicationFailureToFailureProto appFailure
            pure $
              defMessage
                & C.taskToken .~ rawTaskToken tt
                & C.result .~ case fromException err of
                  Just (_cancelled :: ActivityCancelReason) ->
                    defMessage
                      & AR.cancelled
                        .~ ( defMessage
                              & AR.failure
                                .~ ( defMessage
                                      & F.message .~ "Activity cancelled"
                                      & F.canceledFailureInfo
                                        .~ ( defMessage
                                              -- FIXME: provide some details if we have them
                                              & F.details .~ defMessage
                                           )
                                   )
                           )
                  Nothing ->
                    defMessage
                      & AR.failed
                        .~ (defMessage & AR.failure .~ enrichedApplicationFailure)
          Right ok -> do
            $logDebug "Got activity result"
            ok' <- liftIO $ payloadProcessorEncode w.payloadProcessor ok
            pure $
              defMessage
                & C.taskToken .~ rawTaskToken tt
                & C.result
                  .~ ( defMessage
                        & AR.completed
                          .~ (defMessage & AR.result .~ convertToProtoPayload ok')
                     )
        $logDebug ("Activity completion message: " <> T.pack (show completionMsg))
        completionResult <- liftIO $ Core.completeActivityTask w.workerCore completionMsg
        case completionResult of
          Left err -> throwIO err
          Right _ -> pure ()

      atomically $ modifyTVar' w.runningActivities (HashMap.insert tt runningActivity)
      -- We should only be throwing this exception if the activity has a logical error
      -- that is an internal error to the Temporal worker. If the activity throws an
      -- exception, that should be caught and fed to completeActivityTask.
      --
      -- We use link here to kill the worker thread if the activity throws an exception.
      link runningActivity
      putMVar syncPoint ()


applyActivityTaskCancel :: (MonadUnliftIO m, MonadLogger m) => TaskToken -> AT.Cancel -> ActivityWorkerM actEnv m ()
applyActivityTaskCancel tt msg = do
  w <- ask
  $logDebug $ "Cancelling activity: " <> T.pack (show tt)
  running <- readTVarIO w.runningActivities
  let cancelReason = case msg ^. AT.reason of
        AT.NOT_FOUND -> NotFound
        AT.CANCELLED -> CancelRequested
        AT.TIMED_OUT -> Timeout
        AT.WORKER_SHUTDOWN -> WorkerShutdown
        AT.ActivityCancelReason'Unrecognized _ -> UnknownCancellationReason
  forM_ (HashMap.lookup tt running) $ \a ->
    cancelWith a cancelReason `finally` atomically (modifyTVar' w.runningActivities (HashMap.delete tt))

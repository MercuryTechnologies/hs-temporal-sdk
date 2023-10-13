{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE TemplateHaskell #-}
module Temporal.Activity.Worker where
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Bifunctor
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens
import qualified Data.Text as T
import Lens.Family2
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask as AT
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields as AT
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as AR
import qualified Proto.Temporal.Sdk.Core.CoreInterface_Fields as C
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as P
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import Temporal.Activity.Definition
import Temporal.Common
import Temporal.Workflow.Types
import qualified Temporal.Core.Client as Core
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import UnliftIO
import Temporal.Duration (durationFromProto)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)
import Temporal.Interceptor
import Temporal.Activity.Types

data ActivityWorker env = ActivityWorker
  { initialEnv :: env
  , logger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , definitions :: HashMap Text (ActivityDefinition env)
  , runningActivities :: TVar (HashMap TaskToken (Async ()))
  , workerCore :: Core.Worker 'Core.Real
  , activityInboundInterceptors :: ActivityInboundInterceptor
  , activityOutboundInterceptors :: ActivityOutboundInterceptor
  , clientInterceptors :: ClientInterceptors
  }

instance MonadLogger (ActivityWorkerM env) where
  monadLoggerLog loc src lvl msg = do
    w <- ask
    liftIO $ logger w loc src lvl (toLogStr msg)

instance MonadLoggerIO (ActivityWorkerM env) where
  askLoggerIO = do
    w <- ask
    pure $ logger w

newtype ActivityWorkerM env a = ActivityWorkerM { unActivityWorkerM :: ReaderT (ActivityWorker env) IO a }
  deriving
    ( Functor
    , Applicative
    , Monad
    , MonadIO
    , MonadReader (ActivityWorker env)
    , MonadUnliftIO
    )

runActivityWorker :: ActivityWorker env -> ActivityWorkerM env a -> IO a
runActivityWorker w m = runReaderT (unActivityWorkerM m) w

execute :: ActivityWorker actEnv -> IO ()
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

activityInfoFromProto :: TaskToken -> AT.Start -> ActivityInfo
activityInfoFromProto tt msg = ActivityInfo
  { workflowNamespace = Namespace $ msg ^. AT.workflowNamespace
  , workflowType = WorkflowType $ msg ^. AT.workflowType
  , workflowId = WorkflowId $ msg ^. AT.workflowExecution . P.workflowId
  , runId = RunId $ msg ^. AT.workflowExecution . P.runId
  , activityId = ActivityId $ msg ^. AT.activityId
  , activityType = msg ^. AT.activityType
  , headerFields = fmap convertFromProtoPayload (msg ^. AT.headerFields)
  , heartbeatDetails = fmap convertFromProtoPayload (msg ^. AT.vec'heartbeatDetails)
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

-- | Signal to the Temporal worker that the activity will be completed asynchronously (out of band).
--
-- In order to complete the activity once it has been moved to async, use 'Temporal.Client.AsyncActivity.complete', 'Temporal.Client.AsyncActivity.fail', or 'Temporal.Client.AsyncActivity.reportCancellation'.
--
-- Note: Under the hood, this throws a 'CompleteAsync' exception, which is caught and handled by the Temporal worker.
--
-- Make sure that your own code does not swallow or rewrap this exception, otherwise the activity will fail instead
-- of signalling that it will be completed asynchronously.
completeAsync :: MonadIO m => m ()
completeAsync = throwIO CompleteAsync

applyActivityTask :: AT.ActivityTask -> ActivityWorkerM actEnv ()
applyActivityTask task = case task ^. AT.maybe'variant of
  Nothing -> throwIO $ RuntimeError "Activity task has no variant or an unknown variant"
  Just (AT.ActivityTask'Start msg) -> applyActivityTaskStart tt msg
  Just (AT.ActivityTask'Cancel msg) -> applyActivityTaskCancel tt msg
  where
    tt = TaskToken $ task ^. AT.taskToken

requireActivityNotRunning :: TaskToken -> ActivityWorkerM actEnv () -> ActivityWorkerM actEnv ()
requireActivityNotRunning tt m = do
  w <- ask
  running <- readTVarIO w.runningActivities
  case HashMap.lookup tt running of
    Just _ -> throwIO $ RuntimeError "Activity task already running"
    Nothing -> m

-- TODO, where should async exception masking happen?
applyActivityTaskStart :: TaskToken -> AT.Start -> ActivityWorkerM actEnv ()
applyActivityTaskStart tt msg = do
  w <- ask
  $logDebug $ "Starting activity: " <> T.pack (show tt)
  requireActivityNotRunning tt $ do
    let info = activityInfoFromProto tt msg
        env = w.initialEnv
        actEnv = ActivityEnv w.workerCore info w.clientInterceptors env
        input = ExecuteActivityInput
          (fmap convertFromProtoPayload (msg ^. AT.vec'input))
          info.headerFields
          info
    -- We mask here to ensure that the activity is definitely registered
    -- before we start running it. This is important because we need to be able to cancel
    -- it later if the orchestrator requests it.
    mask_ $ do
      syncPoint <- newEmptyMVar
      runningActivity <- async $ do
        (ef :: Either SomeException (Either String Payload)) <- liftIO $ UnliftIO.trySyncOrAsync $ do
          w.activityInboundInterceptors.executeActivity input $ \input' -> do
            case HashMap.lookup info.activityType w.definitions of
              Nothing -> throwIO $ RuntimeError ("Activity type not found: " <> T.unpack info.activityType)
              Just ActivityDefinition{..} -> 
                activityRun actEnv input' `finally` 
                (takeMVar syncPoint *> atomically (modifyTVar' w.runningActivities (HashMap.delete tt)))
        completionMsg <- case join $ fmap (first (toException . ValueError)) ef of
          Left err -> do
            $logError (T.pack (show err))
            pure $ defMessage
              & C.taskToken .~ rawTaskToken tt
              & C.result .~ case fromException err of
              Just AsyncCancelled -> defMessage 
                & AR.cancelled .~ defMessage
              Nothing -> defMessage & AR.failed .~ 
                ( defMessage & AR.failure .~ 
                  ( defMessage 
                    & F.message .~ T.pack (show err)
                    -- TODO, protobuf docs aren't clear on what this should be
                    & F.source .~ "haskell"
                    -- TODO, annotated exceptions might be needed for this
                    & F.stackTrace .~ ""
                    -- TODO encoded attributes
                    -- & F.encodedAttributes .~ _
                    -- & F.cause .~ _
                    & F.activityFailureInfo .~
                    ( defMessage
                      -- & F.scheduledEventId .~ _
                      -- & F.startedEventId .~ _
                      -- TODO, not clear on what this should be
                      & F.identity .~ Core.identity (Core.clientConfig $ Core.getWorkerClient w.workerCore)
                      & F.activityType .~ (defMessage & P.name .~ info.activityType)
                      & F.activityId .~ (msg ^. AT.activityId)
                      -- & F.retryState .~ _
                    )
                  )
                )
          Right ok -> do
            $logDebug "Got activity result"
            pure $ defMessage
              & C.taskToken .~ rawTaskToken tt
              & C.result .~ 
                ( defMessage & AR.completed .~
                  ( defMessage & AR.result .~ convertToProtoPayload ok )
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

applyActivityTaskCancel :: TaskToken -> AT.Cancel -> ActivityWorkerM actEnv ()
applyActivityTaskCancel tt _msg = do
  w <- ask
  $logDebug $ "Cancelling activity: " <> T.pack (show tt)
  running <- readTVarIO w.runningActivities
  forM_ (HashMap.lookup tt running) $ \a ->
    cancel a `finally` atomically (modifyTVar' w.runningActivities (HashMap.delete tt))

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE TemplateHaskell #-}
module Temporal.Activity.Worker where
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
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
import qualified Temporal.Core.Client as Core
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import UnliftIO
import Temporal.Duration (durationFromProto)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data ActivityWorker env = ActivityWorker
  { initialEnv :: env
  , logger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , definitions :: HashMap Text (ActivityDefinition env)
  , runningActivities :: TVar (HashMap TaskToken (Async ()))
  , workerCore :: Core.Worker
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


completeAsync :: MonadIO m => m ()
completeAsync = throwIO CompleteAsync

applyActivityTask :: AT.ActivityTask -> ActivityWorkerM actEnv ()
applyActivityTask task = case task ^. AT.maybe'variant of
  Nothing -> throwIO $ RuntimeError "Activity task has no variant or an unknown variant"
  Just (AT.ActivityTask'Start msg) -> applyActivityTaskStart tt msg
  Just (AT.ActivityTask'Cancel msg) -> applyActivityTaskCancel tt msg
  where
    tt = TaskToken $ task ^. AT.taskToken

-- TODO, where should async exception masking happen?
applyActivityTaskStart :: TaskToken -> AT.Start -> ActivityWorkerM actEnv ()
applyActivityTaskStart tt msg = mask_ $ do
  w <- ask
  $logDebug $ "Starting activity: " <> T.pack (show tt)
  running <- readTVarIO w.runningActivities
  case HashMap.lookup tt running of
    Just _ -> throwIO $ RuntimeError "Activity task already running"
    Nothing -> do
      let info = activityInfoFromProto tt msg
          env = w.initialEnv
      
      a <- async $ do
        ef <- liftIO $ UnliftIO.try $
          case HashMap.lookup info.activityType w.definitions of
            Nothing -> throwIO $ RuntimeError ("Activity type not found: " <> T.unpack info.activityType)
            Just ActivityDefinition{..} -> case activityRun of
              ValidActivityFunction c f applyArgs -> do
                res <- liftIO $ applyArgs f (fmap convertFromProtoPayload (msg ^. AT.vec'input))
                case res of
                  Left err -> throwIO $ ValueError err
                  Right ok -> pure (ok >>= liftIO . Temporal.Payload.encode c)
        case ef of
          Left (SomeException err) -> do
            $logError (T.pack (show err))
            void $ liftIO $ Core.completeActivityTask w.workerCore $ defMessage
              & C.taskToken .~ rawTaskToken tt
              & C.result .~
                ( defMessage & AR.failed .~ 
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
                        & F.identity .~ Core.identity (Core.clientConfig $ Core.getWorkerClient w.workerCore)
                        & F.activityType .~ (defMessage & P.name .~ info.activityType)
                        & F.activityId .~ (msg ^. AT.activityId)
                        -- & F.retryState .~ _
                      )
                    )
                  )
                )
          Right f' -> do
            $logDebug "Activity arguments decoded successfully"
            res <- trySyncOrAsync $ liftIO $ do
              runReaderT (unActivity f') $ ActivityEnv w.workerCore info env
            $logDebug "Got activity result"
            completionResult <- do
              let completionMsg = case res of
                    Right ok -> defMessage
                      & C.taskToken .~ rawTaskToken tt
                      & C.result .~ 
                        ( defMessage & AR.completed .~
                          ( defMessage & AR.result .~ convertToProtoPayload ok )
                        )
                    Left err -> defMessage
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
              $logDebug ("Activity completion message: " <> T.pack (show completionMsg))
              liftIO $ Core.completeActivityTask w.workerCore completionMsg
            $logDebug ("Activity completion result: " <> T.pack (show completionResult))
            atomically $ do
              running' <- readTVar w.runningActivities
              writeTVar w.runningActivities $ HashMap.delete tt running'
            case completionResult of
              Left err -> throwIO err
              Right _ -> pure ()

      atomically $ do
        running' <- readTVar w.runningActivities
        writeTVar w.runningActivities $ HashMap.insert tt a running'
      -- We should only be throwing this exception if the activity has a logical error
      -- that is an internal error to the Temporal worker. If the activity throws an
      -- exception, that should be caught and fed to completeActivityTask.
      --
      -- We use link here to kill the worker thread if the activity throws an exception.
      link a

applyActivityTaskCancel :: TaskToken -> AT.Cancel -> ActivityWorkerM actEnv ()
applyActivityTaskCancel tt _msg = do
  w <- ask
  $logDebug $ "Cancelling activity: " <> T.pack (show tt)
  running <- readTVarIO w.runningActivities
  forM_ (HashMap.lookup tt running) $ \a ->
    cancel a `finally` atomically (modifyTVar' w.runningActivities (HashMap.delete tt))

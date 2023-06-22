{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
module Temporal.Activity.Worker where
import Control.Monad
import Control.Monad.Reader
import Data.ByteString (ByteString)
import Data.Hashable
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Map.Strict (Map)
import Data.ProtoLens
import Data.Text (Text)
import qualified Data.Text as T
import Data.Time.Clock
import Data.Vector (Vector)
import Data.Word
import Lens.Family2
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask as AT
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields as AT
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult as AR
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as AR
import qualified Proto.Temporal.Sdk.Core.CoreInterface as C
import qualified Proto.Temporal.Sdk.Core.CoreInterface_Fields as C
import qualified Proto.Temporal.Api.Common.V1.Message as P
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as P
import qualified Proto.Temporal.Api.Failure.V1.Message as F
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import System.Clock
import Temporal.Activity.Definition
import Temporal.Common
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import Temporal.Internal.JobPool
import Temporal.Worker.Types
import UnliftIO

execute :: Worker wfEnv actEnv -> IO ()
execute worker = runWorkerM worker $ do
  -- TODO, this should be a loop
  forever $ do
    eTask <- liftIO $ Core.pollActivityTask worker.workerCore
    case eTask of
      Left e -> throwIO e
      Right task -> do
        applyActivityTask task

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
  , scheduleToCloseTimeout = fmap timespecFromDuration (msg ^. AT.maybe'scheduleToCloseTimeout)
  , startToCloseTimeout = fmap timespecFromDuration (msg ^. AT.maybe'startToCloseTimeout)
  , heartbeatTimeout = fmap timespecFromDuration (msg ^. AT.maybe'heartbeatTimeout)
  , retryPolicy = fmap retryPolicyFromProto (msg ^. AT.maybe'retryPolicy)
  , isLocal = msg ^. AT.isLocal
  , taskToken = tt
  }


completeAsync :: MonadIO m => m ()
completeAsync = throwIO CompleteAsync

applyActivityTask :: AT.ActivityTask -> WorkerM wfEnv actEnv ()
applyActivityTask task = case task ^. AT.maybe'variant of
  Nothing -> throwIO $ RuntimeError "Activity task has no variant or an unknown variant"
  Just (AT.ActivityTask'Start msg) -> applyActivityTaskStart tt msg
  Just (AT.ActivityTask'Cancel msg) -> applyActivityTaskCancel tt msg
  where
    tt = TaskToken $ task ^. AT.taskToken

-- TODO, where should async exception masking happen?
applyActivityTaskStart :: TaskToken -> AT.Start -> WorkerM wfEnv actEnv ()
applyActivityTaskStart tt msg = do
  w <- ask
  modifyMVar_ w.workerActivityState.runningActivities $ \running -> do
    case HashMap.lookup tt running of
      Just _ -> throwIO $ RuntimeError "Activity task already running"
      Nothing -> do
        let info = activityInfoFromProto tt msg
            env = w.workerConfig.actEnv
        
        ActivityDefinition{..} <- case HashMap.lookup info.activityType w.workerConfig.actDefs of
          Nothing -> throwIO $ RuntimeError ("Activity type not found: " <> T.unpack (info.activityType))
          Just a -> pure a
        a <- async $ do
          ef <- case activityRun of
            ValidActivityFunction c f ap -> liftIO $ UnliftIO.try $ do
              (>>= liftIO . encode c) <$> ap (fmap convertFromProtoPayload (msg ^. AT.vec'input))
          case ef of
            -- TODO proper error handling
            Left (SomeException err) -> throwIO err
            Right f' -> do
              res <- UnliftIO.try $ liftIO $ do
                runReaderT (unActivity f') (w.workerCore, info, env)
              completionResult <- liftIO $ Core.completeActivityTask w.workerCore $ case res of
                Right ok -> defMessage
                  & C.taskToken .~ rawTaskToken tt
                  & C.result .~ 
                    ( defMessage & AR.completed .~
                      ( defMessage & AR.result .~ convertToProtoPayload ok )
                    )
                Left (SomeException err) -> defMessage
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
                            -- TODO, not clear on what this should be
                            -- & F.identity .~ _
                            & F.activityType .~ (defMessage & P.name .~ info.activityType)
                            & F.activityId .~ (msg ^. AT.activityId)
                            -- & F.retryState .~ _
                          )
                        )
                      )
                    )
              modifyMVar_ w.workerActivityState.runningActivities $ \running -> do
                case HashMap.lookup tt running of
                  Nothing -> pure running
                  Just a -> pure $! HashMap.delete tt running
              case completionResult of
                Left err -> throwIO err
                Right _ -> pure ()

        pure $! HashMap.insert tt a running

applyActivityTaskCancel :: TaskToken -> AT.Cancel -> WorkerM wfEnv actEnv ()
applyActivityTaskCancel tt msg = do
  w <- ask
  modifyMVar_ w.workerActivityState.runningActivities $ \running -> do
    case HashMap.lookup tt running of
      Nothing -> pure running
      Just a -> do
        cancel a
        pure $! HashMap.delete tt running










-- runningActivityCancel :: RunningActivity -> ActivityCancelReason -> IO ()
-- runningActivityCancel = undefined

-- runningActivityServerRequestedCancel :: RunningActivity -> IO Bool
-- runningActivityServerRequestedCancel = undefined

-- runningActivityHeartbeatException :: RunningActivity -> IO (Maybe SomeException)
-- runningActivityHeartbeatException = undefined

-- runningActivityMarkDone :: RunningActivity -> IO ()
-- runningActivityMarkDone = undefined

-- runningActivityWaitForHeartbestFinish :: RunningActivity -> IO ()
-- runningActivityWaitForHeartbestFinish = undefined

-- TODO heartbeat utils

-- runActivityWorker = forever $ do
--   task <- Core.pollActivityTask worker
--   result <- runTask task
--   completeActivityTask worker result
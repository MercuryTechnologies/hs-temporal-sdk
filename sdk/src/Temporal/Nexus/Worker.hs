{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}

module Temporal.Nexus.Worker (
  NexusWorker (..),
  NexusOperationHandler (..),
  NexusServiceHandler (..),
  execute,
) where

import Control.Monad (void)
import Control.Monad.IO.Class
import Control.Monad.Logger
import qualified Data.ByteString as BS
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens (defMessage)
import Data.Text (Text)
import qualified Data.Text as T
import Lens.Family2
import qualified Proto.Temporal.Api.Enums.V1.Nexus as NexusEnum
import qualified Proto.Temporal.Api.Nexus.V1.Message as NexusMsg
import qualified Proto.Temporal.Api.Nexus.V1.Message_Fields as NexusMsg
import qualified Proto.Temporal.Sdk.Core.Nexus.Nexus as Nexus
import qualified Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields as Nexus
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as WS
import qualified Temporal.Common.Logging as Logging
import qualified Temporal.Core.Worker as Core
import UnliftIO


data NexusOperationHandler = NexusOperationHandler
  { handleStartOperation :: NexusMsg.StartOperationRequest -> IO (Nexus.NexusTaskCompletion'Status)
  , handleCancelOperation :: NexusMsg.CancelOperationRequest -> IO (Nexus.NexusTaskCompletion'Status)
  }


data NexusServiceHandler = NexusServiceHandler
  { serviceName :: Text
  , operations :: HashMap.HashMap Text NexusOperationHandler
  }


data NexusWorker = NexusWorker
  { workerCore :: !(Core.Worker 'Core.Real)
  , nexusServices :: !(HashMap.HashMap Text NexusServiceHandler)
  }


execute :: (MonadUnliftIO m, MonadLogger m) => NexusWorker -> m ()
execute worker = go
  where
    go = do
      eTask <- liftIO $ Core.pollNexusTask worker.workerCore
      case eTask of
        Left (Core.WorkerError Core.PollShutdown _) ->
          pure ()
        Left e -> do
          Logging.logError (T.pack (show e))
          throwIO e
        Right task -> do
          void $ async $ handleNexusTask worker task
          go


handleNexusTask :: (MonadUnliftIO m, MonadLogger m) => NexusWorker -> Nexus.NexusTask -> m ()
handleNexusTask worker task = do
  case task ^. Nexus.maybe'variant of
    Just (Nexus.NexusTask'Task pollResp) -> do
      let token = pollResp ^. WS.taskToken
          mRequest = pollResp ^. WS.maybe'request
      status <- liftIO $ case mRequest of
        Nothing -> pure $ handlerErrorStatus "Missing request in nexus task" True
        Just req -> case req ^. NexusMsg.maybe'variant of
          Just (NexusMsg.Request'StartOperation startReq) ->
            dispatchStart worker (startReq ^. NexusMsg.service) (startReq ^. NexusMsg.operation) startReq
          Just (NexusMsg.Request'CancelOperation cancelReq) ->
            dispatchCancel worker (cancelReq ^. NexusMsg.service) (cancelReq ^. NexusMsg.operation) cancelReq
          Nothing -> pure $ handlerErrorStatus "Unknown request variant" True
      completeTask worker.workerCore token status

    Just (Nexus.NexusTask'CancelTask cancelTask_) -> do
      let token = cancelTask_ ^. Nexus.taskToken
      completeTask worker.workerCore token (Nexus.NexusTaskCompletion'AckCancel True)

    Nothing -> do
      Logging.logError "Received nexus task with no variant"


dispatchStart :: NexusWorker -> Text -> Text -> NexusMsg.StartOperationRequest -> IO Nexus.NexusTaskCompletion'Status
dispatchStart worker serviceName operationName req =
  case HashMap.lookup serviceName worker.nexusServices of
    Nothing -> pure $ handlerErrorStatus ("Unknown nexus service: " <> serviceName) False
    Just svc -> case HashMap.lookup operationName svc.operations of
      Nothing -> pure $ handlerErrorStatus ("Unknown operation: " <> operationName <> " on service: " <> serviceName) False
      Just handler -> handler.handleStartOperation req


dispatchCancel :: NexusWorker -> Text -> Text -> NexusMsg.CancelOperationRequest -> IO Nexus.NexusTaskCompletion'Status
dispatchCancel worker serviceName operationName req =
  case HashMap.lookup serviceName worker.nexusServices of
    Nothing -> pure $ handlerErrorStatus ("Unknown nexus service: " <> serviceName) False
    Just svc -> case HashMap.lookup operationName svc.operations of
      Nothing -> pure $ handlerErrorStatus ("Unknown operation: " <> operationName <> " on service: " <> serviceName) False
      Just handler -> handler.handleCancelOperation req


completeTask :: (MonadUnliftIO m, MonadLogger m) => Core.Worker 'Core.Real -> BS.ByteString -> Nexus.NexusTaskCompletion'Status -> m ()
completeTask core token status = do
  let completion :: Nexus.NexusTaskCompletion
      completion = defMessage
        & Nexus.taskToken .~ token
        & Nexus.maybe'status .~ Just status
  result <- liftIO $ Core.completeNexusTask core completion
  case result of
    Left err ->
      Logging.logError $ "Failed to complete nexus task: " <> T.pack (show err)
    Right () ->
      pure ()


handlerErrorStatus :: Text -> Bool -> Nexus.NexusTaskCompletion'Status
handlerErrorStatus msg retryable =
  Nexus.NexusTaskCompletion'Error
    ( defMessage
        & NexusMsg.errorType .~ "NOT_FOUND"
        & NexusMsg.retryBehavior
          .~ ( if retryable
                then NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
                else NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
             )
        & NexusMsg.failure .~ (defMessage & NexusMsg.message .~ msg)
    )

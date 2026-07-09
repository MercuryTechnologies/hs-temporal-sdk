{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedRecordDot #-}
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

import Data.Maybe (fromMaybe)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Proto.Temporal.Api.Enums.V1.Nexus as NexusEnum
import qualified Proto.Temporal.Api.Nexus.V1.Message as NexusMsg
import qualified Proto.Temporal.Sdk.Core.Nexus.Nexus as Nexus
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse as WSMsg
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
  case task of
    Nexus.NexusTask mTaskVariant _ -> case mTaskVariant of
      Just (Nexus.NexusTask'Variant'Task (WSMsg.PollNexusTaskQueueResponse mToken mRequest _ _)) -> do
        let token = fromMaybe "" mToken
        status <- liftIO $ case mRequest of
          Nothing -> pure $ handlerErrorStatus "Missing request in nexus task" True
          Just (NexusMsg.Request _ _ mRequestVariant _) -> case mRequestVariant of
            Just (NexusMsg.Request'Variant'StartOperation startReq@(NexusMsg.StartOperationRequest service operation _ _ _ _ _ _)) ->
              dispatchStart worker (fromMaybe "" service) (fromMaybe "" operation) startReq
            Just (NexusMsg.Request'Variant'CancelOperation cancelReq@(NexusMsg.CancelOperationRequest service operation _ _ _)) ->
              dispatchCancel worker (fromMaybe "" service) (fromMaybe "" operation) cancelReq
            Nothing -> pure $ handlerErrorStatus "Unknown request variant" True
        completeTask worker.workerCore token status

      Just (Nexus.NexusTask'Variant'CancelTask (Nexus.CancelNexusTask mToken _ _)) -> do
        let token = fromMaybe "" mToken
        completeTask worker.workerCore token (Nexus.NexusTaskCompletion'Status'AckCancel True)

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
      completion = Nexus.NexusTaskCompletion (Just token) (Just status) []
  result <- liftIO $ Core.completeNexusTask core completion
  case result of
    Left err ->
      Logging.logError $ "Failed to complete nexus task: " <> T.pack (show err)
    Right () ->
      pure ()


handlerErrorStatus :: Text -> Bool -> Nexus.NexusTaskCompletion'Status
handlerErrorStatus msg retryable =
  Nexus.NexusTaskCompletion'Status'Error $
    NexusMsg.HandlerError
      (Just "NOT_FOUND")
      (Just (NexusMsg.Failure (Just msg) mempty Nothing []))
      ( Just
          ( if retryable
              then NexusEnum.NexusHandlerErrorRetryBehavior'NexusHandlerErrorRetryBehaviorRetryable
              else NexusEnum.NexusHandlerErrorRetryBehavior'NexusHandlerErrorRetryBehaviorNonRetryable
          )
      )
      []

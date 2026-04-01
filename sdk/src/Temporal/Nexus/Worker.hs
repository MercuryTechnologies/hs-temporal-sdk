{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}

module Temporal.Nexus.Worker (
  NexusWorker (..),
  NexusOperationHandler (..),
  NexusServiceHandler (..),
  execute,
) where

import Control.Monad.IO.Class
import Control.Monad.Logger
import qualified Data.ByteString as BS
import qualified Data.HashMap.Strict as HashMap
import Data.Map.Strict (Map)
import Data.ProtoLens (defMessage)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Vector as V
import Lens.Family2
import qualified Proto.Temporal.Api.Enums.V1.Nexus as NexusEnum
import Proto.Temporal.Api.Nexus.V1.Message (CancelOperationRequest, Link, Request'Variant (..), StartOperationRequest)
import qualified Proto.Temporal.Api.Nexus.V1.Message_Fields as NexusMsg
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as WS
import qualified Proto.Temporal.Sdk.Core.Nexus.Nexus as Nexus
import qualified Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields as Nexus
import Temporal.Client.Types (WorkflowClient)
import Temporal.Common (Namespace (..), NexusOperationName (..), NexusServiceName (..), TaskQueue (..))
import qualified Temporal.Common.Logging as Logging
import qualified Temporal.Core.Worker as Core
import Temporal.Interceptor (NexusInboundInterceptor (..), NexusOperationContext (..))
import Temporal.Nexus.Types
import Temporal.Payload
import UnliftIO


{- | Domain-level handler for a single Nexus operation.

The SDK applies interceptors and proto conversion automatically;
implementors only deal with domain types.
-}
data NexusOperationHandler env = NexusOperationHandler
  { handleStartOperation
      :: NexusStartInput
      -> NexusHandler env NexusStartResult
  , handleCancelOperation :: Maybe (NexusCancelInput -> NexusHandler env ())
  }


data NexusServiceHandler env = NexusServiceHandler
  { serviceName :: Text
  , operations :: HashMap.HashMap Text (NexusOperationHandler env)
  }


data NexusWorker env = NexusWorker
  { workerCore :: !(Core.Worker 'Core.Real)
  , nexusServices :: !(HashMap.HashMap Text (NexusServiceHandler env))
  , payloadProcessor :: !PayloadProcessor
  , workflowClient :: !WorkflowClient
  , inboundInterceptor :: !NexusInboundInterceptor
  , workerNamespace :: !Namespace
  , workerTaskQueue :: !TaskQueue
  , workerLogger :: !(Loc -> LogSource -> LogLevel -> LogStr -> IO ())
  , workerEnv :: !env
  }


execute :: (MonadUnliftIO m, MonadLogger m) => NexusWorker env -> m ()
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
          a <- async $ handleNexusTask worker task
          link a
          go


handleNexusTask :: (MonadUnliftIO m, MonadLogger m) => NexusWorker env -> Nexus.NexusTask -> m ()
handleNexusTask worker task = do
  case task ^. Nexus.maybe'variant of
    Just (Nexus.NexusTask'Task pollResp) -> do
      let token = pollResp ^. WS.taskToken
          mRequest = pollResp ^. WS.maybe'request
      status <- liftIO $ do
        eResult <- UnliftIO.try $ case mRequest of
          Nothing -> pure $ badRequestErrorStatus "Missing request in nexus task"
          Just req ->
            let reqHeaders = req ^. NexusMsg.header
            in case req ^. NexusMsg.maybe'variant of
                Just (Request'StartOperation startReq) ->
                  dispatchStart worker reqHeaders (startReq ^. NexusMsg.service) (startReq ^. NexusMsg.operation) startReq
                Just (Request'CancelOperation cancelReq) ->
                  dispatchCancel worker reqHeaders (cancelReq ^. NexusMsg.service) (cancelReq ^. NexusMsg.operation) cancelReq
                Nothing -> pure $ badRequestErrorStatus "Unknown request variant"
        case eResult of
          Right s -> pure s
          Left (e :: SomeException) ->
            case fromException e of
              Just handlerErr ->
                pure $ nexusHandlerErrorToStatus handlerErr
              Nothing ->
                pure $ internalErrorStatus ("handler exception: " <> T.pack (show e))
      completeTask worker.workerCore token status
    Just (Nexus.NexusTask'CancelTask cancelTask_) -> do
      let token = cancelTask_ ^. Nexus.taskToken
      completeTask worker.workerCore token (Nexus.NexusTaskCompletion'AckCancel True)
    Nothing -> do
      Logging.logError "Received nexus task with no variant"


{- | Dispatch a start-operation request: proto->domain conversion,
interceptor application, handler invocation, domain->proto conversion.

Applies the 'PayloadProcessor' on both the inbound payload (decode) and the
outbound sync-success payload (encode) so that encryption/compression codecs
are transparent to operation handlers.
-}
dispatchStart :: NexusWorker env -> Map Text Text -> Text -> Text -> StartOperationRequest -> IO Nexus.NexusTaskCompletion'Status
dispatchStart worker reqHeaders svcName opName req =
  case HashMap.lookup svcName worker.nexusServices of
    Nothing -> pure $ notFoundErrorStatus ("Unknown nexus service: " <> svcName)
    Just svc -> case HashMap.lookup opName svc.operations of
      Nothing -> pure $ notFoundErrorStatus ("Unknown operation: " <> opName <> " on service: " <> svcName)
      Just handler -> do
        ePayload <- case fmap convertFromProtoPayload (req ^. NexusMsg.maybe'payload) of
          Nothing -> pure (Right Nothing)
          Just rawPayload -> do
            decoded <- payloadProcessorDecode worker.payloadProcessor rawPayload
            case decoded of
              Left err -> pure (Left ("payload decode failed: " <> T.pack err))
              Right p -> pure (Right (Just p))
        case ePayload of
          Left errMsg -> pure $ internalErrorStatus errMsg
          Right mPayload -> do
            let startInput = NexusStartInput {startInputPayload = mPayload}
                opInfo = extractOperationInfo worker reqHeaders req
                handlerEnv = makeHandlerEnv worker opInfo
                opCtx =
                  NexusOperationContext
                    { nexusCtxServiceName = NexusServiceName svcName
                    , nexusCtxOperationName = NexusOperationName opName
                    , nexusCtxHeaders = reqHeaders
                    }
            result <- worker.inboundInterceptor.handleStartOperation startInput opCtx $ \input' ->
              runNexusHandler handlerEnv (handler.handleStartOperation input')
            processedResult <- case result of
              NexusSyncSuccess payload links -> do
                encoded <- payloadProcessorEncode worker.payloadProcessor payload
                pure $ NexusSyncSuccess encoded links
              other -> pure other
            pure $ startResultToProto processedResult


dispatchCancel :: NexusWorker env -> Map Text Text -> Text -> Text -> CancelOperationRequest -> IO Nexus.NexusTaskCompletion'Status
dispatchCancel worker reqHeaders svcName opName req =
  case HashMap.lookup svcName worker.nexusServices of
    Nothing -> pure $ notFoundErrorStatus ("Unknown nexus service: " <> svcName)
    Just svc -> case HashMap.lookup opName svc.operations of
      Nothing -> pure $ notFoundErrorStatus ("Unknown operation: " <> opName <> " on service: " <> svcName)
      Just handler ->
        case handler.handleCancelOperation of
          Nothing ->
            pure $ Nexus.NexusTaskCompletion'AckCancel True
          Just cancel -> do
            let token = req ^. NexusMsg.operationToken
                cancelInput = NexusCancelInput {cancelInputOperationToken = token, cancelInputHeaders = reqHeaders}
                opInfo =
                  NexusOperationInfo
                    { nexusOpInfoRequestId = ""
                    , nexusOpInfoHeaders = reqHeaders
                    , nexusOpInfoCallbackUrl = ""
                    , nexusOpInfoCallbackHeaders = mempty
                    , nexusOpInfoLinks = mempty
                    , nexusOpInfoService = NexusServiceName svcName
                    , nexusOpInfoOperation = NexusOperationName opName
                    , nexusOpInfoNamespace = worker.workerNamespace
                    , nexusOpInfoTaskQueue = worker.workerTaskQueue
                    }
                handlerEnv = makeHandlerEnv worker opInfo
                opCtx =
                  NexusOperationContext
                    { nexusCtxServiceName = NexusServiceName svcName
                    , nexusCtxOperationName = NexusOperationName opName
                    , nexusCtxHeaders = reqHeaders
                    }
            worker.inboundInterceptor.handleCancelOperation cancelInput opCtx $ \input' ->
              runNexusHandler handlerEnv (cancel input')
            pure $ Nexus.NexusTaskCompletion'AckCancel True


makeHandlerEnv :: NexusWorker env -> NexusOperationInfo -> NexusHandlerEnv env
makeHandlerEnv worker opInfo =
  NexusHandlerEnv
    { nexusHandlerInfo = opInfo
    , nexusHandlerPayloadProcessor = worker.payloadProcessor
    , nexusHandlerWorkflowClient = worker.workflowClient
    , nexusHandlerLogger = worker.workerLogger
    , nexusHandlerEnv = worker.workerEnv
    }


completeTask :: (MonadUnliftIO m, MonadLogger m) => Core.Worker 'Core.Real -> BS.ByteString -> Nexus.NexusTaskCompletion'Status -> m ()
completeTask core token status = do
  let completion :: Nexus.NexusTaskCompletion
      completion =
        defMessage
          & Nexus.taskToken .~ token
          & Nexus.maybe'status .~ Just status
  result <- liftIO $ Core.completeNexusTask core completion
  case result of
    Left err ->
      Logging.logError $ "Failed to complete nexus task: " <> T.pack (show err)
    Right () ->
      pure ()


-- Proto / domain conversion helpers ----------------------------------------

extractOperationInfo :: NexusWorker env -> Map Text Text -> StartOperationRequest -> NexusOperationInfo
extractOperationInfo worker reqHeaders req =
  NexusOperationInfo
    { nexusOpInfoRequestId = req ^. NexusMsg.requestId
    , nexusOpInfoHeaders = reqHeaders
    , nexusOpInfoCallbackUrl = req ^. NexusMsg.callback
    , nexusOpInfoCallbackHeaders = req ^. NexusMsg.callbackHeader
    , nexusOpInfoLinks = V.map convertLink (req ^. NexusMsg.vec'links)
    , nexusOpInfoService = NexusServiceName (req ^. NexusMsg.service)
    , nexusOpInfoOperation = NexusOperationName (req ^. NexusMsg.operation)
    , nexusOpInfoNamespace = worker.workerNamespace
    , nexusOpInfoTaskQueue = worker.workerTaskQueue
    }


convertLink :: Link -> NexusLink
convertLink l =
  NexusLink
    { nexusLinkUrl = l ^. NexusMsg.url
    , nexusLinkType = l ^. NexusMsg.type'
    }


linkToProto :: NexusLink -> Link
linkToProto l =
  defMessage
    & NexusMsg.url .~ l.nexusLinkUrl
    & NexusMsg.type' .~ l.nexusLinkType


startResultToProto :: NexusStartResult -> Nexus.NexusTaskCompletion'Status
startResultToProto (NexusSyncSuccess payload links) =
  let protoPayload = convertToProtoPayload payload
      protoLinks = V.fromList $ fmap linkToProto links
      syncResp = defMessage & NexusMsg.payload .~ protoPayload & NexusMsg.vec'links .~ protoLinks
      startOpResp = defMessage & NexusMsg.syncSuccess .~ syncResp
      response = defMessage & NexusMsg.startOperation .~ startOpResp
  in Nexus.NexusTaskCompletion'Completed response
startResultToProto (NexusAsyncStarted (NexusOperationToken token) links) =
  let protoLinks = V.fromList $ fmap linkToProto links
      asyncResp = defMessage & NexusMsg.operationToken .~ token & NexusMsg.vec'links .~ protoLinks
      startOpResp = defMessage & NexusMsg.asyncSuccess .~ asyncResp
      response = defMessage & NexusMsg.startOperation .~ startOpResp
  in Nexus.NexusTaskCompletion'Completed response
startResultToProto (NexusStartError err) = nexusHandlerErrorToStatus err


{- | Convert a thrown 'NexusHandlerError' to the proto status,
preserving its error type and retry semantics.
-}
nexusHandlerErrorToStatus :: NexusHandlerError -> Nexus.NexusTaskCompletion'Status
nexusHandlerErrorToStatus err =
  Nexus.NexusTaskCompletion'Error
    ( defMessage
        & NexusMsg.errorType .~ err.errorType
        & NexusMsg.retryBehavior
          .~ ( if err.retryable
                then NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
                else NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
             )
        & NexusMsg.failure
          .~ ( defMessage
                & NexusMsg.message .~ err.message
                & NexusMsg.metadata .~ err.failureMetadata
                & NexusMsg.details .~ err.failureDetails
             )
    )


-- | NOT_FOUND — non-retryable. Used for unknown service/operation.
notFoundErrorStatus :: Text -> Nexus.NexusTaskCompletion'Status
notFoundErrorStatus msg =
  Nexus.NexusTaskCompletion'Error
    ( defMessage
        & NexusMsg.errorType .~ "NOT_FOUND"
        & NexusMsg.retryBehavior .~ NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
        & NexusMsg.failure .~ (defMessage & NexusMsg.message .~ msg)
    )


-- | BAD_REQUEST — non-retryable. Used for malformed/missing requests.
badRequestErrorStatus :: Text -> Nexus.NexusTaskCompletion'Status
badRequestErrorStatus msg =
  Nexus.NexusTaskCompletion'Error
    ( defMessage
        & NexusMsg.errorType .~ "BAD_REQUEST"
        & NexusMsg.retryBehavior .~ NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
        & NexusMsg.failure .~ (defMessage & NexusMsg.message .~ msg)
    )


-- | INTERNAL — retryable. Used for unhandled exceptions and infrastructure failures.
internalErrorStatus :: Text -> Nexus.NexusTaskCompletion'Status
internalErrorStatus msg =
  Nexus.NexusTaskCompletion'Error
    ( defMessage
        & NexusMsg.errorType .~ "INTERNAL"
        & NexusMsg.retryBehavior .~ NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
        & NexusMsg.failure .~ (defMessage & NexusMsg.message .~ msg)
    )

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module NexusSpec where

import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens (defMessage)
import qualified Data.Text as T
import Lens.Family2
import qualified Proto.Temporal.Api.Enums.V1.Nexus as NexusEnum
import qualified Proto.Temporal.Api.Nexus.V1.Message_Fields as NexusMsg
import qualified Proto.Temporal.Sdk.Core.Nexus.Nexus as Nexus
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Operator
import Temporal.Payload
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


endpointName :: NexusEndpointName
endpointName = "test-nexus-endpoint"


mkEchoHandler :: NexusOperationHandler
mkEchoHandler = NexusOperationHandler
  { handleStartOperation = \req -> do
      let inputPayload = req ^. NexusMsg.maybe'payload
          syncResp = maybe defMessage (\p -> defMessage & NexusMsg.payload .~ p) inputPayload
          startOpResp = defMessage & NexusMsg.syncSuccess .~ syncResp
          response = defMessage & NexusMsg.startOperation .~ startOpResp
      pure $ Nexus.NexusTaskCompletion'Completed response
  , handleCancelOperation = \_ ->
      pure $ Nexus.NexusTaskCompletion'AckCancel True
  }


mkErrorHandler :: NexusOperationHandler
mkErrorHandler = NexusOperationHandler
  { handleStartOperation = \_ ->
      pure $ Nexus.NexusTaskCompletion'Error
        ( defMessage
            & NexusMsg.errorType .~ "BAD_REQUEST"
            & NexusMsg.retryBehavior .~ NexusEnum.NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
            & NexusMsg.failure .~ (defMessage & NexusMsg.message .~ "intentional test error")
        )
  , handleCancelOperation = \_ ->
      pure $ Nexus.NexusTaskCompletion'AckCancel True
  }


testService :: NexusServiceHandler
testService = NexusServiceHandler
  { serviceName = "test-service"
  , operations = HashMap.fromList
      [ ("echo", mkEchoHandler)
      , ("fail", mkErrorHandler)
      ]
  }


echoCallerWorkflow :: MyWorkflow T.Text
echoCallerWorkflow = do
  let client = W.makeNexusClient endpointName (NexusServiceName "test-service")
      input = encodeJSON ("hello-nexus" :: T.Text)
  result <- W.executeNexusOperation client (NexusOperationName "echo") W.defaultScheduleNexusOperationOptions input
  case decodeJSON result of
    Left err -> error $ "Failed to decode result: " <> show err
    Right val -> pure val


tests :: SpecWith TestEnv
tests = describe "Nexus" $ do
  describe "Endpoint Management" $ do
    specify "create and delete nexus endpoint" $ \TestEnv {..} -> do
      result <- createNexusEndpoint coreClient endpointName (W.Namespace "default") taskQueue
      case result of
        Left err -> expectationFailure $ "Failed to create endpoint: " <> show err
        Right ep -> do
          ep.endpointId `shouldSatisfy` (not . T.null)
          deleteResult <- deleteNexusEndpoint coreClient ep
          deleteResult `shouldBe` Right ()

  describe "Sync Operation" $ do
    specify "workflow calls sync nexus operation and gets result" $ \TestEnv {..} -> do
      let wf = W.provideWorkflow JSON "echoCallerWorkflow" echoCallerWorkflow
          conf = configure () wf $ do
            baseConf
            addNexusServiceHandler testService
      epResult <- createNexusEndpoint coreClient endpointName (W.Namespace "default") taskQueue
      case epResult of
        Left err -> expectationFailure $ "Failed to create endpoint: " <> show err
        Right ep -> do
          withWorker conf $ do
            let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
            result <- useClient (C.execute wf.reference "nexusSyncEcho" opts)
            result `shouldBe` ("hello-nexus" :: T.Text)
          _ <- deleteNexusEndpoint coreClient ep
          pure ()

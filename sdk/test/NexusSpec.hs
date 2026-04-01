{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}

module NexusSpec where

import Control.Exception (bracket)
import Data.Aeson (FromJSON, ToJSON)
import qualified Data.Text as T
import GHC.Generics (Generic)
import qualified Temporal.Client as C
import Temporal.Core.Client (Client)
import Temporal.Duration
import Temporal.Nexus (
  EventReference (..),
  KnownNexusOperation,
  NexusLink (..),
  NexusOperationDefinition,
  NexusOperationInfo (..),
  RequestIdReference (..),
  WorkflowEventLink (..),
  WorkflowEventReference (..),
  WorkflowRunOperationToken (..),
  askNexusOperationContext,
  buildService,
  eventTypeToConstantCase,
  eventTypeToPascalCase,
  generateWorkflowRunOperationToken,
  loadWorkflowRunOperationToken,
  nexusLinkToWorkflowEventLink,
  register,
  syncOperation,
  workflowEventLinkToNexusLink,
  workflowRunOperation,
 )
import qualified Temporal.Nexus as Nexus
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


-- Echo operation: typed sync, returns input unchanged
echoOps :: (NexusOperationDefinition (), KnownNexusOperation T.Text T.Text)
echoOps = syncOperation JSON "echo" pure


echoDef :: NexusOperationDefinition ()
echoDef = fst echoOps


echoRef :: KnownNexusOperation T.Text T.Text
echoRef = snd echoOps


-- RequestId-echo operation: sync, returns the requestId from context
requestIdOps :: (NexusOperationDefinition (), KnownNexusOperation T.Text T.Text)
requestIdOps = syncOperation JSON "request-id-echo" $ \_input -> do
  ctx <- askNexusOperationContext
  pure ctx.nexusOpInfoRequestId


requestIdDef :: NexusOperationDefinition ()
requestIdDef = fst requestIdOps


requestIdRef :: KnownNexusOperation T.Text T.Text
requestIdRef = snd requestIdOps


-- Hello types for async workflow-backed operation
data HelloInput = HelloInput
  { name :: T.Text
  , language :: T.Text
  }
  deriving stock (Show, Eq, Generic)
  deriving anyclass (ToJSON, FromJSON)


data HelloOutput = HelloOutput
  { greeting :: T.Text
  }
  deriving stock (Show, Eq, Generic)
  deriving anyclass (ToJSON, FromJSON)


-- Workflow that the async operation delegates to
helloWorkflow :: HelloInput -> W.Workflow HelloOutput
helloWorkflow input =
  let msg = case input.language of
        "fr" -> "Bonjour, " <> input.name <> "!"
        "de" -> "Hallo, " <> input.name <> "!"
        "es" -> "Hola, " <> input.name <> "!"
        _ -> "Hello, " <> input.name <> "!"
  in pure HelloOutput {greeting = msg}


-- Async workflow-backed operation
helloOps :: (NexusOperationDefinition (), KnownNexusOperation HelloInput HelloOutput)
helloOps = workflowRunOperation JSON "hello" startHello Nothing
  where
    startHello _input =
      pure $ Nexus.NexusOperationToken "not-used-in-sync-test"


helloDef :: NexusOperationDefinition ()
helloDef = fst helloOps


helloRef :: KnownNexusOperation HelloInput HelloOutput
helloRef = snd helloOps


testService :: NexusServiceHandler ()
testService =
  buildService $
    register echoDef $
      register requestIdDef $
        register helloDef $
          Nexus.nexusService "test-service"


-- Caller workflow: sync echo through Nexus
echoCallerWorkflow :: MyWorkflow T.Text
echoCallerWorkflow = do
  let client = W.makeNexusClient endpointName (NexusServiceName "test-service")
  W.executeNexusOperation client echoRef W.defaultScheduleNexusOperationOptions ("hello-nexus" :: T.Text)


-- Caller workflow: returns requestId from Nexus handler
requestIdCallerWorkflow :: MyWorkflow T.Text
requestIdCallerWorkflow = do
  let client = W.makeNexusClient endpointName (NexusServiceName "test-service")
  W.executeNexusOperation client requestIdRef W.defaultScheduleNexusOperationOptions ("probe" :: T.Text)


withEndpoint :: Client -> NexusEndpointName -> W.Namespace -> W.TaskQueue -> (NexusEndpoint -> IO a) -> IO a
withEndpoint client epName ns tq =
  bracket
    ( do
        result <- createNexusEndpoint client epName ns tq
        case result of
          Left err -> error $ "Failed to create endpoint: " <> show err
          Right ep -> pure ep
    )
    (\ep -> deleteNexusEndpoint client ep)


tests :: SpecWith TestEnv
tests = describe "Nexus" $ do
  describe "Endpoint Management" $ do
    specify "create and delete nexus endpoint" $ \TestEnv {..} -> do
      withEndpoint coreClient endpointName (W.Namespace "default") taskQueue $ \ep ->
        ep.endpointId `shouldSatisfy` (not . T.null)

  describe "Sync Operation (typed)" $ do
    specify "workflow calls typed sync nexus operation and gets result" $ \TestEnv {..} -> do
      let wf = W.provideWorkflow JSON "echoCallerWorkflow" echoCallerWorkflow
          conf = configure () wf $ do
            baseConf
            addNexusServiceHandler testService
      withEndpoint coreClient endpointName (W.Namespace "default") taskQueue $ \_ep ->
        withWorker conf $ do
          let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
          result <- useClient (C.execute wf.reference "nexusSyncEcho" opts)
          result `shouldBe` ("hello-nexus" :: T.Text)

  describe "NexusOperationInfo" $ do
    specify "handler receives non-empty requestId from context" $ \TestEnv {..} -> do
      let wf = W.provideWorkflow JSON "requestIdCallerWorkflow" requestIdCallerWorkflow
          conf = configure () wf $ do
            baseConf
            addNexusServiceHandler testService
      withEndpoint coreClient endpointName (W.Namespace "default") taskQueue $ \_ep ->
        withWorker conf $ do
          let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
          result <- useClient (C.execute wf.reference "nexusRequestId" opts)
          result `shouldSatisfy` (not . T.null)

    specify "requestId is stable across retries (non-empty)" $ \TestEnv {..} -> do
      let wf = W.provideWorkflow JSON "requestIdCallerWorkflow2" requestIdCallerWorkflow
          conf = configure () wf $ do
            baseConf
            addNexusServiceHandler testService
      withEndpoint coreClient endpointName (W.Namespace "default") taskQueue $ \_ep ->
        withWorker conf $ do
          let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
          r1 <- useClient (C.execute wf.reference "nexusRequestIdStable1" opts)
          r2 <- useClient (C.execute wf.reference "nexusRequestIdStable2" opts)
          r1 `shouldSatisfy` (not . T.null)
          r2 `shouldSatisfy` (not . T.null)

  describe "WorkflowRunOperationToken" $ do
    specify "roundtrip encode/decode" $ \_ -> do
      let ns = W.Namespace "test-ns"
          wfId = W.WorkflowId "wf-abc-123"
          token = generateWorkflowRunOperationToken ns wfId
      case loadWorkflowRunOperationToken token of
        Left err -> expectationFailure $ "decode failed: " <> T.unpack err
        Right decoded -> do
          decoded.tokenNamespace `shouldBe` "test-ns"
          decoded.tokenWorkflowId `shouldBe` "wf-abc-123"

    specify "roundtrip with unicode" $ \_ -> do
      let ns = W.Namespace "日本語-ns"
          wfId = W.WorkflowId "wf-émojis-🎉"
          token = generateWorkflowRunOperationToken ns wfId
      case loadWorkflowRunOperationToken token of
        Left err -> expectationFailure $ "decode failed: " <> T.unpack err
        Right decoded -> do
          decoded.tokenNamespace `shouldBe` "日本語-ns"
          decoded.tokenWorkflowId `shouldBe` "wf-émojis-🎉"

    specify "decode rejects invalid base64" $ \_ -> do
      let result = loadWorkflowRunOperationToken (Nexus.NexusOperationToken "not-valid-json")
      result `shouldSatisfy` isLeft

    specify "decode rejects unknown token type" $ \_ -> do
      let result = loadWorkflowRunOperationToken (Nexus.NexusOperationToken "eyJ0Ijo5OSwibnMiOiJ4Iiwid2lkIjoieSJ9")
      result `shouldSatisfy` isLeft

    specify "decode rejects unsupported version field" $ \_ -> do
      -- {"t":1,"v":2,"ns":"x","wid":"y"} base64url-encoded
      let result = loadWorkflowRunOperationToken (Nexus.NexusOperationToken "eyJ0IjoxLCJ2IjoyLCJucyI6IngiLCJ3aWQiOiJ5In0")
      result `shouldSatisfy` isLeft

    specify "decode accepts version 0" $ \_ -> do
      -- {"t":1,"v":0,"ns":"x","wid":"y"} base64url-encoded
      let result = loadWorkflowRunOperationToken (Nexus.NexusOperationToken "eyJ0IjoxLCJ2IjowLCJucyI6IngiLCJ3aWQiOiJ5In0")
      case result of
        Left err -> expectationFailure $ "decode failed: " <> T.unpack err
        Right decoded -> do
          decoded.tokenNamespace `shouldBe` "x"
          decoded.tokenWorkflowId `shouldBe` "y"

    specify "decode accepts token without version field" $ \_ -> do
      let ns = W.Namespace "ns"
          wfId = W.WorkflowId "wf"
          token = generateWorkflowRunOperationToken ns wfId
      case loadWorkflowRunOperationToken token of
        Left err -> expectationFailure $ "decode failed: " <> T.unpack err
        Right decoded -> do
          decoded.tokenNamespace `shouldBe` "ns"
          decoded.tokenWorkflowId `shouldBe` "wf"

  describe "Event type format conversion" $ do
    specify "PascalCase to CONSTANT_CASE" $ \_ -> do
      eventTypeToConstantCase "" `shouldBe` ""
      eventTypeToConstantCase "A" `shouldBe` "A"
      eventTypeToConstantCase "Ab" `shouldBe` "AB"
      eventTypeToConstantCase "AbCd" `shouldBe` "AB_CD"
      eventTypeToConstantCase "AbCddE" `shouldBe` "AB_CDD_E"
      eventTypeToConstantCase "ContainsAOneLetterWord" `shouldBe` "CONTAINS_A_ONE_LETTER_WORD"
      eventTypeToConstantCase "NexusOperationScheduled" `shouldBe` "NEXUS_OPERATION_SCHEDULED"
      eventTypeToConstantCase "WorkflowExecutionStarted" `shouldBe` "WORKFLOW_EXECUTION_STARTED"
      eventTypeToConstantCase "WorkflowTaskCompleted" `shouldBe` "WORKFLOW_TASK_COMPLETED"

    specify "CONSTANT_CASE to PascalCase" $ \_ -> do
      eventTypeToPascalCase "" `shouldBe` ""
      eventTypeToPascalCase "A" `shouldBe` "A"
      eventTypeToPascalCase "AB" `shouldBe` "Ab"
      eventTypeToPascalCase "AB_CD" `shouldBe` "AbCd"
      eventTypeToPascalCase "AB_CDD_E" `shouldBe` "AbCddE"
      eventTypeToPascalCase "CONTAINS_A_ONE_LETTER_WORD" `shouldBe` "ContainsAOneLetterWord"
      eventTypeToPascalCase "NEXUS_OPERATION_SCHEDULED" `shouldBe` "NexusOperationScheduled"
      eventTypeToPascalCase "WORKFLOW_EXECUTION_STARTED" `shouldBe` "WorkflowExecutionStarted"

    specify "PascalCase passed through eventTypeToPascalCase unchanged" $ \_ -> do
      eventTypeToPascalCase "NexusOperationScheduled" `shouldBe` "NexusOperationScheduled"
      eventTypeToPascalCase "WorkflowExecutionStarted" `shouldBe` "WorkflowExecutionStarted"

    specify "CONSTANT_CASE passed through eventTypeToConstantCase unchanged" $ \_ -> do
      eventTypeToConstantCase "NEXUS_OPERATION_SCHEDULED" `shouldBe` "NEXUS_OPERATION_SCHEDULED"

  describe "Link conversion" $ do
    specify "roundtrip with EventReference" $ \_ -> do
      let wel =
            WorkflowEventLink
              { welNamespace = "ns2"
              , welWorkflowId = "wid2"
              , welRunId = "rid2"
              , welReference = Just $ WelEventRef $ EventReference 42 "WorkflowExecutionCompleted"
              }
          link = workflowEventLinkToNexusLink wel
      link.nexusLinkType `shouldBe` "temporal.api.common.v1.Link.WorkflowEvent"
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right roundtripped -> roundtripped `shouldBe` wel

    specify "roundtrip with RequestIdReference" $ \_ -> do
      let wel =
            WorkflowEventLink
              { welNamespace = "ns2"
              , welWorkflowId = "wid2"
              , welRunId = "rid2"
              , welReference = Just $ WelRequestIdRef $ RequestIdReference "req-123" "WorkflowTaskCompleted"
              }
          link = workflowEventLinkToNexusLink wel
      link.nexusLinkType `shouldBe` "temporal.api.common.v1.Link.WorkflowEvent"
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right roundtripped -> roundtripped `shouldBe` wel

    specify "roundtrip without reference" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/prod/workflows/wf-1/run-1/history"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right wel -> do
          wel.welNamespace `shouldBe` "prod"
          wel.welWorkflowId `shouldBe` "wf-1"
          wel.welRunId `shouldBe` "run-1"
          wel.welReference `shouldBe` Nothing
          let roundtripped = workflowEventLinkToNexusLink wel
          roundtripped.nexusLinkUrl `shouldBe` link.nexusLinkUrl

    specify "parses PascalCase eventType in URL" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=RequestIdReference&requestID=req-123&eventType=WorkflowTaskCompleted"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right wel -> case wel.welReference of
          Just (WelRequestIdRef ref) ->
            ref.requestIdRefEventType `shouldBe` "WorkflowTaskCompleted"
          other -> expectationFailure $ "expected RequestIdReference, got: " <> show other

    specify "parses CONSTANT_CASE eventType with EVENT_TYPE_ prefix" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=EventReference&eventType=EVENT_TYPE_NEXUS_OPERATION_SCHEDULED&eventID=7"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right wel -> case wel.welReference of
          Just (WelEventRef ref) -> do
            ref.eventRefType `shouldBe` "NexusOperationScheduled"
            ref.eventRefId `shouldBe` 7
          other -> expectationFailure $ "expected EventReference, got: " <> show other

    specify "parses CONSTANT_CASE eventType without prefix" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=EventReference&eventType=NEXUS_OPERATION_SCHEDULED"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right wel -> case wel.welReference of
          Just (WelEventRef ref) ->
            ref.eventRefType `shouldBe` "NexusOperationScheduled"
          other -> expectationFailure $ "expected EventReference, got: " <> show other

    specify "eventID defaults to 0 when missing" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=EventReference&eventType=NexusOperationScheduled"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right wel -> case wel.welReference of
          Just (WelEventRef ref) -> ref.eventRefId `shouldBe` 0
          other -> expectationFailure $ "expected EventReference, got: " <> show other

    specify "requestID defaults to empty when missing" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=RequestIdReference&eventType=WorkflowTaskCompleted"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right wel -> case wel.welReference of
          Just (WelRequestIdRef ref) -> ref.requestIdRefRequestId `shouldBe` ""
          other -> expectationFailure $ "expected RequestIdReference, got: " <> show other

    specify "rejects non-temporal URL scheme" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "https://example.com/workflows"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      nexusLinkToWorkflowEventLink link `shouldSatisfy` isLeft

    specify "rejects invalid URL path" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///badpath"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      nexusLinkToWorkflowEventLink link `shouldSatisfy` isLeft

    specify "rejects unknown referenceType" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=UnknownType"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      nexusLinkToWorkflowEventLink link `shouldSatisfy` isLeft

    specify "rejects EventReference with missing eventType" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=EventReference&eventID=1"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      nexusLinkToWorkflowEventLink link `shouldSatisfy` isLeft

    specify "rejects RequestIdReference with missing eventType" $ \_ -> do
      let link =
            NexusLink
              { nexusLinkUrl = "temporal:///namespaces/ns/workflows/wid/rid/history?referenceType=RequestIdReference&requestID=req"
              , nexusLinkType = "temporal.api.common.v1.Link.WorkflowEvent"
              }
      nexusLinkToWorkflowEventLink link `shouldSatisfy` isLeft

    specify "handles percent-encoded path segments" $ \_ -> do
      let wel =
            WorkflowEventLink
              { welNamespace = "my/namespace"
              , welWorkflowId = "wf/with/slashes"
              , welRunId = "run id"
              , welReference = Nothing
              }
          link = workflowEventLinkToNexusLink wel
      T.isInfixOf "my%2Fnamespace" link.nexusLinkUrl `shouldBe` True
      case nexusLinkToWorkflowEventLink link of
        Left err -> expectationFailure $ "parse failed: " <> T.unpack err
        Right roundtripped -> roundtripped `shouldBe` wel

    specify "serialized event type is always PascalCase" $ \_ -> do
      let wel =
            WorkflowEventLink
              { welNamespace = "ns"
              , welWorkflowId = "wid"
              , welRunId = "rid"
              , welReference = Just $ WelEventRef $ EventReference 7 "NexusOperationScheduled"
              }
          link = workflowEventLinkToNexusLink wel
      T.isInfixOf "eventType=NexusOperationScheduled" link.nexusLinkUrl `shouldBe` True
      T.isInfixOf "EVENT_TYPE" link.nexusLinkUrl `shouldBe` False


isLeft :: Either a b -> Bool
isLeft (Left _) = True
isLeft _ = False

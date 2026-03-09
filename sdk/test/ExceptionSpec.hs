module ExceptionSpec where

import Control.Exception (fromException, toException)
import Data.Int (Int64)
import Data.Maybe (isJust)
import Data.ProtoLens
import Data.ProtoLens.Field (field)
import Data.Text (pack)
import Lens.Family2
import Proto.Temporal.Api.Failure.V1.Message ()
import Temporal.Workflow (ActivityId (..))
import qualified Temporal.Core.Client as Core
import Temporal.Exception (
  ActivityFailure (..),
  ActivityType (..),
  ApplicationFailure (..),
  RetryState (..),
  RPCStatusCode (..),
  RpcError (..),
  RpcErrorDetails (..),
  WorkflowCancelRequested (..),
  WorkflowExecutionClosed (..),
  coreRpcErrorToRpcError,
 )
import Test.Hspec


exampleError :: Core.RpcError
exampleError =
  Core.RpcError
    { Core.code = 6
    , Core.message = "Workflow execution is already running. WorkflowId: zendesk/organization/c4e43516-a488-11eb-bbd4-1b5d0069e6eb, RunId: 0195f782-4076-7e1f-8d9f-6567e745033e."
    , Core.details = "\b\ACK\DC2\154\SOHWorkflow execution is already running. WorkflowId: zendesk/organization/c4e43516-a488-11eb-bbd4-1b5d0069e6eb, RunId: 0195f782-4076-7e1f-8d9f-6567e745033e.\SUB\167\SOH\nWtype.googleapis.com/temporal.api.errordetails.v1.WorkflowExecutionAlreadyStartedFailure\DC2L\n$3f7d236b-fcda-4482-a02d-834c225e5e91\DC2$0195f782-4076-7e1f-8d9f-6567e745033e"
    }


spec :: Spec
spec = do
  describe "RpcError conversion" do
    specify "Core RpcError values should convert to useful Temporal.Exception.RpcError values" $ do
      let rpcError = coreRpcErrorToRpcError exampleError
      rpcError.code `shouldBe` StatusAlreadyExists
      rpcError.message `shouldBe` "Workflow execution is already running. WorkflowId: zendesk/organization/c4e43516-a488-11eb-bbd4-1b5d0069e6eb, RunId: 0195f782-4076-7e1f-8d9f-6567e745033e."
      rpcError.details
        `shouldBe` [ RpcErrorWorkflowExecutionAlreadyStarted $
                      defMessage
                        & field @"startRequestId"
                        .~ "3f7d236b-fcda-4482-a02d-834c225e5e91"
                        & field @"runId"
                        .~ "0195f782-4076-7e1f-8d9f-6567e745033e"
                   ]

  describe "ApplicationFailure hierarchy" $ do
    specify "ApplicationFailure can be created with type and message" $ do
      let af = ApplicationFailure {type' = pack "MyError", message = pack "something failed", nonRetryable = False, details = [], stack = "", nextRetryDelay = Nothing}
      af.type' `shouldBe` pack "MyError"
      af.message `shouldBe` pack "something failed"
    specify "ApplicationFailure is an instance of Exception" $ do
      let af = ApplicationFailure {type' = pack "Test", message = pack "msg", nonRetryable = False, details = [], stack = "", nextRetryDelay = Nothing}
      let ex = toException af
      fromException ex `shouldBe` Just af

  describe "ActivityFailure includes retry state" $ do
    specify "ActivityFailure contains a nested failure" $ do
      let cause = ApplicationFailure {type' = pack "Nested", message = pack "inner", nonRetryable = False, details = [], stack = "", nextRetryDelay = Nothing}
      let af = ActivityFailure {message = pack "activity failed", activityType = ActivityType (pack "MyActivity"), activityId = ActivityId (pack "act-1"), retryState = RetryStateNonRetryableFailure, identity = pack "worker", cause = cause, scheduledEventId = 1 :: Int64, startedEventId = 2 :: Int64, original = defMessage, stack = ""}
      af.cause `shouldBe` cause

  describe "CancellationFailure" $ do
    specify "WorkflowExecutionCanceled is an instance of Exception" $ do
      let ex = toException WorkflowExecutionCanceled
      (fromException ex :: Maybe WorkflowExecutionClosed) `shouldSatisfy` isJust
    specify "WorkflowCancelRequested is an instance of Exception" $ do
      let ex = toException WorkflowCancelRequested
      (fromException ex :: Maybe WorkflowCancelRequested) `shouldSatisfy` isJust

  describe "TimeoutFailure" $ do
    specify "WorkflowExecutionTimedOut is an instance of Exception" $ do
      let ex = toException WorkflowExecutionTimedOut
      (fromException ex :: Maybe WorkflowExecutionClosed) `shouldSatisfy` isJust

  describe "TerminatedFailure" $ do
    specify "WorkflowExecutionTerminated is an instance of Exception" $ do
      let ex = toException WorkflowExecutionTerminated
      (fromException ex :: Maybe WorkflowExecutionClosed) `shouldSatisfy` isJust

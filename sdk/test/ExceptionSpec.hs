{-# LANGUAGE OverloadedLabels #-}
module ExceptionSpec where

import Data.ProtoLens
import Lens.Family2
import qualified Temporal.Core.Client as Core
import Temporal.Exception
import Test.Hspec

exampleError :: Core.RpcError
exampleError = Core.RpcError
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
      rpcError.details `shouldBe`
        [ RpcErrorWorkflowExecutionAlreadyStarted $ defMessage
          & #startRequestId .~ "3f7d236b-fcda-4482-a02d-834c225e5e91"
          & #runId .~ "0195f782-4076-7e1f-8d9f-6567e745033e"
        ]

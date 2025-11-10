{-# LANGUAGE DuplicateRecordFields #-}

module IntegrationSpec.RetryPolicyTests (spec) where

import IntegrationSpec.Utils
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Exception (WorkflowExecutionClosed (..))
import qualified Temporal.Workflow as W
import Test.Hspec


-- | RetryPolicy tests - verify retry behavior for activities
spec :: SpecWith TestEnv
spec = describe "RetryPolicy" $ do
  specify "is used for retryable failures" $ \TestEnv {..} -> do
    let conf = configure () testConf $ do
          baseConf

    withWorker conf $ do
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
              , C.timeouts =
                  C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
              }
      useClient (C.execute testRefs . retryableFailureTest "use-for-retryable" opts)
  -- `shouldThrow` (== WorkflowExecutionFailed)

  specify "ignored for non-retryable failures" $ \TestEnv {..} -> do
    let conf = configure () testConf $ do
          baseConf

    withWorker conf $ do
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
              , C.timeouts =
                  C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
              }
      useClient (C.execute testRefs . nonRetryableFailureTest "ignore-non-retryable" opts)
        `shouldThrow` \case
          (WorkflowExecutionFailed _) -> True
          _ -> False

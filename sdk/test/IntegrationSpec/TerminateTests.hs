{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module IntegrationSpec.TerminateTests (spec) where

import Data.Maybe (fromJust)
import DiscoverInstances (discoverInstances)
import IntegrationSpec.NoOpWorkflow (NoOpWorkflow (..))
import IntegrationSpec.Utils
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import Temporal.Exception (RpcError (..))
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions, workflowRef)
import qualified Temporal.Workflow as W
import Test.Hspec


-- | Terminate and WorkflowIdConflictPolicy tests
spec :: SpecWith TestEnv
spec = do
  describe "Terminate" $ do
    describe "when neither runId nor firstExecutionRunId is provided" $ do
      it "returns" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient $ do
            C.start NoOpWorkflow "test-terminate-works-without-run-ids" opts
            h <- C.getHandle (workflowRef NoOpWorkflow) "test-terminate-works-without-run-ids" Nothing Nothing
            C.terminate
              h {C.workflowHandleRunId = Nothing, C.workflowHandleFirstExecutionRunId = Nothing}
              C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
    describe "when runId is provided without firstExecutionRunId" $ do
      it "returns if runId matches a workflow" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient $ do
            h <- C.start NoOpWorkflow "test-terminate-works-with-good-run-id" opts
            h' <- C.getHandle (workflowRef NoOpWorkflow) "test-terminate-works-with-good-run-id" h.workflowHandleRunId Nothing
            C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
      it "throws if runId does not match a workflow" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $
          do
            let opts =
                  (C.startWorkflowOptions taskQueue)
                    { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                    }
            ( useClient $ do
                h <- C.start NoOpWorkflow "test-terminate-throws-with-bad-run-id" opts
                h' <- C.getHandle (workflowRef NoOpWorkflow) "test-terminate-throws-with-bad-run-id" (Just "bad-run-id") Nothing
                C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
              )
            `shouldThrow` \case
              RpcError {} -> True
              _ -> False
    describe "when firstExecutionRunId is provided without runId" $ do
      it "returns if firstExecutionRunId matches a workflow" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient $ do
            h <- C.start NoOpWorkflow "test-terminate-works-with-good-first-execution-run-id" opts
            h' <-
              C.getHandle
                (workflowRef NoOpWorkflow)
                "test-terminate-works-with-good-first-execution-run-id"
                Nothing
                $ Just C.GetHandleOptions {C.firstExecutionRunId = Just $ fromJust h.workflowHandleFirstExecutionRunId}
            C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
      it "throws if firstExecutionRunId does not match a workflow" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $
          do
            let opts =
                  (C.startWorkflowOptions taskQueue)
                    { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                    }
            ( useClient $ do
                h <- C.start NoOpWorkflow "test-terminate-throws-with-bad-first-execution-run-id" opts
                h' <-
                  C.getHandle
                    (workflowRef NoOpWorkflow)
                    "test-terminate-throws-with-bad-first-execution-run-id"
                    Nothing
                    $ Just C.GetHandleOptions {C.firstExecutionRunId = Just "bad-first-execution-run-id"}
                C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
              )
            `shouldThrow` \case
              RpcError {} -> True
              _ -> False
    describe "when both runId and firstExecutionRunId are provided" $ do
      it "returns if both runId and firstExecutionRunId match a workflow" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient $ do
            h <- C.start NoOpWorkflow "test-terminate-works-with-good-run-id-bad-first-execution-run-id" opts
            h' <-
              C.getHandle
                (workflowRef NoOpWorkflow)
                "test-terminate-works-with-good-run-id-bad-first-execution-run-id"
                h.workflowHandleRunId
                $ Just
                  C.GetHandleOptions
                    { C.firstExecutionRunId = Just $ fromJust h.workflowHandleFirstExecutionRunId
                    }
            C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
      it "throws if runId does not match a workflow" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient
            ( do
                h <- C.start NoOpWorkflow "test-terminate-works-with-bad-run-id-good-first-execution-run-id" opts
                h' <-
                  C.getHandle
                    (workflowRef NoOpWorkflow)
                    "test-terminate-works-with-bad-run-id-good-first-execution-run-id"
                    (Just "bad-run-id")
                    ( Just
                        C.GetHandleOptions
                          { C.firstExecutionRunId = Just $ fromJust h.workflowHandleFirstExecutionRunId
                          }
                    )
                C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
            )
            `shouldThrow` \case
              RpcError {} -> True
              _ -> False
      it "throws if firstExecutionRunId does not match a workflow" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $
          do
            let opts =
                  (C.startWorkflowOptions taskQueue)
                    { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                    }
            useClient
              ( do
                  h <- C.start NoOpWorkflow "test-terminate-throws-good-run-id-bad-first-execution-run-id" opts
                  h' <-
                    C.getHandle
                      (workflowRef NoOpWorkflow)
                      "test-terminate-throws-with-good-run-id-bad-first-execution-run-id"
                      (Just $ fromJust h.workflowHandleRunId)
                      (Just C.GetHandleOptions {C.firstExecutionRunId = Just "bad-first-execution-run-id"})
                  C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
              )
            `shouldThrow` \case
              RpcError {} -> True
              _ -> False

  describe "WorkflowIdConflictPolicy" $ do
    specify "Fail policy prevents duplicate workflows" $ \TestEnv {..} -> do
      let wfId = WorkflowId "test-conflict-fail"
          opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdConflictPolicy = Just C.WorkflowIdConflictPolicyFail
              }

      -- Start first workflow
      h1 <- useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)

      -- Try to start second with same ID - should fail
      useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)
        `shouldThrow` \case
          RpcError {} -> True
          _ -> False

    specify "UseExisting policy returns existing workflow" $ \TestEnv {..} -> do
      let wfId = WorkflowId "test-conflict-use-existing"
          opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdConflictPolicy = Just C.WorkflowIdConflictPolicyUseExisting
              }

      -- Start first workflow
      h1 <- useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)

      -- Start second with same ID - should return handle to existing
      h2 <- useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)

      -- Both handles should refer to same execution
      h1.workflowHandleWorkflowId `shouldBe` h2.workflowHandleWorkflowId
      h1.workflowHandleRunId `shouldBe` h2.workflowHandleRunId

    specify "TerminateExisting policy terminates old workflow" $ \TestEnv {..} -> do
      let wfId = WorkflowId "test-conflict-terminate"
          opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdConflictPolicy = Just C.WorkflowIdConflictPolicyTerminateExisting
              }

      -- Start first workflow
      h1 <- useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)

      -- Start second with same ID - should terminate first and start new
      h2 <- useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)

      -- Should have different run IDs but same workflow ID
      h1.workflowHandleRunId `shouldNotBe` h2.workflowHandleRunId
      h1.workflowHandleWorkflowId `shouldBe` h2.workflowHandleWorkflowId

    specify "Default conflict policy works with TerminateIfRunning reuse policy" $ \TestEnv {..} -> do
      let wfId = WorkflowId "test-terminate-if-running-no-conflict-policy"
          opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyTerminateIfRunning
              }

      -- Start first workflow
      h1 <- useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)

      -- Start second with same ID - should terminate first and start new
      h2 <- useClient (C.start testRefs.shouldRunWorkflowTest wfId opts)

      -- Should have different run IDs but same workflow ID
      h1.workflowHandleRunId `shouldNotBe` h2.workflowHandleRunId
      h1.workflowHandleWorkflowId `shouldBe` h2.workflowHandleWorkflowId

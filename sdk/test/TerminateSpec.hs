{-# LANGUAGE TemplateHaskell #-}

module TerminateSpec where

import Data.Maybe (fromJust)
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Exception
import Temporal.Payload
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


sleepyWorkflow :: W.Workflow ()
sleepyWorkflow = provideCallStack $ W.sleep (seconds 3600)


spec :: Spec
spec = withTestServer_ tests


tests :: SpecWith TestEnv
tests = describe "Terminate" $ do
  let wf = W.provideWorkflow defaultCodec "sleepyWorkflow" sleepyWorkflow

  describe "without runId or firstExecutionRunId" $ do
    it "succeeds" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient $ do
          _ <- C.start wf . reference "term-no-ids" opts
          h <- C.getHandle wf . reference "term-no-ids" Nothing Nothing
          C.terminate
            h {C.workflowHandleRunId = Nothing, C.workflowHandleFirstExecutionRunId = Nothing}
            C.TerminationOptions {terminationReason = "testing", terminationDetails = []}

  describe "with runId" $ do
    it "succeeds with matching runId" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient $ do
          h <- C.start wf . reference "term-good-run" opts
          h' <- C.getHandle wf . reference "term-good-run" h . workflowHandleRunId Nothing
          C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}

    it "throws with non-matching runId" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        ( useClient $ do
            _ <- C.start wf . reference "term-bad-run" opts
            h' <- C.getHandle wf . reference "term-bad-run" (Just "bad-run-id") Nothing
            C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
          )
          `shouldThrow` \(RpcError {}) -> True

  describe "with firstExecutionRunId" $ do
    it "succeeds with matching firstExecutionRunId" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient $ do
          h <- C.start wf . reference "term-good-first" opts
          h' <-
            C.getHandle wf . reference "term-good-first" Nothing $
              Just C.GetHandleOptions {C.firstExecutionRunId = Just $ fromJust h . workflowHandleFirstExecutionRunId}
          C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}

    it "throws with non-matching firstExecutionRunId" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        ( useClient $ do
            _ <- C.start wf . reference "term-bad-first" opts
            h' <-
              C.getHandle wf . reference "term-bad-first" Nothing $
                Just C.GetHandleOptions {C.firstExecutionRunId = Just "bad-first-execution-run-id"}
            C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
          )
          `shouldThrow` \(RpcError {}) -> True

  describe "with both runId and firstExecutionRunId" $ do
    it "succeeds when both match" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient $ do
          h <- C.start wf . reference "term-both-good" opts
          h' <-
            C.getHandle wf . reference "term-both-good" h . workflowHandleRunId $
              Just C.GetHandleOptions {C.firstExecutionRunId = Just $ fromJust h . workflowHandleFirstExecutionRunId}
          C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}

    it "throws when runId doesn't match" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient
          ( do
              h <- C.start wf . reference "term-bad-run-both" opts
              h' <-
                C.getHandle wf . reference "term-bad-run-both" (Just "bad-run-id") $
                  Just C.GetHandleOptions {C.firstExecutionRunId = Just $ fromJust h . workflowHandleFirstExecutionRunId}
              C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
          )
          `shouldThrow` \(RpcError {}) -> True

    it "throws when firstExecutionRunId doesn't match" $ \TestEnv {..} -> do
      let conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        ( useClient $ do
            h <- C.start wf . reference "term-bad-first-both" opts
            h' <-
              C.getHandle wf
                . reference
                  "term-bad-first-both"
                  (Just $ fromJust h . workflowHandleRunId)
                  (Just C.GetHandleOptions {C.firstExecutionRunId = Just "bad-first-execution-run-id"})
            C.terminate h' C.TerminationOptions {terminationReason = "testing", terminationDetails = []}
          )
          `shouldThrow` \(RpcError {}) -> True

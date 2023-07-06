{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
module IntegrationSpec where

import Control.Applicative
import Control.Exception
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Data.Text (Text)
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import System.Clock
import Test.Hspec
import Temporal.Core.Client
import qualified Temporal.Client as C
import Temporal.Exception
import qualified Temporal.Workflow as W
import Temporal.Payload
import Temporal.Worker
import Temporal.Runtime

withWorker :: WorkerConfig wfEnv actEnv -> IO a -> IO a
withWorker conf m = do
  rt <- initializeRuntime
  let clientConfig = defaultClientConfig
  (Right c) <- connectClient rt clientConfig
  bracket (runNoLoggingT $ startWorker c conf) shutdown (const m)


makeClient :: IO C.WorkflowClient
makeClient = do
  rt <- initializeRuntime
  let clientConfig = defaultClientConfig
  (Right c) <- connectClient rt clientConfig
  C.workflowClient c (W.Namespace "test") Nothing

uuidText :: IO Text
uuidText = UUID.toText <$> UUID.nextRandom

spec :: Spec
spec = beforeAll makeClient needsClient

needsClient :: SpecWith C.WorkflowClient 
needsClient = do
  describe "Workflow" $ do
    it "should run a workflow" $ \client -> do
      taskQueue <- W.TaskQueue <$> uuidText
      let testFn :: W.Workflow () () Bool
          testFn = pure True
          wf = W.provideWorkflow JSON "test" () testFn
          conf = configure () () $ do
            setNamespace $ W.Namespace "test"
            setTaskQueue taskQueue
            addWorkflow wf
      withWorker conf $ do
        wfId <- uuidText
        let opts = C.workflowStartOptions
              (W.WorkflowId wfId)
              taskQueue
        C.execute client wf.reference opts
          `shouldReturn` True
    describe "race" $ do
      it "immediate return works" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () Bool
            testFn = pure True `W.race` pure False
            wf = W.provideWorkflow JSON "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True

      it "block on left side works" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () Bool
            testFn = do
              (W.sleep (TimeSpec 5000 0) >> error "sad") `W.race` pure True
            wf = W.provideWorkflow JSON "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True

      it "block on both side works" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () Bool
            testFn = do
              (W.sleep (TimeSpec 5000 0) >> error "sad") `W.race` (W.sleep (TimeSpec 1 0) >> pure True)
            wf = W.provideWorkflow JSON "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True

      it "throws immediately when either side throws" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () Bool
            testFn = do
              (W.sleep (TimeSpec 5000 0) >> error "sad") `W.race` error "foo"
            wf = W.provideWorkflow JSON "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldThrow` (== WorkflowExecutionFailed)

      it "treats error as ok if LHS returns immediately" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () Bool
            testFn = do
              pure True `W.race` error "foo"
            wf = W.provideWorkflow JSON "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True

    describe "Args and return values" $ do
      specify "args should be passed to the workflow in the correct order" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: Int -> Text -> Bool -> W.Workflow () () (Int, Text, Bool)
            testFn a b c = pure (a, b, c)
            wf = W.provideWorkflow JSON "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts 1 "two" False
            `shouldReturn` (1, "two", False)
      specify "args that parse incorrectly should fail a Workflow appropriately" $ \client -> do
        pending
      specify "args that parse incorrectly should fail an Activity appropriately" $ \client -> do
        pending
      specify "Workflow return values that parse incorrectly should throw a ValueException for Client" $ \client -> do
        pending
      specify "ChildWorkflow return values that parse incorrectly should throw a ValueException in a Workflow" $ \client -> do
        pending
      specify "Activity return values that parse incorrectly should throw a ValueException in a Workflow" $ \client -> do
        pending

    -- describe "not found" $ do
    --   xit "should result in a task retry" $ \client -> do
    --     taskQueue <- W.TaskQueue <$> uuidText
    --     let conf = configure () () $ do
    --           setNamespace $ W.Namespace "test"
    --           setTaskQueue taskQueue
    --     withWorker conf $ do
    --       wfId <- uuidText
    --       let opts = C.workflowStartOptions
    --             (W.WorkflowId wfId)
    --             taskQueue
    --       -- pending
    --       let nonExistentWorkflow :: W.KnownWorkflow '[] ()
    --           nonExistentWorkflow = W.KnownWorkflow JSON Nothing Nothing "foo"
    --       _wfHandle <- C.start client nonExistentWorkflow opts
    --       _ <- getLine
    --       pure ()



          
  --     specify "the workflow should return the correct value" pending
  --   describe "Cancellation" $ do
  --     specify "cancel a workflow" pending
  --     specify "cancelling a workflow cancels its activities" pending
  --   describe "Randomness" $ do
  --     specify "randomness is deterministic" pending
  --   describe "Time" $ do
  --     specify "time is deterministic" pending
  --   describe "Activity failures" $ do
  --     specify "ApplicationFailure exception" pending
  --     specify "ActivityFailure exception" pending
  --     specify "Non-wrapped exception" pending
    describe "Child workflows" $ do
      specify "invoke" $ \client -> do
        parentId <- uuidText
        let isEven :: Int -> W.Workflow () () Bool
            isEven x = pure (x `mod` 2 == 0)
            isEventWf = W.provideWorkflow JSON "isEven" () isEven
            parentWorkflow :: W.Workflow () () Bool
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow @() @() isEventWf.reference W.defaultChildWorkflowOptions childWorkflowId 2
              W.waitChildWorkflowResult childWorkflow
            parentWf = W.provideWorkflow JSON "parent" () parentWorkflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow isEventWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId parentId)
                (W.TaskQueue "test")
          C.execute client parentWf.reference opts
            `shouldReturn` True

      specify "failure" $ \client -> do
        parentId <- uuidText
        let busted :: W.Workflow () () ()
            busted = error "busted"
            bustedWf = W.provideWorkflow JSON "busted" () busted
            parentWorkflow :: W.Workflow () () ()
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow @() @() bustedWf.reference W.defaultChildWorkflowOptions childWorkflowId
              W.waitChildWorkflowResult childWorkflow
            parentWf = W.provideWorkflow JSON "parent" () parentWorkflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow bustedWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId parentId)
                (W.TaskQueue "test")
          C.execute client parentWf.reference opts
            `shouldThrow` (== WorkflowExecutionFailed)

      specify "termination" $ \_ -> pending
      specify "timeout" $ \_ -> pending
      specify "startFail" $ \_ -> pending
      specify "cancel" $ \client -> do
        parentId <- uuidText
        let cancelTest :: W.Workflow () () ()
            cancelTest = pure ()
            childWf = W.provideWorkflow JSON "cancelTest" () cancelTest
            parentWorkflow :: W.Workflow () () Bool
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow childWf.reference W.defaultChildWorkflowOptions childWorkflowId
              W.cancelChildWorkflowExecution childWorkflow
              result <- Catch.try $ W.waitChildWorkflowResult childWorkflow
              pure (result == Left ChildWorkflowCancelled)
            parentWf = W.provideWorkflow JSON "parent" () parentWorkflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow childWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId parentId)
                (W.TaskQueue "test")
          C.execute client parentWf.reference opts
            `shouldReturn` True

  --     describe "Signals" $ do
  --       specify "send" pending
  --       specify "interrupt" pending
  --       specify "fail" pending
  --       specify "async fail signal?" pending
  --       specify "always delivered" pending
  --     describe "Query" $ do
  --       specify "query not found" pending
  --       specify "query and unblock" pending
  --   describe "Await condition" $ do
  --     specify "it works" pending
    describe "Sleep" $ do
      specify "sleep" $ \client -> do
        wfId <- uuidText
        let workflow :: W.Workflow () () Bool
            workflow = do
              earlier <- W.now
              W.sleep $ TimeSpec 0 1
              later <- W.now
              pure (later > earlier) 
            wf = W.provideWorkflow JSON "sleepy" () workflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow wf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                (W.TaskQueue "test")
          C.execute client wf.reference opts
            `shouldReturn` True


  --   describe "Timer" $ do
  --     specify "timer" pending
  --     specify "timer and cancel immediately" pending
  --     specify "timer and cancel with delay" pending
  --   describe "Patching" $ do
  --     specify "patch" pending
  --     specify "deprecated patch" pending
  --   specify "default server options" pending
  --   describe "Search attributes" $ do
  --     specify "can read search attributes set at start" pending
  --     specify "can upsert search attributes" pending
  --   describe "Info" $ do
  --     specify "can read workflow info" pending
  --   describe "WorkflowOptions" $ do
  --     specify "passed correctly with defaults" pending
  --     specify "passed correctly" pending
  --   describe "WorkflowHandle" $ do
  --     specify "throws exception if remote workflow is terminated" pending
  --     specify "throws if continued as new" pending
  --     specify "follows chain of execution" pending
  --   describe "ContinueAsNew" $ do
  --     specify "to different workflow" pending
  --     specify "to same workflow keeps memo and search attributes" pending
  --     specify "to different workflow keeps memo and search attributes by default" pending
  --     specify "to different workflow can set memo and search attributes" pending
  --   describe "signalWithStart" $ do
  --     specify "works as intended and returns correct runId" pending
  --   describe "RetryPolicy" $ do
  --     specify "is used for retryable failures" pending
  --     specify "ignored for non-retryable failures" pending
  -- describe "WorkflowClient" $ do
  --   specify "WorkflowExecutionAlreadyStartedError" pending
  --   specify "follows only own execution chain" pending
  --   specify "Handle from signalWithStart follows only own execution chain" pending
  --   specify "getHandle only follows own execution chain" pending
  --   specify "Handle from start terminates run after continue as new" pending
  --   specify "Handle from start does not terminate run after continue as new if given runId" pending
  -- specify "Download and replay multiple executions with client list method" pending

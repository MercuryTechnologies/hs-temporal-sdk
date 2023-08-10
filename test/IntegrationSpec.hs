{-# OPTIONS_GHC -fplugin=IfSat.Plugin #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}
module IntegrationSpec where

import Control.Applicative
import Control.Exception
import Control.Concurrent
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.ByteString (ByteString)
import Data.ProtoLens
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import System.Clock
import Test.Hspec
import Temporal.Core.Client
import qualified Temporal.Client as C
import Temporal.Exception
import qualified Temporal.Workflow as W
import Temporal.Activity
import Temporal.Payload
import Temporal.Worker
import Temporal.Runtime
import System.IO.Unsafe
import System.Timeout (timeout)

rt :: Runtime
rt = unsafePerformIO initializeRuntime
{-# NOINLINE rt #-}

withWorker :: WorkerConfig wfEnv actEnv -> IO a -> IO a
withWorker conf m = do
  let clientConfig = defaultClientConfig
  (Right c) <- connectClient rt clientConfig
  bracket (runStdoutLoggingT $ startWorker c conf) shutdown (const m)

makeClient :: IO C.WorkflowClient
makeClient = do
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
    fspecify "should run a workflow" $ \client -> do
      taskQueue <- W.TaskQueue <$> uuidText
      let testFn :: W.Workflow () () ()
          testFn = pure ()
          wf = W.provideWorkflow JSON "test" () testFn
          conf = configure () () $ do
            setNamespace $ W.Namespace "test"
            setTaskQueue taskQueue
            addWorkflow wf
      withWorker conf $ do
        wfId <- uuidText
        let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ TimeSpec 4 0
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client wf.reference opts
          `shouldReturn` ()
    describe "race" $ do
      specify "block on left side works" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () (Either Bool Bool)
            testFn = do
              res <- ($(logDebug) "sleepy lad" >> W.sleep (TimeSpec 10 0) >> $(logDebug) "bad" >> pure False) `W.race` ($(logDebug) "wow" *> pure True)
              $(logDebug) "done"
              pure res
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
            `shouldReturn` Right True
      specify "block on both side works" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () (Either Bool Bool)
            testFn = do
              (W.sleep (TimeSpec 5000 0) >> pure False) `W.race` (W.sleep (TimeSpec 1 0) >> pure True)
            wf = W.provideWorkflow JSON "blockBothSides" () testFn
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
            `shouldReturn` Right True
      specify "throws immediately when either side throws" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () (Either Bool Bool)
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
      specify "treats error as ok if LHS returns immediately" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () (Either Bool Bool)
            testFn = do
              pure True `W.race` (W.sleep (TimeSpec 5000 0) *> error "sad")
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
            `shouldReturn` Left True
    describe "Activities" $ do
      specify "should run a basic activity without issues" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testActivity :: Activity () Int
            testActivity = pure 1

            testActivityAct :: ProvidedActivity () (Activity () Int)
            testActivityAct = provideActivity JSON "test" testActivity
            
            testFn :: W.Workflow () () Int
            testFn = do
              h <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ TimeSpec 3 0)
              W.wait (h :: W.Task () () Int)
            wf = W.provideWorkflow JSON "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
              addActivity testActivityAct
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` 1
      specify "heartbeat works" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testActivity :: Activity () Int
            testActivity = do
              heartbeat []
              liftIO $ threadDelay 1000000
              pure 1

            testActivityAct :: ProvidedActivity () (Activity () Int)
            testActivityAct = provideActivity JSON "basicHeartbeat" testActivity
            
            testFn :: W.Workflow () () Int
            testFn = do
              h <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ TimeSpec 3 0)
              W.wait (h :: W.Task () () Int)
            wf = W.provideWorkflow JSON "basicHeartbeat" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
              addActivity testActivityAct
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` 1
      specify "should properly handle faulty workflows" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testActivity :: Activity () Int
            testActivity = do
              res <- askActivityInfo
              if res.attempt <= 2
                then do
                  liftIO $ putStrLn "failing"
                  error "sad"
                else pure 1

            testActivityAct :: ProvidedActivity () (Activity () Int)
            testActivityAct = provideActivity JSON "faultyWorkflow" testActivity
            
            testFn :: W.Workflow () () Int
            testFn = do
              h1 <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ TimeSpec 1 0)
              h2 <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ TimeSpec 1 0)
              W.wait (h1 :: W.Task () () Int)
              W.wait (h2 :: W.Task () () Int)

            wf = W.provideWorkflow JSON "faultyWorkflow" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
              addActivity testActivityAct
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` 1
      specify "Immediate activity cancellation returns the expected result to workflows" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testActivity :: Activity () Int
            testActivity = do
              heartbeat []
              pure 0

            testActivityAct :: ProvidedActivity () (Activity () Int)
            testActivityAct = provideActivity JSON "immediateCancelResponse" testActivity
            
            testFn :: W.Workflow () () Int
            testFn = do
              h1 <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ TimeSpec 1 0)
              W.cancel (h1 :: W.Task () () Int)
              W.wait h1 `Catch.catch` \(_ :: ActivityCancelled) -> pure 1

            wf = W.provideWorkflow JSON "activityCancellation" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
              addActivity testActivityAct
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ TimeSpec 4 0
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` 1
      xspecify "Activity cancellation on heartbeat returns the expected result to workflows" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testActivity :: Activity () Int
            testActivity = do
              liftIO $ threadDelay 2000000
              heartbeat []
              pure 0

            testActivityAct :: ProvidedActivity () (Activity () Int)
            testActivityAct = provideActivity JSON "heartbeatAllowsOpportunityToCancel" testActivity
            
            testFn :: W.Workflow () () Int
            testFn = do
              h1 <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ TimeSpec 1 0)
              W.sleep $ TimeSpec 0 1
              W.cancel (h1 :: W.Task () () Int)
              W.wait h1 `Catch.catch` \(_ :: ActivityCancelled) -> pure 1

            wf = W.provideWorkflow JSON "activityCancellationOnHeartbeat" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
              addActivity testActivityAct
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue) 
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ TimeSpec 4 0
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` 1




    describe "Args and return values" $ do
      fspecify "args should be passed to the workflow in the correct order" $ \client -> do
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
      fspecify "binary payloads work" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: ByteString -> W.Workflow () () ByteString
            testFn _ = pure "general kenobi"
            wf = W.provideWorkflow defaultCodec "test" () testFn
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue taskQueue
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts "hello there."
            `shouldReturn` "general kenobi"
  --     specify "args that parse incorrectly should fail a Workflow appropriately" $ \client -> do
  --       pending
  --     specify "args that parse incorrectly should fail an Activity appropriately" $ \client -> do
  --       pending
  --     specify "Workflow return values that parse incorrectly should throw a ValueException for Client" $ \client -> do
  --       pending
  --     specify "ChildWorkflow return values that parse incorrectly should throw a ValueException in a Workflow" $ \client -> do
  --       pending
  --     specify "Activity return values that parse incorrectly should throw a ValueException in a Workflow" $ \client -> do
  --       pending

  --   describe "not found" $ do
  --     xit "should result in a task retry" $ \client -> do
  --       taskQueue <- W.TaskQueue <$> uuidText
  --       let conf = configure () () $ do
  --             setNamespace $ W.Namespace "test"
  --             setTaskQueue taskQueue
  --       withWorker conf $ do
  --         wfId <- uuidText
  --         let opts = C.workflowStartOptions
  --               (W.WorkflowId wfId)
  --               taskQueue
  --         -- pending
  --         let nonExistentWorkflow :: W.KnownWorkflow '[] ()
  --             nonExistentWorkflow = W.KnownWorkflow JSON Nothing Nothing "foo"
  --         _wfHandle <- C.start client nonExistentWorkflow opts
  --         _ <- getLine
  --         pure ()



          
  --   --   specify "the workflow should return the correct value" pending
  --   -- describe "Cancellation" $ do
  --   --   specify "cancel a workflow" pending
  --   --   specify "cancelling a workflow cancels its activities" pending
  --   -- describe "Randomness" $ do
  --   --   specify "randomness is deterministic" pending
    describe "Time" $ do
      specify "time is deterministic" $ \client -> do
        taskQueue <- W.TaskQueue <$> uuidText
        let testFn :: W.Workflow () () (UTCTime, UTCTime, UTCTime)
            testFn = do
              t1 <- W.now
              t2 <- W.now
              W.sleep $ TimeSpec 0 1
              t3 <- W.now
              pure (t1, t2, t3)
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
          (t1, t2, t3) <- C.execute client wf.reference opts
          t1 `shouldBe` t2
          t3 `shouldSatisfy` (> t2)

  --   -- describe "Activity failures" $ do
  --   --   specify "ApplicationFailure exception" pending
  --   --   specify "ActivityFailure exception" pending
  --   --   specify "Non-wrapped exception" pending
    describe "Child workflows" $ do
      specify "invoke" $ \client -> do
        parentId <- uuidText
        let isEven :: Int -> W.Workflow () () Bool
            isEven x = pure (x `mod` 2 == 0)
            isEventWf = W.provideWorkflow JSON "isEven" () isEven
            parentWorkflow :: W.Workflow () () Bool
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              let opts :: W.StartChildWorkflowOptions
                  opts = W.defaultChildWorkflowOptions { W.runTimeout = Just $ TimeSpec 5 0 }
              childWorkflow <- W.startChildWorkflow @() @() isEventWf.reference opts childWorkflowId 2
              $(logDebug) "waiting for child workflow"
              res <- W.waitChildWorkflowResult childWorkflow
              $(logDebug) "got child workflow result"
              pure res
            parentWf = W.provideWorkflow JSON "basicInvokeChildWorkflow" () parentWorkflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow isEventWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = (C.workflowStartOptions (W.WorkflowId parentId) (W.TaskQueue "test"))
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ TimeSpec 5 0
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
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

  -- --     specify "termination" $ \_ -> pending
  -- --     specify "timeout" $ \_ -> pending
  -- --     specify "startFail" $ \_ -> pending
      specify "cancel immediately" $ \client -> do
        parentId <- uuidText
        let cancelTest :: W.Workflow () () ()
            cancelTest = W.sleep $ TimeSpec 60 0
            childWf = W.provideWorkflow JSON "immediateCancelTestChild" () cancelTest
            parentWorkflow :: W.Workflow () () String
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow childWf.reference W.defaultChildWorkflowOptions childWorkflowId
              W.cancelChildWorkflowExecution childWorkflow
              result <- Catch.try $ W.waitChildWorkflowResult childWorkflow
              pure $ show (result :: Either SomeException ())
            parentWf = W.provideWorkflow JSON "immediateCancelTestParent" () parentWorkflow
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
            `shouldReturn` "Left ChildWorkflowCancelled"

      xspecify "cancel after child workflow has started" $ \client -> do
        parentId <- uuidText
        let cancelTest :: W.Workflow () () ()
            cancelTest = go
              where
                go = do
                  result <- Catch.try $ W.sleep $ TimeSpec 1 0
                  case result of
                    Left WorkflowCancelRequested -> pure ()
                    _ -> go

            childWf = W.provideWorkflow JSON "cancelTestChild" () cancelTest
            parentWorkflow :: W.Workflow () () String
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow childWf.reference W.defaultChildWorkflowOptions childWorkflowId
              W.waitChildWorkflowStart childWorkflow
              W.cancelChildWorkflowExecution childWorkflow
              W.sleep $ TimeSpec 3 0
              result <- Catch.try $ W.waitChildWorkflowResult childWorkflow
              pure $ show (result :: Either SomeException ())
            parentWf = W.provideWorkflow JSON "cancelTestParent" () parentWorkflow
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
            `shouldReturn` "Left ChildWorkflowCancelled"

  -- -- --     describe "Signals" $ do
  -- -- --       specify "send" pending
  -- -- --       specify "interrupt" pending
  -- -- --       specify "fail" pending
  -- -- --       specify "async fail signal?" pending
  -- -- --       specify "always delivered" pending
    describe "Query" $ do
      xspecify "works" $ \client -> do
        let echoQuery :: W.QueryDefinition '[Text] Text
            echoQuery = W.QueryDefinition "testQuery" JSON
            workflow :: W.Workflow () () ()
            workflow = do
              W.setQueryHandler echoQuery $ \msg -> pure msg
              W.sleep $ TimeSpec 5000 0
            wf = W.provideWorkflow JSON "queryWorkflow" () workflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                (W.TaskQueue "test")
          h <- C.start client wf.reference opts
          result <- C.query client h echoQuery C.defaultQueryOptions "hello"
          -- C.cancel client h
          result `shouldBe` Right "hello"


      -- specify "query not found" pending
      -- specify "query and unblock" pending
  -- -- --   describe "Await condition" $ do
  -- -- --     specify "it works" pending
    describe "Sleep" $ do
      specify "sleep" $ \client -> do
        wfId <- uuidText
        let workflow :: W.Workflow () () Bool
            workflow = do
              earlier <- W.now
              W.sleep $ TimeSpec 0 1
              W.sleep $ TimeSpec 0 1
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


    describe "Timer" $ do
      specify "timer" $ \client -> do
        let workflow :: W.Workflow () () Bool
            workflow = do
              earlier <- W.now
              t <- W.createTimer $ TimeSpec 0 10
              W.wait t
              later <- W.now
              pure (later > earlier) 
            wf = W.provideWorkflow JSON "timer" () workflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                (W.TaskQueue "test")
          C.execute client wf.reference opts
            `shouldReturn` True
        
      specify "timer and cancel immediately" $ \client -> do
        let workflow :: W.Workflow () () Bool
            workflow = do
              t <- W.createTimer $ TimeSpec 0 1
              W.cancel t
              W.wait t
              pure True
            wf = W.provideWorkflow JSON "timerAndCancelImmediately" () workflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) (W.TaskQueue "test"))
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ TimeSpec 4 0
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True

      specify "timer and cancel with delay" $ \client -> do
        let workflow :: W.Workflow () () Bool
            workflow = do
              t <- W.createTimer $ TimeSpec 5000 0
              W.sleep $ TimeSpec 0 1
              W.cancel t
              W.wait t
              pure True
            wf = W.provideWorkflow JSON "timerAndCancelWithDelay" () workflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) (W.TaskQueue "test"))
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ TimeSpec 4 0
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True
    describe "Patching" $ do
      specify "patch" $ \client ->  do
        let workflow :: W.Workflow () () Bool
            workflow = do
              isPatched <- W.patched (W.PatchId "wibble")
              pure isPatched
            wf = W.provideWorkflow JSON "patchedWorkflow" () workflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) (W.TaskQueue "test"))
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ TimeSpec 4 0
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True
      specify "deprecated patch" $ \client ->  do
        let workflow :: W.Workflow () () Bool
            workflow = do
              W.deprecatePatch (W.PatchId "wibble")
              pure True
            wf = W.provideWorkflow JSON "deprecatedPatchedWorkflow" () workflow
            conf = configure () () $ do
              setNamespace $ W.Namespace "test"
              setTaskQueue $ W.TaskQueue "test"
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) (W.TaskQueue "test"))
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ TimeSpec 4 0
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True
  --   specify "default server options" pending
  --   describe "Search attributes" $ do
  --     specify "can read search attributes set at start" pending
  --     specify "can upsert search attributes" pending
  describe "Info" $ do
    specify "can read workflow info" $ \client -> do
      let workflow :: W.Workflow () () Text
          workflow = do
            i <- W.info
            pure $ W.rawWorkflowType i.workflowType
          wf = W.provideWorkflow JSON "readWorkflowInfo" () workflow
          conf = configure () () $ do
            setNamespace $ W.Namespace "test"
            setTaskQueue $ W.TaskQueue "test"
            addWorkflow wf
      withWorker conf $ do
        wfId <- uuidText
        let opts = (C.workflowStartOptions (W.WorkflowId wfId) (W.TaskQueue "test"))
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ TimeSpec 4 0
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client wf.reference opts
          `shouldReturn` "readWorkflowInfo"

  --   describe "WorkflowOptions" $ do
  --     specify "passed correctly with defaults" pending
  --     specify "passed correctly" pending
  --   describe "WorkflowHandle" $ do
  --     specify "throws exception if remote workflow is terminated" pending
  --     specify "throws if continued as new" pending
  --     specify "follows chain of execution" pending
  describe "ContinueAsNew" $ do
    specify "works" $ \client -> do
      let workflow :: Int -> W.Workflow () () Text
          workflow execCount = if execCount < 1
            then W.continueAsNew wf.reference W.defaultContinueAsNewOptions (execCount + 1)
            else pure "woohoo"

          wf = W.provideWorkflow JSON "continueAsNewWorks" () workflow
          conf = configure () () $ do
            setNamespace $ W.Namespace "test"
            setTaskQueue $ W.TaskQueue "test"
            addWorkflow wf
      withWorker conf $ do
        wfId <- uuidText
        let opts = (C.workflowStartOptions (W.WorkflowId wfId) (W.TaskQueue "test"))
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ TimeSpec 4 0
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client wf.reference opts 0
          `shouldReturn` "woohoo"

      -- specify "to different workflow" pending
      -- specify "to same workflow keeps memo and search attributes" pending
      -- specify "to different workflow keeps memo and search attributes by default" pending
      -- specify "to different workflow can set memo and search attributes" pending
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
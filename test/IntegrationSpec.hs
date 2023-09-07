{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
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
import Data.Int
import Data.ProtoLens
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import GHC.Generics
import RequireCallStack
import System.IO
import Test.Hspec
import Temporal.Core.Client
import qualified Temporal.Client as C
import Temporal.Exception
import qualified Temporal.Workflow as W
import Temporal.Activity
import Temporal.Generic
import Temporal.Payload
import Temporal.Worker
import Temporal.Runtime
import Temporal.SearchAttributes
import System.IO.Unsafe
import System.Timeout (timeout)
import Temporal.Duration
import Temporal.Contrib.OpenTelemetry

rt :: Runtime
rt = unsafePerformIO initializeRuntime
{-# NOINLINE rt #-}

withWorker :: WorkerConfig actEnv -> IO a -> IO a
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
spec = beforeAll setup needsClient
  where
    setup :: IO (C.WorkflowClient, ConfigM () (), W.TaskQueue)
    setup = do
      client <- makeClient 
      (conf, taskQueue) <- mkBaseConf
      pure (client, conf, taskQueue)

type MyWorkflow a = W.RequireCallStack => W.Workflow a

data WorkflowTests t f = WorkflowTests
  { shouldRunWorkflowTest :: Wear t f (W.Workflow ())
  , raceBlockOnLeftSideWorks :: Wear t f (W.Workflow (Either Bool Bool))
  , raceBlockOnBothSidesWorks :: Wear t f (W.Workflow (Either Bool Bool))
  , raceThrowsRhsErrorWhenLhsBlocked :: Wear t f (W.Workflow (Either Bool Bool))
  , raceIgnoresRhsErrorOnLhsSuccess :: Wear t f (W.Workflow (Either Bool Bool))
  , continueAsNewWorks :: Wear t f (Int -> W.Workflow Text)
  , basicActivityWf :: Wear t f (W.Workflow Int)
  , basicActivity :: Wear t f (Activity () Int)
  , heartbeatWorks :: Wear t f (Activity () Int)
  , runHeartbeat :: Wear t f (W.Workflow Int)
  , faultyActivity :: Wear t f (Activity () Int)
  , faultyWorkflow :: Wear t f (W.Workflow Int)
  , workflowWaitConditionWorks :: Wear t f (W.Workflow ())
  } deriving (Generic)

instance FunctorB (WorkflowTests Covered)
instance TraversableB (WorkflowTests Covered)
instance ApplicativeB (WorkflowTests Covered)
instance ConstraintsB (WorkflowTests Covered)
instance Label (WorkflowTests Covered)
instance BareB WorkflowTests

defaultCodec :: JSON
defaultCodec = JSON

signalUnblockWorkflow :: W.SignalRef '[]
signalUnblockWorkflow = W.SignalRef "unblockWorkflow" defaultCodec

testImpls :: Impl WorkflowTests
testImpls = WorkflowTests
  { shouldRunWorkflowTest = $(logDebug) "oh hi!"
  , raceBlockOnLeftSideWorks = provideCallStack $ do
      let lhs = do
            $(logDebug) "sleepy lad" 
            W.sleep (seconds 10) 
            $(logDebug) "bad" 
            pure False
          rhs = $(logDebug) "wow" *> pure True
      res <- lhs `W.race` rhs
      $(logDebug) "done"
      pure res
  , raceBlockOnBothSidesWorks = provideCallStack $ do
      let lhs = W.sleep (seconds 5000) >> pure False 
          rhs = W.sleep (seconds 1) >> pure True
      lhs `W.race` rhs
  , raceThrowsRhsErrorWhenLhsBlocked = provideCallStack $ do
      let lhs = W.sleep (seconds 5000) >> pure False 
          rhs = error "foo"
      lhs `W.race` rhs
  , raceIgnoresRhsErrorOnLhsSuccess = provideCallStack $ do
      pure True `W.race` (W.sleep (seconds 5000) *> error "sad")
  , continueAsNewWorks = provideCallStack $ \execCount -> if execCount < 1
      then W.continueAsNew testRefs.continueAsNewWorks W.defaultContinueAsNewOptions (execCount + 1)
      else pure "woohoo"
  -- should run a basic activity without issues
  , basicActivityWf = provideCallStack $ do
      $logDebug "starting activity"
      h <- W.startActivity 
        testRefs.basicActivity
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
      $logDebug "waiting for activity"
      W.wait (h :: W.Task Int)
  , basicActivity = pure 1
  , heartbeatWorks = do
      heartbeat []
      liftIO $ threadDelay 1000000
      pure 1
  , runHeartbeat = provideCallStack $ do
      h <- W.startActivity 
        testRefs.heartbeatWorks
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
      W.wait (h :: W.Task Int) 
  , faultyActivity = do
      res <- askActivityInfo
      if res.attempt <= 2
        then do
          liftIO $ putStrLn "failing"
          error "sad"
        else pure 1
  , faultyWorkflow = provideCallStack $ do
      h1 <- W.startActivity 
        testRefs.faultyActivity
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
      h2 <- W.startActivity 
        testRefs.faultyActivity
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
      W.wait (h1 :: W.Task Int)
      W.wait (h2 :: W.Task Int)
  , workflowWaitConditionWorks = provideCallStack $ do
      st <- W.newStateVar False
      let waiter = W.waitCondition (W.readStateVar st)
      waiter *> W.writeStateVar st True
      pure ()
  }

testRefs :: Refs WorkflowTests
testRefs = refs defaultCodec testImpls

testDefs :: Defs () WorkflowTests
testDefs = defs defaultCodec testImpls

testConf :: ConfigM () ()
testConf = defsToConfig testDefs

mkBaseConf :: IO (ConfigM () (), W.TaskQueue)
mkBaseConf = do
  interceptor <- makeOpenTelemetryInterceptor
  taskQueue <- W.TaskQueue <$> uuidText
  pure
    ( do
      setNamespace $ W.Namespace "test"
      setTaskQueue taskQueue
      addInterceptors interceptor
    , taskQueue
    )

needsClient :: SpecWith (C.WorkflowClient, ConfigM () (), W.TaskQueue)
needsClient = do
  describe "Workflow" $ do
    specify "should run a workflow" $ \(client, baseConf, taskQueue) -> do
      let conf = configure () $ do
            baseConf
            testConf

      withWorker conf $ do
        wfId <- uuidText
        let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client testRefs.shouldRunWorkflowTest opts
          `shouldReturn` ()
    describe "race" $ do
      specify "block on left side works" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.raceBlockOnLeftSideWorks opts
            `shouldReturn` Right True

      specify "block on both side works" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.raceBlockOnBothSidesWorks opts
            `shouldReturn` Right True

      specify "throws immediately when either side throws" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.raceThrowsRhsErrorWhenLhsBlocked opts
            `shouldThrow` (== WorkflowExecutionFailed)

      specify "treats error as ok if LHS returns immediately" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.raceIgnoresRhsErrorOnLhsSuccess opts
            `shouldReturn` Left True
    describe "Activities" $ do
      specify "should run a basic activity without issues" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.basicActivityWf opts
            `shouldReturn` 1
      specify "heartbeat works" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
              
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.runHeartbeat opts
            `shouldReturn` 1
      specify "should properly handle faulty workflows" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.faultyWorkflow opts
            `shouldReturn` 1
      xspecify "Immediate activity cancellation returns the expected result to workflows" $ \(client, baseConf, taskQueue) -> do
        let testActivity :: Activity () Int
            testActivity = do
              heartbeat []
              pure 0

            testActivityAct :: ProvidedActivity () (Activity () Int)
            testActivityAct = provideActivity defaultCodec "immediateCancelResponse" testActivity
            
            testFn :: MyWorkflow Int
            testFn = do
              h1 <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
              W.cancel (h1 :: W.Task Int)
              W.wait h1 `Catch.catch` \(_ :: ActivityCancelled) -> pure 1

            wf = W.provideWorkflow defaultCodec "activityCancellation" testFn
            conf = configure () $ do
              baseConf
              addWorkflow wf
              addActivity testActivityAct
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` 1
      xspecify "Activity cancellation on heartbeat returns the expected result to workflows" $ \(client, baseConf, taskQueue) -> do
        let testActivity :: Activity () Int
            testActivity = do
              liftIO $ threadDelay 2000000
              heartbeat []
              pure 0

            testActivityAct :: ProvidedActivity () (Activity () Int)
            testActivityAct = provideActivity defaultCodec "heartbeatAllowsOpportunityToCancel" testActivity
            
            testFn :: MyWorkflow Int
            testFn = do
              h1 <- W.startActivity 
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
              W.sleep $ nanoseconds 1
              W.cancel (h1 :: W.Task Int)
              W.wait h1 `Catch.catch` \(_ :: ActivityCancelled) -> pure 1

            wf = W.provideWorkflow defaultCodec "activityCancellationOnHeartbeat" testFn
            conf = configure () $ do
              baseConf
              addWorkflow wf
              addActivity testActivityAct
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue) 
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` 1




    describe "Args and return values" $ do
      specify "args should be passed to the workflow in the correct order" $ \(client, baseConf, taskQueue) -> do
        let testFn :: Int -> Text -> Bool -> MyWorkflow (Int, Text, Bool)
            testFn a b c = pure (a, b, c)
            wf = W.provideWorkflow defaultCodec "test" testFn
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts 1 "two" False
            `shouldReturn` (1, "two", False)
      -- TODO, move to composite codec package
      -- specify "binary payloads work" $ \(client, baseConf, taskQueue) -> do
      --   let testFn :: ByteString -> W.Workflow ByteString
      --       testFn _ = pure "general kenobi"
      --       wf = W.provideWorkflow defaultCodec "test" testFn
      --       conf = configure () $ do
      --         baseConf
      --         addWorkflow wf
      --   withWorker conf $ do
      --     wfId <- uuidText
      --     let opts = C.workflowStartOptions
      --           (W.WorkflowId wfId)
      --           taskQueue
      --     C.execute client wf.reference opts "hello there."
      --       `shouldReturn` "general kenobi"
  --     specify "args that parse incorrectly should fail a Workflow appropriately" $ \(client, baseConf, taskQueue) -> do
  --       pending
  --     specify "args that parse incorrectly should fail an Activity appropriately" $ \(client, baseConf, taskQueue) -> do
  --       pending
  --     specify "Workflow return values that parse incorrectly should throw a ValueException for Client" $ \(client, baseConf, taskQueue) -> do
  --       pending
  --     specify "ChildWorkflow return values that parse incorrectly should throw a ValueException in a Workflow" $ \(client, baseConf, taskQueue) -> do
  --       pending
  --     specify "Activity return values that parse incorrectly should throw a ValueException in a Workflow" $ \(client, baseConf, taskQueue) -> do
  --       pending

  --   describe "not found" $ do
  --     xit "should result in a task retry" $ \(client, baseConf, taskQueue) -> do
  --       let conf = configure () () $ do
  --             baseConf
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
      specify "time is deterministic" $ \(client, baseConf, taskQueue) -> do
        let testFn :: MyWorkflow (UTCTime, UTCTime, UTCTime)
            testFn = do
              t1 <- W.now
              t2 <- W.now
              W.sleep $ nanoseconds 1
              t3 <- W.now
              pure (t1, t2, t3)
            wf = W.provideWorkflow defaultCodec "test" testFn
            conf = configure () $ do
              baseConf
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
      specify "invoke" $ \(client, baseConf, taskQueue) -> do
        parentId <- uuidText
        let isEven :: Int -> W.Workflow Bool
            isEven x = pure (x `mod` 2 == 0)
            isEventWf = W.provideWorkflow defaultCodec "isEven" isEven
            parentWorkflow :: MyWorkflow Bool
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              let opts :: W.StartChildWorkflowOptions
                  opts = W.defaultChildWorkflowOptions { W.runTimeout = Just $ seconds 5 }
              childWorkflow <- W.startChildWorkflow isEventWf.reference opts childWorkflowId 2
              $(logDebug) "waiting for child workflow"
              res <- W.waitChildWorkflowResult childWorkflow
              $(logDebug) "got child workflow result"
              pure res
            parentWf = W.provideWorkflow defaultCodec "basicInvokeChildWorkflow" parentWorkflow
            conf = configure () $ do
              baseConf
              addWorkflow isEventWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = (C.workflowStartOptions (W.WorkflowId parentId) taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 5
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client parentWf.reference opts
            `shouldReturn` True

      specify "failure" $ \(client, baseConf, taskQueue) -> do
        parentId <- uuidText
        let busted :: W.Workflow ()
            busted = error "busted"
            bustedWf = W.provideWorkflow defaultCodec "busted" busted
            parentWorkflow :: MyWorkflow ()
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow bustedWf.reference W.defaultChildWorkflowOptions childWorkflowId
              W.waitChildWorkflowResult childWorkflow
            parentWf = W.provideWorkflow defaultCodec "parent" parentWorkflow
            conf = configure () $ do
              baseConf
              addWorkflow bustedWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId parentId)
                taskQueue
          C.execute client parentWf.reference opts
            `shouldThrow` (== WorkflowExecutionFailed)

  -- --     specify "termination" $ \_ -> pending
  -- --     specify "timeout" $ \_ -> pending
  -- --     specify "startFail" $ \_ -> pending
      xspecify "cancel immediately" $ \(client, baseConf, taskQueue) -> do
        parentId <- uuidText
        let cancelTest :: MyWorkflow ()
            cancelTest = W.sleep $ minutes 1
            childWf = W.provideWorkflow defaultCodec "immediateCancelTestChild" cancelTest
            parentWorkflow :: MyWorkflow String
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow childWf.reference W.defaultChildWorkflowOptions childWorkflowId
              W.cancelChildWorkflowExecution childWorkflow
              result <- Catch.try $ W.waitChildWorkflowResult childWorkflow
              pure $ show (result :: Either SomeException ())
            parentWf = W.provideWorkflow defaultCodec "immediateCancelTestParent" parentWorkflow
            conf = configure () $ do
              baseConf
              addWorkflow childWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId parentId)
                taskQueue
          C.execute client parentWf.reference opts
            `shouldReturn` "Left ChildWorkflowCancelled"

      -- TODO, the parent workflow event list doesn't really show the child workflow being cancelled???
      xspecify "cancel after child workflow has started" $ \(client, baseConf, taskQueue) -> do
        parentId <- uuidText
        let cancelTest :: MyWorkflow ()
            cancelTest = W.waitCancellation

            childWf = W.provideWorkflow defaultCodec "cancelTestChild" cancelTest
            parentWorkflow :: MyWorkflow String
            parentWorkflow = do
              childWorkflowId <- (W.WorkflowId . UUID.toText) <$> W.uuid4
              childWorkflow <- W.startChildWorkflow childWf.reference W.defaultChildWorkflowOptions childWorkflowId
              W.waitChildWorkflowStart childWorkflow
              W.cancelChildWorkflowExecution childWorkflow
              result <- Catch.try $ W.waitChildWorkflowResult childWorkflow
              pure $ show (result :: Either SomeException ())
            parentWf = W.provideWorkflow defaultCodec "cancelTestParent" parentWorkflow
            conf = configure () $ do
              baseConf
              addWorkflow childWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId parentId)
                taskQueue
          C.execute client parentWf.reference opts
            `shouldReturn` "Left ChildWorkflowCancelled"

  -- -- --     describe "Signals" $ do
  -- -- --       specify "send" pending
  -- -- --       specify "interrupt" pending
  -- -- --       specify "fail" pending
  -- -- --       specify "async fail signal?" pending
  -- -- --       specify "always delivered" pending
    describe "Query" $ do
      specify "works" $ \(client, baseConf, taskQueue) -> do
        let echoQuery :: W.QueryDefinition '[Text] Text
            echoQuery = W.QueryDefinition "testQuery" defaultCodec
            workflow :: MyWorkflow ()
            workflow = do
              W.setQueryHandler echoQuery $ \msg -> pure msg
              W.sleep $ seconds 2
            wf = W.provideWorkflow defaultCodec "queryWorkflow" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          h <- C.start client wf.reference opts
          result <- C.query h echoQuery C.defaultQueryOptions "hello"
          C.awaitWorkflowResult h
          result `shouldBe` Right "hello"


      xspecify "query not found" $ \(client, baseConf, taskQueue) -> do
        let echoQuery :: W.QueryDefinition '[Text] Text
            echoQuery = W.QueryDefinition "testQuery" defaultCodec
            workflow :: MyWorkflow ()
            workflow = do
              W.setQueryHandler echoQuery $ \msg -> pure msg
              W.sleep $ seconds 5
            wf = W.provideWorkflow defaultCodec "notFoundQueryWorkflow" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          h <- C.start client wf.reference opts
          result <- C.query h echoQuery C.defaultQueryOptions "hello"
          -- C.cancel client h
          result `shouldBe` Right "hello"
      -- specify "query and unblock" pending
    describe "Await condition" $ do
      xit "works in Workflows" $ \(client, baseConf, taskQueue) -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client testRefs.workflowWaitConditionWorks opts
            `shouldReturn` ()

      it "works in signal handlers" $ \_ -> pending
      it "signal handlers can unblock workflows" $ \_ -> pending
    describe "Sleep" $ do
      specify "sleep" $ \(client, baseConf, taskQueue) -> do
        wfId <- uuidText
        let workflow :: MyWorkflow Bool
            workflow = do
              earlier <- W.now
              W.sleep $ nanoseconds 1
              later <- W.now
              pure (later > earlier) 
            wf = W.provideWorkflow defaultCodec "sleepy" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True


    describe "Timer" $ do
      specify "timer" $ \(client, baseConf, taskQueue) -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              earlier <- W.now
              t <- W.createTimer $ nanoseconds 10
              W.wait t
              later <- W.now
              pure (later > earlier) 
            wf = W.provideWorkflow defaultCodec "timer" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = C.workflowStartOptions
                (W.WorkflowId wfId)
                taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True
        
      specify "timer and cancel immediately" $ \(client, baseConf, taskQueue) -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              t <- W.createTimer $ nanoseconds 1
              W.cancel t
              W.wait t
              pure True
            wf = W.provideWorkflow defaultCodec "timerAndCancelImmediately" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True

      specify "timer and cancel with delay" $ \(client, baseConf, taskQueue) -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              t <- W.createTimer $ seconds 5000
              W.sleep $ nanoseconds 1
              W.cancel t
              W.wait t
              pure True
            wf = W.provideWorkflow defaultCodec "timerAndCancelWithDelay" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True
    describe "Patching" $ do
      specify "patch" $ \(client, baseConf, taskQueue) ->  do
        let workflow :: MyWorkflow Bool
            workflow = do
              isPatched <- W.patched (W.PatchId "wibble")
              pure isPatched
            wf = W.provideWorkflow defaultCodec "patchedWorkflow" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True
      specify "deprecated patch" $ \(client, baseConf, taskQueue) ->  do
        let workflow :: MyWorkflow Bool
            workflow = do
              W.deprecatePatch (W.PatchId "wibble")
              pure True
            wf = W.provideWorkflow defaultCodec "deprecatedPatchedWorkflow" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          wfId <- uuidText
          let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
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
    specify "can read workflow info" $ \(client, baseConf, taskQueue) -> do
      let workflow :: W.Workflow Text
          workflow = do
            i <- W.info
            pure $ W.rawWorkflowType i.workflowType
          wf = W.provideWorkflow defaultCodec "readWorkflowInfo" workflow
          conf = configure () $ do
            baseConf
            addWorkflow wf
      withWorker conf $ do
        wfId <- uuidText
        let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client wf.reference opts
          `shouldReturn` "readWorkflowInfo"

  -- Note, needs the temporal operator to have mapped these attributes up-front:
  -- >  temporal operator search-attribute create --name attr1 --type Bool --namespace test
  -- > temporal operator search-attribute create --name attr2 --type Int --namespace test
  --
  -- Until we have a way to do this in the SDK, we can't test this without manual intervention.
  describe "Search Attributes" $ do
    specify "can read search attributes set at start" $ \(client, baseConf, taskQueue) -> do
      let workflow :: W.Workflow (Map Text SearchAttributeType)
          workflow = do
            i <- W.info
            pure (i.searchAttributes :: Map Text SearchAttributeType)
          wf = W.provideWorkflow defaultCodec "readWorkflowInfo" workflow
          conf = configure () $ do
            baseConf
            addWorkflow wf
      withWorker conf $ do
        wfId <- uuidText
        let initialAttrs = Map.fromList
              [ ("attr1", toSearchAttribute True)
              , ("attr2", toSearchAttribute (4 :: Int64))
              ]
            opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              , C.searchAttributes = initialAttrs
              }
        C.execute client wf.reference opts
          `shouldReturn` initialAttrs
    specify "can read search attributes set at start" $ \(client, baseConf, taskQueue) -> do
      let expectedAttrs = Map.fromList
              [ ("attr1", toSearchAttribute True)
              , ("attr2", toSearchAttribute (4 :: Int64))
              ]
          workflow :: MyWorkflow (Map Text SearchAttributeType)
          workflow = do
            W.upsertSearchAttributes expectedAttrs
            i <- W.info
            pure (i.searchAttributes :: Map Text SearchAttributeType)
          wf = W.provideWorkflow defaultCodec "upsertWorkflowInfo" workflow
          conf = configure () $ do
            baseConf
            addWorkflow wf
      withWorker conf $ do
        wfId <- uuidText
        let 
            opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client wf.reference opts
          `shouldReturn` expectedAttrs
    

  --   describe "WorkflowOptions" $ do
  --     specify "passed correctly with defaults" pending
  --     specify "passed correctly" pending
  --   describe "WorkflowHandle" $ do
  --     specify "throws exception if remote workflow is terminated" pending
  --     specify "throws if continued as new" pending
  --     specify "follows chain of execution" pending
  describe "ContinueAsNew" $ do
    specify "works" $ \(client, baseConf, taskQueue) -> do
      let conf = configure () $ do
            baseConf
            testConf
      withWorker conf $ do
        wfId <- uuidText
        let opts = (C.workflowStartOptions (W.WorkflowId wfId) taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client testRefs.continueAsNewWorks opts 0
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
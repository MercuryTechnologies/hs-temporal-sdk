{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}
module IntegrationSpec where

import Control.Applicative
import Control.Exception
import Control.Exception.Annotated
import Control.Concurrent
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Aeson (Value, FromJSON, ToJSON, encode, eitherDecode)
import Data.ByteString (ByteString)
import Data.Int
import Data.ProtoLens
import Data.Text (Text, pack)
import Data.Time.Clock (UTCTime)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import GHC.Generics
import OpenTelemetry.Trace
import RequireCallStack
import System.IO
import Test.Hspec
import Temporal.Core.Client
import qualified Temporal.Client as C
import Temporal.Exception
import qualified Temporal.Workflow as W
import Temporal.Activity
import Temporal.Bundle
import Temporal.Bundle.TH
import Temporal.Exception (nonRetryableError)
import Temporal.Payload
import Temporal.Worker
import Temporal.SearchAttributes
import System.IO.Unsafe
import System.Timeout (timeout)
import Temporal.Duration
import Temporal.Contrib.OpenTelemetry
import Temporal.Interceptor
import Temporal.EphemeralServer
import Temporal.Operator (IndexedValueType(..), SearchAttributes(..), listSearchAttributes, addSearchAttributes)

unblockWorkflowSignal :: W.SignalRef '[]
unblockWorkflowSignal = W.SignalRef "unblockWorkflow" JSON

temporalBundle [d|
  data WorkflowTests = WorkflowTests
    { shouldRunWorkflowTest :: W.Workflow ()
    , raceBlockOnLeftSideWorks :: W.Workflow (Either Bool Bool)
    , raceBlockOnBothSidesWorks :: W.Workflow (Either Bool Bool)
    , raceThrowsRhsErrorWhenLhsBlocked :: W.Workflow (Either Bool Bool)
    , raceIgnoresRhsErrorOnLhsSuccess :: W.Workflow (Either Bool Bool)
    , continueAsNewWorks :: Int -> W.Workflow Text
    , basicActivityWf :: W.Workflow Int
    , basicActivity :: Activity () Int
    , heartbeatWorks :: Activity () Int
    , runHeartbeat :: W.Workflow Int
    , faultyActivity :: Activity () Int
    , faultyWorkflow :: W.Workflow Int
    , workflowWaitConditionWorks :: W.Workflow ()
    , simpleWait :: W.Workflow ()
    , multipleArgs :: Int -> Text -> Bool -> W.Workflow (Int, Text, Bool)
    , nonRetryableFailureTest :: W.Workflow ()
    , nonRetryableFailureAct :: Activity () ()
    , retryableFailureTest :: W.Workflow ()
    , retryableFailureAct :: Activity () ()
    } deriving (Generic)
  |]

temporalBundle [d|
  data DerivingStrategiesWork = DerivingStrategiesWork
    { derivingStrategyExampleThing :: Int
    } 
    deriving (Show)
  |]

configWithRetry :: PortNumber -> ClientConfig
configWithRetry pn = defaultClientConfig 
  { retryConfig = Just $ ClientRetryConfig
      { initialIntervalMillis = 500
      , randomizationFactor = 0.2
      , multiplier = 1.5
      , maxIntervalMillis = 10000
      , maxRetries = 5
      , maxElapsedTimeMillis = Just 60000
      }
  -- , targetUrl = pack ("http://localhost:" <> show pn)
  }

mkWithWorker :: PortNumber -> WorkerConfig actEnv -> IO a -> IO a
mkWithWorker pn conf m = do
  let clientConfig = configWithRetry pn
  c <- connectClient clientConfig
  bracket (runStdoutLoggingT $ startWorker c conf) shutdown (const m)

makeClient :: PortNumber -> Interceptors -> IO (C.WorkflowClient, Client)
makeClient pn Interceptors{..} = do
  let clientConfig = configWithRetry pn
  c <- connectClient clientConfig 
  (,) 
    <$> C.workflowClient c (W.Namespace "default") clientInterceptors
    <*> pure c

uuidText :: IO Text
uuidText = UUID.toText <$> UUID.nextRandom

data TestEnv = TestEnv
  { client :: C.WorkflowClient
  , baseConf :: ConfigM () ()
  , taskQueue :: W.TaskQueue
  , withWorker :: forall a. WorkerConfig () -> IO a -> IO a
  }

data TemporalWorkflowJobPayload = TemporalWorkflowJobPayload
  { workflowId :: W.WorkflowId
  , workflowType :: W.WorkflowType
  , workflowArgs :: [Data.Aeson.Value]
  , workflowNamespace :: W.Namespace
  , workflowTaskQueue :: W.TaskQueue
  , workflowRetryPolicy :: Maybe W.RetryPolicy
  , workflowIdReusePolicy :: Maybe W.WorkflowIdReusePolicy
  , workflowSearchAttributes :: Map Text SearchAttributeType
  } deriving (Eq, Show, Generic)

instance ToJSON TemporalWorkflowJobPayload
instance FromJSON TemporalWorkflowJobPayload

spec :: Spec
spec = do
  describe "Duration parsing" $ do
    it "should parse a duration" $ do
      let d = "\"1.000000001s\""
      Data.Aeson.eitherDecode d `shouldBe` Right (Duration 1 1)
    it "should parse a duration from a data type" $ do
      let d = Data.Aeson.encode $ Duration 2 4
      Data.Aeson.eitherDecode d `shouldBe` Right (Duration 2 4)
  aroundAll setup needsClient
  where
    setup :: (TestEnv -> IO ()) -> IO ()
    setup go = do
      fp <- getFreePort
      -- withDevServer (defaultTemporalDevServerConfig { port = Just $ fromIntegral fp }) $ \_ -> do
      do
        interceptors <- makeOpenTelemetryInterceptor
        (client, coreClient) <- makeClient fp interceptors

        SearchAttributes{customAttributes} <- either throwIO pure =<< listSearchAttributes coreClient (W.Namespace "default")
        let allTestAttributes = Map.fromList
              [ ("attr1", Temporal.Operator.Bool)
              , ("attr2", Temporal.Operator.Int)
              ]
        addSearchAttributes coreClient (W.Namespace "default") (allTestAttributes `Map.difference` customAttributes)

        (conf, taskQueue) <- mkBaseConf interceptors
        go TestEnv
          { client
          , withWorker = mkWithWorker fp
          , baseConf = conf
          , taskQueue
          }

type MyWorkflow a = W.RequireCallStack => W.Workflow a

defaultCodec :: JSON
defaultCodec = JSON

data RegressionTask = Foo | Bar
  deriving (Eq, Show, Generic)

instance ToJSON RegressionTask
instance FromJSON RegressionTask

signalUnblockWorkflow :: W.SignalRef '[]
signalUnblockWorkflow = W.SignalRef "unblockWorkflow" defaultCodec

testImpls :: WorkflowTests
testImpls = provideCallStack $ WorkflowTests
  { shouldRunWorkflowTest = $(logDebug) "oh hi!"
  , raceBlockOnLeftSideWorks = do
      let lhs = do
            $(logDebug) "sleepy lad" 
            W.sleep (seconds 10) 
            $(logDebug) "bad" 
            pure False
          rhs = $(logDebug) "wow" *> pure True
      res <- lhs `W.race` rhs
      $(logDebug) "done"
      pure res
  , raceBlockOnBothSidesWorks = do
      let lhs = W.sleep (seconds 5000) >> pure False 
          rhs = W.sleep (seconds 1) >> pure True
      lhs `W.race` rhs
  , raceThrowsRhsErrorWhenLhsBlocked = do
      let lhs = W.sleep (seconds 5000) >> pure False 
          rhs = error "foo"
      lhs `W.race` rhs
  , raceIgnoresRhsErrorOnLhsSuccess = do
      pure True `W.race` (W.sleep (seconds 5000) *> error "sad")
  , continueAsNewWorks = \execCount -> if execCount < 1
      then W.continueAsNew testRefs.continueAsNewWorks W.defaultContinueAsNewOptions (execCount + 1)
      else pure "woohoo"
  -- should run a basic activity without issues
  , basicActivityWf = do
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
  , runHeartbeat = do
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
  , faultyWorkflow = do
      h1 <- W.startActivity 
        testRefs.faultyActivity
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
      h2 <- W.startActivity 
        testRefs.faultyActivity
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
      W.wait (h1 :: W.Task Int)
      W.wait (h2 :: W.Task Int)
  , workflowWaitConditionWorks = do
      st <- W.newStateVar False
      W.setSignalHandler unblockWorkflowSignal $ do
        $(logDebug) "unblocking workflow"
        W.writeStateVar st True
      W.waitCondition (W.readStateVar st)
      pure ()
  , simpleWait = do
      st <- W.newStateVar False
      (W.waitCondition (W.readStateVar st) <* W.writeStateVar st True)
  , multipleArgs = \foo bar baz -> pure (foo, bar, baz)
  , nonRetryableFailureTest = do
      h <- W.startActivity 
        testRefs.nonRetryableFailureAct
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
      W.wait (h :: W.Task ())
  , nonRetryableFailureAct = checkpoint nonRetryableError $ do
      error "sad"
  , retryableFailureTest = do
      h <- W.startActivity 
        testRefs.retryableFailureAct
        (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
          -- { retryPolicy = Just $ defaultRetryPolicy 
          --   { nonRetryableErrorTypes = [ "ErrorCall" ]
          --   }
          -- })
      W.wait (h :: W.Task ())
  , retryableFailureAct = do
      i <- askActivityInfo
      if attempt i > 1 
        then pure ()
        else error "sad"
  }

testRefs :: Refs WorkflowTestsB
testRefs = refs defaultCodec testImpls

testDefs :: Defs () WorkflowTestsB
testDefs = defs defaultCodec testImpls

testConf :: ConfigM () ()
testConf = defsToConfig testDefs

mkBaseConf :: Interceptors -> IO (ConfigM () (), W.TaskQueue)
mkBaseConf interceptors = do
  taskQueue <- W.TaskQueue <$> uuidText
  pure
    ( do
      setNamespace $ W.Namespace "default"
      setTaskQueue taskQueue
      addInterceptors interceptors
    , taskQueue
    )

needsClient :: SpecWith TestEnv
needsClient = do
  describe "Workflow" $ do
    specify "should run a workflow" $ \TestEnv{..} -> do
      let conf = configure () $ do
            baseConf
            testConf

      withWorker conf $ do
        let opts = (C.workflowStartOptions taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client testRefs.shouldRunWorkflowTest opts
          `shouldReturn` ()
    describe "race" $ do
      specify "block on left side works" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue 
          C.execute client testRefs.raceBlockOnLeftSideWorks opts
            `shouldReturn` Right True

      specify "block on both side works" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client testRefs.raceBlockOnBothSidesWorks opts
            `shouldReturn` Right True

      specify "throws immediately when either side throws" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client testRefs.raceThrowsRhsErrorWhenLhsBlocked opts
            `shouldThrow` (== WorkflowExecutionFailed)

      specify "treats error as ok if LHS returns immediately" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client testRefs.raceIgnoresRhsErrorOnLhsSuccess opts
            `shouldReturn` Left True
    describe "Activities" $ do
      specify "should run a basic activity without issues" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client testRefs.basicActivityWf opts
            `shouldReturn` 1
      specify "heartbeat works" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
              
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client testRefs.runHeartbeat opts
            `shouldReturn` 1
      specify "should properly handle faulty workflows" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client testRefs.faultyWorkflow opts
            `shouldReturn` 1
      specify "Immediate activity cancellation returns the expected result to workflows" $ \TestEnv{..} -> do
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
          let opts = (C.workflowStartOptions taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` 1
      specify "Activity cancellation on heartbeat returns the expected result to workflows" $ \TestEnv{..} -> do
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
          let opts = (C.workflowStartOptions taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` 1




    describe "Args and return values" $ do
      specify "args should be passed to the workflow in the correct order" $ \TestEnv{..} -> do
        let testFn :: Int -> Text -> Bool -> MyWorkflow (Int, Text, Bool)
            testFn a b c = pure (a, b, c)
            wf = W.provideWorkflow defaultCodec "test" testFn
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client wf.reference opts 1 "two" False
            `shouldReturn` (1, "two", False)
      -- TODO, move to composite codec package
      -- specify "binary payloads work" $ \TestEnv{..} -> do
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
  --     specify "args that parse incorrectly should fail a Workflow appropriately" $ \TestEnv{..} -> do
  --       pending
  --     specify "args that parse incorrectly should fail an Activity appropriately" $ \TestEnv{..} -> do
  --       pending
  --     specify "Workflow return values that parse incorrectly should throw a ValueException for Client" $ \TestEnv{..} -> do
  --       pending
  --     specify "ChildWorkflow return values that parse incorrectly should throw a ValueException in a Workflow" $ \TestEnv{..} -> do
  --       pending
  --     specify "Activity return values that parse incorrectly should throw a ValueException in a Workflow" $ \TestEnv{..} -> do
  --       pending

  --   describe "not found" $ do
  --     xit "should result in a task retry" $ \TestEnv{..} -> do
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
      specify "time is deterministic" $ \TestEnv{..} -> do
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
          let opts = C.workflowStartOptions taskQueue
          (t1, t2, t3) <- C.execute client wf.reference opts
          t1 `shouldBe` t2
          t3 `shouldSatisfy` (> t2)

  --   -- describe "Activity failures" $ do
  --   --   specify "ApplicationFailure exception" pending
  --   --   specify "ActivityFailure exception" pending
  --   --   specify "Non-wrapped exception" pending
    describe "Child workflows" $ do
      specify "invoke" $ \TestEnv{..} -> do
        parentId <- uuidText
        let isEven :: Int -> W.Workflow Bool
            isEven x = pure (x `mod` 2 == 0)
            isEventWf = W.provideWorkflow defaultCodec "isEven" isEven
            parentWorkflow :: MyWorkflow Bool
            parentWorkflow = do
              let opts :: W.StartChildWorkflowOptions
                  opts = W.defaultChildWorkflowOptions { W.runTimeout = Just $ seconds 5 }
              childWorkflow <- W.startChildWorkflow isEventWf.reference opts 2
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
          let opts = (C.workflowStartOptions taskQueue)
                { C.workflowId = Just $ W.WorkflowId parentId
                , C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 5
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client parentWf.reference opts
            `shouldReturn` True

      specify "failure" $ \TestEnv{..} -> do
        parentId <- uuidText
        let busted :: W.Workflow ()
            busted = error "busted"
            bustedWf = W.provideWorkflow defaultCodec "busted" busted
            parentWorkflow :: MyWorkflow ()
            parentWorkflow = do
              childWorkflow <- W.startChildWorkflow bustedWf.reference W.defaultChildWorkflowOptions
              W.waitChildWorkflowResult childWorkflow
            parentWf = W.provideWorkflow defaultCodec "parent" parentWorkflow
            conf = configure () $ do
              baseConf
              addWorkflow bustedWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = (C.workflowStartOptions taskQueue)
                { C.workflowId = Just $ W.WorkflowId parentId
                }
          C.execute client parentWf.reference opts
            `shouldThrow` (== WorkflowExecutionFailed)

  -- --     specify "termination" $ \_ -> pending
  -- --     specify "timeout" $ \_ -> pending
  -- --     specify "startFail" $ \_ -> pending
      specify "cancel immediately" $ \TestEnv{..} -> do
        parentId <- uuidText
        let cancelTest :: MyWorkflow ()
            cancelTest = W.sleep $ minutes 1
            childWf = W.provideWorkflow defaultCodec "immediateCancelTestChild" cancelTest
            parentWorkflow :: MyWorkflow String
            parentWorkflow = do
              childWorkflow <- W.startChildWorkflow childWf.reference W.defaultChildWorkflowOptions
              W.cancelChildWorkflowExecution childWorkflow
              result <- Catch.try $ W.waitChildWorkflowResult childWorkflow
              pure $ show (result :: Either SomeException ())
            parentWf = W.provideWorkflow defaultCodec "immediateCancelTestParent" parentWorkflow
            conf = configure () $ do
              baseConf
              addWorkflow childWf
              addWorkflow parentWf
        withWorker conf $ do
          let opts = (C.workflowStartOptions taskQueue)
                { C.workflowId = Just $ W.WorkflowId parentId
                }
          C.execute client parentWf.reference opts
            `shouldReturn` "Left ChildWorkflowCancelled"

      -- TODO, the parent workflow event list doesn't really show the child workflow being cancelled???
      specify "cancel after child workflow has started" $ \TestEnv{..} -> do
        parentId <- uuidText
        let cancelTest :: MyWorkflow ()
            cancelTest = W.waitCancellation

            childWf = W.provideWorkflow defaultCodec "cancelTestChild" cancelTest
            parentWorkflow :: MyWorkflow String
            parentWorkflow = do
              childWorkflow <- W.startChildWorkflow childWf.reference W.defaultChildWorkflowOptions
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
          let opts = (C.workflowStartOptions taskQueue)
                { C.workflowId = Just $ W.WorkflowId parentId
                }
          C.execute client parentWf.reference opts
            `shouldReturn` "Left ChildWorkflowCancelled"

    describe "Signals" $ do
      specify "send" $ \_ -> pending
      specify "interrupt" $ \_ -> pending
      specify "fail" $ \_ -> pending
      specify "async fail signal?" $ \_ -> pending
      specify "always delivered" $ \_ -> pending
    describe "Query" $ do
      specify "works" $ \TestEnv{..} -> do
        tp <- getGlobalTracerProvider
        let testTracer = makeTracer tp "testTracer" tracerOptions

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
        inSpan testTracer "Query.works" defaultSpanArguments $ do
          withWorker conf $ do
            let opts = C.workflowStartOptions taskQueue
            h <- C.start client wf.reference opts
            result <- C.query h echoQuery C.defaultQueryOptions "hello"
            C.waitWorkflowResult h
            result `shouldBe` Right "hello"


      specify "query not found" $ \TestEnv{..} -> do
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
          let opts = C.workflowStartOptions taskQueue
          h <- C.start client wf.reference opts
          result <- C.query h echoQuery C.defaultQueryOptions "hello"
          -- C.cancel client h
          result `shouldBe` Right "hello"
      -- specify "query and unblock" pending
    describe "Await condition" $ do
      xit "signal handlers can unblock workflows" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          wfH <- C.start client testRefs.workflowWaitConditionWorks opts
          C.signal wfH unblockWorkflowSignal C.defaultSignalOptions
          C.waitWorkflowResult wfH `shouldReturn` ()

      it "works in signal handlers" $ \_ -> pending
      it "works in Workflows" $ \TestEnv{..} -> do
        let conf = configure () $ do
              baseConf
              testConf
        withWorker conf $ do
          let opts = C.workflowStartOptions taskQueue
          C.execute client testRefs.simpleWait opts `shouldReturn` ()
    describe "Sleep" $ do
      specify "sleep" $ \TestEnv{..} -> do
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
          let opts = C.workflowStartOptions taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True


    describe "Timer" $ do
      specify "timer" $ \TestEnv{..} -> do
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
          let opts = C.workflowStartOptions taskQueue
          C.execute client wf.reference opts
            `shouldReturn` True
        
      specify "timer and cancel immediately" $ \TestEnv{..} -> do
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
          let opts = (C.workflowStartOptions taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True

      specify "timer and cancel with delay" $ \TestEnv{..} -> do
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
          let opts = (C.workflowStartOptions taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True
    describe "Patching" $ do
      specify "patch" $ \TestEnv{..} ->  do
        let workflow :: MyWorkflow Bool
            workflow = do
              isPatched <- W.patched (W.PatchId "wibble")
              pure isPatched
            wf = W.provideWorkflow defaultCodec "patchedWorkflow" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          let opts = (C.workflowStartOptions taskQueue)
                { C.timeouts = C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 4
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
                }
          C.execute client wf.reference opts
            `shouldReturn` True
      specify "deprecated patch" $ \TestEnv{..} ->  do
        let workflow :: MyWorkflow Bool
            workflow = do
              W.deprecatePatch (W.PatchId "wibble")
              pure True
            wf = W.provideWorkflow defaultCodec "deprecatedPatchedWorkflow" workflow
            conf = configure () $ do
              baseConf
              addWorkflow wf
        withWorker conf $ do
          let opts = (C.workflowStartOptions taskQueue)
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
    specify "can read workflow info" $ \TestEnv{..} -> do
      let workflow :: W.Workflow Text
          workflow = do
            i <- W.info
            pure $ W.rawWorkflowType i.workflowType
          wf = W.provideWorkflow defaultCodec "readWorkflowInfo" workflow
          conf = configure () $ do
            baseConf
            addWorkflow wf
      withWorker conf $ do
        let opts = (C.workflowStartOptions taskQueue)
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
    specify "can read search attributes set at start" $ \TestEnv{..} -> do
      let workflow :: W.Workflow (Map Text SearchAttributeType)
          workflow = do
            i <- W.info
            pure (i.searchAttributes :: Map Text SearchAttributeType)
          wf = W.provideWorkflow defaultCodec "readWorkflowInfo" workflow
          conf = configure () $ do
            baseConf
            addWorkflow wf
      withWorker conf $ do
        let initialAttrs = Map.fromList
              [ ("attr1", toSearchAttribute True)
              , ("attr2", toSearchAttribute (4 :: Int64))
              ]
            opts = (C.workflowStartOptions taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              , C.searchAttributes = initialAttrs
              }
        C.execute client wf.reference opts
          `shouldReturn` initialAttrs
    specify "can upsert search attributes" $ \TestEnv{..} -> do
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
        let opts = (C.workflowStartOptions taskQueue)
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
    specify "works" $ \TestEnv{..} -> do
      let conf = configure () $ do
            baseConf
            testConf
      withWorker conf $ do
        let opts = (C.workflowStartOptions taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client testRefs.continueAsNewWorks opts 0
          `shouldReturn` "woohoo"

  describe "Regression tests" $ do
    specify "immediate activity start works" $ \TestEnv{..} -> do
      let taskMainActivity :: ProvidedActivity () (RegressionTask -> Activity () ())
          taskMainActivity = provideCallStack $ provideActivity JSON "legacyTaskMainAct" $ \command -> do
            app <- ask
            liftIO $ putStrLn "hi"

          taskMainWorkflow :: W.ProvidedWorkflow (RegressionTask -> W.Workflow ())
          taskMainWorkflow = provideCallStack $ W.provideWorkflow JSON "legacyTaskMain" $ \command -> do
            -- Info{..} <- info
            x <- W.uuid4
            W.executeActivity
              taskMainActivity.reference
              ((W.defaultStartActivityOptions $ W.StartToClose infinity) { W.activityId = Just $ W.ActivityId "woejfwoefijweof"})
              command

          conf = configure () $ do
            baseConf
            testConf

            addActivity taskMainActivity
            addWorkflow taskMainWorkflow

      withWorker conf $ do
        let opts = (C.workflowStartOptions taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Nothing
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client taskMainWorkflow.reference opts Foo
          `shouldReturn` ()

      -- specify "to different workflow" pending
      -- specify "to same workflow keeps memo and search attributes" pending
      -- specify "to different workflow keeps memo and search attributes by default" pending
      -- specify "to different workflow can set memo and search attributes" pending
  --   describe "signalWithStart" $ do
  --     specify "works as intended and returns correct runId" pending
  describe "RetryPolicy" $ do
    specify "is used for retryable failures" $ \TestEnv{..} -> do
      let conf = configure () $ do
            baseConf
            testConf
      withWorker conf $ do
        let opts = (C.workflowStartOptions taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client testRefs.retryableFailureTest opts
          -- `shouldThrow` (== WorkflowExecutionFailed)

    specify "ignored for non-retryable failures" $ \TestEnv{..} -> do
      let conf = configure () $ do
            baseConf
            testConf
      withWorker conf $ do
        let opts = (C.workflowStartOptions taskQueue)
              { C.timeouts = C.TimeoutOptions
                  { C.runTimeout = Just $ seconds 4
                  , C.executionTimeout = Nothing
                  , C.taskTimeout = Nothing
                  }
              }
        C.execute client testRefs.nonRetryableFailureTest opts
          `shouldThrow` (== WorkflowExecutionFailed)

  -- describe "WorkflowClient" $ do
  --   specify "WorkflowExecutionAlreadyStartedError" pending
  --   specify "follows only own execution chain" pending
  --   specify "Handle from signalWithStart follows only own execution chain" pending
  --   specify "getHandle only follows own execution chain" pending
  --   specify "Handle from start terminates run after continue as new" pending
  --   specify "Handle from start does not terminate run after continue as new if given runId" pending
  -- specify "Download and replay multiple executions with client list method" pending
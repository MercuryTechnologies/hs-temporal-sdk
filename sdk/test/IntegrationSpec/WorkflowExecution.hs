{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant bracket" #-}

module IntegrationSpec.WorkflowExecution (spec) where

import Common
import Control.Concurrent
import Control.Exception
import Control.Exception.Annotated
import qualified Control.Exception.Annotated as Annotated
import Control.Monad (replicateM, when)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Aeson (FromJSON, ToJSON, Value (..), toJSON)
import qualified Data.Aeson as Aeson
import qualified Data.ByteString as BS
import Data.Either (isLeft, isRight)
import Data.Foldable (traverse_)
import Data.Functor
import Data.IORef
import Data.Int
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromJust, isJust)
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Time (Day (ModifiedJulianDay), diffUTCTime, getCurrentTime)
import Data.Time.Clock (UTCTime)
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import Data.Vector (Vector)
import qualified Data.Vector as V
import DiscoverInstances (discoverInstances)
import GHC.Generics
import GHC.Stack (SrcLoc (..), callStack, fromCallSiteList)
import IntegrationSpec.HangingWorkflow
import IntegrationSpec.NoOpWorkflow
import IntegrationSpec.Signals
import IntegrationSpec.TimeSkipping
import IntegrationSpec.TimeoutsInWorkflows
import IntegrationSpec.Updates
import IntegrationSpec.Utils
import Lens.Family2
import OpenTelemetry.Trace
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Api.History.V1.Message (WorkflowExecutionFailedEventAttributes (..))
import qualified Proto.Temporal.Api.History.V1.Message_Fields as History
import RequireCallStack
import System.Directory
import System.Environment (lookupEnv)
import System.IO
import Temporal.Activity hiding (activityId, retryPolicy, workflowId)
import Temporal.Bundle
import Temporal.Bundle.TH
import qualified Temporal.Client as C
import qualified Temporal.Client.TestService
import Temporal.Contrib.OpenTelemetry
import Temporal.Core.Client hiding (RpcError)
import Temporal.Duration
import Temporal.EphemeralServer
import qualified Temporal.EphemeralServer as TemporalDevServerConfig (TemporalDevServerConfig (..))
import qualified Temporal.EphemeralServer as TemporalTestServerConfig (TemporalTestServerConfig (..))
import Temporal.Exception hiding (activityId)
import Temporal.Interceptor
import Temporal.Operator (IndexedValueType (..), SearchAttributes (..), addSearchAttributes, listSearchAttributes)
import Temporal.Payload hiding (around)
import Temporal.SearchAttributes
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Testing.Assertions
import Temporal.Worker
import Temporal.Workflow (
  StartActivityOptions (activityId, retryPolicy),
  StartChildWorkflowOptions (workflowId, workflowIdReusePolicy),
 )
import qualified Temporal.Workflow as W
import Temporal.Workflow.Unsafe (performUnsafeNonDeterministicIO)
import Test.Hspec
import TestHelpers (waitForWorkflowStart)


spec :: SpecWith TestEnv
spec = do
  describe "Workflow" $ do
    specify "should run a workflow" $ \TestEnv {..} -> do
      let conf = configure () testConf $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 30
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        useClient (C.execute testRefs.shouldRunWorkflowTest "basicWf" opts)
          `shouldReturn` ()

    describe "Workflow existence assertions" $ do
      specify "checkWorkflowExecutionExists returns correct values" $ \TestEnv {..} -> do
        let wfId = WorkflowId "test-existence-check"
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }

        exists1 <- useClient $ C.checkWorkflowExecutionExists testRefs.shouldRunWorkflowTest wfId
        exists1 `shouldBe` False

        _ <- useClient $ C.start testRefs.shouldRunWorkflowTest wfId opts

        exists2 <- useClient $ C.checkWorkflowExecutionExists testRefs.shouldRunWorkflowTest wfId
        exists2 `shouldBe` True

      specify "check that workflow existence assertions throw correct exceptions" $ \TestEnv {..} -> do
        let wfId = WorkflowId "test-assertion-existence"
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }

        useClient $ assertWorkflowExecutionDoesNotExist testRefs.shouldRunWorkflowTest wfId

        _ <- useClient $ C.start testRefs.shouldRunWorkflowTest wfId opts

        useClient $ assertWorkflowExecutionExists testRefs.shouldRunWorkflowTest wfId

      specify "check that workflow existence assertions throw correct exceptions when assertions fail" $ \TestEnv {..} -> do
        let wfId = WorkflowId "test-assertion-failure"
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }

        useClient (assertWorkflowExecutionExists testRefs.shouldRunWorkflowTest wfId)
          `shouldThrow` (== WorkflowShouldExist wfId)

        _ <- useClient $ C.start testRefs.shouldRunWorkflowTest wfId opts

        useClient (assertWorkflowExecutionDoesNotExist testRefs.shouldRunWorkflowTest wfId)
          `shouldThrow` (== WorkflowShouldNotExist wfId)

    describe "race" $ do
      specify "block on left side works" $ \TestEnv {..} -> do
        let conf = configure () testConf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute testRefs.raceBlockOnLeftSideWorks "blockLeftWorks" opts)
            `shouldReturn` Right True

      specify "block on both side works" $ \TestEnv {..} -> do
        let conf = configure () testConf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute testRefs.raceBlockOnBothSidesWorks "blockBothWorks" opts)
            `shouldReturn` Right True

      specify "throws immediately when either side throws" $ \TestEnv {..} -> do
        let conf = configure () testConf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute testRefs.raceThrowsRhsErrorWhenLhsBlocked "eitherSideThrows" opts)
            `shouldThrow` \case
              (WorkflowExecutionFailed _) -> True
              _ -> False

      specify "treats error as ok if LHS returns immediately" $ \TestEnv {..} -> do
        let conf = configure () testConf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute testRefs.raceIgnoresRhsErrorOnLhsSuccess "lhsError" opts)
            `shouldReturn` Left True

    describe "Args and return values" $ do
      specify "args should be passed to the workflow in the correct order" $ \TestEnv {..} -> do
        let testFn :: Int -> Text -> Bool -> MyWorkflow (Int, Text, Bool)
            testFn a b c = pure (a, b, c)
            wf = W.provideWorkflow defaultCodec "test" testFn
            conf = configure () wf $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute wf.reference "argOrderingIsCorrect" opts 1 "two" False)
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
      --     let opts = C.startWorkflowOptions
      --           (W.WorkflowId wfId)
      --           taskQueue
      --     C.execute wf.reference opts "hello there."
      --       `shouldReturn` "general kenobi"
      specify "args that parse incorrectly should fail a Workflow appropriately" $ \TestEnv {..} -> do
        let testFn :: Int -> W.Workflow Bool
            testFn _ = pure True
            wf = W.provideWorkflow defaultCodec "test" testFn
            badWfRef = W.KnownWorkflow @'[String] @Int defaultCodec "test"
            conf = configure () wf $ do
              baseConf
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        withWorker conf $ do
          useClient (C.execute badWfRef "incorrectWorkflowArg" opts "ruhroh")
            `shouldThrow` \case
              (WorkflowExecutionFailed _) -> True
              _ -> False
      specify "memo values that parse incorrectly should fail a Workflow appropriately" $ \TestEnv {..} -> do
        pending
      specify "header values that parse incorrectly should fail a Workflow appropriately" $ \TestEnv {..} -> do
        pending
      specify "search attribute values that parse incorrectly should fail a Workflow appropriately" $ \TestEnv {..} -> do
        pending
      specify "args that parse incorrectly should fail an Activity appropriately" $ \TestEnv {..} -> do
        let act :: Int -> Activity () Bool
            act _ = pure True
            actDef = provideActivity defaultCodec "badArgAct" act
            badActRef = KnownActivity @'[String] @Bool defaultCodec "badArgAct"
            workflow :: MyWorkflow Bool
            workflow =
              W.executeActivity
                badActRef
                (W.defaultStartActivityOptions $ W.ScheduleToClose $ seconds 3)
                  { retryPolicy = Just W.defaultRetryPolicy {W.maximumAttempts = 1}
                  }
                "notAnInt"
            wf = W.provideWorkflow defaultCodec "badArgActWf" workflow
            conf = configure () (wf, actDef) $ do
              baseConf
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just (seconds 10), C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        withWorker conf $ do
          useClient (C.execute wf.reference "badArgAct" opts)
            `shouldThrow` \case
              (WorkflowExecutionFailed _) -> True
              _ -> False
      specify "Workflow return values that parse incorrectly should throw a ValueException for Client" $ \TestEnv {..} -> do
        let testFn :: Int -> W.Workflow Bool
            testFn _ = pure True
            wf = W.provideWorkflow defaultCodec "test" testFn
            badWfRef = W.KnownWorkflow @'[Int] @String defaultCodec "test"
            conf = configure () wf $ do
              baseConf
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        withWorker conf $ do
          useClient (C.execute badWfRef "incorrectWorkflowArg" opts 0)
            `shouldThrow` (ValueError "Error in $: expected String, but encountered Boolean" ==)
      specify "ChildWorkflow return values that parse incorrectly should throw a ValueException in a Workflow" $ \TestEnv {..} -> do
        let childWorkflow :: W.Workflow Bool
            childWorkflow = pure True
            childWf = W.provideWorkflow defaultCodec "badRetChild" childWorkflow
            badChildRef = W.KnownWorkflow @'[] @String defaultCodec "badRetChild"
            parentWorkflow :: MyWorkflow String
            parentWorkflow =
              W.executeChildWorkflow badChildRef W.defaultChildWorkflowOptions
            parentWf = W.provideWorkflow defaultCodec "badRetChildParent" parentWorkflow
            conf = configure () (parentWf, childWf) $ do
              baseConf
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just (seconds 10), C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        withWorker conf $ do
          useClient (C.execute parentWf.reference "badRetChild" opts)
            `shouldThrow` \case
              (WorkflowExecutionFailed _) -> True
              _ -> False
      specify "Activity return values that parse incorrectly should throw a ValueException in a Workflow" $ \TestEnv {..} -> do
        let act :: Activity () Bool
            act = pure True
            actDef = provideActivity defaultCodec "badRetAct" act
            badActRef = KnownActivity @'[] @String defaultCodec "badRetAct"
            workflow :: MyWorkflow String
            workflow =
              W.executeActivity badActRef (W.defaultStartActivityOptions $ W.StartToClose $ seconds 5)
            wf = W.provideWorkflow defaultCodec "badRetActWf" workflow
            conf = configure () (wf, actDef) $ do
              baseConf
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just (seconds 10), C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        withWorker conf $ do
          useClient (C.execute wf.reference "badRetAct" opts)
            `shouldThrow` \case
              (WorkflowExecutionFailed _) -> True
              _ -> False

    --   describe "not found" $ do
    --     xit "should result in a task retry" $ \TestEnv{..} -> do
    --       let conf = configure () () $ do
    --             baseConf
    --       withWorker conf $ do
    --         wfId <- uuidText
    --         let opts = C.startWorkflowOptions
    --               (W.WorkflowId wfId)
    --               taskQueue
    --         -- pending
    --         let nonExistentWorkflow :: W.KnownWorkflow '[] ()
    --             nonExistentWorkflow = W.KnownWorkflow JSON Nothing Nothing "foo"
    --         _wfHandle <- C.start nonExistentWorkflow opts
    --         _ <- getLine
    --         pure ()

    --   --   specify "the workflow should return the correct value" pending
    --   -- describe "Cancellation" $ do
    --   --   specify "cancel a workflow" pending
    --   --   specify "cancelling a workflow cancels its activities" pending
    --   -- describe "Randomness" $ do
    --   --   specify "randomness is deterministic" pending
    describe "Time" $ do
      specify "time is deterministic" $ \TestEnv {..} -> do
        let testFn :: MyWorkflow (UTCTime, UTCTime, UTCTime)
            testFn = do
              t1 <- W.now
              t2 <- W.now
              W.sleep $ nanoseconds 1
              t3 <- W.now
              pure (t1, t2, t3)
            wf = W.provideWorkflow defaultCodec "test" testFn
            conf = configure () wf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          (t1, t2, t3) <- useClient (C.execute wf.reference "deterministicTime" opts)
          t1 `shouldBe` t2
          t3 `shouldSatisfy` (> t2)

    --   --   specify "ApplicationFailure exception" pending
    --   --   specify "ActivityFailure exception" pending
    --   --   specify "Non-wrapped exception" pending
    describe "Child workflows" $ do
      specify "failing children" $ \TestEnv {..} -> do
        let conf = configure () testConf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts =
                      C.TimeoutOptions
                        { C.runTimeout = Nothing
                        , C.executionTimeout = Nothing
                        , C.taskTimeout = Nothing
                        }
                  }
          childWorkflowIds <- replicateM 3 uuidText
          wfId <- uuidText
          useClient (C.execute testRefs.workflowWithFailingChildren (WorkflowId wfId) opts childWorkflowIds)
            `shouldReturn` ()
          wfId2 <- uuidText
          useClient (C.execute testRefs.workflowWithFailingChildren (WorkflowId wfId2) opts childWorkflowIds)
            `shouldThrow` \case
              (WorkflowExecutionFailed _) -> True
              _ -> False

      specify "invoke" $ \TestEnv {..} -> do
        parentId <- uuidText
        let isEven :: Int -> W.Workflow Bool
            isEven x = pure (even x)
            isEventWf = W.provideWorkflow defaultCodec "isEven" isEven
            parentWorkflow :: MyWorkflow Bool
            parentWorkflow = do
              let childTimeout =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 5
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                  opts :: W.StartChildWorkflowOptions
                  opts = W.defaultChildWorkflowOptions {W.timeoutOptions = childTimeout}
              childWorkflow <- W.startChildWorkflow isEventWf.reference opts 2
              $(logDebug) "waiting for child workflow"
              res <- W.waitChildWorkflowResult childWorkflow
              $(logDebug) "got child workflow result"
              pure res
            parentWf = W.provideWorkflow defaultCodec "basicInvokeChildWorkflow" parentWorkflow
            conf = configure () (isEventWf, parentWf) $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts =
                      C.TimeoutOptions
                        { C.runTimeout = Just $ seconds 5
                        , C.executionTimeout = Nothing
                        , C.taskTimeout = Nothing
                        }
                  }
          useClient (C.execute parentWf.reference (W.WorkflowId parentId) opts)
            `shouldReturn` True

      specify "failure" $ \TestEnv {..} -> do
        parentId <- uuidText
        let busted :: W.Workflow ()
            busted = error "busted"
            bustedWf = W.provideWorkflow defaultCodec "busted" busted
            parentWorkflow :: MyWorkflow ()
            parentWorkflow = do
              childWorkflow <- W.startChildWorkflow bustedWf.reference W.defaultChildWorkflowOptions
              W.waitChildWorkflowResult childWorkflow
            parentWf = W.provideWorkflow defaultCodec "parent" parentWorkflow
            conf = configure () (bustedWf, parentWf) $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute parentWf.reference (W.WorkflowId parentId) opts)
            `shouldThrow` \case
              (WorkflowExecutionFailed _) -> True
              _ -> False

      -- --     specify "termination" $ \_ -> pending
      -- --     specify "timeout" $ \_ -> pending
      -- --     specify "startFail" $ \_ -> pending
      specify "cancel immediately" $ \TestEnv {..} -> do
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
            conf = configure () (childWf, parentWf) $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute parentWf.reference (W.WorkflowId parentId) opts)
            `shouldReturn` "Left ChildWorkflowCancelled"

      -- TODO, the parent workflow event list doesn't really show the child workflow being cancelled???
      specify "cancel after child workflow has started" $ \TestEnv {..} -> do
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
            conf = configure () (childWf, parentWf) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute parentWf.reference (W.WorkflowId parentId) opts)
            `shouldReturn` "Left ChildWorkflowCancelled"

    -- Signal tests are in SignalSpec.hs
    describe "Query" $ do
      specify "works" $ \TestEnv {..} -> do
        tp <- getGlobalTracerProvider
        let testTracer = makeTracer tp "testTracer" tracerOptions

        let echoQuery :: W.KnownQuery '[Text] Text
            echoQuery = W.KnownQuery "testQuery" defaultCodec
            workflow :: MyWorkflow ()
            workflow = do
              W.setQueryHandler echoQuery $ \msg -> pure msg
              W.sleep $ seconds 5
            wf = W.provideWorkflow defaultCodec "queryWorkflow" workflow
            conf = configure () wf $ do
              baseConf

        inSpan testTracer "Query.works" defaultSpanArguments $ do
          withWorker conf $ do
            let opts =
                  (C.startWorkflowOptions taskQueue)
                    { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                    }
            h <- useClient (C.start wf.reference "queryWorks" opts)
            result <- C.query h echoQuery C.defaultQueryOptions "hello"
            C.cancel h (C.CancellationOptions mempty)
            result `shouldBe` Right "hello"

      specify "query not found" $ \TestEnv {..} -> do
        uuid <- uuidText
        let echoQuery :: W.KnownQuery '[Text] Text
            echoQuery = W.KnownQuery "testQuery" defaultCodec
            workflow :: MyWorkflow ()
            workflow = do
              W.setQueryHandler echoQuery $ \msg -> pure msg
              W.sleep $ seconds 5
            wf = W.provideWorkflow defaultCodec "notFoundQueryWorkflow" workflow
            conf = configure () wf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          h <- useClient (C.start wf.reference (WorkflowId uuid) opts)
          result <- C.query h echoQuery C.defaultQueryOptions "hello"
          C.cancel h (C.CancellationOptions mempty)
          result `shouldBe` Right "hello"
    -- specify "query and unblock" pending
    describe "Built-in queries" $ do
      let toMap :: Value -> Map Text Value
          toMap v = case Aeson.fromJSON v of
            Aeson.Success m -> m
            Aeson.Error e -> error $ "expected JSON object: " <> e

      specify "__stack_trace returns non-empty stack while workflow is blocked" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow ()
            workflow = W.sleep (seconds 30)
            wf = W.provideWorkflow defaultCodec "stackTraceWorkflow" workflow
            conf = configure () wf $ baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          h <- useClient (C.start wf.reference "stackTraceTest" opts)
          result <- C.query h builtinStackTraceQuery C.defaultQueryOptions
          C.cancel h (C.CancellationOptions mempty)
          case result of
            Left _ -> expectationFailure "stack trace query was rejected"
            Right txt -> txt `shouldSatisfy` (not . Text.null)

      specify "__enhanced_stack_trace returns structured JSON with SDK info" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow ()
            workflow = W.sleep (seconds 30)
            wf = W.provideWorkflow defaultCodec "enhancedStackTraceWorkflow" workflow
            conf = configure () wf $ baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          h <- useClient (C.start wf.reference "enhancedStackTraceTest" opts)
          result <- C.query h builtinEnhancedStackTraceQuery C.defaultQueryOptions
          C.cancel h (C.CancellationOptions mempty)
          case result of
            Left _ -> expectationFailure "enhanced stack trace query was rejected"
            Right val -> do
              let m = toMap val
              Map.member "sdk" m `shouldBe` True
              Map.member "stacks" m `shouldBe` True
              Map.member "sources" m `shouldBe` True
              let sdkMap = toMap (m Map.! "sdk")
              Map.lookup "name" sdkMap `shouldBe` Just (String "haskell")

      specify "__temporal_workflow_metadata includes handler definitions" $ \TestEnv {..} -> do
        let echoQuery :: W.KnownQuery '[Text] Text
            echoQuery = W.KnownQuery "testMetaQuery" defaultCodec
            mySignal :: W.KnownSignal '[]
            mySignal = W.KnownSignal "testMetaSignal" defaultCodec
            workflow :: MyWorkflow ()
            workflow = do
              W.setQueryHandler echoQuery $ \msg -> pure msg
              W.setSignalHandler mySignal $ pure ()
              W.sleep (seconds 30)
            wf = W.provideWorkflow defaultCodec "metadataWorkflow" workflow
            conf = configure () wf $ baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          h <- useClient (C.start wf.reference "metadataTest" opts)
          result <- C.query h builtinWorkflowMetadataQuery C.defaultQueryOptions
          C.cancel h (C.CancellationOptions mempty)
          case result of
            Left _ -> expectationFailure "workflow metadata query was rejected"
            Right val -> do
              let m = toMap val
                  defMap = toMap (m Map.! "definition")
              Map.lookup "type" defMap `shouldBe` Just (String "metadataWorkflow")
              case Map.lookup "queryDefinitions" defMap of
                Just (Array qs) -> do
                  let names = fmap (\q -> Map.lookup "name" (toMap q)) qs
                  names `shouldSatisfy` elem (Just (String "testMetaQuery"))
                _ -> expectationFailure "expected queryDefinitions array"
              case Map.lookup "signalDefinitions" defMap of
                Just (Array ss) -> do
                  let names = fmap (\s -> Map.lookup "name" (toMap s)) ss
                  names `shouldSatisfy` elem (Just (String "testMetaSignal"))
                _ -> expectationFailure "expected signalDefinitions array"

      specify "__stack_trace shows multiple stacks when workflow has concurrent branches" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow ()
            workflow = do
              _ <- W.race (W.sleep (seconds 30)) (W.sleep (seconds 30))
              pure ()
            wf = W.provideWorkflow defaultCodec "concurrentStackTraceWorkflow" workflow
            conf = configure () wf $ baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          h <- useClient (C.start wf.reference "concurrentStackTraceTest" opts)
          result <- C.query h builtinStackTraceQuery C.defaultQueryOptions
          C.cancel h (C.CancellationOptions mempty)
          case result of
            Left _ -> expectationFailure "stack trace query was rejected"
            Right txt -> do
              let stacks = filter (not . Text.null) $ Text.splitOn "\n\n" txt
              length stacks `shouldSatisfy` (>= 2)

    describe "Await condition" $ do
      it "signal handlers can unblock workflows" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          wfH <- useClient (C.start SignalUnblocksWorkflow "signalHandlerUnblock" opts)
          C.signal wfH unblockWorkflowSignal C.defaultSignalOptions
          C.waitWorkflowResult wfH `shouldReturn` ()

      it "works in signal handlers" $ \TestEnv {..} -> do
        let trigSig :: W.KnownSignal '[Int]
            trigSig = W.KnownSignal "trigSig" defaultCodec
            workflow :: MyWorkflow Int
            workflow = do
              st <- W.newStateVar (0 :: Int)
              W.setSignalHandler trigSig $ \n -> do
                W.waitCondition $ pure True
                W.modifyStateVar st (+ n)
              W.waitCondition $ do
                v <- W.readStateVar st
                pure $ v > 0
              W.readStateVar st
            wf = W.provideWorkflow defaultCodec "waitCondInSignal" workflow
            conf = configure () wf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just (seconds 10), C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          wfH <- useClient (C.start wf.reference "waitCondInSignal" opts)
          C.signal wfH trigSig C.defaultSignalOptions 42
          C.waitWorkflowResult wfH `shouldReturn` 42
      it "works in Workflows" $ \TestEnv {..} -> do
        let conf = configure () testConf $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute testRefs.simpleWait "simpleWait" opts) `shouldReturn` ()
    describe "Sleep" $ do
      specify "sleep" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              earlier <- W.now
              W.sleep $ nanoseconds 1
              later <- W.now
              pure (later > earlier)
            wf = W.provideWorkflow defaultCodec "sleepy" workflow
            conf = configure () wf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute wf.reference "sleep" opts)
            `shouldReturn` True

    describe "Timer" $ do
      specify "timer" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              earlier <- W.now
              t <- W.createTimer $ nanoseconds 10
              mapM_ W.wait t
              later <- W.now
              pure (later > earlier)
            wf = W.provideWorkflow defaultCodec "timer" workflow
            conf = configure () wf $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  }
          useClient (C.execute wf.reference "timer" opts)
            `shouldReturn` True

      specify "timer and cancel immediately" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              t <- W.createTimer $ nanoseconds 1
              mapM_ W.cancel t
              mapM_ W.wait t
              pure True
            wf = W.provideWorkflow defaultCodec "timerAndCancelImmediately" workflow
            conf = configure () wf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts =
                      C.TimeoutOptions
                        { C.runTimeout = Just $ seconds 30
                        , C.executionTimeout = Nothing
                        , C.taskTimeout = Nothing
                        }
                  }
          useClient (C.execute wf.reference "timerAndCancelImmediately" opts)
            `shouldReturn` True

      specify "timer and cancel with delay" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              t <- W.createTimer $ seconds 5000
              W.sleep $ nanoseconds 1
              mapM_ W.cancel t
              mapM_ W.wait t
              pure True
            wf = W.provideWorkflow defaultCodec "timerAndCancelWithDelay" workflow
            conf = configure () wf $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts =
                      C.TimeoutOptions
                        { C.runTimeout = Just $ seconds 30
                        , C.executionTimeout = Nothing
                        , C.taskTimeout = Nothing
                        }
                  }
          useClient (C.execute wf.reference "timerAndCancelWithDelay" opts)
            `shouldReturn` True
    describe "Patching" $ do
      specify "patch" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow Bool
            workflow = W.patched (W.PatchId "wibble")
            wf = W.provideWorkflow defaultCodec "patchedWorkflow" workflow
            conf = configure () wf $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts =
                      C.TimeoutOptions
                        { C.runTimeout = Just $ seconds 30
                        , C.executionTimeout = Nothing
                        , C.taskTimeout = Nothing
                        }
                  }
          useClient (C.execute wf.reference "supplyPatch" opts)
            `shouldReturn` True
      specify "deprecated patch" $ \TestEnv {..} -> do
        let workflow :: MyWorkflow Bool
            workflow = do
              W.deprecatePatch (W.PatchId "wibble")
              pure True
            wf = W.provideWorkflow defaultCodec "deprecatedPatchedWorkflow" workflow
            conf = configure () wf $ do
              baseConf

        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts =
                      C.TimeoutOptions
                        { C.runTimeout = Just $ seconds 30
                        , C.executionTimeout = Nothing
                        , C.taskTimeout = Nothing
                        }
                  }
          useClient (C.execute wf.reference "deprecatePatch" opts)
            `shouldReturn` True
  describe "ContinueAsNew" $ do
    specify "works" $ \TestEnv {..} -> do
      let conf = configure () testConf $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 30
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        useClient (C.execute testRefs.continueAsNewWorks "continueAsNewWorks" opts 0)
          `shouldReturn` "woohoo"
  describe "Workflow replay" $ do
    specify "works" $ \TestEnv {..} -> do
      let originalWorkflow :: W.ProvidedWorkflow (W.Workflow ())
          originalWorkflow = W.provideWorkflow JSON "replay-workflow" $ provideCallStack $ do
            W.sleep $ milliseconds 10
            _ <-
              W.executeActivity
                testRefs.basicActivity
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            W.sleep $ milliseconds 10
          originalConf = provideCallStack $ configure () (testConf <> toDefinitions originalWorkflow) baseConf

      history <- withWorker originalConf $ do
        uuid <- uuidText
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        useClient $ do
          wfHandle <- C.start originalWorkflow (WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      replayResult <- runReplayHistory globalRuntime originalConf history
      replayResult `shouldSatisfy` isRight

      let patchedWorkflow :: W.ProvidedWorkflow (W.Workflow ())
          patchedWorkflow = W.provideWorkflow JSON "replay-workflow" $ provideCallStack $ do
            W.sleep $ milliseconds 10
            _ <-
              W.executeActivity
                testRefs.basicActivity
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            hasPatch <- W.patched "wibble"
            when hasPatch $
              void $
                W.executeActivity
                  testRefs.basicActivity
                  (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            W.sleep $ milliseconds 10

          patchedConf = configure () (testConf <> toDefinitions patchedWorkflow) baseConf

      patchedReplayResult <- runReplayHistory globalRuntime patchedConf history
      patchedReplayResult `shouldSatisfy` isRight

      let incompatibleWorkflow :: W.ProvidedWorkflow (W.Workflow ())
          incompatibleWorkflow = W.provideWorkflow JSON "replay-workflow" $ provideCallStack $ do
            W.sleep $ milliseconds 10
            _ <-
              W.executeActivity
                testRefs.basicActivity
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            _ <-
              W.executeActivity
                testRefs.basicActivity
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            W.sleep $ milliseconds 10

          incompatibleConf = configure () (testConf <> toDefinitions incompatibleWorkflow) baseConf

      incompatibleReplayResult <- runReplayHistory globalRuntime incompatibleConf history
      incompatibleReplayResult `shouldSatisfy` isLeft
  describe "Update" $ do
    describe "startUpdate" $ do
      -- All the tests that call executeUpdate indirectly exercise startUpdate, but confirm here that validation failures are
      -- thrown immediately from startUpdate (without needing to wait for the update outcome)
      it "propagates validation failures" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          let updateOpts =
                C.UpdateOptions
                  { updateId = "start-update-with-a-validator-that-rejects"
                  , updateHeaders = mempty
                  }
          ( useClient do
              h <- C.start UpdateWithValidator "start-update-with-a-validator-that-rejects" opts
              C.startUpdate h testUpdate updateOpts (-12)
            )
            `shouldThrow` \case
              UpdateFailure _ -> True
      it "propagates validation exceptions if the validator throws" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          let updateOpts =
                C.UpdateOptions
                  { updateId = "start-update-with-a-validator-that-throws"
                  , updateHeaders = mempty
                  }
          ( useClient do
              h <- C.start UpdateWithValidator "start-update-with-a-validator-that-throws" opts
              C.startUpdate h testUpdate updateOpts 5
            )
            `shouldThrow` \case
              UpdateFailure _ -> True
    it "works with no validator" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "update-with-no-validator"
                , updateHeaders = mempty
                }
        (updateResult, workflowResult) <- useClient do
          h <- C.start UpdateWithoutValidator "update-with-no-validator" opts
          updateResult <- C.executeUpdate h testUpdate updateOpts 12
          workflowResult <- C.waitWorkflowResult h
          pure (updateResult, workflowResult)
        updateResult `shouldBe` 12
        workflowResult `shouldBe` 12
    it "works with a validator" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "update-with-a-validator"
                , updateHeaders = mempty
                }
        (updateResult, workflowResult) <- useClient do
          h <- C.start UpdateWithValidator "update-with-a-validator" opts
          liftIO $ waitForWorkflowStart h
          updateResult <- C.executeUpdate h testUpdate updateOpts 12
          workflowResult <- C.waitWorkflowResult h
          pure (updateResult, workflowResult)
        updateResult `shouldBe` 12
        workflowResult `shouldBe` 12
    it "propagates validation failures" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "update-with-a-validator-that-rejects"
                , updateHeaders = mempty
                }
        ( useClient do
            h <- C.start UpdateWithValidator "update-with-a-validator-that-rejects" opts
            C.executeUpdate h testUpdate updateOpts (-12)
          )
          `shouldThrow` \case
            UpdateFailure _ -> True
    it "propagates validation exceptions if the validator throws" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "update-with-a-validator-that-throws"
                , updateHeaders = mempty
                }
        ( useClient do
            h <- C.start UpdateWithValidator "update-with-a-validator-that-throws" opts
            C.executeUpdate h testUpdate updateOpts 5
          )
          `shouldThrow` \case
            UpdateFailure _ -> True
    it "propogates update exceptions if the update throws" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "update-that-throws"
                , updateHeaders = mempty
                }
        ( useClient do
            h <- C.start UpdateThatThrows "update-that-throws" opts
            C.executeUpdate h testUpdate updateOpts 5
          )
          `shouldThrow` \case
            UpdateFailure _ -> True
    it "should fail if the args don't parse correctly" $ \TestEnv {..} -> do
      -- state <- runIO $ newIORef (0 :: Int)
      let testUpdateFn :: Int -> W.Workflow Int
          testUpdateFn arg = do
            -- performUnsafeNonDeterministicIO $ modifyIORef state (+ arg)
            -- performUnsafeNonDeterministicIO $ readIORef state
            pure arg
          testWorkflowFn :: W.Workflow Int
          testWorkflowFn = provideCallStack do
            W.setUpdateHandler testUpdate testUpdateFn Nothing
            -- W.waitCondition do
            --   x <- performUnsafeNonDeterministicIO $ readIORef state
            --   pure $ x > 0
            -- performUnsafeNonDeterministicIO $ readIORef state
            W.sleep $ seconds 1
            pure 1
          wfRef = W.provideWorkflow defaultCodec "test" testWorkflowFn
          updateRef = W.provideUpdate defaultCodec "test" testUpdateFn
          badUpdateRef = W.KnownUpdate @'[String] @String defaultCodec "test"
          conf = configure () wfRef $ do
            baseConf
          opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
              , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
              }
          updateOpts =
            C.UpdateOptions
              { updateId = "update-args-do-not-parse"
              , updateHeaders = mempty
              }
      withWorker conf $ do
        ( useClient do
            h <- C.start wfRef "update-args-do-not-parse" opts
            C.executeUpdate h badUpdateRef updateOpts "ruhroh"
          )
          `shouldThrow` \case
            UpdateFailure _ -> True
    it "works with an update that causes the workflow to suspend" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "update-that-suspends"
                , updateHeaders = mempty
                }
        (updateResult, workflowResult) <- useClient do
          h <- C.start UpdateThatSleeps "update-that-suspends" opts
          updateResult <- C.executeUpdate h testUpdate updateOpts 12
          workflowResult <- C.waitWorkflowResult h
          pure (updateResult, workflowResult)
        updateResult `shouldBe` 12
        workflowResult `shouldBe` 12
    it "does not process the update if the workflow throws first" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "no-update-if-workflow-throws-first"
                , updateHeaders = mempty
                }
        (eUpdateResult, eWorkflowResult) <- useClient do
          h <- C.start WorkflowThatThrowsBeforeTheUpdate "no-update-if-workflow-throws-first" opts
          liftIO $ waitForWorkflowStart h
          updateResult <- Catch.try $ C.executeUpdate h testUpdate updateOpts 12
          workflowResult <- Catch.try $ C.waitWorkflowResult h
          let _ = show (updateResult :: Either RpcError Int)
          let _ = show (workflowResult :: Either WorkflowExecutionClosed Int)
          pure (updateResult, workflowResult)
        eUpdateResult `shouldSatisfy` \case
          Left (RpcError _ message _) -> message == "workflow execution already completed"
          _ -> False
        eWorkflowResult `shouldSatisfy` \case
          Left (WorkflowExecutionFailed attrs) -> (attrs ^. History.failure . Failure.message) == "Current state var: 0"
          _ -> False
    it "does process the update if the workflow only fails later" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                }
        let updateOpts =
              C.UpdateOptions
                { updateId = "yes-update-if-workflow-throws-later"
                , updateHeaders = mempty
                }
        (eUpdateResult, eWorkflowResult) <- useClient do
          h <- C.start WorkflowThatThrowsAfterTheUpdate "yes-update-if-workflow-throws-later" opts
          liftIO $ waitForWorkflowStart h
          updateResult <- Catch.try $ C.executeUpdate h testUpdate updateOpts 12
          workflowResult <- Catch.try $ C.waitWorkflowResult h
          let _ = show (updateResult :: Either RpcError Int)
          let _ = show (workflowResult :: Either WorkflowExecutionClosed Int)
          pure (updateResult, workflowResult)
        eUpdateResult `shouldSatisfy` \case
          Right 12 -> True
          _ -> False
        eWorkflowResult `shouldSatisfy` \case
          Left (WorkflowExecutionFailed attrs) -> (attrs ^. History.failure . Failure.message) == "Current state var: 12"
          _ -> False

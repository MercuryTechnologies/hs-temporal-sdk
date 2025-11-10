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

module IntegrationSpec.WorkflowExecution where

import Control.Exception (SomeException)
import Control.Monad (replicateM, void, when)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Data.Either (isLeft, isRight)
import Data.Maybe (fromJust)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import DiscoverInstances (discoverInstances)
import IntegrationSpec.Signals (SignalUnblocksWorkflow (..), unblockWorkflowSignal)
import IntegrationSpec.Utils
import OpenTelemetry.Trace
import RequireCallStack
import Temporal.Bundle
import Temporal.Bundle.TH
import qualified Temporal.Client as C
import Temporal.Contrib.OpenTelemetry
import Temporal.Duration
import Temporal.Exception (WorkflowExecutionClosed (..))
import Temporal.Payload (ValueError (..))
import Temporal.Replay
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Testing.Assertions
import qualified Temporal.Workflow as W
import Test.Hspec


{- | Workflow execution tests - covers basic workflow execution, race conditions,
args/return values, child workflows, queries, await conditions, sleep, timers,
patching, continueAsNew, and replay tests
-}
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
                      { C.runTimeout = Just $ seconds 4
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
        pending
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
        pending

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

    describe "Query" $ do
      specify "works" $ \TestEnv {..} -> do
        tp <- getGlobalTracerProvider
        let testTracer = makeTracer tp "testTracer" tracerOptions

        let echoQuery :: W.KnownQuery '[Text] Text
            echoQuery = W.KnownQuery "testQuery" defaultCodec
            workflow :: MyWorkflow ()
            workflow = do
              W.setQueryHandler echoQuery $ \msg -> pure msg
              W.sleep $ seconds 2
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
            C.waitWorkflowResult h
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
          result `shouldBe` Right "hello"

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

      it "works in signal handlers" $ const pending

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
                        { C.runTimeout = Just $ seconds 4
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
                        { C.runTimeout = Just $ seconds 4
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
                        { C.runTimeout = Just $ seconds 4
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
                        { C.runTimeout = Just $ seconds 4
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
                      { C.runTimeout = Just $ seconds 4
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
          originalConf = provideCallStack $ configure () (testConf, originalWorkflow) baseConf

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

          patchedConf = configure () (testConf, patchedWorkflow) baseConf

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

          incompatibleConf = configure () (testConf, incompatibleWorkflow) baseConf

      incompatibleReplayResult <- runReplayHistory globalRuntime incompatibleConf history
      incompatibleReplayResult `shouldSatisfy` isLeft

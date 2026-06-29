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

module IntegrationSpec.ActivityLifecycle (spec) where

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
  describe "Activities" $ do
    specify "should run a basic activity without issues" $ \TestEnv {..} -> do
      let conf = configure () testConf $ do
            baseConf

      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute testRefs.basicActivityWf "basicActivity" opts)
          `shouldReturn` 1
    specify "heartbeat works" $ \TestEnv {..} -> do
      let conf = configure () testConf $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute testRefs.runHeartbeat "heartbeatWorks" opts)
          `shouldReturn` 1
    specify "should properly handle faulty workflows" $ \TestEnv {..} -> do
      let conf = configure () testConf $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute testRefs.faultyWorkflow "faultyWorkflow" opts)
          `shouldReturn` 1
    specify "Immediate activity cancellation returns the expected result to workflows" $ \TestEnv {..} -> do
      let testActivity :: Activity () Int
          testActivity = withHeartbeat JSON $ \heartbeat _readHeartbeat -> do
            heartbeat ()
            pure 0

          testActivityAct :: ProvidedActivity () (Activity () Int)
          testActivityAct = provideActivity defaultCodec "immediateCancelResponse" testActivity

          testFn :: MyWorkflow Int
          testFn = do
            h1 <-
              W.startActivity
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
            W.cancel (h1 :: W.Task Int)
            W.wait h1 `Catch.catch` \(_ :: ActivityCancelled) -> pure 1

          wf = W.provideWorkflow defaultCodec "activityCancellation" testFn
          conf = configure () (wf, testActivityAct) $ do
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
        useClient (C.execute wf.reference "immediateActivityCancellation" opts)
          `shouldReturn` 1
    specify "Activity cancellation on heartbeat returns the expected result to workflows" $ \TestEnv {..} -> do
      let testActivity :: Activity () Int
          testActivity = withHeartbeat JSON $ \heartbeat _readHeartbeat -> do
            liftIO $ threadDelay 2_000_000
            heartbeat ()
            pure 0

          testActivityAct :: ProvidedActivity () (Activity () Int)
          testActivityAct = provideActivity defaultCodec "heartbeatAllowsOpportunityToCancel" testActivity

          testFn :: MyWorkflow Int
          testFn = do
            h1 <-
              W.startActivity
                testActivityAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
            W.sleep $ nanoseconds 1
            W.cancel (h1 :: W.Task Int)
            W.wait h1 `Catch.catch` \(_ :: ActivityCancelled) -> pure 1

          wf = W.provideWorkflow defaultCodec "activityCancellationOnHeartbeat" testFn
          conf = configure () (wf, testActivityAct) $ do
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
        useClient (C.execute wf.reference "activityCancellationOnHeartbeat" opts)
          `shouldReturn` 1
    specify "Activity retry exhaustion returns that in the RetryState" $ \TestEnv {..} -> do
      wfId <- uuidText
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
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
        useClient (C.execute ActivityTimeoutInWorkflow (WorkflowId wfId) opts)
          `shouldReturn` False

  describe "Local Activities" $ do
    specify "should run a basic local activity" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Activity () Int)
          localAct = provideCallStack $ provideActivity defaultCodec "basicLocalAct" $ pure 42

          workflow :: MyWorkflow Int
          workflow = do
            W.executeLocalActivity
              localAct.reference
              (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5})

          wf = W.provideWorkflow defaultCodec "basicLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute wf.reference "basicLocalActivity" opts)
          `shouldReturn` 42

    specify "local activity with arguments" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Int -> Text -> Activity () Text)
          localAct = provideCallStack $ provideActivity defaultCodec "localActWithArgs" $ \n msg ->
            pure $ msg <> Text.pack (show n)

          workflow :: MyWorkflow Text
          workflow = do
            W.executeLocalActivity
              localAct.reference
              (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5})
              (3 :: Int)
              ("hello" :: Text)

          wf = W.provideWorkflow defaultCodec "localActivityWithArgsWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute wf.reference "localActivityWithArgs" opts)
          `shouldReturn` "hello3"

    specify "local activity failure propagates to workflow" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Activity () ())
          localAct = provideCallStack $ provideActivity defaultCodec "failingLocalAct" $ do
            error "local activity failure"

          workflow :: MyWorkflow ()
          workflow = do
            W.executeLocalActivity
              localAct.reference
              ( W.defaultStartLocalActivityOptions
                  { W.startToCloseTimeout = Just $ seconds 5
                  , W.retryPolicy = Just $ W.defaultRetryPolicy {W.maximumAttempts = 1}
                  }
              )

          wf = W.provideWorkflow defaultCodec "failingLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 10
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        res <- Control.Exception.try @SomeException $ useClient (C.execute wf.reference "failingLocalActivity" opts)
        res `shouldSatisfy` isLeft

    specify "local activity with startLocalActivity and wait" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Activity () Text)
          localAct = provideCallStack $ provideActivity defaultCodec "asyncLocalAct" $ pure "async-result"

          workflow :: MyWorkflow Text
          workflow = do
            task <-
              W.startLocalActivity
                localAct.reference
                (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5})
            W.wait task

          wf = W.provideWorkflow defaultCodec "asyncLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute wf.reference "asyncLocalActivity" opts)
          `shouldReturn` "async-result"

    specify "local activity retries on transient failure" $ \TestEnv {..} -> do
      attemptRef <- newIORef (0 :: Int)
      let localAct :: ProvidedActivity () (Activity () Int)
          localAct = provideCallStack $ provideActivity defaultCodec "retryLocalAct" $ do
            attempt <- liftIO $ atomicModifyIORef' attemptRef (\n -> (n + 1, n + 1))
            if attempt < 3
              then error "transient failure"
              else pure attempt

          workflow :: MyWorkflow Int
          workflow = do
            W.executeLocalActivity
              localAct.reference
              ( W.defaultStartLocalActivityOptions
                  { W.startToCloseTimeout = Just $ seconds 10
                  , W.retryPolicy =
                      Just $
                        W.defaultRetryPolicy
                          { W.maximumAttempts = 5
                          , W.initialInterval = milliseconds 100
                          }
                  }
              )

          wf = W.provideWorkflow defaultCodec "retryLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
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
        useClient (C.execute wf.reference "retryLocalActivity" opts)
          `shouldReturn` 3

    specify "parallel local activities" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Text -> Activity () Text)
          localAct = provideCallStack $ provideActivity defaultCodec "echoLocalAct" pure

          workflow :: MyWorkflow [Text]
          workflow = do
            let laOpts = W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5}
            t1 <- W.startLocalActivity localAct.reference laOpts ("one" :: Text)
            t2 <- W.startLocalActivity localAct.reference laOpts ("two" :: Text)
            t3 <- W.startLocalActivity localAct.reference laOpts ("three" :: Text)
            r1 <- W.wait t1
            r2 <- W.wait t2
            r3 <- W.wait t3
            pure [r1, r2, r3]

          wf = W.provideWorkflow defaultCodec "parallelLocalActivitiesWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute wf.reference "parallelLocalActivities" opts)
          `shouldReturn` ["one", "two", "three"]

    specify "serial local activities in same task" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Text -> Activity () Text)
          localAct = provideCallStack $ provideActivity defaultCodec "serialEchoLocalAct" pure

          workflow :: MyWorkflow [Text]
          workflow = do
            let laOpts = W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5}
            r1 <- W.executeLocalActivity localAct.reference laOpts ("first" :: Text)
            r2 <- W.executeLocalActivity localAct.reference laOpts ("second" :: Text)
            r3 <- W.executeLocalActivity localAct.reference laOpts ("third" :: Text)
            pure [r1, r2, r3]

          wf = W.provideWorkflow defaultCodec "serialLocalActivitiesWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute wf.reference "serialLocalActivities" opts)
          `shouldReturn` ["first", "second", "third"]

    specify "local activity cancellation" $ \TestEnv {..} -> do
      blockForever <- newEmptyMVar
      let localAct :: ProvidedActivity () (Activity () Int)
          localAct = provideCallStack $ provideActivity defaultCodec "longRunningLocalAct" $ do
            liftIO $ takeMVar blockForever
            pure 0

          workflow :: MyWorkflow Int
          workflow = do
            h <-
              W.startLocalActivity
                localAct.reference
                (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 10})
            W.cancel (h :: W.Task Int)
            W.wait h `Catch.catch` \(_ :: ActivityCancelled) -> pure 99

          wf = W.provideWorkflow defaultCodec "cancelLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 15
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        useClient (C.execute wf.reference "cancelLocalActivity" opts)
          `shouldReturn` 99

    specify "local activity non-retryable error does not retry" $ \TestEnv {..} -> do
      attemptRef <- newIORef (0 :: Int)
      let localAct :: ProvidedActivity () (Activity () ())
          localAct = provideCallStack $
            provideActivity defaultCodec "nonRetryLocalAct" $
              checkpoint annotateNonRetryableError $ do
                _ <- liftIO $ atomicModifyIORef' attemptRef (\n -> (n + 1, n + 1))
                error "non-retryable error"

          workflow :: MyWorkflow ()
          workflow = do
            W.executeLocalActivity
              localAct.reference
              ( W.defaultStartLocalActivityOptions
                  { W.startToCloseTimeout = Just $ seconds 5
                  , W.retryPolicy = Just $ W.defaultRetryPolicy {W.maximumAttempts = 5}
                  }
              )

          wf = W.provideWorkflow defaultCodec "nonRetryLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 10
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        res <- Control.Exception.try @SomeException $ useClient (C.execute wf.reference "nonRetryLocalActivity" opts)
        res `shouldSatisfy` isLeft
      finalAttempts <- readIORef attemptRef
      finalAttempts `shouldBe` 1

    specify "isLocal flag is set correctly" $ \TestEnv {..} -> do
      let checkIsLocalAct :: ProvidedActivity () (Activity () Bool)
          checkIsLocalAct = provideCallStack $ provideActivity defaultCodec "checkIsLocalAct" $ do
            info <- askActivityInfo
            pure info.isLocal

          workflow :: MyWorkflow (Bool, Bool)
          workflow = do
            localResult <-
              W.executeLocalActivity
                checkIsLocalAct.reference
                (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5})
            remoteResult <-
              W.executeActivity
                checkIsLocalAct.reference
                (W.defaultStartActivityOptions $ W.StartToClose $ seconds 5)
            pure (localResult, remoteResult)

          wf = W.provideWorkflow defaultCodec "isLocalFlagWf" workflow
          conf = configure () (wf, activityDefinition checkIsLocalAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        useClient (C.execute wf.reference "isLocalFlag" opts)
          `shouldReturn` (True, False)

    specify "local activity timer backoff" $ \TestEnv {..} -> do
      attemptRef <- newIORef (0 :: Int)
      let localAct :: ProvidedActivity () (Activity () Int)
          localAct = provideCallStack $ provideActivity defaultCodec "backoffLocalAct" $ do
            attempt <- liftIO $ atomicModifyIORef' attemptRef (\n -> (n + 1, n + 1))
            if attempt < 2
              then error "retry me"
              else pure attempt

          workflow :: MyWorkflow Int
          workflow = do
            W.executeLocalActivity
              localAct.reference
              ( W.defaultStartLocalActivityOptions
                  { W.startToCloseTimeout = Just $ seconds 30
                  , W.localRetryThreshold = Just $ milliseconds 1
                  , W.retryPolicy =
                      Just $
                        W.defaultRetryPolicy
                          { W.maximumAttempts = 3
                          , W.initialInterval = seconds 2
                          }
                  }
              )

          wf = W.provideWorkflow defaultCodec "backoffLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 60
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        useClient (C.execute wf.reference "backoffLocalActivity" opts)
          `shouldReturn` 2

    specify "local activity timeout configuration" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Activity () (Maybe Duration, Maybe Duration))
          localAct = provideCallStack $ provideActivity defaultCodec "timeoutInfoLocalAct" $ do
            info <- askActivityInfo
            pure (info.startToCloseTimeout, info.scheduleToCloseTimeout)

          workflowStcOnly :: MyWorkflow (Maybe Duration, Maybe Duration)
          workflowStcOnly =
            W.executeLocalActivity
              localAct.reference
              (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5})

          workflowS2cOnly :: MyWorkflow (Maybe Duration, Maybe Duration)
          workflowS2cOnly =
            W.executeLocalActivity
              localAct.reference
              (W.defaultStartLocalActivityOptions {W.scheduleToCloseTimeout = Just $ seconds 7})

          workflowBoth :: MyWorkflow (Maybe Duration, Maybe Duration)
          workflowBoth =
            W.executeLocalActivity
              localAct.reference
              ( W.defaultStartLocalActivityOptions
                  { W.startToCloseTimeout = Just $ seconds 3
                  , W.scheduleToCloseTimeout = Just $ seconds 7
                  }
              )

          wfStc = W.provideWorkflow defaultCodec "timeoutStcOnlyWf" workflowStcOnly
          wfS2c = W.provideWorkflow defaultCodec "timeoutS2cOnlyWf" workflowS2cOnly
          wfBoth = W.provideWorkflow defaultCodec "timeoutBothWf" workflowBoth
          conf = configure () (wfStc, wfS2c, wfBoth, activityDefinition localAct) $ do
            baseConf
      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        stcResult <- useClient (C.execute wfStc.reference "timeoutStcOnly" opts)
        fst stcResult `shouldBe` Just (seconds 5)

        s2cResult <- useClient (C.execute wfS2c.reference "timeoutS2cOnly" opts)
        snd s2cResult `shouldBe` Just (seconds 7)

        bothResult <- useClient (C.execute wfBoth.reference "timeoutBoth" opts)
        fst bothResult `shouldBe` Just (seconds 3)
        snd bothResult `shouldBe` Just (seconds 7)

    specify "cancel local activity during DoBackoff timer" $ \TestEnv {..} -> do
      attemptRef <- newIORef (0 :: Int)
      let localAct :: ProvidedActivity () (Activity () ())
          localAct = provideCallStack $ provideActivity defaultCodec "failForDoBackoffCancelAct" $ do
            n <- liftIO $ atomicModifyIORef' attemptRef (\n -> (n + 1, n))
            when (n < 5) $ error "retry me"

          workflow :: MyWorkflow Int
          workflow = do
            h <-
              W.startLocalActivity
                localAct.reference
                ( W.defaultStartLocalActivityOptions
                    { W.startToCloseTimeout = Just $ seconds 30
                    , W.retryPolicy =
                        Just $
                          W.defaultRetryPolicy
                            { W.maximumAttempts = 10
                            , W.initialInterval = seconds 30
                            }
                    , -- Tiny threshold forces DoBackoff after every failure, creating
                      -- server-side timers that can be cancelled.
                      W.localRetryThreshold = Just $ milliseconds 1
                    }
                )
            -- Wait long enough for the first attempt to fail and the DoBackoff
            -- timer to be scheduled, then cancel.
            W.sleep $ seconds 2
            W.cancel (h :: W.Task ())
            (W.wait h >> pure 0) `Catch.catch` \(_ :: ActivityCancelled) -> pure 77

          wf = W.provideWorkflow defaultCodec "cancelDoBackoffLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
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
        useClient (C.execute wf.reference "cancelDoBackoffLocalActivity" opts)
          `shouldReturn` 77

    specify "worker shutdown completes local activity gracefully" $ \TestEnv {..} -> do
      activityStarted <- newEmptyMVar
      activityCanFinish <- newEmptyMVar
      let localAct :: ProvidedActivity () (Activity () Text)
          localAct = provideCallStack $ provideActivity defaultCodec "shutdownLocalAct" $ do
            liftIO $ putMVar activityStarted ()
            liftIO $ takeMVar activityCanFinish
            pure "completed-during-shutdown"

          workflow :: MyWorkflow Text
          workflow =
            W.executeLocalActivity
              localAct.reference
              (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 30})

          wf = W.provideWorkflow defaultCodec "workerShutdownLocalActivityWf" workflow
          conf = configure () (wf, activityDefinition localAct) $ do
            baseConf
      -- Start workflow in one worker, then shut down while activity is running.
      -- The workflow should still complete because the activity finishes before
      -- the shutdown grace period expires.
      resultVar <- newEmptyMVar
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
        _ <- forkIO $ do
          res <- useClient (C.execute wf.reference "workerShutdownLA" opts)
          putMVar resultVar res
        -- Wait until the activity has started executing
        takeMVar activityStarted
        -- Allow the activity to finish
        putMVar activityCanFinish ()
        -- Wait for the workflow result before the bracket-based shutdown
        res <- takeMVar resultVar
        res `shouldBe` "completed-during-shutdown"

    specify "local activity replay works" $ \TestEnv {..} -> do
      let localAct :: ProvidedActivity () (Text -> Activity () Text)
          localAct = provideCallStack $ provideActivity defaultCodec "replayEchoLocalAct" pure

          originalWorkflow :: W.ProvidedWorkflow (W.Workflow Text)
          originalWorkflow = W.provideWorkflow defaultCodec "replay-local-activity-wf" $ provideCallStack $ do
            W.executeLocalActivity
              localAct.reference
              (W.defaultStartLocalActivityOptions {W.startToCloseTimeout = Just $ seconds 5})
              ("replayed" :: Text)

          originalConf = provideCallStack $ configure () (testConf <> toDefinitions (activityDefinition localAct) <> toDefinitions originalWorkflow) baseConf

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

      let replayConf = originalConf {payloadProcessor = sillyEncryptionPayloadProcessor}
      replayResult <- runReplayHistory globalRuntime replayConf history
      replayResult `shouldSatisfy` isRight

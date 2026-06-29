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

module IntegrationSpec.RegressionTests (spec) where

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
  describe "Regression tests" $ do
    specify "immediate activity start works" $ \TestEnv {..} -> do
      let taskMainActivity :: ProvidedActivity () (RegressionTask -> Activity () ())
          taskMainActivity = provideCallStack $ provideActivity JSON "legacyTaskMainAct" $ \command -> do
            pure ()

          taskMainWorkflow :: W.ProvidedWorkflow (RegressionTask -> W.Workflow ())
          taskMainWorkflow = provideCallStack $ W.provideWorkflow JSON "legacyTaskMain" $ \command -> do
            -- Info{..} <- info
            W.executeActivity
              taskMainActivity.reference
              ((W.defaultStartActivityOptions $ W.StartToClose infinity) {activityId = Just $ W.ActivityId "woejfwoefijweof"})
              command

          definitions =
            ( activityDefinition taskMainActivity
            , workflowDefinition taskMainWorkflow
            , testConf
            )
          conf = configure () definitions $ do
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
        useClient (C.execute taskMainWorkflow.reference "immediate-start-regression" opts Foo)
          `shouldReturn` ()

    -- specify "to different workflow" pending
    -- specify "to same workflow keeps memo and search attributes" pending
    -- specify "to different workflow keeps memo and search attributes by default" pending
    -- specify "to different workflow can set memo and search attributes" pending
    describe "signalWithStart" do
      it "works" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) baseConf
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
          useClient $ do
            liftIO $ putStrLn "signalWithStart call"
            wfH <-
              C.signalWithStart
                SignalUnblocksWorkflow
                "signalWithStart"
                opts
                unblockWorkflowSignal
            lift $ C.waitWorkflowResult wfH `shouldReturn` ()
      it "works with workflow and signal arguments" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) baseConf
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
          useClient $ do
            liftIO $ putStrLn "signalWithStart call"
            wfH <-
              C.signalWithStart
                SignalWithArgsWorkflow
                "signalWithStartWithArgs"
                opts
                signalWithArgs
                50
                2
            lift $ C.waitWorkflowResult wfH `shouldReturn` 25

      -- Test for signal buffering: signals sent via signalWithStart should be
      -- buffered until the handler is registered, not dropped.
      it "buffers signals until handler is registered" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts =
                      C.TimeoutOptions
                        { -- Short timeout so test fails fast if signal is dropped
                          C.runTimeout = Just $ seconds 3
                        , C.executionTimeout = Nothing
                        , C.taskTimeout = Nothing
                        }
                  }
          useClient $ do
            wfH <-
              C.signalWithStart
                SignalBufferingWorkflow
                "signalBufferingTest"
                opts
                signalBufferingSignal
                42
            -- If signal buffering works, workflow completes with signal value
            -- If signal is dropped, workflow times out waiting for the signal
            lift $ C.waitWorkflowResult wfH `shouldReturn` 42

      -- Test that buffered signals are delivered in FIFO order
      it "delivers buffered signals in FIFO order" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) baseConf
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
          useClient $ do
            -- Start workflow with first signal (value 1)
            wfH <-
              C.signalWithStart
                SignalOrderingWorkflow
                "signalOrderingTest"
                opts
                signalBufferingSignal
                (1 :: Int)
            -- Immediately send second signal (value 2)
            C.signal wfH signalBufferingSignal C.defaultSignalOptions (2 :: Int)
            -- Workflow should return signals in order [1, 2]
            -- If order is wrong, we'd get [2, 1]
            lift $ C.waitWorkflowResult wfH `shouldReturn` [1, 2]

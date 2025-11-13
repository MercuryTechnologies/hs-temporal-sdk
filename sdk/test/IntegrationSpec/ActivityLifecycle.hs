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

module IntegrationSpec.ActivityLifecycle where

import Control.Concurrent (threadDelay)
import Control.Monad (void)
import qualified Control.Monad.Catch as Catch
import Control.Monad.IO.Class (liftIO)
import DiscoverInstances (discoverInstances)
import IntegrationSpec.TimeoutsInWorkflows
import IntegrationSpec.Utils
import RequireCallStack
import Temporal.Activity
import Temporal.Bundle.TH
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Exception (ActivityCancelled)
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import qualified Temporal.Workflow as W
import Test.Hspec


{- | Activity lifecycle tests - covers activity execution, cancellation,
heartbeat handling, and retry policies
-}
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
      pending -- TODO: Fix startActivity argument application
    specify "Activity cancellation on heartbeat returns the expected result to workflows" $ \TestEnv {..} -> do
      pending -- TODO: Fix startActivity argument application
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
                      { C.runTimeout = Just $ seconds 4
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        useClient (C.execute ActivityTimeoutInWorkflow (WorkflowId wfId) opts)
          `shouldReturn` False

    specify "Activity return values that parse incorrectly should throw a ValueException in a Workflow" $ \TestEnv {} -> do
      pending

{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}

module IntegrationSpec.TimeSkippingWorkflowTests (spec) where

import Data.Time.Clock (diffUTCTime, getCurrentTime)
import DiscoverInstances (discoverInstances)
import IntegrationSpec.TimeSkipping (VariableSleepFromChildWorkflow (..), VariableSleepWorkflow (..))
import IntegrationSpec.Utils
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import qualified Temporal.Workflow as W
import Test.Hspec


-- | Time skipping workflow tests (run on time-skipping test server)
spec :: SpecWith TestEnv
spec = do
  describe "Workflow" $ do
    it "should run a workflow" $ \TestEnv {..} -> do
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
        useClient (C.execute testRefs . shouldRunWorkflowTest "basicWf" opts)
          `shouldReturn` ()
    it "should skip over sleeps in a workflow" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
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
        startTime <- getCurrentTime
        useClient (C.execute VariableSleepWorkflow "variable-sleep-workflow" opts 10)
        endTime <- getCurrentTime
        let secondsElapsed = diffUTCTime endTime startTime
        secondsElapsed `shouldSatisfy` (< 1)
    it "should skip over sleeps in a child workflow" $ \TestEnv {..} -> do
      let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
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
        startTime <- getCurrentTime
        useClient (C.execute VariableSleepFromChildWorkflow "variable-sleep-from-child-workflow" opts 10)
        endTime <- getCurrentTime
        let secondsElapsed = diffUTCTime endTime startTime
        secondsElapsed `shouldSatisfy` (< 1)

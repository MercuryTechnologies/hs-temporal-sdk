{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}

module IntegrationSpec.TimeSkippingIntegrationTests (spec) where

import DiscoverInstances (discoverInstances)
import IntegrationSpec.TimeSkipping (VariableSleepWorkflow (..))
import IntegrationSpec.Utils
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import qualified Temporal.Client.TestService
import Temporal.Duration
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import qualified Temporal.Workflow as W
import Test.Hspec


-- | Time skipping integration test (verifies time skipping not available on regular server)
spec :: SpecWith TestEnv
spec = describe "Time Skipping" do
  it "fails if not connected to the time-skipping server" $ \TestEnv {..} -> do
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
      h <- useClient (C.start VariableSleepWorkflow "variable-sleep-workflow" opts 10)
      (Temporal.Client.TestService.unlockTimeSkippingWithSleep (C.clientCore (C.workflowHandleClient h)) (seconds 10))
        `shouldThrow` \case
          Temporal.Client.TestService.TimeSkippingNotSupported -> True

{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}

module IntegrationSpec.RegressionTests (spec) where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Class (lift)
import DiscoverInstances (discoverInstances)
import IntegrationSpec.Signals (SignalUnblocksWorkflow (..), SignalWithArgsWorkflow (..), signalWithArgs, unblockWorkflowSignal)
import IntegrationSpec.Utils
import RequireCallStack (provideCallStack)
import Temporal.Activity
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Payload
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import qualified Temporal.Workflow as W
import Test.Hspec


-- | Regression tests - various bug fixes and edge cases
spec :: SpecWith TestEnv
spec = describe "Regression tests" $ do
  specify "immediate activity start works" $ \TestEnv {..} -> do
    let taskMainActivity :: ProvidedActivity () (RegressionTask -> Activity () ())
        taskMainActivity = provideCallStack $ provideActivity JSON "legacyTaskMainAct" $ \command -> do
          pure ()

        taskMainWorkflow :: W.ProvidedWorkflow (RegressionTask -> W.Workflow ())
        taskMainWorkflow = provideCallStack $ W.provideWorkflow JSON "legacyTaskMain" $ \command -> do
          -- Info{..} <- info
          W.executeActivity
            taskMainActivity
            . reference
              ((W.defaultStartActivityOptions $ W.StartToClose infinity) {W.activityId = Just $ W.ActivityId "woejfwoefijweof"})
              command

        conf = configure () (taskMainActivity, taskMainWorkflow, testConf) $ do
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
      useClient (C.execute taskMainWorkflow . reference "immediate-start-regression" opts Foo)
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
                      { C.runTimeout = Just $ seconds 4
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
                      { C.runTimeout = Just $ seconds 4
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

--     specify "works as intended and returns correct runId" pending

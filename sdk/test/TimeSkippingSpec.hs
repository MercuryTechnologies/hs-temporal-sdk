{-# LANGUAGE TemplateHaskell #-}

module TimeSkippingSpec where

import Data.Time.Clock (diffUTCTime, getCurrentTime)
import DiscoverInstances (discoverInstances)
import IntegrationSpec.TimeSkipping
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import qualified Temporal.Client.TestService
import Temporal.Duration
import Temporal.Payload hiding (around)
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = do
  timeSkippingNotSupportedTests
  timeSkippingTests


timeSkippingNotSupportedTests :: Spec
timeSkippingNotSupportedTests =
  aroundAll withServer $
    aroundAllWith (flip $ setup mempty) $
      describe "Time Skipping" $ do
        it "fails if not connected to the time-skipping server" $ \TestEnv {..} -> do
          let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do baseConf
          withWorker conf $ do
            let opts = defaultStartOptsWithTimeout taskQueue (seconds 15)
            h <- useClient (C.start VariableSleepWorkflow "ts-not-supported" opts 10)
            (Temporal.Client.TestService.unlockTimeSkippingWithSleep (C.clientCore (C.workflowHandleClient h)) (seconds 10))
              `shouldThrow` \case
                Temporal.Client.TestService.TimeSkippingNotSupported -> True


timeSkippingTests :: Spec
timeSkippingTests =
  around withTimeSkippingServer $
    aroundWith (flip $ setupTimeSkipping mempty) $
      describe "Time Skipping (with test server)" $ do
        it "runs a basic workflow" $ \TestEnv {..} -> do
          let workflow :: W.Workflow ()
              workflow = pure ()
              wf = W.provideWorkflow defaultCodec "tsBasic" workflow
              conf = configure () wf $ do baseConf
          withWorker conf $ do
            let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
            useClient (C.execute wf.reference "tsBasic" opts) `shouldReturn` ()

        it "should skip over sleeps in a workflow" $ \TestEnv {..} -> do
          let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do baseConf
          withWorker conf $ do
            let opts = defaultStartOptsWithTimeout taskQueue (seconds 15)
            startTime <- getCurrentTime
            _ <- useClient (C.execute VariableSleepWorkflow "ts-skip-sleep" opts 10)
            endTime <- getCurrentTime
            let elapsed = diffUTCTime endTime startTime
            elapsed `shouldSatisfy` (< 3)

        it "should skip over sleeps in a child workflow" $ \TestEnv {..} -> do
          let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do baseConf
          withWorker conf $ do
            let opts = defaultStartOptsWithTimeout taskQueue (seconds 15)
            startTime <- getCurrentTime
            _ <- useClient (C.execute VariableSleepFromChildWorkflow "ts-skip-child" opts 10)
            endTime <- getCurrentTime
            let elapsed = diffUTCTime endTime startTime
            elapsed `shouldSatisfy` (< 3)

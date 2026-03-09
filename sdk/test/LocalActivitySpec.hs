module LocalActivitySpec where

import qualified Control.Monad.Catch as Catch
import Temporal.Activity hiding (retryPolicy)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Exception
import Temporal.Worker (configure)
import Temporal.Workflow (StartLocalActivityOptions(retryPolicy))
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


tests :: SpecWith TestEnv
tests = describe "Local Activities" $ do
  specify "basic local activity execution" $ \TestEnv {..} -> do
    let act :: Activity () Int
        act = pure 42
        actDef = provideActivity defaultCodec "localBasicAct" act
        opts =
          W.defaultStartLocalActivityOptions
            { W.startToCloseTimeout = Just $ seconds 5
            }
        workflow :: MyWorkflow Int
        workflow = do
          h <- W.startLocalActivity actDef.reference opts
          W.wait (h :: W.Task Int)
        wf = W.provideWorkflow defaultCodec "localBasicActWf" workflow
        conf = configure () (wf, actDef) baseConf
    withWorker conf $ do
      let startOpts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute wf.reference "localBasicAct" startOpts)
        `shouldReturn` 42

  specify "local activity with arguments" $ \TestEnv {..} -> do
    let act :: Int -> Int -> Activity () Int
        act a b = pure (a + b)
        actDef = provideActivity defaultCodec "localAddAct" act
        opts =
          W.defaultStartLocalActivityOptions
            { W.startToCloseTimeout = Just $ seconds 5
            }
        workflow :: MyWorkflow Int
        workflow = do
          h <- W.startLocalActivity actDef.reference opts 17 25
          W.wait h
        wf = W.provideWorkflow defaultCodec "localAddActWf" workflow
        conf = configure () (wf, actDef) baseConf
    withWorker conf $ do
      let startOpts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute wf.reference "localAddAct" startOpts)
        `shouldReturn` 42

  specify "local activity failure propagation" $ \TestEnv {..} -> do
    let act :: Activity () ()
        act = error "local activity kaboom"
        actDef = provideActivity defaultCodec "localFailingAct" act
        opts =
          W.defaultStartLocalActivityOptions
            { W.startToCloseTimeout = Just $ seconds 3
            , retryPolicy = Just $ W.defaultRetryPolicy {W.maximumAttempts = 1}
            }
        workflow :: MyWorkflow ()
        workflow = do
          h <- W.startLocalActivity actDef.reference opts
          W.wait (h :: W.Task ())
        wf = W.provideWorkflow defaultCodec "localFailingActWf" workflow
        conf = configure () (wf, actDef) baseConf
    withWorker conf $ do
      let startOpts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute wf.reference "localFailingAct" startOpts)
        `shouldThrow` \case
          WorkflowExecutionFailed _ -> True
          _ -> False

  specify "local activity retry on transient failure" $ \TestEnv {..} -> do
    let act :: Activity () Int
        act = do
          info <- askActivityInfo
          if info.attempt <= 2
            then error "transient"
            else pure 88
        actDef = provideActivity defaultCodec "localRetryAct" act
        opts =
          W.defaultStartLocalActivityOptions
            { W.startToCloseTimeout = Just $ seconds 10
            , retryPolicy =
                Just $
                  W.defaultRetryPolicy
                    { W.maximumAttempts = 5
                    , W.initialInterval = milliseconds 100
                    }
            }
        workflow :: MyWorkflow Int
        workflow = do
          h <- W.startLocalActivity actDef.reference opts
          W.wait (h :: W.Task Int)
        wf = W.provideWorkflow defaultCodec "localRetryActWf" workflow
        conf = configure () (wf, actDef) baseConf
    withWorker conf $ do
      let startOpts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      useClient (C.execute wf.reference "localRetryAct" startOpts)
        `shouldReturn` 88

  specify "local activity cancellation" $ \TestEnv {..} -> do
    let act :: Activity () Int
        act = pure 0
        actDef = provideActivity defaultCodec "localCancelAct" act
        opts =
          W.defaultStartLocalActivityOptions
            { W.startToCloseTimeout = Just $ seconds 5
            }
        workflow :: MyWorkflow Int
        workflow = do
          h <- W.startLocalActivity actDef.reference opts
          W.cancel (h :: W.Task Int)
          W.wait h `Catch.catch` \(_ :: ActivityCancelled) -> pure 777
        wf = W.provideWorkflow defaultCodec "localCancelActWf" workflow
        conf = configure () (wf, actDef) baseConf
    withWorker conf $ do
      let startOpts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute wf.reference "localCancelAct" startOpts)
        `shouldReturn` 777

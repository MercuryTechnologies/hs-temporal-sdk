module SchedulerStressSpec where

import Control.Exception (SomeException)
import Control.Monad (forM_, replicateM_)
import qualified Control.Monad.Catch as Catch
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


tests :: SpecWith TestEnv
tests = describe "Scheduler stress" $ do
  specify "50 concurrent fibers all complete under heavy queue churn" $ \TestEnv {..} -> do
    -- Contract: no fiber is lost or double-resumed. Every branch yields a
    -- deterministic number of times (churning the run queue), bumps a shared
    -- counter exactly once, then parks on a condition that only the final
    -- bump satisfies. A lost fiber -> stuck workflow (timeout); a
    -- double-resumed fiber -> counter > 50.
    let n = 50 :: Int
        workflow :: MyWorkflow Int
        workflow = do
          counter <- W.newStateVar (0 :: Int)
          let branch :: Int -> MyWorkflow ()
              branch i = do
                replicateM_ (1 + i `mod` 3) W.yield
                W.modifyStateVar counter (+ 1)
                W.waitCondition ((>= n) <$> W.readStateVar counter)
          W.traverseConcurrently_ branch [1 .. n]
          W.readStateVar counter
        wf = W.provideWorkflow defaultCodec "schedStressInterleave" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 60)
      useClient (C.execute wf.reference "schedStressInterleave" opts) `shouldReturn` n

  specify "yield ping-pong alternates two fibers without starvation" $ \TestEnv {..} -> do
    -- Contract: 'W.yield' requeues the current continuation BEHIND everything
    -- runnable, so a fiber spinning on yield cannot starve its peer. Two
    -- fibers strictly alternate 25 appends each purely by yielding (never
    -- blocking), forcing the exact sequence "abab...". Starvation -> stuck
    -- workflow; unfair requeueing -> broken alternation.
    let k = 25 :: Int
        workflow :: MyWorkflow Text
        workflow = do
          st <- W.newStateVar ("" :: String)
          let step :: Char -> (Int -> Bool) -> Int -> MyWorkflow ()
              step _ _ 0 = pure ()
              step c myTurn remaining = do
                xs <- W.readStateVar st
                if myTurn (length xs)
                  then do
                    W.modifyStateVar st (c :)
                    step c myTurn (remaining - 1)
                  else do
                    W.yield
                    step c myTurn remaining
          W.concurrently_ (step 'a' even k) (step 'b' odd k)
          Text.pack . reverse <$> W.readStateVar st
        wf = W.provideWorkflow defaultCodec "schedStressPingPong" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 60)
      useClient (C.execute wf.reference "schedStressPingPong" opts)
        `shouldReturn` Text.pack (concat (replicate k "ab"))

  specify "30-signal storm is delivered to handler fibers in FIFO order" $ \TestEnv {..} -> do
    -- Contract: signal handler invocations are injected as fibers in arrival
    -- order, across however many activations the storm spans. Reordered or
    -- dropped handler fibers -> list /= [1..30].
    let n = 30 :: Int
        stormSig = W.KnownSignal @'[Int] "stormSignal" defaultCodec
        workflow :: MyWorkflow [Int]
        workflow = do
          st <- W.newStateVar ([] :: [Int])
          W.setSignalHandler stormSig $ \i -> W.modifyStateVar st (<> [i])
          W.waitCondition ((>= n) . length <$> W.readStateVar st)
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "schedStressSignalStorm" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 60)
      wfH <- useClient (C.start wf.reference "schedStressSignalStorm" opts)
      waitForWorkflowStart wfH
      forM_ [1 .. n] $ \i -> C.signal wfH stormSig C.defaultSignalOptions i
      C.waitWorkflowResult wfH `shouldReturn` [1 .. n]

  specify "catch frame survives suspension while sibling fibers run" $ \TestEnv {..} -> do
    -- Contract: a 'Catch.catch' frame lives inside the captured continuation,
    -- so an exception thrown AFTER the protected region suspends (on a
    -- signal-unblocked condition) and resumes is still caught, while an
    -- unrelated concurrent race completes normally. A catch frame lost across
    -- capture/resume -> workflow fails instead of returning the fallback.
    let unblockSig = W.KnownSignal @'[] "unblock" defaultCodec
        workflow :: MyWorkflow (Text, Text)
        workflow = do
          st <- W.newStateVar False
          W.setSignalHandler unblockSig $ W.writeStateVar st True
          let protected :: MyWorkflow Text
              protected =
                Catch.catch
                  ( do
                      W.waitCondition (W.readStateVar st)
                      error "post-resume boom"
                  )
                  (\(_ :: SomeException) -> pure "fallback")
              sibling :: MyWorkflow Text
              sibling = do
                r <- W.race (W.sleep (nanoseconds 1) >> pure "timer") (W.waitCondition (pure False) >> pure "never")
                pure (either id id r)
          W.concurrently protected sibling
        wf = W.provideWorkflow defaultCodec "schedStressCatchSuspend" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 60)
      wfH <- useClient (C.start wf.reference "schedStressCatchSuspend" opts)
      waitForWorkflowStart wfH
      C.signal wfH unblockSig C.defaultSignalOptions
      C.waitWorkflowResult wfH `shouldReturn` ("fallback", "timer")

  specify "20 races drop loser continuations without corrupting the scheduler" $ \TestEnv {..} -> do
    -- Contract: a race loser's parked one-shot continuation is dropped
    -- safely. 20 sequential races each abandon a permanently-blocked
    -- condition fiber; the loop still counts to exactly 20 and the workflow
    -- completes. A corrupt run queue or resurrected loser -> wrong count or
    -- stuck workflow.
    let n = 20 :: Int
        workflow :: MyWorkflow Int
        workflow = do
          let go :: Int -> MyWorkflow Int
              go i
                | i >= n = pure i
                | otherwise = do
                    r <- W.race (W.sleep (milliseconds 1)) (W.waitCondition (pure False))
                    case r of
                      Left () -> go (i + 1)
                      Right () -> pure (negate 1)
          go 0
        wf = W.provideWorkflow defaultCodec "schedStressRaceDrop" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 60)
      useClient (C.execute wf.reference "schedStressRaceDrop" opts) `shouldReturn` n

  specify "a biselect cancelled as a race loser propagates cancellation and runs its finalizer" $ \TestEnv {..} -> do
    -- When a 'biselect' is itself the losing side of an outer 'race', its
    -- parent fiber is suspended on the wakeup IVar inside the both-blocked
    -- branch.
    --
    -- Cancelling that loser must deliver the synthetic 'WorkflowFiberCancelled'
    -- THROUGH the wakeup suspend so the loser unwinds and its 'finally' runs.
    let workflow :: MyWorkflow Bool
        workflow = do
          ran <- W.newStateVar False
          let blocked :: MyWorkflow (Either () ())
              blocked = W.waitCondition (pure False) >> pure (Left ())
              innerBiselect :: MyWorkflow (Either () ((), ()))
              innerBiselect = W.biselect blocked blocked
              loser :: MyWorkflow (Either () ((), ()))
              loser = innerBiselect `Catch.finally` W.writeStateVar ran True
              winner :: MyWorkflow ()
              winner = W.sleep (milliseconds 5)
          _ <- winner `W.race` loser
          W.readStateVar ran
        wf = W.provideWorkflow defaultCodec "schedStressBiselectCancel" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 60)
      useClient (C.execute wf.reference "schedStressBiselectCancel" opts) `shouldReturn` True

  specify "cancelling a biselect as a race loser runs BOTH children's finalizers" $ \TestEnv {..} -> do
    -- Cancelling a 'biselect' loser must cancel the two sub-fibers it is
    -- waiting on, not just unwind the biselect itself; this means that the
    -- children's finalizers MUST run.
    let workflow :: MyWorkflow (Bool, Bool)
        workflow = do
          ranA <- W.newStateVar False
          ranB <- W.newStateVar False
          let childA :: MyWorkflow (Either () ())
              childA =
                (W.waitCondition (pure False) >> pure (Left ()))
                  `Catch.finally` W.writeStateVar ranA True
              childB :: MyWorkflow (Either () ())
              childB =
                (W.waitCondition (pure False) >> pure (Left ()))
                  `Catch.finally` W.writeStateVar ranB True
              loser :: MyWorkflow (Either () ((), ()))
              loser = W.biselect childA childB
              winner :: MyWorkflow ()
              winner = W.sleep (milliseconds 5)
          _ <- winner `W.race` loser
          (,) <$> W.readStateVar ranA <*> W.readStateVar ranB
        wf = W.provideWorkflow defaultCodec "schedStressBiselectChildFinalizers" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 60)
      useClient (C.execute wf.reference "schedStressBiselectChildFinalizers" opts) `shouldReturn` (True, True)

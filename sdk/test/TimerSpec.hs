module TimerSpec where

import Control.Exception (SomeException)
import qualified Control.Monad.Catch as Catch
import Data.Text (Text)
import Data.Time.Clock (UTCTime, diffUTCTime)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Exception
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


tests :: SpecWith TestEnv
tests = describe "Timers and Sleep" $ do
  describe "Sleep" $ do
    specify "sleep advances workflow time" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Bool
          workflow = do
            earlier <- W.now
            W.sleep $ nanoseconds 1
            later <- W.now
            pure (later > earlier)
          wf = W.provideWorkflow defaultCodec "sleepAdvances" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "sleep" opts) `shouldReturn` True

    specify "multiple sleeps accumulate time" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Int
          workflow = do
            t1 <- W.now
            W.sleep $ nanoseconds 1
            t2 <- W.now
            W.sleep $ nanoseconds 1
            t3 <- W.now
            let d1 = diffUTCTime t2 t1
                d2 = diffUTCTime t3 t2
            if d1 > 0 && d2 > 0 then pure 2 else pure 0
          wf = W.provideWorkflow defaultCodec "multiSleep" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "multiSleep" opts) `shouldReturn` 2

    specify "zero-duration sleep still advances activation" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Bool
          workflow = do
            t1 <- W.now
            W.sleep $ nanoseconds 0
            t2 <- W.now
            pure (t2 >= t1)
          wf = W.provideWorkflow defaultCodec "zeroSleep" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "zeroSleep" opts) `shouldReturn` True

  describe "Timer" $ do
    specify "timer fires and returns" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Bool
          workflow = do
            earlier <- W.now
            t <- W.createTimer $ nanoseconds 10
            mapM_ W.wait t
            later <- W.now
            pure (later > earlier)
          wf = W.provideWorkflow defaultCodec "timerFires" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "timer" opts) `shouldReturn` True

    specify "timer cancel immediately" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Bool
          workflow = do
            t <- W.createTimer $ nanoseconds 1
            mapM_ W.cancel t
            mapM_ W.wait t
            pure True
          wf = W.provideWorkflow defaultCodec "timerCancelImm" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
        useClient (C.execute wf . reference "timerCancelImm" opts) `shouldReturn` True

    specify "timer cancel with delay" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Bool
          workflow = do
            t <- W.createTimer $ seconds 5000
            W.sleep $ nanoseconds 1
            mapM_ W.cancel t
            mapM_ W.wait t
            pure True
          wf = W.provideWorkflow defaultCodec "timerCancelDelay" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
        useClient (C.execute wf . reference "timerCancelDelay" opts) `shouldReturn` True

    specify "multiple timers" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Int
          workflow = do
            t1 <- W.createTimer $ nanoseconds 1
            t2 <- W.createTimer $ nanoseconds 2
            mapM_ W.wait t1
            mapM_ W.wait t2
            pure 2
          wf = W.provideWorkflow defaultCodec "multiTimer" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "multiTimer" opts) `shouldReturn` 2

  describe "Deterministic Time" $ do
    specify "time is deterministic within activation" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow (UTCTime, UTCTime, UTCTime)
          workflow = do
            t1 <- W.now
            t2 <- W.now
            W.sleep $ nanoseconds 1
            t3 <- W.now
            pure (t1, t2, t3)
          wf = W.provideWorkflow defaultCodec "detTime" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        (t1, t2, t3) <- useClient (C.execute wf . reference "detTime" opts)
        t1 `shouldBe` t2
        t3 `shouldSatisfy` (> t2)

  describe "Race" $ do
    specify "race returns first to complete (left)" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow (Either Bool Bool)
          workflow = do
            let lhs :: MyWorkflow Bool
                lhs = W.sleep (seconds 5_000) >> pure False
                rhs :: MyWorkflow Bool
                rhs = pure True
            lhs `W.race` rhs
          wf = W.provideWorkflow defaultCodec "raceLeft" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "raceLeft" opts) `shouldReturn` Right True

    specify "race returns first to complete (both block)" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow (Either Bool Bool)
          workflow = do
            let lhs :: MyWorkflow Bool
                lhs = W.sleep (seconds 5_000) >> pure False
                rhs :: MyWorkflow Bool
                rhs = W.sleep (seconds 1) >> pure True
            lhs `W.race` rhs
          wf = W.provideWorkflow defaultCodec "raceBoth" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "raceBoth" opts) `shouldReturn` Right True

    specify "race throws when either side throws" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow (Either Bool Bool)
          workflow = do
            let lhs :: MyWorkflow Bool
                lhs = W.sleep (seconds 5_000) >> pure False
                rhs :: MyWorkflow Bool
                rhs = error "boom"
            lhs `W.race` rhs
          wf = W.provideWorkflow defaultCodec "raceThrow" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "raceThrow" opts)
          `shouldThrow` \case
            WorkflowExecutionFailed _ -> True
            _ -> False

    specify "race ignores rhs error when lhs returns first" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow (Either Bool Bool)
          workflow = pure True `W.race` (W.sleep (seconds 5_000) *> error "sad")
          wf = W.provideWorkflow defaultCodec "raceIgnore" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "raceIgnore" opts) `shouldReturn` Left True

    specify "concurrently_ runs both to completion" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow ()
          workflow = do
            st <- W.newStateVar False
            W.concurrently_ (W.waitCondition (W.readStateVar st)) (W.writeStateVar st True)
          wf = W.provideWorkflow defaultCodec "concurrently" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "concurrently" opts) `shouldReturn` ()

  describe "Trailing Timer (Py/TS equivalent)" $ do
    specify "timer created but never awaited - workflow still completes" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Int
          workflow = do
            _ <- W.createTimer $ seconds 5000
            pure 7
          wf = W.provideWorkflow defaultCodec "timerNeverAwaited" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "timerNeverAwaited" opts) `shouldReturn` 7

  describe "Timer edge cases (Py/TS equivalents)" $ do
    specify "zero duration sleep completes immediately (Py: test_timer_immediate)" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Text
          workflow = do
            W.sleep $ nanoseconds 0
            pure "immediate"
          wf = W.provideWorkflow defaultCodec "timerImmediate" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "timerImmediate" opts) `shouldReturn` "immediate"

    specify "sequential timers complete in order (Py: test_timer_sequence)" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow [Int]
          workflow = do
            st <- W.newStateVar ([] :: [Int])
            W.sleep $ nanoseconds 1
            W.modifyStateVar st (1 :)
            W.sleep $ nanoseconds 1
            W.modifyStateVar st (2 :)
            W.sleep $ nanoseconds 1
            W.modifyStateVar st (3 :)
            reverse <$> W.readStateVar st
          wf = W.provideWorkflow defaultCodec "timerSequence" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "timerSequence" opts) `shouldReturn` [1, 2, 3]

    specify "race between two timers - shorter wins (TS: timer race)" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow (Either Text Text)
          workflow =
            (W.sleep (nanoseconds 1) >> pure "fast") `W.race` (W.sleep (minutes 100) >> pure "slow")
          wf = W.provideWorkflow defaultCodec "timerRace" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
        useClient (C.execute wf . reference "timerRace" opts) `shouldReturn` Left "fast"

    specify "timer in catch handler works (TS: timer-in-handler)" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow Text
          workflow = do
            Catch.catch
              (error "boom" :: MyWorkflow Text)
              ( \(_ :: SomeException) -> do
                  W.sleep $ nanoseconds 1
                  pure "recovered"
              )
          wf = W.provideWorkflow defaultCodec "timerInCatch" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOpts taskQueue
        useClient (C.execute wf . reference "timerInCatch" opts) `shouldReturn` "recovered"

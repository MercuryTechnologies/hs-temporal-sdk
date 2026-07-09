module InflightSpec where

import Control.Exception (SomeException)
import qualified Control.Monad.Catch as Catch
import Data.Either (isLeft, isRight)
import Data.List (sort)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Worker
import qualified Temporal.Workflow as W
import qualified Temporal.Workflow.Internal.Inflight as Inflight
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


-- | Drains an 'Inflight' to empty, collecting each result in the order 'next'
-- returns them.
drainAll :: W.RequireCallStack => Inflight.Inflight a -> W.Workflow [Either SomeException a]
drainAll inf = do
  m <- Inflight.next inf
  case m of
    Nothing -> pure []
    Just (r, inf') -> (r :) <$> drainAll inf'


-- | Runs the sources with at most @n@ actions in flight, pushing a replacement
-- after each completion.
boundedDrain :: W.RequireCallStack => Int -> [W.Workflow a] -> W.Workflow [Either SomeException a]
boundedDrain n sources0 = do
  let (initial, rest0) = splitAt n sources0
  inf0 <- Inflight.fromFoldable initial
  go inf0 rest0
  where
    go inf rest = do
      m <- Inflight.next inf
      case m of
        Nothing -> pure []
        Just (r, inf') -> do
          (inf'', rest') <- case rest of
            [] -> pure (inf', [])
            s : ss -> do
              inf'' <- Inflight.push inf' s
              pure (inf'', ss)
          (r :) <$> go inf'' rest'


-- | Sleeps for the given duration, then returns the label.
timerAction :: W.RequireCallStack => Duration -> Text -> W.Workflow Text
timerAction d label = do
  mt <- W.createTimer d
  mapM_ W.wait mt
  pure label


-- | An action that issues a command (a second timer) after its first
-- suspension. If 'Inflight.next' re-ran a held member from the top instead of
-- resuming it, the second 'createTimer' would be issued again on a later round
-- and desync the workflow.
twoPhaseTimer :: W.RequireCallStack => Text -> W.Workflow Text
twoPhaseTimer label = do
  mt1 <- W.createTimer (milliseconds 40)
  mapM_ W.wait mt1
  mt2 <- W.createTimer (milliseconds 40)
  mapM_ W.wait mt2
  pure label


-- | Throws a workflow-level exception, which 'next' returns as 'Left'.
failing :: W.RequireCallStack => W.Workflow Text
failing = Catch.throwM (userError "boom")


rightsOf :: [Either e a] -> [a]
rightsOf rs = [x | Right x <- rs]


tests :: SpecWith TestEnv
tests = describe "Inflight" $ do
  specify "next on an empty collection returns Nothing" $ \TestEnv {..} -> do
    let workflow :: MyWorkflow Bool
        workflow = do
          m <- Inflight.next (Inflight.empty :: Inflight.Inflight ())
          pure $ case m of
            Nothing -> True
            Just _ -> False
        wf = W.provideWorkflow defaultCodec "inflightEmpty" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      useClient (C.execute wf.reference "inflightEmpty" opts) `shouldReturn` True

  specify "harvests in completion order, not push order" $ \TestEnv {..} -> do
    -- "third" is pushed first but takes two timer rounds to finish, so the two
    -- single-round members overtake it.
    let workflow :: MyWorkflow [Text]
        workflow = do
          inf <-
            Inflight.fromFoldable
              [ twoPhaseTimer "third"
              , timerAction (milliseconds 40) "first"
              , timerAction (milliseconds 40) "second"
              ]
          rightsOf <$> drainAll inf
        wf = W.provideWorkflow defaultCodec "inflightOrder" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      useClient (C.execute wf.reference "inflightOrder" opts) `shouldReturn` ["first", "second", "third"]

  specify "leftmost member wins a simultaneous completion" $ \TestEnv {..} -> do
    let workflow :: MyWorkflow [Text]
        workflow = do
          inf <-
            Inflight.fromFoldable
              [ timerAction (milliseconds 100) "L"
              , timerAction (milliseconds 100) "R"
              ]
          rightsOf <$> drainAll inf
        wf = W.provideWorkflow defaultCodec "inflightTie" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      useClient (C.execute wf.reference "inflightTie" opts) `shouldReturn` ["L", "R"]

  specify "bounded drain (cap 2) returns every source" $ \TestEnv {..} -> do
    let workflow :: MyWorkflow [Text]
        workflow =
          sort . rightsOf
            <$> boundedDrain
              2
              [ timerAction d (T.pack (show i))
              | (i, d) <-
                  zip
                    [(0 :: Int) ..]
                    [milliseconds 100, milliseconds 200, milliseconds 150, milliseconds 250, milliseconds 120]
              ]
        wf = W.provideWorkflow defaultCodec "inflightBounded" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      useClient (C.execute wf.reference "inflightBounded" opts) `shouldReturn` ["0", "1", "2", "3", "4"]

  specify "held members are resumed, not re-run (no command re-issue)" $ \TestEnv {..} -> do
    let workflow :: MyWorkflow [Text]
        workflow = do
          inf <-
            Inflight.fromFoldable
              [ twoPhaseTimer "slow"
              , timerAction (milliseconds 20) "fast1"
              , timerAction (milliseconds 30) "fast2"
              ]
          sort . rightsOf <$> drainAll inf
        wf = W.provideWorkflow defaultCodec "inflightResume" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      useClient (C.execute wf.reference "inflightResume" opts) `shouldReturn` ["fast1", "fast2", "slow"]

  specify "a failing member yields Left and the drain continues" $ \TestEnv {..} -> do
    let workflow :: MyWorkflow (Bool, Bool, Int)
        workflow = do
          inf <- Inflight.fromFoldable [failing, timerAction (milliseconds 50) "ok"]
          rs <- drainAll inf
          pure (any isLeft rs, any isRight rs, length rs)
        wf = W.provideWorkflow defaultCodec "inflightFailing" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      useClient (C.execute wf.reference "inflightFailing" opts) `shouldReturn` (True, True, 2)

  specify "a thrown member is returned ahead of an earlier completed one" $ \TestEnv {..} -> do
    -- Element 1 throws while elements 0 and 2 complete. Fail-fast means the
    -- throw is returned first, ahead of the already-completed element 0.
    let workflow :: MyWorkflow Text
        workflow = do
          inf <- Inflight.fromFoldable [pure "a", failing, pure "c"]
          m <- Inflight.next inf
          pure $ case m of
            Just (Left _, _) -> "thrown-first"
            Just (Right r, _) -> "done-first:" <> r
            Nothing -> "empty"
        wf = W.provideWorkflow defaultCodec "inflightThrownFirst" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      useClient (C.execute wf.reference "inflightThrownFirst" opts) `shouldReturn` "thrown-first"

  specify "multiple members completing in one activation each return once, in order" $ \TestEnv {..} -> do
    let workflow :: MyWorkflow [Text]
        workflow = do
          inf <- Inflight.fromFoldable [timerAction (milliseconds 100) (T.pack (show i)) | i <- [(0 :: Int) .. 3]]
          rightsOf <$> drainAll inf
        wf = W.provideWorkflow defaultCodec "inflightMultiFill" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      useClient (C.execute wf.reference "inflightMultiFill" opts) `shouldReturn` ["0", "1", "2", "3"]

  specify "an Inflight drained as a race loser is cancelled and runs finalizers" $ \TestEnv {..} -> do
    -- The loser blocks in 'next' on two never-firing members; the winner wins
    -- immediately, so the loser is cancelled while suspended in the drain. The
    -- cancellation must reach 'next' and unwind through 'finally'.
    let workflow :: MyWorkflow (Text, Bool)
        workflow = do
          st <- W.newStateVar False
          r <-
            W.race
              (pure "win" :: W.Workflow Text)
              ( Catch.finally
                  ( do
                      inf <- Inflight.fromFoldable [timerAction (minutes 100) "a", timerAction (minutes 100) "b"]
                      T.concat . rightsOf <$> drainAll inf
                  )
                  (W.writeStateVar st True)
              )
          ran <- W.readStateVar st
          pure (either id id r, ran)
        wf = W.provideWorkflow defaultCodec "inflightRaceLoser" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      useClient (C.execute wf.reference "inflightRaceLoser" opts) `shouldReturn` ("win", True)

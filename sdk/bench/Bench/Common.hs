{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

-- | Shared configuration for the perf benchmarks: the Rust-core runtime, the
-- parameterized benchmark workflow, and the worker config used for BOTH
-- recording (against a dev server) and replay (server-free). The workflow name
-- and codec must be identical across record + replay for replay to succeed, so
-- both paths go through 'benchWorkerConfig'.
module Bench.Common (
  benchRuntime,
  benchWorkflow,
  fanoutParentWorkflow,
  benchWorkerConfig,
  -- * Fixture manifest (single source of truth)
  Family (..),
  benchFixtures,
  familyGroup,
  fixtureKey,
  fixturePathFor,
  fixtureWfId,
  -- * Lower-level path/id helpers (used by the manifest helpers above)
  fixtureDir,
  fixturePath,
  fanoutFixturePath,
  seqWfId,
  fanoutWfId,
  fixtureNs,
) where

import Control.Monad (replicateM_)
import qualified Data.Text as T
import RequireCallStack (provideCallStack)
import System.IO.Unsafe (unsafePerformIO)
import Temporal.Duration (milliseconds)
import Temporal.Payload (JSON (..))
import Temporal.Runtime (Runtime, TelemetryOptions (..), initializeRuntime)
import Temporal.Worker
import qualified Temporal.Workflow as W


-- | One shared Rust-core runtime for the whole process (mirrors the test suite's
-- @globalRuntime@). No telemetry, no server — just the core.
benchRuntime :: Runtime
benchRuntime = unsafePerformIO $ initializeRuntime NoTelemetry
{-# NOINLINE benchRuntime #-}


-- | The benchmark workflow: perform @n@ sequential 1ms timer sleeps. Each timer
-- fire is a separate workflow task, so replaying an @n@-sleep history drives
-- @n@ activations through the Haskell dispatch/apply path — the per-activation
-- macro signal (opportunities #1 dispatch specialization, #2 logging, #4 Info
-- rebuild). NB: sequential sleeps do NOT stress the O(n) run queue (#6); that
-- needs a concurrent-fibers variant, added separately for the Tier-B sweep.
benchWorkflow :: W.ProvidedWorkflow (Int -> W.Workflow ())
benchWorkflow =
  W.provideWorkflow JSON "bench-sleeps-seq" $ \(n :: Int) ->
    provideCallStack $ replicateM_ n (W.sleep (milliseconds 1))


-- | Leaf child workflow: completes immediately (~1 workflow task). Takes an
-- index arg (ignored) so the parent keys each child by position. Its internals
-- are irrelevant to the parent fan-out benchmark — on replay the parent's child
-- results come from recorded history, not from re-running the child. (A
-- with-activity leaf is a separate fixture for child-create cost, if wanted.)
fanoutLeafWorkflow :: W.ProvidedWorkflow (Int -> W.Workflow ())
fanoutLeafWorkflow =
  W.provideWorkflow JSON "bench-fanout-leaf" $ \(_i :: Int) ->
    provideCallStack (pure ())


-- | Fan-out parent: start @c@ leaf children concurrently and await all of them.
-- On replay this holds up to @c@ simultaneously blocked fibers in the run queue
-- (each parked in 'waitChildWorkflowResult'), which is the concurrent-scheduler
-- stress the sequential 'benchWorkflow' deliberately avoids — the vehicle for the
-- O(n) run-queue behavior (#6). Child IDs use the default deterministic uuid4 from
-- the workflow RNG (replay-safe, unique within/across runs).
fanoutParentWorkflow :: W.ProvidedWorkflow (Int -> W.Workflow ())
fanoutParentWorkflow =
  W.provideWorkflow JSON "bench-fanout-parent" $ \(c :: Int) ->
    provideCallStack $
      W.forConcurrently_ [1 .. c] $ \i ->
        W.executeChildWorkflow fanoutLeafWorkflow.reference W.defaultChildWorkflowOptions i


fixtureNs :: W.Namespace
fixtureNs = W.Namespace "default"


-- | Every workflow the bench worker registers. Homogeneous list (all are
-- @ProvidedWorkflow (Int -> Workflow ())@) folded into 'Definitions' via
-- 'toDefinitions' — adding a workflow is a list append, not a wider tuple.
benchWorkflows :: [W.ProvidedWorkflow (Int -> W.Workflow ())]
benchWorkflows = [benchWorkflow, fanoutParentWorkflow, fanoutLeafWorkflow]


-- | All bench definitions, combined monoidally into a single 'Definitions'.
-- Each family is folded in via 'toDefinitions' and @<>@, so workflows and
-- (later) activities can be declared in their own homogeneous lists and merged
-- — no fixed-arity tuple, no shared element type required. The @()@ pins the
-- otherwise-ambiguous @env@.
benchDefs :: Definitions ()
benchDefs = foldMap toDefinitions benchWorkflows


-- | Worker config registering every bench definition. All are needed to RECORD
-- (parent + leaf run on the same worker); for REPLAY only the history's own
-- workflow is exercised, but one shared config keeps record and replay identical.
benchWorkerConfig :: W.TaskQueue -> WorkerConfig ()
benchWorkerConfig tq =
  configure () benchDefs $ do
    setNamespace fixtureNs
    setTaskQueue tq
    -- Discarding logger: message *construction* still runs (that's the cost
    -- opportunity #2 targets), but nothing is written, keeping bench output clean.
    setLogger (\_ _ _ _ -> pure ())


-- | Where checked-in history fixtures live. Relative to the repo root, which is
-- @cabal run@'s working directory, so both the recorder and the benchmark
-- resolve the same path when invoked via cabal from the project root.
fixtureDir :: FilePath
fixtureDir = "sdk/bench/fixtures"


-- | Fixture file for an @n@-sleep history.
fixturePath :: Int -> FilePath
fixturePath n = fixtureDir <> "/sleeps-" <> show n <> ".history.bin"


-- | Fixture file for a @c@-way fan-out parent history.
fanoutFixturePath :: Int -> FilePath
fanoutFixturePath c = fixtureDir <> "/fanout-" <> show c <> ".history.bin"


-- | Workflow IDs used at record time. Replay via @runReplayHistoryProto@ pushes
-- pre-encoded history bytes keyed by workflow ID, so it must pass the SAME ID the
-- history was recorded under — hence these live here as the single source of
-- truth shared by the recorder and the benchmark.
seqWfId :: Int -> W.WorkflowId
seqWfId n = W.WorkflowId ("bench-sleeps-" <> T.pack (show n))


fanoutWfId :: Int -> W.WorkflowId
fanoutWfId c = W.WorkflowId ("bench-fanout-" <> T.pack (show c))


-- | Which parameterized workflow a fixture exercises. 'Sleeps' is the sequential
-- state-machine archetype (N serial timer activations); 'Fanout' is the
-- concurrent-scheduler archetype (C children awaited at once).
data Family = Sleeps | Fanout
  deriving stock (Eq, Show)


-- | The single source of truth for which fixtures exist. Both the recorder
-- (which produces the @.history.bin@ files against a dev server) and the
-- benchmark (which replays them server-free) derive their work lists from this
-- one manifest, so record and replay can never drift out of sync — there is no
-- second list to keep matched by hand.
--
-- Size rationale (do not raise blindly):
--   * 'Sleeps' is capped at 100 — recording sequential 1ms timers costs ~1s of
--     dev-server wall-clock per timer round-trip, so n=1000 would take ~20min and
--     exceed the workflow run timeout. Larger activation counts belong to 'Fanout'
--     (many activations without N serial round-trips).
--   * 'Fanout' parents + children share one task queue, so a large @c@ contends
--     for the worker's workflow-task slots — raise only after checking record time.
benchFixtures :: [(Family, Int)]
benchFixtures =
  [(Sleeps, n) | n <- [1, 10, 100]]
    <> [(Fanout, c) | c <- [10, 50, 100, 200, 500, 1000]]


-- | The tasty-bench group name for a family. This is the token that appears in
-- the benchmark CSV @Name@ column (@All.replay\/\<group\>.\<size\>@) and in the
-- one-shot CSV @family@ column, so the report can join the two. Must stay stable:
-- changing it invalidates existing baselines.
familyGroup :: Family -> String
familyGroup Sleeps = "sleeps-seq"
familyGroup Fanout = "fanout-conc"


-- | Stable short key for a fixture (@"sleeps-100"@ / @"fanout-1000"@). Used as
-- the @BENCH_PROFILE@ selector and as the on-disk fixture filename stem.
fixtureKey :: Family -> Int -> String
fixtureKey Sleeps n = "sleeps-" <> show n
fixtureKey Fanout c = "fanout-" <> show c


-- | On-disk fixture path for a manifest entry.
fixturePathFor :: Family -> Int -> FilePath
fixturePathFor Sleeps n = fixturePath n
fixturePathFor Fanout c = fanoutFixturePath c


-- | Workflow ID a manifest entry was recorded under. Replay must push history
-- bytes keyed by the SAME id the history was recorded with.
fixtureWfId :: Family -> Int -> W.WorkflowId
fixtureWfId Sleeps n = seqWfId n
fixtureWfId Fanout c = fanoutWfId c

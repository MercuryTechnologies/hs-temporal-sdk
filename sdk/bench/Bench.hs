{-# LANGUAGE OverloadedStrings #-}

-- | Replay-driven macro benchmark. Loads checked-in history fixtures and
-- replays each through the full Haskell workflow dispatch/apply path via
-- 'runReplayHistoryProto' (server-free — history is fed into the in-process
-- core as pre-encoded bytes, no per-call re-encode).
--
-- tasty-bench reports allocations (run with @+RTS -T@, set in the stanza), which
-- is our primary metric. A one-shot GHC.Stats allocation figure is also printed
-- per fixture so we get a clean bytes-per-replay number alongside the amortized
-- tasty-bench mean; set @BENCH_ONESHOT_CSV@ to also emit those figures as CSV.
--
-- Drive this via @scripts/perf/bench.sh@ rather than by hand. Raw form:
--   cabal run -v0 --project-file=cabal.project.bench temporal-sdk-bench -- \
--     --csv perf-out/runs/<id>/bench.csv
module Main (main) where

import Control.Monad (forM, forM_, replicateM_)
import qualified Data.ByteString as BS
import Data.Maybe (catMaybes)
import qualified Data.Text as T
import System.Directory (doesFileExist)
import System.Environment (lookupEnv)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)
import Temporal.Replay (readHistoryProtobufFileRaw)
import Temporal.Worker (ReplayHistoryFailure (..), runReplayHistoryProto)
import qualified Temporal.Workflow as W
import Test.Tasty (localOption)
import Test.Tasty.Bench
import Text.Read (readMaybe)

import Bench.Common
import Bench.Stats (withAllocatedBytes)


-- | A fixture loaded into memory, ready to replay.
data Loaded = Loaded
  { loadedFamily :: Family
  , loadedSize :: Int
  , loadedWfId :: W.WorkflowId
  , loadedBytes :: BS.ByteString
  }


-- | Replay one history (pre-encoded protobuf bytes) to completion, failing
-- loudly if the workflow is not replay-compatible (so a broken fixture can't
-- masquerade as a fast benchmark). Uses 'runReplayHistoryProto' with the raw
-- on-disk bytes so we do NOT re-encode the whole history per call — that
-- per-replay 'encodeMessage' was a harness artifact that dominated allocation
-- (proto-lens 'runBuilder') and inflated the per-activation numbers.
replay :: W.WorkflowId -> BS.ByteString -> IO ()
replay wfId bytes = do
  res <- runReplayHistoryProto benchRuntime (benchWorkerConfig (W.TaskQueue "bench-tq")) wfId bytes
  either (\e -> error ("replay failed: " <> T.unpack e.message)) pure res


-- | Load a manifest entry, or 'Nothing' (with a note) if its fixture is missing.
loadFixture :: (Family, Int) -> IO (Maybe Loaded)
loadFixture (fam, n) = do
  let fp = fixturePathFor fam n
  exists <- doesFileExist fp
  if exists
    then do
      bytes <- readHistoryProtobufFileRaw fp
      pure (Just (Loaded fam n (fixtureWfId fam n) bytes))
    else do
      hPutStrLn stderr ("  (missing fixture " <> fp <> " — run scripts/perf/record-fixtures.sh)")
      pure Nothing


main :: IO ()
main = do
  mkey <- lookupEnv "BENCH_PROFILE"
  case mkey >>= parseProfileKey of
    Just (fam, n) -> profileOne fam n
    Nothing -> runBenchmarks


-- | Parse a @BENCH_PROFILE@ key like "sleeps-100" / "fanout-1000".
parseProfileKey :: String -> Maybe (Family, Int)
parseProfileKey s = case break (== '-') s of
  ("sleeps", '-' : num) -> (,) Sleeps <$> readMaybe num
  ("fanout", '-' : num) -> (,) Fanout <$> readMaybe num
  _ -> Nothing


-- | Isolated single-fixture profiling run: bypasses tasty and the multi-fixture
-- one-shot so a cost-centre profile attributes only this fixture's replay.
profileOne :: Family -> Int -> IO ()
profileOne fam n = do
  mf <- loadFixture (fam, n)
  case mf of
    Just l -> replicateM_ 5 (replay (loadedWfId l) (loadedBytes l)) >> putStrLn ("profiled fixture: " <> fixtureKey fam n)
    Nothing -> error ("profile fixture missing: " <> fixtureKey fam n)


runBenchmarks :: IO ()
runBenchmarks = do
  loaded <- catMaybes <$> forM benchFixtures loadFixture
  if null loaded
    then do
      -- Exit nonzero so a CI gate can't pass vacuously when fixtures are absent
      -- (e.g. invoked from the wrong cwd — fixtureDir is repo-root-relative).
      hPutStrLn stderr "No history fixtures found. Run: scripts/perf/record-fixtures.sh"
      exitFailure
    else do
      -- One-shot allocation snapshot per fixture (clean bytes-per-replay).
      putStrLn "== one-shot allocation per replay (GHC.Stats) =="
      oneshotRows <- forM loaded $ \l -> do
        (_, allocd) <- withAllocatedBytes (replay (loadedWfId l) (loadedBytes l))
        putStrLn ("  " <> familyGroup (loadedFamily l) <> " size=" <> show (loadedSize l) <> "  allocated=" <> show allocd <> " bytes")
        pure (familyGroup (loadedFamily l), loadedSize l, allocd)
      -- Emit the deterministic one-shot figures as CSV when asked (report join
      -- key is family+size, matching the tasty Name the report parses).
      mcsv <- lookupEnv "BENCH_ONESHOT_CSV"
      forM_ mcsv $ \path ->
        writeFile path $
          unlines
            ( "family,size,allocated_bytes"
                : [fam <> "," <> show sz <> "," <> show a | (fam, sz, a) <- oneshotRows]
            )
      -- tasty-bench run (reports allocations with +RTS -T). Each `replay` spins
      -- up and tears down a full core replay worker, so it is NOT a cheap
      -- repeatable action: tasty's adaptive loop would keep doubling iterations
      -- chasing a stdev target and churn workers until the core blocks. Force it
      -- to accept the first measurement (RelStDev 100) so worker count stays
      -- bounded. Consequence: reported *times* are noisy — allocation (our metric)
      -- is deterministic regardless. Group names must stay stable (baselines key
      -- on them): see 'familyGroup'.
      let benchesFor fam =
            [bench (show (loadedSize l)) (whnfIO (replay (loadedWfId l) (loadedBytes l))) | l <- loaded, loadedFamily l == fam]
      defaultMain
        [ localOption (RelStDev 100) $ bgroup "replay/sleeps-seq" (benchesFor Sleeps)
        , localOption (RelStDev 100) $ bgroup "replay/fanout-conc" (benchesFor Fanout)
        ]

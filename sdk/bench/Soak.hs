{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

-- | Soak / leak-detection harness. Runs a long-lived REAL worker against a local
-- ephemeral dev server, firing many DISTINCT workflow executions (mixing the
-- 'Outbox' and 'Sync' archetypes, both calling a real activity) and sampling
-- residency over time. Unlike the replay benchmark this exercises the full
-- poll → execute → complete → evict path — the surface where a production leak
-- (Haskell state keyed by runId not pruned on eviction) would live.
--
-- Primary signal: Haskell-heap live bytes (post-GC) vs executions_done — a leak
-- shows as a positive slope. Process RSS is sampled alongside (advisory) to catch
-- native/Rust-core retention the Haskell heap can't see.
--
-- Drive via @scripts/perf/soak.sh@; it computes the slope/verdict from the
-- emitted @residency.csv@. Needs a @temporal@ dev server on PATH.
module Main (main) where

import Control.Concurrent (getNumCapabilities)
import Control.Concurrent.STM (TChan, atomically, tryReadTChan)
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Monad.Reader (runReaderT)
import Data.Char (isSpace)
import Data.IORef (IORef, atomicModifyIORef', newIORef)
import qualified Data.Map.Strict as Map
import qualified Data.Text as T
import Data.Word (Word64)
import GHC.Clock (getMonotonicTimeNSec)
import System.Directory (createDirectoryIfMissing, findExecutable)
import System.Environment (getArgs)
import System.Posix.Process (getProcessID)
import System.Posix.Types (ProcessID)
import System.Process (readProcess)
import Text.Read (readMaybe)

import Temporal.Client (StartWorkflowOptions (..), TimeoutOptions (..))
import qualified Temporal.Client as C
import Temporal.Core.Client (ClientConfig (..), connectClient, defaultClientConfig)
import Temporal.Duration (seconds)
import Temporal.EphemeralServer
import qualified Temporal.EphemeralServer as DevCfg (TemporalDevServerConfig (..))
import Temporal.Worker (shutdown, startWorker, subscribeToEvictions)
import qualified Temporal.Workflow as W
import UnliftIO (bracket, tryAny)
import UnliftIO.Async (pooledMapConcurrentlyN_)

import Bench.Common (benchRuntime, fixtureNs)
import Bench.Stats (ResidencySample (..), sampleResidency)
import Soak.Workload (Archetype (..), OutboxWorkflow (..), SyncWorkflow (..), TimerWorkflow (..), soakWorkerConfig)


-- | How a run is bounded (mutually exclusive; iterations is the default).
data Mode = Iterations !Int | Duration !Int -- ^ Duration in seconds.


data Args = Args
  { aMode :: !Mode
  , aConcurrency :: !Int
  , aSampleEvery :: !Int
  , aWarmup :: !Int
  , aMaxCached :: !Word64
  , aOutboxK :: !Int
  , aFanoutC :: !Int
  , aRatio :: !Int
  -- ^ Outbox:Sync ratio — @r@ means @r@ outbox executions per 1 sync.
  , aTimer :: !Bool
  -- ^ When set, every execution uses the timer archetype (K sequential sleeps,
  -- no activities) — the resolution-path discriminator.
  , aOutDir :: !FilePath
  }


main :: IO ()
main = do
  args <- parseArgs
  createDirectoryIfMissing True (aOutDir args)
  caps <- getNumCapabilities
  writeParamsJson args caps
  temporalPath <-
    findExecutable "temporal"
      >>= maybe (error "Could not find the 'temporal' executable in PATH") pure
  port <- getFreePort
  let serverConf =
        defaultTemporalDevServerConfig
          { DevCfg.port = Just (fromIntegral port)
          , DevCfg.exe = ExistingPath temporalPath
          }
  withDevServer benchRuntime serverConf $ \_ -> do
    let clientConf = defaultClientConfig {targetUrl = "http://localhost:" <> T.pack (show port)}
    coreClient <- runStdoutLoggingT (connectClient benchRuntime clientConf)
    wfClient <- C.workflowClient coreClient (C.mkWorkflowClientConfig fixtureNs)
    let tq = W.TaskQueue "soak-tq"
    bracket (startWorker coreClient (soakWorkerConfig (aMaxCached args) tq)) shutdown $ \worker -> do
      -- Subscribe BEFORE warmup: the dup channel only sees evictions written
      -- after subscription, and anything written to it is retained on the heap
      -- until drained — so we drain fully at every sample (below).
      evChan <- subscribeToEvictions worker
      pid <- getProcessID
      let csvPath = aOutDir args <> "/residency.csv"
      writeFile csvPath "elapsed_ms,executions_done,live_bytes,max_live_bytes,rts_mem_in_use_bytes,rss_bytes,evictions\n"
      idRef <- newIORef (0 :: Int)
      -- Warmup fills the cache to steady state; not sampled.
      runBatch wfClient tq args idRef (aWarmup args)
      startNs <- getMonotonicTimeNSec
      -- Baseline sample at executions_done = 0 (post-warmup steady state).
      evAcc0 <- takeSample csvPath pid startNs evChan 0 0
      loop args wfClient tq idRef evChan csvPath pid startNs 0 evAcc0
  putStrLn "soak complete"


-- | Run one batch of @count@ executions at bounded concurrency. Results are
-- discarded (@pooledMapConcurrentlyN_@) so nothing per-execution is retained.
runBatch :: C.WorkflowClient -> W.TaskQueue -> Args -> IORef Int -> Int -> IO ()
runBatch wfClient tq args idRef count = do
  base <- atomicModifyIORef' idRef (\x -> (x + count, x))
  pooledMapConcurrentlyN_ (aConcurrency args) (runOne wfClient tq args) [base .. base + count - 1]


-- | Fire one execution: pick the archetype by index, start + await it under a
-- unique workflow id.
runOne :: C.WorkflowClient -> W.TaskQueue -> Args -> Int -> IO ()
runOne wfClient tq args i = do
  let opts =
        (C.startWorkflowOptions tq)
          { workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
          , timeouts =
              TimeoutOptions
                { runTimeout = Just (seconds 120)
                , executionTimeout = Nothing
                , taskTimeout = Nothing
                }
          }
  case archetypeFor args i of
    Sync -> do
      h <- runReaderT (C.start SyncWorkflow (W.WorkflowId ("soak-sync-" <> T.pack (show i))) opts (aFanoutC args)) wfClient
      C.waitWorkflowResult h
    Outbox -> do
      h <- runReaderT (C.start OutboxWorkflow (W.WorkflowId ("soak-outbox-" <> T.pack (show i))) opts (aOutboxK args)) wfClient
      C.waitWorkflowResult h
    Timer -> do
      h <- runReaderT (C.start TimerWorkflow (W.WorkflowId ("soak-timer-" <> T.pack (show i))) opts (aOutboxK args)) wfClient
      C.waitWorkflowResult h


-- | Archetype for execution @i@: 1 sync per @ratio@ outbox (period @ratio+1@).
archetypeFor :: Args -> Int -> Archetype
archetypeFor args i
  | aTimer args = Timer
  | (i `mod` (aRatio args + 1)) == aRatio args = Sync
  | otherwise = Outbox


-- | The churn loop: batch → sample → repeat, until the mode's bound is hit.
loop :: Args -> C.WorkflowClient -> W.TaskQueue -> IORef Int -> TChan a -> FilePath -> ProcessID -> Word64 -> Int -> Word64 -> IO ()
loop args wfClient tq idRef evChan csvPath pid startNs = go
  where
    go done evAcc = do
      stop <- case aMode args of
        Iterations n -> pure (done >= n)
        Duration secs -> do
          nowNs <- getMonotonicTimeNSec
          pure ((nowNs - startNs) `div` 1_000_000_000 >= fromIntegral secs)
      if stop
        then pure ()
        else do
          runBatch wfClient tq args idRef (aSampleEvery args)
          let done' = done + aSampleEvery args
          evAcc' <- takeSample csvPath pid startNs evChan evAcc done'
          go done' evAcc'


-- | Drain evictions (frees the retained channel items), then GC + sample live
-- bytes so those items are actually collected, then RSS + elapsed; append one
-- row. Returns the updated cumulative eviction count.
takeSample :: FilePath -> ProcessID -> Word64 -> TChan a -> Word64 -> Int -> IO Word64
takeSample csvPath pid startNs evChan evAcc done = do
  evAcc' <- drainEvictions evChan evAcc
  rs <- sampleResidency
  mrss <- sampleRSSBytes pid
  nowNs <- getMonotonicTimeNSec
  let elapsedMs = (nowNs - startNs) `div` 1_000_000
      rssStr = maybe "" show mrss
      row =
        show elapsedMs
          <> "," <> show done
          <> "," <> show (rsLiveBytes rs)
          <> "," <> show (rsMaxLiveBytes rs)
          <> "," <> show (rsMemInUseBytes rs)
          <> "," <> rssStr
          <> "," <> show evAcc'
          <> "\n"
  appendFile csvPath row
  pure evAcc'


-- | Fully drain a TChan, counting entries (cumulative from @acc@).
drainEvictions :: TChan a -> Word64 -> IO Word64
drainEvictions ch = go
  where
    go !acc = do
      m <- atomically (tryReadTChan ch)
      case m of
        Nothing -> pure acc
        Just _ -> go (acc + 1)


-- | Current process RSS in bytes via @ps@ (portable on macOS/Linux). @ps@ reports
-- KiB. 'Nothing' if the shell-out fails or is unavailable (e.g. a sandbox that
-- denies @ps@ the RSS field) — RSS is advisory, never fatal. @ps@ stderr is
-- redirected so a denied field doesn't spam the run log.
sampleRSSBytes :: ProcessID -> IO (Maybe Word64)
sampleRSSBytes pid = do
  res <- tryAny (readProcess "sh" ["-c", "ps -o rss= -p " <> show pid <> " 2>/dev/null"] "")
  pure $ case res of
    Left _ -> Nothing
    Right out -> (\kb -> kb * 1024) <$> readMaybe (filter (not . isSpace) out)


-- | Record resolved parameters (incl. capability count) so a run is comparable
-- across commits. Written alongside residency.csv; the report refuses to compare
-- runs whose params differ.
writeParamsJson :: Args -> Int -> IO ()
writeParamsJson args caps = writeFile (aOutDir args <> "/params.json") json
  where
    (modeName, modeVal) = case aMode args of
      Iterations n -> ("iterations" :: String, n)
      Duration s -> ("duration_seconds", s)
    json =
      unlines
        [ "{"
        , "  \"mode\": \"" <> modeName <> "\","
        , "  \"mode_value\": " <> show modeVal <> ","
        , "  \"concurrency\": " <> show (aConcurrency args) <> ","
        , "  \"sample_every\": " <> show (aSampleEvery args) <> ","
        , "  \"warmup\": " <> show (aWarmup args) <> ","
        , "  \"max_cached\": " <> show (aMaxCached args) <> ","
        , "  \"outbox_k\": " <> show (aOutboxK args) <> ","
        , "  \"fanout_c\": " <> show (aFanoutC args) <> ","
        , "  \"ratio\": " <> show (aRatio args) <> ","
        , "  \"timer\": " <> (if aTimer args then "true" else "false") <> ","
        , "  \"capabilities\": " <> show caps
        , "}"
        ]


-- | Parse @--key value@ args with defaults. Warmup defaults to @max(128, 4×cache)@
-- so the cache is fully populated and churning before the baseline sample.
parseArgs :: IO Args
parseArgs = do
  m <- Map.fromList . pairs <$> getArgs
  let lk = flip Map.lookup m
      readOr :: (Read a) => a -> String -> a
      readOr d k = maybe d (\s -> maybe d id (readMaybe s)) (lk k)
      maxCached :: Word64
      maxCached = readOr 32 "--max-cached"
      mode = case (lk "--duration", lk "--iterations") of
        (Just d, _) -> Duration (maybe 600 id (readMaybe d))
        (_, Just n) -> Iterations (maybe 5000 id (readMaybe n))
        _ -> Iterations 5000
      warmup = case lk "--warmup" >>= readMaybe of
        Just w -> w
        Nothing -> max 128 (4 * fromIntegral maxCached)
  pure
    Args
      { aMode = mode
      , aConcurrency = readOr 16 "--concurrency"
      , aSampleEvery = readOr 200 "--sample-every"
      , aWarmup = warmup
      , aMaxCached = maxCached
      , aOutboxK = readOr 5 "--outbox-k"
      , aFanoutC = readOr 8 "--fanout-c"
      , aRatio = readOr 3 "--ratio"
      , aTimer = maybe False (const True) (lk "--timer")
      , aOutDir = maybe "perf-out/soak/adhoc" id (lk "--out")
      }
  where
    pairs (k : v : rest) = (k, v) : pairs rest
    pairs _ = []

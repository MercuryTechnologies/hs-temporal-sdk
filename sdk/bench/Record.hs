{-# LANGUAGE OverloadedStrings #-}

-- | One-time fixture recorder. Spins up a local @temporal@ dev server (found on
-- PATH), runs each workflow in the 'benchFixtures' manifest, fetches the
-- resulting event history, and writes it to @sdk/bench/fixtures/<key>.history.bin@.
--
-- Run occasionally (needs the dev server); commit the resulting fixtures. The
-- benchmark itself ('Main' in @Bench.hs@) replays these with no server. Drive
-- this via @scripts/perf/record-fixtures.sh@ rather than by hand.
--
--   temporal-sdk-bench-record            -- record any missing fixtures
--   temporal-sdk-bench-record --list     -- print expected fixture paths (no server)
module Main (main) where

import Control.Monad (forM)
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Monad.Reader (runReaderT)
import qualified Data.Text as T
import System.Directory (createDirectoryIfMissing, doesFileExist, findExecutable)
import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)
import Temporal.Client (StartWorkflowOptions (..), TimeoutOptions (..))
import qualified Temporal.Client as C
import Temporal.Core.Client (ClientConfig (..), connectClient, defaultClientConfig)
import Temporal.Duration (seconds)
import Temporal.EphemeralServer
import qualified Temporal.EphemeralServer as DevCfg (TemporalDevServerConfig (..))
import Temporal.Replay (writeHistoryProtobufFile)
import Temporal.Worker (shutdown, startWorker)
import qualified Temporal.Workflow as W
import UnliftIO (bracket, tryAny)

import Bench.Common


main :: IO ()
main = do
  args <- getArgs
  case args of
    ["--list"] -> mapM_ (putStrLn . uncurry fixturePathFor) benchFixtures
    [] -> recordAll
    _ -> do
      hPutStrLn stderr "usage: temporal-sdk-bench-record [--list]"
      exitFailure


-- | Record every manifest fixture that isn't already on disk. Exits nonzero if
-- any recording fails, so a scripted regen can't silently leave gaps.
recordAll :: IO ()
recordAll = do
  createDirectoryIfMissing True fixtureDir
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
    let clientConf =
          defaultClientConfig
            { targetUrl = "http://localhost:" <> T.pack (show port)
            }
    coreClient <- runStdoutLoggingT (connectClient benchRuntime clientConf)
    wfClient <- C.workflowClient coreClient (C.mkWorkflowClientConfig fixtureNs)
    let tq = W.TaskQueue "bench-tq"
    bracket (startWorker coreClient (benchWorkerConfig tq)) shutdown $ \_ -> do
      results <- forM benchFixtures $ \fx@(fam, n) -> do
        let fp = fixturePathFor fam n
        exists <- doesFileExist fp
        if exists
          then do
            putStrLn ("skip " <> fp <> " (already recorded)")
            pure True
          else do
            -- Don't let one slow/failed fixture abort the whole batch; record
            -- the failure and report it via the exit code at the end.
            res <- tryAny (recordFixture wfClient tq fx)
            case res of
              Right () -> do
                putStrLn ("recorded " <> fp)
                pure True
              Left e -> do
                hPutStrLn stderr ("FAILED " <> fixtureKey fam n <> ": " <> show e)
                pure False
      let failures = length (filter not results)
      if failures > 0
        then do
          hPutStrLn stderr (show failures <> " fixture(s) failed to record")
          exitFailure
        else pure ()


-- | Record a single manifest fixture to its file. The family selects which
-- workflow to start; the leaf children of a 'Fanout' parent run on the same
-- worker/task queue, driven by the shared 'benchWorkerConfig'.
recordFixture :: C.WorkflowClient -> W.TaskQueue -> (Family, Int) -> IO ()
recordFixture wfClient tq (fam, n) = do
  let wfId = fixtureWfId fam n
      opts =
        (C.startWorkflowOptions tq)
          { workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
          , timeouts =
              TimeoutOptions
                { runTimeout = Just (seconds 600)
                , executionTimeout = Nothing
                , taskTimeout = Nothing
                }
          }
  h <- case fam of
    Sleeps -> runReaderT (C.start benchWorkflow wfId opts n) wfClient
    Fanout -> runReaderT (C.start fanoutParentWorkflow wfId opts n) wfClient
  () <- C.waitWorkflowResult h
  hist <- C.fetchHistory h
  writeHistoryProtobufFile (fixturePathFor fam n) hist

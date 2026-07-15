-- | Minimal allocation measurement via "GHC.Stats". Requires the process to run
-- with @+RTS -T@ (the benchmark stanza sets this). Returns total bytes allocated
-- during the action across ALL threads (RTS @allocated_bytes@ is global, so this
-- captures worker-thread allocation the replay spawns — unlike thread-local
-- @getAllocationCounter@). A GC brackets each read so the counter is flushed
-- (otherwise short actions that allocate less than one nursery block read 0).
module Bench.Stats (withAllocatedBytes, ResidencySample (..), sampleResidency) where

import Data.Word (Word64)
import GHC.Stats (
  GCDetails (gcdetails_live_bytes, gcdetails_mem_in_use_bytes),
  RTSStats (gc, max_live_bytes),
  allocated_bytes,
  getRTSStats,
  getRTSStatsEnabled,
 )
import System.Mem (performGC)


withAllocatedBytes :: IO a -> IO (a, Word64)
withAllocatedBytes act = do
  enabled <- getRTSStatsEnabled
  if not enabled
    then do a <- act; pure (a, 0)
    else do
      performGC
      before <- allocated_bytes <$> getRTSStats
      a <- act
      performGC
      after <- allocated_bytes <$> getRTSStats
      pure (a, after - before)


-- | A post-GC snapshot of Haskell-heap residency, for the soak/leak harness.
-- All figures are the RTS's view of the /Haskell/ heap (not process RSS): a
-- cached 'WorkflowInstance' is a live Haskell record, so a leak on the eviction
-- path (Haskell state keyed by runId that is never pruned) shows up directly in
-- 'rsLiveBytes'. Native/Rust-core retention is invisible here — the harness
-- samples process RSS separately for that.
data ResidencySample = ResidencySample
  { rsLiveBytes :: !Word64
  -- ^ Live bytes after the latest (forced) major GC — the leak signal.
  , rsMaxLiveBytes :: !Word64
  -- ^ Peak live bytes over the process lifetime (monotone; context only, never
  -- fed to the slope fit — it includes warmup peaks).
  , rsMemInUseBytes :: !Word64
  -- ^ RTS memory in use incl. slop/fragmentation after the latest GC.
  }


-- | Force a major GC, then read live-heap residency. The GC flattens the
-- collector's sawtooth so successive samples are comparable, and runs weak-ptr
-- finalizers so FFI-held resources are released promptly. Returns all-zero if
-- the RTS was not built/run with stats (@+RTS -T@).
sampleResidency :: IO ResidencySample
sampleResidency = do
  enabled <- getRTSStatsEnabled
  if not enabled
    then pure (ResidencySample 0 0 0)
    else do
      performGC
      s <- getRTSStats
      let g = gc s
      pure
        ResidencySample
          { rsLiveBytes = gcdetails_live_bytes g
          , rsMaxLiveBytes = max_live_bytes s
          , rsMemInUseBytes = gcdetails_mem_in_use_bytes g
          }

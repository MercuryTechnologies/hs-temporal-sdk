-- | Minimal allocation measurement via "GHC.Stats". Requires the process to run
-- with @+RTS -T@ (the benchmark stanza sets this). Returns total bytes allocated
-- during the action across ALL threads (RTS @allocated_bytes@ is global, so this
-- captures worker-thread allocation the replay spawns — unlike thread-local
-- @getAllocationCounter@). A GC brackets each read so the counter is flushed
-- (otherwise short actions that allocate less than one nursery block read 0).
module Bench.Stats (withAllocatedBytes) where

import Data.Word (Word64)
import GHC.Stats (allocated_bytes, getRTSStats, getRTSStatsEnabled)
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

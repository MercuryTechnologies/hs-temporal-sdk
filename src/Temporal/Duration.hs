{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NumericUnderscores #-}
-- | Convenient units of time for use with timers and timeouts.
--
-- Anything longer than a week (Months, Years) becomes ambiguous because they
-- are variable length. For example, a month can be 28, 29, 30, or 31 days.
--
-- If you need to represent a duration as years or months, you may want to use the @time@
-- library to normalize against a specific time zone and then convert the difference
-- between now and then into a Duration.
--
-- Alternatively, consider using Temporal's scheduling features to schedule a workflow
-- to run at one or more specific times in the future.
module Temporal.Duration where
import Data.Fixed
import Data.Time.Clock
import Data.Time.Clock.System
import Data.Data
import Data.Word (Word64, Word32)
import qualified Proto.Google.Protobuf.Duration as Duration
import qualified Proto.Google.Protobuf.Duration_Fields as Duration
import Lens.Family2 ((^.), (.~), (&))
import Data.ProtoLens (defMessage)

-- | A duration of time. Durations are always positive.
data Duration = Duration
  { durationSeconds :: {-# UNPACK #-} !Word64
  , durationNanoseconds :: {-# UNPACK #-} !Word64
  } deriving (Eq, Ord, Show, Data)

addDurations :: Duration -> Duration -> Duration
addDurations (Duration s1 ns1) (Duration s2 ns2) = Duration (s1 + s2 + s) ns
    where
      (s, ns) = (ns1 + ns2) `divMod` 1_000_000_000

-- | Convert a 'DiffTime' to a 'Duration'.
--
-- N.B. negative 'DiffTime' values will be clamped to 0 (i.e. 'Duration' will be 0)
-- in order to avoid the conversion of negative 'DiffTime' values to extremely large
-- Word64 values.
diffTimeToDuration :: DiffTime -> Duration
diffTimeToDuration t = Duration 
  { durationSeconds = fromIntegral ds
  , durationNanoseconds = fromIntegral remainingNanosFromPicos
  }
  where
    totalPicos = max 0 (diffTimeToPicoseconds t)
    picosPerSecond = 1_000_000_000_000
    (ds, remainingPicos) = totalPicos `quotRem` picosPerSecond
    remainingNanosFromPicos = fromIntegral remainingPicos `div` 1_000

-- | Convert a 'NominalDiffTime' to a 'Duration'.
--
-- N.B. negative 'NominalDiffTime' values will be clamped to 0 (i.e. 'Duration' will be 0)
-- in order to avoid the conversion of negative 'NominalDiffTime' values to extremely large
-- Word64 values.
nominalDiffTimeToDuration :: NominalDiffTime -> Duration
nominalDiffTimeToDuration t = Duration 
  { durationSeconds = fromIntegral ds
  , durationNanoseconds = fromIntegral remainingNanosFromPicos
  }
  where
    (MkFixed totalPicos) = max 0 $ nominalDiffTimeToSeconds t
    picosPerSecond = 1_000_000_000_000
    (ds, remainingPicos) = totalPicos `quotRem` picosPerSecond
    remainingNanosFromPicos = fromIntegral remainingPicos `div` 1_000

nanoseconds :: Word64 -> Duration
nanoseconds n = Duration secs ns
  where
    (secs, ns) = n `quotRem` 1_000_000_000

microseconds :: Word64 -> Duration
microseconds n = Duration secs ns
  where
    (secs, ns) = n `quotRem` 1_000_000

milliseconds :: Word64 -> Duration
milliseconds n = Duration secs ns
  where
    (secs, ns) = n `quotRem` 1_000

seconds :: Word64 -> Duration
seconds n = Duration n 0

minutes :: Word32 -> Duration
minutes n = Duration (fromIntegral n * 60) 0

hours :: Word32 -> Duration
hours n = Duration (fromIntegral n * 60 * 60) 0

days :: Word32 -> Duration
days n = Duration (fromIntegral n * 60 * 60 * 24) 0

weeks :: Word32 -> Duration
weeks n = Duration (fromIntegral n * 60 * 60 * 24 * 7) 0

durationFromProto :: Duration.Duration -> Duration
durationFromProto d = Duration
  { durationSeconds = fromIntegral (d ^. Duration.seconds)
  , durationNanoseconds = fromIntegral (d ^. Duration.nanos)
  }

durationToProto :: Duration -> Duration.Duration
durationToProto ts = defMessage
  & Duration.seconds .~ (fromIntegral $ durationSeconds ts)
  & Duration.nanos .~ (fromIntegral $ durationNanoseconds ts)

durationToMilliseconds :: Duration -> Double
durationToMilliseconds (Duration secs ns) = fromIntegral secs * 1_000 + fromIntegral ns / 1_000_000
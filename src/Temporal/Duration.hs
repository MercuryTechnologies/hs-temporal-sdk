{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NumericUnderscores #-}
-- | 
-- Module: Temporal.Duration
-- Description: Effecient and user-friendly time durations
--
--Convenient units of time for use with timers and timeouts.
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
import Data.Aeson
import Data.Aeson.Types (Parser)
import Data.Fixed
import Data.ProtoLens (defMessage)
import qualified Data.Text as T
import Data.Time.Clock
import Data.Data
import Data.Int (Int64, Int32)
import qualified Proto.Google.Protobuf.Duration as Duration
import qualified Proto.Google.Protobuf.Duration_Fields as Duration
import Lens.Family2 ((^.), (.~), (&))
import Text.Printf

-- | A duration of time. Durations are always positive.
data Duration = Duration
  { durationSeconds :: {-# UNPACK #-} !Int64
  , durationNanoseconds :: {-# UNPACK #-} !Int32
  } deriving stock (Eq, Ord, Show, Data)

-- | 	Generated output always contains 0, 3, 6, or 9 fractional digits, depending on required precision, followed by the suffix "s". Accepted are any fractional digits (also none) as long as they fit into nano-seconds precision and the suffix "s" is required.
instance ToJSON Duration where
  toJSON Duration{..} = String $ T.pack $ printf "%d.%09ds" durationSeconds durationNanoseconds

instance FromJSON Duration where
  parseJSON = withText "Duration" parseDuration

parseDuration :: T.Text -> Parser Duration
parseDuration t 
  | T.last t == 's' = pure $ nominalDiffTimeToDuration $ secondsToNominalDiffTime $ read $ T.unpack (T.init t)
  | otherwise = fail "Duration must end with 's'"
    

-- | Add two durations together. Durations are subject to integer overflow.
addDurations :: Duration -> Duration -> Duration
addDurations (Duration s1 ns1) (Duration s2 ns2) = Duration (s1 + s2 + s) $ fromIntegral ns
    where
      (s :: Int64, ns :: Int64) = fromIntegral (ns1 + ns2) `divMod` 1_000_000_000

-- | Convert a 'DiffTime' to a 'Duration'.
--
-- N.B. negative 'DiffTime' values will be clamped to 0 (i.e. 'Duration' will be 0)
-- in order to avoid the conversion of negative 'DiffTime' values to extremely large
-- Word64 values.
diffTimeToDuration :: DiffTime -> Duration
diffTimeToDuration t = Duration 
  { durationSeconds = fromIntegral ds
  , durationNanoseconds = remainingNanosFromPicos
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
  , durationNanoseconds = remainingNanosFromPicos
  }
  where
    (MkFixed totalPicos) = max 0 $ nominalDiffTimeToSeconds t
    picosPerSecond = 1_000_000_000_000
    (ds, remainingPicos) = totalPicos `quotRem` picosPerSecond
    remainingNanosFromPicos = fromIntegral remainingPicos `div` 1_000

-- | Create a 'Duration' from a given number of nanoseconds.
nanoseconds :: Integer -> Duration
nanoseconds n = Duration (fromIntegral secs) (fromIntegral ns)
  where
    (secs, ns) = n `quotRem` 1_000_000_000

-- | Create a 'Duration' from a given number of microseconds.
microseconds :: Integer -> Duration
microseconds n = Duration (fromIntegral secs) (fromIntegral ns)
  where
    (secs, ns) = n `quotRem` 1_000_000

-- | Create a 'Duration' from a given number of milliseconds.
milliseconds :: Int64 -> Duration
milliseconds n = Duration secs $ fromIntegral ns
  where
    (secs, ns) = n `quotRem` 1_000

-- | Create a 'Duration' from a given number of seconds.
seconds :: Int64 -> Duration
seconds n = Duration n 0

-- | Create a 'Duration' from a given number of minutes.
minutes :: Int32 -> Duration
minutes n = Duration (fromIntegral n * 60) 0

-- | Create a 'Duration' from a given number of hours.
hours :: Int32 -> Duration
hours n = Duration (fromIntegral n * 60 * 60) 0

-- | Create a 'Duration' from a given number of days.
days :: Int32 -> Duration
days n = Duration (fromIntegral n * 60 * 60 * 24) 0

-- | Create a 'Duration' from a given number of weeks.
weeks :: Int32 -> Duration
weeks n = Duration (fromIntegral n * 60 * 60 * 24 * 7) 0

-- | A 'Duration' representing the maximum possible length of time. (Approximately 132 years.)
infinity :: Duration
infinity = Duration ((2 :: Int64) ^ (32 :: Int64)) 0

-- | Convert a protocol buffer duration to a 'Duration'.
durationFromProto :: Duration.Duration -> Duration
durationFromProto d = Duration
  { durationSeconds = d ^. Duration.seconds
  , durationNanoseconds = d ^. Duration.nanos
  }

-- | Convert a 'Duration' to a protocol buffer duration.
durationToProto :: Duration -> Duration.Duration
durationToProto ts = defMessage
  & Duration.seconds .~ durationSeconds ts
  & Duration.nanos .~ durationNanoseconds ts

-- | Convert a 'Duration' to a milliseconds represented as a 'Double'. This is mostly useful for
-- human-readable values emitted by logs, metrics, traces, etc.
durationToMilliseconds :: Duration -> Double
durationToMilliseconds (Duration secs ns) = fromIntegral secs * 1_000 + fromIntegral ns / 1_000_000
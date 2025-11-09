{- |
Module: Temporal.Timestamp
Description: Utilities for converting between protobuf Timestamps and UTCTime

This module provides conversion functions between Google's protobuf Timestamp
format and Haskell's UTCTime.
-}
module Temporal.Timestamp (
  protoToUTCTime,
  utcTimeToProto,
) where

import Data.Int (Int32, Int64)
import Data.ProtoLens (defMessage)
import Data.Time.Clock (UTCTime)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime, utcTimeToPOSIXSeconds)
import Lens.Family2 ((&), (.~), (^.))
import qualified Proto.Google.Protobuf.Timestamp as TS
import qualified Proto.Google.Protobuf.Timestamp_Fields as TS


-- | Convert a protobuf Timestamp to UTCTime
protoToUTCTime :: TS.Timestamp -> UTCTime
protoToUTCTime ts =
  let seconds = fromIntegral (ts ^. TS.seconds) :: Integer
      nanos = fromIntegral (ts ^. TS.nanos) :: Integer
      posixTime = fromRational $ toRational seconds + toRational nanos / 1_000_000_000
  in posixSecondsToUTCTime posixTime


-- | Convert UTCTime to a protobuf Timestamp
utcTimeToProto :: UTCTime -> TS.Timestamp
utcTimeToProto time =
  let posix = toRational (utcTimeToPOSIXSeconds time)
      seconds = floor posix :: Int64
      nanos = floor ((posix - toRational seconds) * 1_000_000_000) :: Int32
  in defMessage
      & TS.seconds .~ seconds
      & TS.nanos .~ nanos

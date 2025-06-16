module Temporal.Client.TestService (
  getCurrentTime,
  unlockTimeSkipping,
  lockTimeSkipping,
  sleepUntil,
  sleep,
  unlockTimeSkippingWithSleep,
) where

import Data.Bifunctor (bimap)
import Data.Int (Int32 (..), Int64 (..))
import Data.ProtoLens.Message
import Data.Time.Clock (UTCTime)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime, utcTimeToPOSIXSeconds)
import Lens.Family2
import qualified Proto.Google.Protobuf.Timestamp as TS
import qualified Proto.Google.Protobuf.Timestamp_Fields as TS (nanos, seconds)
import Proto.Temporal.Api.Testservice.V1.RequestResponse (
  GetCurrentTimeResponse,
  LockTimeSkippingRequest,
  SleepRequest,
  SleepUntilRequest,
  UnlockTimeSkippingRequest,
 )
import qualified Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields as Fields
import Temporal.Core.Client (Client)
import qualified Temporal.Core.Client.TestService
import Temporal.Duration (Duration (..), durationToProto)
import qualified Temporal.Exception


getCurrentTime :: Client -> IO (Either Temporal.Exception.RpcError UTCTime)
getCurrentTime client = do
  res <- Temporal.Core.Client.TestService.getCurrentTime client
  case res of
    Left err -> pure $ Left $ Temporal.Exception.coreRpcErrorToRpcError err
    Right val ->
      let time = val ^. Fields.time
      in pure $ Right $ convertTimestampToUTCTime time


unlockTimeSkipping :: Client -> IO (Either Temporal.Exception.RpcError ())
unlockTimeSkipping client = do
  let msg :: UnlockTimeSkippingRequest
      msg = defMessage
  res <- Temporal.Core.Client.TestService.unlockTimeSkipping client msg
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res


lockTimeSkipping :: Client -> IO (Either Temporal.Exception.RpcError ())
lockTimeSkipping client = do
  let msg :: LockTimeSkippingRequest
      msg = defMessage
  res <- Temporal.Core.Client.TestService.lockTimeSkipping client msg
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res


sleepUntil :: Client -> UTCTime -> IO (Either Temporal.Exception.RpcError ())
sleepUntil client time = do
  let msg :: SleepUntilRequest
      msg = defMessage & Fields.timestamp .~ convertUTCTimeToTimestamp time
  res <- Temporal.Core.Client.TestService.sleepUntil client msg
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res


sleep :: Client -> Duration -> IO (Either Temporal.Exception.RpcError ())
sleep client duration = do
  let msg :: SleepRequest
      msg = defMessage & Fields.duration .~ durationToProto duration
  res <- Temporal.Core.Client.TestService.sleep client msg
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res


unlockTimeSkippingWithSleep :: Client -> Duration -> IO (Either Temporal.Exception.RpcError ())
unlockTimeSkippingWithSleep client duration = do
  let msg :: SleepRequest
      msg = defMessage & Fields.duration .~ durationToProto duration
  res <- Temporal.Core.Client.TestService.unlockTimeSkippingWithSleep client msg
  pure $ bimap Temporal.Exception.coreRpcErrorToRpcError (const ()) res


convertTimestampToUTCTime :: TS.Timestamp -> UTCTime
convertTimestampToUTCTime ts =
  let seconds = fromIntegral (ts ^. TS.seconds) :: Integer
      nanos = fromIntegral (ts ^. TS.nanos) :: Integer
      posixTime = fromRational $ toRational seconds + toRational nanos / 1_000_000_000
  in posixSecondsToUTCTime posixTime


convertUTCTimeToTimestamp :: UTCTime -> TS.Timestamp
convertUTCTimeToTimestamp time =
  let posix = toRational (utcTimeToPOSIXSeconds time)
      seconds = floor posix :: Int64
      nanos = floor ((posix - toRational seconds) * 1_000_000_000) :: Int32
  in defMessage
      & TS.seconds .~ seconds
      & TS.nanos .~ nanos

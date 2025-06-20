module Temporal.Client.TestService (
  getCurrentTime,
  unlockTimeSkipping,
  lockTimeSkipping,
  sleepUntil,
  sleep,
  unlockTimeSkippingWithSleep,
  TimeSkippingNotSupported (..),
) where

import Control.Exception
import Data.Int (Int32, Int64)
import Data.ProtoLens.Message
import Data.Time.Clock (UTCTime)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime, utcTimeToPOSIXSeconds)
import Lens.Family2
import qualified Proto.Google.Protobuf.Timestamp as TS
import qualified Proto.Google.Protobuf.Timestamp_Fields as TS (nanos, seconds)
import Proto.Temporal.Api.Testservice.V1.RequestResponse (
  LockTimeSkippingRequest,
  SleepRequest,
  SleepUntilRequest,
  UnlockTimeSkippingRequest,
 )
import qualified Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields as Fields
import Temporal.Core.Client (Client)
import qualified Temporal.Core.Client
import qualified Temporal.Core.Client.TestService
import Temporal.Duration (Duration (..), durationToProto)
import Temporal.Exception (RPCStatusCode (..), RpcError (..), coreRpcErrorToRpcError)


data TimeSkippingNotSupported = TimeSkippingNotSupported
  deriving stock (Show)


instance Exception TimeSkippingNotSupported


getCurrentTime :: Client -> IO UTCTime
getCurrentTime client = do
  res <- Temporal.Core.Client.TestService.getCurrentTime client
  case res of
    Left err -> convertAndThrowError err
    Right val ->
      let time = val ^. Fields.time
      in pure $ protoToUTCTime time


unlockTimeSkipping :: Client -> IO ()
unlockTimeSkipping client = do
  let msg :: UnlockTimeSkippingRequest
      msg = defMessage
  res <- Temporal.Core.Client.TestService.unlockTimeSkipping client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


lockTimeSkipping :: Client -> IO ()
lockTimeSkipping client = do
  let msg :: LockTimeSkippingRequest
      msg = defMessage
  res <- Temporal.Core.Client.TestService.lockTimeSkipping client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


sleepUntil :: Client -> UTCTime -> IO ()
sleepUntil client time = do
  let msg :: SleepUntilRequest
      msg = defMessage & Fields.timestamp .~ utcTimeToProto time
  res <- Temporal.Core.Client.TestService.sleepUntil client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


sleep :: Client -> Duration -> IO ()
sleep client duration = do
  let msg :: SleepRequest
      msg = defMessage & Fields.duration .~ durationToProto duration
  res <- Temporal.Core.Client.TestService.sleep client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


unlockTimeSkippingWithSleep :: Client -> Duration -> IO ()
unlockTimeSkippingWithSleep client duration = do
  let msg :: SleepRequest
      msg = defMessage & Fields.duration .~ durationToProto duration
  res <- Temporal.Core.Client.TestService.unlockTimeSkippingWithSleep client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


protoToUTCTime :: TS.Timestamp -> UTCTime
protoToUTCTime ts =
  let seconds = fromIntegral (ts ^. TS.seconds) :: Integer
      nanos = fromIntegral (ts ^. TS.nanos) :: Integer
      posixTime = fromRational $ toRational seconds + toRational nanos / 1_000_000_000
  in posixSecondsToUTCTime posixTime


utcTimeToProto :: UTCTime -> TS.Timestamp
utcTimeToProto time =
  let posix = toRational (utcTimeToPOSIXSeconds time)
      seconds = floor posix :: Int64
      nanos = floor ((posix - toRational seconds) * 1_000_000_000) :: Int32
  in defMessage
      & TS.seconds .~ seconds
      & TS.nanos .~ nanos


convertAndThrowError :: Temporal.Core.Client.RpcError -> IO a
convertAndThrowError err = do
  let err'@(RpcError {code, message}) = coreRpcErrorToRpcError err
  if code == StatusUnimplemented && message == "unknown service temporal.api.testservice.v1.TestService"
    then throwIO TimeSkippingNotSupported
    else throwIO err'

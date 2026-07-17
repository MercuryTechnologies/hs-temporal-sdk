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

import Data.Time.Clock (UTCTime)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime, utcTimeToPOSIXSeconds)
import qualified Proto.Google.Protobuf.Timestamp as TS
import Proto.Temporal.Api.Testservice.V1.RequestResponse (
  GetCurrentTimeResponse (..),
  LockTimeSkippingRequest (..),
  SleepRequest (..),
  SleepUntilRequest (..),
  UnlockTimeSkippingRequest (..),
 )
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
    Right (GetCurrentTimeResponse mTime _) ->
      pure $ protoToUTCTime (maybe (TS.Timestamp 0 0 []) id mTime)


unlockTimeSkipping :: Client -> IO ()
unlockTimeSkipping client = do
  let msg :: UnlockTimeSkippingRequest
      msg = UnlockTimeSkippingRequest []
  res <- Temporal.Core.Client.TestService.unlockTimeSkipping client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


lockTimeSkipping :: Client -> IO ()
lockTimeSkipping client = do
  let msg :: LockTimeSkippingRequest
      msg = LockTimeSkippingRequest []
  res <- Temporal.Core.Client.TestService.lockTimeSkipping client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


sleepUntil :: Client -> UTCTime -> IO ()
sleepUntil client time = do
  let msg :: SleepUntilRequest
      msg = SleepUntilRequest (Just (utcTimeToProto time)) []
  res <- Temporal.Core.Client.TestService.sleepUntil client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


sleep :: Client -> Duration -> IO ()
sleep client duration = do
  let msg :: SleepRequest
      msg = SleepRequest (Just (durationToProto duration)) []
  res <- Temporal.Core.Client.TestService.sleep client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


unlockTimeSkippingWithSleep :: Client -> Duration -> IO ()
unlockTimeSkippingWithSleep client duration = do
  let msg :: SleepRequest
      msg = SleepRequest (Just (durationToProto duration)) []
  res <- Temporal.Core.Client.TestService.unlockTimeSkippingWithSleep client msg
  case res of
    Left err -> convertAndThrowError err
    Right _ -> pure ()


protoToUTCTime :: TS.Timestamp -> UTCTime
protoToUTCTime (TS.Timestamp tsSeconds tsNanos _) =
  let seconds = fromIntegral tsSeconds :: Integer
      nanos = fromIntegral tsNanos :: Integer
      posixTime = fromRational $ toRational seconds + toRational nanos / 1_000_000_000
  in posixSecondsToUTCTime posixTime


utcTimeToProto :: UTCTime -> TS.Timestamp
utcTimeToProto time =
  let posix = toRational (utcTimeToPOSIXSeconds time)
      seconds = floor posix :: Int64
      nanos = floor ((posix - toRational seconds) * 1_000_000_000) :: Int32
  in TS.Timestamp seconds nanos []


convertAndThrowError :: Temporal.Core.Client.RpcError -> IO a
convertAndThrowError err = do
  let err'@(RpcError {code, message}) = coreRpcErrorToRpcError err
  if code == StatusUnimplemented && message == "unknown service temporal.api.testservice.v1.TestService"
    then throwIO TimeSkippingNotSupported
    else throwIO err'

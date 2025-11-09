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
import Data.ProtoLens.Message
import Data.Time.Clock (UTCTime)
import Lens.Family2
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
import Temporal.Timestamp (protoToUTCTime, utcTimeToProto)


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


convertAndThrowError :: Temporal.Core.Client.RpcError -> IO a
convertAndThrowError err = do
  let err'@(RpcError {code, message}) = coreRpcErrorToRpcError err
  if code == StatusUnimplemented && message == "unknown service temporal.api.testservice.v1.TestService"
    then throwIO TimeSkippingNotSupported
    else throwIO err'

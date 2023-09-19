{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}
module Temporal.Core.Client.TestService where

import Temporal.Core.Client
import Temporal.Internal.FFI
import Proto.Temporal.Api.Testservice.V1.Service
import Proto.Temporal.Api.Testservice.V1.RequestResponse
import Proto.Google.Protobuf.Empty (Empty)

foreign import ccall "hs_get_current_time" hs_get_current_time :: PrimRpcCall
getCurrentTime :: Client -> Empty -> IO (Either RpcError GetCurrentTimeResponse)
getCurrentTime = call @TestService @"getCurrentTime" hs_get_current_time

foreign import ccall "hs_lock_time_skipping" hs_lock_time_skipping :: PrimRpcCall
lockTimeSkipping :: Client -> LockTimeSkippingRequest -> IO (Either RpcError LockTimeSkippingResponse)
lockTimeSkipping = call @TestService @"lockTimeSkipping" hs_lock_time_skipping

foreign import ccall "hs_sleep_until" hs_sleep_until :: PrimRpcCall
sleepUntil :: Client -> SleepUntilRequest -> IO (Either RpcError SleepResponse)
sleepUntil = call @TestService @"sleepUntil" hs_sleep_until

foreign import ccall "hs_sleep" hs_sleep :: PrimRpcCall
sleep :: Client -> SleepRequest -> IO (Either RpcError SleepResponse)
sleep = call @TestService @"sleep" hs_sleep

foreign import ccall "hs_unlock_time_skipping_with_sleep" hs_unlock_time_skipping_with_sleep :: PrimRpcCall
unlockTimeSkippingWithSleep :: Client -> SleepRequest -> IO (Either RpcError SleepResponse)
unlockTimeSkippingWithSleep = call @TestService @"unlockTimeSkippingWithSleep" hs_unlock_time_skipping_with_sleep

foreign import ccall "hs_unlock_time_skipping" hs_unlock_time_skipping :: PrimRpcCall
unlockTimeSkipping :: Client -> UnlockTimeSkippingRequest -> IO (Either RpcError UnlockTimeSkippingResponse)
unlockTimeSkipping = call @TestService @"unlockTimeSkipping" hs_unlock_time_skipping

{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}
module Temporal.Core.Client.TestService where

import Temporal.Core.Client
import Temporal.Internal.FFI
import Proto.Temporal.Api.Testservice.V1.Service
import Proto.Temporal.Api.Testservice.V1.RequestResponse
import Data.ProtoLens (Message(defMessage))

foreign import ccall "hs_get_current_time" hs_get_current_time :: PrimRpcCall
-- | GetCurrentTime returns the current Temporal Test Server time
--
-- This time might not be equal to {@link System#currentTimeMillis()} due to time skipping.
getCurrentTime :: Client -> IO (Either RpcError GetCurrentTimeResponse)
getCurrentTime client = call @TestService @"getCurrentTime" hs_get_current_time client defMessage

foreign import ccall "hs_lock_time_skipping" hs_lock_time_skipping :: PrimRpcCall

-- | lockTimeSkipping increments Time Locking Counter by one.
--
-- If Time Locking Counter is positive, time skipping is locked (disabled).
-- When time skipping is disabled, the time in test server is moving normally, with a real time pace.
-- Test Server is typically started with locked time skipping and Time Locking Counter = 1.
--
-- LockTimeSkipping and UnlockTimeSkipping calls are counted.
lockTimeSkipping :: Client -> LockTimeSkippingRequest -> IO (Either RpcError LockTimeSkippingResponse)
lockTimeSkipping = call @TestService @"lockTimeSkipping" hs_lock_time_skipping

foreign import ccall "hs_sleep_until" hs_sleep_until :: PrimRpcCall

-- | This call returns only when the Test Server Time advances to the specified timestamp.
--
-- If the current Test Server Time is beyond the specified timestamp, returns immediately.
-- This is an EXPERIMENTAL API.
sleepUntil :: Client -> SleepUntilRequest -> IO (Either RpcError SleepResponse)
sleepUntil = call @TestService @"sleepUntil" hs_sleep_until

foreign import ccall "hs_sleep" hs_sleep :: PrimRpcCall
-- | This call returns only when the Test Server Time advances by the specified duration.
-- This is an EXPERIMENTAL API.
sleep :: Client -> SleepRequest -> IO (Either RpcError SleepResponse)
sleep = call @TestService @"sleep" hs_sleep

foreign import ccall "hs_unlock_time_skipping_with_sleep" hs_unlock_time_skipping_with_sleep :: PrimRpcCall
-- | UnlockTimeSkippingWhileSleep decreases time locking counter by one and increases it back
-- once the Test Server Time advances by the duration specified in the request.
--
-- This call returns only when the Test Server Time advances by the specified duration.
--
-- If it is called when Time Locking Counter is
--   - more than 1 and no other unlocks are coming in, rpc call will block for the specified duration, time will not be fast forwarded.
--   - 1, it will lead to fast forwarding of the time by the duration specified in the request and quick return of this rpc call.
--   - 0 will lead to rpc call failure same way as an unbalanced UnlockTimeSkipping.
unlockTimeSkippingWithSleep :: Client -> SleepRequest -> IO (Either RpcError SleepResponse)
unlockTimeSkippingWithSleep = call @TestService @"unlockTimeSkippingWithSleep" hs_unlock_time_skipping_with_sleep

-- | UnlockTimeSkipping decrements Time Locking Counter by one.
--
-- If the counter reaches 0, it unlocks time skipping and fast forwards time.
-- LockTimeSkipping and UnlockTimeSkipping calls are counted. Calling UnlockTimeSkipping does not
-- guarantee that time is going to be fast forwarded as another lock can be holding it.
--
-- Time Locking Counter can't be negative, unbalanced calls to UnlockTimeSkipping will lead to rpc call failure
foreign import ccall "hs_unlock_time_skipping" hs_unlock_time_skipping :: PrimRpcCall
unlockTimeSkipping :: Client -> UnlockTimeSkippingRequest -> IO (Either RpcError UnlockTimeSkippingResponse)
unlockTimeSkipping = call @TestService @"unlockTimeSkipping" hs_unlock_time_skipping

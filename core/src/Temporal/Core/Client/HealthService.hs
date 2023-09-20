{-# LANGUAGE TypeApplications #-}
module Temporal.Client.HealthService where
import Temporal.Core.Client
import Proto.Health.V1.Health

-- foreign import ccall "hs_health_check" hs_health_check :: PrimRpcCall
-- -- healthCheck :: Client -> HealthCheckRequest -> IO (Either RpcError HealthCheckResponse)
-- -- healthCheck = call @HealthService @"healthCheck" hs_health_check
module Temporal.OpenTelemetry where

import OpenTelemetry.Trace.Core
import Temporal.Interceptor
import Temporal.Payload

headerKey :: Text
headerKey = "_tracer-data"

contextFromHeaders :: RawPayload -> Context
contextFromHeaders = undefined

contextToHeaders :: Context -> RawPayload
contextToHeaders = undefined

initializeInterceptors :: IO 
  ( WorkflowInboundInterceptor
  , WorkflowOutboundInterceptor
  , ActivityInboundInterceptor
  , ActivityOutboundInterceptor
  )
initializeInterceptors = undefined
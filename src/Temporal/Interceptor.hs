module Temporal.Interceptor 
  ( Interceptors(..)
  , WorkflowInboundInterceptor(..)
  , WorkflowOutboundInterceptor(..)
  , ActivityInboundInterceptor(..)
  , ActivityOutboundInterceptor(..)
  , interceptorBase
  ) where
import Temporal.Worker.Types

interceptorBase :: Interceptors
interceptorBase = Interceptors
  { workflowInbound = WorkflowInboundInterceptor
    { interceptExecuteWorkflow = ()
    , interceptHandleSignal = ()
    , interceptHandleQuery = ()
    }
  , workflowOutbound = WorkflowOutboundInterceptor
    { interceptContinueAsNew = ()
    , interceptInfo = readIORef inst.workflowInstanceInfo
    , interceptSignalChildWorkflow = ()
    , interceptSignalExternalWorkflow = ()
    , interceptStartActivity = ()
    , interceptStartChildWorkflow = ()
    , interceptStartLocalActivity = ()
    }
  , activityInbound = ActivityInboundInterceptor
    { interceptExecuteActivity = ()
    }
  , activityOutbound = ActivityOutboundInterceptor
    { interceptInfo = ()
    , interceptHeartbeat = ()
    }
  }
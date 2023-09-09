module Temporal.Interceptor 
  ( Interceptors(..)
  , ExecuteWorkflowInput(..)
  , WorkflowInboundInterceptor(..)
  , WorkflowOutboundInterceptor(..)
  , ActivityInboundInterceptor(..)
  , ActivityOutboundInterceptor(..)
  , WorkflowExitVariant(..)
  , ClientInterceptors(..)
  , interceptorConvertChildWorkflowHandle
  )
where

import Control.Exception (SomeException)
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Vector (Vector)
import Temporal.Common
import Temporal.Payload
import Temporal.Workflow.Types
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (WorkflowCommand)
import Temporal.Workflow.Internal.Monad
import Temporal.Client.Types

data ActivityInboundInterceptor = ActivityInboundInterceptor 
  { executeActivity :: ExecuteActivityInput -> (ExecuteActivityInput -> IO (Either String RawPayload)) -> IO (Either String RawPayload)
  }

instance Semigroup ActivityInboundInterceptor where
  l <> r = ActivityInboundInterceptor
    { executeActivity = \input next -> (executeActivity l) input $ \input' -> (executeActivity r) input' next
    }


data ActivityOutboundInterceptor = ActivityOutboundInterceptor { }

instance Semigroup ActivityOutboundInterceptor where
  ActivityOutboundInterceptor <> ActivityOutboundInterceptor = ActivityOutboundInterceptor

data Interceptors = Interceptors
  { workflowInboundInterceptors :: WorkflowInboundInterceptor
  , workflowOutboundInterceptors :: WorkflowOutboundInterceptor
  , activityInboundInterceptors :: ActivityInboundInterceptor
  , activityOutboundInterceptors :: ActivityOutboundInterceptor
  , clientInterceptors :: ClientInterceptors
  }

instance Semigroup Interceptors where
  Interceptors a b c d e <> Interceptors a' b' c' d' e' = Interceptors (a <> a') (b <> b') (c <> c') (d <> d') (e <> e')

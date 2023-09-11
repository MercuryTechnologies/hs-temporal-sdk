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
  { executeActivity :: ExecuteActivityInput -> (ExecuteActivityInput -> IO (Either String Payload)) -> IO (Either String Payload)
  }

instance Semigroup ActivityInboundInterceptor where
  l <> r = ActivityInboundInterceptor
    { executeActivity = \input next -> (executeActivity l) input $ \input' -> (executeActivity r) input' next
    }

instance Monoid ActivityInboundInterceptor where
  mempty = ActivityInboundInterceptor
    { executeActivity = \input next -> next input
    }

data ActivityOutboundInterceptor = ActivityOutboundInterceptor { }

instance Semigroup ActivityOutboundInterceptor where
  ActivityOutboundInterceptor <> ActivityOutboundInterceptor = ActivityOutboundInterceptor

instance Monoid ActivityOutboundInterceptor where
  mempty = ActivityOutboundInterceptor

data Interceptors = Interceptors
  { workflowInboundInterceptors :: WorkflowInboundInterceptor
  , workflowOutboundInterceptors :: WorkflowOutboundInterceptor
  , activityInboundInterceptors :: ActivityInboundInterceptor
  , activityOutboundInterceptors :: ActivityOutboundInterceptor
  , clientInterceptors :: ClientInterceptors
  }


instance Semigroup Interceptors where
  Interceptors a b c d e <> Interceptors a' b' c' d' e' = Interceptors (a <> a') (b <> b') (c <> c') (d <> d') (e <> e')


instance Monoid Interceptors where
  mempty = Interceptors mempty mempty mempty mempty mempty

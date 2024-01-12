-- |
-- Module: Temporal.Interceptor
-- Description: Define interceptors for Temporal workflows and activities.
--
-- Temporal interceptors allow you to customize and extend the behavior of
-- workflows and activities by intercepting and modifying their execution at
-- various points. Interceptors can be used to add cross-cutting concerns,
-- such as logging, security, or monitoring, to your Temporal applications.
--
-- This module provides types and functions for defining and composing
-- interceptors for different parts of Temporal workflows and activities.
--
-- Types for different types of interceptors:
--
-- * 'WorkflowInboundInterceptor': An interceptor for workflows, invoked for
--   commands sent to workflow execution.
-- * 'WorkflowOutboundInterceptor': An interceptor for workflows, invoked for
--   commands sent from a workflow.
-- * 'ActivityInboundInterceptor': An interceptor for activities, invoked for
--   commands sent to an activity.
-- * 'ActivityOutboundInterceptor': An interceptor for activities, invoked for
--   actions executed by an activity.
-- * 'ClientInterceptors': Interceptors for Temporal clients.
--
-- Functions for composing interceptors:
--
-- * 'interceptorConvertChildWorkflowHandle': A function for converting child
--   workflow handles within interceptors.
--
-- Example usage of interceptors:
--
-- * Define a custom interceptor for activities using 'ActivityInboundInterceptor'.
--
--    > myActivityInterceptor :: ActivityInboundInterceptor
--    > myActivityInterceptor = ActivityInboundInterceptor
--    >   { executeActivity = \input next -> do
--    >       -- Perform custom logic before calling the activity function
--    >       result <- next input
--    >       -- Perform custom logic after the activity function completes
--    >       return result
--    >   }
--
-- * Compose multiple interceptors using 'Semigroup' instances.
--
--    > combinedInterceptor :: Interceptor
--    > combinedInterceptor = bugsnagInterceptor <> encryptionInterceptor <> otelInterceptor
--
-- * Provide the interceptors to the Temporal Workflow client and worker.
--
module Temporal.Interceptor 
  ( 
    Interceptors(..)
  , ExecuteWorkflowInput(..)
  , WorkflowInboundInterceptor(..)
  , HandleQueryInput(..)
  , WorkflowOutboundInterceptor(..)
  , ActivityInput(..)
  , ActivityInboundInterceptor(..)
  , ExecuteActivityInput(..)
  , ActivityOutboundInterceptor(..)
  , WorkflowExitVariant(..)
  , ClientInterceptors(..)
  , QueryWorkflowInput(..)
  , SignalWithStartWorkflowInput(..)
  , ScheduleClientInterceptors(..)
  , interceptorConvertChildWorkflowHandle
  )
where

import Temporal.Payload
import Temporal.Workflow.Types
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
  , scheduleClientInterceptors :: ScheduleClientInterceptors
  }


instance Semigroup Interceptors where
  Interceptors a b c d e f <> Interceptors a' b' c' d' e' f' = Interceptors (a <> a') (b <> b') (c <> c') (d <> d') (e <> e') (f <> f')

instance Monoid Interceptors where
  mempty = Interceptors mempty mempty mempty mempty mempty mempty


data ScheduleClientInterceptors = ScheduleClientInterceptors
  { -- | Unlike the other interceptors, this one is invoked on the construction of the workflow start options
    scheduleWorkflowAction :: WorkflowStartOptions -> [Payload] -> IO WorkflowStartOptions
  }

instance Semigroup ScheduleClientInterceptors where
  ScheduleClientInterceptors a <> ScheduleClientInterceptors b = ScheduleClientInterceptors
    { scheduleWorkflowAction = \opts input -> do
        opts' <- a opts input
        b opts' input
    }

instance Monoid ScheduleClientInterceptors where
  mempty = ScheduleClientInterceptors
    { scheduleWorkflowAction = \opts input -> return opts
    }
{- |
Module: Temporal.Interceptor
Description: Define interceptors for Temporal workflows and activities.

Temporal interceptors allow you to customize and extend the behavior of
workflows and activities by intercepting and modifying their execution at
various points. Interceptors can be used to add cross-cutting concerns,
such as logging, security, or monitoring, to your Temporal applications.

This module provides types and functions for defining and composing
interceptors for different parts of Temporal workflows and activities.

Types for different types of interceptors:

* 'WorkflowInboundInterceptor': An interceptor for workflows, invoked for
  commands sent to workflow execution.
* 'WorkflowOutboundInterceptor': An interceptor for workflows, invoked for
  commands sent from a workflow.
* 'ActivityInboundInterceptor': An interceptor for activities, invoked for
  commands sent to an activity.
* 'ActivityOutboundInterceptor': An interceptor for activities, invoked for
  actions executed by an activity.
* 'ClientInterceptors': Interceptors for Temporal clients.

Functions for composing interceptors:

* 'interceptorConvertChildWorkflowHandle': A function for converting child
  workflow handles within interceptors.

Example usage of interceptors:

* Define a custom interceptor for activities using 'ActivityInboundInterceptor'.

   > myActivityInterceptor :: ActivityInboundInterceptor
   > myActivityInterceptor = ActivityInboundInterceptor
   >   { executeActivity = \input next -> do
   >       -- Perform custom logic before calling the activity function
   >       result <- next input
   >       -- Perform custom logic after the activity function completes
   >       return result
   >   }

* Compose multiple interceptors using 'Semigroup' instances.

   > combinedInterceptor :: Interceptor
   > combinedInterceptor = bugsnagInterceptor <> encryptionInterceptor <> otelInterceptor

* Provide the interceptors to the Temporal Workflow client and worker.
-}
module Temporal.Interceptor (
  Interceptors (..),
  ExecuteWorkflowInput (..),
  WorkflowInboundInterceptor (..),
  HandleQueryInput (..),
  HandleUpdateInput (..),
  WorkflowOutboundInterceptor (..),
  ActivityInput (..),
  ActivityInboundInterceptor (..),
  ExecuteActivityInput (..),
  ActivityOutboundInterceptor (..),
  WorkflowExitVariant (..),
  ClientInterceptors (..),
  QueryWorkflowInput (..),
  UpdateWorkflowInput (..),
  SignalWithStartWorkflowInput (..),
  ScheduleClientInterceptors (..),
  StartWorkflowOptions (..),
  HandleUpdateInput (..),
  interceptorConvertChildWorkflowHandle,
) where

import Control.Exception (SomeException)
import Data.Map (Map)
import Data.Text (Text)
import Data.Vault.Strict
import Data.Vector (Vector)
import Temporal.Client.Types
import Temporal.Common
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.ChildWorkflowHandle
import Temporal.Workflow.Task
import Temporal.Workflow.Types


data ActivityInboundInterceptor env = ActivityInboundInterceptor
  { executeActivity :: env -> ExecuteActivityInput -> (env -> ExecuteActivityInput -> IO (Either String Payload)) -> IO (Either String Payload)
  }


instance Semigroup (ActivityInboundInterceptor env) where
  l <> r =
    ActivityInboundInterceptor
      { executeActivity = \env input next -> executeActivity l env input $ \env' input' -> executeActivity r env' input' next
      }


instance Monoid (ActivityInboundInterceptor env) where
  mempty =
    ActivityInboundInterceptor
      { executeActivity = \env input next -> next env input
      }


data ActivityOutboundInterceptor env = ActivityOutboundInterceptor {}


instance Semigroup (ActivityOutboundInterceptor env) where
  ActivityOutboundInterceptor <> ActivityOutboundInterceptor = ActivityOutboundInterceptor


instance Monoid (ActivityOutboundInterceptor env) where
  mempty = ActivityOutboundInterceptor


data Interceptors env = Interceptors
  { workflowInboundInterceptors :: {-# UNPACK #-} !WorkflowInboundInterceptor
  , workflowOutboundInterceptors :: {-# UNPACK #-} !WorkflowOutboundInterceptor
  , activityInboundInterceptors :: !(ActivityInboundInterceptor env)
  , activityOutboundInterceptors :: !(ActivityOutboundInterceptor env)
  , clientInterceptors :: {-# UNPACK #-} !ClientInterceptors
  , scheduleClientInterceptors :: {-# UNPACK #-} !ScheduleClientInterceptors
  , interceptorVault :: {-# UNPACK #-} !Vault
  }


instance Semigroup (Interceptors env) where
  Interceptors a b c d e f g <> Interceptors a' b' c' d' e' f' g' = Interceptors (a <> a') (b <> b') (c <> c') (d <> d') (e <> e') (f <> f') (g <> g')


instance Monoid (Interceptors env) where
  mempty = Interceptors mempty mempty mempty mempty mempty mempty mempty


data ScheduleClientInterceptors = ScheduleClientInterceptors
  { scheduleWorkflowAction :: StartWorkflowOptions -> [Payload] -> IO StartWorkflowOptions
  -- ^ Unlike the other interceptors, this one is invoked on the construction of the workflow start options
  }


instance Semigroup ScheduleClientInterceptors where
  ScheduleClientInterceptors a <> ScheduleClientInterceptors b =
    ScheduleClientInterceptors
      { scheduleWorkflowAction = \opts input -> do
          opts' <- a opts input
          b opts' input
      }


instance Monoid ScheduleClientInterceptors where
  mempty =
    ScheduleClientInterceptors
      { scheduleWorkflowAction = \opts _ -> return opts
      }


data ExecuteWorkflowInput = ExecuteWorkflowInput
  { executeWorkflowInputType :: Text
  , executeWorkflowInputArgs :: Vector Payload
  , executeWorkflowInputHeaders :: Map Text Payload
  , executeWorkflowInputInfo :: Info
  }


data HandleUpdateInput = HandleUpdateInput
  { handleUpdateId :: UpdateId
  , handleUpdateInputType :: Text
  , handleUpdateInputArgs :: Vector Payload
  , handleUpdateInputHeaders :: Map Text Payload
  }


data WorkflowInboundInterceptor = WorkflowInboundInterceptor
  { executeWorkflow
      :: ExecuteWorkflowInput
      -> (ExecuteWorkflowInput -> IO (WorkflowExitVariant Payload))
      -> IO (WorkflowExitVariant Payload)
  , handleQuery
      :: HandleQueryInput
      -> (HandleQueryInput -> IO (Either SomeException Payload))
      -> IO (Either SomeException Payload)
  , handleUpdate
      :: HandleUpdateInput
      -> (HandleUpdateInput -> IO (Either SomeException Payload))
      -> IO (Either SomeException Payload)
  , validateUpdate
      :: HandleUpdateInput
      -> (HandleUpdateInput -> IO (Either SomeException ()))
      -> IO (Either SomeException ())
  }


instance Semigroup WorkflowInboundInterceptor where
  a <> b =
    WorkflowInboundInterceptor
      { executeWorkflow = \input cont -> a.executeWorkflow input $ \input' -> b.executeWorkflow input' cont
      , handleQuery = \input cont -> a.handleQuery input $ \input' -> b.handleQuery input' cont
      , handleUpdate = \input cont -> a.handleUpdate input $ \input' -> b.handleUpdate input' cont
      , validateUpdate = \input cont -> a.validateUpdate input $ \input' -> b.validateUpdate input' cont
      }


instance Monoid WorkflowInboundInterceptor where
  mempty =
    WorkflowInboundInterceptor
      { executeWorkflow = \input cont -> cont input
      , handleQuery = \input cont -> cont input
      , handleUpdate = \input cont -> cont input
      , validateUpdate = \input cont -> cont input
      }


data ActivityInput = ActivityInput
  { activityType :: Text
  , args :: Vector Payload
  , options :: StartActivityOptions
  , seq :: Sequence
  }


data WorkflowOutboundInterceptor = WorkflowOutboundInterceptor
  { scheduleActivity :: ActivityInput -> (ActivityInput -> IO (Task Payload)) -> IO (Task Payload)
  , startChildWorkflowExecution :: Text -> StartChildWorkflowOptions -> (Text -> StartChildWorkflowOptions -> IO (ChildWorkflowHandle Payload)) -> IO (ChildWorkflowHandle Payload)
  , continueAsNew :: forall a. Text -> ContinueAsNewOptions -> (Text -> ContinueAsNewOptions -> IO a) -> IO a
  }


instance Semigroup WorkflowOutboundInterceptor where
  l <> r =
    WorkflowOutboundInterceptor
      { scheduleActivity = \input cont -> scheduleActivity l input $ \input' -> scheduleActivity r input' cont
      , startChildWorkflowExecution = \t input cont -> startChildWorkflowExecution l t input $ \t' input' -> startChildWorkflowExecution r t' input' cont
      , continueAsNew = \n input cont -> continueAsNew l n input $ \n' input' -> continueAsNew r n' input' cont
      }


instance Monoid WorkflowOutboundInterceptor where
  mempty =
    WorkflowOutboundInterceptor
      { scheduleActivity = \input cont -> cont input
      , startChildWorkflowExecution = \t input cont -> cont t input
      , continueAsNew = \n input cont -> cont n input
      }


data WorkflowExitVariant a
  = WorkflowExitContinuedAsNew ContinueAsNewException
  | WorkflowExitCancelled WorkflowCancelRequested
  | WorkflowExitFailed SomeException
  | WorkflowExitSuccess a


data HandleQueryInput = HandleQueryInput
  { handleQueryId :: Text
  , handleQueryInputType :: Text
  , handleQueryInputArgs :: Vector Payload
  , handleQueryInputHeaders :: Map Text Payload
  }

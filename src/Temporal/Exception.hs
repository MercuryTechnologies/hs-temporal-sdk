{-# LANGUAGE InstanceSigs #-}
module Temporal.Exception where

import Control.Exception
import Control.Exception.Annotated
import Data.Text
import Data.Typeable
import qualified Proto.Temporal.Api.Failure.V1.Message as Proto
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (ContinueAsNewWorkflowExecution)
import Proto.Temporal.Api.Failure.V1.Message
import Temporal.Common

-- | Used to denote that a payload either failed to encode or decode
data ValueError
  = ValueError String
  deriving stock (Show)
instance Exception ValueError

---------------------------------------------------------------------
-- SDK failures

data SomeWorkerException = forall e. Exception e => SomeWorkerException e

instance Show SomeWorkerException where
  show (SomeWorkerException e) = show e

instance Exception SomeWorkerException

workerExceptionToException :: Exception e => e -> SomeException
workerExceptionToException = toException . SomeWorkerException

workerExceptionFromException :: Exception e => SomeException -> Maybe e
workerExceptionFromException x = do
  SomeWorkerException a <- fromException x
  cast a

-- | Errors that are an issue with the worker itself, not the workflow
--
-- These errors should cause the worker to exit, and imply an issue with the
-- SDK itself.
data RuntimeError = RuntimeError String
  deriving stock (Show)

instance Exception RuntimeError where
  toException = workerExceptionToException
  fromException = workerExceptionFromException

-- | Errors that are the fault of the developer, not the SDK.
data ApplicationError 
  = WorkflowNotFound String
  | ActivityNotFound String
  | QueryNotFound String
  deriving stock (Show)

instance Exception ApplicationError where
  toException = workerExceptionToException
  fromException = workerExceptionFromException

---------------------------------------------------------------------
-- Workflow exceptions

data SomeWorkflowException = forall e. Exception e => SomeWorkflowException e

instance Show SomeWorkflowException where
  show (SomeWorkflowException e) = show e

instance Exception SomeWorkflowException

workflowExceptionToException :: Exception e => e -> SomeException
workflowExceptionToException = toException . SomeWorkflowException

workflowExceptionFromException :: Exception e => SomeException -> Maybe e
workflowExceptionFromException x = do
  SomeWorkflowException a <- fromException x
  cast a

data LogicBugType 
  = ReadingCompletionsFailedRun
  | WorkflowActivationDeadlock
  deriving stock (Show)

data LogicBug = LogicBug LogicBugType
  deriving stock (Show)

instance Exception LogicBug where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

-- | Errors intentionally thrown by the developer in the workflow code.
data WorkflowException = forall e. Exception e => WorkflowException e

instance Show WorkflowException where
  show (WorkflowException e) = show e

instance Exception WorkflowException where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data WorkflowAlreadyStarted = WorkflowAlreadyStarted 
  { workflowAlreadyStartedWorkflowId :: Text
  , workflowAlreadyStartedWorkflowType :: Text
  } deriving stock (Show)

instance Exception WorkflowAlreadyStarted where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data ChildWorkflowFailed = ChildWorkflowFailed Proto.Failure
  deriving stock (Show)

instance Exception ChildWorkflowFailed where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data ChildWorkflowCancelled = ChildWorkflowCancelled
  deriving stock (Show, Eq)
  -- { childWorkflowCancelledWorkflowId :: Text
  -- , childWorkflowCancelledWorkflowType :: Text
  -- , childWorkflowCancelledRunId :: Text
  -- } deriving (Show)

instance Exception ChildWorkflowCancelled where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data SignalExternalWorkflowFailed = SignalExternalWorkflowFailed Proto.Failure
  deriving stock (Show)

instance Exception SignalExternalWorkflowFailed where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

-- This does not need to be in the exception hierarchy,
-- since we don't want to catch it in the workflow code.
data ContinueAsNewException = ContinueAsNewException ContinueAsNewWorkflowExecution
  deriving stock (Show)

instance Exception ContinueAsNewException

data AlternativeInstanceFailure = AlternativeInstanceFailure
  deriving stock (Show)

instance Exception AlternativeInstanceFailure where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data CancelExternalWorkflowFailed = CancelExternalWorkflowFailed Proto.Failure
  deriving stock (Show)

instance Exception CancelExternalWorkflowFailed where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

-- TODO, include the payload?
data WorkflowCancelRequested = WorkflowCancelRequested
  deriving stock (Show)

instance Exception WorkflowCancelRequested where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data ActivityCancelled = ActivityCancelled Proto.Temporal.Api.Failure.V1.Message.Failure
  deriving stock (Show, Eq)

instance Exception ActivityCancelled where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data ActivityFailure = ActivityFailure 
  { message :: Text
  , activityType :: ActivityType
  , activityId :: ActivityId
  , retryState :: RetryState
  , identity :: Text
  , cause :: Proto.Temporal.Api.Failure.V1.Message.Failure
  } -- Proto.Temporal.Api.Failure.V1.Message.Failure
  deriving stock (Show, Eq)

instance Exception ActivityFailure where
  toException = workflowExceptionToException
  fromException = workflowExceptionFromException

data NonRetryableErrorAnnotation = NonRetryableErrorAnnotation Bool
  deriving stock (Show, Eq)

nonRetryableError :: Annotation
nonRetryableError = Annotation $ NonRetryableErrorAnnotation True

---------------------------------------------------------------------
-- Activity exceptions

data SomeActivityException = forall e. Exception e => SomeActivityException e

instance Show SomeActivityException where
  show (SomeActivityException e) = show e

instance Exception SomeActivityException

activityExceptionToException :: Exception e => e -> SomeException
activityExceptionToException = toException . SomeActivityException

activityExceptionFromException :: Exception e => SomeException -> Maybe e
activityExceptionFromException x = do
  SomeActivityException a <- fromException x
  cast a

{- | 
Asynchronous Activity Completion is a feature that enables an Activity Function to return without causing the Activity Execution to complete. The Temporal Client can then be used to both Heartbeat Activity Execution progress and eventually provide a result.

The intended use-case for this feature is when an external system has the final result of a computation, started by an Activity.

Consider using Asynchronous Activities instead of Signals if the external process is unreliable and might fail to send critical status updates through a Signal.

Consider using Signals as an alternative to Asynchronous Activities to return data back to a Workflow Execution if there is a human in the process loop. The reason is that a human in the loop means multiple steps in the process. The first is the Activity Function that stores state in an external system and at least one other step where a human would “complete” the activity. If the first step fails, you want to detect that quickly and retry instead of waiting for the entire process, which could be significantly longer when humans are involved.
-}
data CompleteAsync = CompleteAsync
  deriving stock (Show)

instance Exception CompleteAsync where
  toException = activityExceptionToException
  fromException = activityExceptionFromException


data WorkflowExecutionClosed 
  = WorkflowExecutionFailed
  | WorkflowExecutionTimedOut
  | WorkflowExecutionCanceled
  | WorkflowExecutionTerminated
  | WorkflowExecutionContinuedAsNew
  deriving stock (Show, Eq)

instance Exception WorkflowExecutionClosed
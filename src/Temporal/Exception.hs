{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE InstanceSigs #-}
module Temporal.Exception where

import Control.Exception
import Control.Exception.Annotated
import Data.Annotation
import Data.Int
import Data.Text
import Data.Typeable
import GHC.Stack
import qualified Proto.Temporal.Api.Failure.V1.Message as Proto
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (ContinueAsNewWorkflowExecution)
import Proto.Temporal.Api.Failure.V1.Message
import Temporal.Common
import Temporal.Payload

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
data WorkflowNotFound = WorkflowNotFound String
  deriving stock (Show)

instance Exception WorkflowNotFound where
  toException = workerExceptionToException
  fromException = workerExceptionFromException

data ActivityNotFound = ActivityNotFound String
  deriving stock (Show)

instance Exception ActivityNotFound where
  toException = workerExceptionToException
  fromException = workerExceptionFromException

data QueryNotFound = QueryNotFound String
  deriving stock (Show)

instance Exception QueryNotFound where
  toException = workerExceptionToException
  fromException = workerExceptionFromException

---------------------------------------------------------------------
-- Workflow exceptions

data LogicBugType 
  = ReadingCompletionsFailedRun
  | WorkflowActivationDeadlock
  deriving stock (Show)

data LogicBug = LogicBug LogicBugType
  deriving stock (Show)

instance Exception LogicBug

data WorkflowAlreadyStarted = WorkflowAlreadyStarted 
  { workflowAlreadyStartedWorkflowId :: Text
  , workflowAlreadyStartedWorkflowType :: Text
  } deriving stock (Show)

instance Exception WorkflowAlreadyStarted

data ChildWorkflowFailed = ChildWorkflowFailed Proto.Failure
  deriving stock (Show)

instance Exception ChildWorkflowFailed

data ChildWorkflowCancelled = ChildWorkflowCancelled
  deriving stock (Show, Eq)
  -- { childWorkflowCancelledWorkflowId :: Text
  -- , childWorkflowCancelledWorkflowType :: Text
  -- , childWorkflowCancelledRunId :: Text
  -- } deriving (Show)

instance Exception ChildWorkflowCancelled

data SignalExternalWorkflowFailed = SignalExternalWorkflowFailed Proto.Failure
  deriving stock (Show)

instance Exception SignalExternalWorkflowFailed

-- This does not need to be in the exception hierarchy,
-- since we don't want to catch it in the workflow code.
data ContinueAsNewException = ContinueAsNewException ContinueAsNewWorkflowExecution
  deriving stock (Show)

instance Exception ContinueAsNewException

data AlternativeInstanceFailure = AlternativeInstanceFailure
  deriving stock (Show)

instance Exception AlternativeInstanceFailure where

data CancelExternalWorkflowFailed = CancelExternalWorkflowFailed Proto.Failure
  deriving stock (Show)

instance Exception CancelExternalWorkflowFailed where

-- TODO, include the payload?
data WorkflowCancelRequested = WorkflowCancelRequested
  deriving stock (Show)

instance Exception WorkflowCancelRequested where

data ActivityCancelled = ActivityCancelled Proto.Temporal.Api.Failure.V1.Message.Failure
  deriving stock (Show, Eq)

instance Exception ActivityCancelled where

data ApplicationFailure = ApplicationFailure
  { type' :: Text
  , message :: Text
  , nonRetryable :: Bool
  , details :: [Payload]
  , stack :: Text
  } 
  deriving stock (Show, Eq)

instance Exception ApplicationFailure where

class ToApplicationFailure e where
  toApplicationFailure :: e -> ApplicationFailure

data ApplicationFailureHandler where 
  ApplicationFailureHandler :: Exception e => (e -> ApplicationFailure) -> ApplicationFailureHandler

mkApplicationFailure :: SomeException -> [ApplicationFailureHandler] -> ApplicationFailure
mkApplicationFailure e handlers = Prelude.foldr tryHandler (ApplicationFailure "" "" False [] "") handlers
  where
    tryHandler (ApplicationFailureHandler hndlr) acc = case fromException e of
      Just e' -> hndlr e'
      Nothing -> acc

mkAnnotatedHandlers :: HasCallStack => [ApplicationFailureHandler] -> [ApplicationFailureHandler]
mkAnnotatedHandlers xs =
  xs >>= \(ApplicationFailureHandler hndlr) ->
    [ ApplicationFailureHandler $ \e -> hndlr e
    , ApplicationFailureHandler $ \(AnnotatedException anns e) -> let base = (hndlr e) in base
      { stack = if base.stack == "" 
        then case tryAnnotations anns of
          (cs : _, _) -> pack $ prettyCallStack cs
          (_, _) -> base.stack
        else base.stack
      -- TODO, convert other annotations to details
      -- , details = if not $ null (details base) then _ else details base
      , nonRetryable = case tryAnnotations anns of
          (NonRetryableErrorAnnotation b : _, _) -> b || nonRetryable base
          (_, _) -> nonRetryable base
      }
    ]

standardApplicationFailureHandlers :: [ApplicationFailureHandler]
standardApplicationFailureHandlers =
  [ ApplicationFailureHandler $ \(h@ApplicationFailure{}) -> h
  , ApplicationFailureHandler $ \(ErrorCallWithLocation msg loc) ->
      ApplicationFailure
        { type' = "ErrorCallWithLocation"
        , message = pack msg
        , nonRetryable = False
        , details = []
        , stack = pack loc
        }
  , ApplicationFailureHandler $ \(SomeException e) ->
      ApplicationFailure
        { type' = pack $ show $ typeOf e
        , message = pack $ displayException e
        , nonRetryable = False
        , details = []
        , stack = ""
        }
  ]

data ActivityFailure = ActivityFailure 
  { message :: Text
  , activityType :: ActivityType
  , activityId :: ActivityId
  , retryState :: RetryState
  , identity :: Text
  , cause :: ApplicationFailure
  , scheduledEventId :: Int64
  , startedEventId :: Int64
  , original :: ActivityFailureInfo
  , stack :: Text
  }
  deriving stock (Show, Eq)

instance Exception ActivityFailure where

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
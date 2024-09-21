{-# LANGUAGE DuplicateRecordFields #-}

module Temporal.Exception (
  module Temporal.Exception,
  ActivityType (..),
  RetryState (..),
) where

import Control.Applicative (Alternative (..))
import Control.Exception
import Control.Exception.Annotated
import Data.Annotation
import Data.Int
import Data.ProtoLens (Message (..))
import Data.Text
import Data.Typeable
import Data.Vector (Vector)
import GHC.Stack
import Lens.Family2
import qualified Proto.Temporal.Api.Common.V1.Message as Common
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Common
import Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Api.Failure.V1.Message as F
import qualified Proto.Temporal.Api.Failure.V1.Message as Proto
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import Proto.Temporal.Api.History.V1.Message
import System.IO.Unsafe (unsafePerformIO)
import Temporal.Common
import Temporal.Duration
import Temporal.Payload
import Temporal.Workflow.Types


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


-- type SomeFailure = Failure (Maybe FailureInfo)

-- data Failure = Failure
--   { message :: Text
--   , source :: Text
--   , stackTrace :: Text
--   , encodedAttributes :: Maybe Payload
--   , cause :: Maybe Failure
--   , failureInfo :: Maybe FailureInfo
--   }

-- data FailureInfo
--   = ApplicationFailureInfo ApplicationFailure
--   | TimeoutFailureInfo TimeoutFailure
--   | CanceledFailureInfo CanceledFailure
--   | TerminatedFailureInfo TerminatedFailure
--   | ServerFailureInfo ServerFailure
--   | ResetWorkflowFailureInfo ResetWorkflowFailure
--   | ActivityFailureInfo ActivityFailure
--   | ChildWorkflowExecutionFailureInfo ChildWorkflowExecutionFailure

-- data ApplicationFailureInfo = ApplicationFailureInfo
--   { type' :: Text
--   , nonRetryable :: Bool
--   , details :: Vector Payload
--   }

-- data TimeoutFailureInfo = TimeoutFailureInfo
--   { timeoutType :: TimeoutTime
--   , lastHeartbeatDetails :: Vector Payload
--   }

-- data CanceledFailureInfo = CanceledFailureInfo
--   { details :: Vector Payload
--   }

-- data ResetWorkflowFailureInfo = ResetWorkflowFailureInfo
--   { lastHeartbeatDetails :: Vector Payload
--   }

-- data TerminatedFailure = TerminatedFailure

-- data ServerFailure = ServerFailure
--   { nonRetryable :: Bool
--   }

-- data ActivityFailure = ActivityFailure
--   { scheduledEventId :: Int64
--   , startedEventId :: Int64
--   , identity :: Text
--   , activityType :: ActivityType
--   , activityId :: ActivityId
--   , retryState :: RetryState
--   }

-- data ChildWorkflowExecutionFailure = ChildWorkflowExecutionFailure
--   { namespace :: Text
--   , workflowExecution :: WorkflowExecution
--   , workflowType :: WorkflowType
--   , initiatedEventId :: Int64
--   , startedEventId :: Int64
--   , retryState :: RetryState
--   }

{- | Errors that are an issue with the worker itself, not the workflow

These errors should cause the worker to exit, and imply an issue with the
SDK itself.
-}
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
  { workflowAlreadyStartedWorkflowId :: WorkflowId
  , workflowAlreadyStartedWorkflowType :: WorkflowType
  }
  deriving stock (Show)


instance Exception WorkflowAlreadyStarted


data ChildWorkflowFailed = ChildWorkflowFailed Proto.Failure
  deriving stock (Show)


instance Exception ChildWorkflowFailed


data ChildWorkflowCancelled = ChildWorkflowCancelled
  deriving stock (Show, Eq)


-- { childWorkflowCancelledWorkflowId :: WorkflowId
-- , childWorkflowCancelledWorkflowType :: WorkflowType
-- , childWorkflowCancelledRunId :: Text
-- } deriving (Show)

instance Exception ChildWorkflowCancelled


data SignalExternalWorkflowFailed = SignalExternalWorkflowFailed Proto.Failure
  deriving stock (Show)


instance Exception SignalExternalWorkflowFailed


-- This does not need to be in the exception hierarchy,
-- since we don't want to catch it in the workflow code.
data ContinueAsNewException = ContinueAsNewException
  { continueAsNewWorkflowType :: WorkflowType
  , continueAsNewArguments :: Vector Payload
  , continueAsNewOptions :: ContinueAsNewOptions
  }
  deriving stock (Show)


instance Exception ContinueAsNewException


data AlternativeInstanceFailure = AlternativeInstanceFailure
  deriving stock (Show)


instance Exception AlternativeInstanceFailure


data CancelExternalWorkflowFailed = CancelExternalWorkflowFailed Proto.Failure
  deriving stock (Show)


instance Exception CancelExternalWorkflowFailed


-- TODO, include the payload?
data WorkflowCancelRequested = WorkflowCancelRequested
  deriving stock (Show)


instance Exception WorkflowCancelRequested


data ActivityCancelled = ActivityCancelled Proto.Temporal.Api.Failure.V1.Message.Failure
  deriving stock (Show, Eq)


instance Exception ActivityCancelled


data ApplicationFailure = ApplicationFailure
  { type' :: Text
  , message :: Text
  , nonRetryable :: Bool
  , details :: [Payload]
  , stack :: Text
  , nextRetryDelay :: Maybe Duration
  }
  deriving stock (Show, Eq)


applicationFailureToFailureProto :: ApplicationFailure -> F.Failure
applicationFailureToFailureProto appFailure =
  defMessage
    & F.message .~ appFailure.message
    & F.source .~ "hs-temporal-sdk"
    & F.stackTrace .~ appFailure.stack
    & F.applicationFailureInfo
      .~ ( defMessage
            & F.type' .~ appFailure.type'
            & F.details .~ (defMessage @Common.Payloads & Common.payloads .~ fmap convertToProtoPayload appFailure.details)
            & F.nonRetryable .~ appFailure.nonRetryable
            & F.maybe'nextRetryDelay .~ fmap durationToProto appFailure.nextRetryDelay
         )


instance Exception ApplicationFailure


class ToApplicationFailure e where
  toApplicationFailure :: e -> ApplicationFailure


data SomeApplicationFailure = forall e. (Exception e, ToApplicationFailure e) => SomeApplicationFailure e


instance Show SomeApplicationFailure where
  show :: SomeApplicationFailure -> String
  show (SomeApplicationFailure e) = show e


instance Exception SomeApplicationFailure


applicationFailureToException :: (Exception e, ToApplicationFailure e) => e -> SomeException
applicationFailureToException e = toException $ SomeApplicationFailure e


applicationFailureFromException :: Exception e => SomeException -> Maybe e
applicationFailureFromException e = do
  (SomeApplicationFailure e') <- fromException e
  cast e'


data ApplicationFailureHandler where
  ApplicationFailureHandler :: Exception e => (e -> ApplicationFailure) -> ApplicationFailureHandler


-- Stripped down callstack rendering to work better in the Temporal UI.
prettySrcLoc :: SrcLoc -> String
prettySrcLoc SrcLoc {..} =
  mconcat
    [ srcLocFile
    , ":"
    , show srcLocStartLine
    , ":"
    , show srcLocStartCol
    , " in "
    , srcLocPackage
    , ":"
    , srcLocModule
    ]


{- | Pretty print a 'CallStack'.

@since 4.9.0.0
-}
prettyCallStack :: CallStack -> String
prettyCallStack = Prelude.unlines . prettyCallStackLines


prettyCallStackLines :: CallStack -> [String]
prettyCallStackLines cs = case getCallStack cs of
  [] -> []
  stk -> Prelude.map prettyCallSite stk
  where
    prettyCallSite (f, loc) = f ++ ", called at " ++ Temporal.Exception.prettySrcLoc loc


mkApplicationFailure :: SomeException -> [ApplicationFailureHandler] -> ApplicationFailure
mkApplicationFailure e@(SomeException e') = Prelude.foldr tryHandler (basicHandler e')
  where
    tryHandler (ApplicationFailureHandler hndlr) acc = maybe acc hndlr $ fromException e


annToPayload :: Annotation -> Payload
annToPayload ann = unsafePerformIO $ encode JSON $ show ann


annotationHandler :: Exception e => (e -> ApplicationFailure) -> AnnotatedException e -> ApplicationFailure
annotationHandler hndlr (AnnotatedException anns e) =
  let
    -- wrapped = toException
    base = hndlr e
    (stack', annsWithoutStack) = tryAnnotations anns
    (nonRetryable', annsWithoutStackOrRetry) = tryAnnotations annsWithoutStack
    (nextRetryDelay', annsWithoutDelay) = tryAnnotations annsWithoutStackOrRetry
  in
    base
      { stack =
          if base.stack == ""
            then case stack' of
              (cs : _) -> pack $ Temporal.Exception.prettyCallStack cs
              _ -> base.stack
            else base.stack
      , details = Prelude.map annToPayload annsWithoutDelay ++ base.details
      , nonRetryable = case nonRetryable' of
          (NonRetryableError b : _) -> b || nonRetryable base
          _ -> nonRetryable base
      , nextRetryDelay = case nextRetryDelay' of
          (NextRetryDelay d : _) -> d <|> nextRetryDelay base
          _ -> nextRetryDelay base
      }


basicHandler :: Exception e => e -> ApplicationFailure
basicHandler e = case toException e of
  (SomeException e') ->
    ApplicationFailure
      { type' = pack $ show $ typeOf e'
      , message = pack $ displayException e'
      , nonRetryable = False
      , details = []
      , stack = ""
      , nextRetryDelay = Nothing
      }


mkAnnotatedHandlers :: [ApplicationFailureHandler] -> [ApplicationFailureHandler]
mkAnnotatedHandlers xs =
  ( xs >>= \(ApplicationFailureHandler hndlr) ->
      [ ApplicationFailureHandler hndlr
      , ApplicationFailureHandler $ \e -> annotationHandler hndlr e
      ]
  )
    ++ [ApplicationFailureHandler $ \e -> annotationHandler basicHandler (e :: AnnotatedException SomeException)]


standardApplicationFailureHandlers :: [ApplicationFailureHandler]
standardApplicationFailureHandlers =
  [ ApplicationFailureHandler $ \h@ApplicationFailure {} -> h
  , ApplicationFailureHandler $ \(SomeApplicationFailure e) -> toApplicationFailure e
  , ApplicationFailureHandler $ \(ErrorCallWithLocation msg loc) ->
      ApplicationFailure
        { type' = "ErrorCallWithLocation"
        , message = pack msg
        , nonRetryable = False
        , details = []
        , stack = pack loc
        , nextRetryDelay = Nothing
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


instance Exception ActivityFailure


data NonRetryableError = NonRetryableError Bool
  deriving stock (Show, Eq)


annotateNonRetryableError :: Annotation
annotateNonRetryableError = Annotation $ NonRetryableError True


annotateRetryableError :: Annotation
annotateRetryableError = Annotation $ NonRetryableError False


data NextRetryDelay = NextRetryDelay (Maybe Duration)
  deriving stock (Show, Eq)


annotateNextRetryDelay :: Duration -> Annotation
annotateNextRetryDelay = Annotation . NextRetryDelay . pure


annotateNoRetryDelay :: Annotation
annotateNoRetryDelay = Annotation $ NextRetryDelay Nothing


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
  = WorkflowExecutionFailed WorkflowExecutionFailedEventAttributes
  | WorkflowExecutionTimedOut
  | WorkflowExecutionCanceled
  | WorkflowExecutionTerminated
  | WorkflowExecutionContinuedAsNew
  deriving stock (Show, Eq)


instance Exception WorkflowExecutionClosed


data WorkflowExecutionFailedAttributes = WorkflowExecutionFailedAttributes
  { failure :: Maybe Failure
  , retryState :: RetryState
  , workflowTaskCompletedEventId :: Int64
  , newExecutionRunId :: Maybe RunId
  }
  deriving stock (Show, Eq)

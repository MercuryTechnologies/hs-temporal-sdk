{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Workflow.WorkflowInstance where
import Control.Applicative (liftA2)
import Control.Concurrent.Async (Async)
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.State.Class
import Data.Hashable (Hashable)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Int
import Data.IORef (IORef)
import Data.ProtoLens
import Data.Set (Set)
import Data.Text (Text)
import Data.Vector (Vector)
import Data.Word
import Lens.Family2
import Temporal.Common
import Temporal.Exception
import Temporal.Payload
import Temporal.Worker.Types
import System.Clock
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  , WorkflowCommand'Variant(..)
  , CompleteWorkflowExecution
  )
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
  ( WorkflowActivation
  , FireTimer
  , UpdateRandomSeed
  , QueryWorkflow
  , CancelWorkflow
  , StartWorkflow
  , SignalWorkflow
  , ResolveActivity
  , NotifyHasPatch
  , ResolveChildWorkflowExecutionStart
  , ResolveChildWorkflowExecution
  , ResolveSignalExternalWorkflow
  , ResolveRequestCancelExternalWorkflow
  , WorkflowActivationJob
  , WorkflowActivationJob'Variant(..)
  )
import UnliftIO hiding (catch)


emptySequences :: SequenceMaps
emptySequences = SequenceMaps mempty mempty mempty mempty mempty mempty

isEmpty :: SequenceMaps -> Bool
isEmpty SequenceMaps{..} = 
  HashMap.null timers &&
  HashMap.null activities &&
  HashMap.null childWorkflows &&
  HashMap.null externalSignals &&
  HashMap.null externalCancels &&
  HashMap.null conditionsAwaitingSignal


-- done :: ResultVal a -> InstanceM env (Result env a)
-- done (Ok a _) = return (Done a)
-- done (ThrowWorkflow e _) = raise e
-- done (ThrowInternal e) = throwIO e

-- eitherToResultThrowIO :: Either SomeException a -> ResultVal a
-- eitherToResultThrowIO (Right a) = Ok a NilWrites
-- eitherToResultThrowIO (Left e)
--   | Just HaxlException{} <- fromException e = ThrowHaxl e NilWrites
--   | otherwise = ThrowIO e

-- eitherToResult :: Either SomeException a -> ResultVal a
-- eitherToResult (Right a) = Ok a NilWrites
-- eitherToResult (Left e) = ThrowWorkflow e NilWrites

-- -----------------------------------------------------------------------------
-- ResultVar

-- | A sink for the result of a data fetch in 'BlockedFetch'
newtype ResultVar a =
  ResultVar (Either SomeException a -> IO ())

mkResultVar
  :: (Either SomeException a -> IO ())
  -> ResultVar a
mkResultVar = ResultVar

putFailure :: (Exception e) => ResultVar a -> e -> IO ()
putFailure r = putResult r . except

putSuccess :: ResultVar a -> a -> IO ()
putSuccess r = putResult r . Right

putResult :: ResultVar a -> Either SomeException a -> IO ()
putResult (ResultVar io) res = io res

except :: (Exception e) => e -> Either SomeException a
except = Left . toException

-- TODO default to WaitCancellationCompleted per protobuf docs
{- |
Defines how the workflow will wait (or not) for cancellation of the 
activity to be confirmed.
-}
data ActivityCancellationType 
  = ActivityCancellationTryCancel 
  -- ^ Initiate a cancellation request and immediately report cancellation to the workflow.
  | ActivityCancellationWaitCancellationCompleted 
  -- ^ Wait for activity cancellation completion. Note that activity must heartbeat to receive a
  -- cancellation notification. This can block the cancellation for a long time if activity
  -- doesn't heartbeat or chooses to ignore the cancellation request.
  | ActivityCancellationAbandon
  -- ^ Do not request cancellation of the activity and immediately report cancellation to the
  -- workflow

activityCancellationTypeToProto :: ActivityCancellationType -> Command.ActivityCancellationType
activityCancellationTypeToProto ActivityCancellationTryCancel = Command.TRY_CANCEL
activityCancellationTypeToProto ActivityCancellationWaitCancellationCompleted = Command.WAIT_CANCELLATION_COMPLETED
activityCancellationTypeToProto ActivityCancellationAbandon = Command.ABANDON

-- | Controls at which point to report back when a child workflow is cancelled.
data ChildWorkflowCancellationType 
  = ChildWorkflowCancellationAbandon 
  -- ^  Do not request cancellation of the child workflow if already scheduled
  | ChildWorkflowCancellationTryCancel 
  -- ^ Initiate a cancellation request and immediately report cancellation to the parent workflow
  | ChildWorkflowCancellationWaitCancellationCompleted 
  -- ^ Wait for child cancellation completion.
  | ChildWorkflowCancellationWaitCancellationRequested
  -- ^ Request cancellation of the child and wait for confirmation that the request was received.

childWorkflowCancellationTypeToProto :: ChildWorkflowCancellationType -> ChildWorkflow.ChildWorkflowCancellationType
childWorkflowCancellationTypeToProto ChildWorkflowCancellationAbandon = ChildWorkflow.ABANDON
childWorkflowCancellationTypeToProto ChildWorkflowCancellationTryCancel = ChildWorkflow.TRY_CANCEL
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationCompleted = ChildWorkflow.WAIT_CANCELLATION_COMPLETED
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationRequested = ChildWorkflow.WAIT_CANCELLATION_REQUESTED

-- | Used by the service to determine the fate of a child workflow
-- in case its parent is closed.
data ParentClosePolicy 
  = ParentClosePolicyUnspecified 
  -- ^ Lets the server set the default.
  | ParentClosePolicyTerminate 
  -- ^ Terminate the child workflow.
  | ParentClosePolicyAbandon 
  -- ^ Do not terminate the child workflow. The child workflow continues to run.
  | ParentClosePolicyRequestCancel
  -- ^ Request cancellation on the child workflow.

parentClosePolicyToProto :: ParentClosePolicy -> ChildWorkflow.ParentClosePolicy
parentClosePolicyToProto ParentClosePolicyUnspecified = ChildWorkflow.PARENT_CLOSE_POLICY_UNSPECIFIED
parentClosePolicyToProto ParentClosePolicyTerminate = ChildWorkflow.PARENT_CLOSE_POLICY_TERMINATE
parentClosePolicyToProto ParentClosePolicyAbandon = ChildWorkflow.PARENT_CLOSE_POLICY_ABANDON
parentClosePolicyToProto ParentClosePolicyRequestCancel = ChildWorkflow.PARENT_CLOSE_POLICY_REQUEST_CANCEL

{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Workflow.WorkflowInstance where
import qualified Data.HashMap.Strict as HashMap
import Temporal.Common.ActivityOptions
import Temporal.Common.ContinueAsNewOptions
import Temporal.Worker.Types
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import UnliftIO hiding (catch)

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

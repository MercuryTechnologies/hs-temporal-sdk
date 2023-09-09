{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Workflow.WorkflowInstance where
import qualified Data.HashMap.Strict as HashMap
import Temporal.Worker.Types
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import UnliftIO hiding (catch)
import Temporal.Workflow.Types

activityCancellationTypeToProto :: ActivityCancellationType -> Command.ActivityCancellationType
activityCancellationTypeToProto ActivityCancellationTryCancel = Command.TRY_CANCEL
activityCancellationTypeToProto ActivityCancellationWaitCancellationCompleted = Command.WAIT_CANCELLATION_COMPLETED
activityCancellationTypeToProto ActivityCancellationAbandon = Command.ABANDON

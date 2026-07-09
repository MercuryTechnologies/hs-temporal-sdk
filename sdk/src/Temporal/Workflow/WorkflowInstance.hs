{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}

module Temporal.Workflow.WorkflowInstance where

import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import Temporal.Workflow.Types


activityCancellationTypeToProto :: ActivityCancellationType -> Command.ActivityCancellationType
activityCancellationTypeToProto ActivityCancellationTryCancel = Command.ActivityCancellationType'TryCancel
activityCancellationTypeToProto ActivityCancellationWaitCancellationCompleted = Command.ActivityCancellationType'WaitCancellationCompleted
activityCancellationTypeToProto ActivityCancellationAbandon = Command.ActivityCancellationType'Abandon

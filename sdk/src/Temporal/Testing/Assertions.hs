module Temporal.Testing.Assertions (
  assertWorkflowExecutionExists,
  assertWorkflowExecutionDoesNotExist,
) where

import Control.Monad (unless, when)
import Control.Monad.IO.Class
import GHC.Stack
import Temporal.Client (HasWorkflowClient, checkWorkflowExecutionExists)
import Temporal.Common (WorkflowId)
import Temporal.Workflow.Definition (WorkflowRef)


-- | Assert that a workflow execution exists on the Temporal server
assertWorkflowExecutionExists :: (MonadIO m, HasWorkflowClient m, WorkflowRef wf, HasCallStack) => wf -> WorkflowId -> m ()
assertWorkflowExecutionExists wfRef wfId = do
  exists <- checkWorkflowExecutionExists wfRef wfId
  unless exists $
    error $
      "Expected workflow execution to exist: " <> show wfId


-- | Assert that a workflow execution does not exist on the Temporal server
assertWorkflowExecutionDoesNotExist :: (MonadIO m, HasWorkflowClient m, WorkflowRef wf, HasCallStack) => wf -> WorkflowId -> m ()
assertWorkflowExecutionDoesNotExist wfRef wfId = do
  exists <- checkWorkflowExecutionExists wfRef wfId
  when exists $
    error $
      "Expected workflow execution to not exist: " <> show wfId

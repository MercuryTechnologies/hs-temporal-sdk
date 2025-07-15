module Temporal.Testing.Assertions (
  assertWorkflowExecutionExists,
  assertWorkflowExecutionDoesNotExist,
  WorkflowAssertionFailure (..),
) where

import Control.Exception (Exception, throwIO)
import Control.Monad (unless, when)
import Control.Monad.IO.Class
import GHC.Stack
import Temporal.Client (HasWorkflowClient, checkWorkflowExecutionExists)
import Temporal.Common (WorkflowId)
import Temporal.Workflow.Definition (WorkflowRef)


-- | Exception thrown when workflow assertion fails
data WorkflowAssertionFailure
  = WorkflowShouldExist WorkflowId
  | WorkflowShouldNotExist WorkflowId
  deriving (Show, Eq)


instance Exception WorkflowAssertionFailure


-- | Assert that a workflow execution exists on the Temporal server
assertWorkflowExecutionExists :: (MonadIO m, HasWorkflowClient m, WorkflowRef wf, HasCallStack) => wf -> WorkflowId -> m ()
assertWorkflowExecutionExists wfRef wfId = do
  exists <- checkWorkflowExecutionExists wfRef wfId
  unless exists $
    liftIO $
      throwIO $
        WorkflowShouldExist wfId


-- | Assert that a workflow execution does not exist on the Temporal server
assertWorkflowExecutionDoesNotExist :: (MonadIO m, HasWorkflowClient m, WorkflowRef wf, HasCallStack) => wf -> WorkflowId -> m ()
assertWorkflowExecutionDoesNotExist wfRef wfId = do
  exists <- checkWorkflowExecutionExists wfRef wfId
  when exists $
    liftIO $
      throwIO $
        WorkflowShouldNotExist wfId

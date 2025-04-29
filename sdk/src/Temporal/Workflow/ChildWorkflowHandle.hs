module Temporal.Workflow.ChildWorkflowHandle where

import Control.Monad
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation (ResolveChildWorkflowExecution)
import Temporal.Common
import Temporal.Payload
import Temporal.Workflow.IVar


{- | A client side handle to a single child Workflow instance.

It can be used to signal, wait for completion, and cancel the workflow.
-}
data ChildWorkflowHandle result = ChildWorkflowHandle
  { childWorkflowSequence :: Sequence
  , startHandle :: IVar ()
  , resultHandle :: IVar ResolveChildWorkflowExecution
  , childWorkflowResultConverter :: Payload -> IO result
  , childWorkflowId :: WorkflowId
  , firstExecutionRunId :: IVar RunId
  }


instance Functor ChildWorkflowHandle where
  fmap f h = h {childWorkflowResultConverter = fmap f . childWorkflowResultConverter h}


{- | This is only intended for use by interceptors. Normal workflow code should be able to use
the 'fmap' instance for simple transformations or else provide an appropriate codec.
-}
interceptorConvertChildWorkflowHandle :: ChildWorkflowHandle a -> (a -> IO b) -> ChildWorkflowHandle b
interceptorConvertChildWorkflowHandle h f =
  h
    { childWorkflowResultConverter = childWorkflowResultConverter h >=> f
    }

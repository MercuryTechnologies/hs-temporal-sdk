-- | The internals of Workflow handles. They are exposed here primarily for interceptor implementations.
module Temporal.Workflow.Unsafe.Handle where

import Control.Monad.Reader
import qualified Data.HashMap.Strict as HashMap
import Data.Kind
import Data.ProtoLens
import Lens.Family2
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow_Fields as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as Common
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import RequireCallStack
import Temporal.Common
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.Internal.Instance
import Temporal.Workflow.Internal.Monad
import UnliftIO


{- | Some tasks in a Workflow return a handle that can be used to wait for the task to complete.

This class provides a common interface for waiting on these handles.
-}
class Wait h where
  type WaitResult h :: Type


  -- | Wait for a handle on an an action to complete.
  wait :: RequireCallStack => h -> WaitResult h


{- | Some tasks in a Workflow return a handle that can be used to cancel a task.

This class provides a common interface for performing cancellation on these handles.
-}
class Cancel h where
  type CancelResult h :: Type


  -- | Signal to Temporal that a handle representing an async action should be cancelled.
  cancel :: RequireCallStack => h -> CancelResult h


instance Wait (Task a) where
  type WaitResult (Task a) = Workflow a
  wait t = do
    updateCallStackW
    t.waitAction


instance Cancel (Task a) where
  type CancelResult (Task a) = Workflow ()
  cancel t = do
    updateCallStackW
    t.cancelAction


{- | Returns an action that can be used to await cancellation of an external workflow.

Throws 'CancelExternalWorkflowFailed' if the cancellation request failed.
-}
instance Cancel (ExternalWorkflowHandle a) where
  type CancelResult (ExternalWorkflowHandle a) = Workflow (Workflow ())


  cancel h = ilift $ do
    inst <- ask
    s@(Sequence sVal) <- nextExternalSignalSequence
    res <- newIVar
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps {externalSignals = HashMap.insert s res (externalSignals seqMaps)}
    addCommand
      ( defMessage
          & Command.requestCancelExternalWorkflowExecution
            .~ ( defMessage
                  & Command.seq .~ sVal
                  & Command.workflowExecution
                    .~ ( defMessage
                          & Common.workflowId .~ rawWorkflowId h.externalWorkflowWorkflowId
                          & Common.runId .~ maybe "" rawRunId h.externalWorkflowRunId
                       )
               )
      )
    pure $ do
      res' <- getIVar res
      case res' ^. Activation.maybe'failure of
        Nothing -> pure ()
        Just f -> throw $ CancelExternalWorkflowFailed f


instance Wait (ChildWorkflowHandle a) where
  type WaitResult (ChildWorkflowHandle a) = Workflow a
  wait = waitChildWorkflowResult


waitChildWorkflowStart :: RequireCallStack => ChildWorkflowHandle result -> Workflow ()
waitChildWorkflowStart wfHandle = do
  updateCallStackW
  getIVar wfHandle.startHandle


waitChildWorkflowResult :: RequireCallStack => ChildWorkflowHandle result -> Workflow result
waitChildWorkflowResult wfHandle@(ChildWorkflowHandle {childWorkflowResultConverter}) = do
  updateCallStackW
  res <- getIVar wfHandle.resultHandle
  case res ^. Activation.result . ChildWorkflow.maybe'status of
    Nothing -> ilift $ throwIO $ RuntimeError "Unrecognized child workflow result status"
    Just s -> case s of
      ChildWorkflow.ChildWorkflowResult'Completed res' -> do
        eVal <- ilift $ liftIO $ UnliftIO.try $ childWorkflowResultConverter $ convertFromProtoPayload $ res' ^. ChildWorkflow.result
        case eVal of
          Left err -> throw (err :: SomeException)
          Right ok -> pure ok
      ChildWorkflow.ChildWorkflowResult'Failed res' -> throw $ ChildWorkflowFailed $ res' ^. ChildWorkflow.failure
      ChildWorkflow.ChildWorkflowResult'Cancelled _ -> throw ChildWorkflowCancelled


instance Cancel (ChildWorkflowHandle a) where
  type CancelResult (ChildWorkflowHandle a) = Workflow ()
  cancel h = do
    updateCallStackW
    cancelChildWorkflowExecution h


cancelChildWorkflowExecution :: RequireCallStack => ChildWorkflowHandle result -> Workflow ()
cancelChildWorkflowExecution ChildWorkflowHandle {childWorkflowSequence} = ilift $ do
  updateCallStack
  -- I don't see a way to block on this? I guess Temporal wants us to rely on the orchestrator
  -- managing the cancellation. Compare with ResolveRequestCancelExternalWorkflow. I think
  -- external workflows need a resolution step because they may not even exist.
  addCommand $
    defMessage
      & Command.cancelChildWorkflowExecution
        .~ ( defMessage
              & Command.childWorkflowSeq .~ rawSequence childWorkflowSequence
           )

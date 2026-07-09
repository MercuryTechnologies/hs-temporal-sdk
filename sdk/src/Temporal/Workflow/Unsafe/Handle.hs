-- | The internals of Workflow handles. They are exposed here primarily for interceptor implementations.
module Temporal.Workflow.Unsafe.Handle where

import Control.Monad.Reader
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe (fromMaybe)
import Data.Kind
import Proto.Decode (decodeMessage)
import Proto.Encode (encodeMessage)
import Lens.Family2
import qualified Proto.Temporal.Api.Failure.V1.Message as Failure
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.Common.Common as Common
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation (
  ResolveChildWorkflowExecution (..),
  ResolveRequestCancelExternalWorkflow (..),
 )
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
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
    s@(Sequence sVal) <- nextExternalCancelSequence
    res <- newTrackedIVar
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps {externalCancels = HashMap.insert s res (externalCancels seqMaps)}
    addCommand $
      Command.WorkflowCommand
        Nothing
        ( Just $
            Command.WorkflowCommand'Variant'RequestCancelExternalWorkflowExecution $
              Command.RequestCancelExternalWorkflowExecution
                (Just sVal)
                ( Just $
                    Common.NamespacedWorkflowExecution
                      Nothing
                      (Just $ rawWorkflowId h.externalWorkflowWorkflowId)
                      (fmap rawRunId h.externalWorkflowRunId)
                      []
                )
                Nothing
                []
        )
        []
    pure $ do
      res' <- getIVar res
      case res'.failure of
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
waitChildWorkflowResult wfHandle@(ChildWorkflowHandle {childWorkflowResultConverter}) =
  waitChildWorkflowStart wfHandle >> do
    updateCallStackW
    res <- getIVar wfHandle.resultHandle
    case res.result >>= (.status) of
      Nothing -> ilift $ throwIO $ RuntimeError "Unrecognized child workflow result status"
      Just s -> case s of
        ChildWorkflow.ChildWorkflowResult'Status'Completed res' -> do
          payload <- maybe (ilift $ throwIO $ RuntimeError "Child workflow completed without result payload") pure res'.result
          eVal <- ilift $ liftIO $ UnliftIO.try $ childWorkflowResultConverter $ convertFromProtoPayload payload
          case eVal of
            Left err -> throw (err :: SomeException)
            Right ok -> pure ok
        ChildWorkflow.ChildWorkflowResult'Status'Failed res' -> throw $ ChildWorkflowFailed $ fromMaybe (Failure.Failure Nothing Nothing Nothing Nothing Nothing Nothing []) res'.failure
        ChildWorkflow.ChildWorkflowResult'Status'Cancelled _ -> throw ChildWorkflowCancelled


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
    Command.WorkflowCommand
      Nothing
      ( Just $
          Command.WorkflowCommand'Variant'CancelChildWorkflowExecution $
            Command.CancelChildWorkflowExecution (Just $ rawSequence childWorkflowSequence) Nothing []
      )
      []

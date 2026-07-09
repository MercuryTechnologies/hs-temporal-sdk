module Temporal.Workflow.Internal.Instance (
  InstanceM,
  runInstanceM,
  WorkflowInstance (..),
  Info (..),
  Sequences (..),
  Sequence (..),
  Reversed,
  fromReversed,
  push,
  drainCommands,
  nextExternalCancelSequence,
  nextChildWorkflowSequence,
  nextExternalSignalSequence,
  nextTimerSequence,
  nextActivitySequence,
  nextConditionSequence,
  nextNexusOperationSequence,
) where

import Control.Monad.Reader
import qualified Data.HashSet as HashSet
import Data.ProtoLens
import qualified Data.Text as T
import GHC.Stack
import Lens.Family2
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import Temporal.Common
import qualified Temporal.Common.Logging as Logging
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Types
import UnliftIO


runInstanceM :: WorkflowInstance -> InstanceM a -> IO a
runInstanceM worker m = runReaderT (unInstanceM m) worker


-- | Drain the accumulated commands into a successful activation completion.
drainCommands :: HasCallStack => InstanceM Core.WorkflowActivationCompletion
drainCommands = do
  inst <- ask
  info <- readIORef inst.workflowInstanceInfo
  knownFlags <- readIORef inst.workflowKnownFlags
  cmds <- readIORef inst.workflowCommands
  writeIORef inst.workflowCommands $ Reversed []
  let completionSuccessful :: Core.Success
      completionSuccessful =
        defMessage
          & Completion.commands .~ fromReversed cmds
          & Completion.usedInternalFlags .~ HashSet.toList knownFlags
      completionMessage :: Core.WorkflowActivationCompletion
      completionMessage =
        defMessage
          & Completion.runId .~ rawRunId info.runId
          & Completion.successful .~ completionSuccessful
  Logging.logDebug ("drainCommands: " <> T.pack (show completionMessage) <> " " <> T.pack (prettyCallStack callStack))
  pure completionMessage


nextExternalCancelSequence :: InstanceM Sequence
nextExternalCancelSequence = do
  inst <- ask
  liftIO $ do
    seqs <- readIORef inst.workflowSequences
    let seq' = externalCancel seqs
    Sequence seq' <$ writeIORef inst.workflowSequences seqs {externalCancel = succ seq'}


nextChildWorkflowSequence :: InstanceM Sequence
nextChildWorkflowSequence = do
  inst <- ask
  liftIO $ do
    seqs <- readIORef inst.workflowSequences
    let seq' = childWorkflow seqs
    Sequence seq' <$ writeIORef inst.workflowSequences seqs {childWorkflow = succ seq'}


nextExternalSignalSequence :: InstanceM Sequence
nextExternalSignalSequence = do
  inst <- ask
  liftIO $ do
    seqs <- readIORef inst.workflowSequences
    let seq' = externalSignal seqs
    Sequence seq' <$ writeIORef inst.workflowSequences seqs {externalSignal = succ seq'}


nextTimerSequence :: InstanceM Sequence
nextTimerSequence = do
  inst <- ask
  liftIO $ do
    seqs <- readIORef inst.workflowSequences
    let seq' = timer seqs
    Sequence seq' <$ writeIORef inst.workflowSequences seqs {timer = succ seq'}


nextActivitySequence :: InstanceM Sequence
nextActivitySequence = do
  inst <- ask
  liftIO $ do
    seqs <- readIORef inst.workflowSequences
    let seq' = activity seqs
    Sequence seq' <$ writeIORef inst.workflowSequences seqs {activity = succ seq'}


nextConditionSequence :: InstanceM Sequence
nextConditionSequence = do
  inst <- ask
  liftIO $ do
    seqs <- readIORef inst.workflowSequences
    let seq' = condition seqs
    Sequence seq' <$ writeIORef inst.workflowSequences seqs {condition = succ seq'}


nextNexusOperationSequence :: InstanceM Sequence
nextNexusOperationSequence = do
  inst <- ask
  liftIO $ do
    seqs <- readIORef inst.workflowSequences
    let seq' = nexusOperation seqs
    Sequence seq' <$ writeIORef inst.workflowSequences seqs {nexusOperation = succ seq'}

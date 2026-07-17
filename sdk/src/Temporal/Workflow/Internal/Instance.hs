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
  flushCommands,
  nextExternalCancelSequence,
  nextChildWorkflowSequence,
  nextExternalSignalSequence,
  nextTimerSequence,
  nextActivitySequence,
  nextConditionSequence,
  nextNexusOperationSequence,
) where

import Control.Monad.Reader
import Data.Atomics (atomicModifyIORefCAS)
import Proto.Decode (decodeMessage)
import Proto.Encode (encodeMessage)
import qualified Data.Text as T
import GHC.Stack
import qualified Data.Vector as V
import qualified Data.Vector.Unboxed as VU
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import Temporal.Common
import qualified Temporal.Common.Logging as Logging
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Types
import UnliftIO


runInstanceM :: WorkflowInstance -> InstanceM a -> IO a
runInstanceM worker m = runReaderT (unInstanceM m) worker


flushCommands :: HasCallStack => InstanceM ()
flushCommands = do
  inst <- ask
  info <- readIORef inst.workflowInstanceInfo
  cmds <- atomically $ do
    currentCmds <- readTVar inst.workflowCommands
    writeTVar inst.workflowCommands $ Reversed []
    pure currentCmds
  let completionSuccessful :: Core.Success
      completionSuccessful = Core.Success (V.fromList (fromReversed cmds)) VU.empty Nothing []
      completionMessage :: Core.WorkflowActivationCompletion
      completionMessage =
        Core.WorkflowActivationCompletion
          (Just (rawRunId info.runId))
          (Just (Core.WorkflowActivationCompletion'Status'Successful completionSuccessful))
          []
  Logging.logDebug ("flushCommands: " <> T.pack (show completionMessage) <> " " <> T.pack (prettyCallStack callStack))
  res <- liftIO $ inst.workflowCompleteActivation completionMessage
  case res of
    Left err -> do
      Logging.logError ("flushCommands: failed: " <> T.pack (show err))
      throwIO err
    Right () -> pure ()


nextExternalCancelSequence :: InstanceM Sequence
nextExternalCancelSequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = externalCancel seqs
    in (seqs {externalCancel = succ seq'}, Sequence seq')


nextChildWorkflowSequence :: InstanceM Sequence
nextChildWorkflowSequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = childWorkflow seqs
    in (seqs {childWorkflow = succ seq'}, Sequence seq')


nextExternalSignalSequence :: InstanceM Sequence
nextExternalSignalSequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = externalSignal seqs
    in (seqs {externalSignal = succ seq'}, Sequence seq')


nextTimerSequence :: InstanceM Sequence
nextTimerSequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = timer seqs
    in (seqs {timer = succ seq'}, Sequence seq')


nextActivitySequence :: InstanceM Sequence
nextActivitySequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = activity seqs
    in (seqs {activity = succ seq'}, Sequence seq')


nextConditionSequence :: InstanceM Sequence
nextConditionSequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = condition seqs
    in (seqs {condition = succ seq'}, Sequence seq')


nextNexusOperationSequence :: InstanceM Sequence
nextNexusOperationSequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = nexusOperation seqs
    in (seqs {nexusOperation = succ seq'}, Sequence seq')

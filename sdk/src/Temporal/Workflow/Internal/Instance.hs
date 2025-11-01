module Temporal.Workflow.Internal.Instance (
  InstanceM,
  runInstanceM,
  WorkflowInstance (..),
  Info (..),
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
) where

import Control.Monad.Reader
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


flushCommands :: HasCallStack => InstanceM ()
flushCommands = do
  inst <- ask
  info <- readIORef inst.workflowInstanceInfo
  cmds <- atomically $ do
    currentCmds <- readTVar inst.workflowCommands
    writeTVar inst.workflowCommands $ Reversed []
    pure currentCmds
  let completionSuccessful :: Core.Success
      completionSuccessful = defMessage & Completion.commands .~ fromReversed cmds
      completionMessage :: Core.WorkflowActivationCompletion
      completionMessage =
        defMessage
          & Completion.runId .~ rawRunId info.runId
          & Completion.successful .~ completionSuccessful
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
  atomicModifyIORef' inst.asyncOperations.externalCancelTracking.externalCancelSequence $ \seq' ->
    (succ seq', Sequence seq')


nextChildWorkflowSequence :: InstanceM Sequence
nextChildWorkflowSequence = do
  inst <- ask
  atomicModifyIORef' inst.asyncOperations.childWorkflowTracking.childWorkflowSeqCounter $ \seq' ->
    (succ seq', Sequence seq')


nextExternalSignalSequence :: InstanceM Sequence
nextExternalSignalSequence = do
  inst <- ask
  atomicModifyIORef' inst.asyncOperations.externalSignalTracking.externalSignalSequence $ \seq' ->
    (succ seq', Sequence seq')


nextTimerSequence :: InstanceM Sequence
nextTimerSequence = do
  inst <- ask
  atomicModifyIORef' inst.asyncOperations.timerTracking.timerSeqCounter $ \seq' ->
    (succ seq', Sequence seq')


nextActivitySequence :: InstanceM Sequence
nextActivitySequence = do
  inst <- ask
  atomicModifyIORef' inst.asyncOperations.activityTracking.activitySequence $ \seq' ->
    (succ seq', Sequence seq')


nextConditionSequence :: InstanceM Sequence
nextConditionSequence = do
  inst <- ask
  atomicModifyIORef' inst.asyncOperations.conditionTracking.conditionSequence $ \seq' ->
    (succ seq', Sequence seq')

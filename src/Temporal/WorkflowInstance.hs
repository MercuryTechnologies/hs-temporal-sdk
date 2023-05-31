{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
module Temporal.WorkflowInstance 
  ( WorkflowInstance
  , Info(..)
  , create
  , activate
  , addCommand 
  , nextActivitySequence
  , nextChildWorkflowSequence
  , nextExternalCancelSequence
  , nextExternalSignalSequence
  , nextTimerSequence
  ) where

import Control.Concurrent.STM (retry)
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.IO.Class
import Data.Hashable (Hashable)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens
import Data.Time.Clock (UTCTime)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Text (Text)
import qualified Data.Text as Text
import Data.IORef (IORef)
import Data.Vector (Vector)
import qualified Data.Vector as V
import Data.Word (Word32, Word64)
import Lens.Family2
import System.Clock (TimeSpec(..))
import System.Random (mkStdGen)
import Temporal.Common
import Temporal.Payloads
import Temporal.Workflow.Unsafe (runWorkflow)
import Temporal.Workflow.WorkflowDefinition (WorkflowDefinition(..), SomeSerializableFunction(..))
import Temporal.Workflow.WorkflowInstance
import Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult
  ( ActivityResolution
  , ActivityResolution'Status(..)
  )
import Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as ActivityResult
import Proto.Temporal.Api.Failure.V1.Message (Failure)
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
  ( WorkflowActivation
  , FireTimer
  , UpdateRandomSeed
  , QueryWorkflow
  , CancelWorkflow
  , StartWorkflow
  , SignalWorkflow
  , ResolveActivity
  , NotifyHasPatch
  , ResolveChildWorkflowExecutionStart
  , ResolveChildWorkflowExecution
  , ResolveSignalExternalWorkflow
  , ResolveRequestCancelExternalWorkflow
  , WorkflowActivationJob
  , WorkflowActivationJob'Variant(..)
  )
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion
  ( WorkflowActivationCompletion
  , WorkflowActivationCompletion'Status(..)
  )
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  , WorkflowCommand'Variant(..)
  , CompleteWorkflowExecution
  )
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import UnliftIO


create :: MonadLoggerIO m => Info -> WorkflowDefinition env -> m (WorkflowInstance env)
create workflowInstanceInfo workflowInstanceDefinition = do
  workflowInstanceLogger <- askLoggerIO
  workflowRandomnessSeed <- WorkflowGenM <$> newIORef (mkStdGen 0)
  workflowNotifiedPatches <- newIORef mempty
  workflowMemoizedPatches <- newIORef mempty
  workflowSequences <- newIORef Sequences
    { externalCancel = 0
    , childWorkflow = 0
    , externalSignal = 0
    , timer = 0
    , activity = 0
    }
  workflowTime <- newIORef $ TimeSpec 0 0
  workflowIsReplaying <- newIORef False
  workflowSequenceMaps <- newMVar $ SequenceMaps mempty mempty mempty mempty mempty
  workflowPrimaryTask <- newIORef Nothing
  workflowRunQueueRef <- newIORef JobNil
  workflowCommands <- newTVarIO $ RunningActivation []
  workflowCompletions <- newTVarIO []
  pure WorkflowInstance {..}


-- | This should never raise an exception, but instead catch all exceptions
-- and set as completion failure.
activate :: WorkflowInstance env -> WorkflowActivation -> IO WorkflowActivationCompletion
activate inst act = runInstanceM inst $ do
  $(logDebug) "activate"
  eResult <- applyJobs $ act ^. Activation.vec'jobs
  -- TODO: Can the completion send both successful commands and a failure
  -- message at the same time? In theory we can make partial progress on
  -- a workflow, but still fail at some point?
  case eResult of
    Left err -> do
      $(logWarn) "Failed activation on workflow" -- <> toLogStr (show $ workflowType info) <> " with ID " <> toLogStr (workflowId info) <> " and run ID " <> toLogStr (runId info))
      -- TODO, failures should have source / stack trace info
      -- TODO, convert failure type using a supplied payload converter
      let failure = defMessage
            & Completion.failure .~ (defMessage & Failure.message .~ Text.pack (show err))
          completion = completionBase
            & Completion.failed .~ failure
      pure completion
    Right () -> do
      $(logDebug) "Successfully submitted all activation jobs to workflow"
      successfulCommands <- readSuccessfulCommands
      $(logDebug) $ Text.pack ("got those commands " ++ show successfulCommands)
      forM_ successfulCommands $ \cmd -> do
        $(logDebug) $ Text.pack ("Successful command: " <> show cmd)
      let success = defMessage & Completion.commands .~ successfulCommands
          completion = completionBase
            & Completion.successful .~ success
      pure completion
  where
    info = inst.workflowInstanceInfo
    completionBase = defMessage & Completion.runId .~ rawRunId info.runId

runInstanceM :: WorkflowInstance env -> InstanceM env a -> IO a
runInstanceM worker m = runReaderT (unInstanceM m) worker
-- createWorkflowInstance :: Worker env -> WorkflowActivation -> IO WorklowInstance
-- createWorkflowInstance w act = do

-- NB the workflow commands are reversed since we're pushing them onto a stack
-- as we go.
readSuccessfulCommands :: InstanceM env [WorkflowCommand]
readSuccessfulCommands = do
  $(logDebug) "readSuccessfulCommands"
  inst <- ask
  cmds <- atomically $ do
    commands <- readTVar inst.workflowCommands
    case commands of
      FlushActivationCompletion cmds -> do
        writeTVar inst.workflowCommands (RunningActivation [])
        pure $ finalizeCommandsForCompletion cmds
      RunningActivation _cmds -> 
        -- We want to wait until we've explored the entire activation before sending.
        retry
  $(logDebug) $ Text.pack ("readSuccessfulCommands: " <> show cmds)
  pure cmds

addCommand :: (MonadIO m) => WorkflowInstance env -> WorkflowCommand -> m ()
addCommand inst command = do
  -- $(logDebug) $ Text.pack ("Adding command: " <> show command)
  atomically $ do
    modifyTVar' inst.workflowCommands $ \case
      RunningActivation cmds -> RunningActivation (command:cmds)
      FlushActivationCompletion cmds -> FlushActivationCompletion (command:cmds)

-- We need to remove any commands that are not query responses after a terminal response.
-- (note: I don't know how that would happen, but it's in the Python SDK code?)
-- We need to reverse the commands since we must send them up in the right order
finalizeCommandsForCompletion :: [WorkflowCommand] -> [WorkflowCommand]
finalizeCommandsForCompletion commands = go commands [] False
  where
    go :: [WorkflowCommand] -> [WorkflowCommand] -> Bool -> [WorkflowCommand]
    go [] acc _seenTerminalCommand = acc
    go (c:cs) acc True = go cs (c:acc) True
    go (c:cs) acc False = case c ^. Command.maybe'variant of
      -- TODO, don't have any useful information here
      Nothing -> error "finalizeCommandsForCompletion: command has no variant"
      Just variant -> case variant of
        WorkflowCommand'RespondToQuery _ -> go cs (c:acc) False
        WorkflowCommand'CompleteWorkflowExecution _ -> go cs (c:acc) True
        WorkflowCommand'ContinueAsNewWorkflowExecution _ -> go cs (c:acc) True
        WorkflowCommand'FailWorkflowExecution _ -> go cs (c:acc) True

nextExternalCancelSequence :: InstanceM env (Sequence ResolveRequestCancelExternalWorkflow)
nextExternalCancelSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalCancel seqs
    in (seqs { externalCancel = succ seq' }, Sequence seq')

nextChildWorkflowSequence :: InstanceM env (Sequence ResolveChildWorkflowExecutionStart)
nextChildWorkflowSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = childWorkflow seqs
    in (seqs { childWorkflow = succ seq' }, Sequence seq')

nextExternalSignalSequence :: InstanceM env (Sequence ResolveSignalExternalWorkflow)
nextExternalSignalSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalSignal seqs
    in (seqs { externalSignal = succ seq' }, Sequence seq')

nextTimerSequence :: InstanceM env (Sequence ())
nextTimerSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = timer seqs
    in (seqs { timer = succ seq' }, Sequence seq')

nextActivitySequence :: InstanceM env (Sequence ResolveActivity)
nextActivitySequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = activity seqs
    in (seqs { activity = succ seq' }, Sequence seq')


{-
data WorkflowExitValue a
  = WorkflowContinueAsNew ContinueAsNewWorkflowExecution
  | WorkflowCancelled
  | WorkflowEvicted
  | WorkflowNormal a

data ActivityExitValue a
  = ActivityWillCompleteAsync
  | ActivityNormal a

data CancellableId
  = Timer Word32
  | Activity Word32
  | LocalActivity Word32
  | ChildWorkflow Word32
  | SignalExternalWorkflow Word32
  -- seqnuum, execution, only_child
  | ExternalWorkflow Word32 NamespacedWorkflowExecution Bool
-}

applyStartWorkflow :: StartWorkflow -> InstanceM env ()
applyStartWorkflow startWorkflow = do
  act <- async $ runTopLevel $ do
    inst <- ask
    let def = inst.workflowInstanceDefinition
    case def of
      (WorkflowDefinition _ _ _ (SomeSerializableFunction fmt innerF applyArgs)) -> do
        let args = fmap convertFromProtoPayload (startWorkflow ^. Command.arguments)
            eAct = applyArgs fmt innerF args
        -- TODO make sure that we also catch exceptions from payload processing
        case eAct of
          Left err -> do
            $(logError) $ Text.pack ("Failed to decode workflow arguments: " <> show err)
            throwIO $ ValueError "Failed to decode workflow arguments"
          Right act -> do
            -- TODO exception handling liike in the .NET version (RunTopLevelAsync): 
            -- https://github.com/temporalio/sdk-dotnet/blob/main/src/Temporalio/Worker/WorkflowInstance.cs#L626
            let workflowCtxt = Context 
                  { contextNamespace = inst.workflowInstanceInfo.namespace 
                  }
            result <- runWorkflow workflowCtxt $ do
              Temporal.Payloads.encode fmt <$> act
            $(logDebug) $ Text.pack ("Workflow result: " <> show result)
            -- TODO, the .NET version seems to return payloads from encoding, not just the inner result
            addCommand inst $ defMessage & Command.completeWorkflowExecution .~ (defMessage & Command.result .~ convertToProtoPayload (RawPayload result mempty))

  primary <- asks workflowPrimaryTask
  writeIORef primary (Just act)

  -- let runWorkflow :: ExecuteWorkflowInput -> InstanceM env ()
  --     runWorkflow input = do
  --       result <- await $ executeWorkflow input
  --       pure ()
        -- let resultPayloads = 
  pure ()

applyFireTimer :: FireTimer -> InstanceM env ()
applyFireTimer fireTimer = do
  throwIO $ RuntimeError "FireTimer should be handled by applyResolutions"

applyUpdateRandomSeed :: UpdateRandomSeed -> InstanceM env ()
applyUpdateRandomSeed updateRandomSeed = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ updateRandomSeed ^. Activation.randomnessSeed)

applyQueryWorkflow :: QueryWorkflow -> InstanceM env ()
applyQueryWorkflow queryWorkflow = do
  throwIO $ RuntimeError "QueryWorkflow not implemented"
  -- where
  --   runQuery = do
  --     let baseCommand = defMessage & Activation.respondToQuery . Activation.queryId .~ (queryWorkflow ^. Activation.queryId)


applyCancelWorkflow :: CancelWorkflow -> InstanceM env ()
applyCancelWorkflow cancelWorkflow = do
  mAct <- readIORef =<< asks workflowPrimaryTask
  mapM_ UnliftIO.cancel mAct

applySignalWorkflow :: SignalWorkflow -> InstanceM env ()
applySignalWorkflow _ = throwIO $ RuntimeError "SignalWorkflow should be handled by applyResolutions"

applyResolveActivity :: ResolveActivity -> InstanceM env ()
applyResolveActivity resolveActivity = throwIO $ RuntimeError "ResolveActivity should be handled by applyResolutions"

applyNotifyHasPatch :: NotifyHasPatch -> InstanceM env ()
applyNotifyHasPatch notifyHasPatch = do
  inst <- ask
  let patches :: IORef (Set PatchId)
      patches = inst.workflowNotifiedPatches
  atomicModifyIORef' patches $ \set -> (Set.insert (notifyHasPatch ^. Activation.patchId . to PatchId) set, ())

applyResolveChildWorkflowExecutionStart :: ResolveChildWorkflowExecutionStart -> InstanceM env ()
applyResolveChildWorkflowExecutionStart resolveChildWorkflowExecutionStart = do
  throwIO $ RuntimeError "ResolveChildWorkflowExecutionStart not implemented"

applyResolveChildWorkflowExecution :: ResolveChildWorkflowExecution -> InstanceM env ()
applyResolveChildWorkflowExecution resolveChildWorkflowExecution = do
  throwIO $ RuntimeError "ResolveChildWorkflowExecution not implemented"

applyResolveSignalExternalWorkflow :: ResolveSignalExternalWorkflow -> InstanceM env ()
applyResolveSignalExternalWorkflow resolveSignalExternalWorkflow = do
  throwIO $ RuntimeError "ResolveSignalExternalWorkflow should be handled by applyResolutions"


applyResolveRequestCancelExternalWorkflow :: ResolveRequestCancelExternalWorkflow -> InstanceM env ()
applyResolveRequestCancelExternalWorkflow resolveRequestCancelExternalWorkflow = throwIO $ RuntimeError "ResolveRequestCancelExternalWorkflow should be handled by applyResolutions"

data PendingJob 
  = PendingJobResolveActivity ResolveActivity
  | PendingJobResolveChildWorkflowExecution ResolveChildWorkflowExecution
  | PendingJobResolveSignalExternalWorkflow ResolveSignalExternalWorkflow
  | PendingJobResolveRequestCancelExternalWorkflow ResolveRequestCancelExternalWorkflow
  | PendingJobFireTimer FireTimer



-- TODO: the .NET SDK implies that this manual sorting derived from the Python SDK is not necessary.
-- It seems to think that the jobs are already sorted in the correct order by the server.
applyJobs :: Vector WorkflowActivationJob -> InstanceM env (Either SomeException ())
applyJobs jobs = UnliftIO.try $ do
  patchNotifications
  signalWorkflows
  queryWorkflows
  otherJobs
  -- Resolve these last because otherJobs might have applyStartJob in it?
  -- TODO Need to think hard to ensure that sequences are not messed up by this somehow
  applyResolutions resolutions
  where
    (patchNotifications, signalWorkflows, queryWorkflows, resolutions, otherJobs) = V.foldr 
      (\job (patchNotifications, signalWorkflows, queryWorkflows, resolutions, otherJobs) -> case job ^. Activation.maybe'variant of
        Just (WorkflowActivationJob'NotifyHasPatch n) -> (applyNotifyHasPatch n *> patchNotifications, signalWorkflows, queryWorkflows, resolutions, otherJobs)
        Just (WorkflowActivationJob'SignalWorkflow sig) -> (patchNotifications, applySignalWorkflow sig *> signalWorkflows, queryWorkflows, resolutions, otherJobs)
        Just (WorkflowActivationJob'QueryWorkflow q) -> (patchNotifications, signalWorkflows, applyQueryWorkflow q *> queryWorkflows, resolutions, otherJobs)
        -- We collect these in bulk and resolve them in one go by pushing them into the completed queue. This reactivates the suspended workflow
        -- and it tries to execute further.
        Just (WorkflowActivationJob'FireTimer r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobFireTimer r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveActivity r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveActivity r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveChildWorkflowExecution r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveChildWorkflowExecution r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveSignalExternalWorkflow r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveSignalExternalWorkflow r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveRequestCancelExternalWorkflow r : resolutions, otherJobs)
        -- Catch-all for anything else that falls through the cracks
        _ -> (patchNotifications, signalWorkflows, queryWorkflows, resolutions, applyActivationJob job *> otherJobs)
      )
      (pure (), pure (), pure (), [], pure ())
      jobs

-- Enum type implemented for completeness, but see 'applyJobs' for shortcuts that avoids pattern matching on the variant type more than necessary.
applyActivationJob :: WorkflowActivationJob -> InstanceM env ()
applyActivationJob job = case job ^. Activation.maybe'variant of
  Nothing -> throwIO $ RuntimeError "Uncrecognized workflow activation job variant"
  Just variant_ -> case variant_ of
    WorkflowActivationJob'StartWorkflow startWorkflow -> applyStartWorkflow startWorkflow
    WorkflowActivationJob'FireTimer fireTimer -> applyFireTimer fireTimer
    WorkflowActivationJob'UpdateRandomSeed updateRandomSeed -> applyUpdateRandomSeed updateRandomSeed
    WorkflowActivationJob'QueryWorkflow queryWorkflow -> applyQueryWorkflow queryWorkflow
    WorkflowActivationJob'CancelWorkflow cancelWorkflow -> applyCancelWorkflow cancelWorkflow
    WorkflowActivationJob'SignalWorkflow signalWorkflow -> applySignalWorkflow signalWorkflow
    WorkflowActivationJob'ResolveActivity resolveActivity -> applyResolveActivity resolveActivity
    WorkflowActivationJob'NotifyHasPatch notifyHasPatch -> applyNotifyHasPatch notifyHasPatch
    WorkflowActivationJob'ResolveChildWorkflowExecutionStart resolveChildWorkflowExecutionStart -> applyResolveChildWorkflowExecutionStart resolveChildWorkflowExecutionStart
    WorkflowActivationJob'ResolveChildWorkflowExecution resolveChildWorkflowExecution -> applyResolveChildWorkflowExecution resolveChildWorkflowExecution
    WorkflowActivationJob'ResolveSignalExternalWorkflow resolveSignalExternalWorkflow -> applyResolveSignalExternalWorkflow resolveSignalExternalWorkflow
    WorkflowActivationJob'ResolveRequestCancelExternalWorkflow resolveRequestCancelExternalWorkflow -> applyResolveRequestCancelExternalWorkflow resolveRequestCancelExternalWorkflow
    -- Ignore, handled in the worker code.
    WorkflowActivationJob'RemoveFromCache removeFromCache -> pure ()

applyResolutions :: [PendingJob] -> InstanceM env ()
applyResolutions [] = pure ()
applyResolutions rs = do
  inst <- ask
  modifyMVar inst.workflowSequenceMaps $ \sequenceMaps -> do
    let makeCompletion (completions, sequenceMaps') pj = case pj of
          PendingJobResolveActivity msg -> do
            let existingIVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.activities
            case existingIVar of
              Nothing -> do
                new <- newIVar
                pure 
                  ( CompleteReq (Ok msg) new : completions
                  , sequenceMaps' 
                    { activities = HashMap.insert (msg ^. Activation.seq . to Sequence) new (sequenceMaps'.activities) 
                    }
                  )
          PendingJobResolveChildWorkflowExecution msg -> error "applyResolutions: PendingJobResolveChildWorkflowExecution not implemented"
          PendingJobResolveSignalExternalWorkflow msg -> error "applyResolutions: PendingJobResolveSignalExternalWorkflow not implemented"
          PendingJobResolveRequestCancelExternalWorkflow msg -> error "applyResolutions: PendingJobResolveRequestCancelExternalWorkflow not implemented"
          PendingJobFireTimer msg -> error "applyResolutions: PendingJobFireTimer not implemented"
    -- If an IVar for a sequence number is not present, we create it and add it to the sequence.
    -- This helps any workflow code that increments a sequence number ensure that it picks up the
    -- correct IVar.
    --
    -- TODO: we can probably clean out the IVar for a sequence number from the corresponding map
    -- once we know that the workflow code has seen it.
    (newCompletions, updatedSequenceMaps) <- foldM makeCompletion ([], sequenceMaps) rs
    atomically $ do
      completions <- readTVar inst.workflowCompletions
      writeTVar inst.workflowCompletions (completions ++ newCompletions)
    pure (updatedSequenceMaps, ())
{-
data WorkflowExitValue a
  = WorkflowContinueAsNew ContinueAsNewWorkflowExecution
  | WorkflowCancelled
  | WorkflowEvicted
  | WorkflowNormal a

data ActivityExitValue a
  = ActivityWillCompleteAsync
  | ActivityNormal a

data CancellableId
  = Timer Word32
  | Activity Word32
  | LocalActivity Word32
  | ChildWorkflow Word32
  | SignalExternalWorkflow Word32
  -- seqnuum, execution, only_child
  | ExternalWorkflow Word32 NamespacedWorkflowExecution Bool
-}

-- Note: this is not intended to end up inside of the workflowPrimaryTask value,
-- or else cancellation will not work properly.
runTopLevel :: InstanceM env a -> InstanceM env ()
runTopLevel handle = do
  inst <- ask
  void handle `catches`
    [ 
    --   Handler $ \ContinueAsNewException{..} -> putStrLn "ContinueAsNew Not implemented yet"
    -- , Handler $ \CancelledException{..} -> putStrLn "Cancelled Not implemented yet"
    -- , Handler $ \FailureException{..} -> putStrLn "Failure Not implemented yet"
    -- , Handler $ \OperationCancelledException{..} -> putStrLn "OperationCancelled Not implemented yet"
    -- TODO this is not really domain specific, but since the running task is an async handle, it's an easy hack to get the right behavior
      Handler $ \AsyncCancelled -> do
        addCommand inst (defMessage & Command.cancelWorkflowExecution .~ defMessage)
    , Handler $ \(SomeException e) -> $(logError) ("SomeException Not implemented yet" <> Text.pack (show e))
    ]

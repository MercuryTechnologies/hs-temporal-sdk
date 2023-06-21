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

import Control.Applicative
import Control.Concurrent.STM (retry)
import Control.Monad
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
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.Unsafe (runWorkflow, finishWorkflow, addCommand)
import Temporal.Worker.Types
import Temporal.Workflow.WorkflowDefinition (WorkflowDefinition(..), ValidWorkflowFunction(..))
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
  , ResolveChildWorkflowExecutionStart'Status(..)
  )
import Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow
  ( StartChildWorkflowExecutionFailedCause(..)
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
import qualified Proto.Temporal.Api.Failure.V1.Message as F
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import UnliftIO


create :: MonadLoggerIO m => Info -> env -> WorkflowDefinition env st -> m (WorkflowInstance env st)
create workflowInstanceInfo workflowEnv workflowInstanceDefinition = do
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
  workflowCommands <- newTVarIO $ RunningActivation $ Reversed []
  workflowCompletions <- newTVarIO []
  workflowState <- newIORef workflowInstanceDefinition.workflowInitialState
  workflowSignalHandlers <- newIORef mempty
  workflowQueryHandlers <- newIORef mempty
  pure WorkflowInstance {..}


-- | This should never raise an exception, but instead catch all exceptions
-- and set as completion failure.
activate :: Worker env actEnv -> WorkflowInstance env st -> WorkflowActivation -> IO WorkflowActivationCompletion
activate w inst act = runInstanceM inst $ do
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
      successfulCommands <- fromReversed <$> readSuccessfulCommands
      forM_ successfulCommands $ \cmd -> do
        $(logDebug) $ Text.pack ("Sending command: " <> show cmd)
      let success = defMessage & Completion.commands .~ successfulCommands
          completion = completionBase
            & Completion.successful .~ success
      pure completion
  where
    info = inst.workflowInstanceInfo
    completionBase = defMessage & Completion.runId .~ rawRunId info.runId

runInstanceM :: WorkflowInstance env st -> InstanceM env st a -> IO a
runInstanceM worker m = runReaderT (unInstanceM m) worker
-- createWorkflowInstance :: Worker env -> WorkflowActivation -> IO WorklowInstance
-- createWorkflowInstance w act = do

-- NB the workflow commands are reversed since we're pushing them onto a stack
-- as we go.
readSuccessfulCommands :: InstanceM env st (Reversed WorkflowCommand)
readSuccessfulCommands = do
  inst <- ask
  cmds <- atomically $ do
    commands <- readTVar inst.workflowCommands
    case commands of
      FlushActivationCompletion cmds -> do
        writeTVar inst.workflowCommands (RunningActivation $ Reversed [])
        pure cmds
      RunningActivation _cmds -> 
        -- We want to wait until we've explored the entire activation before sending.
        retry
  $(logDebug) $ Text.pack ("readSuccessfulCommands: " <> show cmds)
  pure cmds

-- We need to remove any commands that are not query responses after a terminal response.
-- (note: I don't know how that would happen, but it's in the Python SDK code?)
finalizeCommandsForCompletion :: Reversed WorkflowCommand -> [WorkflowCommand]
finalizeCommandsForCompletion (Reversed commands) = reverse $ go commands [] False
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

nextExternalCancelSequence :: InstanceM env st Sequence
nextExternalCancelSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalCancel seqs
    in (seqs { externalCancel = succ seq' }, Sequence seq')

nextChildWorkflowSequence :: InstanceM env st Sequence
nextChildWorkflowSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = childWorkflow seqs
    in (seqs { childWorkflow = succ seq' }, Sequence seq')

nextExternalSignalSequence :: InstanceM env st Sequence
nextExternalSignalSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalSignal seqs
    in (seqs { externalSignal = succ seq' }, Sequence seq')

nextTimerSequence :: InstanceM env st Sequence
nextTimerSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = timer seqs
    in (seqs { timer = succ seq' }, Sequence seq')

nextActivitySequence :: InstanceM env st Sequence
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

applyStartWorkflow :: StartWorkflow -> InstanceM env st ()
applyStartWorkflow startWorkflow = do
  act <- async $ runTopLevel $ do
    inst <- ask
    let def = inst.workflowInstanceDefinition
    case def of
      (WorkflowDefinition _ initialState (ValidWorkflowFunction fmt innerF applyArgs)) -> do
        -- Set the starting randomness seed
        let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
        writeIORef genRef (mkStdGen $ fromIntegral $ startWorkflow ^. Activation.randomnessSeed)
        writeIORef inst.workflowTime (startWorkflow ^. Activation.startTime . to timespecFromTimestamp)

        let args = fmap convertFromProtoPayload (startWorkflow ^. Command.vec'arguments)
        eAct <- liftIO $ applyArgs innerF args
        -- TODO make sure that we also catch exceptions from payload processing
        case eAct of
          Left err -> do
            $(logError) $ Text.pack ("Failed to decode workflow arguments: " <> show err)
            throwIO $ ValueError "Failed to decode workflow arguments"
          Right act -> do
            result <- newIVar
            runWorkflow result act >>= finishWorkflow result fmt

  primary <- asks workflowPrimaryTask
  writeIORef primary (Just act)
  pure ()

applyFireTimer :: FireTimer -> InstanceM env st ()
applyFireTimer fireTimer = do
  throwIO $ RuntimeError "FireTimer should be handled by applyResolutions"

applyUpdateRandomSeed :: UpdateRandomSeed -> InstanceM env st ()
applyUpdateRandomSeed updateRandomSeed = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ updateRandomSeed ^. Activation.randomnessSeed)

applyQueryWorkflow :: QueryWorkflow -> InstanceM env st ()
applyQueryWorkflow queryWorkflow = do
  throwIO $ RuntimeError "QueryWorkflow not implemented"
  -- where
  --   runQuery = do
  --     let baseCommand = defMessage & Activation.respondToQuery . Activation.queryId .~ (queryWorkflow ^. Activation.queryId)


applyCancelWorkflow :: CancelWorkflow -> InstanceM env st ()
applyCancelWorkflow cancelWorkflow = do
  mAct <- readIORef =<< asks workflowPrimaryTask
  mapM_ UnliftIO.cancel mAct

applySignalWorkflow :: SignalWorkflow -> InstanceM env st ()
applySignalWorkflow signalWorkflow = do
  inst <- ask
  handlers <- readIORef inst.workflowSignalHandlers
  let handlerOrDefault = 
        HashMap.lookup (Just (signalWorkflow ^. Activation.signalName)) handlers <|>
        HashMap.lookup Nothing handlers
  case handlerOrDefault of
    Nothing -> do
      $(logWarn) $ Text.pack ("No signal handler found for signal: " <> show (signalWorkflow ^. Activation.signalName))
    Just handler -> do
      let args = fmap convertFromProtoPayload (signalWorkflow ^. Command.vec'input)
      liftIO $ handler args

applyNotifyHasPatch :: NotifyHasPatch -> InstanceM env st ()
applyNotifyHasPatch notifyHasPatch = do
  inst <- ask
  let patches :: IORef (Set PatchId)
      patches = inst.workflowNotifiedPatches
  atomicModifyIORef' patches $ \set -> (Set.insert (notifyHasPatch ^. Activation.patchId . to PatchId) set, ())

data PendingJob 
  = PendingJobResolveActivity ResolveActivity
  | PendingJobResolveChildWorkflowExecutionStart ResolveChildWorkflowExecutionStart
  | PendingJobResolveChildWorkflowExecution ResolveChildWorkflowExecution
  | PendingJobResolveSignalExternalWorkflow ResolveSignalExternalWorkflow
  | PendingJobResolveRequestCancelExternalWorkflow ResolveRequestCancelExternalWorkflow
  | PendingJobFireTimer FireTimer

-- TODO: the .NET SDK implies that this manual sorting derived from the Python SDK is not necessary.
-- It seems to think that the jobs are already sorted in the correct order by the server.
applyJobs :: Vector WorkflowActivationJob -> InstanceM env st (Either SomeException ())
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
        Just (WorkflowActivationJob'ResolveChildWorkflowExecutionStart r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveChildWorkflowExecutionStart r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveChildWorkflowExecution r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveChildWorkflowExecution r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveSignalExternalWorkflow r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveSignalExternalWorkflow r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveRequestCancelExternalWorkflow r : resolutions, otherJobs)
        -- Catch-all for anything else that falls through the cracks
        _ -> (patchNotifications, signalWorkflows, queryWorkflows, resolutions, applyActivationJob job *> otherJobs)
      )
      (pure (), pure (), pure (), [], pure ())
      jobs

-- Enum type implemented for completeness, but see 'applyJobs' for shortcuts that avoids pattern matching on the variant type more than necessary.
applyActivationJob :: WorkflowActivationJob -> InstanceM env st ()
applyActivationJob job = case job ^. Activation.maybe'variant of
  Nothing -> throwIO $ RuntimeError "Uncrecognized workflow activation job variant"
  Just variant_ -> case variant_ of
    WorkflowActivationJob'StartWorkflow startWorkflow -> applyStartWorkflow startWorkflow
    WorkflowActivationJob'FireTimer fireTimer -> applyFireTimer fireTimer
    WorkflowActivationJob'UpdateRandomSeed updateRandomSeed -> applyUpdateRandomSeed updateRandomSeed
    WorkflowActivationJob'QueryWorkflow queryWorkflow -> applyQueryWorkflow queryWorkflow
    WorkflowActivationJob'CancelWorkflow cancelWorkflow -> applyCancelWorkflow cancelWorkflow
    WorkflowActivationJob'SignalWorkflow signalWorkflow -> applySignalWorkflow signalWorkflow
    WorkflowActivationJob'NotifyHasPatch notifyHasPatch -> applyNotifyHasPatch notifyHasPatch
    WorkflowActivationJob'ResolveActivity resolveActivity -> throwIO $ RuntimeError "ResolveActivity should be handled by applyResolutions"
    WorkflowActivationJob'ResolveChildWorkflowExecutionStart _ ->  throwIO $ RuntimeError "ResolveChildWorkflowExecutionStart should be handled by applyResolutions"
    WorkflowActivationJob'ResolveChildWorkflowExecution _ -> throwIO $ RuntimeError "ResolveChildWorkflowExecution should be handled by applyResolutions"
    WorkflowActivationJob'ResolveSignalExternalWorkflow _ -> throwIO $ RuntimeError "ResolveSignalExternalWorkflow should be handled by applyResolutions"
    WorkflowActivationJob'ResolveRequestCancelExternalWorkflow _ -> throwIO $ RuntimeError "ResolveRequestCancelExternalWorkflow should be handled by applyResolutions"
    -- Ignore, handled in the worker code.
    WorkflowActivationJob'RemoveFromCache removeFromCache -> pure ()

setFirstExecutionRunId :: ChildWorkflowHandle env st result -> RunId -> ChildWorkflowHandle env st result
setFirstExecutionRunId cw runId = cw
  { firstExecutionRunId = firstExecutionRunId cw <|> Just runId
  }

applyResolutions :: [PendingJob] -> InstanceM env st ()
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
              Just existing -> do
                pure 
                  ( CompleteReq (Ok msg) existing : completions
                  , sequenceMaps'
                  )
          PendingJobResolveChildWorkflowExecutionStart msg -> do
            let existingHandle = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
            case existingHandle of
              Nothing -> do
                throwIO $ RuntimeError "Child workflow not found"
              Just (SomeChildWorkflowHandle existing) -> case msg ^. Activation.maybe'status of
                Nothing -> do
                  throwIO $ RuntimeError "Child workflow start did not have a known status"
                Just status -> case status of
                  ResolveChildWorkflowExecutionStart'Succeeded succeeded -> 
                    pure 
                      ( CompleteReq (Ok ()) (startHandle existing) : completions
                      , sequenceMaps'
                        { childWorkflows = HashMap.adjust 
                            (\(SomeChildWorkflowHandle cw) -> SomeChildWorkflowHandle $ setFirstExecutionRunId cw (succeeded ^. Activation.runId . to RunId)) 
                            (msg ^. Activation.seq . to Sequence) 
                            sequenceMaps'.childWorkflows
                        }
                      )
                  ResolveChildWorkflowExecutionStart'Failed failed ->
                    let updatedMaps = sequenceMaps'
                          { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                          }
                    in case failed ^. Activation.cause of
                          START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS -> 
                            pure 
                              ( CompleteReq 
                                (
                                  ThrowWorkflow $ toException $ WorkflowAlreadyStarted
                                    { workflowAlreadyStartedWorkflowId = failed ^. Activation.workflowId
                                    , workflowAlreadyStartedWorkflowType = failed ^. Activation.workflowType
                                    }
                                ) existing.startHandle 
                                : completions
                              , updatedMaps
                              )
                          _ ->
                            pure
                              ( CompleteReq 
                                (ThrowInternal $ toException $ RuntimeError ("Unknown child workflow start failure: " <> show (failed ^. Activation.cause)))
                                existing.startHandle 
                                : completions
                              , updatedMaps
                              )
                  ResolveChildWorkflowExecutionStart'Cancelled cancelled -> 
                    pure 
                      ( CompleteReq 
                        (ThrowWorkflow $ toException ChildWorkflowCancelled) existing.startHandle
                            : completions
                      , sequenceMaps'
                        { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                        }
                      )

          PendingJobResolveChildWorkflowExecution msg -> do
            let existingHandle = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
            case existingHandle of
              Nothing ->  throwIO $ RuntimeError "Child Workflow Execution not found"
              Just (SomeChildWorkflowHandle h) -> do
                pure
                  ( CompleteReq (Ok msg) h.resultHandle : completions
                  , sequenceMaps'
                    { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                    }
                  )

          PendingJobResolveSignalExternalWorkflow msg -> error "applyResolutions: PendingJobResolveSignalExternalWorkflow not implemented"
          PendingJobResolveRequestCancelExternalWorkflow msg -> error "applyResolutions: PendingJobResolveRequestCancelExternalWorkflow not implemented"
          PendingJobFireTimer msg -> do
            let existingIVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.timers
            case existingIVar of
              Nothing -> throwIO $ RuntimeError "Timer not found"
              Just existing -> do
                pure 
                  ( CompleteReq (Ok ()) existing : completions
                  , sequenceMaps'
                    { timers = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.timers
                    }
                  )

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
runTopLevel :: InstanceM env st a -> InstanceM env st ()
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
    , Handler $ \(SomeException e) -> do
        $(logError) $ Text.pack ("Caught exception: " <> show e)
        addCommand inst 
          ( defMessage 
            & Command.failWorkflowExecution .~ 
              ( defMessage 
                & Command.failure .~ 
                  ( defMessage
                    & F.message .~ Text.pack (show e)
                  )
              )
          )
    ]

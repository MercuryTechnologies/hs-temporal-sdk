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
  , nextConditionSequence
  , addStackTraceHandler
  ) where

import Control.Applicative
import Control.Concurrent.STM (retry)
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.IO.Class
import Data.Hashable (Hashable)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.List
import qualified Data.Map.Strict as Map
import Data.Maybe
import Data.ProtoLens
import Data.Time.Clock (UTCTime)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import Data.IORef (IORef)
import Data.Vector (Vector)
import qualified Data.Vector as V
import Data.Word (Word32, Word64)
import GHC.Stack (HasCallStack, emptyCallStack, callStack, prettyCallStack)
import Lens.Family2
import System.Random (mkStdGen)
import Temporal.Common
import Temporal.Core.Client (Client)
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
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import Data.Time.Clock.System (SystemTime(..))


create :: MonadLoggerIO m 
  => (Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  -> Info 
  -> WorkflowDefinition
  -> m WorkflowInstance
create workflowCompleteActivation info workflowInstanceDefinition = do
  workflowInstanceLogger <- askLoggerIO
  workflowRandomnessSeed <- WorkflowGenM <$> newIORef (mkStdGen 0)
  workflowNotifiedPatches <- newIORef mempty
  workflowMemoizedPatches <- newIORef mempty
  workflowSequences <- newIORef Sequences
    { externalCancel = 1
    , childWorkflow = 1
    , externalSignal = 1
    , timer = 1
    , activity = 1
    , condition = 1
    }
  workflowTime <- newIORef $ MkSystemTime 0 0
  workflowIsReplaying <- newIORef False
  workflowSequenceMaps <- newTVarIO $ SequenceMaps mempty mempty mempty mempty mempty mempty
  workflowPrimaryTask <- newIORef Nothing
  workflowCommands <- newTVarIO $ Reversed []
  workflowSignalHandlers <- newIORef mempty
  workflowCallStack <- newIORef emptyCallStack
  workflowQueryHandlers <- newIORef mempty
  workflowInstanceInfo <- newIORef info
  workflowInstanceContinuationEnv <- ContinuationEnv <$> newIORef JobNil <*> newTVarIO []
  workflowCancellationState <- newIORef CancellationNotRequested
  pure WorkflowInstance {..}

-- | This is a special query handler that is added to every workflow instance.
--
-- It allows the Temporal UI to query the current call stack to see what is currently happening
-- in the workflow.
addStackTraceHandler :: MonadUnliftIO m => WorkflowInstance -> m ()
addStackTraceHandler inst = do
  let specialHandler = \qId _ -> do
        cs <- readIORef inst.workflowCallStack
        let callStackPayload = RawPayload (Text.encodeUtf8 $ Text.pack $ prettyCallStack cs) (Map.singleton "encoding" "text/plain")
        let cmd = defMessage
              & Command.respondToQuery .~
                ( defMessage
                  & Command.queryId .~ (rawQueryId qId)
                  & Command.succeeded .~
                    ( defMessage
                      & Command.response .~ convertToProtoPayload callStackPayload
                    )
                )
        addCommand inst cmd
  modifyIORef' inst.workflowQueryHandlers (HashMap.insert (Just "__stack_trace") specialHandler)

-- | This should never raise an exception, but instead catch all exceptions
-- and set as completion failure.
activate :: Worker actEnv -> WorkflowInstance -> WorkflowActivation -> IO ()
activate w inst act = runInstanceM inst $ do
  info <- atomicModifyIORef' inst.workflowInstanceInfo $ \info -> 
    let info' = info { historyLength = act ^. Activation.historyLength }
    in (info', info')
  let completionBase = defMessage & Completion.runId .~ rawRunId info.runId
  writeIORef inst.workflowTime (act ^. Activation.timestamp . to timespecFromTimestamp)
  eResult <- case w.workerConfig.deadlockTimeout of
    Nothing -> applyJobs $ act ^. Activation.vec'jobs
    Just timeoutDuration -> do
      res <- timeout timeoutDuration $ applyJobs $ act ^. Activation.vec'jobs
      case res of
        Nothing -> do
          $(logError) "Deadlock detected"
          pure $ Left $ toException $ LogicBug WorkflowActivationDeadlock
        Just res' -> pure res'
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
      liftIO (Core.completeWorkflowActivation w.workerCore completion >>= either throwIO pure)
    Right () -> pure ()

      -- successfulCommands <- fromReversed <$> readSuccessfulCommands
      -- forM_ successfulCommands $ \cmd -> do
      --   $(logDebug) $ Text.pack ("Sending command: " <> show cmd)
      -- let success = defMessage & Completion.commands .~ successfulCommands
      --     completion = completionBase
      --       & Completion.successful .~ success
      -- pure completion

runInstanceM :: WorkflowInstance -> InstanceM a -> IO a
runInstanceM worker m = runReaderT (unInstanceM m) worker

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

nextExternalCancelSequence :: InstanceM Sequence
nextExternalCancelSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalCancel seqs
    in (seqs { externalCancel = succ seq' }, Sequence seq')

nextChildWorkflowSequence :: InstanceM Sequence
nextChildWorkflowSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = childWorkflow seqs
    in (seqs { childWorkflow = succ seq' }, Sequence seq')

nextExternalSignalSequence :: InstanceM Sequence
nextExternalSignalSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalSignal seqs
    in (seqs { externalSignal = succ seq' }, Sequence seq')

nextTimerSequence :: InstanceM Sequence
nextTimerSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = timer seqs
    in (seqs { timer = succ seq' }, Sequence seq')

nextActivitySequence :: InstanceM Sequence
nextActivitySequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = activity seqs
    in (seqs { activity = succ seq' }, Sequence seq')

nextConditionSequence :: InstanceM Sequence
nextConditionSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = condition seqs
    in (seqs { condition = succ seq' }, Sequence seq')

applyStartWorkflow :: StartWorkflow -> InstanceM ()
applyStartWorkflow startWorkflow = do
  act <- async $ runTopLevel $ do
    inst <- ask
    let def = inst.workflowInstanceDefinition
    case def of
      (WorkflowDefinition _ (ValidWorkflowFunction fmt innerF applyArgs)) -> do
        -- Set the starting randomness seed
        let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
        writeIORef genRef (mkStdGen $ fromIntegral $ startWorkflow ^. Activation.randomnessSeed)
        writeIORef inst.workflowTime (startWorkflow ^. Activation.startTime . to timespecFromTimestamp)

        let args = fmap convertFromProtoPayload (startWorkflow ^. Command.vec'arguments)
            eAct = applyArgs innerF args
        -- TODO make sure that we also catch exceptions from payload processing
        finishWorkflow fmt =<< case eAct of
          Left msg -> do
            $(logError) $ Text.pack ("Failed to decode workflow arguments: " <> msg)
            throwIO (ValueError msg)
          Right act -> runWorkflow act 

  primary <- asks workflowPrimaryTask
  writeIORef primary (Just act)
  pure ()

applyFireTimer :: FireTimer -> InstanceM ()
applyFireTimer fireTimer = do
  throwIO $ RuntimeError "FireTimer should be handled by applyResolutions"

applyUpdateRandomSeed :: UpdateRandomSeed -> InstanceM ()
applyUpdateRandomSeed updateRandomSeed = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ updateRandomSeed ^. Activation.randomnessSeed)

applyQueryWorkflow :: HasCallStack => QueryWorkflow -> InstanceM ()
applyQueryWorkflow queryWorkflow = do
  inst <- ask
  handles <- readIORef inst.workflowQueryHandlers
  let handlerOrDefault = 
        HashMap.lookup (Just (queryWorkflow ^. Activation.queryType)) handles <|>
        HashMap.lookup Nothing handles
  case handlerOrDefault of
    Nothing -> do
      $(logWarn) $ Text.pack ("No query handler found for query: " <> show (queryWorkflow ^. Activation.queryType))
      let cmd = defMessage & Command.respondToQuery .~
            ( defMessage
              & Command.queryId .~ (queryWorkflow ^. Activation.queryId)
              & Command.failed .~ 
                (defMessage 
                  & F.message .~ "No query handler found for query"
                  -- & Command.source .~ "Temporal.WorkflowInstance.applyQueryWorkflow"
                  & F.stackTrace .~ (Text.pack $ prettyCallStack callStack)
                )
            )
      addCommand inst cmd
    Just h -> liftIO $ h 
      (QueryId $ queryWorkflow ^. Activation.queryId)
      (fmap convertFromProtoPayload (queryWorkflow ^. Command.vec'arguments))
  -- where
  --   runQuery = do
  --     let baseCommand = defMessage & Activation.respondToQuery . Activation.queryId .~ (queryWorkflow ^. Activation.queryId)


applyCancelWorkflow :: CancelWorkflow -> InstanceM ()
applyCancelWorkflow cancelWorkflow = do
  inst <- ask
  modifyIORef' inst.workflowCancellationState $ \old -> if old < CancellationRequested
    then CancellationRequested
    else old
  flushCommands

applySignalWorkflow :: SignalWorkflow -> InstanceM ()
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
      -- Signal all conditions that are waiting for a signal.
      -- Realistically, this should only be one condition at a time, 
      -- but we'll signal all of them just in case.
      seqMaps <- readTVarIO inst.workflowSequenceMaps 
      -- apply completions
      liftIO $ mapM_ (\ivar -> putIVar ivar (Ok ()) inst.workflowInstanceContinuationEnv) $ HashMap.elems seqMaps.conditionsAwaitingSignal

applyNotifyHasPatch :: NotifyHasPatch -> InstanceM ()
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
applyJobs :: Vector WorkflowActivationJob -> InstanceM (Either SomeException ())
applyJobs jobs = UnliftIO.try $ do
  patchNotifications
  signalWorkflows
  queryWorkflows
  otherJobs
  -- Resolve these last because otherJobs might have applyStartJob in it?
  -- TODO Need to think hard to ensure that sequences are not messed up by this somehow
  activationResults <- applyResolutions resolutions
  inst <- ask
  atomically $ do
    results <- readTVar inst.workflowInstanceContinuationEnv.activationResults
    writeTVar inst.workflowInstanceContinuationEnv.activationResults (results <> activationResults)
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
applyActivationJob :: WorkflowActivationJob -> InstanceM ()
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

applyResolutions :: [PendingJob] -> InstanceM [ActivationResult]
applyResolutions [] = pure []
applyResolutions rs = do
  inst <- ask
  atomically $ do
    sequenceMaps <- readTVar inst.workflowSequenceMaps
    let makeCompletion :: ([ActivationResult], SequenceMaps) -> PendingJob -> ([ActivationResult], SequenceMaps)
        makeCompletion (!completions, !sequenceMaps') pj = case pj of
          PendingJobResolveActivity msg -> do
            let existingIVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.activities
            case existingIVar of
              Nothing ->
                E.throw $ RuntimeError "Activity handle not found"
              Just existing ->
                ( ActivationResult (Ok msg) existing : completions
                , sequenceMaps' 
                  { activities = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.activities
                  }
                )
          PendingJobResolveChildWorkflowExecutionStart msg -> do
            let existingHandle = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
            case existingHandle of
              Nothing ->
                E.throw $ RuntimeError "Child workflow not found"
              Just (SomeChildWorkflowHandle existing) -> case msg ^. Activation.maybe'status of
                Nothing ->
                  E.throw $ RuntimeError "Child workflow start did not have a known status"
                Just status -> case status of
                  ResolveChildWorkflowExecutionStart'Succeeded succeeded ->
                    ( ActivationResult (Ok ()) existing.startHandle : 
                      ActivationResult (Ok $ (succeeded ^. Activation.runId . to RunId)) existing.firstExecutionRunId :
                      completions
                    , sequenceMaps'
                    )
                  ResolveChildWorkflowExecutionStart'Failed failed ->
                    let updatedMaps = sequenceMaps'
                          { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                          }
                    in case failed ^. Activation.cause of
                          START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS ->
                            let failure :: forall v. ResultVal v
                                failure = ThrowWorkflow $ toException $ WorkflowAlreadyStarted
                                  { workflowAlreadyStartedWorkflowId = failed ^. Activation.workflowId
                                  , workflowAlreadyStartedWorkflowType = failed ^. Activation.workflowType
                                  }
                            in
                              ( ActivationResult failure existing.startHandle : 
                                ActivationResult failure existing.firstExecutionRunId :
                                completions
                              , updatedMaps
                              )
                          _ ->
                            ( ActivationResult
                                (ThrowInternal $ toException $ RuntimeError ("Unknown child workflow start failure: " <> show (failed ^. Activation.cause))) 
                                existing.startHandle : completions
                            , updatedMaps
                            )
                  ResolveChildWorkflowExecutionStart'Cancelled cancelled -> 
                    ( ActivationResult (Ok ()) existing.startHandle :
                      ActivationResult (ThrowWorkflow $ toException ChildWorkflowCancelled) existing.firstExecutionRunId :
                      ActivationResult (ThrowWorkflow $ toException ChildWorkflowCancelled) existing.resultHandle :
                      completions 
                    , sequenceMaps'
                      { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                      }
                    )

          PendingJobResolveChildWorkflowExecution msg -> do
            let existingHandle = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
            case existingHandle of
              Nothing -> E.throw $ RuntimeError "Child Workflow Execution not found"
              Just (SomeChildWorkflowHandle h) ->
                ( ActivationResult (Ok msg) h.resultHandle : completions
                , sequenceMaps'
                  { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                  }
                )

          PendingJobResolveSignalExternalWorkflow msg -> do
            let mresVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalSignals
            case mresVar of
              Nothing -> E.throw $ RuntimeError "External Signal IVar for sequence not found"
              Just resVar ->
                ( ActivationResult (Ok msg) resVar : completions
                , sequenceMaps'
                  { externalSignals = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalSignals
                  }
                )

          PendingJobResolveRequestCancelExternalWorkflow msg -> do
            let mresVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalCancels
            case mresVar of
              Nothing -> E.throw $ RuntimeError "External Cancel IVar for sequence not found"
              Just resVar ->
                ( ActivationResult (Ok msg) resVar : completions
                , sequenceMaps'
                  { externalCancels = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.externalCancels
                  }
                )

          PendingJobFireTimer msg -> do
            let existingIVar = HashMap.lookup (msg ^. Activation.seq . to Sequence) sequenceMaps'.timers
            case existingIVar of
              Nothing -> E.throw $ RuntimeError "Timer not found"
              Just existing ->
                ( ActivationResult (Ok ()) existing : completions
                , sequenceMaps'
                  { timers = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.timers
                  }
                )

    let (newCompletions, updatedSequenceMaps) = foldl' makeCompletion ([], sequenceMaps) rs 
    writeTVar inst.workflowSequenceMaps updatedSequenceMaps
    pure newCompletions

-- Note: this is not intended to end up inside of the workflowPrimaryTask value,
-- or else cancellation will not work properly.
runTopLevel :: InstanceM a -> InstanceM ()
runTopLevel handle = do
  inst <- ask
  void handle `catches`
    [ Handler $ \(ContinueAsNewException msg) -> do
      inst <- ask
      addCommand inst (defMessage & Command.continueAsNewWorkflowExecution .~ msg)
      flushCommands
    
    -- , Handler $ \FailureException{..} -> putStrLn "Failure Not implemented yet"
    -- , Handler $ \OperationCancelledException{..} -> putStrLn "OperationCancelled Not implemented yet"
    , Handler $ \WorkflowCancelRequested -> do
        addCommand inst (defMessage & Command.cancelWorkflowExecution .~ defMessage)
        flushCommands
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
        flushCommands
    ]
  $logDebug "Finished top level of workflow"

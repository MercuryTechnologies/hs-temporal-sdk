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
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Functor.Identity
import qualified Data.HashMap.Strict as HashMap
import Data.List
import Data.Proxy
import Data.ProtoLens
import Data.Set (Set)
import qualified Data.Set as Set
import qualified Data.Text as Text
import Data.Vector (Vector)
import qualified Data.Vector as V
import GHC.Stack (HasCallStack, emptyCallStack, callStack, prettyCallStack)
import Lens.Family2
import System.Random (mkStdGen)
import Temporal.Common
import Temporal.Coroutine
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.Definition
import Temporal.Workflow.Eval (ActivationResult(..), SuspendableWorkflowExecution, runWorkflow, injectWorkflowSignal)
import Temporal.Workflow.Info
import Temporal.Workflow.Internal.Instance
import Temporal.Workflow.Internal.Monad
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
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  )
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Api.Failure.V1.Message as F
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import UnliftIO
import Data.Time.Clock.System (SystemTime(..))
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Completion
import Temporal.Payload (RawPayload)


create :: MonadLoggerIO m 
  => (Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  -> (Vector RawPayload -> IO (Either String (Workflow RawPayload)))
  -> Maybe Int -- ^ deadlock timeout in seconds
  -> WorkflowInboundInterceptor
  -> WorkflowOutboundInterceptor
  -> Info 
  -> StartWorkflow
  -> m WorkflowInstance
create workflowCompleteActivation workflowFn workflowDeadlockTimeout inboundInterceptor outboundInterceptor info start = do
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
  workflowCommands <- newTVarIO $ Reversed []
  workflowSignalHandlers <- newIORef mempty
  workflowCallStack <- newIORef emptyCallStack
  workflowQueryHandlers <- newIORef mempty
  workflowInstanceInfo <- newIORef info
  workflowInstanceContinuationEnv <- ContinuationEnv <$> newIORef JobNil
  workflowCancellationVar <- newIVar
  activationChannel <- newChan
  executionThread <- newIORef (error "Workflow thread not yet started")
  -- The execution thread is funny because it needs access to the instance, but the instance
  -- needs access to the execution thread. It's a bit of a circular dependency, but
  -- pretty innocuous since writing to the executionThread var happens before anything else
  -- is allowed to interact with the instance.
  let inst = WorkflowInstance {..}
  workerThread <- liftIO $ async $ runInstanceM inst $ do
    exec <- setUpWorkflowExecution start
    res <- liftIO $ inboundInterceptor.executeWorkflow exec $ \exec' -> runInstanceM inst $ do
      wf <- applyStartWorkflow exec' workflowFn
      runWorkflowToCompletion wf
    case res of
      WorkflowExitSuccess result -> finishWorkflow result
      WorkflowExitContinuedAsNew cmd -> addCommand cmd
      WorkflowExitCancelled cmd -> addCommand cmd
      WorkflowExitFailed _ cmd -> addCommand cmd
    flushCommands
    handleQueriesAfterCompletion
  writeIORef executionThread workerThread
  pure inst

runWorkflowToCompletion :: SuspendableWorkflowExecution RawPayload -> InstanceM (WorkflowExitVariant RawPayload)
runWorkflowToCompletion wf = runTopLevel $ do
  inst <- ask
  let completeStep :: Await [ActivationResult] (SuspendableWorkflowExecution RawPayload) -> InstanceM (SuspendableWorkflowExecution RawPayload)
      completeStep suspension = do
        $logDebug "Awaiting activation results from workflow"
        -- If the workflow is blocked, then we necessarily have to signal the temporal-core
        -- that we are stuck. Once we get unstuck (e.g. something is in the activation channel)
        -- then we can resume the workflow.
        --
        -- AFAICT it should be a 1:1 relationship between flushing and receiving an activation.
        flushCommands
        activation <- readChan inst.activationChannel
        $logDebug "Awaiting activation results from workflow"
        fmap runIdentity $ activate activation $ Identity suspension
  supplyM completeStep wf

-- | This runs indefinitely, handling queries that come in after the workflow has completed.
--
-- Termination occurs when we receive an eviction signal from Temporal. At that point,
-- the thread has 'cancel' called on it, which breaks us out of the loop.
--
-- TODO perhaps we need to ensure that any any completed queries have added their commands
-- to the command queue before we exit this loop?
handleQueriesAfterCompletion :: InstanceM ()
handleQueriesAfterCompletion = forever $ do
  activation <- readChan =<< asks activationChannel
  completion <- UnliftIO.try $ activate activation Proxy

  case completion of
    Left (SomeException err) -> do
      $(logDebug) ("Workflow failure: " <> Text.pack (show err))
      -- TODO there are lots of fields on this failureProto that we probably want to fill in
      let innerFailure :: F.Failure
          innerFailure = defMessage & F.message .~ Text.pack (show err)

          failureProto :: Completion.Failure
          failureProto = defMessage & Completion.failure .~ innerFailure
            
          completionMessage = defMessage
            & Completion.runId .~ (activation ^. Activation.runId)
            & Completion.failed .~ failureProto
      inst <- ask
      liftIO (inst.workflowCompleteActivation completionMessage >>= either throwIO pure)
    Right Proxy -> do
      -- At this point, the workflow isn't running, so we can always flush the commands.
      flushCommands


-- | This is a special query handler that is added to every workflow instance.
--
-- It allows the Temporal UI to query the current call stack to see what is currently happening
-- in the workflow.
addStackTraceHandler :: WorkflowInstance -> IO ()
addStackTraceHandler inst = do
  let specialHandler qId _ = do
        cs <- readIORef inst.workflowCallStack
        callStackPayload <- Temporal.Payload.encode JSON (Text.pack $ prettyCallStack cs)
        let cmd = defMessage
              & Command.respondToQuery .~
                ( defMessage
                  & Command.queryId .~ rawQueryId qId
                  & Command.succeeded .~
                    ( defMessage
                      & Command.response .~ convertToProtoPayload callStackPayload
                    )
                )
        runInstanceM inst $ addCommand cmd
  modifyIORef' inst.workflowQueryHandlers (HashMap.insert (Just "__stack_trace") specialHandler)

-- This should never raise an exception, but instead catch all exceptions
-- and set as completion failure.
activate 
  :: Functor f 
  => WorkflowActivation 
  -> f (Await [ActivationResult] (SuspendableWorkflowExecution RawPayload) )
  -> InstanceM (f (SuspendableWorkflowExecution RawPayload))
activate act suspension = do
  inst <- ask
  info <- atomicModifyIORef' inst.workflowInstanceInfo $ \info -> 
    let info' = info { historyLength = act ^. Activation.historyLength }
    in (info', info')
  let completionBase = defMessage & Completion.runId .~ rawRunId info.runId
  writeIORef inst.workflowTime (act ^. Activation.timestamp . to timespecFromTimestamp)
  eResult <- case inst.workflowDeadlockTimeout of
    Nothing -> applyJobs (act ^. Activation.vec'jobs) suspension
    Just timeoutDuration -> do
      res <- timeout timeoutDuration $ applyJobs (act ^. Activation.vec'jobs) suspension
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
      liftIO (inst.workflowCompleteActivation completion >>= either throwIO pure)
      -- I think it's morally okay to crash the worker thread here.
      throwIO err
    Right f -> pure f


-- | This gives us the basic state for a workflow instance prior to initial evaluation.
setUpWorkflowExecution :: StartWorkflow -> InstanceM ExecuteWorkflowInput
setUpWorkflowExecution startWorkflow = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ startWorkflow ^. Activation.randomnessSeed)
  writeIORef inst.workflowTime (startWorkflow ^. Activation.startTime . to timespecFromTimestamp)
  info <- readIORef inst.workflowInstanceInfo

  pure $ ExecuteWorkflowInput
    { executeWorkflowInputType = startWorkflow ^. Activation.workflowType
    , executeWorkflowInputArgs = fmap convertFromProtoPayload (startWorkflow ^. Command.vec'arguments)
    , executeWorkflowInputHeaders = fmap convertFromProtoPayload (startWorkflow ^. Activation.headers)
    , executeWorkflowInputInfo = info
    }

applyStartWorkflow :: ExecuteWorkflowInput -> (Vector RawPayload -> IO (Either String (Workflow RawPayload))) -> InstanceM (SuspendableWorkflowExecution RawPayload)
applyStartWorkflow execInput workflowFn = do
  inst <- ask
  let executeWorkflowBase input = runInstanceM inst $ do
        -- case inst.workflowInstanceDefinition of
        --   (WorkflowDefinition _ (ValidWorkflowFunction fmt innerF applyArgs)) -> do
            eAct <- liftIO $ workflowFn input.executeWorkflowInputArgs
            case eAct of
              Left msg -> do
                $(logError) $ Text.pack ("Failed to decode workflow arguments: " <> msg)
                throwIO (ValueError msg)
              Right act -> pure (runWorkflow act)

  liftIO $ executeWorkflowBase execInput

applyUpdateRandomSeed :: UpdateRandomSeed -> InstanceM ()
applyUpdateRandomSeed updateRandomSeed = do
  inst <- ask
  let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
  writeIORef genRef (mkStdGen $ fromIntegral $ updateRandomSeed ^. Activation.randomnessSeed)

applyQueryWorkflow :: HasCallStack => QueryWorkflow -> InstanceM ()
applyQueryWorkflow queryWorkflow = do
  inst <- ask
  handles <- readIORef inst.workflowQueryHandlers
  $logDebug $ Text.pack ("Applying query: " <> show (queryWorkflow ^. Activation.queryType))
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
                  & F.stackTrace .~ Text.pack (prettyCallStack callStack)
                )
            )
      addCommand cmd
    Just h -> liftIO $ h 
      (QueryId $ queryWorkflow ^. Activation.queryId)
      (fmap convertFromProtoPayload (queryWorkflow ^. Command.vec'arguments))

applySignalWorkflow :: SignalWorkflow -> Workflow ()
applySignalWorkflow signalWorkflow = do
  handlers <- Workflow $ \_ -> do
    inst <- ask
    Done <$> readIORef inst.workflowSignalHandlers
  let handlerOrDefault = 
        HashMap.lookup (Just (signalWorkflow ^. Activation.signalName)) handlers <|>
        HashMap.lookup Nothing handlers
  case handlerOrDefault of
    Nothing -> do
      $(logWarn) $ Text.pack ("No signal handler found for signal: " <> show (signalWorkflow ^. Activation.signalName))
    Just handler -> do
      let args = fmap convertFromProtoPayload (signalWorkflow ^. Command.vec'input)
      handler args
      Workflow $ \_ -> do
        inst <- ask
        -- Signal all conditions that are waiting for a signal.
        -- Realistically, this should only be one condition at a time, 
        -- but we'll signal all of them just in case.
        seqMaps <- readTVarIO inst.workflowSequenceMaps 
        -- apply completions
        liftIO $ fmap Done $ mapM_ (\ivar -> putIVar ivar (Ok ()) inst.workflowInstanceContinuationEnv) $ HashMap.elems seqMaps.conditionsAwaitingSignal

applyNotifyHasPatch :: NotifyHasPatch -> InstanceM ()
applyNotifyHasPatch notifyHasPatch = do
  inst <- ask
  let patches :: IORef (Set PatchId)
      patches = inst.workflowNotifiedPatches
  atomicModifyIORef' patches $ \patchSet -> (Set.insert (notifyHasPatch ^. Activation.patchId . to PatchId) patchSet, ())

data PendingJob 
  = PendingJobResolveActivity ResolveActivity
  | PendingJobResolveChildWorkflowExecutionStart ResolveChildWorkflowExecutionStart
  | PendingJobResolveChildWorkflowExecution ResolveChildWorkflowExecution
  | PendingJobResolveSignalExternalWorkflow ResolveSignalExternalWorkflow
  | PendingJobResolveRequestCancelExternalWorkflow ResolveRequestCancelExternalWorkflow
  | PendingJobFireTimer FireTimer
  | PendingWorkflowCancellation CancelWorkflow

applyJobs 
  :: Functor f
  => Vector WorkflowActivationJob 
  -- We use the functor here because we need to call applyJobs both before and after a workflow has completed.
  -- During workflow execution, identity is the functor, but after a workflow has completed, Proxy is the functor
  -- since we don't actually have any continuation to run.
  -> f (Await [ActivationResult] (SuspendableWorkflowExecution RawPayload))
  -> InstanceM (Either SomeException (f (SuspendableWorkflowExecution RawPayload)))
applyJobs jobs fAwait = UnliftIO.try $ do
  $logDebug $ Text.pack ("Applying jobs: " <> show jobs)
  inst <- ask
  let (patchNotifications, signalWorkflows, queryWorkflows, resolutions, otherJobs) = jobGroups
  patchNotifications
  queryWorkflows
  otherJobs
  activationResults <- applyResolutions resolutions
  seqMaps <- atomically $ readTVar inst.workflowSequenceMaps
  let activations = activationResults ++ map (\var -> ActivationResult (Ok ()) var) (HashMap.elems seqMaps.conditionsAwaitingSignal)
  pure $
    (\(Await wf) -> 
      -- If we don't have any activations or signals, then no useful state could have changed.
      -- This happens when we receive non-resolving jobs like queries. If we reactivate
      -- the workflow, it will just block again, which we don't want, because it confuses
      -- the SDK core's state machine.

      case activations of
        [] -> case signalWorkflows of
          [] -> suspend (Await wf)
          sigs -> lift (mapM_ injectWorkflowSignal sigs) *> wf []
        nonEmptyActivations -> case signalWorkflows of
          [] -> wf activations
          sigs -> lift (mapM_ injectWorkflowSignal sigs) *> wf activations
        {- TODO: we need to run the signal workflows without messing up ContinuationEnv: runWorkflow signalWorkflows -}
    ) <$> fAwait


  where
    jobGroups = V.foldr 
      (\job tup@(!patchNotifications, !signalWorkflows, !queryWorkflows, !resolutions, !otherJobs) -> case job ^. Activation.maybe'variant of
        Just (WorkflowActivationJob'NotifyHasPatch n) -> (applyNotifyHasPatch n *> patchNotifications, signalWorkflows, queryWorkflows, resolutions, otherJobs)
        Just (WorkflowActivationJob'SignalWorkflow sig) -> (patchNotifications, applySignalWorkflow sig : signalWorkflows, queryWorkflows, resolutions, otherJobs)
        Just (WorkflowActivationJob'QueryWorkflow q) -> (patchNotifications, signalWorkflows, applyQueryWorkflow q *> queryWorkflows, resolutions, otherJobs)
        -- We collect these in bulk and resolve them in one go by pushing them into the completed queue. This reactivates the suspended workflow
        -- and it tries to execute further.
        Just (WorkflowActivationJob'FireTimer r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobFireTimer r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveActivity r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveActivity r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveChildWorkflowExecutionStart r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveChildWorkflowExecutionStart r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveChildWorkflowExecution r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveChildWorkflowExecution r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveSignalExternalWorkflow r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveSignalExternalWorkflow r : resolutions, otherJobs)
        Just (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow r) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingJobResolveRequestCancelExternalWorkflow r : resolutions, otherJobs)
        Just (WorkflowActivationJob'UpdateRandomSeed updateRandomSeed) -> (patchNotifications, signalWorkflows, queryWorkflows, resolutions, otherJobs *> applyUpdateRandomSeed updateRandomSeed)
        Just (WorkflowActivationJob'CancelWorkflow cancelWorkflow) -> (patchNotifications, signalWorkflows, queryWorkflows, PendingWorkflowCancellation cancelWorkflow : resolutions, otherJobs)
        -- By the time we get here, the workflow should already be running.
        Just (WorkflowActivationJob'StartWorkflow _startWorkflow) -> tup
        -- Handled in the worker.
        Just (WorkflowActivationJob'RemoveFromCache _removeFromCache) -> tup
        Nothing -> E.throw $ RuntimeError "Uncrecognized workflow activation job variant"
      )
      (pure (), [], pure (), [], pure ())
      jobs

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
                  ResolveChildWorkflowExecutionStart'Cancelled _cancelled -> 
                    ( ActivationResult (Ok ()) existing.startHandle :
                      ActivationResult (ThrowWorkflow $ toException ChildWorkflowCancelled) existing.firstExecutionRunId :
                      ActivationResult (ThrowWorkflow $ toException ChildWorkflowCancelled) existing.resultHandle :
                      completions 
                    , sequenceMaps'
                      { childWorkflows = HashMap.delete (msg ^. Activation.seq . to Sequence) sequenceMaps'.childWorkflows
                      }
                    )
          PendingWorkflowCancellation _ -> (ActivationResult (Ok ()) inst.workflowCancellationVar : completions, sequenceMaps')

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

-- Note: this is intended to exclusively handle top-level workflow execution.
--
-- Don't use elsewhere.
runTopLevel :: InstanceM a -> InstanceM (WorkflowExitVariant a)
runTopLevel m = do
  (WorkflowExitSuccess <$> m) `catches`
    [ Handler $ \(ContinueAsNewException msg) -> do
        pure $ WorkflowExitContinuedAsNew $ defMessage & Command.continueAsNewWorkflowExecution .~ msg
    , Handler $ \WorkflowCancelRequested -> do
        pure $ WorkflowExitCancelled $ defMessage & Command.cancelWorkflowExecution .~ defMessage
    , Handler $ \e -> do
        pure $ WorkflowExitFailed e $
          defMessage 
            & Command.failWorkflowExecution .~ 
              ( defMessage 
                & Command.failure .~ 
                  ( defMessage
                    & F.message .~ Text.pack (show e)
                  )
              )
    ]

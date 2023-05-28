{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
module Temporal.WorkflowInstance 
  ( WorkflowInstance
  , Info(..)
  , create
  , activate
  ) where

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
import Temporal.Common
import Temporal.Payloads
import Temporal.Workflow.Unsafe (ParentInfo, RetryPolicy, Context(..), runWorkflow)
import Temporal.Workflow.WorkflowDefinition (WorkflowDefinition(..), SomeSerializableFunction(..))
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

newtype Sequence = Sequence Word32
  deriving (Eq, Ord, Show, Enum, Num, Hashable)

data Sequences = Sequences
  { externalCancel :: !Sequence
  , childWorkflow :: !Sequence
  , externalSignal :: !Sequence
  , timer :: !Sequence
  , activity :: !Sequence
  }

data Info = Info
  { attempt :: Int
  , continuedRunId :: Maybe RunId
  , cronSchedule :: Maybe Text
  , executionTimeout :: Maybe TimeSpec
  , headers :: HashMap Text Text
  , namespace :: Namespace
  , parent :: Maybe ParentInfo
  -- , rawMemo
  , retryPolicy :: Maybe RetryPolicy
  , runId :: RunId
  , runTimeout :: Maybe TimeSpec
  -- , searchAttributes
  , startTime :: TimeSpec -- Consider using UTCTime?
  , taskQueue :: TaskQueue
  , taskTimeout :: TimeSpec
  , workflowId :: WorkflowId
  , workflowType :: WorkflowType
  }

data WorkflowInstance env = WorkflowInstance
  { workflowInstanceInfo :: Info
  , workflowInstanceDefinition :: WorkflowDefinition env
  , workflowInstanceLogger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workflowRandomnessSeed :: IORef Word64
  -- , workflowInstanceJobPool :: JobPool
  , workflowNotifiedPatches :: IORef (Set PatchId)
  , workflowSequences :: IORef Sequences
  , workflowTime :: IORef TimeSpec
  , workflowIsReplaying :: IORef Bool
  , workflowCommands :: IORef [WorkflowCommand]
  , workflowPendingTimers :: IORef (HashMap Sequence (MVar ()))
  , workflowPendingActivities :: IORef (HashMap Sequence (MVar ResolveActivity))
  , workflowPendingChildWorkflows :: IORef (HashMap Sequence (MVar ResolveChildWorkflowExecutionStart))
  , workflowPendingExternalSignals :: IORef (HashMap Sequence (MVar ResolveSignalExternalWorkflow))
  , workflowPendingExternalCancels :: IORef (HashMap Sequence (MVar ResolveRequestCancelExternalWorkflow))
  , workflowPrimaryTask :: IORef (Maybe (Async ()))
  -- , externFunctions
  -- , disableEagerActivityExecution :: Bool
  }

newtype InstanceM env a = InstanceM { unInstanceM :: ReaderT (WorkflowInstance env) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (WorkflowInstance env), MonadUnliftIO)

instance MonadLogger (InstanceM env) where
  monadLoggerLog loc src lvl msg = do
    logger <- asks workflowInstanceLogger
    liftIO $ logger loc src lvl (toLogStr msg)

instance MonadLoggerIO (InstanceM env) where
  askLoggerIO = asks workflowInstanceLogger

create :: MonadLoggerIO m => Info -> WorkflowDefinition env -> m (WorkflowInstance env)
create workflowInstanceInfo workflowInstanceDefinition = do
  workflowInstanceLogger <- askLoggerIO
  workflowRandomnessSeed <- newIORef 0
  workflowNotifiedPatches <- newIORef mempty
  workflowSequences <- newIORef Sequences
    { externalCancel = 0
    , childWorkflow = 0
    , externalSignal = 0
    , timer = 0
    , activity = 0
    }
  workflowTime <- newIORef $ TimeSpec 0 0
  workflowIsReplaying <- newIORef False
  workflowCommands <- newIORef []
  workflowPendingTimers <- newIORef mempty
  workflowPendingActivities <- newIORef mempty
  workflowPendingChildWorkflows <- newIORef mempty
  workflowPendingExternalSignals <- newIORef mempty
  workflowPendingExternalCancels <- newIORef mempty
  workflowPrimaryTask <- newIORef Nothing
  pure WorkflowInstance {..}



-- | This should never raise an exception, but instead catch all exceptions
-- and set as completion failure.
activate :: WorkflowInstance env -> WorkflowActivation -> IO WorkflowActivationCompletion
activate inst act = runInstanceM inst $ do
  $(logDebug) "activate"
  eResult <- applyJobs $ act ^. Activation.vec'jobs
  -- Important: the completion can send both successful commands and a failure
  -- message at the same time. This is because we can make partial progress on
  -- a workflow, but still fail at some point.
  successfulCommands <- finalizeCommandsForCompletion <$> readSuccessfulCommands
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
      $(logDebug) "Successful activation"
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
  inst <- ask
  liftIO $ readIORef inst.workflowCommands

addCommand :: WorkflowCommand -> InstanceM env ()
addCommand command = do
  inst <- ask
  liftIO $ modifyIORef inst.workflowCommands (command:)

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

nextExternalCancelSequence :: InstanceM env Sequence
nextExternalCancelSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalCancel seqs
    in (seqs { externalCancel = succ seq' }, seq')

nextChildWorkflowSequence :: InstanceM env Sequence
nextChildWorkflowSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = childWorkflow seqs
    in (seqs { childWorkflow = succ seq' }, seq')

nextExternalSignalSequence :: InstanceM env Sequence
nextExternalSignalSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = externalSignal seqs
    in (seqs { externalSignal = succ seq' }, seq')

nextTimerSequence :: InstanceM env Sequence
nextTimerSequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = timer seqs
    in (seqs { timer = succ seq' }, seq')

nextActivitySequence :: InstanceM env Sequence
nextActivitySequence = do
  inst <- ask
  atomicModifyIORef' inst.workflowSequences $ \seqs ->
    let seq' = timer seqs
    in (seqs { timer = succ seq' }, seq')

popPending :: Sequence -> (WorkflowInstance env -> IORef (HashMap Sequence a)) -> InstanceM env (Maybe a)
popPending seq f = mask_ $ do
  inst <- ask
  let ref = f inst
  atomicModifyIORef' ref $ \pending ->
    ( HashMap.delete seq pending
    , HashMap.lookup seq pending
    )

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
    def <- asks workflowInstanceDefinition
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
            inst <- ask
            let workflowCtxt = Context 
                  { contextNamespace = inst.workflowInstanceInfo.namespace 
                  }
            result <- liftIO $ runWorkflow workflowCtxt $ do
              Temporal.Payloads.encode fmt <$> act
            -- TODO, the .NET version seems to return payloads from encoding, not just the inner result
            addCommand $ defMessage & Command.completeWorkflowExecution .~ (defMessage & Command.result .~ convertToProtoPayload (RawPayload result mempty))

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
  inst <- ask
  mTimerHandle <- popPending (fireTimer ^. Activation.seq . to Sequence) workflowPendingTimers
  -- We ignore an absent handler because it may have been cancelled and
  -- removed earlier this activation by a signal
  forM_ mTimerHandle $ \timerHandle -> do
    tryPutMVar timerHandle ()

applyUpdateRandomSeed :: UpdateRandomSeed -> InstanceM env ()
applyUpdateRandomSeed updateRandomSeed = do
  inst <- ask
  writeIORef inst.workflowRandomnessSeed $ updateRandomSeed ^. Activation.randomnessSeed

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
applySignalWorkflow signalWorkflow = do
  throwIO $ RuntimeError "SignalWorkflow not implemented"

applyResolveActivity :: ResolveActivity -> InstanceM env ()
applyResolveActivity resolveActivity = do
  inst <- ask
  mHandle <- popPending (resolveActivity ^. Activation.seq . to Sequence) workflowPendingActivities
  case mHandle of
    Nothing -> throwIO $ RuntimeError ("Failed finding activity handle for sequence " <> show (resolveActivity ^. Activation.seq))
    Just handle_ -> void $ tryPutMVar handle_ resolveActivity
    {-
    case resolveActivity ^. Activation.result . ActivityResult.maybe'status of
      Nothing -> throwIO $ RuntimeError ("Unknown activity result status " <> show (resolveActivity ^. Activation.result))
      Just s -> case s of
        ActivityResolution'Completed completed -> tryPutMVar handle_ payload
        ActivityResolution'Failed failed -> resolveFailure handle_ payload
        ActivityResolution'Cancelled _ -> resolveFailure handle_ payload
        ActivityResolution'Backoff backoff -> do
          resolveBackoff handle_ backoff
    -}

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
  inst <- ask
  mHandle <- popPending (resolveSignalExternalWorkflow ^. Activation.seq . to Sequence) workflowPendingExternalSignals
  case mHandle of
    Nothing -> throwIO $ RuntimeError ("Failed finding external signal handle for sequence " <> show (resolveSignalExternalWorkflow ^. Activation.seq))
    Just handle_ -> void $ tryPutMVar handle_ resolveSignalExternalWorkflow
      {-
      case resolveSignalExternalWorkflow ^. Activation.failure of
      Nothing -> resolveSuccess handle_ ()
      Just failure -> resolveFailure handle_ {-TODO convert failure using failure converter -} failure
      -}


applyResolveRequestCancelExternalWorkflow :: ResolveRequestCancelExternalWorkflow -> InstanceM env ()
applyResolveRequestCancelExternalWorkflow resolveRequestCancelExternalWorkflow = do
  inst <- ask
  mHandle <- popPending (resolveRequestCancelExternalWorkflow ^. Activation.seq . to Sequence) workflowPendingExternalCancels
  case mHandle of
    Nothing -> throwIO $ RuntimeError ("Failed finding external cancel handle for sequence " <> show (resolveRequestCancelExternalWorkflow ^. Activation.seq))
    Just handle_ -> void $ tryPutMVar handle_ resolveRequestCancelExternalWorkflow
      {-
      case resolveRequestCancelExternalWorkflow ^. Activation.failure of
      Nothing -> resolveSuccess handle_ ()
      Just failure -> resolveFailure handle_ {-TODO convert failure using failure converter -} failure
      -}

-- TODO: the .NET SDK implies that this manual sorting derived from the Python SDK is not necessary.
-- It seems to think that the jobs are already sorted in the correct order by the server.
applyJobs :: Vector WorkflowActivationJob -> InstanceM env (Either SomeException ())
applyJobs jobs = try $ do
  -- Split into job sets with patches, then signals, then non-queries, then
  -- queries
  mapM_ applyActivationJob patchNotifications
  mapM_ applyActivationJob signalWorkflows
  mapM_ applyActivationJob queryWorkflows
  mapM_ applyActivationJob otherJobs
  -- TODO Python SDK mentions checking conditions, but I don't know what that means in this context
  where
    (patchNotifications, signalWorkflows, queryWorkflows, otherJobs) = V.foldr 
      (\job (patchNotifications, signalWorkflows, queryWorkflows, otherJobs) -> case job ^. Activation.maybe'variant of
        Just (WorkflowActivationJob'NotifyHasPatch _) -> (job : patchNotifications, signalWorkflows, queryWorkflows, otherJobs)
        Just (WorkflowActivationJob'SignalWorkflow _) -> (patchNotifications, job : signalWorkflows, queryWorkflows, otherJobs)
        Just (WorkflowActivationJob'QueryWorkflow _) -> (patchNotifications, signalWorkflows, job : queryWorkflows, otherJobs)
        _ -> (patchNotifications, signalWorkflows, queryWorkflows, job : otherJobs)
      )
      ([], [], [], [])
      jobs


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
    -- Ignore, handled elsewhere
    WorkflowActivationJob'RemoveFromCache removeFromCache -> pure ()

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
runTopLevel handle = void handle `catches`
  [ 
  --   Handler $ \ContinueAsNewException{..} -> putStrLn "ContinueAsNew Not implemented yet"
  -- , Handler $ \CancelledException{..} -> putStrLn "Cancelled Not implemented yet"
  -- , Handler $ \FailureException{..} -> putStrLn "Failure Not implemented yet"
  -- , Handler $ \OperationCancelledException{..} -> putStrLn "OperationCancelled Not implemented yet"
  -- TODO this is not really domain specific, but since the running task is an async handle, it's an easy hack to get the right behavior
    Handler $ \AsyncCancelled -> do
      addCommand (defMessage & Command.cancelWorkflowExecution .~ defMessage)
  , Handler $ \(SomeException e) -> $(logError) "SomeException Not implemented yet"
  ]

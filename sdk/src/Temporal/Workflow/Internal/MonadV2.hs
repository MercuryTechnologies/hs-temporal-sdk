{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}
module Temporal.Workflow.Internal.MonadV2 where

import Control.Applicative
import Control.Concurrent.STM (retry, newTQueue, flushTQueue)
import Control.Monad
import Control.Monad.Catch (throwM)
import Control.Monad.Logger
import Control.Monad.Reader
import qualified Control.Monad.Catch as Catch
import qualified Control.Exception as E
import Data.Dynamic
import Data.Foldable
import Data.Traversable
import Data.Function hiding ((&))
import Data.Hashable
import Data.HashSet (HashSet)
import qualified Data.Set as Set
import qualified Data.HashMap.Strict as HashMap
import qualified Data.Map.Strict as Map
import Data.ProtoLens
import qualified Data.Text as Text
import GHC.Exts (Any)
import GHC.TypeLits
import GHC.Stack
import Lens.Family2
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (WorkflowCommand)
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import UnliftIO
import UnliftIO.Concurrent
import System.Random (
  mkStdGen,
  genShortByteString,
  genWord16,
  genWord32,
  genWord32R,
  genWord64,
  genWord64R,
  genWord8,
 )
import System.Random.Stateful (FrozenGen (..), RandomGenM (..), StatefulGen (..), StdGen)
import Temporal.Common
import Temporal.Duration
import Temporal.Exception
import Temporal.Interceptor
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.ChildWorkflowHandle
import Temporal.Workflow.CommandQueue
import Temporal.Workflow.Instance
import Temporal.Workflow.IVar
import Temporal.Workflow.Types
import Unsafe.Coerce (unsafeCoerce)
import Data.Vector (Vector)
import Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow (StartChildWorkflowExecutionFailedCause(..))
import Data.Maybe



ilift :: InstanceM a -> Workflow a
ilift = Workflow

{- | The Workflow monad is a constrained execution environment that helps
developers write code that can be executed deterministically and reliably.

If a Workflow execution is interrupted, for example due to a server failure,
or otherwise fails to complete, the Temporal service will automatically
replay the Workflow execution up to the point of interruption with the same
inputs at each step in the function.

The 'st' state may be used to store information that is needed to respond to
any queries or signals that are received by the Workflow execution.

Workflow code must be deterministic. This means:

- no threading
- no randomness
- no external calls to processes
- no network I/O
- no global state mutation
- no system date or time

This might seem like a lot of restrictions, but Temporal provides a number of
functions that allow you to use similar functionality in a deterministic way.

A critical aspect of developing Workflow Definitions is ensuring they exhibit certain deterministic traits –
that is, making sure that the same Commands are emitted in the same sequence,
whenever a corresponding Workflow Function Execution (instance of the Function Definition) is re-executed.
-}
newtype Workflow a = Workflow
  { unWorkflow :: InstanceM a }
  deriving newtype
    ( Functor, Applicative, Monad, Alternative
    , Catch.MonadThrow, Catch.MonadCatch, Catch.MonadMask
    )

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadIO Workflow where
  liftIO = error "Unreachable"

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadUnliftIO Workflow where
  withRunInIO _ = error "Unreachable"

instance Semigroup a => Semigroup (Workflow a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (Workflow a) where
  mempty = pure mempty

instance {-# OVERLAPPABLE #-} MonadLogger Workflow where
  monadLoggerLog loc src lvl msg = Workflow do
    inst <- asks workflowRuntimeInstance
    liftIO $ inst.workflowInstanceLogger loc src lvl (toLogStr msg)

instance StatefulGen WorkflowGenM Workflow where
  uniformWord32R r = applyWorkflowGen (genWord32R r)
  {-# INLINE uniformWord32R #-}
  uniformWord64R r = applyWorkflowGen (genWord64R r)
  {-# INLINE uniformWord64R #-}
  uniformWord8 = applyWorkflowGen genWord8
  {-# INLINE uniformWord8 #-}
  uniformWord16 = applyWorkflowGen genWord16
  {-# INLINE uniformWord16 #-}
  uniformWord32 = applyWorkflowGen genWord32
  {-# INLINE uniformWord32 #-}
  uniformWord64 = applyWorkflowGen genWord64
  {-# INLINE uniformWord64 #-}
  uniformShortByteString n = applyWorkflowGen (genShortByteString n)


applyWorkflowGen :: (StdGen -> (a, StdGen)) -> WorkflowGenM -> Workflow a
applyWorkflowGen f (WorkflowGenM ref) = Workflow do
  g <- readIORef ref
  case f g of
    (!a, !g') -> a <$ writeIORef ref g'
{-# INLINE applyWorkflowGen #-}


newWorkflowGenM :: StdGen -> Workflow WorkflowGenM
newWorkflowGenM g = Workflow (WorkflowGenM <$> newIORef g)
{-# INLINE newWorkflowGenM #-}


instance RandomGenM WorkflowGenM StdGen Workflow where
  applyRandomGenM = applyWorkflowGen


instance FrozenGen StdGen Workflow where
  type MutableGen StdGen Workflow = WorkflowGenM
  freezeGen g = Workflow $ readIORef (unWorkflowGenM g)
  thawGen = newWorkflowGenM

newtype Condition a = Condition (STM a)
  deriving newtype (Functor, Applicative, Monad)

{- | Wait on a condition to become true before continuing.

This must be used with signals, steps executed concurrently via the Applicative instance,
or with the `race` command, as those are the only way for
state to change in a workflow while a portion of the workflow itself is
in this blocking condition.

N.B. this should be used with care, as it can lead to the workflow
suspending indefinitely if the condition is never met.
(e.g. if there is no signal handler that changes the state appropriately)
-}
waitCondition :: Condition Bool -> Workflow ()
waitCondition m@(Condition c) = Workflow do
  runtime <- ask
  tid <- myThreadId
  (result, thread) <- atomically do
    result <- c
    threads <- readTVar $ threadManager $ getThreadManager runtime
    thread <- case HashMap.lookup tid threads of
      Just thread -> do
        writeTVar (workflowThreadBlocked thread) (not result)
        pure thread
      Nothing ->
        -- This theoretically can happen if a child thread gets created via 'asyncWorkflow'
        -- and the main thread hasn't updated the threads map yet, so we just retry and
        -- wait for this child thread to get added to the map.
        retry
    pure (result, thread)
  unless result $ atomically do
    -- In this case, we're waiting for the condition to become true.
    -- Nothing else on the thread can be done, so we just block.
    guard =<< c
    writeTVar (workflowThreadBlocked thread) False

newtype Query a = Query (STM a)
  deriving newtype (Functor, Applicative, Monad)

newtype StateVar a = StateVar
  { stateVarRef :: TVar a
  } deriving newtype (Eq)

newStateVar :: a -> Workflow (StateVar a)
newStateVar = Workflow . fmap StateVar . newTVarIO

askInstance :: Workflow WorkflowInstance
askInstance = Workflow $ asks workflowRuntimeInstance

class MonadReadStateVar m where
  readStateVar :: StateVar a -> m a

instance MonadReadStateVar Workflow where
  readStateVar = Workflow . readStateVar

instance MonadReadStateVar InstanceM where
  readStateVar = readTVarIO . stateVarRef

instance MonadReadStateVar Query where
  readStateVar = Query . readTVar . stateVarRef

instance MonadReadStateVar Condition where
  readStateVar = Condition . readTVar . stateVarRef

class MonadWriteStateVar m where
  writeStateVar :: StateVar a -> a -> m ()

instance MonadWriteStateVar Workflow where
  writeStateVar ref = Workflow . writeStateVar ref

instance MonadWriteStateVar InstanceM where
  writeStateVar ref = atomically . writeTVar (stateVarRef ref)

instance MonadWriteStateVar Query where
  writeStateVar ref = Query . writeTVar (stateVarRef ref)

instance MonadWriteStateVar Condition where
  writeStateVar ref = Condition . writeTVar (stateVarRef ref)

asyncWorkflow :: Workflow a -> InstanceM (Async a)
asyncWorkflow (Workflow m) = do
  wf <- ask
  -- TODO support propagating trace context, etc via interceptor config options
  let threadWrapper _restore = id
  asyncWithUnmask $ \restore' -> do
    threadWrapper restore' do
      tid <- myThreadId
      atomically do
        workflowThreadBlocked <- newTVar False
        modifyTVar' (threadManager $ getThreadManager wf) $ HashMap.insert tid $ WorkflowThread workflowThreadBlocked
      restore' m

-- `finally` atomically (modifyTVar' (threadManager $ getThreadManager wf) $ HashMap.delete tid)

waitAsyncWorkflow :: Async a -> Workflow a
waitAsyncWorkflow a = Workflow do
  runtime <- ask
  let deregisterThread = modifyTVar'
            (threadManager $ getThreadManager runtime)
            (HashMap.delete $ asyncThreadId a)
      waitForResultAndRethrow = do
        markBlockedState runtime False
        deregisterThread
        res <- waitCatchSTM a
        pure $ either throwM pure res
  join $ atomically do
    mRes <- pollSTM a
    case mRes of
      Nothing -> do
        markBlockedState runtime True
        pure $ join $ atomically waitForResultAndRethrow
      Just res -> do
        deregisterThread
        pure $ either throwM pure res


parallelAp :: Workflow (a -> b) -> Workflow a -> Workflow b
parallelAp ff aa = Workflow do
  runtime <- ask
  fh <- asyncWorkflow ff
  ah <- asyncWorkflow aa
  atomically $ markBlockedState runtime True
  (f, a) <- waitBoth fh ah `finally` atomically (markBlockedState runtime False)
  pure $ f a

initializeRuntime :: WorkflowInstance -> STM WorkflowRuntime
initializeRuntime inst = do
  q <- newCommandQueue
  threads <- ThreadManager <$> newTVar mempty
  readyToFlush <- newTVar False
  cancelRequested <- newTVar False
  sequenceMaps <-
    SequenceMaps
      <$> newTVar mempty
      <*> newTVar mempty
      <*> newTVar mempty
      <*> newTVar mempty
      <*> newTVar mempty
      -- Sequences are initialized to 1, because 0 looks the same as uninitialized
      -- in protobuf-land.
      <*> (Sequences <$> newTVar 1 <*> newTVar 1 <*> newTVar 1 <*> newTVar 1 <*> newTVar 1)

  pure WorkflowRuntime
        { workflowRuntimeInstance = inst
        , workflowRuntimeThreads = threads
        , workflowRuntimeCommandQueue = q
        , workflowRuntimeReadyToFlush = readyToFlush
        , workflowRuntimeCancelRequested = cancelRequested
        , workflowRuntimeSequenceMaps = sequenceMaps
        }

data RunningWorkflow = RunningWorkflow
  { runningWorkflowScheduler :: {-# UNPACK #-} !(Async ())
  , runningWorkflowFlusher :: {-# UNPACK #-} !(Async ())
  , runningWorkflowMainThread :: {-# UNPACK #-} !(Async (WorkflowExitVariant Payload))
  , runningWorkflowRuntime :: {-# UNPACK #-} !WorkflowRuntime
  }

shutdownRunningWorkflow :: MonadIO m => RunningWorkflow -> m ()
shutdownRunningWorkflow rw = do
  cancel rw.runningWorkflowScheduler
  cancel rw.runningWorkflowFlusher
  cancel rw.runningWorkflowMainThread

data ThreadState = NotRunning | Running | Completed

runWorkflow :: (MonadIO m, HasCallStack) => WorkflowInstance -> Workflow Payload -> m RunningWorkflow
runWorkflow inst m = liftIO do
  (runtime, mainThreadStarted) <- atomically do
    (,) <$> initializeRuntime inst <*> newTVar False

  let
    {-

    High level overview:

    The main thread runs the core workflow implementation.
    It is responsible for launching other worker threads, adding commands to the command queue.

    There is a scheduler thread that waits for all threads to block, then signals that we should flush.
    When we get an activation, we apply the jobs, then

    -}
    runTopLevel :: Workflow Payload -> InstanceM (WorkflowExitVariant Payload)
    runTopLevel (Workflow ma) = do
      (WorkflowExitSuccess <$> ma)
        `catches` [ Handler $ \e@(ContinueAsNewException {}) -> pure $ WorkflowExitContinuedAsNew e
                  , Handler $ \WorkflowCancelRequested -> do
                      pure $ WorkflowExitCancelled WorkflowCancelRequested
                  , Handler $ \(e :: SomeException) -> do
                      pure $ WorkflowExitFailed e
                  ]

    eval :: InstanceM (WorkflowExitVariant Payload)
    eval = mask $ \restore -> do
      tid <- myThreadId
      let tidText = Text.pack (show tid)
          threadWrapper _restore = id
          runner = do
            atomically do
              isBlocked <- newTVar False
              modifyTVar' (threadManager $ getThreadManager runtime) $ HashMap.insert tid $ WorkflowThread isBlocked
              writeTVar mainThreadStarted True
            $(logDebug) $ "Thread " <> tidText <> ": running main thread!"
            result <- restore (runTopLevel m)
            $(logDebug) $ "Thread " <> tidText <> ": ran main thread!"
            cmd <- convertExitVariantToCommand result
            $(logDebug) $ "Thread " <> tidText <> ": shutting down"
            atomically do
              addCommand runtime cmd
              writeTVar runtime.workflowRuntimeReadyToFlush True
            $(logDebug) $ "Thread " <> tidText <> ": done!"
            pure result
      result <- threadWrapper restore runner `finally` shutdownThreads tid
      $(logDebug) $ "Thread " <> tidText <> ": exiting"
      pure result

    -- If the workflow is blocked, then we necessarily have to signal the temporal-core
    -- that we are stuck. Once we get unstuck (e.g. something is in the activation channel)
    -- then we can resume the workflow.
    --
    -- There are a few cases like singalWithStart where a workflow will reach a blocking
    -- state, but we aren't actually ready to flush the commands yet. So, we read
    -- from the activation channel and resume the workflow until the channel is emptied.
    --
    -- Once we're blocked in that way, then we should flush the commands and wait for
    -- the next activation(s?).
    schedule = do
      tid <- myThreadId
      atomically (guard =<< readTVar mainThreadStarted)
      forever do
        -- It's important that 'activate' fully consumes the activation from the channel
        -- before we block again. Otherwise, we might end up in a situation where
        -- we say we're ready to flush, but we haven't processed the previous activation.
        -- This could cause a deadlock.
        liftIO $ join $ atomically do
          waitAllBlocked runtime
          activation <- readTQueue runtime.workflowRuntimeInstance.activationChannel
          activate runtime activation tid

        -- This has to be done in a separate atomically block, because the change to
        -- workflowRuntimeReadyToFlush has to be committed before we read from the
        -- activation channel.
        atomically do
          waitAllBlocked runtime
          writeTVar runtime.workflowRuntimeReadyToFlush True

    flush = forever $ do
      atomically do
        ready <- readTVar runtime.workflowRuntimeReadyToFlush
        guard ready
        writeTVar runtime.workflowRuntimeReadyToFlush False
      flushCommands runtime

    shutdownThreads myTid = do
      -- Theoretically, you could have threads created after taking all of these,
      -- but that shouldn't happen in practice.
      ts <- readTVarIO $ threadManager $ getThreadManager runtime
      mapM_ cancelWorkflowThreadNoWait $ HashMap.keys $ HashMap.delete myTid ts


  runInstanceM runtime do
    s <- async (schedule `finally` $(logDebug) "Schedule thread exiting")
    f <- async (flush `finally` $(logDebug) "Flush thread exiting")
    e <- async do
      link s
      link f
      eval
    pure $ RunningWorkflow s f e runtime

flushCommands :: (HasCallStack, MonadIO m) => WorkflowRuntime -> m ()
flushCommands runtime = do
  tid <- myThreadId
  (info, cmds) <- atomically do
    info <- readTVar runtime.workflowRuntimeInstance.workflowInstanceInfo
    cmds <- getCommands runtime.workflowRuntimeCommandQueue
    pure (info, cmds)
  let completionSuccessful :: Core.Success
      completionSuccessful = defMessage & Completion.commands .~ cmds
      completionMessage :: Core.WorkflowActivationCompletion
      completionMessage =
        defMessage
          & Completion.runId .~ rawRunId info.runId
          & Completion.successful .~ completionSuccessful
  res <- liftIO $ runtime.workflowRuntimeInstance.workflowCompleteActivation completionMessage
  case res of
    Left err -> throwIO err
    Right () -> pure ()

activate :: WorkflowRuntime -> WorkflowActivation -> ThreadId -> STM (IO ())
activate runtime act tid = do
  let inst = runtime.workflowRuntimeInstance
  info <- do
    info <- readTVar inst.workflowInstanceInfo
    let info' =
          info
            { historyLength = act ^. Activation.historyLength
            , continueAsNewSuggested = act ^. Activation.continueAsNewSuggested
            }
    writeTVar inst.workflowInstanceInfo info'
    pure info'
  let completionBase = defMessage & Completion.runId .~ rawRunId info.runId
  writeTVar inst.workflowTime (act ^. Activation.timestamp . to timespecFromTimestamp)
  writeTVar inst.workflowIsReplaying (act ^. Activation.isReplaying)
  pure do
    let apply = try do
          runReaderT
            (unInstanceM $ unWorkflow $ applyJobs (act ^. Activation.vec'jobs))
            runtime
    eResult <- case inst.workflowDeadlockTimeout of
      Nothing -> apply
      Just timeoutDuration -> do
        res <- UnliftIO.timeout timeoutDuration apply
        case res of
          Nothing -> do
            pure $ Left $ toException $ LogicBug WorkflowActivationDeadlock
          Just res' -> pure res'
    tid' <- myThreadId
    case eResult of
      Left err -> do
        -- TODO, failures should have source / stack trace info
        -- TODO, convert failure type using a supplied payload converter
        let failure =
              defMessage
                & Completion.failure .~ (defMessage & Failure.message .~ Text.pack (show err))
            completion =
              completionBase
                & Completion.failed .~ failure
        liftIO (inst.workflowCompleteActivation completion >>= either throwIO pure)
        -- I think it's morally okay to crash the worker thread here.
        throwIO err
      Right f -> do
        pure f

applyJobs :: Vector WorkflowActivationJob -> Workflow ()
applyJobs jobs = Workflow $ do
  runtime <- ask
  -- We want the atomicity here because we want to ensure that all the Workflow threads get the ability to
  -- unblock at the same time.
  jobActions <- atomically $ for jobs $ \job -> do
    case fromMaybe (error "applyJobs: Job has no variant") (job ^. Activation.maybe'variant) of
      WorkflowActivationJob'NotifyHasPatch n -> handleNotifyHasPatch runtime n
      WorkflowActivationJob'SignalWorkflow sig -> handleSignalWorkflow runtime sig
      WorkflowActivationJob'QueryWorkflow q -> handleQueryWorkflow runtime q
      WorkflowActivationJob'FireTimer r -> handleFireTimer runtime r
      WorkflowActivationJob'ResolveActivity r -> handleResolveActivity runtime r
      WorkflowActivationJob'ResolveChildWorkflowExecutionStart r -> handleResolveChildWorkflowExecutionStart runtime r
      WorkflowActivationJob'ResolveChildWorkflowExecution r -> handleResolveChildWorkflowExecution runtime r
      WorkflowActivationJob'ResolveSignalExternalWorkflow r -> handleResolveSignalExternalWorkflow runtime r
      WorkflowActivationJob'ResolveRequestCancelExternalWorkflow r -> handleResolveRequestCancelExternalWorkflow runtime r
      WorkflowActivationJob'UpdateRandomSeed updateRandomSeed -> handleUpdateRandomSeed runtime updateRandomSeed
      WorkflowActivationJob'CancelWorkflow cancelWorkflow -> handleCancelWorkflow runtime cancelWorkflow
      WorkflowActivationJob'StartWorkflow startWorkflow -> handleStartWorkflow runtime startWorkflow
      WorkflowActivationJob'RemoveFromCache removeFromCache -> handleRemoveFromCache runtime removeFromCache
      WorkflowActivationJob'DoUpdate doUpdate -> handleDoUpdate runtime doUpdate

  liftIO $ sequence_ jobActions

handleNotifyHasPatch :: WorkflowRuntime -> NotifyHasPatch -> STM (IO ())
handleNotifyHasPatch runtime n = do
  let inst = runtime.workflowRuntimeInstance
  modifyTVar' inst.workflowNotifiedPatches $ \patchSet ->
    Set.insert (n ^. Activation.patchId . to PatchId) patchSet
  pure $ pure ()

handleSignalWorkflow :: WorkflowRuntime -> SignalWorkflow -> STM (IO ())
handleSignalWorkflow runtime sig = do
  let inst = runtime.workflowRuntimeInstance
  handlers <- readTVar runtime.workflowRuntimeInstance.workflowSignalHandlers
  pure do
    let handlerOrDefault =
          HashMap.lookup (Just (sig ^. Activation.signalName)) handlers
            <|> HashMap.lookup Nothing handlers
    case handlerOrDefault of
      Nothing -> pure ()
      Just handler -> do
        -- signals can block (via sleep, or waiting on a condition), so we run them
        -- in a separate thread.
        --
        -- TODO use link(2) to connect the thrown exception to the main workflow thread
        void $ runInstanceM runtime $ do
          h <- asyncWithUnmask $ \restore -> do
            tid <- myThreadId
            args <- processorDecodePayloads
              inst.payloadProcessor
              (fmap convertFromProtoPayload (sig ^. Command.vec'input))
            atomically do
              workflowThreadBlocked <- newTVar False
              modifyTVar'
                (threadManager $ getThreadManager runtime)
                (HashMap.insert tid $ WorkflowThread workflowThreadBlocked)
            restore $ handler args

          link h

handleQueryWorkflow :: WorkflowRuntime -> QueryWorkflow -> STM (IO ())
handleQueryWorkflow runtime q = do
  let inst = runtime.workflowRuntimeInstance
  handlers <- readTVar runtime.workflowRuntimeInstance.workflowQueryHandlers
  pure do
    let handlerOrDefault =
          HashMap.lookup (Just (q ^. Activation.queryType)) handlers
          <|> HashMap.lookup Nothing handlers
    case handlerOrDefault of
      Nothing -> do
        let cmd = defMessage
              & Command.respondToQuery .~
                ( defMessage
                  & Command.queryId .~ q ^. Activation.queryId
                  & Command.failed .~ (defMessage & Failure.message .~ "Query not found")
                )
        atomically $ addCommand runtime cmd
      Just handler -> do
        args <- processorDecodePayloads inst.payloadProcessor (fmap convertFromProtoPayload (q ^. Command.vec'arguments))
        let baseInput =
              HandleQueryInput
                { handleQueryId = q ^. Activation.queryId
                , handleQueryInputType = q ^. Activation.queryType
                , handleQueryInputArgs = args
                , handleQueryInputHeaders = fmap convertFromProtoPayload (q ^. Activation.headers)
                }
        res <- inst.inboundInterceptor.handleQuery baseInput $ \input -> do
          handler (QueryId input.handleQueryId) input.handleQueryInputArgs input.handleQueryInputHeaders
        cmd <- case res of
          Left err -> do
            -- TODO, more useful error message
            pure $ defMessage & Command.failed .~ (defMessage & Failure.message .~ Text.pack (show err))
          Right ok -> do
            res' <- liftIO $ payloadProcessorEncode inst.payloadProcessor ok
            pure $ defMessage & Command.queryId .~ baseInput.handleQueryId & Command.succeeded .~ (defMessage & Command.response .~ convertToProtoPayload res')
        atomically $ addCommand runtime $ defMessage & Command.respondToQuery .~ cmd

handleFireTimer :: WorkflowRuntime -> FireTimer -> STM (IO ())
handleFireTimer runtime msg = do
  let t = msg ^. Activation.seq . to Sequence
  mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.timers t
  case mvar of
    Nothing -> Catch.throwM $ RuntimeError "Timer not found"
    Just ivar' -> do
      putIVar ivar' ()
      pure $ pure ()

handleResolveActivity :: WorkflowRuntime -> ResolveActivity -> STM (IO ())
handleResolveActivity runtime msg = do
  let a = msg ^. Activation.seq . to Sequence
  mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.activities a
  case mvar of
    Nothing -> Catch.throwM $ RuntimeError "Activity handle not found"
    Just existing -> do
      putIVar existing msg
      pure $ pure ()

handleResolveChildWorkflowExecutionStart :: WorkflowRuntime -> ResolveChildWorkflowExecutionStart -> STM (IO ())
handleResolveChildWorkflowExecutionStart runtime msg = do
  wfs <- readTVar runtime.workflowRuntimeSequenceMaps.childWorkflows
  let mHandle = HashMap.lookup (msg ^. Activation.seq . to Sequence) wfs
      unregisterOnFailure =
        modifyTVar' runtime.workflowRuntimeSequenceMaps.childWorkflows $ HashMap.delete (msg ^. Activation.seq . to Sequence)
  case mHandle of
    Nothing -> Catch.throwM $ RuntimeError "Child workflow not found"
    Just existing -> case msg ^. Activation.maybe'status of
      Nothing -> do
        unregisterOnFailure
        Catch.throwM $ RuntimeError "Child workflow start did not have a known status"
      Just status -> do
        let eResult = case status of
              ResolveChildWorkflowExecutionStart'Succeeded succeeded -> Right (succeeded ^. Activation.runId . to RunId)
              ResolveChildWorkflowExecutionStart'Failed failed -> case failed ^. Activation.cause of
                START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS -> Left $ toException $ WorkflowAlreadyStarted
                  { workflowAlreadyStartedWorkflowId = WorkflowId (failed ^. Activation.workflowId)
                  , workflowAlreadyStartedWorkflowType = WorkflowType (failed ^. Activation.workflowType)
                  }
                _ -> Left $ toException $ RuntimeError ("Unhandled child workflow start failure: " <> show (failed ^. Activation.cause))
              ResolveChildWorkflowExecutionStart'Cancelled _cancelled -> Left $ toException ChildWorkflowCancelled
        case eResult of
          Left err -> do
            unregisterOnFailure
            putIVar existing.startHandle (E.throw err)
            putIVar existing.firstExecutionRunId (E.throw err)
            putIVar existing.resultHandle (E.throw err)
          Right runId -> do
            putIVar existing.startHandle ()
            putIVar existing.firstExecutionRunId runId
  pure $ pure ()

handleResolveChildWorkflowExecution :: WorkflowRuntime -> ResolveChildWorkflowExecution -> STM (IO ())
handleResolveChildWorkflowExecution runtime msg = do
  let r = msg ^. Activation.seq . to Sequence
  mHandle <- resolveSequence runtime.workflowRuntimeSequenceMaps.childWorkflows r
  case mHandle of
    Nothing ->
      Catch.throwM $ RuntimeError "Child workflow handle not found"
    Just existing -> putIVar existing.resultHandle msg
  pure $ pure ()

handleResolveSignalExternalWorkflow :: WorkflowRuntime -> ResolveSignalExternalWorkflow -> STM (IO ())
handleResolveSignalExternalWorkflow runtime msg = do
  let r = msg ^. Activation.seq . to Sequence
  mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.externalSignals r
  case mvar of
    Nothing -> Catch.throwM $ RuntimeError "External signal handle not found"
    Just ivar -> putIVar ivar msg
  pure $ pure ()

handleResolveRequestCancelExternalWorkflow :: WorkflowRuntime -> ResolveRequestCancelExternalWorkflow -> STM (IO ())
handleResolveRequestCancelExternalWorkflow runtime msg = do
  let r = msg ^. Activation.seq . to Sequence
  mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.externalCancels r
  case mvar of
    Nothing -> Catch.throwM $ RuntimeError "External cancel handle not found"
    Just ivar -> putIVar ivar msg
  pure $ pure ()

handleUpdateRandomSeed :: WorkflowRuntime -> UpdateRandomSeed -> STM (IO ())
handleUpdateRandomSeed runtime r = pure do
  let inst = runtime.workflowRuntimeInstance
  writeIORef
    (unWorkflowGenM inst.workflowRandomnessSeed)
    (mkStdGen $ fromIntegral $ r ^. Activation.randomnessSeed)

handleCancelWorkflow :: WorkflowRuntime -> CancelWorkflow -> STM (IO ())
handleCancelWorkflow runtime _ = do
  writeTVar runtime.workflowRuntimeCancelRequested True
  pure $ pure ()

handleStartWorkflow
  :: WorkflowRuntime
  -> StartWorkflow
  -> STM (IO ())
handleStartWorkflow runtime _ = error "Should have been handled by the WorkflowWorker code"

handleRemoveFromCache :: WorkflowRuntime -> RemoveFromCache -> STM (IO ())
handleRemoveFromCache runtime _ = pure $ pure () -- Implementation provided elsewhere

handleDoUpdate :: WorkflowRuntime -> DoUpdate -> STM (IO ())
handleDoUpdate runtime _ = pure $ pure () -- Not implemented yet

convertExitVariantToCommand :: WorkflowExitVariant Payload -> InstanceM Command.WorkflowCommand
convertExitVariantToCommand variant = do
  runtime <- ask
  let inst = runtime.workflowRuntimeInstance
  let processor = inst.payloadProcessor
  case variant of
    WorkflowExitSuccess result -> do
      result' <- liftIO $ payloadProcessorEncode processor result
      pure $
        defMessage
          & Command.completeWorkflowExecution .~ (defMessage & Command.result .~ convertToProtoPayload result')
    WorkflowExitContinuedAsNew (ContinueAsNewException {..}) -> do
      i <- atomically $ readTVar inst.workflowInstanceInfo
      searchAttrs <-
        liftIO $
          searchAttributesToProto
            ( if continueAsNewOptions.searchAttributes == mempty
                then i.searchAttributes
                else continueAsNewOptions.searchAttributes
            )
      args <- processorEncodePayloads processor continueAsNewArguments
      let hdrs = continueAsNewOptions.headers
      memo <- processorEncodePayloads processor continueAsNewOptions.memo
      pure $
        defMessage
          & Command.continueAsNewWorkflowExecution
            .~ ( defMessage
                  & Command.workflowType .~ rawWorkflowType continueAsNewWorkflowType
                  & Command.taskQueue .~ maybe "" rawTaskQueue continueAsNewOptions.taskQueue
                  & Command.vec'arguments .~ fmap convertToProtoPayload args
                  & Command.maybe'retryPolicy .~ (retryPolicyToProto <$> continueAsNewOptions.retryPolicy)
                  & Command.searchAttributes .~ searchAttrs
                  & Command.headers .~ fmap convertToProtoPayload hdrs
                  & Command.memo .~ fmap convertToProtoPayload memo
                  & Command.maybe'workflowTaskTimeout .~ (durationToProto <$> continueAsNewOptions.taskTimeout)
                  & Command.maybe'workflowRunTimeout .~ (durationToProto <$> continueAsNewOptions.runTimeout)
               )
    WorkflowExitCancelled WorkflowCancelRequested -> do
      pure $ defMessage & Command.cancelWorkflowExecution .~ defMessage
    WorkflowExitFailed e | Just (actFailure :: ActivityFailure) <- fromException e -> do
      let appFailure = actFailure.cause
          enrichedApplicationFailure =
            defMessage
              & Failure.message .~ actFailure.message
              & Failure.source .~ "hs-temporal-sdk"
              & Failure.activityFailureInfo .~ actFailure.original
              & Failure.stackTrace .~ actFailure.stack
              & Failure.cause
                .~ ( defMessage
                      & Failure.message .~ appFailure.message
                      & Failure.source .~ "hs-temporal-sdk"
                      & Failure.stackTrace .~ appFailure.stack
                      & Failure.applicationFailureInfo
                        .~ ( defMessage
                              & Failure.type' .~ type' appFailure
                              & Failure.nonRetryable .~ nonRetryable appFailure
                           )
                   )
      pure $
        defMessage
          & Command.failWorkflowExecution
            .~ ( defMessage
                  & Command.failure .~ enrichedApplicationFailure
               )
    WorkflowExitFailed e -> do
      runtime <- ask
      let inst = runtime.workflowRuntimeInstance
          appFailure = mkApplicationFailure e inst.errorConverters
          enrichedApplicationFailure = applicationFailureToFailureProto appFailure
      pure $
        defMessage
          & Command.failWorkflowExecution
            .~ ( defMessage
                  & Command.failure .~ enrichedApplicationFailure
               )

-- applyDoUpdateWorkflow :: DoUpdate -> Workflow ()
-- applyDoUpdateWorkflow doUpdate = provideCallStack do
--   (validator, updateAction) <- ilift do
--     inst <- ask
--     handlers <- readIORef inst.workflowUpdateHandlers
--     let handlerAndValidatorOrDefault =
--           HashMap.lookup (Just (doUpdate ^. Activation.name)) handlers
--             <|> HashMap.lookup Nothing handlers
--     case handlerAndValidatorOrDefault of
--       Nothing -> do
--         let errMessage = Text.pack ("No update handler found for update: " <> show (doUpdate ^. Activation.name))
--         let err = mkApplicationFailure (toException $ UpdateNotFound errMessage) inst.errorConverters
--         $(logWarn) errMessage
--         let cmd =
--               defMessage
--                 & Command.updateResponse
--                   .~ ( defMessage
--                         & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
--                         & Command.rejected .~ applicationFailureToFailureProto err
--                      )
--         addCommand cmd
--         pure (pure False, error "This should never happen")
--       Just WorkflowUpdateImplementation {..} -> do
--         updateArgs <- UnliftIO.try $ processorDecodePayloads inst.payloadProcessor (fmap convertFromProtoPayload (doUpdate ^. Activation.vec'input))
--         let runValidator = doUpdate ^. Activation.runValidator
--             updateId = UpdateId $ doUpdate ^. Activation.id
--             updateHeaders = fmap convertFromProtoPayload (doUpdate ^. Activation.headers)
--         case updateArgs of
--           Left err ->
--             pure
--               ( do
--                   addCommand $
--                     defMessage
--                       & Command.updateResponse
--                         .~ ( defMessage
--                               & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
--                               & Command.rejected .~ applicationFailureToFailureProto (mkApplicationFailure err inst.errorConverters)
--                            )
--                   pure False
--               , error "Error processing update args"
--               )
--           Right args -> do
--             let baseInput =
--                   HandleUpdateInput
--                     { handleUpdateId = updateId
--                     , handleUpdateInputType = doUpdate ^. Activation.name
--                     , handleUpdateInputArgs = args
--                     , handleUpdateInputHeaders = updateHeaders
--                     }
--             let runUpdate = inst.inboundInterceptor.handleUpdate baseInput $ \input ->
--                   updateImplementation input.handleUpdateId input.handleUpdateInputArgs input.handleUpdateInputHeaders
--             pure $
--               if runValidator
--                 then
--                   ( do
--                       eValidatorResult <- case updateValidationImplementation of
--                         Nothing -> pure $ Right ()
--                         Just f -> do
--                           eResult <- UnliftIO.try $
--                             liftIO $
--                               inst.inboundInterceptor.validateUpdate baseInput $ \input ->
--                                 unValidation $ f input.handleUpdateId input.handleUpdateInputArgs input.handleUpdateInputHeaders
--                           pure $ join eResult
--                       case eValidatorResult of
--                         Left err -> do
--                           addCommand $
--                             defMessage
--                               & Command.updateResponse
--                                 .~ ( defMessage
--                                       & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
--                                       & Command.rejected .~ applicationFailureToFailureProto (mkApplicationFailure err inst.errorConverters)
--                                    )
--                           pure False
--                         Right () -> do
--                           addCommand $
--                             defMessage
--                               & Command.updateResponse
--                                 .~ ( defMessage
--                                       & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
--                                       & Command.accepted .~ defMessage
--                                    )
--                           pure True
--                   , runUpdate
--                   )
--                 else
--                   ( do
--                       addCommand $
--                         defMessage
--                           & Command.updateResponse
--                             .~ ( defMessage
--                                   & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
--                                   & Command.accepted .~ defMessage
--                                )
--                       pure True
--                   , runUpdate
--                   )
--   runAction <- ilift validator
--   when runAction $ do
--     ePayload <- Temporal.Workflow.Internal.Monad.try updateAction
--     $(logDebug) "we executed the update!"
--     Workflow $ \_env -> do
--       inst <- ask
--       case ePayload of
--         Left err -> do
--           $(logDebug) "gonna send an update rejected message!"
--           addCommand $
--             defMessage
--               & Command.updateResponse
--                 .~ ( defMessage
--                       & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
--                       & Command.rejected .~ applicationFailureToFailureProto (mkApplicationFailure err inst.errorConverters)
--                    )
--           pure $ Throw err
--         Right payload -> do
--           $(logDebug) "gonna send an update completed message!"
--           payload' <- liftIO $ payloadProcessorEncode inst.payloadProcessor payload
--           addCommand $
--             defMessage
--               & Command.updateResponse
--                 .~ ( defMessage
--                       & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
--                       & Command.completed .~ convertToProtoPayload payload'
--                    )
--           pure $ Done ()

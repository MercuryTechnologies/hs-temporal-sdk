{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}

module Temporal.Workflow.Monad where

import Control.Applicative
import Control.Concurrent.STM (retry)
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.Catch (throwM)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Dynamic
import Data.Either (isRight)
import Data.Foldable
import qualified Data.HashMap.Strict as HashMap
import Data.HashSet (HashSet)
import qualified Data.HashSet as HashSet
import Data.Hashable (Hashable)
import Data.Kind
import qualified Data.Map.Strict as Map
import Data.Maybe
import Data.ProtoLens
import qualified Data.Set as Set
import qualified Data.Text as Text
import Data.Traversable
import Data.Vector (Vector)
import Data.Word
import GHC.Conc (unsafeIOToSTM)
import GHC.Exts (Any)
import GHC.Stack
import GHC.TypeLits
import Lens.Family2
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow (StartChildWorkflowExecutionFailedCause (..))
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (WorkflowCommand)
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import RequireCallStack
import System.Random (
  genShortByteString,
  genWord16,
  genWord32,
  genWord32R,
  genWord64,
  genWord64R,
  genWord8,
  mkStdGen,
 )
import System.Random.Stateful (FrozenGen (..), RandomGenM (..), StatefulGen (..), StdGen)
import Temporal.Common
import Temporal.Duration
import Temporal.Exception
import Temporal.Interceptor
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.ChildWorkflowHandle
import qualified Temporal.Workflow.CommandQueue as CommandQueue
import Temporal.Workflow.IVar
import Temporal.Workflow.Instance
import Temporal.Workflow.Types
import UnliftIO
import UnliftIO.Concurrent
import Unsafe.Coerce (unsafeCoerce)


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
  {unWorkflow :: InstanceM a}
  deriving newtype
    ( Functor
    , Applicative
    , Monad
    , Alternative
    , Catch.MonadThrow
    , Catch.MonadCatch
    , Catch.MonadMask
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


untilM_ :: (Monad m) => m Bool -> m ()
untilM_ p = go
  where
    go = do
      x <- p
      unless x go


{- | Wait on a condition to become true before continuing.

This must be used with signals, updates, steps executed concurrently,
or with the `race` command, as those are the only way for
state to change in a workflow while a portion of the workflow itself is
in this blocking condition.

This should be used with care, as it can lead to the workflow
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
  untilM_ $ atomically do
    isBlocked <- readTVar thread.workflowThreadBlocked
    when isBlocked retry
    conditionSatisfied <- c
    writeTVar thread.workflowThreadBlocked (not conditionSatisfied)
    pure conditionSatisfied


newtype Query a = Query (STM a)
  deriving newtype (Functor, Applicative, Monad)


data StateVar a = StateVar
  { stateVarRef :: {-# UNPACK #-} !(TVar a)
  , stateVarBlocks :: {-# UNPACK #-} !(TVar (HashSet ThreadId))
  }
  deriving (Eq)


newStateVar :: a -> Workflow (StateVar a)
newStateVar x = Workflow do
  stateVarRef <- newTVarIO x
  stateVarBlocks <- newTVarIO mempty
  pure StateVar {..}


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
  readStateVar ref = Condition do
    tid <- unsafeIOToSTM myThreadId
    modifyTVar' ref.stateVarBlocks $ HashSet.insert tid
    readTVar ref.stateVarRef


instance MonadReadStateVar Validation where
  readStateVar = Validation . readTVarIO . stateVarRef


class MonadWriteStateVar m where
  writeStateVar :: StateVar a -> a -> m ()
  modifyStateVar :: StateVar a -> (a -> a) -> m ()


instance MonadWriteStateVar Workflow where
  writeStateVar ref x = Workflow do
    runtime <- ask
    atomically do
      unblockableThreads <- stateTVar ref.stateVarBlocks $ \blocks -> (blocks, mempty)
      writeTVar ref.stateVarRef x
      threadManager <- readTVar (getThreadManager runtime).threadManager
      for_ unblockableThreads $ \thread -> do
        writeTVar (threadManager HashMap.! thread).workflowThreadBlocked False
  modifyStateVar ref f = Workflow do
    runtime <- ask
    atomically do
      threadManager <- readTVar (getThreadManager runtime).threadManager
      unblockableThreads <- stateTVar ref.stateVarBlocks $ \blocks -> (blocks, mempty)
      modifyTVar' ref.stateVarRef f
      for_ unblockableThreads $ \thread -> do
        writeTVar (threadManager HashMap.! thread).workflowThreadBlocked False


instance MonadWriteStateVar InstanceM where
  writeStateVar ref = atomically . writeTVar (stateVarRef ref)


instance TypeError ('Text "A Query cannot mutate state") => MonadWriteStateVar Query where
  writeStateVar = error "Unreachable"


instance TypeError ('Text "A Condition cannot mutate state") => MonadWriteStateVar Condition where
  writeStateVar = error "Unreachable"


asyncWorkflow :: Workflow a -> InstanceM (Async a)
asyncWorkflow (Workflow m) = do
  wf <- ask
  -- TODO support propagating trace context, etc via interceptor config options
  let threadWrapper _restore = id
  h <- asyncWithUnmask $ \restore' -> do
    threadWrapper restore' do
      tid <- myThreadId
      atomically $ registerThread wf tid
      restore' m
  atomically $ waitThreadsRegistered wf [asyncThreadId h]
  pure h


waitAsyncWorkflow :: Async a -> Workflow a
waitAsyncWorkflow a = Workflow do
  runtime <- ask
  tid <- myThreadId
  let waitForResultAndRethrow = do
        markBlockedState runtime False
        deregisterThread runtime (asyncThreadId a)
        res <- waitCatchSTM a
        pure $ either throwM pure res
  join $ atomically do
    mRes <- pollSTM a
    case mRes of
      Nothing -> do
        markBlockedState runtime True
        pure $ join $ atomically waitForResultAndRethrow
      Just res -> do
        deregisterThread runtime (asyncThreadId a)
        pure $ either throwM pure res


parallelAp :: Workflow (a -> b) -> Workflow a -> Workflow b
parallelAp ff aa = Workflow $ UnliftIO.mask $ \restore -> do
  runtime <- ask
  tid <- myThreadId
  fh <- asyncWorkflow ff
  ah <- asyncWorkflow aa
  atomically do
    markBlockedState runtime True
    waitThreadsRegistered runtime [asyncThreadId fh, asyncThreadId ah]
  (f, a) <-
    restore (waitBoth fh ah) `finally` atomically do
      tid' <- unsafeIOToSTM myThreadId
      markBlockedState runtime False
      deregisterThread runtime $ asyncThreadId fh
      deregisterThread runtime $ asyncThreadId ah
  pure $ f a


initializeRuntime :: WorkflowInstance -> STM WorkflowRuntime
initializeRuntime inst = do
  q <- CommandQueue.newCommandQueue
  threads <- ThreadManager <$> newTVar mempty
  cancelRequested <- newIVarSTM threads
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
  unappliedJobs <- newTVar 0
  signalSupport <- SignalSupport <$> newTVar [] <*> newTVar mempty
  querySupport <- QuerySupport <$> newTVar [] <*> newTVar mempty
  updateSupport <- UpdateSupport <$> newTVar [] <*> newTVar mempty
  pure
    WorkflowRuntime
      { workflowRuntimeInstance = inst
      , workflowRuntimeThreads = threads
      , workflowRuntimeCommandQueue = q
      , workflowRuntimeCancelRequested = cancelRequested
      , workflowRuntimeSequenceMaps = sequenceMaps
      , workflowRuntimeUnappliedJobs = unappliedJobs
      , signals = signalSupport
      , queries = querySupport
      , updates = updateSupport
      }


data RunningWorkflow = RunningWorkflow
  { runningWorkflowScheduler :: {-# UNPACK #-} !(Async ())
  , runningWorkflowMainThread :: {-# UNPACK #-} !(Async (WorkflowExitVariant Payload))
  , runningWorkflowRuntime :: {-# UNPACK #-} !WorkflowRuntime
  }


shutdownRunningWorkflow :: MonadIO m => RunningWorkflow -> m ()
shutdownRunningWorkflow rw = do
  cancel rw.runningWorkflowScheduler
  cancel rw.runningWorkflowMainThread


{- | This is a special query handler that is added to every workflow instance.

It allows the Temporal UI to query the current call stack to see what is currently happening
in the workflow.
-}
addStackTraceHandler :: WorkflowRuntime -> IO ()
addStackTraceHandler runtime = do
  let specialHandler _ _ _ = do
        cs <- readIORef runtime.workflowRuntimeInstance.workflowCallStack
        Right <$> Temporal.Payload.encode JSON (Text.pack $ Temporal.Exception.prettyCallStack cs)
  atomically $ modifyTVar' runtime.queries.queryHandlers (HashMap.insert (Just "__stack_trace") specialHandler)


newtype ApplyM a = ApplyM
  { unApplyM :: ReaderT (WorkflowRuntime, Async (WorkflowExitVariant Payload), TVar (InstanceM ())) STM a
  -- ^ Main worker thread, actions to apply on once out of the STM block
  }
  deriving newtype (Functor, Applicative, Monad)


instance MonadIVar ApplyM where
  putIVar i = ApplyM . lift . putIVar i
  tryReadIVar = ApplyM . lift . tryReadIVar


runApplyM :: WorkflowRuntime -> Async (WorkflowExitVariant Payload) -> ApplyM a -> STM (a, IO ())
runApplyM runtime mainThread (ApplyM m) = do
  actionVar <- newTVar mempty
  x <- runReaderT m (runtime, mainThread, actionVar)
  m <- readTVar actionVar
  pure (x, runInstanceM runtime m)


applyIO :: InstanceM () -> ApplyM ()
applyIO action = ApplyM $ do
  (_, _, actionVar) <- ask
  lift $ modifyTVar' actionVar (>> action)


applySTM :: STM a -> ApplyM a
applySTM = ApplyM . lift


askRuntime :: ApplyM WorkflowRuntime
askRuntime = ApplyM $ do
  (runtime, _, _) <- ask
  pure runtime


askMainThread :: ApplyM (Async (WorkflowExitVariant Payload))
askMainThread = ApplyM $ do
  (_, mainThread, _) <- ask
  pure mainThread


specificHandlerOrDefault :: Hashable k => HashMap.HashMap (Maybe k) v -> k -> Maybe v
specificHandlerOrDefault handlers key = HashMap.lookup (Just key) handlers <|> HashMap.lookup Nothing handlers


runWorkflow :: (MonadIO m, HasCallStack) => WorkflowInstance -> Workflow Payload -> m RunningWorkflow
runWorkflow inst m = liftIO do
  runtime <- atomically $ initializeRuntime inst
  addStackTraceHandler runtime
  runInstanceM runtime do
    let
      {-

      High level overview:

      The main thread runs the core workflow implementation.
      It is responsible for launching other worker threads, adding commands to the command queue.

      There is a scheduler thread that waits for all threads to block, then signals that we should flush.
      When we get an activation, we apply the jobs, then

      -}
      runTopLevel :: Workflow Payload -> InstanceM (WorkflowExitVariant Payload)
      runTopLevel (Workflow ma) = withRunInIO $ \runInIO -> liftIO do
        (WorkflowExitSuccess <$> runInIO ma)
          `E.catches` [ E.Handler $ \e@(ContinueAsNewException {}) -> pure $ WorkflowExitContinuedAsNew e
                      , E.Handler $ \WorkflowCancelRequested -> pure $ WorkflowExitCancelled WorkflowCancelRequested
                      , E.Handler $ \AsyncCancelled -> E.throwIO AsyncCancelled
                      , E.Handler $ \(e :: SomeException) -> pure $ WorkflowExitFailed e
                      ]

      shutdownThreads myTid = do
        -- Theoretically, you could have threads created after taking all of these,
        -- but that shouldn't happen in practice.
        ts <- atomically do
          deregisterThread runtime myTid
          readTVar $ threadManager $ getThreadManager runtime
        -- TODO, report abandoned signals and updates to user
        mapM_ cancelWorkflowThreadNoWait $ HashMap.keys ts

      eval :: InstanceM (WorkflowExitVariant Payload)
      eval = mask $ \restore -> do
        tid <- myThreadId
        let tidText = Text.pack (show tid)
            threadWrapper _restore = id
            runner = do
              atomically $ registerThread runtime tid
              result <- restore (runTopLevel m)
              cmd <- convertExitVariantToCommand result
              atomically do
                CommandQueue.addCommand runtime cmd
              pure result
        threadWrapper restore runner `finally` shutdownThreads tid

      applyActivations mainThreadId = do
        activation <- readTQueue runtime.workflowRuntimeInstance.activationChannel
        activate runtime activation mainThreadId

      applyQueuedSignals :: Async (WorkflowExitVariant Payload) -> STM (Int, IO ())
      applyQueuedSignals mainThread = do
        signalHandlers <- readTVar runtime.signals.signalHandlers
        handleableSignals <- stateTVar runtime.signals.bufferedSignals $ \signals ->
          span (\signal -> (Just (signal ^. Activation.signalName) `HashMap.member` signalHandlers) || (Nothing `HashMap.member` signalHandlers)) signals
        let signalCount = length handleableSignals
        if signalCount > 0
          then runApplyM runtime mainThread do
            applySTM $ modifyTVar' runtime.workflowRuntimeUnappliedJobs (+ length handleableSignals)
            mapM_ handleSignalWorkflow handleableSignals
            pure signalCount
          else pure (signalCount, pure ())

      applyQueuedQueries :: Async (WorkflowExitVariant Payload) -> STM (Int, IO ())
      applyQueuedQueries mainThread = do
        queryHandlers <- readTVar runtime.queries.queryHandlers
        queriesToProcess <- stateTVar runtime.queries.bufferedQueries $ \queries -> (queries, [])
        let (goodQueries, badQueries) =
              span
                ( \query ->
                    (Just (query ^. Activation.queryType) `HashMap.member` queryHandlers) || (Nothing `HashMap.member` queryHandlers)
                )
                queriesToProcess
        -- TODO, do we need to count unapplied jobs here. I think so.
        modifyTVar' runtime.workflowRuntimeUnappliedJobs (+ length goodQueries)
        res@(_, actions) <- runApplyM runtime mainThread $ mapM handleQueryWorkflow goodQueries
        for_ badQueries $ \query -> do
          CommandQueue.addCommand runtime $
            defMessage
              & Command.respondToQuery
                .~ ( defMessage
                      & Command.queryId .~ query ^. Activation.queryId
                      & Command.failed .~ (defMessage & Failure.message .~ "Query not found")
                   )
        pure (length goodQueries, actions)

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
      schedule :: Async (WorkflowExitVariant Payload) -> InstanceM ()
      schedule mainThread = mask $ \restore -> do
        let mainThreadId = asyncThreadId mainThread
        -- We need something to be started in order to ensure that we don't immediately
        -- hit 'waitAllThreadsBlocked' is True.
        --
        -- It's also ideal to wait for the main thread to be blocked, because then it's
        -- had a chance to register its signal handlers, etc.
        tid <- myThreadId
        atomically do
          threads <- readTVar (getThreadManager runtime).threadManager
          mainThreadOutcome <- pollSTM mainThread
          case mainThreadOutcome of
            Nothing -> case HashMap.lookup mainThreadId threads of
              Just thread -> do
                blocked <- readTVar thread.workflowThreadBlocked
                unless blocked retry
              Nothing -> do
                retry -- Waiting for the main thread to get added to the thread manager.
            Just _ -> pure ()

        -- It's important that 'activate' fully consumes the activation from the channel
        -- before we block again. Otherwise, we might end up in a situation where
        -- we say we're ready to flush, but we haven't processed the previous activation.
        -- This could cause a deadlock.
        --
        -- If we have applied all the activations, then we take a stab at running any
        -- queued signals, queries, and updates in case an unblocking of the Workflow
        -- allowed them to be processed.
        forever do
          -- We use activations and flushes are 1:1, and we want to
          -- ensure that we flush in the face of errors before failing out.
          ( do
              liftIO $ join $ atomically $ applyActivations mainThread
              atomically do
                waitAllJobsHandled runtime
                waitAllThreadsBlocked runtime
              untilM_ do
                (handleCount, m) <- atomically $ applyQueuedSignals mainThread
                liftIO m
                atomically do
                  waitAllJobsHandled runtime
                  waitAllThreadsBlocked runtime
                pure (handleCount == 0)
              -- By the time we've applied all the signals that we can,
              -- all of the queries we can possibly handle must have been
              -- defined.
              liftIO . snd =<< atomically (applyQueuedQueries mainThread)
              restore $ atomically do
                waitAllJobsHandled runtime
                waitAllThreadsBlocked runtime
            )
            `finally` do
              flushCommands runtime

      waitAllJobsHandled runtime = do
        unappliedJobs <- readTVar runtime.workflowRuntimeUnappliedJobs
        tid <- unsafeIOToSTM myThreadId
        guard (unappliedJobs == 0)

    e <- async eval
    s <- async (schedule e `finally` $(logDebug) "Schedule thread exiting")
    -- We want these threads
    link e
    link s
    pure $ RunningWorkflow s e runtime


flushCommands :: (HasCallStack, MonadLogger m, MonadIO m) => WorkflowRuntime -> m ()
flushCommands runtime = do
  tid <- liftIO myThreadId
  (info, cmds) <- atomically do
    info <- readTVar runtime.workflowRuntimeInstance.workflowInstanceInfo
    cmds <- CommandQueue.getCommands runtime.workflowRuntimeCommandQueue
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
    Left err -> do
      throwIO err
    Right () -> do
      pure ()


activate :: WorkflowRuntime -> WorkflowActivation -> Async (WorkflowExitVariant Payload) -> STM (IO ())
activate runtime act mainThread = do
  let inst = runtime.workflowRuntimeInstance
  tid <- unsafeIOToSTM myThreadId
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
  let jobCount = Data.Foldable.length (act ^. Activation.vec'jobs)
  pure do
    let apply = try do
          runReaderT
            (unInstanceM $ applyJobs mainThread (act ^. Activation.vec'jobs))
            runtime
    eResult <- case inst.workflowDeadlockTimeout of
      Nothing -> do
        apply
      Just timeoutDuration -> do
        res <- UnliftIO.timeout timeoutDuration apply
        pure $ case res of
          Nothing ->
            Left $ toException $ LogicBug WorkflowActivationDeadlock
          Just res' ->
            res'
    case eResult of
      Left err -> do
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


markJobHandled :: WorkflowRuntime -> STM ()
markJobHandled runtime = do
  jobCount <- readTVar runtime.workflowRuntimeUnappliedJobs
  writeTVar runtime.workflowRuntimeUnappliedJobs (jobCount - 1)


applyJobHandled :: ApplyM ()
applyJobHandled = do
  runtime <- askRuntime
  applySTM $ markJobHandled runtime


applyJobs :: Async (WorkflowExitVariant Payload) -> Vector WorkflowActivationJob -> InstanceM ()
applyJobs mainThread jobs = do
  runtime <- ask
  tid <- myThreadId
  let jobCount = Data.Foldable.length jobs
  -- We want the atomicity here because we want to ensure that all the Workflow threads get the ability to
  -- unblock at the same time.
  (_, jobActions) <- atomically $ runApplyM runtime mainThread $ do
    applySTM $ writeTVar runtime.workflowRuntimeUnappliedJobs jobCount
    for jobs $ \job -> do
      case fromMaybe (error "applyJobs: Job has no variant") (job ^. Activation.maybe'variant) of
        WorkflowActivationJob'NotifyHasPatch n -> do
          handleNotifyHasPatch n
        WorkflowActivationJob'SignalWorkflow sig -> do
          handleSignalWorkflow sig
        WorkflowActivationJob'QueryWorkflow q -> do
          handleQueryWorkflow q
        WorkflowActivationJob'FireTimer r -> do
          handleFireTimer r
        WorkflowActivationJob'ResolveActivity r -> do
          handleResolveActivity r
        WorkflowActivationJob'ResolveChildWorkflowExecutionStart r -> do
          handleResolveChildWorkflowExecutionStart r
        WorkflowActivationJob'ResolveChildWorkflowExecution r -> do
          handleResolveChildWorkflowExecution r
        WorkflowActivationJob'ResolveSignalExternalWorkflow r -> do
          handleResolveSignalExternalWorkflow r
        WorkflowActivationJob'ResolveRequestCancelExternalWorkflow r -> do
          handleResolveRequestCancelExternalWorkflow r
        WorkflowActivationJob'UpdateRandomSeed updateRandomSeed -> do
          handleUpdateRandomSeed updateRandomSeed
        WorkflowActivationJob'CancelWorkflow cancelWorkflow -> do
          handleCancelWorkflow cancelWorkflow
        WorkflowActivationJob'InitializeWorkflow startWorkflow -> do
          handleStartWorkflow startWorkflow
        WorkflowActivationJob'RemoveFromCache removeFromCache -> do
          handleRemoveFromCache removeFromCache
        WorkflowActivationJob'DoUpdate doUpdate -> do
          handleDoUpdate doUpdate
        WorkflowActivationJob'ResolveNexusOperationStart _ -> do
          applyJobHandled
        WorkflowActivationJob'ResolveNexusOperation _ -> do
          applyJobHandled

  liftIO jobActions


handleNotifyHasPatch :: NotifyHasPatch -> ApplyM ()
handleNotifyHasPatch n = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
    let inst = runtime.workflowRuntimeInstance
    modifyTVar' inst.workflowNotifiedPatches $ \patchSet ->
      Set.insert (n ^. Activation.patchId . to PatchId) patchSet


handleSignalWorkflow :: SignalWorkflow -> ApplyM ()
handleSignalWorkflow sig = do
  runtime <- askRuntime
  let inst = runtime.workflowRuntimeInstance
  handlers <- applySTM $ readTVar runtime.signals.signalHandlers
  case specificHandlerOrDefault handlers (sig ^. Activation.signalName) of
    Nothing -> applySTM do
      -- TODO, if there's a huge amount of signals, this is algorithmically inefficient.
      modifyTVar' runtime.signals.bufferedSignals (++ [sig])
      markJobHandled runtime
    Just handler -> do
      mainThread <- askMainThread
      applyIO $ mask_ do
        -- signals can block (via sleep, or waiting on a condition), so we run them
        -- in a separate thread.
        void $ asyncWithUnmask $ \restore -> do
          tid <- myThreadId
          args <-
            processorDecodePayloads
              inst.payloadProcessor
              (fmap convertFromProtoPayload (sig ^. Command.vec'input))
          atomically do
            markJobHandled runtime
            registerThread runtime tid
          restore (handler args) `finally` atomically do
            deregisterThread runtime tid


handleQueryWorkflow :: QueryWorkflow -> ApplyM ()
handleQueryWorkflow q = do
  runtime <- askRuntime
  let inst = runtime.workflowRuntimeInstance
  handlers <- applySTM $ readTVar runtime.queries.queryHandlers
  case specificHandlerOrDefault handlers (q ^. Activation.queryType) of
    Nothing -> applySTM do
      -- If there's a huge amount of queries, this is algorithmically inefficient.
      --
      -- This is not likely to be an issue in practice, because queries are unlikely to show
      -- up en masse, and because queries are pretty much always registered at the start of
      -- Workflow implementations
      modifyTVar' runtime.queries.bufferedQueries (++ [q])
      markJobHandled runtime
    Just handler -> applyIO do
      args <- processorDecodePayloads inst.payloadProcessor (fmap convertFromProtoPayload (q ^. Command.vec'arguments))
      let baseInput =
            HandleQueryInput
              { handleQueryId = q ^. Activation.queryId
              , handleQueryInputType = q ^. Activation.queryType
              , handleQueryInputArgs = args
              , handleQueryInputHeaders = fmap convertFromProtoPayload (q ^. Activation.headers)
              }
      res <- liftIO $ inst.inboundInterceptor.handleQuery baseInput $ \input -> do
        handler (QueryId input.handleQueryId) input.handleQueryInputArgs input.handleQueryInputHeaders
      cmd <- case res of
        Left err -> do
          -- TODO, more useful error message
          pure $ defMessage & Command.failed .~ (defMessage & Failure.message .~ Text.pack (show err))
        Right ok -> do
          res' <- liftIO $ payloadProcessorEncode inst.payloadProcessor ok
          pure $ defMessage & Command.queryId .~ baseInput.handleQueryId & Command.succeeded .~ (defMessage & Command.response .~ convertToProtoPayload res')
      atomically do
        markJobHandled runtime
        CommandQueue.addCommand runtime $ defMessage & Command.respondToQuery .~ cmd


handleFireTimer :: FireTimer -> ApplyM ()
handleFireTimer msg = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
    let t = msg ^. Activation.seq . to Sequence
    mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.timers t
    case mvar of
      Nothing -> Catch.throwM $ RuntimeError "Timer not found"
      Just ivar' -> putIVar ivar' ()


handleResolveActivity :: ResolveActivity -> ApplyM ()
handleResolveActivity msg = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
    let a = msg ^. Activation.seq . to Sequence
    mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.activities a
    case mvar of
      Nothing -> Catch.throwM $ RuntimeError "Activity handle not found"
      Just existing -> putIVar existing msg


handleResolveChildWorkflowExecutionStart :: ResolveChildWorkflowExecutionStart -> ApplyM ()
handleResolveChildWorkflowExecutionStart msg = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
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
                  START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS ->
                    Left $
                      toException $
                        WorkflowAlreadyStarted
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


handleResolveChildWorkflowExecution :: ResolveChildWorkflowExecution -> ApplyM ()
handleResolveChildWorkflowExecution msg = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
    let r = msg ^. Activation.seq . to Sequence
    mHandle <- resolveSequence runtime.workflowRuntimeSequenceMaps.childWorkflows r
    case mHandle of
      Nothing ->
        Catch.throwM $ RuntimeError "Child workflow handle not found"
      Just existing -> putIVar existing.resultHandle msg


handleResolveSignalExternalWorkflow :: ResolveSignalExternalWorkflow -> ApplyM ()
handleResolveSignalExternalWorkflow msg = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
    let r = msg ^. Activation.seq . to Sequence
    mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.externalSignals r
    case mvar of
      Nothing -> Catch.throwM $ RuntimeError "External signal handle not found"
      Just ivar -> putIVar ivar msg


handleResolveRequestCancelExternalWorkflow :: ResolveRequestCancelExternalWorkflow -> ApplyM ()
handleResolveRequestCancelExternalWorkflow msg = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
    let r = msg ^. Activation.seq . to Sequence
    mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.externalCancels r
    case mvar of
      Nothing -> Catch.throwM $ RuntimeError "External cancel handle not found"
      Just ivar -> putIVar ivar msg


handleUpdateRandomSeed :: UpdateRandomSeed -> ApplyM ()
handleUpdateRandomSeed r = do
  runtime <- askRuntime
  let inst = runtime.workflowRuntimeInstance
  applyIO do
    tid <- myThreadId
    writeIORef
      (unWorkflowGenM inst.workflowRandomnessSeed)
      (mkStdGen $ fromIntegral $ r ^. Activation.randomnessSeed)
    atomically $ markJobHandled runtime


handleCancelWorkflow :: CancelWorkflow -> ApplyM ()
handleCancelWorkflow _ = do
  runtime <- askRuntime
  applySTM do
    markJobHandled runtime
    putIVar runtime.workflowRuntimeCancelRequested ()


handleStartWorkflow
  :: InitializeWorkflow
  -> ApplyM ()
handleStartWorkflow _ = applyJobHandled


handleRemoveFromCache :: RemoveFromCache -> ApplyM ()
handleRemoveFromCache _ = applyJobHandled


handleDoUpdate :: DoUpdate -> ApplyM ()
handleDoUpdate doUpdate = do
  runtime <- askRuntime
  mainThread <- askMainThread
  let inst = runtime.workflowRuntimeInstance
      acceptUpdate =
        CommandQueue.addCommand runtime $
          defMessage
            & Command.updateResponse
              .~ ( defMessage
                    & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                    & Command.accepted .~ defMessage
                 )
      rejectUpdate :: forall e. Exception e => e -> STM ()
      rejectUpdate err =
        CommandQueue.addCommand runtime $
          defMessage
            & Command.updateResponse
              .~ ( defMessage
                    & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                    & Command.rejected .~ applicationFailureToFailureProto (mkApplicationFailure (toException err) inst.errorConverters)
                 )
      completeUpdate payload =
        CommandQueue.addCommand runtime $
          defMessage
            & Command.updateResponse
              .~ ( defMessage
                    & Command.protocolInstanceId .~ (doUpdate ^. Activation.protocolInstanceId)
                    & Command.completed .~ convertToProtoPayload payload
                 )

  -- (validator, updateAction) <- do
  handlers <- applySTM $ readTVar runtime.updates.updateHandlers
  case specificHandlerOrDefault handlers (doUpdate ^. Activation.name) of
    Nothing -> applySTM do
      let errMessage = Text.pack ("No update handler found for update: " <> show (doUpdate ^. Activation.name))
      let err = UpdateNotFound errMessage
      markJobHandled runtime
      rejectUpdate err
    Just WorkflowUpdateImplementation {..} -> applyIO do
      updateArgs <- UnliftIO.try $ processorDecodePayloads inst.payloadProcessor (fmap convertFromProtoPayload (doUpdate ^. Activation.vec'input))
      let runValidator = doUpdate ^. Activation.runValidator
          updateId = UpdateId $ doUpdate ^. Activation.id
          updateHeaders = fmap convertFromProtoPayload (doUpdate ^. Activation.headers)
      case updateArgs of
        Left err -> atomically do
          markJobHandled runtime
          rejectUpdate (err :: SomeException)
        Right args -> do
          let baseInput =
                HandleUpdateInput
                  { handleUpdateId = updateId
                  , handleUpdateInputType = doUpdate ^. Activation.name
                  , handleUpdateInputArgs = args
                  , handleUpdateInputHeaders = updateHeaders
                  }
              runUpdateTopLevel :: IO (Either SomeException Payload) -> InstanceM ()
              runUpdateTopLevel m = do
                void $ asyncWithUnmask $ \restore -> do
                  tid <- myThreadId
                  atomically do
                    acceptUpdate
                    markJobHandled runtime
                    registerThread runtime tid
                  ePayload <- restore (liftIO m)
                  case ePayload of
                    Left err -> do
                      atomically do
                        rejectUpdate err
                        deregisterThread runtime tid
                      throwM err
                    Right payload -> do
                      payload' <- liftIO $ payloadProcessorEncode inst.payloadProcessor payload
                      atomically do
                        completeUpdate payload'
                        deregisterThread runtime tid
              runUpdate :: InstanceM ()
              runUpdate = runUpdateTopLevel $ handleUpdate inst.inboundInterceptor baseInput $ \input ->
                UnliftIO.try $ runInstanceM runtime $ updateImplementation input.handleUpdateId input.handleUpdateInputArgs input.handleUpdateInputHeaders
          if runValidator
            then do
              eValidatorResult <- case updateValidationImplementation of
                Nothing -> pure $ Right ()
                Just f -> do
                  eResult <- UnliftIO.try $
                    liftIO $
                      inst.inboundInterceptor.validateUpdate baseInput $ \input ->
                        unValidation $ f input.handleUpdateId input.handleUpdateInputArgs input.handleUpdateInputHeaders
                  pure $ join eResult
              case eValidatorResult of
                Left err -> atomically do
                  markJobHandled runtime
                  rejectUpdate (err :: SomeException)
                Right () -> runUpdate
            else runUpdate


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
      let appFailure = mkApplicationFailure e inst.errorConverters
          enrichedApplicationFailure = applicationFailureToFailureProto appFailure
      pure $
        defMessage
          & Command.failWorkflowExecution
            .~ ( defMessage
                  & Command.failure .~ enrichedApplicationFailure
               )


addCommand :: WorkflowCommand -> InstanceM ()
addCommand command = do
  inst <- ask
  atomically $ CommandQueue.addCommand inst command


-- Bit of a hack. This needs to be called for each workflow activity in the official SDK
updateCallStack :: RequireCallStack => InstanceM ()
updateCallStack = do
  inst <- asks workflowRuntimeInstance
  writeIORef inst.workflowCallStack $ popCallStack callStack


updateCallStackW :: RequireCallStack => Workflow ()
updateCallStackW = Workflow do
  inst <- asks workflowRuntimeInstance
  writeIORef inst.workflowCallStack $ popCallStack callStack


{- | Handle representing an external Workflow Execution.

This handle can only be cancelled and signalled.

To call other methods, like query and result, use a WorkflowClient.getHandle inside an Activity.
-}
data ExternalWorkflowHandle (result :: Type) = ExternalWorkflowHandle
  { externalWorkflowWorkflowId :: WorkflowId
  , externalWorkflowRunId :: Maybe RunId
  }

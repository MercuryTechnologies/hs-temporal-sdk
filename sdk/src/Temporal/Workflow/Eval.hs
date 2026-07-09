{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UndecidableInstances #-}

module Temporal.Workflow.Eval where

import Control.Exception.Base (NoMatchingContinuationPrompt (..))
import Control.Monad (void, when)
import Control.Monad.Reader
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.Stack
import OpenTelemetry.Context.ThreadLocal (attachContext, getContext)
import RequireCallStack
import Temporal.Common
import qualified Temporal.Common.Logging as Logging
import Temporal.Exception (RuntimeError (..))
import Temporal.Workflow.Internal.DelimCC (PromptTag, control0, prompt)
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Types
import Text.Printf
import UnliftIO
import Unsafe.Coerce


withRunId :: Text -> InstanceM Text
withRunId arg = do
  inst <- ask
  info <- readIORef inst.workflowInstanceInfo
  return ("[runId=" <> rawRunId info.runId <> "] " <> arg)


-- | Suspend the run until the driver supplies the next activation's results.
--
-- Run-level analogue of 'suspendVia'.
awaitActivationVia :: PromptTag (RunStatus a) -> IO [ActivationResult]
awaitActivationVia tag = do
  resumed <- newIORef False
  control0
    tag
    ( \k -> pure $ RunBlocked $ \rs -> do
        alreadyResumed <- atomicModifyIORef' resumed (\r -> (True, r))
        when alreadyResumed $
          throwIO $
            RuntimeError "Internal invariant violation: a suspended workflow run was resumed more than once. Please report this as a bug in hs-temporal-sdk."
        prompt tag (k (pure rs))
    )
    `UnliftIO.catch` \NoMatchingContinuationPrompt ->
      throwIO $
        RuntimeError "A workflow run awaited an activation outside the run scheduler. Please report this as a bug in hs-temporal-sdk."


-- How this works:
--
-- A workflow instance executes a `Workflow` computation on its own thread.
-- There is a cooperative interplay between the main instance thread
-- responsible for executing WorkflowActivations and the workflow thread.
--
-- The workflow thread evaluates computations as deeply as possible before
-- blocking and forcing the WorkfowActivation processing code to submit
-- a WorkflowActivationCompletion to the core worker.
--
-- This has a lot of similarities to ideas from Haxl's GenHaxl monad with
-- regards to suspending and resuming as we get results back, but is different
-- in that we want to treat execution of async tasks
-- (executeChildWorkflow, timers, etc.) as awaitable and cancellable.
-- That is, we return a handle similar to an Async value and
-- let the workflow writer choose if/when to suspend. It's also viable
-- to just start a workflow or activity for its side effects and ignore the result
--
-- Another difference is that workflow signals allow for these handles to be
-- altered out of band, so we can't just traverse the tree and trust the
-- computation flow to be fully within our control. I think this is fine,
-- but it does mean that we might need to update the scheduler code below
-- to allow injecting these signals into the run queue.
--
-- Regardless, once we signal a WorkflowActivationCompletion, we wait in a
-- suspended state.
--
-- The core worker will eventually activate the instance again, at which
-- point we use Sequence values in the variants of the different workflow
-- activation jobs to fill any corresponding handles with their
-- results and continue execution.
--                                                              ┌────────────────────┐
--                               Run a Workflow action that     │                    │
--                               fills an IVar.                 │                    │
--                                                              │      schedule      │
--                               Once we get the result of the  │                    │
--                               Workflow action, figure out if │                    │
--                               the full computation is        └────────────────────┘
--                               completed. If not, reschedule  ▲          │
--                               to execute more Workflow code. │          │
--                                                              │          ▼
--                                                              ┌────────────────────┐
--                                                              │                    │
--                                                              │                    │
--                                ┌────────────────────┐◀────── │     reschedule     │
--                                │                    │        │                    │
--                                │                    │        │                    │
--                  ┌─────────────│   emptyRunQueue    │───────▶└────────────────────┘
--                  │             │                    │
--                  │             │                    │
--                  │             └────────────────────┘◀────────────────────────────────┐
--                  │             ▲          │                                           │
--                  │             │          └───────┐                                   │
--                  │             │                  │                                   │
--                  ▼             │                  ▼                                   │
--     ┌────────────────────────┐ ┌────────────────────────────────────┐    ┌────────────────────────┐
--     │                        │ │                                    │    │                        │
--     │ checkActivationResults │ │  flushCommandsAndAwaitActivation   │───▶│ waitActivationResults  │
--     │                        │ │                                    │    │                        │
--     └────────────────────────┘ └────────────────────────────────────┘    └────────────────────────┘
-- Look at queued workflow         If we don't have any filled
-- computations. If we don't have  IVars after calling
-- any queued computations to      checkActivationResults, and we         The workflow activation logic
-- run, we need to see if there    also don't have any more               is fully in charge of
-- are any activation results      scheduled jobs, then we're             resolving pending IVars, so we
-- that we've received from        blocked. We have to flush what         just hang out until an
-- polling and used to fill IVars  we've got, then wait for an            activation is registered.
-- tracked in the sequence maps.   activation to come in to
--                                 unblock us.
-- If we fill an IVar, then we
-- add any blocked computations
-- to the scheduled jobs list so
-- we can resume working on them.
--
-- We hand this back to
-- emptyRunQueue.
runWorkflow :: forall a. HasCallStack => IO [ActivationResult] -> (RequireCallStackImpl => Workflow a) -> InstanceM a
runWorkflow awaitAction wf = provideCallStack $ do
  inst <- ask
  pendingActivations <- newTVarIO []
  finalResult@IVar {ivarRef = resultRef} <- newIVar -- where to put the final result
  mainLocals <- newFiberLocals
  let
    -- Run a task (fresh or suspended fiber), and put its result in the given IVar
    schedule :: ContinuationEnv -> JobList -> FiberLocals -> FiberTask b -> IVar b -> InstanceM ()
    schedule env rq locals task ivar@IVar {ivarRef = ref} = do
      cs <- readIORef inst.workflowCallStack
      logMsg <- withRunId (Text.pack $ printf "schedule: %d\n%s" (1 + lengthJobList rq) $ prettyCallStack cs)
      Logging.logDebug logMsg
      let {-# INLINE result #-}
          result r = do
            e <- readIORef ref
            case e of
              IVarFull _ ->
                -- An IVar is typically only meant to be written to once
                -- so it's tempting to think we should throw an error here. But there
                -- are legitimate use-cases for writing several times– namely
                -- when using race, biselect, etc.
                reschedule env rq
              IVarEmpty workflowActions -> do
                writeIORef ref (IVarFull r)
                -- Have we got the final result now?
                if ref == unsafeCoerce resultRef
                  then -- comparing IORefs of different types is safe, it's
                  -- pointer-equality on the MutVar#.

                    -- TODO, I don't know if there are any cases where we need
                    -- to worry about discarding unfinished computations, but
                    -- I think exiting at the conclusion of a workflow is the
                    -- right thing to do.
                    pure ()
                  else -- We have a result, but don't discard unfinished
                  -- computations in the run queue.
                  --
                  -- In our case, unfinished computations can represent signals.
                    reschedule env $ appendJobList workflowActions rq
      r <- UnliftIO.try $ withFiberContext locals $ runFiberTask env locals task
      case r of
        Left e
          | Just (WorkflowThrown inner) <- fromException e -> do
              -- Nothing awaits a detached handler fiber's result, so surface
              -- the failure in the logs instead of letting it vanish. Update
              -- handlers rethrow after reporting a rejection to the server,
              -- so this is debug-level noise for them; see
              -- applyDoUpdateWorkflow.
              when (fiberIsDetachedHandler locals) $
                Logging.logDebug =<< withRunId ("Signal/update handler finished with a workflow-level exception (dropped; update rejections are already reported): " <> Text.pack (show inner))
              result $ ThrowWorkflow inner
          | otherwise -> do
              rethrowAsyncExceptions e
              when (fiberIsDetachedHandler locals) $
                Logging.logWarn =<< withRunId ("Unhandled exception in a signal/update handler; nothing awaits the handler's result, so the exception is dropped: " <> Text.pack (show e))
              result $ ThrowInternal e
        Right (SDone a) -> result $ Ok a
        Right (SBlocked i k) -> do
          Logging.logDebug =<< withRunId "scheduled job blocked"
          parkTask env locals (ResumeTask i k) ivar i
          reschedule env rq

    reschedule :: ContinuationEnv -> JobList -> InstanceM ()
    reschedule env@ContinuationEnv {..} jobs = do
      Logging.logDebug =<< withRunId "reschedule"
      case jobs of
        JobNil -> do
          rq <- readIORef runQueueRef
          case rq of
            JobNil -> emptyRunQueue env
            JobCons env' locals' task' ivar' rest -> do
              writeIORef runQueueRef JobNil
              schedule env' rest locals' task' ivar'
        JobCons env' locals' task' ivar' rest ->
          schedule env' rest locals' task' ivar'

    emptyRunQueue :: ContinuationEnv -> InstanceM ()
    emptyRunQueue env = do
      Logging.logDebug =<< withRunId "emptyRunQueue"
      workflowActions <- checkActivationResults env
      case workflowActions of
        JobNil -> awaitActivation env
        _ -> reschedule env workflowActions

    awaitActivation :: ContinuationEnv -> InstanceM ()
    awaitActivation env = do
      Logging.logDebug =<< withRunId "flushCommandsAndAwaitActivation"
      waitActivationResults env

    checkActivationResults :: ContinuationEnv -> InstanceM JobList
    checkActivationResults _env = do
      Logging.logDebug =<< withRunId "checkActivationResults"
      comps <- atomically $ do
        c <- readTVar pendingActivations
        writeTVar pendingActivations []
        pure c
      case comps of
        [] -> do
          Logging.logDebug =<< withRunId "No new activation results"
          return JobNil
        _ -> do
          Logging.logDebug =<< withRunId (Text.pack $ printf "%d complete" (length comps))
          let
            getComplete (ActivationResult a IVar {ivarRef = cr}) = do
              r <- readIORef cr
              case r of
                IVarFull _ -> do
                  Logging.logDebug =<< withRunId "existing result"
                  return JobNil
                -- this happens if a data source reports a result,
                -- and then throws an exception.  We call putResult
                -- a second time for the exception, which comes
                -- ahead of the original request (because it is
                -- pushed on the front of the completions list) and
                -- therefore overrides it.
                IVarEmpty cv -> do
                  writeIORef cr (IVarFull a)
                  return cv
          jobs <- mapM getComplete comps
          return (foldr appendJobList JobNil jobs)

    waitActivationResults :: ContinuationEnv -> InstanceM ()
    waitActivationResults env = do
      Logging.logDebug =<< withRunId "waitActivationResults"
      newActivations <- do
        activations <- readTVarIO pendingActivations
        if null activations
          then liftIO awaitAction
          else do
            atomically $ writeTVar pendingActivations []
            return activations
      atomically $ writeTVar pendingActivations newActivations
      jobs <- readIORef env.runQueueRef
      case jobs of
        JobNil -> emptyRunQueue env
        _ -> do
          writeIORef env.runQueueRef JobNil
          reschedule env jobs

  let env = inst.workflowInstanceContinuationEnv
  schedule env JobNil mainLocals (FreshTask wf) finalResult
  r <- readIORef resultRef
  case r of
    IVarEmpty _ -> error "runWorkflow: missing result"
    IVarFull (Ok a) -> pure a
    IVarFull (ThrowWorkflow e) -> throwIO e
    IVarFull (ThrowInternal e) -> throwIO e


rethrowAsyncExceptions :: MonadIO m => SomeException -> m ()
rethrowAsyncExceptions e
  | Just SomeAsyncException {} <- fromException e = UnliftIO.throwIO e
  | otherwise = return ()


-- Injects a signal or update workflow into the job queue.
-- Uses append (FIFO) so signals/updates are processed in arrival order.
injectWorkflowSignalOrUpdate :: Workflow a -> InstanceM ()
injectWorkflowSignalOrUpdate signal = do
  result <- newIVar
  locals <- newDetachedHandlerFiberLocals
  inst <- ask
  let env@(ContinuationEnv jobList) = inst.workflowInstanceContinuationEnv
  -- Append to end (FIFO) to preserve arrival order for signals/updates
  modifyIORef' jobList $ \j -> appendJobList j (JobCons env locals (FreshTask signal) result JobNil)


{- | Run one fiber step under the fiber's own OpenTelemetry context.

Fibers for one workflow instance all interleave cooperatively on that
instance's single dedicated GHC thread, so a fiber never migrates threads;
but because sibling fibers share that thread, the thread-local OTel context
left behind by one fiber cannot be trusted by the next. Instead each fiber
owns a context slot: it is attached before
the step, snapshotted back after the step (whether the fiber completed or
suspended), and the ambient context is restored for the scheduler. A fiber
that has not run yet inherits the ambient context of its first step, which
is the workflow's root context.
-}
withFiberContext :: FiberLocals -> InstanceM a -> InstanceM a
withFiberContext locals act = do
  prev <- getContext
  mctx <- readIORef locals.fiberOtelContext
  case mctx of
    Nothing -> pure ()
    Just ctx -> void $ attachContext ctx
  r <- act `UnliftIO.onException` void (attachContext prev)
  writeIORef locals.fiberOtelContext . Just =<< getContext
  void $ attachContext prev
  pure r

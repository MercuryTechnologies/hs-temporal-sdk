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
        alreadyResumed <- readIORef resumed
        writeIORef resumed True
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
-- runWorkflow drives a single workflow run as a tree of cooperatively
-- scheduled fibers on the thread advancing the run (the worker's activator
-- thread).
--
-- Fibers are stepped as far as they go, then block on IVars whose results can
-- only be supplied by a future activation.
-- 
-- When nothing is runnable, the whole run suspends: `awaitAction`
-- captures its continuation up to the prompt installed by `runActivation`,
-- which drains the pending commands into a completion and, on the next
-- activation, fills the awaited IVars and resumes the continuation.
--
-- The scheduler borrows from Haxl's GenHaxl -- run work until it blocks, then
-- suspend -- but treats async operations (e.g. activities, timers, child
-- workflows) as first-class awaitable/cancellable handles rather than an
-- implicit dependency graph: the workflow decides if and when to await a handle.
--
-- Signals and updates may fill handles out of band, so the scheduler also
-- injects their jobs into the run queue.
-- 
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
--     │ checkActivationResults │ │           awaitActivation          │───▶│ waitActivationResults  │
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
  pendingActivations <- newIORef []
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
      Logging.logDebug =<< withRunId "awaitActivation"
      waitActivationResults env

    checkActivationResults :: ContinuationEnv -> InstanceM JobList
    checkActivationResults _env = do
      Logging.logDebug =<< withRunId "checkActivationResults"
      comps <- readIORef pendingActivations
      writeIORef pendingActivations []
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
        activations <- readIORef pendingActivations
        if null activations
          then liftIO awaitAction
          else do
            writeIORef pendingActivations []
            return activations
      writeIORef pendingActivations newActivations
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

Fibers for one workflow instance interleave cooperatively on whichever thread
is advancing the current activation, and a fiber's continuation may resume on
a different thread on a later activation. Either way the thread-local OTel
context left behind by one fiber cannot be trusted by the next, so each fiber
owns a context slot: it is attached before the step, snapshotted back after the
step (whether the fiber completed or suspended), and the ambient context is
restored for the scheduler. A fiber that has not run yet inherits the ambient
context of its first step, which is the workflow's root context.
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

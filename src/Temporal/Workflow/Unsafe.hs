{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Workflow.Unsafe where
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Int (Int32)
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.IO.Exception (BlockedIndefinitelyOnSTM(..))
import GHC.TypeLits
import System.Clock (TimeSpec)
import Temporal.Common
import Temporal.Workflow.WorkflowInstance
import UnliftIO
import Control.Concurrent.STM (retry)
import Unsafe.Coerce

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
-- let the workflow writer choose if/when to suspend. It's also viable (I think)
-- to just start a workflow or activity for its side effects and ignore the result
--
-- Another difference is that workflow signals allow for these handles to be
-- altered out of band, so we can't just traverse the tree and trust the
-- computation flow to be fully within our control.
--
-- Regardless, once we signal a WorkflowActivationCompletion, we wait in a
-- suspended state.
--
-- The core worker will eventually activate the instance again, at which
-- point we use Sequence values in the variants of the different workflow
-- activation jobs to fill any corresponding handles with their
-- results and continue execution.
--
-- We follow this process indefinitely until the final result is returned.
-- At this point, the instance is responsible for marking a workflow as
-- successful or failed.
runWorkflow :: forall env a. Context env -> Workflow env a -> InstanceM env a
runWorkflow ctxt wf = do
  result@IVar{ivarRef = resultRef} <- newIVar -- where to put the final result
  let -- Run a workflow to completion, and put its result in the given IVar.
      schedule :: JobList env -> Workflow env b -> IVar env b -> InstanceM env ()
      schedule runQueue (Workflow run) ivar@IVar{ivarRef = !ref} = do
        $(logDebug) "Schedule"
        let {-# INLINE result #-}
            result r = do
              e <- readIORef ref
              case e of
                IVarFull _ -> 
                  -- We already have a result for this value, so we
                  -- just let execution continue. This case happens if
                  -- we receive multiple writes to the same result,
                  -- but that's fine for temporal's semantics.
                  --
                  -- This is not actually expected to happen in practice,
                  -- but not a problem if it does.
                  reschedule runQueue
                IVarEmpty pendingJobs -> do
                  writeIORef ref (IVarFull r)
                  -- Have we got the final result now?
                  if ref == unsafeCoerce resultRef
                          -- comparing IORefs of different types is safe, it's
                          -- pointer-equality on the MutVar#.
                  then
                    -- We have a result, but don't discard unfinished
                    -- computations in the run queue.
                    -- Nothing can depend on the final IVar, so wfs must
                    -- be empty.
                    case runQueue of
                      JobNil -> return ()
                      _ -> do
                        inst <- ask
                        modifyIORef' inst.workflowRunQueueRef (appendJobList runQueue)
                  else 
                    reschedule (appendJobList pendingJobs runQueue)
        r <- UnliftIO.try $ runReaderT run ctxt
        case r of
          Left e -> do
            rethrowAsyncExceptions e
            result (ThrowInternal e)
          Right (Done a) -> do
            result (Ok a)
          Right (Throw ex) -> do
            result (ThrowWorkflow ex)
          Right (Blocked i fn) -> do
            addJob (toWorkflow fn) ivar i
            reschedule runQueue

      -- execute as much as we can and only complete an 
      -- activation when we have no more computation to do.
      -- This is necessary, because we want all commands
      -- added to the WorkflowActivationCompletion before sending
      -- it off.
      reschedule :: JobList env -> InstanceM env ()
      reschedule workflows = case workflows of
        JobNil -> do
          $(logDebug) "reschedule: empty run queue"
          inst <- ask
          runQueue <- readIORef inst.workflowRunQueueRef
          case runQueue of
            JobNil -> 
              -- If we don't have anything in the run queue, then we
              -- need to flush commands and wait for completions.
              emptyRunQueue
            JobCons workflow resultSlot remainingJobs -> do
              writeIORef inst.workflowRunQueueRef JobNil
              schedule remainingJobs workflow resultSlot
        JobCons workflow resultSlot remainingJobs -> do
          $(logDebug) "reschedule: non-empty run queue"
          schedule remainingJobs workflow resultSlot

      emptyRunQueue :: InstanceM env ()
      emptyRunQueue = do
        $(logDebug) "emptyRunQueue"
        -- Convert any completions to jobs and reschedule if there is anything useful to process.
        wfs <- checkCompletions
        case wfs of
          -- Otherwise, we have no more meaningful work to do, so we need to flush commands and wait
          -- for new completions.
          JobNil -> flushCommands
          _ -> reschedule wfs

      flushCommands :: InstanceM env ()
      flushCommands = do
        $(logDebug) "flushCommands start"
        inst <- ask
        cmds <- atomically $ do
          currentCmds <- readTVar inst.workflowCommands
          case currentCmds of
            FlushActivationCompletion _ -> do
              -- Already trying to flush, so we don't need to do anything.
              retry
            RunningActivation cmds -> case cmds of
              [] -> pure currentCmds
              _ -> do
                -- Signal the main instance thread that it should complete the activation.
                let new = FlushActivationCompletion cmds
                writeTVar inst.workflowCommands new
                pure new
        $(logDebug) ("flushCommands: " <> Text.pack (show cmds))
        emptyRunQueue

      checkCompletions :: InstanceM env (JobList env)
      checkCompletions = do
        inst <- ask
        comps <- atomicallyOnBlocking (LogicBug ReadingCompletionsFailedRun) $ do
          c <- readTVar inst.workflowCompletions
          writeTVar inst.workflowCompletions []
          return c
        $(logDebug) ("checkCompletions: " <> Text.pack (show $ length comps) <> " completions")
        case comps of
          [] -> return JobNil
          _ -> do
            let
                getComplete (CompleteReq a IVar{ivarRef = !cr}) = do
                  r <- readIORef cr
                  case r of
                    IVarFull _ -> do
                      return JobNil
                      -- this could happen if Temporal reports a result,
                      -- and then throws an exception. We call putResult
                      -- a second time for the exception, which comes
                      -- ahead of the original request (because it is 
                      -- pushed on the front of the completions list) and
                      -- therefore overrides it.
                    IVarEmpty cv -> do
                      writeIORef cr (IVarFull a)
                      return cv
            jobs <- mapM getComplete comps
            return (foldr appendJobList JobNil jobs)

      waitCompletions :: InstanceM env ()
      waitCompletions = do
        $(logDebug) "wait completions"
        inst <- ask
        let
          wrapped = atomicallyOnBlocking (LogicBug ReadingCompletionsFailedRun)
          doWait = wrapped $ do
            c <- readTVar inst.workflowCompletions
            when (null c) retry
        doWait
        emptyRunQueue

  schedule JobNil wf result
  r <- readIORef resultRef
  case r of
    IVarEmpty _ -> error "runWorkflow: missing result"
    IVarFull (Ok a) -> pure a
    -- If a user-facing exception wasn't handled within the workflow, then that
    -- means the workflow failed, so we can throw it.
    IVarFull (ThrowWorkflow e) -> throwIO e
    IVarFull (ThrowInternal e) -> throwIO e

atomicallyOnBlocking :: MonadUnliftIO m => Exception e => e -> STM a -> m a
atomicallyOnBlocking e stm = UnliftIO.catch 
  (atomically stm)
  (\BlockedIndefinitelyOnSTM -> throwIO e)

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadIO (Workflow env) where
  liftIO = error "Unreachable"

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadUnliftIO (Workflow env) where
  withRunInIO _ = error "Unreachable"

rethrowAsyncExceptions :: MonadIO m => SomeException -> m ()
rethrowAsyncExceptions e
  | Just SomeAsyncException{} <- fromException e = UnliftIO.throwIO e
  | otherwise = return ()

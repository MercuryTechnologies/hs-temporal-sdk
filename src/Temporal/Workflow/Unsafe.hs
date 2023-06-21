{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Workflow.Unsafe where
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Int (Int32)
import Data.ProtoLens
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.IO.Exception (BlockedIndefinitelyOnSTM(..))
import GHC.TypeLits
import Lens.Family2
import System.Clock (TimeSpec)
import Temporal.Common
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.WorkflowInstance
import Temporal.Worker.Types
import UnliftIO
import Control.Concurrent.STM (retry)
import Unsafe.Coerce
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  , WorkflowCommand'Variant(..)
  , CompleteWorkflowExecution
  )

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
runWorkflow :: forall env st a. IVar env st a -> Workflow env st a -> InstanceM env st (ResultVal a)
runWorkflow result@IVar{ivarRef = resultRef} wf = do
  inst <- ask
  schedule result JobNil wf result
  r <- readIORef resultRef
  case r of
    IVarEmpty _ -> error "runWorkflow: missing result"
    IVarFull result -> pure result

finishWorkflow :: (Codec codec a) => IVar env st a -> codec -> ResultVal a -> InstanceM env st ()
finishWorkflow resVar codec result = do
  cmd <- case result of
    Ok a -> do
        res <- liftIO $ Temporal.Payload.encode codec a
        let completeMessage = defMessage & Command.completeWorkflowExecution .~ (defMessage & Command.result .~ convertToProtoPayload res)
        pure completeMessage
    -- If a user-facing exception wasn't handled within the workflow, then that
    -- means the workflow failed.
    ThrowWorkflow e -> do
      -- eAttrs <- liftIO $ encodeException inst.workflowCodec (e :: SomeException)
      let completeMessage = defMessage & Command.failWorkflowExecution .~ 
            ( defMessage 
              & Command.failure .~ 
                ( defMessage
                  & F.message .~ Text.pack (show e)
                  & F.stackTrace .~ ""
                  -- & F.encodedAttributes .~ convertToProtoPayload eAttrs
                )
            )
      pure completeMessage
    -- Crash the worker if we get an internal exception.
    ThrowInternal e -> throwIO e
  inst <- ask
  addCommand inst cmd
  flushCommands resVar

atomicallyOnBlocking :: MonadUnliftIO m => Exception e => e -> STM a -> m a
atomicallyOnBlocking e stm = UnliftIO.catch 
  (atomically stm)
  (\BlockedIndefinitelyOnSTM -> throwIO e)

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadIO (Workflow env st) where
  liftIO = error "Unreachable"

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadUnliftIO (Workflow env st) where
  withRunInIO _ = error "Unreachable"

rethrowAsyncExceptions :: MonadIO m => SomeException -> m ()
rethrowAsyncExceptions e
  | Just SomeAsyncException{} <- fromException e = UnliftIO.throwIO e
  | otherwise = return ()

addCommand :: (MonadIO m) => WorkflowInstance env st -> WorkflowCommand -> m ()
addCommand inst command = do
  -- $(logDebug) $ Text.pack ("Adding command: " <> show command)
  atomically $ do
    modifyTVar' inst.workflowCommands $ \case
      RunningActivation cmds -> RunningActivation $ push command cmds
      FlushActivationCompletion cmds -> FlushActivationCompletion $ push command cmds

flushCommands :: IVar env st a -> InstanceM env st ()
flushCommands result = do
  inst <- ask
  cmds <- atomically $ do
    currentCmds <- readTVar inst.workflowCommands
    case currentCmds of
      FlushActivationCompletion _ -> do
        -- Already trying to flush, so we don't need to do anything.
        retry
      RunningActivation cmds -> do
        {-
        case cmds of
        (Reversed []) -> pure currentCmds
        _ -> do
          -}
          -- Signal the main instance thread that it should complete the activation.
          let new = FlushActivationCompletion cmds
          writeTVar inst.workflowCommands new
          pure new
  $(logDebug) ("flushCommands: " <> Text.pack (show cmds))
  -- Wait for the main instance thread to complete the activation, we will just spin
  -- on the run loop without having anything useful to process.
  atomically $ do
    c <- readTVar inst.workflowCompletions
    when (null c) retry
  emptyRunQueue result


emptyRunQueue :: IVar env st a -> InstanceM env st ()
emptyRunQueue result = do
  -- Convert any completions to jobs and reschedule if there is anything useful to process.
  wfs <- checkCompletions
  case wfs of
    -- Otherwise, we have no more meaningful work to do, so we need to flush commands and wait
    -- for new completions.
    JobNil -> flushCommands result
    _ -> reschedule result wfs

checkCompletions :: InstanceM env st (JobList env st)
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

-- execute as much as we can and only complete an 
-- activation when we have no more computation to do.
-- This is necessary, because we want all commands
-- added to the WorkflowActivationCompletion before sending
-- it off.
reschedule :: IVar env st a -> JobList env st -> InstanceM env st ()
reschedule result workflows = case workflows of
  JobNil -> do
    inst <- ask
    runQueue <- readIORef inst.workflowRunQueueRef
    case runQueue of
      JobNil -> 
        -- If we don't have anything in the run queue, then we
        -- need to flush commands and wait for completions.
        emptyRunQueue result
      JobCons workflow resultSlot remainingJobs -> do
        writeIORef inst.workflowRunQueueRef JobNil
        schedule result remainingJobs workflow resultSlot
  JobCons workflow resultSlot remainingJobs -> do
    schedule result remainingJobs workflow resultSlot

-- Run a workflow to completion, and put its result in the given IVar.
schedule :: IVar env st a -> JobList env st -> Workflow env st b -> IVar env st b -> InstanceM env st ()
schedule finalResult@IVar{ivarRef = !resultRef} runQueue (Workflow run) ivar@IVar{ivarRef = !ref} = do
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
            reschedule finalResult runQueue
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
              reschedule finalResult (appendJobList pendingJobs runQueue)
  r <- UnliftIO.try run
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
      reschedule finalResult runQueue

waitCompletions :: IVar env st a -> InstanceM env st ()
waitCompletions result = do
  inst <- ask
  let
    wrapped = atomicallyOnBlocking (LogicBug ReadingCompletionsFailedRun)
    doWait = wrapped $ do
      c <- readTVar inst.workflowCompletions
      when (null c) retry
  doWait
  emptyRunQueue result
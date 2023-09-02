{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Workflow.Unsafe where
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Int (Int32)
import Data.List.NonEmpty (NonEmpty)
import Data.ProtoLens
import Data.Kind
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.IO.Exception (BlockedIndefinitelyOnSTM(..))
import GHC.Stack
import GHC.TypeLits
import Lens.Family2
import Temporal.Common
import Temporal.Coroutine
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.WorkflowInstance
import Temporal.Worker.Types
import UnliftIO
import Control.Concurrent.STM (retry, writeTVar)
import Unsafe.Coerce
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  , WorkflowCommand'Variant(..)
  , CompleteWorkflowExecution
  )
import qualified Control.Exception
import Text.Printf
import RequireCallStack

withRunId :: Text -> InstanceM Text
withRunId arg = do
  inst <- ask
  info <- readIORef $ inst.workflowInstanceInfo
  return ("[runId=" <> rawRunId info.runId <> "] " <> arg)

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
runWorkflow :: forall a. HasCallStack => (RequireCallStackImpl => Workflow a) -> SuspendableWorkflowExecution a
runWorkflow wf = provideCallStack $ do
  inst <- lift ask
  pendingActivations <- lift $ newTVarIO []
  let env = inst.workflowInstanceContinuationEnv
  result@IVar{ivarRef = resultRef} <- newIVar -- where to put the final result
  let
    -- Run a job, and put its result in the given IVar
    schedule :: ContinuationEnv -> JobList -> Workflow b -> IVar b -> SuspendableWorkflowExecution ()
    schedule env@ContinuationEnv{..} rq wf ivar@IVar{ivarRef = !ref} = do
      lift $ do
        cs <- readIORef inst.workflowCallStack
        logMsg <- withRunId (Text.pack $ printf "schedule: %d\n%s" (1 + lengthJobList rq) $ prettyCallStack cs)
        $logDebug logMsg
      let {-# INLINE result #-}
          result r = do
            e <- lift $ readIORef ref
            case e of
              IVarFull _ ->
                -- An IVar is typically only meant to be written to once
                -- so it would make sense to throw an error here. But there
                -- are legitimate use-cases for writing several times.
                -- (See Haxl.Core.Parallel)
                reschedule env rq
              IVarEmpty workflowActions -> do
                lift $ writeIORef ref (IVarFull r)
                -- Have we got the final result now?
                if ref == unsafeCoerce resultRef
                        -- comparing IORefs of different types is safe, it's
                        -- pointer-equality on the MutVar#.
                  then pure ()
                    -- TODO- Haxl had the following comment here:
                    -- We have a result, but don't discard unfinished
                    -- computations in the run queue. See
                    -- Note [runHaxl and unfinished requests].
                    -- Nothing can depend on the final IVar, so workflowActions must
                    -- be empty.
                    -- case rq of
                    --   JobNil -> return ()
                    --   _ -> modifyIORef' runQueueRef (appendJobList rq)
                  else reschedule env $ appendJobList workflowActions rq
      r <- lift $ UnliftIO.try $  do
        let (Workflow run) = wf
        run env
      case r of
        Left e -> do
          rethrowAsyncExceptions e
          result $ ThrowInternal e
        Right (Done a) -> result $ Ok a
        Right (Throw ex) -> result $ ThrowWorkflow ex
        Right (Blocked i fn) -> do
          lift ($logDebug =<< withRunId "scheduled job blocked")
          lift $ addJob env (toWf fn) ivar i
          reschedule env rq

    reschedule :: ContinuationEnv -> JobList -> SuspendableWorkflowExecution ()
    reschedule env@ContinuationEnv{..} jobs = do
      lift ($logDebug =<< withRunId "reschedule")
      case jobs of
        JobNil -> do
          rq <- lift $ readIORef runQueueRef
          case rq of
            JobNil -> emptyRunQueue env
            JobCons env' a b c -> do
              lift $ writeIORef runQueueRef JobNil
              schedule env' c a b
        JobCons env' a b c ->
          schedule env' c a b
    
    emptyRunQueue :: ContinuationEnv -> SuspendableWorkflowExecution ()
    emptyRunQueue env = do
      lift $ do
        logMsg <- withRunId "emptyRunQueue"
        $logDebug logMsg
      workflowActions <- checkActivationResults env
      case workflowActions of
        JobNil -> flushCommandsAndAwaitActivation env
        _ -> reschedule env workflowActions
    
    flushCommandsAndAwaitActivation :: ContinuationEnv -> SuspendableWorkflowExecution ()
    flushCommandsAndAwaitActivation env@ContinuationEnv{..} = do
      inst <- lift ask
      lift ($logDebug =<< withRunId "flushCommandsAndAwaitActivation")
      waitActivationResults env

    checkActivationResults :: ContinuationEnv -> SuspendableWorkflowExecution JobList
    checkActivationResults ContinuationEnv{..} = lift $ do
      $logDebug =<< withRunId "checkActivationResults"
      comps <- atomically $ do
        c <- readTVar pendingActivations
        writeTVar pendingActivations []
        pure c
      case comps of
        [] -> do
          $logDebug =<< withRunId "No new activation results"
          return JobNil
        _ -> do
          ($logDebug =<< withRunId (Text.pack $ printf "%d complete" (length comps)))
          let
              getComplete (ActivationResult a IVar{ivarRef = !cr}) = do
                r <- readIORef cr
                case r of
                  IVarFull _ -> do
                    $logDebug =<< withRunId "existing result"
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

    waitActivationResults :: ContinuationEnv -> SuspendableWorkflowExecution ()
    waitActivationResults env@ContinuationEnv{..} = do
      lift ($logDebug =<< withRunId "waitActivationResults")
      newActivations <- do
        activations <- lift $ atomically $ readTVar pendingActivations
        if null activations
          then await
          else do
            lift $ atomically $ writeTVar pendingActivations []
            return activations
      atomically $ writeTVar pendingActivations newActivations
      emptyRunQueue env
  
  schedule env JobNil wf result
  r <- readIORef resultRef
  case r of
    IVarEmpty _ -> error "runWorkflow: missing result"
    IVarFull (Ok a)            -> pure a
    IVarFull (ThrowWorkflow e) -> throwIO e
    IVarFull (ThrowInternal e) -> throwIO e


finishWorkflow :: RawPayload -> InstanceM ()
finishWorkflow result = do
  $logDebug =<< withRunId "Finishing workflow"
  let completeMessage = defMessage & 
        Command.completeWorkflowExecution .~ (defMessage & Command.result .~ convertToProtoPayload result)
  inst <- ask
  addCommand inst completeMessage

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadIO Workflow where
  liftIO = error "Unreachable"

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadUnliftIO Workflow where
  withRunInIO _ = error "Unreachable"

rethrowAsyncExceptions :: MonadIO m => SomeException -> m ()
rethrowAsyncExceptions e
  | Just SomeAsyncException{} <- fromException e = UnliftIO.throwIO e
  | otherwise = return ()

addCommand :: (MonadIO m) => WorkflowInstance -> WorkflowCommand -> m ()
addCommand inst command = do
  atomically $ do
    modifyTVar' inst.workflowCommands $ \cmds -> push command cmds

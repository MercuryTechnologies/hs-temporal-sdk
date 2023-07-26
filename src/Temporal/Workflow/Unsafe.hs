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
runWorkflow :: Workflow env st a -> InstanceM env st (ResultVal a)
runWorkflow wf = do
  eResult <- UnliftIO.try $ unWorkflow wf
  case eResult of
    Left (e :: SomeException) -> pure $ ThrowWorkflow e
    Right result -> pure $ Ok result
-- ^ TODO handle exceptions

finishWorkflow :: (Codec codec a) => codec -> ResultVal a -> InstanceM env st ()
finishWorkflow codec result = do
  $logDebug "Calling finishWorkflow"
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
    -- Except for ContinueAsNew, which we handle specially.
    ThrowInternal e -> case fromException e of
      Just (ContinueAsNewException attrs) -> do
        let completeMessage = defMessage 
              & Command.continueAsNewWorkflowExecution .~ attrs
        pure completeMessage
      Nothing -> throwIO e
  inst <- ask
  addCommand inst cmd
  flushCommands
  -- This seems like it needs to actually wait for the flush to finish.

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

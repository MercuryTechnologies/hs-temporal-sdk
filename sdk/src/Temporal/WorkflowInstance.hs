{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module Temporal.WorkflowInstance (
  WorkflowInstance,
  Info (..),
  create,
  activate,
  nextActivitySequence,
  nextChildWorkflowSequence,
  nextExternalCancelSequence,
  nextExternalSignalSequence,
  nextTimerSequence,
  addStackTraceHandler,
) where

import Control.Applicative
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Foldable
import Data.Functor.Identity
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens
import Data.Set (Set)
import qualified Data.Set as Set
import qualified Data.Text as Text
import Data.Time.Clock.System (SystemTime (..))
import Data.Vault.Strict (Vault)
import Data.Vector (Vector)
import qualified Data.Vector as V
import GHC.Stack (HasCallStack, emptyCallStack)
import Lens.Family2
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow (
  StartChildWorkflowExecutionFailedCause (..),
 )
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation (
  CancelWorkflow,
  DoUpdate,
  FireTimer,
  InitializeWorkflow,
  NotifyHasPatch,
  QueryWorkflow,
  ResolveActivity,
  ResolveChildWorkflowExecution,
  ResolveChildWorkflowExecutionStart,
  ResolveChildWorkflowExecutionStart'Status (..),
  ResolveRequestCancelExternalWorkflow,
  ResolveSignalExternalWorkflow,
  SignalWorkflow,
  UpdateRandomSeed,
  WorkflowActivation,
  WorkflowActivationJob,
  WorkflowActivationJob'Variant (..),
 )
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Completion
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import RequireCallStack (provideCallStack)
import System.Random (mkStdGen)
import Temporal.Common
import qualified Temporal.Core.Worker as Core
import Temporal.Coroutine
import Temporal.Duration
import Temporal.Exception
import qualified Temporal.Exception as Err
import Temporal.Interceptor
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.Instance
import Temporal.Workflow.Internal.Instance
import Temporal.Workflow.Internal.MonadV2
import Temporal.Workflow.Types
import UnliftIO


create
  :: (HasCallStack, MonadLoggerIO m)
  => (Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  -> Maybe Int
  -- ^ deadlock timeout in seconds
  -> [ApplicationFailureHandler]
  -> WorkflowInboundInterceptor
  -> WorkflowOutboundInterceptor
  -> Vault
  -> PayloadProcessor
  -> Info
  -> m WorkflowInstance
create
  workflowCompleteActivation
  workflowDeadlockTimeout
  errorConverters
  inboundInterceptor
  outboundInterceptor
  workflowVault
  payloadProcessor
  info = do

  $logDebug "Instantiating workflow instance"
  workflowInstanceLogger <- askLoggerIO
  workflowRandomnessSeed <- WorkflowGenM <$> newIORef (mkStdGen 0)
  workflowNotifiedPatches <- newTVarIO mempty
  workflowMemoizedPatches <- newTVarIO mempty
  workflowTime <- newTVarIO $ MkSystemTime 0 0
  workflowIsReplaying <- newTVarIO False
  workflowSignalHandlers <- newTVarIO mempty
  workflowQueryHandlers <- newTVarIO mempty
  workflowCallStack <- newIORef emptyCallStack
  workflowInstanceInfo <- newTVarIO info
  activationChannel <- newTQueueIO
  -- The execution thread is funny because it needs access to the instance, but the instance
  -- needs access to the execution thread. It's a bit of a circular dependency, but
  -- pretty innocuous since writing to the executionThread var happens before anything else
  -- is allowed to interact with the instance.
  let inst = WorkflowInstance {..}
  -- workerThread <- liftIO $ async $ runInstanceM inst $ do
  --   $logDebug "Start workflow execution thread"
  --   exec <- setUpWorkflowExecution start
  --   res <- liftIO $ inboundInterceptor.executeWorkflow exec $ \exec' -> runInstanceM inst $ runTopLevel $ do
  --     $logDebug "Executing workflow"
  --     wf <- applyStartWorkflow exec' workflowFn
  --     runWorkflowToCompletion wf
  --   $logDebug "Workflow execution completed"
  --   addCommand =<< convertExitVariantToCommand res
  --   flushCommands
  --   $logDebug "Handling leftover queries"
  --   handleQueriesAfterCompletion

  -- If we have an exception crash the workflow thread, then we need to throw to the worker too,
  -- otherwise it will just hang forever.
  pure inst


{- | This is a special query handler that is added to every workflow instance.

It allows the Temporal UI to query the current call stack to see what is currently happening
in the workflow.
-}
addStackTraceHandler :: WorkflowInstance -> IO ()
addStackTraceHandler inst = do
  let specialHandler _ _ _ = do
        cs <- readIORef inst.workflowCallStack
        Right <$> Temporal.Payload.encode JSON (Text.pack $ Temporal.Exception.prettyCallStack cs)
  atomically $ modifyTVar' inst.workflowQueryHandlers (HashMap.insert (Just "__stack_trace") specialHandler)


-- -- | This gives us the basic state for a workflow instance prior to initial evaluation.
-- setUpWorkflowExecution :: StartWorkflow -> InstanceM ExecuteWorkflowInput
-- setUpWorkflowExecution startWorkflow = do
--   runtime <- ask
--   let inst = runtime.workflowRuntimeInstance
--   let (WorkflowGenM genRef) = inst.workflowRandomnessSeed
--   writeIORef genRef (mkStdGen $ fromIntegral $ startWorkflow ^. Activation.randomnessSeed)
--   atomically $ writeTVar inst.workflowTime (startWorkflow ^. Activation.startTime . to timespecFromTimestamp)
--   info <- readTVarIO inst.workflowInstanceInfo
--   pure $
--     ExecuteWorkflowInput
--       { executeWorkflowInputType = startWorkflow ^. Activation.workflowType
--       , executeWorkflowInputArgs = fmap convertFromProtoPayload (startWorkflow ^. Command.vec'arguments)
--       , executeWorkflowInputHeaders = fmap convertFromProtoPayload (startWorkflow ^. Activation.headers)
--       , executeWorkflowInputInfo = info
--       }


-- applyStartWorkflow :: ExecuteWorkflowInput -> (Vector Payload -> Workflow Payload) -> Workflow Payload
-- applyStartWorkflow input workflowFn = Workflow do
--   runtime <- ask
--   let inst = runtime.workflowRuntimeInstance
--   ps <- processorDecodePayloads inst.payloadProcessor input.executeWorkflowInputArgs
--   unWorkflow $ workflowFn ps



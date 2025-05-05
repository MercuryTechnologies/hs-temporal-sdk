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
import Temporal.Workflow.Monad
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
    workflowCallStack <- newIORef emptyCallStack
    workflowInstanceInfo <- newTVarIO info
    activationChannel <- newTQueueIO
    let inst = WorkflowInstance {..}
    pure inst

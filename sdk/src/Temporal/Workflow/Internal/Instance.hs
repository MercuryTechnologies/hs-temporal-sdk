{-# LANGUAGE TemplateHaskell #-}

module Temporal.Workflow.Internal.Instance (
  InstanceM,
  runInstanceM,
  WorkflowInstance (..),
  Info (..),
  Sequences (..),
  Sequence (..),
  nextExternalCancelSequence,
  nextChildWorkflowSequence,
  nextExternalSignalSequence,
  nextTimerSequence,
  nextActivitySequence,
) where

import Control.Monad.Logger
import Control.Monad.Reader
import Data.ProtoLens
import qualified Data.Text as T
import GHC.Stack
import Lens.Family2
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import Temporal.Common
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Instance
import Temporal.Workflow.Types
import UnliftIO
import qualified Temporal.Workflow.CommandQueue as CommandQueue

nextExternalCancelSequence :: InstanceM Sequence
nextExternalCancelSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.externalCancel $ \s ->
    (Sequence s, succ s)


nextChildWorkflowSequence :: InstanceM Sequence
nextChildWorkflowSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.childWorkflow $ \s ->
    (Sequence s, succ s)


nextExternalSignalSequence :: InstanceM Sequence
nextExternalSignalSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.externalSignal $ \s ->
    (Sequence s, succ s)


nextTimerSequence :: InstanceM Sequence
nextTimerSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.timer $ \s ->
    (Sequence s, succ s)


nextActivitySequence :: InstanceM Sequence
nextActivitySequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.activity $ \s ->
    (Sequence s, succ s)


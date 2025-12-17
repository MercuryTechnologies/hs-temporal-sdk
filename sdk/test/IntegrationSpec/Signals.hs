{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module IntegrationSpec.Signals where

import Control.Exception
import Control.Monad
import Control.Monad.Logger
import RequireCallStack (provideCallStack)
import Temporal.Duration
import Temporal.Payload
import Temporal.TH
import Temporal.Workflow


unblockWorkflowSignal :: KnownSignal '[]
unblockWorkflowSignal = KnownSignal "unblockWorkflow" JSON


signalWithArgs :: KnownSignal '[Int]
signalWithArgs = KnownSignal "signalWithArgs" JSON


signalUnblocksWorkflow :: Workflow ()
signalUnblocksWorkflow = provideCallStack do
  st <- newStateVar False
  setSignalHandler unblockWorkflowSignal $ do
    $(logDebug) "unblocking workflow"
    writeStateVar st True
  waitCondition (readStateVar st)
  pure ()


registerWorkflow 'signalUnblocksWorkflow


signalWithArgsWorkflow :: Int -> Workflow Int
signalWithArgsWorkflow init = provideCallStack do
  st <- newStateVar init
  setSignalHandler signalWithArgs $ \signaled -> do
    $(logDebug) "updating value and unblocking workflow"
    modifyStateVar st (`div` signaled)
  waitCondition do
    val <- readStateVar st
    pure $ val /= init
  readStateVar st


registerWorkflow 'signalWithArgsWorkflow


-- | Signal for testing buffering behavior
signalBufferingSignal :: KnownSignal '[Int]
signalBufferingSignal = KnownSignal "signalBuffering" JSON


{- | This workflow tests signal buffering behavior.

When used with signalWithStart, the signal arrives in the same activation
as the workflow start. The signal should be buffered until the handler
is registered (which happens when the workflow code executes setSignalHandler).

Without buffering, the signal would be dropped and waitCondition would hang forever.
-}
signalBufferingWorkflow :: Workflow Int
signalBufferingWorkflow = provideCallStack do
  $(logDebug) "Starting signalBufferingWorkflow"
  -- Create state var to track received signals
  signalsReceived <- newStateVar ([] :: [Int])

  -- Register signal handler - this is where buffered signals should be delivered
  $(logDebug) "About to register signal handler"
  setSignalHandler signalBufferingSignal $ \value -> do
    $(logDebug) "Signal handler invoked"
    modifyStateVar signalsReceived (value :)

  $(logDebug) "Signal handler registered, now waiting for condition"
  -- Wait for at least one signal to be received
  -- Without buffering, this will hang forever because the signal was dropped
  waitCondition $ do
    signals <- readStateVar signalsReceived
    pure $ not (null signals)

  $(logDebug) "Condition satisfied, returning"
  -- Return the sum of received signal values
  signals <- readStateVar signalsReceived
  pure $ sum signals


registerWorkflow 'signalBufferingWorkflow


{- | Tests that multiple buffered signals are delivered in FIFO order.

This workflow waits for 2 signals and returns them in the order received.
The test sends signals with values [1, 2] and expects them back in that order,
verifying that buffered signals maintain their arrival order.
-}
signalOrderingWorkflow :: Workflow [Int]
signalOrderingWorkflow = provideCallStack do
  $(logDebug) "Starting signalOrderingWorkflow"
  -- Append to the end to preserve order
  signalsReceived <- newStateVar ([] :: [Int])

  $(logDebug) "About to register signal handler"
  setSignalHandler signalBufferingSignal $ \value -> do
    $(logDebug) "Signal handler invoked"
    -- Append to end to maintain FIFO order
    modifyStateVar signalsReceived (<> [value])

  $(logDebug) "Signal handler registered, waiting for 2 signals"
  -- Wait for at least 2 signals
  waitCondition $ do
    signals <- readStateVar signalsReceived
    pure $ length signals >= 2

  $(logDebug) "Received 2 signals, returning"
  readStateVar signalsReceived


registerWorkflow 'signalOrderingWorkflow

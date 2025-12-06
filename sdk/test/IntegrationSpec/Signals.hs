{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module IntegrationSpec.Signals where

import Control.Monad.Logger (logDebug)
import RequireCallStack (provideCallStack)
import Temporal.Activity (Activity)
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


signalWithActivityA :: Activity () ()
signalWithActivityA = pure ()

registerActivity 'signalWithActivityA

signalWithActivityWorkflow :: Workflow Int
signalWithActivityWorkflow = provideCallStack do
  executeActivity SignalWithActivityA (defaultStartActivityOptions $ StartToClose $ seconds 2)

  var <- newStateVar []
  setSignalHandler signalWithArgs $ \i -> do
    $(logDebug) "updating value and unblocking workflow"
    readStateVar var >>= \s -> writeStateVar var (i : s)

  waitCondition $ (not . null) <$> readStateVar var
  head <$> readStateVar var

registerWorkflow 'signalWithActivityWorkflow

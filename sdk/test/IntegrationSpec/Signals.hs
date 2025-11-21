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
import qualified Data.PQueue.Prio.Min as MinPQueue


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
 
signalEnqueuesItemWorkflow :: Workflow [Int]
signalEnqueuesItemWorkflow = provideCallStack do
  var <- newStateVar MinPQueue.empty
  setSignalHandler signalWithArgs $ \i -> do
    $(logDebug) "updating value and unblocking workflow"
    t <- now
    readStateVar var >>= \s -> writeStateVar var (MinPQueue.insert t i s)

  sleep (seconds 2)

  waitCondition $ (not . MinPQueue.null) <$> readStateVar var
  (map snd . MinPQueue.toList) <$> readStateVar var

registerWorkflow 'signalEnqueuesItemWorkflow

{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module IntegrationSpec.TimeSkipping where

import Control.Exception
import Control.Monad
import Control.Monad.Logger
import qualified Data.Text as T
import RequireCallStack (provideCallStack)
import Temporal.Duration
import Temporal.Payload
import Temporal.TH
import Temporal.Workflow


variableSleepWorkflow :: Int -> Workflow Int
variableSleepWorkflow n = provideCallStack do
  sleep $ seconds $ fromIntegral n
  pure n


registerWorkflow 'variableSleepWorkflow


variableSleepFromChildWorkflow :: Int -> Workflow Int
variableSleepFromChildWorkflow n = provideCallStack do
  void $ executeChildWorkflow VariableSleepWorkflow defaultChildWorkflowOptions n
  pure n


registerWorkflow 'variableSleepFromChildWorkflow

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
  a <- now
  sleep $ seconds $ fromIntegral n
  b <- now
  pure n


registerWorkflow 'variableSleepWorkflow

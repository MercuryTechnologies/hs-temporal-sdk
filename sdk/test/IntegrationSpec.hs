{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant bracket" #-}

module IntegrationSpec where

import Common
import Control.Concurrent
import Control.Exception
import Control.Exception.Annotated
import qualified Control.Exception.Annotated as Annotated
import Control.Monad (replicateM, when)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Aeson (FromJSON, ToJSON, Value, toJSON)
import qualified Data.ByteString as BS
import Data.Either (isLeft, isRight)
import Data.Foldable (traverse_)
import Data.Functor
import Data.IORef
import Data.Int
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromJust, isJust)
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Time (Day (ModifiedJulianDay), diffUTCTime, getCurrentTime)
import Data.Time.Clock (UTCTime)
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import Data.Vector (Vector)
import qualified Data.Vector as V
import DiscoverInstances (discoverInstances)
import GHC.Generics
import GHC.Stack (SrcLoc (..), callStack, fromCallSiteList)
import qualified IntegrationSpec.ActivityLifecycle as ActivityLifecycle
import qualified IntegrationSpec.ClientOperations as ClientOperations
import qualified IntegrationSpec.ErrorHandling as ErrorHandling
import qualified IntegrationSpec.ExceptionConversionTests as ExceptionConversionTests
import IntegrationSpec.HangingWorkflow
import qualified IntegrationSpec.HangingWorkflowTests as HangingWorkflowTests
import IntegrationSpec.NoOpWorkflow
import qualified IntegrationSpec.RegressionTests as RegressionTests
import qualified IntegrationSpec.RetryPolicyTests as RetryPolicyTests
import IntegrationSpec.Signals
import qualified IntegrationSpec.SignalsTests as SignalsTests
import qualified IntegrationSpec.TerminateTests as TerminateTests
import IntegrationSpec.TimeSkipping
import qualified IntegrationSpec.TimeSkippingIntegrationTests as TimeSkippingIntegrationTests
import qualified IntegrationSpec.TimeSkippingWorkflowTests as TimeSkippingWorkflowTests
import IntegrationSpec.TimeoutsInWorkflows
import qualified IntegrationSpec.UpdateInterceptorTests as UpdateInterceptorTests
import IntegrationSpec.Updates
import IntegrationSpec.Utils
import qualified IntegrationSpec.WorkerManagement as WorkerManagement
import qualified IntegrationSpec.WorkflowExecution as WorkflowExecution
import Lens.Family2
import OpenTelemetry.Trace
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Api.History.V1.Message (WorkflowExecutionFailedEventAttributes (..))
import qualified Proto.Temporal.Api.History.V1.Message_Fields as History
import RequireCallStack
import System.Directory
import System.Environment (lookupEnv)
import System.IO
import Temporal.Activity
import Temporal.Bundle
import Temporal.Bundle.TH
import qualified Temporal.Client as C
import qualified Temporal.Client.TestService
import Temporal.Contrib.OpenTelemetry
import Temporal.Core.Client hiding (RpcError)
import Temporal.Duration
import Temporal.EphemeralServer
import qualified Temporal.EphemeralServer as TemporalDevServerConfig (TemporalDevServerConfig (..))
import qualified Temporal.EphemeralServer as TemporalTestServerConfig (TemporalTestServerConfig (..))
import Temporal.Exception
import Temporal.Interceptor
import Temporal.Operator (IndexedValueType (..), SearchAttributes (..), addSearchAttributes, listSearchAttributes)
import Temporal.Payload hiding (around)
import Temporal.SearchAttributes
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Testing.Assertions
import Temporal.Worker
import qualified Temporal.Workflow as W
import Temporal.Workflow.Unsafe (performUnsafeNonDeterministicIO)
import Test.Hspec


-- All test infrastructure moved to IntegrationSpec.Utils
-- (temporalBundle, test types, client setup, etc.)

spec :: Spec
spec = do
  -- Error handling tests moved to IntegrationSpec.ErrorHandling
  ErrorHandling.spec

  aroundAll withServer $ do
    aroundAllWith (flip $ setup mempty) needsClient
    aroundAllWith (flip $ setup mempty) TerminateTests.spec
    UpdateInterceptorTests.spec

  -- Whether time-skipping is enabled is global state in the test server (it's not tracked
  -- per workflow or anything) so we need to use around (rather than aroundAll) to get a
  -- distinct server for each test
  around withTimeSkippingServer $ do
    aroundWith (flip $ setupTimeSkipping mempty) needsTimeSkipping


-- All test infrastructure moved to IntegrationSpec.Utils:
-- - MyWorkflow type alias
-- - defaultCodec
-- - RegressionTask data type
-- - signalUnblockWorkflow
-- - testImpls, testRefs, testDefs, testConf
-- - mkBaseConf

needsClient :: SpecWith TestEnv
needsClient = do
  -- Workflow execution tests moved to IntegrationSpec.WorkflowExecution
  WorkflowExecution.spec

  -- Activity lifecycle tests moved to IntegrationSpec.ActivityLifecycle
  ActivityLifecycle.spec

  -- Signals tests (all pending) moved to IntegrationSpec.SignalsTests
  SignalsTests.spec

  -- Worker management tests moved to IntegrationSpec.WorkerManagement
  WorkerManagement.spec

  -- Client operation tests moved to IntegrationSpec.ClientOperations
  ClientOperations.spec

  -- Regression tests moved to IntegrationSpec.RegressionTests
  RegressionTests.spec

  -- RetryPolicy tests moved to IntegrationSpec.RetryPolicyTests
  RetryPolicyTests.spec

  -- Exception conversion tests moved to IntegrationSpec.ExceptionConversionTests
  ExceptionConversionTests.spec

  -- Hanging Workflow tests moved to IntegrationSpec.HangingWorkflowTests
  HangingWorkflowTests.spec

  -- Time skipping integration test moved to IntegrationSpec.TimeSkippingIntegrationTests
  TimeSkippingIntegrationTests.spec


needsTimeSkipping :: SpecWith TestEnv
needsTimeSkipping = TimeSkippingWorkflowTests.spec

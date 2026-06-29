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

module IntegrationSpec.RetryPolicyTests (spec) where

import Common
import Control.Concurrent
import Control.Exception
import Control.Exception.Annotated
import qualified Control.Exception.Annotated as Annotated
import Control.Monad (replicateM, when)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Aeson (FromJSON, ToJSON, Value (..), toJSON)
import qualified Data.Aeson as Aeson
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
import IntegrationSpec.HangingWorkflow
import IntegrationSpec.NoOpWorkflow
import IntegrationSpec.Signals
import IntegrationSpec.TimeSkipping
import IntegrationSpec.TimeoutsInWorkflows
import IntegrationSpec.Updates
import IntegrationSpec.Utils
import Lens.Family2
import OpenTelemetry.Trace
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Api.History.V1.Message (WorkflowExecutionFailedEventAttributes (..))
import qualified Proto.Temporal.Api.History.V1.Message_Fields as History
import RequireCallStack
import System.Directory
import System.Environment (lookupEnv)
import System.IO
import Temporal.Activity hiding (activityId, retryPolicy, workflowId)
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
import Temporal.Exception hiding (activityId)
import Temporal.Interceptor
import Temporal.Operator (IndexedValueType (..), SearchAttributes (..), addSearchAttributes, listSearchAttributes)
import Temporal.Payload hiding (around)
import Temporal.SearchAttributes
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Testing.Assertions
import Temporal.Worker
import Temporal.Workflow (
  StartActivityOptions (activityId, retryPolicy),
  StartChildWorkflowOptions (workflowId, workflowIdReusePolicy),
 )
import qualified Temporal.Workflow as W
import Temporal.Workflow.Unsafe (performUnsafeNonDeterministicIO)
import Test.Hspec
import TestHelpers (waitForWorkflowStart)


spec :: SpecWith TestEnv
spec = do
  describe "RetryPolicy" $ do
    specify "is used for retryable failures" $ \TestEnv {..} -> do
      let conf = configure () testConf $ do
            baseConf

      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 30
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        useClient (C.execute testRefs.retryableFailureTest "use-for-retryable" opts)
    -- `shouldThrow` (== WorkflowExecutionFailed)

    specify "ignored for non-retryable failures" $ \TestEnv {..} -> do
      let conf = configure () testConf $ do
            baseConf

      withWorker conf $ do
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 30
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                }
        useClient (C.execute testRefs.nonRetryableFailureTest "ignore-non-retryable" opts)
          `shouldThrow` \case
            (WorkflowExecutionFailed _) -> True
            _ -> False

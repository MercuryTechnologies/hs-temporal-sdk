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

module IntegrationSpec.ClientOperations (spec) where

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
  describe "Search Attributes" $ do
    specify "can read search attributes set at start" $ \TestEnv {..} -> do
      let workflow :: W.Workflow (Map SearchAttributeKey SearchAttributeType)
          workflow = do
            i <- W.info
            pure (i.searchAttributes :: Map SearchAttributeKey SearchAttributeType)
          wf = W.provideWorkflow defaultCodec "readWorkflowInfo" workflow
          conf = configure () wf $ do
            baseConf
      withWorker conf $ do
        let initialAttrs =
              Map.fromList
                [ ("attr1", toSearchAttribute True)
                , ("attr2", toSearchAttribute (4 :: Int64))
                ]
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { C.runTimeout = Just $ seconds 30
                      , C.executionTimeout = Nothing
                      , C.taskTimeout = Nothing
                      }
                , C.searchAttributes = initialAttrs
                }
        useClient (C.execute wf.reference "attributesSetAtStart" opts)
          `shouldReturn` initialAttrs
    specify "can upsert search attributes" $ \TestEnv {..} -> do
      let expectedAttrs =
            Map.fromList
              [ ("attr1", toSearchAttribute True)
              , ("attr2", toSearchAttribute (4 :: Int64))
              ]
          workflow :: MyWorkflow (Map SearchAttributeKey SearchAttributeType)
          workflow = do
            W.upsertSearchAttributes expectedAttrs
            i <- W.info
            pure i.searchAttributes
          wf = W.provideWorkflow defaultCodec "upsertWorkflowInfo" workflow
          conf = configure () wf $ do
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
        useClient (C.execute wf.reference "searchAttributesUpsert" opts)
          `shouldReturn` expectedAttrs
  describe "Memo" $ do
    specify "able to read memo set at start" $ \TestEnv {..} -> do
      let workflow :: W.Workflow (Map Text Payload)
          workflow = W.getMemoValues
          wf = W.provideWorkflow JSON "readMemo" workflow
          conf = configure () wf $ do
            baseConf
      withWorker conf $ do
        p1 <- encode JSON ("v1" :: Text)
        p2 <- encode JSON (1 :: Int)
        let opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.memo = Map.fromList [("a", p1), ("b", p2)]
                }
        let expected = Map.fromList [("a", p1), ("b", p2)]
        m <- useClient (C.execute wf.reference "memo-read" opts)
        m `shouldBe` expected
    specify "can upsert memo" $ \TestEnv {..} -> do
      p1 <- encode JSON ("v1" :: Text)
      p2 <- encode JSON (1 :: Int)
      let workflow :: MyWorkflow (Map Text Payload)
          workflow = do
            W.upsertMemo (Map.fromList [("b", toJSON ("two" :: Text)), ("c", toJSON True)])
            i <- W.info
            pure i.rawMemo
          wf = W.provideWorkflow JSON "upsertMemo" workflow
          conf = configure () wf $ do
            baseConf
          opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
              , C.memo = Map.fromList [("a", p1), ("b", p2)]
              }
      withWorker conf $ do
        m <- useClient (C.execute wf.reference "memo-upsert" opts)
        let expectedB = encodeJSON (toJSON ("two" :: Text))
            expectedC = encodeJSON (toJSON True)
            expected =
              Map.fromList
                [ ("a", p1)
                , ("b", expectedB)
                , ("c", expectedC)
                ]
        m `shouldBe` expected
    specify "multiple upserts work" $ \TestEnv {..} -> do
      let workflow :: MyWorkflow (Map Text Payload)
          workflow = do
            W.upsertMemo (Map.fromList [("a", toJSON ("v1" :: Text))])
            W.upsertMemo (Map.fromList [("b", toJSON ("v2" :: Text))])
            W.upsertMemo (Map.fromList [("a", toJSON ("v3" :: Text))])
            i <- W.info
            pure i.rawMemo
          wf = W.provideWorkflow JSON "memo-upsert-many" workflow
          conf = configure () wf $ do baseConf
      withWorker conf $ do
        let expectedA = encodeJSON (toJSON ("v3" :: Text))
            expectedB = encodeJSON (toJSON ("v2" :: Text))
            expected = Map.fromList [("a", expectedA), ("b", expectedB)]
            opts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                }
        m <- useClient (C.execute wf.reference "memo-upsert-many" opts)
        m `shouldBe` expected

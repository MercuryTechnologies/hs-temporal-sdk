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

module IntegrationSpec.ClientOperations where

import Data.Aeson (toJSON)
import Data.Int (Int64)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import IntegrationSpec.Utils
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec


-- | Client operation tests (search attributes, memo, queries, signals, updates)
spec :: SpecWith TestEnv
spec = do
  -- Note, needs the temporal operator to have mapped these attributes up-front:
  -- >  temporal operator search-attribute create --name attr1 --type Bool --namespace test
  -- > temporal operator search-attribute create --name attr2 --type Int --namespace test
  --
  -- Until we have a way to do this in the SDK, we can't test this without manual intervention.
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
                      { C.runTimeout = Just $ seconds 4
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
                      { C.runTimeout = Just $ seconds 4
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

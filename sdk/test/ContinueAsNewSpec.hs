module ContinueAsNewSpec where

import Data.Int (Int64)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.Worker
import Temporal.Workflow (ContinueAsNewOptions (memo))
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


tests :: SpecWith TestEnv
tests = describe "ContinueAsNew" $ do
  specify "basic continue-as-new works" $ \TestEnv {..} -> do
    let countDown :: Int -> W.Workflow Text
        countDown n
          | n <= 0 = pure "done"
          | otherwise = W.continueAsNew wf.reference W.defaultContinueAsNewOptions (n - 1)
        wf = W.provideWorkflow defaultCodec "countDown" countDown
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute wf.reference "basic-can" opts 5)
        `shouldReturn` "done"

  specify "continue-as-new to same workflow" $ \TestEnv {..} -> do
    let countDown :: Int -> W.Workflow Text
        countDown n
          | n <= 0 = pure "done"
          | otherwise = W.continueAsNew wf.reference W.defaultContinueAsNewOptions (n - 1)
        wf = W.provideWorkflow defaultCodec "countDownSelf" countDown
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute wf.reference "can-same-wf" opts 3)
        `shouldReturn` "done"

  specify "continue-as-new preserves workflow ID" $ \TestEnv {..} -> do
    let wfId = W.WorkflowId "can-preserve-workflow-id"
        countDown :: Int -> W.Workflow W.WorkflowId
        countDown n
          | n <= 0 = do
              i <- W.info
              pure i.workflowId
          | otherwise = W.continueAsNew wf.reference W.defaultContinueAsNewOptions (n - 1)
        wf = W.provideWorkflow defaultCodec "countDownPreserveId" countDown
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      result <- useClient (C.execute wf.reference wfId opts 1)
      result `shouldBe` wfId

  specify "continue-as-new with different args" $ \TestEnv {..} -> do
    let countDown :: Int -> W.Workflow Int
        countDown n
          | n <= 0 = pure n
          | otherwise = W.continueAsNew wf.reference W.defaultContinueAsNewOptions (n - 1)
        wf = W.provideWorkflow defaultCodec "countDownArgs" countDown
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute wf.reference "can-different-args" opts 4)
        `shouldReturn` 0

  specify "continue-as-new with search attributes" $ \TestEnv {..} -> do
    let initialAttrs =
          Map.fromList
            [ ("attr1", toSearchAttribute True)
            , ("attr2", toSearchAttribute (42 :: Int64))
            ]
        countDown :: Int -> W.Workflow (Map SearchAttributeKey SearchAttributeType)
        countDown n
          | n <= 0 = do
              i <- W.info
              pure i.searchAttributes
          | otherwise = W.continueAsNew wf.reference W.defaultContinueAsNewOptions (n - 1)
        wf = W.provideWorkflow defaultCodec "countDownSearchAttrs" countDown
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let opts =
            (defaultStartOptsWithTimeout taskQueue (seconds 10))
              { C.searchAttributes = initialAttrs
              }
      useClient (C.execute wf.reference "can-search-attrs" opts 2)
        `shouldReturn` initialAttrs

  specify "continue-as-new to different workflow (TS: continue-as-new-to-different-workflow)" $ \TestEnv {..} -> do
    let finalWf :: W.Workflow Text
        finalWf = pure "from-final"
        final = W.provideWorkflow defaultCodec "canFinal" finalWf
        startWf :: W.Workflow Text
        startWf = W.continueAsNew final.reference W.defaultContinueAsNewOptions
        start = W.provideWorkflow defaultCodec "canStart" startWf
        conf = configure () (start, final) $ do baseConf

    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient (C.execute start.reference "can-diff-wf" opts)
        `shouldReturn` "from-final"

  specify "client follows continue-as-new chain" $ \TestEnv {..} -> do
    let countDown :: Int -> W.Workflow Int
        countDown n
          | n <= 0 = pure 0
          | otherwise = W.continueAsNew wf.reference W.defaultContinueAsNewOptions (n - 1)
        wf = W.provideWorkflow defaultCodec "countDownChain" countDown
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      -- Chain of 10 continue-as-new calls; client should get final result
      useClient (C.execute wf.reference "can-chain" opts 10)
        `shouldReturn` 0

  specify "continue-as-new keeps memo (TS: same-workflow keeps memo and search attributes)" $ \TestEnv {..} -> do
    let workflow :: Int -> W.Workflow (Map Text Payload)
        workflow n
          | n <= 0 = W.getMemoValues
          | otherwise = W.continueAsNew wf.reference W.defaultContinueAsNewOptions (n - 1)
        wf = W.provideWorkflow defaultCodec "canKeepsMemo" workflow
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let memoVal = encodeJSON ("remember-me" :: Text)
          opts =
            (defaultStartOptsWithTimeout taskQueue (seconds 10))
              { C.memo = Map.fromList [("key1", memoVal)]
              }
      result <- useClient (C.execute wf.reference "can-keeps-memo" opts 2)
      Map.member "key1" result `shouldBe` True

  specify "continue-as-new can set memo (TS: CaN can set memo)" $ \TestEnv {..} -> do
    let workflow :: Int -> W.Workflow (Map Text Payload)
        workflow n
          | n <= 0 = W.getMemoValues
          | otherwise = do
              let newMemo = Map.fromList [("newkey", encodeJSON ("newval" :: Text))]
                  canOpts = W.defaultContinueAsNewOptions {memo = newMemo}
              W.continueAsNew wf.reference canOpts (n - 1)
        wf = W.provideWorkflow defaultCodec "canSetMemo" workflow
        conf = configure () wf $ do baseConf

    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      result <- useClient (C.execute wf.reference "can-set-memo" opts 1)
      Map.member "newkey" result `shouldBe` True

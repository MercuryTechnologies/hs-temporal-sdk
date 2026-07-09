{-# OPTIONS_GHC -O0 #-}

module BoundedConcurrencySpec (spec) where

import Control.Monad.Catch (MonadCatch, try)
import Data.Bifunctor (first)
import GHC.TypeLits (natVal)
import Hedgehog
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
import RequireCallStack (provideCallStack)
import Temporal.Activity (Activity, ProvidedActivity, provideActivity)
import qualified Temporal.Client as C
import Temporal.Contrib.BoundedConcurrency
import Temporal.Duration (minutes, seconds)
import Temporal.Exception (ActivityFailure)
import Temporal.Worker (configure)
import qualified Temporal.Workflow as W
import Test.Hspec
import Test.Hspec.Hedgehog
import TestHelpers

-- | A trivial activity used by the workflow-driven tests below: it just echoes
-- back the integer it is given. This is enough to exercise the bounded
-- concurrency / continue-as-new machinery against a real Temporal server.
echoInt :: Int -> Activity () Int
echoInt = pure

echoIntDef :: ProvidedActivity () (Int -> Activity () Int)
echoIntDef = provideActivity defaultCodec "echoInt" echoInt

activityOptions :: W.StartActivityOptions
activityOptions = W.defaultStartActivityOptions (W.StartToClose (minutes 1))

-- | Start / run the @echoInt@ activity for a single integer.
startEchoInt :: W.RequireCallStack => Int -> W.Workflow (W.Task Int)
startEchoInt = W.startActivity echoIntDef activityOptions

executeEchoInt :: W.RequireCallStack => Int -> W.Workflow Int
executeEchoInt = W.executeActivity echoIntDef activityOptions

spec :: Spec
spec = do
  describe "Bounded concurrency utils" $ do
    describe "withDynamicConcurrency" $ do
      it "clamps a dynamic value into [0, 2000]" $ hedgehog $ do
        i <- forAll $ Gen.integral (Range.linearFrom 0 (-9000) 9000)
        withDynamicConcurrency i natVal === max 0 (min 2000 i)
      it "rejects out of bounds (lower)" $
        withDynamicConcurrency @Int (-1) natVal `shouldBe` 0
      it "rejects out of bounds (upper)" $
        withDynamicConcurrency @Int 9000 natVal `shouldBe` 2000

    withTestServer_ workflowTests

workflowTests :: SpecWith TestEnv
workflowTests = do
  describe "safelyRecursive" $ do
    specify "works in a simple example" $ \TestEnv {..} -> do
      let wf :: W.ProvidedWorkflow (Int -> Int -> W.Workflow Int)
          wf =
            W.provideWorkflow defaultCodec "sumSafelyRecursive" $
              provideCallStack $
                safelyRecursive wf.reference W.defaultContinueAsNewOptions \go i acc ->
                  case i == 0 of
                    True -> pure acc
                    False -> do
                      _ <- executeEchoInt i
                      let !i' = i - 1
                          !acc' = acc + i
                      go i' acc'
          conf = configure () (wf, echoIntDef) $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
        useClient (C.execute wf.reference "safelyRecursive" opts 10 0)
          `shouldReturn` 55

  describe "unfoldConcurrentlyBounded" $ do
    specify "works in a simple example" $ \TestEnv {..} -> do
      let wf :: W.ProvidedWorkflow (Int -> W.Workflow (ActionResult Int [Int]))
          wf =
            W.provideWorkflow defaultCodec "countConcurrentlyBounded" $ \upperBound ->
              provideCallStack $
                let unfold :: Int -> W.Workflow (Maybe (W.Task Int, Int))
                    unfold i = case i > upperBound of
                      True -> pure Nothing
                      False -> provideCallStack do
                        task <- startEchoInt i
                        pure (Just (task, i + 1))
                 in unfoldConcurrentlyBounded @100 unfold 1
          conf = configure () (wf, echoIntDef) $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
        result <- useClient (C.execute wf.reference "unfoldConcurrentlyBounded" opts 10)
        result `shouldBe` ActionResult'Done [1 .. 10]

    specify "returns HistoryExhausted when appropriate" $ \TestEnv {..} -> do
      let wf :: W.ProvidedWorkflow (Int -> W.Workflow (ActionResult Int [Int]))
          wf =
            W.provideWorkflow defaultCodec "countConcurrentlyBoundedCAN" $ \upperBound ->
              provideCallStack $
                let unfold :: Int -> W.Workflow (Maybe (W.Task Int, Int))
                    unfold i = case i > upperBound of
                      True -> pure Nothing
                      False -> provideCallStack do
                        task <- startEchoInt i
                        pure (Just (task, i + 1))
                 in unfoldConcurrentlyBounded @100 unfold 1
          conf = configure () (wf, echoIntDef) $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOptsWithTimeout taskQueue (minutes 5)
        result <- useClient (C.execute wf.reference "unfoldConcurrentlyBoundedCAN" opts 1500)
        case result of
          ActionResult'HistoryExhausted _ _ -> pure ()
          _ -> expectationFailure "Expected history exhaustion"

  describe "handleActionResult" $ do
    specify "continues as new when appropriate, and carries state forward" $ \TestEnv {..} -> do
      let selfApply :: forall r. (Int -> Int -> Int -> r) -> (Int, Int) -> Int -> r
          selfApply go (i, ub) sumSoFar = go i ub sumSoFar

          mySum :: Int -> Either (W.Task Int, ActivityFailure) Int -> W.Workflow Int
          mySum b = \case
            Left (_theInput, _theException) -> pure b -- ignore failures in this example
            Right a -> pure $ a + b

          wf :: W.ProvidedWorkflow (Int -> Int -> Int -> W.Workflow Int)
          wf =
            W.provideWorkflow defaultCodec "sumConcurrentlyBoundedCan" $
              provideCallStack $
                handleActionResult
                  wf.reference
                  W.defaultContinueAsNewOptions
                  selfApply
                  \lowerBound upperBound sumSoFar ->
                    let unfold :: (Int, Int) -> W.Workflow (Maybe (W.Task Int, (Int, Int)))
                        unfold (i, _ub) = case i > upperBound of
                          True -> pure Nothing
                          False -> provideCallStack do
                            task <- startEchoInt i
                            pure (Just (task, (i + 1, upperBound)))
                     in unfoldWaitableFoldResultConcurrentlyBounded @100
                          unfold
                          (lowerBound, upperBound)
                          mySum
                          sumSoFar
                          -- catch any activity failures and pair them with their input
                          (\waitA a -> first ((,) a) <$> try @_ @ActivityFailure (waitA a))
          conf = configure () (wf, echoIntDef) $ do baseConf
      withWorker conf $ do
        let opts = defaultStartOptsWithTimeout taskQueue (minutes 5)
        useClient (C.execute wf.reference "handleActionResult" opts 1 1500 0)
          `shouldReturn` 1_125_750

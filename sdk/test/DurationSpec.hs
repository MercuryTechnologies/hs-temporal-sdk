module DurationSpec where

import Data.Aeson (FromJSON, ToJSON, Value, eitherDecode, encode)
import Data.Either (isLeft)
import Hedgehog
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
import Temporal.Duration
import Test.Hspec
import Test.Hspec.Hedgehog


genDuration :: Gen Duration
genDuration =
  mkDuration
    <$> Gen.integral (Range.linear minBound maxBound)
    <*> Gen.integral (Range.linear minBound maxBound)


bothSignsMatchAssertion :: (MonadTest m, HasCallStack) => Duration -> m ()
bothSignsMatchAssertion d =
  assert
    ( (durationSeconds d >= 0 && durationNanoseconds d >= 0)
        || (durationSeconds d <= 0 && durationNanoseconds d <= 0)
    )


{-# ANN spec "HLint: ignore Monoid law, right identity" #-}
{-# ANN spec "HLint: ignore Monoid law, left identity" #-}
{-# ANN spec "HLint: ignore Use fold" #-}
spec :: Spec
spec = describe "Duration" $ do
  describe "parsing" $ do
    it "should parse a duration" $ do
      let d = "\"1.000000001s\""
      Data.Aeson.eitherDecode d `shouldBe` Right (mkDuration 1 1)
    it "should parse a duration from a data type" $ do
      let d = Data.Aeson.encode $ mkDuration 2 4
      Data.Aeson.eitherDecode d `shouldBe` Right (mkDuration 2 4)
  describe "math" $ do
    it "nanosecond overflow" $ do
      let d1 = mkDuration 1 0
      let d2 = mkDuration 0 2_000_000_000
      addDurations d1 d2 `shouldBe` mkDuration 3 0
    it "negative nanosecond added to positive seconds" $ do
      let d1 = mkDuration 1 0
      let d2 = mkDuration 0 (-1_000_000_000)
      addDurations d1 d2 `shouldBe` mkDuration 0 0
    it "negative nanoseconds and negative seconds" $ do
      let d1 = mkDuration (-1) 0
      let d2 = mkDuration (-1) (-1_000_000_000)
      addDurations d1 d2 `shouldBe` mkDuration (-3) 0
    it "negative seconds and positive nanoseconds" $ do
      let d1 = mkDuration (-1) 0
      let d2 = mkDuration 0 1_000_000_000
      addDurations d1 d2 `shouldBe` mkDuration 0 0
    it "negative seconds exceed positive nanoseconds" $ do
      let d1 = mkDuration (-2) 0
      let d2 = mkDuration 0 1_000_000_000
      addDurations d1 d2 `shouldBe` mkDuration (-1) 0
    it "negative nanoseconds exceed positive seconds" $ do
      let d1 = mkDuration 1 0
      let d2 = mkDuration 0 (-2_100_000_000)
      addDurations d1 d2 `shouldBe` mkDuration (-1) (-100_000_000)
  describe "Semigroup" $ do
    specify "associativity" $ hedgehog $ do
      ds <- forAll $ (,,) <$> genDuration <*> genDuration <*> genDuration
      (ds <> (ds <> ds)) === ((ds <> ds) <> ds)
  describe "Monoid" $ do
    specify "right identity" $ hedgehog $ do
      d <- forAll genDuration
      (d <> mempty) === d
    specify "left identity" $ hedgehog $ do
      d <- forAll genDuration
      (mempty <> d) === d
    specify "concatenation" $ hedgehog $ do
      ds <- forAll $ Gen.list (Range.linear 0 100) genDuration
      foldr (<>) mempty ds === mconcat ds

  describe "addDurations" $ do
    it "ensures signs match" $ hedgehog $ do
      (l, r) <- forAll $ (,) <$> genDuration <*> genDuration
      bothSignsMatchAssertion $ addDurations l r

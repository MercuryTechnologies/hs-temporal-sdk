module DurationSpec where

import Data.Aeson (FromJSON, ToJSON, Value, eitherDecode, encode)
import Data.Either (isLeft)
import Data.Time.Clock.System
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


{- | Generate a duration that won't cause overflow when added to a SystemTime
and ensures that seconds and nanoseconds have matching signs.
-}
genSafeDuration :: Gen Duration
genSafeDuration = do
  secs <- Gen.integral (Range.linear (-1000) 1000)
  if secs == 0
    then do
      -- For zero seconds, allow any nanosecond value
      ns <- Gen.integral (Range.linear (-999_999_999) 999_999_999)
      pure $ mkDuration secs ns
    else do
      -- For non-zero seconds, ensure nanoseconds match the sign
      ns <- Gen.integral (Range.linear 0 999_999_999)
      pure $ mkDuration secs (if secs < 0 then -ns else ns)


-- | Generate a positive duration that won't cause overflow when added to a SystemTime
genPositiveSafeDuration :: Gen Duration
genPositiveSafeDuration = do
  secs <- Gen.integral (Range.linear 0 1000)
  ns <- Gen.integral (Range.linear 0 999_999_999)
  pure $ mkDuration secs ns


bothSignsMatchAssertion :: (MonadTest m, HasCallStack) => Duration -> m ()
bothSignsMatchAssertion d =
  assert
    ( (durationSeconds d >= 0 && durationNanoseconds d >= 0)
        || (durationSeconds d <= 0 && durationNanoseconds d <= 0)
    )


{-# ANN spec ("HLint: ignore Monoid law, right identity" :: String) #-}
{-# ANN spec ("HLint: ignore Monoid law, left identity" :: String) #-}
{-# ANN spec ("HLint: ignore Use fold" :: String) #-}
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

  describe "addDurationToSystemTime" $ do
    it "handles nanosecond overflow" $ do
      let duration = mkDuration 1 1_000_000_000
      let time = MkSystemTime 0 0
      addDurationToSystemTime duration time `shouldBe` MkSystemTime 2 0
    it "handles negative nanoseconds" $ do
      let duration = mkDuration 1 (-500_000_000)
      let time = MkSystemTime 0 600_000_000
      addDurationToSystemTime duration time `shouldBe` MkSystemTime 1 100_000_000
    it "handles max nanoseconds" $ do
      let duration = mkDuration 0 1
      let time = MkSystemTime 0 999_999_999
      addDurationToSystemTime duration time `shouldBe` MkSystemTime 1 0
    it "handles negative duration" $ do
      let duration = mkDuration (-1) (-500_000_000)
      let time = MkSystemTime 2 600_000_000
      addDurationToSystemTime duration time `shouldBe` MkSystemTime 1 100_000_000
    it "handles zero duration" $ do
      let duration = mkDuration 0 0
      let time = MkSystemTime 1 500_000_000
      addDurationToSystemTime duration time `shouldBe` time
    it "handles large positive duration" $ do
      let duration = mkDuration 1000 0
      let time = MkSystemTime 0 0
      addDurationToSystemTime duration time `shouldBe` MkSystemTime 1000 0
    it "handles large negative duration" $ do
      let duration = mkDuration (-1000) 0
      let time = MkSystemTime 1000 0
      addDurationToSystemTime duration time `shouldBe` MkSystemTime 0 0

    it "preserves SystemTime invariants" $ hedgehog $ do
      duration <- forAll genPositiveSafeDuration
      time <-
        forAll $
          MkSystemTime
            <$> Gen.integral (Range.linear 0 1000) -- Keep times positive for this test
            <*> Gen.word32 (Range.linear 0 999_999_999)
      let result = addDurationToSystemTime duration time
      assert $ systemNanoseconds result < 1_000_000_000
      assert $ systemSeconds result >= 0

    it "roundtrips with diffSystemTime" $ hedgehog $ do
      duration <- forAll genPositiveSafeDuration
      time <-
        forAll $
          MkSystemTime
            <$> Gen.integral (Range.linear 0 1000) -- Keep times positive for this test
            <*> Gen.word32 (Range.linear 0 999_999_999)
      let newTime = addDurationToSystemTime duration time
      let diff = diffSystemTime time newTime
      diff === duration

  describe "diffSystemTime" $ do
    it "calculates positive difference" $ do
      let t1 = MkSystemTime 0 0
      let t2 = MkSystemTime 1 500_000_000
      diffSystemTime t1 t2 `shouldBe` mkDuration 1 500_000_000
    it "calculates negative difference" $ do
      let t1 = MkSystemTime 1 500_000_000
      let t2 = MkSystemTime 0 0
      diffSystemTime t1 t2 `shouldBe` mkDuration (-1) (-500_000_000)
    it "handles nanosecond overflow" $ do
      let t1 = MkSystemTime 0 800_000_000
      let t2 = MkSystemTime 1 200_000_000
      diffSystemTime t1 t2 `shouldBe` mkDuration 0 400_000_000
    it "handles max nanoseconds" $ do
      let t1 = MkSystemTime 0 0
      let t2 = MkSystemTime 0 999_999_999
      diffSystemTime t1 t2 `shouldBe` mkDuration 0 999_999_999
    it "handles zero difference" $ do
      let t = MkSystemTime 1 500_000_000
      diffSystemTime t t `shouldBe` mkDuration 0 0
    it "handles large time difference" $ do
      let t1 = MkSystemTime 0 0
      let t2 = MkSystemTime 1000 0
      diffSystemTime t1 t2 `shouldBe` mkDuration 1000 0
    it "roundtrips with addDurationToSystemTime" $ do
      let duration = mkDuration 1 500_000_000
      let time = MkSystemTime 0 0
      let newTime = addDurationToSystemTime duration time
      diffSystemTime time newTime `shouldBe` duration

    it "is antisymmetric" $ hedgehog $ do
      t1 <-
        forAll $
          MkSystemTime
            <$> Gen.integral (Range.linear 0 1000)
            <*> Gen.word32 (Range.linear 0 999_999_999)
      t2 <-
        forAll $
          MkSystemTime
            <$> Gen.integral (Range.linear 0 1000)
            <*> Gen.word32 (Range.linear 0 999_999_999)
      let d1 = diffSystemTime t1 t2
      let d2 = diffSystemTime t2 t1
      d1 === mkDuration (-durationSeconds d2) (-durationNanoseconds d2)

    it "obeys triangle inequality" $ hedgehog $ do
      t1 <-
        forAll $
          MkSystemTime
            <$> Gen.integral (Range.linear 0 1000)
            <*> Gen.word32 (Range.linear 0 999_999_999)
      t2 <-
        forAll $
          MkSystemTime
            <$> Gen.integral (Range.linear 0 1000)
            <*> Gen.word32 (Range.linear 0 999_999_999)
      t3 <-
        forAll $
          MkSystemTime
            <$> Gen.integral (Range.linear 0 1000)
            <*> Gen.word32 (Range.linear 0 999_999_999)
      let d1 = diffSystemTime t1 t2
      let d2 = diffSystemTime t2 t3
      let d3 = diffSystemTime t1 t3
      let sum = addDurations d1 d2
      sum === d3

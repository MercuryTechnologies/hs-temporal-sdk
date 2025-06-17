module MockActivityEnvironmentSpec where

import Control.Monad.Reader (ask)
import Data.Text (Text)
import Temporal.Activity (Activity, ActivityInfo (..), askActivityInfo, withHeartbeat)
import Temporal.Payload (JSON (..))
import Temporal.Testing.MockActivityEnvironment (MockActivityEnvironment (..), mkMockActivityEnvironment, runMockActivity)
import Test.Hspec


spec :: Spec
spec = do
  describe "MockActivityEnvironment" do
    it "runs a simple activity" do
      let act :: Int -> Activity () Int
          act i = pure $ i + 1
          n = 0
      mock <- mkMockActivityEnvironment ()
      result <- runMockActivity mock (act n)
      result `shouldBe` (n + 1)

    -- we don't check all the fields here, just a few that should be
    -- initialized to reasonable defaults for testing
    it "can retrieve mocked activity info" do
      mock <- mkMockActivityEnvironment ()
      actInfo <- runMockActivity mock askActivityInfo
      actInfo.activityId `shouldBe` "test"
      actInfo.attempt `shouldBe` 0
      actInfo.workflowNamespace `shouldBe` "default"

    it "runs an activity with a custom environment" do
      let act :: Activity Int Int
          act = ask
          expected = 1
      mock <- mkMockActivityEnvironment expected
      result <- runMockActivity mock act
      result `shouldBe` expected

    it "runs an activity with heartbeating" do
      let msg = "tear up the planks! here, here! it is the beating of this hideous heart!"
          act :: Activity () Text
          act = withHeartbeat JSON \beat readHeartbeat ->
            readHeartbeat >>= \case
              Nothing -> beat msg *> act
              Just m -> pure m

      mock <- mkMockActivityEnvironment ()
      result <- runMockActivity mock act
      result `shouldBe` msg

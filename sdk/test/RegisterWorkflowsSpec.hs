{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE TemplateHaskell #-}

module RegisterWorkflowsSpec where

import Control.Monad (void)
import Data.Text qualified as Text
import Language.Haskell.TH (newDeclarationGroup)
import RequireCallStack (provideCallStack)
import Temporal.Activity
import Temporal.Duration (seconds)
import Temporal.TH
import Temporal.Workflow
import Test.Hspec


-- Register all functions at once using the simple register function
$( register
    [d|
      simpleWorkflow :: Int -> Workflow Bool
      simpleWorkflow x = pure (x == 0)


      stringWorkflow :: String -> Int -> Workflow String
      stringWorkflow s n = pure $ s ++ show n


      voidWorkflow :: Workflow ()
      voidWorkflow = provideCallStack $ do
        void $ executeChildWorkflow SimpleWorkflow defaultChildWorkflowOptions 42
        continueAsNew VoidWorkflow defaultContinueAsNewOptions


      simpleActivity :: Activity () Bool
      simpleActivity = pure True


      greetingActivity :: String -> Activity () String
      greetingActivity s = pure $ "Hello " ++ s


      customWorkflow :: Double -> Workflow Double
      customWorkflow x = pure (x * 2.0)


      customActivity :: Int -> Activity () Int
      customActivity n = pure (n + 1)
      |]
 )


-- Register with dynamic configuration functions
$( registerWithConfig
    ( RegistrationConfig
        -- Workflow config function: add "wf-" prefix to names
        (\name _ -> defaultWorkflowConfig {workflowConfigNameOverride = Just $ "wf-" <> Text.pack (show name)})
        -- Activity config function: add "act-" prefix to names
        (\name _ -> defaultActivityConfig {activityConfigNameOverride = Just $ "act-" <> Text.pack (show name)})
    )
    [d|
      dynamicWorkflow :: Bool -> Workflow Int
      dynamicWorkflow b = pure $ if b then 1 else 0


      dynamicActivity :: String -> Activity () String
      dynamicActivity s = pure $ "Dynamic: " ++ s
      |]
 )


-- Use newDeclarationGroup to separate Template Haskell splices
$(newDeclarationGroup)


-- Test that we can reference the registered workflows
testWorkflowReferences :: Workflow ()
testWorkflowReferences = provideCallStack do
  _ <- startChildWorkflow SimpleWorkflow defaultChildWorkflowOptions 42
  _ <- startChildWorkflow StringWorkflow defaultChildWorkflowOptions "test" 123
  _ <- startChildWorkflow VoidWorkflow defaultChildWorkflowOptions
  _ <- startChildWorkflow CustomWorkflow defaultChildWorkflowOptions 3.14
  _ <- startChildWorkflow DynamicWorkflow defaultChildWorkflowOptions True
  pure ()


-- Test that we can reference the registered activities
testActivityReferences :: Workflow ()
testActivityReferences = provideCallStack do
  _ <- executeActivity SimpleActivity (defaultStartActivityOptions $ StartToClose $ seconds 1)
  _ <- executeActivity GreetingActivity (defaultStartActivityOptions $ StartToClose $ seconds 1) "world"
  _ <- executeActivity CustomActivity (defaultStartActivityOptions $ StartToClose $ seconds 1) 42
  _ <- executeActivity DynamicActivity (defaultStartActivityOptions $ StartToClose $ seconds 1) "test"
  pure ()


spec :: Spec
spec = do
  describe "fnName" do
    it "works the same as registerWorkflow does for names" do
      fnName SimpleWorkflow `shouldBe` "RegisterWorkflowsSpec.simpleWorkflow"
      fnName SimpleActivity `shouldBe` "RegisterWorkflowsSpec.simpleActivity"

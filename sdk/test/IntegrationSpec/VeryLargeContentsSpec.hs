{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE TemplateHaskell #-}
module IntegrationSpec.VeryLargeContentsSpec where

import Control.Exception (SomeException (..), try)
import Control.Monad
import Data.Aeson
import qualified Data.Text as T
import Data.UUID (UUID)
import qualified Data.UUID.V4 as UUID
import DiscoverInstances (discoverInstances)
import IntegrationSpec.Helpers
import RequireCallStack
import System.Random.Stateful
import Temporal.Activity
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.TH
import Temporal.Worker
import Temporal.Workflow
import Test.Hspec


{-
   Temporal has limits of 2MB for a single payload, and 4MB for a single
   gRPC request. At the time of writing, the Haskell SDK falls into a black
   hole as soon as one of these limits is exceeded. The tests here are
   exercising that the SDK actually surfaces errors in a fashion that is
   comprehensible to the user.
-}

-- ~2.5 MB
largePayload :: T.Text
largePayload = T.replicate 2_500_000 "a"


{- | We don't produce the input here, so we just have to prove that we can receive it or
reject it gracefully
-}
largeInputWorkflow :: T.Text -> Workflow ()
largeInputWorkflow _ = pure ()


registerWorkflow 'largeInputWorkflow


largeOutputWorkflow :: Workflow T.Text
largeOutputWorkflow = pure largePayload


registerWorkflow 'largeOutputWorkflow


largeOutputActivity :: Activity () T.Text
largeOutputActivity = do
  pure largePayload


registerActivity 'largeOutputActivity


largeInputActivity :: T.Text -> Activity () ()
largeInputActivity _ = pure ()


registerActivity 'largeInputActivity


bringRegisteredTemporalFunctionsIntoScope


largeInputInvokingWorkflow :: Workflow ()
largeInputInvokingWorkflow = provideCallStack do
  let options = defaultStartActivityOptions $ StartToClose $ seconds 10
  _ <- executeActivity LargeInputActivity options largePayload
  pure ()


registerWorkflow 'largeInputInvokingWorkflow


largeOutputInvokingWorkflow :: Workflow ()
largeOutputInvokingWorkflow = provideCallStack do
  let options = defaultStartActivityOptions $ StartToClose $ seconds 10
  _ <- executeActivity LargeOutputActivity options
  pure ()


registerWorkflow 'largeOutputInvokingWorkflow


requestBodySizeExceedsLimitWorkflow :: Workflow ()
requestBodySizeExceedsLimitWorkflow = provideCallStack do
  let biggishChunk = T.replicate 1_000_000 "a"
      options = defaultStartActivityOptions $ StartToClose $ seconds 10
  hs <- replicateM 5 $ startActivity LargeInputActivity options biggishChunk
  mapM_ wait hs
  pure ()


registerWorkflow 'requestBodySizeExceedsLimitWorkflow


bringRegisteredTemporalFunctionsIntoScope


spec :: Spec
spec = aroundAll withServer $ aroundAllWith (flip $ setup mempty) do
  let instances = provideCallStack $ discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)
  fdescribe "Very large payloads" do
    it "should return reasonable workflow failures on overly large inputs" $ \TestEnv {..} -> do
      uuid <- WorkflowId <$> uuidText
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just C.WorkflowIdReusePolicyTerminateIfRunning
              }
          wf = useClient $ C.execute LargeInputWorkflow uuid opts largePayload
      x <- try wf
      case x of
        Left (SomeException e) -> do
          print e
          pure ()
        Right _ -> error "Succeeded when we expected an error"
    it "should return reasonable workflow failures on overly large outputs" $ \TestEnv {..} -> do
      uuid <- WorkflowId <$> uuidText
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just C.WorkflowIdReusePolicyTerminateIfRunning
              }
          wf = useClient $ C.execute LargeOutputWorkflow uuid opts
          conf = configure () instances $ do
            baseConf
      withWorker conf $ do
        wf `shouldThrow` \case
          (SomeException _) -> True

    it "should return reasonable activity failures on overly large inputs" $ \TestEnv {..} -> do
      uuid <- WorkflowId <$> uuidText
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just C.WorkflowIdReusePolicyTerminateIfRunning
              }
          wf = useClient $ C.execute LargeInputInvokingWorkflow uuid opts
          conf = configure () instances $ do
            baseConf
      withWorker conf $ do
        x <- try wf
        case x of
          Left (SomeException e) -> do
            print e
            pure ()
          Right _ -> error "Succeeded when we expected an error"
    it "should return reasonable activity failures on overly large outputs" $ \TestEnv {..} -> do
      uuid <- WorkflowId <$> uuidText
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just C.WorkflowIdReusePolicyTerminateIfRunning
              }
          wf = useClient $ C.execute LargeOutputInvokingWorkflow uuid opts
          conf = configure () instances $ do
            baseConf
      withWorker conf $ do
        x <- try wf
        case x of
          Left (SomeException e) -> do
            print e
            pure ()
          Right _ -> error "Succeeded when we expected an error"
    fit "should handle the situation where no one payload is too large, but collectively they are" $ \TestEnv {..} -> do
      uuid <- WorkflowId <$> uuidText
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just C.WorkflowIdReusePolicyTerminateIfRunning
              }
          wf = useClient $ C.execute RequestBodySizeExceedsLimitWorkflow uuid opts
          conf = configure () instances $ do
            baseConf
      withWorker conf $ do
        x <- try wf
        case x of
          Left (SomeException e) -> do
            print e
            pure ()
          Right _ -> error "Succeeded when we expected an error"

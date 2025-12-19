{-# LANGUAGE DuplicateRecordFields #-}

module IntegrationSpec.ExceptionConversionTests (spec) where

import qualified Control.Exception.Annotated as Annotated
import IntegrationSpec.Utils
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Exception (WorkflowExecutionClosed (..))
import qualified Temporal.Workflow as W
import Test.Hspec


-- | Exception conversion integration tests
spec :: SpecWith TestEnv
spec = describe "Exception conversion" $ do
  specify "AnnotatedException and SomeException values don't appear in ApplicationFailure" $ \TestEnv {..} -> do
    uuid <- uuidText

    let
      taskMainWorkflow :: W.ProvidedWorkflow (W.Workflow ())
      taskMainWorkflow = provideCallStack $ W.provideWorkflow JSON "AnnotatedExceptionHaver" $ do
        Annotated.throw SampleException

      conf = configure () (taskMainWorkflow, testConf) $ do
        baseConf

    withWorker conf $ do
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
              , C.timeouts =
                  C.TimeoutOptions
                    { C.runTimeout = Just $ seconds 1
                    , C.executionTimeout = Nothing
                    , C.taskTimeout = Nothing
                    }
              }
      res <- Annotated.try (useClient (C.execute taskMainWorkflow . reference (WorkflowId uuid) opts))
      res
        `shouldSatisfy` ( \case
                            Left (WorkflowExecutionFailed {}) -> True
                            _ -> False
                        )

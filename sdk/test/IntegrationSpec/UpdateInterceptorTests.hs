{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module IntegrationSpec.UpdateInterceptorTests (spec) where

import Data.IORef
import Data.Maybe (fromJust)
import Data.Text (Text)
import Data.Vector (Vector)
import qualified Data.Vector as V
import DiscoverInstances (discoverInstances)
import IntegrationSpec.Updates (UpdateWithValidator (..), testUpdate)
import IntegrationSpec.Utils
import Network.Socket (PortNumber)
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Interceptor
import Temporal.Payload
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import qualified Temporal.Workflow as W
import Temporal.Workflow.Unsafe (performUnsafeNonDeterministicIO)
import Test.Hspec


-- | Update interceptor tests
spec :: SpecWith PortNumber
spec = do
  describe "Update interceptors" do
    handleUpdateWasCalled <- runIO $ newIORef False
    validateUpdateWasCalled <- runIO $ newIORef False
    updateWorkflowWasCalled <- runIO $ newIORef False
    let
      captureIfCalledInterceptors :: Interceptors ()
      captureIfCalledInterceptors =
        mempty
          { workflowInboundInterceptors =
              mempty
                { handleUpdate = \input next -> do
                    performUnsafeNonDeterministicIO $ writeIORef handleUpdateWasCalled True
                    next input
                , validateUpdate = \input next -> do
                    writeIORef validateUpdateWasCalled True
                    next input
                }
          , clientInterceptors =
              mempty
                { updateWorkflow = \input next -> do
                    writeIORef updateWorkflowWasCalled True
                    next input
                }
          }
    withInterceptors captureIfCalledInterceptors do
      it "should call update interceptors" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          let updateOpts =
                C.UpdateOptions
                  { updateId = "update-interceptors-are-called"
                  , updateHeaders = mempty
                  }
          (updateResult, workflowResult) <- useClient do
            h <- C.start UpdateWithValidator "update-interceptors-are-called" opts
            updateResult <- C.executeUpdate h testUpdate updateOpts 12
            workflowResult <- C.waitWorkflowResult h
            pure (updateResult, workflowResult)
          updateResult `shouldBe` 12
          workflowResult `shouldBe` 12
          readIORef handleUpdateWasCalled `shouldReturn` True
          readIORef validateUpdateWasCalled `shouldReturn` True
          readIORef updateWorkflowWasCalled `shouldReturn` True
    handleUpdateArgs <- runIO $ newIORef (Nothing :: Maybe (Vector Payload))
    validateUpdateArgs <- runIO $ newIORef (Nothing :: Maybe (Vector Payload))
    updateWorkflowArgs <- runIO $ newIORef (Nothing :: Maybe (Vector Payload))
    let
      captureArgsInterceptors :: Interceptors ()
      captureArgsInterceptors =
        mempty
          { workflowInboundInterceptors =
              mempty
                { handleUpdate = \input next -> do
                    performUnsafeNonDeterministicIO $ writeIORef handleUpdateArgs $ Just input.handleUpdateInputArgs
                    next input
                , validateUpdate = \input next -> do
                    writeIORef validateUpdateArgs $ Just input.handleUpdateInputArgs
                    next input
                }
          , clientInterceptors =
              mempty
                { updateWorkflow = \input next -> do
                    writeIORef updateWorkflowArgs $ Just input.updateWorkflowArgs
                    next input
                }
          }
    withInterceptors captureArgsInterceptors do
      it "calls update interceptors with the expected args" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          let updateOpts =
                C.UpdateOptions
                  { updateId = "update-interceptors-get-expected-args"
                  , updateHeaders = mempty
                  }
          (updateResult, workflowResult) <- useClient do
            h <- C.start UpdateWithValidator "update-interceptors-get-expected-args" opts
            updateResult <- C.executeUpdate h testUpdate updateOpts 12
            workflowResult <- C.waitWorkflowResult h
            pure (updateResult, workflowResult)
          updateResult `shouldBe` 12
          workflowResult `shouldBe` 12
          updateArgsPayload <- readIORef handleUpdateArgs
          let updateArg = payloadData $ V.head $ fromJust updateArgsPayload
          updateArg `shouldBe` "12"
          validatorArgsPayload <- readIORef validateUpdateArgs
          let validatorArg = payloadData $ V.head $ fromJust validatorArgsPayload
          validatorArg `shouldBe` "12"
          updateWorkflowPayload <- readIORef updateWorkflowArgs
          let updateWorkflowArg = payloadData $ V.head $ fromJust updateWorkflowPayload
          updateWorkflowArg `shouldBe` "12"
    handleUpdateOrdering <- runIO $ newIORef ([] :: [Text])
    validateUpdateOrdering <- runIO $ newIORef ([] :: [Text])
    updateWorkflowOrdering <- runIO $ newIORef ([] :: [Text])
    let
      captureOrderingInterceptors0 :: Interceptors ()
      captureOrderingInterceptors0 =
        mempty
          { workflowInboundInterceptors =
              mempty
                { handleUpdate = \input next -> do
                    performUnsafeNonDeterministicIO $ modifyIORef handleUpdateOrdering (++ ["a"])
                    next input
                , validateUpdate = \input next -> do
                    modifyIORef validateUpdateOrdering (++ ["a"])
                    next input
                }
          , clientInterceptors =
              mempty
                { updateWorkflow = \input next -> do
                    modifyIORef updateWorkflowOrdering (++ ["a"])
                    next input
                }
          }
      captureOrderingInterceptors1 :: Interceptors ()
      captureOrderingInterceptors1 =
        mempty
          { workflowInboundInterceptors =
              mempty
                { handleUpdate = \input next -> do
                    performUnsafeNonDeterministicIO $ modifyIORef handleUpdateOrdering (++ ["b"])
                    next input
                , validateUpdate = \input next -> do
                    modifyIORef validateUpdateOrdering (++ ["b"])
                    next input
                }
          , clientInterceptors =
              mempty
                { updateWorkflow = \input next -> do
                    modifyIORef updateWorkflowOrdering (++ ["b"])
                    next input
                }
          }
      captureOrderingInterceptors :: Interceptors ()
      captureOrderingInterceptors = captureOrderingInterceptors0 <> captureOrderingInterceptors1
    withInterceptors captureOrderingInterceptors do
      it "calls update interceptors in the expected order" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          let updateOpts =
                C.UpdateOptions
                  { updateId = "update-interceptors-are-called-in-expected-order"
                  , updateHeaders = mempty
                  }
          (updateResult, workflowResult) <- useClient do
            h <- C.start UpdateWithValidator "update-interceptors-are-called-in-expected-order" opts
            updateResult <- C.executeUpdate h testUpdate updateOpts 12
            workflowResult <- C.waitWorkflowResult h
            pure (updateResult, workflowResult)
          updateResult `shouldBe` 12
          workflowResult `shouldBe` 12
          readIORef handleUpdateOrdering `shouldReturn` ["a", "b"]
          readIORef validateUpdateOrdering `shouldReturn` ["a", "b"]
          readIORef updateWorkflowOrdering `shouldReturn` ["a", "b"]
    let
      modifyArgsInterceptors :: Interceptors ()
      modifyArgsInterceptors =
        mempty
          { workflowInboundInterceptors =
              mempty
                { handleUpdate = \input next -> do
                    let metadata = payloadMetadata $ V.head input.handleUpdateInputArgs
                    next $ input {handleUpdateInputArgs = V.singleton Payload {payloadData = "24", payloadMetadata = metadata}}
                }
          , clientInterceptors = mempty
          }
    withInterceptors modifyArgsInterceptors do
      it "supports modifying the args passed to update" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          let updateOpts =
                C.UpdateOptions
                  { updateId = "update-interceptors-can-modify-args"
                  , updateHeaders = mempty
                  }
          (updateResult, workflowResult) <- useClient do
            h <- C.start UpdateWithValidator "update-interceptors-can-modify-args" opts
            updateResult <- C.executeUpdate h testUpdate updateOpts 12
            workflowResult <- C.waitWorkflowResult h
            pure (updateResult, workflowResult)
          updateResult `shouldBe` 24
          workflowResult `shouldBe` 24
    let
      modifyArgsOnClientInterceptors :: Interceptors ()
      modifyArgsOnClientInterceptors =
        mempty
          { clientInterceptors =
              mempty
                { updateWorkflow = \input next -> do
                    let metadata = payloadMetadata $ V.head input.updateWorkflowArgs
                    next $ input {updateWorkflowArgs = V.singleton Payload {payloadData = "24", payloadMetadata = metadata}}
                }
          }
    withInterceptors modifyArgsOnClientInterceptors do
      it "supports modifying the args passed to update client-side" $ \TestEnv {..} -> do
        let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
              baseConf
        withWorker conf $ do
          let opts =
                (C.startWorkflowOptions taskQueue)
                  { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                  , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
                  }
          let updateOpts =
                C.UpdateOptions
                  { updateId = "update-client-interceptors-can-modify-args"
                  , updateHeaders = mempty
                  }
          (updateResult, workflowResult) <- useClient do
            h <- C.start UpdateWithValidator "update-client-interceptors-can-modify-args" opts
            updateResult <- C.executeUpdate h testUpdate updateOpts 12
            workflowResult <- C.waitWorkflowResult h
            pure (updateResult, workflowResult)
          updateResult `shouldBe` 24
          workflowResult `shouldBe` 24


withInterceptors :: Interceptors () -> SpecWith TestEnv -> SpecWith PortNumber
withInterceptors interceptors = aroundAllWith $ flip $ setup interceptors

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module WorkerTunerSpec where

import Common
import Control.Concurrent.MVar
import Control.Exception (bracket)
import Control.Monad (void, when)
import Control.Monad.Logger
import Control.Monad.Reader
import Data.IORef
import Data.Text (Text, pack)
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import GHC.Generics
import RequireCallStack
import System.Directory
import System.Environment (lookupEnv)
import Temporal.Activity
import Temporal.Bundle
import Temporal.Bundle.TH
import qualified Temporal.Client as C
import Temporal.Workflow (TaskQueue (..))
import Temporal.Core.Client hiding (RpcError)
import qualified Temporal.Core.Worker as Core
import Temporal.Core.Worker
  ( CustomSlotSupplier (..)
  , MarkSlotUsedContext (..)
  , ReleaseSlotContext (..)
  , ResourceBasedTunerConfig (..)
  , SlotSupplierConfig (..)
  , TunerConfig (..)
  , newCustomSlotSupplierHandle
  , freeCustomSlotSupplierHandle
  )
import Temporal.Duration
import Temporal.EphemeralServer
import qualified Temporal.EphemeralServer as TemporalDevServerConfig (TemporalDevServerConfig (..))
import Temporal.Payload
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec


temporalBundle
  [d|
    data TunerWorkflows = TunerWorkflows
      { tunerSuccessWorkflow :: W.Workflow Text
      , tunerActivityWorkflow :: W.Workflow Int
      , tunerBasicActivity :: Activity () Int
      }
      deriving stock (Generic)
    |]


tunerTestDefs :: Defs () TunerWorkflows
tunerTestDefs =
  defs JSON $
    provideCallStack $
      TunerWorkflows
        { tunerSuccessWorkflow = pure "success"
        , tunerActivityWorkflow = do
            W.executeActivity
              tunerTestRefs.tunerBasicActivity
              (W.defaultStartActivityOptions $ W.StartToClose $ seconds 5)
        , tunerBasicActivity = pure 42
        }


tunerTestRefs :: Refs TunerWorkflows
tunerTestRefs = refs JSON


tunerTestConf :: Definitions ()
tunerTestConf = collectTemporalDefinitions tunerTestDefs


uuidText :: IO Text
uuidText = UUID.toText <$> UUID.nextRandom


withServer :: (PortNumber -> IO a) -> IO a
withServer f = do
  lookupEnv "HS_TEMPORAL_SDK_LOCAL_TEST_SERVER" >>= \case
    Just _ -> f 7233
    _ -> do
      fp <- getFreePort
      mTemporalPath <- findExecutable "temporal"
      conf <- case mTemporalPath of
        Nothing -> error "Could not find the 'temporal' executable in PATH"
        Just temporalPath -> do
          let serverConfig =
                defaultTemporalDevServerConfig
                  { TemporalDevServerConfig.port = Just $ fromIntegral fp
                  , TemporalDevServerConfig.exe = ExistingPath temporalPath
                  }
          pure serverConfig
      withDevServer globalRuntime conf $ \_ -> do
        f fp


clientUrl :: PortNumber -> Text
clientUrl pn = "http://localhost:" <> pack (show pn)


mkConf :: TunerConfig -> IO (WorkerConfig ())
mkConf tunerCfg = do
  tq <- TaskQueue <$> uuidText
  pure $
    configure () tunerTestConf $ do
      setNamespace $ W.Namespace "default"
      setTaskQueue tq
      setTuner tunerCfg


mkClient :: PortNumber -> IO (C.WorkflowClient, Client)
mkClient pn = do
  c <- runStdoutLoggingT $ connectClient globalRuntime defaultClientConfig {targetUrl = clientUrl pn}
  wfClient <-
    C.workflowClient
      c
      C.WorkflowClientConfig
        { namespace = "default"
        , interceptors = mempty
        , payloadProcessor = PayloadProcessor pure (pure . Right)
        , enableTimeSkipping = False
        }
  pure (wfClient, c)


runWorkflowWithTuner :: PortNumber -> TunerConfig -> IO Text
runWorkflowWithTuner pn tunerCfg = do
  conf <- mkConf tunerCfg
  (wfClient, coreClient) <- mkClient pn
  bracket (startWorker coreClient conf) shutdown $ \_ -> do
    let tq = TaskQueue $ Core.taskQueue (coreConfig conf)
        opts = (C.startWorkflowOptions tq) {C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate}
    wfId <- W.WorkflowId <$> uuidText
    handle <- flip runReaderT wfClient $ C.start tunerTestRefs.tunerSuccessWorkflow wfId opts
    C.waitWorkflowResult handle


runActivityWorkflowWithTuner :: PortNumber -> TunerConfig -> IO Int
runActivityWorkflowWithTuner pn tunerCfg = do
  conf <- mkConf tunerCfg
  (wfClient, coreClient) <- mkClient pn
  bracket (startWorker coreClient conf) shutdown $ \_ -> do
    let tq = TaskQueue $ Core.taskQueue (coreConfig conf)
        opts = (C.startWorkflowOptions tq) {C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate}
    wfId <- W.WorkflowId <$> uuidText
    handle <- flip runReaderT wfClient $ C.start tunerTestRefs.tunerActivityWorkflow wfId opts
    C.waitWorkflowResult handle


spec :: Spec
spec = do
  aroundAll withServer $ do
    describe "Worker Tuner" $ do
      specify "worker runs with resource-based tuner" $ \pn -> do
        let tunerCfg =
              TunerConfig
                { workflowSlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 100) (Just 0)
                , activitySlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 10) (Just 20)
                , localActivitySlotSupplier = Just $ ResourceBasedSlotSupplier (Just 1) (Just 50) Nothing
                , nexusSlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 10) (Just 100)
                , resourceBasedTunerOptions =
                    Just
                      ResourceBasedTunerConfig
                        { targetMemoryUsage = 0.6
                        , targetCpuUsage = 0.6
                        }
                }
        result <- runWorkflowWithTuner pn tunerCfg
        result `shouldBe` "success"

      specify "worker runs with fixed-size tuner" $ \pn -> do
        let tunerCfg =
              TunerConfig
                { workflowSlotSupplier = Just $ FixedSizeSlotSupplier 10
                , activitySlotSupplier = Just $ FixedSizeSlotSupplier 10
                , localActivitySlotSupplier = Just $ FixedSizeSlotSupplier 10
                , nexusSlotSupplier = Just $ FixedSizeSlotSupplier 5
                , resourceBasedTunerOptions = Nothing
                }
        result <- runWorkflowWithTuner pn tunerCfg
        result `shouldBe` "success"

      specify "worker runs with mixed slot suppliers" $ \pn -> do
        let tunerCfg =
              TunerConfig
                { workflowSlotSupplier = Just $ FixedSizeSlotSupplier 10
                , activitySlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 10) (Just 20)
                , localActivitySlotSupplier = Just $ FixedSizeSlotSupplier 10
                , nexusSlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 10) (Just 100)
                , resourceBasedTunerOptions =
                    Just
                      ResourceBasedTunerConfig
                        { targetMemoryUsage = 0.5
                        , targetCpuUsage = 0.5
                        }
                }
        result <- runWorkflowWithTuner pn tunerCfg
        result `shouldBe` "success"

      specify "worker with resource-based tuner executes activities" $ \pn -> do
        let tunerCfg =
              TunerConfig
                { workflowSlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 100) Nothing
                , activitySlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 100) (Just 20)
                , localActivitySlotSupplier = Just $ ResourceBasedSlotSupplier (Just 1) (Just 50) Nothing
                , nexusSlotSupplier = Just $ ResourceBasedSlotSupplier (Just 2) (Just 10) (Just 100)
                , resourceBasedTunerOptions =
                    Just
                      ResourceBasedTunerConfig
                        { targetMemoryUsage = 0.8
                        , targetCpuUsage = 0.8
                        }
                }
        result <- runActivityWorkflowWithTuner pn tunerCfg
        result `shouldBe` 42

      specify "worker with defaults for resource-based slot options" $ \pn -> do
        let tunerCfg =
              TunerConfig
                { workflowSlotSupplier = Just $ ResourceBasedSlotSupplier Nothing Nothing Nothing
                , activitySlotSupplier = Just $ ResourceBasedSlotSupplier (Just 1) Nothing Nothing
                , localActivitySlotSupplier = Nothing
                , nexusSlotSupplier = Just $ ResourceBasedSlotSupplier Nothing Nothing Nothing
                , resourceBasedTunerOptions =
                    Just
                      ResourceBasedTunerConfig
                        { targetMemoryUsage = 0.6
                        , targetCpuUsage = 0.6
                        }
                }
        result <- runWorkflowWithTuner pn tunerCfg
        result `shouldBe` "success"

      specify "worker runs with custom slot supplier (workflow)" $ \pn -> do
        reserveCount <- newIORef (0 :: Int)
        releaseCount <- newIORef (0 :: Int)
        let supplier =
              CustomSlotSupplier
                { reserveSlot = \_ -> atomicModifyIORef' reserveCount (\n -> (n + 1, ()))
                , tryReserveSlot = \_ -> pure True
                , markSlotUsed = \_ -> pure ()
                , releaseSlot = \_ -> atomicModifyIORef' releaseCount (\n -> (n + 1, ()))
                }
        bracket (newCustomSlotSupplierHandle supplier) freeCustomSlotSupplierHandle $ \h -> do
          let tunerCfg =
                TunerConfig
                  { workflowSlotSupplier = Just $ CustomSlotSupplierConfig h
                  , activitySlotSupplier = Just $ FixedSizeSlotSupplier 10
                  , localActivitySlotSupplier = Just $ FixedSizeSlotSupplier 10
                  , nexusSlotSupplier = Just $ FixedSizeSlotSupplier 10
                  , resourceBasedTunerOptions = Nothing
                  }
          result <- runWorkflowWithTuner pn tunerCfg
          result `shouldBe` "success"
          rc <- readIORef reserveCount
          rc `shouldSatisfy` (> 0)

      specify "worker runs with custom slot supplier for all slot kinds" $ \pn -> do
        reserveCount <- newIORef (0 :: Int)
        let supplier =
              CustomSlotSupplier
                { reserveSlot = \_ -> atomicModifyIORef' reserveCount (\n -> (n + 1, ()))
                , tryReserveSlot = \_ -> pure True
                , markSlotUsed = \_ -> pure ()
                , releaseSlot = \_ -> pure ()
                }
        bracket (newCustomSlotSupplierHandle supplier) freeCustomSlotSupplierHandle $ \h -> do
          let tunerCfg =
                TunerConfig
                  { workflowSlotSupplier = Just $ CustomSlotSupplierConfig h
                  , activitySlotSupplier = Just $ CustomSlotSupplierConfig h
                  , localActivitySlotSupplier = Just $ CustomSlotSupplierConfig h
                  , nexusSlotSupplier = Just $ CustomSlotSupplierConfig h
                  , resourceBasedTunerOptions = Nothing
                  }
          result <- runActivityWorkflowWithTuner pn tunerCfg
          result `shouldBe` 42

      specify "custom slot supplier with concurrency limiting" $ \pn -> do
        slotsInUse <- newIORef (0 :: Int)
        maxSlots <- newIORef (0 :: Int)
        let maxConcurrency = 3 :: Int
        -- Gate starts empty; releaseSlot fills it to wake blocked reserveSlot callers
        slotGate <- newEmptyMVar
        let supplier =
              CustomSlotSupplier
                { reserveSlot = \_ -> do
                    let go = do
                          n <- readIORef slotsInUse
                          when (n >= maxConcurrency) $ do
                            takeMVar slotGate
                            go
                    go
                , tryReserveSlot = \_ -> do
                    n <- readIORef slotsInUse
                    pure (n < maxConcurrency)
                , markSlotUsed = \_ -> do
                    n <- atomicModifyIORef' slotsInUse (\n -> (n + 1, n + 1))
                    atomicModifyIORef' maxSlots (\m -> (max m n, ()))
                , releaseSlot = \_ -> do
                    atomicModifyIORef' slotsInUse (\n -> (max 0 (n - 1), ()))
                    void $ tryPutMVar slotGate ()
                }
        bracket (newCustomSlotSupplierHandle supplier) freeCustomSlotSupplierHandle $ \h -> do
          let tunerCfg =
                TunerConfig
                  { workflowSlotSupplier = Just $ CustomSlotSupplierConfig h
                  , activitySlotSupplier = Just $ FixedSizeSlotSupplier 10
                  , localActivitySlotSupplier = Just $ FixedSizeSlotSupplier 10
                  , nexusSlotSupplier = Just $ FixedSizeSlotSupplier 10
                  , resourceBasedTunerOptions = Nothing
                  }
          result <- runWorkflowWithTuner pn tunerCfg
          result `shouldBe` "success"
          peak <- readIORef maxSlots
          peak `shouldSatisfy` (<= maxConcurrency)

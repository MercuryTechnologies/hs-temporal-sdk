{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant bracket" #-}

-- | Shared utilities and test infrastructure for integration tests
module IntegrationSpec.Utils (
  -- * Test workflows and activities bundle
  WorkflowTests (..),
  testRefs,
  testDefs,
  testConf,
  testImpls,
  DerivingStrategiesWork (..),

  -- * Test exception types
  SampleException (..),
  AnApplicationFailure (..),
  RegressionTask (..),

  -- * Test environment and setup
  TestEnv (..),
  TemporalWorkflowJobPayload (..),
  withServer,
  withTimeSkippingServer,
  setup,
  setupTimeSkipping,
  mkBaseConf,
  baseConf,
  configure,
  withWorker,
  useClient,
  globalRuntime,
  runReplayHistory,

  -- * Client and worker helpers
  configWithRetry,
  mkWithWorker,
  makeClient,
  makeTimeSkippingClient,
  sillyEncryptionPayloadProcessor,
  makeClient',

  -- * Utilities
  uuidText,
  defaultCodec,
  MyWorkflow,
  WorkflowId (..),
  JSON (..),
) where

import Common
import Control.Concurrent
import Control.Exception
import Control.Exception.Annotated
import qualified Control.Exception.Annotated as Annotated
import Control.Monad (replicateM, when)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Aeson (FromJSON, ToJSON, Value, toJSON)
import qualified Data.ByteString as BS
import Data.Either (isLeft, isRight)
import Data.Foldable (traverse_)
import Data.Functor
import Data.IORef
import Data.Int
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromJust, isJust)
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Time (Day (ModifiedJulianDay), diffUTCTime, getCurrentTime)
import Data.Time.Clock (UTCTime)
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import Data.Vector (Vector)
import qualified Data.Vector as V
import DiscoverInstances (discoverInstances)
import GHC.Generics
import GHC.Stack (SrcLoc (..), callStack, fromCallSiteList)
import Lens.Family2
import OpenTelemetry.Trace
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import Proto.Temporal.Api.History.V1.Message (WorkflowExecutionFailedEventAttributes (..))
import qualified Proto.Temporal.Api.History.V1.Message_Fields as History
import RequireCallStack
import System.Directory
import System.Environment (lookupEnv)
import System.IO
import Temporal.Activity
import Temporal.Bundle
import Temporal.Bundle.TH
import qualified Temporal.Client as C
import qualified Temporal.Client.TestService
import Temporal.Contrib.OpenTelemetry
import Temporal.Core.Client hiding (RpcError)
import Temporal.Duration
import Temporal.EphemeralServer
import qualified Temporal.EphemeralServer as TemporalDevServerConfig (TemporalDevServerConfig (..))
import qualified Temporal.EphemeralServer as TemporalTestServerConfig (TemporalTestServerConfig (..))
import Temporal.Exception
import Temporal.Interceptor
import Temporal.Operator (IndexedValueType (..), SearchAttributes (..), addSearchAttributes, listSearchAttributes)
import Temporal.Payload hiding (around)
import Temporal.SearchAttributes
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Testing.Assertions
import Temporal.Worker
import qualified Temporal.Workflow as W
import Temporal.Workflow.Unsafe (performUnsafeNonDeterministicIO)


-- | Main test workflows and activities bundle
temporalBundle
  [d|
    data WorkflowTests = WorkflowTests
      { shouldRunWorkflowTest :: W.Workflow ()
      , raceBlockOnLeftSideWorks :: W.Workflow (Either Bool Bool)
      , raceBlockOnBothSidesWorks :: W.Workflow (Either Bool Bool)
      , raceThrowsRhsErrorWhenLhsBlocked :: W.Workflow (Either Bool Bool)
      , raceIgnoresRhsErrorOnLhsSuccess :: W.Workflow (Either Bool Bool)
      , continueAsNewWorks :: Int -> W.Workflow Text
      , basicActivityWf :: W.Workflow Int
      , basicActivity :: Activity () Int
      , heartbeatWorks :: Activity () Int
      , runHeartbeat :: W.Workflow Int
      , faultyActivity :: Activity () Int
      , faultyWorkflow :: W.Workflow Int
      , simpleWait :: W.Workflow ()
      , multipleArgs :: Int -> Text -> Bool -> W.Workflow (Int, Text, Bool)
      , nonRetryableFailureTest :: W.Workflow ()
      , nonRetryableFailureAct :: Activity () ()
      , retryableFailureTest :: W.Workflow ()
      , retryableFailureAct :: Activity () ()
      , -- Workflow with failing children
        workflowWithFailingChildren :: [Text] -> W.Workflow ()
      , workflowWithFailingChildrenChild :: W.Workflow ()
      }
      deriving stock (Generic)
    |]


temporalBundle
  [d|
    data DerivingStrategiesWork = DerivingStrategiesWork
      { derivingStrategyExampleThing :: Int
      }
      deriving stock (Show)
    |]


-- | Sample exception for testing exception handling
data SampleException = SampleException
  deriving stock (Show)


instance Exception SampleException


-- | Application failure for testing ApplicationFailure conversion
data AnApplicationFailure = AnApplicationFailure
  deriving stock (Show)


instance Exception AnApplicationFailure where
  toException = applicationFailureToException
  fromException = applicationFailureFromException


instance ToApplicationFailure AnApplicationFailure where
  toApplicationFailure _ =
    ApplicationFailure
      "AnApplicationFailure"
      "Uh oh"
      False
      []
      ""
      (Just $ seconds 1)


-- | Client configuration with retry settings
configWithRetry :: PortNumber -> ClientConfig
configWithRetry pn =
  defaultClientConfig
    { targetUrl = "http://localhost:" <> Text.pack (show pn)
    , retryConfig =
        Just $
          ClientRetryConfig
            { initialIntervalMillis = 500
            , randomizationFactor = 0.2
            , multiplier = 1.5
            , maxIntervalMillis = 10_000
            , maxRetries = 15
            , maxElapsedTimeMillis = Just 60_000
            }
    }


-- | Create a worker with the given configuration
mkWithWorker :: PortNumber -> WorkerConfig actEnv -> IO a -> IO a
mkWithWorker pn conf m = do
  let clientConfig_ = configWithRetry pn
  c <- runStdoutLoggingT $ connectClient globalRuntime clientConfig_
  bracket (startWorker c (conf {payloadProcessor = sillyEncryptionPayloadProcessor})) shutdown (const m)


{- | Silly encryption payload processor for testing
Increments bytestring bytes by 1 on encode, and decrements by 1 on decode
-}
sillyEncryptionPayloadProcessor :: PayloadProcessor
sillyEncryptionPayloadProcessor = PayloadProcessor incr decr
  where
    incr (Payload data_ meta) = pure $ Payload (BS.map (+ 1) data_) meta
    decr (Payload data_ meta) = pure $ Right $ Payload (BS.map (\x -> x - 1) data_) meta


-- | Create a workflow client and core client
makeClient :: PortNumber -> Interceptors env -> IO (C.WorkflowClient, Client)
makeClient pn interceptors = makeClient' pn interceptors False


-- | Create a time-skipping workflow client and core client
makeTimeSkippingClient :: PortNumber -> Interceptors env -> IO (C.WorkflowClient, Client)
makeTimeSkippingClient pn interceptors = makeClient' pn interceptors True


-- | Internal helper to create client with optional time skipping
makeClient' :: PortNumber -> Interceptors env -> Bool -> IO (C.WorkflowClient, Client)
makeClient' pn Interceptors {..} enableTimeSkipping = do
  let conf = configWithRetry pn
  c <- runStdoutLoggingT $ connectClient globalRuntime conf
  (,)
    <$> C.workflowClient
      c
      ( C.WorkflowClientConfig
          { namespace = "default"
          , interceptors = clientInterceptors
          , payloadProcessor = sillyEncryptionPayloadProcessor
          , enableTimeSkipping
          }
      )
    <*> pure c


-- | Generate a random UUID as Text
uuidText :: IO Text
uuidText = UUID.toText <$> UUID.nextRandom


-- | Test environment containing client, worker, and configuration helpers
data TestEnv = TestEnv
  { useClient :: forall a. ReaderT C.WorkflowClient IO a -> IO a
  , baseConf :: ConfigM () ()
  , taskQueue :: W.TaskQueue
  , withWorker :: forall a. WorkerConfig () -> IO a -> IO a
  }


-- | Payload for temporal workflow job tests
data TemporalWorkflowJobPayload = TemporalWorkflowJobPayload
  { workflowId :: W.WorkflowId
  , workflowType :: W.WorkflowType
  , workflowArgs :: [Data.Aeson.Value]
  , workflowNamespace :: W.Namespace
  , workflowTaskQueue :: W.TaskQueue
  , workflowRetryPolicy :: Maybe W.RetryPolicy
  , workflowIdReusePolicy :: Maybe W.WorkflowIdReusePolicy
  , workflowSearchAttributes :: Map SearchAttributeKey SearchAttributeType
  }
  deriving stock (Eq, Show, Generic)


instance ToJSON TemporalWorkflowJobPayload


instance FromJSON TemporalWorkflowJobPayload


-- | Run test with temporal dev server
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


-- | Run test with time-skipping test server
withTimeSkippingServer :: (PortNumber -> IO a) -> IO a
withTimeSkippingServer f = do
  lookupEnv "HS_TEMPORAL_SDK_LOCAL_TIME_SKIPPING_TEST_SERVER" >>= \case
    Just _ -> f 7234
    _ -> do
      fp <- getFreePort
      mTemporalPath <- findExecutable "temporal-test-server"
      conf <- case mTemporalPath of
        Nothing -> error "Could not find the 'temporal-test-server' (time-skipping) executable in PATH"
        Just temporalPath -> do
          pure
            TemporalTestServerConfig
              { TemporalTestServerConfig.exe = ExistingPath temporalPath
              , TemporalTestServerConfig.port = Just $ fromIntegral fp
              , TemporalTestServerConfig.extraArgs = []
              }
      withTestServer globalRuntime conf $ \_ -> do
        f fp


-- | Setup test environment with given interceptors
setup :: Interceptors () -> PortNumber -> (TestEnv -> IO ()) -> IO ()
setup additionalInterceptors fp go = do
  otelInterceptors <- makeOpenTelemetryInterceptor
  let interceptors = otelInterceptors <> additionalInterceptors
  (client, coreClient) <- makeClient fp interceptors

  SearchAttributes {customAttributes} <- either throwIO pure =<< listSearchAttributes coreClient (W.Namespace "default")
  let allTestAttributes =
        Map.fromList
          [ ("attr1", Temporal.Operator.Bool)
          , ("attr2", Temporal.Operator.Int)
          ]
  _ <- addSearchAttributes coreClient (W.Namespace "default") (allTestAttributes `Map.difference` customAttributes)

  (conf, taskQueue) <- mkBaseConf interceptors
  go
    TestEnv
      { useClient = flip runReaderT client
      , withWorker = mkWithWorker fp
      , baseConf = conf
      , taskQueue
      }


-- | Setup time-skipping test environment with given interceptors
setupTimeSkipping :: Interceptors () -> PortNumber -> (TestEnv -> IO ()) -> IO ()
setupTimeSkipping additionalInterceptors fp go = do
  otelInterceptors <- makeOpenTelemetryInterceptor
  let interceptors = otelInterceptors <> additionalInterceptors
  (client, _) <- makeTimeSkippingClient fp interceptors
  (conf, taskQueue) <- mkBaseConf interceptors
  go
    TestEnv
      { useClient = flip runReaderT client
      , withWorker = mkWithWorker fp
      , baseConf = conf
      , taskQueue
      }


-- | Type alias for workflow with call stack
type MyWorkflow a = W.RequireCallStack => W.Workflow a


-- | Default codec for tests
defaultCodec :: JSON
defaultCodec = JSON


-- | Regression task type for testing
data RegressionTask = Foo | Bar
  deriving stock (Eq, Show, Generic)


instance ToJSON RegressionTask


instance FromJSON RegressionTask


-- | Signal to unblock workflow
signalUnblockWorkflow :: W.KnownSignal '[]
signalUnblockWorkflow = W.KnownSignal "unblockWorkflow" defaultCodec


-- | Test workflow implementations
testImpls :: Impl WorkflowTests
testImpls =
  provideCallStack $
    WorkflowTests
      { shouldRunWorkflowTest = $(logDebug) "oh hi!"
      , raceBlockOnLeftSideWorks = do
          let lhs, rhs :: RequireCallStack => W.Workflow Bool
              lhs = do
                $(logDebug) "sleepy lad"
                W.sleep (seconds 10)
                $(logDebug) "bad"
                pure False
              rhs = $(logDebug) "wow" $> True
          res <- lhs `W.race` rhs
          $(logDebug) "done"
          pure res
      , raceBlockOnBothSidesWorks = do
          let lhs, rhs :: RequireCallStack => W.Workflow Bool
              lhs = W.sleep (seconds 5_000) >> pure False
              rhs = W.sleep (seconds 1) >> pure True
          lhs `W.race` rhs
      , raceThrowsRhsErrorWhenLhsBlocked = do
          let lhs, rhs :: RequireCallStack => W.Workflow Bool
              lhs = W.sleep (seconds 5_000) >> pure False
              rhs = error "foo"
          lhs `W.race` rhs
      , raceIgnoresRhsErrorOnLhsSuccess = do
          pure True `W.race` (W.sleep (seconds 5_000) *> error "sad")
      , continueAsNewWorks = \execCount ->
          if execCount < 1
            then W.continueAsNew testRefs.continueAsNewWorks W.defaultContinueAsNewOptions (execCount + 1)
            else pure "woohoo"
      , -- should run a basic activity without issues
        basicActivityWf = do
          $logDebug "starting activity"
          h <-
            W.startActivity
              testRefs.basicActivity
              (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          $logDebug "waiting for activity"
          W.wait (h :: W.Task Int)
      , basicActivity = pure 1
      , heartbeatWorks = withHeartbeat JSON $ \heartbeat _readHeartbeat -> do
          heartbeat ()
          liftIO $ threadDelay 1_000_000
          pure 1
      , runHeartbeat = do
          h <-
            W.startActivity
              testRefs.heartbeatWorks
              (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          W.wait (h :: W.Task Int)
      , faultyActivity = do
          res <- askActivityInfo
          if res.attempt <= 2
            then do
              error "sad"
            else pure 1
      , faultyWorkflow = do
          h1 <-
            W.startActivity
              testRefs.faultyActivity
              (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
          h2 <-
            W.startActivity
              testRefs.faultyActivity
              (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
          _ <- W.wait @(W.Task Int) h1
          W.wait @(W.Task Int) h2
      , simpleWait = do
          st <- W.newStateVar False
          W.concurrently_ (W.waitCondition (W.readStateVar st)) (W.writeStateVar st True)
      , multipleArgs = \foo bar baz -> pure (foo, bar, baz)
      , nonRetryableFailureTest = do
          h <-
            W.startActivity
              testRefs.nonRetryableFailureAct
              (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
          W.wait (h :: W.Task ())
      , nonRetryableFailureAct = checkpoint annotateNonRetryableError $ do
          error "sad"
      , retryableFailureTest = do
          h <-
            W.startActivity
              testRefs.retryableFailureAct
              (W.defaultStartActivityOptions $ W.StartToClose $ seconds 1)
          W.wait (h :: W.Task ())
      , retryableFailureAct = do
          i <- askActivityInfo
          if attempt i > 1
            then pure ()
            else error "sad"
      , workflowWithFailingChildren = \wfs -> do
          let runWf :: RequireCallStack => WorkflowId -> W.Workflow ()
              runWf f =
                W.executeChildWorkflow
                  testRefs.workflowWithFailingChildrenChild
                  ( W.defaultChildWorkflowOptions
                      { W.workflowId = Just f
                      , W.workflowIdReusePolicy = W.WorkflowIdReusePolicyAllowDuplicateFailedOnly
                      }
                  )
          traverse_ (runWf . WorkflowId) wfs
      , workflowWithFailingChildrenChild = do
          W.sleep $ seconds 2
      }


-- | References to test workflows and activities
testRefs :: Refs WorkflowTests
testRefs = refs defaultCodec


-- | Test workflow and activity definitions
testDefs :: Defs () WorkflowTests
testDefs = defs defaultCodec testImpls


-- | Test configuration with all definitions
testConf :: Definitions ()
testConf = collectTemporalDefinitions testDefs


-- | Create base configuration with interceptors
mkBaseConf :: Interceptors () -> IO (ConfigM () (), W.TaskQueue)
mkBaseConf interceptors = do
  taskQueue <- W.TaskQueue <$> uuidText
  pure
    ( do
        setNamespace $ W.Namespace "default"
        setTaskQueue taskQueue
        addInterceptors interceptors
        setLogger $ defaultOutput stdout
    , taskQueue
    )

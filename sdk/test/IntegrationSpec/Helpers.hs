module IntegrationSpec.Helpers where

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
import Data.Time (Day (ModifiedJulianDay))
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
import Temporal.Contrib.OpenTelemetry
import Temporal.Core.Client
import Temporal.Duration
import Temporal.EphemeralServer
import Temporal.Exception
import Temporal.Interceptor
import Temporal.Operator (IndexedValueType (..), SearchAttributes (..), addSearchAttributes, listSearchAttributes)
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Worker
import qualified Temporal.Workflow as W
import Temporal.Workflow.Unsafe (performUnsafeNonDeterministicIO)
import Test.Hspec


data TestEnv = TestEnv
  { useClient :: forall a. ReaderT C.WorkflowClient IO a -> IO a
  , baseConf :: ConfigM () ()
  , taskQueue :: W.TaskQueue
  , withWorker :: forall a. WorkerConfig () -> IO a -> IO a
  }


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
            -- , targetUrl = pack ("http://localhost:" <> show pn)
    }


mkWithWorker :: PortNumber -> WorkerConfig actEnv -> IO a -> IO a
mkWithWorker pn conf m = do
  let clientConfig_ = configWithRetry pn
  c <- connectClient globalRuntime clientConfig_
  bracket (startWorker c (conf {payloadProcessor = sillyEncryptionPayloadProcessor})) shutdown (const m)


-- Increment the bytestring words by 1 on encode, and decrement by 1 on decode
--
-- This is used to test that the payload processor is working correctly
sillyEncryptionPayloadProcessor :: PayloadProcessor
sillyEncryptionPayloadProcessor = PayloadProcessor incr decr
  where
    incr (Payload data_ meta) = pure $ Payload (BS.map (+ 1) data_) meta
    decr (Payload data_ meta) = pure $ Right $ Payload (BS.map (\x -> x - 1) data_) meta


makeClient :: PortNumber -> Interceptors env -> IO (C.WorkflowClient, Client)
makeClient pn Interceptors {..} = do
  let conf = configWithRetry pn
  c <- connectClient globalRuntime conf
  (,)
    <$> C.workflowClient
      c
      ( C.WorkflowClientConfig
          { namespace = "default"
          , interceptors = clientInterceptors
          , payloadProcessor = sillyEncryptionPayloadProcessor
          }
      )
    <*> pure c


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
                  { port = Just $ fromIntegral fp
                  , exe = ExistingPath temporalPath
                  }
          pure serverConfig
      withDevServer globalRuntime conf $ \_ -> do
        f fp


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

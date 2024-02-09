{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module ConcurrentAccessSpec where

import Control.Monad.Logger
import qualified Data.Text as T
import Test.Hspec
import qualified Data.EvalRecord as Rec
import Temporal.Bundle
import Temporal.Bundle.TH
import Temporal.Client
import Temporal.Core.Client
import Temporal.Payload
import Temporal.Workflow
import Temporal.Worker
import UnliftIO
import UnliftIO.Resource

temporalBundle [d|
  data OodlesOfQueues = OodlesOfQueues
    { queue1 :: TaskQueue
    , queue2 :: TaskQueue
    , queue3 :: TaskQueue
    , queue4 :: TaskQueue
    , queue5 :: TaskQueue
    , queue6 :: TaskQueue
    , queue7 :: TaskQueue
    , queue8 :: TaskQueue
    , queue9 :: TaskQueue
    , queue10 :: TaskQueue
    , queue11 :: TaskQueue
    , queue12 :: TaskQueue
    , queue13 :: TaskQueue
    , queue14 :: TaskQueue
    , queue15 :: TaskQueue
    , queue16 :: TaskQueue
    }
  
  data Functions = Functions
    { something :: Workflow ()
    }
  |]

impl :: Impl Functions
impl = Functions (pure ())

conf :: Definitions ()
conf = collectTemporalDefinitions $ defs JSON impl

workerConfigs :: WorkerConfigs () OodlesOfQueues
workerConfigs = Rec.pureC @((~) (WorkerConfig ())) $ \meta -> configure () conf $ do 
  setTaskQueue $ TaskQueue $ T.pack $ Rec.name meta

spec :: Spec
spec = do
  describe "Concurrent Worker initialization" $ do
    fit "should work" $ do
      runResourceT $ runStdoutLoggingT $ do
        let clientConfig = defaultClientConfig 
              { retryConfig = Just $ ClientRetryConfig
                  { initialIntervalMillis = 500
                  , randomizationFactor = 0.2
                  , multiplier = 1.5
                  , maxIntervalMillis = 10000
                  , maxRetries = 5
                  , maxElapsedTimeMillis = Just 60000
                  }
              }
        c <- liftIO $ connectClient clientConfig 
        qs <- replicateConcurrently 100 $ allocateU (startTaskQueues c workerConfigs) (liftIO . shutdownTaskQueues)
        mapConcurrently_ (\(k, _) -> release k) qs
      True `shouldBe` True
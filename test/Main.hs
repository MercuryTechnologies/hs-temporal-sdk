module Main where

import Control.Concurrent
import Control.Exception
import Control.Monad
import Test.Hspec.Runner
import Test.Hspec.Formatters
import qualified Spec
import Temporal.Runtime
import OpenTelemetry.Trace

main :: IO ()
main = do
  bracket initializeGlobalTracerProvider shutdownTracerProvider $ \_ -> do
  -- forkIO $ do
  --   threadDelay 1000000
  --   logs <- fetchLogs rt
  --   forM_ logs $ \log -> do
  --     putStrLn $ show (coreLogLevel log) <> ": " <> show (coreLogMessage log)
    hspecWith defaultConfig {configFormatter = Just progress} Spec.spec
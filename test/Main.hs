module Main where

import Control.Concurrent
import Control.Exception
import Control.Monad
import OpenTelemetry.Trace
import qualified Spec
import Temporal.EphemeralServer
import Temporal.Runtime
import Test.Hspec.Formatters
import Test.Hspec.Runner


main :: IO ()
main = do
  bracket initializeGlobalTracerProvider shutdownTracerProvider $ \_ -> do
    -- forkIO $ do
    --   threadDelay 1000000
    --   logs <- fetchLogs rt
    --   forM_ logs $ \log -> do
    --     putStrLn $ show (coreLogLevel log) <> ": " <> show (coreLogMessage log)
    hspecWith defaultConfig {configFormatter = Just progress} Spec.spec

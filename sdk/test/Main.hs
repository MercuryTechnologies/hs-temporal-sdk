module Main where

import Control.Exception
import Data.Function ((&))
import OpenTelemetry.Trace
import qualified Spec
import Test.Hspec.Api.Formatters.V1
import Test.Hspec.Runner


main :: IO ()
main = do
  -- bracket initializeGlobalTracerProvider shutdownTracerProvider $ \_ -> do
  -- forkIO $ do
  --   threadDelay 1000000
  --   logs <- fetchLogs rt
  --   forM_ logs $ \log -> do
  --     putStrLn $ show (coreLogLevel log) <> ": " <> show (coreLogMessage log)
  hspecWith (defaultConfig & useFormatter ("progress", progress)) Spec.spec

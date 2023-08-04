module Main where

import Control.Concurrent
import Control.Monad
import Test.Hspec.Runner
import Test.Hspec.Formatters
import qualified Spec
import Temporal.Runtime
import IntegrationSpec (rt)

main :: IO ()
main = do
  -- forkIO $ do
  --   threadDelay 1000000
  --   logs <- fetchLogs rt
  --   forM_ logs $ \log -> do
  --     putStrLn $ show (coreLogLevel log) <> ": " <> show (coreLogMessage log)
  hspecWith defaultConfig {configFormatter = Just progress} Spec.spec
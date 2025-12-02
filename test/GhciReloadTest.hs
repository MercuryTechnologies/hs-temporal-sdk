{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedStrings #-}

module GHCiReloadTest where

import Control.Concurrent (threadDelay)
import Temporal.Runtime

-- | Test configuration
testConfig :: IO ()
testConfig = do
    putStrLn "=== GHCi Reload Test ==="
    putStrLn "This module tests that the Temporal runtime survives GHCi reloads."
    putStrLn "Run this in GHCi:"
    putStrLn "  1. :load GHCiReloadTest"
    putStrLn "  2. runTest"
    putStrLn "  3. :reload"
    putStrLn "  4. runTest"
    putStrLn "If no crashes occur, the fix is working!"

-- | Simple test that initializes runtime and verifies no crash
-- Note: initializeRuntime now always reuses runtimes by default for GHCi reload resilience
runTest :: IO ()
runTest = do
    putStrLn "\n--- Starting test run (WITH runtime reuse) ---"

    -- Initialize runtime (automatically reuses existing runtime for GHCi reload resilience)
    putStrLn "Initializing Temporal runtime..."
    rt <- initializeRuntime NoTelemetry

    putStrLn "Runtime initialized successfully!"

    -- Small delay to let any background threads start
    threadDelay 100000  -- 100ms

    putStrLn "Cleaning up runtime..."
    destroyRuntime rt

    putStrLn "✓ Test completed successfully!"
    putStrLn "No crashes detected.\n"

-- | Quick test message
testMessage :: String
testMessage = "GHCi Reload Test Module Loaded Successfully! Run 'runTest' to test."

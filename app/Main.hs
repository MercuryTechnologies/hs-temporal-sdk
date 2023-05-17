{-# LANGUAGE ForeignFunctionInterface #-}

module Main (main) where

import Foreign.C.Types
import Temporal.Client
import Temporal.Runtime
import System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering

  putStrLn "Initializing Temporal runtime"
  rt <- initializeRuntime
  putStrLn "Connecting..."
  c <- connectClient rt defaultClientConfig
  case c of
    Left err -> error $ "Failed to connect to Temporal server: " <> show err
    Right c -> do
      putStrLn "Connected to Temporal server"
      updateMetadata c mempty
  pure ()
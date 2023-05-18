{-# LANGUAGE ForeignFunctionInterface #-}

module Main (main) where

import Data.ProtoLens.Message
import Foreign.C.Types
import Temporal.Client
import Temporal.Client.WorkflowService
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
      resp <- getSystemInfo c defMessage
      print resp
  pure ()
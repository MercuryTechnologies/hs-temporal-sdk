{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Control.Monad.Logger (runStdoutLoggingT)
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens.Message
import Data.Proxy
import qualified Data.Text as T
import Data.UUID.V4
import Data.UUID (UUID)
import qualified Data.UUID as UUID
import Foreign.C.Types
import Lens.Family2
import Temporal.Core.Client
import Temporal.Client.WorkflowService
import Temporal.Runtime
import Temporal.Core.Worker (defaultWorkerConfig)
import Temporal.Payloads (JSON)
import Temporal.Worker
import Temporal.Workflow
import Temporal.Workflow.WorkflowDefinition
import System.Environment
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as Proto
import Proto.Temporal.Api.Common.V1.Message_Fields (name)
import UnliftIO


main :: IO ()
main = do
  hSetBuffering stdout NoBuffering

  putStrLn "Initializing Temporal runtime"
  rt <- initializeRuntime
  putStrLn "Connecting..."
  c <- connectClient rt defaultClientConfig
  cmd <- getArgs
  case c of
    Left err -> error $ "Failed to connect to Temporal server: " <> show err
    Right c -> do
      putStrLn "Connected to Temporal server"
      resp <- getSystemInfo c defMessage
      print resp
      case cmd of
        ["worker"] -> runWorker c
        ["client", id'] -> runClient c id'
        _ -> error "Unknown command"
  pure ()

runWorker :: Client -> IO ()
runWorker c = do
  putStrLn "Running worker"
  let conf = mkConfig defaultWorkerConfig () $ HashMap.fromList
        [ ("hello", defineWorkflow (Proxy @JSON) "hello" (pure () :: Workflow () ()))
        ]
  runStdoutLoggingT $ withWorker c conf $ \handle -> do
    wait handle

runClient :: Client -> String -> IO ()
runClient c id' = do
  putStrLn "Running client"
  reqId <- nextRandom
  let req = defMessage
        & Proto.namespace .~ "default"
        & Proto.taskQueue .~ (defMessage & name .~ "default")
        & workflowType .~ (defMessage & name .~ "hello")
        & workflowId .~ T.pack id'
        & Proto.requestId .~ UUID.toText reqId
  resp <- startWorkflowExecution c req 
  
  print resp
        -- & workflowRunTimeoutSeconds .~ 100
        -- & workflowTaskTimeoutSeconds .~ 100
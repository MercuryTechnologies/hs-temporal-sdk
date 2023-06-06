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
import Lens.Family2
import Temporal.Core.Client
import Temporal.Client.WorkflowService
import Temporal.Runtime
import Temporal.Core.Worker (defaultWorkerConfig)
import Temporal.Payload (JSON(..))
import Temporal.Activity (Activity, defineActivity)
import Temporal.Worker
import Temporal.Workflow hiding (Info(..), wait)
import qualified Temporal.Workflow as Workflow
import Temporal.Workflow.WorkflowDefinition
import System.Environment
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as Proto
import Proto.Temporal.Api.Common.V1.Message_Fields (name)
import System.Clock
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
        ["client", taskname, id'] -> runClient c taskname id'
        _ -> error "Unknown command"
  pure ()

runWorker :: Client -> IO ()
runWorker c = do
  putStrLn "Running worker"
  let workflowDefs = HashMap.fromList
        [ ("hello", OpaqueWorkflow $ defineWorkflow JSON "hello" () (pure () :: Workflow JSON () () ()))
        , ( "helloActivity"
          , OpaqueWorkflow $ defineWorkflow JSON "helloActivity" () $ do
              act <- startActivity "Activate!" (defaultStartActivityOptions $ StartToClose $ TimeSpec 10 0) []
              Workflow.wait act
              pure ()
          )
        ]
      activityDefs = HashMap.fromList
        [ ("Activate!", defineActivity JSON "Activate!" (liftIO (putStrLn "OWKWROKRK") :: Activity () ()))]
      conf = mkConfig defaultWorkerConfig () workflowDefs () activityDefs
  runStdoutLoggingT $ do
    w <- startWorker c conf
    waitWorker w

runClient :: Client -> String -> String -> IO ()
runClient c taskname id' = do
  putStrLn "Running client"
  reqId <- nextRandom
  let req = defMessage
        & Proto.namespace .~ "default"
        & Proto.taskQueue .~ (defMessage & name .~ "default")
        & workflowType .~ (defMessage & name .~ T.pack taskname)
        & workflowId .~ T.pack id'
        & Proto.requestId .~ UUID.toText reqId
  resp <- startWorkflowExecution c req 
  
  print resp
        -- & workflowRunTimeoutSeconds .~ 100
        -- & workflowTaskTimeoutSeconds .~ 100
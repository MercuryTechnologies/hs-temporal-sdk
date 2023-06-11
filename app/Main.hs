{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Control.Monad
import Control.Concurrent
import Control.Monad.Logger (runStdoutLoggingT)
import qualified Data.HashMap.Strict as HashMap
import Data.ProtoLens.Message
import Data.Proxy
import qualified Data.Text as T
import Data.UUID.V4
import Data.UUID
import qualified Data.UUID as UUID
import Lens.Family2
import Temporal.Core.Client
import Temporal.Client.WorkflowService
import Temporal.Runtime
import Temporal.Core.Worker (defaultWorkerConfig)
import Temporal.Payload (JSON(..))
import Temporal.Activity (Activity, provideActivity)
import Temporal.Worker
import Temporal.Workflow hiding (Info(..), wait)
import qualified Temporal.Workflow as Workflow
import System.Environment
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as Proto
import Proto.Temporal.Api.Common.V1.Message_Fields (name)
import System.Clock
import UnliftIO

shootMissiles :: Int -> Activity () Int
shootMissiles times = do
  replicateM_ times $ do
    liftIO $ putStrLn "Shooting missile"
    liftIO $ threadDelay 1000000
    liftIO $ putStrLn "Missile shot"
  pure times

(shootMissileDef, shootMissileRef) = provideActivity JSON (Proxy @"shootMissiles") shootMissiles

requirePresidentialApproval :: Workflow () () ()
requirePresidentialApproval = do
  sleep $ TimeSpec 10 0
  pure ()

requirePresidentialApprovalRef :: KnownWorkflow "requirePresidentialApproval" '[] ()
requirePresidentialApprovalRef = KnownWorkflow JSON Nothing Nothing


launchTheMissiles :: Workflow () () Int
launchTheMissiles = do
  uuid <- uuid4
  presidentialApproval <- startChildWorkflow 
    requirePresidentialApprovalRef
    (defaultChildWorkflowOptions 
      { runTimeout = Just $ TimeSpec 20 0
      , taskTimeout = Just $ TimeSpec 20 0
      })
    (WorkflowId ("presidentialApproval-" <> UUID.toText uuid))
  waitChildWorkflowResult presidentialApproval
  act <- startActivity 
    (defaultStartActivityOptions $ StartToClose $ TimeSpec 40 0) 
    shootMissileRef 
    4
  r <- Workflow.wait act
  pure r


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
        [ ("hello", OpaqueWorkflow $ defineWorkflow JSON "hello" () (pure () :: Workflow () () ()))
        , ("launchTheMissiles", OpaqueWorkflow $ defineWorkflow JSON "launchTheMissiles" () launchTheMissiles)
        ]
      activityDefs =
        [ shootMissileDef
        ]
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
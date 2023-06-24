{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Control.Monad
import Control.Concurrent
import Control.Monad.Logger
import qualified Data.HashMap.Strict as HashMap
import Data.Proxy
import qualified Data.Text as T
import Data.UUID.V4
import Data.UUID
import qualified Data.UUID as UUID
import qualified Temporal.Client as C
import Temporal.Core.Client (Client, connectClient, defaultClientConfig)
import Temporal.Client.WorkflowService
import Temporal.EphemeralServer
import Temporal.Runtime
import Temporal.Core.Worker (defaultWorkerConfig)
import Temporal.Payload (JSON(..))
import Temporal.Activity (Activity, provideActivity)
import Temporal.Worker
import Temporal.Workflow hiding (Info(..), wait)
import qualified Temporal.Workflow as Workflow
import System.Environment
import System.Clock
import System.Posix.Signals
import UnliftIO

shootMissiles :: Int -> Activity () Int
shootMissiles times = do
  replicateM_ times $ do
    liftIO $ putStrLn "Shooting missile"
    liftIO $ threadDelay 1000000
    liftIO $ putStrLn "Missile shot"
  pure times


requirePresidentialApproval :: Workflow () () ()
requirePresidentialApproval = do
  sleep $ TimeSpec 10 0
  pure ()


launchTheMissiles :: Workflow () () Int
launchTheMissiles = do
  uuid <- uuid4
  $(logInfo) ("Launching the missiles with UUID " <> T.pack (UUID.toString uuid))
  presidentialApproval <- startChildWorkflow 
    requirePresidentialApprovalRef
    (defaultChildWorkflowOptions 
      { runTimeout = Just $ TimeSpec 20 0
      , taskTimeout = Just $ TimeSpec 20 0
      })
    (WorkflowId ("presidentialApproval-" <> UUID.toText uuid))
  $(logInfo) ("Awaiting confirmation from the president: " <> T.pack (UUID.toString uuid))
  waitChildWorkflowResult presidentialApproval
  $(logInfo) ("Confirmation confirmed, initiating sequence: " <> T.pack (UUID.toString uuid))
  act <- startActivity 
    (defaultStartActivityOptions $ StartToClose $ TimeSpec 40 0) 
    shootMissileRef 
    4
  $(logInfo) ("Sequence initiated: " <> T.pack (UUID.toString uuid))
  r <- Workflow.wait act
  $(logInfo) ("Sequence complete: " <> T.pack (UUID.toString uuid))
  pure r


hello :: T.Text -> Workflow () () T.Text
hello person = do
  t <- now
  let msg = "Hello, " <> person <> "! " <> T.pack (show t)
  $(logInfo) msg
  pure msg


-- To Run:
--
-- temporal workflow start --cron "* * * * *" --type chronicWorkflow --workflow-id chronic-chron-fixed --task-queue default
chronicWorkflow :: Workflow () () ()
chronicWorkflow = do
  t <- now
  $(logInfo) (T.pack ("Starting chronic workflow: " ++ show t))

(helloDef, helloRef) = provideWorkflow JSON "hello" () hello
(requirePresidentialApprovalDef, requirePresidentialApprovalRef) = provideWorkflow JSON "requirePresidentialApproval" () requirePresidentialApproval
(launchTheMissilesDef, launchTheMissilesRef) = provideWorkflow JSON "launchTheMissiles" () launchTheMissiles
(chronicWorkflowDef, chronicWorkflowRef) = provideWorkflow JSON "chronicWorkflow" () chronicWorkflow

(shootMissileDef, shootMissileRef) = provideActivity JSON "shootMissiles" shootMissiles

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  rt <- initializeRuntime
  -- _ephemeral <- startDevServer rt (defaultTemporalDevServerConfig { exe = ExistingPath "/opt/homebrew/bin/temporal" })
  
  putStrLn "Initializing Temporal runtime"
  putStrLn "Connecting..."
  c <- connectClient rt defaultClientConfig
  cmd <- getArgs
  case c of
    Left err -> error $ "Failed to connect to Temporal server: " <> show err
    Right c -> do
      putStrLn "Connected to Temporal server"
      case cmd of
        ["worker"] -> runWorker c
        ["client", taskname, id'] -> runClient c taskname id'
        _ -> error "Unknown command"
  pure ()

runWorker :: Client -> IO ()
runWorker c = do
  putStrLn "Running worker"
  let conf = configure () () $ do
        addWorkflow helloDef
        addWorkflow launchTheMissilesDef
        addWorkflow requirePresidentialApprovalDef
        addWorkflow chronicWorkflowDef

        addActivity shootMissileDef

  runStdoutLoggingT $ do
    w <- startWorker c conf
    withRunInIO $ \run -> do
      _ <- installHandler sigINT (Catch $ run $ shutdown w) Nothing
      _ <- installHandler sigTERM (Catch $ run $ shutdown w) Nothing
      pure ()
    waitWorker w

runClient :: Client -> String -> String -> IO ()
runClient c taskname id' = do
  putStrLn "Running client"
  reqId <- nextRandom
  let namespace = Namespace "default"
      queue = TaskQueue "default"
  workflowClient <- C.workflowClient c (Namespace "default") Nothing
  resp <- C.start 
    workflowClient
    helloRef
    (C.workflowStartOptions (WorkflowId $ T.pack id') queue)
    "Ian"
  C.awaitWorkflowResult resp >>= print
  pure ()
        -- & workflowRunTimeoutSeconds .~ 100
        -- & workflowTaskTimeoutSeconds .~ 100
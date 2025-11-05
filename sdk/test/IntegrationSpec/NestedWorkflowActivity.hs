{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module IntegrationSpec.NestedWorkflowActivity where

import Control.Monad.IO.Class (liftIO)
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.Generics (Generic)
import RequireCallStack (provideCallStack)
import Temporal.Activity
import Temporal.Bundle.TH
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Payload
import Temporal.TH
import qualified Temporal.Workflow as W


$( register
    [d|
      -- \| The main outer workflow that starts the chain.
      -- It executes an activity which will start another workflow.
      -- Takes the task queue as a parameter so the activity knows where to start the inner workflow.
      outerWorkflow :: W.TaskQueue -> W.Workflow Text
      outerWorkflow taskQueue = provideCallStack $ do
        -- Execute the first activity, passing the task queue so it can start the inner workflow
        result <-
          W.executeActivity
            MiddleActivity
            (W.defaultStartActivityOptions $ W.StartToClose $ seconds 30)
            taskQueue
        pure $ "Outer workflow completed with result: " <> result


      -- \| This activity starts another workflow and waits for its completion.
      -- This demonstrates starting workflows from activities.
      -- It takes the task queue as a parameter so it knows where to start the inner workflow.
      middleActivity :: W.TaskQueue -> Activity () Text
      middleActivity taskQueue = provideCallStack $ do
        info <- askActivityInfo

        -- Start the inner workflow on the same task queue with a 3-second timeout
        let W.WorkflowId outerWfId = info.workflowId
            innerWorkflowId = W.WorkflowId $ outerWfId <> "-inner"
            startOpts =
              (C.startWorkflowOptions taskQueue)
                { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
                , C.timeouts =
                    C.TimeoutOptions
                      { executionTimeout = Just $ seconds 3
                      , runTimeout = Nothing
                      , taskTimeout = Nothing
                      }
                }

        -- Execute the inner workflow and wait for its result
        -- Activity has a HasWorkflowClient instance, so we can call C.execute directly
        result <- C.execute InnerWorkflow innerWorkflowId startOpts 42
        pure $ "Inner workflow returned: " <> result


      -- \| The inner workflow that is started by the activity.
      -- It executes another activity to complete the chain.
      innerWorkflow :: Int -> W.Workflow Text
      innerWorkflow n = provideCallStack $ do
        -- Execute the final activity in the chain
        finalResult <-
          W.executeActivity
            FinalActivity
            (W.defaultStartActivityOptions $ W.StartToClose $ seconds 30)
            n
        pure $ "Inner workflow completed: " <> finalResult


      -- \| The final activity at the end of the chain.
      finalActivity :: Int -> Activity () Text
      finalActivity n = provideCallStack $ do
        info <- askActivityInfo
        pure $
          Text.pack $
            "Final activity executed with input "
              <> show n
              <> " in workflow "
              <> show info.workflowId
      |]
 )

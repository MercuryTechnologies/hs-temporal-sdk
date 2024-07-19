{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE TemplateHaskell #-}

module THCompiles where

import Language.Haskell.TH (newDeclarationGroup)
import RequireCallStack (provideCallStack)
import Temporal.Activity
import Temporal.Client qualified as Client
import Temporal.TH
import Temporal.Workflow


actWithoutTimeoutDefault :: Activity () ()
actWithoutTimeoutDefault = pure ()


registerActivity 'actWithoutTimeoutDefault


actWithTimeoutDefault :: Activity () ()
actWithTimeoutDefault = pure ()


registerActivity 'actWithTimeoutDefault


actWithNameOverride :: Activity () ()
actWithNameOverride = pure ()


registerActivityWithOptions
  'actWithNameOverride
  defaultActivityConfig
    { activityConfigNameOverride = Just "my-name"
    }


actWithAliases :: Activity () ()
actWithAliases = pure ()


registerActivityWithOptions
  'actWithAliases
  defaultActivityConfig
    { activityConfigAliases = ["alias1", "alias2"]
    }


workflowWithTaskQueue :: Int -> Workflow ()
workflowWithTaskQueue _ = pure ()


registerWorkflow 'workflowWithTaskQueue


data Wibble = Wibble


dingoBingo :: String -> Bool -> () -> Activity Wibble ()
dingoBingo _ _ _ = pure ()


registerActivity 'dingoBingo


newDeclarationGroup


workflowReferencingChild :: Workflow ()
workflowReferencingChild = provideCallStack do
  _ <- startChildWorkflow WorkflowWithTaskQueue defaultChildWorkflowOptions 0
  executeChildWorkflow WorkflowWithTaskQueue defaultChildWorkflowOptions 1


actionReferencingWorkflow :: Activity () ()
actionReferencingWorkflow = provideCallStack do
  _ <- Client.start WorkflowWithTaskQueue "1" (Client.startWorkflowOptions (TaskQueue "foo")) 1
  Client.execute WorkflowWithTaskQueue "2" (Client.startWorkflowOptions (TaskQueue "foo")) 1

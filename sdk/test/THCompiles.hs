{-# LANGUAGE TemplateHaskell #-}

module THCompiles where

import Language.Haskell.TH (newDeclarationGroup)
import RequireCallStack (provideCallStack)
import Temporal.Activity
import qualified Temporal.Client.TH as Client
import Temporal.Duration
import Temporal.TH
import Temporal.TH.Annotations
import Temporal.Workflow
import Temporal.Workflow.TH


actWithoutTimeoutDefault :: Activity () ()
actWithoutTimeoutDefault = pure ()


{-# ANN actWithTimeoutDefault (activityTimeout $ StartToClose $ seconds 2) #-}
actWithTimeoutDefault :: Activity () ()
actWithTimeoutDefault = pure ()


{-# ANN actWithNameOverride (overrideName "my-name") #-}
actWithNameOverride :: Activity () ()
actWithNameOverride = pure ()


{-# ANN actWithAliases (aliases ["alias1", "alias2"]) #-}
actWithAliases :: Activity () ()
actWithAliases = pure ()


{-# ANN actWithTaskQueue (AlwaysUse "my-task-queue") #-}
actWithTaskQueue :: Activity () ()
actWithTaskQueue = pure ()


-- {-# ANN actWithTimeouts defaultTimeoutOptions #-}
-- actWithTimeouts :: Activity () ()
-- actWithTimeouts = pure ()

{-# ANN actWithCancellationPolicy ActivityCancellationAbandon #-}
actWithCancellationPolicy :: Activity () ()
actWithCancellationPolicy = pure ()


{-# ANN actWithRetryPolicy defaultRetryPolicy #-}
actWithRetryPolicy :: Activity () ()
actWithRetryPolicy = pure ()


{-# ANN actWithHeartbeatTimeout (HeartbeatTimeout $ seconds 10) #-}
actWithHeartbeatTimeout :: Activity () ()
actWithHeartbeatTimeout = pure ()


-- {-# ANN actWithScheduleToStartTimeout (ScheduleToStartTimeout $ seconds 10) #-}
-- actWithScheduleToStartTimeout :: Activity () ()
-- actWithScheduleToStartTimeout = pure ()

{-# ANN workflowWithTaskQueue (AlwaysUse "my-task-queue") #-}
workflowWithTaskQueue :: Workflow ()
workflowWithTaskQueue = pure ()


workflowWithoutTaskQueue :: Workflow ()
workflowWithoutTaskQueue = pure ()


registerMany
  [ 'actWithoutTimeoutDefault
  , 'actWithTimeoutDefault
  , 'actWithNameOverride
  , 'actWithAliases
  , 'actWithTaskQueue
  , -- , 'actWithTimeouts
    'actWithCancellationPolicy
  , 'actWithRetryPolicy
  , 'actWithHeartbeatTimeout
  , -- , 'actWithScheduleToStartTimeout
    'workflowWithTaskQueue
  , 'workflowWithoutTaskQueue
  ]


newDeclarationGroup


workflowReferencingChild :: Workflow ()
workflowReferencingChild = provideCallStack do
  _ <- $(start 'workflowWithTaskQueue)
  $(execute 'workflowWithTaskQueue)
  _ <- $(start 'workflowWithoutTaskQueue)
  $(execute 'workflowWithoutTaskQueue)


actionReferencingWorkflow :: Activity () ()
actionReferencingWorkflow = provideCallStack do
  _ <- $(Client.start 'workflowWithTaskQueue) "1"
  $(Client.execute 'workflowWithTaskQueue) "2"
  _ <- $(Client.start 'workflowWithoutTaskQueue) "3" (TaskQueue "foo")
  $(Client.execute 'workflowWithoutTaskQueue) "4" (TaskQueue "foo")


registerMany
  [ 'workflowReferencingChild
  , 'actionReferencingWorkflow
  ]

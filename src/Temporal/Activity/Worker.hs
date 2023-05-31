module Temporal.Activity.Worker where

data ActivityWorker env = ActivityWorker
  { activityWorkerEnv :: env
  , activityWorkerDefinitions :: HashMap Text (ActivityDefinition env)
  }

withActivityWorker :: (ActivityWorker -> IO a) -> IO a
withActivityWorker f = withAsync go $ \workerAsync -> do
  f $ ActivityWorker
  where
    go = undefined




data RunningActivity = RunningActivity
  { 
  }

-- TODO, also need a version for upstream cancellation like .NET has
runningActivityCancel :: RunningActivity -> ActivityCancelReason -> IO ()
runningActivityCancel = undefined

runningActivityServerRequestedCancel :: RunningActivity -> IO Bool
runningActivityServerRequestedCancel = undefined

runningActivityHeartbeatException :: RunningActivity -> IO (Maybe SomeException)
runningActivityHeartbeatException = undefined

runningActivityMarkDone :: RunningActivity -> IO ()
runningActivityMarkDone = undefined

runningActivityWaitForHeartbestFinish :: RunningActivity -> IO ()
runningActivityWaitForHeartbestFinish = undefined

-- TODO heartbeat utils


module Temporal.Worker where

newtype WorkerPtr = WorkerPtr { workerPtr :: ForeignPtr WorkerPtr }

data Worker = Worker
  { worker :: WorkerPtr
  , workerRuntime :: Runtime
  }

newtype HistoryPusher = HistoryPusher { historyPusher :: ForeignPtr HistoryPusher }


type Proto = ByteString
type RunId = ByteString
type WorkflowId = ByteString

newWorker :: Runtime -> WorkerConfig -> IO Worker
newWorker = undefined

newReplayWorker :: Runtime -> WorkerConfig -> IO (Either ReplayWorkerConstructionError (Worker, HistoryPusher))
newReplayWorker = undefined

data WorkerConfig = WorkerConfig
  { namespace :: Text
  , taskQueue :: Text
  , buildId :: Text
  , identityOverride :: Maybe Text
  , maxCachedWorkflows :: CUSize
  , maxOutstandingWorkflowTasks :: CUSize
  , maxOutstandingActivities :: CUSize
  , maxOutstandingLocalActivities :: CUSize
  , maxConcurrentWorkflowTaskPolls :: CUSize
  , nonstickyToStickyPollRatio :: Float
  , maxConcurrentActivityTaskPolls :: CUSize
  , noRemoteActivities :: Bool
  , stickyQueueScheduleToStartTimeoutMillis :: Word64
  , maxHeartbeatThrottleIntervalMillis :: Word64
  , defaultHeartbeatThrottleIntervalMillis :: Word64
  , maxActivitiesPerSecond :: Maybe Double
  , maxTaskQueueActivitiesPerSecond :: Maybe Double
  , gracefulShutdownPeriodMillis :: Word64
  }

-- These are async in Rust, need to figure out how to get it to play nice with
-- Haskell's RTS.
pollWorkflowActivation :: Worker -> IO (Either PollError Proto)
pollWorkflowActivation = undefined

pollActivityTask :: Worker -> IO (Either PollError Proto)
pollActivityTask = undefined

completeWorkflowActivation :: Worker -> Proto -> IO (Either CompletionError ())
completeWorkflowActivation = undefined

completeActivityTask :: Worker -> Proto -> IO (Either CompletionError ())
completeActivityTask = undefined

recordActivityHeartbeat :: Worker -> Proto -> IO (Either CompletionError ())
recordActivityHeartbeat = undefined

requestWorkflowEviction :: Worker -> RunId -> IO ()
requestWorkflowEviction = undefined

initiateShutdown :: Worker -> IO ()
initiateShutdown = undefined

pushHistory :: HistoryPusher -> WorkflowId -> ByteString -> IO ()
pushHistory = undefined

closeHistoryPusher :: HistoryPusher -> IO ()
closeHistoryPusher = undefined
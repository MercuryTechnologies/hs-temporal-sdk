{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
module Temporal.Core.Worker 
  ( Worker
  , getWorkerClient
  , WorkerConfig(..)
  , getWorkerConfig
  , defaultWorkerConfig
  , WorkerError(..)
  , WorkerErrorCode(..)
  , WorkerType(..)
  , SWorkerType(..)
  , SomeWorkerType(..)
  , newWorker
  , newReplayWorker
  , InactiveForReplay
  , WorkflowActivation
  , pollWorkflowActivation
  , ActivityTask
  , pollActivityTask
  , WorkflowActivationCompletion
  , completeWorkflowActivation
  , ActivityTaskCompletion
  , completeActivityTask
  , ActivityHeartbeat
  , recordActivityHeartbeat
  , requestWorkflowEviction
  , initiateShutdown
  , finalizeShutdown
  , HistoryPusher
  , HistoryEvent
  , pushHistory
  , closeHistory
  ) where
import Control.Exception
import Data.Aeson
import Data.Aeson.TH
import Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as BL
import Data.Proxy
import Data.Text (Text)
import Data.Word
import Foreign.C.String
import Foreign.ForeignPtr
import Foreign.Marshal
import Foreign.Ptr
import Foreign.Storable
import Temporal.Core.Client
import Temporal.Internal.FFI
import Temporal.Runtime
import Data.ProtoLens.Encoding (encodeMessage, decodeMessageOrDie)
import Proto.Temporal.Api.History.V1.Message (HistoryEvent)
import Proto.Temporal.Sdk.Core.CoreInterface (ActivityHeartbeat, ActivityTaskCompletion)
import Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask (ActivityTask)
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation (WorkflowActivation)
import Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion (WorkflowActivationCompletion)
import Data.Void (Void)

data WorkerType = Real | Replay

-- | A singleton type for 'WorkerType'.
data SWorkerType (ty :: WorkerType) where
  SReal :: SWorkerType 'Real
  SReplay :: SWorkerType 'Replay

-- Promote a 'WorkerType' to a singleton type.
data SomeWorkerType where
  SomeWorkerType :: SWorkerType ty -> SomeWorkerType

type family InactiveForReplay (ty :: WorkerType) a where
  InactiveForReplay 'Real a = a
  InactiveForReplay 'Replay _ = Void

data Worker (ty :: WorkerType) = Worker 
  { workerPtr :: ForeignPtr (Worker ty)
  , workerConfig :: WorkerConfig
  , workerClient :: InactiveForReplay ty Client
  }

getWorkerClient :: Worker 'Real -> Client
getWorkerClient = workerClient

getWorkerConfig :: Worker ty -> WorkerConfig
getWorkerConfig = workerConfig

newtype HistoryPusher = HistoryPusher { historyPusher :: ForeignPtr HistoryPusher }
foreign import ccall "&hs_temporal_history_pusher_drop" historyPusherFinalizer :: FunPtr (Ptr HistoryPusher -> IO ())

type Proto = ByteString
type RunId = ByteString
type WorkflowId = ByteString

data WorkerConfig = WorkerConfig
  { namespace :: Text
  , taskQueue :: Text
  , buildId :: Text
  , identityOverride :: Maybe Text
  , maxCachedWorkflows :: Word64
  , maxOutstandingWorkflowTasks :: Word64
  , maxOutstandingActivities :: Word64
  , maxOutstandingLocalActivities :: Word64
  , maxConcurrentWorkflowTaskPolls :: Word64
  , nonstickyToStickyPollRatio :: Float
  , maxConcurrentActivityTaskPolls :: Word64
  , noRemoteActivities :: Bool
  , stickyQueueScheduleToStartTimeoutMillis :: Word64
  , maxHeartbeatThrottleIntervalMillis :: Word64
  , defaultHeartbeatThrottleIntervalMillis :: Word64
  , maxActivitiesPerSecond :: Maybe Double
  , maxTaskQueueActivitiesPerSecond :: Maybe Double
  , gracefulShutdownPeriodMillis :: Word64
  }
deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''WorkerConfig

defaultWorkerConfig :: WorkerConfig
defaultWorkerConfig = WorkerConfig
  { namespace = "default"
  , taskQueue = "default"
  , buildId = ""
  , identityOverride = Nothing
  , maxCachedWorkflows = 100000
  , maxOutstandingWorkflowTasks = 1000
  , maxOutstandingActivities = 1000
  , maxOutstandingLocalActivities = 1000
  , maxConcurrentWorkflowTaskPolls = 5
  , nonstickyToStickyPollRatio = 0.85
  , maxConcurrentActivityTaskPolls = 5
  , noRemoteActivities = False
  , stickyQueueScheduleToStartTimeoutMillis = 60000
  , maxHeartbeatThrottleIntervalMillis = 300000
  , defaultHeartbeatThrottleIntervalMillis = 300000
  , maxActivitiesPerSecond = Nothing
  , maxTaskQueueActivitiesPerSecond = Nothing
  , gracefulShutdownPeriodMillis = 0
  }

data WorkerErrorCode 
  = SDKError 
  | InitWorkerFailed 
  | InitReplayWorkerFailed 
  | InvalidProto 
  | ReplayWorkerClosed 
  | PollShutdown 
  | PollFailure 
  | CompletionFailure 
  | InvalidWorkerConfig
  | UnknownError Word8
  deriving (Show)

instance Storable WorkerErrorCode where
  sizeOf = const 1
  alignment = const 1
  peek ptr = do
    code <- peek (castPtr ptr :: Ptr Word8)
    case code of
      1 -> pure SDKError
      2 -> pure InitWorkerFailed
      3 -> pure InitReplayWorkerFailed
      4 -> pure InvalidProto
      5 -> pure ReplayWorkerClosed
      6 -> pure PollShutdown
      7 -> pure PollFailure
      8 -> pure CompletionFailure
      9 -> pure InvalidWorkerConfig
      _ -> pure $ UnknownError code
  poke ptr_ code = case code of
    SDKError -> poke ptr 1
    InitWorkerFailed -> poke ptr 2
    InitReplayWorkerFailed -> poke ptr 3
    InvalidProto -> poke ptr 4
    ReplayWorkerClosed -> poke ptr 5
    PollShutdown -> poke ptr 6
    PollFailure -> poke ptr 7
    CompletionFailure -> poke ptr 8
    InvalidWorkerConfig -> poke ptr 9
    (UnknownError code) -> poke ptr code
    where
      ptr = castPtr ptr_ :: Ptr Word8

data WorkerError = WorkerError
  { code :: WorkerErrorCode
  , message :: String
  } deriving (Show)

instance Exception WorkerError

foreign import ccall "hs_temporal_drop_worker_error" rust_dropWorkerError :: Ptr WorkerError -> IO ()

peekWorkerError :: Ptr WorkerError -> IO WorkerError
peekWorkerError ptr = do
  code <- peek (castPtr ptr :: Ptr WorkerErrorCode)
  msg <- peekCString (castPtr (plusPtr ptr (sizeOf code)))
  pure $ WorkerError code msg

instance ManagedRustValue WorkerError where
  type RustRef WorkerError = Ptr WorkerError
  type HaskellRep WorkerError = WorkerError
  fromRust _ rustPtr =
    peekWorkerError rustPtr `finally` rust_dropWorkerError rustPtr

foreign import ccall "hs_temporal_new_worker" raw_newWorker :: Ptr CoreClient -> Ptr (CArray Word8) -> Ptr (Ptr (Worker 'Real)) -> Ptr (Ptr WorkerError) -> IO ()
foreign import ccall "&hs_temporal_drop_worker" workerFinalizer :: FunPtr (Ptr (Worker ty) -> IO ())

-- note: removed the Runtime argument from the C function since the runtime can be accessed from the client. Might want to add it back later if
-- it is some sort of load-bearing memory management thing.
newWorker :: Client -> WorkerConfig -> IO (Either WorkerError (Worker 'Real))
newWorker c wc = withClient c $ \cPtr -> do
  withCArrayBS (BL.toStrict $ encode wc) $ \wcPtr -> do
    alloca $ \wPtrPtr -> do
      alloca $ \errPtrPtr -> do
        raw_newWorker cPtr wcPtr wPtrPtr errPtrPtr
        errPtr <- peek errPtrPtr
        if errPtr == nullPtr
          then do
            wPtr <- peek wPtrPtr
            fp <- newForeignPtr workerFinalizer wPtr
            pure $ Right $ Worker fp wc c
          else do
            err <- peekWorkerError errPtr
            pure $ Left err

foreign import ccall "hs_temporal_new_replay_worker" raw_newReplayWorker :: Ptr Runtime -> Ptr (CArray Word8) -> Ptr (Ptr (Worker 'Replay)) -> Ptr (Ptr HistoryPusher) -> Ptr (Ptr WorkerError) -> IO ()

newReplayWorker :: WorkerConfig -> IO (Either WorkerError (Worker 'Replay, HistoryPusher))
newReplayWorker = newReplayWorker' globalRuntime

newReplayWorker' :: Runtime -> WorkerConfig -> IO (Either WorkerError (Worker 'Replay, HistoryPusher))
newReplayWorker' r conf = withRuntime r $ \rPtr -> do
  alloca $ \wPtrPtr -> do
    alloca $ \hpPtrPtr -> do
      withCArrayBS (BL.toStrict $ encode conf) $ \confPtr -> do
        alloca $ \errPtrPtr -> do
          raw_newReplayWorker rPtr confPtr wPtrPtr hpPtrPtr errPtrPtr
          errPtr <- peek errPtrPtr
          if errPtr == nullPtr
            then do
              wPtr <- peek wPtrPtr
              hpPtr <- peek hpPtrPtr
              w <- newForeignPtr workerFinalizer wPtr
              hp <- newForeignPtr historyPusherFinalizer hpPtr
              pure $ Right (Worker w conf (error "Void"), HistoryPusher hp)
            else do
              err <- peekWorkerError errPtr
              pure $ Left err

foreign import ccall "hs_temporal_worker_poll_workflow_activation" raw_pollWorkflowActivation :: Ptr (Worker ty) -> TokioCall WorkerError (CArray Word8)
pollWorkflowActivation :: Worker ty -> IO (Either WorkerError WorkflowActivation)
pollWorkflowActivation (Worker w _ _) = do
  withForeignPtr w $ \wPtr -> do
    makeTokioAsyncCall (raw_pollWorkflowActivation wPtr)
      (fromRust (Proxy @WorkerError))
      (fmap decodeMessageOrDie . fromRust (Proxy @(CArray Word8)))

foreign import ccall "hs_temporal_worker_poll_activity_task" raw_pollActivityTask :: Ptr (Worker ty) -> TokioCall WorkerError (CArray Word8)
pollActivityTask :: Worker ty -> IO (Either WorkerError ActivityTask)
pollActivityTask (Worker w _ _) = do
  withForeignPtr w $ \wPtr -> do
    makeTokioAsyncCall (raw_pollActivityTask wPtr)
      (fromRust (Proxy @WorkerError))
      (fmap decodeMessageOrDie . fromRust (Proxy @(CArray Word8)))

foreign import ccall "hs_temporal_worker_complete_workflow_activation" raw_completeWorkflowActivation :: Ptr (Worker ty) -> Ptr (CArray Word8) -> TokioCall WorkerError ()
completeWorkflowActivation :: Worker ty -> WorkflowActivationCompletion -> IO (Either WorkerError ())
completeWorkflowActivation (Worker w _ _) p = withForeignPtr w $ \wPtr -> do
  withCArrayBS (encodeMessage p) $ \pPtr -> do
    makeTokioAsyncCall (raw_completeWorkflowActivation wPtr pPtr)
      (fromRust (Proxy @WorkerError))
      (fromRust (Proxy @()))

foreign import ccall "hs_temporal_worker_complete_activity_task" raw_completeActivityTask :: Ptr (Worker ty) -> Ptr (CArray Word8) -> TokioCall WorkerError ()
completeActivityTask :: Worker ty -> ActivityTaskCompletion -> IO (Either WorkerError ())
completeActivityTask (Worker w _ _) p = withForeignPtr w $ \wPtr -> do
  withCArrayBS (encodeMessage p) $ \pPtr -> do
    makeTokioAsyncCall (raw_completeActivityTask wPtr pPtr)
      (fromRust (Proxy @WorkerError))
      (fromRust (Proxy @()))

foreign import ccall "hs_temporal_worker_record_activity_heartbeat" raw_recordActivityHeartbeat :: Ptr (Worker ty) -> Ptr (CArray Word8) -> Ptr (Ptr WorkerError) -> Ptr (Ptr ()) -> IO ()
recordActivityHeartbeat :: Worker ty -> ActivityHeartbeat -> IO (Either WorkerError ())
recordActivityHeartbeat (Worker w _ _) p = withForeignPtr w $ \wPtr -> do
  withCArrayBS (encodeMessage p) $ \pPtr -> do
    alloca $ \errPtrPtr -> do
      alloca $ \resPtrPtr -> do
        raw_recordActivityHeartbeat wPtr pPtr errPtrPtr resPtrPtr
        errPtr <- peek errPtrPtr
        if errPtr == nullPtr
          then pure $ Right ()
          else Left <$> fromRust (Proxy @WorkerError) errPtr

foreign import ccall "hs_temporal_worker_request_workflow_eviction" raw_requestWorkflowEviction :: Ptr (Worker ty) -> Ptr (CArray Word8) -> IO ()
requestWorkflowEviction :: Worker ty -> RunId -> IO ()
requestWorkflowEviction (Worker w _ _) r = withForeignPtr w $ \wPtr -> do
  withCArrayBS r $ \rPtr -> do
    raw_requestWorkflowEviction wPtr rPtr

foreign import ccall "hs_temporal_worker_initiate_shutdown" raw_initiateShutdown :: Ptr (Worker ty) -> IO ()
{- | Initiate shutdown.
-}
initiateShutdown :: Worker ty -> IO ()
initiateShutdown (Worker w _ _) = withForeignPtr w $ \wPtr -> do
  raw_initiateShutdown wPtr

foreign import ccall "hs_temporal_worker_finalize_shutdown" raw_finalizeShutdown :: Ptr (Worker ty) -> TokioCall WorkerError ()
{- |
Completes shutdown and frees all resources. You should avoid simply dropping workers, as
this does not allow async tasks to report any panics that may have occurred cleanly.

This should be called only after 'raw_shutdown' has resolved and/or both polling
functions have returned `ShutDown` errors.
-}
finalizeShutdown :: Worker ty -> IO (Either WorkerError ())
finalizeShutdown (Worker w _ _) = withForeignPtr w $ \wPtr -> do
  makeTokioAsyncCall (raw_finalizeShutdown wPtr)
    (fromRust (Proxy @WorkerError))
    (fromRust (Proxy @()))

foreign import ccall "hs_temporal_history_pusher_push_history" raw_pushHistory :: Ptr HistoryPusher -> Ptr (CArray Word8) -> Ptr (CArray Word8) -> TokioCall WorkerError ()
-- TODO not sure if HistoryEvent is the right protobuf type here.
pushHistory :: HistoryPusher -> WorkflowId -> HistoryEvent -> IO (Either WorkerError ())
pushHistory (HistoryPusher hp) wf p = withForeignPtr hp $ \hpPtr -> do
  withCArrayBS wf $ \wfPtr -> do
    withCArrayBS (encodeMessage p) $ \pPtr -> do
      makeTokioAsyncCall (raw_pushHistory hpPtr wfPtr pPtr)
        (fromRust (Proxy @WorkerError))
        (fromRust (Proxy @()))

foreign import ccall "hs_temporal_history_pusher_close" raw_closeHistoryPusher :: Ptr HistoryPusher -> IO ()
closeHistory :: HistoryPusher -> IO ()
closeHistory (HistoryPusher hp) = withForeignPtr hp $ \hpPtr -> do
  raw_closeHistoryPusher hpPtr

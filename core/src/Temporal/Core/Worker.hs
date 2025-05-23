{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module Temporal.Core.Worker (
  Worker,
  getWorkerClient,
  WorkerConfig (..),
  getWorkerConfig,
  defaultWorkerConfig,
  WorkerError (..),
  WorkerErrorCode (..),
  WorkerType (..),
  SWorkerType (..),
  SomeWorkerType (..),
  newWorker,
  validateWorker,
  newReplayWorker,
  closeWorker,
  InactiveForReplay,
  WorkflowActivation,
  pollWorkflowActivation,
  ActivityTask,
  pollActivityTask,
  WorkflowActivationCompletion,
  completeWorkflowActivation,
  ActivityTaskCompletion,
  completeActivityTask,
  ActivityHeartbeat,
  recordActivityHeartbeat,
  requestWorkflowEviction,
  initiateShutdown,
  finalizeShutdown,
  HistoryPusher,
  History,
  pushHistory,
  closeHistory,
  KnownWorkerType (..),
  PollerBehavior(..),
  WorkerVersioningStrategy(..),
  VersioningBehavior(..),
) where

import Control.Exception
import Control.Monad
import Data.Aeson
import Data.Aeson.TH
import Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as BL
import Data.IORef
import Data.ProtoLens.Encoding (decodeMessageOrDie, encodeMessage)
import Data.Text (Text)
import Data.Void (Void)
import Data.Word
import Foreign.C.String
import Foreign.ForeignPtr
import Foreign.Marshal
import Foreign.Ptr
import Foreign.Storable
import Proto.Temporal.Api.History.V1.Message (History)
import Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask (ActivityTask)
import Proto.Temporal.Sdk.Core.CoreInterface (ActivityHeartbeat, ActivityTaskCompletion)
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation (WorkflowActivation)
import Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion (WorkflowActivationCompletion)
import Temporal.Core.CTypes
import Temporal.Core.Client
import Temporal.Internal.FFI
import Temporal.Runtime


data PollerBehavior
  = SimpleMaximum Word64
  | Autoscaling
      { minimum :: Word64
      , maximum :: Word64
      , initial :: Word64
      }
  deriving stock (Show, Eq)

deriveJSON (defaultOptions
  { fieldLabelModifier = camelTo2 '_'
  , sumEncoding = ObjectWithSingleField
  }) ''PollerBehavior

data VersioningBehavior
  = Pinned
  | AutoUpgrade
  deriving stock (Show, Eq)

deriveJSON (defaultOptions
  { fieldLabelModifier = camelTo2 '_'
  }) ''VersioningBehavior

data WorkerVersioningStrategy
  = NoVersioning
      { buildId :: Text
      }
  | WorkerDeploymentBased
      { deploymentName :: Text
      , buildId :: Text
      , useWorkerVersioning :: Bool
      , defaultVersioningBehavior :: Maybe VersioningBehavior
      }
  | LegacyBuildIdBased
      { buildId :: Text
      }
  deriving stock (Show, Eq)

deriveJSON (defaultOptions
  { fieldLabelModifier = camelTo2 '_'
  , sumEncoding = ObjectWithSingleField
  }) ''WorkerVersioningStrategy


data WorkerConfig = WorkerConfig
  { namespace :: Text
  , taskQueue :: Text
  , clientIdentityOverride :: Maybe Text
  , maxCachedWorkflows :: Word64
  , maxOutstandingWorkflowTasks :: Word64
  , maxOutstandingActivities :: Word64
  , maxOutstandingLocalActivities :: Word64
  , workflowTaskPollerBehavior :: PollerBehavior
  , nonstickyToStickyPollRatio :: Float
  , activityTaskPollerBehavior :: PollerBehavior
  , noRemoteActivities :: Bool
  , stickyQueueScheduleToStartTimeoutMillis :: Word64
  , maxHeartbeatThrottleIntervalMillis :: Word64
  , defaultHeartbeatThrottleIntervalMillis :: Word64
  , maxActivitiesPerSecond :: Maybe Double
  , maxTaskQueueActivitiesPerSecond :: Maybe Double
  , gracefulShutdownPeriodMillis :: Word64
  , nondeterminismAsWorkflowFail :: Bool
  , nondeterminismAsWorkflowFailForTypes :: [Text]
  , ignoreEvictsOnShutdown :: Bool
  , fetchingConcurrency :: Word64
  , localTimeoutBufferForActivitiesMillis :: Word64
  , versioningStrategy :: WorkerVersioningStrategy
  -- TODO:
  -- tuner
  -- nexus_task_poller_behavior
  -- max_outstanding_nexus_tasks
  -- versioning_strategy
  }


deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''WorkerConfig

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
  InactiveForReplay 'Replay _ = ()


class KnownWorkerType (ty :: WorkerType) where
  knownWorkerType :: SWorkerType ty


instance KnownWorkerType 'Real where
  knownWorkerType = SReal


instance KnownWorkerType 'Replay where
  knownWorkerType = SReplay


singFor :: KnownWorkerType ty => proxy ty -> SWorkerType ty
singFor _ = knownWorkerType


data Worker (ty :: WorkerType) = Worker
  { workerPtr :: {-# UNPACK #-} !(IORef (ForeignPtr (Worker ty)))
  , workerConfig :: !WorkerConfig
  , workerClient :: !(InactiveForReplay ty Client)
  , workerRuntime :: {-# UNPACK #-} !Runtime
  }


withWorker :: forall ty a. KnownWorkerType ty => Worker ty -> (Ptr (Worker ty) -> IO a) -> IO a
withWorker w@(Worker ptrRef _ c r) f = withRuntime r $ \_ ->
  let keepClientAlive :: IO a -> IO a
      keepClientAlive = case singFor w of
        SReal -> \m -> do
          a <- m
          touchClient c
          pure a
        SReplay -> id
  in keepClientAlive $ do
      ptr <- readIORef ptrRef
      withForeignPtr ptr f


getWorkerClient :: Worker 'Real -> Client
getWorkerClient = workerClient


getWorkerConfig :: Worker ty -> WorkerConfig
getWorkerConfig = workerConfig


newtype HistoryPusher = HistoryPusher {historyPusher :: Ptr HistoryPusher}


type Proto = ByteString


type RunId = ByteString


type WorkflowId = ByteString


defaultWorkerConfig :: WorkerConfig
defaultWorkerConfig =
  WorkerConfig
    { namespace = "default"
    , taskQueue = "default"
    , clientIdentityOverride = Nothing
    , maxCachedWorkflows = 0  -- Default from Rust SDK
    , maxOutstandingWorkflowTasks = 1000
    , maxOutstandingActivities = 1000
    , maxOutstandingLocalActivities = 1000
    , workflowTaskPollerBehavior = SimpleMaximum 5
    , nonstickyToStickyPollRatio = 0.2  -- Default from Rust SDK
    , activityTaskPollerBehavior = SimpleMaximum 5
    , noRemoteActivities = False
    , stickyQueueScheduleToStartTimeoutMillis = 10000  -- 10 seconds from Rust SDK
    , maxHeartbeatThrottleIntervalMillis = 60000  -- 60 seconds from Rust SDK
    , defaultHeartbeatThrottleIntervalMillis = 30000  -- 30 seconds from Rust SDK
    , maxActivitiesPerSecond = Nothing
    , maxTaskQueueActivitiesPerSecond = Nothing
    , gracefulShutdownPeriodMillis = 0
    , nondeterminismAsWorkflowFail = False
    , nondeterminismAsWorkflowFailForTypes = []
    , ignoreEvictsOnShutdown = False
    , fetchingConcurrency = 5  -- Default from Rust SDK
    , localTimeoutBufferForActivitiesMillis = 5000  -- 5 seconds from Rust SDK
    , versioningStrategy = NoVersioning {buildId = ""}
    }


foreign import ccall "hs_temporal_new_worker" raw_newWorker :: Ptr CoreClient -> Ptr (CArray Word8) -> Ptr (Ptr (Worker 'Real)) -> Ptr (Ptr CWorkerError) -> IO ()


foreign import ccall "hs_temporal_validate_worker" raw_validateWorker :: Ptr (Worker ty) -> TokioCall CWorkerValidationError CUnit


validateWorker :: Worker 'Real -> IO (Either WorkerValidationError ())
validateWorker w = withWorker w $ \wp -> do
  res <- makeTokioAsyncCall (raw_validateWorker wp) (Just rust_dropWorkerValidationError) (Just rust_dropUnit)
  case res of
    Left err -> Left <$> withForeignPtr err (peek >=> peekWorkerValidationError)
    Right _ -> pure $ Right ()


foreign import ccall "&hs_temporal_drop_worker" raw_closeWorker :: FinalizerPtr (Worker ty)


getWorkerError :: Ptr CWorkerError -> IO WorkerError
getWorkerError errPtr = do
  fp <- newForeignPtr rust_dropWorkerError errPtr
  withForeignPtr fp (peek >=> peekWorkerError)


-- note: removed the Runtime argument from the C function since the runtime can be accessed from the client. Might want to add it back later if
-- it is some sort of load-bearing memory management thing.
newWorker :: Client -> WorkerConfig -> IO (Either WorkerError (Worker 'Real))
newWorker c wc = withClient c $ \cPtr -> do
  withCArrayBS (BL.toStrict $ encode wc) $ \wcPtr -> do
    wPtrPtrFP <- mallocForeignPtr
    errPtrPtrFP <- mallocForeignPtr
    withForeignPtr wPtrPtrFP $ \wPtrPtr -> do
      withForeignPtr errPtrPtrFP $ \errPtrPtr -> do
        poke wPtrPtr nullPtr
        poke errPtrPtr nullPtr

        mask_ $ do
          raw_newWorker cPtr wcPtr wPtrPtr errPtrPtr
          errPtr <- peek errPtrPtr
          if errPtr == nullPtr
            then do
              wPtr <- peek wPtrPtr
              wPtrFP <- newForeignPtr raw_closeWorker wPtr
              wPtrRef <- newIORef wPtrFP
              pure $ Right $ Worker wPtrRef wc c (clientRuntime c)
            else Left <$> getWorkerError errPtr


data WorkerAlreadyClosed = WorkerAlreadyClosed
  deriving stock (Show)


instance Exception WorkerAlreadyClosed


closeWorker :: Worker ty -> IO ()
closeWorker (Worker w _ _ _) = mask_ $ do
  wp <- atomicModifyIORef' w $ \wp -> (throw WorkerAlreadyClosed, wp)
  finalizeForeignPtr wp


foreign import ccall "hs_temporal_new_replay_worker" raw_newReplayWorker :: Ptr Runtime -> Ptr (CArray Word8) -> Ptr (Ptr (Worker 'Replay)) -> Ptr (Ptr HistoryPusher) -> Ptr (Ptr CWorkerError) -> IO ()


newReplayWorker :: Runtime -> WorkerConfig -> IO (Either WorkerError (Worker 'Replay, HistoryPusher))
newReplayWorker r conf = withRuntime r $ \rPtr -> do
  alloca $ \wPtrPtr -> do
    alloca $ \hpPtrPtr -> do
      withCArrayBS (BL.toStrict $ encode conf) $ \confPtr -> do
        alloca $ \errPtrPtr -> do
          poke wPtrPtr nullPtr
          poke hpPtrPtr nullPtr
          poke errPtrPtr nullPtr

          raw_newReplayWorker rPtr confPtr wPtrPtr hpPtrPtr errPtrPtr
          errPtr <- peek errPtrPtr
          if errPtr == nullPtr
            then do
              wPtr <- peek wPtrPtr
              hpPtr <- peek hpPtrPtr
              w <- newForeignPtr raw_closeWorker wPtr
              wRef <- newIORef w
              pure $ Right (Worker wRef conf () r, HistoryPusher hpPtr)
            else Left <$> getWorkerError errPtr


foreign import ccall "hs_temporal_worker_poll_workflow_activation" raw_pollWorkflowActivation :: Ptr (Worker ty) -> TokioCall CWorkerError (CArray Word8)


pollWorkflowActivation :: KnownWorkerType ty => Worker ty -> IO (Either WorkerError WorkflowActivation)
pollWorkflowActivation w = withWorker w $ \wp -> do
  res <-
    makeTokioAsyncCall
      (raw_pollWorkflowActivation wp)
      (Just rust_dropWorkerError)
      (Just rust_dropByteArray)
  case res of
    Left err -> Left <$> withForeignPtr err (peek >=> peekWorkerError)
    Right ok -> Right . decodeMessageOrDie <$> withForeignPtr ok (peek >=> cArrayToByteString)


foreign import ccall "hs_temporal_worker_poll_activity_task" raw_pollActivityTask :: Ptr (Worker ty) -> TokioCall CWorkerError (CArray Word8)


pollActivityTask :: KnownWorkerType ty => Worker ty -> IO (Either WorkerError ActivityTask)
pollActivityTask w = withWorker w $ \wp -> do
  res <-
    makeTokioAsyncCall
      (raw_pollActivityTask wp)
      (Just rust_dropWorkerError)
      (Just rust_dropByteArray)
  case res of
    Left err -> Left <$> withForeignPtr err (peek >=> peekWorkerError)
    Right res -> Right . decodeMessageOrDie <$> withForeignPtr res (peek >=> cArrayToByteString)


foreign import ccall "hs_temporal_worker_complete_workflow_activation" raw_completeWorkflowActivation :: Ptr (Worker ty) -> Ptr (CArray Word8) -> TokioCall CWorkerError CUnit


completeWorkflowActivation :: KnownWorkerType ty => Worker ty -> WorkflowActivationCompletion -> IO (Either WorkerError ())
completeWorkflowActivation w p = withWorker w $ \wp ->
  withCArrayBS (encodeMessage p) $ \pPtr -> do
    res <-
      makeTokioAsyncCall
        (raw_completeWorkflowActivation wp pPtr)
        (Just rust_dropWorkerError)
        (Just rust_dropUnit)
    case res of
      Left err -> Left <$> withForeignPtr err (peek >=> peekWorkerError)
      Right _ -> pure $ Right ()


foreign import ccall "hs_temporal_worker_complete_activity_task" raw_completeActivityTask :: Ptr (Worker ty) -> Ptr (CArray Word8) -> TokioCall CWorkerError CUnit


completeActivityTask :: KnownWorkerType ty => Worker ty -> ActivityTaskCompletion -> IO (Either WorkerError ())
completeActivityTask w p = withWorker w $ \wp ->
  withCArrayBS (encodeMessage p) $ \pPtr -> do
    res <-
      makeTokioAsyncCall
        (raw_completeActivityTask wp pPtr)
        (Just rust_dropWorkerError)
        (Just rust_dropUnit)
    case res of
      Left err -> Left <$> withForeignPtr err (peek >=> peekWorkerError)
      Right _ -> pure $ Right ()


foreign import ccall "hs_temporal_worker_record_activity_heartbeat" raw_recordActivityHeartbeat :: Ptr (Worker ty) -> Ptr (CArray Word8) -> Ptr (Ptr CWorkerError) -> Ptr (Ptr CUnit) -> IO ()


recordActivityHeartbeat :: KnownWorkerType ty => Worker ty -> ActivityHeartbeat -> IO (Either WorkerError ())
recordActivityHeartbeat w p = withWorker w $ \wp ->
  withCArrayBS (encodeMessage p) $ \pPtr -> do
    alloca $ \errPtrPtr -> do
      alloca $ \resPtrPtr -> mask_ $ do
        poke errPtrPtr nullPtr
        poke resPtrPtr nullPtr
        raw_recordActivityHeartbeat wp pPtr errPtrPtr resPtrPtr
        errPtr <- peek errPtrPtr
        if errPtr == nullPtr
          then do
            rust_dropUnitNow =<< peek resPtrPtr
            pure $ Right ()
          else Left <$> getWorkerError errPtr


foreign import ccall "hs_temporal_worker_request_workflow_eviction" raw_requestWorkflowEviction :: Ptr (Worker ty) -> Ptr (CArray Word8) -> IO ()


requestWorkflowEviction :: KnownWorkerType ty => Worker ty -> RunId -> IO ()
requestWorkflowEviction w r = withWorker w $ \wp ->
  withCArrayBS r $ \rPtr -> do
    raw_requestWorkflowEviction wp rPtr


foreign import ccall "hs_temporal_worker_initiate_shutdown" raw_initiateShutdown :: Ptr (Worker ty) -> IO ()


-- | Initiate shutdown.
initiateShutdown :: KnownWorkerType ty => Worker ty -> IO ()
initiateShutdown w = withWorker w raw_initiateShutdown


foreign import ccall "hs_temporal_worker_finalize_shutdown" raw_finalizeShutdown :: Ptr (Worker ty) -> TokioCall CWorkerError CUnit


{- |
Completes shutdown and frees all resources. You should avoid simply dropping workers, as
this does not allow async tasks to report any panics that may have occurred cleanly.

This should be called only after 'initiateShutdown' has resolved and/or both polling
functions have returned `ShutDown` errors.
-}
finalizeShutdown :: KnownWorkerType ty => Worker ty -> IO (Either WorkerError ())
finalizeShutdown w = withWorker w $ \wp -> do
  res <-
    makeTokioAsyncCall
      (raw_finalizeShutdown wp)
      (Just rust_dropWorkerError)
      (Just rust_dropUnit)
  case res of
    Left err -> Left <$> withForeignPtr err (peek >=> peekWorkerError)
    Right _ -> pure $ Right ()


foreign import ccall "hs_temporal_history_pusher_push_history" raw_pushHistory :: Ptr HistoryPusher -> Ptr (CArray Word8) -> Ptr (CArray Word8) -> TokioCall CWorkerError CUnit


pushHistory :: HistoryPusher -> WorkflowId -> Either ByteString History -> IO (Either WorkerError ())
pushHistory (HistoryPusher hp) wf p =
  withCArrayBS wf $ \wfPtr -> do
    withCArrayBS (either id encodeMessage p) $ \pPtr -> do
      res <-
        makeTokioAsyncCall
          (raw_pushHistory hp wfPtr pPtr)
          (Just rust_dropWorkerError)
          (Just rust_dropUnit)
      case res of
        Left err -> Left <$> withForeignPtr err (peek >=> peekWorkerError)
        Right _ -> pure $ Right ()


foreign import ccall "hs_temporal_history_pusher_close" raw_closeHistoryPusher :: Ptr HistoryPusher -> IO ()


closeHistory :: HistoryPusher -> IO ()
closeHistory (HistoryPusher hp) =
  raw_closeHistoryPusher hp

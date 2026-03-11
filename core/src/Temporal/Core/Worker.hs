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
  pushHistoryJson,
  historyProtoToJson,
  closeHistory,
  KnownWorkerType (..),
  -- * Resource-safe wrappers
  bracketWorker,
  -- * Worker tuner configuration
  TunerConfig (..),
  SlotSupplierConfig (..),
  ResourceBasedTunerConfig (..),
  -- * Custom slot supplier
  CustomSlotSupplier (..),
  SlotReservationContext (..),
  SlotInfo (..),
  MarkSlotUsedContext (..),
  ReleaseSlotContext (..),
  CustomSlotSupplierHandle,
  newCustomSlotSupplierHandle,
  freeCustomSlotSupplierHandle,
) where

import Control.Concurrent (forkIO)
import Control.Exception
import Control.Monad
import Data.Aeson
import Data.Aeson.TH
import Data.Atomics (atomicModifyIORefCAS)
import Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.IORef
import Data.ProtoLens.Encoding (decodeMessageOrDie, encodeMessage)
import Data.Text (Text)
import Data.Void (Void)
import Data.Word
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal hiding (void)
import Foreign.Ptr
import Foreign.StablePtr
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
import UnliftIO (MonadIO, MonadUnliftIO, liftIO)
import qualified UnliftIO


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
  { workerPtr :: {-# UNPACK #-} !(IORef (Ptr (Worker ty)))
  , workerConfig :: !WorkerConfig
  , workerClient :: !(InactiveForReplay ty Client)
  , workerRuntime :: {-# UNPACK #-} !Runtime
  }


withWorker :: forall ty a. KnownWorkerType ty => Worker ty -> (Ptr (Worker ty) -> IO a) -> IO a
withWorker (Worker ptrRef _ _ r) f = withRuntime r $ \_ -> do
  ptr <- readIORef ptrRef
  f ptr


getWorkerClient :: Worker 'Real -> Client
getWorkerClient = workerClient


getWorkerConfig :: Worker ty -> WorkerConfig
getWorkerConfig = workerConfig


newtype HistoryPusher = HistoryPusher {historyPusher :: Ptr HistoryPusher}


type Proto = ByteString


type RunId = ByteString


type WorkflowId = ByteString


-- ---------------------------------------------------------------------------
-- Slot reservation / info context types (mirrors Rust serialization)
-- ---------------------------------------------------------------------------

data SlotReservationContext = SlotReservationContext
  { slotCtxTaskQueue :: Text
  , slotCtxWorkerIdentity :: Text
  , slotCtxNumIssuedSlots :: Word64
  , slotCtxIsSticky :: Bool
  }
  deriving stock (Show, Eq)


instance FromJSON SlotReservationContext where
  parseJSON = withObject "SlotReservationContext" $ \o ->
    SlotReservationContext
      <$> o .: "task_queue"
      <*> o .: "worker_identity"
      <*> o .: "num_issued_slots"
      <*> o .: "is_sticky"


data SlotInfo
  = WorkflowSlotInfo {workflowType :: Text, slotIsSticky :: Bool}
  | ActivitySlotInfo {activityType :: Text}
  | LocalActivitySlotInfo {localActivityType :: Text}
  | NexusSlotInfo {nexusService :: Text, nexusOperation :: Text}
  deriving stock (Show, Eq)


instance FromJSON SlotInfo where
  parseJSON = withObject "SlotInfo" $ \o -> do
    ty <- o .: "type"
    case (ty :: Text) of
      "workflow" -> WorkflowSlotInfo <$> o .: "workflow_type" <*> o .: "is_sticky"
      "activity" -> ActivitySlotInfo <$> o .: "activity_type"
      "local_activity" -> LocalActivitySlotInfo <$> o .: "activity_type"
      "nexus" -> NexusSlotInfo <$> o .: "service" <*> o .: "operation"
      _ -> fail $ "Unknown slot info type: " <> show ty


newtype MarkSlotUsedContext = MarkSlotUsedContext
  { markSlotInfo :: SlotInfo
  }
  deriving stock (Show, Eq)


instance FromJSON MarkSlotUsedContext where
  parseJSON = withObject "MarkSlotUsedContext" $ \o ->
    MarkSlotUsedContext <$> o .: "slot_info"


newtype ReleaseSlotContext = ReleaseSlotContext
  { releaseSlotInfo :: Maybe SlotInfo
  }
  deriving stock (Show, Eq)


instance FromJSON ReleaseSlotContext where
  parseJSON = withObject "ReleaseSlotContext" $ \o ->
    ReleaseSlotContext <$> o .:? "slot_info"


-- ---------------------------------------------------------------------------
-- Custom slot supplier
-- ---------------------------------------------------------------------------

-- | User-provided callbacks for a custom slot supplier.
--
-- @reserveSlot@ blocks until a slot is available. Called from Rust async context;
-- the implementation may block freely (it runs in a forked Haskell thread).
--
-- @tryReserveSlot@ must return immediately. Returns 'True' if a slot was granted.
--
-- @markSlotUsed@ and @releaseSlot@ are fire-and-forget notifications.
data CustomSlotSupplier = CustomSlotSupplier
  { reserveSlot :: SlotReservationContext -> IO ()
  , tryReserveSlot :: SlotReservationContext -> IO Bool
  , markSlotUsed :: MarkSlotUsedContext -> IO ()
  , releaseSlot :: ReleaseSlotContext -> IO ()
  }


-- | Opaque handle to a Rust-side custom slot supplier.
-- Must be freed with 'freeCustomSlotSupplierHandle' when no longer needed.
data CustomSlotSupplierHandle = CustomSlotSupplierHandle
  { unCustomSlotSupplierHandle :: !(Ptr CustomSlotSupplierHandle)
  , customSlotSupplierCleanup :: !(IO ())
  }


-- Rust FFI for custom slot supplier lifecycle
foreign import ccall "hs_temporal_new_custom_slot_supplier"
  raw_newCustomSlotSupplier
    :: FunPtr ReserveSlotCallback
    -> FunPtr TryReserveSlotCallback
    -> FunPtr MarkSlotUsedCallback
    -> FunPtr ReleaseSlotCallback
    -> IO (Ptr CustomSlotSupplierHandle)


foreign import ccall "hs_temporal_drop_custom_slot_supplier"
  raw_dropCustomSlotSupplier :: Ptr CustomSlotSupplierHandle -> IO ()


foreign import ccall "hs_temporal_slot_reserve_complete"
  raw_slotReserveComplete :: Ptr () -> IO ()


-- Callback types matching the Rust function pointer signatures.
-- ctx_ptr and ctx_len borrow JSON bytes that MUST be copied before returning.
type ReserveSlotCallback = Ptr Word8 -> CSize -> Ptr () -> IO ()
type TryReserveSlotCallback = Ptr Word8 -> CSize -> IO CInt
type MarkSlotUsedCallback = Ptr Word8 -> CSize -> IO ()
type ReleaseSlotCallback = Ptr Word8 -> CSize -> IO ()


-- "wrapper" imports to create FunPtrs from Haskell closures
foreign import ccall "wrapper"
  mkReserveSlotFunPtr :: ReserveSlotCallback -> IO (FunPtr ReserveSlotCallback)

foreign import ccall "wrapper"
  mkTryReserveSlotFunPtr :: TryReserveSlotCallback -> IO (FunPtr TryReserveSlotCallback)

foreign import ccall "wrapper"
  mkMarkSlotUsedFunPtr :: MarkSlotUsedCallback -> IO (FunPtr MarkSlotUsedCallback)

foreign import ccall "wrapper"
  mkReleaseSlotFunPtr :: ReleaseSlotCallback -> IO (FunPtr ReleaseSlotCallback)


-- | Decode a JSON payload from a Rust-owned (ptr, len) borrow.
-- Copies the bytes immediately so the pointer can be freed by Rust after return.
unsafeDecodeJSON :: FromJSON a => Ptr Word8 -> CSize -> IO a
unsafeDecodeJSON ptr len = do
  bs <- BS.packCStringLen (castPtr ptr, fromIntegral len)
  case eitherDecodeStrict' bs of
    Left err -> throwIO $ userError $ "Custom slot supplier JSON decode: " <> err
    Right v -> pure v


-- | Create a Rust-side custom slot supplier handle backed by Haskell callbacks.
-- The returned handle can be embedded in a 'SlotSupplierConfig' via
-- 'CustomSlotSupplierConfig'. Free with 'freeCustomSlotSupplierHandle'.
newCustomSlotSupplierHandle :: CustomSlotSupplier -> IO CustomSlotSupplierHandle
newCustomSlotSupplierHandle css = do
  stablePtr <- newStablePtr css

  reserveFP <- mkReserveSlotFunPtr $ \ctxPtr ctxLen completionPtr -> do
    ctx <- unsafeDecodeJSON ctxPtr ctxLen
    supplier <- deRefStablePtr stablePtr
    void $ forkIO $ do
      reserveSlot supplier ctx
      raw_slotReserveComplete completionPtr

  tryReserveFP <- mkTryReserveSlotFunPtr $ \ctxPtr ctxLen -> do
    ctx <- unsafeDecodeJSON ctxPtr ctxLen
    supplier <- deRefStablePtr stablePtr
    granted <- tryReserveSlot supplier ctx
    pure $ if granted then 1 else 0

  markUsedFP <- mkMarkSlotUsedFunPtr $ \infoPtr infoLen -> do
    ctx <- unsafeDecodeJSON infoPtr infoLen
    supplier <- deRefStablePtr stablePtr
    markSlotUsed supplier ctx

  releaseFP <- mkReleaseSlotFunPtr $ \infoPtr infoLen -> do
    ctx <- unsafeDecodeJSON infoPtr infoLen
    supplier <- deRefStablePtr stablePtr
    releaseSlot supplier ctx

  rustPtr <- raw_newCustomSlotSupplier reserveFP tryReserveFP markUsedFP releaseFP

  let cleanup = do
        freeHaskellFunPtr reserveFP
        freeHaskellFunPtr tryReserveFP
        freeHaskellFunPtr markUsedFP
        freeHaskellFunPtr releaseFP
        freeStablePtr stablePtr

  pure $ CustomSlotSupplierHandle rustPtr cleanup


-- | Free a custom slot supplier handle and its associated resources.
freeCustomSlotSupplierHandle :: CustomSlotSupplierHandle -> IO ()
freeCustomSlotSupplierHandle h = do
  raw_dropCustomSlotSupplier (unCustomSlotSupplierHandle h)
  customSlotSupplierCleanup h


-- ---------------------------------------------------------------------------
-- Slot supplier config
-- ---------------------------------------------------------------------------

data SlotSupplierConfig
  = FixedSizeSlotSupplier {fixedSlots :: Word64}
  | ResourceBasedSlotSupplier
      { minimumSlots :: Maybe Word64
      , maximumSlots :: Maybe Word64
      , rampThrottleMs :: Maybe Word64
      }
  | CustomSlotSupplierConfig
      { customHandle :: CustomSlotSupplierHandle
      }


instance ToJSON SlotSupplierConfig where
  toJSON (FixedSizeSlotSupplier n) =
    object
      [ "type" .= ("fixed_size" :: Text)
      , "slots" .= n
      ]
  toJSON (ResourceBasedSlotSupplier minS maxS ramp) =
    object
      [ "type" .= ("resource_based" :: Text)
      , "minimum_slots" .= minS
      , "maximum_slots" .= maxS
      , "ramp_throttle_ms" .= ramp
      ]
  toJSON (CustomSlotSupplierConfig h) =
    object
      [ "type" .= ("custom" :: Text)
      , "handle" .= ptrToWord (unCustomSlotSupplierHandle h)
      ]
    where
      ptrToWord :: Ptr a -> Word64
      ptrToWord = fromIntegral . ptrToWordPtr


instance FromJSON SlotSupplierConfig where
  parseJSON = withObject "SlotSupplierConfig" $ \o -> do
    ty <- o .: "type"
    case (ty :: Text) of
      "fixed_size" -> FixedSizeSlotSupplier <$> o .: "slots"
      "resource_based" ->
        ResourceBasedSlotSupplier
          <$> o .:? "minimum_slots"
          <*> o .:? "maximum_slots"
          <*> o .:? "ramp_throttle_ms"
      "custom" -> do
        w <- o .: "handle"
        pure $ CustomSlotSupplierConfig $ CustomSlotSupplierHandle (wordPtrToPtr $ fromIntegral (w :: Word64)) (pure ())
      _ -> fail $ "Unknown slot supplier type: " <> show ty


data ResourceBasedTunerConfig = ResourceBasedTunerConfig
  { targetMemoryUsage :: Double
  , targetCpuUsage :: Double
  }
  deriving stock (Show, Eq)


instance ToJSON ResourceBasedTunerConfig where
  toJSON r =
    object
      [ "target_memory_usage" .= targetMemoryUsage r
      , "target_cpu_usage" .= targetCpuUsage r
      ]


instance FromJSON ResourceBasedTunerConfig where
  parseJSON = withObject "ResourceBasedTunerConfig" $ \o ->
    ResourceBasedTunerConfig
      <$> o .: "target_memory_usage"
      <*> o .: "target_cpu_usage"


data TunerConfig = TunerConfig
  { workflowSlotSupplier :: Maybe SlotSupplierConfig
  , activitySlotSupplier :: Maybe SlotSupplierConfig
  , localActivitySlotSupplier :: Maybe SlotSupplierConfig
  , resourceBasedTunerOptions :: Maybe ResourceBasedTunerConfig
  }


instance ToJSON TunerConfig where
  toJSON t =
    object
      [ "workflow_slot_supplier" .= workflowSlotSupplier t
      , "activity_slot_supplier" .= activitySlotSupplier t
      , "local_activity_slot_supplier" .= localActivitySlotSupplier t
      , "resource_based_tuner_options" .= resourceBasedTunerOptions t
      ]


instance FromJSON TunerConfig where
  parseJSON = withObject "TunerConfig" $ \o ->
    TunerConfig
      <$> o .:? "workflow_slot_supplier"
      <*> o .:? "activity_slot_supplier"
      <*> o .:? "local_activity_slot_supplier"
      <*> o .:? "resource_based_tuner_options"


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
  , nondeterminismAsWorkflowFail :: Bool
  , nondeterminismAsWorkflowFailForTypes :: [Text]
  , tuner :: Maybe TunerConfig
  }


deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''WorkerConfig


defaultWorkerConfig :: WorkerConfig
defaultWorkerConfig =
  WorkerConfig
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
    , nondeterminismAsWorkflowFail = False
    , nondeterminismAsWorkflowFailForTypes = []
    , tuner = Nothing
    }


foreign import ccall "hs_temporal_new_worker" raw_newWorker :: Ptr CoreClient -> Ptr (CArray Word8) -> Ptr (Ptr (Worker 'Real)) -> Ptr (Ptr CWorkerError) -> IO ()


foreign import ccall "hs_temporal_validate_worker" raw_validateWorker :: Ptr (Worker ty) -> TokioCall CWorkerValidationError CUnit


validateWorker :: Worker 'Real -> IO (Either WorkerValidationError ())
validateWorker w = withWorker w $ \wp ->
  withTokioAsyncCall
    (raw_validateWorker wp)
    rust_dropWorkerValidationError
    rust_dropUnit
    (\errPtr -> peek errPtr >>= peekWorkerValidationError)
    (\_ -> return ())


foreign import ccall "hs_temporal_drop_worker" raw_closeWorker :: Ptr (Worker ty) -> IO ()


getWorkerError :: Ptr CWorkerError -> IO WorkerError
getWorkerError errPtr = do
  err <- peek errPtr >>= peekWorkerError
  rust_dropWorkerError errPtr
  return err


-- note: removed the Runtime argument from the C function since the runtime can be accessed from the client. Might want to add it back later if
-- it is some sort of load-bearing memory management thing.
newWorker :: Client -> WorkerConfig -> IO (Either WorkerError (Worker 'Real))
newWorker c wc = withClient c $ \cPtr -> do
  withCArrayBS (BL.toStrict $ encode wc) $ \wcPtr -> do
    alloca $ \wPtrPtr -> do
      alloca $ \errPtrPtr -> do
        poke wPtrPtr nullPtr
        poke errPtrPtr nullPtr

        mask_ $ do
          raw_newWorker cPtr wcPtr wPtrPtr errPtrPtr
          errPtr <- peek errPtrPtr
          if errPtr == nullPtr
            then do
              wPtr <- peek wPtrPtr
              wPtrRef <- newIORef wPtr
              pure $ Right $ Worker wPtrRef wc c (clientRuntime c)
            else Left <$> getWorkerError errPtr


data WorkerAlreadyClosed = WorkerAlreadyClosed
  deriving stock (Show)


instance Exception WorkerAlreadyClosed


-- | Explicitly close a worker.
--
-- Explicitly close a worker, freeing its resources immediately.
-- After calling this, the worker must not be used again.
closeWorker :: Worker ty -> IO ()
closeWorker (Worker w _ _ _) = mask_ $ do
  wp <- liftIO $ atomicModifyIORefCAS w $ \wp -> (throw WorkerAlreadyClosed, wp)
  raw_closeWorker wp


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
              wRef <- newIORef wPtr
              pure $ Right (Worker wRef conf () r, HistoryPusher hpPtr)
            else Left <$> getWorkerError errPtr


foreign import ccall "hs_temporal_worker_poll_workflow_activation" raw_pollWorkflowActivation :: Ptr (Worker ty) -> TokioCall CWorkerError (CArray Word8)


pollWorkflowActivation :: KnownWorkerType ty => Worker ty -> IO (Either WorkerError WorkflowActivation)
pollWorkflowActivation w = withWorker w $ \wp ->
  withTokioAsyncCall
    (raw_pollWorkflowActivation wp)
    rust_dropWorkerError
    rust_dropByteArray
    (\errPtr -> peek errPtr >>= peekWorkerError)
    (\resPtr -> do
      arr <- peek resPtr
      bs <- cArrayToByteString arr
      return (decodeMessageOrDie bs))


foreign import ccall "hs_temporal_worker_poll_activity_task" raw_pollActivityTask :: Ptr (Worker ty) -> TokioCall CWorkerError (CArray Word8)


pollActivityTask :: KnownWorkerType ty => Worker ty -> IO (Either WorkerError ActivityTask)
pollActivityTask w = withWorker w $ \wp ->
  withTokioAsyncCall
    (raw_pollActivityTask wp)
    rust_dropWorkerError
    rust_dropByteArray
    (\errPtr -> peek errPtr >>= peekWorkerError)
    (\resPtr -> do
      arr <- peek resPtr
      bs <- cArrayToByteString arr
      return (decodeMessageOrDie bs))


foreign import ccall "hs_temporal_worker_complete_workflow_activation" raw_completeWorkflowActivation :: Ptr (Worker ty) -> Ptr (CArray Word8) -> TokioCall CWorkerError CUnit


completeWorkflowActivation :: KnownWorkerType ty => Worker ty -> WorkflowActivationCompletion -> IO (Either WorkerError ())
completeWorkflowActivation w p = withWorker w $ \wp ->
  withCArrayBS (encodeMessage p) $ \pPtr ->
    withTokioAsyncCall
      (raw_completeWorkflowActivation wp pPtr)
      rust_dropWorkerError
      rust_dropUnit
      (\errPtr -> peek errPtr >>= peekWorkerError)
      (\_ -> return ())


foreign import ccall "hs_temporal_worker_complete_activity_task" raw_completeActivityTask :: Ptr (Worker ty) -> Ptr (CArray Word8) -> TokioCall CWorkerError CUnit


completeActivityTask :: KnownWorkerType ty => Worker ty -> ActivityTaskCompletion -> IO (Either WorkerError ())
completeActivityTask w p = withWorker w $ \wp ->
  withCArrayBS (encodeMessage p) $ \pPtr ->
    withTokioAsyncCall
      (raw_completeActivityTask wp pPtr)
      rust_dropWorkerError
      rust_dropUnit
      (\errPtr -> peek errPtr >>= peekWorkerError)
      (\_ -> return ())


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
            unitPtr <- peek resPtrPtr
            bracket (pure unitPtr) rust_dropUnit (\_ -> pure $ Right ())
          else do
            Left <$> getWorkerError errPtr


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
finalizeShutdown w = withWorker w $ \wp ->
  withTokioAsyncCall
    (raw_finalizeShutdown wp)
    rust_dropWorkerError
    rust_dropUnit
    (\errPtr -> peek errPtr >>= peekWorkerError)
    (\_ -> return ())


foreign import ccall "hs_temporal_history_pusher_push_history" raw_pushHistory :: Ptr HistoryPusher -> Ptr (CArray Word8) -> Ptr (CArray Word8) -> TokioCall CWorkerError CUnit


pushHistory :: HistoryPusher -> WorkflowId -> Either ByteString History -> IO (Either WorkerError ())
pushHistory (HistoryPusher hp) wf p =
  withCArrayBS wf $ \wfPtr ->
    withCArrayBS (either id encodeMessage p) $ \pPtr ->
      withTokioAsyncCall
        (raw_pushHistory hp wfPtr pPtr)
        rust_dropWorkerError
        rust_dropUnit
        (\errPtr -> peek errPtr >>= peekWorkerError)
        (\_ -> return ())


foreign import ccall "hs_temporal_history_pusher_push_history_json" raw_pushHistoryJson :: Ptr HistoryPusher -> Ptr (CArray Word8) -> Ptr (CArray Word8) -> TokioCall CWorkerError CUnit


-- | Push a workflow history in protobuf canonical JSON format to a replay worker.
-- The JSON is deserialized on the Rust side, bypassing proto-lens's incomplete
-- JSON support.
pushHistoryJson :: HistoryPusher -> WorkflowId -> ByteString -> IO (Either WorkerError ())
pushHistoryJson (HistoryPusher hp) wf jsonBytes =
  withCArrayBS wf $ \wfPtr ->
    withCArrayBS jsonBytes $ \jsonPtr ->
      withTokioAsyncCall
        (raw_pushHistoryJson hp wfPtr jsonPtr)
        rust_dropWorkerError
        rust_dropUnit
        (\errPtr -> peek errPtr >>= peekWorkerError)
        (\_ -> return ())


foreign import ccall "hs_temporal_history_proto_to_json" raw_historyProtoToJson :: Ptr (CArray Word8) -> Ptr (Ptr (CArray Word8)) -> Ptr (Ptr (CArray Word8)) -> IO ()


-- | Convert protobuf-encoded History bytes to canonical protobuf JSON.
-- The conversion is performed on the Rust side via prost + serde.
-- Useful for testing the JSON replay path.
historyProtoToJson :: ByteString -> IO (Either String ByteString)
historyProtoToJson protoBytes =
  withCArrayBS protoBytes $ \protoPtr ->
    alloca $ \resultSlot ->
      alloca $ \errorSlot -> do
        poke resultSlot nullPtr
        poke errorSlot nullPtr
        raw_historyProtoToJson protoPtr resultSlot errorSlot
        errPtr <- peek errorSlot
        if errPtr /= nullPtr
          then do
            arr <- peek errPtr
            bs <- cArrayToByteString arr
            rust_dropByteArray errPtr
            pure $ Left $ show bs
          else do
            resPtr <- peek resultSlot
            arr <- peek resPtr
            bs <- cArrayToByteString arr
            rust_dropByteArray resPtr
            pure $ Right bs


foreign import ccall "hs_temporal_history_pusher_close" raw_closeHistoryPusher :: Ptr HistoryPusher -> IO ()


closeHistory :: HistoryPusher -> IO ()
closeHistory (HistoryPusher hp) =
  raw_closeHistoryPusher hp


-- | Bracket-style wrapper for Worker that ensures proper cleanup.
--
-- Example:
--
-- @
-- result <- newWorker client workerConfig
-- case result of
--   Left err -> error $ show err
--   Right worker -> bracketWorker worker $ \\w -> do
--     ...
-- @
bracketWorker :: Worker ty -> (Worker ty -> IO a) -> IO a
bracketWorker worker = UnliftIO.bracket (return worker) closeWorker

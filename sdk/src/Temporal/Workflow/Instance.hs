module Temporal.Workflow.Instance where

import Control.Applicative
import qualified Control.Exception as E
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.IORef
import Data.Kind
import Data.Map.Strict (Map)
import Data.Set (Set)
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import Data.Vault.Strict (Vault)
import Data.Vector (Vector)
import Data.Word (Word32)
import GHC.Exts
import GHC.Stack
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation as Core
import System.Random.Stateful (StdGen)
import Temporal.Common
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Interceptor
import Temporal.Payload
import Temporal.Workflow.ChildWorkflowHandle
import Temporal.Workflow.CommandQueue
import Temporal.Workflow.IVar
import Temporal.Workflow.Types
import UnliftIO
import UnliftIO.Concurrent
import UnliftIO.STM


newtype WorkflowGenM = WorkflowGenM {unWorkflowGenM :: IORef StdGen}

data WorkflowUpdateImplementation = WorkflowUpdateImplementation
  { updateImplementation :: {-# UNPACK #-} !(UpdateId -> Vector Payload -> Map Text Payload -> Workflow Payload)
  , updateValidationImplementation :: {-# UNPACK #-} !(Maybe (UpdateId -> Vector Payload -> Map Text Payload -> Validation (Either SomeException ())))
  }

data WorkflowInstance = WorkflowInstance
  { workflowInstanceInfo :: {-# UNPACK #-} !(TVar Info)
  , workflowInstanceLogger :: !(Loc -> LogSource -> LogLevel -> LogStr -> IO ())
  , workflowRandomnessSeed :: {-# UNPACK #-} !WorkflowGenM
  , workflowNotifiedPatches :: {-# UNPACK #-} !(TVar (Set PatchId))
  , workflowMemoizedPatches :: {-# UNPACK #-} !(TVar (HashMap PatchId Bool))
  , workflowTime :: {-# UNPACK #-} !(TVar SystemTime)
  , workflowIsReplaying :: {-# UNPACK #-} !(TVar Bool)
  , workflowCallStack :: {-# UNPACK #-} !(IORef CallStack)
  , workflowCompleteActivation :: !(Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  , workflowDeadlockTimeout :: Maybe Int
  , workflowVault :: {-# UNPACK #-} !Vault
  , -- These are how the instance gets its work done
    activationChannel :: {-# UNPACK #-} !(TQueue Core.WorkflowActivation)
  , inboundInterceptor :: {-# UNPACK #-} !WorkflowInboundInterceptor
  , outboundInterceptor :: {-# UNPACK #-} !WorkflowOutboundInterceptor
  , -- Improves error reporting
    errorConverters :: [ApplicationFailureHandler]
  , payloadProcessor :: {-# UNPACK #-} !PayloadProcessor
  }


data WorkflowRuntime = WorkflowRuntime
  { workflowRuntimeInstance :: {-# UNPACK #-} !WorkflowInstance
  , workflowRuntimeThreads :: {-# UNPACK #-} !ThreadManager
  , workflowRuntimeCommandQueue :: {-# UNPACK #-} !CommandQueue
  , workflowRuntimeCancelRequested :: {-# UNPACK #-} !(IVar ())
  , workflowRuntimeSequenceMaps :: {-# UNPACK #-} !SequenceMaps
  , workflowRuntimeUnappliedJobs :: {-# UNPACK #-} !(TVar Int)
  , signals :: {-# UNPACK #-} !SignalSupport
  , queries :: {-# UNPACK #-} !QuerySupport
  , updates :: {-# UNPACK #-} !UpdateSupport
  }


data SignalSupport = SignalSupport
  { bufferedSignals :: {-# UNPACK #-} !(TVar [SignalWorkflow])
  -- ^ Since in this SDK, signals are registered during the execution of a workflow,
  -- we can't kick off signal requests until the workflow has had a chance to register
  -- handlers.
  --
  -- So, we buffer signals here that are processed prior to the Workflow having a chance
  -- to process them.
  --
  -- When should we start handling these signals? We can't kick them off _immediately_
  -- upon registration, because the Workflow may not have had a chance to register subsequent
  -- signal handlers.
  --
  -- We also need to respect the order that signals are received, so we can't just
  -- drain the queue for only recognized signals.
  --
  -- So, I think the best option is that up until we hit a signal that we don't recognize,
  -- we just enqueue the signals into the queue, and treat them as dealt with by decrementing
  -- the unappliedJobs counter.
  , signalHandlers :: {-# UNPACK #-} !(TVar (HashMap (Maybe Text) (Vector Payload -> InstanceM ())))
  }


data QuerySupport = QuerySupport
  { bufferedQueries :: {-# UNPACK #-} !(TVar [QueryWorkflow])
  , queryHandlers :: {-# UNPACK #-} !(TVar (HashMap (Maybe Text) (QueryId -> Vector Payload -> Map Text Payload -> IO (Either SomeException Payload))))
  }

data UpdateSupport = UpdateSupport
  { bufferedUpdates :: {-# UNPACK #-} !(TVar [DoUpdate])
  , updateHandlers :: {-# UNPACK #-} !(TVar (HashMap (Maybe Text) WorkflowUpdateImplementation))
  }

instance HasThreadManager WorkflowRuntime where
  getThreadManager = workflowRuntimeThreads


instance HasCommandQueue WorkflowRuntime where
  getCommandQueue = workflowRuntimeCommandQueue


type SequenceMap a = HashMap.HashMap Sequence a


resolveSequence :: TVar (SequenceMap a) -> Sequence -> STM (Maybe a)
resolveSequence sequenceMap seq = stateTVar sequenceMap $ \m -> (HashMap.lookup seq m, HashMap.delete seq m)


data Sequences = Sequences
  { externalCancel :: {-# UNPACK #-} !(TVar Word32)
  , childWorkflow :: {-# UNPACK #-} !(TVar Word32)
  , externalSignal :: {-# UNPACK #-} !(TVar Word32)
  , timer :: {-# UNPACK #-} !(TVar Word32)
  , activity :: {-# UNPACK #-} !(TVar Word32)
  }


data SequenceMaps = SequenceMaps
  { timers :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ())))
  , activities :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ResolveActivity)))
  , childWorkflows :: {-# UNPACK #-} !(TVar (SequenceMap (ChildWorkflowHandle Any)))
  , externalSignals :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ResolveSignalExternalWorkflow)))
  , externalCancels :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ResolveRequestCancelExternalWorkflow)))
  , counters :: {-# UNPACK #-} !Sequences
  }


newtype InstanceM (a :: Type) = InstanceM {unInstanceM :: ReaderT WorkflowRuntime IO a}
  deriving newtype
    ( Functor
    , Applicative
    , Alternative
    , Monad
    , MonadIO
    , MonadReader WorkflowRuntime
    , MonadUnliftIO
    , Catch.MonadThrow
    , Catch.MonadCatch
    , Catch.MonadMask
    )


instance Semigroup a => Semigroup (InstanceM a) where
  (<>) = liftA2 (<>)


instance Monoid a => Monoid (InstanceM a) where
  mempty = InstanceM $ pure mempty


instance MonadLogger InstanceM where
  monadLoggerLog loc src lvl msg = do
    logger <- asks (workflowInstanceLogger . workflowRuntimeInstance)
    liftIO $ logger loc src lvl (toLogStr msg)


instance MonadLoggerIO InstanceM where
  askLoggerIO = asks (workflowInstanceLogger . workflowRuntimeInstance)


runInstanceM :: WorkflowRuntime -> InstanceM a -> IO a
runInstanceM runtime m = runReaderT (unInstanceM m) runtime


nextExternalCancelSequence :: InstanceM Sequence
nextExternalCancelSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.externalCancel $ \s ->
    (Sequence s, succ s)


nextChildWorkflowSequence :: InstanceM Sequence
nextChildWorkflowSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.childWorkflow $ \s ->
    (Sequence s, succ s)


nextExternalSignalSequence :: InstanceM Sequence
nextExternalSignalSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.externalSignal $ \s ->
    (Sequence s, succ s)


nextTimerSequence :: InstanceM Sequence
nextTimerSequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.timer $ \s ->
    (Sequence s, succ s)


nextActivitySequence :: InstanceM Sequence
nextActivitySequence = do
  runtime <- ask
  atomically $ stateTVar runtime.workflowRuntimeSequenceMaps.counters.activity $ \s ->
    (Sequence s, succ s)

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Worker.Types where
import Control.Applicative (liftA2, Alternative(..))
import Control.Concurrent.Async (Async)
import qualified Control.Concurrent.STM as STM
import Control.Concurrent.STM.TMVar (TMVar)
import Control.Exception (SomeException)
import qualified Control.Monad.Catch as Catch
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.State
import Data.ProtoLens
import Data.ByteString (ByteString)
import Data.Hashable (Hashable(..))
import Data.IORef (IORef)
import Data.Proxy
import Data.HashMap.Strict (HashMap)
import Data.Kind
import Data.Map.Strict (Map)
import Data.Set (Set)
import Data.Text (Text)
import qualified Data.Text as T
import Data.Vector (Vector)
import Data.Word (Word32)
import GHC.Stack (CallStack, HasCallStack, callStack, withFrozenCallStack, popCallStack)
import Control.Concurrent.STM.TVar (TVar)
import Lens.Family2
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
  ( ResolveActivity
  , ResolveChildWorkflowExecutionStart
  , ResolveChildWorkflowExecution
  , ResolveSignalExternalWorkflow
  , ResolveRequestCancelExternalWorkflow
  )
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  , WorkflowCommand'Variant(..)
  , CompleteWorkflowExecution
  )
import Proto.Temporal.Api.Common.V1.Message (Payload, Memo, SearchAttributes)
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Completion
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields as Completion
import Temporal.Activity.Definition
import Temporal.Common
import Temporal.Coroutine
import qualified Temporal.Core.Worker as Core
import qualified Temporal.Core.Client as Core
import Temporal.Exception
import Temporal.Payload hiding (Payload)
import Temporal.Internal.JobPool (SomeAsync)
import Temporal.SearchAttributes
import System.Random 
  ( StdGen
  , genWord32R
  , genWord64R
  , genWord8
  , genWord16
  , genWord32
  , genWord64
  , genShortByteString
  )
import System.Random.Stateful (StatefulGen(..), RandomGenM(..), FrozenGen(..))
import qualified Temporal.Core.Client as C
import UnliftIO hiding (race)
import RequireCallStack
import Text.Printf
import Temporal.Core.Worker (completeWorkflowActivation)
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion as Core
import Data.Time.Clock.System (SystemTime)
import Temporal.Duration (Duration)
import Control.Category (Category)

data WorkerConfig activityEnv = WorkerConfig
  { deadlockTimeout :: Maybe Int
  , wfDefs :: HashMap Text WorkflowDefinition
  , actEnv :: activityEnv
  , actDefs :: HashMap Text (ActivityDefinition activityEnv)
  , coreConfig :: Core.WorkerConfig
  , interceptorConfig :: Interceptors
  }

data ActivityInboundInterceptor = ActivityInboundInterceptor { }

instance Semigroup ActivityInboundInterceptor where
  ActivityInboundInterceptor <> ActivityInboundInterceptor = ActivityInboundInterceptor

data ActivityOutboundInterceptor = ActivityOutboundInterceptor { }

instance Semigroup ActivityOutboundInterceptor where
  ActivityOutboundInterceptor <> ActivityOutboundInterceptor = ActivityOutboundInterceptor

data ExecuteWorkflowInput = ExecuteWorkflowInput
  { executeWorkflowInputType :: Text
  , executeWorkflowInputArgs :: Vector RawPayload
  , executeWorkflowInputHeaders :: Map Text RawPayload
  , executeWorkflowInputInfo :: Info
  }

data WorkflowInboundInterceptor = WorkflowInboundInterceptor 
  { executeWorkflow 
    :: ExecuteWorkflowInput 
    -> (ExecuteWorkflowInput -> IO (WorkflowExecution RawPayload))
    -> IO (WorkflowExecution RawPayload)
  }

instance Semigroup WorkflowInboundInterceptor where
  WorkflowInboundInterceptor a <> WorkflowInboundInterceptor b = WorkflowInboundInterceptor $ \input cont -> a input $ \input' -> b input' cont

data WorkflowOutboundInterceptor = WorkflowOutboundInterceptor { }

instance Semigroup WorkflowOutboundInterceptor where
  WorkflowOutboundInterceptor <> WorkflowOutboundInterceptor = WorkflowOutboundInterceptor

data Interceptors = Interceptors
  { workflowInboundInterceptors :: WorkflowInboundInterceptor
  , workflowOutboundInterceptors :: WorkflowOutboundInterceptor
  , activityInboundInterceptors :: ActivityInboundInterceptor
  , activityOutboundInterceptors :: ActivityOutboundInterceptor
  }

instance Semigroup Interceptors where
  Interceptors a b c d <> Interceptors a' b' c' d' = Interceptors (a <> a') (b <> b') (c <> c') (d <> d')


data Worker activityEnv = Worker
  { workerCore :: Core.Worker
  , workerTaskQueue :: Text
  , workerConfig :: WorkerConfig activityEnv
  , workerLogFn :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workerWorkflowState :: WorkflowWorker
  , workerActivityState :: ActivityWorker activityEnv
  }

newtype WorkerM activityEnv a = WorkerM { unWorkerM :: ReaderT (Worker activityEnv) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (Worker activityEnv), MonadUnliftIO)

instance MonadLogger (WorkerM activityEnv) where
  monadLoggerLog loc src level msg = do
    worker <- ask
    liftIO $ worker.workerLogFn loc src level (toLogStr msg)

instance MonadLoggerIO (WorkerM activityEnv) where
  askLoggerIO = do
    worker <- ask
    pure worker.workerLogFn

newtype Sequence = Sequence { rawSequence :: Word32 }
  deriving (Eq, Ord, Show, Enum, Num, Hashable)

type SequenceMap a = HashMap Sequence a

data Sequences = Sequences
  { externalCancel :: !Word32
  , childWorkflow :: !Word32
  , externalSignal :: !Word32
  , timer :: !Word32
  , activity :: !Word32
  , condition :: !Word32
  }

data ParentInfo = ParentInfo
  { parentNamespace :: Namespace
  , parentRunId :: RunId
  , parentWorkflowId :: WorkflowId
  }

-- TODO, update search attributes as workflow progresses
data Info = Info
  { historyLength :: {-# UNPACK #-} !Word32
  , attempt :: {-# UNPACK #-} !Int
  , continuedRunId :: Maybe RunId
  , cronSchedule :: Maybe Text
  , executionTimeout :: Maybe Duration
  , headers :: Map Text RawPayload
  , namespace :: Namespace
  , parent :: Maybe ParentInfo
  , rawMemo :: Map Text RawPayload
  , retryPolicy :: Maybe RetryPolicy
  , runId :: RunId
  , runTimeout :: Maybe Duration
  , searchAttributes :: Map Text SearchAttributeType
  , startTime :: SystemTime
  , taskQueue :: TaskQueue
  , taskTimeout :: Duration
  , workflowId :: WorkflowId
  , workflowType :: WorkflowType
  }


-- Newtyped because the list is reversed
newtype Reversed a = Reversed [a]
  deriving (Functor, Show, Eq)

fromReversed :: Reversed a -> [a]
fromReversed (Reversed xs) = reverse xs

push :: a -> Reversed a -> Reversed a
push x (Reversed xs) = Reversed (x:xs)

data SequenceMaps = SequenceMaps 
  { timers :: {-# UNPACK #-} !(SequenceMap (IVar ()))
  , activities :: {-# UNPACK #-} !(SequenceMap (IVar ResolveActivity))
  , childWorkflows :: {-# UNPACK #-} !(SequenceMap (SomeChildWorkflowHandle))
  , externalSignals :: {-# UNPACK #-} !(SequenceMap (IVar ResolveSignalExternalWorkflow))
  , externalCancels :: {-# UNPACK #-} !(SequenceMap (IVar ResolveRequestCancelExternalWorkflow))
  , conditionsAwaitingSignal :: {-# UNPACK #-} !(SequenceMap (IVar ()))
  }

data CancellationState
  = CancellationNotRequested
  | CancellationRequested
  | CancellationSignaledToWorkflow
  deriving (Show, Eq, Ord, Enum, Bounded)

data ExecutionState 
  = ExecutionNotStarted
  | SuspendedExecution (Await [ActivationResult] (SuspendableWorkflowExecution RawPayload))
  | CompletedExecution

data WorkflowInstance = WorkflowInstance
  { workflowInstanceInfo :: {-# UNPACK #-} !(IORef Info)
  , workflowInstanceDefinition :: WorkflowDefinition
  , workflowInstanceLogger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workflowRandomnessSeed :: WorkflowGenM
  , workflowNotifiedPatches :: {-# UNPACK #-} !(IORef (Set PatchId))
  , workflowMemoizedPatches :: {-# UNPACK #-} !(IORef (HashMap PatchId Bool))
  , workflowSequences :: {-# UNPACK #-} !(IORef Sequences)
  , workflowTime :: {-# UNPACK #-} !(IORef SystemTime)
  , workflowIsReplaying :: {-# UNPACK #-} !(IORef Bool)
  , workflowCommands :: {-# UNPACK #-} !(TVar (Reversed WorkflowCommand))
  , workflowSequenceMaps :: {-# UNPACK #-} !(TVar (SequenceMaps))
  , workflowSignalHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (Vector RawPayload -> IO ())))
  , workflowQueryHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (QueryId -> Vector RawPayload -> IO ())))
  , workflowCallStack :: {-# UNPACK #-} !(IORef CallStack)
  , workflowCompleteActivation :: !(Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  , workflowInstanceContinuationEnv :: {-# UNPACK #-} !(ContinuationEnv)
  , workflowCancellationVar :: {-# UNPACK #-} !(IVar ())
  , workflowDeadlockTimeout :: Maybe Int
  -- These are how the instance gets its work done
  , activationChannel :: Chan Core.WorkflowActivation
  , executionThread :: IORef (Async ())
  , currentWorkflowState :: IORef ExecutionState
  , interceptors :: Interceptors
  }

newtype InstanceM (a :: Type) = InstanceM { unInstanceM :: ReaderT WorkflowInstance IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader WorkflowInstance, MonadUnliftIO)

instance MonadLogger InstanceM where
  monadLoggerLog loc src lvl msg = do
    logger <- asks workflowInstanceLogger
    liftIO $ logger loc src lvl (toLogStr msg)

instance MonadLoggerIO InstanceM where
  askLoggerIO = asks workflowInstanceLogger

data WorkflowWorker = WorkflowWorker
  { workerWorkflowFunctions :: HashMap Text WorkflowDefinition
  , runningWorkflows :: TVar (HashMap RunId WorkflowInstance)
  , deadlockedWorkflows :: TVar (HashMap RunId SomeAsync)
  , workerClient :: C.Client
  }

{- |
A Signal is an asynchronous request to a Workflow Execution.

A Signal delivers data to a running Workflow Execution. It cannot return data to the caller; 
to do so, use a Query instead. The Workflow code that handles a Signal can mutate Workflow state. 
A Signal can be sent from a Temporal Client or a Workflow. 
When a Signal is sent, it is received by the Cluster and recorded as an Event to the Workflow Execution Event History. 
A successful response from the Cluster means that the Signal has been persisted and will be delivered at least once to 
the Workflow Execution.

A Signal must include a destination (Namespace and Workflow Id) and name. It can include a list of arguments.

Signal handlers are Workflow functions that listen for Signals by the Signal name. 
Signals are delivered in the order they are received by the Cluster. 
If multiple deliveries of a Signal would be a problem for your Workflow, add idempotency logic to your Signal handler 
that checks for duplicates.
-}
data WorkflowSignalDefinition = 
  forall codec f. (FunctionSupportsCodec codec (ArgsOf f) (ResultOf Workflow f), ResultOf Workflow f ~ ()) => 
  WorkflowSignalDefinition
    Text -- name
    codec
    f
    (f -> Vector RawPayload -> IO (Either String (Workflow ())))
  -- { workflowSignalName :: Text
  -- , workflowSignalHandler :: [Payload] -> IO ()
  -- }

-- | This is a Workflow function that can be called from the outside world.
--
-- You can create a definition via 'Temporal.Workflow.provideWorkflow'.
--
-- To make a worker use this definition, you must add it to the 'WorkerConfig' via 'Temporal.Workflow.addWorkflow'.
data WorkflowDefinition = WorkflowDefinition
  { workflowName :: Text
  , workflowRun :: ValidWorkflowFunction
  }

class HasWorkflowDefinition a where
  workflowDefinition :: a -> WorkflowDefinition

instance HasWorkflowDefinition WorkflowDefinition where
  workflowDefinition = id


data ValidWorkflowFunction = forall codec f. 
  ( f ~ (ArgsOf f :->: Workflow (ResultOf Workflow f))
  , FunctionSupportsCodec codec (ArgsOf f) (ResultOf Workflow f)
  , RequireCallStack
  ) => 
  ValidWorkflowFunction
    codec
    f
    (f -> Vector RawPayload -> Either String (Workflow (ResultOf Workflow f)))

data ActivityCancelReason
  = GoneFromServer
  -- ^ The activity no longer exists on the server (may already be completed or its workflow
  -- may be completed).
  | CancelRequested
  -- ^ The was explicitly cancelled.
  | Timeout
  -- ^ Activity timeout caused the activity to marked cancelled.
  | WorkerShutdown
  -- ^ The worker the activity is running is shutting down.
  | HeartbeatRecordFailuer
  -- ^ Failed to record heartbeat. This usually only happens if the payload converter fails.

class HasActivityDefinition a where
  type ActivityDefinitionEnv a :: Type
  activityDefinition :: a -> ActivityDefinition (ActivityDefinitionEnv a)

instance HasActivityDefinition (ActivityDefinition env) where
  type ActivityDefinitionEnv (ActivityDefinition env) = env
  activityDefinition = id

data ActivityDefinition env = ActivityDefinition
  { activityName :: Text
  , activityRun :: ValidActivityFunction env
  }


data ActivityWorker env = ActivityWorker
  { initialEnv :: env
  , definitions :: HashMap Text (ActivityDefinition env)
  , runningActivities :: TVar (HashMap TaskToken (Async ()))
  }


newtype WorkflowGenM = WorkflowGenM { unWorkflowGenM :: IORef StdGen }

instance StatefulGen WorkflowGenM Workflow where
  uniformWord32R r = applyWorkflowGen (genWord32R r)
  {-# INLINE uniformWord32R #-}
  uniformWord64R r = applyWorkflowGen (genWord64R r)
  {-# INLINE uniformWord64R #-}
  uniformWord8 = applyWorkflowGen genWord8
  {-# INLINE uniformWord8 #-}
  uniformWord16 = applyWorkflowGen genWord16
  {-# INLINE uniformWord16 #-}
  uniformWord32 = applyWorkflowGen genWord32
  {-# INLINE uniformWord32 #-}
  uniformWord64 = applyWorkflowGen genWord64
  {-# INLINE uniformWord64 #-}
  uniformShortByteString n = applyWorkflowGen (genShortByteString n)

applyWorkflowGen :: (StdGen -> (a, StdGen)) -> WorkflowGenM -> Workflow a
applyWorkflowGen f (WorkflowGenM ref) = Workflow $ \_ -> do
  g <- readIORef ref
  case f g of
    (!a, !g') -> Done a <$ writeIORef ref g'
{-# INLINE applyWorkflowGen #-}

newWorkflowGenM :: StdGen -> Workflow WorkflowGenM
newWorkflowGenM g = Workflow $ \_ -> (Done . WorkflowGenM) <$> newIORef g
{-# INLINE newWorkflowGenM #-}

instance RandomGenM WorkflowGenM StdGen Workflow where
  applyRandomGenM = applyWorkflowGen

instance FrozenGen StdGen Workflow where
  type MutableGen StdGen Workflow = WorkflowGenM
  freezeGen g = Workflow $ \_ -> Done <$> readIORef (unWorkflowGenM g)
  thawGen g = newWorkflowGenM g

-- -----------------------------------------------------------------------------
-- JobList

-- | A list of computations together with the IVar into which they
-- should put their result.
--
-- This could be an ordinary list, but the optimised representation
-- saves space and time.
--
data JobList
  = JobNil
  | forall a . 
    JobCons
      ContinuationEnv
      (Workflow a)
      {-# UNPACK #-} !(IVar a)
      JobList

appendJobList :: JobList -> JobList -> JobList
appendJobList JobNil c = c
appendJobList c JobNil = c
appendJobList (JobCons a b c d) e = JobCons a b c $! appendJobList d e

lengthJobList :: JobList -> Int
lengthJobList JobNil = 0
lengthJobList (JobCons _ _ _ j) = 1 + lengthJobList j

data IVarContents a
  = IVarFull (ResultVal a)
  | IVarEmpty JobList

-- | A synchronisation point. It either contains a value, or a list of computations waiting for the value.
newtype IVar a = IVar { ivarRef :: IORef (IVarContents a) }


-- | The contents of a full IVar.  We have to distinguish exceptions
-- thrown by the machinery of the library from those thrown in the
-- Workflow, so -- that when the result is fetched using getIVar, 
-- we can handle the exception in the right way.
data ResultVal a
  = Ok a
  -- Unrecoverable error in the temporal library that should crash the worker
  | ThrowInternal SomeException
  -- Error in the workflow that should be returned to the caller
  | ThrowWorkflow SomeException


-- -----------------------------------------------------------------------------
-- Cont

-- | A data representation of a Workflow continuation.  This is to avoid
-- repeatedly traversing a left-biased tree in a continuation, leading
-- O(n^2) complexity for some pathalogical cases.
--
-- See "A Smart View on Datatypes", Jaskelioff/Rivas, ICFP'15
data Cont a
  = Cont (Workflow a)
  | forall b. Cont b :>>= (b -> Workflow a)
  | forall b. (b -> a) :<$> (Cont b)
  | Return (IVar a)

toWf :: Cont a -> Workflow a
toWf (Cont wf) = wf
toWf (m :>>= k) = toWfBind m k
toWf (f :<$> x) = toWfFmap f x
toWf (Return i) = getIVar i

toWfBind :: Cont b -> (b -> Workflow a) -> Workflow a
toWfBind (m :>>= k) k2 = toWfBind m (k >=> k2)
toWfBind (Cont wf) k = wf >>= k
toWfBind (f :<$> x) k = toWfBind x (k . f)
toWfBind (Return i) k = getIVar i >>= k

toWfFmap :: (a -> b) -> Cont a -> Workflow b
toWfFmap f (m :>>= k) = toWfBind m (k >=> return . f)
toWfFmap f (Cont wf) = f <$> wf
toWfFmap f (g :<$> x) = toWfFmap (f . g) x
toWfFmap f (Return i) = f <$> getIVar i

-- -----------------------------------------------------------------------------
-- Result

-- | The result of a computation is either 'Done' with a value, 'Throw'
-- with an exception, or 'Blocked' on the result of a data fetch with
-- a continuation.
data Result a
  = Done a
  | Throw SomeException
  | forall b . Blocked
      {-# UNPACK #-} !(IVar b)
      (Cont a)
        -- ^ The 'IVar' is what we are blocked on; 'Cont' is the
        -- continuation.  This might be wrapped further if we're
        -- nested inside multiple '>>=', before finally being added
        -- to the 'IVar'.

instance (Show a) => Show (Result a) where
  show (Done a) = printf "Done(%s)" $ show a
  show (Throw e) = printf "Throw(%s)" $ show e
  show Blocked{} = "Blocked"

data ContinuationEnv = ContinuationEnv
  { runQueueRef :: {-# UNPACK #-} !(IORef JobList)
    -- ^ runnable computations. Things get added to here when we wake up
    -- a computation that was waiting for something.  When the list is
    -- empty, either we're finished, or we're waiting for some data fetch
    -- to return. 
  }

-- Bit of a hack. This needs to be called for each workflow activity in the official SDK
updateCallStack :: RequireCallStack => InstanceM ()
updateCallStack = do
  inst <- ask
  writeIORef inst.workflowCallStack $ popCallStack callStack

updateCallStackW :: RequireCallStack => Workflow ()
updateCallStackW = Workflow $ \_ -> do
  inst <- ask
  writeIORef inst.workflowCallStack $ popCallStack callStack
  pure $ Done ()

-- | Values that were blocking waiting for an activation, and have now
-- been unblocked.  The worker adds these to a queue ('activationResults') using
-- 'putResult'; the scheduler collects them from the queue and unblocks
-- the relevant computations.
data ActivationResult = forall a. ActivationResult
  (ResultVal a)
  !(IVar a)

-- | This function can be used to trace a bunch of lines to stdout when
-- debugging core.
trace_ :: String -> a -> a
trace_ _ = id
-- trace_ = Debug.Trace.trace

-- | The Workflow monad is a constrained execution environment that helps
-- developers write code that can be executed deterministically and reliably.
--
-- If a Workflow execution is interrupted, for example due to a server failure,
-- or otherwise fails to complete, the Temporal service will automatically
-- replay the Workflow execution up to the point of interruption with the same
-- inputs at each step in the function.
--
-- The 'st' state may be used to store information that is needed to respond to
-- any queries or signals that are received by the Workflow execution.
newtype Workflow a = Workflow { unWorkflow :: (ContinuationEnv -> InstanceM (Result a)) }

instance Functor Workflow where
  fmap f (Workflow m) = Workflow $ \env -> do
    r <- m env
    case r of
      Done a -> return (Done (f a))
      Throw e -> return (Throw e)
      Blocked ivar cont -> trace_ "fmap Blocked" $
        return (Blocked ivar (f :<$> cont))

instance Applicative Workflow where
  pure a = Workflow $ \_env -> return (Done a)
  Workflow ff <*> Workflow aa = Workflow $ \env -> do
    rf <- ff env
    case rf of
      Done f -> do
        ra <- aa env
        case ra of
          Done a -> trace_ "Done/Done" $ return (Done (f a))
          Throw e -> trace_ "Done/Throw" $ return (Throw e)
          Blocked ivar fcont -> trace_ "Done/Blocked" $
            return (Blocked ivar (f :<$> fcont))
      Throw e -> trace_ "Throw" $ return (Throw e)
      Blocked ivar1 fcont -> do
        ra <- aa env
        case ra of
          Done a -> trace_ "Blocked/Done" $
            return (Blocked ivar1 (($ a) :<$> fcont))
          Throw e -> trace_ "Blocked/Throw" $
            return (Blocked ivar1 (fcont :>>= (\_ -> throw e)))
          Blocked ivar2 acont -> trace_ "Blocked/Blocked" $
            blockedBlocked env ivar1 fcont ivar2 acont
            -- Note [Blocked/Blocked]

blockedBlocked
  :: ContinuationEnv
  -> IVar c
  -> Cont (a -> b)
  -> IVar d
  -> Cont a
  -> InstanceM (Result b)
blockedBlocked _ _ (Return i) ivar2 acont =
  return (Blocked ivar2 (acont :>>= getIVarApply i))
blockedBlocked _ _ (g :<$> Return i) ivar2 acont =
  return (Blocked ivar2 (acont :>>= \ a -> (\f -> g f a) <$> getIVar i))
blockedBlocked env ivar1 fcont ivar2 acont = do
  i <- newIVar
  addJob env (toWf fcont) i ivar1
  let cont = acont :>>= \a -> getIVarApply i a
  return (Blocked ivar2 cont)

-- Note [Blocked/Blocked]
--
-- This is the tricky case: we're blocked on both sides of the <*>.
-- We need to divide the computation into two pieces that may continue
-- independently when the resources they are blocked on become
-- available.  Moreover, the computation as a whole depends on the two
-- pieces.  It works like this:
--
--   ff <*> aa
--
-- becomes
--
--   (ff >>= putIVar i) <*> (a <- aa; f <- getIVar i; return (f a)
--
-- where the IVar i is a new synchronisation point.  If the right side
-- gets to the `getIVar` first, it will block until the left side has
-- called 'putIVar'.
--
-- We can also do it the other way around:
--
--   (do ff <- f; getIVar i; return (ff a)) <*> (a >>= putIVar i)

instance Monad Workflow where
  Workflow m >>= k = Workflow $ \env -> do
    e <- m env
    case e of
      Done a -> unWorkflow (k a) env
      Throw e -> return (Throw e)
      Blocked ivar cont -> trace_ ">>= Blocked" $
        return (Blocked ivar (cont :>>= k))
  -- A note on (>>):
  --
  -- Unlike Haxl, we can't use the the Applicative version here, because
  -- it prevents us from sleeping between two actions. We can use (*>) ourselves
  -- to opt into the Applicative version when we want to.


-- | If the first computation throws a value that implements 'SomeWorkflowException', 
-- try the second one.
instance Alternative Workflow where
  empty = throw AlternativeInstanceFailure
  (<|>) l r = l `Temporal.Worker.Types.catch` \(SomeWorkflowException e) -> r

instance {-# OVERLAPPABLE #-} MonadLogger Workflow where
  monadLoggerLog loc src lvl msg = Workflow $ \_ -> do
    logger <- asks workflowInstanceLogger
    fmap Done $ liftIO $ logger loc src lvl (toLogStr msg)

newIVar :: MonadIO m => m (IVar a)
newIVar = do
  ivarRef <- newIORef $ IVarEmpty JobNil
  pure IVar{..}

getIVar :: IVar a -> Workflow a
getIVar i@(IVar {ivarRef = !ref}) = Workflow $ \env -> do
  e <- readIORef ref
  case e of
    IVarFull (Ok a) -> pure $ Done a
    IVarFull (ThrowWorkflow e) -> liftIO $ raiseFromIVar env i e
    IVarFull (ThrowInternal e) -> throwIO e
    IVarEmpty _ -> pure $ Blocked i (Return i)

-- Just a specialised version of getIVar, for efficiency in <*>
getIVarApply :: IVar (a -> b) -> a -> Workflow b
getIVarApply i@IVar{ivarRef = !ref} a = Workflow $ \env -> do
  e <- readIORef ref
  case e of
    IVarFull (Ok f) -> return (Done (f a))
    IVarFull (ThrowWorkflow e) -> liftIO $ raiseFromIVar env i e
    IVarFull (ThrowInternal e) -> throwIO e
    IVarEmpty _ ->
      return (Blocked i (Cont (getIVarApply i a)))

putIVar :: IVar a -> ResultVal a -> ContinuationEnv -> IO ()
putIVar IVar{ivarRef = !ref} a ContinuationEnv{..} = do
  e <- readIORef ref
  case e of
    IVarEmpty jobs -> do
      writeIORef ref (IVarFull a)
      modifyIORef' runQueueRef (appendJobList jobs)
      -- An IVar is typically only meant to be written to once
      -- so it would make sense to throw an error here. But there
      -- are legitimate use-cases for writing several times.
    IVarFull{} -> return ()

tryReadIVar :: IVar a -> Workflow (Maybe a)
tryReadIVar i@IVar{ivarRef = !ref} = Workflow $ \env -> do
  e <- readIORef ref
  case e of
    IVarFull (Ok a) -> pure $ Done (Just a)
    IVarFull (ThrowWorkflow e) -> liftIO $ raiseFromIVar env i e
    IVarFull (ThrowInternal e) -> throwIO e
    IVarEmpty _ -> pure $ Done Nothing

raiseFromIVar :: Exception e => ContinuationEnv -> IVar a -> e -> IO (Result b)
raiseFromIVar env _ivar e = raiseImpl env (toException e)

{-# INLINE raiseImpl #-}
raiseImpl :: ContinuationEnv -> SomeException -> IO (Result b)
raiseImpl ContinuationEnv{..} e = return $ Throw e
  -- | testReportFlag ReportExceptionLabelStack $ report flags
  -- , Just (HaxlException Nothing h) <- fromException e = do
  --   let stk = NonEmpty.toList $ profLabelStack profCurrent
  --   return $ Throw $ toException $ HaxlException (Just stk) h
  -- | otherwise = return $ Throw e 

{-# INLINE addJob #-}
addJob :: ContinuationEnv -> Workflow b -> IVar b -> IVar a -> InstanceM ()
addJob env !wf !resultIVar IVar{ivarRef = !ref} =
  modifyIORef' ref $ \contents ->
    case contents of
      IVarEmpty list -> IVarEmpty (JobCons env wf resultIVar list)
      _ -> addJobPanic

addJobPanic :: forall a . a
addJobPanic = error "addJob: not empty"

flushCommands :: InstanceM ()
flushCommands = do
  inst <- ask
  info <- readIORef inst.workflowInstanceInfo
  cmds <- atomically $ do
    currentCmds <- readTVar inst.workflowCommands
    writeTVar inst.workflowCommands $ Reversed []
    pure currentCmds
  let completionSuccessful :: Core.Success
      completionSuccessful = defMessage & Completion.commands .~ fromReversed cmds
      completionMessage :: Core.WorkflowActivationCompletion
      completionMessage = defMessage
        & Completion.runId .~ rawRunId info.runId
        & Completion.successful .~ completionSuccessful
  $(logDebug) ("flushCommands: " <> T.pack (show completionMessage))
  res <- liftIO $ inst.workflowCompleteActivation completionMessage
  case res of
    Left err -> do
      $(logError) ("flushCommands: failed: " <> T.pack (show err))
      throwIO err
    Right () -> pure ()

instance Semigroup a => Semigroup (Workflow a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (Workflow a) where
  mempty = pure mempty

-- -----------------------------------------------------------------------------
-- Exceptions

-- | Throw an exception in the Workflow monad
throw :: Exception e => e -> Workflow a
throw e = Workflow $ \env -> liftIO $ raise env e

raise :: Exception e => ContinuationEnv -> e -> IO (Result a)
raise env e = raiseImpl env (toException e)

-- | Catch an exception in the Workflow monad
catch :: Exception e => Workflow a -> (e -> Workflow a) -> Workflow a
catch (Workflow m) h = Workflow $ \env -> do
  r <- m env
  case r of
    Done a -> pure $ Done a
    Throw e 
      | Just e' <- fromException e -> unWorkflow (h e') env
      | otherwise -> liftIO $ raise env e
    Blocked ivar k -> return $ Blocked ivar $ Cont $ Temporal.Worker.Types.catch (toWf k) h

-- | Catch exceptions that satisfy a predicate
catchIf
  :: Exception e => (e -> Bool) -> Workflow a -> (e -> Workflow a)
  -> Workflow a
catchIf cond m handler =
  Temporal.Worker.Types.catch m $ \e -> if cond e then handler e else throw e

-- | Returns @'Left' e@ if the computation throws an exception @e@, or
-- @'Right' a@ if it returns a result @a@.
try :: Exception e => Workflow a -> Workflow (Either e a)
try m = (Right <$> m) `Temporal.Worker.Types.catch` (return . Left)

instance Catch.MonadThrow Workflow where throwM = Temporal.Worker.Types.throw
instance Catch.MonadCatch Workflow where catch = Temporal.Worker.Types.catch

data ValidActivityFunction env = forall codec f. 
  ( f ~ (ArgsOf f :->: Activity env (ResultOf (Activity env) f))
  , FunctionSupportsCodec codec (ArgsOf f) (ResultOf (Activity env) f)
  ) => 
  ValidActivityFunction 
    codec 
    f
    (f -> Vector RawPayload -> Either String (Activity env (ResultOf (Activity env) f)))

runWorkerM :: Worker actEnv -> WorkerM actEnv a -> IO a
runWorkerM worker m = runReaderT (unWorkerM m) worker

nonEmptyString :: Text -> Maybe Text
nonEmptyString t = if T.null t then Nothing else Just t

data SomeChildWorkflowHandle = forall result. SomeChildWorkflowHandle (ChildWorkflowHandle result)

-- | A client side handle to a single child Workflow instance. 
--
-- It can be used to signal, wait for completion, and cancel the workflow.
data ChildWorkflowHandle result = forall codec. (Codec codec result) =>
  ChildWorkflowHandle
    { childWorkflowSequence :: Sequence
    , startHandle :: IVar ()
    , resultHandle :: IVar ResolveChildWorkflowExecution
    , childWorkflowCodec :: codec
    , childWorkflowId :: WorkflowId
    , firstExecutionRunId :: IVar RunId
    }


{- |
Queries are sent from a Temporal Client to a Workflow Execution. The API call is synchronous. The Query is identified at both ends by a Query name. The Workflow must have a Query handler that is developed to handle that Query and provide data that represents the state of the Workflow Execution.

Queries are strongly consistent and are guaranteed to return the most recent state. 
This means that the data reflects the state of all confirmed Events that came in before the Query was sent. 
An Event is considered confirmed if the call creating the Event returned success. 
Events that are created while the Query is outstanding may or may not be reflected in the Workflow state the Query result is based on.

A Query can carry arguments to specify the data it is requesting. And each Workflow can expose data to multiple types of Queries.

A Query must never mutate the state of the Workflow Execution—
that is, Queries are read-only and cannot contain any blocking code. 
This means, for example, that Query handling logic cannot schedule Activity Executions.

Sending Queries to completed Workflow Executions is supported, though Query reject conditions can be configured per Query
-}
data QueryDefinition (args :: [Type]) (result :: Type) = forall codec.
  (Codec codec result, ApplyPayloads codec args, GatherArgs codec args) =>
  QueryDefinition 
    { queryName :: Text
    , queryCodec :: codec 
    }

convertToProtoMemo :: Map Text RawPayload -> Memo
convertToProtoMemo m = defMessage & Message.fields .~ fmap convertToProtoPayload m

class FunctionHoist (args :: [Type]) where
  hoistFn :: (forall x. m x -> n x) -> Proxy args -> Proxy result -> (args :->: m result) -> (args :->: n result)

instance FunctionHoist '[] where
  hoistFn trans _ _ f = trans f

instance FunctionHoist args => FunctionHoist (a ': args) where
  hoistFn trans _ res f = \arg -> hoistFn trans (Proxy @args) res (f arg)

-- | A specalized version of 'hoist' that allows you to change the end result functor of a given function.
hoist 
  :: forall m n f. (f ~ ArgsOf f :->: m (ResultOf m f), FunctionHoist (ArgsOf f))
  => (forall x. m x -> n x) 
  -> f 
  -> (ArgsOf f :->: n (ResultOf m f))
hoist trans f = hoistFn trans (Proxy @(ArgsOf f)) (Proxy @(ResultOf m f)) f

type SuspendableWorkflowExecution a = Coroutine (Await [ActivationResult]) InstanceM a

newtype WorkflowExecution a = WorkflowExecution { unWorkflowExecution :: SuspendableWorkflowExecution a }
  deriving (Functor, Applicative, Monad, MonadIO)

coroutineHoist 
  :: forall f m n a. (Functor f, Monad m, Monad n) 
  => (forall b. m b -> n b) -> Coroutine f m a -> Coroutine f n a
coroutineHoist f routine = Coroutine 
  { resume = liftM go $ f $ resume routine
  }
  where 
    go (Right r) = Right r
    go (Left s) = Left (coroutineHoist f <$> s)

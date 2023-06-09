{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Worker.Types where
import Control.Applicative (liftA2, Alternative(..))
import Control.Concurrent.Async (Async)
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
import GHC.Stack (CallStack)
import Control.Concurrent.MVar (MVar)
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
import Temporal.Activity.Definition
import Temporal.Common
import Temporal.Exception
import Temporal.Payload hiding (Payload)
import Temporal.Internal.JobPool (SomeAsync)
import qualified Temporal.Core.Worker as Core
import System.Clock (TimeSpec)
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

data WorkerConfig workflowEnv activityEnv = WorkerConfig
  { deadlockTimeout :: Maybe Int
  , wfEnv :: workflowEnv
  , wfDefs :: HashMap Text (OpaqueWorkflow WorkflowDefinition workflowEnv)
  , actEnv :: activityEnv
  , actDefs :: HashMap Text (ActivityDefinition activityEnv)
  , coreConfig :: Core.WorkerConfig
  }

data Worker workflowEnv activityEnv = Worker
  { workerCore :: Core.Worker
  , workerTaskQueue :: Text
  , workerConfig :: WorkerConfig workflowEnv activityEnv
  , workerLogFn :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workerWorkflowState :: WorkflowWorker workflowEnv
  , workerActivityState :: ActivityWorker activityEnv
  }

newtype WorkerM workflowEnv activityEnv a = WorkerM { unWorkerM :: ReaderT (Worker workflowEnv activityEnv) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (Worker workflowEnv activityEnv), MonadUnliftIO)

instance MonadLogger (WorkerM workflowEnv activityEnv) where
  monadLoggerLog loc src level msg = do
    worker <- ask
    liftIO $ worker.workerLogFn loc src level (toLogStr msg)

instance MonadLoggerIO (WorkerM workflowEnv activityEnv) where
  askLoggerIO = do
    worker <- ask
    pure worker.workerLogFn

data OpaqueWorkflow f env = forall st. OpaqueWorkflow (f env st)

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
  , executionTimeout :: Maybe TimeSpec
  , headers :: HashMap Text Text
  , namespace :: Namespace
  , parent :: Maybe ParentInfo
  , rawMemo :: Map Text RawPayload
  , retryPolicy :: Maybe RetryPolicy
  , runId :: RunId
  , runTimeout :: Maybe TimeSpec
  , searchAttributes :: Map Text RawPayload
  , startTime :: TimeSpec -- Consider using UTCTime?
  , taskQueue :: TaskQueue
  , taskTimeout :: TimeSpec
  , workflowId :: WorkflowId
  , workflowType :: WorkflowType
  }


-- Newtyped because the list is reversed
newtype Reversed a = Reversed [a]
  deriving (Functor, Show)

fromReversed :: Reversed a -> [a]
fromReversed (Reversed xs) = reverse xs

push :: a -> Reversed a -> Reversed a
push x (Reversed xs) = Reversed (x:xs)

data WorkflowCommands 
  = FlushActivationCompletion (Reversed WorkflowCommand) -- Note: reversed. Needs to have finalizeCommandsForCompletion called on it.
  | RunningActivation (Reversed WorkflowCommand)
  deriving (Show)

data SequenceMaps env st = SequenceMaps 
  { timers :: {-# UNPACK #-} !(SequenceMap (IVar env st ()))
  , activities :: {-# UNPACK #-} !(SequenceMap (IVar env st ResolveActivity))
  , childWorkflows :: {-# UNPACK #-} !(SequenceMap (SomeChildWorkflowHandle env st))
  , externalSignals :: {-# UNPACK #-} !(SequenceMap (IVar env st ResolveSignalExternalWorkflow))
  , externalCancels :: {-# UNPACK #-} !(SequenceMap (IVar env st ResolveRequestCancelExternalWorkflow))
  , conditionsAwaitingSignal :: {-# UNPACK #-} !(SequenceMap (IVar env st ()))
  }

data WorkflowInstance env st = WorkflowInstance
  { workflowInstanceInfo :: {-# UNPACK #-} !(IORef Info)
  , workflowInstanceDefinition :: WorkflowDefinition env st
  , workflowInstanceLogger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workflowRandomnessSeed :: WorkflowGenM
  -- , workflowInstanceJobPool :: JobPool
  , workflowNotifiedPatches :: {-# UNPACK #-} !(IORef (Set PatchId))
  , workflowMemoizedPatches :: {-# UNPACK #-} !(IORef (HashMap PatchId Bool))
  , workflowSequences :: {-# UNPACK #-} !(IORef Sequences)
  , workflowTime :: {-# UNPACK #-} !(IORef TimeSpec)
  , workflowIsReplaying :: {-# UNPACK #-} !(IORef Bool)
  , workflowRunQueueRef :: {-# UNPACK #-} !(IORef (JobList env st))
  , workflowPrimaryTask :: {-# UNPACK #-} !(IORef (Maybe (Async ())))
  , workflowCompletions :: {-# UNPACK #-} !(TVar [CompleteReq env st])
  , workflowCommands :: {-# UNPACK #-} !(TVar WorkflowCommands)
  , workflowSequenceMaps :: {-# UNPACK #-} !(MVar (SequenceMaps env st))
  , workflowState :: {-# UNPACK #-} !(IORef st)
  , workflowEnv :: env
  , workflowSignalHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (Vector RawPayload -> IO ())))
  , workflowQueryHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (QueryId -> Vector RawPayload -> IO ())))
  , workflowCallStack :: {-# UNPACK #-} !(IORef CallStack)
  -- , externFunctions
  -- , disableEagerActivityExecution :: Bool
  }

newtype InstanceM (env :: *) (st :: *) (a :: *) = InstanceM { unInstanceM :: ReaderT (WorkflowInstance env st) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (WorkflowInstance env st), MonadUnliftIO)

instance MonadLogger (InstanceM env st) where
  monadLoggerLog loc src lvl msg = do
    logger <- asks workflowInstanceLogger
    liftIO $ logger loc src lvl (toLogStr msg)

instance MonadLoggerIO (InstanceM env st) where
  askLoggerIO = asks workflowInstanceLogger

data WorkflowWorker env = WorkflowWorker
  { workerWorkflowFunctions :: HashMap Text (OpaqueWorkflow WorkflowDefinition env)
  , runningWorkflows :: TMVar (HashMap RunId (OpaqueWorkflow WorkflowInstance env))
  , deadlockedWorkflows :: TVar (HashMap RunId SomeAsync)
  , workerEnv :: env
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
data WorkflowSignalDefinition env st = 
  forall codec f. (IsValidWorkflowFunction codec env st f, ResultOf (Workflow env st) f ~ ()) => 
  WorkflowSignalDefinition
    Text -- name
    codec
    f
    (f -> Vector RawPayload -> IO (Either String (Workflow env st ())))
  -- { workflowSignalName :: Text
  -- , workflowSignalHandler :: [Payload] -> IO ()
  -- }

-- | This is a Workflow function that can be called from the outside world.
--
-- You can create a definition via 'Temporal.Workflow.provideWorkflow'.
--
-- To make a worker use this definition, you must add it to the 'WorkerConfig' via 'Temporal.Workflow.addWorkflow'.
data WorkflowDefinition env st = WorkflowDefinition
  { workflowName :: Text
  , workflowInitialState :: st
  , workflowRun :: ValidWorkflowFunction env st
  }

-- | This constraint synonym ensures that a workflow function's arguments and result are serializable and use the correct monad.
type IsValidWorkflowFunction (codec :: *) (env :: *) (st :: *) f = 
  ( ApplyPayloads codec (ArgsOf f)
  , Codec codec (ResultOf (Workflow env st) f)
  , Typeable (ResultOf (Workflow env st) f)
  )

data ValidWorkflowFunction env st = forall codec f. (IsValidWorkflowFunction codec env st f) => 
  ValidWorkflowFunction
    codec
    f
    (f -> Vector RawPayload -> IO (Workflow env st (ResultOf (Workflow env st) f)))

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

data ActivityDefinition env = ActivityDefinition
  { activityName :: Text
  , activityRun :: ValidActivityFunction env
  }


data ActivityWorker env = ActivityWorker
  { initialEnv :: env
  , definitions :: HashMap Text (ActivityDefinition env)
  , runningActivities :: MVar (HashMap TaskToken (Async ()))
  }


newtype WorkflowGenM = WorkflowGenM { unWorkflowGenM :: IORef StdGen }

instance StatefulGen WorkflowGenM (Workflow env st) where
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

applyWorkflowGen :: (StdGen -> (a, StdGen)) -> WorkflowGenM -> Workflow env st a
applyWorkflowGen f (WorkflowGenM ref) = Workflow $ do
  g <- readIORef ref
  case f g of
    (!a, !g') -> Done a <$ writeIORef ref g'
{-# INLINE applyWorkflowGen #-}

newWorkflowGenM :: StdGen -> Workflow env st WorkflowGenM
newWorkflowGenM = Workflow . fmap (Done . WorkflowGenM) . newIORef
{-# INLINE newWorkflowGenM #-}

instance RandomGenM WorkflowGenM StdGen (Workflow env st) where
  applyRandomGenM = applyWorkflowGen

instance FrozenGen StdGen (Workflow env st) where
  type MutableGen StdGen (Workflow env st) = WorkflowGenM
  freezeGen = Workflow . fmap Done . readIORef . unWorkflowGenM
  thawGen g = newWorkflowGenM g

-- | A synchronisation point. It either contains a value, or a list of computations waiting for the value.
newtype IVar env st a = IVar { ivarRef :: IORef (IVarContents env st a) }


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

data IVarContents env st a
  = IVarFull (ResultVal a)
  | IVarEmpty (JobList env st)

{- |
A list of computations together with the IVar into which they should put their result.

This could be an ordinary list, but the optimised representation saves space and time.
-}
data JobList env st
  = JobNil
  | forall a. JobCons 
    {- (Context env) todo if MonadReader doesn't work we may need to propagate context here. -} 
    !(Workflow env st a) 
    !(IVar env st a)
    !(JobList env st)

-- | A resolved result from an activation, containing the result,
-- and the 'IVar' representing the blocked computations. Handling an
-- activation for blocked actions involves looking up the Sequence 
-- and adding these to a queue ('completions') using
-- 'putResult'; the scheduler collects them from the queue and unblocks
-- the relevant computations.
data CompleteReq env st
  = forall a. CompleteReq
      (ResultVal a)
      !(IVar env st a)

-- | The Workflow monad is a constrained execution environment that helps
-- developers write code that can be executed deterministically and reliably.
--
-- If a Workflow execution is interrupted, for example due to a server failure,
-- or otherwise fails to complete, the Temporal service will automatically
-- replay the Workflow execution up to the point of interruption with the same
-- inputs at each step in the function.
--
-- The Workflow monad also carries an app specific environment, 'env' and state 'st'.
--
-- The 'st' state may be used to store information that is needed to respond to
-- any queries or signals that are received by the Workflow execution.
newtype Workflow 
  env 
  st 
  a
  = Workflow { unWorkflow :: InstanceM env st (Result env st a) }

instance Functor (Workflow env st) where
  fmap f (Workflow m) = Workflow $ do
    r <- m
    case r of
      Done a -> pure $ Done $ f a
      Throw e -> pure $ Throw e
      Blocked ivar cont -> pure $ Blocked ivar (f :<$> cont)

instance Applicative (Workflow env st) where
  pure = Workflow . pure . Done
  Workflow ff <*> Workflow aa = Workflow $ do
    rf <- ff
    case rf of
      Done f -> do
        ra <- aa
        case ra of
          Done a -> pure $ Done $ f a
          Throw e -> pure $ Throw e
          Blocked ivar fcont -> pure $ Blocked ivar (f :<$> fcont)
      Throw e -> pure $ Throw e
      Blocked ivar fcont -> do
        ra <- aa
        case ra of
          Done a -> pure $ Blocked ivar (($ a) :<$> fcont)
          Throw e -> pure $ Blocked ivar (fcont :>>= (\_ -> throw e))
          Blocked ivar' acont -> blockedBlocked ivar fcont ivar' acont

blockedBlocked
  :: IVar env st c
  -> Cont env st (a -> b)
  -> IVar env st d
  -> Cont env st a
  -> InstanceM env st (Result env st b)
blockedBlocked _ (Return i) ivar2 acont =
  return (Blocked ivar2 (acont :>>= getIVarApply i))
blockedBlocked _ (g :<$> Return i) ivar2 acont =
  return (Blocked ivar2 (acont :>>= \ a -> (\f -> g f a) <$> getIVar i))
blockedBlocked ivar1 fcont ivar2 acont = do
  i <- newIVar
  addJob (toWorkflow fcont) i ivar1
  let cont = acont :>>= \a -> getIVarApply i a
  return (Blocked ivar2 cont)

-- | If the first computation throws a value that implements 'SomeWorkflowException', 
-- try the second one.
instance Alternative (Workflow env st) where
  empty = throw AlternativeInstanceFailure
  (<|>) l r = l `Temporal.Worker.Types.catch` \(SomeWorkflowException e) -> r
  
-- | Return the first complete result between two Workflow computations.
-- The first one to complete (left-biased) will return its result. 
-- If either branch throws an exception, the first encountered exception 
-- will be thrown.
--
-- Note that unchosen branch may or may not continue to execute in the 
-- background depending on where the computations on either branch block.
-- Therefore, you should not try to implement any cleanup or compensation
-- logic in branching Workflow computations.
race :: Workflow env st a -> Workflow env st a -> Workflow env st a
race (Workflow l) (Workflow r) = Workflow $ do
  rl <- l
  case rl of
    Done a -> pure $ Done a
    Throw e -> pure $ Throw e
    Blocked ivar cont -> do
      rr <- r
      case rr of
        Done a -> pure $ Done a
        Throw e -> pure $ Throw e
        Blocked ivar' cont' -> raceBlockedBlocked ivar cont ivar' cont'

--  Race [Blocked/Blocked]
--
-- This is the tricky case: we're blocked on both sides of the <|>.
-- We need to divide the computation into two pieces that may continue
-- independently when the resources they are blocked on become
-- available.
--
--   ll `race` rr
--
-- becomes
--
--   ((ll >>= putIVar i) *> (rr >>= putIVar i)) >>= \_ -> getIVar i
--
-- where the IVar i is a new synchronisation point. 
--
raceBlockedBlocked 
  :: IVar env st b
  -> Cont env st a
  -> IVar env st c
  -> Cont env st a
  -> InstanceM env st (Result env st a)
raceBlockedBlocked _ (Return i) _ _ = igetIVar i 
raceBlockedBlocked _ _ _ (Return i) = igetIVar i 
raceBlockedBlocked ivar1 lcont ivar2 rcont = do
  i <- newIVar
  addJob (toWorkflow lcont) i ivar1
  addJob (toWorkflow rcont) i ivar2
  let cont = Race lcont rcont
  return (Blocked i cont)

instance MonadLogger (Workflow env st) where
  monadLoggerLog loc src lvl msg = Workflow $ do
    logger <- asks workflowInstanceLogger
    liftIO $ logger loc src lvl (toLogStr msg)
    pure $ Done ()

newIVar :: MonadIO m => m (IVar env st a)
newIVar = do
  ivarRef <- newIORef (IVarEmpty JobNil)
  pure IVar{..}

{-# INLINE addJob #-}
addJob
  :: Workflow env st b 
  -> IVar env st b 
  -> IVar env st a 
  -> InstanceM env st ()
addJob !wf !resultIVar IVar{ivarRef = !ref} =
  modifyIORef' ref $ \contents ->
    case contents of
      IVarEmpty list -> IVarEmpty (JobCons wf resultIVar list)
      _ -> addJobPanic

addJobPanic :: forall a . a
addJobPanic = error "addJob: not empty"

-- Just a specialised version of getIVar, for efficiency in <*>
getIVarApply :: IVar env st (a -> b) -> a -> Workflow env st b
getIVarApply i@IVar{ivarRef = !ref} a = Workflow $ do
  e <- readIORef ref
  case e of
    IVarFull (Ok f) -> return (Done (f a))
    IVarFull (ThrowWorkflow e) -> raise e
    IVarFull (ThrowInternal e) -> throwIO e
    IVarEmpty _ ->
      return (Blocked i (Cont (getIVarApply i a)))

getIVar :: IVar env st a -> Workflow env st a
getIVar = Workflow . igetIVar

igetIVar :: IVar env st a -> InstanceM env st (Result env st a)
igetIVar i@IVar{ivarRef = !ref} = do
  e <- readIORef ref
  case e of
    IVarFull (Ok a) -> return (Done a)
    IVarFull (ThrowWorkflow e) -> raise e
    IVarFull (ThrowInternal e) -> throwIO e
    IVarEmpty _ -> return (Blocked i (Return i))

instance Monad (Workflow env st) where
  return = pure
  Workflow m >>= k = Workflow $ do
    r <- m
    case r of
      Done a -> unWorkflow (k a)
      Throw e -> pure $ Throw e
      Blocked ivar cont -> pure $ Blocked ivar (cont :>>= k)
  -- Unlike Haxl, we can't readily use parallel exploration of data fetches
  -- because we want to be able to block on things like tasks, workflows, etc.
  -- Maximum parallelism is an anti-goal.
  --
  -- TODO: we could probably use (>>=) to implement a fetch barrier for blocking
  -- operations instead of disabling the parallel fetching entirely
  -- (>>) = (*>)

instance MonadReader env (Workflow env st) where
  ask = Workflow (Done <$> asks workflowEnv)
  local f (Workflow m) = Workflow $ local (\inst -> inst { workflowEnv = f $ workflowEnv inst }) m

instance MonadState st (Workflow env st) where
  get = Workflow (fmap Done . readIORef . workflowState =<< ask)
  put st = Workflow $ do
    inst <- ask
    liftIO (writeIORef (workflowState inst) $! st)
    return $ Done ()
  state f = Workflow $ fmap Done $ do
    inst <- ask
    liftIO $ atomicModifyIORef' (workflowState inst) $ \st ->
      let (a, st') = f st
      in (st', a)

instance Semigroup a => Semigroup (Workflow env st a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (Workflow env st a) where
  mempty = pure mempty

-- | The result of a computation is either Done with a value, Throw with an exception, 
-- or Blocked while awaiting the result of a workflow or activity.
data Result env st a 
  = Done a
  | Throw SomeException
  | forall b. Blocked !(IVar env st b) (Cont env st a)


-- | A data representation of a Workflow continuation. 
-- This is to avoid repeatedly traversing a left-biased tree in a continuation, 
-- leading O(n^2) complexity for some pathalogical cases
--
-- -- See "A Smart View on Datatypes", Jaskelioff/Rivas, ICFP'15
data Cont env st a
  = Cont (Workflow env st a)
  | forall b. (Cont env st b) :>>= (b -> Workflow env st a)
  | forall b. (b -> a) :<$> (Cont env st b)
  | Race (Cont env st a) (Cont env st a)
  | Return (IVar env st a)

-- -----------------------------------------------------------------------------
-- Exceptions

-- | Throw an exception in the Workflow monad
throw :: Exception e => e -> Workflow env st a
throw = Workflow . raise

raise :: Exception e => e -> InstanceM env st (Result env st a)
raise e = raiseImpl (toException e)

{-# INLINE raiseImpl #-}
raiseImpl :: SomeException -> InstanceM env st (Result env st b)
raiseImpl e = case fromException e of
  Nothing -> pure $ Throw e
  Just (WorkflowException h) ->
    pure $ Throw $ toException $ WorkflowException h

-- | Catch an exception in the Workflow monad
catch :: Exception e => Workflow env st a -> (e -> Workflow env st a) -> Workflow env st a
catch (Workflow m) h = Workflow $ do
   r <- m
   case r of
     Done a    -> pure (Done a)
     Throw e | Just e' <- fromException e -> unWorkflow $ h e'
             | otherwise -> pure $ Throw e
     Blocked ivar k -> pure $ Blocked ivar (Cont (Temporal.Worker.Types.catch (toWorkflow k) h))

-- | Catch exceptions that satisfy a predicate
catchIf
  :: Exception e => (e -> Bool) -> Workflow env st a -> (e -> Workflow env st a)
  -> Workflow env st a
catchIf cond m handler =
  Temporal.Worker.Types.catch m $ \e -> if cond e then handler e else throw e

-- | Returns @'Left' e@ if the computation throws an exception @e@, or
-- @'Right' a@ if it returns a result @a@.
try :: Exception e => Workflow env st a -> Workflow env st (Either e a)
try m = (Right <$> m) `Temporal.Worker.Types.catch` (return . Left)

instance Catch.MonadThrow (Workflow env st) where throwM = Temporal.Worker.Types.throw
instance Catch.MonadCatch (Workflow env st) where catch = Temporal.Worker.Types.catch


toWorkflow :: Cont env st a -> Workflow env st a
toWorkflow (Cont wf) = wf
toWorkflow (m :>>= k) = toWorkflowBind m k
toWorkflow (f :<$> x) = toWorkflowFmap f x
toWorkflow (Race l r) = toWorkflow l `race` toWorkflow r
toWorkflow (Return i) = getIVar i

toWorkflowBind :: Cont env st b -> (b -> Workflow env st a) -> Workflow env st a
toWorkflowBind (m :>>= k) k2 = toWorkflowBind m (k >=> k2)
toWorkflowBind (Cont wf) k = wf >>= k
toWorkflowBind (f :<$> x) k = toWorkflowBind x (k . f)
toWorkflowBind (Race l r) k = toWorkflowBind l k `race` toWorkflowBind r k
toWorkflowBind (Return i) k = getIVar i >>= k

toWorkflowFmap :: (a -> b) -> Cont env st a -> Workflow env st b
toWorkflowFmap f (m :>>= k) = toWorkflowBind m (k >=> pure . f)
toWorkflowFmap f (Cont workflow) = f <$> workflow
toWorkflowFmap f (g :<$> x) = toWorkflowFmap (f . g) x
toWorkflowFmap f (Race l r) = toWorkflowFmap f l `race` toWorkflowFmap f r
toWorkflowFmap f (Return i) = f <$> getIVar i

type IsValidActivityFunction env codec f = 
    ( ApplyPayloads codec (ArgsOf f)
    , Codec codec (ResultOf (Activity env) f)
    )

data ValidActivityFunction env = forall codec f. (IsValidActivityFunction env codec f) => 
  ValidActivityFunction 
    codec 
    f
    (Vector RawPayload -> IO (Activity env (ResultOf (Activity env) f)))

runWorkerM :: Worker wfEnv actEnv -> WorkerM wfEnv actEnv a -> IO a
runWorkerM worker m = runReaderT (unWorkerM m) worker

nonEmptyString :: Text -> Maybe Text
nonEmptyString t = if T.null t then Nothing else Just t

data SomeChildWorkflowHandle env st = forall result. SomeChildWorkflowHandle (ChildWorkflowHandle env st result)

-- | A client side handle to a single child Workflow instance. 
--
-- It can be used to signal, wait for completion, and cancel the workflow.
data ChildWorkflowHandle env st result = forall codec. (Codec codec result) =>
  ChildWorkflowHandle
    { childWorkflowSequence :: Sequence
    , startHandle :: IVar env st ()
    , resultHandle :: IVar env st ResolveChildWorkflowExecution
    , childWorkflowCodec :: codec
    , childWorkflowId :: WorkflowId
    , firstExecutionRunId :: IVar env st RunId
    }

-- | Handle representing an external Workflow Execution.
--
-- This handle can only be cancelled and signalled. 
--
-- To call other methods, like query and result, use a WorkflowClient.getHandle inside an Activity.
data ExternalWorkflowHandle env st result = ExternalWorkflowHandle
  { externalWorkflowWorkflowId :: WorkflowId
  , externalWorkflowRunId :: Maybe RunId
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
  (Codec codec result, ApplyPayloads codec args) =>
  QueryDefinition 
    { queryName :: Text
    , queryCodec :: codec 
    }

convertToProtoMemo :: Map Text RawPayload -> Memo
convertToProtoMemo m = defMessage & Message.fields .~ fmap convertToProtoPayload m

convertToProtoSearchAttributes :: Map Text RawPayload -> SearchAttributes
convertToProtoSearchAttributes m = defMessage & Message.indexedFields .~ fmap convertToProtoPayload m

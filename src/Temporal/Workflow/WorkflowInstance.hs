{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Workflow.WorkflowInstance where
import Control.Applicative (liftA2)
import Control.Concurrent.Async (Async)
import Control.Concurrent.MVar (MVar)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Hashable (Hashable)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Int
import Data.IORef (IORef)
import Data.Proxy
import Data.ProtoLens
import Data.Set (Set)
import Data.Text (Text)
import Data.Vector (Vector)
import Data.Word
import Lens.Family2
import Temporal.Common
import Temporal.Payloads
import System.Clock
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
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
  ( WorkflowCommand
  , WorkflowCommand'Variant(..)
  , CompleteWorkflowExecution
  )
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
  ( WorkflowActivation
  , FireTimer
  , UpdateRandomSeed
  , QueryWorkflow
  , CancelWorkflow
  , StartWorkflow
  , SignalWorkflow
  , ResolveActivity
  , NotifyHasPatch
  , ResolveChildWorkflowExecutionStart
  , ResolveChildWorkflowExecution
  , ResolveSignalExternalWorkflow
  , ResolveRequestCancelExternalWorkflow
  , WorkflowActivationJob
  , WorkflowActivationJob'Variant(..)
  )
import UnliftIO hiding (catch)

data ParentInfo = ParentInfo
  { parentNamespace :: Namespace
  , parentRunId :: RunId
  , parentWorkflowId :: WorkflowId
  }

data RetryPolicy = RetryPolicy
  { initialInterval :: TimeSpec
  , backoffCoefficient :: Double
  , maximumInterval :: Maybe TimeSpec
  , maximumAttempts :: Int32
  , nonRetryableErrorTypes :: Vector Text
  }

retryPolicyToProto :: RetryPolicy -> Message.RetryPolicy
retryPolicyToProto (RetryPolicy initialInterval backoffCoefficient maximumInterval maximumAttempts nonRetryableErrorTypes) = 
  -- Using a full destructure here to make sure we don't miss any new fields later. ^
  defMessage
    & Message.initialInterval .~ timespecToDuration initialInterval
    & Message.backoffCoefficient .~ backoffCoefficient
    & Message.maybe'maximumInterval .~ fmap timespecToDuration maximumInterval
    & Message.maximumAttempts .~ maximumAttempts
    & Message.vec'nonRetryableErrorTypes .~ nonRetryableErrorTypes

newtype Sequence a = Sequence { rawSequence :: Word32 }
  deriving (Eq, Ord, Show, Enum, Num, Hashable)

type SequenceMap env a = HashMap (Sequence a) (IVar env a)

data Sequences = Sequences
  { externalCancel :: !Word32
  , childWorkflow :: !Word32
  , externalSignal :: !Word32
  , timer :: !Word32
  , activity :: !Word32
  }

data Info = Info
  { attempt :: Int
  , continuedRunId :: Maybe RunId
  , cronSchedule :: Maybe Text
  , executionTimeout :: Maybe TimeSpec
  , headers :: HashMap Text Text
  , namespace :: Namespace
  , parent :: Maybe ParentInfo
  -- , rawMemo
  , retryPolicy :: Maybe RetryPolicy
  , runId :: RunId
  , runTimeout :: Maybe TimeSpec
  -- , searchAttributes
  , startTime :: TimeSpec -- Consider using UTCTime?
  , taskQueue :: TaskQueue
  , taskTimeout :: TimeSpec
  , workflowId :: WorkflowId
  , workflowType :: WorkflowType
  }

data SequenceMaps env = SequenceMaps 
  { timers :: {-# UNPACK #-} !(SequenceMap env ())
  , activities :: {-# UNPACK #-} !(SequenceMap env ResolveActivity)
  , childWorkflows :: {-# UNPACK #-} !(SequenceMap env ResolveChildWorkflowExecutionStart)
  , externalSignals :: {-# UNPACK #-} !(SequenceMap env ResolveSignalExternalWorkflow)
  , externalCancels :: {-# UNPACK #-} !(SequenceMap env ResolveRequestCancelExternalWorkflow)
  }

emptySequences :: SequenceMaps env
emptySequences = SequenceMaps mempty mempty mempty mempty mempty

isEmpty :: SequenceMaps env -> Bool
isEmpty SequenceMaps{..} = 
  HashMap.null timers &&
  HashMap.null activities &&
  HashMap.null childWorkflows &&
  HashMap.null externalSignals &&
  HashMap.null externalCancels

data WorkflowCommands 
  = FlushActivationCompletion [WorkflowCommand] -- Note: reversed. Needs to have finalizeCommandsForCompletion called on it.
  | RunningActivation [WorkflowCommand]
  deriving (Show)

data WorkflowInstance env = WorkflowInstance
  { workflowInstanceInfo :: Info
  , workflowInstanceDefinition :: WorkflowDefinition env
  , workflowInstanceLogger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workflowRandomnessSeed :: WorkflowGenM
  -- , workflowInstanceJobPool :: JobPool
  , workflowNotifiedPatches :: {-# UNPACK #-} !(IORef (Set PatchId))
  , workflowMemoizedPatches :: {-# UNPACK #-} !(IORef (HashMap PatchId Bool))
  , workflowSequences :: {-# UNPACK #-} !(IORef Sequences)
  , workflowTime :: {-# UNPACK #-} !(IORef TimeSpec)
  , workflowIsReplaying :: {-# UNPACK #-} !(IORef Bool)
  , workflowRunQueueRef :: {-# UNPACK #-} !(IORef (JobList env))
  , workflowPrimaryTask :: {-# UNPACK #-} !(IORef (Maybe (Async ())))
  , workflowCompletions :: {-# UNPACK #-} !(TVar [CompleteReq env])
  , workflowCommands :: {-# UNPACK #-} !(TVar WorkflowCommands)
  , workflowSequenceMaps :: {-# UNPACK #-} !(MVar (SequenceMaps env))
  -- , externFunctions
  -- , disableEagerActivityExecution :: Bool
  }

data Context env = Context
  { contextNamespace :: Namespace
  -- , contextAppEnv :: env
  }

newtype InstanceM env a = InstanceM { unInstanceM :: ReaderT (WorkflowInstance env) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (WorkflowInstance env), MonadUnliftIO)

instance MonadLogger (InstanceM env) where
  monadLoggerLog loc src lvl msg = do
    logger <- asks workflowInstanceLogger
    liftIO $ logger loc src lvl (toLogStr msg)

instance MonadLoggerIO (InstanceM env) where
  askLoggerIO = asks workflowInstanceLogger


-- | A data representation of a Workflow continuation. 
-- This is to avoid repeatedly traversing a left-biased tree in a continuation, 
-- leading O(n^2) complexity for some pathalogical cases
--
-- -- See "A Smart View on Datatypes", Jaskelioff/Rivas, ICFP'15
data Cont env a
  = Cont (Workflow env a)
  | forall b. (Cont env b) :>>= (b -> Workflow env a)
  | forall b. (b -> a) :<$> (Cont env b)
  | Return (IVar env a)

toWorkflow :: Cont env a -> Workflow env a
toWorkflow (Cont wf) = wf
toWorkflow (m :>>= k) = toWorkflowBind m k
toWorkflow (f :<$> x) = toWorkflowFmap f x
toWorkflow (Return i) = getIVar i

toWorkflowBind :: Cont env b -> (b -> Workflow env a) -> Workflow env a
toWorkflowBind (m :>>= k) k2 = toWorkflowBind m (k >=> k2)
toWorkflowBind (Cont wf) k = wf >>= k
toWorkflowBind (f :<$> x) k = toWorkflowBind x (k . f)
toWorkflowBind (Return i) k = getIVar i >>= k

toWorkflowFmap :: (a -> b) -> Cont env a -> Workflow env b
toWorkflowFmap f (m :>>= k) = toWorkflowBind m (k >=> pure . f)
toWorkflowFmap f (Cont workflow) = f <$> workflow
toWorkflowFmap f (g :<$> x) = toWorkflowFmap (f . g) x
toWorkflowFmap f (Return i) = f <$> getIVar i

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

-- done :: ResultVal a -> InstanceM env (Result env a)
-- done (Ok a _) = return (Done a)
-- done (ThrowWorkflow e _) = raise e
-- done (ThrowInternal e) = throwIO e

-- eitherToResultThrowIO :: Either SomeException a -> ResultVal a
-- eitherToResultThrowIO (Right a) = Ok a NilWrites
-- eitherToResultThrowIO (Left e)
--   | Just HaxlException{} <- fromException e = ThrowHaxl e NilWrites
--   | otherwise = ThrowIO e

-- eitherToResult :: Either SomeException a -> ResultVal a
-- eitherToResult (Right a) = Ok a NilWrites
-- eitherToResult (Left e) = ThrowWorkflow e NilWrites

-- | A resolved result from an activation, containing the result,
-- and the 'IVar' representing the blocked computations. Handling an
-- activation for blocked actions involves looking up the Sequence 
-- and adding these to a queue ('completions') using
-- 'putResult'; the scheduler collects them from the queue and unblocks
-- the relevant computations.
data CompleteReq env
  = forall a. CompleteReq
      (ResultVal a)
      !(IVar env a)

-- | The result of a computation is either Done with a value, Throw with an exception, 
-- or Blocked while awaiting the result of a workflow or activity.
data Result env a 
  = Done a
  | Throw SomeException
  | forall b. Blocked !(IVar env b) (Cont env a)

-- -----------------------------------------------------------------------------
-- ResultVar

-- | A sink for the result of a data fetch in 'BlockedFetch'
newtype ResultVar a =
  ResultVar (Either SomeException a -> IO ())
  -- The Bool here is True if result was returned by a child thread,
  -- rather than the main runHaxl thread.  see Note [tracking allocation in
  -- child threads]

mkResultVar
  :: (Either SomeException a -> IO ())
  -> ResultVar a
mkResultVar = ResultVar

putFailure :: (Exception e) => ResultVar a -> e -> IO ()
putFailure r = putResult r . except

putSuccess :: ResultVar a -> a -> IO ()
putSuccess r = putResult r . Right

putResult :: ResultVar a -> Either SomeException a -> IO ()
putResult (ResultVar io) res = io res

except :: (Exception e) => e -> Either SomeException a
except = Left . toException

-- | A synchronisation point. It either contains a value, or a list of computations waiting for the value.
newtype IVar env a = IVar { ivarRef :: IORef (IVarContents env a) }

data IVarContents env a
  = IVarFull (ResultVal a)
  | IVarEmpty (JobList env)

newIVar :: InstanceM env (IVar env a)
newIVar = do
  ivarRef <- newIORef (IVarEmpty JobNil)
  return IVar{..}

newFullIVar :: ResultVal a -> InstanceM env (IVar env a)
newFullIVar r = do
  ivarRef <- newIORef (IVarFull r)
  return IVar{..}

getIVar :: IVar env a -> Workflow env a
getIVar i@IVar{ivarRef = !ref} = Workflow $ do
  e <- readIORef ref
  case e of
    IVarFull (Ok a) -> return (Done a)
    IVarFull (ThrowWorkflow e) -> raise e
    IVarFull (ThrowInternal e) -> throwIO e
    IVarEmpty _ -> return (Blocked i (Return i))

-- Just a specialised version of getIVar, for efficiency in <*>
getIVarApply :: IVar env (a -> b) -> a -> Workflow env b
getIVarApply i@IVar{ivarRef = !ref} a = Workflow $ do
  e <- readIORef ref
  case e of
    IVarFull (Ok f) -> return (Done (f a))
    IVarFull (ThrowWorkflow e) -> raise e
    IVarFull (ThrowInternal e) -> throwIO e
    IVarEmpty _ ->
      return (Blocked i (Cont (getIVarApply i a)))

putIVar :: IVar env a -> ResultVal a -> InstanceM env ()
putIVar IVar{ivarRef = !ref} a = do
  inst <- ask
  e <- readIORef ref
  case e of
    IVarEmpty jobs -> do
      writeIORef ref (IVarFull a)
      modifyIORef' inst.workflowRunQueueRef (appendJobList jobs)
      -- An IVar is typically only meant to be written to once
      -- so it would make sense to throw an error here. But there
      -- are legitimate use-cases for writing several times.
    IVarFull{} -> return ()

{-# INLINE addJob #-}
addJob :: Workflow env b -> IVar env b -> IVar env a -> InstanceM env ()
addJob !wf !resultIVar IVar{ivarRef = !ref} =
  modifyIORef' ref $ \contents ->
    case contents of
      IVarEmpty list -> IVarEmpty (JobCons wf resultIVar list)
      _ -> addJobPanic

addJobPanic :: forall a . a
addJobPanic = error "addJob: not empty"

{- |
A list of computations together with the IVar into which they should put their result.

This could be an ordinary list, but the optimised representation saves space and time.
-}
data JobList env
  = JobNil
  | forall a. JobCons 
    {- (Context env) todo if MonadReader doesn't work we may need to propagate context here. -} 
    !(Workflow env a) 
    !(IVar env a) 
    !(JobList env)

appendJobList :: JobList env -> JobList env -> JobList env
appendJobList JobNil c = c
appendJobList c JobNil = c
appendJobList (JobCons a b c) d = JobCons a b $! appendJobList c d 

lengthJobList :: JobList env -> Int
lengthJobList JobNil = 0
lengthJobList (JobCons _ _ j) = 1 + lengthJobList j


newtype Workflow env a = Workflow { unWorkflow :: ReaderT (Context env) (InstanceM env) (Result env a) }

instance Functor (Workflow env) where
  fmap f (Workflow m) = Workflow $ do
    r <- m
    case r of
      Done a -> pure $ Done $ f a
      Throw e -> pure $ Throw e
      Blocked ivar cont -> pure $ Blocked ivar (f :<$> cont)

blockedBlocked
  :: IVar env c
  -> Cont env (a -> b)
  -> IVar env d
  -> Cont env a
  -> InstanceM env (Result env b)
blockedBlocked _ (Return i) ivar2 acont =
  return (Blocked ivar2 (acont :>>= getIVarApply i))
blockedBlocked _ (g :<$> Return i) ivar2 acont =
  return (Blocked ivar2 (acont :>>= \ a -> (\f -> g f a) <$> getIVar i))
blockedBlocked ivar1 fcont ivar2 acont = do
  i <- newIVar
  addJob (toWorkflow fcont) i ivar1
  let cont = acont :>>= \a -> getIVarApply i a
  return (Blocked ivar2 cont)

-- Note on 'blockedBlocked'
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
instance Applicative (Workflow env) where
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
          Blocked ivar' acont -> lift $ blockedBlocked ivar fcont ivar' acont

instance Monad (Workflow env) where
  return = pure
  Workflow m >>= k = Workflow $ do
    r <- m
    case r of
      Done a -> unWorkflow (k a)
      Throw e -> pure $ Throw e
      Blocked ivar cont -> pure $ Blocked ivar (cont :>>= k)
  -- We really want the Applicative version of >>
  (>>) = (*>)

instance Semigroup a => Semigroup (Workflow env a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (Workflow env a) where
  mempty = pure mempty

-- -----------------------------------------------------------------------------
-- Exceptions

data WorkflowException = forall e. (Exception e) => WorkflowException e

instance Show WorkflowException where
  show (WorkflowException e) = show e
instance Exception WorkflowException

-- | Throw an exception in the Workflow monad
throw :: Exception e => e -> Workflow env a
throw = Workflow . raise

raise :: Exception e => e -> ReaderT (Context env) (InstanceM env) (Result env a)
raise e = raiseImpl (toException e)

{-# INLINE raiseImpl #-}
raiseImpl :: SomeException -> ReaderT (Context env) (InstanceM env) (Result env b)
raiseImpl e = case fromException e of
  Nothing -> pure $ Throw e
  Just (WorkflowException h) ->
    pure $ Throw $ toException $ WorkflowException h

-- | Catch an exception in the Haxl monad
catch :: Exception e => Workflow env a -> (e -> Workflow env a) -> Workflow env a
catch (Workflow m) h = Workflow $ do
   r <- m
   case r of
     Done a    -> pure (Done a)
     Throw e | Just e' <- fromException e -> unWorkflow $ h e'
             | otherwise -> pure $ Throw e
     Blocked ivar k -> pure $ Blocked ivar (Cont (catch (toWorkflow k) h))

-- | Catch exceptions that satisfy a predicate
catchIf
  :: Exception e => (e -> Bool) -> Workflow env a -> (e -> Workflow env a)
  -> Workflow env a
catchIf cond m handler =
  catch m $ \e -> if cond e then handler e else throw e

-- | Returns @'Left' e@ if the computation throws an exception @e@, or
-- @'Right' a@ if it returns a result @a@.
try :: Exception e => Workflow env a -> Workflow env (Either e a)
try m = (Right <$> m) `catch` (return . Left)

instance Catch.MonadThrow (Workflow env) where throwM = Temporal.Workflow.WorkflowInstance.throw
instance Catch.MonadCatch (Workflow env) where catch = Temporal.Workflow.WorkflowInstance.catch



newtype WorkflowGenM = WorkflowGenM { unWorkflowGenM :: IORef StdGen }

instance StatefulGen WorkflowGenM (Workflow env) where
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

applyWorkflowGen :: (StdGen -> (a, StdGen)) -> WorkflowGenM -> Workflow env a
applyWorkflowGen f (WorkflowGenM ref) = Workflow $ do
  g <- readIORef ref
  case f g of
    (!a, !g') -> Done a <$ writeIORef ref g'
{-# INLINE applyWorkflowGen #-}

newWorkflowGenM :: StdGen -> Workflow m WorkflowGenM
newWorkflowGenM = Workflow . fmap (Done . WorkflowGenM) . newIORef
{-# INLINE newWorkflowGenM #-}

instance RandomGenM WorkflowGenM StdGen (Workflow env) where
  applyRandomGenM = applyWorkflowGen

instance FrozenGen StdGen (Workflow env) where
  type MutableGen StdGen (Workflow env) = WorkflowGenM
  freezeGen = Workflow . fmap Done . readIORef . unWorkflowGenM
  thawGen g = newWorkflowGenM g

data LogicBugType = ReadingCompletionsFailedRun
  deriving (Show)

data LogicBug = LogicBug LogicBugType
  deriving (Show)

instance Exception LogicBug










data WorkflowSignalDefinition = WorkflowSignalDefinition
  -- { workflowSignalName :: Text
  -- , workflowSignalHandler :: [Payload] -> IO ()
  -- }

data WorkflowQueryDefinition = WorkflowQueryDefinition

data WorkflowDefinition env = WorkflowDefinition
  { workflowName :: Text
  , workflowSignals :: HashMap Text WorkflowSignalDefinition
  , workflowQueries :: HashMap Text WorkflowQueryDefinition
  , workflowRun :: SomeSerializableFunction env
  }

type ValidWorkflowFunction env fmt f = 
  ( ToPayloads fmt (ArgsOf f)
  , ApplyPayloads fmt f (Workflow env (ResultOf (Workflow env) f))
  , Codec fmt (ResultOf (Workflow env) f)
  )

-- TODO, I think we can avoid keeping the original function around and just use the serialized version
data SomeSerializableFunction env = 
  forall fmt f. (ValidWorkflowFunction env fmt f) => 
  SomeSerializableFunction 
    (Proxy fmt) 
    f
    (Proxy fmt -> f -> [RawPayload] -> Either String (Workflow env (ResultOf (Workflow env) f)))

data ActivityCancellationType = ActivityCancellationTryCancel | ActivityCancellationWaitCancellationCompleted | ActivityCancellationAbandon

activityCancellationTypeToProto :: ActivityCancellationType -> Command.ActivityCancellationType
activityCancellationTypeToProto ActivityCancellationTryCancel = Command.TRY_CANCEL
activityCancellationTypeToProto ActivityCancellationWaitCancellationCompleted = Command.WAIT_CANCELLATION_COMPLETED
activityCancellationTypeToProto ActivityCancellationAbandon = Command.ABANDON

data ChildWorkflowCancellationType 
  = ChildWorkflowCancellationAbandon 
  | ChildWorkflowCancellationTryCancel 
  | ChildWorkflowCancellationWaitCancellationCompleted 
  | ChildWorkflowCancellationWaitCancellationRequested

childWorkflowCancellationTypeToProto :: ChildWorkflowCancellationType -> ChildWorkflow.ChildWorkflowCancellationType
childWorkflowCancellationTypeToProto ChildWorkflowCancellationAbandon = ChildWorkflow.ABANDON
childWorkflowCancellationTypeToProto ChildWorkflowCancellationTryCancel = ChildWorkflow.TRY_CANCEL
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationCompleted = ChildWorkflow.WAIT_CANCELLATION_COMPLETED
childWorkflowCancellationTypeToProto ChildWorkflowCancellationWaitCancellationRequested = ChildWorkflow.WAIT_CANCELLATION_REQUESTED

data ParentClosePolicy 
  = ParentClosePolicyUnspecified 
  | ParentClosePolicyTerminate 
  | ParentClosePolicyAbandon 
  | ParentClosePolicyRequestCancel

parentClosePolicyToProto :: ParentClosePolicy -> ChildWorkflow.ParentClosePolicy
parentClosePolicyToProto ParentClosePolicyUnspecified = ChildWorkflow.PARENT_CLOSE_POLICY_UNSPECIFIED
parentClosePolicyToProto ParentClosePolicyTerminate = ChildWorkflow.PARENT_CLOSE_POLICY_TERMINATE
parentClosePolicyToProto ParentClosePolicyAbandon = ChildWorkflow.PARENT_CLOSE_POLICY_ABANDON
parentClosePolicyToProto ParentClosePolicyRequestCancel = ChildWorkflow.PARENT_CLOSE_POLICY_REQUEST_CANCEL

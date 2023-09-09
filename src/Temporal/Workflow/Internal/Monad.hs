{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# LANGUAGE TemplateHaskell #-}
module Temporal.Workflow.Internal.Monad where
import Control.Applicative
import Control.Exception (Exception, SomeException)
import qualified Control.Monad.Catch as Catch
import System.Random.Stateful (StdGen, StatefulGen(..), RandomGenM(..), FrozenGen(..))
import Temporal.Common
import Data.Text (Text)
import Temporal.Duration
import Temporal.Exception
import Temporal.Payload
import Data.ProtoLens
import Data.Map.Strict (Map)
import Data.Time.Clock.System (SystemTime)
import Temporal.SearchAttributes (SearchAttributeType)
import Data.Word (Word32)
import Data.Hashable
import Control.Concurrent.Async
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as Common
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (WorkflowCommand)
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Control.Concurrent.STM.TVar (TVar)
import Control.Monad.Logger
import Control.Concurrent (Chan)
import Lens.Family2
import qualified Temporal.Core.Worker as Core
import GHC.TypeLits
import GHC.Stack
import Data.Vector (Vector)
import Data.Set (Set)
import Data.Kind
import Control.Monad.Reader
import UnliftIO
import RequireCallStack
import Text.Printf
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
import Temporal.Workflow.Types
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
newtype Workflow a = Workflow { unWorkflow :: ContinuationEnv -> InstanceM (Result a) }

ilift :: RequireCallStack => InstanceM a -> Workflow a
ilift m = Workflow $ \_ -> Done <$> m

askInstance :: Workflow WorkflowInstance
askInstance = Workflow $ \_ -> asks Done

finishWorkflow :: RawPayload -> InstanceM ()
finishWorkflow result = do
  let completeMessage = defMessage &
        Command.completeWorkflowExecution .~ (defMessage & Command.result .~ convertToProtoPayload result)
  addCommand completeMessage

addCommand :: WorkflowCommand -> InstanceM ()
addCommand command = do
  inst <- ask
  atomically $ do
    modifyTVar' inst.workflowCommands $ \cmds -> push command cmds


-- | This function can be used to trace a bunch of lines to stdout when
-- debugging core.
trace_ :: String -> a -> a
trace_ _ = id
-- trace_ = Debug.Trace.trace

data ContinuationEnv = ContinuationEnv
  { runQueueRef :: {-# UNPACK #-} !(IORef JobList)
    -- ^ runnable computations. Things get added to here when we wake up
    -- a computation that was waiting for something.  When the list is
    -- empty, either we're finished, or we're waiting for some data fetch
    -- to return. 
  }

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
      Throw e' -> return (Throw e')
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
  (<|>) l r = l `Temporal.Workflow.Internal.Monad.catch` \(SomeWorkflowException _) -> r

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadIO Workflow where
  liftIO = error "Unreachable"

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadUnliftIO Workflow where
  withRunInIO _ = error "Unreachable"

instance {-# OVERLAPPABLE #-} MonadLogger Workflow where
  monadLoggerLog loc src lvl msg = Workflow $ \_ -> do
    logger <- asks workflowInstanceLogger
    fmap Done $ liftIO $ logger loc src lvl (toLogStr msg)

instance Semigroup a => Semigroup (Workflow a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (Workflow a) where
  mempty = pure mempty

-- -----------------------------------------------------------------------------
-- Exceptions

-- | Throw an exception in the Workflow monad
throw :: Exception e => e -> Workflow a
throw e = Workflow $ \env -> liftIO $ raise env e

{-# INLINE raiseImpl #-}
raiseImpl :: ContinuationEnv -> SomeException -> IO (Result b)
raiseImpl _ e = return $ Throw e

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
    Blocked ivar k -> return $ Blocked ivar $ Cont $ Temporal.Workflow.Internal.Monad.catch (toWf k) h

-- | Catch exceptions that satisfy a predicate
catchIf
  :: Exception e => (e -> Bool) -> Workflow a -> (e -> Workflow a)
  -> Workflow a
catchIf cond m handler =
  Temporal.Workflow.Internal.Monad.catch m $ \e -> if cond e then handler e else throw e

-- | Returns @'Left' e@ if the computation throws an exception @e@, or
-- @'Right' a@ if it returns a result @a@.
try :: Exception e => Workflow a -> Workflow (Either e a)
try m = (Right <$> m) `Temporal.Workflow.Internal.Monad.catch` (return . Left)

instance Catch.MonadThrow Workflow where throwM = Temporal.Workflow.Internal.Monad.throw
instance Catch.MonadCatch Workflow where catch = Temporal.Workflow.Internal.Monad.catch

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
  thawGen = newWorkflowGenM

{-# INLINE addJob #-}
addJob :: ContinuationEnv -> Workflow b -> IVar b -> IVar a -> InstanceM ()
addJob env !wf !resultIVar IVar{ivarRef = !ref} =
  modifyIORef' ref $ \case
    IVarEmpty list -> IVarEmpty (JobCons env wf resultIVar list)
    _ -> addJobPanic

addJobPanic :: forall a . a
addJobPanic = error "addJob: not empty"

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

instance (Show a) => Show (Result a) where
  show (Done a) = printf "Done(%s)" $ show a
  show (Throw e) = printf "Throw(%s)" $ show e
  show Blocked{} = "Blocked"

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

newIVar :: MonadIO m => m (IVar a)
newIVar = do
  ivarRef <- newIORef $ IVarEmpty JobNil
  pure IVar{..}

getIVar :: IVar a -> Workflow a
getIVar i@(IVar {ivarRef = !ref}) = Workflow $ \env -> do
  e <- readIORef ref
  case e of
    IVarFull (Ok a) -> pure $ Done a
    IVarFull (ThrowWorkflow e') -> liftIO $ raiseFromIVar env i e'
    IVarFull (ThrowInternal e') -> throwIO e'
    IVarEmpty _ -> pure $ Blocked i (Return i)

-- Just a specialised version of getIVar, for efficiency in <*>
getIVarApply :: IVar (a -> b) -> a -> Workflow b
getIVarApply i@IVar{ivarRef = !ref} a = Workflow $ \env -> do
  e <- readIORef ref
  case e of
    IVarFull (Ok f) -> return (Done (f a))
    IVarFull (ThrowWorkflow e') -> liftIO $ raiseFromIVar env i e'
    IVarFull (ThrowInternal e') -> throwIO e'
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
    IVarFull (ThrowWorkflow e') -> liftIO $ raiseFromIVar env i e'
    IVarFull (ThrowInternal e') -> throwIO e'
    IVarEmpty _ -> pure $ Done Nothing

raiseFromIVar :: Exception e => ContinuationEnv -> IVar a -> e -> IO (Result b)
raiseFromIVar env _ivar e = raiseImpl env (toException e)


newtype InstanceM (a :: Type) = InstanceM { unInstanceM :: ReaderT WorkflowInstance IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader WorkflowInstance, MonadUnliftIO)

instance MonadLogger InstanceM where
  monadLoggerLog loc src lvl msg = do
    logger <- asks workflowInstanceLogger
    liftIO $ logger loc src lvl (toLogStr msg)

instance MonadLoggerIO InstanceM where
  askLoggerIO = asks workflowInstanceLogger

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

data WorkflowInstance = WorkflowInstance
  { workflowInstanceInfo :: {-# UNPACK #-} !(IORef Info)
  , workflowInstanceLogger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workflowRandomnessSeed :: WorkflowGenM
  , workflowNotifiedPatches :: {-# UNPACK #-} !(IORef (Set PatchId))
  , workflowMemoizedPatches :: {-# UNPACK #-} !(IORef (HashMap PatchId Bool))
  , workflowSequences :: {-# UNPACK #-} !(IORef Sequences)
  , workflowTime :: {-# UNPACK #-} !(IORef SystemTime)
  , workflowIsReplaying :: {-# UNPACK #-} !(IORef Bool)
  , workflowCommands :: {-# UNPACK #-} !(TVar (Reversed WorkflowCommand))
  , workflowSequenceMaps :: {-# UNPACK #-} !(TVar SequenceMaps)
  , workflowSignalHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (Vector RawPayload -> Workflow ())))
  , workflowQueryHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (QueryId -> Vector RawPayload -> IO ())))
  , workflowCallStack :: {-# UNPACK #-} !(IORef CallStack)
  , workflowCompleteActivation :: !(Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  , workflowInstanceContinuationEnv :: {-# UNPACK #-} !ContinuationEnv
  , workflowCancellationVar :: {-# UNPACK #-} !(IVar ())
  , workflowDeadlockTimeout :: Maybe Int
  -- These are how the instance gets its work done
  , activationChannel :: Chan Core.WorkflowActivation
  , executionThread :: IORef (Async ())
  , inboundInterceptor :: WorkflowInboundInterceptor
  , outboundInterceptor :: WorkflowOutboundInterceptor
  }

data SomeChildWorkflowHandle = forall result. SomeChildWorkflowHandle (ChildWorkflowHandle result)

type SequenceMap a = HashMap Sequence a

data Sequences = Sequences
  { externalCancel :: !Word32
  , childWorkflow :: !Word32
  , externalSignal :: !Word32
  , timer :: !Word32
  , activity :: !Word32
  , condition :: !Word32
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
  , childWorkflows :: {-# UNPACK #-} !(SequenceMap SomeChildWorkflowHandle)
  , externalSignals :: {-# UNPACK #-} !(SequenceMap (IVar ResolveSignalExternalWorkflow))
  , externalCancels :: {-# UNPACK #-} !(SequenceMap (IVar ResolveRequestCancelExternalWorkflow))
  , conditionsAwaitingSignal :: {-# UNPACK #-} !(SequenceMap (IVar ()))
  }


-- | An async action handle that can be awaited or cancelled.
data Task a = Task
  { waitAction :: Workflow a
  , cancelAction :: Workflow ()
  }

instance Functor Task where
  fmap f (Task wait cancel) = Task (fmap f wait) cancel

instance Applicative Task where
  pure a = Task (pure a) (pure ())
  Task wait cancel <*> Task wait' cancel' = Task (wait <*> wait') (cancel *> cancel')

-- | Sometimes you want to alter the result of a task, but you 'Task' doesn't work as
-- a monad due to the 'cancel' action. This function lets you alter the result of a task
-- in the workflow monad.
bindTask :: Task a -> (a -> Workflow b) -> Task b
bindTask (Task wait cancel) f = Task (wait >>= f) cancel


-- | Handle representing an external Workflow Execution.
--
-- This handle can only be cancelled and signalled. 
--
-- To call other methods, like query and result, use a WorkflowClient.getHandle inside an Activity.
data ExternalWorkflowHandle (result :: Type) = ExternalWorkflowHandle
  { externalWorkflowWorkflowId :: WorkflowId
  , externalWorkflowRunId :: Maybe RunId
  }


-- | A client side handle to a single child Workflow instance. 
--
-- It can be used to signal, wait for completion, and cancel the workflow.
data ChildWorkflowHandle result = ChildWorkflowHandle
  { childWorkflowSequence :: Sequence
  , startHandle :: IVar ()
  , resultHandle :: IVar ResolveChildWorkflowExecution
  , childWorkflowResultConverter :: RawPayload -> IO result
  , childWorkflowId :: WorkflowId
  , firstExecutionRunId :: IVar RunId
  }

instance Functor ChildWorkflowHandle where
  fmap f h = h { childWorkflowResultConverter = \r -> f <$> childWorkflowResultConverter h r }

-- | This is only intended for use by interceptors. Normal workflow code should be able to use
-- the 'fmap' instance for simple transformations or else provide an appropriate codec.
interceptorConvertChildWorkflowHandle :: ChildWorkflowHandle a -> (a -> IO b) -> ChildWorkflowHandle b
interceptorConvertChildWorkflowHandle h f = h 
  { childWorkflowResultConverter = \r -> childWorkflowResultConverter h r >>= f
  }

data ExecuteWorkflowInput = ExecuteWorkflowInput
  { executeWorkflowInputType :: Text
  , executeWorkflowInputArgs :: Vector RawPayload
  , executeWorkflowInputHeaders :: Map Text RawPayload
  , executeWorkflowInputInfo :: Info
  }

data WorkflowExitVariant a
  = WorkflowExitContinuedAsNew WorkflowCommand
  | WorkflowExitCancelled WorkflowCommand
  | WorkflowExitFailed SomeException WorkflowCommand
  | WorkflowExitSuccess a

data WorkflowInboundInterceptor = WorkflowInboundInterceptor
  { executeWorkflow
    :: ExecuteWorkflowInput
    -> (ExecuteWorkflowInput -> IO (WorkflowExitVariant RawPayload))
    -> IO (WorkflowExitVariant RawPayload)
  }

instance Semigroup WorkflowInboundInterceptor where
  WorkflowInboundInterceptor a <> WorkflowInboundInterceptor b = WorkflowInboundInterceptor $ \input cont -> a input $ \input' -> b input' cont

data ActivityInput = ActivityInput
  { activityType :: Text
  , args :: Vector RawPayload
  , options :: StartActivityOptions
  , seq :: Sequence
  }

data WorkflowOutboundInterceptor = WorkflowOutboundInterceptor
  { scheduleActivity :: ActivityInput -> (ActivityInput -> IO (Task RawPayload)) -> IO (Task RawPayload)
  , startChildWorkflowExecution :: Text -> StartChildWorkflowOptions -> (Text -> StartChildWorkflowOptions -> IO (ChildWorkflowHandle RawPayload)) -> IO (ChildWorkflowHandle RawPayload)
  , continueAsNew :: forall a. Text -> ContinueAsNewOptions -> (Text -> ContinueAsNewOptions -> IO a) -> IO a
  }

instance Semigroup WorkflowOutboundInterceptor where
  l <> r = WorkflowOutboundInterceptor
    { scheduleActivity = \input cont -> scheduleActivity l input $ \input' -> scheduleActivity r input' cont
    , startChildWorkflowExecution = \t input cont -> startChildWorkflowExecution l t input $ \t' input' -> startChildWorkflowExecution r t' input' cont
    , continueAsNew = \n input cont -> continueAsNew l n input $ \n' input' -> continueAsNew r n' input' cont
    }

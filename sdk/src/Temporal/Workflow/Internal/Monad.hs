{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Temporal.Workflow.Internal.Monad where

import Control.Applicative
import Control.Concurrent.Async
import Control.Monad
import Control.Exception.Base (NoMatchingContinuationPrompt (..))
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Atomics (atomicModifyIORefCAS)
import Data.Foldable (for_)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.HashSet (HashSet)
import qualified Data.HashSet as HashSet
import Data.Kind
import Data.List.NonEmpty (NonEmpty (..))
import qualified Data.List.NonEmpty as NE
import Data.Map.Strict (Map)
import Data.Monoid (Endo (..))
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import Data.Vault.Strict
import Data.Vector (Vector)
import Data.Word (Word32, Word64)
import GHC.Stack
import GHC.TypeLits
import OpenTelemetry.Context (Context)
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (WorkflowCommand)
import RequireCallStack
import System.Random (
  genShortByteString,
  genWord16,
  genWord32,
  genWord32R,
  genWord64,
  genWord64R,
  genWord8,
 )
import System.Random.Stateful (FrozenGen (..), RandomGenM (..), StatefulGen (..), StdGen
#if MIN_VERSION_random(1,3,0)
                              , ThawedGen (..)
#endif
                              )
import Temporal.Common
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.Types
import Temporal.Workflow.Internal.DelimCC
import UnliftIO


{- | The Workflow monad is a constrained execution environment that helps
developers write code that can be executed deterministically and reliably.

If a Workflow execution is interrupted, for example due to a server failure,
or otherwise fails to complete, the Temporal service will automatically
replay the Workflow execution up to the point of interruption with the same
inputs at each step in the function.

The 'st' state may be used to store information that is needed to respond to
any queries or signals that are received by the Workflow execution.

Workflow code must be deterministic. This means:

- no threading
- no randomness
- no external calls to processes
- no network I/O
- no global state mutation
- no system date or time

This might seem like a lot of restrictions, but Temporal provides a number of
functions that allow you to use similar functionality in a deterministic way.

A critical aspect of developing Workflow Definitions is ensuring they exhibit certain deterministic traits –
that is, making sure that the same Commands are emitted in the same sequence,
whenever a corresponding Workflow Function Execution (instance of the Function Definition) is re-executed.
-}
newtype Workflow a = Workflow {unWorkflow :: FiberEnv -> InstanceM a}


ilift :: RequireCallStack => InstanceM a -> Workflow a
ilift m = Workflow $ const m


askInstance :: Workflow WorkflowInstance
askInstance = Workflow $ const ask


addCommand :: WorkflowCommand -> InstanceM ()
addCommand command = do
  inst <- ask
  atomically $ do
    modifyTVar' inst.workflowCommands $ \cmds -> push command cmds


{- | This function can be used to trace a bunch of lines to stdout when
debugging core.
-}
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


{- | Per-fiber execution context threaded through every 'Workflow' action.

'fiberContEnv' is the per-instance scheduling state shared by all fibers.
'fiberLocals' is shared between a fiber and any sub-fibers it runs inline
('parallelAp', 'Temporal.Workflow.biselectOpt').
'fiberSuspend' blocks the current fiber on an 'IVar' by capturing its
continuation up to the delimiter installed by 'runFiber'; sub-fibers get
their own delimiter and therefore their own suspend function.
-}
data FiberEnv = FiberEnv
  { fiberContEnv :: {-# UNPACK #-} !ContinuationEnv
  , fiberLocals :: !FiberLocals
  , fiberSuspend :: forall v. IVar v -> IO (ResultVal v)
  }


{- | Mutable state owned by one logical fiber (the main workflow, an injected
signal\/update handler job, or an internal job created by the concurrency
combinators).

The OpenTelemetry 'Context' slot gives each fiber its own view of the
thread-local context: the scheduler attaches it before every step and
snapshots it back at every suspension, so spans created while one fiber is
running never leak onto interleaved fibers or across activations.
'Nothing' means the fiber has not run yet and inherits the ambient context
of its first step.

'fiberIsDetachedHandler' marks fibers whose result IVar has no dependents
(injected signal\/update handler jobs): nothing ever reads their outcome, so
the scheduler logs their failures instead of letting them vanish silently.
-}
data FiberLocals = FiberLocals
  { fiberOtelContext :: {-# UNPACK #-} !(IORef (Maybe Context))
  , fiberIsDetachedHandler :: !Bool
  }


-- | Fiber-local state for a fiber whose result is consumed by another fiber
-- (or by 'Temporal.Workflow.Eval.runWorkflow' itself).
newFiberLocals :: MonadIO m => m FiberLocals
newFiberLocals = do
  ctx <- newIORef Nothing
  pure FiberLocals {fiberOtelContext = ctx, fiberIsDetachedHandler = False}


-- | Fiber-local state for a detached handler fiber (injected signal\/update
-- jobs): failures are logged by the scheduler since nothing awaits them.
newDetachedHandlerFiberLocals :: MonadIO m => m FiberLocals
newDetachedHandlerFiberLocals = do
  ctx <- newIORef Nothing
  pure FiberLocals {fiberOtelContext = ctx, fiberIsDetachedHandler = True}


{- | A workflow-level exception (raised by 'throw' or delivered through an
'IVar' as 'ThrowWorkflow'), as distinguished from exceptions thrown by the
SDK machinery itself. Only workflow-level exceptions are catchable by
'Temporal.Workflow.Internal.Monad.catch'.
-}
newtype WorkflowThrown = WorkflowThrown SomeException


instance Show WorkflowThrown where
  show (WorkflowThrown e) = "WorkflowThrown (" <> show e <> ")"


instance Exception WorkflowThrown


throwWorkflow :: MonadIO m => SomeException -> m a
throwWorkflow = liftIO . throwIO . WorkflowThrown


-- | Deliver the contents of a filled 'IVar' into the current fiber.
deliverResultVal :: MonadIO m => ResultVal a -> m a
deliverResultVal (Ok a) = pure a
deliverResultVal (ThrowWorkflow e) = throwWorkflow e
deliverResultVal (ThrowInternal e) = liftIO $ throwIO e


{- | A synthetic cancellation delivered to a fiber continuation that the
scheduler is about to drop (the losing side of a 'race'\/'biselectOpt').

It mirrors the async exception that 'Control.Concurrent.Async.cancel' throws
into a thread: it unwinds the loser through its 'bracket'\/'finally'
finalizers instead of abandoning them. Unlike a real async exception, it is
/not/ swallowed by 'Temporal.Workflow.Internal.Monad.catch', 'try', or
'Control.Applicative.<|>' (those rethrow it), so a catch-all handler in the
loser cannot accidentally resurrect a cancelled fiber; only the bracket
family ('generalBracket') observes it, runs its release, and re-raises.
-}
data WorkflowFiberCancelled = WorkflowFiberCancelled
  deriving stock (Show)


instance Exception WorkflowFiberCancelled


instance Functor Workflow where
  fmap f (Workflow m) = Workflow (fmap f . m)


instance Applicative Workflow where
  pure a = Workflow $ \_env -> pure a


  -- NB: deliberately the sequential version, because people get too
  -- confused about what's going on with the parallel one. Use
  -- 'ConcurrentWorkflow' to opt in to 'parallelAp'.
  ff <*> aa = ff >>= \f -> aa >>= \a -> pure (f a)

{- | Explore both sides of an applicative composition concurrently.

Each side runs as a sub-fiber (its own delimited continuation). If a side
suspends on an 'IVar', the other side still gets to run; when both suspend,
the function side is parked as an independent job in the scheduler (Note
[Blocked/Blocked]) and the argument side is adopted by the parent fiber.
-}
parallelAp :: Workflow (a -> b) -> Workflow a -> Workflow b
parallelAp ff aa = Workflow $ \env -> do
  sf <- runSubFiber env ff
  case sf of
    SubDone f -> do
      sa <- runSubFiber env aa
      case sa of
        SubDone a -> pure (f a)
        SubThrown e -> throwWorkflow e
        SubBlocked ivar k -> f <$> driveSubFiber env ivar k
    SubThrown e -> throwWorkflow e
    SubBlocked ivar1 kf -> do
      sa <- runSubFiber env aa
      case sa of
        SubDone a -> ($ a) <$> driveSubFiber env ivar1 kf
        SubThrown e -> do
          -- Match the historical semantics: let the blocked function side
          -- run to completion before rethrowing the argument side's error.
          _ <- driveSubFiber env ivar1 kf
          throwWorkflow e
        SubBlocked ivar2 ka -> do
          -- Note [Blocked/Blocked]
          i <- newIVar
          parkTask (fiberContEnv env) (fiberLocals env) (ResumeTask ivar1 kf) i ivar1
          a <- driveSubFiber env ivar2 ka
          f <- unWorkflow (getIVar i) env
          pure (f a)


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
-- where the IVar i is a new synchronisation point.  The suspended
-- function side is parked on the IVar it blocked on; when that fills,
-- the scheduler resumes it and its result lands in 'i'.  The parent
-- fiber adopts the argument side and finally reads 'i', blocking until
-- the function side has caught up.

instance Monad Workflow where
  Workflow m >>= k = Workflow $ \env -> do
    a <- m env
    unWorkflow (k a) env


-- A note on (>>):
--
-- Unlike Haxl, we can't use the the Applicative version here, because
-- it prevents us from sleeping between two actions. We can use (*>) ourselves
-- to opt into the Applicative version when we want to.

-- TODO If the first computation throws a value that implements 'SomeWorkflowException',
-- try the second one.
instance Alternative Workflow where
  empty = throw AlternativeInstanceFailure
  (<|>) l r = l `Temporal.Workflow.Internal.Monad.catch` \(SomeException _) -> r


instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadIO Workflow where
  liftIO = error "Unreachable"


instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadUnliftIO Workflow where
  withRunInIO _ = error "Unreachable"


instance {-# OVERLAPPABLE #-} MonadLogger Workflow where
  monadLoggerLog loc src lvl msg = Workflow $ \_ -> do
    logger <- asks workflowInstanceLogger
    liftIO $ logger loc src lvl (toLogStr msg)


instance Semigroup a => Semigroup (Workflow a) where
  (<>) = liftA2 (<>)


instance Monoid a => Monoid (Workflow a) where
  mempty = pure mempty


-- -----------------------------------------------------------------------------
-- Exceptions

-- | Throw an exception in the Workflow monad
throw :: (HasCallStack, Exception e) => e -> Workflow a
throw e = Workflow $ \_ -> throwWorkflow (toException e)


{- | Catch an exception in the Workflow monad.

Catches workflow-level exceptions ('throw', failed activities, etc.) as
well as synchronous exceptions of a matching type thrown by SDK-internal
code. Because the handler frames live on the fiber's captured continuation,
a 'catch' remains armed across suspension points: blocking in the middle of
the protected region and resuming on a later activation preserves it.
-}
catch :: Exception e => Workflow a -> (e -> Workflow a) -> Workflow a
catch (Workflow m) h = Workflow $ \env ->
  m env `UnliftIO.catch` \(se :: SomeException) ->
    case fromException se of
      Just (WorkflowThrown inner)
        -- A fiber cancellation ('WorkflowFiberCancelled') must never be
        -- swallowed by an ordinary handler, or a catch-all in a cancelled
        -- 'race' loser would resurrect it. Rethrow; only the bracket family
        -- ('generalBracket') observes it, to run finalizers.
        | Just WorkflowFiberCancelled <- fromException inner -> throwIO se
        | Just e <- fromException inner -> unWorkflow (h e) env
        | otherwise -> throwIO se
      Nothing
        | Just WorkflowFiberCancelled <- fromException se -> throwIO se
        | Just e <- fromException se -> unWorkflow (h e) env
        | otherwise -> throwIO se


-- | Catch exceptions that satisfy a predicate
catchIf
  :: Exception e
  => (e -> Bool)
  -> Workflow a
  -> (e -> Workflow a)
  -> Workflow a
catchIf cond m handler =
  Temporal.Workflow.Internal.Monad.catch m $ \e -> if cond e then handler e else throw e


{- | Returns @'Left' e@ if the computation throws an exception @e@, or
@'Right' a@ if it returns a result @a@.
-}
try :: Exception e => Workflow a -> Workflow (Either e a)
try m = (Right <$> m) `Temporal.Workflow.Internal.Monad.catch` (return . Left)


instance Catch.MonadThrow Workflow where throwM = Temporal.Workflow.Internal.Monad.throw


instance Catch.MonadCatch Workflow where catch = Temporal.Workflow.Internal.Monad.catch


-- | Build an 'Catch.ExitCaseException' from a caught exception, unwrapping
-- the internal 'WorkflowThrown' envelope so the release action observes the
-- exception the workflow actually raised.
exitCaseException :: SomeException -> Catch.ExitCase a
exitCaseException se = Catch.ExitCaseException $ case fromException se of
  Just (WorkflowThrown inner) -> inner
  _ -> se


{- | An intentionally UNLAWFUL 'Catch.MonadMask' instance for 'Workflow'.

A lawful 'MonadMask' is impossible here: async-exception masking state lives
in the thread-state object, not on the Haskell stack, so the
delimited-continuation primops ('control0#') that suspend and resume a fiber
neither capture nor restore it. A 'mask' therefore cannot span a suspension,
and we do not pretend otherwise.

The instance is nonetheless safe /in this monad/, because the sole thing a
lawful 'MonadMask' buys you is async-exception-safe handling of a leakable
resource — and 'Workflow' cannot allocate one. It has 'TypeError' instances
for 'MonadIO' and 'MonadUnliftIO' (below), so no arbitrary IO, and hence no
file handle, socket, or lock, can be acquired inside a workflow. The bracket
family is provided purely for /control-flow/ instrumentation (interceptor
spans, error reporting), where the semantics below are exactly what is
wanted. If you find yourself wanting these methods to guard a real resource,
you have gone wrong: acquire it in an activity instead.

Caveats, made explicit:

  * 'mask' and 'uninterruptibleMask' do NOT block async exceptions. The
    @restore@ argument is 'id'. Do not rely on them for atomicity. (A given
    workflow instance runs entirely on one dedicated GHC thread and its
    fibers are scheduled cooperatively, so there is no concurrent thread
    racing to deliver an async exception mid-region anyway.)

  * 'generalBracket' runs @release@ for 'Catch.ExitCaseSuccess' and
    'Catch.ExitCaseException', so @bracket@\/@finally@\/@onException@ close a
    span on both the returning and the throwing path, even across a
    suspension, since the handler frame rides the fiber's captured
    continuation. It catches at the IO level (not via the user-facing
    'catch'), so it observes and re-raises a 'WorkflowFiberCancelled' too:
    the SDK's own combinators never leave a continuation in the
    'Catch.ExitCaseAbort' state. When 'race'\/'biselectOpt' drops its losing
    side, 'cancelSubFiber' resumes that continuation with a
    'WorkflowFiberCancelled' (gated on 'sdkFlagRaceLoserCancellation' so it
    stays off when replaying histories recorded before the change), so the
    loser's finalizers run through the
    'Catch.ExitCaseException' path rather than being abandoned. A genuine
    'Catch.ExitCaseAbort' (a continuation neither resumed nor cancelled)
    would skip @release@, but nothing in the SDK produces one, and there is
    no resource to leak regardless.
-}
instance Catch.MonadMask Workflow where
  mask restoreToRunner = restoreToRunner id
  uninterruptibleMask restoreToRunner = restoreToRunner id
  generalBracket acquire release use = Workflow $ \env -> do
    resource <- unWorkflow acquire env
    -- Catch at the IO level rather than via the user-facing 'catch', so that
    -- @release@ runs for EVERY exit, including a 'WorkflowFiberCancelled'
    -- (which 'catch' deliberately refuses to swallow). The catch frame rides
    -- the fiber's captured continuation, so it stays armed across any
    -- suspension inside @use@. The original exception is re-raised verbatim
    -- (no 'WorkflowThrown' re-wrapping), preserving its identity for the
    -- fiber runner and any outer handler.
    result <-
      (Right <$> unWorkflow (use resource) env)
        `UnliftIO.catch` \(se :: SomeException) -> pure (Left se)
    case result of
      Left se -> do
        _ <- unWorkflow (release resource (exitCaseException se)) env
        throwIO se
      Right b -> do
        c <- unWorkflow (release resource (Catch.ExitCaseSuccess b)) env
        pure (b, c)


newtype WorkflowGenM = WorkflowGenM {unWorkflowGenM :: IORef StdGen}


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
    (!a, !g') -> a <$ writeIORef ref g'
{-# INLINE applyWorkflowGen #-}


newWorkflowGenM :: StdGen -> Workflow WorkflowGenM
newWorkflowGenM g = Workflow $ \_ -> WorkflowGenM <$> newIORef g
{-# INLINE newWorkflowGenM #-}


instance RandomGenM WorkflowGenM StdGen Workflow where
  applyRandomGenM = applyWorkflowGen


instance FrozenGen StdGen Workflow where
  type MutableGen StdGen Workflow = WorkflowGenM
  freezeGen g = Workflow $ \_ -> readIORef (unWorkflowGenM g)

#if MIN_VERSION_random(1,3,0)
instance ThawedGen StdGen Workflow where
#endif
  thawGen = newWorkflowGenM


{-# INLINE parkTask #-}


{- | Park a task on the IVar it is waiting for; when the IVar is filled,
'putIVar' moves it onto the run queue. If the IVar is already full, the task
goes straight onto the front of the run queue.
-}
parkTask :: ContinuationEnv -> FiberLocals -> FiberTask b -> IVar b -> IVar a -> InstanceM ()
parkTask env locals !task !resultIVar IVar {ivarRef = ref} =
  join $ liftIO $ atomicModifyIORefCAS ref $ \case
    IVarEmpty list -> (IVarEmpty (JobCons env locals task resultIVar list), pure ())
    full -> (full, modifyIORef' env.runQueueRef (JobCons env locals task resultIVar))


{- | Yield control back to the workflow scheduler, re-queueing the current
continuation behind everything that is currently runnable.

This is a purely local yield: it appends the continuation to the instance run
queue and returns control to the scheduler, emits __no__ command, writes
__no__ history, and never reaches the flush-and-suspend boundary, does not
round-trip to the server and is invisible to replay.
-}
yield :: Workflow ()
yield = Workflow $ \env -> do
  -- NOTE: We suspend the current fiber on a fresh, empty `IVar` so the
  -- scheduler parks its continuation in gate's waiting list, and we append a
  -- trivial "filler" job, targeting gate, to the back of the run queue.
  --
  -- Once the scheduler drains everything ahead of it, the filler runs, fills
  -- gate, and the parked continuation is re-queued and resumed.
  --
  -- Keeping a job on the run queue for the duration of the yield is what prevents
  -- the scheduler from flushing commands and suspending.
  --
  -- The gate is intentionally untracked so this momentary block does not show
  -- up in __stack_trace queries.
  gate <- newIVar
  let cenv = fiberContEnv env
  liftIO $ modifyIORef' cenv.runQueueRef $ \j ->
    appendJobList j (JobCons cenv (fiberLocals env) (FreshTask (pure ())) gate JobNil)
  _ <- liftIO $ fiberSuspend env gate
  pure ()


-- -----------------------------------------------------------------------------
-- Fibers

{- | The status of a fiber after running it as far as it can go: either it
produced a result, or it suspended waiting on an 'IVar'.

A suspended fiber is a first-class continuation captured with 'control0'
(see 'suspendVia'); resuming it delivers the 'ResultVal' of the 'IVar' it
was blocked on and runs the fiber to its next suspension point (or to
completion). The continuation re-installs its own 'prompt', so a resumed
fiber may suspend again. Each continuation must be resumed at most once.
-}
data Status a
  = SDone a
  | forall v. SBlocked {-# UNPACK #-} !(IVar v) (ResultVal v -> IO (Status a))


{- | Like 'Status', but for sub-fibers run inside another fiber
('parallelAp', 'Temporal.Workflow.biselectOpt'): workflow-level exceptions
('WorkflowThrown') are reified so the caller can sequence other work before
propagating them. Internal exceptions still propagate natively.
-}
data SubStatus a
  = SubDone a
  | SubThrown SomeException
  | forall v. SubBlocked {-# UNPACK #-} !(IVar v) (ResultVal v -> IO (Status a))


-- | A schedulable unit of work: a fiber not yet started, or a suspended one.
data FiberTask a
  = FreshTask (Workflow a)
  | forall v. ResumeTask {-# UNPACK #-} !(IVar v) (ResultVal v -> IO (Status a))


{- | A list of fibers together with the IVar into which they
should put their result.

This could be an ordinary list, but the optimised representation
saves space and time.
-}
data JobList
  = JobNil
  | forall a.
    JobCons
      ContinuationEnv
      !FiberLocals
      !(FiberTask a)
      {-# UNPACK #-} !(IVar a)
      JobList


appendJobList :: JobList -> JobList -> JobList
appendJobList JobNil c = c
appendJobList c JobNil = c
appendJobList (JobCons a b c d e) f = JobCons a b c d $! appendJobList e f


lengthJobList :: JobList -> Int
lengthJobList JobNil = 0
lengthJobList (JobCons _ _ _ _ j) = 1 + lengthJobList j


-- | Run a workflow from the start as a fiber, delimited by a fresh prompt.
runFiber :: ContinuationEnv -> FiberLocals -> Workflow a -> InstanceM (Status a)
runFiber cenv locals (Workflow f) = do
  inst <- ask
  liftIO $ do
    tag <- newPromptTag
    let env = FiberEnv cenv locals (suspendVia tag)
    prompt tag (SDone <$> runReaderT (unInstanceM (f env)) inst)


{- | Block the current fiber on an 'IVar': capture the continuation up to the
fiber's delimiter and return it to whoever ran the fiber as an 'SBlocked'.
The captured continuation is resumed with the contents of the 'IVar' once it
has been filled.

Two failure modes are turned into precise errors here:

* Blocking outside a fiber (no delimiter on the stack) — e.g. running a
  blocking 'Workflow' action from inside 'performUnsafeNonDeterministicIO',
  from an interceptor's IO continuation on a foreign thread, or from an STM
  transaction — raises 'NoMatchingContinuationPrompt', which we rethrow as a
  'RuntimeError' explaining the misuse.
* A captured continuation is strictly one-shot; resuming it twice would
  silently reuse a stack segment. A guard turns any accidental double
  resumption (a scheduler invariant violation) into a loud 'RuntimeError'.
-}
suspendVia :: PromptTag (Status a) -> IVar v -> IO (ResultVal v)
suspendVia tag ivar = do
  resumed <- newIORef False
  control0
    tag
    ( \k -> pure $ SBlocked ivar $ \rv -> do
        alreadyResumed <- atomicModifyIORefCAS resumed (\r -> (True, r))
        when alreadyResumed $
          throwIO $
            RuntimeError "Internal invariant violation: a suspended workflow fiber was resumed more than once. Please report this as a bug in hs-temporal-sdk."
        prompt tag (k (pure rv))
    )
    `UnliftIO.catch` \NoMatchingContinuationPrompt ->
      throwIO $
        RuntimeError "A blocking Workflow operation was used outside the workflow scheduler. This usually means a blocking action (executeActivity, sleep, getIVar, waitCondition, ...) was run from inside performUnsafeNonDeterministicIO, from an interceptor's IO continuation on another thread, or from within an STM transaction. Blocking Workflow operations may only run on the workflow's own fiber."


{- | Run a schedulable task: start a fresh fiber, or resume a suspended one
with the now-available contents of the IVar it was blocked on.
-}
runFiberTask :: ContinuationEnv -> FiberLocals -> FiberTask a -> InstanceM (Status a)
runFiberTask cenv locals (FreshTask wf) = runFiber cenv locals wf
runFiberTask _ _ (ResumeTask ivar k) = do
  contents <- readIORef (ivarRef ivar)
  case contents of
    IVarFull rv -> liftIO $ k rv
    -- Spurious wakeup (should not happen: tasks are only moved to the run
    -- queue when their IVar is filled); simply park again.
    IVarEmpty _ -> pure (SBlocked ivar k)


subStatus :: Status a -> SubStatus a
subStatus (SDone a) = SubDone a
subStatus (SBlocked i k) = SubBlocked i k


{- | Run a workflow as a sub-fiber of the current fiber, reifying
workflow-level exceptions.
-}
runSubFiber :: FiberEnv -> Workflow a -> InstanceM (SubStatus a)
runSubFiber env wf =
  (subStatus <$> runFiber (fiberContEnv env) (fiberLocals env) wf)
    `UnliftIO.catch` \(WorkflowThrown e) -> pure (SubThrown e)


-- | Resume a suspended sub-fiber with the contents of the IVar it blocked on.
resumeSubFiber :: (ResultVal v -> IO (Status a)) -> ResultVal v -> InstanceM (SubStatus a)
resumeSubFiber k rv =
  liftIO $ (subStatus <$> k rv) `UnliftIO.catch` \(WorkflowThrown e) -> pure (SubThrown e)


{- | Step a possibly-suspended sub-fiber: resume it only if the IVar it is
blocked on has been filled in the meantime; otherwise leave it suspended.
-}
stepSubFiber :: IVar v -> (ResultVal v -> IO (Status a)) -> InstanceM (SubStatus a)
stepSubFiber ivar k = do
  contents <- readIORef (ivarRef ivar)
  case contents of
    IVarFull rv -> resumeSubFiber k rv
    IVarEmpty _ -> pure (SubBlocked ivar k)


{- | Adopt a suspended sub-fiber: block the parent fiber on the same IVars
the sub-fiber blocks on until the sub-fiber completes.
-}
driveSubFiber :: forall a v0. FiberEnv -> IVar v0 -> (ResultVal v0 -> IO (Status a)) -> InstanceM a
driveSubFiber env = go
  where
    go :: IVar v -> (ResultVal v -> IO (Status a)) -> InstanceM a
    go ivar k = do
      rv <- liftIO $ fiberSuspend env ivar
      st <- resumeSubFiber k rv
      case st of
        SubDone a -> pure a
        SubThrown e -> throwWorkflow e
        SubBlocked ivar' k' -> go ivar' k'


{- | Cancel a fiber continuation that the scheduler is about to drop (the
losing side of a 'race'\/'biselectOpt'). Instead of silently discarding it,
resume it once with a synthetic 'WorkflowFiberCancelled' so its
'bracket'\/'finally' finalizers run, mirroring how
'Control.Concurrent.Async.cancel' delivers an async exception to a thread.

The loser's result (or the re-raised cancellation) is discarded. If a
finalizer itself suspends, it is driven to completion, so 'race' does not
return until the loser has finished unwinding (matching
'Control.Concurrent.Async.race', which waits on the cancelled loser). Each
continuation is still resumed at most once. A workflow-level exception
escaping the loser is swallowed (it belongs to a computation whose result is
being thrown away); an internal machinery exception still propagates, as it
must.
-}
cancelSubFiber :: forall a v. FiberEnv -> IVar v -> (ResultVal v -> IO (Status a)) -> InstanceM ()
cancelSubFiber env = go True
  where
    go :: forall w. Bool -> IVar w -> (ResultVal w -> IO (Status a)) -> InstanceM ()
    go firstResume ivar k = do
      rv <-
        if firstResume
          then pure (ThrowWorkflow (toException WorkflowFiberCancelled))
          else liftIO $ fiberSuspend env ivar
      next <-
        liftIO $
          (Just <$> k rv) `UnliftIO.catch` \(WorkflowThrown _) -> pure Nothing
      case next of
        Nothing -> pure ()
        Just (SDone _) -> pure ()
        Just (SBlocked ivar' k') -> go False ivar' k'


{- | A Temporal SDK internal flag: a small, permanent per-SDK id that gates a
replay-unsafe behaviour change.

The mechanism (shared with the TypeScript\/Python\/Go SDKs): a flag is either
recorded as used in a workflow's history or not. On a live task 'tryUseSdkFlag'
turns the behaviour on and records the id; on replay it returns whether the id
was present in the history up to the current task. So a behaviour introduced
behind a flag is used by new executions yet stays off when replaying a history
recorded before the flag existed, keeping replay deterministic. Ids are chosen
per-SDK starting at 1, never reused or renumbered.
-}
newtype SdkFlag = SdkFlag {sdkFlagId :: Word32}
  deriving stock (Eq, Ord, Show)


{- | Gate: run finalizers on a dropped @race@\/@biselect@ loser by resuming it
with a synthetic 'WorkflowFiberCancelled'. Off for histories recorded before
this flag, which drop losers silently (see 'cancelSubFiber').
-}
sdkFlagRaceLoserCancellation :: SdkFlag
sdkFlagRaceLoserCancellation = SdkFlag 1


{- | Check whether an 'SdkFlag'-gated behaviour is enabled for the current
workflow task, recording the flag as used when running live.

  * If the id is already known (advertised by core from history, or used
    earlier this run), return 'True'.
  * Otherwise, if this is NOT a replay, mark the flag used (so it is echoed in
    the completion's @used_internal_flags@ and lands in history) and return
    'True'.
  * Otherwise (replaying a history without the flag) return 'False'.

This is the default-on variant (live executions always adopt the new
behaviour); it MUST be called at the same logical point on replay as live.
-}
tryUseSdkFlag :: SdkFlag -> InstanceM Bool
tryUseSdkFlag (SdkFlag fid) = do
  inst <- ask
  known <- readIORef inst.workflowKnownFlags
  if fid `HashSet.member` known
    then pure True
    else do
      replaying <- readIORef inst.workflowIsReplaying
      if replaying
        then pure False
        else do
          modifyIORef' inst.workflowKnownFlags (HashSet.insert fid)
          pure True


data IVarContents a
  = IVarFull (ResultVal a)
  | IVarEmpty JobList


{- | A synchronisation point. It either contains a value, or a list of
computations waiting for the value.

When 'ivarId' is non-zero, the runtime tracks the call stack at the
point this IVar blocks so that @__stack_trace@ and
@__enhanced_stack_trace@ queries can report concurrent stacks.
-}
data IVar a = IVar
  { ivarId :: {-# UNPACK #-} !Word64
  , ivarRef :: {-# UNPACK #-} !(IORef (IVarContents a))
  }


{- | The contents of a full IVar.  We have to distinguish exceptions
thrown by the machinery of the library from those thrown in the
Workflow, so -- that when the result is fetched using getIVar,
we can handle the exception in the right way.
-}
data ResultVal a
  = Ok a
  | -- Unrecoverable error in the temporal library that should crash the worker
    ThrowInternal SomeException
  | -- Error in the workflow that should be returned to the caller
    ThrowWorkflow SomeException


newIVar :: MonadIO m => m (IVar a)
newIVar = do
  ivarRef <- newIORef $ IVarEmpty JobNil
  pure IVar {ivarId = 0, ..}


-- | Allocate an IVar with a unique id drawn from the per-instance counter.
-- Tracked IVars have their blocking call stacks recorded so that built-in
-- queries can report all concurrent stacks.
newTrackedIVar :: InstanceM (IVar a)
newTrackedIVar = do
  inst <- ask
  ivarId <- liftIO $ atomicModifyIORefCAS inst.workflowIVarCounter (\n -> let !n' = n + 1 in (n', n'))
  ivarRef <- newIORef $ IVarEmpty JobNil
  pure IVar {..}


getIVar :: IVar a -> Workflow a
getIVar i@(IVar {ivarId = vid, ivarRef = ref}) = Workflow $ \env -> do
  e <- readIORef ref
  case e of
    IVarFull r -> do
      when (vid /= 0) $ removeBlockedStack vid
      deliverResultVal r
    IVarEmpty _ -> do
      when (vid /= 0) $ recordBlockedStack vid
      r <- liftIO $ fiberSuspend env i
      when (vid /= 0) $ removeBlockedStack vid
      deliverResultVal r


recordBlockedStack :: Word64 -> InstanceM ()
recordBlockedStack vid = do
  inst <- ask
  cs <- readIORef inst.workflowCallStack
  modifyIORef' inst.workflowBlockedStacks $ HashMap.insert vid cs


removeBlockedStack :: Word64 -> InstanceM ()
removeBlockedStack vid = do
  inst <- ask
  modifyIORef' inst.workflowBlockedStacks $ HashMap.delete vid


putIVar :: IVar a -> ResultVal a -> ContinuationEnv -> IO ()
putIVar IVar {ivarRef = ref} a ContinuationEnv {..} = do
  e <- readIORef ref
  case e of
    IVarEmpty jobs -> trace_ "putIVar/Empty" $ do
      writeIORef ref (IVarFull a)
      modifyIORef' runQueueRef (appendJobList jobs)
    -- An IVar is typically only meant to be written to once
    -- so it would make sense to throw an error here. But there
    -- are legitimate use-cases for writing several times.
    IVarFull {} -> trace_ "putIVar/Full" return ()


tryReadIVar :: IVar a -> Workflow (Maybe a)
tryReadIVar IVar {ivarRef = ref} = Workflow $ \_ -> do
  e <- readIORef ref
  case e of
    IVarFull (Ok a) -> pure $ Just a
    IVarFull (ThrowWorkflow e') -> throwWorkflow e'
    IVarFull (ThrowInternal e') -> throwIO e'
    IVarEmpty _ -> pure Nothing


-- | A type-erased 'IVar', for 'awaitAny'.
data SomeIVar = forall v. SomeIVar (IVar v)


{- | A first-class handle to a single pending result: the 'IVar' the result will
be delivered on, paired with a decoder from its raw 'ResultVal' to @a@.

It is a 'Functor' but deliberately not an 'Applicative'\/'Monad': those would
admit an effect between a bind and the suspension point, and a 'Pending's 
only valid suspension point is the 'IVar' it wraps.
-}
data Pending a = forall v. Pending !(IVar v) !(ResultVal v -> IO a)


instance Functor Pending where
  fmap f (Pending ivar dec) = Pending ivar (fmap f . dec)


-- | The 'IVar' underlying a 'Pending', type-erased.
pendingIVar :: Pending a -> SomeIVar
pendingIVar (Pending ivar _) = SomeIVar ivar


-- | Block until the 'Pending' resolves, then decode.
-- 
-- __NOTE__: Callers should prefer the polymorphic 'Temporal.Workflow.wait'.
awaitPending :: Pending a -> Workflow a
awaitPending (Pending i@(IVar {ivarId = vid, ivarRef = ref}) dec) = Workflow $ \env -> do
  e <- readIORef ref
  rv <- case e of
    IVarFull r -> do
      when (vid /= 0) $ removeBlockedStack vid
      pure r
    IVarEmpty _ -> do
      when (vid /= 0) $ recordBlockedStack vid
      r <- liftIO $ fiberSuspend env i
      when (vid /= 0) $ removeBlockedStack vid
      pure r
  liftIO $ dec rv


-- | Non-blocking read.
-- 
-- __NOTE__: Callers should prefer the polymorphic 'Temporal.Workflow.poll'.
pollPending :: Pending a -> Workflow (Maybe a)
pollPending (Pending IVar {ivarRef = ref} dec) = Workflow $ \_ -> do
  e <- readIORef ref
  case e of
    IVarFull r -> Just <$> liftIO (dec r)
    IVarEmpty _ -> pure Nothing


-- | Block until one of @sources@ resolves; return its index, or the lowest of
-- two indices if both resolve simultaneously.
awaitAny :: FiberEnv -> NonEmpty SomeIVar -> InstanceM Int
awaitAny env sources = do
  let cenv = fiberContEnv env
      locals = fiberLocals env
      srcs = NE.toList sources
      scanFull :: Int -> [SomeIVar] -> InstanceM (Maybe Int)
      scanFull _ [] = pure Nothing
      scanFull !i (SomeIVar ivar : rest) = do
        c <- readIORef (ivarRef ivar)
        case c of
          IVarFull _ -> pure (Just i)
          IVarEmpty _ -> scanFull (i + 1) rest
  mFast <- scanFull 0 srcs
  case mFast of
    Just i -> pure i
    Nothing -> do
      wakeup <- newIVar
      for_ (reverse (zip [0 :: Int ..] srcs)) $ \(idx, SomeIVar iv) -> do
        wakerRes <- newIVar
        let waker = FreshTask $ Workflow $ \_ ->
              liftIO $ putIVar wakeup (Ok idx) cenv
        parkTask cenv locals waker wakerRes iv
      liftIO (fiberSuspend env wakeup) >>= deliverResultVal


{- | Return whichever of two 'Pending's resolves first; unlike 'race', the 'Pending'
that doesn't resolve is __not__ canceled.

If both 'Pending's resolve simultaneously, the first is returned on the 'Left'.

-- __NOTE__: Callers should prefer the polymorphic 'Temporal.Workflow.select'.
-}
selectPending :: Pending a -> Pending b -> Workflow (Either a b)
selectPending l r = Workflow $ \env -> do
  idx <- awaitAny env (pendingIVar l :| [pendingIVar r])
  if idx == 0
    then Left <$> unWorkflow (awaitPending l) env
    else Right <$> unWorkflow (awaitPending r) env


{- | A very restricted Monad that allows for reading 'StateVar' values. This Monad
keeps track of which 'StateVar' values are read so that it can block and retry
the computation if any of the values change.
-}
newtype Condition a = Condition
  { unCondition :: ReaderT (IORef (Set Sequence)) InstanceM a
  -- ^ We track the sequence number of each accessed StateVar so that we can
  -- block and retry the condition evaluation if the state changes.
  }
  deriving newtype (Functor, Applicative, Monad)


newtype Validation a = Validation
  {unValidation :: IO a}
  deriving newtype (Functor, Applicative, Monad, Catch.MonadThrow, Catch.MonadCatch)


{- | 'StateVar' values are mutable variables scoped to a Workflow run.

'Workflow's are deterministic, so you may not use normal IORefs, since the IORef
could have been created outside of the workflow and cause nondeterminism.

However, it is totally safe to mutate state variables as long as they are scoped
to a workflow and derive their state transitions from the workflow's deterministic
execution.

StateVar values may also be read from within a query and mutated within signal handlers.
-}
data StateVar a = StateVar
  { stateVarId :: !Sequence
  , stateVarRef :: !(IORef a)
  }


instance Eq (StateVar a) where
  a == b = stateVarId a == stateVarId b


instance Ord (StateVar a) where
  compare a b = compare (stateVarId a) (stateVarId b)


newStateVar :: a -> Workflow (StateVar a)
newStateVar a = Workflow $ \_ -> do
  StateVar <$> nextVarIdSequence <*> newIORef a


reevaluateDependentConditions :: StateVar a -> InstanceM ()
reevaluateDependentConditions cref = do
  inst <- ask
  join $ atomically $ do
    seqMaps <- readTVar inst.workflowSequenceMaps
    let pendingConds = seqMaps.conditionsAwaitingSignal
        (reactivateConds, unactivatedConds) =
          HashMap.foldlWithKey'
            ( \(reactivateConds', unactivatedConds') k v@(ivar, varDependencies) ->
                if cref.stateVarId `Set.member` varDependencies
                  then
                    ( reactivateConds' >> liftIO (putIVar ivar (Ok ()) inst.workflowInstanceContinuationEnv)
                    , unactivatedConds'
                    )
                  else
                    ( reactivateConds'
                    , HashMap.insert k v unactivatedConds'
                    )
            )
            (pure (), mempty)
            pendingConds
    writeTVar inst.workflowSequenceMaps (seqMaps {conditionsAwaitingSignal = unactivatedConds})
    pure reactivateConds


class MonadReadStateVar m where
  readStateVar :: StateVar a -> m a


class MonadWriteStateVar m where
  writeStateVar :: StateVar a -> a -> m ()
  modifyStateVar :: StateVar a -> (a -> a) -> m ()


instance MonadReadStateVar Condition where
  readStateVar var = Condition $ do
    touchedVars <- ask
    modifyIORef' touchedVars (Set.insert var.stateVarId)
    readIORef var.stateVarRef


instance MonadReadStateVar Validation where
  readStateVar var = Validation $ readIORef var.stateVarRef


instance MonadReadStateVar Workflow where
  readStateVar var = Workflow $ \_ -> readIORef var.stateVarRef


instance MonadWriteStateVar Workflow where
  writeStateVar var a = Workflow $ \_ -> do
    writeIORef var.stateVarRef a
    reevaluateDependentConditions var
  modifyStateVar var f = Workflow $ \_ -> do
    res <- modifyIORef' var.stateVarRef f
    reevaluateDependentConditions var
    pure res


{- | The Query monad is a very constrained version of the Workflow monad. It can
only read state variables and return values. It is used to define query handlers.
-}
newtype Query a = Query (InstanceM a)
  deriving newtype (Functor, Applicative, Monad)


instance MonadReadStateVar Query where
  readStateVar var = Query $ readIORef var.stateVarRef


newtype InstanceM (a :: Type) = InstanceM {unInstanceM :: ReaderT WorkflowInstance IO a}
  deriving newtype
    ( Functor
    , Applicative
    , Monad
    , MonadIO
    , MonadReader WorkflowInstance
    , MonadUnliftIO
    , Catch.MonadThrow
    , Catch.MonadCatch
    , Catch.MonadMask
    )


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


data WorkflowUpdateImplementation = WorkflowUpdateImplementation
  { updateImplementation :: !(UpdateId -> Vector Payload -> Map Text Payload -> Workflow Payload)
  , updateValidationImplementation :: {-# UNPACK #-} !(Maybe (UpdateId -> Vector Payload -> Map Text Payload -> Validation (Either SomeException ())))
  }


data WorkflowInstance = WorkflowInstance
  { workflowInstanceInfo :: {-# UNPACK #-} !(IORef Info)
  , workflowInstanceLogger :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  , workflowRandomnessSeed :: WorkflowGenM
  , workflowNotifiedPatches :: {-# UNPACK #-} !(IORef (Set PatchId))
  , workflowMemoizedPatches :: {-# UNPACK #-} !(IORef (HashMap PatchId Bool))
  , workflowSequences :: {-# UNPACK #-} !(IORef Sequences)
  , workflowTime :: {-# UNPACK #-} !(IORef SystemTime)
  , workflowIsReplaying :: {-# UNPACK #-} !(IORef Bool)
  , -- | SDK internal flags (see 'SdkFlag') recorded as usable for this run.
    -- Seeded each activation from the core's advertised
    -- @available_internal_flags@ and grown by live 'tryUseSdkFlag' hits; the
    -- accumulated set is echoed back to core in every completion's
    -- @used_internal_flags@ so behaviour changes gated on a flag replay
    -- deterministically (histories predating a flag simply lack its id).
    workflowKnownFlags :: {-# UNPACK #-} !(IORef (HashSet Word32))
  , workflowCommands :: {-# UNPACK #-} !(TVar (Reversed WorkflowCommand))
  , workflowSequenceMaps :: {-# UNPACK #-} !(TVar SequenceMaps)
  , workflowSignalHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (Vector Payload -> Workflow ())))
  , -- | Signals that arrived before their handler was registered.
    -- These are buffered and delivered when setSignalHandler is called.
    -- Uses Endo for O(1) append (diff-list style).
    workflowBufferedSignals :: {-# UNPACK #-} !(IORef (HashMap Text (Endo [(Vector Payload, Map Text Payload)])))
  , workflowQueryHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) (QueryId -> Vector Payload -> Map Text Payload -> IO (Either SomeException Payload))))
  , workflowUpdateHandlers :: {-# UNPACK #-} !(IORef (HashMap (Maybe Text) WorkflowUpdateImplementation))
  , workflowCallStack :: {-# UNPACK #-} !(IORef CallStack)
  , workflowIVarCounter :: {-# UNPACK #-} !(IORef Word64)
  , workflowBlockedStacks :: {-# UNPACK #-} !(IORef (HashMap Word64 CallStack))
  , workflowCompleteActivation :: !(Core.WorkflowActivationCompletion -> IO (Either Core.WorkerError ()))
  , workflowInstanceContinuationEnv :: {-# UNPACK #-} !ContinuationEnv
  , workflowCancellationVar :: {-# UNPACK #-} !(IVar ())
  , workflowDeadlockTimeout :: Maybe Int
  , workflowVault :: {-# UNPACK #-} !Vault
  , -- These are how the instance gets its work done
    activationChannel :: {-# UNPACK #-} !(TQueue Core.WorkflowActivation)
  , executionThread :: {-# UNPACK #-} !(IORef (Async ()))
  , inboundInterceptor :: {-# UNPACK #-} !WorkflowInboundInterceptor
  , outboundInterceptor :: {-# UNPACK #-} !WorkflowOutboundInterceptor
  , -- Improves error reporting
    errorConverters :: [ApplicationFailureHandler]
  , payloadProcessor :: {-# UNPACK #-} !PayloadProcessor
  }


data SomeChildWorkflowHandle = forall result. SomeChildWorkflowHandle (ChildWorkflowHandle result)


type SequenceMap a = HashMap Sequence a


data Sequences = Sequences
  { externalCancel :: {-# UNPACK #-} !Word32
  , childWorkflow :: {-# UNPACK #-} !Word32
  , externalSignal :: {-# UNPACK #-} !Word32
  , timer :: {-# UNPACK #-} !Word32
  , activity :: {-# UNPACK #-} !Word32
  , condition :: {-# UNPACK #-} !Word32
  , varId :: {-# UNPACK #-} !Word32
  , nexusOperation :: {-# UNPACK #-} !Word32
  }


-- Newtyped because the list is reversed
newtype Reversed a = Reversed [a]
  deriving newtype (Functor, Show, Eq)


fromReversed :: Reversed a -> [a]
fromReversed (Reversed xs) = reverse xs


push :: a -> Reversed a -> Reversed a
push x (Reversed xs) = Reversed (x : xs)


data NexusOperationHandles = NexusOperationHandles
  { nexusStartHandle :: {-# UNPACK #-} !(IVar NexusOperationStartResult)
  , nexusResultHandle :: {-# UNPACK #-} !(IVar NexusOperationResult)
  }


data SequenceMaps = SequenceMaps
  { timers :: {-# UNPACK #-} !(SequenceMap (IVar ()))
  , activities :: {-# UNPACK #-} !(SequenceMap (IVar ResolveActivity))
  , childWorkflows :: {-# UNPACK #-} !(SequenceMap SomeChildWorkflowHandle)
  , externalSignals :: {-# UNPACK #-} !(SequenceMap (IVar ResolveSignalExternalWorkflow))
  , externalCancels :: {-# UNPACK #-} !(SequenceMap (IVar ResolveRequestCancelExternalWorkflow))
  , conditionsAwaitingSignal :: {-# UNPACK #-} !(SequenceMap (IVar (), Set Sequence))
  , nexusOperations :: {-# UNPACK #-} !(SequenceMap NexusOperationHandles)
  }


-- | An async action handle that can be awaited or cancelled.
data Task a = Task
  { waitAction :: Workflow a
  , cancelAction :: Workflow ()
  }


instance Functor Task where
  fmap f (Task wait' cancel') = Task (fmap f wait') cancel'


instance Applicative Task where
  pure a = Task (pure a) (pure ())
  Task waitL cancelL <*> Task waitR cancelR = Task (waitL <*> waitR) (cancelL *> cancelR)


{- | Sometimes you want to alter the result of a task, but you 'Task' doesn't work as
a monad due to the 'cancel' action. This function lets you alter the result of a task
in the workflow monad.
-}
bindTask :: Task a -> (a -> Workflow b) -> Task b
bindTask (Task wait' cancel') f = Task (wait' >>= f) cancel'


{- | Handle representing an external Workflow Execution.

This handle can only be cancelled and signalled.

To call other methods, like query and result, use a WorkflowClient.getHandle inside an Activity.
-}
data ExternalWorkflowHandle (result :: Type) = ExternalWorkflowHandle
  { externalWorkflowWorkflowId :: WorkflowId
  , externalWorkflowRunId :: Maybe RunId
  }


{- | A client side handle to a single child Workflow instance.

It can be used to signal, wait for completion, and cancel the workflow.
-}
data ChildWorkflowHandle result = ChildWorkflowHandle
  { childWorkflowSequence :: Sequence
  , startHandle :: IVar ()
  , resultHandle :: IVar ResolveChildWorkflowExecution
  , childWorkflowResultConverter :: Payload -> IO result
  , childWorkflowId :: WorkflowId
  , firstExecutionRunId :: IVar RunId
  }


instance Functor ChildWorkflowHandle where
  fmap f h = h {childWorkflowResultConverter = fmap f . childWorkflowResultConverter h}


{- | This is only intended for use by interceptors. Normal workflow code should be able to use
the 'fmap' instance for simple transformations or else provide an appropriate codec.
-}
interceptorConvertChildWorkflowHandle :: ChildWorkflowHandle a -> (a -> IO b) -> ChildWorkflowHandle b
interceptorConvertChildWorkflowHandle h f =
  h
    { childWorkflowResultConverter = childWorkflowResultConverter h >=> f
    }


data ExecuteWorkflowInput = ExecuteWorkflowInput
  { executeWorkflowInputType :: WorkflowType
  , executeWorkflowInputArgs :: Vector Payload
  , executeWorkflowInputHeaders :: Map Text Payload
  , executeWorkflowInputInfo :: Info
  }


data WorkflowExitVariant a
  = WorkflowExitContinuedAsNew ContinueAsNewException
  | WorkflowExitCancelled WorkflowCancelRequested
  | WorkflowExitFailed SomeException
  | WorkflowExitSuccess a


data HandleQueryInput = HandleQueryInput
  { handleQueryId :: QueryId
  , handleQueryInputType :: Text
  , handleQueryInputArgs :: Vector Payload
  , handleQueryInputHeaders :: Map Text Payload
  , handleQueryWorkflowInfo :: Info
  }


data HandleUpdateInput = HandleUpdateInput
  { handleUpdateId :: UpdateId
  , handleUpdateInputType :: Text
  , handleUpdateInputArgs :: Vector Payload
  , handleUpdateInputHeaders :: Map Text Payload
  , handleUpdateWorkflowInfo :: Info
  }


data HandleSignalInput = HandleSignalInput
  { handleSignalInputType :: Text
  , handleSignalInputArgs :: Vector Payload
  , handleSignalInputHeaders :: Map Text Payload
  , handleSignalWorkflowInfo :: Info
  }


data WorkflowInboundInterceptor = WorkflowInboundInterceptor
  { executeWorkflow
      :: ExecuteWorkflowInput
      -> (ExecuteWorkflowInput -> IO (WorkflowExitVariant Payload))
      -> IO (WorkflowExitVariant Payload)
  , handleQuery
      :: HandleQueryInput
      -> (HandleQueryInput -> IO (Either SomeException Payload))
      -> IO (Either SomeException Payload)
  , handleUpdate
      :: HandleUpdateInput
      -> (HandleUpdateInput -> Workflow Payload)
      -> Workflow Payload
  , handleSignal
      :: HandleSignalInput
      -> (HandleSignalInput -> Workflow ())
      -> Workflow ()
  , validateUpdate
      :: HandleUpdateInput
      -> (HandleUpdateInput -> IO (Either SomeException ()))
      -> IO (Either SomeException ())
  }


instance Semigroup WorkflowInboundInterceptor where
  a <> b =
    WorkflowInboundInterceptor
      { executeWorkflow = \input cont -> a.executeWorkflow input $ \input' -> b.executeWorkflow input' cont
      , handleQuery = \input cont -> a.handleQuery input $ \input' -> b.handleQuery input' cont
      , handleUpdate = \input cont -> a.handleUpdate input $ \input' -> b.handleUpdate input' cont
      , handleSignal = \input cont -> a.handleSignal input $ \input' -> b.handleSignal input' cont
      , validateUpdate = \input cont -> a.validateUpdate input $ \input' -> b.validateUpdate input' cont
      }


instance Monoid WorkflowInboundInterceptor where
  mempty =
    WorkflowInboundInterceptor
      { executeWorkflow = \input cont -> cont input
      , handleQuery = \input cont -> cont input
      , handleUpdate = \input cont -> cont input
      , handleSignal = \input cont -> cont input
      , validateUpdate = \input cont -> cont input
      }


data ActivityInput = ActivityInput
  { activityType :: Text
  , args :: Vector Payload
  , options :: StartActivityOptions
  , seq :: Sequence
  }


data LocalActivityInput = LocalActivityInput
  { localActivityType :: Text
  , localArgs :: Vector Payload
  , localOptions :: StartLocalActivityOptions
  , localSeq :: Sequence
  }


data WorkflowOutboundInterceptor = WorkflowOutboundInterceptor
  { scheduleActivity :: ActivityInput -> (ActivityInput -> IO (Task Payload)) -> IO (Task Payload)
  , scheduleLocalActivity :: LocalActivityInput -> (LocalActivityInput -> IO (Task Payload)) -> IO (Task Payload)
  , startChildWorkflowExecution :: Text -> StartChildWorkflowOptions -> (Text -> StartChildWorkflowOptions -> IO (ChildWorkflowHandle Payload)) -> IO (ChildWorkflowHandle Payload)
  , continueAsNew :: forall a. Text -> ContinueAsNewOptions -> (Text -> ContinueAsNewOptions -> IO a) -> IO a
  }


instance Semigroup WorkflowOutboundInterceptor where
  l <> r =
    WorkflowOutboundInterceptor
      { scheduleActivity = \input cont -> scheduleActivity l input $ \input' -> scheduleActivity r input' cont
      , scheduleLocalActivity = \input cont -> Temporal.Workflow.Internal.Monad.scheduleLocalActivity l input $ \input' -> Temporal.Workflow.Internal.Monad.scheduleLocalActivity r input' cont
      , startChildWorkflowExecution = \t input cont -> startChildWorkflowExecution l t input $ \t' input' -> startChildWorkflowExecution r t' input' cont
      , continueAsNew = \n input cont -> continueAsNew l n input $ \n' input' -> continueAsNew r n' input' cont
      }


instance Monoid WorkflowOutboundInterceptor where
  mempty =
    WorkflowOutboundInterceptor
      { scheduleActivity = \input cont -> cont input
      , scheduleLocalActivity = \input cont -> cont input
      , startChildWorkflowExecution = \t input cont -> cont t input
      , continueAsNew = \n input cont -> cont n input
      }


nextVarIdSequence :: InstanceM Sequence
nextVarIdSequence = do
  inst <- ask
  liftIO $ atomicModifyIORefCAS inst.workflowSequences $ \seqs ->
    let seq' = varId seqs
    in (seqs {varId = succ seq'}, Sequence seq')

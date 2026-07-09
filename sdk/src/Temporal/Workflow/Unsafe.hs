{- | Unsafe functions for performing IO in the Workflow monad.

These functions fundamentally break the purity of the Workflow monad, so
they should be used with extreme caution.

In particular, they should not be used to alter the control flow of the
Workflow.

The reason that they exist at all is because there are some operations
needed for observability and debugging that don't produce observable changes
to the Workflow state, such as logging.

It is the responsibility of the developer to ensure that these functions are
used in a way that does not break the determinism guarantees of the Workflow.

As such, these functions are not exported from the Temporal module to discourage
inadvisable use.
-}
module Temporal.Workflow.Unsafe (
  performUnsafeNonDeterministicIO,
  unsafeReadWorkflowVault,
  unsafeIsReplaying,
  withoutDeadlockDetection,
) where

import qualified Control.Monad.Catch as Catch
import Control.Monad.IO.Class
import Data.IORef (atomicWriteIORef, readIORef)
import Data.Vault.Strict (Vault)
import GHC.Clock (getMonotonicTimeNSec)
import RequireCallStack (provideCallStack)
import qualified Temporal.Common.Logging as Logging
import Temporal.Workflow
import Temporal.Workflow.Internal.Monad


{- | Perform an arbitrary IO action in the Workflow monad.

This function is unsafe because it allows non-deterministic IO to be performed
within a Workflow. This breaks the fundamental guarantee that Workflows are
deterministic and replayable.

This should only be used for operations that do not affect the control flow
or observable state of the Workflow, such as logging or metrics collection.

If the IO action throws an exception, it will be caught and rethrown in the
Workflow monad.

Use this function with extreme caution. Improper use includes but is not limited to:

* Reading from files or databases, as the data may change between replays
* Making network requests, as responses may vary
* Getting the current time/date, as it changes between replays
* Generating random numbers outside of Workflow.Random
* Modifying global/shared state
* Any IO that could affect control flow decisions

Instead of using this function, prefer the safe alternatives provided by the
Temporal SDK:

* For time, use 'Workflow.currentTimeMillis'
* For randomness, use 'Workflow.Random'
* For external data, use Activities
* For side effects, use 'Workflow.sideEffect'
-}
performUnsafeNonDeterministicIO :: IO a -> Workflow a
performUnsafeNonDeterministicIO m = Workflow (\_ -> liftIO m)
{-# INLINE performUnsafeNonDeterministicIO #-}


{- | Read the worker 'Vault' associated with the currently executing workflow.

This is \"unsafe\" only in the sense that the presence of a given key is a
property of how the worker was configured, not something the type system
guarantees; reading the vault itself is deterministic and replay-safe.
-}
unsafeReadWorkflowVault :: Workflow Vault
unsafeReadWorkflowVault = do
  inst <- askInstance
  pure inst.workflowVault


{- | Whether the workflow is currently replaying recorded history rather than
executing for the first time.

This is intended for gating side effects that must not be repeated on every
replay; it is unsafe only inasmuch as it provides a side-channel for workflow
state that could be used to introduce non-determinism.
-}
unsafeIsReplaying :: Workflow Bool
unsafeIsReplaying = do
  inst <- askInstance
  performUnsafeNonDeterministicIO (readIORef inst.workflowIsReplaying)


{- | Run a workflow action with deadlock detection disabled for its duration.

Intended for legitimately slow /synchronous/ deterministic work that would
otherwise trip the deadlock timeout.

The deadline is cleared on entry and, on exit, pushed out by the elapsed time
so the surrounding activation keeps its remaining budget.

Unsafe: a genuine deadlock inside the block goes undetected and hangs the
activation.

It is 'Workflow'-only, so it does not cover query or update handlers.

It is meant for non-suspending blocks; if the block suspends across an
activation boundary the next activation re-arms detection and protection is not
carried across (although a warning is logged).
-}
withoutDeadlockDetection :: Workflow a -> Workflow a
withoutDeadlockDetection act = do
  inst <- askInstance
  Catch.bracket (disarm inst) (rearm inst) (\_ -> act)
  where
    disarm inst = performUnsafeNonDeterministicIO $ do
      previousDeadline <- readIORef inst.workflowDeadlineNs
      t0 <- getMonotonicTimeNSec
      atomicWriteIORef inst.workflowDeadlineNs Nothing
      pure (previousDeadline, t0)
    -- Deadlock detection was already disabled.
    rearm _ (Nothing, _) = pure ()
    rearm inst (Just deadline, t0) = do
      currentDeadline <- performUnsafeNonDeterministicIO $ readIORef inst.workflowDeadlineNs
      case currentDeadline of
        -- Still disarmed by us: push the deadline out by the elapsed time.
        Nothing -> performUnsafeNonDeterministicIO $ do
          t1 <- getMonotonicTimeNSec
          atomicWriteIORef inst.workflowDeadlineNs (Just $ deadline + (t1 - t0))
        -- A new activation re-armed the deadline: the block suspended across an
        -- activation boundary; leave the fresh deadline to avoid mixing epochs.
        Just _ -> provideCallStack $ ilift $
          Logging.logWarn "withoutDeadlockDetection: block suspended across an activation; deadlock detection re-armed mid-block"

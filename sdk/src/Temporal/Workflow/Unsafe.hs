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
  performUnsafeNonDeterministicIO
) where

import Control.Monad.IO.Class
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
performUnsafeNonDeterministicIO m = Workflow (\_ -> Done <$> liftIO m)
{-# INLINE performUnsafeNonDeterministicIO #-}

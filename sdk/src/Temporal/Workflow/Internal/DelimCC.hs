{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}

{- |
Module: Temporal.Workflow.Internal.DelimCC
Description: Thin IO wrappers around the GHC 9.6+ delimited continuation primops.

The 'Temporal.Workflow.Workflow' monad implements cooperative multitasking:
a workflow instance interleaves the main workflow "fiber" with signal
handlers, update handlers, and concurrency combinators ('Temporal.Workflow.race',
'Temporal.Workflow.concurrently', ...) on a single thread, suspending
whenever a fiber blocks on an unresolved 'Temporal.Workflow.Internal.Monad.IVar'.

Suspension is implemented with the delimited continuation primops
('GHC.Exts.prompt#' \/ 'GHC.Exts.control0#'): each fiber runs inside a
'prompt', and blocking operations use 'control0' to capture the rest of the
fiber (including any 'Control.Exception.catch' frames) as a first-class
value that the scheduler parks on the 'Temporal.Workflow.Internal.Monad.IVar'
it is waiting for.

Invariants relied upon by the scheduler:

* A captured continuation is resumed at most once, and always via 'prompt'
  with the same tag it was captured with (so later suspensions in the same
  fiber have a delimiter to capture up to).
* 'control0' is never invoked from inside an STM transaction or an
  'System.IO.Unsafe.unsafePerformIO' thunk; workflow blocking operations are
  only reachable from plain 'IO' driven by the scheduler.
* Continuations may be resumed on a different OS thread than the one they
  were captured on; the captured stack segment is ordinary heap data.
-}
module Temporal.Workflow.Internal.DelimCC (
  PromptTag,
  newPromptTag,
  prompt,
  control0,
) where

import GHC.Exts (PromptTag#, control0#, newPromptTag#, prompt#)
import GHC.IO (IO (..))


-- | A unique delimiter for a fiber. @a@ is the answer type of the delimited scope.
data PromptTag a = PromptTag (PromptTag# a)


newPromptTag :: IO (PromptTag a)
newPromptTag = IO $ \s -> case newPromptTag# s of
  (# s', tag #) -> (# s', PromptTag tag #)
{-# INLINE newPromptTag #-}


-- | Delimit a scope: @control0 tag@ within @m@ captures up to this point.
prompt :: PromptTag a -> IO a -> IO a
prompt (PromptTag tag) (IO m) = IO (prompt# tag m)
{-# INLINE prompt #-}


{- | Capture the continuation up to the nearest enclosing @'prompt' tag@,
removing the delimiter. The continuation does /not/ reinstate the delimiter
when applied; resumers must wrap the application in @'prompt' tag@ again if
the computation may suspend further.
-}
control0 :: PromptTag a -> ((IO b -> IO a) -> IO a) -> IO b
control0 (PromptTag tag) f =
  IO (control0# tag (\k -> case f (\(IO b) -> IO (k b)) of IO a -> a))
{-# INLINE control0 #-}

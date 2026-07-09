{-# LANGUAGE PatternSynonyms #-}

-- | This module defines a data structure and corresponding functions to assist
-- with activity or child workflow multiplexing within Temporal
-- workflows.
--
-- Motivation and usage is similar to the common libc multiplexing routines
-- @select@ and @poll@, which is where the names are derived from.
module Temporal.Contrib.BoundedConcurrency.Select
  ( Select,
    mkSelect,
    push,
    poll,
    awaitAction,
  )
where

import Data.Functor
import Data.Sequence (Seq, pattern Empty, pattern (:|>))
import qualified Data.Sequence as Seq
import Data.Void
import Temporal.Workflow
import qualified Temporal.Workflow as Workflow
import Prelude

newtype Select a = Select
  { runQueue :: Seq a
  }

mkSelect :: [a] -> Select a
mkSelect = Select . Seq.fromList

push :: Select a -> a -> Select a
push Select {runQueue} = Select . (runQueue Seq.|>)

-- | Given a @Select w@ where @w@ is an instance of 'Wait', wait on all of the
-- actions concurrently.
--
-- This returns @Nothing@ iff the @Select@ is empty, otherwise it blocks and
-- returns the first action wrapped in a @Just@ alongside a new @Select@ that
-- doesn't contain the @w@ that finished.
poll :: forall w b. (Wait w, WaitResult w ~ Workflow b, RequireCallStack) => Select w -> Workflow (Maybe b, Select w)
poll sel = awaitAction sel Workflow.wait

-- | Performs the @waitAction@ concurrently
--
-- Returns @Nothing@ iff the @Select@ is empty (i.e. it contains no elements),
-- otherwise, blocks and returns the first action result wrapped in a @Just@
-- alongside a new @Select@ that doesn't contain the element associated with the
-- finished action.
awaitAction :: forall a b. RequireCallStack => Select a -> (a -> Workflow b) -> Workflow (Maybe b, Select a)
awaitAction Select {runQueue} waitAction = case runQueue of
  -- there are no elements, return Nothing
  Empty -> pure (Nothing, Select Empty)
  -- there are elements. Run them all concurrently returning the first value
  -- returned alongside the runqueue with the finished child removed.
  rs :|> r ->
    let waitLast = do
          rval <- waitAction r
          pure (rval, Select rs)
     in Seq.foldrWithIndex selectChild waitLast rs <&> \case
          (val, newSel) -> (Just val, newSel)
  where
    -- NB: 'biselectOptNoCancel', not 'biselectOpt'.
    --
    -- A @Select@ is a poll: when one element wins, the others should not be
    -- abandoned. 'biselectOpt' would /cancel/ every losing element on
    -- every round.
    selectChild :: RequireCallStack => Int -> a -> Workflow (b, Select a) -> Workflow (b, Select a)
    selectChild k v rest = do
      biselectOptNoCancel (\res -> Left (res, Select $ Seq.deleteAt k runQueue)) Left id unused (waitAction v) rest
      where
        unused :: forall x. (Void, Void) -> x
        unused = absurd . fst

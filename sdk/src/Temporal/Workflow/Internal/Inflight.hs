{- | A collection of concurrently-running workflow actions, harvested according
to the order that they complete.

An action is started once and only ever resumed, so a wait that emits commands
as it runs (e.g. a local activity backing off between attempts) never re-emits
them.

An 'Inflight' must always use the value returned by the latest 'push' or 'next',
since reusing an older one resumes a continuation twice.

Dropping a non-empty 'Inflight' abandons its members: the underlying operations
keep running, and because the members are neither completed nor cancelled,
their finalizers never run.
-}
module Temporal.Workflow.Internal.Inflight
  ( Inflight
  , empty
  , size
  , push
  , fromFoldable
  , next
  ) where

import Control.Exception (SomeException)
import Control.Monad (foldM)
import Control.Monad.IO.Class (liftIO)
import Data.Foldable (traverse_)
import Data.Sequence (Seq)
import qualified Data.Sequence as Seq
import Temporal.Workflow.Internal.Monad hiding (push)


-- | A set of in-flight actions, each yielding an @a@.
newtype Inflight a = Inflight (Seq (SubStatus a))


-- | The empty set.
empty :: Inflight a
empty = Inflight Seq.empty


-- | Returns the number of actions still running.
size :: Inflight a -> Int
size (Inflight ms) = Seq.length ms


{- | Starts the action and adds it to the set; the action runs immediately up
to its first suspension and is only ever resumed afterwards, never restarted.
-}
push :: Inflight a -> Workflow a -> Workflow (Inflight a)
push (Inflight ms) act = Workflow $ \env -> do
  st <- runSubFiber env act
  pure $ Inflight $ ms Seq.|> st


-- | Starts every action, in the collection's fold order.
fromFoldable :: Foldable f => f (Workflow a) -> Workflow (Inflight a)
fromFoldable = foldM push empty


{- | Return the first action in an 'Inflight' that completes, alongside an
'Inflight' with the remaining actions that are still pending.

Exceptions raised by the completed action are returned promptly as
@'Left' 'SomeException'@ so the caller can handle them separately from the
remaining in-flight actions.

When several actions have finished, they are returned in insertion-order.
-}
next :: forall a. Inflight a -> Workflow (Maybe (Either SomeException a, Inflight a))
next (Inflight members0)
  | Seq.null members0 = Workflow $ \_ -> pure Nothing
  | otherwise = Workflow $ \env -> do
      let cenv = fiberContEnv env
          locals = fiberLocals env

          -- Park a waker on a blocked action that fills this round's wakeup.
          -- 
          -- Wakers left over from an earlier round fill a wakeup that is already
          -- full, so 'putIVar' makes them no-ops.
          arm :: IVar () -> SubStatus a -> InstanceM ()
          arm wakeup (SubBlocked iv _) = do
            wakerRes <- newIVar
            let waker = FreshTask $ Workflow $ \_ -> liftIO $ putIVar wakeup (Ok ()) cenv
            parkTask cenv locals waker wakerRes iv
          arm _ _ = pure ()

          loop :: Seq (SubStatus a) -> InstanceM (Maybe (Either SomeException a, Inflight a))
          loop members = do
            res <- scan members
            case res of
              Left (result, rest) -> pure (Just (result, Inflight rest))
              Right blocked -> do
                wakeup <- newIVar
                traverse_ (arm wakeup) blocked
                rv <- liftIO $ fiberSuspend env wakeup
                -- A wakeup value other than 'Ok' means the caller was cancelled.
                _ <- deliverResultVal rv
                loop blocked

      loop members0
  where
    -- Advance a blocked sub-fiber.
    step :: SubStatus a -> InstanceM (SubStatus a)
    step (SubBlocked iv k) = stepSubFiber iv k
    step st = pure st

    -- Resume every ready action; returns either of the first thrown exception
    -- or the leftmost completed result.
    scan
      :: Seq (SubStatus a)
      -> InstanceM (Either (Either SomeException a, Seq (SubStatus a)) (Seq (SubStatus a)))
    scan members = do
      stepped <- traverse step members
      pure $ case Seq.foldlWithIndex choose Nothing stepped of
        Nothing -> Right stepped
        Just (i, r) -> Left (r, Seq.deleteAt i stepped)
      where
        choose best i = \case
          SubThrown e -> case best of Just (_, Left _) -> best; _ -> Just (i, Left e)
          SubDone a -> case best of Nothing -> Just (i, Right a); _ -> best
          SubBlocked {} -> best

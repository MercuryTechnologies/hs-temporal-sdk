module Temporal.Coroutine where

import Control.Monad
import qualified Control.Monad.Catch as Catch
import Control.Monad.Trans


newtype Await x y = Await (x -> y)


instance Functor (Await x) where
  fmap f (Await g) = Await (f . g)


-- | Suspending, resumable monadic computations.
newtype Coroutine s m r = Coroutine
  { resume :: m (Either (s (Coroutine s m r)) r)
  -- ^ Run the next step of a `Coroutine` computation. The result of the step execution will be either a suspension or
  -- the final coroutine result.
  }


instance (Functor s, Functor m) => Functor (Coroutine s m) where
  fmap f t = Coroutine (fmap (apply f) (resume t))
    where
      apply fc (Right x) = Right (fc x)
      apply fc (Left s) = Left (fmap (fmap fc) s)


instance (Functor s, Functor m, Monad m) => Applicative (Coroutine s m) where
  pure x = Coroutine (return (Right x))
  (<*>) = ap
  t *> f = Coroutine (resume t >>= apply f)
    where
      apply fc (Right _) = resume fc
      apply fc (Left s) = return (Left (fmap (>> fc) s))


instance (Functor s, Monad m) => Monad (Coroutine s m) where
  return = pure
  t >>= f = Coroutine (resume t >>= apply f)
    where
      apply fc (Right x) = resume (fc x)
      apply fc (Left s) = return (Left (fmap (>>= fc) s))
  (>>) = (*>)


instance (Functor s, MonadFail m) => MonadFail (Coroutine s m) where
  fail msg = Coroutine (Right <$> fail msg)


instance Functor s => MonadTrans (Coroutine s) where
  lift = Coroutine . liftM Right


instance (Functor s, MonadIO m) => MonadIO (Coroutine s m) where
  liftIO = lift . liftIO


instance (Functor s, Catch.MonadThrow m) => Catch.MonadThrow (Coroutine s m) where
  throwM = lift . Catch.throwM


instance (Functor s, Catch.MonadCatch m) => Catch.MonadCatch (Coroutine s m) where
  catch (Coroutine t) h = Coroutine $ do
    r <- Catch.catch t (resume . h)
    case r of
      Right x -> return (Right x)
      Left s -> return (Left (fmap (`Catch.catch` h) s))


suspend :: (Monad m) => s (Coroutine s m x) -> Coroutine s m x
suspend s = Coroutine (return (Left s))
{-# INLINE suspend #-}


-- | Suspend the current coroutine until a value is provided.
await :: Monad m => Coroutine (Await x) m x
await = suspend (Await return)


supply :: Monad m => (s (Coroutine s m x) -> Coroutine s m x) -> Coroutine s m x -> m x
supply runStep = loop
  where
    loop c = resume c >>= either (loop . runStep) pure


-- | Runs a suspendable 'Coroutine' to its completion with a monadic action.
supplyM :: Monad m => (s (Coroutine s m x) -> m (Coroutine s m x)) -> Coroutine s m x -> m x
supplyM runStep = loop
  where
    loop c = resume c >>= either (runStep >=> loop) pure


coroutineHoist
  :: forall f m n a
   . (Functor f, Monad m, Monad n)
  => (forall b. m b -> n b)
  -> Coroutine f m a
  -> Coroutine f n a
coroutineHoist f routine =
  Coroutine
    { resume = liftM go $ f $ resume routine
    }
  where
    go (Right r) = Right r
    go (Left s) = Left (coroutineHoist f <$> s)

{-# LANGUAGE CPP #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Temporal.Workflow.Saga 
  ( SagaT
  , runSaga
  , compensated
  ) where
import Control.Monad
#if MIN_VERSION_mtl(2,3,0)
import Control.Monad.Accum
import Control.Monad.Select
#endif
import Control.Monad.Error.Class (MonadError)
import Control.Monad.RWS (MonadReader)
import Control.Monad.State
import Control.Monad.Writer
import Data.Functor.Contravariant
import Control.Applicative
import Control.Monad.Cont
import Control.Monad.Catch (MonadCatch)
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger (MonadLogger)
import Control.Monad.Logger (logError)
import qualified Data.Text as T

{- | The saga pattern is a failure management pattern that helps establish consistency in distributed applications, 
and coordinates transactions between multiple services to attempt to maintain data consistency.

If you’re wondering if the saga pattern is right for your scenario, ask yourself: 
does your logic involve multiple steps, some of which span machines, services, shards, or databases, for which partial execution is undesirable? 
Turns out, this is exactly where sagas are useful. Maybe you are checking inventory, charging a user’s credit card, and then fulfilling the order. 
Maybe you are managing a supply chain. 

The saga pattern is helpful because it basically functions as a state machine storing program progress, 
preventing multiple credit card charges, reverting if necessary, and knowing exactly how to safely resume 
in a consistent state in the event of power loss.

There are many “do it all, or don’t bother” software applications in the real-world: 

if you successfully charge the user for an item but your fulfillment service reports that the item is out of stock, you’re going to have upset 
users if you don’t refund the charge. If you have the opposite problem and accidentally deliver items “for free,” you’ll be out of business. 

If the machine coordinating a machine learning data processing pipeline crashes but the follower machines carry on processing the data with 
nowhere to report their data to, you may have a very expensive compute resources bill on your hands. In all of these cases having some sort of “progress tracking” and compensation code to deal with these “do-it-all-or-don’t-do-any-of-it” tasks is exactly what the saga pattern provides. In saga parlance, these sorts of “all or nothing” tasks are called long-running transactions. This doesn’t necessarily mean such actions run for a “long” time, just that they require more steps in 
logical time than something running locally interacting with a single database.

A saga is composed of two parts:

1. Defined behavior for “going backwards” if you need to “undo” something (i.e., compensations)
2. Behavior for striving towards forward progress (i.e., saving state to know where to recover 
   from in the face of failure). This second part is often called the “orchestration logic” of the saga.
   For Temporal, execution of the orchestration logic is handled by the Temporal server, and the saga
   monad transformer here simply needs to handle the compensation logic.

Lastly, note that compensation actions are still subject to the same restrictions as any other workflow code.
This means that compensation Actions run within a Workflow monad can be timed out, and they can be retried.
Make sure in this case that whatever retry / timeout policies you have in place for your workflow are appropriate
for the compensation actions you are running.

For more information on the saga pattern, see the following resources:

- [Saga Pattern Made Easy](https://temporal.io/blog/saga-pattern-made-easy-with-temporal/)
- [The Saga Pattern in Distributed Systems](https://www.cs.cornell.edu/andru/cs711/2002fa/reading/sagas.pdf)
-}
newtype SagaT m a = SagaT { unSagaT :: StateT [m ()] m a }
  deriving (Functor, Applicative, Monad, MonadIO)

runSaga :: (MonadCatch m, MonadLogger m) => (Catch.SomeException -> m ()) -> SagaT m a -> m a
runSaga compensationExceptionHandler m = flip evalStateT [] $ do
  unSagaT (m `Catch.onException` compensate compensationExceptionHandler)

instance MonadTrans SagaT where
  lift = SagaT . lift

instance MonadState s m => MonadState s (SagaT m) where
  get = lift get
  put = lift . put

deriving newtype instance MonadError e m => MonadError e (SagaT m)
deriving newtype instance MonadReader r m => MonadReader r (SagaT m)
#if MIN_VERSION_mtl(2,3,0)
deriving newtype instance MonadAccum w m => MonadAccum w (SagaT m)
deriving newtype instance MonadSelect w m => MonadSelect w (SagaT m)
#endif
deriving newtype instance MonadWriter w m => MonadWriter w (SagaT m)
deriving newtype instance MonadFail m => MonadFail (SagaT m)
deriving newtype instance MonadFix m => MonadFix (SagaT m)
deriving newtype instance Contravariant m => Contravariant (SagaT m)
deriving newtype instance MonadPlus m => Alternative (SagaT m)
deriving newtype instance MonadPlus m => MonadPlus (SagaT m)
deriving newtype instance MonadCont m => MonadCont (SagaT m)
deriving newtype instance MonadLogger m => MonadLogger (SagaT m)
deriving newtype instance Catch.MonadThrow m => Catch.MonadThrow (SagaT m)
deriving newtype instance Catch.MonadCatch m => Catch.MonadCatch (SagaT m)

-- | Run all compensation actions that have been added to the saga.
compensate :: (MonadCatch m, MonadLogger m) => (Catch.SomeException -> m ()) -> SagaT m ()
compensate compensationExceptionHandler = SagaT $ do
  actions <- get
  put []
  lift $ forM_ actions $ \action -> do
    res <- Catch.try $ action
    case res of
      Left (e :: Catch.SomeException) -> do
        Catch.catchAll (compensationExceptionHandler e) $ \e' -> do
          $(logError) $ T.pack $ "Saga compensation error handler threw exception: " <> show e'
      Right () -> pure ()

addCompensation :: Monad m => m () -> SagaT m ()
addCompensation action = SagaT $ modify (action :)

compensated :: (MonadCatch m)
  => m () 
  -- ^ The compensation action to run if this saga step fails.
  --
  -- This action will be run in the event of any subsequent failure, 
  -- not just the failure of this saga step.
  --
  -- Saga compensation actions will be run in reverse order
  -- of their addition to the saga.
  --
  -- Lastly, note that all sync exceptions thrown by the compensation
  -- action will be swallowed.
  -> m a 
  -- ^ The saga step to run.
  -> SagaT m a
compensated compensation step = do
  res <- lift step 
  addCompensation compensation
  pure res

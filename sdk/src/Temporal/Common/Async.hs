{-# LANGUAGE RankNTypes #-}

module Temporal.Common.Async where

import GHC.Conc (labelThread)
import UnliftIO
import UnliftIO.Concurrent


asyncLabelled :: MonadUnliftIO m => String -> m a -> m (Async a)
asyncLabelled label action = async $ do
  asyncId <- myThreadId
  liftIO $ labelThread asyncId label
  action


{- | Like 'asyncLabelled', but hands the spawned action an @unmask@ restore so
it can run a cancellable region even when spawned inside a 'mask_'.
-}
asyncLabelledWithUnmask :: MonadUnliftIO m => String -> ((forall b. m b -> m b) -> m a) -> m (Async a)
asyncLabelledWithUnmask label action = asyncWithUnmask $ \unmask -> do
  asyncId <- myThreadId
  liftIO $ labelThread asyncId label
  action unmask


forkIOLabelled :: MonadUnliftIO m => String -> m () -> m ThreadId
forkIOLabelled label action = UnliftIO.Concurrent.forkIO $ do
  asyncId <- myThreadId
  liftIO $ labelThread asyncId label
  action

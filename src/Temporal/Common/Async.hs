module Temporal.Common.Async where

import UnliftIO
import UnliftIO.Concurrent
import GHC.Conc (labelThread)

asyncLabelled :: MonadUnliftIO m => String -> m a -> m (Async a)
asyncLabelled label action = async $ do
  asyncId <- myThreadId
  liftIO $ labelThread asyncId label
  action

forkIOLabelled :: MonadUnliftIO m => String -> m () -> m ThreadId
forkIOLabelled label action = UnliftIO.Concurrent.forkIO $ do
  asyncId <- myThreadId
  liftIO $ labelThread asyncId label
  action

{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE GADTs #-}
module Temporal.Internal.JobPool 
  ( SomeAsync(..)
  , JobPool
  , JobPoolOptions(..)
  , newJobPool
  , shutdownJobPool
  , withJobPool
  , enqueueJob
  , enqueueJob_
  , enqueueJobAsync
  ) where

import Control.Concurrent.Async
import Control.Concurrent.Chan
import Control.Concurrent
import Control.Concurrent.STM
import Control.Concurrent.STM.TVar
import Control.Exception
import Control.Monad
import qualified Data.Map.Strict as Map

data SomeAsync = forall a. SomeAsync (Async a)

data JobPool = JobPool
  { jobPool :: TVar (Map.Map ThreadId SomeAsync)
  , jobQueue :: Chan (IO ())
  , jobActiveCount :: TVar Int
  , jobActivator :: Async ()
  }

data JobPoolOptions = JobPoolOptions
  { jobPoolOptionsMaxConcurrentJobs :: Maybe Int
  , jobPoolOptionsThreadLabelPrefix :: String
  }

newJobPool :: JobPoolOptions -> IO JobPool
newJobPool options = do
  jobPool <- newTVarIO mempty
  jobQueue <- newChan
  jobActiveCount <- newTVarIO 0
  maxConcurrentJobs <- case jobPoolOptionsMaxConcurrentJobs options of
    Nothing -> getNumCapabilities
    Just n -> pure n
  let activator activeCountVar queue = forever $ do
        atomically $ do
          activeCount <- readTVar activeCountVar
          check $ activeCount < maxConcurrentJobs
        join $ readChan queue
  jobActivator <- async $ activator jobActiveCount jobQueue
  pure JobPool{..}

shutdownJobPool :: JobPool -> IO ()
shutdownJobPool jp = do
  cancel (jobActivator jp)
  atomically $ do
    activeCount <- readTVar (jobActiveCount jp)
    check $ activeCount == 0

-- TODO, implement a version that allows running jobs to complete gracefully
-- before shutting down
withJobPool :: JobPoolOptions -> (JobPool -> IO a) -> IO a
withJobPool options f = bracket (newJobPool options) shutdownJobPool f

-- | Returns an action that, when executed, will block until the Async task has started.
--
-- Caution: calling this function on a job pool that has been shut down will block forever.
enqueueJob :: JobPool -> IO a -> IO (IO (Async a))
enqueueJob jp m = do
  initiationBlock <- newEmptyMVar
  writeChan (jobQueue jp) $ do
    mask_ $ do
      a <- async $ m `finally` do
        tid <- myThreadId
        atomically $ do
          modifyTVar' (jobActiveCount jp) (subtract 1)
          modifyTVar' (jobPool jp) $ \m -> Map.delete tid m
      atomically $ do
        modifyTVar' (jobActiveCount jp) (+1)
        modifyTVar' (jobPool jp) $ \m -> Map.insert (asyncThreadId a) (SomeAsync a) m
      putMVar initiationBlock a
  {- TODO, detect deadlock and throw an exception instead -}
  pure $ takeMVar initiationBlock

-- | Enqueue a job into the job pool without caring about the result.
enqueueJob_ :: JobPool -> IO a -> IO ()
enqueueJob_ jp m = do
  writeChan (jobQueue jp) $ do
    mask_ $ do
      a <- async $ m `finally` do
        tid <- myThreadId
        atomically $ do
          modifyTVar' (jobActiveCount jp) (subtract 1)
          modifyTVar' (jobPool jp) $ \m -> Map.delete tid m
      atomically $ do
        modifyTVar' (jobActiveCount jp) (+1)
        modifyTVar' (jobPool jp) $ \m -> Map.insert (asyncThreadId a) (SomeAsync a) m

enqueueJobAsync :: JobPool -> IO a -> IO (Async a)
enqueueJobAsync jobPool m = do
  runner <- enqueueJob jobPool m
  async $ do
    activate <- runner
    wait activate

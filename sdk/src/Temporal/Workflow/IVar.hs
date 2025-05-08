module Temporal.Workflow.IVar where

import Control.Monad
import Control.Monad.Logger
import Data.Foldable
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe (isJust)
import Data.Typeable
import GHC.Conc (unsafeIOToSTM)
import UnliftIO
import UnliftIO.Concurrent


data WorkflowThread = WorkflowThread
  { workflowThreadBlocked :: {-# UNPACK #-} !(TVar Bool)
  }


cancelWorkflowThreadNoWait :: MonadIO m => ThreadId -> m ()
cancelWorkflowThreadNoWait thread = do
  throwTo thread AsyncCancelled


class HasThreadManager a where
  getThreadManager :: a -> ThreadManager


newtype ThreadManager = ThreadManager
  { threadManager :: TVar (HashMap.HashMap ThreadId WorkflowThread)
  }


data IVar a = IVar
  { ivar :: {-# UNPACK #-} !(TMVar a)
  , blocks :: {-# UNPACK #-} !(TVar (HashMap.HashMap ThreadId WorkflowThread))
  , manager :: {-# UNPACK #-} !ThreadManager
  -- ^ Shared manager
  }


instance Typeable a => Show (IVar a) where
  show _ = "IVar<" <> show (typeRep (Proxy :: Proxy a)) <> ">"


newIVar :: MonadIO m => ThreadManager -> m (IVar a)
newIVar m = IVar <$> newEmptyTMVarIO <*> newTVarIO mempty <*> pure m


newIVarSTM :: ThreadManager -> STM (IVar a)
newIVarSTM manager = do
  ivar <- newEmptyTMVar
  blocks <- newTVar mempty
  pure $ IVar ivar blocks manager


class MonadIVar m where
  putIVar :: IVar a -> a -> m ()
  tryReadIVar :: IVar a -> m (Maybe a)


instance MonadIVar STM where
  putIVar IVar {ivar, blocks} x = void do
    _ <- tryPutTMVar ivar x
    currentlyBlocked <- readTVar blocks
    for_ currentlyBlocked (\blocked -> writeTVar blocked.workflowThreadBlocked False)
    writeTVar blocks mempty


  tryReadIVar IVar {ivar} = tryReadTMVar ivar


waitIVar :: (MonadLogger m, MonadIO m, Typeable a) => IVar a -> m a
waitIVar IVar {..} = do
  tid <- myThreadId
  join $ do
    atomically do
      threads <- readTVar $ threadManager manager
      let threadState = case HashMap.lookup tid threads of
            Just thread -> thread
            Nothing -> error ("waitIVar: Thread in map should exist " <> show tid)
      mval <- tryReadTMVar ivar
      case mval of
        Nothing -> do
          writeTVar threadState.workflowThreadBlocked True
          modifyTVar' blocks $ HashMap.insert tid threadState
          pure $ atomically $ readTMVar ivar
        Just val -> do
          pure $ pure val


-- | Use this to determine when we want to flush things to the server.
waitAllThreadsBlocked :: HasThreadManager r => r -> STM ()
waitAllThreadsBlocked runtime = do
  threads <- readTVar $ threadManager $ getThreadManager runtime
  blockingState <- mapM (readTVar . workflowThreadBlocked) threads
  let allBlocked = and blockingState
  guard allBlocked


markBlockedState :: HasThreadManager r => r -> Bool -> STM ()
markBlockedState runtime blockedOrNot = do
  tid <- unsafeIOToSTM myThreadId
  threads <- readTVar $ threadManager $ getThreadManager runtime
  case HashMap.lookup tid threads of
    Just thread -> writeTVar thread.workflowThreadBlocked blockedOrNot
    Nothing -> error ("markBlockedState: " <> show tid <> " not found")


deregisterThread :: HasThreadManager r => r -> ThreadId -> STM ()
deregisterThread runtime tid = do
  modifyTVar' (threadManager $ getThreadManager runtime) $ HashMap.delete tid


registerThread :: HasThreadManager r => r -> ThreadId -> STM ()
registerThread runtime tid = do
  isBlocked <- newTVar False
  modifyTVar'
    (threadManager $ getThreadManager runtime)
    (HashMap.insert tid $ WorkflowThread isBlocked)


waitThreadsRegistered :: (HasThreadManager r, Foldable t) => r -> t ThreadId -> STM ()
waitThreadsRegistered runtime threads = do
  tm <- readTVar $ threadManager $ getThreadManager runtime
  guard $ all (`HashMap.member` tm) threads

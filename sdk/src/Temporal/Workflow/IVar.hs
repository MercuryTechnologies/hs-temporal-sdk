{-# LANGUAGE TemplateHaskell #-}
module Temporal.Workflow.IVar where
import Control.Concurrent.STM (retry)
import Control.Monad
import Control.Monad.Reader.Class
import Data.Foldable
import qualified Data.Text as Text
import qualified Data.HashMap.Strict as HashMap
import UnliftIO
import UnliftIO.Concurrent
import Control.Monad.Logger
import Data.Typeable
import GHC.Conc (unsafeIOToSTM)


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

putIVar :: IVar a -> a -> STM ()
putIVar IVar{ivar, blocks} x = void do
  _ <- tryPutTMVar ivar x
  currentlyBlocked <- readTVar blocks
  for_ currentlyBlocked (\blocked -> writeTVar blocked.workflowThreadBlocked False)
  writeTVar blocks mempty

waitIVar :: (MonadLogger m, MonadIO m, Typeable a) => IVar a -> m a
waitIVar IVar{..} = do
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
          pure $ do
            x <- atomically $ readTMVar ivar
            pure x
        Just val -> pure do
          pure val

-- | Use this to determine when we want to flush things to the server.
waitAllBlocked :: HasThreadManager r => r -> STM ()
waitAllBlocked runtime = do
  threads <- readTVar $ threadManager $ getThreadManager runtime
  allBlocked <- and <$> mapM (readTVar . workflowThreadBlocked) threads
  guard allBlocked

markBlockedState :: HasThreadManager r => r -> Bool -> STM ()
markBlockedState runtime blockedOrNot = do
  tid <- unsafeIOToSTM myThreadId
  threads <- readTVar $ threadManager $ getThreadManager runtime
  case HashMap.lookup tid threads of
    Just thread -> writeTVar thread.workflowThreadBlocked blockedOrNot
    Nothing -> error ("markBlockedState: " <> show tid <> " not found")

{-# LANGUAGE TemplateHaskell #-}
module Temporal.Workflow.IVar where
import Control.Concurrent.STM (retry)
import Control.Monad
import Control.Monad.Reader.Class
import Debug.Trace
import qualified Data.Text as Text
import qualified Data.HashMap.Strict as HashMap
import UnliftIO
import UnliftIO.Concurrent
import Control.Monad.Logger

data WorkflowThread = WorkflowThread
  { workflowThreadBlocked :: {-# UNPACK #-} !(TVar Bool)
  }

cancelWorkflowThreadNoWait :: MonadIO m => ThreadId -> m ()
cancelWorkflowThreadNoWait thread = do
  throwTo thread AsyncCancelled

class HasThreadManager a where
  threadManager :: a -> TVar (HashMap.HashMap ThreadId WorkflowThread)

data IVar a = IVar
  { ivar :: {-# UNPACK #-} !(TMVar a)
--  , name :: {-# UNPACK #-} !Text
  }

-- instance Show (IVar a) where
--   show IVar{name} = "IVar<" <> show name <> ">"

newIVar :: MonadIO m => m (IVar a)
newIVar = IVar <$> newEmptyTMVarIO

putIVar :: IVar a -> a -> STM ()
putIVar IVar{ivar} x = void $ tryPutTMVar ivar x

waitIVar :: (MonadLogger m, MonadIO m, MonadReader r m, HasThreadManager r) => IVar a -> m a
waitIVar IVar{ivar} = do
  inst <- ask
  tid <- myThreadId
  let tidText = Text.pack (show tid)
  join $ do
    $(logDebug) "trying to read ivar"
    atomically do
      threads <- readTVar $ threadManager inst
      let threadState = case HashMap.lookup tid threads of
            Just thread -> thread
            Nothing -> error ("waitIVar: Thread in map should exist " <> show tid)
      mval <- tryReadTMVar ivar
      case mval of
        Nothing -> do
          writeTVar threadState.workflowThreadBlocked True
          pure $ do
            $(logDebug) ("wait for ivar " <> tidText)
            x <- atomically $ do
              writeTVar threadState.workflowThreadBlocked False
              readTMVar ivar
            $(logDebug) ("read ivar with blocking " <> tidText)
            pure x
        Just val -> pure do
          $(logDebug) ("read ivar without blocking " <> tidText)
          pure val

-- | Use this to determine when we want to flush things to the server.
waitAllBlocked :: HasThreadManager r => r -> STM ()
waitAllBlocked runtime = do
  threads <- readTVar $ threadManager runtime
  traceM "waiting for all blocked"
  allBlocked <- and <$> mapM (readTVar . workflowThreadBlocked) threads
  guard allBlocked
  traceM "all blocked"

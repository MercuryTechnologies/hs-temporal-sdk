{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Common where
import Control.Concurrent.Async hiding (cancel)
import qualified Control.Concurrent.Async as Async
import Control.Concurrent.MVar
import Control.Concurrent.STM
import Control.Exception
import Control.Monad
import Control.Monad.IO.Class
import Data.Hashable (Hashable)
import Data.Text (Text)

newtype WorkflowType = WorkflowType Text
  deriving (Eq, Ord, Show, Hashable)
newtype WorkflowId = WorkflowId Text
  deriving (Eq, Ord, Show, Hashable)
newtype Namespace = Namespace Text
  deriving (Eq, Ord, Show, Hashable)
newtype RunId = RunId { rawRunId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype PatchId = PatchId Text
  deriving (Eq, Ord, Show, Hashable)
newtype TaskQueue = TaskQueue Text
  deriving (Eq, Ord, Show, Hashable)
newtype ActivityId = ActivityId Text
  deriving (Eq, Ord, Show, Hashable)
newtype SignalId = SignalId Text
  deriving (Eq, Ord, Show, Hashable)
newtype TimerId = TimerId Text
  deriving (Eq, Ord, Show, Hashable)
newtype CancellationId = CancellationId Text
  deriving (Eq, Ord, Show, Hashable)
-- | Errors that are an issue with the worker itself, not the workflow
--
-- These errors should cause the worker to exit, and imply an issue with the
-- SDK itself.
data RuntimeError = RuntimeError String
  deriving (Show)
instance Exception RuntimeError

data ApplicationError 
  = WorkflowNotFound String
  deriving (Show)
instance Exception ApplicationError

data ValueError
  = ValueError String
  deriving (Show)
instance Exception ValueError

{-
Class hierarchy of promise-like types:

class 
-}

class Awaitable m a where
  type AwaitResult a
  await :: a -> m (AwaitResult a) 

instance MonadIO m => Awaitable m (Async a) where
  type AwaitResult (Async a) = a
  await = liftIO . wait

instance MonadIO m => Awaitable m (MVar a) where
  type AwaitResult (MVar a) = a
  await = liftIO . readMVar

instance Awaitable STM (TMVar a) where
  type AwaitResult (TMVar a) = a
  await = readTMVar

class Monad m => Cancelable m a where
  cancel :: a -> m ()

instance MonadIO m => Cancelable m (Async a) where
  cancel = liftIO . Async.cancel

class Monad m => Resolvable m a where
  resolve :: a -> AwaitResult a -> m ()

instance MonadIO m => Resolvable m (MVar a) where
  resolve m v = void $ liftIO $ tryPutMVar m v

class Monad m => ResolveFallible m e a where
  resolveFailure :: a -> e -> m ()

instance (MonadIO m, Exception e) => ResolveFallible m e (Async a) where
  resolveFailure a e = liftIO $ Async.cancelWith a e

class Monad m => AwaitFallible m e a where
  type AwaitFailure a
  awaitEither :: a -> m (Either e (AwaitResult a))

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
import Data.ProtoLens
import Lens.Family2
import qualified Proto.Google.Protobuf.Duration as Duration
import qualified Proto.Google.Protobuf.Duration_Fields as Duration
import qualified Proto.Google.Protobuf.Timestamp as Timestamp
import qualified Proto.Google.Protobuf.Timestamp_Fields as Timestamp
import qualified System.Clock as Clock

-- | This is generally the name of the function itself
newtype WorkflowType = WorkflowType { rawWorkflowType :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype WorkflowId = WorkflowId { rawWorkflowId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype Namespace = Namespace { rawNamespace :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype RunId = RunId { rawRunId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype PatchId = PatchId { rawPatchId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype TaskQueue = TaskQueue { rawTaskQueue :: Text }
  deriving (Eq, Ord, Show, Hashable)
-- | Unique identifier for an activity within a workflow.
newtype ActivityId = ActivityId { rawActivityId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype SignalId = SignalId { rawSignalId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype TimerId = TimerId { rawTimerId :: Text }
  deriving (Eq, Ord, Show, Hashable)
newtype CancellationId = CancellationId { rawCancellationId :: Text }
  deriving (Eq, Ord, Show, Hashable)

timespecFromDuration :: Duration.Duration -> Clock.TimeSpec
timespecFromDuration d = Clock.TimeSpec
  { Clock.sec = d ^. Duration.seconds
  , Clock.nsec = fromIntegral (d ^. Duration.nanos)
  }

timespecToDuration :: Clock.TimeSpec -> Duration.Duration
timespecToDuration ts = defMessage
  & Duration.seconds .~ Clock.sec ts
  & Duration.nanos .~ fromIntegral (Clock.nsec ts)

timespecFromTimestamp :: Timestamp.Timestamp -> Clock.TimeSpec
timespecFromTimestamp ts = Clock.TimeSpec
  { Clock.sec = ts ^. Timestamp.seconds
  , Clock.nsec = fromIntegral (ts ^. Timestamp.nanos)
  }

timespecToTimestamp :: Clock.TimeSpec -> Timestamp.Timestamp
timespecToTimestamp ts = defMessage
  & Timestamp.seconds .~ Clock.sec ts
  & Timestamp.nanos .~ fromIntegral (Clock.nsec ts)

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

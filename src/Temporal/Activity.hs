{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
module Temporal.Activity 
  ( Activity
  , defineActivity
  , ActivityDefinition
  , ValidActivityFunction
  , ActivityInfo(..)
  , CompleteAsync(..)
  , completeAsync
  , ActivityCancelReason(..)
  ) where
import UnliftIO
import Control.Monad.Reader
import Data.ByteString (ByteString)
import Data.Proxy
import Data.Text (Text)
import Data.Time.Clock
import Temporal.Common
import Temporal.Payloads

data ActivityCancelReason 
  = GoneFromServer
  -- ^ The activity no longer exists on the server (may already be completed or its workflow
  -- may be completed).
  | CancelRequested
  -- ^ The was explicitly cancelled.
  | Timeout
  -- ^ Activity timeout caused the activity to marked cancelled.
  | WorkerShutdown
  -- ^ The worker the activity is running is shutting down.
  | HeartbeatRecordFailuer
  -- ^ Failed to record heartbeat. This usually only happens if the payload converter fails.

type ValidActivityFunction env fmt f = (ToPayloads fmt (ArgsOf f), Codec fmt (ResultOf (Activity env) f))
data SomeSerializableFunction env = forall fmt f. (ValidActivityFunction env fmt f) => SomeSerializableFunction (Proxy fmt) f

data ActivityDefinition env = ActivityDefinition
  { activityName :: Text
  , activityRun :: SomeSerializableFunction env
  }


data ActivityInfo = ActivityInfo
  { activityId :: ActivityId
  , activityType :: Text
  , attempt :: Int
  , currentAttemptScheduledTime :: UTCTime
  , heartbeatDetails :: ()
  , heartbeatTimeout :: Maybe NominalDiffTime
  , isLocal :: Bool
  , scheduleToCloseTimeout :: Maybe NominalDiffTime
  , scheduledTime :: UTCTime
  , startToCloseTimeout :: Maybe NominalDiffTime
  , startedTime :: UTCTime
  , taskQueue :: TaskQueue
  , taskToken :: ByteString
  , workflowId :: WorkflowId
  , workflowNamespace :: Namespace
  , workflowRunId :: RunId
  , workflowType :: WorkflowType
  }

-- | An activity is a unit of work that is executed by a worker. It is a specialized function call
-- that can be executed one or more times, and can be cancelled while it is running.
newtype Activity env a = Activity { unActivity :: ReaderT (ActivityInfo, env) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadUnliftIO)

data CompleteAsync = CompleteAsync
  deriving (Show)
instance Exception CompleteAsync

completeAsync :: MonadIO m => m ()
completeAsync = throwIO CompleteAsync

defineActivity :: (ValidActivityFunction env fmt f) => Proxy fmt -> Text -> f -> ActivityDefinition env
defineActivity p name f = ActivityDefinition
  { activityName = name
  , activityRun = SomeSerializableFunction p f
  }

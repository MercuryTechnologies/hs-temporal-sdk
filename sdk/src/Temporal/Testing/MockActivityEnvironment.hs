module Temporal.Testing.MockActivityEnvironment (
  MockActivityEnvironment (..),
  runMockActivity,
  mkMockActivityEnvironment,
) where

import Control.Exception (Exception (..), throw)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.IORef (newIORef)
import qualified Data.Map.Strict as Map
import Data.Time.Clock (UTCTime (..))
import Data.Time.Clock.System (systemEpochDay, utcToSystemTime)
import Temporal.Activity.Definition (Activity, ActivityEnv (..), runActivity)
import Temporal.Activity.Types (ActivityInfo (..))
import qualified Temporal.Core.Worker as Worker
import qualified Temporal.Duration as Duration
import Temporal.Payload (JSON (..), PayloadProcessor, mkPayloadProcessor)


{- | Environment for testing a Temporal 'Activity'.

This environment is used with 'runMockActivity' to execute activity code in
in 'IO', without any associated Temporal runtime.

__NOTE__: This type provides stubs for all 'Activity' functionality /except/
for Temporal Worker Client calls; in the presence of these, the mocked
environment will throw an impure exception.

We may stub out this interface a little more in the future, but the client's
API surface area is pretty large.
-}
data MockActivityEnvironment env = MockActivityEnvironment
  { info :: {-# UNPACK #-} !ActivityInfo
  , payloadProcessor :: {-# UNPACK #-} !PayloadProcessor
  , recordHeartbeat :: Worker.ActivityHeartbeat -> IO (Either Worker.WorkerError ())
  , workerConfig :: {-# UNPACK #-} !Worker.WorkerConfig
  , env :: env
  }


{- | Run a Temporal 'Activity' in a mocked environment — without access to a
Temporal runtime — and return its result in 'IO'.

See 'MockActivityEnvironment' and 'mkMockActivityEnvironment' for additional
usage details.

__NOTE__: Any 'Activity' that makes Temporal Worker Client calls (e.g. via
'askActivityClient') will lazily throw an 'IllegalWorkerClientException'.
-}
runMockActivity :: MonadIO m => MockActivityEnvironment env -> Activity env a -> m a
runMockActivity env activity = do
  let
    actEnv =
      ActivityEnv
        env.info
        mempty
        env.payloadProcessor
        env.recordHeartbeat
        env.workerConfig
        (throw IllegalWorkerClientException)
        env.env
  liftIO $ runActivity actEnv activity


{- | Create a 'MockActivityEnvironment' with reasonable defaults for testing:

    * scheduled and started times set to the Unix Epoch
    * all durations set to 1 second
    * empty 'headerFields'
    * no retry policy
    * 'JSON' payload processor
    * no-op 'recordHeartbeat' function
    * default worker config

These fields can be customized as-needed for testing purposes, this function
is just meant to provide a starting point that (should) run most activities.
-}
mkMockActivityEnvironment :: MonadIO m => env -> m (MockActivityEnvironment env)
mkMockActivityEnvironment env = do
  rawHeartbeatDetails <- liftIO $ newIORef mempty
  let info =
        ActivityInfo
          { activityId = "test"
          , activityType = "unknown"
          , attempt = 0
          , currentAttemptScheduledTime = utcToSystemTime $ UTCTime systemEpochDay 0
          , headerFields = Map.empty
          , heartbeatTimeout = Nothing
          , isLocal = False
          , rawHeartbeatDetails
          , retryPolicy = Nothing
          , runId = "test-run"
          , scheduleToCloseTimeout = Just $ Duration.seconds 1
          , scheduledTime = utcToSystemTime $ UTCTime systemEpochDay 0
          , startToCloseTimeout = Just $ Duration.seconds 1
          , startedTime = utcToSystemTime $ UTCTime systemEpochDay 0
          , taskQueue = "test"
          , taskToken = "test"
          , workflowId = "test"
          , workflowNamespace = "default"
          , workflowType = "test"
          }
      payloadProcessor = mkPayloadProcessor JSON
      recordHeartbeat _ = pure (Right ())
      workerConfig = Worker.defaultWorkerConfig
  pure
    MockActivityEnvironment
      { info
      , payloadProcessor
      , recordHeartbeat
      , workerConfig
      , env
      }


{- | Structured exception type indicating that the 'Activity' under test
attempted to access a Temporal Worker, which we cannot support within
'MockActivityEnvironment'.
-}
data IllegalWorkerClientException = IllegalWorkerClientException
  deriving stock (Show)


instance Exception IllegalWorkerClientException where
  displayException e = show e <> ": Temporal Worker Client calls are not supported within 'MockActivityEnvironment'"

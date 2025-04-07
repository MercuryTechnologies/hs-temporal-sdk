{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

{- |
Module: Temporal.Activity
Description: Define and work with Temporal activities.

Temporal activities are units of work in a Temporal workflow. They encapsulate
a specific task or operation that needs to be executed within a workflow
instance. Activities can be synchronous or asynchronous and are designed to
perform external actions, such as interacting with databases, sending emails,
or invoking external services.

When writing activities to execute withing a workflow, we recommend writing
them while keeping the following principles in mind:

1. __Retryable__: Activities can be automatically retried by the Temporal
   system in case of failures. You can configure the retry behavior, such as
   the maximum number of retries and retry intervals.

2. __Idempotency__: Since Activities are designed to be retryable,
   executing an activity multiple times should not have unintended side
   effects. This is crucial for ensuring the reliability of workflow
   executions.

3. __Cancellable__: Activities can be cancelled, which means that they can
   be stopped before they complete execution. This is useful for handling
   long-running activities that need to be aborted in certain situations.
   As a consequence, activities should to be written to receive 'ActivityCancelReason'
   exceptions asynchronously.
-}
module Temporal.Activity (
  Activity,

  -- * Built-in Activity primitives
  withHeartbeat,
  rawHeartbeat,
  getRawHeartbeat,
  ActivityInfo (..),
  askActivityInfo,
  ActivityCancelReason (..),
  activityWorkflowClient,
  askActivityClient,
  mapActivityEnv,

  -- * Defining Activities
  provideActivity,
  ProvidedActivity (..),
  mapProvidedActivityEnv,
  KnownActivity (..),
  ActivityDefinition (..),
  mapActivityDefinitionEnv,

  -- * Asynchronous Completion
  TaskToken (..),
  CompleteAsync (..),
  completeAsync,

  -- * Commonly used
  (:->:),
) where

import Control.Monad
import Control.Monad.IO.Class
import Control.Monad.Reader.Class
import Data.ProtoLens
import Data.Proxy
import Data.Text (Text)
import qualified Data.Vector as V
import Lens.Family2
import qualified Proto.Temporal.Sdk.Core.CoreInterface_Fields as Proto
import Temporal.Activity.Definition
import Temporal.Activity.Types
import Temporal.Activity.Worker
import Temporal.Client
import Temporal.Common
import Temporal.Core.Worker (getWorkerClient, recordActivityHeartbeat)
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.Types
import UnliftIO


{- | A utility function for constructing an 'ActivityDefinition' from a function as well as
a 'KnownActivity' value. This is useful for keeping the argument, codec, and result types
in sync with each other so that changes to the function are reflected at their use sites.

> myActivity :: Activity env ()
> myActivity = liftIO $ putStrLn "Hello world!"
>
> myActivityDef :: ProvidedActivity env (Activity env ())
> myActivityDef = provideActivity
>   JSON -- codec for serializing arguments and results
>   "myActivity" -- visible name of the workflow
>   myActivity -- the workflow function
-}
provideActivity
  :: forall codec env f
   . ( f ~ (ArgsOf f :->: Activity env (ResultOf (Activity env) f))
     , FunctionSupportsCodec codec (ArgsOf f) (ResultOf (Activity env) f)
     )
  => codec
  -> Text
  -> f
  -> ProvidedActivity env f
provideActivity codec name f =
  ProvidedActivity
    { definition =
        ActivityDefinition
          { activityName = name
          , activityRun = \input -> do
              eAct <-
                liftIO $
                  applyPayloads
                    codec
                    (Proxy @(ArgsOf f))
                    (Proxy @(Activity env (ResultOf (Activity env) f)))
                    f
                    input.activityArgs
              traverse (>>= (liftIO . encode codec)) eAct
          }
    , reference =
        KnownActivity
          { knownActivityCodec = codec
          , knownActivityName = name
          }
    }


{- |
An Activity Heartbeat is a ping from the Worker Process that is executing the Activity to the Temporal Cluster. Each Heartbeat informs the Temporal Cluster that the Activity Execution is making progress and the Worker has not crashed. If the Cluster does not receive a Heartbeat within a Heartbeat Timeout time period, the Activity will be considered failed and another Activity Task Execution may be scheduled according to the Retry Policy.

Heartbeats may not always be sent to the Cluster—they may be throttled by the Worker.

Activity Cancellations are delivered to Activities from the Cluster when they Heartbeat. Activities that don't Heartbeat can't receive a Cancellation. Heartbeat throttling may lead to Cancellation getting delivered later than expected.

Heartbeats can contain payloads describing the Activity's current progress. If an Activity gets retried, the Activity can access the details from the last Heartbeat that was sent to the Cluster.
-}
rawHeartbeat :: V.Vector Payload -> Activity env ()
rawHeartbeat baseDetails = do
  (TaskToken token) <- taskToken <$> askActivityInfo
  recordHeartbeat <- askActivityRecordHeartbeat
  info <- askActivityInfo
  let details =
        defMessage
          & Proto.taskToken .~ token
          & Proto.vec'details .~ fmap convertToProtoPayload baseDetails
  -- TODO throw exception if this fails?
  void $ liftIO do
    writeIORef info.rawHeartbeatDetails baseDetails
    recordHeartbeat details


getRawHeartbeat :: Activity env (V.Vector Payload)
getRawHeartbeat = do
  info <- askActivityInfo
  liftIO $ readIORef info.rawHeartbeatDetails


{- |
This function is useful for writing activities that need to send and receive
heartbeat details.

This function provides a safer interface for ensuring that the heartbeat details
are properly encoded and decoded using the given codec into the given type that
you want to use.

Example:

@
data CursorState = CursorState
  { cursorOffset :: String
  } deriving (Generic, Show, Eq)

instance ToJSON CursorState
instance FromJSON CursorState

yourActivity :: Activity env ()
yourActivity = withHeartbeat JSON $ \heartbeat readHeartbeat -> do
  mCursor <- readHeartbeat
  case mCursor of
    Nothing -> do
      -- do something with the cursor
      heartbeat (CursorState "0")
    Just cursor -> do
      -- do something with the cursor, recovering from some previous activity failure
      heartbeat cursor
@
-}
withHeartbeat :: forall a b env codec. Codec codec a => codec -> ((a -> Activity env ()) -> Activity env (Maybe a) -> Activity env b) -> Activity env b
withHeartbeat codec f = do
  act <- askActivityInfo
  let performHeartbeat x = do
        res <- liftIO $ encode codec x
        rawHeartbeat $ pure res

      readHeartbeatValue = do
        details <- liftIO $ readIORef act.rawHeartbeatDetails
        case details V.!? 0 of
          Nothing -> pure Nothing
          Just payload -> do
            res <- liftIO $ decode codec payload
            case res of
              Left err -> throwIO $ ValueError err
              Right a -> pure $ Just a
  f performHeartbeat readHeartbeatValue


{- | It is very common for an Activity to do things that interact
with another Workflow, like using 'query' or 'signal'. This function
provides a 'WorkflowClient' that can be used to accomplish that.
-}
activityWorkflowClient :: Activity env WorkflowClient
activityWorkflowClient = Activity $ do
  e <- ask
  workflowClient e.activityWorkerClient $
    WorkflowClientConfig
      { namespace = e.activityInfo.workflowNamespace
      , interceptors = e.activityClientInterceptors
      , payloadProcessor = e.activityPayloadProcessor
      , enableTimeSkipping = False
      }


instance HasWorkflowClient (Activity env) where
  askWorkflowClient = activityWorkflowClient

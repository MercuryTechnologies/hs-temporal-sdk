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

  -- * Built-in Acitivity primitives
  heartbeat,
  ActivityInfo (..),
  askActivityInfo,
  ActivityCancelReason (..),
  activityWorkflowClient,
  askActivityClient,

  -- * Defining Activities
  provideActivity,
  ProvidedActivity (..),
  KnownActivity (..),
  ActivityDefinition (..),
  ValidActivityFunction,

  -- * Asynchronous Completion
  TaskToken (..),
  CompleteAsync (..),
  completeAsync,
) where

import Control.Monad
import Control.Monad.IO.Class
import Control.Monad.Reader.Class
import Data.ProtoLens
import Data.Proxy
import Data.Text (Text)
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


{- | A utility function for constructing an 'ActivityDefinition' from a function as well as
a 'KnownActivity' value. This is useful for keeping the argument, codec, and result types
in sync with each other so that changes to the function are reflected at their use sites.

> myActivity :: Activity env ()
> myActivity = liftIO $ putStrLn "Hello world!"
>
> myActivityDef :: ActivityDefinition env (Activity env ())
> myActivityDef = provideWorkflow
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
          , activityRun = \actEnv input -> do
              eAct <-
                applyPayloads
                  codec
                  (Proxy @(ArgsOf f))
                  (Proxy @(Activity env (ResultOf (Activity env) f)))
                  f
                  input.activityArgs
              traverse (runActivity actEnv >=> encode codec) eAct
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
heartbeat :: [Payload] -> Activity env ()
heartbeat baseDetails = do
  (TaskToken token) <- taskToken <$> askActivityInfo
  worker <- askActivityWorker
  let details =
        defMessage
          & Proto.taskToken .~ token
          & Proto.details .~ fmap convertToProtoPayload baseDetails
  -- TODO throw exception if this fails?
  void $ liftIO $ recordActivityHeartbeat worker details


{- | It is very common for an Activity to do things that interact
with another Workflow, like using 'query' or 'signal'. This function
provides a 'WorkflowClient' that can be used to accomplish that.
-}
activityWorkflowClient :: Activity env WorkflowClient
activityWorkflowClient = Activity $ do
  e <- ask
  workflowClient (getWorkerClient e.activityWorker) $
    WorkflowClientConfig
      { namespace = e.activityInfo.workflowNamespace
      , interceptors = e.activityClientInterceptors
      , payloadProcessor = e.activityPayloadProcessor
      }


instance HasWorkflowClient (Activity env) where
  askWorkflowClient = activityWorkflowClient

{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
module Temporal.Activity 
  ( Activity
  , provideActivity
  , ProvidedActivity(..)
  , ActivityDefinition
  , IsValidActivityFunction
  , ValidActivityFunction
  , heartbeat
  , ActivityInfo(..)
  , askActivityInfo
  , CompleteAsync(..)
  , completeAsync
  , ActivityCancelReason(..)
  , TaskToken
  ) where

import Control.Exception
import Control.Monad
import Control.Monad.IO.Class
import Data.ProtoLens
import Data.Proxy
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Typeable
import GHC.TypeLits
import Lens.Family2
import Temporal.Exception
import Temporal.Activity.Definition
import Temporal.Activity.Worker
import Temporal.Common
import Temporal.Core.Worker (recordActivityHeartbeat)
import Temporal.Payload
import Temporal.Workflow
import Temporal.Workflow.WorkflowDefinition
import Temporal.Worker.Types

import qualified Proto.Temporal.Sdk.Core.CoreInterface_Fields as Proto

-- | A utility function for constructing an 'ActivityDefinition' from a function as well as
-- a 'KnownActivity' value. This is useful for keeping the argument, codec, and result types
-- in sync with each other so that changes to the function are reflected at their use sites.
--
-- > myActivity :: Activity env ()
-- > myActivity = liftIO $ putStrLn "Hello world!"
-- >
-- > myActivityDef :: ActivityDefinition env (Activity env ())
-- > myActivityDef = provideWorkflow 
-- >   JSON -- codec for serializing arguments and results
-- >   "myActivity" -- visible name of the workflow
-- >   myActivity -- the workflow function
provideActivity :: forall codec name env f.
  ( IsValidActivityFunction env codec f
  , GatherArgs codec (ArgsOf f)
  , (ArgsOf f :->: Activity env (ResultOf (Activity env) f)) ~ f
  , Typeable (ResultOf (Activity env) f)
  ) => codec -> Text -> f -> ProvidedActivity env f
provideActivity codec name f = ProvidedActivity
  { definition = ActivityDefinition
      { activityName = name
      , activityRun = ValidActivityFunction 
          codec 
          f 
          (applyPayloads codec (Proxy @(ArgsOf f)) (Proxy @(Activity env (ResultOf (Activity env) f))) f)
      }
  , reference = KnownActivity
      { knownActivityCodec = codec
      , knownActivityQueue = Nothing
      , knownActivityName = name
      }
  }

data ProvidedActivity env f = ProvidedActivity
  { definition :: ActivityDefinition env
  , reference :: KnownActivity (ArgsOf f) (ResultOf (Activity env) f)
  }

{- |
An Activity Heartbeat is a ping from the Worker Process that is executing the Activity to the Temporal Cluster. Each Heartbeat informs the Temporal Cluster that the Activity Execution is making progress and the Worker has not crashed. If the Cluster does not receive a Heartbeat within a Heartbeat Timeout time period, the Activity will be considered failed and another Activity Task Execution may be scheduled according to the Retry Policy.

Heartbeats may not always be sent to the Cluster—they may be throttled by the Worker.

Activity Cancellations are delivered to Activities from the Cluster when they Heartbeat. Activities that don't Heartbeat can't receive a Cancellation. Heartbeat throttling may lead to Cancellation getting delivered later than expected.

Heartbeats can contain a details field describing the Activity's current progress. If an Activity gets retried, the Activity can access the details from the last Heartbeat that was sent to the Cluster.
-}
heartbeat :: [RawPayload] -> Activity env ()
heartbeat baseDetails = do
  (TaskToken token) <- taskToken <$> askActivityInfo
  worker <- askActivityWorker
  let details = defMessage 
        & Proto.taskToken .~ token
        & Proto.details .~ fmap convertToProtoPayload baseDetails
  -- TODO throw exception if this fails?
  void $ liftIO $ recordActivityHeartbeat worker details

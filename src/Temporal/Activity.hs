{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
module Temporal.Activity 
  ( Activity
  , provideActivity
  , ActivityDefinition
  , ValidActivityFunction
  , heartbeat
  , ActivityInfo(..)
  , askActivityInfo
  , CompleteAsync(..)
  , completeAsync
  , ActivityCancelReason(..)
  ) where

import Control.Exception
import Control.Monad
import Control.Monad.IO.Class
import Data.ProtoLens
import Data.Proxy
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.TypeLits
import Lens.Family2
import Temporal.Exception
import Temporal.Activity.Definition
import Temporal.Activity.Worker
import Temporal.Common
import Temporal.Core.Worker (recordActivityHeartbeat)
import Temporal.Payload
import Temporal.Workflow
import Temporal.Worker.Types

import qualified Proto.Temporal.Sdk.Core.CoreInterface_Fields as Proto

provideActivity :: forall codec name env f.
  ( IsValidActivityFunction env codec f
  , StartActivityArgs codec (ArgsOf f) (ResultOf (Activity env) f)
  , (ArgsOf f :->: Activity env (ResultOf (Activity env) f)) ~ f
  ) => codec -> Text -> f -> (ActivityDefinition env, KnownActivity (ArgsOf f) (ResultOf (Activity env) f))
provideActivity codec name f = 
  ( ActivityDefinition
      { activityName = name
      , activityRun = ValidActivityFunction 
          codec 
          f 
          (applyPayloads codec (Proxy @(ArgsOf f)) (Proxy @(Activity env (ResultOf (Activity env) f))) f)
      }
  , KnownActivity
      { knownActivityCodec = codec
      , knownActivityQueue = Nothing
      , knownActivityName = name
      }
  )

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

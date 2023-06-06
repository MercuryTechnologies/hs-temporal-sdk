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

import Control.Exception
import Control.Monad.IO.Class
import Data.Text (Text)
import Temporal.Exception
import Temporal.Activity.Definition
import Temporal.Activity.Worker
import Temporal.Payload
import Temporal.Worker.Types

defineActivity :: forall codec env f.
  ( IsValidActivityFunction env codec f
  ) => codec -> Text -> f -> ActivityDefinition env
defineActivity codec name f = ActivityDefinition
  { activityName = name
  , activityRun = ValidActivityFunction codec f applyPayloads
  }

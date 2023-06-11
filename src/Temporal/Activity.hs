module Temporal.Activity 
  ( Activity
  , provideActivity
  , ActivityDefinition
  , ValidActivityFunction
  , ActivityInfo(..)
  , CompleteAsync(..)
  , completeAsync
  , ActivityCancelReason(..)
  ) where

import Control.Exception
import Control.Monad.IO.Class
import Data.Proxy
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.TypeLits
import Temporal.Exception
import Temporal.Activity.Definition
import Temporal.Activity.Worker
import Temporal.Payload
import Temporal.Workflow
import Temporal.Worker.Types

provideActivity :: forall codec name env f.
  ( IsValidActivityFunction env codec f
  , AllArgsSupportCodec codec (ArgsOf f)
  , KnownSymbol name
  , StartActivityArgs codec (ArgsOf f) (ResultOf (Activity env) f)
  ) => codec -> Proxy name -> f -> (ActivityDefinition env, KnownActivity name (ArgsOf f) (ResultOf (Activity env) f))
provideActivity codec name f = 
  ( ActivityDefinition
      { activityName = Text.pack $ symbolVal name
      , activityRun = ValidActivityFunction codec f applyPayloads
      }
  , KnownActivity
      { knownActivityCodec = codec
      , knownActivityQueue = Nothing
      }
  )

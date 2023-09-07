{-# LANGUAGE ScopedTypeVariables #-}
module Temporal.Workflow.Signal where
import Data.Kind
import Temporal.Payload
import Data.Text (Text)
import Data.Proxy
import Data.Vector (Vector)

data SignalRef (args :: [Type]) = forall codec. (ApplyPayloads codec args, GatherArgs codec args) => 
  SignalRef
    { signalName :: Text
    , signalCodec :: codec
    }

data SignalDefinition (args :: [Type]) =
  SignalDefinition 
    { signalRef :: SignalRef args
    , signalApply :: forall res. Proxy res -> (args :->: res) -> Vector RawPayload -> IO res
    }

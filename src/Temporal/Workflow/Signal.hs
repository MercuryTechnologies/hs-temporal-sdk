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
    { signalDefinitionRef :: SignalRef args
    , signalDefinitionApply :: forall res. Proxy res -> (args :->: res) -> Vector Payload -> IO res
    }

class HasSignalRef sig where
  type SignalArgs sig :: [Type]
  signalRef :: sig -> SignalRef (SignalArgs sig)

instance HasSignalRef (SignalRef args) where
  type SignalArgs (SignalRef args) = args
  signalRef = id

instance HasSignalRef (SignalDefinition args) where
  type SignalArgs (SignalDefinition args) = args
  signalRef (SignalDefinition ref _) = ref

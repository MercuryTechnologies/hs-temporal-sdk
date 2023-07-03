{-# LANGUAGE
  AllowAmbiguousTypes,
  ConstraintKinds,
  DataKinds,
  FunctionalDependencies,
  FlexibleContexts,
  FlexibleInstances,
  GADTs,
  InstanceSigs,
  MultiParamTypeClasses,
  QuantifiedConstraints,
  RankNTypes,
  ScopedTypeVariables,
  TypeOperators,
  TypeFamilies,
  TypeFamilyDependencies,
  UndecidableInstances,
  TypeApplications #-}
module Temporal.Workflow.WorkflowDefinition 
  ( WorkflowDefinition(..) -- TODO, only export the type, not the constructor from this module
  , ValidWorkflowFunction(..) -- TODO, move to internal
  , KnownWorkflow(..)
  , SignalDefinition(..)
  -- , StartChildWorkflow(..)
  , gatherStartChildWorkflowArgs
  , provideWorkflow
  , GatherArgs(..)
  ) where

import Data.Aeson hiding (encode, decode)
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as BL
import Data.Kind
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Typeable (Typeable)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Typeable
import Data.Vector (Vector)
import GHC.TypeLits
import Temporal.Common
import Temporal.Payload
import Temporal.Workflow.WorkflowInstance
import Temporal.Worker.Types

class GatherArgs codec (args :: [Type]) where
  gatherArgs 
    :: Proxy args 
    -> codec 
    -> ([IO RawPayload] -> [IO RawPayload]) 
    -> ([IO RawPayload] -> result)
    -> (args :->: result)

instance (Codec codec arg, GatherArgs codec args) => GatherArgs codec (arg ': args) where
  gatherArgs _ c accum f = \arg ->
    gatherArgs 
      (Proxy @args) 
      c 
      (accum . (encode c arg :))
      f

instance GatherArgs codec '[] where
  gatherArgs _ _ accum f = f $ accum []

-- | A 'KnownWorkflow' is a handle that contains all the information needed to start a 
-- Workflow either as a child workflow or as a top-level workflow via a 'Client'.
data KnownWorkflow (args :: [Type]) (result :: Type) = forall codec. 
  ( Codec codec result
  , GatherArgs codec args
  , Typeable result
  ) => KnownWorkflow 
        { knownWorkflowCodec :: codec 
        , knownWorkflowNamespace :: Maybe Namespace
        , knownWorkflowQueue :: Maybe TaskQueue
        , knownWorkflowName :: Text
        }

gatherStartChildWorkflowArgs 
  :: forall env st args result codec. GatherArgs codec args
  => codec 
  -> ([IO RawPayload] -> Workflow env st (ChildWorkflowHandle env st result)) 
  -> (args :->: Workflow env st (ChildWorkflowHandle env st result))
gatherStartChildWorkflowArgs c f = gatherArgs (Proxy @args) c id f

data SignalDefinition (args :: [Type]) = forall codec. GatherArgs codec args =>
  SignalDefinition 
    { signalName :: Text 
    , signalCodec :: codec
    , signalApply :: forall res. Proxy res -> (args :->: res) -> Vector RawPayload -> IO res
    }

-- | A utility function for constructing a 'WorkflowDefinition' from a function as well as
-- a 'KnownWorkflow' value. This is useful for keeping the argument, codec, and result types
-- in sync with each other so that changes to the function are reflected at their use sites.
--
-- > myWorkflow :: Workflow () () Int
-- > myWorkflow = pure 1
-- >
-- > myWorkflowDef :: (WorkflowDefinition () (), KnownWorkflow "myWorkflow" () Int)
-- > myWorkflowDef = provideWorkflow 
-- >   JSON -- codec
-- >   (Proxy @"myWorkflow") -- visible name of the workflow
-- >   () -- initial state
-- >   myWorkflow -- the workflow function
provideWorkflow :: forall env st name codec f.
  ( IsValidWorkflowFunction codec env st f
  -- , StartChildWorkflowArgs codec (ArgsOf f) (ResultOf (Workflow env st) f)
  , GatherArgs codec (ArgsOf f)
  , f ~ (ArgsOf f :->: Workflow env st (ResultOf (Workflow env st) f))
  ) => codec -> Text -> st -> f -> (WorkflowDefinition env st, KnownWorkflow (ArgsOf f) (ResultOf (Workflow env st) f))
provideWorkflow codec name st f = 
  ( WorkflowDefinition
    { workflowName = name
    , workflowInitialState = st
    , workflowRun = ValidWorkflowFunction 
        codec 
        f 
        (applyPayloads 
          codec 
          (Proxy @(ArgsOf f)) 
          (Proxy @(Workflow env st (ResultOf (Workflow env st) f)))
        )
    }
  , KnownWorkflow
    { knownWorkflowCodec = codec
    , knownWorkflowQueue = Nothing
    , knownWorkflowNamespace = Nothing
    , knownWorkflowName = name
    }
  )

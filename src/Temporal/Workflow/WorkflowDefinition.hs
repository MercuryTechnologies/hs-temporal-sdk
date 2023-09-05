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
  , SignalRef(..)
  , SignalDefinition(..)
  -- , StartChildWorkflow(..)
  , gatherStartChildWorkflowArgs
  , provideWorkflow
  , ProvidedWorkflow(..)
  , GatherArgs(..)
  , WorkflowRef(..)
  ) where

import Data.Kind
import Data.Text (Text)
import Data.Typeable
import Data.Vector (Vector)
import Temporal.Common
import Temporal.Payload
import Temporal.Worker.Types
import RequireCallStack

class WorkflowRef (f :: Type) where
  type WorkflowArgs f :: [Type]
  type WorkflowResult f :: Type
  workflowRef :: f -> KnownWorkflow (WorkflowArgs f) (WorkflowResult f)

instance WorkflowRef (KnownWorkflow args result) where
  type WorkflowArgs (KnownWorkflow args result) = args
  type WorkflowResult (KnownWorkflow args result) = result
  workflowRef = id

-- | A 'KnownWorkflow' is a handle that contains all the information needed to start a 
-- Workflow either as a child workflow or as a top-level workflow via a 'Client'.
data KnownWorkflow (args :: [Type]) (result :: Type) = forall codec. 
  ( FunctionSupportsCodec codec args result
  ) => KnownWorkflow 
        { knownWorkflowCodec :: codec 
        , knownWorkflowNamespace :: Maybe Namespace
        , knownWorkflowQueue :: Maybe TaskQueue
        , knownWorkflowName :: Text
        }

gatherStartChildWorkflowArgs 
  :: forall args result codec. GatherArgs codec args
  => codec 
  -> ([IO RawPayload] -> Workflow (ChildWorkflowHandle result)) 
  -> (args :->: Workflow (ChildWorkflowHandle result))
gatherStartChildWorkflowArgs c f = gatherArgs (Proxy @args) c id f

data SignalRef (args :: [Type]) = forall codec. (ApplyPayloads codec args, GatherArgs codec args) => 
  SignalRef
    { signalName :: Text
    , signalCodec :: codec
    }

data SignalDefinition (args :: [Type]) = forall codec. GatherArgs codec args =>
  SignalDefinition 
    { signalRef :: SignalRef args
    , signalApply :: forall res. Proxy res -> (args :->: res) -> Vector RawPayload -> IO res
    }

data ProvidedWorkflow f = ProvidedWorkflow
  { definition :: WorkflowDefinition
  , reference :: KnownWorkflow (ArgsOf f) (ResultOf Workflow f)
  }

instance HasWorkflowDefinition (ProvidedWorkflow f) where
  workflowDefinition :: ProvidedWorkflow f -> WorkflowDefinition
  workflowDefinition = definition

instance WorkflowRef (ProvidedWorkflow f) where
  type WorkflowArgs (ProvidedWorkflow f) = ArgsOf f
  type WorkflowResult (ProvidedWorkflow f) = ResultOf Workflow f
  workflowRef :: ProvidedWorkflow f -> KnownWorkflow (WorkflowArgs (ProvidedWorkflow f)) (WorkflowResult (ProvidedWorkflow f))
  workflowRef = reference

-- | A utility function for constructing a 'WorkflowDefinition' from a function as well as
-- a 'KnownWorkflow' value. This is useful for keeping the argument, codec, and result types
-- in sync with each other so that changes to the function are reflected at their use sites.
--
-- > myWorkflow :: Workflow () () Int
-- > myWorkflow = pure 1
-- >
-- > myWorkflowDef :: ProvidedWorkflow () () Int
-- > myWorkflowDef = provideWorkflow 
-- >   JSON -- codec
-- >   @"myWorkflow" -- visible name of the workflow
-- >   () -- initial state
-- >   myWorkflow -- the workflow function
provideWorkflow :: forall codec f.
  ( f ~ ArgsOf f :->: Workflow (ResultOf Workflow f)
  , FunctionSupportsCodec codec (ArgsOf f) (ResultOf Workflow f)) => codec -> Text -> (RequireCallStackImpl => f) -> ProvidedWorkflow f
provideWorkflow codec name f = provideCallStack $ ProvidedWorkflow
  { definition = WorkflowDefinition
    { workflowName = name
    , workflowRun = ValidWorkflowFunction 
        codec 
        f
        (applyPayloads 
          codec 
          (Proxy @(ArgsOf f)) 
          (Proxy @(Workflow (ResultOf Workflow f)))
        )
    }
  , reference = KnownWorkflow
    { knownWorkflowCodec = codec
    , knownWorkflowQueue = Nothing
    , knownWorkflowNamespace = Nothing
    , knownWorkflowName = name
    }
  }

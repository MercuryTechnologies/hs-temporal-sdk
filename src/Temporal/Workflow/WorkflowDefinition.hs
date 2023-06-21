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
  , knownWorkflowName
  , StartChildWorkflow(..)
  , StartChildWorkflowArgs(..)
  , gatherStartChildWorkflowArgs
  , provideWorkflow
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
import GHC.TypeLits
import Temporal.Common
import Temporal.Payload
import Temporal.Workflow.WorkflowInstance
import Temporal.Worker.Types

-- | A 'KnownWorkflow' is a handle that contains all the information needed to start a 
-- Workflow either as a child workflow or as a top-level workflow via a 'Client'.
data KnownWorkflow (name :: Symbol) (args :: [Type]) (result :: Type) = forall codec. 
  ( Codec codec result
  , AllArgsSupportCodec codec args
  , StartChildWorkflowArgs codec args result
  ) => KnownWorkflow 
        { knownWorkflowCodec :: codec 
        , knownWorkflowNamespace :: Maybe Namespace
        , knownWorkflowQueue :: Maybe TaskQueue
        }

knownWorkflowName :: forall name args result. KnownSymbol name => KnownWorkflow name args result -> Text
knownWorkflowName _ = Text.pack $ symbolVal (Proxy @name)

class StartChildWorkflowArgs codec (args :: [*]) baseResult where
  applyWfArgs_ 
    :: Proxy args 
    -> Proxy env
    -> Proxy st
    -> codec
    -> ([IO RawPayload] -> [IO RawPayload]) 
    -> ([IO RawPayload] -> Workflow env st (ChildWorkflowHandle env st baseResult))
    -> StartChildWorkflow env st baseResult args

instance StartChildWorkflowArgs codec '[] baseResult where
  applyWfArgs_ argsP _ _ _ accum f = f $ accum []

instance (Codec codec a, StartChildWorkflowArgs codec as baseResult) => StartChildWorkflowArgs codec (a ': as) baseResult where
  applyWfArgs_ argsP envP stP c accum f = \arg ->
    applyWfArgs_
    (Proxy @as) 
    envP
    stP
    c
    ((encode c arg :) . accum) 
    f

gatherStartChildWorkflowArgs :: forall env st args baseResult codec. StartChildWorkflowArgs codec args baseResult => codec -> ([IO RawPayload] -> Workflow env st (ChildWorkflowHandle env st baseResult)) -> StartChildWorkflow env st baseResult args 
gatherStartChildWorkflowArgs c f = applyWfArgs_ (Proxy @args) (Proxy @env) (Proxy @st) c id f

type family StartChildWorkflow env st baseResult (args :: [*]) = r | r -> env st baseResult args where
  StartChildWorkflow env st baseResult '[] = Workflow env st (ChildWorkflowHandle env st baseResult)
  StartChildWorkflow env st baseResult (a ': as) = a -> StartChildWorkflow env st baseResult as 

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
provideWorkflow ::
  ( IsValidWorkflowFunction codec env st f
  , AllArgsSupportCodec codec (ArgsOf f)
  , KnownSymbol name
  , StartChildWorkflowArgs codec (ArgsOf f) (ResultOf (Workflow env st) f)
  ) => codec -> Proxy name -> st -> f -> (WorkflowDefinition env st, KnownWorkflow name (ArgsOf f) (ResultOf (Workflow env st) f))
provideWorkflow codec name st f = 
  ( WorkflowDefinition
    { workflowName = Text.pack $ symbolVal name
    , workflowInitialState = st
    , workflowRun = ValidWorkflowFunction codec f (applyPayloads codec)
    }
  , KnownWorkflow
    { knownWorkflowCodec = codec
    , knownWorkflowQueue = Nothing
    , knownWorkflowNamespace = Nothing
    }
  )

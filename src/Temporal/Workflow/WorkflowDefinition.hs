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
  UndecidableInstances,
  TypeApplications #-}
module Temporal.Workflow.WorkflowDefinition 
  ( WorkflowDefinition(..) -- TODO, only export the type, not the constructor from this module
  , SomeSerializableFunction(..) -- TODO, move to internal
  , workflowName
  , defineWorkflow
  ) where

import Data.Aeson hiding (encode, decode)
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as BL
import Data.Kind
import Data.Text (Text)
import Data.Typeable (Typeable)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Typeable
import Temporal.Payloads
import Temporal.Workflow

data WorkflowSignalDefinition = WorkflowSignalDefinition
  -- { workflowSignalName :: Text
  -- , workflowSignalHandler :: [Payload] -> IO ()
  -- }

data WorkflowQueryDefinition = WorkflowQueryDefinition

data WorkflowDefinition env = WorkflowDefinition
  { workflowName :: Text
  , workflowSignals :: HashMap Text WorkflowSignalDefinition
  , workflowQueries :: HashMap Text WorkflowQueryDefinition
  , workflowRun :: SomeSerializableFunction env
  }

type ValidWorkflowFunction env fmt f = 
  ( ToPayloads fmt (ArgsOf f)
  , ApplyPayloads fmt f (Workflow env (ResultOf (Workflow env) f))
  , Codec fmt (ResultOf (Workflow env) f)
  )

-- TODO, I think we can avoid keeping the original function around and just use the serialized version
data SomeSerializableFunction env = 
  forall fmt f. (ValidWorkflowFunction env fmt f) => 
  SomeSerializableFunction 
    (Proxy fmt) 
    f
    (Proxy fmt -> f -> [RawPayload] -> Either String (Workflow env (ResultOf (Workflow env) f)))

defineWorkflow :: 
  ( ValidWorkflowFunction env fmt f
  ) => Proxy fmt -> Text -> f -> WorkflowDefinition env
defineWorkflow p name f = WorkflowDefinition
  { workflowName = name
  , workflowSignals = HashMap.empty
  , workflowQueries = HashMap.empty
  , workflowRun = SomeSerializableFunction p f applyPayloads
  }

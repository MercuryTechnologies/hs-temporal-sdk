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
  , ValidWorkflowFunction(..) -- TODO, move to internal
  , OpaqueWorkflow(..)
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
import Temporal.Payload
import Temporal.Workflow.WorkflowInstance
import Temporal.Worker.Types

defineWorkflow ::
  ( IsValidWorkflowFunction codec env st f
  , AllArgsSupportCodec codec (ArgsOf f)
  ) => codec -> Text -> st -> f -> WorkflowDefinition env st
defineWorkflow codec name st f = WorkflowDefinition
  { workflowName = name
  , workflowInitialState = st
  , workflowSignals = HashMap.empty
  , workflowQueries = HashMap.empty
  , workflowRun = ValidWorkflowFunction codec f (applyPayloads codec)
  }

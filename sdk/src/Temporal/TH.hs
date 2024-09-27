{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveLift #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE UndecidableSuperClasses #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

{-# HLINT ignore "Use ++" #-}

{- |
Module      : Temporal.TH
Description : Template Haskell utilities for Temporal Workflow and Activity definitions
Stability   : experimental
Portability : POSIX

The `Temporal.TH` module provides Template Haskell-based utilities for defining,
configuring, and registering Temporal Workflows and Activities in a type-safe and
declarative manner. This module simplifies the process of integrating Temporal
with Haskell applications by automating much of the boilerplate code typically
required for setting up Workflows and Activities.

Key features of this module include:

1. Automatic registration of Workflows and Activities.
2. Type-safe configuration options for both Workflows and Activities.
3. Generation of necessary typeclass instances for Workflow and Activity functions.
4. Support for custom naming and aliasing of Activities.
5. Integration with Haskell's strong type system to ensure correctness at compile-time.

The main functions provided by this module are:

- 'registerWorkflow' and 'registerWorkflowWithOptions': For registering Workflow functions.
- 'registerActivity' and 'registerActivityWithOptions': For registering Activity functions.
- 'discoverDefinitions': For automatically discovering and collecting all defined Workflows and Activities.

When you apply the registration functions to your Workflow and Activity functions,
a number of things happen automatically:

1. The registration functions generate a new data type with the same name as your Workflow or Activity function (capitalized).
   Example: If you define a Workflow function named @myWorkflow@, the generated data type will be named @MyWorkflow@.
2. A number of type classes are generated or derived for your Workflow or Activity function to support invoking them.

Example usage:

@
{\-# LANGUAGE DerivingVia #-\}
{\-# LANGUAGE TemplateHaskell #-\}
{\-# LANGUAGE ImportQualifiedPost #-\}

module MyWorkflows where

import Language.Haskell.TH (newDeclarationGroup)
import RequireCallStack (provideCallStack)
import Temporal.Activity
import Temporal.TH
import Temporal.TH.Options
import Temporal.Workflow
import Temporal.Client qualified as Client

-- Simple activity registration
actWithoutTimeoutDefault :: Activity () ()
actWithoutTimeoutDefault = pure ()
\$(registerActivity 'actWithoutTimeoutDefault)

-- Activity registration with name override
actWithNameOverride :: Activity () ()
actWithNameOverride = pure ()
\$(registerActivityWithOptions 'actWithNameOverride defaultActivityConfiguration
  { actNameOverride = Just "my-name"
  })

-- Activity registration with aliases
actWithAliases :: Activity () ()
actWithAliases = pure ()
\$(registerActivityWithOptions 'actWithAliases defaultActivityConfiguration
  { actAliases = ["alias1", "alias2"]
  })

-- Workflow registration
myWorkflow :: Int -> Workflow ()
myWorkflow _ = pure ()
\$(registerWorkflow 'myWorkflow)

-- Use newDeclarationGroup to separate Template Haskell splices
\$(newDeclarationGroup)

-- Workflow referencing a child workflow
workflowReferencingChild :: Workflow ()
workflowReferencingChild = provideCallStack do
  _ <- startChildWorkflow MyWorkflow defaultChildWorkflowOptions 0
  executeChildWorkflow MyWorkflow defaultChildWorkflowOptions 1

-- Activity referencing a workflow
actionReferencingWorkflow :: Activity () ()
actionReferencingWorkflow = provideCallStack do
  _ <- Client.start MyWorkflow "1" (Client.startWorkflowOptions (TaskQueue "foo")) 1
  Client.execute MyWorkflow "2" (Client.startWorkflowOptions (TaskQueue "foo")) 1
@

Note the use of 'newDeclarationGroup' from "Language.Haskell.TH" to separate
Template Haskell splices, which can be necessary in some cases to avoid
compilation errors– namely, when you want to invoke a Workflow or Activity later
in the same module.

The one use case where the TH mechanism struggles is when you want to use the
'continueAsNew' function from "Temporal.Workflow" in a Workflow to start a new
instance of the same Workflow. In this case, you can define the machinery manually:

@
workflowThatContinuesAsNew :: Int -> Workflow ()
workflowThatContinuesAsNew x = do
  if x < 1000
  then continueAsNew WorkflowThatContinuesAsNew defaultContinueAsNewOptions (x + 1)
  else return ()

data WorkflowThatContinuesAsNew = WorkflowThatContinuesAsNew
  deriving anyclass (WorkflowFn)
  deriving (WorkflowDef, WorkflowRef) via WorkflowImpl WorkflowThatContinuesAsNew

instance Fn WorkflowThatContinuesAsNew where
  fnName = Text.pack $ show 'workflowThatContinuesAsNew
  fnDefinition _ = provideCallStack workflowThatContinuesAsNew
  fnSing = WorkflowThatContinuesAsNew
@
-}
module Temporal.TH (
  discoverDefinitions,
  SomeDict,
  SomeDictOf (..),
  registerActivity,
  registerActivityWithOptions,
  ActivityConfig (..),
  defaultActivityConfig,
  registerWorkflow,
  registerWorkflowWithOptions,
  WorkflowConfig (..),
  defaultWorkflowConfig,
  Fn (..),
  WorkflowFn (..),
  WorkflowRef (..),
  WorkflowDef (..),
  ActivityFn (..),
  ActivityRef (..),
  ActivityDef (..),
  fnSingE,
  fnSingDataAndConName,
  ActivityImpl (..),
  WorkflowImpl (..),
  bringRegisteredTemporalFunctionsIntoScope,
) where

import qualified Data.HashMap.Strict as Map
import Data.Typeable
import DiscoverInstances
import qualified Language.Haskell.TH as TH
import Language.Haskell.TH.Lib
import qualified Language.Haskell.TH.Syntax as TH
import qualified Temporal.Activity as Act
import Temporal.Activity.Definition (ActivityDef (..))
import Temporal.TH.Classes
import Temporal.TH.Internal
import Temporal.Worker (Definitions (..))
import Temporal.Workflow
import qualified Temporal.Workflow as Wf
import Temporal.Workflow.Definition (WorkflowDef (..))


registerActivityWithOptions :: forall codec m. (TH.Quote m, TH.Quasi m, TH.Lift codec) => TH.Name -> ActivityConfig codec -> m [TH.Dec]
registerActivityWithOptions n conf = do
  fnType <- TH.qReifyType n
  let dataName = conT $ fnSingDataAndConName n
  baseDecls <- makeFnDecls n fnType
  actDefs <-
    [d|
      instance Temporal.TH.Classes.ActivityFn $dataName where
        activityConfig _ = conf


      deriving via (Temporal.TH.Classes.ActivityImpl $dataName) instance ActivityRef $dataName


      deriving via (Temporal.TH.Classes.ActivityImpl $dataName) instance ActivityDef $dataName
      |]
  pure $ concat [baseDecls, actDefs]


registerActivity :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> m [TH.Dec]
registerActivity n = registerActivityWithOptions n defaultActivityConfig


registerWorkflowWithOptions :: forall codec m. (TH.Quote m, TH.Quasi m, TH.Lift codec) => TH.Name -> WorkflowConfig codec -> m [TH.Dec]
registerWorkflowWithOptions n conf = do
  fnType <- TH.qReifyType n
  let dataName = conT $ fnSingDataAndConName n
  baseDecls <- makeFnDecls n fnType
  additionalDecls <-
    [d|
      instance Temporal.TH.Classes.WorkflowFn $dataName where
        workflowConfig _ = conf


      deriving via (Temporal.TH.Classes.WorkflowImpl $dataName) instance WorkflowRef $dataName


      deriving via (Temporal.TH.Classes.WorkflowImpl $dataName) instance WorkflowDef $dataName
      |]

  pure $ concat [baseDecls, additionalDecls]


registerWorkflow :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> m [TH.Dec]
registerWorkflow n = registerWorkflowWithOptions n defaultWorkflowConfig


-- | Alias for 'newDeclarationGroup' that makes the intent a bit more clear.
bringRegisteredTemporalFunctionsIntoScope :: TH.Q [TH.Dec]
bringRegisteredTemporalFunctionsIntoScope = TH.newDeclarationGroup


---------------------------------------------------------------------------------------
-- Produce dictionaries

discoverDefinitions
  :: forall env
   . (RequireCallStack, Typeable env)
  => [SomeDict WorkflowFn]
  -> [SomeDict ActivityFn]
  -> Definitions env
discoverDefinitions wfs acts =
  let
    aliasedWfs =
      concatMap
        ( \(SomeDictOf inst) ->
            let def = Wf.definition $ Temporal.TH.Classes.workflowImpl $ fn inst
            in (Wf.workflowName def, def) : map (\alias -> (alias, def {Wf.workflowName = alias})) (workflowConfigAliases $ workflowConfig $ fn inst)
        )
        wfs
    aliasedActs =
      concatMap
        ( \(SomeDictOf inst) -> case cast (Act.definition $ Temporal.TH.Classes.activityImpl $ fn inst) of
            Just (def :: Act.ActivityDefinition env) ->
              (Act.activityName def, def) : map (\alias -> (alias, def {Act.activityName = alias})) (activityConfigAliases $ activityConfig $ fn inst)
            Nothing -> []
        )
        acts
  in
    Definitions
      (Map.fromListWith (\l _ -> error ("Encountered duplicate Workflow definition names: " ++ show (Wf.workflowName l))) aliasedWfs)
      (Map.fromListWith (\l _ -> error ("Encountered duplicate Activity definition names: " ++ show (Act.activityName l))) aliasedActs)

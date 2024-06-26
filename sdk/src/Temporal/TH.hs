{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveLift #-}
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
module Temporal.TH (
  discoverDefinitions,
  SomeDict (..),
  register,
  registerMany,
  -- , PayloadCodec(..)
  Aliases (..),
  aliases,
  NameOverride (..),
  overrideName,
  WorkflowFn,
  ActivityFn,
  fnSingE,
  fnSingDataAndConName,
) where

import Control.Applicative
import qualified Data.HashMap.Strict as Map
import qualified Data.Map.Strict as M
import Data.Maybe
import qualified Data.Text as Text
import Data.Typeable
import DiscoverInstances
import qualified Language.Haskell.TH as TH
import Language.Haskell.TH.Lib
import qualified Language.Haskell.TH.Syntax as TH
import qualified Temporal.Activity as Act
import qualified Temporal.Client as Client
import Temporal.TH.Annotations
import Temporal.TH.Classes
import Temporal.TH.Internal
import Temporal.Worker (Definitions (..))
import Temporal.Workflow
import qualified Temporal.Workflow as Cwf (StartChildWorkflowOptions (..))
import qualified Temporal.Workflow as Wf
import Validation (Validation (..))


register :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> m [TH.Dec]
register n = register' n =<< TH.qReifyType n


register' :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> TH.Type -> m [TH.Dec]
register' n fnType = do
  let dataName = conT $ fnSingDataAndConName n
  baseDecls <- makeFnDecls n fnType
  temporalAnns <- findAllAnnotations n
  additionalDecls <-
    if
      | isActivityFunction fnType -> do
          let vActAnns = validateActivityAnnotations temporalAnns
          anns@ActivityAnnotations {..} <- case vActAnns of
            Failure errs -> error $ formatValidationResults n errs
            Success ok -> pure ok
          let configImpl =
                defaultActivityConfig
                  { activityNameOverride = actNameOverride
                  , activityAliases = actAliases
                  }
          actDefs <-
            [d|
              instance ActivityFn $dataName where
                activityConfig _ = configImpl
                activityOptions _ = activityAnnotationsToStartActivityOptionsModifier anns
              |]
          timeoutDefs <- case actTimeouts of
            Just timeout ->
              [d|
                instance ActivityTimeout $dataName where
                  activityTimeout _ = timeout
                |]
            Nothing -> pure []
          pure $
            concat
              [ actDefs
              , timeoutDefs
              ]
      | isWorkflowFunction fnType -> do
          let vWfAnns = validateWorkflowAnnotations temporalAnns
          wfAnns@WorkflowAnnotations {..} <- case vWfAnns of
            Failure errs -> error $ formatValidationResults n errs
            Success ok -> pure ok
          let configImpl =
                defaultWorkflowConfig
                  { workflowNameOverride = wfNameOverride
                  , workflowAliases = wfAliases
                  }
          (<>)
            <$> [d|
              instance WorkflowFn $dataName where
                workflowConfig _ = configImpl
                workflowClientStartOptions _ = workflowAnnotationsToStartWorkflowOptionsModifier wfAnns
                workflowChildWorkflowStartOptions _ = workflowAnnotationsToStartChildWorkflowOptionsModifier wfAnns
              |]
            <*> case wfTaskQueue of
              NoPreference -> pure []
              Root q ->
                [d|
                  instance WorkflowRootTaskQueue $dataName where
                    workflowRootTaskQueue _ = q
                  |]
              AlwaysUse q ->
                [d|
                  instance WorkflowRootTaskQueue $dataName where
                    workflowRootTaskQueue _ = q
                  |]
      | otherwise -> pure []
  pure $ concat [baseDecls, additionalDecls]


registerMany :: forall m. (TH.Quote m, TH.Quasi m) => [TH.Name] -> m [TH.Dec]
registerMany = fmap concat . mapM register


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
            let def = Wf.definition $ Temporal.TH.Classes.workflowRef inst
            in (Wf.workflowName def, def) : map (\alias -> (alias, def {Wf.workflowName = alias})) (workflowAliases $ workflowConfig inst)
        )
        wfs
    aliasedActs =
      concatMap
        ( \(SomeDictOf inst) -> case cast (Act.definition $ Temporal.TH.Classes.activityRef inst) of
            Just (def :: Act.ActivityDefinition env) ->
              (Act.activityName def, def) : map (\alias -> (alias, def {Act.activityName = alias})) (activityAliases $ activityConfig inst)
            Nothing -> []
        )
        acts
  in
    Definitions
      (Map.fromListWith (\l _ -> error ("Encountered duplicate Workflow definition names: " ++ show (Wf.workflowName l))) aliasedWfs)
      (Map.fromListWith (\l _ -> error ("Encountered duplicate Activity definition names: " ++ show (Act.activityName l))) aliasedActs)

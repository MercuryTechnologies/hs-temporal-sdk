{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveLift #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE UndecidableSuperClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Temporal.TH.Classes where

import Data.Kind (Type)
import Data.Maybe (fromMaybe)
import qualified Data.Text as Text
import Data.Typeable
import Language.Haskell.TH (Name)
import qualified Language.Haskell.TH.Syntax as TH
import RequireCallStack (provideCallStack)
import Temporal.Activity
import Temporal.Activity.Definition
import Temporal.Client
import Temporal.Payload
import Temporal.Workflow
import Temporal.Workflow.Definition


class Fn t where
  type FnType t :: Type
  fnName :: t -> Text.Text
  fnName = Text.pack . show . fnTHName
  fnDefinition :: t -> (RequireCallStack => FnType t)
  fnSing :: t
  fnTHName :: t -> Name


fn :: Fn t => Proxy t -> t
fn _ = fnSing


data WorkflowConfig = WorkflowConfig
  { -- clientDefaultOptions :: Maybe StartWorkflowOptions
    -- , childWorkflowDefaultOptions :: Maybe StartChildWorkflowOptions
    workflowNameOverride :: Maybe Text.Text
  , workflowAliases :: [Text.Text]
  -- TODO, add support for custom metadata like alerting channels
  -- , customMetadata :: _
  }
  deriving stock (Show, TH.Lift)


class (Fn f) => WorkflowFn (f :: Type) where
  type WorkflowCodec f :: Type
  type WorkflowCodec _ = JSON


  workflowCodec :: f -> WorkflowCodec f
  default workflowCodec :: (WorkflowCodec f ~ JSON) => f -> WorkflowCodec f
  workflowCodec _ = JSON


  workflowImpl :: RequireCallStack => f -> ProvidedWorkflow (FnType f)
  default workflowImpl
    :: ( RequireCallStack
       , FnType f ~ (ArgsOf (FnType f) :->: Workflow (ResultOf Workflow (FnType f)))
       , FunctionSupportsCodec (WorkflowCodec f) (ArgsOf (FnType f)) (ResultOf Workflow (FnType f))
       )
    => f
    -> ProvidedWorkflow (FnType f)
  workflowImpl x = workflowRefWithCodec x (workflowConfig x) (workflowCodec x)


  workflowConfig :: f -> WorkflowConfig
  workflowConfig _ = defaultWorkflowConfig


newtype WorkflowImpl f = WorkflowImpl f


instance (Fn f, WorkflowFn f) => WorkflowDef (WorkflowImpl f) where
  workflowDefinition (WorkflowImpl f) = provideCallStack (Temporal.TH.Classes.workflowImpl f).definition


instance (Fn f, WorkflowFn f) => WorkflowRef (WorkflowImpl f) where
  type WorkflowArgs (WorkflowImpl f) = ArgsOf (FnType f)
  type WorkflowResult (WorkflowImpl f) = ResultOf Workflow (FnType f)
  workflowRef (WorkflowImpl f) = provideCallStack (Temporal.TH.Classes.workflowImpl f).reference


defaultWorkflowConfig :: WorkflowConfig
defaultWorkflowConfig = WorkflowConfig Nothing []


workflowRefWithCodec
  :: ( RequireCallStack
     , Fn f
     , FnType f ~ (ArgsOf (FnType f) :->: Workflow (ResultOf Workflow (FnType f)))
     , FunctionSupportsCodec codec (ArgsOf (FnType f)) (ResultOf Workflow (FnType f))
     )
  => f
  -> WorkflowConfig
  -> codec
  -> ProvidedWorkflow (FnType f)
workflowRefWithCodec p conf c = provideWorkflow c (fromMaybe (fnName p) $ workflowNameOverride conf) $ fnDefinition p


data ActivityConfig = ActivityConfig
  { activityNameOverride :: Maybe Text.Text
  , -- TODO, add support for custom metadata like alerting channels
    -- , customMetadata :: _
    activityAliases :: [Text.Text]
  }
  deriving stock (TH.Lift)


defaultActivityConfig :: ActivityConfig
defaultActivityConfig = ActivityConfig Nothing []


type family FnActivityEnv f where
  FnActivityEnv (Activity env _a) = env
  FnActivityEnv (_ -> Activity env _a) = env


class (Fn f, Typeable (FnActivityEnv (FnType f))) => ActivityFn f where
  type ActivityCodec f :: Type
  type ActivityCodec _ = JSON


  activityCodec :: f -> ActivityCodec f
  default activityCodec :: (ActivityCodec f ~ JSON) => f -> ActivityCodec f
  activityCodec _ = JSON


  activityEnvType :: f -> TypeRep
  activityEnvType _ = typeRep (Proxy :: Proxy (FnActivityEnv (FnType f)))


  activityImpl
    :: ( RequireCallStack
       )
    => f
    -> ProvidedActivity (FnActivityEnv (FnType f)) (FnType f)
  default activityImpl
    :: ( RequireCallStack
       , env ~ FnActivityEnv (FnType f)
       , FnType f ~ (ArgsOf (FnType f) :->: Activity env (ResultOf (Activity env) (FnType f)))
       , FunctionSupportsCodec (ActivityCodec f) (ArgsOf (FnType f)) (ResultOf (Activity env) (FnType f))
       )
    => f
    -> ProvidedActivity (FnActivityEnv (FnType f)) (FnType f)
  activityImpl x = activityRefWithCodec x (activityCodec x)


  activityConfig :: f -> ActivityConfig
  activityConfig _ = defaultActivityConfig


newtype ActivityImpl f = ActivityImpl f


instance (Fn f, ActivityFn f) => ActivityDef (ActivityImpl f) where
  type ActivityDefinitionEnv (ActivityImpl f) = FnActivityEnv (FnType f)
  activityDefinition (ActivityImpl f) = provideCallStack (Temporal.TH.Classes.activityImpl f).definition


instance (Fn f, ActivityFn f) => ActivityRef (ActivityImpl f) where
  type ActivityArgs (ActivityImpl f) = ArgsOf (FnType f)
  type ActivityResult (ActivityImpl f) = ResultOf (Activity (FnActivityEnv (FnType f))) (FnType f)
  activityRef (ActivityImpl f) = provideCallStack (Temporal.TH.Classes.activityImpl f).reference


activityRefWithCodec
  :: ( RequireCallStack
     , ActivityFn f
     , env ~ FnActivityEnv (FnType f)
     , FnType f ~ (ArgsOf (FnType f) :->: Activity env (ResultOf (Activity env) (FnType f)))
     , FunctionSupportsCodec codec (ArgsOf (FnType f)) (ResultOf (Activity env) (FnType f))
     )
  => f
  -> codec
  -> ProvidedActivity env (FnType f)
activityRefWithCodec p c =
  provideActivity
    c
    (fromMaybe (fnName p) (activityNameOverride $ activityConfig p))
    (fnDefinition p)

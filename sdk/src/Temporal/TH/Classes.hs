{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveLift #-}
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
import Data.Proxy
import qualified Data.Text as Text
import Data.Typeable
import Language.Haskell.TH (Name)
import qualified Language.Haskell.TH.Syntax as TH
import Temporal.Activity
import Temporal.Client
import Temporal.Payload
import Temporal.Workflow


class Fn t where
  type FnType t :: Type
  fnName :: Proxy t -> Text.Text
  fnDefinition :: Proxy t -> (RequireCallStack => FnType t)
  fnSing :: t
  fnTHName :: Proxy t -> Name


type family FnArgs (f :: Type) :: [Type] where
  FnArgs (a -> b) = a ': FnArgs b
  FnArgs _a = '[]


type family FnResult (f :: Type) :: Type where
  FnResult (_a -> b) = FnResult b
  FnResult a = a


data Pure


data Impure (m :: Type -> Type)


type family UnwrapFnResult (m :: Type) (result :: Type) :: Type where
  UnwrapFnResult (Impure m) (m a) = a


type family FnSupportsCodecConstraint' codec purity f where
  FnSupportsCodecConstraint' codec Pure f = (FunctionSupportsCodec codec (FnArgs f) (FnResult f), f ~ (FnArgs f :->: FnResult f))
  FnSupportsCodecConstraint' codec (Impure m) f = (FunctionSupportsCodec codec (FnArgs f) (UnwrapFnResult (Impure m) (FnResult f)), f ~ (FnArgs f :->: m (UnwrapFnResult (Impure m) (FnResult f))))


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


  workflowCodec :: Proxy f -> WorkflowCodec f
  default workflowCodec :: (WorkflowCodec f ~ JSON) => Proxy f -> WorkflowCodec f
  workflowCodec _ = JSON


  workflowRef :: RequireCallStack => Proxy f -> ProvidedWorkflow (FnType f)
  default workflowRef
    :: ( RequireCallStack
       , FnType f ~ (ArgsOf (FnType f) :->: Workflow (ResultOf Workflow (FnType f)))
       , FunctionSupportsCodec (WorkflowCodec f) (ArgsOf (FnType f)) (ResultOf Workflow (FnType f))
       )
    => Proxy f
    -> ProvidedWorkflow (FnType f)
  workflowRef x = workflowRefWithCodec x (workflowConfig x) (workflowCodec x)


  workflowConfig :: Proxy f -> WorkflowConfig
  workflowConfig _ = defaultWorkflowConfig


  workflowClientStartOptions :: Proxy f -> (StartWorkflowOptions -> StartWorkflowOptions)


  workflowChildWorkflowStartOptions :: Proxy f -> (StartChildWorkflowOptions -> StartChildWorkflowOptions)


class WorkflowFn f => WorkflowRootTaskQueue f where
  workflowRootTaskQueue :: Proxy f -> TaskQueue


defaultWorkflowConfig :: WorkflowConfig
defaultWorkflowConfig = WorkflowConfig Nothing []


workflowRefWithCodec
  :: ( RequireCallStack
     , Fn f
     , FnType f ~ (ArgsOf (FnType f) :->: Workflow (ResultOf Workflow (FnType f)))
     , FunctionSupportsCodec codec (ArgsOf (FnType f)) (ResultOf Workflow (FnType f))
     )
  => Proxy f
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


  activityCodec :: Proxy f -> ActivityCodec f
  default activityCodec :: (ActivityCodec f ~ JSON) => Proxy f -> ActivityCodec f
  activityCodec _ = JSON


  activityEnvType :: Proxy f -> TypeRep
  activityEnvType _ = typeRep (Proxy :: Proxy (FnActivityEnv (FnType f)))


  activityRef
    :: ( RequireCallStack
       )
    => Proxy f
    -> ProvidedActivity (FnActivityEnv (FnType f)) (FnType f)
  default activityRef
    :: ( RequireCallStack
       , env ~ FnActivityEnv (FnType f)
       , FnType f ~ (ArgsOf (FnType f) :->: Activity env (ResultOf (Activity env) (FnType f)))
       , FunctionSupportsCodec (ActivityCodec f) (ArgsOf (FnType f)) (ResultOf (Activity env) (FnType f))
       )
    => Proxy f
    -> ProvidedActivity (FnActivityEnv (FnType f)) (FnType f)
  activityRef x = activityRefWithCodec x (activityCodec x)


  activityOptions :: Proxy f -> (StartActivityOptions -> StartActivityOptions)
  activityOptions _ = id


  activityConfig :: Proxy f -> ActivityConfig
  activityConfig _ = defaultActivityConfig


class ActivityFn f => ActivityTimeout f where
  activityTimeout :: Proxy f -> ActivityTimeoutPolicy


activityRefWithCodec
  :: ( RequireCallStack
     , ActivityFn f
     , env ~ FnActivityEnv (FnType f)
     , FnType f ~ (ArgsOf (FnType f) :->: Activity env (ResultOf (Activity env) (FnType f)))
     , FunctionSupportsCodec codec (ArgsOf (FnType f)) (ResultOf (Activity env) (FnType f))
     )
  => Proxy f
  -> codec
  -> ProvidedActivity env (FnType f)
activityRefWithCodec p c =
  provideActivity
    c
    (fromMaybe (fnName p) (activityNameOverride $ activityConfig p))
    (fnDefinition p)

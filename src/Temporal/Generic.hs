{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE UndecidableSuperClasses #-}
{-# LANGUAGE InstanceSigs #-}
-- | Define and reference workflows and activities using records.
--
-- The usage of this module is best explained by example. First, define a record type
-- that contains all of the workflows and activities that you want to define:
--
-- @
-- data EmailWorkflows t f = Workflows
--  { emailNewUser :: Wear t f (Int -> Workflow ())
--  , sendEmail :: Wear t f (String -> Activity () ())
--  , emailPasswordReset :: Wear t f (String -> Workflow ())
--  } deriving (Generic)
-- @
-- 
-- We define all of our fields using the 'Wear' type, which is a type family
-- that lets us convert fields from their direct function definitions into
-- versions that are wrapped in a functor.
--
-- Next, we will need some boilerplate instances for this type:
--
-- @
-- instance FunctorB (EmailWorkflows Covered)
-- instance TraversableB (EmailWorkflows Covered)
-- instance ApplicativeB (EmailWorkflows Covered)
-- instance ConstraintsB (EmailWorkflows Covered)
-- instance BareB EmailWorkflows
-- instance Label (EmailWorkflows Covered)
-- @
--
-- Using 'refs', we can use our record type to provide references to our workflows and activities.
-- References are essentially identifiers that we can use across application / process boundaries
-- to invoke our workflows and activities with Temporal.
--
-- @
-- wfRefs :: Refs EmailWorkflows
-- wfRefs = refs JSON workflowsImpl
-- @
--
-- Now, we can implement our workflows and activities:
--
-- @
-- workflowsImpl :: Impl EmailWorkflows
-- workflowsImpl = Workflows
--   { emailNewUser = \userId -> provideCallStack $ do
--       h <- startActivity 
--         wfRefs.sendEmail -- <=== Note how we can reference other workflows and activities using the refs we defined above
--         (defaultStartActivityOptions $ ScheduleToClose $ TimeSpec 0 0)
--         "foo"
--       wait h
--   , sendEmail = \email -> do
--       pure ()
--   , emailPasswordReset = \email -> do
--       pure ()
--   }
-- @
--
-- Lastly, we want a way to register our workflows and activities with the Temporal worker:
--
-- @
-- workerConfigFromRecord = defsToConfig $ defs JSON workflowsImpl
-- @
-- 
-- This will produce a 'ConfigM' that we can use to register our workflows and activities with the Temporal worker
-- as part of a larger 'ConfigM' that we pass to 'startWorker'.
--
module Temporal.Generic 
  ( 
  -- * Turning implementations into references and definitions
    refs
  , Refs
  , Ref(..)
  , defs
  , Defs
  , Def(..)
  , defsToConfig
  , Impl
  , provide
  -- * Naming schemes for turning record fields into workflow and activity names
  , Labels
  , Labeled(..)
  , Label(..)
  -- * Reexports
  -- | Provides 'FunctorB', 'TraversableB', 'ApplicativeB', 'ConstraintsB' type classes needed to use the functions in 'Temporal.Generic'.
  , module Barbies
  -- | Provides 'BareB' type class, 'Wear', 'Bare', and 'Covered' needed to use the functions in this module.
  , module Barbies.Bare
  -- * Constraints
  , CanUseAsRefs
  , CanUseAsDefs
  ) where

import Control.Monad.Reader
import Data.Functor.Const
import Data.Functor.Identity
import Data.Kind
import Data.Proxy
import qualified Data.Text as Text
import GHC.Generics
import GHC.TypeLits
import RequireCallStack
import Barbies
import Barbies.Bare
import Temporal.Workflow.Types
-- import Temporal.Activity
-- import Temporal.Generic.Applicative
-- import Temporal.Generic.Constraints
-- import Temporal.Generic.Functor
-- import Temporal.Generic.GenericN
-- import Temporal.Generic.GUsing
-- import Temporal.Generic.Traversable
import Temporal.Payload
import Temporal.Activity
import Temporal.Activity.Definition
import Temporal.Worker
import Temporal.Workflow 
import Temporal.Workflow.Definition
import Temporal.Workflow.Internal.Monad

type family ApplyRef (args :: [Type]) (f :: Type) where
  ApplyRef args (Workflow result) = KnownWorkflow args result
  ApplyRef args (Activity env result) = KnownActivity args result
  ApplyRef args (a -> b) = ApplyRef (a ': args) b
  ApplyRef args a = TypeError ('Text "Expected a Workflow or Activity, but got " ':<>: 'ShowType a)

type FnRef f = ApplyRef '[] f

type family ApplyDef (f :: Type) where
  ApplyDef (Workflow result) = WorkflowDefinition
  ApplyDef (Activity env result) = ActivityDefinition env
  ApplyDef (a -> b) = ApplyDef b
  ApplyDef a = TypeError ('Text "Expected a Workflow or Activity, but got " ':<>: 'ShowType a)

type FnDef f = ApplyDef f

-- | A reference to a workflow or activity.
--
-- Depending on whether the result monad is 'Workflow' or 'Activity',
-- this will be a 'KnownWorkflow' or 'KnownActivity'.
--
-- Callsites that invoke workflows or activities can use the 'ActivityRef'
-- and 'WorkflowRef' typeclasses to treat this type as the underlying
-- value, so you can generally use values of this type as if they were the underlying
-- workflow or activity reference.
newtype Ref fn = Ref
  { ref :: FnRef fn
  }

type family InnerActivityResult (f :: Type) where
  InnerActivityResult (Activity env result) = result
  InnerActivityResult (a -> b) = InnerActivityResult b
  InnerActivityResult a = TypeError ('Text "Expected an Activity, but got " ':<>: 'ShowType a)

instance (FnRef f ~ KnownActivity (ArgsOf f) (InnerActivityResult f)) => ActivityRef (Ref f) where
  type ActivityArgs (Ref f) = ArgsOf f
  type ActivityResult (Ref f) = InnerActivityResult f
  activityRef :: Ref f -> KnownActivity (ActivityArgs (Ref f)) (ActivityResult (Ref f))
  activityRef = ref

instance (FnRef f ~ KnownWorkflow (ArgsOf f) (ResultOf Workflow f)) => WorkflowRef (Ref f) where
  type WorkflowArgs (Ref f) = ArgsOf f
  type WorkflowResult (Ref f) = ResultOf Workflow f
  workflowRef :: Ref f -> KnownWorkflow (WorkflowArgs (Ref f)) (WorkflowResult (Ref f))
  workflowRef = ref

class RefFromFunction' codec (f :: Type) (original :: Type) where
  refFromFunction :: Proxy f -> codec -> String -> Proxy original -> Ref original

instance 
  ( FnRef original ~ KnownWorkflow (ArgsOf original) (ResultOf Workflow original)
  , FunctionSupportsCodec' Workflow codec original
  ) => RefFromFunction' codec (Workflow result) original where
  refFromFunction _ codec name f = Ref $ KnownWorkflow codec Nothing Nothing $ Text.pack name

instance 
  ( FnRef original ~ KnownActivity (ArgsOf original) (ResultOf (Activity env) original)
  , FunctionSupportsCodec' (Activity env) codec original
  ) => RefFromFunction' codec (Activity env result) original where
  refFromFunction _ codec name f = Ref $ KnownActivity codec Nothing $ Text.pack name

instance RefFromFunction' codec b original => RefFromFunction' codec (a -> b) original where
  refFromFunction _ codec name f = refFromFunction (Proxy @b) codec name f

class RefFromFunction' codec f f => RefFromFunction codec f
instance RefFromFunction' codec f f => RefFromFunction codec f



class DefFromFunction' codec env (f :: Type) (original :: Type) where
  defFromFunction :: RequireCallStack => Proxy f -> codec -> String -> original -> Def env original

class DefFromFunction' codec env f f => DefFromFunction codec env f
instance DefFromFunction' codec env f f => DefFromFunction codec env f

instance 
  ( ApplyDef original ~ WorkflowDefinition
  , FunctionSupportsCodec' Workflow codec original
  ) => DefFromFunction' codec env (Workflow result) original where
  defFromFunction _ codec name f = Def $ WorkflowDefinition (Text.pack name) $ \payloads -> do
    eWf <- applyPayloads 
      codec 
      (Proxy @(ArgsOf original)) 
      (Proxy @(Workflow (ResultOf Workflow original)))
      f
      payloads
    pure $ fmap (\wf -> wf >>= \result -> ilift (liftIO $ encode codec result)) eWf


instance 
  ( ApplyDef original ~ ActivityDefinition env
  , FunctionSupportsCodec' (Activity env) codec original
  ) => DefFromFunction' codec env (Activity env result) original where
  defFromFunction _ codec name f = Def $ ActivityDefinition 
    (Text.pack name)
    (\actEnv input -> do
      eAct <- applyPayloads 
        codec 
        (Proxy @(ArgsOf original)) 
        (Proxy @(Activity env (ResultOf (Activity env) original)))
        f
        input.activityArgs
      traverse (\act -> runActivity actEnv act >>= encode codec) eAct
    )
    -- ValidActivityFunction codec f (applyPayloads codec (Proxy @(ArgsOf original)) (Proxy @(Activity env (ResultOf (Activity env) original))))

instance DefFromFunction' codec env b original => DefFromFunction' codec env (a -> b) original where
  defFromFunction _ codec name f = defFromFunction (Proxy @b) codec name f

-- data KnownWorkflowFromFn (fn :: Type) a = KnownWorkflowFromFn
--   { workflowFromFn :: KnownWorkflow (ArgsOf fn) (ResultOf Workflow fn)
--   }


-- | A bare record type that supplies the actual implementation of workflows and activities.
type Impl f = f Bare Identity
-- | References to workflows and activities that can be used at invokation callsites.
type Refs f = f Covered Ref
-- | A wrapped version of the implementations that carries information needed to register workflows and activities with the Temporal worker.
type Defs env f = f Covered (Def env)

-- | A record of each field's name.
type Labels f = f Covered (Const String)

data Labeled a = Labeled
  { label :: String
  , value :: a
  } deriving stock ( Functor )

-- | A definition of a workflow or activity.
--
-- Depending on whether the result monad is 'Workflow' or 'Activity', 
-- this will be a 'WorkflowDefinition' or 'ActivityDefinition'.
--
-- Using this directly is generally not needed. Instead, call 'defsToConfig'
-- on a record of 'Def' values to produce a 'ConfigM' that you can pass to
-- 'startWorker'.
data Def env a = ToConfig env (FnDef a) => Def
  { defVal :: FnDef a
  }

class Label f where
  -- | Used to prefix workflow types to disambiguate them between modules.
  --
  -- Override this for a given record to provide different naming functionality
  namespace :: Proxy (f (Const String)) -> String
  default namespace :: (Generic (f (Const String)), GLabel (Rep (f (Const String)))) => Proxy (f (Const String)) -> String
  namespace _ = gTypeName (Proxy @(Rep (f (Const String))))

  fieldNames :: f (Const String)
  default fieldNames :: (Generic (f (Const String)), GLabel (Rep (f (Const String)))) => f (Const String)
  fieldNames = to $ glabel @(Rep (f (Const String)))

class GLabel (structure :: Type -> Type) where
  gTypeName :: Proxy (structure) -> String
  glabel :: structure x

instance (KnownSymbol tyName, KnownSymbol moduleName, GLabel inner) => GLabel (D1 ('MetaData tyName moduleName packageName isNewtype) inner) where
  gTypeName _ = concat [symbolVal (Proxy @moduleName), ".", symbolVal (Proxy @tyName)]
  glabel = M1 glabel

instance GLabel inner
    => GLabel (C1 ('MetaCons name fixity 'True) inner) where
  gTypeName = undefined
  glabel = M1 glabel

instance TypeError ('Text "You can't collect labels for a non-record type!")
    => GLabel (C1 ('MetaCons name fixity 'False) inner) where
  gTypeName = undefined
  glabel = undefined

instance KnownSymbol name
    => GLabel (S1 ('MetaSel ('Just name) i d c) (K1 index (Const String inner))) where
  gTypeName = undefined
  glabel = M1 (K1 (Const (symbolVal (Proxy @name))))

instance (GLabel left, GLabel right) => GLabel (left :*: right) where
  gTypeName = undefined
  glabel = glabel :*: glabel

type CanUseAsRefs f codec = 
  ( BareB f
  , ConstraintsB (f Covered)
  , AllB (RefFromFunction codec) (f Covered)
  , Label (f Covered)
  , ApplicativeB (f Covered)
  )

class CoverIfNeeded b t f where
  coverIfNeeded :: b t f -> b Covered f

instance BareB b => CoverIfNeeded b Bare Identity where
  coverIfNeeded = bcover

instance CoverIfNeeded b Covered f where
  coverIfNeeded = id

refs :: forall r t f codec.
  ( CanUseAsRefs r codec
  , CoverIfNeeded r t f
  ) => codec -> r t f -> Refs r 
refs codec wfrec = result
  where
    ns :: String
    ns = Temporal.Generic.namespace (Proxy @(r Covered (Const String)))

    defLabels :: r Covered (Const String)
    defLabels = bmap (\(Const str) -> Const $ concat [ns, ".", str]) fieldNames

    convertToKnownWorkflow :: forall wf. RefFromFunction codec wf => Const String wf -> Ref wf
    convertToKnownWorkflow = \(Const n) -> refFromFunction (Proxy @wf) codec n (Proxy @wf)

    result :: r Covered Ref
    result = bmapC @(RefFromFunction codec) convertToKnownWorkflow defLabels

type CanUseAsDefs f codec env = 
  ( BareB f
  , ConstraintsB (f Covered)
  , AllB (DefFromFunction codec env) (f Covered)
  , Label (f Covered)
  , ApplicativeB (f Covered)
  )

defs :: forall f codec env. 
  ( CanUseAsDefs f codec env
  ) => codec -> Impl f -> Defs env f
defs codec wfrec = result
  where
    covered :: f Covered Identity
    covered = bcover wfrec

    ns :: String
    ns = Temporal.Generic.namespace (Proxy @(f Covered (Const String)))

    defLabels :: f Covered (Const String)
    defLabels = bmap (\(Const str) -> Const $ concat [ns, ".", str]) fieldNames

    labeledFields :: f Covered Labeled
    labeledFields = bzipWith (\(Const label) (Identity f) -> Labeled label f) defLabels covered

    convertToWorkflowDefinition :: forall wf. (DefFromFunction codec env wf) => Labeled wf -> Def env wf
    convertToWorkflowDefinition = (\(Labeled n f) -> provideCallStack $ defFromFunction (pure f) codec n f) 

    result :: f Covered (Def env)
    result = bmapC @(DefFromFunction codec env) convertToWorkflowDefinition labeledFields

instance ToConfig env WorkflowDefinition where
  toConfig = addWorkflow

instance ToConfig env (ActivityDefinition env) where
  toConfig = addActivity

-- | Convert a record of 'Def' values into a 'ConfigM' that you can pass to 'startWorker'.
defsToConfig :: (TraversableB f) => f (Def actEnv) -> ConfigM actEnv ()
defsToConfig = bfoldMap (\(Def x) -> toConfig x)

provide :: FunctorB (r t) => b -> r t (Reader b) -> r t Identity
provide x = bmap (\r -> Identity $ runReader r x)
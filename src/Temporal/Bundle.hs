{-# LANGUAGE AllowAmbiguousTypes #-}
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
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableSuperClasses #-}
{-# LANGUAGE InstanceSigs #-}
-- | 
-- Module: Temporal.Bundle
-- Description: Utilities to define and reference workflows and activities using records.
--
-- Define and reference workflows and activities using records.
--
-- The usage of this module is best explained by example. First, define a record type
-- that contains all of the workflows and activities that you want to define:
--
-- @
-- data EmailWorkflowsB t f = Workflows
--  { emailNewUser :: Wear t f (Int -> Workflow ())
--  , sendEmail :: Wear t f (String -> Activity () ())
--  , emailPasswordReset :: Wear t f (String -> Workflow ())
--  } deriving (Generic)
--
-- type EmailWorkflows = EmailWorkflowsB Bare Identity
-- type EmailWorkflowsH = EmailWorkflowsB Covered
-- @
-- 
-- We define all of our fields using the 'Wear' type, which is a type family
-- that lets us convert fields from their direct function definitions into
-- versions that are wrapped in a functor.
--
-- Next, we will need some boilerplate instances for this type:
--
-- @
-- instance FunctorB (EmailWorkflowsB Covered)
-- instance TraversableB (EmailWorkflowsB Covered)
-- instance ApplicativeB (EmailWorkflowsB Covered)
-- instance ConstraintsB (EmailWorkflowsB Covered)
-- instance BareB EmailWorkflowsB
-- instance Label (EmailWorkflowsB Covered)
-- @
--
-- As an alternative to using 'Generic' and deriving these instances, you can use
-- 'Temporal.Bundle.TH' to generate them for you. With this style, you don't have
-- to introduce the type parameters manually:
--
-- @
-- import Temporal.Bundle.TH
--
-- passthroughBareB [d|
--   data EmailWorkflows = Workflows
--     { emailNewUser :: Int -> Workflow ()
--     , sendEmail :: String -> Activity () ()
--     , emailPasswordReset :: String -> Workflow ()
--     }
--   |]
-- @
--
-- This will generate the same instances as the manual version above,
-- with the following type synonyms:
--
-- @
-- data EmailWorkflowsB = Workflows {..}
-- type EmailWorkflows = EmailWorkflowsB Bare Identity
-- type EmailWorkflowsH = EmailWorkflowsB Covered
-- @
--
-- Now that we have our record type, we can turn it into references and definitions:
--
-- Using 'refs', we can use our record type to provide references to our workflows and activities.
-- References are essentially identifiers that we can use across application / process boundaries
-- to invoke our workflows and activities with Temporal.
--
-- @
-- wfRefs :: Refs EmailWorkflowsB
-- wfRefs = refs JSON workflowsImpl
-- @
--
-- Now, we can implement our workflows and activities:
--
-- @
-- workflowsImpl :: EmailWorkflows
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
module Temporal.Bundle 
  ( 
  -- * Turning implementations into references and definitions
    refs
  , Refs
  , Ref(..)
  , defs
  , Defs
  , Def(..)
  , collectTemporalDefinitions
  , Impl
  -- * Reexports
  -- * Constraints
  , CanUseAsRefs
  , CanUseAsDefs
  , RefFromFunction(..)
  , RefFromFunction'(..)
  , WorkflowRef(..)
  , ActivityRef(..)
  , InnerActivityResult
  , ApplyDef
  , ApplyRef
  ) where

import Data.EvalRecord 
  ( FunctorRec, ApplicativeRec, TraversableRec, ConstraintsRec, AllRec
  )
import qualified Data.EvalRecord as Rec
import Fcf

import Control.Monad.Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Data.Functor.Const
import Data.Functor.Identity
import qualified Data.HashMap.Strict as HashMap
import Data.Kind
import Data.Proxy
import qualified Data.Text as Text
import GHC.Generics
import GHC.TypeLits
import RequireCallStack
import Data.String (IsString)
import Data.Typeable
import Data.Kind
import qualified Data.List.NonEmpty as NE
import Temporal.Workflow.Types
import Temporal.Payload
import Temporal.Activity
import Temporal.Activity.Definition
import Temporal.Core.Client
import Temporal.Worker
import Temporal.Workflow 
import Temporal.Workflow.Definition
import Temporal.Workflow.Internal.Monad
import UnliftIO

type family ApplyRef (original :: Type) (f :: Type) where
  ApplyRef original (Workflow result) = KnownWorkflow (ArgsOf original) result
  ApplyRef original (Activity env result) = KnownActivity (ArgsOf original) result
  ApplyRef original (_ -> b) = ApplyRef original b
  ApplyRef _ a = TypeError ('Text "Expected a Workflow or Activity, but got " ':<>: 'ShowType a)

-- | A reference to a workflow or activity.
--
-- Depending on whether the result monad is 'Workflow' or 'Activity',
-- the 'Eval' instance will resolve to either a 'KnownWorkflow' or 'KnownActivity'.
data Ref :: Type -> Exp Type 

type instance Eval (Ref f) = ApplyRef f f

type family ApplyDef (f :: Type) where
  ApplyDef (Workflow result) = WorkflowDefinition
  ApplyDef (Activity env result) = ActivityDefinition env
  ApplyDef (_ -> b) = ApplyDef b
  ApplyDef a = TypeError ('Text "Expected a Workflow or Activity, but got " ':<>: 'ShowType a)

data Def :: Type -> Type -> Exp Type

type instance Eval (Def _ f) = ApplyDef f

type family InnerActivityResult (f :: Type) where
  InnerActivityResult (Activity env result) = result
  InnerActivityResult (_ -> b) = InnerActivityResult b
  InnerActivityResult a = TypeError ('Text "Expected an Activity, but got " ':<>: 'ShowType a)

class RefFromFunction' codec (f :: Type) original where
  refFromFunction :: Proxy f -> codec -> String -> Proxy original -> Ref @@ original

instance 
  ( FunctionSupportsCodec' Workflow codec original
  , Ref @@ original ~ KnownWorkflow (ArgsOf original) (ResultOf Workflow original)
  ) => RefFromFunction' codec (Workflow result) original where
  refFromFunction _ codec name f = KnownWorkflow codec $ Text.pack name

instance 
  ( FunctionSupportsCodec' (Activity env) codec original
  , Ref @@ original ~ KnownActivity (ArgsOf original) (ResultOf (Activity env) original)
  ) => RefFromFunction' codec (Activity env result) original where
  refFromFunction _ codec name f = KnownActivity codec $ Text.pack name

instance RefFromFunction' codec b original => RefFromFunction' codec (a -> b) original where
  refFromFunction _ codec name f = refFromFunction (Proxy @b) codec name f

class RefFromFunction' codec f f => RefFromFunction codec f
instance RefFromFunction' codec f f => RefFromFunction codec f

class DefFromFunction' codec env (f :: Type) (original :: Type) where
  defFromFunction :: RequireCallStack => Proxy f -> codec -> String -> original -> Def env @@ original

class DefFromFunction' codec env f f => DefFromFunction codec env f
instance DefFromFunction' codec env f f => DefFromFunction codec env f

instance 
  ( FunctionSupportsCodec' Workflow codec original
  , Def env @@ original ~ WorkflowDefinition 
  ) => DefFromFunction' codec env (Workflow result) original where
  defFromFunction _ codec name f = WorkflowDefinition (Text.pack name) $ \payloads -> do
    eWf <- applyPayloads 
      codec 
      (Proxy @(ArgsOf original)) 
      (Proxy @(Workflow (ResultOf Workflow original)))
      f
      payloads
    pure $ fmap (\wf -> wf >>= \result -> ilift (liftIO $ encode codec result)) eWf


instance 
  ( FunctionSupportsCodec' (Activity env) codec original
  , Def env @@ original ~ ActivityDefinition env
  ) => DefFromFunction' codec env (Activity env result) original where
  defFromFunction _ codec name f = ActivityDefinition 
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

instance DefFromFunction' codec env b original => DefFromFunction' codec env (a -> b) original where
  defFromFunction _ codec name f = defFromFunction @codec @env (Proxy @b) codec name f

-- | A bare record type that supplies the actual implementation of workflows and activities.
type Impl f = f Pure
-- | References to workflows and activities that can be used at invokation callsites.
type Refs f = f Ref
-- | A wrapped version of the implementations that carries information needed to register workflows and activities with the Temporal worker.
type Defs env f = f (Def env)

type CanUseAsRefs f codec = 
  ( ConstraintsRec f
  , AllRec (RefFromFunction codec) f
  , ApplicativeRec f
  )

-- | Produce a record of references to workflows and activities from a record of implementations.
--
-- The fields in the records produced by this function can be used to invoke the workflows and activities
-- via the Temporal client or within Temporal workflows.
refs :: forall r f codec.
  ( CanUseAsRefs r codec
  ) => codec -> r f -> Refs r 
refs codec wfrec = result
  where
    ns :: String
    ns = Rec.typeName (Proxy @r)

    defLabels :: r (ConstFn String)
    defLabels = Rec.pure (\meta -> concat [ns, ".", Rec.name meta])

    convertToKnownWorkflow :: forall wf. RefFromFunction codec wf => Rec.Metadata wf -> String -> Ref @@ wf
    convertToKnownWorkflow = \_ n -> refFromFunction (Proxy @wf) codec n (Proxy @wf)

    result :: r Ref
    result = Rec.mapC @(RefFromFunction codec) convertToKnownWorkflow defLabels

-- | Constraints needed to turn a record of implementations into a record of definitions.
--
-- That is, all of the fields (Workflows, Activities) in the record support the supplied codec,
-- and the activities have an environment of type @env@.
type CanUseAsDefs f codec env = 
  ( ConstraintsRec f
  , AllRec (DefFromFunction codec env) f
  , ApplicativeRec f
  )

-- | Produce a record of definitions from a record of implementations, using the supplied codec.
defs :: forall f codec env. 
  ( CanUseAsDefs f codec env
  ) => codec -> Impl f -> Defs env f
defs codec wfrec = result
  where
    ns :: String
    ns = Rec.typeName (Proxy @f)

    defLabels :: f (ConstFn String)
    defLabels = Rec.pure (\meta -> concat [ns, ".", Rec.name meta])

    labeledFields :: f (Rec.Tuple2 (ConstFn String) Pure)
    labeledFields = Rec.zipWith (\_ label f -> (label, f)) defLabels wfrec

    convertToWorkflowDefinition :: forall wf. (DefFromFunction codec env wf) => Rec.Metadata wf -> (String, wf) -> Def env @@ wf
    convertToWorkflowDefinition = (\_ (n, f) -> provideCallStack $ defFromFunction @codec @env (pure f) codec n f) 

    result :: f (Def env)
    result = Rec.mapC @(DefFromFunction codec env) convertToWorkflowDefinition labeledFields


-- | Convert a record of 'Def' values into a worker and  that you can pass to 'startWorker'.
collectTemporalDefinitions :: forall rec actEnv f. (TraversableRec rec, ConstraintsRec rec, Rec.AllRecF (ToDefinitions actEnv) f rec) => rec f -> Definitions actEnv
collectTemporalDefinitions = Rec.foldMapC @(Rec.ClassF (ToDefinitions actEnv) f) mkConf
  where
    mkConf :: forall a. ToDefinitions actEnv (f @@ a) => Rec.Metadata a -> f @@ a -> Definitions actEnv
    mkConf _ = toDefinitions

type family ActivityOptionsFieldType (f :: Type) :: Type where
  ActivityOptionsFieldType (Activity env result) = StartActivityOptions
  ActivityOptionsFieldType (_ -> b) = ActivityOptionsFieldType b
  ActivityOptionsFieldType (Workflow a) = StartChildWorkflowOptions

class FieldToActivityOptionDefaults f where
  activityOptionDefaults 
    :: Proxy f 
    -> StartActivityOptions 
    -> StartChildWorkflowOptions
    -> ActivityOptionsFieldType f

instance FieldToActivityOptionDefaults b => FieldToActivityOptionDefaults (a -> b) where
  activityOptionDefaults _ act wf = activityOptionDefaults (Proxy @b) act wf

instance FieldToActivityOptionDefaults (Activity env result) where
  activityOptionDefaults _ opts _ = opts

instance FieldToActivityOptionDefaults (Workflow a) where
  activityOptionDefaults _ _ opts = opts


data ActivityOptionDefaults :: Type -> Exp Type

type instance Eval (ActivityOptionDefaults f) = ActivityOptionsFieldType f

-- | Define a record that provides the same default options for all activities in the a record.
--
-- This is useful when you want to provide the same default options for all activities in a record.
-- For example, you might want to provide a default timeout or non-retryable error type list for all activities.
provideDefaultOptions 
  :: forall rec
  .  (ApplicativeRec rec, ConstraintsRec rec, AllRec FieldToActivityOptionDefaults rec) 
  => StartActivityOptions 
  -> StartChildWorkflowOptions
  -> rec ActivityOptionDefaults
provideDefaultOptions act wf = Rec.mapC 
  @FieldToActivityOptionDefaults 
  mkDefaults 
  emptyBase
  where
    mkDefaults :: forall a. FieldToActivityOptionDefaults a => Rec.Metadata a -> () -> ActivityOptionDefaults @@ a
    mkDefaults meta _ = activityOptionDefaults (proxyFromMeta meta) act wf 
    proxyFromMeta :: forall a. Rec.Metadata a -> Proxy a
    proxyFromMeta = const Proxy
    emptyBase :: rec (ConstFn ())
    emptyBase = Rec.pure $ \_ -> ()

data InWorkflowProxies :: Type -> Type -> Exp Type

type instance Eval (InWorkflowProxies ProxySync (KnownWorkflow args res)) = args :->: Workflow res
type instance Eval (InWorkflowProxies ProxyAsync (KnownWorkflow args res)) = args :->: Workflow (ChildWorkflowHandle res)
type instance Eval (InWorkflowProxies ProxySync (KnownActivity args res)) = args :->: Workflow res
type instance Eval (InWorkflowProxies ProxyAsync (KnownActivity args res)) = args :->: Workflow (Task res)

data RefStartOptions :: Type -> Exp Type
type instance Eval (RefStartOptions (KnownWorkflow _ _)) = StartChildWorkflowOptions
type instance Eval (RefStartOptions (KnownActivity _ _)) = StartActivityOptions

class UseAsInWorkflowProxy synchronicity ref where
  useAsInWorkflowProxy 
    :: RequireCallStack 
    => synchronicity 
    -> ref 
    -> RefStartOptions @@ ref 
    -> InWorkflowProxies synchronicity @@ ref

instance UseAsInWorkflowProxy ProxySync (KnownActivity args res) where
  useAsInWorkflowProxy _ = executeActivity 
instance UseAsInWorkflowProxy ProxyAsync (KnownActivity args res) where
  useAsInWorkflowProxy _ = startActivity 

instance UseAsInWorkflowProxy ProxySync (KnownWorkflow args res) where
  useAsInWorkflowProxy _ = executeChildWorkflow
instance UseAsInWorkflowProxy ProxyAsync (KnownWorkflow args res) where
  useAsInWorkflowProxy _ = startChildWorkflow

data ProxySync = ProxySync
data ProxyAsync = ProxyAsync

-- | Combine a record of references with a record of default options to give a record of
-- functions that can be used to start activities and workflows. This is just a convenience
-- function that makes it so that you don't have to call 'executeActivity' or 'executeChildWorkflow'
-- directly as often.
--
-- 
-- inWorkflowProxies 
--   :: forall synchronicity rec
--   .  (ConstraintsRec rec, Rec.AllRecF (UseAsInWorkflowProxy synchronicity) Ref rec, ApplicativeRec rec)
--   => synchronicity
--   -> rec ActivityOptionDefaults 
--   -> rec Ref 
--   -> rec (InWorkflowProxies synchronicity)
-- inWorkflowProxies s = Rec.zipWithC @(UseAsInWorkflowProxy synchronicity) $ \meta opt ref -> 
--   useAsInWorkflowProxy s ref opt


type Workers rec = rec (ConstFn Worker)
type WorkerConfigs env rec = rec (ConstFn (WorkerConfig env))


-- | Start a Temporal worker for each task queue specified in the MercuryTaskQueues record.
--
-- This function starts each worker concurrently, waits for them to initialize, and then returns
-- a worker for each task queue.
startTaskQueues :: forall rec m env. (TraversableRec rec, MonadLoggerIO m, MonadUnliftIO m, MonadCatch m) => Client -> WorkerConfigs env rec -> m (Workers rec)
startTaskQueues client conf = startWorkers conf >>= awaitWorkersStart
  where
    startWorkers :: rec (ConstFn (WorkerConfig env)) -> m (rec (ConstFn (Async Worker)))
    startWorkers = Rec.traverse (\_ workerConfig -> async (startWorker client workerConfig))
    awaitWorkersStart :: rec (ConstFn (Async Worker)) -> m (rec (ConstFn Worker))
    awaitWorkersStart = Rec.traverse (\_ workerStartupThread -> UnliftIO.wait workerStartupThread)

-- | Stop each Temporal worker for each task queue specified in the MercuryTaskQueues record.
--
-- This function stops each worker concurrently, waits for them to complete shutdown (gracefully or not), and then returns.
shutdownTaskQueues :: forall rec. (TraversableRec rec) => Workers rec -> IO ()
shutdownTaskQueues workers =
  stopWorkers workers
    >>= awaitWorkersStop
  where
    stopWorkers :: rec (ConstFn Worker) -> IO (rec (ConstFn (Async ())))
    stopWorkers = Rec.traverse (\_ worker -> async (shutdown worker))
    awaitWorkersStop :: rec (ConstFn (Async ())) -> IO ()
    awaitWorkersStop = Rec.traverse_ (\_ workerShutdownThread -> UnliftIO.wait workerShutdownThread)


-- data ProxyActivity :: k -> Exp k

-- type family ConvertActivity (f :: k) :: k where
--   ConvertActivity (Activity env result) = Workflow result
--   ConvertActivity (a -> b) = a -> ConvertActivity b
--   ConvertActivity a = a

-- type instance Eval (ProxyActivity f) = (Eval (WrapperOf f)) (ConvertActivity (Eval (Unwrap f)))

-- data WorkflowsAsMonadIO :: m -> k -> Exp k

-- type family ConvertWorkflow (m :: Type -> Type) (f :: Type) :: Type where
--   ConvertWorkflow m (Workflow result) = m result
--   ConvertWorkflow m (a -> b) = a -> ConvertWorkflow m b
--   ConvertWorkflow _ a = a

-- type instance Eval (WorkflowsAsMonadIO m f) = (Eval (WrapperOf f)) (ConvertWorkflow m (Eval (Unwrap f)))



{-
data Wrap :: (k -> k) -> k -> Exp k
type instance Eval (Wrap f a) = f a

data WrapperOf :: k -> Exp (k -> k)
type instance Eval (WrapperOf (f x)) = f

fiddleConcrete :: Fiddle Unwrap Identity
fiddleConcrete = Fiddle
  { fiddle = \x -> pure ()
  , faddle = \x -> pure ()
  }

fiddleProxyActivities :: Fiddle (Unwrap <=< WorkflowsAsMonadIO IO <=< ProxyActivity) Identity
fiddleProxyActivities = Fiddle
  { fiddle = \x -> pure ()
  , faddle = \x -> pure ()
  }

class EvalB b where
  bunwrap :: b Pure Identity -> b Unwrap Identity
  bwrap :: b Unwrap Identity -> b Pure Identity

instance EvalB (Fiddle Pure) where
  bunwrap = id
  bwrap = id

bunwrapFrom :: EvalB b => (forall a. f a -> a) -> b Pure f -> b Unwrap Identity
bwrapWith :: EvalB b => (forall a. a -> f a) -> b Unwrap Identity -> b Pure f
-}

-- {-
-- TODO figure out how to support startActivity, executeActivity, and startLocalActivity
-- from this typeclass. 
-- -}
-- class ConvertActivityToProxyWorkflow (f :: Type) where
--   convertActivityToProxyWorkflow :: f -> ConvertActivity f

-- instance ConvertActivityToProxyWorkflow (Activity env result) where
--   convertActivityToProxyWorkflow = undefined

-- instance ConvertActivityToProxyWorkflow b => ConvertActivityToProxyWorkflow (a -> b) where
--   convertActivityToProxyWorkflow = undefined

-- instance (ConvertActivity a ~ a) => ConvertActivityToProxyWorkflow a where
--   convertActivityToProxyWorkflow = id

-- -- TODO, similar to ConvertActivityToProxyWorkflow, figure out how to support
-- -- execute, start, and signalWithStart
-- class ConvertWorkflowToClientInvocation (f :: Type) where
--   -- convertWorkflowToClientInvocation :: MonadIO m => Client -> f -> ConvertWorkflow IO f

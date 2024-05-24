{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuantifiedConstraints #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

module Temporal.Workflow.Definition (
  HasWorkflowDefinition (..),
  WorkflowDefinition (..), -- TODO, only export the type, not the constructor from this module
  KnownWorkflow (..),
  SignalRef (..),
  WorkflowSignalDefinition (..),
  -- , StartChildWorkflow(..)
  provideWorkflow,
  ProvidedWorkflow (..),
  GatherArgs,
  WorkflowRef (..),
) where

import Control.Monad.IO.Class
import Data.Kind
import Data.Text (Text)
import Data.Typeable
import Data.Vector (Vector)
import RequireCallStack
import Temporal.Payload
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Signal


{- | This is a Workflow function that can be called from the outside world.

You can create a definition via 'Temporal.Workflow.provideWorkflow'.

To make a worker use this definition, you must add it to the 'WorkerConfig' via 'Temporal.Workflow.addWorkflow'.
-}
data WorkflowDefinition = WorkflowDefinition
  { workflowName :: Text
  , workflowRun :: Vector Payload -> IO (Either String (Workflow Payload))
  }


class HasWorkflowDefinition a where
  workflowDefinition :: a -> WorkflowDefinition


instance HasWorkflowDefinition WorkflowDefinition where
  workflowDefinition = id


class WorkflowRef (f :: Type) where
  type WorkflowArgs f :: [Type]
  type WorkflowResult f :: Type
  workflowRef :: f -> KnownWorkflow (WorkflowArgs f) (WorkflowResult f)


instance WorkflowRef (KnownWorkflow args result) where
  type WorkflowArgs (KnownWorkflow args result) = args
  type WorkflowResult (KnownWorkflow args result) = result
  workflowRef = id


{- | A 'KnownWorkflow' is a handle that contains all the information needed to start a
Workflow either as a child workflow or as a top-level workflow via a 'Client'.
-}
data KnownWorkflow (args :: [Type]) (result :: Type) = forall codec.
  ( FunctionSupportsCodec codec args result
  ) =>
  KnownWorkflow
  { knownWorkflowCodec :: codec
  , knownWorkflowName :: Text
  }


-- gatherStartChildWorkflowArgs
--   :: forall args result codec. GatherArgs codec args
--   => codec
--   -> ([IO Payload] -> Workflow (ChildWorkflowHandle result))
--   -> (args :->: Workflow (ChildWorkflowHandle result))
-- gatherStartChildWorkflowArgs c f = gatherArgs (Proxy @args) c id f

data ProvidedWorkflow f = ProvidedWorkflow
  { definition :: WorkflowDefinition
  , reference :: KnownWorkflow (ArgsOf f) (ResultOf Workflow f)
  }


instance HasWorkflowDefinition (ProvidedWorkflow f) where
  workflowDefinition :: ProvidedWorkflow f -> WorkflowDefinition
  workflowDefinition = definition


instance VarArgs (ArgsOf f) => WorkflowRef (ProvidedWorkflow f) where
  type WorkflowArgs (ProvidedWorkflow f) = ArgsOf f
  type WorkflowResult (ProvidedWorkflow f) = ResultOf Workflow f
  workflowRef :: ProvidedWorkflow f -> KnownWorkflow (WorkflowArgs (ProvidedWorkflow f)) (WorkflowResult (ProvidedWorkflow f))
  workflowRef = reference


{- | A utility function for constructing a 'WorkflowDefinition' from a function as well as
a 'KnownWorkflow' value. This is useful for keeping the argument, codec, and result types
in sync with each other so that changes to the function are reflected at their use sites.

> myWorkflow :: Workflow () () Int
> myWorkflow = pure 1
>
> myWorkflowDef :: ProvidedWorkflow () () Int
> myWorkflowDef = provideWorkflow
>   JSON -- codec
>   @"myWorkflow" -- visible name of the workflow
>   () -- initial state
>   myWorkflow -- the workflow function
-}
provideWorkflow
  :: forall codec f
   . ( f ~ (ArgsOf f :->: Workflow (ResultOf Workflow f))
     , FunctionSupportsCodec codec (ArgsOf f) (ResultOf Workflow f)
     )
  => codec
  -> Text
  -> (RequireCallStackImpl => f)
  -> ProvidedWorkflow f
provideWorkflow codec name f =
  provideCallStack $
    ProvidedWorkflow
      { definition =
          WorkflowDefinition
            { workflowName = name
            , workflowRun = \payloads -> do
                eWf <-
                  applyPayloads
                    codec
                    (Proxy @(ArgsOf f))
                    (Proxy @(Workflow (ResultOf Workflow f)))
                    f
                    payloads
                pure $ fmap (\wf -> wf >>= \result -> ilift (liftIO $ encode codec result)) eWf
            }
      , reference =
          KnownWorkflow
            { knownWorkflowCodec = codec
            , knownWorkflowName = name
            }
      }


{- |
A Signal is an asynchronous request to a Workflow Execution.

A Signal delivers data to a running Workflow Execution. It cannot return data to the caller;
to do so, use a Query instead. The Workflow code that handles a Signal can mutate Workflow state.
A Signal can be sent from a Temporal Client or a Workflow.
When a Signal is sent, it is received by the Cluster and recorded as an Event to the Workflow Execution Event History.
A successful response from the Cluster means that the Signal has been persisted and will be delivered at least once to
the Workflow Execution.

A Signal must include a destination (Namespace and Workflow Id) and name. It can include a list of arguments.

Signal handlers are Workflow functions that listen for Signals by the Signal name.
Signals are delivered in the order they are received by the Cluster.
If multiple deliveries of a Signal would be a problem for your Workflow, add idempotency logic to your Signal handler
that checks for duplicates.
-}
data WorkflowSignalDefinition
  = forall codec f.
    (FunctionSupportsCodec codec (ArgsOf f) (ResultOf Workflow f), ResultOf Workflow f ~ ()) =>
    WorkflowSignalDefinition
      Text -- name
      codec
      f
      (f -> Vector Payload -> IO (Either String (Workflow ())))

-- { workflowSignalName :: Text
-- , workflowSignalHandler :: [Payload] -> IO ()
-- }

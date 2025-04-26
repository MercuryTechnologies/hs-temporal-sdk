{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# LANGUAGE RoleAnnotations #-}

module Temporal.Workflow.Internal.Monad where

import Control.Applicative
import Control.Concurrent.Async
import Control.Monad
import qualified Control.Monad.Catch as Catch
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.Trans.Resource
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HashMap
import Data.Kind
import Data.Map.Strict (Map)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import Data.Vault.Strict
import Data.Vector (Vector)
import Data.Word (Word32)
-- import Debug.Trace
import GHC.Stack
import GHC.TypeLits
import Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (WorkflowCommand)
import RequireCallStack
import Temporal.Common
import qualified Temporal.Core.Worker as Core
import Temporal.Exception
import Temporal.Payload
import Temporal.Workflow.ChildWorkflowHandle
import Temporal.Workflow.IVar
import Temporal.Workflow.Instance
import Temporal.Workflow.Internal.MonadV2
import Temporal.Workflow.Task
import Temporal.Workflow.Types
import Text.Printf
import UnliftIO
import qualified Temporal.Workflow.CommandQueue as CommandQueue

addCommand :: WorkflowCommand -> InstanceM ()
addCommand command = do
  inst <- ask


-- Bit of a hack. This needs to be called for each workflow activity in the official SDK
updateCallStack :: RequireCallStack => InstanceM ()
updateCallStack = do
  inst <- asks workflowRuntimeInstance
  writeIORef inst.workflowCallStack $ popCallStack callStack


updateCallStackW :: RequireCallStack => Workflow ()
updateCallStackW = Workflow do
  inst <- asks workflowRuntimeInstance
  writeIORef inst.workflowCallStack $ popCallStack callStack


{- | Handle representing an external Workflow Execution.

This handle can only be cancelled and signalled.

To call other methods, like query and result, use a WorkflowClient.getHandle inside an Activity.
-}
data ExternalWorkflowHandle (result :: Type) = ExternalWorkflowHandle
  { externalWorkflowWorkflowId :: WorkflowId
  , externalWorkflowRunId :: Maybe RunId
  }

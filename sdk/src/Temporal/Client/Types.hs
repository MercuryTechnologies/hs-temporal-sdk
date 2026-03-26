{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveLift #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Temporal.Client.Types where

import Data.Aeson (FromJSON, ToJSON)
import Data.Int (Int32)
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Vector (Vector)
import GHC.Generics (Generic)
import Language.Haskell.TH.Syntax (Lift)
import Temporal.Common
import Temporal.Core.Client (Client)
import Temporal.Duration
import Temporal.Payload
import Temporal.SearchAttributes


-- | Configuration parameters for starting a workflow execution.
data StartWorkflowOptions = StartWorkflowOptions
  { taskQueue :: TaskQueue
  -- ^ A Task Queue is a lightweight, dynamically allocated queue that one or more Worker Entities poll for Tasks.
  --
  -- Task Queues are very lightweight components. Task Queues do not require explicit registration but instead are created on demand when
  -- a Workflow Execution spawns or when a Worker Process subscribes to it. When a Task Queue is created, both a Workflow Task Queue and
  -- an Activity Task Queue are created under the same name. There is no limit to the number of Task Queues a Temporal Application
  -- can use or a Temporal Cluster can maintain.
  , followRuns :: Bool
  , workflowIdReusePolicy :: Maybe WorkflowIdReusePolicy
  -- ^ A Workflow Id Reuse Policy determines whether a Workflow Execution is allowed to spawn with a particular Workflow Id, if that Workflow Id has been used with a previous, and now Closed, Workflow Execution.
  --
  -- It is not possible for a new Workflow Execution to spawn with the same Workflow Id as another Open Workflow Execution, regardless of the Workflow Id Reuse Policy. In some cases, an attempt to spawn a Workflow
  -- Execution with a Workflow Id that is the same as the Id of a currently Open Workflow Execution results in a @Workflow execution already started@ error.
  , workflowIdConflictPolicy :: Maybe WorkflowIdConflictPolicy
  -- ^ A Workflow Id Conflict Policy determines how to resolve a conflict when spawning
  -- a new Workflow Execution with a particular Workflow Id used by an existing Open Workflow Execution.
  , retryPolicy :: Maybe RetryPolicy
  -- ^ A Retry Policy can work in cooperation with the timeouts to provide fine controls to optimize the execution experience.
  --
  -- Use a Retry Policy to retry a Workflow Execution in the event of a failure.
  --
  -- Workflow Executions do not retry by default, and Retry Policies should be used with Workflow Executions only in
  -- certain situations.
  --
  -- This should not be confused with Activity retry policies, which are used to retry Activities and specified at those
  -- callsites.
  , cronSchedule :: Maybe Text
  -- ^ A Temporal Cron Job is the series of Workflow Executions that occur when a Cron Schedule is
  -- provided in the call to spawn a Workflow Execution.
  --
  -- A Cron Schedule is provided as an option when the call to spawn a Workflow Execution is made.
  --
  -- You can set each Workflow to repeat on a schedule with the cronSchedule option:
  --
  -- >
  -- > Temporal.Client.start scheduledWorkflow
  -- >   (Temporal.Client.startWorkflowOptions "my-workflow" "my-task-queue") { cronSchedule = Just "* * * * *" } -- start every minute
  -- >
  --
  -- Note that Temporal offers more advanced scheduling support via 'Temporal.Client.Schedule', so
  -- it is generally recommended to use that instead of Cron Schedules.
  , memo :: !(Map Text Payload)
  -- ^ A Memo is a non-indexed set of Workflow Execution metadata that developers supply at start time or
  -- in Workflow code and that is returned when you describe or list Workflow Executions.
  --
  -- The primary purpose of using a Memo is to enhance the organization and management of Workflow Executions.
  -- Add your own metadata, such as notes or descriptions, to a Workflow Execution, which lets you annotate and
  -- categorize Workflow Executions based on developer-defined criteria. This feature is particularly useful
  -- when dealing with numerous Workflow Executions because it facilitates the addition of context, reminders,
  -- or any other relevant information that aids in understanding or tracking the Workflow Execution.
  , searchAttributes :: !(Map SearchAttributeKey SearchAttributeType)
  -- ^ Search attributes are indexed by the Temporal server and can be used in queries on the dashboard
  -- or by the Temporal CLI to find Workflows. These values are not encrypted and can be seen by anyone
  -- with access to the Temporal namespace.
  , headers :: !(Map Text Payload)
  -- ^ Custom headers to be added to the Workflow Execution. These are generally more useful for interceptors
  -- to add metadata to the Workflow rather than for application code.
  , timeouts :: TimeoutOptions
  -- ^ Each Workflow timeout controls the maximum duration of a different aspect of a Workflow Execution.
  , requestEagerExecution :: Bool
  -- ^ Eager activity execution is an optimization on some servers that sends activities
  -- back to the same worker as the calling workflow if they can run there.
  , workflowStartDelay :: Maybe Duration
  , priority :: Maybe Priority
  -- ^ Controls relative ordering of task processing when tasks are backlogged
  -- in a task queue. See 'Priority' for full details.
  --
  -- Use 'mkPriority' for the common case:
  --
  -- @
  -- opts { priority = Just ('mkPriority' 1) }
  -- @
  --
  -- 'Nothing' (the default) inherits from the calling workflow, or uses the
  -- server default (typically @3@ with a 1–5 range).
  }
  deriving stock (Show, Eq, Lift)


{- | Controls relative ordering of task processing when tasks are backlogged in
a task queue. Maps to the Temporal @temporal.api.common.v1.Priority@ proto.

Priority is attached to workflows and activities. Activities and child workflows
__inherit__ 'Priority' from the workflow that created them, but may override
individual fields when started. For each field, a zero\/empty value means
\"inherit from the calling workflow\", or if there is no calling workflow, use
the server default.

The overall dispatch semantics are:

1. __'priorityKey'__: lower number goes first (priority 1 beats priority 5).
2. __'fairnessKey'__ and __'fairnessWeight'__: within a single priority level
   the server partitions work by fairness key and dispatches in proportion to
   weight.

Tasks in a queue are processed in close-to-priority order, although small
deviations are possible (especially with multiple task queue partitions).

==== Minimal usage

Most callers only need 'mkPriority':

@
opts { priority = Just ('mkPriority' 1) }   -- high priority
opts { priority = Just ('mkPriority' 5) }   -- lower priority
@

==== Fairness partitioning

The fairness mechanism prevents a single high-volume tenant from monopolising
all workers on a shared task queue. Set 'fairnessKey' to a tenant\/account
identifier (or a fixed label like @\"high\"@\/@\"low\"@) and the server will
dispatch tasks for each key in proportion to its 'fairnessWeight'.

@
Priority
  { priorityKey   = 2
  , fairnessKey   = \"tenant-abc\"
  , fairnessWeight = 1.0
  }
@

Weights can also be overridden per-key via the server's @UpdateTaskQueueConfig@
API (takes precedence over weights set here).

Leave 'fairnessKey' empty and 'fairnessWeight' at @0@ unless your deployment
specifically needs fairness partitioning.
-}
data Priority = Priority
  { priorityKey :: !Int32
  -- ^ Positive integer from 1 to /n/ where __smaller integers correspond to
  -- higher priority__ (tasks run sooner). The maximum value (minimum priority)
  -- is determined by server configuration and defaults to @5@. The default
  -- priority when unset is @(min + max) \/ 2@, which is @3@ with the default
  -- range of 1–5.
  , fairnessKey :: !Text
  -- ^ Short string (max 64 bytes) used as a key for fairness balancing within
  -- the same priority level. Can correspond to a tenant ID or a fixed label
  -- like @\"high\"@\/@\"low\"@. The server dispatches tasks for a given key in
  -- proportion to its 'fairnessWeight'. Default is @\"\"@ (empty — no fairness
  -- partitioning).
  , fairnessWeight :: !Float
  -- ^ Weight for task dispatch for the associated 'fairnessKey'. Tasks for a
  -- fairness key are dispatched in proportion to their weight. The server
  -- clamps values to the range @[0.001, 1000]@. Default weight is @1.0@.
  --
  -- Effective weight precedence (highest to lowest):
  --
  -- 1. Weights overridden in task queue configuration (@UpdateTaskQueueConfig@ API)
  -- 2. Weights attached to the workflow\/activity (this field)
  -- 3. Server default of @1.0@
  }
  deriving stock (Show, Eq, Generic, Lift)


instance ToJSON Priority


instance FromJSON Priority


{- | Construct a 'Priority' from just the numeric key, leaving fairness
fields at their defaults (@fairnessKey = \"\"@, @fairnessWeight = 0@).

Lower values mean higher priority. With the default server range of 1–5:

@
'mkPriority' 1  -- highest priority (runs first)
'mkPriority' 3  -- default priority
'mkPriority' 5  -- lowest priority (runs last)
@
-}
mkPriority :: Int32 -> Priority
mkPriority k = Priority {priorityKey = k, fairnessKey = "", fairnessWeight = 0}


{- | Smart constructor for 'StartWorkflowOptions'.

At a minimum, a 'Workflow' execution requires a 'TaskQueue' (taken as an argument here) and a 'WorkflowId' (provided
as an argument to the workflow execution function).

'WorkflowId's are used to uniquely identify a running 'Workflow' and must be unique, themselves, unless a 'Workflow'
is configured with a 'WorkflowIdReusePolicy' that permits duplication.
-}
startWorkflowOptions :: TaskQueue -> StartWorkflowOptions
startWorkflowOptions tq =
  StartWorkflowOptions
    { taskQueue = tq
    , followRuns = True
    , workflowIdReusePolicy = Nothing
    , workflowIdConflictPolicy = Nothing
    , retryPolicy = Nothing
    , cronSchedule = Nothing
    , memo = mempty
    , searchAttributes = mempty
    , headers = mempty
    , timeouts =
        TimeoutOptions
          { executionTimeout = Nothing
          , runTimeout = Nothing
          , taskTimeout = Nothing
          }
    , requestEagerExecution = False
    , workflowStartDelay = Nothing
    , priority = Nothing
    }


data WorkflowClientConfig = WorkflowClientConfig
  { namespace :: !Namespace
  -- ^ Default namespace for all workflows started by this client.
  , interceptors :: !ClientInterceptors
  -- ^ Interceptors to be used by the client.
  , payloadProcessor :: !PayloadProcessor
  -- ^ The payload processor to be used by the client.
  --
  -- This can be used to apply encryption and compression to payloads.
  , enableTimeSkipping :: !Bool
  -- ^ Whether to enable "time-skipping" for testing.
  }


-- TODO
-- , clientHeaders :: Map Text Payload

mkWorkflowClientConfig :: Namespace -> WorkflowClientConfig
mkWorkflowClientConfig ns =
  WorkflowClientConfig
    { namespace = ns
    , interceptors = mempty
    , payloadProcessor = PayloadProcessor pure (pure . Right)
    , enableTimeSkipping = False
    }


mkTimeSkippingWorkflowClientConfig :: Namespace -> WorkflowClientConfig
mkTimeSkippingWorkflowClientConfig ns =
  let c = mkWorkflowClientConfig ns
  in c {enableTimeSkipping = True}


data WorkflowClient = WorkflowClient
  { clientCore :: {-# UNPACK #-} !Client
  , clientConfig :: {-# UNPACK #-} !WorkflowClientConfig
  }


data WorkflowHandle a = WorkflowHandle
  { workflowHandleReadResult :: Payload -> IO a
  , workflowHandleType :: WorkflowType
  , workflowHandleClient :: WorkflowClient
  , workflowHandleWorkflowId :: WorkflowId
  , workflowHandleRunId :: Maybe RunId
  , workflowHandleFirstExecutionRunId :: Maybe RunId
  }


instance Functor WorkflowHandle where
  fmap f w = w {workflowHandleReadResult = fmap f . workflowHandleReadResult w}


-- | QueryRejectCondition can used to reject the query if workflow state does not satisfy condition.
data QueryRejectCondition
  = -- | indicates that query should not be rejected
    QueryRejectConditionRejectNone
  | -- | indicates that query should be rejected if workflow is not open
    QueryRejectConditionNotOpen
  | -- | indicates that query should be rejected if workflow did not complete cleanly
    QueryRejectConditionNotCompletedCleanly


data QueryWorkflowInput = QueryWorkflowInput
  { queryWorkflowWorkflowId :: WorkflowId
  , queryWorkflowRejectCondition :: QueryRejectCondition
  , queryWorkflowHeaders :: Map Text Payload
  , queryWorkflowType :: Text
  , queryWorkflowRunId :: Maybe RunId
  , queryWorkflowArgs :: Vector Payload
  }


data UpdateWorkflowInput = UpdateWorkflowInput
  { updateWorkflowWorkflowId :: WorkflowId
  , updateWorkflowHeaders :: Map Text Payload
  , updateWorkflowType :: Text
  , updateWorkflowRunId :: Maybe RunId
  , updateWorkflowArgs :: Vector Payload
  }


data UpdateHandle a = UpdateHandle
  { updateHandleUpdateId :: UpdateId
  , updateHandleWorkflowId :: WorkflowId
  , updateHandleWorkflowRunId :: Maybe RunId
  , updateHandleReadResult :: Payload -> IO a
  , updateHandleWorkflowClient :: WorkflowClient
  , updateHandleType :: Text
  }


instance Functor UpdateHandle where
  fmap x y = y {updateHandleReadResult = fmap x . updateHandleReadResult y}


data WorkflowExecutionStatus
  = Running
  | Completed
  | Failed
  | Canceled
  | Terminated
  | ContinuedAsNew
  | TimedOut
  | UnknownStatus
  deriving stock (Read, Show, Eq, Ord)


data QueryRejected = QueryRejected
  { status :: WorkflowExecutionStatus
  }
  deriving stock (Read, Show, Eq, Ord)


data SignalWithStartWorkflowInput = SignalWithStartWorkflowInput
  { signalWithStartWorkflowType :: WorkflowType
  , signalWithStartWorkflowId :: WorkflowId
  , signalWithStartArgs :: Vector Payload
  , signalWithStartSignalName :: Text
  , signalWithStartSignalArgs :: Vector Payload
  , signalWithStartOptions :: StartWorkflowOptions
  }


data ClientInterceptors = ClientInterceptors
  { start :: WorkflowType -> WorkflowId -> StartWorkflowOptions -> Vector Payload -> (WorkflowType -> WorkflowId -> StartWorkflowOptions -> Vector Payload -> IO (WorkflowHandle Payload)) -> IO (WorkflowHandle Payload)
  , queryWorkflow :: QueryWorkflowInput -> (QueryWorkflowInput -> IO (Either QueryRejected Payload)) -> IO (Either QueryRejected Payload)
  , signalWithStart :: SignalWithStartWorkflowInput -> (SignalWithStartWorkflowInput -> IO (WorkflowHandle Payload)) -> IO (WorkflowHandle Payload)
  , updateWorkflow :: UpdateWorkflowInput -> (UpdateWorkflowInput -> IO (UpdateHandle Payload)) -> IO (UpdateHandle Payload)
  -- TODO
  -- signal
  -- terminate
  -- cancel
  -- describe
  }


instance Semigroup ClientInterceptors where
  a <> b =
    ClientInterceptors
      { start = \t wfId o ps next -> a.start t wfId o ps $ \t' wfId' o' ps' -> b.start t' wfId' o' ps' next
      , queryWorkflow = \i next -> a.queryWorkflow i $ \i' -> b.queryWorkflow i' next
      , signalWithStart = \i next -> a.signalWithStart i $ \i' -> b.signalWithStart i' next
      , updateWorkflow = \i next -> a.updateWorkflow i $ \i' -> b.updateWorkflow i' next
      }


instance Monoid ClientInterceptors where
  mempty =
    ClientInterceptors
      (\t wf o ps next -> next t wf o ps)
      (\i next -> next i)
      (\i next -> next i)
      (\i next -> next i)

-- , signal :: SignalWorkflowInput -> (SignalWorkflowInput -> IO ()) -> IO ()
--   -- , signalWithStart :: SignalWithStartWorkflowInput -> (SignalWithStartWorkflowInput -> IO ()) -> IO ()
--   -- , query :: QueryWorkflowInput -> (QueryWorkflowInput -> IO ()) -> IO ()
--   -- , terminate :: TerminateWorkflowInput -> (TerminateWorkflowInput -> IO ()) -> IO ()
--   -- , cancel :: CancelWorkflowInput -> (CancelWorkflowInput -> IO ()) -> IO ()
--   -- , describe :: DescribeWorkflowInput -> (DescribeWorkflowInput -> IO ()) -> IO ()
--   }

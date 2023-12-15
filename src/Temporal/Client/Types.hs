module Temporal.Client.Types where
import Temporal.Common
import Data.Map.Strict (Map)
import Data.Text (Text)
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.Duration
import Temporal.Workflow.Definition
import Temporal.Core.Client (Client)

-- | Configuration parameters for starting a workflow execution.
data WorkflowStartOptions = WorkflowStartOptions
  { workflowId :: Maybe WorkflowId
  -- ^ A Workflow Id is a customizable, application-level identifier for a Workflow Execution that is unique to an Open Workflow Execution within a Namespace.
  --
  -- A Workflow Id is meant to be a business-process identifier such as customer identifier or order identifier.
  --
  -- A Workflow Id Reuse Policy can be used to manage whether a Workflow Id can be re-used. The Temporal Platform guarantees uniqueness of the Workflow Id within a Namespace based on the Workflow Id Reuse Policy.
  --
  -- A Workflow Execution can be uniquely identified across all Namespaces by its Namespace, Workflow Id, and Run Id.
  , taskQueue :: Maybe TaskQueue
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
  , retry :: Maybe RetryPolicy
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
  -- >   (Temporal.Client.workflowStartOptions "my-workflow" "my-task-queue") { cronSchedule = Just "* * * * *" } -- start every minute
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
  , searchAttributes :: !(Map Text SearchAttributeType)
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
  }

-- | Smart constructor for 'WorkflowStartOptions'.
--
-- At a minimum, a 'Workflow' execution requires a 'WorkflowId' and a 'TaskQueue'.
--
-- It is recommend to specify 'WorkflowId' in most cases, as it is used to uniquely identify a 'Workflow' execution,
-- but if one is not specified then a random UUID will be generated.
workflowStartOptions :: WorkflowStartOptions
workflowStartOptions = WorkflowStartOptions
  { workflowId = Nothing
  , taskQueue = Nothing
  , followRuns = True
  , workflowIdReusePolicy = Nothing
  , retry = Nothing
  , cronSchedule = Nothing
  , memo = mempty
  , searchAttributes = mempty
  , headers = mempty
  , timeouts = TimeoutOptions
    { executionTimeout = Nothing
    , runTimeout = Nothing
    , taskTimeout = Nothing
    }
  , requestEagerExecution = False
  , workflowStartDelay = Nothing
  }

data TimeoutOptions = TimeoutOptions
  { executionTimeout :: Maybe Duration
  -- ^ A Workflow Execution Timeout is the maximum time that a Workflow Execution can be executing (have an Open status) including retries and any usage of Continue As New.
  --
  -- The default value is ∞ (infinite). If this timeout is reached, the Workflow Execution changes to a Timed Out status. This timeout is different from the Workflow Run Timeout. This timeout is most commonly used for stopping the execution of a Temporal Cron Job after a certain amount of time has passed.
  , runTimeout :: Maybe Duration
  -- ^ A Workflow Run Timeout is the maximum amount of time that a single Workflow Run is restricted to.
  --
  -- The default is set to the same value as the Workflow Execution Timeout. This timeout is most commonly used to limit the execution time of a single Temporal Cron Job Execution.
  --
  -- If the Workflow Run Timeout is reached, the Workflow Execution is Terminated.
  , taskTimeout :: Maybe Duration
  -- ^ A Workflow Task Timeout is the maximum amount of time allowed for a Worker to execute a Workflow Task after the Worker has pulled that Workflow Task from the Task Queue.
  --
  -- The default value is 10 seconds. This timeout is primarily available to recognize whether a Worker has gone down so that the Workflow Execution can be recovered on a different Worker. The main reason for increasing the default value would be to accommodate a Workflow Execution that has a very long Workflow Execution History that could take longer than 10 seconds for the Worker to load.
  }

data WorkflowClient = WorkflowClient 
  { clientCore :: Client
  , clientDefaultNamespace :: Namespace
  , clientInterceptors :: ClientInterceptors
  -- , clientHeaders :: Map Text Payload
  }

data WorkflowHandle a = WorkflowHandle
  { workflowHandleReadResult :: Payload -> IO a
  , workflowHandleType :: WorkflowType
  , workflowHandleClient :: WorkflowClient
  , workflowHandleWorkflowId :: WorkflowId
  , workflowHandleRunId :: Maybe RunId
  }

instance Functor WorkflowHandle where
  fmap f w = w { workflowHandleReadResult = fmap f . workflowHandleReadResult w }

-- | QueryRejectCondition can used to reject the query if workflow state does not satisfy condition.
data QueryRejectCondition
  = QueryRejectConditionRejectNone
  -- ^ indicates that query should not be rejected
  | QueryRejectConditionNotOpen
  -- ^ indicates that query should be rejected if workflow is not open
  | QueryRejectConditionNotCompletedCleanly
  -- ^ indicates that query should be rejected if workflow did not complete cleanly

data QueryWorkflowInput = QueryWorkflowInput 
  { queryWorkflowWorkflowId :: WorkflowId
  , queryWorkflowRejectCondition :: QueryRejectCondition
  , queryWorkflowHeaders :: Map Text Payload
  , queryWorkflowType :: Text
  , queryWorkflowRunId :: Maybe RunId
  , queryWorkflowArgs :: [Payload]
  }

data WorkflowExecutionStatus
  = Running
  | Completed
  | Failed
  | Canceled
  | Terminated
  | ContinuedAsNew
  | TimedOut
  | UnknownStatus
  deriving (Read, Show, Eq, Ord)

data QueryRejected
  = QueryRejected
    { status :: WorkflowExecutionStatus
    } deriving (Read, Show, Eq, Ord)

data SignalWithStartWorkflowInput = SignalWithStartWorkflowInput
  { signalWithStartWorkflowType :: WorkflowType
  , signalWithStartArgs :: [Payload]
  , signalWithStartSignalName :: Text
  , signalWithStartSignalArgs :: [Payload]
  , signalWithStartOptions :: WorkflowStartOptions
  }

data ClientInterceptors = ClientInterceptors
  { start :: WorkflowType -> WorkflowStartOptions -> [Payload] -> (WorkflowType -> WorkflowStartOptions -> [Payload] -> IO (WorkflowHandle Payload)) -> IO (WorkflowHandle Payload)
  , queryWorkflow :: QueryWorkflowInput -> (QueryWorkflowInput -> IO (Either QueryRejected Payload)) -> IO (Either QueryRejected Payload)
  , signalWithStart :: SignalWithStartWorkflowInput -> (SignalWithStartWorkflowInput -> IO (WorkflowHandle Payload)) -> IO (WorkflowHandle Payload)
  -- TODO
  -- signal
  -- terminate
  -- cancel
  -- describe
  }

instance Semigroup ClientInterceptors where
  a <> b = ClientInterceptors 
    { start = \t o ps next -> a.start t o ps $ \t' o' ps' -> b.start t' o' ps' next
    , queryWorkflow = \i next -> a.queryWorkflow i $ \i' -> b.queryWorkflow i' next
    , signalWithStart = \i next -> a.signalWithStart i $ \i' -> b.signalWithStart i' next
    }

instance Monoid ClientInterceptors where
  mempty = ClientInterceptors
    (\t o ps next -> next t o ps)
    (\i next -> next i)
    (\i next -> next i)

-- , signal :: SignalWorkflowInput -> (SignalWorkflowInput -> IO ()) -> IO ()
--   -- , signalWithStart :: SignalWithStartWorkflowInput -> (SignalWithStartWorkflowInput -> IO ()) -> IO ()
--   -- , query :: QueryWorkflowInput -> (QueryWorkflowInput -> IO ()) -> IO ()
--   -- , terminate :: TerminateWorkflowInput -> (TerminateWorkflowInput -> IO ()) -> IO ()
--   -- , cancel :: CancelWorkflowInput -> (CancelWorkflowInput -> IO ()) -> IO ()
--   -- , describe :: DescribeWorkflowInput -> (DescribeWorkflowInput -> IO ()) -> IO ()
--   }
module Temporal.Client.Types where
import Temporal.Common
import Data.Map.Strict (Map)
import Data.Text (Text)
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.Duration
import Temporal.Workflow.Definition
import Temporal.Core.Client (Client)

data WorkflowStartOptions = WorkflowStartOptions
  { workflowId :: WorkflowId
  , taskQueue :: TaskQueue
  , followRuns :: Bool
  , workflowIdReusePolicy :: Maybe WorkflowIdReusePolicy
  , retry :: Maybe RetryPolicy
  , cronSchedule :: Maybe Text
  , memo :: !(Map Text Payload)
  , searchAttributes :: !(Map Text SearchAttributeType)
  , headers :: !(Map Text Payload)
  , timeouts :: TimeoutOptions
  , requestEagerExecution :: Bool
  }

workflowStartOptions :: WorkflowId -> TaskQueue -> WorkflowStartOptions
workflowStartOptions wfId tq = WorkflowStartOptions
  { workflowId = wfId
  , taskQueue = tq
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
  }

data TimeoutOptions = TimeoutOptions
  { executionTimeout :: Maybe Duration
  , runTimeout :: Maybe Duration
  , taskTimeout :: Maybe Duration
  }

data WorkflowClient = WorkflowClient 
  { clientCore :: Client
  , clientDefaultNamespace :: Namespace
  , clientInterceptors :: ClientInterceptors
  -- , clientDefaultQueue :: TaskQueue
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
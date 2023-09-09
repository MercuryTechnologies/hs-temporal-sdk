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
  , memo :: !(Map Text RawPayload)
  , searchAttributes :: !(Map Text SearchAttributeType)
  , headers :: !(Map Text RawPayload)
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
  -- , clientHeaders :: Map Text RawPayload
  }

data WorkflowHandle a = WorkflowHandle
  { workflowHandleReadResult :: RawPayload -> IO a
  , workflowHandleType :: WorkflowType
  , workflowHandleClient :: WorkflowClient
  , workflowHandleWorkflowId :: WorkflowId
  , workflowHandleRunId :: Maybe RunId
  }

instance Functor WorkflowHandle where
  fmap f w = w { workflowHandleReadResult = fmap f . workflowHandleReadResult w }

data ClientInterceptors = ClientInterceptors
  { start :: WorkflowType -> WorkflowStartOptions -> [RawPayload] -> (WorkflowType -> WorkflowStartOptions -> [RawPayload] -> IO (WorkflowHandle RawPayload)) -> IO (WorkflowHandle RawPayload)
  }

instance Semigroup ClientInterceptors where
  ClientInterceptors a <> ClientInterceptors b = ClientInterceptors $ \t o ps next -> a t o ps $ \t' o' ps' -> b t' o' ps' next

instance Monoid ClientInterceptors where
  mempty = ClientInterceptors
    (\t o ps next -> next t o ps)

-- , signal :: SignalWorkflowInput -> (SignalWorkflowInput -> IO ()) -> IO ()
--   -- , signalWithStart :: SignalWithStartWorkflowInput -> (SignalWithStartWorkflowInput -> IO ()) -> IO ()
--   -- , query :: QueryWorkflowInput -> (QueryWorkflowInput -> IO ()) -> IO ()
--   -- , terminate :: TerminateWorkflowInput -> (TerminateWorkflowInput -> IO ()) -> IO ()
--   -- , cancel :: CancelWorkflowInput -> (CancelWorkflowInput -> IO ()) -> IO ()
--   -- , describe :: DescribeWorkflowInput -> (DescribeWorkflowInput -> IO ()) -> IO ()
--   }
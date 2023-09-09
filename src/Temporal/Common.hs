{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Common where
import Data.Hashable (Hashable)
import Data.ByteString (ByteString)
import Data.Time.Clock.System
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import Data.Int (Int32)
import Data.ProtoLens
import Data.String
import Data.Vector (Vector)
import Data.Word (Word32)
import Lens.Family2
import qualified Proto.Google.Protobuf.Timestamp as Timestamp
import qualified Proto.Google.Protobuf.Timestamp_Fields as Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Message
import qualified Proto.Temporal.Api.Enums.V1.Workflow as Workflow
import Temporal.Duration
import Data.Kind
import Data.Proxy
import Temporal.Payload
import qualified Data.Text as T
import Data.Map (Map)

-- | This is generally the name of the function itself
newtype WorkflowType = WorkflowType { rawWorkflowType :: Text }
  deriving (Eq, Ord, Show, Hashable, IsString)

-- | A Workflow Id is a customizable, application-level identifier for a Workflow Execution that is unique to an Open Workflow Execution within a Namespace.
newtype WorkflowId = WorkflowId { rawWorkflowId :: Text }
  deriving (Eq, Ord, Show, Hashable, IsString)

-- | A Namespace is a unit of isolation within the Temporal Platform
newtype Namespace = Namespace { rawNamespace :: Text }
  deriving (Eq, Ord, Show, Hashable)

-- | A Run Id is a globally unique, platform-level identifier for a Workflow Execution.
newtype RunId = RunId { rawRunId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype PatchId = PatchId { rawPatchId :: Text }
  deriving (Eq, Ord, Show, Hashable)

-- | A Task Queue is a queue that a Worker Process polls for Tasks.
--
-- Task Queues do not have any ordering guarantees. 
-- It is possible to have a Task that stays in a Task Queue for a period of time, if there is a backlog that wasn't drained for that time.
--
-- Task Queues are very lightweight components. 
-- Task Queues do not require explicit registration but instead are created on demand when a Workflow Execution or Activity spawns or 
-- when a Worker Process subscribes to it. When a Task Queue is created, both a Workflow Task Queue and an Activity Task Queue are 
-- created under the same name. There is no limit to the number of Task Queues a Temporal Application can use or a Temporal Cluster 
-- can maintain.
newtype TaskQueue = TaskQueue { rawTaskQueue :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype ActivityType = ActivityType { rawActivityType :: Text }
  deriving (Eq, Ord, Show, Hashable)

-- | A unique identifier for an Activity Execution.
newtype ActivityId = ActivityId { rawActivityId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype ScheduleId = ScheduleId { rawScheduleId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype SignalId = SignalId { rawSignalId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype TimerId = TimerId { rawTimerId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype CancellationId = CancellationId { rawCancellationId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype QueryId = QueryId { rawQueryId :: Text }
  deriving (Eq, Ord, Show, Hashable)

newtype TaskToken = TaskToken { rawTaskToken :: ByteString }
  deriving (Eq, Show, Ord, Hashable)

timespecFromTimestamp :: Timestamp.Timestamp -> SystemTime
timespecFromTimestamp ts = MkSystemTime
  { systemSeconds = ts ^. Timestamp.seconds
  , systemNanoseconds = fromIntegral (ts ^. Timestamp.nanos)
  }

timespecToTimestamp :: SystemTime -> Timestamp.Timestamp
timespecToTimestamp ts = defMessage
  & Timestamp.seconds .~ systemSeconds ts
  & Timestamp.nanos .~ fromIntegral (systemNanoseconds ts)

-- | A Retry Policy is a collection of attributes that instructs the Temporal Server how to retry a failure of a Workflow Execution or an Activity Task Execution.
data RetryPolicy = RetryPolicy
  { initialInterval :: Duration
  , backoffCoefficient :: Double
  , maximumInterval :: Maybe Duration
  , maximumAttempts :: Int32
  , nonRetryableErrorTypes :: Vector Text
  }

retryPolicyToProto :: RetryPolicy -> Message.RetryPolicy
retryPolicyToProto (RetryPolicy initialInterval backoffCoefficient maximumInterval maximumAttempts nonRetryableErrorTypes) = 
  -- Using a full destructure here to make sure we don't miss any new fields later. ^
  defMessage
    & Message.initialInterval .~ durationToProto initialInterval
    & Message.backoffCoefficient .~ backoffCoefficient
    & Message.maybe'maximumInterval .~ fmap durationToProto maximumInterval
    & Message.maximumAttempts .~ maximumAttempts
    & Message.vec'nonRetryableErrorTypes .~ nonRetryableErrorTypes

retryPolicyFromProto :: Message.RetryPolicy -> RetryPolicy
retryPolicyFromProto p = RetryPolicy
  { initialInterval = durationFromProto (p ^. Message.initialInterval)
  , backoffCoefficient = p ^. Message.backoffCoefficient
  , maximumInterval = fmap durationFromProto (p ^. Message.maybe'maximumInterval)
  , maximumAttempts = p ^. Message.maximumAttempts
  , nonRetryableErrorTypes = p ^. Message.vec'nonRetryableErrorTypes
  }

{- | A Workflow Id Reuse Policy determines whether a Workflow Execution is allowed to spawn with a particular Workflow Id, 
if that Workflow Id has been used with a previous, and now Closed, Workflow Execution.

It is not possible for a new Workflow Execution to spawn with the same Workflow Id as another Open Workflow Execution, 
regardless of the Workflow Id Reuse Policy. In some cases, an attempt to spawn a Workflow Execution with a Workflow Id
that is the same as the Id of a currently Open Workflow Execution results in a Workflow execution already started error.
-}
data WorkflowIdReusePolicy
  = WorkflowIdReusePolicyUnspecified
  | WorkflowIdReusePolicyAllowDuplicate
  -- ^ The Workflow Execution is allowed to exist regardless of the Closed status of a previous Workflow Execution with 
  -- the same Workflow Id. This is currently the default policy, if one is not specified. 
  -- Use this when it is OK to have a Workflow Execution with the same Workflow Id as a previous, 
  -- but now Closed, Workflow Execution.
  | WorkflowIdReusePolicyAllowDuplicateFailedOnly
  -- ^ The Workflow Execution is allowed to exist only if a previous Workflow Execution with the same Workflow Id does not 
  -- have a Completed status. Use this policy when there is a need to re-execute a Failed, Timed Out, Terminated or 
  -- Cancelled Workflow Execution and guarantee that the Completed Workflow Execution will not be re-executed.
  | WorkflowIdReusePolicyRejectDuplicate
  -- ^ The Workflow Execution cannot exist if a previous Workflow Execution has the same Workflow Id, regardless of the 
  -- Closed status. Use this when there can only be one Workflow Execution per Workflow Id within a Namespace for 
  -- the given retention period.
  | WorkflowIdReusePolicyTerminateIfRunning
  -- ^ Specifies that if a Workflow Execution with the same Workflow Id is already running, 
  -- it should be terminated and a new Workflow Execution with the same Workflow Id should be started. 
  -- This policy allows for only one Workflow Execution with a specific Workflow Id to be running at any given time.
  deriving (Eq, Ord, Show, Enum, Bounded)

workflowIdReusePolicyToProto :: WorkflowIdReusePolicy -> Workflow.WorkflowIdReusePolicy
workflowIdReusePolicyToProto = \case
  WorkflowIdReusePolicyUnspecified -> Workflow.WORKFLOW_ID_REUSE_POLICY_UNSPECIFIED
  WorkflowIdReusePolicyAllowDuplicate -> Workflow.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE
  WorkflowIdReusePolicyAllowDuplicateFailedOnly -> Workflow.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE_FAILED_ONLY
  WorkflowIdReusePolicyRejectDuplicate -> Workflow.WORKFLOW_ID_REUSE_POLICY_REJECT_DUPLICATE
  WorkflowIdReusePolicyTerminateIfRunning -> Workflow.WORKFLOW_ID_REUSE_POLICY_TERMINATE_IF_RUNNING

memoAttributesToProto :: Map.Map Text Message.Payload -> Message.Memo
memoAttributesToProto memoAttrs = defMessage & Message.fields .~ memoAttrs

memoAttributesFromProto :: Message.Memo -> Map.Map Text Message.Payload
memoAttributesFromProto = view Message.fields

headerToProto :: Map.Map Text Message.Payload -> Message.Header
headerToProto header = defMessage & Message.fields .~ header

headerFromProto :: Message.Header -> Map.Map Text Message.Payload
headerFromProto = view Message.fields

data ParentInfo = ParentInfo
  { parentNamespace :: Namespace
  , parentRunId :: RunId
  , parentWorkflowId :: WorkflowId
  }

newtype Sequence = Sequence { rawSequence :: Word32 }
  deriving (Eq, Ord, Show, Enum, Num, Hashable)

class FunctionHoist (args :: [Type]) where
  hoistFn :: (forall x. m x -> n x) -> Proxy args -> Proxy result -> (args :->: m result) -> (args :->: n result)

instance FunctionHoist '[] where
  hoistFn trans _ _ f = trans f

instance FunctionHoist args => FunctionHoist (a ': args) where
  hoistFn trans _ res f = \arg -> hoistFn trans (Proxy @args) res (f arg)

-- | A specalized version of 'hoist' that allows you to change the end result functor of a given function.
hoist 
  :: forall m n f. (f ~ ArgsOf f :->: m (ResultOf m f), FunctionHoist (ArgsOf f))
  => (forall x. m x -> n x) 
  -> f 
  -> (ArgsOf f :->: n (ResultOf m f))
hoist trans f = hoistFn trans (Proxy @(ArgsOf f)) (Proxy @(ResultOf m f)) f

nonEmptyString :: Text -> Maybe Text
nonEmptyString t = if T.null t then Nothing else Just t

convertToProtoMemo :: Map Text RawPayload -> Message.Memo
convertToProtoMemo m = defMessage & Message.fields .~ fmap convertToProtoPayload m
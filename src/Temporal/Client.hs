{- | Workflow Clients are embedded in your application code and connect to a Temporal Server.

They are used to start new workflows and to signal existing workflows.
-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE NamedFieldPuns #-}
module Temporal.Client 
  (
  -- * Workflow Client
    WorkflowClient
  , workflowClient
  , WorkflowStartOptions(..)
  , workflowStartOptions
  , start
  , WorkflowHandle
  , awaitWorkflowResult
  , execute
  -- * Async Completion Client
  -- * Schedule Client
  -- * Miscellaneous
  , streamEvents
  , FollowOption(..)
  ) where

import Conduit
import Control.Monad
import Control.Monad.IO.Class
import Data.Int
import Data.Kind
import Data.Proxy
import Data.ProtoLens.Field
import Data.ProtoLens.Message
import Data.Map (Map)
import Data.Maybe
import Data.Text (Text)
import Data.Typeable
import qualified Data.Text as Text
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import qualified Data.Vector as V
import System.Clock (TimeSpec(..))

import Temporal.Core.Client.WorkflowService
import Temporal.Core.Client
import Temporal.Workflow.WorkflowDefinition
import Temporal.Worker.Types
import Temporal.Common
import Temporal.Exception
import Temporal.Payload
import Lens.Family2
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Common
import Proto.Temporal.Api.Enums.V1.TaskQueue (TaskQueueKind(..))
import qualified Proto.Temporal.Api.Taskqueue.V1.Message_Fields as TQ
import Proto.Temporal.Api.History.V1.Message (HistoryEvent, HistoryEvent'Attributes(..))
import qualified Proto.Temporal.Api.History.V1.Message_Fields as History
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as RR
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse 
  ( GetWorkflowExecutionHistoryRequest
  , GetWorkflowExecutionHistoryResponse
  , QueryWorkflowRequest
  , QueryWorkflowResponse
  )
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as WF
import qualified Proto.Temporal.Api.Enums.V1.Query as Query
import qualified Proto.Temporal.Api.Query.V1.Message_Fields as Query
import Proto.Temporal.Api.Enums.V1.Workflow (HistoryEventFilterType(..), WorkflowExecutionStatus(..))
import System.Posix.Process
import Network.BSD
import UnliftIO
import Unsafe.Coerce
---------------------------------------------------------------------------------
-- WorkflowClient stuff

workflowClient 
  :: MonadIO m
  => Client 
  -> Namespace 
  -- ^ Default namespace for all workflows started by this client.
  -> Maybe Text 
  -- ^ Identity of the client. 
  --
  -- If not provided, a default will be generated from the process ID and hostname.
  -> m WorkflowClient
workflowClient c ns mIdent = do
  ident <- maybe (liftIO defaultClientIdentity) pure mIdent
  pure WorkflowClient
    { clientCore = c
    , clientDefaultNamespace = ns
    , clientIdentity = ident
    }

data WorkflowClient = WorkflowClient 
  { clientCore :: Client
  , clientDefaultNamespace :: Namespace
  -- , clientDefaultQueue :: TaskQueue
  , clientIdentity :: Text
  }

defaultClientIdentity :: IO Text
defaultClientIdentity = do
  pid <- getProcessID
  host <- getHostName
  pure (Text.pack $ show pid <> "@" <> host)

execute
  :: forall args result m. (MonadIO m )
  => WorkflowClient 
  -> KnownWorkflow args result 
  -> WorkflowStartOptions
  -> (args :->: m result)
execute c k@(KnownWorkflow codec _ _ _) opts = gather $ \payloadsIO -> liftIO $ do
  inputs <- sequence payloadsIO
  h <- startFromPayloads c k opts inputs
  awaitWorkflowResult h
  where
    gather :: ([IO RawPayload] -> m result) -> (args :->: m result)
    gather = gatherArgs (Proxy @args) codec Prelude.id

data GetWorkflowHandleOptions = GetWorkflowHandleOptions

data WorkflowHandle a = forall args. WorkflowHandle
  { workflowHandleWorkflow :: KnownWorkflow args a
  , workflowHandleClient :: WorkflowClient
  , workflowHandleWorkflowId :: WorkflowId
  , workflowHandleRunId :: Maybe RunId
  }

awaitWorkflowResult :: MonadIO m => WorkflowHandle a -> m a
awaitWorkflowResult h@(WorkflowHandle (KnownWorkflow{knownWorkflowCodec}) c wf r) = do
  mev <- liftIO $ waitResult c wf r c.clientDefaultNamespace
  case mev of
    Nothing -> error "Unexpected empty history"
    Just ev -> case ev ^. History.maybe'attributes of
      Nothing -> error "Unrecognized history event"
      Just attrType -> case attrType of
        HistoryEvent'WorkflowExecutionCompletedEventAttributes attrs -> do
          let payloads = convertFromProtoPayload <$> (attrs ^. History.result . Common.payloads)
          -- LMAO this is such a comical coercion
          --
          -- We just need to ignore payloads if the result type is unit to allow workflows to evolve
          -- such that they can return something else in the future.
          if typeRep h == typeOf ()
            then pure $ unsafeCoerce ()
            else case payloads of
              (a:_) -> liftIO $ do
                result <- decode knownWorkflowCodec a
                either (throwIO . ValueError) pure result
              _ -> error "Missing result payload"
        HistoryEvent'WorkflowExecutionFailedEventAttributes attrs -> throwIO WorkflowExecutionFailed
        HistoryEvent'WorkflowExecutionTimedOutEventAttributes attrs -> throwIO WorkflowExecutionTimedOut
        HistoryEvent'WorkflowExecutionCanceledEventAttributes attrs -> throwIO WorkflowExecutionCanceled
        HistoryEvent'WorkflowExecutionTerminatedEventAttributes attrs -> throwIO WorkflowExecutionTerminated
        HistoryEvent'WorkflowExecutionContinuedAsNewEventAttributes attrs -> throwIO WorkflowExecutionContinuedAsNew
        e -> error ("History event not supported " <> show e)


signal :: forall m args a. MonadIO m => WorkflowHandle a -> SignalDefinition args -> (args :->: m ())
signal = undefined

-- | QueryRejectCondition can used to reject the query if workflow state does not satisfy condition.
data QueryRejectCondition
  = QueryRejectConditionRejectNone
  -- ^ indicates that query should not be rejected
  | QueryRejectConditionNotOpen
  -- ^ indicates that query should be rejected if workflow is not open
  | QueryRejectConditionNotCompletedCleanly
  -- ^ indicates that query should be rejected if workflow did not complete cleanly

data QueryOptions = QueryOptions
  { queryRejectCondition :: QueryRejectCondition
  }

defaultQueryOptions :: QueryOptions
defaultQueryOptions = QueryOptions
  { queryRejectCondition = QueryRejectConditionRejectNone
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

data QueryRejected
  = QueryRejected
    { status :: Temporal.Client.WorkflowExecutionStatus
    }

query :: forall m args result a. (MonadIO m, Typeable result)
  => WorkflowClient
  -> WorkflowHandle a 
  -> QueryDefinition args result 
  -> QueryOptions
  -> (args :->: m (Either QueryRejected result))
query c h (QueryDefinition qn codec) opts = gather $ \payloadsIO -> liftIO $ do
  inputs <- sequence payloadsIO
  let msg :: QueryWorkflowRequest
      msg = defMessage 
        & WF.namespace .~ rawNamespace c.clientDefaultNamespace
        & WF.execution .~
          (defMessage
            & Common.workflowId .~ rawWorkflowId h.workflowHandleWorkflowId
            & Common.runId .~ maybe "" rawRunId h.workflowHandleRunId
          )
        & WF.query .~ 
          (defMessage 
            & Query.queryType .~ qn
            & Query.queryArgs .~
              (defMessage & Common.payloads .~ fmap convertToProtoPayload inputs)
            -- TODO
            -- & Q.header .~ _
          )
        & WF.queryRejectCondition .~ case opts.queryRejectCondition of
          QueryRejectConditionRejectNone -> Query.QUERY_REJECT_CONDITION_NONE
          QueryRejectConditionNotOpen -> Query.QUERY_REJECT_CONDITION_NOT_OPEN
          QueryRejectConditionNotCompletedCleanly -> Query.QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY

  (res :: QueryWorkflowResponse) <- either throwIO pure =<< queryWorkflow c.clientCore msg
  case res ^. WF.maybe'queryRejected of
    Just rejection -> do
      let status = queryRejectionStatusFromProto (rejection ^. Query.status)
      pure $ Left $ QueryRejected { .. }
    Nothing -> if typeRep (Proxy @result) == typeOf ()
      then pure $ Right $ unsafeCoerce ()
      else 
        case (res ^. WF.queryResult . Common.vec'payloads) V.!? 0 of
          Nothing -> throwIO $ ValueError "No return value payloads provided by query response"
          Just p -> do
            res <- decode codec (convertFromProtoPayload p)
            either (throwIO . ValueError) (pure . Right) res

  where
    gather :: ([IO RawPayload] -> m (Either QueryRejected result)) -> (args :->: m (Either QueryRejected result))
    gather = gatherArgs (Proxy @args) codec Prelude.id

    queryRejectionStatusFromProto = \case
      WORKFLOW_EXECUTION_STATUS_UNSPECIFIED -> UnknownStatus
      WORKFLOW_EXECUTION_STATUS_RUNNING -> Running
      WORKFLOW_EXECUTION_STATUS_COMPLETED -> Completed
      WORKFLOW_EXECUTION_STATUS_FAILED -> Failed
      WORKFLOW_EXECUTION_STATUS_CANCELED -> Canceled
      WORKFLOW_EXECUTION_STATUS_TERMINATED -> Temporal.Client.Terminated
      WORKFLOW_EXECUTION_STATUS_CONTINUED_AS_NEW -> ContinuedAsNew
      WORKFLOW_EXECUTION_STATUS_TIMED_OUT -> TimedOut
      WorkflowExecutionStatus'Unrecognized _ -> UnknownStatus 

getHandle
  :: (MonadIO m, Codec codec a)
  => WorkflowClient
  -> codec
  -> WorkflowId
  -> Maybe RunId
  -> Maybe GetWorkflowHandleOptions
  -> m (WorkflowHandle a)
getHandle = undefined

-- TODO
-- list 
--   :: MonadIO m
--   => WorkflowClient
--   -> ListWorkflowOptions
--   -> m [WorkflowId]

data WorkflowResultOptions = WorkflowResultOptions

result
  :: MonadIO m
  => WorkflowClient
  -> WorkflowId
  -> Maybe RunId
  -> Maybe WorkflowResultOptions
  -> m (Maybe a)
result = undefined

signalWithStart 
  :: MonadIO m 
  => WorkflowClient 
  -> WorkflowStartOptions 
  -> KnownWorkflow wfArgs result 
  -> SignalDefinition sigArgs 
  -> (wfArgs :->: (sigArgs :->: m ()))
signalWithStart = undefined

data WorkflowStartOptions = WorkflowStartOptions
  { workflowId :: WorkflowId
  , taskQueue :: TaskQueue
  , followRuns :: Bool
  , workflowIdReusePolicy :: Maybe WorkflowIdReusePolicy
  , retry :: Maybe RetryPolicy
  , cronSchedule :: Maybe Text
  , memo :: Maybe (Map Text RawPayload)
  , searchAttributes :: Maybe (Map Text RawPayload)
  , timeouts :: TimeoutOptions
  }

workflowStartOptions :: WorkflowId -> TaskQueue -> WorkflowStartOptions
workflowStartOptions wfId tq = WorkflowStartOptions
  { workflowId = wfId
  , taskQueue = tq
  , followRuns = True
  , workflowIdReusePolicy = Nothing
  , retry = Nothing
  , cronSchedule = Nothing
  , memo = Nothing
  , searchAttributes = Nothing
  , timeouts = TimeoutOptions
    { executionTimeout = Nothing
    , runTimeout = Nothing
    , taskTimeout = Nothing
    }
  }

data TimeoutOptions = TimeoutOptions
  { executionTimeout :: Maybe TimeSpec
  , runTimeout :: Maybe TimeSpec
  , taskTimeout :: Maybe TimeSpec
  }

startFromPayloads 
  :: MonadIO m
  => WorkflowClient
  -> KnownWorkflow args result
  -> WorkflowStartOptions
  -> [RawPayload]
  -> m (WorkflowHandle result)
startFromPayloads c k@(KnownWorkflow codec _ _ _) opts payloads = liftIO $ do
  reqId <- UUID.nextRandom
  let req = defMessage
        & WF.namespace .~ (rawNamespace $ fromMaybe (c.clientDefaultNamespace) $ knownWorkflowNamespace k)
        & WF.workflowId .~ rawWorkflowId opts.workflowId
        & WF.workflowType .~ 
          ( defMessage & Common.name .~ knownWorkflowName k 
          )
        & WF.taskQueue .~ 
          ( defMessage 
            & Common.name .~ (rawTaskQueue opts.taskQueue)
            & TQ.kind .~ TASK_QUEUE_KIND_UNSPECIFIED
          )
        & WF.input .~ 
          ( defMessage & Common.payloads .~ (convertToProtoPayload <$> payloads)
          )
        & WF.maybe'workflowExecutionTimeout .~ (timespecToDuration <$> opts.timeouts.executionTimeout)
        & WF.maybe'workflowRunTimeout .~ (timespecToDuration <$> opts.timeouts.runTimeout)
        & WF.maybe'workflowTaskTimeout .~ (timespecToDuration <$> opts.timeouts.taskTimeout)
        & WF.identity .~ c.clientIdentity
        & WF.requestId .~ UUID.toText reqId
        & WF.workflowIdReusePolicy .~ 
          workflowIdReusePolicyToProto
            (fromMaybe WorkflowIdReusePolicyAllowDuplicateFailedOnly opts.workflowIdReusePolicy)
        & WF.maybe'retryPolicy .~ (retryPolicyToProto <$> opts.retry)
        & WF.cronSchedule .~ maybe "" Prelude.id opts.cronSchedule
        & WF.maybe'memo .~ (convertToProtoMemo <$> opts.memo)
        & WF.maybe'searchAttributes .~ (convertToProtoSearchAttributes <$> opts.searchAttributes)
    --     TODO Not sure how to use these yet
    --     & WF.header .~
    --     & WF.requestEagerExecution .~
    --     & WF.continuedFailure .~
    --     & WF.lastCompletionResult .~
  res <- startWorkflowExecution c.clientCore req
  case res of
    Left err -> throwIO err
    Right swer -> pure $ WorkflowHandle 
      { workflowHandleWorkflow = k
      , workflowHandleClient = c
      , workflowHandleWorkflowId = opts.workflowId
      , workflowHandleRunId = Just (RunId $ swer ^. WF.runId)
      }

start
  :: forall args result m. (MonadIO m)
  => WorkflowClient
  -> KnownWorkflow args result
  -> WorkflowStartOptions
  -> (args :->: m (WorkflowHandle result))
start c k@(KnownWorkflow codec _ _ _) opts = gather $ \payloadsIO -> liftIO $ do
  inputs <- sequence payloadsIO
  startFromPayloads c k opts inputs
  where
    gather :: ([IO RawPayload] -> m (WorkflowHandle result)) -> (args :->: m (WorkflowHandle result))
    gather = gatherArgs (Proxy @args) codec Prelude.id


---------------------------------------------------------------------------------
-- AsyncCompletionClient

-- | A client for asynchronous completion and heartbeating of Activities.
data AsyncCompletionClient = AsyncCompletionClient Client

complete :: AsyncCompletionClient -> TaskToken -> m ()
complete = undefined

fail :: AsyncCompletionClient -> TaskToken -> SomeException -> m ()
fail = undefined

heartbeat :: AsyncCompletionClient -> TaskToken -> [RawPayload] -> m ()
heartbeat = undefined

reportCancellation :: AsyncCompletionClient -> TaskToken -> [RawPayload] -> m ()
reportCancellation = undefined

---------------------------------------------------------------------------------
-- ScheduleClient

data ScheduleClient = ScheduleClient Client

data ScheduleHandle = ScheduleHandle

data CreateScheduleOptions = CreateScheduleOptions
data ScheduleAlreadyRunning = ScheduleAlreadyRunning
createSchedule 
  :: ScheduleClient 
  -> CreateScheduleOptions
  -> m (Either ScheduleAlreadyRunning ScheduleHandle)
createSchedule = undefined

getScheduleHandle
  :: ScheduleClient
  -> ScheduleId
  -> m (Maybe ScheduleHandle)
getScheduleHandle = undefined

data ListSchedulesOptions = ListSchedulesOptions

listSchedules 
  :: ScheduleClient
  -> ListSchedulesOptions
  -- Popper
  -> m (m [ScheduleId])
listSchedules = undefined

data FollowOption = FollowRuns | ThisRunOnly

-- | Thrown when 'FollowOption' is 'ThisRunOnly' and the workflow continues as new.
data WorkflowContinuedAsNewException = WorkflowContinuedAsNewException
  { workflowContinuedAsNewExceptionRunId :: RunId
  } deriving (Show)

instance Exception WorkflowContinuedAsNewException

applyNewExecutionRunId 
  :: HasField s "newExecutionRunId" Text
  => s 
  -> GetWorkflowExecutionHistoryRequest 
  -> Maybe GetWorkflowExecutionHistoryRequest
  -> Maybe GetWorkflowExecutionHistoryRequest
applyNewExecutionRunId attrs req alt = if attrs ^. History.newExecutionRunId == ""
  then alt
  else let exec = req ^. RR.execution in
    Just
      ( req 
          & RR.execution .~ (exec & RR.runId .~ (attrs ^. History.newExecutionRunId))
          & RR.nextPageToken .~ "" 
      )

streamEvents 
  :: MonadIO m 
  => WorkflowClient 
  -> FollowOption
  -> GetWorkflowExecutionHistoryRequest 
  -> ConduitT () HistoryEvent m ()
streamEvents c followOpt baseReq = go baseReq
  where
    go req = do
      res <- liftIO $ getWorkflowExecutionHistory c.clientCore req
      case res of
        Left err -> throwIO err
        Right res -> do
          yieldMany (res ^. RR.history . History.events)
          case decideLoop baseReq res of
            Nothing -> pure ()
            Just req' -> go req'
    decideLoop :: GetWorkflowExecutionHistoryRequest -> GetWorkflowExecutionHistoryResponse -> Maybe GetWorkflowExecutionHistoryRequest
    decideLoop req res = 
      if V.null (res ^. RR.history . History.vec'events)
      then nextPage
      else case V.last (res ^. RR.history . History.vec'events) ^. History.maybe'attributes of
        Nothing -> nextPage
        Just attrType -> 
          case attrType of
            HistoryEvent'WorkflowExecutionCompletedEventAttributes attrs -> case followOpt of
              FollowRuns -> applyNewExecutionRunId attrs req nextPage
              ThisRunOnly -> nextPage
            HistoryEvent'WorkflowExecutionFailedEventAttributes attrs -> case followOpt of
              FollowRuns -> applyNewExecutionRunId attrs req nextPage
              ThisRunOnly -> nextPage
            HistoryEvent'WorkflowExecutionTimedOutEventAttributes attrs -> case followOpt of
              FollowRuns -> applyNewExecutionRunId attrs req nextPage
              ThisRunOnly -> nextPage
            HistoryEvent'WorkflowExecutionContinuedAsNewEventAttributes attrs -> case followOpt of
              FollowRuns ->  if attrs ^. History.newExecutionRunId == ""
                then error "Expected newExecutionRunId in WorkflowExecutionContinuedAsNewEventAttributes"
                else Just $ req 
                  & RR.nextPageToken .~ "" 
                  & RR.execution %~ (RR.runId .~ (attrs ^. History.newExecutionRunId))
              ThisRunOnly -> Nothing
            _ -> Nothing
      where 
        nextPage = if res ^. RR.nextPageToken == "" 
          then Nothing 
          else Just (req & RR.nextPageToken .~ (res ^. RR.nextPageToken))

waitResult 
  :: WorkflowClient
  -> WorkflowId 
  -> Maybe RunId 
  -> Namespace {- options incl namespace -}
  -> IO (Maybe HistoryEvent)
waitResult c wfId mrId (Namespace ns) = do
  let startingReq :: GetWorkflowExecutionHistoryRequest
      startingReq = defMessage
        & RR.namespace .~ ns
        & RR.execution .~ 
          ( defMessage 
            & Common.workflowId .~ rawWorkflowId wfId
            & case mrId of
                Nothing -> Prelude.id
                Just rId -> (Common.runId .~ rawRunId rId)
          )
        & RR.maximumPageSize .~ 1000
        & RR.waitNewEvent .~ True
        & RR.historyEventFilterType .~ HISTORY_EVENT_FILTER_TYPE_CLOSE_EVENT
        & RR.skipArchival .~ True
  connect (streamEvents c FollowRuns startingReq) lastC




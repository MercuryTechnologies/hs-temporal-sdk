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

import Temporal.Client.WorkflowService
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
  )
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as WF
import Proto.Temporal.Api.Enums.V1.Workflow (HistoryEventFilterType(..))
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


signal :: MonadIO m => WorkflowHandle a -> SignalDefinition args -> (args :->: m ())
signal = undefined

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


  {-
      if (ev.workflowExecutionCompletedEventAttributes) {
        // Note that we can only return one value from our workflow function in JS.
        // Ignore any other payloads in result
        const [result] = await decodeArrayFromPayloads(
          this.dataConverter,
          ev.workflowExecutionCompletedEventAttributes.result?.payloads
        );
        return result as any;
      } else if (ev.workflowExecutionFailedEventAttributes) {
        const { failure, retryState } = ev.workflowExecutionFailedEventAttributes;
        throw new WorkflowFailedError(
          'Workflow execution failed',
          await decodeOptionalFailureToOptionalError(this.dataConverter, failure),
          retryState ?? RetryState.RETRY_STATE_UNSPECIFIED
        );
      } else if (ev.workflowExecutionCanceledEventAttributes) {
        const failure = new CancelledFailure(
          'Workflow canceled',
          await decodeArrayFromPayloads(
            this.dataConverter,
            ev.workflowExecutionCanceledEventAttributes.details?.payloads
          )
        );
        failure.stack = '';
        throw new WorkflowFailedError(
          'Workflow execution cancelled',
          failure,
          RetryState.RETRY_STATE_NON_RETRYABLE_FAILURE
        );
      } else if (ev.workflowExecutionTerminatedEventAttributes) {
        const failure = new TerminatedFailure(
          ev.workflowExecutionTerminatedEventAttributes.reason || 'Workflow execution terminated'
        );
        failure.stack = '';
        throw new WorkflowFailedError(
          ev.workflowExecutionTerminatedEventAttributes.reason || 'Workflow execution terminated',
          failure,
          RetryState.RETRY_STATE_NON_RETRYABLE_FAILURE
        );
      } else if (ev.workflowExecutionTimedOutEventAttributes) {
        if (followRuns && ev.workflowExecutionTimedOutEventAttributes.newExecutionRunId) {
          execution.runId = ev.workflowExecutionTimedOutEventAttributes.newExecutionRunId;
          req.nextPageToken = undefined;
          continue;
        }
        const failure = new TimeoutFailure(
          'Workflow execution timed out',
          undefined,
          TimeoutType.TIMEOUT_TYPE_START_TO_CLOSE
        );
        failure.stack = '';
        throw new WorkflowFailedError(
          'Workflow execution timed out',
          failure,
          ev.workflowExecutionTimedOutEventAttributes.retryState || 0
        );
      } else if (ev.workflowExecutionContinuedAsNewEventAttributes) {
        const { newExecutionRunId } = ev.workflowExecutionContinuedAsNewEventAttributes;
        if (!newExecutionRunId) {
          throw new TypeError('Expected service to return newExecutionRunId for WorkflowExecutionContinuedAsNewEvent');
        }
        if (!followRuns) {
          throw new WorkflowContinuedAsNewError('Workflow execution continued as new', newExecutionRunId);
        }
        execution.runId = newExecutionRunId;
        req.nextPageToken = undefined;
        continue;
      }
    }
  -}



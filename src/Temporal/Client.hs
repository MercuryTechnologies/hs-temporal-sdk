{- | Workflow Clients are embedded in your application code and connect to a Temporal Server.

They are used to start new workflows and to signal existing workflows.
-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
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
  , TimeoutOptions(..)
  , workflowStartOptions
  , Temporal.Client.start
  , WorkflowHandle
  , awaitWorkflowResult
  , TerminationOptions
  , terminate
  , execute
  , QueryOptions(..)
  , QueryRejectCondition(..)
  , QueryRejected(..)
  , defaultQueryOptions
  , query
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

import Temporal.Core.Client.WorkflowService
import Temporal.Core.Client
import Temporal.Workflow.Definition
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
import UnliftIO
import Unsafe.Coerce
import Data.ProtoLens (Message(defMessage))
import Temporal.Payload (convertToProtoPayload)
import Temporal.Client.Types
import Temporal.SearchAttributes
import Temporal.SearchAttributes.Internal
import Temporal.Workflow (WorkflowRef(..), QueryDefinition(..))
import Temporal.Duration (Duration, durationToProto)
---------------------------------------------------------------------------------
-- WorkflowClient stuff

workflowClient 
  :: MonadIO m
  => Client 
  -> Namespace 
  -- ^ Default namespace for all workflows started by this client.
  -> ClientInterceptors
  -- ^ Identity of the client. 
  --
  -- If not provided, a default will be generated from the process ID and hostname.
  -> m WorkflowClient
workflowClient c ns int = do
  pure WorkflowClient
    { clientCore = c
    , clientDefaultNamespace = ns
    , clientInterceptors = int
    }


throwEither :: (MonadIO m, Exception e) => IO (Either e a) -> m a
throwEither = either throwIO pure <=< liftIO

execute
  :: forall m wf. (MonadIO m, WorkflowRef wf)
  => WorkflowClient 
  -> wf
  -> WorkflowStartOptions
  -> (WorkflowArgs wf :->: m (WorkflowResult wf))
execute c wf opts = case workflowRef wf of
  k@(KnownWorkflow codec _ _ _) -> do
    let gather :: ([IO Payload] -> m (WorkflowResult wf)) -> (WorkflowArgs wf :->: m (WorkflowResult wf))
        gather = gatherArgs (Proxy @(WorkflowArgs wf)) codec Prelude.id
    gather $ \inputs -> liftIO $ do
      h <- startFromPayloads c k opts =<< sequence inputs
      awaitWorkflowResult h

awaitWorkflowResult :: (Typeable a, MonadIO m) => WorkflowHandle a -> m a
awaitWorkflowResult h@(WorkflowHandle readResult _ c wf r) = do
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
              (a:_) -> liftIO $ readResult a
              _ -> error "Missing result payload"
        HistoryEvent'WorkflowExecutionFailedEventAttributes attrs -> throwIO WorkflowExecutionFailed
        HistoryEvent'WorkflowExecutionTimedOutEventAttributes attrs -> throwIO WorkflowExecutionTimedOut
        HistoryEvent'WorkflowExecutionCanceledEventAttributes attrs -> throwIO WorkflowExecutionCanceled
        HistoryEvent'WorkflowExecutionTerminatedEventAttributes attrs -> throwIO WorkflowExecutionTerminated
        HistoryEvent'WorkflowExecutionContinuedAsNewEventAttributes attrs -> throwIO WorkflowExecutionContinuedAsNew
        e -> error ("History event not supported " <> show e)

data SignalOptions
  = SignalOptions
  { requestId :: Maybe Text
  -- ^ Used to de-dupe sent signals
  , skipGenerateWorkflowTask :: Bool
  -- ^ Indicates that a new workflow task should not be generated when this signal is received.
  --
  -- Defaults to False.
  --
  -- Generally this is not needed.
  , headers :: Map Text Payload
  }

defaultSignalOptions :: SignalOptions
defaultSignalOptions = SignalOptions
  { skipGenerateWorkflowTask = False
  , requestId = Nothing
  , headers = mempty
  }

signal :: forall m args a. MonadIO m 
  => WorkflowHandle a 
  -> SignalRef args 
  -> SignalOptions
  -> (args :->: m ())
signal h@(WorkflowHandle _ _t c wf r) (SignalRef sName sCodec) opts = gather $ \inputs -> do
  result <- liftIO $ do
    args <- traverse (fmap convertToProtoPayload) inputs
    signalWorkflowExecution c.clientCore $ defMessage
      & WF.namespace .~ rawNamespace c.clientDefaultNamespace
      & WF.workflowExecution .~ (defMessage
        & Common.workflowId .~ rawWorkflowId wf
        & Common.runId .~ maybe "" rawRunId r
        )
      & WF.signalName .~ sName
      & WF.input .~ (defMessage & Common.payloads .~ args)
      & WF.identity .~ (identity $ clientConfig c.clientCore)
      & WF.requestId .~ fromMaybe "" opts.requestId
      -- Deprecated, no need to set
      -- & WF.control .~ _
      -- TODO put other useful headers in here
      & WF.header .~ (headerToProto $ fmap convertToProtoPayload opts.headers)
      & WF.skipGenerateWorkflowTask .~ opts.skipGenerateWorkflowTask
  case result of 
    Left err -> throwIO err
    Right _ -> pure ()
  where
    gather :: ([IO Payload] -> m ()) -> (args :->: m ())
    gather = gatherArgs (Proxy @args) sCodec Prelude.id


data QueryOptions = QueryOptions
  { queryId :: Text
  , queryRejectCondition :: QueryRejectCondition
  , queryHeaders :: Map Text Payload
  }

defaultQueryOptions :: QueryOptions
defaultQueryOptions = QueryOptions
  { queryRejectCondition = QueryRejectConditionRejectNone
  , queryHeaders = mempty
  }


query :: forall m args result a. (MonadIO m, Typeable result)
  => WorkflowHandle a 
  -> QueryDefinition args result 
  -> QueryOptions
  -> (args :->: m (Either QueryRejected result))
query h (QueryDefinition qn codec) opts = gather $ \inputs -> liftIO $ do
  args <- sequence inputs
  let baseInput = QueryWorkflowInput 
        { queryWorkflowType = qn
        , queryWorkflowRunId = h.workflowHandleRunId
        , queryWorkflowRejectCondition = opts.queryRejectCondition
        , queryWorkflowWorkflowId = h.workflowHandleWorkflowId
        , queryWorkflowHeaders = opts.queryHeaders
        , queryWorkflowArgs = args
        }
  eRes <- h.workflowHandleClient.clientInterceptors.queryWorkflow baseInput $ \input -> do
    let msg :: QueryWorkflowRequest
        msg = defMessage 
          & WF.namespace .~ rawNamespace h.workflowHandleClient.clientDefaultNamespace
          & WF.execution .~
            (defMessage
              & Common.workflowId .~ rawWorkflowId input.queryWorkflowWorkflowId
              & Common.runId .~ maybe "" rawRunId input.queryWorkflowRunId
            )
          & WF.query .~ 
            (defMessage 
              & Query.queryType .~ input.queryWorkflowType
              & Query.queryArgs .~
                (defMessage & Common.payloads .~ fmap convertToProtoPayload input.queryWorkflowArgs)
              & Query.header .~ (headerToProto $ fmap convertToProtoPayload input.queryWorkflowHeaders)
            )
          & WF.queryRejectCondition .~ case opts.queryRejectCondition of
            QueryRejectConditionRejectNone -> Query.QUERY_REJECT_CONDITION_NONE
            QueryRejectConditionNotOpen -> Query.QUERY_REJECT_CONDITION_NOT_OPEN
            QueryRejectConditionNotCompletedCleanly -> Query.QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY

    (res :: QueryWorkflowResponse) <- either throwIO pure =<< Temporal.Core.Client.WorkflowService.queryWorkflow h.workflowHandleClient.clientCore msg
    case res ^. WF.maybe'queryRejected of
      Just rejection -> do
        let status = queryRejectionStatusFromProto (rejection ^. Query.status)
        pure $ Left $ QueryRejected { .. }
      Nothing -> case (res ^. WF.queryResult . Common.vec'payloads) V.!? 0 of
        Nothing -> throwIO $ ValueError "No return value payloads provided by query response"
        Just p -> pure $ Right $ convertFromProtoPayload p
  forM eRes $ \p ->
    decode codec p >>= either (throwIO . ValueError) pure
  where
    gather :: ([IO Payload] -> m (Either QueryRejected result)) -> (args :->: m (Either QueryRejected result))
    gather = gatherArgs (Proxy @args) codec Prelude.id

    queryRejectionStatusFromProto = \case
      WORKFLOW_EXECUTION_STATUS_UNSPECIFIED -> UnknownStatus
      WORKFLOW_EXECUTION_STATUS_RUNNING -> Running
      WORKFLOW_EXECUTION_STATUS_COMPLETED -> Completed
      WORKFLOW_EXECUTION_STATUS_FAILED -> Failed
      WORKFLOW_EXECUTION_STATUS_CANCELED -> Canceled
      WORKFLOW_EXECUTION_STATUS_TERMINATED -> Terminated
      WORKFLOW_EXECUTION_STATUS_CONTINUED_AS_NEW -> ContinuedAsNew
      WORKFLOW_EXECUTION_STATUS_TIMED_OUT -> TimedOut
      WorkflowExecutionStatus'Unrecognized _ -> UnknownStatus 

getHandle
  :: (MonadIO m)
  => WorkflowClient
  -> KnownWorkflow args a
  -> WorkflowId
  -> Maybe RunId
  -> m (WorkflowHandle a)
getHandle c (KnownWorkflow {knownWorkflowCodec, knownWorkflowName}) wfId runId = pure $ WorkflowHandle 
  { workflowHandleReadResult = \a -> do
      result <- decode knownWorkflowCodec a
      either (throwIO . ValueError) pure result
  , workflowHandleClient = c
  , workflowHandleWorkflowId = wfId
  , workflowHandleRunId = runId
  , workflowHandleType = WorkflowType knownWorkflowName
  }

-- TODO
-- list 
--   :: MonadIO m
--   => WorkflowClient
--   -> ListWorkflowOptions
--   -> m [WorkflowId]

signalWithStart 
  :: MonadIO m 
  => WorkflowClient 
  -> WorkflowStartOptions 
  -> KnownWorkflow args result
  -> SignalDefinition sigArgs 
  -> (args :->: (sigArgs :->: m ()))
signalWithStart = undefined


startFromPayloads 
  :: MonadIO m
  => WorkflowClient
  -> KnownWorkflow args result
  -> WorkflowStartOptions
  -> [Payload]
  -> m (WorkflowHandle result)
startFromPayloads c k@(KnownWorkflow codec _ _ _) opts payloads = do
  wfH <- liftIO $ (Temporal.Client.Types.start c.clientInterceptors) (WorkflowType $ knownWorkflowName k) opts payloads $ \wfName opts' payloads' -> do
    reqId <- UUID.nextRandom
    searchAttrs <- searchAttributesToProto opts'.searchAttributes
    let req = defMessage
          & WF.namespace .~ (rawNamespace $ fromMaybe (c.clientDefaultNamespace) $ knownWorkflowNamespace k)
          & WF.workflowId .~ rawWorkflowId opts'.workflowId
          & WF.workflowType .~ 
            ( defMessage & Common.name .~ rawWorkflowType wfName
            )
          & WF.taskQueue .~ 
            ( defMessage 
              & Common.name .~ (rawTaskQueue opts'.taskQueue)
              & TQ.kind .~ TASK_QUEUE_KIND_UNSPECIFIED
            )
          & WF.input .~ 
            ( defMessage & Common.payloads .~ (convertToProtoPayload <$> payloads')
            )
          & WF.maybe'workflowExecutionTimeout .~ (durationToProto <$> opts'.timeouts.executionTimeout)
          & WF.maybe'workflowRunTimeout .~ (durationToProto <$> opts'.timeouts.runTimeout)
          & WF.maybe'workflowTaskTimeout .~ (durationToProto <$> opts'.timeouts.taskTimeout)
          & WF.identity .~ (identity $ clientConfig c.clientCore)
          & WF.requestId .~ UUID.toText reqId
          & WF.workflowIdReusePolicy .~ 
            workflowIdReusePolicyToProto
              (fromMaybe WorkflowIdReusePolicyAllowDuplicateFailedOnly opts'.workflowIdReusePolicy)
          & WF.maybe'retryPolicy .~ (retryPolicyToProto <$> opts'.retry)
          & WF.cronSchedule .~ maybe "" Prelude.id opts'.cronSchedule
          & WF.memo .~ (convertToProtoMemo opts'.memo)
          & WF.searchAttributes .~ (defMessage & Common.indexedFields .~ searchAttrs)
      --     TODO Not sure how to use these yet
          & WF.header .~ (headerToProto $ fmap convertToProtoPayload opts'.headers)
          & WF.requestEagerExecution .~ opts'.requestEagerExecution
          {- 
            These values will be available as ContinuedFailure and LastCompletionResult in the
            WorkflowExecutionStarted event and through SDKs. The are currently only used by the
            server itself (for the schedules feature) and are not intended to be exposed in
            StartWorkflowExecution.

            WF.continuedFailure
            WF.lastCompletionResult

          -}
    res <- startWorkflowExecution c.clientCore req
    case res of
      Left err -> throwIO err
      Right swer -> pure $ WorkflowHandle 
        { workflowHandleReadResult = pure
        , workflowHandleType = WorkflowType $ knownWorkflowName k
        , workflowHandleClient = c
        , workflowHandleWorkflowId = opts.workflowId
        , workflowHandleRunId = Just (RunId $ swer ^. WF.runId)
        }
  pure $ wfH 
    { workflowHandleReadResult = \a -> workflowHandleReadResult wfH a >>= \b -> do
        result <- decode codec b
        either (throwIO . ValueError) pure result
    }

start
  :: forall args result m. (MonadIO m)
  => WorkflowClient
  -> KnownWorkflow args result
  -> WorkflowStartOptions
  -> (args :->: m (WorkflowHandle result))
start c k@(KnownWorkflow codec _ _ _) opts = gather $ \inputs -> liftIO $ do
  startFromPayloads c k opts =<< sequence inputs
  where
    gather :: ([IO Payload] -> m (WorkflowHandle result)) -> (args :->: m (WorkflowHandle result))
    gather = gatherArgs (Proxy @args) codec Prelude.id

data TerminationOptions = TerminationOptions
  { terminationReason :: Text
  , terminationDetails :: [Payload]
  -- | If set, this call will error if the (most recent | specified workflow run id in the WorkflowHandle) is not part of the same
  -- execution chain as this id.
  , firstExecutionRunId  :: Maybe RunId
  }

-- | Terminating a workflow immediately signals to the worker that the workflow should 
-- cease execution. The workflow will not be given a chance to react to the termination.
terminate :: MonadIO m => WorkflowHandle a -> TerminationOptions -> m ()
terminate h req = void $ throwEither $ terminateWorkflowExecution 
  h.workflowHandleClient.clientCore
  msg
  where
    msg = defMessage
      & RR.namespace .~ rawNamespace h.workflowHandleClient.clientDefaultNamespace
      & RR.workflowExecution .~
        ( defMessage 
          & Common.workflowId .~ rawWorkflowId h.workflowHandleWorkflowId
          & Common.runId .~ maybe "" rawRunId h.workflowHandleRunId
        )
      & RR.reason .~ req.terminationReason
      & RR.details .~ 
        ( defMessage & Common.payloads .~ fmap convertToProtoPayload req.terminationDetails )
      & RR.identity .~ identity (clientConfig h.workflowHandleClient.clientCore)
      & RR.firstExecutionRunId .~ maybe "" rawRunId req.firstExecutionRunId


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




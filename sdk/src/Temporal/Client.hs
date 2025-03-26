{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use >=>" #-}

{- |
Module: Temporal.Client
Description: Invoke and interact with Temporal Workflows.

Workflow Clients are embedded in your application code and connect to a Temporal Server.

They are used to start new workflows and to signal existing workflows.
-}
module Temporal.Client (
  -- * Workflow Client
  WorkflowClient,
  workflowClient,
  WorkflowClientConfig (..),
  mkWorkflowClientConfig,
  HasWorkflowClient (..),

  -- * Running Workflows
  StartWorkflowOptions (..),
  TimeoutOptions (..),
  startWorkflowOptions,
  Temporal.Client.start,
  startFromPayloads,
  WorkflowHandle,
  execute,
  waitWorkflowResult,

  -- * Closing Workflows
  TerminationOptions (..),
  terminate,

  -- * Querying Workflows
  QueryOptions (..),
  QueryRejectCondition (..),
  QueryRejected (..),
  Temporal.Client.Types.WorkflowExecutionStatus (..),
  defaultQueryOptions,
  query,

  -- * Sending Signals to Workflows
  SignalOptions (..),
  KnownSignal (..),
  signal,
  defaultSignalOptions,
  Temporal.Client.signalWithStart,

  -- * Producing handles for existing workflows
  getHandle,

  -- * Workflow history utilities
  fetchHistory,
  streamEvents,
  FollowOption (..),
) where

import Conduit
import Control.Monad
import Control.Monad.Trans.Accum
import Control.Monad.Trans.Cont
import Control.Monad.Trans.Except
import Control.Monad.Trans.Identity
import Control.Monad.Trans.Maybe
import qualified Control.Monad.Trans.RWS.CPS as CRWS
import qualified Control.Monad.Trans.RWS.Lazy as LRWS
import qualified Control.Monad.Trans.RWS.Strict as SRWS
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Select
import qualified Control.Monad.Trans.State.Lazy as LS
import qualified Control.Monad.Trans.State.Strict as SS
import qualified Control.Monad.Trans.Writer.CPS as CW
import qualified Control.Monad.Trans.Writer.Lazy as LW
import qualified Control.Monad.Trans.Writer.Strict as SW
import Data.Foldable (for_)
import Data.Int (Int64)
import Data.Map (Map)
import Data.Maybe
import Data.ProtoLens.Field
import Data.ProtoLens.Message
import Data.Proxy
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import Data.Typeable
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUID
import qualified Data.Vector as V
import Lens.Family2
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Common
import qualified Proto.Temporal.Api.Enums.V1.Query as Query
import Proto.Temporal.Api.Enums.V1.TaskQueue (TaskQueueKind (..))
import Proto.Temporal.Api.Enums.V1.Workflow (HistoryEventFilterType (..), WorkflowExecutionStatus (..))
import Proto.Temporal.Api.History.V1.Message (History, HistoryEvent, HistoryEvent'Attributes (..))
import qualified Proto.Temporal.Api.History.V1.Message_Fields as History
import qualified Proto.Temporal.Api.Query.V1.Message_Fields as Query
import qualified Proto.Temporal.Api.Taskqueue.V1.Message_Fields as TQ
import qualified Proto.Temporal.Api.Update.V1.Message as Update
import qualified Proto.Temporal.Api.Update.V1.Message_Fields as Update
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse (
  GetWorkflowExecutionHistoryRequest,
  GetWorkflowExecutionHistoryResponse,
  QueryWorkflowRequest,
  QueryWorkflowResponse,
  UpdateWorkflowExecutionRequest,
  UpdateWorkflowExecutionResponse,
 )
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as RR
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as WF
import Temporal.Client.Types
import Temporal.Common
import qualified Temporal.Core.Client as Core
import Temporal.Core.Client.WorkflowService
import Temporal.Duration (Duration, durationToProto)
import Temporal.Exception
import Temporal.Payload
import Temporal.SearchAttributes.Internal
import Temporal.Workflow (KnownQuery (..), KnownSignal (..), QueryRef (..))
import Temporal.Workflow.Definition
import UnliftIO
import Unsafe.Coerce


---------------------------------------------------------------------------------
-- WorkflowClient stuff

workflowClient
  :: MonadIO m
  => Core.Client
  -> WorkflowClientConfig
  -> m WorkflowClient
workflowClient c conf = do
  pure
    WorkflowClient
      { clientCore = c
      , clientConfig = conf
      }


class HasWorkflowClient m where
  askWorkflowClient :: m WorkflowClient


instance {-# OVERLAPS #-} Monad m => HasWorkflowClient (ReaderT WorkflowClient m) where
  askWorkflowClient = ask


instance (Monad m, HasWorkflowClient m, Monoid w) => HasWorkflowClient (AccumT w m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (ReaderT r m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (CRWS.RWST r w s m) where
  askWorkflowClient = lift askWorkflowClient


instance {-# OVERLAPS #-} (Monad m) => HasWorkflowClient (CRWS.RWST WorkflowClient w s m) where
  askWorkflowClient = CRWS.ask


instance (Monad m, HasWorkflowClient m, Monoid w) => HasWorkflowClient (LRWS.RWST r w s m) where
  askWorkflowClient = lift askWorkflowClient


instance {-# OVERLAPS #-} (Monad m, Monoid w) => HasWorkflowClient (LRWS.RWST WorkflowClient w s m) where
  askWorkflowClient = LRWS.ask


instance (Monad m, HasWorkflowClient m, Monoid w) => HasWorkflowClient (SRWS.RWST r w s m) where
  askWorkflowClient = lift askWorkflowClient


instance {-# OVERLAPS #-} (Monad m, Monoid w) => HasWorkflowClient (SRWS.RWST WorkflowClient w s m) where
  askWorkflowClient = SRWS.ask


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (CW.WriterT w m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m, Monoid w) => HasWorkflowClient (LW.WriterT w m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m, Monoid w) => HasWorkflowClient (SW.WriterT w m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (LS.StateT s m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (SS.StateT s m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (ExceptT e m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (IdentityT m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (ContT r m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (MaybeT m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (SelectT r m) where
  askWorkflowClient = lift askWorkflowClient


instance (Monad m, HasWorkflowClient m) => HasWorkflowClient (ConduitT i o m) where
  askWorkflowClient = lift askWorkflowClient


instance HasWorkflowClient ((->) WorkflowClient) where
  askWorkflowClient = id


throwEither :: (MonadIO m, Exception e) => IO (Either e a) -> m a
throwEither = either throwIO pure <=< liftIO


{- | Run a workflow, synchronously waiting for it to complete.

This function will block until the workflow completes, and will return the result of the workflow
or throw a 'WorkflowExecutionClosed' exception if the workflow was closed without returning a result.
-}
execute
  :: forall m wf
   . (HasWorkflowClient m, MonadIO m, WorkflowRef wf)
  => wf
  -> WorkflowId
  -> StartWorkflowOptions
  -> (WorkflowArgs wf :->: m (WorkflowResult wf))
execute (workflowRef -> k@(KnownWorkflow codec _)) wfId opts = withArgs @(WorkflowArgs wf) @(m (WorkflowResult wf)) codec $ \inputs -> do
  h <- startFromPayloads k wfId opts inputs
  waitWorkflowResult h


{- | Given a 'WorkflowHandle', wait for the workflow to complete and return the result.

This function will block until the workflow completes, and will return the result of the workflow
or throw a 'WorkflowExecutionClosed' exception if the workflow was closed without returning a result.
-}
waitWorkflowResult :: (Typeable a, MonadIO m) => WorkflowHandle a -> m a
waitWorkflowResult h@(WorkflowHandle readResult _ c wf r) = do
  mev <- runReaderT (waitResult wf r c.clientConfig.namespace) c
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
              (a : _) -> liftIO $ readResult a
              _ -> error "Missing result payload"
        HistoryEvent'WorkflowExecutionFailedEventAttributes attrs ->
          throwIO $ WorkflowExecutionFailed attrs
        HistoryEvent'WorkflowExecutionTimedOutEventAttributes _attrs -> throwIO WorkflowExecutionTimedOut
        HistoryEvent'WorkflowExecutionCanceledEventAttributes _attrs -> throwIO WorkflowExecutionCanceled
        HistoryEvent'WorkflowExecutionTerminatedEventAttributes _attrs -> throwIO WorkflowExecutionTerminated
        HistoryEvent'WorkflowExecutionContinuedAsNewEventAttributes _attrs -> throwIO WorkflowExecutionContinuedAsNew
        e -> error ("History event not supported " <> show e)


data SignalOptions = SignalOptions
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
defaultSignalOptions =
  SignalOptions
    { skipGenerateWorkflowTask = False
    , requestId = Nothing
    , headers = mempty
    }


{- | A Signal is an asynchronous request to a Workflow Execution.

A Signal delivers data to a running Workflow Execution. It cannot return data to the caller;
to do so, use a Query instead. The Workflow code that handles a Signal can mutate Workflow state.
A Signal can be sent from a Temporal Client or a Workflow. When a Signal is sent, it is received
by the Cluster and recorded as an Event to the Workflow Execution Event History. A successful
response from the Cluster means that the Signal has been persisted and will be delivered at least
once to the Workflow Execution. The next scheduled Workflow Task will contain the Signal Event.

Signal handlers are Workflow functions that listen for Signals by the Signal name. Signals are delivered
in the order they are received by the Cluster. If multiple deliveries of a Signal would be a problem for
your Workflow, add idempotency logic to your Signal handler that checks for duplicates.
-}
signal
  :: forall m sig a
   . (MonadIO m, SignalRef sig)
  => WorkflowHandle a
  -> sig
  -> SignalOptions
  -> (SignalArgs sig :->: m ())
signal (WorkflowHandle _ _t c wf r) (signalRef -> (KnownSignal sName sCodec)) opts = withArgs @(SignalArgs sig) @(m ()) sCodec $ \inputs -> liftIO $ do
  inputs' <- processorEncodePayloads c.clientConfig.payloadProcessor =<< liftIO (sequence inputs)
  hdrs <- processorEncodePayloads c.clientConfig.payloadProcessor opts.headers
  result <-
    signalWorkflowExecution c.clientCore $
      defMessage
        & WF.namespace .~ rawNamespace c.clientConfig.namespace
        & WF.workflowExecution
          .~ ( defMessage
                & Common.workflowId .~ rawWorkflowId wf
                & Common.runId .~ maybe "" rawRunId r
             )
        & WF.signalName .~ sName
        & WF.input .~ (defMessage & Common.vec'payloads .~ fmap convertToProtoPayload inputs')
        & WF.identity .~ Core.identity (Core.clientConfig c.clientCore)
        & WF.requestId .~ fromMaybe "" opts.requestId
        -- Deprecated, no need to set
        -- & WF.control .~ _
        -- TODO put other useful headers in here
        & WF.header .~ headerToProto (fmap convertToProtoPayload hdrs)
        & WF.skipGenerateWorkflowTask .~ opts.skipGenerateWorkflowTask
  case result of
    Left err -> throwIO err
    Right _ -> pure ()


data QueryOptions = QueryOptions
  { -- queryId :: Text
    -- ,
    queryRejectCondition :: QueryRejectCondition
  , queryHeaders :: Map Text Payload
  }


defaultQueryOptions :: QueryOptions
defaultQueryOptions =
  QueryOptions
    { queryRejectCondition = QueryRejectConditionRejectNone
    , queryHeaders = mempty
    }


{- | A Query is a synchronous operation that is used to get the state of a Workflow Execution. The state of a running Workflow Execution is constantly changing. You can use Queries to expose the internal Workflow Execution state to the external world. Queries are available for running or completed Workflows Executions only if the Worker is up and listening on the Task Queue.

Queries are sent from a Temporal Client to a Workflow Execution. The API call is synchronous. The Query is identified at both ends by a Query name. The Workflow must have a Query handler that is developed to handle that Query and provide data that represents the state of the Workflow Execution.

Queries are strongly consistent and are guaranteed to return the most recent state. This means that the data reflects the state of all confirmed Events that came in before the Query was sent. An Event is considered confirmed if the call creating the Event returned success. Events that are created while the Query is outstanding may or may not be reflected in the Workflow state the Query result is based on.

A Query can carry arguments to specify the data it is requesting. And each Workflow can expose data to multiple types of Queries.

A Query must never mutate the state of the Workflow Execution—that is, Queries are read-only and cannot contain any blocking code. This means, for example, that Query handling logic cannot schedule Activity Executions.

For the Haskell library, this means that the only state that is accessible to a Query is 'Info' and values in 'StateVar's.

Sending Queries to completed Workflow Executions is supported, though Query reject conditions can be configured per Query.
-}
query
  :: forall m query a
   . (MonadIO m, QueryRef query)
  => WorkflowHandle a
  -> query
  -> QueryOptions
  -> (QueryArgs query :->: m (Either QueryRejected (QueryResult query)))
query h (queryRef -> KnownQuery qn codec) opts = withArgs @(QueryArgs query) @(m (Either QueryRejected (QueryResult query))) codec $ \inputs -> liftIO $ do
  inputs' <- sequence inputs
  let processor = h.workflowHandleClient.clientConfig.payloadProcessor
      baseInput =
        QueryWorkflowInput
          { queryWorkflowType = qn
          , queryWorkflowRunId = h.workflowHandleRunId
          , queryWorkflowRejectCondition = opts.queryRejectCondition
          , queryWorkflowWorkflowId = h.workflowHandleWorkflowId
          , queryWorkflowHeaders = opts.queryHeaders
          , queryWorkflowArgs = inputs'
          }
  eRes <- h.workflowHandleClient.clientConfig.interceptors.queryWorkflow baseInput $ \input -> do
    queryArgs <- processorEncodePayloads processor input.queryWorkflowArgs
    headerPayloads <- processorEncodePayloads processor input.queryWorkflowHeaders
    let msg :: QueryWorkflowRequest
        msg =
          defMessage
            & WF.namespace .~ rawNamespace h.workflowHandleClient.clientConfig.namespace
            & WF.execution
              .~ ( defMessage
                    & Common.workflowId .~ rawWorkflowId input.queryWorkflowWorkflowId
                    & Common.runId .~ maybe "" rawRunId input.queryWorkflowRunId
                 )
            & WF.query
              .~ ( defMessage
                    & Query.queryType .~ input.queryWorkflowType
                    & Query.queryArgs
                      .~ (defMessage & Common.vec'payloads .~ fmap convertToProtoPayload queryArgs)
                    & Query.header .~ headerToProto (fmap convertToProtoPayload headerPayloads)
                 )
            & WF.queryRejectCondition .~ case opts.queryRejectCondition of
              QueryRejectConditionRejectNone -> Query.QUERY_REJECT_CONDITION_NONE
              QueryRejectConditionNotOpen -> Query.QUERY_REJECT_CONDITION_NOT_OPEN
              QueryRejectConditionNotCompletedCleanly -> Query.QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY

    (res :: QueryWorkflowResponse) <- either throwIO pure =<< Temporal.Core.Client.WorkflowService.queryWorkflow h.workflowHandleClient.clientCore msg
    case res ^. WF.maybe'queryRejected of
      Just rejection -> do
        let status = queryRejectionStatusFromProto (rejection ^. Query.status)
        pure $ Left $ QueryRejected {..}
      Nothing -> case (res ^. WF.queryResult . Common.vec'payloads) V.!? 0 of
        Nothing -> throwIO $ ValueError "No return value payloads provided by query response"
        Just p -> pure $ Right $ convertFromProtoPayload p
  forM eRes $ \p ->
    payloadProcessorDecode processor p >>= either (throwIO . ValueError) pure >>= decode codec >>= either (throwIO . ValueError) pure
  where
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


{- | Sometimes you know that a Workflow exists or existed, but you didn't create the workflow from
the current process or code path. In this case, you can use 'getHandle' to get a handle to the
workflow so that you can interact with it.

Note that it is possible for a workflow to be closed or archived by the time you get a handle,
so you should be prepared to handle 'WorkflowExecutionClosed' exceptions.
-}
getHandle
  :: (HasWorkflowClient m, MonadIO m)
  => KnownWorkflow args a
  -> WorkflowId
  -> Maybe RunId
  -> m (WorkflowHandle a)
getHandle (KnownWorkflow {knownWorkflowCodec, knownWorkflowName}) wfId runId = do
  c <- askWorkflowClient
  pure $
    WorkflowHandle
      { workflowHandleReadResult = \a -> do
          result <- decode knownWorkflowCodec =<< either (throwIO . ValueError) pure =<< payloadProcessorDecode c.clientConfig.payloadProcessor a
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

{- | Start a new Workflow Execution from an unchecked list of payloads. This can be useful if you are forwarding
execution from another Workflow or from an external source, but no checking to make sure that the input
types are correct is performed.
-}
startFromPayloads
  :: (MonadIO m, HasWorkflowClient m)
  => KnownWorkflow args result
  -> WorkflowId
  -- ^ A Workflow Id is a customizable, application-level identifier for a Workflow Execution that is unique to an Open Workflow Execution within a Namespace.
  --
  -- A Workflow Id is meant to be a business-process identifier such as customer identifier or order identifier.
  --
  -- A Workflow Id Reuse Policy can be used to manage whether a Workflow Id can be re-used. The Temporal Platform guarantees uniqueness of the Workflow Id within a Namespace based on the Workflow Id Reuse Policy.
  --
  -- A Workflow Execution can be uniquely identified across all Namespaces by its Namespace, Workflow Id, and Run Id.
  -> StartWorkflowOptions
  -> V.Vector UnencodedPayload
  -> m (WorkflowHandle result)
startFromPayloads k@(KnownWorkflow codec _) wfId opts payloads = do
  c <- askWorkflowClient
  ps <- liftIO $ sequence payloads
  wfH <- liftIO $ Temporal.Client.Types.start c.clientConfig.interceptors (WorkflowType $ knownWorkflowName k) wfId opts ps $ \wfName wfId' opts' payloads' -> do
    reqId <- UUID.nextRandom
    searchAttrs <- searchAttributesToProto opts'.searchAttributes
    payloads'' <- processorEncodePayloads c.clientConfig.payloadProcessor payloads'
    hdrs <- processorEncodePayloads c.clientConfig.payloadProcessor opts'.headers
    let tq = rawTaskQueue opts'.taskQueue
        req =
          defMessage
            & WF.namespace .~ rawNamespace c.clientConfig.namespace
            & WF.workflowId .~ rawWorkflowId wfId'
            & WF.workflowType
              .~ ( defMessage & Common.name .~ rawWorkflowType wfName
                 )
            & WF.taskQueue
              .~ ( defMessage
                    & Common.name .~ tq
                    & TQ.kind .~ TASK_QUEUE_KIND_UNSPECIFIED
                 )
            & WF.input
              .~ ( defMessage & Common.vec'payloads .~ (convertToProtoPayload <$> payloads'')
                 )
            & WF.maybe'workflowExecutionTimeout .~ (durationToProto <$> opts'.timeouts.executionTimeout)
            & WF.maybe'workflowRunTimeout .~ (durationToProto <$> opts'.timeouts.runTimeout)
            & WF.maybe'workflowTaskTimeout .~ (durationToProto <$> opts'.timeouts.taskTimeout)
            & WF.identity .~ Core.identity (Core.clientConfig c.clientCore)
            & WF.requestId .~ UUID.toText reqId
            & WF.workflowIdReusePolicy
              .~ workflowIdReusePolicyToProto
                (fromMaybe WorkflowIdReusePolicyAllowDuplicateFailedOnly opts'.workflowIdReusePolicy)
            & WF.maybe'retryPolicy .~ (retryPolicyToProto <$> opts'.retryPolicy)
            & WF.cronSchedule .~ fromMaybe "" opts'.cronSchedule
            & WF.memo .~ convertToProtoMemo opts'.memo
            & WF.searchAttributes .~ (defMessage & Common.indexedFields .~ searchAttrs)
            --     TODO Not sure how to use these yet
            & WF.header .~ headerToProto (fmap convertToProtoPayload hdrs)
            & WF.requestEagerExecution .~ opts'.requestEagerExecution
            {-
              These values will be available as ContinuedFailure and LastCompletionResult in the
              WorkflowExecutionStarted event and through SDKs. The are currently only used by the
              server itself (for the schedules feature) and are not intended to be exposed in
              StartWorkflowExecution.

              WF.continuedFailure
              WF.lastCompletionResult
            -}
            & WF.maybe'workflowStartDelay .~ (durationToProto <$> workflowStartDelay opts')
    res <- startWorkflowExecution c.clientCore req
    case res of
      Left err -> throwIO err
      Right swer ->
        pure $
          WorkflowHandle
            { workflowHandleReadResult = pure
            , workflowHandleType = WorkflowType $ knownWorkflowName k
            , workflowHandleClient = c
            , workflowHandleWorkflowId = wfId'
            , workflowHandleRunId = Just (RunId $ swer ^. WF.runId)
            }
  pure $
    wfH
      { workflowHandleReadResult = \a ->
          workflowHandleReadResult wfH a >>= \b -> do
            result <- decode codec =<< either (throwIO . ValueError) pure =<< payloadProcessorDecode c.clientConfig.payloadProcessor b
            either (throwIO . ValueError) pure result
      }


{- | Begin a new Workflow Execution.

This function does not wait for the Workflow to complete. Instead, it returns a 'WorkflowHandle'
that can be used to wait for the Workflow to complete or perform other operations.

This can be used to "fire-and-forget" a Workflow by discarding the handle.
-}
start
  :: forall m wf
   . (MonadIO m, HasWorkflowClient m, WorkflowRef wf)
  => wf
  -> WorkflowId
  -> StartWorkflowOptions
  -> (WorkflowArgs wf :->: m (WorkflowHandle (WorkflowResult wf)))
start (workflowRef -> k@(KnownWorkflow codec _)) wfId opts = withArgs @(WorkflowArgs wf) @(m (WorkflowHandle (WorkflowResult wf))) codec $ \inputs -> do
  startFromPayloads k wfId opts inputs


{- | If there is a running Workflow Execution with the given Workflow Id, it will be Signaled.

Otherwise, a new Workflow Execution is started and immediately send the Signal.
-}
signalWithStart
  :: forall wf sig m
   . (MonadIO m, HasWorkflowClient m, WorkflowRef wf, SignalRef sig)
  => wf
  -> WorkflowId
  -> StartWorkflowOptions
  -> sig
  -> (WorkflowArgs wf :->: (SignalArgs sig :->: m (WorkflowHandle (WorkflowResult wf))))
signalWithStart (workflowRef -> k@(KnownWorkflow codec _)) wfId opts (signalRef -> KnownSignal n sigCodec) = unnestedArgs
  where
    signalArgsMaker :: m (SignalArgs sig :->: m (WorkflowHandle (WorkflowResult wf))) -> SignalArgs sig :->: m (WorkflowHandle (WorkflowResult wf))
    signalArgsMaker = sequenceArgs @(SignalArgs sig) @m (Proxy @(m (WorkflowHandle (WorkflowResult wf))))

    unnestedArgs :: WorkflowArgs wf :->: (SignalArgs sig :->: m (WorkflowHandle (WorkflowResult wf)))
    unnestedArgs =
      mapResult
        @(WorkflowArgs wf)
        signalArgsMaker
        nestedArgs

    nestedArgs = withArgs @(WorkflowArgs wf) @(m (SignalArgs sig :->: m (WorkflowHandle (WorkflowResult wf)))) codec $ \wfArgs -> do
      c <- askWorkflowClient
      wfArgs' <- processorEncodePayloads c.clientConfig.payloadProcessor =<< liftIO (sequence wfArgs)
      pure $ signalArgs wfArgs'

    signalArgs :: V.Vector Payload -> SignalArgs sig :->: m (WorkflowHandle (WorkflowResult wf))
    signalArgs wfArgs = withArgs @(SignalArgs sig) @(m (WorkflowHandle (WorkflowResult wf))) sigCodec $ \sa -> do
      c <- askWorkflowClient
      sigArgs' <- liftIO $ sequence sa
      let processor = c.clientConfig.payloadProcessor
          interceptorOpts =
            SignalWithStartWorkflowInput
              { signalWithStartWorkflowType = WorkflowType $ knownWorkflowName k
              , signalWithStartSignalName = n
              , signalWithStartSignalArgs = sigArgs'
              , signalWithStartArgs = wfArgs
              , signalWithStartOptions = opts
              , signalWithStartWorkflowId = wfId
              }
      wfH <- liftIO $ Temporal.Client.Types.signalWithStart c.clientConfig.interceptors interceptorOpts $ \opts' -> do
        reqId <- UUID.nextRandom
        searchAttrs <- searchAttributesToProto opts'.signalWithStartOptions.searchAttributes
        signalArgs' <- processorEncodePayloads processor opts'.signalWithStartSignalArgs
        wfArgs' <- processorEncodePayloads processor opts'.signalWithStartArgs
        hdrs <- processorEncodePayloads processor opts'.signalWithStartOptions.headers
        memo' <- processorEncodePayloads processor opts'.signalWithStartOptions.memo
        let tq = rawTaskQueue opts'.signalWithStartOptions.taskQueue
            msg =
              defMessage
                & RR.namespace .~ rawNamespace c.clientConfig.namespace
                & RR.workflowId .~ rawWorkflowId opts'.signalWithStartWorkflowId
                & RR.workflowType
                  .~ ( defMessage & Common.name .~ rawWorkflowType opts'.signalWithStartWorkflowType
                     )
                & WF.requestId .~ UUID.toText reqId
                & RR.searchAttributes .~ (defMessage & Common.indexedFields .~ searchAttrs)
                & RR.taskQueue
                  .~ ( defMessage
                        & Common.name .~ tq
                        & TQ.kind .~ TASK_QUEUE_KIND_UNSPECIFIED
                     )
                & RR.input
                  .~ ( defMessage & Common.vec'payloads .~ fmap convertToProtoPayload wfArgs'
                     )
                & RR.maybe'workflowExecutionTimeout .~ (durationToProto <$> opts'.signalWithStartOptions.timeouts.executionTimeout)
                & RR.maybe'workflowRunTimeout .~ (durationToProto <$> opts'.signalWithStartOptions.timeouts.runTimeout)
                & RR.maybe'workflowTaskTimeout .~ (durationToProto <$> opts'.signalWithStartOptions.timeouts.taskTimeout)
                & RR.identity .~ Core.identity (Core.clientConfig c.clientCore)
                & RR.requestId .~ UUID.toText reqId
                & RR.workflowIdReusePolicy
                  .~ workflowIdReusePolicyToProto
                    (fromMaybe WorkflowIdReusePolicyAllowDuplicateFailedOnly opts'.signalWithStartOptions.workflowIdReusePolicy)
                & RR.signalName .~ n
                & RR.signalInput .~ (defMessage & Common.vec'payloads .~ fmap convertToProtoPayload signalArgs')
                -- Deprecated, no need to set
                -- & RR.control .~ _
                & RR.maybe'retryPolicy .~ (retryPolicyToProto <$> opts'.signalWithStartOptions.retryPolicy)
                & RR.cronSchedule .~ fromMaybe "" opts'.signalWithStartOptions.cronSchedule
                & RR.memo .~ convertToProtoMemo memo'
                & RR.header .~ headerToProto (fmap convertToProtoPayload hdrs)
        -- & RR.workflowStartDelay .~ _
        -- & RR.skipGenerateWorkflowTask .~ _
        res <-
          signalWithStartWorkflowExecution
            c.clientCore
            msg
        case res of
          Left err -> throwIO err
          Right swer ->
            pure $
              WorkflowHandle
                { workflowHandleReadResult = pure
                , workflowHandleType = WorkflowType $ knownWorkflowName k
                , workflowHandleClient = c
                , workflowHandleWorkflowId = opts'.signalWithStartWorkflowId
                , workflowHandleRunId = Just (RunId $ swer ^. WF.runId)
                }
      pure $
        wfH
          { workflowHandleReadResult = \a ->
              workflowHandleReadResult wfH a >>= \b -> do
                result <- decode codec b
                either (throwIO . ValueError) pure result
          }


data TerminationOptions = TerminationOptions
  { terminationReason :: Text
  , terminationDetails :: [Payload]
  , firstExecutionRunId :: Maybe RunId
  -- ^ If set, this call will error if the (most recent | specified workflow run id in the WorkflowHandle) is not part of the same
  -- execution chain as this id.
  }


{- | Terminating a workflow immediately signals to the worker that the workflow should
cease execution. The workflow will not be given a chance to react to the termination.
-}
terminate :: MonadIO m => WorkflowHandle a -> TerminationOptions -> m ()
terminate h req =
  void $
    throwEither $
      terminateWorkflowExecution
        h.workflowHandleClient.clientCore
        msg
  where
    msg =
      defMessage
        & RR.namespace .~ rawNamespace h.workflowHandleClient.clientConfig.namespace
        & RR.workflowExecution
          .~ ( defMessage
                & Common.workflowId .~ rawWorkflowId h.workflowHandleWorkflowId
                & Common.runId .~ maybe "" rawRunId h.workflowHandleRunId
             )
        & RR.reason .~ req.terminationReason
        & RR.details
          .~ (defMessage & Common.payloads .~ fmap convertToProtoPayload req.terminationDetails)
        & RR.identity .~ Core.identity (Core.clientConfig h.workflowHandleClient.clientCore)
        & RR.firstExecutionRunId .~ maybe "" rawRunId req.firstExecutionRunId


data FollowOption = FollowRuns | ThisRunOnly


-- | Thrown when 'FollowOption' is 'ThisRunOnly' and the workflow continues as new.
data WorkflowContinuedAsNewException = WorkflowContinuedAsNewException
  { workflowContinuedAsNewExceptionRunId :: RunId
  }
  deriving stock (Show)


instance Exception WorkflowContinuedAsNewException


{- | Fetch the history of a Workflow execution as it currently stands.

This is useful for Workflow replay tests.
-}
fetchHistory :: MonadIO m => WorkflowHandle a -> m History
fetchHistory h = do
  let startingReq :: GetWorkflowExecutionHistoryRequest
      startingReq =
        defMessage
          & RR.namespace .~ rawNamespace h.workflowHandleClient.clientConfig.namespace
          & RR.execution
            .~ ( defMessage
                  & Common.workflowId .~ rawWorkflowId h.workflowHandleWorkflowId
                  & case h.workflowHandleRunId of
                    Nothing -> Prelude.id
                    Just rId -> Common.runId .~ rawRunId rId
               )
          & RR.maximumPageSize .~ 100
          & RR.waitNewEvent .~ False
          & RR.historyEventFilterType .~ HISTORY_EVENT_FILTER_TYPE_ALL_EVENT
          & RR.skipArchival .~ True
  allEvents <- runReaderT (sourceToList (streamEvents FollowRuns startingReq)) h.workflowHandleClient
  pure $ build (History.events .~ allEvents)


applyNewExecutionRunId
  :: HasField s "newExecutionRunId" Text
  => s
  -> GetWorkflowExecutionHistoryRequest
  -> Maybe GetWorkflowExecutionHistoryRequest
  -> Maybe GetWorkflowExecutionHistoryRequest
applyNewExecutionRunId attrs req alt =
  if attrs ^. History.newExecutionRunId == ""
    then alt
    else
      let exec = req ^. RR.execution
      in Just
          ( req
              & RR.execution .~ (exec & RR.runId .~ (attrs ^. History.newExecutionRunId))
              & RR.nextPageToken .~ ""
          )


{- | Workflow execution history is represented as a series of events. This function allows you to
subscribe to those events and process them as they are received. As an example, this is used to implement
'waitWorkflowResult'.
-}
streamEvents
  :: (MonadIO m, HasWorkflowClient m)
  => FollowOption
  -> GetWorkflowExecutionHistoryRequest
  -> ConduitT () HistoryEvent m ()
streamEvents followOpt baseReq = askWorkflowClient >>= \c -> go c baseReq
  where
    go c req = do
      res <- liftIO $ getWorkflowExecutionHistory c.clientCore req
      case res of
        Left err -> throwIO err
        Right x -> do
          yieldMany (x ^. RR.history . History.events)
          for_ (decideLoop baseReq x) (go c)
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
                FollowRuns ->
                  if attrs ^. History.newExecutionRunId == ""
                    then error "Expected newExecutionRunId in WorkflowExecutionContinuedAsNewEventAttributes"
                    else
                      Just $
                        req
                          & RR.nextPageToken .~ ""
                          & RR.execution %~ (RR.runId .~ (attrs ^. History.newExecutionRunId))
                ThisRunOnly -> Nothing
              _ -> Nothing
      where
        nextPage =
          if res ^. RR.nextPageToken == ""
            then Nothing
            else Just (req & RR.nextPageToken .~ (res ^. RR.nextPageToken))


waitResult
  :: (MonadIO m, HasWorkflowClient m)
  => WorkflowId
  -> Maybe RunId
  -> Namespace {- options incl namespace -}
  -> m (Maybe HistoryEvent)
waitResult wfId mrId (Namespace ns) = do
  let startingReq :: GetWorkflowExecutionHistoryRequest
      startingReq =
        defMessage
          & RR.namespace .~ ns
          & RR.execution
            .~ ( defMessage
                  & Common.workflowId .~ rawWorkflowId wfId
                  & case mrId of
                    Nothing -> Prelude.id
                    Just rId -> Common.runId .~ rawRunId rId
               )
          & RR.maximumPageSize .~ 100
          & RR.waitNewEvent .~ True
          & RR.historyEventFilterType .~ HISTORY_EVENT_FILTER_TYPE_CLOSE_EVENT
          & RR.skipArchival .~ True
  connect (streamEvents FollowRuns startingReq) lastC


-- listOpenWorkflowExecutions
--   :: (MonadIO m, HasWorkflowClient m)
--   => ListOpenWorkflowExecutionsRequest
--   -> ConduitT () WorkflowExecutionInfo m ()

-- listClosedWorkflowExecutions
--   :: (MonadIO m, HasWorkflowClient m)
--   => ListClosedWorkflowExecutionsRequest
--   -> ConduitT () WorkflowExecutionInfo m ()

-- scanWorkflowExecutions
--   :: (MonadIO m, HasWorkflowClient m)
--   => ScanWorkflowExecutionsRequest
--   -> ConduitT () WorkflowExecutionInfo m ()

-- countWorkflowExecutions
--   :: (MonadIO m, HasWorkflowClient m)
--   => CountWorkflowExecutionsRequest
--   -> m Int64

data UpdateLifecycleStage
  = UpdateLifecycleStageUnspecified
  | UpdateLifecycleStageAdmitted
  | UpdateLifecycleStageAccepted
  | UpdateLifecycleStageCompleted
  deriving stock (Eq, Show)


data UpdateOptions = UpdateOptions
  { updateId :: UpdateId
  , updateHeaders :: Map Text Payload
  , waitPolicy :: UpdateLifecycleStage
  }


update
  :: forall m args result a
   . (MonadIO m, HasWorkflowClient m)
  => WorkflowHandle a
  -> KnownUpdate args result
  -> UpdateOptions
  -> args
    :->: m result
update h@(WorkflowHandle _ _ c _ _) (KnownUpdate updateCodec updateName) opts = withArgs @args @(m result) updateCodec $ \inputs -> liftIO $ do
  inputs' <- sequence inputs
  let processor = h.workflowHandleClient.clientConfig.payloadProcessor
      baseInput =
        UpdateWorkflowInput
          { updateWorkflowType = updateName
          , updateWorkflowRunId = h.workflowHandleRunId
          , updateWorkflowWorkflowId = h.workflowHandleWorkflowId
          , updateWorkflowHeaders = opts.updateHeaders
          , updateWorkflowArgs = inputs'
          }
  -- TODO: client interceptor
  let input = baseInput
  eRes {- h.workflowHandleClient.clientConfig.interceptors.updateWorkflow baseInput $ \input -> -} <- do
    updateArgs <- processorEncodePayloads processor input.updateWorkflowArgs
    headerPayloads <- processorEncodePayloads processor input.updateWorkflowHeaders
    let msg :: UpdateWorkflowExecutionRequest
        msg =
          defMessage
            & WF.namespace .~ rawNamespace h.workflowHandleClient.clientConfig.namespace
            & WF.workflowExecution
              .~ ( defMessage
                    & Common.workflowId .~ rawWorkflowId input.updateWorkflowWorkflowId
                    & Common.runId .~ maybe "" rawRunId input.updateWorkflowRunId
                 )
            & WF.firstExecutionRunId .~ "" -- TODO: get this
            & WF.waitPolicy .~ defMessage -- TODO
            & WF.request
              .~ ( defMessage
                    & Update.meta
                      .~ ( defMessage
                            & Update.updateId .~ rawUpdateId opts.updateId
                            & Update.identity .~ Core.identity (Core.clientConfig c.clientCore)
                         )
                    & Update.input
                      .~ ( defMessage
                            & Update.header .~ headerToProto (fmap convertToProtoPayload headerPayloads)
                            & Update.name .~ input.updateWorkflowType
                            & Update.args .~ (defMessage & Common.vec'payloads .~ fmap convertToProtoPayload updateArgs)
                         )
                 )

    (res :: UpdateWorkflowExecutionResponse) <- either throwIO pure =<< Temporal.Core.Client.WorkflowService.updateWorkflowExecution h.workflowHandleClient.clientCore msg
    case res ^. Update.maybe'outcome of
      Nothing -> throwIO $ ValueError "No return value payloads provided by update response"
      Just outcome -> do
        case outcome ^. Update.maybe'value of
          Just (Update.Outcome'Success payloads) -> case (payloads ^. Common.vec'payloads) V.!? 0 of
            Nothing -> throwIO $ ValueError "No return value payloads provided by update response"
            Just p -> pure $ convertFromProtoPayload p
          -- TODO: convert this failure thing to a nice Haskell version
          Just (Update.Outcome'Failure failure) -> throwIO $ ValueError "No return value payloads provided by update response"
          Nothing -> throwIO $ ValueError "No return value payloads provided by update response"
  payloadProcessorDecode processor eRes >>= either (throwIO . ValueError) pure >>= decode updateCodec >>= either (throwIO . ValueError) pure

-- query
--   :: forall m query a
--    . (MonadIO m, QueryRef query)
--   => WorkflowHandle a
--   -> query
--   -> QueryOptions
--   -> (QueryArgs query :->: m (Either QueryRejected (QueryResult query)))
-- query h (queryRef -> KnownQuery qn codec) opts = withArgs @(QueryArgs query) @(m (Either QueryRejected (QueryResult query))) codec $ \inputs -> liftIO $ do
--   inputs' <- sequence inputs
--   let processor = h.workflowHandleClient.clientConfig.payloadProcessor
--       baseInput =
--         QueryWorkflowInput
--           { queryWorkflowType = qn
--           , queryWorkflowRunId = h.workflowHandleRunId
--           , queryWorkflowRejectCondition = opts.queryRejectCondition
--           , queryWorkflowWorkflowId = h.workflowHandleWorkflowId
--           , queryWorkflowHeaders = opts.queryHeaders
--           , queryWorkflowArgs = inputs'
--           }
--   eRes <- h.workflowHandleClient.clientConfig.interceptors.queryWorkflow baseInput $ \input -> do
--     queryArgs <- processorEncodePayloads processor input.queryWorkflowArgs
--     headerPayloads <- processorEncodePayloads processor input.queryWorkflowHeaders
--     let msg :: QueryWorkflowRequest
--         msg =
--           defMessage
--             & WF.namespace .~ rawNamespace h.workflowHandleClient.clientConfig.namespace
--             & WF.execution
--               .~ ( defMessage
--                     & Common.workflowId .~ rawWorkflowId input.queryWorkflowWorkflowId
--                     & Common.runId .~ maybe "" rawRunId input.queryWorkflowRunId
--                  )
--             & WF.query
--               .~ ( defMessage
--                     & Query.queryType .~ input.queryWorkflowType
--                     & Query.queryArgs
--                       .~ (defMessage & Common.vec'payloads .~ fmap convertToProtoPayload queryArgs)
--                     & Query.header .~ headerToProto (fmap convertToProtoPayload headerPayloads)
--                  )
--             & WF.queryRejectCondition .~ case opts.queryRejectCondition of
--               QueryRejectConditionRejectNone -> Query.QUERY_REJECT_CONDITION_NONE
--               QueryRejectConditionNotOpen -> Query.QUERY_REJECT_CONDITION_NOT_OPEN
--               QueryRejectConditionNotCompletedCleanly -> Query.QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY

--     (res :: QueryWorkflowResponse) <- either throwIO pure =<< Temporal.Core.Client.WorkflowService.queryWorkflow h.workflowHandleClient.clientCore msg
--     case res ^. WF.maybe'queryRejected of
--       Just rejection -> do
--         let status = queryRejectionStatusFromProto (rejection ^. Query.status)
--         pure $ Left $ QueryRejected {..}
--       Nothing -> case (res ^. WF.queryResult . Common.vec'payloads) V.!? 0 of
--         Nothing -> throwIO $ ValueError "No return value payloads provided by query response"
--         Just p -> pure $ Right $ convertFromProtoPayload p
--   forM eRes $ \p ->
--     payloadProcessorDecode processor p >>= either (throwIO . ValueError) pure >>= decode codec >>= either (throwIO . ValueError) pure
--   where
--     queryRejectionStatusFromProto = \case
--       WORKFLOW_EXECUTION_STATUS_UNSPECIFIED -> UnknownStatus
--       WORKFLOW_EXECUTION_STATUS_RUNNING -> Running
--       WORKFLOW_EXECUTION_STATUS_COMPLETED -> Completed
--       WORKFLOW_EXECUTION_STATUS_FAILED -> Failed
--       WORKFLOW_EXECUTION_STATUS_CANCELED -> Canceled
--       WORKFLOW_EXECUTION_STATUS_TERMINATED -> Terminated
--       WORKFLOW_EXECUTION_STATUS_CONTINUED_AS_NEW -> ContinuedAsNew
--       WORKFLOW_EXECUTION_STATUS_TIMED_OUT -> TimedOut
--       WorkflowExecutionStatus'Unrecognized _ -> UnknownStatus

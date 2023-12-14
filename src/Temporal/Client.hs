{- | 
Module: Temporal.Client
Description: Invoke and interact with Temporal Workflows.

Workflow Clients are embedded in your application code and connect to a Temporal Server.

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
  -- * Running Workflows
  , WorkflowStartOptions(..)
  , TimeoutOptions(..)
  , workflowStartOptions
  , Temporal.Client.start
  , startFromPayloads
  , WorkflowHandle
  , execute
  , waitWorkflowResult
  -- * Closing Workflows
  , TerminationOptions(..)
  , terminate
  -- * Querying Workflows
  , QueryOptions(..)
  , QueryRejectCondition(..)
  , QueryRejected(..)
  , Temporal.Client.Types.WorkflowExecutionStatus(..)
  , defaultQueryOptions
  , query
  -- * Sending Signals to Workflows
  , SignalOptions(..)
  , signal
  , defaultSignalOptions
  , Temporal.Client.signalWithStart
  -- * Producing handles for existing workflows
  , getHandle
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
import Temporal.Workflow.Signal (SignalRef(..))
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

-- | Run a workflow, synchronously waiting for it to complete.
--
-- This function will block until the workflow completes, and will return the result of the workflow
-- or throw a 'WorkflowExecutionClosed' exception if the workflow was closed without returning a result.
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
      waitWorkflowResult h

-- | Given a 'WorkflowHandle', wait for the workflow to complete and return the result.
--
-- This function will block until the workflow completes, and will return the result of the workflow
-- or throw a 'WorkflowExecutionClosed' exception if the workflow was closed without returning a result.
waitWorkflowResult :: (Typeable a, MonadIO m) => WorkflowHandle a -> m a
waitWorkflowResult h@(WorkflowHandle readResult _ c wf r) = do
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

-- | A Signal is an asynchronous request to a Workflow Execution.
--
-- A Signal delivers data to a running Workflow Execution. It cannot return data to the caller; 
-- to do so, use a Query instead. The Workflow code that handles a Signal can mutate Workflow state. 
-- A Signal can be sent from a Temporal Client or a Workflow. When a Signal is sent, it is received 
-- by the Cluster and recorded as an Event to the Workflow Execution Event History. A successful 
-- response from the Cluster means that the Signal has been persisted and will be delivered at least 
-- once to the Workflow Execution. The next scheduled Workflow Task will contain the Signal Event.
--
-- Signal handlers are Workflow functions that listen for Signals by the Signal name. Signals are delivered 
-- in the order they are received by the Cluster. If multiple deliveries of a Signal would be a problem for 
-- your Workflow, add idempotency logic to your Signal handler that checks for duplicates.
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
      & WF.identity .~ (Temporal.Core.Client.identity $ clientConfig c.clientCore)
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

-- | A Query is a synchronous operation that is used to get the state of a Workflow Execution. The state of a running Workflow Execution is constantly changing. You can use Queries to expose the internal Workflow Execution state to the external world. Queries are available for running or completed Workflows Executions only if the Worker is up and listening on the Task Queue.
--
-- Queries are sent from a Temporal Client to a Workflow Execution. The API call is synchronous. The Query is identified at both ends by a Query name. The Workflow must have a Query handler that is developed to handle that Query and provide data that represents the state of the Workflow Execution.
--
-- Queries are strongly consistent and are guaranteed to return the most recent state. This means that the data reflects the state of all confirmed Events that came in before the Query was sent. An Event is considered confirmed if the call creating the Event returned success. Events that are created while the Query is outstanding may or may not be reflected in the Workflow state the Query result is based on.
--
-- A Query can carry arguments to specify the data it is requesting. And each Workflow can expose data to multiple types of Queries.
--
-- A Query must never mutate the state of the Workflow Execution—that is, Queries are read-only and cannot contain any blocking code. This means, for example, that Query handling logic cannot schedule Activity Executions.
--
-- For the Haskell library, this means that the only state that is accessible to a Query is 'Info' and values in 'StateVar's.
--
-- Sending Queries to completed Workflow Executions is supported, though Query reject conditions can be configured per Query.
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

-- | Sometimes you know that a Workflow exists or existed, but you didn't create the workflow from
-- the current process or code path. In this case, you can use 'getHandle' to get a handle to the
-- workflow so that you can interact with it.
--
-- Note that it is possible for a workflow to be closed or archived by the time you get a handle,
-- so you should be prepared to handle 'WorkflowExecutionClosed' exceptions.
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

-- | Start a new Workflow Execution from an unchecked list of payloads. This can be useful if you are forwarding
-- execution from another Workflow or from an external source, but no checking to make sure that the input
-- types are correct is performed.
startFromPayloads 
  :: MonadIO m
  => WorkflowClient
  -> KnownWorkflow args result
  -> WorkflowStartOptions
  -> [Payload]
  -> m (WorkflowHandle result)
startFromPayloads c k@(KnownWorkflow codec _ mwfQ _) opts payloads = do
  wfH <- liftIO $ (Temporal.Client.Types.start c.clientInterceptors) (WorkflowType $ knownWorkflowName k) opts payloads $ \wfName opts' payloads' -> do
    reqId <- UUID.nextRandom
    searchAttrs <- searchAttributesToProto opts'.searchAttributes
    let wfId = case opts'.workflowId of
          Nothing -> UUID.toText reqId
          Just wfId -> rawWorkflowId wfId
        tq = rawTaskQueue $ case opts'.taskQueue of
          Nothing -> case mwfQ of
            Nothing -> c.clientDefaultQueue
            Just wfQ -> wfQ
          Just taskQ -> taskQ
        req = defMessage
          & WF.namespace .~ (rawNamespace $ fromMaybe (c.clientDefaultNamespace) $ knownWorkflowNamespace k)
          & WF.workflowId .~ wfId
          & WF.workflowType .~ 
            ( defMessage & Common.name .~ rawWorkflowType wfName
            )
          & WF.taskQueue .~ 
            ( defMessage 
              & Common.name .~ tq
              & TQ.kind .~ TASK_QUEUE_KIND_UNSPECIFIED
            )
          & WF.input .~ 
            ( defMessage & Common.payloads .~ (convertToProtoPayload <$> payloads')
            )
          & WF.maybe'workflowExecutionTimeout .~ (durationToProto <$> opts'.timeouts.executionTimeout)
          & WF.maybe'workflowRunTimeout .~ (durationToProto <$> opts'.timeouts.runTimeout)
          & WF.maybe'workflowTaskTimeout .~ (durationToProto <$> opts'.timeouts.taskTimeout)
          & WF.identity .~ (Temporal.Core.Client.identity $ clientConfig c.clientCore)
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
          & WF.maybe'workflowStartDelay .~ (durationToProto <$> workflowStartDelay opts')
    res <- startWorkflowExecution c.clientCore req
    case res of
      Left err -> throwIO err
      Right swer -> pure $ WorkflowHandle 
        { workflowHandleReadResult = pure
        , workflowHandleType = WorkflowType $ knownWorkflowName k
        , workflowHandleClient = c
        , workflowHandleWorkflowId = WorkflowId wfId
        , workflowHandleRunId = Just (RunId $ swer ^. WF.runId)
        }
  pure $ wfH 
    { workflowHandleReadResult = \a -> workflowHandleReadResult wfH a >>= \b -> do
        result <- decode codec b
        either (throwIO . ValueError) pure result
    }

-- | Begin a new Workflow Execution.
--
-- This function does not wait for the Workflow to complete. Instead, it returns a 'WorkflowHandle'
-- that can be used to wait for the Workflow to complete or perform other operations.
--
-- This can be used to "fire-and-forget" a Workflow by discarding the handle.
start
  :: forall m wf. (MonadIO m, WorkflowRef wf)
  => WorkflowClient
  -> wf
  -> WorkflowStartOptions
  -> (WorkflowArgs wf :->: m (WorkflowHandle (WorkflowResult wf)))
start c wf opts = case workflowRef wf of 
  k@(KnownWorkflow codec _ _ _) -> do
    let gather :: ([IO Payload] -> m (WorkflowHandle (WorkflowResult wf))) -> (WorkflowArgs wf :->: m (WorkflowHandle (WorkflowResult wf)))
        gather = gatherArgs (Proxy @(WorkflowArgs wf)) codec Prelude.id
    gather $ \inputs -> liftIO $ do
      startFromPayloads c k opts =<< sequence inputs


-- | If there is a running Workflow Execution with the given Workflow Id, it will be Signaled. 
--
-- Otherwise, a new Workflow Execution is started and immediately send the Signal.
signalWithStart 
  :: forall wf sigArgs m. (MonadIO m, WorkflowRef wf)
  => WorkflowClient 
  -> wf
  -> WorkflowStartOptions 
  -> SignalRef sigArgs 
  -> (WorkflowArgs wf :->: (sigArgs :->: m (WorkflowHandle (WorkflowResult wf))))
signalWithStart c wf opts (SignalRef n sigCodec) = case workflowRef wf of
  k@(KnownWorkflow codec _ mwfQ _) -> do
    let gatherWf :: ([IO Payload] -> (sigArgs :->: m (WorkflowHandle (WorkflowResult wf)))) -> (WorkflowArgs wf :->: sigArgs :->: m (WorkflowHandle (WorkflowResult wf)))
        gatherWf = gatherArgs (Proxy @(WorkflowArgs wf)) codec Prelude.id

        gatherSig :: ([IO Payload] -> m (WorkflowHandle (WorkflowResult wf))) -> (sigArgs :->: m (WorkflowHandle (WorkflowResult wf)))
        gatherSig = gatherArgs (Proxy @sigArgs) sigCodec Prelude.id
    
    gatherWf $ \wfInputs -> gatherSig $ \sigInputs -> liftIO $ do
      wfArgs <- sequence wfInputs
      sigArgs <- sequence sigInputs
      let interceptorOpts = SignalWithStartWorkflowInput
            { signalWithStartWorkflowType = WorkflowType $ knownWorkflowName k
            , signalWithStartSignalName = n
            , signalWithStartSignalArgs = sigArgs
            , signalWithStartArgs = wfArgs
            , signalWithStartOptions = opts
            }
      wfH <- Temporal.Client.Types.signalWithStart c.clientInterceptors interceptorOpts $ \opts' -> do
        reqId <- UUID.nextRandom
        searchAttrs <- searchAttributesToProto opts'.signalWithStartOptions.searchAttributes

        let wfId = case opts'.signalWithStartOptions.workflowId of
              Nothing -> UUID.toText reqId
              Just wfId -> rawWorkflowId wfId
            tq = rawTaskQueue $ case opts'.signalWithStartOptions.taskQueue of
              Nothing -> case mwfQ of
                Nothing -> c.clientDefaultQueue
                Just wfQ -> wfQ
              Just taskQ -> taskQ
            msg = defMessage
              & RR.namespace .~ (rawNamespace $ fromMaybe (c.clientDefaultNamespace) $ knownWorkflowNamespace k)
              & RR.workflowId .~ wfId
              & RR.workflowType .~
                ( defMessage & Common.name .~ rawWorkflowType opts'.signalWithStartWorkflowType
                )
              & WF.requestId .~ UUID.toText reqId
              & RR.searchAttributes .~ (defMessage & Common.indexedFields .~ searchAttrs)
              & RR.taskQueue .~
                ( defMessage 
                  & Common.name .~ tq
                  & TQ.kind .~ TASK_QUEUE_KIND_UNSPECIFIED
                )
              & RR.input .~
                ( defMessage & Common.payloads .~ (convertToProtoPayload <$> wfArgs)
                )
              & RR.maybe'workflowExecutionTimeout .~ (durationToProto <$> opts'.signalWithStartOptions.timeouts.executionTimeout)
              & RR.maybe'workflowRunTimeout .~ (durationToProto <$> opts'.signalWithStartOptions.timeouts.runTimeout)
              & RR.maybe'workflowTaskTimeout .~ (durationToProto <$> opts'.signalWithStartOptions.timeouts.taskTimeout)
              & RR.identity .~ (Temporal.Core.Client.identity $ clientConfig c.clientCore)
              & RR.requestId .~ UUID.toText reqId
              & RR.workflowIdReusePolicy .~
                  workflowIdReusePolicyToProto
                    (fromMaybe WorkflowIdReusePolicyAllowDuplicateFailedOnly opts'.signalWithStartOptions.workflowIdReusePolicy)
              & RR.signalName .~ n
              & RR.signalInput .~ (defMessage & Common.payloads .~ fmap convertToProtoPayload sigArgs)
              -- Deprecated, no need to set
              -- & RR.control .~ _
              & RR.maybe'retryPolicy .~ (retryPolicyToProto <$> opts'.signalWithStartOptions.retry)
              & RR.cronSchedule .~ maybe "" Prelude.id opts'.signalWithStartOptions.cronSchedule
              & RR.memo .~ (convertToProtoMemo opts'.signalWithStartOptions.memo)
              & RR.header .~ (headerToProto $ fmap convertToProtoPayload opts'.signalWithStartOptions.headers)
              -- & RR.workflowStartDelay .~ _
              -- & RR.skipGenerateWorkflowTask .~ _
        res <- signalWithStartWorkflowExecution 
          c.clientCore
          ( msg 
          )
        case res of
          Left err -> throwIO err
          Right swer -> pure $ WorkflowHandle 
            { workflowHandleReadResult = pure
            , workflowHandleType = WorkflowType $ knownWorkflowName k
            , workflowHandleClient = c
            , workflowHandleWorkflowId = WorkflowId wfId
            , workflowHandleRunId = Just (RunId $ swer ^. WF.runId)
            }
      pure $ wfH 
        { workflowHandleReadResult = \a -> workflowHandleReadResult wfH a >>= \b -> do
            result <- decode codec b
            either (throwIO . ValueError) pure result
        }

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
      & RR.identity .~ Temporal.Core.Client.identity (clientConfig h.workflowHandleClient.clientCore)
      & RR.firstExecutionRunId .~ maybe "" rawRunId req.firstExecutionRunId


data FollowOption = FollowRuns | ThisRunOnly

-- | Thrown when 'FollowOption' is 'ThisRunOnly' and the workflow continues as new.
data WorkflowContinuedAsNewException = WorkflowContinuedAsNewException
  { workflowContinuedAsNewExceptionRunId :: RunId
  } deriving stock (Show)

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

-- | Workflow execution history is represented as a series of events. This function allows you to
-- subscribe to those events and process them as they are received. As an example, this is used to implement
-- 'waitWorkflowResult'.
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
        & RR.maximumPageSize .~ 100
        & RR.waitNewEvent .~ True
        & RR.historyEventFilterType .~ HISTORY_EVENT_FILTER_TYPE_CLOSE_EVENT
        & RR.skipArchival .~ True
  connect (streamEvents c FollowRuns startingReq) lastC




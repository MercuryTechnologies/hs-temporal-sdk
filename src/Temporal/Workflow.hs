{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ViewPatterns #-}

{- |

This module provides the core functionality for defining functions that can be
executed as Temporal workflows.

In day-to-day conversations, the term Workflow frequently denotes either a Workflow Type, a Workflow Definition, or a Workflow Execution.

= What is a Workflow Definition?

A Workflow Definition is the code that defines the constraints of a Workflow Execution.

A Workflow Definition is often also referred to as a Workflow Function. In Temporal's documentation, a Workflow Definition refers to the source for the instance of a Workflow Execution, while a Workflow Function refers to the source for the instance of a Workflow Function Execution.

A Workflow Execution effectively executes once to completion, while a Workflow Function Execution occurs many times during the life of a Workflow Execution.

= Deterministic constraints

A critical aspect of developing Workflow Definitions is ensuring they exhibit certain deterministic traits – that is, making sure that the same Commands are emitted in the same sequence, whenever a corresponding Workflow Function Execution (instance of the Function Definition) is re-executed.

The execution semantics of a Workflow Execution include the re-execution of a Workflow Function, which is called a Replay. The use of Workflow APIs in the function is what generates Commands. Commands tell the Cluster which Events to create and add to the Workflow Execution's Event History. When a Workflow Function executes, the Commands that are emitted are compared with the existing Event History. If a corresponding Event already exists within the Event History that maps to the generation of that Command in the same sequence, and some specific metadata of that Command matches with some specific metadata of the Event, then the Function Execution progresses.

For example, using an SDK's "Execute Activity" API generates the ScheduleActivityTask Command. When this API is called upon re-execution, that Command is compared with the Event that is in the same location within the sequence. The Event in the sequence must be an ActivityTaskScheduled Event, where the Activity name is the same as what is in the Command.

If a generated Command doesn't match what it needs to in the existing Event History, then the Workflow Execution returns a non-deterministic error.

The following are the two reasons why a Command might be generated out of sequence or the wrong Command might be generated altogether:

- Code changes are made to a Workflow Definition that is in use by a running Workflow Execution.
- There is intrinsic non-deterministic logic (such as inline random branching).

= Code changes can cause non-deterministic behavior

The Workflow Definition can change in very limited ways once there is a Workflow Execution depending on it. To alleviate non-deterministic issues that arise from code changes, we recommend using Workflow Versioning.

For example, let's say we have a Workflow Definition that defines the following sequence:

1. Start and wait on a Timer/sleep.
2. Spawn and wait on an Activity Execution.
3. Complete.

We start a Worker and spawn a Workflow Execution that uses that Workflow Definition. The Worker would emit the StartTimer Command and the Workflow Execution would become suspended.

Before the Timer is up, we change the Workflow Definition to the following sequence:

1. Spawn and wait on an Activity Execution.
2. Start and wait on a Timer/sleep.
3. Complete.

When the Timer fires, the next Workflow Task will cause the Workflow Function to re-execute. The first Command the Worker sees would be ScheduleActivityTask Command, which wouldn't match up to the expected TimerStarted Event.

The Workflow Execution would fail and return a non-deterministic error.

The following are examples of minor changes that would not result in non-determinism errors when re-executing a History which already contain the Events:

- Changing the duration of a Timer
- Changing the arguments to:

    * The Activity Options in a call to spawn an Activity Execution (local or nonlocal).
    * The Child Workflow Options in a call to spawn a Child Workflow Execution.
    * Call to Signal an External Workflow Execution.

- Adding a Signal Handler for a Signal Type that has not been sent to this Workflow Execution.

= Workflow Versioning

Note: not yet implemented

The Workflow Versioning feature enables the creation of logical branching inside a Workflow Definition based on a developer specified version identifier. This feature is useful for Workflow Definition logic needs to be updated, but there are running Workflow Executions that currently depends on it. It is important to note that a practical way to handle different versions of Workflow Definitions, without using the versioning API, is to run the different versions on separate Task Queues.

= Handling unreliable Worker Processes

You do not handle Worker Process failure or restarts in a Workflow Definition.

Workflow Function Executions are completely oblivious to the Worker Process in terms of failures or downtime. The Temporal Platform ensures that the state of a Workflow Execution is recovered and progress resumes if there is an outage of either Worker Processes or the Temporal Cluster itself. The only reason a Workflow Execution might fail is due to the code throwing an error or exception, not because of underlying infrastructure outages.
-}
module Temporal.Workflow (
  Workflow,
  WorkflowDefinition,
  KnownWorkflow (..),
  ProvidedWorkflow (..),
  provideWorkflow,
  Task,
  StartToClose (..),
  ScheduleToClose (..),
  These (..),

  -- * Workflow monad operations
  -- $workflowBasics

  -- ** Activity operations
  -- $activityBasics
  ActivityRef (..),
  KnownActivity (..),
  StartActivityOptions (..), -- TODO fields conflict
  ActivityCancellationType (..),
  StartActivityTimeoutOption (..),
  defaultStartActivityOptions,
  startActivity,
  executeActivity,
  StartLocalActivityOptions (..),
  defaultStartLocalActivityOptions,
  startLocalActivity,

  -- ** Child workflow operations
  -- $childWorkflow
  StartChildWorkflowOptions (..),
  defaultChildWorkflowOptions,
  WorkflowRef (..),
  startChildWorkflow,
  executeChildWorkflow,
  ChildWorkflowHandle,
  Wait (..),
  Cancel (..),
  WorkflowHandle (..),
  waitChildWorkflowResult,
  waitChildWorkflowStart,
  cancelChildWorkflowExecution,
  ExternalWorkflowHandle,
  getExternalWorkflowHandle,
  Info (..),
  RetryPolicy (..),
  defaultRetryPolicy,
  ParentInfo (..),

  -- * Workflow metadata

  --
  info,
  getMemoValues,
  lookupMemoValue,
  upsertSearchAttributes,

  -- * Versioning workflows
  -- $versioning
  patched,
  deprecatePatch,

  -- * Interacting with running Workflows

  -- ** Queries
  -- $queries
  QueryRef (..),
  Query,
  KnownQuery (..),
  setQueryHandler,

  -- ** Signals
  -- $signals
  SignalRef (..),
  KnownSignal (..),
  setSignalHandler,
  ValidSignalHandler,
  Condition,
  waitCondition,

  -- * Other utilities
  Temporal.Workflow.race,
  biselect,
  biselectOpt,
  unsafeAsyncEffectSink,

  -- * State vars
  StateVar,
  newStateVar,
  MonadReadStateVar (..),
  MonadWriteStateVar (..),

  -- * Time and timers
  now,
  time,
  sleep,
  Timer,
  createTimer,

  -- * Workflow cancellation
  isCancelRequested,
  waitCancellation,

  -- * Random value generation
  -- $randomness
  randomGen,
  uuid4,
  WorkflowGenM,

  -- * Continue as new
  ContinueAsNewOptions (..), -- TODO, fields conflict
  defaultContinueAsNewOptions,
  Temporal.Workflow.continueAsNew,

  -- * Type definitions
  GatherArgs,
  ActivityId (..),
  WorkflowId (..),
  Namespace (..),
  TaskQueue (..),
  PatchId (..),
  RunId (..),
  ParentClosePolicy (..),
  ChildWorkflowCancellationType (..),
  WorkflowIdReusePolicy (..),
  WorkflowType (..),
  RequireCallStack,
  TimeoutOptions (..),
) where

import Control.Concurrent (forkIO)
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.State
import qualified Data.ByteString.Short as SBS
import Data.Coerce
import qualified Data.HashMap.Strict as HashMap
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe
import Data.ProtoLens
import Data.Proxy
import qualified Data.Set as Set
import Data.Text (Text)
import qualified Data.Text as Text
import Data.These (These (..))
import Data.Time.Clock (UTCTime)
import Data.Time.Clock.System (SystemTime (..), systemToUTCTime)
import Data.UUID (UUID)
import qualified Data.UUID as UUID
import Data.UUID.Types.Internal (buildFromBytes)
import Data.Vector (Vector)
import qualified Data.Vector as V
import GHC.Stack
import Lens.Family2
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Payloads
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as Failure
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as ActivityResult
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as Common
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import RequireCallStack
import System.Random.Stateful
import Temporal.Activity.Definition (Activity, ActivityRef (..), KnownActivity (..), ProvidedActivity (..))
import Temporal.Common
import Temporal.Common.TimeoutType
import Temporal.Duration (Duration, durationToProto, seconds)
import Temporal.Exception
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.SearchAttributes.Internal
import Temporal.Workflow.Definition
import Temporal.Workflow.Internal.Monad
import Temporal.Workflow.Query
import Temporal.Workflow.Signal
import Temporal.Workflow.Types
import Temporal.Workflow.Unsafe.Handle
import Temporal.Workflow.WorkflowInstance
import Temporal.WorkflowInstance
import UnliftIO


-- class MonadWorkflow m where
-- startChildWorkflowFromPayloads :: forall args result. RequireCallStack => KnownWorkflow args result -> StartChildWorkflowOptions -> [IO Payload] -> m (ChildWorkflowHandle result)
-- startActivityFromPayloads :: forall args result. RequireCallStack => KnownActivity args result -> StartActivityOptions -> [IO Payload] -> m (Task result)
-- askInfo :: m Info
-- getMemoValues :: m (Map Text Payload)
-- upsertSearchAttributes :: RequireCallStack => Map Text SearchAttributeType -> m ()
-- applyPatch :: RequireCallStack => PatchId -> Bool -> m Bool
-- randomGen :: m StdGen
-- uuid4 :: m UUID
-- setQueryHandler
-- setSignalHandler
-- time
-- createTimer
-- continueAsNew
-- getExternalWorkflowHandle
-- waitCondition
-- unsafeEffectSink

newtype WorkflowInternal a = WorkflowInternal (ReaderT ContinuationEnv InstanceM a)
  deriving newtype (Functor, Applicative, Monad, MonadIO)


-- | We need a specialized version of 'withArgs' since we aren't supposed to introduce arbitrary effects in the 'Workflow' monad.
withWorkflowArgs :: forall args result codec. (VarArgs args, AllArgs (Codec codec) args) => codec -> (V.Vector Payload -> Workflow result) -> args :->: Workflow result
withWorkflowArgs c f =
  mapResult
    @args
    @(WorkflowInternal (Result result))
    @(Workflow result)
    safely
    $ withArgs @args @(WorkflowInternal (Result result)) c
    $ \args -> do
      args' <- liftIO $ sequence args
      unsafely $ f args'
  where
    unsafely :: Workflow a -> WorkflowInternal (Result a)
    unsafely = coerce
    safely :: WorkflowInternal (Result a) -> Workflow a
    safely = coerce


{- $activityBasics

An Activity is an IO-based function that executes a single, well-defined action (either short or long running),
such as calling another service, transcoding a media file, or sending an email message.
Activity code can be non-deterministic.

We recommend that it be idempotent.

Workflow code orchestrates the execution of Activities, persisting the results.
If an Activity Function Execution fails, any future execution starts from initial state (except Heartbeats).

Activity Functions are executed by Worker Processes. When the Activity Function returns,
the Worker sends the results back to the Temporal Cluster as part of the ActivityTaskCompleted Event.
The Event is added to the Workflow Execution's Event History.
-}


startActivityFromPayloads
  :: forall args result
   . RequireCallStack
  => KnownActivity args result
  -> StartActivityOptions
  -> Vector Payload
  -> Workflow (Task result)
startActivityFromPayloads (KnownActivity codec name) opts typedPayloads = ilift $ do
  runInIO <- askRunInIO
  updateCallStack
  inst <- ask
  let intercept :: ActivityInput -> (ActivityInput -> IO (Task Payload)) -> IO (Task Payload)
      intercept = inst.outboundInterceptor.scheduleActivity
  s@(Sequence actSeq) <- nextActivitySequence
  rawTask <- liftIO $ intercept (ActivityInput name typedPayloads opts s) $ \activityInput -> runInIO $ do
    resultSlot <- newIVar
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps {activities = HashMap.insert s resultSlot (activities seqMaps)}

    i <- readIORef inst.workflowInstanceInfo
    hdrs <- processorEncodePayloads inst.payloadProcessor activityInput.options.headers
    args <- processorEncodePayloads inst.payloadProcessor activityInput.args
    let actId = maybe (Text.pack $ show actSeq) rawActivityId (activityInput.options.activityId)
        scheduleActivity =
          defMessage
            & Command.seq .~ actSeq
            & Command.activityId .~ actId
            & Command.activityType .~ activityInput.activityType
            & Command.taskQueue .~ rawTaskQueue (fromMaybe i.taskQueue activityInput.options.taskQueue)
            & Command.headers .~ fmap convertToProtoPayload hdrs
            & Command.vec'arguments .~ fmap convertToProtoPayload args
            & Command.maybe'retryPolicy .~ fmap retryPolicyToProto activityInput.options.retryPolicy
            & Command.cancellationType .~ activityCancellationTypeToProto activityInput.options.cancellationType
            & Command.maybe'scheduleToStartTimeout .~ fmap durationToProto activityInput.options.scheduleToStartTimeout
            & Command.maybe'heartbeatTimeout .~ fmap durationToProto activityInput.options.heartbeatTimeout
            & \msg ->
              case activityInput.options.timeout of
                This (StartToClose t) -> msg & Command.startToCloseTimeout .~ durationToProto t
                That (ScheduleToClose t) -> msg & Command.scheduleToCloseTimeout .~ durationToProto t
                These (StartToClose stc) (ScheduleToClose stc') ->
                  msg
                    & Command.startToCloseTimeout .~ durationToProto stc
                    & Command.scheduleToCloseTimeout .~ durationToProto stc'
                & Command.doNotEagerlyExecute .~ activityInput.options.disableEagerExecution

    let cmd = defMessage & Command.scheduleActivity .~ scheduleActivity
    addCommand cmd
    pure $
      Task
        { waitAction = do
            res <- getIVar resultSlot
            $(logInfo) ("Activity result: " <> Text.pack (show res))
            Workflow $ \_ -> case res ^. Activation.result . ActivityResult.maybe'status of
              Nothing -> error "Activity result missing status"
              Just (ActivityResult.ActivityResolution'Completed success) -> do
                res <- liftIO $ payloadProcessorDecode inst.payloadProcessor $ convertFromProtoPayload (success ^. ActivityResult.result)
                pure $ case res of
                  Left err -> Throw $ toException $ ValueError err
                  Right val -> Done val
              Just (ActivityResult.ActivityResolution'Failed failure_) ->
                let failure = failure_ ^. ActivityResult.failure
                in pure $
                    Throw $
                      toException $
                        ActivityFailure
                          { message = failure ^. Failure.message
                          , activityType = ActivityType $ activityInput.activityType
                          , activityId = ActivityId actId
                          , retryState = retryStateFromProto $ failure ^. Failure.activityFailureInfo . Failure.retryState
                          , identity = failure ^. Failure.activityFailureInfo . Failure.identity
                          , cause =
                              let cause_ = failure ^. Failure.cause
                              in ApplicationFailure
                                  { type' = cause_ ^. Failure.applicationFailureInfo . Failure.type'
                                  , message = cause_ ^. Failure.message
                                  , nonRetryable = cause_ ^. Failure.applicationFailureInfo . Failure.nonRetryable
                                  , details = cause_ ^. Failure.applicationFailureInfo . Failure.details . Payloads.payloads . to (fmap convertFromProtoPayload)
                                  , stack = cause_ ^. Failure.stackTrace
                                  }
                          , scheduledEventId = failure ^. Failure.activityFailureInfo . Failure.scheduledEventId
                          , startedEventId = failure ^. Failure.activityFailureInfo . Failure.startedEventId
                          , original = failure ^. Failure.activityFailureInfo
                          , stack = Text.pack $ prettyCallStack callStack
                          }
              Just (ActivityResult.ActivityResolution'Cancelled details) -> pure $ Throw $ toException $ ActivityCancelled (details ^. ActivityResult.failure)
              Just (ActivityResult.ActivityResolution'Backoff _doBackoff) -> error "not implemented"
        , cancelAction = do
            let cancelCmd =
                  defMessage
                    & Command.requestCancelActivity
                      .~ ( defMessage
                            & Command.seq .~ actSeq
                         )
            ilift $ addCommand cancelCmd
        }
  pure
    ( rawTask
        `bindTask` ( \payload -> Workflow $ \_ -> do
                      result <- liftIO $ decode codec payload
                      case result of
                        Left err -> pure $ Throw $ toException $ ValueError err
                        Right val -> pure $ Done val
                   )
    )


startActivity
  :: forall activity
   . (RequireCallStack, ActivityRef activity)
  => activity
  -> StartActivityOptions
  -> (ActivityArgs activity :->: Workflow (Task (ActivityResult activity)))
startActivity (activityRef -> k@(KnownActivity codec _name)) opts =
  withWorkflowArgs @(ActivityArgs activity) @(Task (ActivityResult activity)) codec (startActivityFromPayloads k opts)


executeActivity
  :: forall activity
   . (RequireCallStack, ActivityRef activity)
  => activity
  -> StartActivityOptions
  -> (ActivityArgs activity :->: Workflow (ActivityResult activity))
executeActivity (activityRef -> k@(KnownActivity codec _name)) opts = withWorkflowArgs @(ActivityArgs activity) @(ActivityResult activity) codec $ \typedPayloads -> do
  -- gatherArgs (Proxy @(ActivityArgs activity)) codec id $ \typedPayloads -> do
  actHandle <- startActivityFromPayloads k opts typedPayloads
  Temporal.Workflow.Unsafe.Handle.wait actHandle


{- | A client side handle to a single Workflow instance. It can be used to signal a workflow execution.

Given the following Workflow definition:
-}
class WorkflowHandle h where
  -- | Signal a running Workflow.
  signal :: (SignalRef ref, RequireCallStack) => h result -> ref -> (SignalArgs ref :->: Workflow (Task ()))


instance WorkflowHandle ChildWorkflowHandle where
  signal h =
    signalWorkflow h (Command.childWorkflowId .~ rawWorkflowId h.childWorkflowId)


instance WorkflowHandle ExternalWorkflowHandle where
  signal h =
    signalWorkflow h (Command.workflowExecution .~ converted)
    where
      converted =
        defMessage
          & Common.workflowId .~ rawWorkflowId h.externalWorkflowWorkflowId
          & Common.runId .~ maybe "" rawRunId h.externalWorkflowRunId


-- TODO
-- & Common.namespace .~ rawNamespace h.externalNamespace

-- | A Workflow can send a Signal to another Workflow, in which case it's called an External Signal.
signalWorkflow
  :: forall result h ref
   . (RequireCallStack, SignalRef ref)
  => h result
  -> (Command.SignalExternalWorkflowExecution -> Command.SignalExternalWorkflowExecution)
  -> ref
  -> (SignalArgs ref :->: Workflow (Task ()))
signalWorkflow _ f (signalRef -> KnownSignal signalName signalCodec) = withWorkflowArgs @(SignalArgs ref) @(Task ()) signalCodec $ \ps -> do
  ilift $ do
    updateCallStack
    resVar <- newIVar
    inst <- ask
    s <- nextExternalSignalSequence
    args <- processorEncodePayloads inst.payloadProcessor ps
    let cmd =
          defMessage
            & Command.signalExternalWorkflowExecution
              .~ ( f
                    ( defMessage
                        & Command.seq .~ rawSequence s
                        & Command.signalName .~ signalName
                        & Command.vec'args .~ fmap convertToProtoPayload args
                        -- TODO
                        -- & Command.headers .~ _
                    )
                 )
    addCommand cmd
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps {externalSignals = HashMap.insert s resVar seqMaps.externalSignals}
    pure $
      Task
        { waitAction = do
            res <- getIVar resVar
            case res ^. Activation.maybe'failure of
              Nothing -> pure ()
              Just failureInfo -> throw $ SignalExternalWorkflowFailed failureInfo
        , cancelAction = do
            let cancelCmd =
                  defMessage
                    & Command.cancelSignalWorkflow
                      .~ ( defMessage
                            & Command.seq .~ rawSequence s
                         )
            ilift $ addCommand cancelCmd
        }


startChildWorkflowFromPayloads
  :: forall wf
   . (RequireCallStack, WorkflowRef wf)
  => wf
  -> StartChildWorkflowOptions
  -> Vector Payload
  -> Workflow (ChildWorkflowHandle (WorkflowResult wf))
startChildWorkflowFromPayloads (workflowRef -> k@(KnownWorkflow codec _)) opts ps = do
  wfId <- case opts.workflowId of
    Nothing -> (WorkflowId . UUID.toText) <$> uuid4
    Just wfId -> pure wfId
  ilift $ go ps wfId
  where
    go :: Vector Payload -> WorkflowId -> InstanceM (ChildWorkflowHandle (WorkflowResult wf))
    go typedPayloads wfId = do
      updateCallStack
      wfHandle <- sendChildWorkflowCommand typedPayloads wfId
      pure wfHandle
    sendChildWorkflowCommand typedPayloads wfId = do
      inst <- ask
      -- TODO these need to pass through the interceptor
      runInIO <- askRunInIO
      wfHandle <- liftIO $ inst.outboundInterceptor.startChildWorkflowExecution (knownWorkflowName k) opts $ \wfName opts' -> runInIO $ do
        args <- processorEncodePayloads inst.payloadProcessor typedPayloads
        let convertedPayloads = fmap convertToProtoPayload args
        hdrs <- processorEncodePayloads inst.payloadProcessor opts'.headers
        memo <- processorEncodePayloads inst.payloadProcessor opts'.initialMemo

        s@(Sequence wfSeq) <- nextChildWorkflowSequence
        startSlot <- newIVar
        resultSlot <- newIVar
        firstExecutionRunId <- newIVar
        i <- readIORef inst.workflowInstanceInfo
        searchAttrs <- liftIO $ searchAttributesToProto opts'.searchAttributes
        let childWorkflowOptions =
              defMessage
                & Command.seq .~ wfSeq
                & Command.namespace .~ rawNamespace i.namespace
                & Command.workflowId .~ rawWorkflowId wfId
                & Command.workflowType .~ wfName
                & Command.taskQueue .~ rawTaskQueue (fromMaybe i.taskQueue opts'.taskQueue)
                & Command.vec'input .~ convertedPayloads
                & Command.maybe'workflowExecutionTimeout .~ fmap durationToProto opts'.timeoutOptions.executionTimeout
                & Command.maybe'workflowRunTimeout .~ fmap durationToProto opts'.timeoutOptions.runTimeout
                & Command.maybe'workflowTaskTimeout .~ fmap durationToProto opts'.timeoutOptions.taskTimeout
                & Command.parentClosePolicy .~ parentClosePolicyToProto opts'.parentClosePolicy
                & Command.workflowIdReusePolicy .~ workflowIdReusePolicyToProto opts'.workflowIdReusePolicy
                & Command.maybe'retryPolicy .~ fmap retryPolicyToProto opts'.retryPolicy
                & Command.cronSchedule .~ fromMaybe "" opts'.cronSchedule
                & Command.headers .~ fmap convertToProtoPayload hdrs
                & Command.memo .~ fmap convertToProtoPayload memo
                & Command.searchAttributes .~ searchAttrs
                & Command.cancellationType .~ childWorkflowCancellationTypeToProto opts'.cancellationType

            cmd =
              defMessage
                & Command.startChildWorkflowExecution .~ childWorkflowOptions

            wfHandle =
              ChildWorkflowHandle
                { childWorkflowSequence = s
                , startHandle = startSlot
                , resultHandle = resultSlot
                , firstExecutionRunId = firstExecutionRunId
                , childWorkflowResultConverter = pure
                , childWorkflowId = wfId
                }

        atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
          seqMaps {childWorkflows = HashMap.insert s (SomeChildWorkflowHandle wfHandle) seqMaps.childWorkflows}

        addCommand cmd
        pure wfHandle
      pure $
        wfHandle
          { childWorkflowResultConverter = \r -> do
              decodingResult <- decode codec =<< either (throwIO . ValueError) pure =<< payloadProcessorDecode inst.payloadProcessor r
              case decodingResult of
                Left err -> throwIO $ ValueError err
                Right val -> pure val
          }


{- $childWorkflow

A Child Workflow Execution is a Workflow Execution that is spawned from within another Workflow.

A Workflow Execution can be both a Parent and a Child Workflow Execution because any Workflow can spawn another Workflow.
-}


{- | Start a child Workflow execution

Returns a client-side handle that implements a child Workflow interface.

By default, a child will be scheduled on the same task queue as its parent.

A child Workflow handle supports awaiting completion, signaling and cancellation via the returned handle.

In order to query the child, use a WorkflowClient from an Activity.
-}
startChildWorkflow
  :: forall wf
   . (RequireCallStack, WorkflowRef wf)
  => wf
  -> StartChildWorkflowOptions
  -> (WorkflowArgs wf :->: Workflow (ChildWorkflowHandle (WorkflowResult wf)))
startChildWorkflow (workflowRef -> k@(KnownWorkflow codec _)) opts =
  withWorkflowArgs @(WorkflowArgs wf) @(ChildWorkflowHandle (WorkflowResult wf)) codec (startChildWorkflowFromPayloads k opts)


executeChildWorkflow
  :: forall wf
   . (RequireCallStack, WorkflowRef wf)
  => wf
  -> StartChildWorkflowOptions
  -> (WorkflowArgs wf :->: Workflow (WorkflowResult wf))
executeChildWorkflow (workflowRef -> k@(KnownWorkflow codec _)) opts = withWorkflowArgs @(WorkflowArgs wf) @(WorkflowResult wf) codec $ \typedPayloads -> do
  h <- startChildWorkflowFromPayloads k opts typedPayloads
  waitChildWorkflowResult h


data StartLocalActivityOptions = StartLocalActivityOptions
  { activityId :: Maybe ActivityId
  , scheduleToCloseTimeout :: Maybe Duration
  -- ^ Indicates how long the caller is willing to wait for local activity completion. Limits how
  -- long retries will be attempted. When not specified defaults to the workflow execution
  -- timeout (which may be unset).
  , scheduleToStartTimeout :: Maybe Duration
  -- ^ Limits time the local activity can idle internally before being executed. That can happen if
  -- the worker is currently at max concurrent local activity executions. This timeout is always
  -- non retryable as all a retry would achieve is to put it back into the same queue. Defaults
  -- to `schedule_to_close_timeout` if not specified and that is set. Must be <=
  -- `schedule_to_close_timeout` when set, otherwise, it will be clamped down.
  , startToCloseTimeout :: Maybe Duration
  -- ^ Maximum time the local activity is allowed to execute after the task is dispatched. This
  -- timeout is always retryable. Either or both of `schedule_to_close_timeout` and this must be
  -- specified. If set, this must be <= `schedule_to_close_timeout`, otherwise, it will be
  -- clamped down.
  , retryPolicy :: Maybe RetryPolicy
  -- ^ Specify a retry policy for the local activity. By default local activities will be retried
  -- indefinitely.
  , localRetryThreshold :: Maybe Duration
  -- ^ If the activity is retrying and backoff would exceed this value, lang will be told to
  -- schedule a timer and retry the activity after. Otherwise, backoff will happen internally in
  -- core. Defaults to 1 minute.
  , cancellationType :: ActivityCancellationType
  -- ^ Defines how the workflow will wait (or not) for cancellation of the activity to be
  -- confirmed. Lang should default this to `WAIT_CANCELLATION_COMPLETED`, even though proto
  -- will default to `TRY_CANCEL` automatically.
  , headers :: Map Text Payload
  }


defaultStartLocalActivityOptions :: StartLocalActivityOptions
defaultStartLocalActivityOptions =
  StartLocalActivityOptions
    { activityId = Nothing
    , scheduleToCloseTimeout = Nothing
    , scheduleToStartTimeout = Nothing
    , startToCloseTimeout = Nothing
    , retryPolicy = Nothing
    , localRetryThreshold = Nothing
    , cancellationType = ActivityCancellationWaitCancellationCompleted
    , headers = mempty
    }


startLocalActivity
  :: forall act
   . (RequireCallStack, ActivityRef act)
  => act
  -> StartLocalActivityOptions
  -> (ActivityArgs act :->: Workflow (Task (ActivityResult act)))
startLocalActivity (activityRef -> KnownActivity codec n) opts = withWorkflowArgs @(ActivityArgs act) @(Task (ActivityResult act)) codec $ \typedPayloads -> do
  updateCallStackW
  originalTime <- time
  ilift $ do
    inst <- ask
    let ps = fmap convertToProtoPayload typedPayloads
    s@(Sequence actSeq) <- nextActivitySequence
    resultSlot <- newIVar
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps {activities = HashMap.insert s resultSlot (activities seqMaps)}
    -- TODO, seems like `attempt` and `originalScheduledTime`
    -- imply that we are in charge of retrying local activities ourselves?
    let actId = maybe (Text.pack $ show actSeq) rawActivityId opts.activityId
        cmd =
          defMessage
            & Command.scheduleLocalActivity
              .~ ( defMessage
                    & Command.seq .~ actSeq
                    & Command.activityId .~ actId
                    & Command.activityType .~ n
                    -- & attempt .~ _
                    -- & headers .~ _
                    & Command.originalScheduleTime .~ timespecToTimestamp originalTime
                    & Command.vec'arguments .~ ps
                    & Command.maybe'scheduleToCloseTimeout .~ (durationToProto <$> opts.scheduleToCloseTimeout)
                    & Command.maybe'scheduleToStartTimeout .~ (durationToProto <$> opts.scheduleToStartTimeout)
                    & Command.maybe'startToCloseTimeout .~ (durationToProto <$> opts.startToCloseTimeout)
                    & Command.maybe'retryPolicy .~ (retryPolicyToProto <$> opts.retryPolicy)
                    & Command.maybe'localRetryThreshold .~ (durationToProto <$> opts.localRetryThreshold)
                    & Command.cancellationType .~ activityCancellationTypeToProto opts.cancellationType
                 )
    addCommand cmd
    pure $
      Task
        { waitAction = do
            res <- getIVar resultSlot
            Workflow $ \_ -> case res ^. Activation.result . ActivityResult.maybe'status of
              Nothing -> error "Activity result missing status"
              Just (ActivityResult.ActivityResolution'Completed success) -> do
                result <- liftIO $ decode codec $ convertFromProtoPayload $ success ^. ActivityResult.result
                case result of
                  -- TODO handle properly
                  Left err -> error $ "Failed to decode activity result: " <> show err
                  Right val -> pure $ Done val
              Just (ActivityResult.ActivityResolution'Failed failure_) ->
                let failure = failure_ ^. ActivityResult.failure
                in pure $
                    Throw $
                      toException $
                        ActivityFailure
                          { message = failure ^. Failure.message
                          , activityType = ActivityType n
                          , activityId = ActivityId actId
                          , retryState = retryStateFromProto $ failure ^. Failure.activityFailureInfo . Failure.retryState
                          , identity = failure ^. Failure.activityFailureInfo . Failure.identity
                          , cause =
                              let cause_ = failure ^. Failure.cause
                              in ApplicationFailure
                                  { type' = cause_ ^. Failure.applicationFailureInfo . Failure.type'
                                  , message = cause_ ^. Failure.message
                                  , nonRetryable = cause_ ^. Failure.applicationFailureInfo . Failure.nonRetryable
                                  , details = cause_ ^. Failure.applicationFailureInfo . Failure.details . Payloads.payloads . to (fmap convertFromProtoPayload)
                                  , stack = cause_ ^. Failure.stackTrace
                                  }
                          , scheduledEventId = failure ^. Failure.activityFailureInfo . Failure.scheduledEventId
                          , startedEventId = failure ^. Failure.activityFailureInfo . Failure.startedEventId
                          , original = failure ^. Failure.activityFailureInfo
                          , stack = Text.pack $ prettyCallStack callStack
                          }
              Just (ActivityResult.ActivityResolution'Cancelled details) -> pure $ Throw $ toException $ ActivityCancelled (details ^. ActivityResult.failure)
              Just (ActivityResult.ActivityResolution'Backoff _doBackoff) -> error "not implemented"
        , cancelAction = do
            let cancelCmd =
                  defMessage
                    & Command.requestCancelLocalActivity
                      .~ ( defMessage
                            & Command.seq .~ actSeq
                         )
            ilift $ addCommand cancelCmd
        }


{- $metadata

Temporal provides a number of ways to access metadata about the current Workflow execution.

Some are useful for debugging (like 'memo', and 'upsertSearchAttributes'), and some are useful for
making decisions about how to proceed (like using 'info' to decide whether to continue-as-new).
-}


{- | We recommend calling 'info' whenever accessing 'Info' fields. Some 'Info' fields change during the lifetime of an Execution—
like historyLength and searchAttributes— and some may be changeable in the future— like taskQueue.
-}
info :: Workflow Info
info = askInstance >>= (\m -> Workflow $ \_ -> Done <$> m) . readIORef . workflowInstanceInfo


-- (ask >>= readIORef) workflowInstanceInfo <$> askInstance

-- | Current workflow's raw memo values.
getMemoValues :: Workflow (Map Text Payload)
getMemoValues = do
  details <- info
  pure details.rawMemo


-- | Lookup a memo value by key.
lookupMemoValue :: Text -> Workflow (Maybe Payload)
lookupMemoValue k = do
  memoMap <- getMemoValues
  pure $ Map.lookup k memoMap


{- | Updates this Workflow's Search Attributes by merging the provided searchAttributes with the existing Search Attributes

Using this function will overwrite any existing Search Attributes with the same key.
-}
upsertSearchAttributes :: RequireCallStack => Map Text SearchAttributeType -> Workflow ()
upsertSearchAttributes values = ilift $ do
  updateCallStack
  attrs <- liftIO $ traverse (fmap convertToProtoPayload . encode JSON) values
  let cmd =
        defMessage
          & Command.upsertWorkflowSearchAttributes
            .~ ( defMessage
                  & Command.searchAttributes .~ attrs
               )
  addCommand cmd
  inst <- ask
  modifyIORef' inst.workflowInstanceInfo $ \Info {..} ->
    Info {searchAttributes = searchAttributes <> values, ..}


{- | Current time from the workflow perspective.

The time returned is updated only when the workflow performs an
operation in the Workflow monad that blocks. Examples of such operations
are 'sleep', 'awaitCondition', 'awaitActivity', 'awaitWorkflow', etc.

Equivalent to `getCurrentTime` from the `time` package.
-}
now :: Workflow UTCTime
now = Workflow $ \_ ->
  Done <$> do
    wft <- workflowTime <$> ask
    t <- readIORef wft
    pure $! systemToUTCTime t


{- $versioning

Versioning (known as "patching" in the Haskell library) lets you update Workflow Definitions
without causing non-deterministic behavior in current long-running Workflows.

You may need to patch if:

- You want to change the remaining logic of a Workflow while it is still running
- If your new logic can result in a different execution path
-}


applyPatch :: RequireCallStack
  => PatchId
  -> Bool
  -- ^ whether the patch is deprecated
  -> Workflow Bool
applyPatch pid deprecated = ilift $ do
  updateCallStack
  inst <- ask
  memoized <- readIORef inst.workflowMemoizedPatches
  case HashMap.lookup pid memoized of
    Just val -> pure val
    Nothing -> do
      isReplaying <- readIORef inst.workflowIsReplaying
      notifiedPatches <- readIORef inst.workflowNotifiedPatches
      let usePatch = not isReplaying || Set.member pid notifiedPatches
      writeIORef inst.workflowMemoizedPatches $ HashMap.insert pid usePatch memoized
      when usePatch $ do
        addCommand $
          defMessage
            & Command.setPatchMarker .~ (defMessage & Command.patchId .~ rawPatchId pid & Command.deprecated .~ deprecated)
      pure usePatch


{- | Patch or upgrade workflow code by checking or stating that this workflow has a certain patch.

See official Temporal docs page for info.

If the workflow is replaying an existing history, then this function returns true if that history
was produced by a worker which also had a patched call with the same patchId.

If the history was produced by a worker without such a call, then it will return false.

If the workflow is not currently replaying, then this call always returns true.

Your workflow code should run the "new" code if this returns true, if it returns false,
you should run the "old" code. By doing this, you can maintain determinism.
-}
patched :: RequireCallStack => PatchId -> Workflow Bool
patched pid = do
  updateCallStackW
  applyPatch pid False


{- | Indicate that a patch is being phased out.

See official Temporal docs page for info.

Workflows with this call may be deployed alongside workflows with a patched call, but they must not be deployed while any workers
still exist running old code without a patched call, or any runs with histories produced by such workers exist.
If either kind of worker encounters a history produced by the other, their behavior is undefined.

Once all live workflow runs have been produced by workers with this call, you can deploy workers which are free of either kind of
patch call for this ID. Workers with and without this call may coexist, as long as they are both running the "new" code.
-}
deprecatePatch :: RequireCallStack => PatchId -> Workflow ()
deprecatePatch pid = do
  updateCallStackW
  void $ applyPatch pid True


{- $randomness

Workflow executions are deterministic, so you can't use the usual IO-based random number generation.

Instead, each workflow execution is given a seed from the Temporal platform to seed a PRNG. This
allows you to generate random values in a deterministic way.

The 'Workflow' monad provides a 'RandomGen' instance, so you can use the usual 'random' and 'randomR'
functions from the 'System.Random' and 'System.Random.Stateful' modules.
-}


-- | Get a mutable randomness generator for the workflow.
randomGen :: Workflow WorkflowGenM
randomGen = workflowRandomnessSeed <$> askInstance


{- | Generate an RFC compliant V4 uuid.

Uses the workflow's deterministic PRNG, making it safe for use within a workflow.

This function is cryptographically insecure.
-}
uuid4 :: Workflow UUID
uuid4 = do
  wft <- workflowRandomnessSeed <$> askInstance
  sbs <- uniformShortByteString 16 wft
  pure $
    buildFromBytes
      4
      (sbs `SBS.index` 0x0)
      (sbs `SBS.index` 0x1)
      (sbs `SBS.index` 0x2)
      (sbs `SBS.index` 0x3)
      (sbs `SBS.index` 0x4)
      (sbs `SBS.index` 0x5)
      (sbs `SBS.index` 0x6)
      (sbs `SBS.index` 0x7)
      (sbs `SBS.index` 0x8)
      (sbs `SBS.index` 0x9)
      (sbs `SBS.index` 0xA)
      (sbs `SBS.index` 0xB)
      (sbs `SBS.index` 0xC)
      (sbs `SBS.index` 0xD)
      (sbs `SBS.index` 0xE)
      (sbs `SBS.index` 0xF)


{- $queries

A Query is a synchronous operation that is used to get the state of a Workflow Execution.
The state of a running Workflow Execution is constantly changing.
You can use Queries to expose the internal Workflow Execution state to the external world.
Queries are available for running or completed Workflows Executions only if the Worker is
up and listening on the Task Queue.

Queries are strongly consistent and are guaranteed to return the most recent state.
This means that the data reflects the state of all confirmed Events that came in before
the Query was sent. An Event is considered confirmed if the call creating the Event returned
success. Events that are created while the Query is outstanding may or may not be reflected
in the Workflow state the Query result is based on.

A Query can carry arguments to specify the data it is requesting. And each Workflow can expose data to multiple types of Queries.

A Query cannot mutate the state of the Workflow Execution— that is, Queries are read-only and cannot contain any blocking code.
This means, for example, that Query handling logic cannot schedule Activity Executions.
-}


{- | Register a query handler.

The handler will be called when a query with the given name is received.
-}
setQueryHandler
  :: forall query f
   . ( QueryRef query
     , f ~ (QueryArgs query :->: Query (QueryResult query))
     , RequireCallStack
     )
  => query
  -> f
  -> Workflow ()
setQueryHandler (queryRef -> KnownQuery n codec) f = ilift $ do
  updateCallStack
  inst <- ask
  withRunInIO $ \runInIO -> do
    liftIO $ modifyIORef' inst.workflowQueryHandlers $ \handles ->
      HashMap.insert (Just n) (\qId vec hdrs -> runInIO $ qHandler qId vec hdrs) handles
  where
    qHandler :: QueryId -> Vector Payload -> Map Text Payload -> InstanceM (Either SomeException Payload)
    qHandler (QueryId _) vec _ = do
      eHandler <-
        liftIO $
          applyPayloads
            codec
            (Proxy @(QueryArgs query))
            (Proxy @(Query (QueryResult query)))
            f
            vec
      -- TODO handle exceptions properly
      case eHandler of
        Left err -> pure $ Left $ toException $ ValueError err
        Right (Query r) -> do
          eResult <- UnliftIO.try r
          case eResult of
            Left err -> pure $ Left err
            Right result -> liftIO $ UnliftIO.try $ encode codec result


type ValidSignalHandler f =
  ( ResultOf Workflow f ~ ()
  , (ArgsOf f :->: Workflow ()) ~ f
  )


setSignalHandler
  :: forall f ref
   . ( ValidSignalHandler f
     , RequireCallStack
     , SignalRef ref
     , ArgsOf f ~ SignalArgs ref
     )
  => ref
  -> f
  -> Workflow ()
setSignalHandler (signalRef -> KnownSignal n codec) f = ilift $ do
  updateCallStack
  -- TODO ^ inner callstack?
  inst <- ask
  liftIO $ modifyIORef' inst.workflowSignalHandlers $ \handlers ->
    HashMap.insert (Just n) handle' handlers
  where
    handle' :: Vector Payload -> Workflow ()
    handle' = \vec -> do
      eWorkflow <- Workflow $ \_env ->
        liftIO $
          fmap Done $
            applyPayloads
              codec
              (Proxy @(ArgsOf f))
              (Proxy @(Workflow ()))
              f
              vec
      case eWorkflow of
        Left err -> throw $ ValueError err
        Right w -> w


{- | Current time from the workflow perspective.

The value is relative to epoch time.
-}
time :: RequireCallStack => Workflow SystemTime
time = ilift $ do
  updateCallStack
  wft <- workflowTime <$> ask
  readIORef wft


data Timer = Timer
  { timerSequence :: Sequence
  , timerHandle :: IVar ()
  }


{- | Asynchronous sleep.

Creates a timer that fires after the specified duration.

The timer is not guaranteed to fire immediately after the duration expires,
but it is intended to fire as close to the expiration as possible.

Note that the timer is started when the command is received by the Temporal Platform,
not when the timer is created. The command is sent as soon as the workflow is blocked
by any operation, such as 'sleep', 'awaitCondition', 'awaitActivity', 'awaitWorkflow', etc.
-}
createTimer :: RequireCallStack => Duration -> Workflow Timer
createTimer ts = ilift $ do
  updateCallStack
  inst <- ask
  s@(Sequence seqId) <- nextTimerSequence
  let cmd =
        defMessage
          & Command.startTimer
            .~ ( defMessage
                  & Command.seq .~ seqId
                  & Command.startToFireTimeout .~ durationToProto ts
               )
  $(logDebug) "Add command: sleep"
  res <- newIVar
  atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
    seqMaps {timers = HashMap.insert s res seqMaps.timers}
  addCommand cmd
  pure $ Timer {timerSequence = s, timerHandle = res}


sleep :: RequireCallStack => Duration -> Workflow ()
sleep ts = do
  updateCallStackW
  t <- createTimer ts
  Temporal.Workflow.Unsafe.Handle.wait t


instance Wait Timer where
  type WaitResult Timer = Workflow ()
  wait = getIVar . timerHandle


instance Cancel Timer where
  type CancelResult Timer = Workflow ()


  cancel t = Workflow $ \_ -> do
    updateCallStack
    inst <- ask
    let cmd =
          defMessage
            & Command.cancelTimer
              .~ ( defMessage
                    & Command.seq .~ rawSequence (timerSequence t)
                 )
    addCommand cmd
    $(logDebug) "about to putIVar: cancelTimer"
    liftIO $
      putIVar
        t.timerHandle
        (Ok ())
        inst.workflowInstanceContinuationEnv

    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps {timers = HashMap.delete t.timerSequence seqMaps.timers}

    $(logDebug) "finished putIVar: cancelTimer"
    pure $ Done ()


{- | Continue-As-New is a mechanism by which the latest relevant state is passed to a new Workflow Execution, with a fresh Event History.

As a precautionary measure, the Temporal Platform limits the total Event History to 51,200 Events or 50 MB, and will warn you after
10,240 Events or 10 MB. To prevent a Workflow Execution Event History from exceeding this limit and failing,
use Continue-As-New to start a new Workflow Execution with a fresh Event History.

All values passed to a Workflow Execution through parameters or returned through a result value are recorded into the Event History.
A Temporal Cluster stores the full Event History of a Workflow Execution for the duration of a Namespace's retention period.
A Workflow Execution that periodically executes many Activities has the potential of hitting the size limit.

A very large Event History can adversely affect the performance of a Workflow Execution. For example, in the case of a Workflow Worker failure,
the full Event History must be pulled from the Temporal Cluster and given to another Worker via a Workflow Task.
If the Event history is very large, it may take some time to load it.

The Continue-As-New feature enables developers to complete the current Workflow Execution and start a new one atomically.

The new Workflow Execution has the same Workflow Id, but a different Run Id, and has its own Event History.
TODO, don't make this an exception, make it a return value
-}
continueAsNew
  :: forall wf
   . WorkflowRef wf
  => wf
  -- ^ The workflow to continue as new. It doesn't have to be the same as the current workflow.
  -> ContinueAsNewOptions
  -> (WorkflowArgs wf :->: Workflow (WorkflowResult wf))
continueAsNew (workflowRef -> k@(KnownWorkflow codec _)) opts = withWorkflowArgs @(WorkflowArgs wf) @(WorkflowResult wf) codec $ \args -> do
  i <- info
  Workflow $ \_ -> do
    inst <- ask
    res <- liftIO $ (Temporal.Workflow.Internal.Monad.continueAsNew inst.outboundInterceptor) (knownWorkflowName k) opts $ \wfName (opts' :: ContinueAsNewOptions) -> do
      -- searchAttrs <- searchAttributesToProto
      --     (if opts'.searchAttributes == mempty
      --       then i.searchAttributes
      --       else opts'.searchAttributes)
      throwIO $ ContinueAsNewException (WorkflowType wfName) args opts'
    pure $ Done res


-- | Returns a client-side handle that can be used to signal and cancel an existing Workflow execution. It takes a Workflow ID and optional run ID.
getExternalWorkflowHandle :: RequireCallStack => WorkflowId -> Maybe RunId -> Workflow (ExternalWorkflowHandle result)
getExternalWorkflowHandle wfId mrId = do
  updateCallStackW
  pure $
    ExternalWorkflowHandle
      { externalWorkflowWorkflowId = wfId
      , externalWorkflowRunId = mrId
      }


{- | Wait on a condition to become true before continuing.

This must be used with signals, steps executed concurrently via the Applicative instance,
or with the `race` command, as those are the only way for
state to change in a workflow while a portion of the workflow itself is
in this blocking condition.

N.B. this should be used with care, as it can lead to the workflow
suspending indefinitely if the condition is never met.
(e.g. if there is no signal handler that changes the state appropriately)
-}
waitCondition :: RequireCallStack => Condition Bool -> Workflow ()
waitCondition c@(Condition m) = do
  updateCallStackW
  (conditionSatisfied, touchedVars) <- ilift $ do
    sRef <- newIORef mempty
    sat <- runReaderT m sRef
    (,) <$> pure sat <*> readIORef sRef
  if conditionSatisfied
    then pure ()
    else go touchedVars
  where
    -- When blocked, the condition needs to be rechecked every time a signal is received
    -- or a new resolutions are received from a workflow activation.
    go touchedVars = do
      blockedVar <- ilift $ do
        inst <- ask
        res <- newIVar
        conditionSeq <- nextConditionSequence
        atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
          seqMaps
            { conditionsAwaitingSignal = HashMap.insert conditionSeq (res, touchedVars) seqMaps.conditionsAwaitingSignal
            }
        pure res
      -- Wait for the condition to be signaled. Once signalled, we just try again.
      -- writeStateVar and friends are in charge of filling the ivar and clearing out the seqmaps between rechecks
      getIVar blockedVar
      waitCondition c


{- | While workflows are deterministic, there are categories of operational concerns (metrics, logging, tracing, etc.) that require
access to IO operations like the network or filesystem. The 'IO' monad is not generally available in the 'Workflow' monad, but you
can use 'sink' to run an 'IO' action in a workflow. In order to maintain determinism, the operation will be executed asynchronously
and does not return a value. Be sure that the sink operation terminates, or else you will leak memory and/or threads.

Do not use 'sink' for any Workflow logic, or else you will violate determinism.
-}
unsafeAsyncEffectSink :: RequireCallStack => IO () -> Workflow ()
unsafeAsyncEffectSink m = do
  updateCallStackW
  ilift $ liftIO $ void $ forkIO m


-- -----------------------------------------------------------------------------
-- Parallel operations

biselect
  :: RequireCallStack
  => Workflow (Either a b)
  -> Workflow (Either a c)
  -> Workflow (Either a (b, c))
biselect wfA wfB = biselectOpt id id Left Right wfA wfB


{-# INLINE biselectOpt #-}
biselectOpt
  :: RequireCallStack
  => (l -> Either a b)
  -> (r -> Either a c)
  -> (a -> t)
  -> ((b, c) -> t)
  -> Workflow l
  -> Workflow r
  -> Workflow t
biselectOpt discrimA discrimB left right wfL wfR =
  let go (Workflow wfA) (Workflow wfB) = Workflow $ \env -> do
        ra <- wfA env
        case ra of
          Done ea ->
            case discrimA ea of
              Left a -> return (Done (left a))
              Right b -> do
                rb <- wfB env
                case rb of
                  Done eb ->
                    case discrimB eb of
                      Left a -> return (Done (left a))
                      Right c -> return (Done (right (b, c)))
                  Throw e -> return (Throw e)
                  Blocked ib wfB' ->
                    return
                      ( Blocked
                          ib
                          (wfB' :>>= \b' -> goRight b b')
                      )
          Throw e -> return (Throw e)
          Blocked ia wfA' -> do
            rb <- wfB env
            case rb of
              Done eb ->
                case discrimB eb of
                  Left a -> return (Done (left a))
                  Right c ->
                    return (Blocked ia (wfA' :>>= \a' -> goLeft a' c))
              Throw e -> return (Throw e)
              Blocked ib wfB' -> do
                i <- newIVar
                addJob env (return ()) i ia
                addJob env (return ()) i ib
                return (Blocked i (Cont (go (toWf wfA') (toWf wfB'))))
      -- The code above makes sure that the computation
      -- wakes up whenever either 'ia' or 'ib' is filled.
      -- The ivar 'i' is used as a synchronisation point
      -- for the whole computation, and we make sure that
      -- whenever 'ia' or 'ib' are filled in then 'i' will
      -- also be filled.

      goRight b eb =
        case discrimB eb of
          Left a -> return (left a)
          Right c -> return (right (b, c))
      goLeft ea c =
        case discrimA ea of
          Left a -> return (left a)
          Right b -> return (right (b, c))
  in go wfL wfR


{- | This function takes two Workflow computations as input, and returns the
output of whichever computation finished first.
-}
race
  :: RequireCallStack
  => Workflow a
  -> Workflow b
  -> Workflow (Either a b)
race x y = biselectOpt discrimX discrimY id right x y
  where
    discrimX :: a -> Either (Either a b) ()
    discrimX a = Left (Left a)

    discrimY :: b -> Either (Either a b) ()
    discrimY b = Left (Right b)

    right _ = error "race: We should never have a 'Right ()'"


{-
=== state vars ===

Since state vars await cause Conditions to await, we need a way to track whether they have
been updated since the condition suspended. We give each statevar a unique identifier for
lookups, and a sequence number that updates for each write to the IORef.
-}

{- | 'Workflow's may be sent a cancellation request from the Temporal Platform,
but Workflow code is not required to respond to the cancellation request.

In order to opt in to cancellation handling, you can call 'isCancelRequested'
periodically within your workflow code to check whether a cancellation request
has been received.
-}
isCancelRequested :: RequireCallStack => Workflow Bool
isCancelRequested = do
  updateCallStackW
  inst <- askInstance
  res <- tryReadIVar inst.workflowCancellationVar
  case res of
    Nothing -> pure False
    Just () -> pure True


{- | Block the current workflow's main execution thread until the workflow is cancelled.

The workflow can still respond to signals and queries while waiting for cancellation.

Upon cancellation, the workflow will throw a 'WorkflowCancelRequested' exception.

This function is useful for actor-style workflows that perform work in response to signals
and/or respond to queries, but otherwise need to remain idle on their main codepath.

N.B. It is likely not safe to call this in a signal handler.
-}
waitCancellation :: RequireCallStack => Workflow ()
waitCancellation = do
  updateCallStackW
  inst <- askInstance
  getIVar inst.workflowCancellationVar
  throw WorkflowCancelRequested


defaultRetryPolicy :: RetryPolicy
defaultRetryPolicy =
  RetryPolicy
    { initialInterval = seconds 1
    , backoffCoefficient = 2
    , maximumInterval = Nothing
    , maximumAttempts = 0
    , nonRetryableErrorTypes = mempty
    }

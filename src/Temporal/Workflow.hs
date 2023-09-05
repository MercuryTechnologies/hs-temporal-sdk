{-| Workflows

This module provides the core functionality for defining functions that can be
executed as Temporal workflows.

> import Temporal.Workflow

Workflow code must be deterministic. This means:

- no threading
- no randomness
- no external calls to processes
- no network I/O
- no global state mutation
- no system date or time

This might seem like a lot of restrictions, but Temporal provides a number of
functions that allow you to use similar functionality in a deterministic way.

A critical aspect of developing Workflow Definitions is ensuring they exhibit certain deterministic traits –
that is, making sure that the same Commands are emitted in the same sequence,
whenever a corresponding Workflow Function Execution (instance of the Function Definition) is re-executed.
-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Workflow 
  ( Workflow
  , WorkflowDefinition
  , KnownWorkflow(..)
  , ProvidedWorkflow(..)
  , provideWorkflow
  , Task
  , TimeoutType(..)
  -- * Workflow monad operations
  -- $workflowBasics

  -- ** Activity operations
  -- $activityBasics
  , ActivityRef(..)
  , KnownActivity(..)
  , StartActivityOptions(..)
  , defaultStartActivityOptions
  , startActivity
  , executeActivity
  , StartLocalActivityOptions(..)
  , startLocalActivity
  -- ** Child workflow operations
  -- $childWorkflow
  , StartChildWorkflowOptions(..)
  , defaultChildWorkflowOptions
  , WorkflowRef(..)
  , startChildWorkflow
  , executeChildWorkflow
  , ChildWorkflowHandle
  , ExternalWorkflowHandle
  , Wait(..)
  , Cancel(..)
  , WorkflowHandle(..)
  , waitChildWorkflowResult
  , waitChildWorkflowStart
  , cancelChildWorkflowExecution
  , Info(..)
  , RetryPolicy(..)
  , ParentInfo(..)
  -- * Workflow metadata
  -- 
  , info
  , getMemoValues
  , lookupMemoValue
  , upsertSearchAttributes
  -- * Versioning workflows
  -- $versioning
  , patched
  , deprecatePatch
  -- * Interacting with running Workflows
  -- ** Queries
  -- $queries
  , QueryDefinition(..)
  , setQueryHandler
  -- ** Signals
  -- $signals
  , SignalRef(..)
  , SignalDefinition(..)
  , setSignalHandler
  , waitCondition
  -- * Other utilities
  , Temporal.Workflow.race
  , unsafeAsyncEffectSink
  -- * State vars
  , StateVar
  , newStateVar
  , MonadReadStateVar(..)
  , MonadWriteStateVar(..)
  -- * Time and timers
  , now
  , time
  , sleep
  , Timer
  , createTimer
  -- * Workflow cancellation
  , isCancelRequested
  , waitCancellation
  -- * Random value generation
  -- $randomness
  , randomGen
  , uuid4
  , WorkflowGenM
  -- * Continue as new
  , ContinueAsNewOptions(..)
  , defaultContinueAsNewOptions
  , continueAsNew
  -- * Type definitions
  , GatherArgs
  , ActivityId(..)
  , WorkflowId(..)
  , Namespace(..)
  , TaskQueue(..)
  , PatchId(..)
  , RunId(..)
  , ParentClosePolicy(..)
  , ChildWorkflowCancellationType(..)
  , WorkflowIdReusePolicy(..)
  , WorkflowType(..)
  , RequireCallStack
  ) where
import Control.Concurrent (forkIO)
import Control.Monad
import Control.Monad.State
import Control.Monad.Logger
import Control.Monad.Reader
import qualified Data.ByteString.Short as SBS
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe
import Data.ProtoLens
import Data.Proxy
import qualified Data.Set as Set
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Time.Clock (UTCTime)
import Data.Time.Clock.System (SystemTime(..), systemToUTCTime)
import Data.Kind
import Data.UUID (UUID)
import Data.UUID.Types.Internal ( buildFromBytes )
import Data.Vector (Vector)
import Lens.Family2
import Proto.Temporal.Api.Common.V1.Message (Payload)
import RequireCallStack
import System.Random.Stateful
import Temporal.Common
import Temporal.Exception
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.Worker.Types
import Temporal.Workflow.Unsafe
import Temporal.WorkflowInstance
import Temporal.Workflow.WorkflowInstance
import Temporal.Workflow.WorkflowDefinition
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as Common
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow_Fields as ChildWorkflow
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import UnliftIO
import Temporal.Duration (Duration, durationToProto)

-- | An async action handle that can be awaited or cancelled.
data Task a = Task 
  { waitAction :: Workflow a
  , cancelAction :: Workflow ()
  }

ilift :: RequireCallStack => InstanceM a -> Workflow a
ilift m = Workflow $ \_ -> Done <$> m

askInstance :: Workflow WorkflowInstance
askInstance = Workflow $ \_ -> Done <$> ask

data ContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue :: Maybe TaskQueue
  , runTimeout :: Maybe Duration
  , taskTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , memo :: Map Text RawPayload
  , searchAttributes :: Map Text SearchAttributeType
  , headers :: Map Text RawPayload
  }

defaultContinueAsNewOptions :: ContinueAsNewOptions
defaultContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue = Nothing
  , runTimeout = Nothing
  , taskTimeout = Nothing
  , retryPolicy = Nothing
  , memo = mempty
  , searchAttributes = mempty
  , headers = mempty
  }

data StartActivityOptions = StartActivityOptions
  { activityId :: Maybe ActivityId
  , taskQueue :: Maybe TaskQueue
  , timeout :: TimeoutType
  , scheduleToStartTimeout :: Maybe Duration
  , heartbeatTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , cancellationType :: ActivityCancellationType
  , headers :: Map Text RawPayload -- TODO payloads
  , disableEagerExecution :: Bool
  }

defaultStartActivityOptions :: TimeoutType -> StartActivityOptions
defaultStartActivityOptions t = StartActivityOptions
  { activityId = Nothing
  , taskQueue = Nothing
  , timeout = t
  , scheduleToStartTimeout = Nothing
  , heartbeatTimeout = Nothing
  , retryPolicy = Nothing
  , cancellationType = ActivityCancellationTryCancel
  , headers = mempty
  , disableEagerExecution = False
  }

data TimeoutType 
  = StartToClose Duration 
  | ScheduleToClose Duration
  | StartToCloseAndScheduleToClose Duration Duration

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


data KnownActivity (args :: [Type]) (result :: Type) = forall codec. 
  ( Codec codec result
  , GatherArgs codec args
  , Typeable result
  ) => KnownActivity
        { knownActivityCodec :: codec
        , knownActivityQueue :: Maybe TaskQueue
        , knownActivityName :: Text
        }

class ActivityRef (f :: Type) where
  type ActivityArgs f :: [Type]
  type ActivityResult f :: Type
  activityRef :: f -> KnownActivity (ActivityArgs f) (ActivityResult f)

instance ActivityRef (KnownActivity args result) where
  type ActivityArgs (KnownActivity args result) = args
  type ActivityResult (KnownActivity args result) = result
  activityRef = id

startActivityFromPayloads 
  :: forall args result. RequireCallStack 
  => KnownActivity args result 
  -> StartActivityOptions 
  -> [IO RawPayload] 
  -> Workflow (Task result)
startActivityFromPayloads (KnownActivity codec mTaskQueue name) opts typedPayloads = ilift $ do
  updateCallStack
  inst <- ask
  ps <- traverse (fmap convertToProtoPayload . liftIO) typedPayloads

  s@(Sequence actSeq) <- nextActivitySequence
  resultSlot <- newIVar
  atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
    seqMaps { activities = HashMap.insert s resultSlot (activities seqMaps) }

  info <- readIORef inst.workflowInstanceInfo
  let scheduleActivity = defMessage
        & Command.seq .~ actSeq
        & Command.activityId .~ maybe (Text.pack $ show actSeq) rawActivityId (opts.activityId)
        & Command.activityType .~ name
        & Command.taskQueue .~ rawTaskQueue (fromMaybe info.taskQueue mTaskQueue)
        & Command.headers .~ fmap convertToProtoPayload opts.headers
        & Command.arguments .~ ps
        & Command.maybe'retryPolicy .~ fmap retryPolicyToProto opts.retryPolicy
        & Command.cancellationType .~ activityCancellationTypeToProto opts.cancellationType
        & Command.maybe'scheduleToStartTimeout .~ fmap durationToProto opts.scheduleToStartTimeout
        & Command.maybe'heartbeatTimeout .~ fmap durationToProto opts.heartbeatTimeout
        & \msg -> case opts.timeout of
          StartToClose t -> msg & Command.startToCloseTimeout .~ durationToProto t
          ScheduleToClose t -> msg & Command.scheduleToCloseTimeout .~ durationToProto t
          StartToCloseAndScheduleToClose stc stc' -> msg 
            & Command.startToCloseTimeout .~ durationToProto stc
            & Command.scheduleToCloseTimeout .~ durationToProto stc'
        & Command.doNotEagerlyExecute .~ opts.disableEagerExecution

  let cmd = defMessage & Command.scheduleActivity .~ scheduleActivity
  addCommand cmd
  pure $ Task 
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
        Just (ActivityResult.ActivityResolution'Failed failure) -> pure $ Throw $ toException $ ActivityFailed (failure ^. ActivityResult.failure)
        Just (ActivityResult.ActivityResolution'Cancelled details) -> pure $ Throw $ toException $ ActivityCancelled (details ^. ActivityResult.failure)
        Just (ActivityResult.ActivityResolution'Backoff doBackoff) -> error "not implemented"
    , cancelAction = do
      let cancelCmd = defMessage
            & Command.requestCancelActivity .~ 
              ( defMessage
                & Command.seq .~ actSeq
              )
      ilift $ addCommand cancelCmd
    }

startActivity 
  :: forall activity. (RequireCallStack, ActivityRef activity)
  => activity
  -> StartActivityOptions 
  -> (ActivityArgs activity :->: Workflow (Task (ActivityResult activity)))
startActivity activity opts = case activityRef activity of
  k@(KnownActivity codec mTaskQueue name) -> 
    gatherActivityArgs @(ActivityArgs activity) @(ActivityResult activity) codec (startActivityFromPayloads k opts)

executeActivity
  ::forall activity. (RequireCallStack, ActivityRef activity)
  => activity
  -> StartActivityOptions 
  -> (ActivityArgs activity :->: Workflow (ActivityResult activity))
executeActivity activity opts = case activityRef activity of
  k@(KnownActivity codec mTaskQueue name) -> 
    gatherArgs (Proxy @(ActivityArgs activity)) codec id $ \typedPayloads -> do
      actHandle <- startActivityFromPayloads k opts typedPayloads
      Temporal.Workflow.wait actHandle

gatherActivityArgs 
  :: forall args result codec. GatherArgs codec args
  => codec 
  -> ([IO RawPayload] -> Workflow (Task result)) 
  -> (args :->: Workflow (Task result))
gatherActivityArgs c f = gatherArgs (Proxy @args) c id f

data StartChildWorkflowOptions = StartChildWorkflowOptions 
  { cancellationType :: ChildWorkflowCancellationType
  , parentClosePolicy :: ParentClosePolicy
  , executionTimeout :: Maybe Duration
  , runTimeout :: Maybe Duration
  , taskTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , cronSchedule :: Maybe Text
  , initialMemo :: Map Text Proto.Temporal.Api.Common.V1.Message.Payload
  , searchAttributes :: Map Text SearchAttributeType 
  , headers :: Map Text Proto.Temporal.Api.Common.V1.Message.Payload
  , workflowIdReusePolicy :: WorkflowIdReusePolicy
  }

defaultChildWorkflowOptions :: StartChildWorkflowOptions
defaultChildWorkflowOptions = StartChildWorkflowOptions
  { cancellationType = ChildWorkflowCancellationAbandon
  , parentClosePolicy = ParentClosePolicyUnspecified
  , executionTimeout = Nothing
  , runTimeout = Nothing
  , taskTimeout = Nothing
  , retryPolicy = Nothing
  , cronSchedule = Nothing
  , initialMemo = mempty
  , searchAttributes = mempty
  , headers = mempty
  , workflowIdReusePolicy = WorkflowIdReusePolicyUnspecified
  }

class Wait h where
  type WaitResult h :: Type
  -- | Wait for a handle on an an action to complete.
  wait :: RequireCallStack => h -> WaitResult h

instance Wait (Task a) where
  type WaitResult (Task a) = Workflow a
  wait t = do
    updateCallStackW
    t.waitAction

instance Wait (ChildWorkflowHandle a) where
  type WaitResult (ChildWorkflowHandle a) = Workflow a
  wait h = waitChildWorkflowResult h

class Cancel h where
  type CancelResult h :: Type
  -- | Signal to Temporal that a handle representing an async action should be cancelled.
  cancel :: RequireCallStack => h -> CancelResult h

instance Cancel (Task a) where
  type CancelResult (Task a) = Workflow ()
  cancel t = do
    updateCallStackW
    t.cancelAction

instance Cancel (ChildWorkflowHandle a) where
  type CancelResult (ChildWorkflowHandle a) = Workflow ()
  cancel h = do
    updateCallStackW
    cancelChildWorkflowExecution h

instance Cancel (ExternalWorkflowHandle a) where
  type CancelResult (ExternalWorkflowHandle a) = Workflow (Workflow ())

  -- | Returns an action that can be used to await cancellation of an external workflow.
  --
  -- Throws 'CancelExternalWorkflowFailed' if the cancellation request failed.
  cancel h = ilift $ do
    inst <- ask
    s@(Sequence sVal) <- nextExternalSignalSequence
    res <- newIVar
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps { externalSignals = HashMap.insert s res (externalSignals seqMaps) }
    addCommand 
      (defMessage 
        & Command.requestCancelExternalWorkflowExecution .~ 
          ( defMessage 
            & Command.seq .~ sVal
            & Command.workflowExecution .~ 
              ( defMessage 
                & Common.workflowId .~ rawWorkflowId h.externalWorkflowWorkflowId
                & Common.runId .~ maybe "" rawRunId h.externalWorkflowRunId
              )
          )
      )
    pure $ do
      res' <- getIVar res
      case res' ^. Activation.maybe'failure of
        Nothing -> pure ()
        Just f -> throw $ CancelExternalWorkflowFailed f

-- | Handle representing an external Workflow Execution.
--
-- This handle can only be cancelled and signalled. 
--
-- To call other methods, like query and result, use a WorkflowClient.getHandle inside an Activity.
data ExternalWorkflowHandle (result :: Type) = ExternalWorkflowHandle
  { externalWorkflowWorkflowId :: WorkflowId
  , externalWorkflowRunId :: Maybe RunId
  }

-- | A client side handle to a single Workflow instance. It can be used to signal a workflow execution.
--
-- Given the following Workflow definition:
class WorkflowHandle h where
  -- | Signal a running Workflow.
  signal :: RequireCallStack => h result -> SignalDefinition args -> (args :->: Workflow (Task ()))

instance WorkflowHandle ChildWorkflowHandle where
  signal h =
    signalWorkflow h (Command.childWorkflowId .~ rawWorkflowId h.childWorkflowId)

instance WorkflowHandle ExternalWorkflowHandle where
  signal h =
    signalWorkflow h (Command.workflowExecution .~ converted)
    where
      converted = defMessage
        & Common.workflowId .~ rawWorkflowId h.externalWorkflowWorkflowId
        & Common.runId .~ maybe "" rawRunId h.externalWorkflowRunId
        -- TODO
        -- & Common.namespace .~ rawNamespace h.externalNamespace

signalWorkflow 
  :: forall args result h. RequireCallStack
  => h result
  -> (Command.SignalExternalWorkflowExecution -> Command.SignalExternalWorkflowExecution)
  -> SignalDefinition args
  -> (args :->: Workflow (Task ()))
signalWorkflow _ f (SignalDefinition (SignalRef signalName signalCodec) signalApply) = gatherSignalChildWorkflowArgs @args @() signalCodec $ \ps -> do
  ilift $ do
    updateCallStack
    resVar <- newIVar
    inst <- ask
    s <- nextExternalSignalSequence
    args <- liftIO $ traverse (fmap convertToProtoPayload) ps
    let cmd = defMessage
          & Command.signalExternalWorkflowExecution .~
            ( f 
              ( defMessage
                & Command.seq .~ rawSequence s
                & Command.signalName .~ signalName 
                & Command.args .~ args
              -- TODO
              -- & Command.headers .~ _
              )
            )
    addCommand cmd
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps { externalSignals = HashMap.insert s resVar seqMaps.externalSignals }
    pure $ Task 
      { waitAction = do
          res <- getIVar resVar
          case res ^. Activation.maybe'failure of
            Nothing -> pure ()
            Just f -> throw $ SignalExternalWorkflowFailed f
      , cancelAction = do
          let cancelCmd = defMessage 
                & Command.cancelSignalWorkflow .~ 
                  ( defMessage 
                    & Command.seq .~ rawSequence s
                  )
          ilift $ addCommand cancelCmd
      }

gatherSignalChildWorkflowArgs 
  :: forall args result codec. GatherArgs codec args
  => codec 
  -> ([IO RawPayload] -> Workflow (Task result)) 
  -> (args :->: Workflow (Task result))
gatherSignalChildWorkflowArgs c f = gatherArgs (Proxy @args) c id f


startChildWorkflowFromPayloads :: forall args result. RequireCallStack => KnownWorkflow args result -> StartChildWorkflowOptions -> WorkflowId -> [IO RawPayload] -> Workflow (ChildWorkflowHandle result)
startChildWorkflowFromPayloads k@(KnownWorkflow codec mNamespace mTaskQueue _) opts wfId = ilift . go
  where
    go :: [IO RawPayload] -> InstanceM (ChildWorkflowHandle result)
    go typedPayloads = do
      updateCallStack
      args <- liftIO $ sequence typedPayloads
      wfHandle <- sendChildWorkflowCommand args
      pure wfHandle
    sendChildWorkflowCommand typedPayloads = do
      inst <- ask
      let ps =  fmap convertToProtoPayload typedPayloads
      
      s@(Sequence wfSeq) <- nextChildWorkflowSequence
      startSlot <- newIVar
      resultSlot <- newIVar
      firstExecutionRunId <- newIVar
      info <- readIORef inst.workflowInstanceInfo
      searchAttrs <- liftIO $ searchAttributesToProto opts.searchAttributes
      let childWorkflowOptions = defMessage
            & Command.seq .~ wfSeq
            & Command.namespace .~ rawNamespace (fromMaybe info.namespace mNamespace)
            & Command.workflowId .~ rawWorkflowId wfId
            & Command.workflowType .~ knownWorkflowName k
            & Command.taskQueue .~ rawTaskQueue (fromMaybe info.taskQueue mTaskQueue)
            & Command.input .~ ps
            & Command.maybe'workflowExecutionTimeout .~ fmap durationToProto opts.executionTimeout
            & Command.maybe'workflowRunTimeout .~ fmap durationToProto opts.runTimeout
            & Command.maybe'workflowTaskTimeout .~ fmap durationToProto opts.taskTimeout
            & Command.parentClosePolicy .~ parentClosePolicyToProto opts.parentClosePolicy
            & Command.workflowIdReusePolicy .~ workflowIdReusePolicyToProto opts.workflowIdReusePolicy
            & Command.maybe'retryPolicy .~ fmap retryPolicyToProto opts.retryPolicy
            & Command.cronSchedule .~ fromMaybe "" opts.cronSchedule
            & Command.headers .~ opts.headers
            & Command.memo .~ opts.initialMemo
            & Command.searchAttributes .~ searchAttrs
            & Command.cancellationType .~ childWorkflowCancellationTypeToProto opts.cancellationType

          cmd = defMessage 
            & Command.startChildWorkflowExecution .~ childWorkflowOptions
        
          wfHandle = ChildWorkflowHandle 
            { childWorkflowSequence = s
            , startHandle = startSlot 
            , resultHandle = resultSlot
            , firstExecutionRunId = firstExecutionRunId
            , childWorkflowCodec = codec
            , childWorkflowId = wfId
            }

      atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
        seqMaps { childWorkflows = HashMap.insert s (SomeChildWorkflowHandle wfHandle) seqMaps.childWorkflows }

      $(logDebug) "Add command: startChildWorkflowExecution"
      addCommand cmd
      pure wfHandle

-- $childWorkflow
--
-- A Child Workflow Execution is a Workflow Execution that is spawned from within another Workflow.
--
-- A Workflow Execution can be both a Parent and a Child Workflow Execution because any Workflow can spawn another Workflow.

-- | Start a child Workflow execution
--
-- Returns a client-side handle that implements a child Workflow interface.
--
-- By default, a child will be scheduled on the same task queue as its parent.
--
-- A child Workflow handle supports awaiting completion, signaling and cancellation via the returned handle.
--
-- In order to query the child, use a WorkflowClient from an Activity.
startChildWorkflow 
  :: forall args result. RequireCallStack
  => KnownWorkflow args result
  -> StartChildWorkflowOptions
  -> WorkflowId
  -> (args :->: Workflow (ChildWorkflowHandle result))
startChildWorkflow k@(KnownWorkflow codec mNamespace mTaskQueue _) opts wfId =
  gatherStartChildWorkflowArgs @args @result codec (startChildWorkflowFromPayloads k opts wfId)

waitChildWorkflowStart :: RequireCallStack => ChildWorkflowHandle result -> Workflow ()
waitChildWorkflowStart wfHandle = do
  updateCallStackW
  getIVar wfHandle.startHandle

waitChildWorkflowResult :: RequireCallStack => ChildWorkflowHandle result -> Workflow result
waitChildWorkflowResult wfHandle@(ChildWorkflowHandle{childWorkflowCodec}) = do
  updateCallStackW
  $(logDebug) "Wait child workflow result"
  res <- getIVar wfHandle.resultHandle
  case res ^. Activation.result . ChildWorkflow.maybe'status of
    Nothing -> ilift $ throwIO $ RuntimeError "Unrecognized child workflow result status"
    Just s -> case s of
      ChildWorkflow.ChildWorkflowResult'Completed res -> do
        eVal <- ilift $ liftIO $ decode childWorkflowCodec $ convertFromProtoPayload $ res ^. ChildWorkflow.result
        case eVal of
          Left err -> throw $ ValueError err
          Right ok -> pure ok
      ChildWorkflow.ChildWorkflowResult'Failed res -> throw $ ChildWorkflowFailed $ res ^. ChildWorkflow.failure
      ChildWorkflow.ChildWorkflowResult'Cancelled _ -> throw ChildWorkflowCancelled

executeChildWorkflow
  :: forall args result. RequireCallStack
  => KnownWorkflow args result
  -> StartChildWorkflowOptions
  -> WorkflowId
  -> (args :->: Workflow result)
executeChildWorkflow k@(KnownWorkflow codec mNamespace mTaskQueue _) opts wfId = gatherArgs (Proxy @args) codec id $ \typedPayloads -> do
  h <- startChildWorkflowFromPayloads k opts wfId typedPayloads
  waitChildWorkflowResult h

cancelChildWorkflowExecution :: RequireCallStack => ChildWorkflowHandle result -> Workflow ()
cancelChildWorkflowExecution wfHandle@(ChildWorkflowHandle{childWorkflowSequence}) = ilift $ do
  updateCallStack
  -- I don't see a way to block on this? I guess Temporal wants us to rely on the orchestrator
  -- managing the cancellation. Compare with ResolveRequestCancelExternalWorkflow. I think
  -- external workflows need a resolution step because they may not even exist.
  addCommand $ defMessage 
    & Command.cancelChildWorkflowExecution .~ 
      ( defMessage 
        & Command.childWorkflowSeq .~ rawSequence childWorkflowSequence
      )

data StartLocalActivityOptions = StartLocalActivityOptions 
  { activityId :: Maybe ActivityId
  -- | Indicates how long the caller is willing to wait for local activity completion. Limits how
  -- long retries will be attempted. When not specified defaults to the workflow execution
  -- timeout (which may be unset).
  , scheduleToCloseTimeout :: Maybe Duration
  -- | Limits time the local activity can idle internally before being executed. That can happen if
  -- the worker is currently at max concurrent local activity executions. This timeout is always
  -- non retryable as all a retry would achieve is to put it back into the same queue. Defaults
  -- to `schedule_to_close_timeout` if not specified and that is set. Must be <=
  -- `schedule_to_close_timeout` when set, otherwise, it will be clamped down.
  , scheduleToStartTimeout :: Maybe Duration
  -- | Maximum time the local activity is allowed to execute after the task is dispatched. This
  -- timeout is always retryable. Either or both of `schedule_to_close_timeout` and this must be
  -- specified. If set, this must be <= `schedule_to_close_timeout`, otherwise, it will be
  -- clamped down. 
  , startToCloseTimeout :: Maybe Duration
  -- | Specify a retry policy for the local activity. By default local activities will be retried
  -- indefinitely.
  , retryPolicy :: Maybe RetryPolicy
  -- | If the activity is retrying and backoff would exceed this value, lang will be told to
  -- schedule a timer and retry the activity after. Otherwise, backoff will happen internally in
  -- core. Defaults to 1 minute.
  , localRetryThreshold :: Maybe Duration
  -- | Defines how the workflow will wait (or not) for cancellation of the activity to be
  -- confirmed. Lang should default this to `WAIT_CANCELLATION_COMPLETED`, even though proto
  -- will default to `TRY_CANCEL` automatically.
  , cancellationType :: ActivityCancellationType
  , headers :: Map Text RawPayload
  }

defaultStartLocalActivityOptions :: StartLocalActivityOptions
defaultStartLocalActivityOptions = StartLocalActivityOptions
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
  :: forall args result. RequireCallStack
  => KnownActivity args result
  -> StartLocalActivityOptions 
  -> (args :->: Workflow (Task result))
startLocalActivity (KnownActivity codec _ n) opts = gatherActivityArgs  @args @result codec $ \typedPayloads -> do
  updateCallStackW
  originalTime <- time
  ilift $ do
    inst <- ask
    ps <- liftIO $ traverse (fmap convertToProtoPayload) typedPayloads
    s@(Sequence actSeq) <- nextActivitySequence
    resultSlot <- newIVar
    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps { activities = HashMap.insert s resultSlot (activities seqMaps) }
    -- TODO, seems like `attempt` and `originalScheduledTime`
    -- imply that we are in charge of retrying local activities ourselves?
    let cmd = defMessage 
          & Command.scheduleLocalActivity .~
            ( defMessage
              & Command.seq .~ actSeq
              & Command.activityId .~ maybe (Text.pack $ show actSeq) rawActivityId opts.activityId
              & Command.activityType .~ n
              -- & attempt .~ _
              -- & headers .~ _
              & Command.originalScheduleTime .~ timespecToTimestamp originalTime
              & Command.arguments .~ ps
              & Command.maybe'scheduleToCloseTimeout .~ (durationToProto <$> opts.scheduleToCloseTimeout)
              & Command.maybe'scheduleToStartTimeout .~ (durationToProto <$> opts.scheduleToStartTimeout)
              & Command.maybe'startToCloseTimeout .~ (durationToProto <$> opts.startToCloseTimeout)
              & Command.maybe'retryPolicy .~ (retryPolicyToProto <$> opts.retryPolicy)
              & Command.maybe'localRetryThreshold .~ (durationToProto <$> opts.localRetryThreshold)
              & Command.cancellationType .~ activityCancellationTypeToProto opts.cancellationType
            )
    addCommand cmd
    pure $ Task 
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
          Just (ActivityResult.ActivityResolution'Failed failure) -> pure $ Throw $ toException $ ActivityFailed (failure ^. ActivityResult.failure)
          Just (ActivityResult.ActivityResolution'Cancelled details) -> pure $ Throw $ toException $ ActivityCancelled (details ^. ActivityResult.failure)
          Just (ActivityResult.ActivityResolution'Backoff doBackoff) -> error "not implemented"
      , cancelAction = do
        let cancelCmd = defMessage
              & Command.requestCancelLocalActivity .~ 
                ( defMessage
                  & Command.seq .~ actSeq
                )
        ilift $ addCommand cancelCmd
      }

-- $metadata
--
-- Temporal provides a number of ways to access metadata about the current Workflow execution.
--
-- Some are useful for debugging (like 'memo', and 'upsertSearchAttributes'), and some are useful for
-- making decisions about how to proceed (like using 'info' to decide whether to continue-as-new).

-- | We recommend calling 'info' whenever accessing 'Info' fields. Some 'Info' fields change during the lifetime of an Execution—
-- like historyLength and searchAttributes— and some may be changeable in the future— like taskQueue.
info :: Workflow Info
info = askInstance >>= (\m -> Workflow $ \_ -> Done <$> m) . readIORef . workflowInstanceInfo
--(ask >>= readIORef) workflowInstanceInfo <$> askInstance

-- | Current workflow's raw memo values.
getMemoValues :: Workflow (Map Text RawPayload)
getMemoValues = do
  details <- info
  pure details.rawMemo

-- | Lookup a memo value by key.
lookupMemoValue :: Text -> Workflow (Maybe RawPayload)
lookupMemoValue k = do
  memoMap <- getMemoValues
  pure $ Map.lookup k memoMap


-- | Updates this Workflow's Search Attributes by merging the provided searchAttributes with the existing Search Attributes
--
-- Using this function will overwrite any existing Search Attributes with the same key.
upsertSearchAttributes :: RequireCallStack => Map Text SearchAttributeType -> Workflow ()
upsertSearchAttributes values = ilift $ do
  updateCallStack
  attrs <- liftIO $ traverse (fmap convertToProtoPayload . encode JSON) values
  let cmd = defMessage & Command.upsertWorkflowSearchAttributes .~ 
        ( defMessage
          & Command.searchAttributes .~ attrs
        )
  addCommand cmd
  inst <- ask
  modifyIORef' inst.workflowInstanceInfo $ \(info :: Info) ->
    (info { searchAttributes = info.searchAttributes <> values } :: Info)
  where

-- | Current time from the workflow perspective.
--
-- The time returned is updated only when the workflow performs an
-- operation in the Workflow monad that blocks. Examples of such operations
-- are 'sleep', 'awaitCondition', 'awaitActivity', 'awaitWorkflow', etc.
--
-- Equivalent to `getCurrentTime` from the `time` package.
now :: Workflow UTCTime
now = Workflow $ \_ -> Done <$> do
  wft <- workflowTime <$> ask
  t <- readIORef wft
  pure $! systemToUTCTime t

-- $versioning
--
-- Versioning (known as "patching" in the Haskell library) lets you update Workflow Definitions 
-- without causing non-deterministic behavior in current long-running Workflows.
--
-- You may need to patch if:
--
-- - You want to change the remaining logic of a Workflow while it is still running
-- - If your new logic can result in a different execution path
applyPatch :: RequireCallStack => PatchId -> Bool {- ^ whether the patch is deprecated -} -> Workflow Bool 
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
        addCommand $ defMessage & 
          Command.setPatchMarker .~ (defMessage & Command.patchId .~ rawPatchId pid & Command.deprecated .~ deprecated)
      pure usePatch

-- | Patch or upgrade workflow code by checking or stating that this workflow has a certain patch.
--
-- See official Temporal docs page for info.
--
-- If the workflow is replaying an existing history, then this function returns true if that history 
-- was produced by a worker which also had a patched call with the same patchId. 
--
--If the history was produced by a worker without such a call, then it will return false.
--
-- If the workflow is not currently replaying, then this call always returns true.
--
-- Your workflow code should run the "new" code if this returns true, if it returns false, 
-- you should run the "old" code. By doing this, you can maintain determinism.
patched :: RequireCallStack => PatchId -> Workflow Bool
patched pid = do
  updateCallStackW
  applyPatch pid False

-- | Indicate that a patch is being phased out.
--
-- See official Temporal docs page for info.
--
-- Workflows with this call may be deployed alongside workflows with a patched call, but they must not be deployed while any workers 
-- still exist running old code without a patched call, or any runs with histories produced by such workers exist. 
-- If either kind of worker encounters a history produced by the other, their behavior is undefined.
--
-- Once all live workflow runs have been produced by workers with this call, you can deploy workers which are free of either kind of 
-- patch call for this ID. Workers with and without this call may coexist, as long as they are both running the "new" code.
deprecatePatch :: RequireCallStack => PatchId -> Workflow ()
deprecatePatch pid = do
  updateCallStackW
  void $ applyPatch pid True

-- $randomness
--
-- Workflow executions are deterministic, so you can't use the usual IO-based random number generation.
--
-- Instead, each workflow execution is given a seed from the Temporal platform to seed a PRNG. This
-- allows you to generate random values in a deterministic way.
--
-- The 'Workflow' monad provides a 'RandomGen' instance, so you can use the usual 'random' and 'randomR'
-- functions from the 'System.Random' and 'System.Random.Stateful' modules.

-- | Get a mutable randomness generator for the workflow.
randomGen :: Workflow WorkflowGenM
randomGen = workflowRandomnessSeed <$> askInstance

-- | Generate an RFC compliant V4 uuid. 
--
-- Uses the workflow's deterministic PRNG, making it safe for use within a workflow.
--
-- This function is cryptographically insecure.
uuid4 :: Workflow UUID
uuid4 = do
  wft <- workflowRandomnessSeed <$> askInstance
  sbs <- uniformShortByteString 16 wft
  pure $ buildFromBytes 4
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


newtype Query a = Query (InstanceM a)
  deriving (Functor, Applicative, Monad)

-- $queries
-- 
-- A Query is a synchronous operation that is used to get the state of a Workflow Execution. 
-- The state of a running Workflow Execution is constantly changing. 
-- You can use Queries to expose the internal Workflow Execution state to the external world. 
-- Queries are available for running or completed Workflows Executions only if the Worker is 
-- up and listening on the Task Queue.
--
-- Queries are strongly consistent and are guaranteed to return the most recent state. 
-- This means that the data reflects the state of all confirmed Events that came in before 
-- the Query was sent. An Event is considered confirmed if the call creating the Event returned 
-- success. Events that are created while the Query is outstanding may or may not be reflected 
-- in the Workflow state the Query result is based on.
--
-- A Query can carry arguments to specify the data it is requesting. And each Workflow can expose data to multiple types of Queries.
--
-- A Query cannot mutate the state of the Workflow Execution— that is, Queries are read-only and cannot contain any blocking code. 
-- This means, for example, that Query handling logic cannot schedule Activity Executions.

-- | Register a query handler.
--
-- The handler will be called when a query with the given name is received.
setQueryHandler :: forall f result.
  ( ResultOf Query f ~ result
  , f ~ (ArgsOf f :->: Query result)
  , RequireCallStack
  ) => QueryDefinition (ArgsOf f) result -> f -> Workflow ()
setQueryHandler (QueryDefinition n codec) f = ilift $ do
  updateCallStack
  inst <- ask
  withRunInIO $ \runInIO -> do
    liftIO $ modifyIORef' inst.workflowQueryHandlers $ \handles ->
      HashMap.insert (Just n) (\qId vec -> runInIO $ handle qId vec) handles
  where
    handle :: QueryId -> Vector RawPayload -> InstanceM ()
    handle (QueryId qId) vec = do
      eHandler <- liftIO $ applyPayloads 
            codec 
            (Proxy @(ArgsOf f))
            (Proxy @(Query (ResultOf Query f))) 
            f 
            vec
      -- TODO handle exceptions properly
      case eHandler of
        Left err -> throwIO $ ValueError err
        Right (Query r) -> do
          inst <- ask
          eResult <- UnliftIO.try $ fmap (encode codec) r
          commandResult <- case eResult of
            Left (SomeException err) ->
              pure $ Command.failed .~ 
                ( defMessage
                  & F.message .~ Text.pack (show err)
                  -- TODO, protobuf docs aren't clear on what this should be
                  & F.source .~ "haskell"
                  -- TODO, annotated exceptions might be needed for this
                  & F.stackTrace .~ ""
                  -- TODO encoded attributes
                  -- & F.encodedAttributes .~ _
                  -- & F.cause .~ _
                  & F.activityFailureInfo .~
                    ( defMessage
                  --   -- & F.scheduledEventId .~ _
                  --   -- & F.startedEventId .~ _
                    -- & WF.identity .~ (identity $ clientConfig c.clientCore)
                    )
                  --   & F.activityType .~ (defMessage & P.name .~ info.activityType)
                  --   & F.activityId .~ (msg ^. AT.activityId)
                  --   -- & F.retryState .~ _
                  -- )
                )
            Right resultM -> do
              result <- liftIO resultM
              pure $ Command.succeeded .~ (defMessage & Command.response .~ convertToProtoPayload result)
          let cmd = defMessage
                & Command.respondToQuery .~
                  ( defMessage
                    & Command.queryId .~ qId
                    & commandResult
                  )
          addCommand cmd
          
type ValidSignalHandler f = 
  ( ResultOf Workflow f ~ ()
  , (ArgsOf f :->: Workflow ()) ~ f
  )

setSignalHandler :: forall f.
  ( ValidSignalHandler f
  , RequireCallStack
  ) => SignalRef (ArgsOf f) -> f -> Workflow ()
setSignalHandler (SignalRef n codec) f = ilift $ do
  updateCallStack
  -- TODO ^ inner callstack?
  inst <- ask
  withRunInIO $ \runInIO -> do
    liftIO $ modifyIORef' inst.workflowSignalHandlers $ \handlers -> 
      HashMap.insert (Just n) handle handlers
  where
    handle :: Vector RawPayload -> Workflow ()
    handle = \vec ->  do
      eWorkflow <- Workflow $ \env -> liftIO $ fmap Done $ applyPayloads 
        codec
        (Proxy @(ArgsOf f))
        (Proxy @(Workflow ()))
        f
        vec
      case eWorkflow of
        Left err -> throw $ ValueError err 
        Right w -> w

-- | Current time from the workflow perspective.
--
-- The value is relative to epoch time.
time :: RequireCallStack => Workflow SystemTime
time = ilift $ do
  updateCallStack
  wft <- workflowTime <$> ask
  readIORef wft

data Timer = Timer
  { timerSequence :: Sequence
  , timerHandle :: IVar ()
  }

-- | Asynchronous sleep.
--
-- Creates a timer that fires after the specified duration.
--
-- The timer is not guaranteed to fire immediately after the duration expires,
-- but it is intended to fire as close to the expiration as possible.
--
-- Note that the timer is started when the command is received by the Temporal Platform,
-- not when the timer is created. The command is sent as soon as the workflow is blocked
-- by any operation, such as 'sleep', 'awaitCondition', 'awaitActivity', 'awaitWorkflow', etc.
createTimer :: RequireCallStack => Duration -> Workflow Timer
createTimer ts = ilift $ do
  updateCallStack
  inst <- ask
  s@(Sequence seqId) <- nextTimerSequence
  let cmd = defMessage & Command.startTimer .~ 
        ( defMessage 
          & Command.seq .~ seqId
          & Command.startToFireTimeout .~ durationToProto ts
        )
  $(logDebug) "Add command: sleep"
  res <- newIVar
  atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
    seqMaps { timers = HashMap.insert s res seqMaps.timers }
  addCommand cmd
  pure $ Timer { timerSequence = s, timerHandle = res }

sleep :: RequireCallStack => Duration -> Workflow ()
sleep ts = do
  updateCallStackW
  t <- createTimer ts
  Temporal.Workflow.wait t

instance Wait Timer where
  type WaitResult Timer = Workflow ()
  wait = getIVar . timerHandle

instance Cancel Timer where
  type CancelResult Timer = Workflow ()

  cancel t = Workflow $ \env -> do
    updateCallStack
    inst <- ask
    let cmd = defMessage & Command.cancelTimer .~ 
          ( defMessage 
            & Command.seq .~ rawSequence (timerSequence t)
          )
    addCommand cmd
    $(logDebug) "about to putIVar: cancelTimer"
    liftIO $ putIVar 
      t.timerHandle 
      (Ok ()) 
      inst.workflowInstanceContinuationEnv

    atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
      seqMaps { timers = HashMap.delete t.timerSequence seqMaps.timers }

    $(logDebug) "finished putIVar: cancelTimer"
    pure $ Done ()


gatherContinueAsNewArgs 
  :: forall args result codec. GatherArgs codec args
  => codec 
  -> ([IO RawPayload] -> Workflow result) 
  -> (args :->: Workflow result)
gatherContinueAsNewArgs c f = gatherArgs (Proxy @args) c id f

-- | Continue-As-New is a mechanism by which the latest relevant state is passed to a new Workflow Execution, with a fresh Event History.
--
-- As a precautionary measure, the Temporal Platform limits the total Event History to 51,200 Events or 50 MB, and will warn you after 
-- 10,240 Events or 10 MB. To prevent a Workflow Execution Event History from exceeding this limit and failing, 
-- use Continue-As-New to start a new Workflow Execution with a fresh Event History.
--
-- All values passed to a Workflow Execution through parameters or returned through a result value are recorded into the Event History. 
-- A Temporal Cluster stores the full Event History of a Workflow Execution for the duration of a Namespace's retention period. 
-- A Workflow Execution that periodically executes many Activities has the potential of hitting the size limit.
--
-- A very large Event History can adversely affect the performance of a Workflow Execution. For example, in the case of a Workflow Worker failure, 
-- the full Event History must be pulled from the Temporal Cluster and given to another Worker via a Workflow Task. 
-- If the Event history is very large, it may take some time to load it.
--
-- The Continue-As-New feature enables developers to complete the current Workflow Execution and start a new one atomically.
--
-- The new Workflow Execution has the same Workflow Id, but a different Run Id, and has its own Event History.
-- TODO, don't make this an exception, make it a return value
continueAsNew 
  :: forall wf. WorkflowRef wf
  => wf
  -- ^ The workflow to continue as new. It doesn't have to be the same as the current workflow.
  -> ContinueAsNewOptions 
  -> (WorkflowArgs wf :->: Workflow (WorkflowResult wf))
continueAsNew wf opts = case workflowRef wf of
  k@(KnownWorkflow codec _ _ _) -> gatherContinueAsNewArgs @(WorkflowArgs wf) @(WorkflowResult wf) codec $ \args -> do
    i <- info
    Workflow $ \_ -> do
      searchAttrs <- liftIO $ searchAttributesToProto 
          (if opts.searchAttributes == mempty
            then i.searchAttributes
            else opts.searchAttributes)
      args <- liftIO $ traverse (fmap convertToProtoPayload) args
      throwIO $ ContinueAsNewException $ defMessage
        & Command.workflowType .~ knownWorkflowName k
        & Command.taskQueue .~ (maybe "" rawTaskQueue opts.taskQueue)
        & Command.arguments .~ args
        & Command.maybe'retryPolicy .~ (retryPolicyToProto <$> opts.retryPolicy)
        & Command.searchAttributes .~ searchAttrs
        & Command.headers .~ fmap convertToProtoPayload opts.headers
        & Command.memo .~ fmap convertToProtoPayload opts.memo
        & Command.maybe'workflowTaskTimeout .~ (durationToProto <$> opts.taskTimeout)
        & Command.maybe'workflowRunTimeout .~ (durationToProto <$> opts.runTimeout)

-- | Returns a client-side handle that can be used to signal and cancel an existing Workflow execution. It takes a Workflow ID and optional run ID.
getExternalWorkflowHandle :: RequireCallStack => WorkflowId -> Maybe RunId -> Workflow (ExternalWorkflowHandle result)
getExternalWorkflowHandle wfId mrId = do
  updateCallStackW
  pure $ ExternalWorkflowHandle
    { externalWorkflowWorkflowId = wfId
    , externalWorkflowRunId = mrId
    }

newtype Condition a = Condition 
  { unCondition :: InstanceM a
  -- ^ We track the sequence number of each accessed StateVar so that we can
  -- block and retry the condition evaluation if the state changes.
  }
  deriving (Functor, Applicative, Monad)

instance MonadReadStateVar Condition where
  readStateVar StateVar{..} = Condition $ readIORef ref

-- | Wait on a condition to become true before continuing.
--
-- This must be used with signals, steps executed concurrently via the Applicative instance,
-- or with the `race` command, as those are the only way for
-- state to change in a workflow while a portion of the workflow itself is
-- in this blocking condition.
--
-- N.B. this should be used with care, as it can lead to the workflow
-- suspending indefinitely if the condition is never met. 
-- (e.g. if there is no signal handler that changes the state appropriately)
waitCondition :: RequireCallStack => Condition Bool -> Workflow ()
waitCondition (Condition m) = do
  updateCallStackW
  conditionSatisfied <- ilift m
  if conditionSatisfied
    then pure ()
    else go
  where
    -- When blocked, the condition needs to be re-evaluated every time a signal is received
    -- or a new resolutions are received from a workflow activation.
    go = do
      (conditionSeq, blockedVar) <- ilift $ do
        inst <- ask
        res <- newIVar
        conditionSeq <- nextConditionSequence
        atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
          seqMaps { conditionsAwaitingSignal = HashMap.insert conditionSeq res seqMaps.conditionsAwaitingSignal }
        pure (conditionSeq, res)
      -- Wait for the condition to be signaled.
      getIVar blockedVar
      -- Delete the condition from the map so that it doesn't leak memory.
      conditionSatisfied <- ilift $ do
        inst <- ask
        atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
          seqMaps { conditionsAwaitingSignal = HashMap.delete conditionSeq seqMaps.conditionsAwaitingSignal }
        m
      if conditionSatisfied
        then pure ()
        else go

-- | While workflows are deterministic, there are categories of operational concerns (metrics, logging, tracing, etc.) that require
-- access to IO operations like the network or filesystem. The 'IO' monad is not generally available in the 'Workflow' monad, but you 
-- can use 'sink' to run an 'IO' action in a workflow. In order to maintain determinism, the operation will be executed asynchronously 
-- and does not return a value. Be sure that the sink operation terminates, or else you will leak memory and/or threads.
--
-- Do not use 'sink' for any Workflow logic, or else you will violate determinism.
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
                        Right c -> return (Done (right (b,c)))
                    Throw e -> return (Throw e)
                    Blocked ib wfB' ->
                      return (Blocked ib
                              (wfB' :>>= \b' -> goRight b b'))
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

-- | This function takes two Workflow computations as input, and returns the
-- output of whichever computation finished first.
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


newtype StateVar a = StateVar
  { ref :: IORef a
  }

newStateVar :: a -> Workflow (StateVar a)
newStateVar a = Workflow $ \_ -> (Done . StateVar) <$> newIORef a

class MonadReadStateVar m where
  readStateVar :: StateVar a -> m a

class MonadWriteStateVar m where
  writeStateVar :: StateVar a -> a -> m ()
  modifyStateVar :: StateVar a -> (a -> a) -> m ()

instance MonadReadStateVar Workflow where
  readStateVar (StateVar ref) = Workflow $ \_ -> Done <$> readIORef ref

instance MonadWriteStateVar Workflow where
  writeStateVar (StateVar ref) a = Workflow $ \_ -> Done <$> writeIORef ref a
  modifyStateVar (StateVar ref) f = Workflow $ \_ -> Done <$> modifyIORef' ref f

instance MonadReadStateVar Query where
  readStateVar (StateVar ref) = Query $ readIORef ref

isCancelRequested :: RequireCallStack => Workflow Bool
isCancelRequested = do
  updateCallStackW
  inst <- askInstance
  res <- tryReadIVar inst.workflowCancellationVar
  case res of
    Nothing -> pure False
    Just () -> pure True

-- | Block the current workflow's main execution thread until the workflow is cancelled.
--
-- The workflow can still respond to signals and queries while waiting for cancellation.
--
-- Upon cancellation, the workflow will throw a 'WorkflowCancelRequested' exception.
waitCancellation :: RequireCallStack => Workflow ()
waitCancellation = do
  updateCallStackW
  inst <- askInstance
  getIVar inst.workflowCancellationVar
  throw WorkflowCancelRequested
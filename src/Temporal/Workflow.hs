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
  , KnownActivity(..)
  , StartActivityOptions(..)
  , defaultStartActivityOptions
  , startActivity
  , StartLocalActivityOptions(..)
  , startLocalActivity
  -- ** Child workflow operations
  -- $childWorkflow
  , StartChildWorkflowOptions(..)
  , defaultChildWorkflowOptions
  , startChildWorkflow
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
  , memo
  , memoValue
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
  , SignalDefinition(..)
  -- , setSignalHandler
  , waitCondition
  -- , waitCancellation
  -- * Other utilities
  , Temporal.Workflow.race
  , unsafeAsyncEffectSink
  -- * Time and timers
  , now
  , time
  , sleep
  , Timer
  , createTimer
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
  , IsValidWorkflowFunction
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
import Control.Applicative
import Control.Monad
import Control.Monad.State
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.IO.Class
import qualified Data.Aeson
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Short as SBS
import Data.Functor.Compose
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import qualified Data.HashMap.Strict as HashMap
import Data.Maybe
import Data.ProtoLens
import Data.Proxy
import qualified Data.Set as Set
import Data.Text (Text)
import Data.Type.Equality
import qualified Data.Text as Text
import Data.Time.Clock (UTCTime)
import Data.Time.Clock.System (SystemTime(..), systemToUTCTime)
import Data.Kind
import Data.UUID (UUID)
import Data.UUID.Types.Internal ( buildFromBytes )
import Data.Word (Word32)
import Data.Vector (Vector)
import GHC.Stack
import GHC.TypeLits
import Lens.Family2
import Proto.Temporal.Api.Common.V1.Message (Payload)
import RequireCallStack
import System.Clock (TimeSpec(..))
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
import qualified Temporal.Core.Client as Core
import qualified Proto.Temporal.Sdk.Core.Common.Common_Fields as Common
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands as Command
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow_Fields as ChildWorkflow
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import UnliftIO

-- | An async action handle that can be awaited or cancelled.
data Task env st a = Task 
  { waitAction :: Workflow env st a
  , cancelAction :: Workflow env st ()
  }

ilift :: RequireCallStack => InstanceM env st a -> Workflow env st a
ilift m = Workflow $ \_ -> Done <$> m

askInstance :: Workflow env st (WorkflowInstance env st)
askInstance = Workflow $ \_ -> Done <$> ask

data ContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue :: Maybe TaskQueue
  , runTimeout :: Maybe TimeSpec
  , taskTimeout :: Maybe TimeSpec
  , retryPolicy :: Maybe RetryPolicy
  -- , TODO memo :: 
  -- , TODO searchAttributes :: Maybe (Map Text Payload)
  -- , TODO headers
  }

defaultContinueAsNewOptions :: ContinueAsNewOptions
defaultContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue = Nothing
  , runTimeout = Nothing
  , taskTimeout = Nothing
  , retryPolicy = Nothing
  }

data StartActivityOptions = StartActivityOptions
  { activityId :: Maybe ActivityId
  , taskQueue :: Maybe TaskQueue
  , timeout :: TimeoutType
  , scheduleToStartTimeout :: Maybe TimeSpec
  , heartbeatTimeout :: Maybe TimeSpec
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
  = StartToClose TimeSpec 
  | ScheduleToClose TimeSpec
  | StartToCloseAndScheduleToClose TimeSpec TimeSpec

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

knownActivityArgsProxy :: KnownActivity args result -> Proxy args
knownActivityArgsProxy _ = Proxy

startActivity 
  :: forall env st args result. RequireCallStack
  => KnownActivity args result 
  -> StartActivityOptions 
  -> (args :->: Workflow env st (Task env st result))
startActivity k@(KnownActivity codec mTaskQueue name) opts = gatherActivityArgs @env @st @args @result codec $ \typedPayloads -> ilift $ do
  updateCallStack
  inst <- ask
  let ps = convertToProtoPayload <$> typedPayloads

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
        & Command.maybe'scheduleToStartTimeout .~ fmap timespecToDuration opts.scheduleToStartTimeout
        & Command.maybe'heartbeatTimeout .~ fmap timespecToDuration opts.heartbeatTimeout
        & \msg -> case opts.timeout of
          StartToClose t -> msg & Command.startToCloseTimeout .~ timespecToDuration t
          ScheduleToClose t -> msg & Command.scheduleToCloseTimeout .~ timespecToDuration t
          StartToCloseAndScheduleToClose stc stc' -> msg 
            & Command.startToCloseTimeout .~ timespecToDuration stc
            & Command.scheduleToCloseTimeout .~ timespecToDuration stc'
        & Command.doNotEagerlyExecute .~ opts.disableEagerExecution

  let cmd = defMessage & Command.scheduleActivity .~ scheduleActivity
  addCommand inst cmd
  pure $ Task 
    { waitAction = do
      res <- getIVar resultSlot
      Workflow $ \_ -> case res ^. Activation.result . ActivityResult.maybe'status of
        Nothing -> error "Activity result missing status"
        Just (ActivityResult.ActivityResolution'Completed success) -> do
          let result = decode codec $ convertFromProtoPayload $ success ^. ActivityResult.result
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
      ilift $ addCommand inst cancelCmd
    }

gatherActivityArgs 
  :: forall env st args result codec. GatherArgs codec args
  => codec 
  -> ([RawPayload] -> Workflow env st (Task env st result)) 
  -> (args :->: Workflow env st (Task env st result))
gatherActivityArgs c f = gatherArgs (Proxy @args) c id f

data StartChildWorkflowOptions = StartChildWorkflowOptions 
  { cancellationType :: ChildWorkflowCancellationType
  , parentClosePolicy :: ParentClosePolicy
  , executionTimeout :: Maybe TimeSpec
  , runTimeout :: Maybe TimeSpec
  , taskTimeout :: Maybe TimeSpec
  , retryPolicy :: Maybe RetryPolicy
  , cronSchedule :: Maybe Text
  , initialMemo :: Map Text Proto.Temporal.Api.Common.V1.Message.Payload
  , searchAttributes :: Map Text Proto.Temporal.Api.Common.V1.Message.Payload
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

instance Wait (Task env st a) where
  type WaitResult (Task env st a) = Workflow env st a
  wait t = do
    updateCallStackW
    t.waitAction

instance Wait (ChildWorkflowHandle env st a) where
  type WaitResult (ChildWorkflowHandle env st a) = Workflow env st a
  wait h = waitChildWorkflowResult h

class Cancel h where
  type CancelResult h :: Type
  -- | Signal to Temporal that a handle representing an async action should be cancelled.
  cancel :: RequireCallStack => h -> CancelResult h

instance Cancel (Task env st a) where
  type CancelResult (Task env st a) = Workflow env st ()
  cancel t = do
    updateCallStackW
    t.cancelAction

instance Cancel (ChildWorkflowHandle env st a) where
  type CancelResult (ChildWorkflowHandle env st a) = Workflow env st ()
  cancel h = do
    updateCallStackW
    cancelChildWorkflowExecution h

instance Cancel (ExternalWorkflowHandle env st a) where
  type CancelResult (ExternalWorkflowHandle env st a) = Workflow env st (Workflow env st ())

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
      inst 
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
data ExternalWorkflowHandle (env :: Type) (st :: Type) (result :: Type) = ExternalWorkflowHandle
  { externalWorkflowWorkflowId :: WorkflowId
  , externalWorkflowRunId :: Maybe RunId
  }

-- | A client side handle to a single Workflow instance. It can be used to signal a workflow execution.
--
-- Given the following Workflow definition:
class WorkflowHandle h where
  -- | Signal a running Workflow.
  signal :: RequireCallStack => h env st result -> SignalDefinition args -> (args :->: Workflow env st (Task env st ()))

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
  :: forall env st args result h. RequireCallStack
  => h env st result
  -> (Command.SignalExternalWorkflowExecution -> Command.SignalExternalWorkflowExecution)
  -> SignalDefinition args
  -> (args :->: Workflow env st (Task env st ()))
signalWorkflow _ f (SignalDefinition signalName signalCodec signalApply) = gatherSignalChildWorkflowArgs @env @st @args @() signalCodec $ \ps -> do
  ilift $ do
    updateCallStack
    resVar <- newIVar
    inst <- ask
    s <- nextExternalSignalSequence
    let cmd = defMessage
          & Command.signalExternalWorkflowExecution .~
            ( f 
              ( defMessage
                & Command.seq .~ rawSequence s
                & Command.signalName .~ signalName 
                & Command.args .~ (convertToProtoPayload <$> ps)
              -- TODO
              -- & Command.headers .~ _
              )
            )
    addCommand inst cmd
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
          ilift $ addCommand inst cancelCmd
      }

gatherSignalChildWorkflowArgs 
  :: forall env st args result codec. GatherArgs codec args
  => codec 
  -> ([RawPayload] -> Workflow env st (Task env st result)) 
  -> (args :->: Workflow env st (Task env st result))
gatherSignalChildWorkflowArgs c f = gatherArgs (Proxy @args) c id f

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
  :: forall env st args result. RequireCallStack
  => KnownWorkflow args result 
  -> StartChildWorkflowOptions
  -> WorkflowId
  -> (args :->: Workflow env st (ChildWorkflowHandle env st result))
startChildWorkflow k@(KnownWorkflow codec mNamespace mTaskQueue _) opts wfId =
  gatherStartChildWorkflowArgs @env @st @args @result codec $ \typedPayloads -> ilift $ go typedPayloads
  where
    go :: [RawPayload] -> InstanceM env st (ChildWorkflowHandle env st result)
    go typedPayloads = do
      updateCallStack
      wfHandle <- sendChildWorkflowCommand typedPayloads
      pure wfHandle
    sendChildWorkflowCommand typedPayloads = do
      inst <- ask
      let ps =  fmap convertToProtoPayload typedPayloads
      
      s@(Sequence wfSeq) <- nextChildWorkflowSequence
      startSlot <- newIVar
      resultSlot <- newIVar
      firstExecutionRunId <- newIVar
      info <- readIORef inst.workflowInstanceInfo
      
      let childWorkflowOptions = defMessage
            & Command.seq .~ wfSeq
            & Command.namespace .~ rawNamespace (fromMaybe info.namespace mNamespace)
            & Command.workflowId .~ rawWorkflowId wfId
            & Command.workflowType .~ knownWorkflowName k
            & Command.taskQueue .~ rawTaskQueue (fromMaybe info.taskQueue mTaskQueue)
            & Command.input .~ ps
            & Command.maybe'workflowExecutionTimeout .~ fmap timespecToDuration opts.executionTimeout
            & Command.maybe'workflowRunTimeout .~ fmap timespecToDuration opts.runTimeout
            & Command.maybe'workflowTaskTimeout .~ fmap timespecToDuration opts.taskTimeout
            & Command.parentClosePolicy .~ parentClosePolicyToProto opts.parentClosePolicy
            & Command.workflowIdReusePolicy .~ workflowIdReusePolicyToProto opts.workflowIdReusePolicy
            & Command.maybe'retryPolicy .~ fmap retryPolicyToProto opts.retryPolicy
            & Command.cronSchedule .~ fromMaybe "" opts.cronSchedule
            & Command.headers .~ opts.headers
            & Command.memo .~ opts.initialMemo
            & Command.searchAttributes .~ opts.searchAttributes
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
      addCommand inst cmd
      pure wfHandle

waitChildWorkflowStart :: RequireCallStack => ChildWorkflowHandle env st result -> Workflow env st ()
waitChildWorkflowStart wfHandle = do
  updateCallStackW
  getIVar wfHandle.startHandle

waitChildWorkflowResult :: RequireCallStack => ChildWorkflowHandle env st result -> Workflow env st result
waitChildWorkflowResult wfHandle@(ChildWorkflowHandle{childWorkflowCodec}) = do
  updateCallStackW
  $(logDebug) "Wait child workflow result"
  res <- getIVar wfHandle.resultHandle
  case res ^. Activation.result . ChildWorkflow.maybe'status of
    Nothing -> ilift $ throwIO $ RuntimeError "Unrecognized child workflow result status"
    Just s -> case s of
      ChildWorkflow.ChildWorkflowResult'Completed res -> do
        let eVal = decode childWorkflowCodec $ convertFromProtoPayload $ res ^. ChildWorkflow.result
        case eVal of
          Left err -> throw $ ValueError err
          Right ok -> pure ok
      ChildWorkflow.ChildWorkflowResult'Failed res -> throw $ ChildWorkflowFailed $ res ^. ChildWorkflow.failure
      ChildWorkflow.ChildWorkflowResult'Cancelled _ -> throw ChildWorkflowCancelled

cancelChildWorkflowExecution :: RequireCallStack => ChildWorkflowHandle env st result -> Workflow env st ()

cancelChildWorkflowExecution wfHandle@(ChildWorkflowHandle{childWorkflowSequence}) = ilift $ do
  updateCallStack
  inst <- ask
  -- I don't see a way to block on this? I guess Temporal wants us to rely on the orchestrator
  -- managing the cancellation. Compare with ResolveRequestCancelExternalWorkflow. I think
  -- external workflows need a resolution step because they may not even exist.
  addCommand inst $ defMessage 
    & Command.cancelChildWorkflowExecution .~ 
      ( defMessage 
        & Command.childWorkflowSeq .~ rawSequence childWorkflowSequence
      )

data StartLocalActivityOptions = StartLocalActivityOptions 
  { activityId :: Maybe ActivityId
  -- | Indicates how long the caller is willing to wait for local activity completion. Limits how
  -- long retries will be attempted. When not specified defaults to the workflow execution
  -- timeout (which may be unset).
  , scheduleToCloseTimeout :: Maybe TimeSpec
  -- | Limits time the local activity can idle internally before being executed. That can happen if
  -- the worker is currently at max concurrent local activity executions. This timeout is always
  -- non retryable as all a retry would achieve is to put it back into the same queue. Defaults
  -- to `schedule_to_close_timeout` if not specified and that is set. Must be <=
  -- `schedule_to_close_timeout` when set, otherwise, it will be clamped down.
  , scheduleToStartTimeout :: Maybe TimeSpec
  -- | Maximum time the local activity is allowed to execute after the task is dispatched. This
  -- timeout is always retryable. Either or both of `schedule_to_close_timeout` and this must be
  -- specified. If set, this must be <= `schedule_to_close_timeout`, otherwise, it will be
  -- clamped down. 
  , startToCloseTimeout :: Maybe TimeSpec
  -- | Specify a retry policy for the local activity. By default local activities will be retried
  -- indefinitely.
  , retryPolicy :: Maybe RetryPolicy
  -- | If the activity is retrying and backoff would exceed this value, lang will be told to
  -- schedule a timer and retry the activity after. Otherwise, backoff will happen internally in
  -- core. Defaults to 1 minute.
  , localRetryThreshold :: Maybe TimeSpec
  -- | Defines how the workflow will wait (or not) for cancellation of the activity to be
  -- confirmed. Lang should default this to `WAIT_CANCELLATION_COMPLETED`, even though proto
  -- will default to `TRY_CANCEL` automatically.
  , cancellationType :: ActivityCancellationType
  -- TODO headers
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
  }

startLocalActivity 
  :: forall env st args result. RequireCallStack
  => KnownActivity args result
  -> StartLocalActivityOptions 
  -> (args :->: Workflow env st (Task env st result))
startLocalActivity (KnownActivity codec _ n) opts = gatherActivityArgs @env @st @args @result codec $ \typedPayloads -> do
  updateCallStackW
  originalTime <- time
  ilift $ do
    inst <- ask
    let ps = convertToProtoPayload <$> typedPayloads
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
              & Command.maybe'scheduleToCloseTimeout .~ (timespecToDuration <$> opts.scheduleToCloseTimeout)
              & Command.maybe'scheduleToStartTimeout .~ (timespecToDuration <$> opts.scheduleToStartTimeout)
              & Command.maybe'startToCloseTimeout .~ (timespecToDuration <$> opts.startToCloseTimeout)
              & Command.maybe'retryPolicy .~ (retryPolicyToProto <$> opts.retryPolicy)
              & Command.maybe'localRetryThreshold .~ (timespecToDuration <$> opts.localRetryThreshold)
              & Command.cancellationType .~ activityCancellationTypeToProto opts.cancellationType
            )
    addCommand inst cmd
    pure $ Task 
      { waitAction = do
        res <- getIVar resultSlot
        Workflow $ \_ -> case res ^. Activation.result . ActivityResult.maybe'status of
          Nothing -> error "Activity result missing status"
          Just (ActivityResult.ActivityResolution'Completed success) -> do
            let result = decode codec $ convertFromProtoPayload $ success ^. ActivityResult.result
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
        ilift $ addCommand inst cancelCmd
      }

-- $metadata
--
-- Temporal provides a number of ways to access metadata about the current Workflow execution.
--
-- Some are useful for debugging (like 'memo', and 'upsertSearchAttributes'), and some are useful for
-- making decisions about how to proceed (like using 'info' to decide whether to continue-as-new).

-- | We recommend calling 'info' whenever accessing 'Info' fields. Some 'Info' fields change during the lifetime of an Execution—
-- like historyLength and searchAttributes— and some may be changeable in the future— like taskQueue.
info :: Workflow env st Info
info = askInstance >>= (\m -> Workflow $ \_ -> Done <$> m) . readIORef . workflowInstanceInfo
--(ask >>= readIORef) workflowInstanceInfo <$> askInstance

-- | Current workflow's raw memo values.
memo :: Workflow env st (Map Text RawPayload)
memo = do
  details <- info
  pure details.rawMemo

-- | Lookup a memo value by key.
memoValue :: Text -> Workflow env st (Maybe RawPayload)
memoValue k = do
  memoMap <- memo
  pure $ Map.lookup k memoMap


-- | Updates this Workflow's Search Attributes by merging the provided searchAttributes with the existing Search Attributes
--
-- Using this function will overwrite any existing Search Attributes with the same key.
upsertSearchAttributes :: RequireCallStack => Map Text SearchAttributeType -> Workflow env st ()
upsertSearchAttributes values = ilift $ do
  updateCallStack
  inst <- ask
  addCommand inst cmd
  modifyIORef' inst.workflowInstanceInfo $ \(info :: Info) ->
    (info { searchAttributes = info.searchAttributes <> values } :: Info)
  where
    cmd = defMessage & Command.upsertWorkflowSearchAttributes .~ 
      ( defMessage
        & Command.searchAttributes .~ fmap (convertToProtoPayload . encode JSON) values
      )

-- | Current time from the workflow perspective.
--
-- The time returned is updated only when the workflow performs an
-- operation in the Workflow monad that blocks. Examples of such operations
-- are 'sleep', 'awaitCondition', 'awaitActivity', 'awaitWorkflow', etc.
--
-- Equivalent to `getCurrentTime` from the `time` package.
now :: Workflow env st UTCTime
now = Workflow $ \_ -> Done <$> do
  wft <- workflowTime <$> ask
  TimeSpec{..} <- readIORef wft
  pure $! systemToUTCTime $ MkSystemTime sec (fromIntegral nsec)

-- $versioning
--
-- Versioning (known as "patching" in the Haskell library) lets you update Workflow Definitions 
-- without causing non-deterministic behavior in current long-running Workflows.
--
-- You may need to patch if:
--
-- - You want to change the remaining logic of a Workflow while it is still running
-- - If your new logic can result in a different execution path
applyPatch :: RequireCallStack => PatchId -> Bool {- ^ whether the patch is deprecated -} -> Workflow env st Bool 
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
        liftIO $ addCommand inst $ defMessage & 
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
patched :: RequireCallStack => PatchId -> Workflow env st Bool
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
deprecatePatch :: RequireCallStack => PatchId -> Workflow env st ()
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
randomGen :: Workflow env st WorkflowGenM
randomGen = workflowRandomnessSeed <$> askInstance

-- | Generate an RFC compliant V4 uuid. 
--
-- Uses the workflow's deterministic PRNG, making it safe for use within a workflow.
--
-- This function is cryptographically insecure.
uuid4 :: Workflow env st UUID
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


newtype Query env st a = Query (Reader (env, st) a)
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
setQueryHandler :: forall env st f result.
  ( ResultOf (Query env st) f ~ result
  , f ~ (ArgsOf f :->: Query env st result)
  , RequireCallStack
  ) => QueryDefinition (ArgsOf f) result -> f -> Workflow env st ()
setQueryHandler (QueryDefinition n codec) f = ilift $ do
  updateCallStack
  inst <- ask
  withRunInIO $ \runInIO -> do
    liftIO $ modifyIORef' inst.workflowQueryHandlers $ \handles ->
      HashMap.insert (Just n) (\qId vec -> runInIO $ handle qId vec) handles
  where
    handle :: QueryId -> Vector RawPayload -> InstanceM env st ()
    handle (QueryId qId) vec = do
      eHandler <- liftIO $ UnliftIO.try $ applyPayloads 
        codec 
        (Proxy @(ArgsOf f))
        (Proxy @(Query env st (ResultOf (Query env st) f))) 
        f 
        vec
      -- TODO handle exceptions properly
      case eHandler of
        Left (ValueError err) -> throwIO $ ValueError err
        Right (Query r) -> do
          inst <- ask
          st <- readIORef inst.workflowState
          eResult <- liftIO $ UnliftIO.try $ pure $ encode codec $ runReader r (inst.workflowEnv, st)
          let cmd = defMessage
                & Command.respondToQuery .~
                  ( defMessage
                    & Command.queryId .~ qId
                    & case eResult of
                      Left (SomeException err) ->
                        Command.failed .~ 
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
                      Right result -> do
                        Command.succeeded .~ (defMessage & Command.response .~ convertToProtoPayload result)
                  )
          addCommand inst cmd
          
type ValidSignalHandler env st f = 
  ( ResultOf (Workflow env st) f ~ ()
  , (ArgsOf f :->: Workflow env st ()) ~ f
  )

setSignalHandler :: forall env st f.
  ( ValidSignalHandler env st f
  , RequireCallStack
  ) => SignalDefinition (ArgsOf f) -> f -> Workflow env st ()
setSignalHandler (SignalDefinition n codec applyToSignal) f = ilift $ do
  updateCallStack
  -- TODO ^ inner callstack?
  inst <- ask
  withRunInIO $ \runInIO -> do
    liftIO $ modifyIORef' inst.workflowSignalHandlers $ \handlers -> 
      HashMap.insert (Just n) (runInIO . handle) handlers
  where
    handle :: Vector RawPayload -> InstanceM env st ()
    handle = \vec -> do
      eWorkflow <- liftIO $ UnliftIO.try $ applyToSignal 
        (Proxy @(Workflow env st ()))
        f 
        vec
      -- TODO handle exceptions properly
      case eWorkflow of
        Left (ValueError err) -> throwIO $ ValueError err
        Right w -> do
          resultVal <- UnliftIO.try $ runWorkflow w
          cmd <- case resultVal of
            Right () -> pure Nothing
            -- If a user-facing exception wasn't handled within the workflow, then that
            -- means the workflow failed.
            Left e -> do
              -- eAttrs <- liftIO $ encodeException inst.workflowCodec (e :: SomeException)
              let completeMessage = defMessage & Command.failWorkflowExecution .~ 
                    ( defMessage 
                      & Command.failure .~ 
                        ( defMessage
                          & F.message .~ Text.pack (show (e :: SomeException))
                          & F.stackTrace .~ ""
                          -- & F.encodedAttributes .~ convertToProtoPayload eAttrs
                        )
                    )
              pure $ Just completeMessage
          inst <- ask
          forM_ cmd (addCommand inst)
          flushCommands

-- | Current time from the workflow perspective.
--
-- The value is relative to epoch time.
time :: RequireCallStack => Workflow env st TimeSpec
time = ilift $ do
  updateCallStack
  wft <- workflowTime <$> ask
  readIORef wft

data Timer env st = Timer
  { timerSequence :: Sequence
  , timerHandle :: IVar env st ()
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
createTimer :: RequireCallStack => TimeSpec -> Workflow env st (Timer env st)
createTimer ts = ilift $ do
  updateCallStack
  inst <- ask
  s@(Sequence seqId) <- nextTimerSequence
  let cmd = defMessage & Command.startTimer .~ 
        ( defMessage 
          & Command.seq .~ seqId
          & Command.startToFireTimeout .~ timespecToDuration ts
        )
  $(logDebug) "Add command: sleep"
  res <- newIVar
  atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
    seqMaps { timers = HashMap.insert s res seqMaps.timers }
  addCommand inst cmd
  pure $ Timer { timerSequence = s, timerHandle = res }

sleep :: RequireCallStack => TimeSpec -> Workflow env st ()
sleep ts = do
  updateCallStackW
  t <- createTimer ts
  Temporal.Workflow.wait t

instance Wait (Timer env st) where
  type WaitResult (Timer env st) = Workflow env st ()
  wait = getIVar . timerHandle

instance Cancel (Timer env st) where
  type CancelResult (Timer env st) = Workflow env st ()

  cancel t = Workflow $ \env -> do
    updateCallStack
    inst <- ask
    let cmd = defMessage & Command.cancelTimer .~ 
          ( defMessage 
            & Command.seq .~ rawSequence (timerSequence t)
          )
    addCommand inst cmd
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
  :: forall env st args result a codec. GatherArgs codec args
  => codec 
  -> ([RawPayload] -> Workflow env st a) 
  -> (args :->: Workflow env st a)
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
continueAsNew 
  :: forall env st args result a. KnownWorkflow args result
  -- ^ The workflow to continue as new. It doesn't have to be the same as the current workflow.
  -> ContinueAsNewOptions 
  -> (args :->: Workflow env st a)
continueAsNew k@(KnownWorkflow codec _ _ _) opts = gatherContinueAsNewArgs @env @st @args @result @a codec $ \args -> do
  Workflow $ \_ -> do
    throwIO $ ContinueAsNewException $ defMessage
      & Command.workflowType .~ knownWorkflowName k
      & Command.taskQueue .~ (maybe "" rawTaskQueue opts.taskQueue)
      & Command.arguments .~ (convertToProtoPayload <$> args)
      & Command.maybe'retryPolicy .~ (retryPolicyToProto <$> opts.retryPolicy)
      -- TODO 
      -- & Command.searchAttributes .~ _
      -- & Command.headers .~ _
      -- & Command.memo .~ _
      & Command.maybe'workflowTaskTimeout .~ (timespecToDuration <$> opts.taskTimeout)
      & Command.maybe'workflowRunTimeout .~ (timespecToDuration <$> opts.runTimeout)

-- | Returns a client-side handle that can be used to signal and cancel an existing Workflow execution. It takes a Workflow ID and optional run ID.
getExternalWorkflowHandle :: RequireCallStack => WorkflowId -> Maybe RunId -> Workflow env st (ExternalWorkflowHandle env st result)
getExternalWorkflowHandle wfId mrId = do
  updateCallStackW
  pure $ ExternalWorkflowHandle
    { externalWorkflowWorkflowId = wfId
    , externalWorkflowRunId = mrId
    }

-- | Wait on a condition to become true before continuing.
--
-- This must be used with signals, as that is the only way for
-- state to change in a workflow while the workflow itself is
-- in this blocking condition.
--
-- N.B. this should be used with care, as it can lead to the workflow
-- suspending indefinitely if the condition is never met. 
-- (e.g. if there is no signal handler that changes the state appropriately)
waitCondition :: RequireCallStack => (st -> Bool) -> Workflow env st ()
waitCondition f = do
  st <- get
  if f st
    then pure ()
    else go
  where
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
      ilift $ do
        inst <- ask
        atomically $ modifyTVar' inst.workflowSequenceMaps $ \seqMaps ->
          seqMaps { conditionsAwaitingSignal = HashMap.delete conditionSeq seqMaps.conditionsAwaitingSignal }
      st <- get
      if f st
        then pure ()
        else go

-- | While workflows are deterministic, there are categories of operational concerns (metrics, logging, tracing, etc.) that require
-- access to IO operations like the network or filesystem. The 'IO' monad is not generally available in the 'Workflow' monad, but you 
-- can use 'sink' to run an 'IO' action in a workflow. In order to maintain determinism, the operation will be executed asynchronously 
-- and does not return a value. Be sure that the sink operation terminates, or else you will leak memory and/or threads.
--
-- Do not use 'sink' for any Workflow logic, or else you will violate determinism.
unsafeAsyncEffectSink :: RequireCallStack => IO () -> Workflow env st ()
unsafeAsyncEffectSink m = do
  updateCallStackW
  ilift $ liftIO $ void $ forkIO m


-- -----------------------------------------------------------------------------
-- Parallel operations

biselect 
  :: RequireCallStack
  => Workflow env st (Either a b)
  -> Workflow env st (Either a c)
  -> Workflow env st (Either a (b, c))
biselect wfA wfB = biselectOpt id id Left Right wfA wfB

{-# INLINE biselectOpt #-}
biselectOpt 
  :: RequireCallStack
  => (l -> Either a b)
  -> (r -> Either a c)
  -> (a -> t)
  -> ((b, c) -> t)
  -> Workflow env st l
  -> Workflow env st r
  -> Workflow env st t
biselectOpt discrimA discrimB left right wfA wfB =
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
  in go wfA wfB

-- | This function takes two Workflow computations as input, and returns the
-- output of whichever computation finished first.
race
  :: RequireCallStack
  => Workflow env st a
  -> Workflow env st b
  -> Workflow env st (Either a b)
race x y = biselectOpt discrimX discrimY id right x y
  where
    discrimX :: a -> Either (Either a b) ()
    discrimX a = Left (Left a)

    discrimY :: b -> Either (Either a b) ()
    discrimY b = Left (Right b)

    right _ = error "race: We should never have a 'Right ()'"
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
  ( WorkflowDefinition
  , provideWorkflow
  , Workflow
  , WorkflowId(..)
  , Namespace(..)
  , TaskQueue(..)
  , ParentClosePolicy(..)
  , ChildWorkflowCancellationType(..)
  , WorkflowIdReusePolicy(..)
  , PatchId(..)
  , RunId(..)
  , WorkflowType(..)
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
  , KnownWorkflow(..)
  -- ** Child workflow operations
  -- $childWorkflow
  , StartChildWorkflowOptions(..)
  , defaultChildWorkflowOptions
  -- , StartChildWorkflow
  , startChildWorkflow
  , ChildWorkflowHandle
  , waitChildWorkflowResult
  , Temporal.Workflow.wait
  , cancelChildWorkflowExecution
  -- , execWorkflow
  -- , continueAsNew
  -- , executeLocalActivity
  , Info(..)
  , RetryPolicy(..)
  , ParentInfo(..)
  , info
  -- , memo
  -- , memoValue
  -- * Versioning workflows
  -- $versioning
  , patched
  , deprecatePatch
  -- , query
  -- , setDynamicQueryHandler
  -- , setDynamicSignalHandler
  , QueryDefinition(..)
  , setQueryHandler
  , SignalDefinition(..)
  , setSignalHandler
  , upsertSearchAttributes
  -- , signal
  -- * Time and timers
  , now
  , time
  , sleep
  -- * Random value generation
  -- $randomness
  , randomGen
  , uuid4
  , WorkflowGenM(..)
  ) where
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.IO.Class
import qualified Data.Aeson
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Short as SBS
import Data.Functor.Compose
import Data.Map.Strict (Map)
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
import GHC.TypeLits
import Lens.Family2
import Proto.Temporal.Api.Common.V1.Message (Payload)
import System.Clock (TimeSpec(..))
import System.Random.Stateful
import Temporal.Common
import Temporal.Exception
import Temporal.Payload
import Temporal.Worker.Types
import Temporal.Workflow.Unsafe
import Temporal.WorkflowInstance
import Temporal.Workflow.WorkflowInstance
import Temporal.Workflow.WorkflowDefinition
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow as ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow_Fields as ChildWorkflow
import qualified Proto.Temporal.Api.Failure.V1.Message_Fields as F
import UnliftIO



data Task env st a = Task (Workflow env st a)

wait :: Task env st a -> Workflow env st a
wait (Task w) = w

ilift :: InstanceM env st a -> Workflow env st a
ilift = Workflow . fmap Done

askInstance :: Workflow env st (WorkflowInstance env st)
askInstance = ilift ask

data ContinueAsNewOptions = ContinueAsNewOptions
  { workflow :: Maybe WorkflowType
  , args :: (Vector Proto.Temporal.Api.Common.V1.Message.Payload)
  , taskQueue :: Maybe TaskQueue
  , runTimeout :: Maybe TimeSpec
  , taskTimeout :: Maybe TimeSpec
  , retryPolicy :: Maybe RetryPolicy
  -- , TODO memo :: 
  -- , TODO searchAttributes :: Maybe (Map Text Payload)
  -- , TODO headers
  }
-- continueAsNew :: () -> Workflow env ()
-- continueAsNew = undefined

data StartActivityOptions = StartActivityOptions
  { activityId :: Maybe ActivityId
  , taskQueue :: Maybe TaskQueue
  , timeout :: TimeoutType
  , scheduleToStartTimeout :: Maybe TimeSpec
  , heartbeatTimeout :: Maybe TimeSpec
  , retryPolicy :: Maybe RetryPolicy
  , cancellationType :: ActivityCancellationType
  -- , headers :: Maybe (Map Text Text) -- TODO payloads
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
  :: forall env st args result.
     KnownActivity args result 
  -> StartActivityOptions 
  -> (args :->: Workflow env st (Task env st result))
startActivity k@(KnownActivity codec mTaskQueue name) opts = gatherActivityArgs @env @st @args @result codec $ \typedPayloads -> ilift $ do
  inst <- ask
  ps <- liftIO $ forM typedPayloads $ \payloadAction -> 
    fmap convertToProtoPayload payloadAction

  s@(Sequence actSeq) <- nextActivitySequence
  resultSlot <- newIVar
  modifyMVar inst.workflowSequenceMaps $ \seqMaps -> do
    pure (seqMaps { activities = HashMap.insert s resultSlot (activities seqMaps) }, ())

  let scheduleActivity = defMessage
        & Command.seq .~ actSeq
        & Command.activityId .~ maybe (Text.pack $ show actSeq) rawActivityId (opts.activityId)
        & Command.activityType .~ name
        & Command.taskQueue .~ rawTaskQueue (fromMaybe inst.workflowInstanceInfo.taskQueue mTaskQueue)
        & Command.arguments .~ ps
        & Command.maybe'retryPolicy .~ fmap retryPolicyToProto opts.retryPolicy
        & Command.cancellationType .~ activityCancellationTypeToProto opts.cancellationType
        & Command.maybe'scheduleToStartTimeout .~ fmap timespecToDuration opts.scheduleToStartTimeout
        & Command.maybe'heartbeatTimeout .~ fmap timespecToDuration opts.heartbeatTimeout
        & Command.headers .~ mempty -- TODO
        & \msg -> case opts.timeout of
          StartToClose t -> msg & Command.startToCloseTimeout .~ timespecToDuration t
          ScheduleToClose t -> msg & Command.scheduleToCloseTimeout .~ timespecToDuration t
          StartToCloseAndScheduleToClose stc stc' -> msg 
            & Command.startToCloseTimeout .~ timespecToDuration stc
            & Command.scheduleToCloseTimeout .~ timespecToDuration stc'

  let cmd = defMessage & Command.scheduleActivity .~ scheduleActivity
  addCommand inst cmd
  pure $ Task $ do
    res <- getIVar resultSlot
    case res ^. Activation.result . ActivityResult.maybe'status of
      Nothing -> error "Activity result missing status"
      Just (ActivityResult.ActivityResolution'Completed success) -> do
        result <- ilift $ liftIO $ decode codec $ convertFromProtoPayload $ success ^. ActivityResult.result
        case result of
          -- TODO handle properly
          Left err -> error $ "Failed to decode activity result: " <> show err
          Right val -> pure val
      Just (ActivityResult.ActivityResolution'Failed failure) -> error "not implemented"
      Just (ActivityResult.ActivityResolution'Cancelled details) -> error "not implemented"
      Just (ActivityResult.ActivityResolution'Backoff doBackoff) -> error "not implemented"

gatherActivityArgs 
  :: forall env st args result codec. GatherArgs codec args
  => codec 
  -> ([IO RawPayload] -> Workflow env st (Task env st result)) 
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
  , memo :: Map Text Proto.Temporal.Api.Common.V1.Message.Payload
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
  , memo = mempty
  , searchAttributes = mempty
  , headers = mempty
  , workflowIdReusePolicy = WorkflowIdReusePolicyUnspecified
  }

signalChildWorkflow 
  :: ChildWorkflowHandle env st result 
  -> QueryDefinition codec args result
  -> Workflow env st ()
signalChildWorkflow = undefined

-- $childWorkflow
--
-- A Child Workflow Execution is a Workflow Execution that is spawned from within another Workflow.
--
-- By default, a child is scheduled on the same Task Queue as the parent.

startChildWorkflow 
  :: forall env st args result. KnownWorkflow args result 
  -> StartChildWorkflowOptions
  -> WorkflowId
  -> (args :->: Workflow env st (ChildWorkflowHandle env st result))
startChildWorkflow k@(KnownWorkflow codec mNamespace mTaskQueue _) opts wfId = 
  gatherStartChildWorkflowArgs @env @st @args @result codec go
  where
    go :: [IO RawPayload] -> Workflow env st (ChildWorkflowHandle env st result)
    go typedPayloads = do
      wfHandle <- sendChildWorkflowCommand typedPayloads
      getIVar wfHandle.startHandle
      pure wfHandle
    sendChildWorkflowCommand typedPayloads = ilift $ do
      inst <- ask
      ps <- liftIO $ forM typedPayloads $ \payloadAction -> 
        fmap convertToProtoPayload payloadAction
      
      s@(Sequence wfSeq) <- nextChildWorkflowSequence
      startSlot <- newIVar
      resultSlot <- newIVar
      
      let childWorkflowOptions = defMessage
            & Command.seq .~ wfSeq
            & Command.namespace .~ rawNamespace (fromMaybe inst.workflowInstanceInfo.namespace mNamespace)
            & Command.workflowId .~ rawWorkflowId wfId
            & Command.workflowType .~ knownWorkflowName k
            & Command.taskQueue .~ rawTaskQueue (fromMaybe inst.workflowInstanceInfo.taskQueue mTaskQueue)
            & Command.input .~ ps
            & Command.maybe'workflowExecutionTimeout .~ fmap timespecToDuration opts.executionTimeout
            & Command.maybe'workflowRunTimeout .~ fmap timespecToDuration opts.runTimeout
            & Command.maybe'workflowTaskTimeout .~ fmap timespecToDuration opts.taskTimeout
            & Command.parentClosePolicy .~ parentClosePolicyToProto opts.parentClosePolicy
            & Command.workflowIdReusePolicy .~ workflowIdReusePolicyToProto opts.workflowIdReusePolicy
            & Command.maybe'retryPolicy .~ fmap retryPolicyToProto opts.retryPolicy
            & Command.cronSchedule .~ fromMaybe "" opts.cronSchedule
            & Command.headers .~ opts.headers
            & Command.memo .~ opts.memo
            & Command.searchAttributes .~ opts.searchAttributes
            & Command.cancellationType .~ childWorkflowCancellationTypeToProto opts.cancellationType

          cmd = defMessage 
            & Command.startChildWorkflowExecution .~ childWorkflowOptions
        
          wfHandle = ChildWorkflowHandle 
            { childWorkflowSequence = s
            , startHandle = startSlot 
            , resultHandle = resultSlot
            , firstExecutionRunId = Nothing
            , childWorkflowCodec = codec
            }

      modifyMVar_ inst.workflowSequenceMaps $ \seqMaps -> do
        pure $ seqMaps { childWorkflows = HashMap.insert s (SomeChildWorkflowHandle wfHandle) seqMaps.childWorkflows }

      $(logDebug) "Add command: startChildWorkflowExecution"
      addCommand inst cmd
      pure wfHandle

waitChildWorkflowResult :: ChildWorkflowHandle env st result -> Workflow env st result
waitChildWorkflowResult wfHandle@(ChildWorkflowHandle{childWorkflowCodec}) = do
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

cancelChildWorkflowExecution :: ChildWorkflowHandle env st result -> Workflow env st ()
cancelChildWorkflowExecution wfHandle@(ChildWorkflowHandle{childWorkflowSequence}) = ilift $ do
  inst <- ask
  addCommand inst $ defMessage 
    & Command.cancelChildWorkflowExecution .~ 
      ( defMessage 
        & Command.childWorkflowSeq .~ rawSequence childWorkflowSequence
      )

data StartLocalActivityOptions = StartLocalActivityOptions 
  { activityId :: Maybe ActivityId
  , scheduleToCloseTimeout :: Maybe TimeSpec
  , scheduleToStartTimeout :: Maybe TimeSpec
  , startToCloseTimeout :: Maybe TimeSpec
  , retryPolicy :: Maybe RetryPolicy
  , localRetryThreshold :: Maybe TimeSpec
  , cancellationType :: ActivityCancellationType
  -- TODO headers
  }
startLocalActivity 
  :: StartLocalActivityOptions 
  -> KnownActivity args result
  -> Workflow env st ()
startLocalActivity = undefined


info :: Workflow env st Info
info = workflowInstanceInfo <$> askInstance

-- memo :: () -> Workflow env ()
-- memo = undefined

-- memoValue :: () -> Workflow env ()
-- memoValue = undefined

-- Current time from the workflow perspective.
--
-- Equivalent to `getCurrentTime` from the `time` package.
now :: Workflow env st UTCTime
now = Workflow $ do
  wft <- workflowTime <$> ask
  TimeSpec{..} <- readIORef wft
  pure $! Done $! systemToUTCTime $ MkSystemTime sec (fromIntegral nsec)

-- $versioning
--
-- Versioning (known as "patching" in the Haskell library) lets you update Workflow Definitions 
-- without causing non-deterministic behavior in current long-running Workflows.
--
-- You may need to patch if:
--
-- - You want to change the remaining logic of a Workflow while it is still running
-- - If your new logic can result in a different execution path
applyPatch :: PatchId -> Bool {- ^ whether the patch is deprecated -} -> Workflow env st Bool 
applyPatch pid deprecated = Workflow $ fmap Done $ do
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

patched :: PatchId -> Workflow env st Bool
patched pid = applyPatch pid False

deprecatePatch :: PatchId -> Workflow env st ()
deprecatePatch pid = void $ applyPatch pid True

-- TODO move the codec value into the QueryDefinition?
query 
  :: QueryDefinition codec args result 
  -> (args :->: Workflow env st (ChildWorkflowHandle env st result))
query = undefined

-- | Get a mutable randomness generator for the workflow.
randomGen :: Workflow env st WorkflowGenM
randomGen = workflowRandomnessSeed <$> askInstance

-- setDynamicQueryHandler :: () -> Workflow env ()
-- setDynamicQueryHandler = undefined

-- setDynamicSignalHandler :: () -> Workflow env ()
-- setDynamicSignalHandler = undefined

newtype Query env st a = Query (Reader (env, st) a)


setQueryHandler :: forall codec env st f result.
  ( ResultOf (Query env st) f ~ result
  , ApplyPayloads codec (ArgsOf f) (Query env st result)
  , Codec codec result
  , f ~ (ArgsOf f :->: Query env st result)
  ) => codec -> QueryDefinition codec (ArgsOf f) result -> f -> Workflow env st ()
setQueryHandler codec (QueryDefinition n) f = ilift $ do
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
          eResult <- liftIO $ UnliftIO.try $ encode codec $ runReader r (inst.workflowEnv, st)
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
                            -- & F.activityFailureInfo .~
                            -- ( defMessage
                            --   -- & F.scheduledEventId .~ _
                            --   -- & F.startedEventId .~ _
                            --   -- TODO, not clear on what this should be
                            --   -- & F.identity .~ _
                            --   & F.activityType .~ (defMessage & P.name .~ info.activityType)
                            --   & F.activityId .~ (msg ^. AT.activityId)
                            --   -- & F.retryState .~ _
                            -- )
                          )
                      Right result -> do
                        Command.succeeded .~ (defMessage & Command.response .~ convertToProtoPayload result)
                  )
          addCommand inst cmd
          
  

setSignalHandler :: forall env st f.
  ( ResultOf (Workflow env st) f ~ ()
  , (ArgsOf f :->: Workflow env st ()) ~ f
  ) => SignalDefinition (ArgsOf f) -> f -> Workflow env st ()
setSignalHandler (SignalDefinition n codec applyToSignal) f = ilift $ do
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
          result <- newIVar
          resultVal <- runWorkflow result w
          cmd <- case resultVal of
            Ok () -> pure Nothing
            -- If a user-facing exception wasn't handled within the workflow, then that
            -- means the workflow failed.
            ThrowWorkflow e -> do
              -- eAttrs <- liftIO $ encodeException inst.workflowCodec (e :: SomeException)
              let completeMessage = defMessage & Command.failWorkflowExecution .~ 
                    ( defMessage 
                      & Command.failure .~ 
                        ( defMessage
                          & F.message .~ Text.pack (show e)
                          & F.stackTrace .~ ""
                          -- & F.encodedAttributes .~ convertToProtoPayload eAttrs
                        )
                    )
              pure $ Just completeMessage
            -- Crash the worker if we get an internal exception.
            ThrowInternal e -> throwIO e
          inst <- ask
          forM_ cmd (addCommand inst)
          flushCommands result

-- | Current time from the workflow perspective.
--
-- The value is relative to epoch time.
time :: Workflow env st TimeSpec
time = Workflow $ do
  wft <- workflowTime <$> ask
  Done <$> readIORef wft

-- | Updates this Workflow's Search Attributes by merging the provided searchAttributes with the existing Search Attributes
--
-- Using this function will overwrite any existing Search Attributes with the same key.
upsertSearchAttributes :: Map Text Data.Aeson.Value -> Workflow env st ()
upsertSearchAttributes values = ilift $ do
  inst <- ask
  addCommand inst cmd
  where
    cmd = defMessage & Command.upsertWorkflowSearchAttributes .~ 
      ( defMessage
        & Command.searchAttributes .~ mapValues
      )
    mapValues = fmap (convertToProtoPayload . (\x -> RawPayload x mempty) . L.toStrict . Data.Aeson.encode) values

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

-- waitCondition :: () -> Workflow env ()
-- waitCondition = undefined

{- TODO Inquire about these:

Side Effects are used to execute non-deterministic code, such as generating a UUID or a random number, without compromising deterministic in the Workflow. This is done by storing the non-deterministic results of the Side Effect into the Workflow Event History.

sideEffect :: IO a -> Workflow env st a
sideEffect = undefined

Mutable Side Effects execute the provided function once, and then it looks up the History of the value with the given Workflow ID.

If there is no existing value, then it records the function result as a value with the given Workflow Id on the History.

If there is an existing value, then it compares whether the existing value from the History has changed from the new function results, by calling the equals function.

If the values are equal, then it returns the value without recording a new Marker Event

If the values aren't equal, then it records the new value with the same ID on the History.

mutableSideEffect :: IO a -> Workflow env st a
mutableSideEffect = undefined
-}

-- TODO, timer suopport?

sleep :: TimeSpec -> Workflow env st ()
sleep ts = do
  res <- ilift $ do
    inst <- ask
    s@(Sequence seqId) <- nextTimerSequence
    let cmd = defMessage & Command.startTimer .~ 
          ( defMessage 
            & Command.seq .~ seqId
            & Command.startToFireTimeout .~ timespecToDuration ts
          )
    $(logDebug) "Add command: sleep"
    res <- newIVar
    modifyMVar_ inst.workflowSequenceMaps $ \seqMaps -> do
      pure $ seqMaps { timers = HashMap.insert s res seqMaps.timers }
    addCommand inst cmd
    pure res
  getIVar res

-- TODO, would be nice to ensure that the arg types are the same as the workflow args.
-- continueAsNew 
--   :: KnownWorkflow name args result 
--   -> ContinueAsNewOptions 
--   -> Workflow env st ()
-- continueAsNew k@(KnownWorkflow codec mNamespace mTaskQueue) opts = do

getExternalWorkflowHandle :: WorkflowId -> Maybe RunId -> Workflow env st (ChildWorkflowHandle env st result)
getExternalWorkflowHandle = undefined
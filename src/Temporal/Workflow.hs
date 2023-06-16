{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Workflow 
  ( provideWorkflow
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
  , KnownActivity(..)
  , knownActivityName
  , StartActivityOptions(..)
  , defaultStartActivityOptions
  , StartActivity
  , startActivity
  , StartLocalActivityOptions(..)
  , startLocalActivity
  , KnownWorkflow(..)
  , StartChildWorkflowArgs(..)
  , StartChildWorkflowOptions(..)
  , defaultChildWorkflowOptions
  , StartChildWorkflow
  , startChildWorkflow
  , ChildWorkflowHandle
  , waitChildWorkflowResult
  , Temporal.Workflow.wait
  -- , execWorkflow
  -- , continueAsNew
  -- , executeLocalActivity
  , Info(..)
  , RetryPolicy(..)
  , ParentInfo(..)
  , info
  -- , memo
  -- , memoValue
  , patched
  , deprecatePatch
  -- , query
  -- , setDynamicQueryHandler
  -- , setDynamicSignalHandler
  -- , setQueryHandler
  -- , setSignalHandler
  -- , signal
  , now
  , time
  , sleep
  -- , upsertSearchAttributes
  , randomGen
  , uuid4
  -- , waitCondition
  , WorkflowGenM(..)
  , StartActivityArgs
  ) where
import Control.Monad
import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.IO.Class
import qualified Data.ByteString.Short as SBS
import Data.Functor.Compose
import Data.Map.Strict (Map)
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

type family StartActivity env st baseResult (args :: [*]) = r | r -> env st baseResult args where
  StartActivity env st baseResult '[] = Workflow env st (Task env st baseResult)
  StartActivity env st baseResult (a ': as) = a -> StartActivity env st baseResult as 

class StartActivityArgs codec (args :: [*]) baseResult where
  applyArgs_ 
    :: Proxy args 
    -> Proxy env
    -> Proxy st
    -> codec
    -> ([IO RawPayload] -> [IO RawPayload]) 
    -> ([IO RawPayload] -> Workflow env st (Task env st baseResult))
    -> StartActivity env st baseResult args 

instance StartActivityArgs codec '[] baseResult where
  applyArgs_ argsP envP stP _ accum f = f $ accum []

instance (Codec codec a, StartActivityArgs codec as baseResult) => StartActivityArgs codec (a ': as) baseResult where
  applyArgs_ argsP envP stP c accum f = \arg ->
    applyArgs_
    (Proxy @as) 
    envP
    stP
    c
    ((encode c arg :) . accum) 
    f

gatherStartActivityArgs :: forall env st args baseResult codec. StartActivityArgs codec args baseResult => codec -> ([IO RawPayload] -> Workflow env st (Task env st baseResult)) -> StartActivity env st baseResult args 
gatherStartActivityArgs c f = applyArgs_ (Proxy @args) (Proxy @env) (Proxy @st) c id f

data KnownActivity (name :: Symbol) (args :: [Type]) (result :: Type) 
  = forall codec. (Codec codec result, AllArgsSupportCodec codec args, StartActivityArgs codec args result) => KnownActivity
    { knownActivityCodec :: codec
    , knownActivityQueue :: Maybe TaskQueue
    }

knownActivityArgsProxy :: KnownActivity name args result -> Proxy args
knownActivityArgsProxy _ = Proxy

knownActivityName :: forall name args result. KnownSymbol name => KnownActivity name args result -> Text
knownActivityName _ = Text.pack $ symbolVal (Proxy @name)

startActivity :: 
  ( KnownSymbol name
  ) => StartActivityOptions -> KnownActivity name args result -> StartActivity env st result args
startActivity opts k@(KnownActivity codec mTaskQueue) = gatherStartActivityArgs codec $ \typedPayloads -> ilift $ do
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
        & Command.activityType .~ knownActivityName k
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
  where


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

-- TODO signalChildWorkflow support
-- signalChildWorkflow :: ChildWorkflowHandler env st result -> _ -> Workflow env st ()

startChildWorkflow 
  :: (KnownSymbol name)
  => KnownWorkflow name args result 
  -> StartChildWorkflowOptions
  -> WorkflowId
  -> StartChildWorkflow env st result args 
startChildWorkflow k@(KnownWorkflow codec mNamespace mTaskQueue) opts wfId = gatherStartChildWorkflowArgs codec $ \typedPayloads -> do
  wfHandle <- sendChildWorkflowCommand typedPayloads
  getIVar wfHandle.startHandle
  pure wfHandle
  where
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
  -> KnownActivity name args result
  -> Workflow env st ()
startLocalActivity = undefined

-- {-
-- Function	get_dynamic_query_handler	Get the dynamic query handler if any.
-- Function	get_dynamic_signal_handler	Get the dynamic signal handler if any.
-- Function	get_external_workflow_handle	Get a workflow handle to an existing workflow by its ID.
-- Function	get_external_workflow_handle_for	Get a typed workflow handle to an existing workflow by its ID.
-- Function	get_query_handler	Get the query handler for the given name if any.
-- Function	get_signal_handler	Get the signal handler for the given name if any.
-- -}

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

-- query :: () -> Workflow env ()
-- query = undefined

-- | Get a mutable randomness generator for the workflow.
randomGen :: Workflow env st WorkflowGenM
randomGen = workflowRandomnessSeed <$> askInstance

-- setDynamicQueryHandler :: () -> Workflow env ()
-- setDynamicQueryHandler = undefined

-- setDynamicSignalHandler :: () -> Workflow env ()
-- setDynamicSignalHandler = undefined

-- setQueryHandler :: () -> Workflow env ()
-- setQueryHandler = undefined

-- setSignalHandler :: () -> Workflow env ()
-- setSignalHandler = undefined

-- signal :: () -> Workflow env ()
-- signal = undefined

-- | Current time from the workflow perspective.
--
-- The value is relative to epoch time.
time :: Workflow env st TimeSpec
time = Workflow $ do
  wft <- workflowTime <$> ask
  Done <$> readIORef wft

-- upsertSearchAttributes :: () -> Workflow env ()
-- upsertSearchAttributes = undefined

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

{-
Side Effects are used to execute non-deterministic code, such as generating a UUID or a random number, without compromising deterministic in the Workflow. This is done by storing the non-deterministic results of the Side Effect into the Workflow Event History.

-}
sideEffect :: IO a -> Workflow env st a
sideEffect = undefined

{- |
Mutable Side Effects execute the provided function once, and then it looks up the History of the value with the given Workflow ID.

If there is no existing value, then it records the function result as a value with the given Workflow Id on the History.

If there is an existing value, then it compares whether the existing value from the History has changed from the new function results, by calling the equals function.

If the values are equal, then it returns the value without recording a new Marker Event

If the values aren't equal, then it records the new value with the same ID on the History.

-}
mutableSideEffect :: IO a -> Workflow env st a
mutableSideEffect = undefined

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
  
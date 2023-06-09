{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Workflow 
  ( Workflow
  , Task
  , TimeoutType(..)
  , Temporal.Workflow.wait
  -- , execWorkflow
  -- , continueAsNew
  -- , executeActivity
  -- , executeChildWorkflow
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
  , StartActivityOptions(..)
  , defaultStartActivityOptions
  , startActivity
  , startLocalActivity
  , startChildWorkflow
  , now
  , time
  -- , upsertSearchAttributes
  , randomGen
  , uuid4
  -- , waitCondition
  , WorkflowGenM(..)
  ) where

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
import Data.Kind
import Data.UUID (UUID)
import Data.UUID.Types.Internal ( buildFromBytes )
import Data.Word (Word32)
import Data.Vector (Vector)
import GHC.TypeLits
import Lens.Family2
import Proto.Temporal.Api.Common.V1.Message (Payload)
import System.Clock (TimeSpec)
import System.Random.Stateful
import Temporal.Common
import Temporal.Payload
import Temporal.Worker.Types
import Temporal.Workflow.Unsafe
import Temporal.WorkflowInstance
import Temporal.Workflow.WorkflowInstance
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields as Activation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands_Fields as Command
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult as ActivityResult
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields as ActivityResult
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

class StartActivityArgs codec env st (args :: [*]) baseResult where
  applyArgs_ 
    :: Proxy args 
    -> codec
    -> ([IO RawPayload] -> [IO RawPayload]) 
    -> ([IO RawPayload] -> Workflow env st (Task env st baseResult))
    -> StartActivity env st baseResult args 
    -- ([RawPayload] -> Workflow env st (Task env st RawPayload)) -> StartActivity env st args baseResult

instance StartActivityArgs codec env st '[] baseResult where
  applyArgs_ argsP _ accum f = f $ accum []

instance (Codec codec a, StartActivityArgs codec env st as baseResult) => StartActivityArgs codec env st (a ': as) baseResult where
  applyArgs_ argsP c accum f = \arg ->
    applyArgs_
    (Proxy @as) 
    c
    ((encode c arg :) . accum) 
    f

gatherArgs :: forall env st args baseResult codec. StartActivityArgs codec env st args baseResult => codec -> ([IO RawPayload] -> Workflow env st (Task env st baseResult)) -> StartActivity env st baseResult args 
gatherArgs c f = applyArgs_ (Proxy @args) c id f

data KnownActivity localEnv localSt (queue :: Symbol) (name :: Symbol) (args :: [Type]) (result :: Type) = forall codec. 
  ( Codec codec result
  , AllArgsSupportCodec codec args
  , StartActivityArgs codec localEnv localSt args result
  ) => KnownActivity codec

knownActivityArgsProxy :: KnownActivity localEnv localSt queue name args result -> Proxy args
knownActivityArgsProxy _ = Proxy

knownActivityQueue :: forall localEnv localSt queue name args result. KnownSymbol queue => KnownActivity localEnv localSt queue name args result -> Text
knownActivityQueue _ = Text.pack $ symbolVal (Proxy @queue)

knownActivityName :: forall localEnv localSt queue name args result. KnownSymbol name => KnownActivity localEnv localSt queue name args result -> Text
knownActivityName _ = Text.pack $ symbolVal (Proxy @name)

knownWorkflowExample :: KnownWorkflow "queue" "name" '[Int, Text] Text
knownWorkflowExample = KnownWorkflow JSON

callKnownWorkflow :: Workflow () () (Task () () Text)
callKnownWorkflow = startChildWorkflow 
  undefined
  knownWorkflowExample
  1
  "hello"

knownActivityExample :: KnownActivity () () "queue" "name" '[Int, Text] Text
knownActivityExample = KnownActivity JSON

callKnownActivity :: Workflow () () (Task () () Text)
callKnownActivity = startActivity 
  undefined
  knownActivityExample
  1
  "hello"

startActivity :: 
  ( KnownSymbol queue
  , KnownSymbol name
  ) => StartActivityOptions -> KnownActivity env st queue name args result -> StartActivity env st result args
startActivity opts k@(KnownActivity codec) = gatherArgs codec $ \typedPayloads -> ilift $ do
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
        & Command.taskQueue .~ knownActivityQueue k -- rawTaskQueue (fromMaybe inst.workflowInstanceInfo.taskQueue opts.taskQueue)
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
  $(logDebug) "Add command: scheduleActivity"
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
    -- gatherArgs :: BuildArgs args (Compose (Workflow env st) (Task env st)) result
    -- gatherArgs = toPayloadsAp (pure codec) (knownActivityArgsProxy k) id

type family StartChildWorkflow env st (args :: [*]) baseResult where
  StartChildWorkflow env st '[] baseResult = Workflow env st (Task env st baseResult)
  StartChildWorkflow env st (a ': as) baseResult = a -> StartChildWorkflow env st as baseResult

data KnownWorkflow (queue :: Symbol) (name :: Symbol) (args :: [Type]) (result :: Type) = forall codec. 
  ( Codec codec result
  , AllArgsSupportCodec codec args
  ) => KnownWorkflow codec

data StartChildWorkflowOptions = StartChildWorkflowOptions 
  { childWorkflowId :: Maybe WorkflowId -- TODO should this be maybe?
  , taskQueue :: Maybe TaskQueue
  , cancellationType :: ChildWorkflowCancellationType
  , parentClosePolicy :: ParentClosePolicy
  , executionTimeout :: Maybe TimeSpec
  , runTimeout :: Maybe TimeSpec
  , taskTimeout :: Maybe TimeSpec
  , retryPolicy :: Maybe RetryPolicy
  , cronSchedule :: Maybe Text
  , memo :: Maybe (Map Text Proto.Temporal.Api.Common.V1.Message.Payload)
  , searchAttributes :: Maybe (Map Text Proto.Temporal.Api.Common.V1.Message.Payload)
  }

startChildWorkflow 
  :: StartChildWorkflowOptions 
  -> KnownWorkflow queue name args result 
  -> StartChildWorkflow env st args result
startChildWorkflow = undefined

data StartLocalActivityOptions = StartLocalActivityOptions 
  { -- TODO Activity name
    -- TODO args
    activityId :: Maybe ActivityId
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
  -> KnownActivity env st queue name args result
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
now = undefined

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
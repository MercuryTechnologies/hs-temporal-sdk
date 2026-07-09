{-# HLINT ignore "Use ?~" #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE QuantifiedConstraints #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilyDependencies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{- |
Module: Temporal.Client.Schedule
Description: Schedule Workflow executions

A Schedule contains instructions for starting a Workflow Execution at specific times. Schedules provide a more flexible and user-friendly approach than Temporal Cron Jobs.

= How to enable Schedules
A Schedule has an identity and is independent of a Workflow Execution. This differs from a Temporal Cron Job, which relies on a cron schedule as a property of the Workflow Execution.

== Action
The Action of a Schedule is where the Workflow Execution properties are established, such as Workflow Type, Task Queue, parameters, and timeouts.

Workflow Executions started by a Schedule have the following additional properties:

- The Action's timestamp is appended to the Workflow Id.
- The TemporalScheduledStartTime Search Attribute is added to the Workflow Execution. The value is the Action's timestamp.
- The TemporalScheduledById Search Attribute is added to the Workflow Execution. The value is the Schedule Id.
- The Schedule Spec describes when the Action is taken. There are two kinds of Schedule Spec:
  - A simple interval, like "every 30 minutes" (aligned to start at the Unix epoch, and optionally including a phase offset).
  - A calendar-based expression, similar to the "cron expressions" supported by lots of software, including the older Temporal Cron feature.

The following calendar JSON fields are available:

- year
- month
- dayOfMonth
- dayOfWeek
- hour
- minute
- second
- comment

Each field can contain a comma-separated list of ranges (or the * wildcard), and each range can include a slash followed by a skip value. The hour, minute, and second fields default to 0 while the others default to *, so you can describe many useful specs with only a few fields.

For month, names of months may be used instead of integers (case-insensitive, abbreviations permitted). For dayOfWeek, day-of-week names may be used.

The comment field is optional and can be used to include a free-form description of the intent of the calendar spec, useful for complicated specs.

No matter which form you supply, calendar and interval specs are converted to canonical representations. What you see when you "describe" or "list" a Schedule might not look exactly like what you entered, but it has the same meaning.

== Other Spec features

=== Multiple intervals/calendar expressions

A Spec can have combinations of multiple intervals and/or calendar expressions to define a specific Schedule.

=== Time bounds

Provide an absolute start or end time (or both) with a Spec to ensure that no actions are taken before the start time or after the end time.

=== Exclusions

A Spec can contain exclusions in the form of zero or more calendar expressions. This can be used to express scheduling like "each Monday at noon except for holidays. You'll have to provide your own set of exclusions and include it in each schedule; there are no pre-defined sets. (This feature isn't currently exposed in tctl or the Temporal Web UI.)

=== Jitter

If given, a random offset between zero and the maximum jitter is added to each Action time (but bounded by the time until the next scheduled Action).

== Time zones

By default, calendar-based expressions are interpreted in UTC. Temporal recommends using UTC to avoid various surprising properties of time zones. If you don't want to use UTC, you can provide the name of a time zone. The time zone definition is loaded on the Temporal Server Worker Service from either disk or the fallback embedded in the binary.

For more operational control, embed the contents of the time zone database file in the Schedule Spec itself. (Note: this isn't currently exposed in tctl or the web UI.)

== Pause
A Schedule can be Paused. When a Schedule is Paused, the Spec has no effect. However, you can still force manual actions by using the tctl schedule trigger command.

To assist communication among developers and operators, a “notes” field can be updated on pause or resume to store an explanation for the current state.

== Backfill
A Schedule can be Backfilled. When a Schedule is Backfilled, all the Actions that would have been taken over a specified time period are taken now (in parallel if the AllowAll Overlap Policy is used; sequentially if BufferAll is used). You might use this to fill in runs from a time period when the Schedule was paused due to an external condition that's now resolved, or a period before the Schedule was created.

== Limit number of Actions
A Schedule can be limited to a certain number of scheduled Actions (that is, not trigger immediately). After that it will act as if it were paused.

== Policies
A Schedule supports a set of Policies that enable customizing behavior.

=== Overlap Policy
The Overlap Policy controls what happens when it is time to start a Workflow Execution but a previously started Workflow Execution is still running. The following options are available:

Skip: Default. Nothing happens; the Workflow Execution is not started.
BufferOne: Starts the Workflow Execution as soon as the current one completes. The buffer is limited to one. If another Workflow Execution is supposed to start, but one is already in the buffer, only the one in the buffer eventually starts.
BufferAll: Allows an unlimited number of Workflows to buffer. They are started sequentially.
CancelOther: Cancels the running Workflow Execution, and then starts the new one after the old one completes cancellation.
TerminateOther: Terminates the running Workflow Execution and starts the new one immediately.
AllowAll Starts any number of concurrent Workflow Executions. With this policy (and only this policy), more than one Workflow Execution, started by the Schedule, can run simultaneously.
Catchup Window
The Temporal Cluster might be down or unavailable at the time when a Schedule should take an Action. When it comes back up, the Catchup Window controls which missed Actions should be taken at that point. The default is one minute, which means that the Schedule attempts to take any Actions that wouldn't be more than one minute late. An outage that lasts longer than the Catchup Window could lead to missed Actions. (But you can always Backfill.)

=== Pause-on-failure
If this policy is set, a Workflow Execution started by a Schedule that ends with a failure or timeout (but not Cancellation or Termination) causes the Schedule to automatically pause.

Note that with the AllowAll Overlap Policy, this pause might not apply to the next Workflow Execution, because the next Workflow Execution might have started before the failed one finished. It applies only to Workflow Executions that were scheduled to start after the failed one finished.

== Last completion result
A Workflow started by a Schedule can obtain the completion result from the most recent successful run. (How you do this depends on the SDK you're using.)

For overlap policies that don't allow overlap, “the most recent successful run” is straightforward to define. For the AllowAll policy, it refers to the run that completed most recently, at the time that the run in question is started. Consider the following overlapping runs:

@
time -------------------------------------------->
 A     |----------------------|
 B               |-------|
 C                          |---------------|
 D                                |--------------T
@

If D asks for the last completion result at time T, it gets the result of A. Not B, even though B started more recently, because A completed later. And not C, even though C completed after A, because the result for D is captured when D is started, not when it's queried.

Failures and timeouts do not affect the last completion result.

Last failure
A Workflow started by a Schedule can obtain the details of the failure of the most recent run that ended at the time when the Workflow in question was started. Unlike last completion result, a successful run does reset the last failure.

Limitations
Internally, a Schedule is implemented as a Workflow. If you're using Advanced Visibility (Elasticsearch), these Workflow Executions are hidden from normal views. If you're using Standard Visibility, they are visible, though there's no need to interact with them directly.
-}
module Temporal.Client.Schedule (
  mkScheduleClient,
  ScheduleClient,
  CreateScheduleRequest (..),
  createSchedule,
  deleteSchedule,
  listSchedules,
  ScheduleListInfo (..),
  ScheduleListEntry (..),
  ScheduleActionResult (..),
  ListSchedulesOptions (..),
  ListScheduleMatchingTimesOptions (..),
  listScheduleMatchingTimes,
  describeSchedule,
  DescribeScheduleResponse (..),
  patchSchedule,
  SchedulePatch (..),
  updateSchedule,
  UpdateScheduleRequest (..),
  ScheduleId (..),
  scheduleSpec,
  ScheduleSpec (..),
  Schedule (..),
  TriggerImmediatelyRequest (..),
  BackfillRequest (..),
  StructuredCalendarSpec (..),
  structuredCalendarSpec,
  calendarSpec,
  CalendarSpec (..),
  IntervalSpec (..),
  WorkflowExecution (..),
  ScheduleInfo (..),
  mkScheduleAction,
  ScheduleAction (..),
  SchedulePolicies (..),
  ScheduleState (..),
  PauseState (..),
  OverlapPolicy (..),
  Range (..),
  scheduleSpecToProto,
  scheduleSpecFromProto,
  scheduleActionToProto,
  scheduleActionFromProto,
  module Temporal.Duration,
) where

import Control.Monad
import Data.ByteString (ByteString)
import Data.Conduit
import Data.Int (Int32, Int64)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromMaybe)
import Data.Text (Text)
-- import Temporal.Client (StartWorkflowOptions(..), TimeoutOptions(..))

import Data.Time.Clock.System (SystemTime)
import Data.Vector (Vector)
import qualified Data.Vector as V
import GHC.Generics
import GHC.Records
import Proto.Encode (encodeMessage)
import qualified Proto.Temporal.Api.Common.V1.Message as C
import qualified Proto.Temporal.Api.Enums.V1.Schedule as S
import Proto.Temporal.Api.Enums.V1.TaskQueue (TaskQueueKind (..))
import qualified Proto.Temporal.Api.Schedule.V1.Message as S
import qualified Proto.Temporal.Api.Taskqueue.V1.Message as TQ
import qualified Proto.Temporal.Api.Workflow.V1.Message as W
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse as WF
import Temporal.Client
import Temporal.Common
import Temporal.Core.Client as Core
import qualified Temporal.Core.Client.WorkflowService as Core
import Temporal.Duration
import Temporal.Exception
import Temporal.Payload
import Temporal.SearchAttributes
import Temporal.SearchAttributes.Internal
import Temporal.Workflow hiding (yield)
import UnliftIO


searchAttributesMessageFromMap :: Map Text C.Payload -> C.SearchAttributes
searchAttributesMessageFromMap attrs =
  mempty
    { C.indexedFields =
        V.fromList
          (fmap (\(key, value) -> C.SearchAttributes'IndexedFieldsEntry (Just key) (Just value) []) (Map.toList attrs))
    }


searchAttributesMapFromMessage :: C.SearchAttributes -> Map Text C.Payload
searchAttributesMapFromMessage attrs =
  V.foldr
    ( \(C.SearchAttributes'IndexedFieldsEntry mKey mValue _) acc ->
        case (mKey, mValue) of
          (Just key, Just value) -> Map.insert key value acc
          _ -> acc
    )
    Map.empty
    (getField @"indexedFields" attrs)


headerMessageFromMap :: Map Text C.Payload -> C.Header
headerMessageFromMap headers =
  mempty
    { C.fields =
        V.fromList
          (fmap (\(key, value) -> C.Header'FieldsEntry (Just key) (Just value) []) (Map.toList headers))
    }


---------------------------------------------------------------------------------
-- ScheduleClient

mkScheduleClient :: Client -> Namespace -> ScheduleClient
mkScheduleClient c ns =
  ScheduleClient
    { scheduleClient = c
    , scheduleClientNamespace = ns
    }


data ScheduleClient = ScheduleClient
  { scheduleClient :: Client
  , scheduleClientNamespace :: Namespace
  }


instance HasField "identity" ScheduleClient Text where
  getField c = (Core.clientConfig c.scheduleClient).identity


data CreateScheduleRequest = CreateScheduleRequest
  { scheduleId :: !ScheduleId
  -- ^ The id of the new schedule.
  , schedule :: !Schedule
  -- ^ The schedule spec, policies, action, and initial state.
  , initialPatch :: !(Maybe SchedulePatch)
  -- ^ Optional initial patch (e.g. to run the action once immediately).
  , memo :: !(Map Text Payload)
  -- ^ Memo attached to the schedule itself.
  , requestId :: !Text
  -- ^ A unique identifier for this create request for idempotence. Typically UUIDv4.
  , searchAttributes :: !(Map SearchAttributeKey SearchAttributeType)
  -- ^ Search attributes attached to the schedule itself.
  }
  deriving stock (Show, Eq, Ord, Generic)


-- | Creates a new schedule.
createSchedule
  :: MonadIO m
  => ScheduleClient
  -> CreateScheduleRequest
  -> m ByteString
createSchedule s opts = liftIO $ do
  searchAttributes <- searchAttributesToProto opts.searchAttributes
  resp <- do
    eResp <-
      Core.createSchedule
        (scheduleClient s)
        ( mempty
            { WF.namespace = Just (rawNamespace s.scheduleClientNamespace)
            , WF.scheduleId = Just (rawScheduleId opts.scheduleId)
            , WF.schedule = Just (scheduleToProto opts.schedule)
            , WF.identity = Just s.identity
            , WF.initialPatch = schedulePatchToProto <$> opts.initialPatch
            , WF.memo = Just (convertToProtoMemo opts.memo)
            , WF.requestId = Just opts.requestId
            , WF.searchAttributes = Just (searchAttributesMessageFromMap searchAttributes)
            }
        )
    case eResp of
      Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
      Right resp -> pure resp
  pure $ fromMaybe "" (getField @"conflictToken" resp)


-- | Deletes a schedule, removing it from the system.
deleteSchedule
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> m ()
deleteSchedule c sId = do
  eResp <-
    liftIO $
      Core.deleteSchedule
        c.scheduleClient
        ( mempty
            { WF.namespace = Just (rawNamespace c.scheduleClientNamespace)
            , WF.identity = Just c.identity
            , WF.scheduleId = Just (rawScheduleId sId)
            }
        )
  case eResp of
    Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
    Right _ -> pure ()


data ListSchedulesOptions = ListSchedulesOptions
  { maximumPageSize :: Int32
  }
  deriving stock (Show, Eq, Ord, Generic)


data WorkflowExecution = WorkflowExecution
  { workflowId :: !WorkflowId
  , runId :: !RunId
  }
  deriving stock (Show, Eq, Ord, Generic)


workflowExecutionFromProto :: C.WorkflowExecution -> WorkflowExecution
workflowExecutionFromProto p =
  WorkflowExecution
    { workflowId = WorkflowId (fromMaybe "" (getField @"workflowId" p))
    , runId = RunId (fromMaybe "" (getField @"runId" p))
    }


data ScheduleListInfo = ScheduleListInfo
  { spec :: !(Maybe ScheduleSpec)
  , workflowType :: !WorkflowType
  , notes :: !Text
  , paused :: !Bool
  , recentActions :: ![ScheduleActionResult]
  , futureActionTimes :: ![SystemTime]
  }
  deriving stock (Show, Eq, Ord, Generic)


data ScheduleListEntry = ScheduleListEntry
  { scheduleId :: !ScheduleId
  , memo :: !(Map Text Payload)
  , searchAttributes :: !(Map SearchAttributeKey SearchAttributeType)
  , info :: !(Maybe ScheduleListInfo)
  }
  deriving stock (Show, Eq, Ord, Generic)


scheduleListInfoFromProto :: S.ScheduleListInfo -> ScheduleListInfo
scheduleListInfoFromProto p =
  ScheduleListInfo
    { spec = scheduleSpecFromProto <$> getField @"spec" p
    , workflowType = WorkflowType (fromMaybe "" (getField @"name" (fromMaybe mempty (getField @"workflowType" p))))
    , notes = fromMaybe "" (getField @"notes" p)
    , paused = fromMaybe False (getField @"paused" p)
    , recentActions = V.toList (scheduleActionResultFromProto <$> getField @"recentActions" p)
    , futureActionTimes = V.toList (timespecFromTimestamp <$> getField @"futureActionTimes" p)
    }


scheduleListEntryFromProto :: S.ScheduleListEntry -> IO ScheduleListEntry
scheduleListEntryFromProto p = do
  let searchAttrs :: Map Text C.Payload
      searchAttrs = searchAttributesMapFromMessage (fromMaybe mempty (getField @"searchAttributes" p))
  searchAttributes <- do
    res <- searchAttributesFromProto searchAttrs
    case res of
      Left err -> throwIO $ ValueError err
      Right attrs -> pure attrs

  pure $
    ScheduleListEntry
      { info = scheduleListInfoFromProto <$> getField @"info" p
      , scheduleId = ScheduleId (fromMaybe "" (getField @"scheduleId" p))
      , memo = convertFromProtoMemo (fromMaybe mempty (getField @"memo" p))
      , ..
      }


-- | List all schedules in a namespace.
listSchedules
  :: MonadIO m
  => ScheduleClient
  -> ListSchedulesOptions
  -> ConduitT () (Vector ScheduleListEntry) m ()
listSchedules c opts = go ""
  where
    go tok = do
      resp <- liftIO do
        eResp <-
          Core.listSchedules
            c.scheduleClient
            ( mempty
                { WF.namespace = Just (rawNamespace c.scheduleClientNamespace)
                , WF.maximumPageSize = Just opts.maximumPageSize
                , WF.nextPageToken = Just tok
                }
            )
        case eResp of
          Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
          Right resp -> pure resp
      unless (V.null (getField @"schedules" resp)) $ do
        liftIO (traverse scheduleListEntryFromProto (getField @"schedules" resp)) >>= yield
      if fromMaybe "" (getField @"nextPageToken" resp) == "" || V.null (getField @"schedules" resp)
        then pure ()
        else go (fromMaybe "" (getField @"nextPageToken" resp))


data ListScheduleMatchingTimesOptions = ListScheduleMatchingTimesOptions
  { scheduleId :: !ScheduleId
  , startTime :: !SystemTime
  , endTime :: !SystemTime
  }
  deriving stock (Show, Eq, Ord, Generic)


-- | Lists matching times within a range.
listScheduleMatchingTimes
  :: MonadIO m
  => ScheduleClient
  -> ListScheduleMatchingTimesOptions
  -> m (Vector SystemTime)
listScheduleMatchingTimes c opts = do
  resp <-
    liftIO do
      eResp <-
        Core.listScheduleMatchingTimes
          c.scheduleClient
          ( mempty
              { WF.namespace = Just (rawNamespace c.scheduleClientNamespace)
              , WF.scheduleId = Just (rawScheduleId opts.scheduleId)
              , WF.startTime = Just (timespecToTimestamp opts.startTime)
              , WF.endTime = Just (timespecToTimestamp opts.endTime)
              }
          )
      case eResp of
        Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
        Right resp -> pure resp
  pure $ timespecFromTimestamp <$> getField @"startTime" resp


data ScheduleActionResult = ScheduleActionResult
  { scheduleTime :: !SystemTime
  , actualTime :: !SystemTime
  , startWorkflowResult :: !WorkflowExecution
  }
  deriving stock (Show, Eq, Ord, Generic)


scheduleActionResultFromProto :: S.ScheduleActionResult -> ScheduleActionResult
scheduleActionResultFromProto p =
  ScheduleActionResult
    { scheduleTime = timespecFromTimestamp (fromMaybe mempty (getField @"scheduleTime" p))
    , actualTime = timespecFromTimestamp (fromMaybe mempty (getField @"actualTime" p))
    , startWorkflowResult = workflowExecutionFromProto (fromMaybe mempty (getField @"startWorkflowResult" p))
    }


data ScheduleInfo = ScheduleInfo
  { actionCount :: !Int64
  -- ^ Number of actions taken so far.
  , missedCatchupWindow :: !Int64
  -- ^ Number of times a scheduled action was skipped due to missing the catchup window.
  , overlapSkipped :: !Int64
  -- ^ Number of skipped actions due to overlap.
  , runningWorkflows :: [WorkflowExecution]
  -- ^ Currently-running workflows started by this schedule. (There might be
  -- more than one if the overlap policy allows overlaps.)
  -- Note that the run_ids in here are the original execution run ids as
  -- started by the schedule. If the workflows retried, did continue-as-new,
  -- or were reset, they might still be running but with a different run_id.
  , recentActions :: [ScheduleActionResult]
  -- ^ Most recent ten actual action times (including manual triggers).
  , futureActionTimes :: [SystemTime]
  -- ^ Next ten scheduled action times.
  , createTime :: !(Maybe SystemTime)
  -- ^ Timestamp of schedule creation.
  , updateTime :: !(Maybe SystemTime)
  -- ^ Timestamp of last update.
  , invalidScheduleError :: !Text
  -- ^ deprecated
  }
  deriving stock (Show, Eq, Generic)


scheduleInfoFromProto :: S.ScheduleInfo -> ScheduleInfo
scheduleInfoFromProto p =
  ScheduleInfo
    { actionCount = fromMaybe 0 (getField @"actionCount" p)
    , missedCatchupWindow = fromMaybe 0 (getField @"missedCatchupWindow" p)
    , overlapSkipped = fromMaybe 0 (getField @"overlapSkipped" p)
    , runningWorkflows = V.toList (workflowExecutionFromProto <$> getField @"runningWorkflows" p)
    , recentActions = V.toList (scheduleActionResultFromProto <$> getField @"recentActions" p)
    , futureActionTimes = V.toList (timespecFromTimestamp <$> getField @"futureActionTimes" p)
    , createTime = timespecFromTimestamp <$> getField @"createTime" p
    , updateTime = timespecFromTimestamp <$> getField @"updateTime" p
    , invalidScheduleError = fromMaybe "" (getField @"invalidScheduleError" p)
    }


data Schedule = Schedule
  { spec :: !ScheduleSpec
  , action :: !ScheduleAction
  , policies :: !SchedulePolicies
  , state :: !ScheduleState
  }
  deriving stock (Show, Eq, Ord, Generic)


scheduleToProto :: Schedule -> S.Schedule
scheduleToProto p =
  mempty
    { S.spec = Just (scheduleSpecToProto p.spec)
    , S.action = Just (scheduleActionToProto p.action)
    , S.policies = Just (schedulePoliciesToProto p.policies)
    , S.state = Just (scheduleStateToProto p.state)
    }


{- | The set of policies that can be used to customize scheduling behavior.

https://docs.temporal.io/schedule#policies
-}
data SchedulePolicies = SchedulePolicies
  { overlapPolicy :: !OverlapPolicy
  -- ^ Policy for overlaps.
  --
  -- Note that this can be changed after a schedule has taken some actions,
  -- and some changes might produce unintuitive results. In general, the later
  -- policy overrides the earlier policy.
  --
  -- https://docs.temporal.io/schedule#overlap-policy
  , catchupWindow :: !(Maybe Duration)
  -- ^ Policy for catchups:
  --
  -- If the Temporal server misses an action due to one or more components
  -- being down, and comes back up, the action will be run if the scheduled
  -- time is within this window from the current time.
  --
  -- This value defaults to 1 year, and can't be less than 10 seconds.
  --
  -- https://docs.temporal.io/schedule#catchup-window
  , pauseOnFailure :: !Bool
  -- ^ If true, and a workflow run fails or times out, turn on "paused".
  -- This applies after retry policies: the full chain of retries must fail to
  -- trigger a pause here.
  --
  -- https://docs.temporal.io/schedule#pause-on-failure
  }
  deriving stock (Show, Eq, Ord, Generic)


schedulePoliciesToProto :: SchedulePolicies -> S.SchedulePolicies
schedulePoliciesToProto p =
  mempty
    { S.overlapPolicy = Just (overlapPolicyToProto p.overlapPolicy)
    , S.catchupWindow = durationToProto <$> p.catchupWindow
    , S.pauseOnFailure = Just p.pauseOnFailure
    }


schedulePoliciesFromProto :: S.SchedulePolicies -> SchedulePolicies
schedulePoliciesFromProto p =
  SchedulePolicies
    { overlapPolicy = overlapPolicyFromProto (fromMaybe S.ScheduleOverlapPolicy'ScheduleOverlapPolicyUnspecified (getField @"overlapPolicy" p))
    , catchupWindow = durationFromProto <$> getField @"catchupWindow" p
    , pauseOnFailure = fromMaybe False (getField @"pauseOnFailure" p)
    }


data OverlapPolicy
  = Unspecified
  | -- | Skip (default) means don't start anything. When the
    -- workflow completes, the next scheduled event after that time will be considered.
    Skip
  | -- | BufferOne means start the workflow again soon as the
    -- current one completes, but only buffer one start in this way. If another start is
    -- supposed to happen when the workflow is running, and one is already buffered, then
    -- only the first one will be started after the running workflow finishes.
    BufferOne
  | -- | BufferAll means buffer up any number of starts to all
    -- happen sequentially, immediately after the running workflow completes.
    BufferAll
  | -- | CancelOther means that if there is another workflow
    -- running, cancel it, and start the new one after the old one completes cancellation.
    CancelOther
  | -- | TerminateOther means that if there is another workflow
    -- running, terminate it and start the new one immediately.
    TerminateOther
  | -- | AllowAll means start any number of concurrent workflows.
    -- Note that with this policy, last completion result and last failure will not be
    -- available since workflows are not sequential.
    AllowAll
  | OverlapPolicyUnrecognized
  deriving stock (Show, Eq, Ord, Generic)


overlapPolicyToProto :: OverlapPolicy -> S.ScheduleOverlapPolicy
overlapPolicyToProto p = case p of
  Unspecified -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicyUnspecified
  Skip -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicySkip
  BufferOne -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicyBufferOne
  BufferAll -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicyBufferAll
  CancelOther -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicyCancelOther
  TerminateOther -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicyTerminateOther
  AllowAll -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicyAllowAll
  OverlapPolicyUnrecognized -> S.ScheduleOverlapPolicy'ScheduleOverlapPolicyUnspecified


overlapPolicyFromProto :: S.ScheduleOverlapPolicy -> OverlapPolicy
overlapPolicyFromProto p = case p of
  S.ScheduleOverlapPolicy'ScheduleOverlapPolicyUnspecified -> Unspecified
  S.ScheduleOverlapPolicy'ScheduleOverlapPolicySkip -> Skip
  S.ScheduleOverlapPolicy'ScheduleOverlapPolicyBufferOne -> BufferOne
  S.ScheduleOverlapPolicy'ScheduleOverlapPolicyBufferAll -> BufferAll
  S.ScheduleOverlapPolicy'ScheduleOverlapPolicyCancelOther -> CancelOther
  S.ScheduleOverlapPolicy'ScheduleOverlapPolicyTerminateOther -> TerminateOther
  S.ScheduleOverlapPolicy'ScheduleOverlapPolicyAllowAll -> AllowAll
  _ -> OverlapPolicyUnrecognized


data ScheduleState = ScheduleState
  { notes :: !Text
  -- ^ Informative human-readable message with contextual notes, e.g. the reason
  -- a schedule is paused. The system may overwrite this message on certain
  -- conditions, e.g. when pause-on-failure happens.
  , paused :: !Bool
  -- ^ If true, do not take any actions based on the schedule spec.
  , limitedActions :: !Bool
  -- ^ If limited_actions is true, decrement remaining_actions after each
  -- action, and do not take any more scheduled actions if remaining_actions
  -- is zero. Actions may still be taken by explicit request (i.e. trigger
  -- immediately or backfill). Skipped actions (due to overlap policy) do not
  -- count against remaining actions.
  , remainingActions :: !Int64
  }
  deriving stock (Show, Eq, Ord, Generic)


scheduleStateToProto :: ScheduleState -> S.ScheduleState
scheduleStateToProto p =
  mempty
    { S.notes = Just p.notes
    , S.paused = Just p.paused
    , S.limitedActions = Just p.limitedActions
    , S.remainingActions = Just p.remainingActions
    }


scheduleStateFromProto :: S.ScheduleState -> ScheduleState
scheduleStateFromProto p =
  ScheduleState
    { notes = fromMaybe "" (getField @"notes" p)
    , paused = fromMaybe False (getField @"paused" p)
    , limitedActions = fromMaybe False (getField @"limitedActions" p)
    , remainingActions = fromMaybe 0 (getField @"remainingActions" p)
    }


data ScheduleAction
  = StartWorkflow W.NewWorkflowExecutionInfo
  | ScheduleActionUnrecognized
  deriving stock (Eq, Show)


instance Ord ScheduleAction where
  compare (StartWorkflow left) (StartWorkflow right) =
    compare (encodeMessage left) (encodeMessage right)
  compare StartWorkflow {} ScheduleActionUnrecognized = LT
  compare ScheduleActionUnrecognized StartWorkflow {} = GT
  compare ScheduleActionUnrecognized ScheduleActionUnrecognized = EQ


mkScheduleAction
  :: forall wf m
   . (MonadIO m, WorkflowRef wf)
  => wf
  -> WorkflowId
  -- ^ Unlike other uses of WorkflowId, this will be used as a prefix for the
  -- actual workflow id, which will be unique.
  -> StartWorkflowOptions
  -- ^ All fields of 'StartWorkflowOptions' are valid except for the workflow id reuse policy and cron string.
  --
  -- The workflow id will generally have a timestamp appended for uniqueness.
  -> (WorkflowArgs wf :->: m ScheduleAction)
mkScheduleAction (workflowRef -> KnownWorkflow codec wfName) (WorkflowId wfId) opts = withArgs @(WorkflowArgs wf) @(m ScheduleAction) codec $ \inputs -> liftIO $ do
  searchAttrs <- searchAttributesToProto opts.searchAttributes
  inputs' <- sequence inputs
  let tq = rawTaskQueue opts.taskQueue
      executionInfo =
        mempty
          { W.workflowId = Just wfId
          , W.workflowType = Just ((mempty :: C.WorkflowType) {C.name = Just wfName})
          , W.taskQueue =
              Just
                ( mempty
                    { TQ.name = Just tq
                    , TQ.kind = Just TaskQueueKind'TaskQueueKindUnspecified
                    }
                )
          , W.input = Just (mempty {C.payloads = convertToProtoPayload <$> inputs'})
          , W.workflowExecutionTimeout = durationToProto <$> opts.timeouts.executionTimeout
          , W.workflowRunTimeout = durationToProto <$> opts.timeouts.runTimeout
          , W.workflowTaskTimeout = durationToProto <$> opts.timeouts.taskTimeout
          , W.retryPolicy = retryPolicyToProto <$> opts.retryPolicy
          , W.memo = Just (convertToProtoMemo opts.memo)
          , W.searchAttributes = Just (searchAttributesMessageFromMap searchAttrs)
          , W.header = Just (headerMessageFromMap (convertToProtoPayload <$> opts.headers))
          }
  pure $ StartWorkflow executionInfo


scheduleActionToProto :: ScheduleAction -> S.ScheduleAction
scheduleActionToProto a = case a of
  StartWorkflow wf -> mempty {S.action = Just (S.ScheduleAction'Action'StartWorkflow wf)}
  ScheduleActionUnrecognized -> mempty


scheduleActionFromProto :: S.ScheduleAction -> ScheduleAction
scheduleActionFromProto a = case getField @"action" a of
  Nothing -> ScheduleActionUnrecognized
  Just a' -> case a' of
    S.ScheduleAction'Action'StartWorkflow wf -> StartWorkflow wf


scheduleFromProto :: S.Schedule -> Schedule
scheduleFromProto p =
  Schedule
    { spec = scheduleSpecFromProto (fromMaybe mempty (getField @"spec" p))
    , action = scheduleActionFromProto (fromMaybe mempty (getField @"action" p))
    , policies = schedulePoliciesFromProto (fromMaybe mempty (getField @"policies" p))
    , state = scheduleStateFromProto (fromMaybe mempty (getField @"state" p))
    }


data DescribeScheduleResponse = DescribeScheduleResponse
  { schedule :: !Schedule
  -- ^
  -- The complete current schedule details. This may not match the schedule as
  -- created because:
  -- - some types of schedule specs may get compiled into others (e.g. CronString into StructuredCalendarSpec)
  -- - some unspecified fields may be replaced by defaults
  -- - some fields in the state are modified automatically
  -- - the schedule may have been modified by UpdateSchedule or PatchSchedule
  , info :: !ScheduleInfo
  -- ^ Extra schedule state info.
  , memo :: !(Map Text Payload)
  -- ^ The memo that the schedule was created with.
  , searchAttributes :: !(Map SearchAttributeKey SearchAttributeType)
  -- ^ The search attributes that the schedule was created with.
  , conflictToken :: !ByteString
  -- ^ This value can be passed back to UpdateSchedule to ensure that the
  -- schedule was not modified between a Describe and an Update, which could
  -- lead to lost updates and other confusion.
  }
  deriving stock (Show, Eq, Generic)


-- | Returns the schedule description and current state of an existing schedule.
describeSchedule
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> m DescribeScheduleResponse
describeSchedule c (ScheduleId s) = liftIO $ do
  eResp <-
    Core.describeSchedule
      c.scheduleClient
      ( mempty
          { WF.namespace = Just (rawNamespace c.scheduleClientNamespace)
          , WF.scheduleId = Just s
          }
      )
  case eResp of
    Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
    Right res -> do
      resp <- searchAttributesFromProto (searchAttributesMapFromMessage (fromMaybe mempty (getField @"searchAttributes" res)))
      case resp of
        Left err -> throwIO $ ValueError err
        Right searchAttributes ->
          pure $
            DescribeScheduleResponse
              { schedule = scheduleFromProto (fromMaybe mempty (getField @"schedule" res))
              , info = scheduleInfoFromProto (fromMaybe mempty (getField @"info" res))
              , memo = convertFromProtoMemo (fromMaybe mempty (getField @"memo" res))
              , searchAttributes = searchAttributes
              , conflictToken = fromMaybe "" (getField @"conflictToken" res)
              }


data TriggerImmediatelyRequest = TriggerImmediatelyRequest
  { overlapPolicy :: !OverlapPolicy
  }
  deriving stock (Show, Eq, Ord, Generic)


triggerImmediatelyRequestToProto :: TriggerImmediatelyRequest -> S.TriggerImmediatelyRequest
triggerImmediatelyRequestToProto p =
  mempty
    { S.overlapPolicy = Just (overlapPolicyToProto p.overlapPolicy)
    }


data BackfillRequest = BackfillRequest
  { startTime :: !SystemTime
  -- ^ Start of time range to evaluate schedule in.
  , endTime :: !SystemTime
  -- ^ End of time range to evaluate schedule in.
  , overlapPolicy :: !OverlapPolicy
  -- ^ Override overlap policy for this request.
  }
  deriving stock (Show, Eq, Ord, Generic)


backfillRequestToProto :: BackfillRequest -> S.BackfillRequest
backfillRequestToProto p =
  mempty
    { S.startTime = Just (timespecToTimestamp p.startTime)
    , S.endTime = Just (timespecToTimestamp p.endTime)
    , S.overlapPolicy = Just (overlapPolicyToProto p.overlapPolicy)
    }


data PauseState = Unpause !Text | Pause !Text
  deriving stock (Show, Eq, Ord, Generic)


data SchedulePatch = SchedulePatch
  { triggerImmediately :: !(Maybe TriggerImmediatelyRequest)
  -- ^ If set, trigger one action immediately.
  , backfillRequest :: ![BackfillRequest]
  -- ^ If set, runs though the specified time period(s) and takes actions as if that time
  -- passed by right now, all at once. The overlap policy can be overridden for the
  -- scope of the backfill.
  , pauseState :: !(Maybe PauseState)
  -- ^ If set, change the state and set the
  -- notes field to the value of the string.
  , requestId :: !Text
  }
  deriving stock (Show, Eq, Ord, Generic)


schedulePatchToProto :: SchedulePatch -> S.SchedulePatch
schedulePatchToProto p =
  mempty
    { S.triggerImmediately = triggerImmediatelyRequestToProto <$> p.triggerImmediately
    , S.backfillRequest = V.fromList (backfillRequestToProto <$> p.backfillRequest)
    , S.pause = case p.pauseState of
        Just (Pause notes) -> Just notes
        _ -> Nothing
    , S.unpause = case p.pauseState of
        Just (Unpause notes) -> Just notes
        _ -> Nothing
    }


-- | Makes a specific change to a schedule or triggers an immediate action.
patchSchedule
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> SchedulePatch
  -> m ()
patchSchedule c (ScheduleId s) p = liftIO $ do
  eResp <-
    Core.patchSchedule
      c.scheduleClient
      ( mempty
          { WF.namespace = Just (rawNamespace c.scheduleClientNamespace)
          , WF.scheduleId = Just s
          , WF.patch = Just (schedulePatchToProto p)
          , WF.identity = Just c.identity
          , WF.requestId = Just p.requestId
          }
      )
  case eResp of
    Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
    Right _ -> pure ()


data UpdateScheduleRequest = UpdateScheduleRequest
  { schedule :: !Schedule
  -- ^ The new schedule. The four main fields of the schedule (spec, action,
  -- policies, state) are replaced completely by the values in this message.
  , conflictToken :: !(Maybe ByteString)
  -- ^ This can be the value of conflict_token from a DescribeScheduleResponse,
  -- which will cause this request to fail if the schedule has been modified
  -- between the Describe and this Update.
  -- If missing, the schedule will be updated unconditionally.
  , requestId :: !Text
  -- ^ A unique identifier for this update request for idempotence. Typically UUIDv4.
  }
  deriving stock (Show, Eq, Generic)


updateSchedule
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> UpdateScheduleRequest
  -> m ()
updateSchedule c (ScheduleId s) u = liftIO $ do
  _resp <- do
    eResp <-
      Core.updateSchedule
        c.scheduleClient
        ( mempty
            { WF.namespace = Just (rawNamespace c.scheduleClientNamespace)
            , WF.scheduleId = Just s
            , WF.schedule = Just (scheduleToProto u.schedule)
            , WF.conflictToken = Just (fromMaybe "" u.conflictToken)
            , WF.identity = Just c.identity
            , WF.requestId = Just u.requestId
            }
        )
    case eResp of
      Left err -> throwIO $ Temporal.Exception.coreRpcErrorToRpcError err
      Right _ -> pure ()
  pure ()


scheduleSpec :: ScheduleSpec
scheduleSpec =
  ScheduleSpec
    { structuredCalendar = mempty
    , cronString = mempty
    , calendar = mempty
    , interval = mempty
    , excludeCalendar = mempty
    , excludeStructuredCalendar = mempty
    , startTime = Nothing
    , endTime = Nothing
    , jitter = Nothing
    , timezoneName = "UTC"
    , timezoneData = Nothing
    }


{- | ScheduleSpec is a complete description of a set of absolute timestamps
(possibly infinite) that an action should occur at. The meaning of a
ScheduleSpec depends only on its contents and never changes, except that the
definition of a time zone can change over time (most commonly, when daylight
saving time policy changes for an area). To create a totally self-contained
ScheduleSpec, use UTC or include timezone_data.

For input, you can provide zero or more of: structured_calendar, calendar,
cron_string, interval, and exclude_structured_calendar, and all of them will
be used (the schedule will take action at the union of all of their times,
minus the ones that match exclude_structured_calendar).

On input, calendar and cron_string fields will be compiled into
structured_calendar (and maybe interval and timezone_name), so if you
Describe a schedule, you'll see only structured_calendar, interval, etc.
-}
data ScheduleSpec = ScheduleSpec
  { structuredCalendar :: [StructuredCalendarSpec]
  -- ^ Calendar-based specifications of times.
  , cronString :: [Text]
  -- ^ cron_string holds a traditional cron specification as a string. It
  -- accepts 5, 6, or 7 fields, separated by spaces, and interprets them the
  -- same way as CalendarSpec.
  --
  -- * 5 fields:         minute, hour, day_of_month, month, day_of_week
  -- * 6 fields:         minute, hour, day_of_month, month, day_of_week, year
  -- * 7 fields: second, minute, hour, day_of_month, month, day_of_week, year
  --
  -- If year is not given, it defaults to *. If second is not given, it
  -- defaults to 0.
  --
  -- Shorthands @yearly, @monthly, @weekly, @daily, and @hourly are also
  -- accepted instead of the 5-7 time fields.
  --
  -- Optionally, the string can be preceded by CRON_TZ=<timezone name> or
  -- TZ=<timezone name>, which will get copied to timezone_name. (There must
  -- not also be a timezone_name present.)
  -- Optionally "#" followed by a comment can appear at the end of the string.
  -- Note that the special case that some cron implementations have for
  -- treating day_of_month and day_of_week as "or" instead of "and" when both
  -- are set is not implemented.
  -- @every <interval>[/<phase>] is accepted and gets compiled into an
  -- IntervalSpec instead. <interval> and <phase> should be a decimal integer
  -- with a unit suffix s, m, h, or d.
  , calendar :: [CalendarSpec]
  -- ^ Calendar-based specifications of times.
  , interval :: [IntervalSpec]
  -- ^ Interval-based specifications of times.
  , excludeCalendar :: [CalendarSpec]
  -- ^ Any timestamps matching any of exclude_* will be skipped.
  , excludeStructuredCalendar :: [StructuredCalendarSpec]
  -- ^ Any timestamps matching any of exclude_* will be skipped.
  , startTime :: Maybe SystemTime
  -- ^ If startTime is set, any timestamps before startTime will be skipped.
  -- (Together, startTime and endTime make an inclusive interval.)
  , endTime :: Maybe SystemTime
  -- ^ If endTime is set, any timestamps after endTime will be skipped.
  , jitter :: Maybe Duration
  -- ^ All timestamps will be incremented by a random value from 0 to this
  -- amount of jitter. Default: 0
  , timezoneName :: Text
  -- ^ Time zone to interpret all calendar-based specs in.
  --
  -- If unset, defaults to UTC. We recommend using UTC for your application if
  -- at all possible, to avoid various surprising properties of time zones.
  --
  -- Time zones may be provided by name, corresponding to names in the IANA
  -- time zone database (see https://www.iana.org/time-zones). The definition
  -- will be loaded by the Temporal server from the environment it runs in.
  --
  -- If your application requires more control over the time zone definition
  -- used, it may pass in a complete definition in the form of a TZif file
  -- from the time zone database. If present, this will be used instead of
  -- loading anything from the environment. You are then responsible for
  -- updating timezone_data when the definition changes.
  --
  -- Calendar spec matching is based on literal matching of the clock time
  -- with no special handling of DST: if you write a calendar spec that fires
  -- at 2:30am and specify a time zone that follows DST, that action will not
  -- be triggered on the day that has no 2:30am. Similarly, an action that
  -- fires at 1:30am will be triggered twice on the day that has two 1:30s.
  --
  -- Also note that no actions are taken on leap-seconds (e.g. 23:59:60 UTC).
  , timezoneData :: Maybe ByteString
  -- ^ Some time zone definitions are not available in the IANA database, or
  -- are not available in the version of the database that the Temporal
  -- server is using. In this case, you can provide a complete definition in
  -- the form of a TZif file from the time zone database. If present, this
  -- will be used instead of loading anything from the environment. You are
  -- then responsible for updating timezone_data when the definition changes.
  }
  deriving stock (Eq, Ord, Show, Generic)


scheduleSpecToProto :: ScheduleSpec -> S.ScheduleSpec
scheduleSpecToProto p =
  mempty
    { S.structuredCalendar = V.fromList (structuredCalendarSpecToProto <$> p.structuredCalendar)
    , S.cronString = V.fromList p.cronString
    , S.calendar = V.fromList (calendarSpecToProto <$> p.calendar)
    , S.interval = V.fromList (intervalSpecToProto <$> p.interval)
    , S.excludeCalendar = V.fromList (calendarSpecToProto <$> p.excludeCalendar)
    , S.excludeStructuredCalendar = V.fromList (structuredCalendarSpecToProto <$> p.excludeStructuredCalendar)
    , S.startTime = timespecToTimestamp <$> p.startTime
    , S.endTime = timespecToTimestamp <$> p.endTime
    , S.jitter = durationToProto <$> p.jitter
    , S.timezoneName = Just p.timezoneName
    , S.timezoneData = Just (fromMaybe "" p.timezoneData)
    }


scheduleSpecFromProto :: S.ScheduleSpec -> ScheduleSpec
scheduleSpecFromProto p =
  ScheduleSpec
    { structuredCalendar = V.toList (structuredCalendarSpecFromProto <$> getField @"structuredCalendar" p)
    , cronString = V.toList (getField @"cronString" p)
    , calendar = V.toList (calendarSpecFromProto <$> getField @"calendar" p)
    , interval = V.toList (intervalSpecFromProto <$> getField @"interval" p)
    , excludeCalendar = V.toList (calendarSpecFromProto <$> getField @"excludeCalendar" p)
    , excludeStructuredCalendar = V.toList (structuredCalendarSpecFromProto <$> getField @"excludeStructuredCalendar" p)
    , startTime = timespecFromTimestamp <$> getField @"startTime" p
    , endTime = timespecFromTimestamp <$> getField @"endTime" p
    , jitter = durationFromProto <$> getField @"jitter" p
    , timezoneName = fromMaybe "" (getField @"timezoneName" p)
    , timezoneData = getField @"timezoneData" p
    }


{- | Range represents a set of integer values, used to match fields of a calendar
time in StructuredCalendarSpec. If end < start, then end is interpreted as
equal to start. This means you can use a Range with start set to a value, and
end and step unset (defaulting to 0) to represent a single value.
-}
data Range = Range
  { start :: !Int32
  -- ^ Start of range (inclusive).
  , end :: !Int32
  -- ^ End of range (inclusive).
  , step :: !Int32
  -- ^ Step (optional, default 1).
  }
  deriving stock (Eq, Ord, Show, Generic)


rangeToProto :: Range -> S.Range
rangeToProto p =
  mempty
    { S.start = Just p.start
    , S.end = Just p.end
    , S.step = Just p.step
    }


rangeFromProto :: S.Range -> Range
rangeFromProto p =
  Range
    { start = fromMaybe 0 (getField @"start" p)
    , end = fromMaybe 0 (getField @"end" p)
    , step = fromMaybe 0 (getField @"step" p)
    }


{- | StructuredCalendarSpec describes an event specification relative to the
calendar, in a form that's easy to work with programmatically. Each field can
be one or more ranges.

A timestamp matches if at least one range of each field matches the
corresponding fields of the timestamp, except for year: if year is missing,
that means all years match. For all fields besides year, at least one Range
must be present to match anything.
-}
data StructuredCalendarSpec = StructuredCalendarSpec
  { second :: [Range]
  -- ^ Match seconds (0-59)
  , minute :: [Range]
  -- ^ Match minutes (0-59)
  , hour :: [Range]
  -- ^ Match hours (0-23)
  , dayOfMonth :: [Range]
  -- ^ Match days of the month (1-31)
  , month :: [Range]
  -- ^ Match months (1-12)
  , year :: [Range]
  -- ^ Match years.
  , dayOfWeek :: [Range]
  -- ^ Match days of the week (0-6; 0 is Sunday).
  , comment :: Text
  -- ^ Free-form comment describing the intention of this spec.
  }
  deriving stock (Eq, Ord, Show, Generic)


structuredCalendarSpec :: StructuredCalendarSpec
structuredCalendarSpec =
  StructuredCalendarSpec
    { second = mempty
    , minute = mempty
    , hour = mempty
    , dayOfMonth = mempty
    , month = mempty
    , year = mempty
    , dayOfWeek = mempty
    , comment = mempty
    }


structuredCalendarSpecToProto :: StructuredCalendarSpec -> S.StructuredCalendarSpec
structuredCalendarSpecToProto p =
  mempty
    { S.second = V.fromList (rangeToProto <$> p.second)
    , S.minute = V.fromList (rangeToProto <$> p.minute)
    , S.hour = V.fromList (rangeToProto <$> p.hour)
    , S.dayOfMonth = V.fromList (rangeToProto <$> p.dayOfMonth)
    , S.month = V.fromList (rangeToProto <$> p.month)
    , S.year = V.fromList (rangeToProto <$> p.year)
    , S.dayOfWeek = V.fromList (rangeToProto <$> p.dayOfWeek)
    , S.comment = Just p.comment
    }


structuredCalendarSpecFromProto :: S.StructuredCalendarSpec -> StructuredCalendarSpec
structuredCalendarSpecFromProto p =
  StructuredCalendarSpec
    { second = V.toList (rangeFromProto <$> getField @"second" p)
    , minute = V.toList (rangeFromProto <$> getField @"minute" p)
    , hour = V.toList (rangeFromProto <$> getField @"hour" p)
    , dayOfMonth = V.toList (rangeFromProto <$> getField @"dayOfMonth" p)
    , month = V.toList (rangeFromProto <$> getField @"month" p)
    , year = V.toList (rangeFromProto <$> getField @"year" p)
    , dayOfWeek = V.toList (rangeFromProto <$> getField @"dayOfWeek" p)
    , comment = fromMaybe "" (getField @"comment" p)
    }


data CalendarSpec = CalendarSpec
  { second :: !Text
  , -- \^ Expression to match seconds. Default: 0
    minute :: !Text
  -- ^ Expression to match minutes. Default: 0
  , hour :: !Text
  -- ^ Expression to match hours. Default: 0
  , dayOfMonth :: !Text
  -- ^ Expression to match days of the month. Default: *
  , month :: !Text
  -- ^ Expression to match months. Default: *
  , year :: !Text
  -- ^ Expression to match years. Default: *
  , dayOfWeek :: !Text
  -- ^ Expression to match days of the week. Default: *
  , comment :: !Text
  -- ^ Free-form comment describing the intention of this spec.
  }
  deriving stock (Eq, Ord, Show, Generic)


calendarSpec :: CalendarSpec
calendarSpec =
  CalendarSpec
    { second = "0"
    , minute = "0"
    , hour = "0"
    , dayOfMonth = "*"
    , month = "*"
    , year = "*"
    , dayOfWeek = "*"
    , comment = ""
    }


calendarSpecToProto :: CalendarSpec -> S.CalendarSpec
calendarSpecToProto p =
  mempty
    { S.second = Just p.second
    , S.minute = Just p.minute
    , S.hour = Just p.hour
    , S.dayOfMonth = Just p.dayOfMonth
    , S.month = Just p.month
    , S.year = Just p.year
    , S.dayOfWeek = Just p.dayOfWeek
    , S.comment = Just p.comment
    }


calendarSpecFromProto :: S.CalendarSpec -> CalendarSpec
calendarSpecFromProto p =
  CalendarSpec
    { second = fromMaybe "" (getField @"second" p)
    , minute = fromMaybe "" (getField @"minute" p)
    , hour = fromMaybe "" (getField @"hour" p)
    , dayOfMonth = fromMaybe "" (getField @"dayOfMonth" p)
    , month = fromMaybe "" (getField @"month" p)
    , year = fromMaybe "" (getField @"year" p)
    , dayOfWeek = fromMaybe "" (getField @"dayOfWeek" p)
    , comment = fromMaybe "" (getField @"comment" p)
    }


{- | IntervalSpec matches times that can be expressed as:

> epoch + n * interval + phase

where n is an integer.
phase defaults to zero if missing. interval is required.
Both interval and phase must be non-negative and are truncated to the nearest
second before any calculations.
For example, an interval of 1 hour with phase of zero would match every hour,
on the hour. The same interval but a phase of 19 minutes would match every
xx:19:00. An interval of 28 days with phase zero would match
2022-02-17T00:00:00Z (among other times). The same interval with a phase of 3
days, 5 hours, and 23 minutes would match 2022-02-20T05:23:00Z instead.
-}
data IntervalSpec = IntervalSpec
  { interval :: !Duration
  , phase :: !(Maybe Duration)
  }
  deriving stock (Eq, Show, Ord, Generic)


intervalSpecToProto :: IntervalSpec -> S.IntervalSpec
intervalSpecToProto p =
  mempty
    { S.interval = Just (durationToProto p.interval)
    , S.phase = durationToProto <$> p.phase
    }


intervalSpecFromProto :: S.IntervalSpec -> IntervalSpec
intervalSpecFromProto p =
  IntervalSpec
    { interval = durationFromProto (fromMaybe mempty (getField @"interval" p))
    , phase = durationFromProto <$> getField @"phase" p
    }

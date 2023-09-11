{-# LANGUAGE DuplicateRecordFields #-}
{- |
A Schedule contains instructions for starting a Workflow Execution at specific times. Schedules provide a more flexible and user-friendly approach than Temporal Cron Jobs.

How to enable Schedules
A Schedule has an identity and is independent of a Workflow Execution. This differs from a Temporal Cron Job, which relies on a cron schedule as a property of the Workflow Execution.

Action
The Action of a Schedule is where the Workflow Execution properties are established, such as Workflow Type, Task Queue, parameters, and timeouts.

Workflow Executions started by a Schedule have the following additional properties:

- The Action's timestamp is appended to the Workflow Id.
- The TemporalScheduledStartTime Search Attribute is added to the Workflow Execution. The value is the Action's timestamp.
- The TemporalScheduledById Search Attribute is added to the Workflow Execution. The value is the Schedule Id. 
- The Schedule Spec describes when the Action is taken. There are two kinds of Schedule Spec:
  - A simple interval, like "every 30 minutes" (aligned to start at the Unix epoch, and optionally including a phase offset).
  - A calendar-based expression, similar to the "cron expressions" supported by lots of software, including the older Temporal Cron feature.

The following calendar JSON fields are available:

year
month
dayOfMonth
dayOfWeek
hour
minute
second
comment
Each field can contain a comma-separated list of ranges (or the * wildcard), and each range can include a slash followed by a skip value. The hour, minute, and second fields default to 0 while the others default to *, so you can describe many useful specs with only a few fields.

For month, names of months may be used instead of integers (case-insensitive, abbreviations permitted). For dayOfWeek, day-of-week names may be used.

The comment field is optional and can be used to include a free-form description of the intent of the calendar spec, useful for complicated specs.

No matter which form you supply, calendar and interval specs are converted to canonical representations. What you see when you "describe" or "list" a Schedule might not look exactly like what you entered, but it has the same meaning.

Other Spec features:

Multiple intervals/calendar expressions: A Spec can have combinations of multiple intervals and/or calendar expressions to define a specific Schedule.

Time bounds: Provide an absolute start or end time (or both) with a Spec to ensure that no actions are taken before the start time or after the end time.

Exclusions: A Spec can contain exclusions in the form of zero or more calendar expressions. This can be used to express scheduling like "each Monday at noon except for holidays. You'll have to provide your own set of exclusions and include it in each schedule; there are no pre-defined sets. (This feature isn't currently exposed in tctl or the Temporal Web UI.)

Jitter: If given, a random offset between zero and the maximum jitter is added to each Action time (but bounded by the time until the next scheduled Action).

Time zones: By default, calendar-based expressions are interpreted in UTC. Temporal recommends using UTC to avoid various surprising properties of time zones. If you don't want to use UTC, you can provide the name of a time zone. The time zone definition is loaded on the Temporal Server Worker Service from either disk or the fallback embedded in the binary.

For more operational control, embed the contents of the time zone database file in the Schedule Spec itself. (Note: this isn't currently exposed in tctl or the web UI.)

Pause
A Schedule can be Paused. When a Schedule is Paused, the Spec has no effect. However, you can still force manual actions by using the tctl schedule trigger command.

To assist communication among developers and operators, a “notes” field can be updated on pause or resume to store an explanation for the current state.

Backfill
A Schedule can be Backfilled. When a Schedule is Backfilled, all the Actions that would have been taken over a specified time period are taken now (in parallel if the AllowAll Overlap Policy is used; sequentially if BufferAll is used). You might use this to fill in runs from a time period when the Schedule was paused due to an external condition that's now resolved, or a period before the Schedule was created.

Limit number of Actions
A Schedule can be limited to a certain number of scheduled Actions (that is, not trigger immediately). After that it will act as if it were paused.

Policies
A Schedule supports a set of Policies that enable customizing behavior.

Overlap Policy
The Overlap Policy controls what happens when it is time to start a Workflow Execution but a previously started Workflow Execution is still running. The following options are available:

Skip: Default. Nothing happens; the Workflow Execution is not started.
BufferOne: Starts the Workflow Execution as soon as the current one completes. The buffer is limited to one. If another Workflow Execution is supposed to start, but one is already in the buffer, only the one in the buffer eventually starts.
BufferAll: Allows an unlimited number of Workflows to buffer. They are started sequentially.
CancelOther: Cancels the running Workflow Execution, and then starts the new one after the old one completes cancellation.
TerminateOther: Terminates the running Workflow Execution and starts the new one immediately.
AllowAll Starts any number of concurrent Workflow Executions. With this policy (and only this policy), more than one Workflow Execution, started by the Schedule, can run simultaneously.
Catchup Window
The Temporal Cluster might be down or unavailable at the time when a Schedule should take an Action. When it comes back up, the Catchup Window controls which missed Actions should be taken at that point. The default is one minute, which means that the Schedule attempts to take any Actions that wouldn't be more than one minute late. An outage that lasts longer than the Catchup Window could lead to missed Actions. (But you can always Backfill.)

Pause-on-failure
If this policy is set, a Workflow Execution started by a Schedule that ends with a failure or timeout (but not Cancellation or Termination) causes the Schedule to automatically pause.

Note that with the AllowAll Overlap Policy, this pause might not apply to the next Workflow Execution, because the next Workflow Execution might have started before the failed one finished. It applies only to Workflow Executions that were scheduled to start after the failed one finished.

Last completion result
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
module Temporal.Client.Schedule
{-
  ( createSchedule
  , deleteSchedule
  , listSchedules
  , ScheduleListInfo(..)
  , ScheduleListEntry(..)
  , ScheduleActionResult(..)
  , ListSchedulesOptions(..)
  , listScheduleMatchingTimes
  , describeSchedule
  , patchSchedule
  , updateSchedule
  , ScheduleId
  , module Temporal.Duration 
  ) -} where

import Control.Monad
import Control.Monad.IO.Class (MonadIO)
import Data.Conduit
import Data.Int (Int32)
import Data.Map.Strict (Map)
import Data.ProtoLens
import Data.Vector (Vector)
import qualified Data.Vector as V
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import Temporal.Duration
import Temporal.Common
import Temporal.Payload
import Temporal.Core.Client
import qualified Temporal.Core.Client.WorkflowService as Core
import Lens.Family2
import qualified Proto.Temporal.Api.Schedule.V1.Message as S
import qualified Proto.Temporal.Api.Schedule.V1.Message_Fields as S
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse as WF
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as WF
import Data.Time.Clock.System (SystemTime)
import UnliftIO
import Temporal.Common (timespecFromTimestamp, Namespace (rawNamespace), ScheduleId (rawScheduleId))

{-
throwEither :: MonadIO m => m (Either a b) -> m b
throwEither m = do
  e <- m
  case e of
    Left err -> throwIO err
    Right ok -> pure ok

---------------------------------------------------------------------------------
-- ScheduleClient

data ScheduleClient = ScheduleClient 
  { scheduleClient :: Client
  , scheduleClientNamespace :: Namespace
  , scheduleClientIdentity :: Text
  }

data ScheduleHandle = ScheduleHandle

data CreateScheduleOptions = CreateScheduleOptions
  { scheduleId :: !ScheduleId
  , schedule :: !ScheduleSpec
  , initialPatch :: !(Maybe ScheduleSpec)
  -- TODO, not sure what the point of this is. Idempotency?
  , requestId :: !Text
  , memo :: !(Map Text Payload)
  , searchAttributes :: !(Map Text Payload)
  }

data ScheduleAlreadyRunning = ScheduleAlreadyRunning

createSchedule 
  :: MonadIO m
  => ScheduleClient 
  -> CreateScheduleOptions
  -> m (Either ScheduleAlreadyRunning ScheduleHandle)
createSchedule = undefined

deleteSchedule 
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> m ()
deleteSchedule c sId = do
  _resp <- liftIO $ throwEither $ Core.deleteSchedule 
    c.scheduleClient 
    (defMessage 
      & WF.namespace .~ rawNamespace c.scheduleClientNamespace
      & WF.identity .~ c.scheduleClientIdentity
      & WF.scheduleId .~ rawScheduleId sId
    )
  pure ()

data ListSchedulesOptions = ListSchedulesOptions
  { maximumPageSize :: Int32 
  }

data ScheduleActionResult = ScheduleActionResult

data ScheduleListInfo = ScheduleListInfo
  { spec :: !(Maybe ScheduleSpec)
  , workflowType :: !Text
  , notes :: !Text
  , paused :: !Bool
  , recentActions :: !(Vector ScheduleActionResult)
  , futureActionTimes :: !(Vector SystemTime)
  }

data ScheduleListEntry = ScheduleListEntry
  { scheduleId :: !ScheduleId
  , memo :: !(Map Text Payload)
  , searchAttributes :: !(Map Text Payload)
  , info :: !(Maybe ScheduleListInfo)
  }

scheduleListEntryFromProto :: S.ScheduleListEntry -> ScheduleListEntry
scheduleListEntryFromProto p = ScheduleListEntry
  { scheduleId = ScheduleId (p ^. S.scheduleId)
  , memo = maybe mempty _ (p ^. S.memo)
  , searchAttributes = maybe mempty _ (p ^. S.searchAttributes)
  , info = fmap scheduleListInfoFromProto (p ^. S.maybe'info)
  }

listSchedules 
  :: MonadIO m
  => ScheduleClient
  -> ListSchedulesOptions
  -> ConduitT () (Vector ScheduleListEntry) m ()
listSchedules c opts = go ""
  where
    go tok = do
      resp <- liftIO $ throwEither $ Core.listSchedules 
        c.scheduleClient 
        (defMessage 
          & WF.namespace .~ rawNamespace c.scheduleClientNamespace
          & WF.identity .~ c.scheduleClientIdentity
          & WF.maximumPageSize .~ opts.maximumPageSize
        )
      unless (V.null (resp ^. WF.vec'schedules)) $ yield (resp ^. WF.vec'schedules)
      if resp ^. WF.nextPageToken == "" || V.null (resp ^. WF.vec'schedules)
        then pure ()
        else go (resp ^. WF.nextPageToken)

data ListScheduleMatchingTimesOptions = ListScheduleMatchingTimesOptions
  { scheduleId :: !ScheduleId
  , startTime :: !SystemTime
  , endTime :: !SystemTime
  }

listScheduleMatchingTimes
  :: MonadIO m
  => ScheduleClient 
  -> ListSchedulesOptions 
  -> m (Vector SystemTime)
listScheduleMatchingTimes c opts = do
  resp <- liftIO $ throwEither $ Core.listScheduleMatchingTimes 
    c.scheduleClient 
    (defMessage 
      & WF.namespace .~ rawNamespace c.scheduleClientNamespace
      & WF.scheduleId .~ rawScheduleId opts.scheduleId
      & WF.startTime .~ timespecToTimestamp (opts.startTime)
      & WF.endTime .~ timespecToTimestamp (opts.endTime)
    )
  pure $ fmap timespecFromTimestamp (resp ^. WF.vec'startTime) 
      

describeSchedule 
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> m (Maybe ScheduleSpec)
describeSchedule = undefined

patchSchedule 
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> ScheduleSpec
  -> m ()
patchSchedule = undefined

updateSchedule 
  :: MonadIO m
  => ScheduleClient
  -> ScheduleId
  -> ScheduleSpec
  -> m ()
updateSchedule = undefined

scheduleSpec :: ScheduleSpec
scheduleSpec = ScheduleSpec
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
  , timezoneData = ""
  }

data ScheduleSpec = ScheduleSpec
  { structuredCalendar :: !(Vector StructuredCalendarSpec)
  , cronString :: !(Vector Text)
  , calendar :: !(Vector CalendarSpec)
  , interval :: !(Vector IntervalSpec)
  , excludeCalendar :: !(Vector CalendarSpec)
  , excludeStructuredCalendar :: !(Vector StructuredCalendarSpec)
  , startTime :: !(Maybe UTCTime)
  , endTime :: !(Maybe UTCTime)
  , jitter :: !(Maybe Duration)
  , timezoneName :: !Text
  , timezoneData :: !Text
  }

data Range = Range
  { start :: !Int32
  , end :: !Int32
  , step :: !Int32
  }

data StructuredCalendarSpec = StructuredCalendarSpec
  { second :: !(Vector Range)
  , minute :: !(Vector Range)
  , hour :: !(Vector Range)
  , dayOfMonth :: !(Vector Range)
  , month :: !(Vector Range)
  , year :: !(Vector Range)
  , dayOfWeek :: !(Vector Range)
  , comment :: !Text
  }

structuredCalendarSpec :: StructuredCalendarSpec
structuredCalendarSpec = StructuredCalendarSpec
  { second = mempty
  , minute = mempty
  , hour = mempty
  , dayOfMonth = mempty
  , month = mempty
  , year = mempty
  , dayOfWeek = mempty
  , comment = mempty
  }

data CalendarSpec = CalendarSpec
  { second :: !Text
  , minute :: !Text
  , hour :: !Text
  , dayOfMonth :: !Text
  , month :: !Text
  , year :: !Text
  , dayOfWeek :: !Text
  , comment :: !Text
  }

data IntervalSpec = IntervalSpec
  { interval :: !(Maybe Duration)
  , phase :: !(Maybe Duration)
  }
-}
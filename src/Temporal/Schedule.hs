{-# LANGUAGE DuplicateRecordFields #-}
module Temporal.Schedule
  ( createSchedule
  , deleteSchedule
  , listSchedules
  , listScheduleMatchingTimes
  , describeSchedule
  , patchSchedule
  , updateSchedule
  
  ) where

import Control.Monad.IO.Class (MonadIO)
import Data.Int (Int32)
import Data.Vector (Vector)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import System.Clock

---------------------------------------------------------------------------------
-- ScheduleClient

data ScheduleClient = ScheduleClient 
  { scheduleClient :: Client
  , scheduleClientNamespace :: Namespace
  , scheduleClientIdentity :: Text
  }

newtype ScheduleId = ScheduleId { rawScheduleId :: Text }
data ScheduleHandle = ScheduleHandle

data CreateScheduleOptions = CreateScheduleOptions
  { scheduleId :: !ScheduleId
  , schedule :: !ScheduleSpec
  , initialPatch :: !(Maybe ScheduleSpec)
  -- TODO, not sure what the point of this is. Idempotency?
  , requestId :: !Text
  , memo :: !(Map Text RawPayload)
  , searchAttributes :: !(Map Text RawPayload)
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
deleteSchedule c sId = Core.deleteSchedule 
  c.scheduleClient 
  (defMessage 
    & namespace .~ c.scheduleClientNamespace
    & identity .~ c.scheduleClientIdentity
    & scheduleId .~ sId
  )

data ListSchedulesOptions = ListSchedulesOptions
  { maximumPageSize :: Int32 
  }

listSchedules 
  :: MonadIO m
  => ScheduleClient
  -> ListSchedulesOptions
  -> ConduiT () (Vector ScheduleListEntry) m ()
listSchedules c opts = go ""
  where
    go tok = do
      resp <- Core.listSchedules 
        c.scheduleClient 
        (defMessage 
          & namespace .~ c.scheduleClientNamespace
          & identity .~ c.scheduleClientIdentity
          & maximumPageSize .~ maximumPageSize opts
        )
      unless (V.null (resp ^. schedules)) $ yield (resp ^. schedules)
      if resp ^. nextPageToken == "" || V.null (resp ^. schedules)
        then pure ()
        else go (resp ^. nextPageToken)

data ListScheduleMatchingTimesOptions = ListScheduleMatchingTimesOptions
  { maximumPageSize :: Int32
  , startTime :: !UTCTime
  , endTime :: !UTCTime
  }

listScheduleMatchingTimes
  :: MonadIO m
  => ScheduleClient 
  -> ListSchedulesOptions 
  -> ConduitT () [ScheduleId] m ()
listScheduleMatchingTimes c opts = go ""
  where
    go tok = do
      resp <- Core.listScheduleMatchingTimes 
        c.scheduleClient 
        (defMessage 
          & namespace .~ c.scheduleClientNamespace
          & maximumPageSize .~ maximumPageSize opts
        )
      unless (V.null (resp ^. scheduleIds)) $ yield (resp ^. scheduleIds)
      if resp ^. nextPageToken == "" || V.null (resp ^. scheduleIds)
        then pure ()
        else go (resp ^. nextPageToken)

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
  , jitter :: !(Maybe TimeSpec)
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
  { interval :: !(Maybe TimeSpec)
  , phase :: !(Maybe TimeSpec)
  }
G
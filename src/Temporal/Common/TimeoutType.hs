module Temporal.Common.TimeoutType where
import Temporal.Duration

data TimeoutType 
  = StartToClose Duration 
  | ScheduleToClose Duration
  | StartToCloseAndScheduleToClose Duration Duration

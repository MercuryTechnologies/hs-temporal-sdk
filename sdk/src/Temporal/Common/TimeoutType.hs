{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveLift #-}

module Temporal.Common.TimeoutType where

import Data.Data (Data)
import Language.Haskell.TH.Syntax (Lift)
import Temporal.Duration


{- | An Activity Execution must have either this timeout (Start-To-Close) or the Schedule-To-Close Timeout set.
We recommend always setting this timeout; however, make sure that Start-To-Close Timeout is always set to be
longer than the maximum possible time for the Activity Execution to complete. For long running Activity Executions,
we recommend also using Activity Heartbeats and Heartbeat Timeouts.

Tip: We strongly recommend setting a Start-To-Close Timeout.

The Temporal Server doesn't detect failures when a Worker loses communication with the Server or crashes. Therefore, the Temporal Server relies on the Start-To-Close Timeout to force Activity retries.
-}
newtype StartToClose = StartToClose Duration
  deriving stock (Eq, Ord, Show, Lift, Data)


{- | A Schedule-To-Close Timeout is the maximum amount of time allowed for the overall Activity Execution, from when the first Activity Task is scheduled to when the last Activity
Task, in the chain of Activity Tasks that make up the Activity Execution, reaches a Closed status.

An Activity Execution must have either this timeout (Schedule-To-Close) or Start-To-Close set. By default, an Activity Execution Retry Policy dictates that retries occur for up to 10 years.
This timeout can be used to control the overall duration of an Activity Execution in the face of failures (repeated Activity Task Executions), without altering the Maximum Attempts field of the Retry Policy.
-}
newtype ScheduleToClose = ScheduleToClose Duration
  deriving stock (Eq, Ord, Show, Lift, Data)

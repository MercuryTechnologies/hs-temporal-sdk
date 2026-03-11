{-# LANGUAGE DuplicateRecordFields #-}
{-# OPTIONS_GHC -Wno-partial-fields #-}

{- |
Module: Temporal.Ops.Diagnostics
Description: Detect "wedged" workflow executions.

Provides pure classification functions that inspect the typed output of
'Temporal.Client.Describe.describeWorkflow' and identify common
operational problems:

  * Nondeterminism errors (workflow task retrying at high attempt counts)
  * Workflow task timeouts (consecutive timeout signals)
  * Stuck activities (high retry attempt with last heartbeat)
  * Starved activities (scheduled but never started)
  * Stale heartbeats (started but heartbeat is too old or missing)
  * Stalled cancellations (cancel-requested but not completing)

All check functions are pure and operate on 'WorkflowExecutionDescription',
making them easy to unit test without a running Temporal server.
-}
module Temporal.Ops.Diagnostics (
  -- * Wedged reason classification
  WedgedReason (..),
  DiagnosticOptions (..),
  defaultDiagnosticOptions,
  classifyWorkflow,

  -- * Streaming scanner
  scanWedgedWorkflows,

  -- * Individual check functions (pure, for testing)
  checkNondeterminism,
  checkStuckActivities,
  checkWorkflowTaskTimeouts,
  checkStarvedActivities,
  checkStaleHeartbeats,
  checkStalledCancellations,
) where

import Conduit
import Data.Int (Int32)
import Data.Time.Clock.System (SystemTime)
import qualified Data.Vector as V
import Temporal.Client (HasWorkflowClient)
import Temporal.Client.Describe
import Temporal.Client.List
import Temporal.Common (ActivityId, ActivityType, WorkflowId, RunId)
import Temporal.Duration (Duration, diffSystemTime, minutes, durationSeconds)


data WedgedReason
  = NondeterminismError
      { pendingWorkflowTaskAttempt :: !Int32
      }
  | WorkflowTaskTimeouts
      { consecutiveTimeouts :: !Int32
      }
  | StuckActivity
      { activityType :: !ActivityType
      , activityId :: !ActivityId
      , attempt :: !Int32
      , scheduledTime :: !(Maybe SystemTime)
      , lastHeartbeat :: !(Maybe SystemTime)
      }
  | StarvedActivity
      { activityType :: !ActivityType
      , activityId :: !ActivityId
      , scheduledTime :: !(Maybe SystemTime)
      }
  | StaleHeartbeat
      { activityType :: !ActivityType
      , activityId :: !ActivityId
      , lastStartedTime :: !(Maybe SystemTime)
      , lastHeartbeat :: !(Maybe SystemTime)
      }
  | StalledCancellation
      { activityType :: !ActivityType
      , activityId :: !ActivityId
      , attempt :: !Int32
      , scheduledTime :: !(Maybe SystemTime)
      }
  deriving stock (Show, Eq)


data DiagnosticOptions = DiagnosticOptions
  { nondeterminismAttemptThreshold :: !Int32
  -- ^ Pending workflow task attempt count that indicates a nondeterminism loop.
  -- Default: 3
  , activityStuckThreshold :: !Duration
  -- ^ How long an activity must be in STARTED state with high attempts before
  -- it is considered stuck. Also used for SCHEDULED (starved) threshold.
  -- Default: 5 minutes
  , workflowTaskTimeoutThreshold :: !Int32
  -- ^ Pending workflow task attempt count that indicates repeated timeouts.
  -- Default: 5
  , heartbeatStaleThreshold :: !Duration
  -- ^ For STARTED activities: how long since last heartbeat before considering
  -- the activity stale. Default: 10 minutes
  , cancellationStallThreshold :: !Duration
  -- ^ For CANCEL_REQUESTED activities: how long before the cancellation is
  -- considered stalled. Default: 5 minutes
  }
  deriving stock (Show, Eq)


defaultDiagnosticOptions :: DiagnosticOptions
defaultDiagnosticOptions =
  DiagnosticOptions
    { nondeterminismAttemptThreshold = 3
    , activityStuckThreshold = minutes 5
    , workflowTaskTimeoutThreshold = 5
    , heartbeatStaleThreshold = minutes 10
    , cancellationStallThreshold = minutes 5
    }


classifyWorkflow
  :: DiagnosticOptions
  -> SystemTime
  -> WorkflowExecutionDescription
  -> [WedgedReason]
classifyWorkflow opts now desc =
  checkNondeterminism opts desc
    <> checkWorkflowTaskTimeouts opts desc
    <> checkStuckActivities opts now desc
    <> checkStarvedActivities opts now desc
    <> checkStaleHeartbeats opts now desc
    <> checkStalledCancellations opts now desc


checkNondeterminism :: DiagnosticOptions -> WorkflowExecutionDescription -> [WedgedReason]
checkNondeterminism opts desc = case desc.pendingWorkflowTask of
  Nothing -> []
  Just task
    | task.attempt >= opts.nondeterminismAttemptThreshold ->
        [NondeterminismError {pendingWorkflowTaskAttempt = task.attempt}]
    | otherwise -> []


checkWorkflowTaskTimeouts :: DiagnosticOptions -> WorkflowExecutionDescription -> [WedgedReason]
checkWorkflowTaskTimeouts opts desc = case desc.pendingWorkflowTask of
  Nothing -> []
  Just task
    | task.attempt >= opts.workflowTaskTimeoutThreshold ->
        [WorkflowTaskTimeouts {consecutiveTimeouts = task.attempt}]
    | otherwise -> []


-- | Activities in STARTED state with high attempt count.
-- Excludes CANCEL_REQUESTED activities (handled by checkStalledCancellations).
checkStuckActivities :: DiagnosticOptions -> SystemTime -> WorkflowExecutionDescription -> [WedgedReason]
checkStuckActivities opts now desc =
  V.toList $ V.mapMaybe go desc.pendingActivities
  where
    go a
      | a.state == PENDING_ACTIVITY_STATE_STARTED
      , a.attempt >= opts.nondeterminismAttemptThreshold
      , isOldEnough a.scheduledTime =
          Just
            StuckActivity
              { activityType = a.activityType
              , activityId = a.activityId
              , attempt = a.attempt
              , scheduledTime = a.scheduledTime
              , lastHeartbeat = a.lastHeartbeatTime
              }
      | otherwise = Nothing

    isOldEnough Nothing = True
    isOldEnough (Just t) =
      let d = diffSystemTime t now
      in durationSeconds d >= durationSeconds opts.activityStuckThreshold


-- | Activities in SCHEDULED state that have never been started,
-- lingering longer than the stuck threshold.
checkStarvedActivities :: DiagnosticOptions -> SystemTime -> WorkflowExecutionDescription -> [WedgedReason]
checkStarvedActivities opts now desc =
  V.toList $ V.mapMaybe go desc.pendingActivities
  where
    go a
      | a.state == PENDING_ACTIVITY_STATE_SCHEDULED
      , isOldEnough a.scheduledTime =
          Just
            StarvedActivity
              { activityType = a.activityType
              , activityId = a.activityId
              , scheduledTime = a.scheduledTime
              }
      | otherwise = Nothing

    isOldEnough Nothing = True
    isOldEnough (Just t) =
      let d = diffSystemTime t now
      in durationSeconds d >= durationSeconds opts.activityStuckThreshold


-- | Activities in STARTED state whose last heartbeat is stale or missing.
checkStaleHeartbeats :: DiagnosticOptions -> SystemTime -> WorkflowExecutionDescription -> [WedgedReason]
checkStaleHeartbeats opts now desc =
  V.toList $ V.mapMaybe go desc.pendingActivities
  where
    go a
      | a.state == PENDING_ACTIVITY_STATE_STARTED
      , isHeartbeatStale a =
          Just
            StaleHeartbeat
              { activityType = a.activityType
              , activityId = a.activityId
              , lastStartedTime = a.lastStartedTime
              , lastHeartbeat = a.lastHeartbeatTime
              }
      | otherwise = Nothing

    isHeartbeatStale a = case a.lastHeartbeatTime of
      Nothing -> case a.lastStartedTime of
        Nothing -> False
        Just st ->
          let d = diffSystemTime st now
          in durationSeconds d >= durationSeconds opts.heartbeatStaleThreshold
      Just hb ->
        let d = diffSystemTime hb now
        in durationSeconds d >= durationSeconds opts.heartbeatStaleThreshold


-- | Activities in CANCEL_REQUESTED state lingering longer than the
-- cancellation stall threshold.
checkStalledCancellations :: DiagnosticOptions -> SystemTime -> WorkflowExecutionDescription -> [WedgedReason]
checkStalledCancellations opts now desc =
  V.toList $ V.mapMaybe go desc.pendingActivities
  where
    go a
      | a.state == PENDING_ACTIVITY_STATE_CANCEL_REQUESTED
      , isOldEnough a.scheduledTime =
          Just
            StalledCancellation
              { activityType = a.activityType
              , activityId = a.activityId
              , attempt = a.attempt
              , scheduledTime = a.scheduledTime
              }
      | otherwise = Nothing

    isOldEnough Nothing = True
    isOldEnough (Just t) =
      let d = diffSystemTime t now
      in durationSeconds d >= durationSeconds opts.cancellationStallThreshold


scanWedgedWorkflows
  :: (MonadIO m, HasWorkflowClient m)
  => DiagnosticOptions
  -> SystemTime
  -> ListWorkflowsOptions
  -> ConduitT i (WorkflowId, RunId, [WedgedReason]) m ()
scanWedgedWorkflows _opts _now listOpts = do
  listWorkflows listOpts .| awaitForever (\summary ->
    yield (summary.workflowId, summary.runId, []))

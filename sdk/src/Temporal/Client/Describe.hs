{-# LANGUAGE DuplicateRecordFields #-}

{- |
Module: Temporal.Client.Describe
Description: High-level typed wrappers for describing workflow executions.

Provides Haskell-native types for the information returned by the
@DescribeWorkflowExecution@ gRPC call, so callers don't need to reach
into proto-lens directly.
-}
module Temporal.Client.Describe (
  WorkflowExecutionDescription (..),
  PendingActivityDescription (..),
  PendingWorkflowTaskDescription (..),
  PendingActivityState (..),
  describeWorkflow,
) where

import Data.Int (Int32)
import Data.ProtoLens (defMessage)
import Data.ProtoLens.Field (field)
import Data.Time.Clock.System (SystemTime)
import qualified Data.Vector as V
import Lens.Family2 ((&), (.~), (^.))
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Common
import Proto.Temporal.Api.Enums.V1.Workflow (
  PendingActivityState (..),
 )
import qualified Proto.Temporal.Api.Workflow.V1.Message_Fields as WfMsg
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as RR
import Temporal.Client.Types (WorkflowClient (..), WorkflowClientConfig (..))
import Temporal.Common
import Temporal.Core.Client.WorkflowService (describeWorkflowExecution)
import Temporal.Exception (coreRpcErrorToRpcError)
import UnliftIO (MonadIO, liftIO, throwIO)


data WorkflowExecutionDescription = WorkflowExecutionDescription
  { workflowType :: !WorkflowType
  , workflowId :: !WorkflowId
  , runId :: !RunId
  , taskQueue :: !TaskQueue
  , startTime :: !(Maybe SystemTime)
  , closeTime :: !(Maybe SystemTime)
  , executionTime :: !(Maybe SystemTime)
  , pendingActivities :: !(V.Vector PendingActivityDescription)
  , pendingWorkflowTask :: !(Maybe PendingWorkflowTaskDescription)
  }
  deriving stock (Show, Eq)


data PendingActivityDescription = PendingActivityDescription
  { activityType :: !ActivityType
  , activityId :: !ActivityId
  , state :: !PendingActivityState
  , attempt :: !Int32
  , maximumAttempts :: !Int32
  , scheduledTime :: !(Maybe SystemTime)
  , lastStartedTime :: !(Maybe SystemTime)
  , lastHeartbeatTime :: !(Maybe SystemTime)
  , expirationTime :: !(Maybe SystemTime)
  }
  deriving stock (Show, Eq)


data PendingWorkflowTaskDescription = PendingWorkflowTaskDescription
  { attempt :: !Int32
  , originalScheduledTime :: !(Maybe SystemTime)
  , startedTime :: !(Maybe SystemTime)
  , scheduledTime :: !(Maybe SystemTime)
  }
  deriving stock (Show, Eq)


describeWorkflow
  :: (MonadIO m)
  => WorkflowClient
  -> WorkflowId
  -> Maybe RunId
  -> m WorkflowExecutionDescription
describeWorkflow c wfId mRunId = liftIO $ do
  let conf :: WorkflowClientConfig
      conf = c.clientConfig
      req =
        defMessage
          & field @"namespace" .~ rawNamespace conf.namespace
          & field @"execution"
            .~ ( defMessage
                  & field @"workflowId" .~ rawWorkflowId wfId
                  & field @"runId" .~ maybe "" rawRunId mRunId
               )
  res <- describeWorkflowExecution c.clientCore req
  case res of
    Left err -> throwIO $ coreRpcErrorToRpcError err
    Right resp -> pure $ fromProto resp
  where
    fromProto resp =
      let i = resp ^. RR.workflowExecutionInfo
          cfg = resp ^. RR.executionConfig
      in WorkflowExecutionDescription
            { workflowType = WorkflowType $ i ^. WfMsg.type' . Common.name
            , workflowId = WorkflowId $ i ^. WfMsg.execution . Common.workflowId
            , runId = RunId $ i ^. WfMsg.execution . Common.runId
            , taskQueue = TaskQueue $ cfg ^. WfMsg.taskQueue . Common.name
            , startTime = timespecFromTimestamp <$> (i ^. WfMsg.maybe'startTime)
            , closeTime = timespecFromTimestamp <$> (i ^. WfMsg.maybe'closeTime)
            , executionTime = timespecFromTimestamp <$> (i ^. WfMsg.maybe'executionTime)
            , pendingActivities = fmap activityFromProto (resp ^. RR.vec'pendingActivities)
            , pendingWorkflowTask = wfTaskFromProto <$> (resp ^. RR.maybe'pendingWorkflowTask)
            }

    activityFromProto a =
      PendingActivityDescription
        { activityType = ActivityType $ a ^. WfMsg.activityType . Common.name
        , activityId = ActivityId $ a ^. WfMsg.activityId
        , state = a ^. WfMsg.state
        , attempt = a ^. WfMsg.attempt
        , maximumAttempts = a ^. WfMsg.maximumAttempts
        , scheduledTime = timespecFromTimestamp <$> (a ^. WfMsg.maybe'scheduledTime)
        , lastStartedTime = timespecFromTimestamp <$> (a ^. WfMsg.maybe'lastStartedTime)
        , lastHeartbeatTime = timespecFromTimestamp <$> (a ^. WfMsg.maybe'lastHeartbeatTime)
        , expirationTime = timespecFromTimestamp <$> (a ^. WfMsg.maybe'expirationTime)
        }

    wfTaskFromProto t =
      PendingWorkflowTaskDescription
        { attempt = t ^. WfMsg.attempt
        , originalScheduledTime = timespecFromTimestamp <$> (t ^. WfMsg.maybe'originalScheduledTime)
        , startedTime = timespecFromTimestamp <$> (t ^. WfMsg.maybe'startedTime)
        , scheduledTime = timespecFromTimestamp <$> (t ^. WfMsg.maybe'scheduledTime)
        }

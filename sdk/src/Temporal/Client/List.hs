{-# LANGUAGE DuplicateRecordFields #-}

{- |
Module: Temporal.Client.List
Description: High-level typed wrappers for listing workflow executions.

Provides a streaming 'ConduitT' interface over the @ListWorkflowExecutions@
gRPC call with automatic pagination, returning Haskell-native summary types
instead of raw proto messages.
-}
module Temporal.Client.List (
  ListWorkflowsOptions (..),
  WorkflowExecutionSummary (..),
  listWorkflows,
) where

import Conduit
import Control.Monad (unless)
import Data.Int (Int32)
import Data.ProtoLens (defMessage)
import Data.Text (Text)
import Data.Time.Clock.System (SystemTime)
import Lens.Family2 ((^.), (.~), (&))
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Common
import qualified Proto.Temporal.Api.Workflow.V1.Message_Fields as WfMsg
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as RR
import Temporal.Client (HasWorkflowClient (..))
import Temporal.Client.Types (WorkflowClient (..), WorkflowClientConfig (..))
import Temporal.Common
import Temporal.Core.Client.WorkflowService (listWorkflowExecutions)
import Temporal.Exception (coreRpcErrorToRpcError)
import UnliftIO (MonadIO, liftIO, throwIO)


data ListWorkflowsOptions = ListWorkflowsOptions
  { query :: !Text
  , pageSize :: !Int32
  }
  deriving stock (Show, Eq)


data WorkflowExecutionSummary = WorkflowExecutionSummary
  { workflowType :: !WorkflowType
  , workflowId :: !WorkflowId
  , runId :: !RunId
  , taskQueue :: !TaskQueue
  , startTime :: !(Maybe SystemTime)
  , closeTime :: !(Maybe SystemTime)
  , executionTime :: !(Maybe SystemTime)
  }
  deriving stock (Show, Eq)


listWorkflows
  :: (MonadIO m, HasWorkflowClient m)
  => ListWorkflowsOptions
  -> ConduitT i WorkflowExecutionSummary m ()
listWorkflows opts = askWorkflowClient >>= \c -> do
  let conf :: WorkflowClientConfig
      conf = c.clientConfig
      baseReq =
        defMessage
          & RR.namespace .~ rawNamespace conf.namespace
          & RR.query .~ opts.query
          & RR.pageSize .~ opts.pageSize
  go c baseReq
  where
    go c req = do
      res <- liftIO $ listWorkflowExecutions c.clientCore req
      case res of
        Left err -> throwIO $ coreRpcErrorToRpcError err
        Right x -> do
          yieldMany $ fmap summaryFromProto (x ^. RR.vec'executions)
          unless (x ^. RR.nextPageToken == "") $
            go c (req & RR.nextPageToken .~ (x ^. RR.nextPageToken))

    summaryFromProto i =
      WorkflowExecutionSummary
        { workflowType = WorkflowType $ i ^. WfMsg.type' . Common.name
        , workflowId = WorkflowId $ i ^. WfMsg.execution . Common.workflowId
        , runId = RunId $ i ^. WfMsg.execution . Common.runId
        , taskQueue = TaskQueue $ i ^. WfMsg.taskQueue
        , startTime = timespecFromTimestamp <$> (i ^. WfMsg.maybe'startTime)
        , closeTime = timespecFromTimestamp <$> (i ^. WfMsg.maybe'closeTime)
        , executionTime = timespecFromTimestamp <$> (i ^. WfMsg.maybe'executionTime)
        }

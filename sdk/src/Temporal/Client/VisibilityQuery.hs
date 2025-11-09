{-# LANGUAGE LambdaCase #-}

{- |
Module: Temporal.Client.VisibilityQuery
Description: Query builders for Temporal visibility API

This module provides both primitive query builders and a type-safe ADT
for constructing visibility queries to filter workflow executions.

Temporal's visibility queries use a SQL-like syntax. For more information
on the query language, see the Temporal documentation.
-}
module Temporal.Client.VisibilityQuery (
  -- * Type-Safe Query ADT
  VisibilityQuery (..),
  renderQuery,

  -- * Time Range
  TimeRange (..),

  -- * Primitive Query Builders
  queryByWorkflowType,
  queryByWorkflowId,
  queryByStatus,
  queryByStartTime,
  queryByCloseTime,
  queryByExecutionTime,
  combineQueries,
) where

import Data.Text (Text)
import qualified Data.Text as T
import Data.Time.Clock (UTCTime)
import Data.Time.Format.ISO8601 (iso8601Show)
import Temporal.Client.Types (WorkflowExecutionStatus (..))
import Temporal.Common (WorkflowId (..), WorkflowType (..))


-- | A time range for filtering workflow executions by time.
data TimeRange
  = -- | Events after the specified time (exclusive)
    After UTCTime
  | -- | Events before the specified time (exclusive)
    Before UTCTime
  | -- | Events between two times (inclusive)
    Between UTCTime UTCTime
  deriving stock (Show, Eq)


{- | A type-safe representation of visibility queries.

Use 'renderQuery' to convert to the raw query string format expected
by the Temporal visibility API.

Example:

@
let query = AndQuery
      [ WorkflowTypeQuery "MyWorkflow"
      , StatusQuery Running
      , StartTimeQuery (After someTime)
      ]
in renderQuery query
-- Result: "WorkflowType='MyWorkflow' AND WorkflowStatus='Running' AND StartTime>'2024-01-01T00:00:00Z'"
@
-}
data VisibilityQuery
  = -- | Filter by workflow type
    WorkflowTypeQuery WorkflowType
  | -- | Filter by workflow ID
    WorkflowIdQuery WorkflowId
  | -- | Filter by workflow execution status
    StatusQuery WorkflowExecutionStatus
  | -- | Filter by workflow start time
    StartTimeQuery TimeRange
  | -- | Filter by workflow close time
    CloseTimeQuery TimeRange
  | -- | Filter by workflow execution time (duration)
    ExecutionTimeQuery TimeRange
  | -- | Combine multiple queries with AND
    AndQuery [VisibilityQuery]
  | -- | Combine multiple queries with OR
    OrQuery [VisibilityQuery]
  | -- | Raw query string (escape hatch)
    RawQuery Text
  deriving stock (Show, Eq)


{- | Render a 'VisibilityQuery' to the raw query string format.

This function converts the type-safe ADT representation to the SQL-like
query string expected by Temporal's visibility API.
-}
renderQuery :: VisibilityQuery -> Text
renderQuery = \case
  WorkflowTypeQuery wfType -> queryByWorkflowType wfType
  WorkflowIdQuery wfId -> queryByWorkflowId wfId
  StatusQuery status -> queryByStatus status
  StartTimeQuery timeRange -> queryByStartTime timeRange
  CloseTimeQuery timeRange -> queryByCloseTime timeRange
  ExecutionTimeQuery timeRange -> queryByExecutionTime timeRange
  AndQuery queries -> combineQueries (map renderQuery queries)
  OrQuery queries -> "(" <> T.intercalate " OR " (map renderQuery queries) <> ")"
  RawQuery raw -> raw


{- | Build a query to filter by workflow type.

Example:

@
queryByWorkflowType "MyWorkflow"
-- Result: "WorkflowType='MyWorkflow'"
@
-}
queryByWorkflowType :: WorkflowType -> Text
queryByWorkflowType (WorkflowType wfType) =
  "WorkflowType='" <> escapeQueryString wfType <> "'"


{- | Build a query to filter by workflow ID.

Example:

@
queryByWorkflowId "workflow-123"
-- Result: "WorkflowId='workflow-123'"
@
-}
queryByWorkflowId :: WorkflowId -> Text
queryByWorkflowId (WorkflowId wfId) =
  "WorkflowId='" <> escapeQueryString wfId <> "'"


{- | Build a query to filter by workflow execution status.

Example:

@
queryByStatus Running
-- Result: "WorkflowStatus='Running'"
@
-}
queryByStatus :: WorkflowExecutionStatus -> Text
queryByStatus status =
  "WorkflowStatus='" <> statusToText status <> "'"


{- | Build a query to filter by workflow start time.

Example:

@
queryByStartTime (After someTime)
-- Result: "StartTime>'2024-01-01T00:00:00Z'"
@
-}
queryByStartTime :: TimeRange -> Text
queryByStartTime = formatTimeRange "StartTime"


{- | Build a query to filter by workflow close time.

Example:

@
queryByCloseTime (Between startTime endTime)
-- Result: "CloseTime BETWEEN '2024-01-01T00:00:00Z' AND '2024-01-02T00:00:00Z'"
@
-}
queryByCloseTime :: TimeRange -> Text
queryByCloseTime = formatTimeRange "CloseTime"


{- | Build a query to filter by workflow execution time (duration).

Example:

@
queryByExecutionTime (After someTime)
-- Result: "ExecutionTime>'2024-01-01T00:00:00Z'"
@
-}
queryByExecutionTime :: TimeRange -> Text
queryByExecutionTime = formatTimeRange "ExecutionTime"


{- | Combine multiple query strings with AND.

Example:

@
combineQueries
  [ queryByWorkflowType "MyWorkflow"
  , queryByStatus Running
  ]
-- Result: "WorkflowType='MyWorkflow' AND WorkflowStatus='Running'"
@
-}
combineQueries :: [Text] -> Text
combineQueries [] = ""
combineQueries [q] = q
combineQueries queries = T.intercalate " AND " queries


-- Internal helper functions

statusToText :: WorkflowExecutionStatus -> Text
statusToText = \case
  Running -> "Running"
  Completed -> "Completed"
  Failed -> "Failed"
  Canceled -> "Canceled"
  Terminated -> "Terminated"
  ContinuedAsNew -> "ContinuedAsNew"
  TimedOut -> "TimedOut"
  UnknownStatus -> "Unspecified"


formatTimeRange :: Text -> TimeRange -> Text
formatTimeRange field = \case
  After time ->
    field <> ">'" <> T.pack (iso8601Show time) <> "'"
  Before time ->
    field <> "<'" <> T.pack (iso8601Show time) <> "'"
  Between start end ->
    field <> " BETWEEN '" <> T.pack (iso8601Show start) <> "' AND '" <> T.pack (iso8601Show end) <> "'"


-- | Escape single quotes in query strings by doubling them
escapeQueryString :: Text -> Text
escapeQueryString = T.replace "'" "''"

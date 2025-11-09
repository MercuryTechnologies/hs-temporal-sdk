{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}

{- |
Module: Temporal.Client.WorkflowRule
Description: Workflow rules for automatic actions on workflows

Workflow rules allow you to automatically take actions on workflows that match certain
criteria when specific events occur. This is useful for:

- Automatically pausing activities based on predicates
- Implementing circuit breakers or rate limiting
- Enforcing operational policies across workflows

= Usage Example

@
import Temporal.Client.WorkflowRule
import Temporal.Client.VisibilityQuery
import qualified Data.Vector as V

-- Create a rule to pause activities when they meet certain conditions
let trigger = activityStartTrigger "ActivityType = 'ExpensiveOperation'"
    action = pauseActivityAction
    query = WorkflowTypeQuery "DataProcessing"

ruleId <- createWorkflowRule
  (WorkflowRuleId "expense-limiter")
  query
  trigger
  (V.singleton action)
  Nothing  -- No expiration

-- List all rules
(rules, nextToken) <- listWorkflowRules defaultListWorkflowRulesOptions

-- Describe a specific rule
rule <- describeWorkflowRule (WorkflowRuleId "expense-limiter")

-- Manually trigger a rule for testing
triggerWorkflowRuleById
  (WorkflowRuleId "expense-limiter")
  "my-workflow-id"
  Nothing

-- Delete a rule
deleteWorkflowRule (WorkflowRuleId "expense-limiter")
@
-}
module Temporal.Client.WorkflowRule (
  -- * Workflow Rule Types
  WorkflowRuleId (..),
  WorkflowRuleInfo (..),
  ActivityStartTrigger (..),
  PauseActivityAction (..),
  VisibilityQueryString (..),

  -- * Creating and Managing Rules
  createWorkflowRule,
  describeWorkflowRule,
  deleteWorkflowRule,
  listWorkflowRules,

  -- * Triggering Rules
  triggerWorkflowRuleById,
  triggerWorkflowRuleBySpec,

  -- * Builder Helpers
  mkActivityStartTrigger,
  mkPauseActivityAction,

  -- * Query Options
  ListWorkflowRulesOptions (..),
  defaultListWorkflowRulesOptions,
) where

import Data.Int (Int32)
import Data.ProtoLens (defMessage)
import Data.String (IsString)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import Data.Time.Clock (UTCTime)
import qualified Data.Vector as V
import Lens.Family2 ((&), (.~), (^.))
import qualified Proto.Temporal.Api.Common.V1.Message as Common
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Common
import qualified Proto.Temporal.Api.Rules.V1.Message as Rules
import qualified Proto.Temporal.Api.Rules.V1.Message_Fields as Rules
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse as RR
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as RR
import Temporal.Client (HasWorkflowClient (..))
import Temporal.Client.Types (WorkflowClient (..), WorkflowClientConfig (WorkflowClientConfig, namespace))
import Temporal.Client.VisibilityQuery (VisibilityQuery, renderQuery)
import Temporal.Common (Namespace (..))
import Temporal.Core.Client (RpcError)
import qualified Temporal.Core.Client.WorkflowService as CoreWS
import Temporal.Exception (coreRpcErrorToRpcError)
import Temporal.Timestamp (protoToUTCTime, utcTimeToProto)
import UnliftIO (MonadIO, liftIO, throwIO)


-- | Unique identifier for a workflow rule.
newtype WorkflowRuleId = WorkflowRuleId {unWorkflowRuleId :: Text}
  deriving stock (Show, Eq, Ord)
  deriving newtype (IsString)


{- | A visibility query as returned from the server.

This is the string representation of a visibility query. When creating rules,
you use the structured 'VisibilityQuery' type which is then rendered to this format.
-}
newtype VisibilityQueryString = VisibilityQueryString {unVisibilityQueryString :: Text}
  deriving stock (Show, Eq, Ord)
  deriving newtype (IsString)


{- | Trigger that fires when an activity starts.

The predicate is a SQL-like string filter that is evaluated against activity attributes
when an activity is about to start. If the predicate matches, the rule's actions are executed.

= Supported Activity Attributes

The predicate can reference the following activity attributes:

- @ActivityType@ - The Activity Type name (mapping to an Activity Definition)
- @ActivityId@ - The ID of the activity
- @ActivityAttempt@ - The number of attempts of the activity
- @BackoffInterval@ - The current backoff time between scheduled attempts
- @ActivityStatus@ - The status of the activity (\"Scheduled\", \"Started\", \"Paused\")
- @TaskQueue@ - The name of the task queue the activity should run on

= Supported Operators

- Comparison: @=@, @!=@, @>@, @>=@, @<@, @<=@
- Logical: @AND@, @OR@, @()@
- Range: @BETWEEN ... AND@
- String matching: @STARTS_WITH@

= Examples

@
-- Match expensive operations
mkActivityStartTrigger "ActivityType = 'ExpensiveOperation'"

-- Match activities with high attempt counts
mkActivityStartTrigger "ActivityAttempt > 3"

-- Match specific task queue and activity type
mkActivityStartTrigger "TaskQueue = 'critical-queue' AND ActivityType STARTS_WITH 'payment-'"

-- Match activities with long backoff intervals
mkActivityStartTrigger "BackoffInterval BETWEEN '1m' AND '1h'"
@
-}
newtype ActivityStartTrigger = ActivityStartTrigger
  { predicate :: Text
  -- ^ SQL-like predicate expression evaluated against activity attributes
  }
  deriving stock (Show, Eq, Ord)


{- | Action to pause an activity.

Currently, this is the only supported action type. When triggered, it will pause
the activity, preventing it from starting until manually unpaused.
-}
data PauseActivityAction = PauseActivityAction
  deriving stock (Show, Eq, Ord)


{- | Information about a workflow rule.

Contains metadata about a rule including its identifier, creation time, and specification.
-}
data WorkflowRuleInfo = WorkflowRuleInfo
  { ruleId :: !WorkflowRuleId
  -- ^ Unique identifier for this rule
  , createTime :: !(Maybe UTCTime)
  -- ^ When the rule was created
  , visibilityQuery :: !VisibilityQueryString
  -- ^ Workflow filter query (as returned from server)
  , activityStartTrigger :: !(Maybe ActivityStartTrigger)
  -- ^ Activity start trigger, if present
  , expirationTime :: !(Maybe UTCTime)
  -- ^ When the rule will be automatically deleted, if set
  }
  deriving stock (Show, Eq)


{- | Options for listing workflow rules.

These options control pagination of rule listing results.
-}
data ListWorkflowRulesOptions = ListWorkflowRulesOptions
  { pageSize :: !Int32
  -- ^ Maximum number of results per page
  , nextPageToken :: !(Maybe Text)
  -- ^ Token for fetching the next page of results
  }
  deriving stock (Show, Eq)


-- | Default options for listing workflow rules.
defaultListWorkflowRulesOptions :: ListWorkflowRulesOptions
defaultListWorkflowRulesOptions =
  ListWorkflowRulesOptions
    { pageSize = 100
    , nextPageToken = Nothing
    }


{- | Create an activity start trigger with the given predicate.

The predicate is a SQL-like expression that can reference activity attributes.
See 'ActivityStartTrigger' for the full list of supported attributes and operators.

@
-- Pause activities of a specific type
mkActivityStartTrigger "ActivityType = 'RiskyOperation'"

-- Pause activities after multiple failures
mkActivityStartTrigger "ActivityAttempt > 5"
@
-}
mkActivityStartTrigger :: Text -> ActivityStartTrigger
mkActivityStartTrigger predExpr = ActivityStartTrigger {predicate = predExpr}


-- | Create a pause activity action.
mkPauseActivityAction :: PauseActivityAction
mkPauseActivityAction = PauseActivityAction


{- | Create a new workflow rule.

Creates a rule that will automatically take actions on workflows matching the visibility
query when the trigger conditions are met.

The visibility query filters which workflows the rule applies to, while the trigger
predicate determines when the rule's actions should be executed for those workflows.

@
-- Pause expensive operations in data processing workflows
let trigger = mkActivityStartTrigger "ActivityType = 'ExpensiveOperation'"
    action = mkPauseActivityAction
    query = WorkflowTypeQuery "DataProcessing"

createWorkflowRule
  (WorkflowRuleId "expense-limiter")
  query
  trigger
  (V.singleton action)
  Nothing  -- No expiration

-- Pause activities after multiple retries
let trigger = mkActivityStartTrigger "ActivityAttempt > 3"
    action = mkPauseActivityAction
    query = AndQuery [WorkflowTypeQuery "Payment", StatusQuery Running]

createWorkflowRule
  (WorkflowRuleId "payment-retry-limiter")
  query
  trigger
  (V.singleton action)
  (Just expirationTime)  -- Expires after a certain date
@
-}
createWorkflowRule
  :: (HasWorkflowClient m, MonadIO m)
  => WorkflowRuleId
  -> VisibilityQuery
  -> ActivityStartTrigger
  -> V.Vector PauseActivityAction
  -> Maybe UTCTime
  -> m ()
createWorkflowRule (WorkflowRuleId ruleId') visQuery trigger actions mExpiration = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient

  let activityStartProto :: Rules.WorkflowRuleSpec'ActivityStartingTrigger
      activityStartProto =
        defMessage
          & Rules.predicate
            .~ predicate trigger

      actionsProto = V.map (const (defMessage & Rules.activityPause .~ defMessage)) actions

      specBase :: Rules.WorkflowRuleSpec
      specBase =
        defMessage
          & Rules.id
            .~ ruleId'
          & Rules.activityStart
            .~ activityStartProto
          & Rules.visibilityQuery
            .~ renderQuery visQuery
          & Rules.vec'actions
            .~ actionsProto

      spec :: Rules.WorkflowRuleSpec
      spec = case mExpiration of
        Nothing -> specBase
        Just expTime -> specBase & Rules.expirationTime .~ utcTimeToProto expTime

      req :: RR.CreateWorkflowRuleRequest
      req =
        defMessage
          & RR.namespace
            .~ rawNamespace ns
          & RR.spec
            .~ spec
          & RR.forceScan
            .~ False

  _ <- liftIO $ CoreWS.createWorkflowRule clientCore req >>= handleRpcError
  pure ()


{- | Get detailed information about a specific workflow rule.

Returns the rule's specification, creation time, and current state.

@
rule <- describeWorkflowRule (WorkflowRuleId "expense-limiter")
putStrLn $ "Rule created at: " <> show (createTime rule)
@
-}
describeWorkflowRule
  :: (HasWorkflowClient m, MonadIO m)
  => WorkflowRuleId
  -> m WorkflowRuleInfo
describeWorkflowRule (WorkflowRuleId ruleId') = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient

  let req :: RR.DescribeWorkflowRuleRequest
      req =
        defMessage
          & RR.namespace
            .~ rawNamespace ns
          & RR.ruleId
            .~ ruleId'

  resp <- liftIO $ CoreWS.describeWorkflowRule clientCore req >>= handleRpcError
  liftIO $ protoToRuleInfo resp


{- | Delete a workflow rule.

Once deleted, the rule will no longer trigger or take actions on workflows.

@
deleteWorkflowRule (WorkflowRuleId "expense-limiter")
@
-}
deleteWorkflowRule
  :: (HasWorkflowClient m, MonadIO m)
  => WorkflowRuleId
  -> m ()
deleteWorkflowRule (WorkflowRuleId ruleId') = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient

  let req :: RR.DeleteWorkflowRuleRequest
      req =
        defMessage
          & RR.namespace
            .~ rawNamespace ns
          & RR.ruleId
            .~ ruleId'

  _ <- liftIO $ CoreWS.deleteWorkflowRule clientCore req >>= handleRpcError
  pure ()


{- | List all workflow rules in the namespace.

Results can be paginated using the options parameter.

@
let opts = defaultListWorkflowRulesOptions
(rules, nextToken) <- listWorkflowRules opts

-- Get the next page if available
case nextToken of
  Just token -> do
    (moreRules, _) <- listWorkflowRules opts{nextPageToken = Just token}
    -- process moreRules
  Nothing -> pure ()
@
-}
listWorkflowRules
  :: (HasWorkflowClient m, MonadIO m)
  => ListWorkflowRulesOptions
  -> m ([WorkflowRuleInfo], Maybe Text)
listWorkflowRules opts = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient

  let req :: RR.ListWorkflowRulesRequest
      req =
        defMessage
          & RR.namespace
            .~ rawNamespace ns
          & RR.nextPageToken
            .~ maybe "" TE.encodeUtf8 (nextPageToken opts)

  resp <- liftIO $ CoreWS.listWorkflowRules clientCore req >>= handleRpcError

  let rules = resp ^. RR.vec'rules
      nextToken =
        let token = TE.decodeUtf8 (resp ^. RR.nextPageToken)
        in if T.null token then Nothing else Just token

  infos <- liftIO $ mapM workflowRuleFromProto (V.toList rules)
  pure (infos, nextToken)


{- | Manually trigger evaluation of a workflow rule by rule ID.

This is useful for testing rules or manually applying rule actions to specific workflows.

@
triggerWorkflowRuleById
  (WorkflowRuleId "expense-limiter")
  "my-workflow-id"
  Nothing  -- Use current run ID
@
-}
triggerWorkflowRuleById
  :: (HasWorkflowClient m, MonadIO m)
  => WorkflowRuleId
  -> Text
  -- ^ Workflow ID
  -> Maybe Text
  -- ^ Optional run ID (if not provided, uses the current run)
  -> m ()
triggerWorkflowRuleById (WorkflowRuleId ruleId') workflowId mRunId = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient

  let executionBase :: Common.WorkflowExecution
      executionBase =
        defMessage
          & Common.workflowId
            .~ workflowId

      execution :: Common.WorkflowExecution
      execution = case mRunId of
        Nothing -> executionBase
        Just runId -> executionBase & Common.runId .~ runId

      req :: RR.TriggerWorkflowRuleRequest
      req =
        defMessage
          & RR.namespace
            .~ rawNamespace ns
          & RR.execution
            .~ execution
          & RR.id
            .~ ruleId'

  _ <- liftIO $ CoreWS.triggerWorkflowRule clientCore req >>= handleRpcError
  pure ()


{- | Manually trigger evaluation using a complete rule specification.

This allows triggering with an ad-hoc rule specification without creating a persistent rule.

@
let trigger = mkActivityStartTrigger "ActivityType = 'Test'"
    action = mkPauseActivityAction
    query = WorkflowTypeQuery "TestWorkflow"

triggerWorkflowRuleBySpec
  (WorkflowRuleId "temp-rule")
  query
  trigger
  (V.singleton action)
  "my-workflow-id"
  Nothing
@
-}
triggerWorkflowRuleBySpec
  :: (HasWorkflowClient m, MonadIO m)
  => WorkflowRuleId
  -> VisibilityQuery
  -> ActivityStartTrigger
  -> V.Vector PauseActivityAction
  -> Text
  -- ^ Workflow ID
  -> Maybe Text
  -- ^ Optional run ID
  -> m ()
triggerWorkflowRuleBySpec (WorkflowRuleId ruleId') visQuery trigger actions workflowId mRunId = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient

  let activityStartProto :: Rules.WorkflowRuleSpec'ActivityStartingTrigger
      activityStartProto =
        defMessage
          & Rules.predicate
            .~ predicate trigger

      actionsProto = V.map (const (defMessage & Rules.activityPause .~ defMessage)) actions

      spec :: Rules.WorkflowRuleSpec
      spec =
        defMessage
          & Rules.id
            .~ ruleId'
          & Rules.activityStart
            .~ activityStartProto
          & Rules.visibilityQuery
            .~ renderQuery visQuery
          & Rules.vec'actions
            .~ actionsProto

      executionBase :: Common.WorkflowExecution
      executionBase =
        defMessage
          & Common.workflowId
            .~ workflowId

      execution :: Common.WorkflowExecution
      execution = case mRunId of
        Nothing -> executionBase
        Just runId -> executionBase & Common.runId .~ runId

      req :: RR.TriggerWorkflowRuleRequest
      req =
        defMessage
          & RR.namespace
            .~ rawNamespace ns
          & RR.execution
            .~ execution
          & RR.spec
            .~ spec

  _ <- liftIO $ CoreWS.triggerWorkflowRule clientCore req >>= handleRpcError
  pure ()


-- | Convert protobuf DescribeWorkflowRuleResponse to domain type
protoToRuleInfo :: RR.DescribeWorkflowRuleResponse -> IO WorkflowRuleInfo
protoToRuleInfo resp = do
  case resp ^. RR.maybe'rule of
    Nothing -> fail "No rule in response"
    Just rule -> workflowRuleFromProto rule


-- | Convert protobuf WorkflowRule to domain type
workflowRuleFromProto :: Rules.WorkflowRule -> IO WorkflowRuleInfo
workflowRuleFromProto rule = do
  let mSpec = rule ^. Rules.maybe'spec
      createTime' = fmap protoToUTCTime (rule ^. Rules.maybe'createTime)

  case mSpec of
    Nothing -> fail "No spec in workflow rule"
    Just spec -> do
      let ruleId' = spec ^. Rules.id
          visQuery = spec ^. Rules.visibilityQuery
          mTrigger = case spec ^. Rules.maybe'trigger of
            Just (Rules.WorkflowRuleSpec'ActivityStart activityStart) ->
              Just ActivityStartTrigger {predicate = activityStart ^. Rules.predicate}
            Nothing -> Nothing
          expirationTime' = fmap protoToUTCTime (spec ^. Rules.maybe'expirationTime)

      pure
        WorkflowRuleInfo
          { ruleId = WorkflowRuleId ruleId'
          , createTime = createTime'
          , visibilityQuery = VisibilityQueryString visQuery
          , activityStartTrigger = mTrigger
          , expirationTime = expirationTime'
          }


-- | Handle RPC errors by converting and throwing them
handleRpcError :: Either Temporal.Core.Client.RpcError a -> IO a
handleRpcError (Right a) = pure a
handleRpcError (Left err) = throwIO $ coreRpcErrorToRpcError err

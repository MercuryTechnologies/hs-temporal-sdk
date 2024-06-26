{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveLift #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}

module Temporal.TH.Annotations (
  -- * Annotations
  Aliases (..),
  aliases,
  TaskQueuePreference (..),
  NameOverride (..),
  overrideName,
  ActivityTimeoutPolicy (..),
  activityTimeout,
  ScheduleToStartTimeout (..),
  HeartbeatTimeout (..),

  -- * Finding and validating annotations
  findAllAnnotations,
  AllAnnotations (..),
  WorkflowAnnotations (..),
  workflowAnnotationsToStartWorkflowOptionsModifier,
  workflowAnnotationsToStartChildWorkflowOptionsModifier,
  ActivityAnnotations (..),
  activityAnnotationsToStartActivityOptionsModifier,
  ValidationResult (..),
  validateWorkflowAnnotations,
  validateActivityAnnotations,
  formatValidationResults,
) where

import Control.Applicative
import Data.Coerce
import Data.Data
import Data.Foldable (toList)
import Data.List.NonEmpty (NonEmpty)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromMaybe)
import Data.Text
import qualified Data.Text as Text
import Language.Haskell.TH.Syntax (AnnLookup (..), Lift, Name, Quasi (..))
import Temporal.Client (StartWorkflowOptions (..))
import Temporal.Duration (Duration)
import Temporal.SearchAttributes
import Temporal.Workflow (
  ActivityCancellationType,
  ActivityTimeoutPolicy,
  ChildWorkflowCancellationType,
  ParentClosePolicy,
  RetryPolicy,
  StartActivityOptions (..),
  StartActivityTimeoutOption (..),
  StartChildWorkflowOptions (..),
  TaskQueue (..),
  TimeoutOptions,
  WorkflowIdReusePolicy,
 )
import Validation


data TaskQueuePreference
  = NoPreference
  | -- | Always use this task queue when starting the given workflow or activity
    -- when not manually overridden by the caller.
    --
    -- This is still _overridable_ by the caller when starting the workflow or activity.
    AlwaysUse TaskQueue
  | -- | Use this task queue if no other task queue is specified when starting the workflow
    -- using the client.
    Root TaskQueue
  deriving stock (Show, Eq, Data, Lift)


newtype NameOverride = NameOverride Text.Text
  deriving stock (Show, Eq, Data, Lift)


{- | Sometimes you want to override the name of a Workflow or Activity. This can be
useful if the fully qualified name of the function is really long and you want
to provide a shorter name for the Workflow or Activity. This can also be useful
if you want to provide a more descriptive name for the Workflow or Activity.

Applies to: Workflows, Activities
-}
overrideName :: Text.Text -> NameOverride
overrideName = NameOverride


newtype Aliases = Aliases [Text.Text]
  deriving stock (Show, Eq, Data, Lift)


{- | It's a fairly common need to move the definition of a Workflow or Activity
to a different module or rename the function. If you do this naively, you may
end up with a Workflow that is currently running in Temporal that can't complete
execution because the function it was referencing no longer exists. To avoid this,
you can use the `aliases` annotation to provide a list of aliases that the Workflow
or Activity can be referenced by. This way, you can move or rename the function
while providing backwards compatibility for any currently running Workflows.

Once you are sure that all Workflows that were referencing the old name have
completed, you can remove the alias.

Applies to: Workflows, Activities
-}
aliases :: [Text.Text] -> Aliases
aliases = Aliases


{- | When writing an Activity, it is often the case that the original implementor of the
Activity has a better understanding of the Activity's behavior than the caller of the
Activity. In this case, the implementor of the Activity should consider providing a default
timeout for the Activity so that the caller doesn't have to provide a timeout for every
invocation of the Activity.

Applies to: Activities
-}
activityTimeout :: forall timeout. StartActivityTimeoutOption timeout => timeout -> ActivityTimeoutPolicy
activityTimeout = toStartActivityTimeoutOption


newtype HeartbeatTimeout = HeartbeatTimeout Duration
  deriving stock (Show, Eq, Data, Lift)


newtype ScheduleToStartTimeout = ScheduleToStartTimeout Duration
  deriving stock (Show, Eq, Data, Lift)


-- TODO
-- data PayloadCodec = PayloadCodec 'Name
--   deriving (Data)

{- | When invoking a Workflow from a client, you must specify what task queue the Workflow
should be scheduled on. This can be done by providing a `TaskQueue` value at the callsite,
but it can be tedious to provide the same `TaskQueue` value every time you invoke the Workflow.
If a particular Workflow always uses the same `TaskQueue`, you can provide a default `TaskQueue`
for the Workflow so that the caller doesn't have to provide the `TaskQueue` every time.
defaultTaskQueue
-}

{- |
preferredTaskQueue
-}

{- | When an Activity or Workflow fails, you can specify a Retry Policy to determine how the Activity
or Workflow should be retried. This can be useful for handling transient failures in a way that
is transparent to the caller of the Activity or Workflow.

It is more common for the original implementor of the Activity or Workflow to have a better
understanding of the failure characteristics of the Activity or Workflow, so it is recommended
that the implementor provide a default Retry Policy for the Activity or Workflow so that the caller
benefits from the domain knowledge of the implementor.

Applies to: Activities, Workflows
retryPolicy
-}

-- executionTimeout
-- runTimeout
-- taskTimeout
-- heartbeatTimeout

{- | A Workflow Id Reuse Policy determines whether a Workflow Execution is allowed to spawn with a
particular Workflow Id, if that Workflow Id has been used with a previous, and now Closed, Workflow Execution.

As with Retry Policies, it is more common for the original implementor of the Workflow to have a better
understanding of the Workflow's behavior, so it is recommended that the implementor provide a default
if the Workflow Id Reuse Policy is meaningful for the Workflow.

Applies to: Workflows
workflowIdReusePolicy
-}

{- | When starting a Workflow, search attributes can be provided to the Workflow to help with
querying and filtering Workflows in the Temporal dashboard. The annotation version of this
will apply to all invocations of the Workflow.
searchAttributes
-}

{- | When canceling an Activity, initiate a cancellation request and immediately report cancellation
to the workflow.
activityCancellation
-}

-- parentClosePolicy

data AllAnnotations = AllAnnotations
  { nameOverrideAnns :: [NameOverride]
  , aliasesAnns :: [Text]
  , activityTimeoutAnns :: [ActivityTimeoutPolicy]
  , taskQueueAnns :: [TaskQueuePreference]
  , retryPolicyAnns :: [RetryPolicy]
  , workflowIdReusePolicyAnns :: [WorkflowIdReusePolicy]
  , searchAttributesAnns :: [(Text, SearchAttributeType)]
  , timeoutsAnns :: [TimeoutOptions]
  , activityCancellationTypeAnns :: [ActivityCancellationType]
  , scheduleToStartTimeoutAnns :: [ScheduleToStartTimeout]
  , heartbeatTimeoutAnns :: [HeartbeatTimeout]
  , childWorkflowCancellationTypeAnns :: [ChildWorkflowCancellationType]
  , parentClosePolicyAnns :: [ParentClosePolicy]
  }


findAllAnnotations :: Quasi m => Name -> m AllAnnotations
findAllAnnotations n = do
  AllAnnotations
    <$> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n
    <*> findAnn n


data ValidationResult
  = OnlyForWorkflows Text
  | OnlyForActivities Text
  | OnlySupportsOneAnnotation Text


formatValidationResults :: Name -> NonEmpty ValidationResult -> String
formatValidationResults txt = Prelude.unlines . fmap go . toList
  where
    go = \case
      OnlyForWorkflows ann -> "The annotation " <> Text.unpack ann <> " on " <> show txt <> " is only supported for Workflows."
      OnlyForActivities ann -> "The annotation " <> Text.unpack ann <> " on " <> show txt <> " is only supported for Activities."
      OnlySupportsOneAnnotation ann -> "The annotation " <> Text.unpack ann <> " on " <> show txt <> " can only occur once."


data WorkflowAnnotations = WorkflowAnnotations
  { wfNameOverride :: Maybe Text
  , wfAliases :: [Text]
  , wfTaskQueue :: TaskQueuePreference
  , wfRetryPolicy :: Maybe RetryPolicy
  , wfWorkflowIdReusePolicy :: Maybe WorkflowIdReusePolicy
  , wfSearchAttributes :: [(Text, SearchAttributeType)]
  , wfTimeouts :: Maybe TimeoutOptions
  , wfChildWorkflowCancellationType :: Maybe ChildWorkflowCancellationType
  , wfParentClosePolicy :: Maybe ParentClosePolicy
  }
  deriving stock (Show, Eq, Data, Lift)


atMostOne :: Text -> [a] -> Validation (NonEmpty ValidationResult) (Maybe a)
atMostOne txt (_ : _ : _xs) = failure $ OnlySupportsOneAnnotation txt
atMostOne _ [x] = pure $ Just x
atMostOne _ [] = pure Nothing


ensureActivityOnlyOptionUnpopulated :: Text -> [a] -> Validation (NonEmpty ValidationResult) ()
ensureActivityOnlyOptionUnpopulated _ [] = pure ()
ensureActivityOnlyOptionUnpopulated txt _ = failure $ OnlyForActivities txt


validateWorkflowAnnotations :: AllAnnotations -> Validation (NonEmpty ValidationResult) WorkflowAnnotations
validateWorkflowAnnotations AllAnnotations {..} = do
  ensureActivityOnlyOptionUnpopulated "activityTimeout" activityTimeoutAnns
    *> ensureActivityOnlyOptionUnpopulated "heartbeatTimeout" heartbeatTimeoutAnns
    *> ensureActivityOnlyOptionUnpopulated "activityCancellationType" activityCancellationTypeAnns
    *> ensureActivityOnlyOptionUnpopulated "scheduleToStartTimeout" scheduleToStartTimeoutAnns
    *> ( WorkflowAnnotations
          <$> atMostOne "nameOverride" (coerce nameOverrideAnns)
          <*> pure aliasesAnns
          <*> (fromMaybe NoPreference <$> atMostOne "taskQueue" taskQueueAnns)
          <*> atMostOne "retryPolicy" retryPolicyAnns
          <*> atMostOne "workflowIdReusePolicy" workflowIdReusePolicyAnns
          <*> pure searchAttributesAnns
          <*> atMostOne "timeouts" timeoutsAnns
       )
    <*> atMostOne "childWorkflowCancellationType" childWorkflowCancellationTypeAnns
    <*> atMostOne "parentClosePolicy" parentClosePolicyAnns


workflowAnnotationsToStartWorkflowOptionsModifier :: WorkflowAnnotations -> StartWorkflowOptions -> StartWorkflowOptions
workflowAnnotationsToStartWorkflowOptionsModifier WorkflowAnnotations {..} opts =
  opts
    { taskQueue = case wfTaskQueue of
        AlwaysUse tq -> tq
        Root tq -> tq
        NoPreference -> Temporal.Client.taskQueue opts
    , retryPolicy = wfRetryPolicy <|> opts.retryPolicy
    , workflowIdReusePolicy = wfWorkflowIdReusePolicy <|> opts.workflowIdReusePolicy
    , searchAttributes = Map.fromList wfSearchAttributes <> opts.searchAttributes
    , timeouts = fromMaybe (Temporal.Client.timeouts opts) wfTimeouts
    }


workflowAnnotationsToStartChildWorkflowOptionsModifier :: WorkflowAnnotations -> StartChildWorkflowOptions -> StartChildWorkflowOptions
workflowAnnotationsToStartChildWorkflowOptionsModifier WorkflowAnnotations {..} opts =
  opts
    { taskQueue = case wfTaskQueue of
        AlwaysUse tq -> Just tq
        Root _ -> opts.taskQueue
        NoPreference -> opts.taskQueue
    , retryPolicy = wfRetryPolicy <|> opts.retryPolicy
    , searchAttributes = Map.fromList wfSearchAttributes <> opts.searchAttributes
    , timeoutOptions = fromMaybe (Temporal.Workflow.timeoutOptions opts) wfTimeouts
    , workflowIdReusePolicy = fromMaybe (Temporal.Workflow.workflowIdReusePolicy opts) wfWorkflowIdReusePolicy
    , parentClosePolicy = fromMaybe (Temporal.Workflow.parentClosePolicy opts) wfParentClosePolicy
    , cancellationType = fromMaybe opts.cancellationType wfChildWorkflowCancellationType
    }


data ActivityAnnotations = ActivityAnnotations
  { actNameOverride :: Maybe Text
  , actAliases :: [Text]
  , actActivityTimeout :: Maybe ActivityTimeoutPolicy
  , actTaskQueue :: TaskQueuePreference
  , actRetryPolicy :: Maybe RetryPolicy
  , actTimeouts :: Maybe TimeoutOptions
  , actActivityCancellationType :: Maybe ActivityCancellationType
  , actScheduleToStartTimeout :: Maybe Duration
  , actHeartbeatTimeout :: Maybe Duration
  }
  deriving stock (Show, Eq, Data, Lift)


validateActivityAnnotations :: AllAnnotations -> Validation (NonEmpty ValidationResult) ActivityAnnotations
validateActivityAnnotations AllAnnotations {..} = do
  ensureActivityOnlyOptionUnpopulated "workflowIdReusePolicy" workflowIdReusePolicyAnns
    *> ensureActivityOnlyOptionUnpopulated "searchAttributes" searchAttributesAnns
    *> ensureActivityOnlyOptionUnpopulated "childWorkflowCancellationType" childWorkflowCancellationTypeAnns
    *> ensureActivityOnlyOptionUnpopulated "parentClosePolicy" parentClosePolicyAnns
    *> ( ActivityAnnotations
          <$> atMostOne "nameOverride" (coerce nameOverrideAnns)
          <*> pure aliasesAnns
          <*> atMostOne "activityTimeout" activityTimeoutAnns
          <*> (fromMaybe NoPreference <$> atMostOne "taskQueue" taskQueueAnns)
          <*> atMostOne "retryPolicy" retryPolicyAnns
          <*> atMostOne "timeouts" timeoutsAnns
          <*> atMostOne "activityCancellationType" activityCancellationTypeAnns
          <*> fmap coerce (atMostOne "scheduleToStartTimeout" scheduleToStartTimeoutAnns)
          <*> fmap coerce (atMostOne "heartbeatTimeout" heartbeatTimeoutAnns)
       )


activityAnnotationsToStartActivityOptionsModifier :: ActivityAnnotations -> StartActivityOptions -> StartActivityOptions
activityAnnotationsToStartActivityOptionsModifier ActivityAnnotations {..} opts =
  opts
    { taskQueue = case actTaskQueue of
        AlwaysUse tq -> Just tq
        _ -> opts.taskQueue
    , retryPolicy = actRetryPolicy <|> opts.retryPolicy
    , timeout = fromMaybe (timeout opts) actActivityTimeout
    , scheduleToStartTimeout = actScheduleToStartTimeout <|> scheduleToStartTimeout opts
    , heartbeatTimeout = actHeartbeatTimeout <|> heartbeatTimeout opts
    , cancellationType = fromMaybe opts.cancellationType actActivityCancellationType
    }


findAnn :: (Data a, Quasi m) => Name -> m [a]
findAnn = qReifyAnnotations . AnnLookupName

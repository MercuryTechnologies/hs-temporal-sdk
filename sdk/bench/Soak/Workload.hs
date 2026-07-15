{-# LANGUAGE TemplateHaskell #-}

-- | Soak worker configuration. Collects the TH-registered workload
-- ("Soak.Workload.Defs") into a 'WorkerConfig' via 'discoverDefinitions' +
-- 'discoverInstances', and re-exports the archetype reference types the client
-- loop starts.
module Soak.Workload (
  Archetype (..),
  OutboxWorkflow (..),
  SyncWorkflow (..),
  TimerWorkflow (..),
  soakWorkerConfig,
) where

import Data.Word (Word64)
import DiscoverInstances (discoverInstances)
import RequireCallStack (provideCallStack)
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import Temporal.Worker
import Temporal.Workflow (TaskQueue)

import Bench.Common (fixtureNs)
import Soak.Workload.Defs (OutboxWorkflow (..), SyncWorkflow (..), TimerWorkflow (..))


-- | Which archetype an execution drives. The client loop rotates these by a
-- configurable ratio.
data Archetype = Outbox | Sync | Timer
  deriving stock (Eq, Show)


-- | Worker config for the soak. @maxCached@ is the leak lever: a low value forces
-- the sticky cache to churn so the eviction path (prime leak suspect) actually
-- runs. Discarding logger keeps output clean. Definitions are discovered from the
-- TH-registered workload; 'provideCallStack' discharges 'discoverDefinitions'\''s
-- 'RequireCallStack'.
soakWorkerConfig :: Word64 -> TaskQueue -> WorkerConfig ()
soakWorkerConfig maxCached tq =
  provideCallStack $
    configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
      setNamespace fixtureNs
      setTaskQueue tq
      setMaxCachedWorkflows maxCached
      setLogger (\_ _ _ _ -> pure ())

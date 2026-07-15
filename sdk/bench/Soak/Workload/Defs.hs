{-# LANGUAGE DeriveLift #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE TemplateHaskell #-}

-- | Soak workload, registered via Temporal's Template Haskell 'register' splice.
-- Each function gets a generated PascalCase reference type (e.g. 'SoakActivity',
-- 'OutboxWorkflow') carrying the ActivityRef/WorkflowRef instances, so they can be
-- invoked with arguments directly — no ambiguous @.reference@ type-family plumbing.
--
-- Two prod-shaped archetypes plus a shared activity, all exercising the REAL
-- worker path (poll → execute → complete → evict) against a live dev server:
--   * 'OutboxWorkflow' — sequential state machine (activity run K times in series).
--   * 'SyncWorkflow'   — fan-out (C child workflows, each calling the activity).
--
-- Kept in its own module (no export list, so the generated names/instances are all
-- exported) so that 'discoverInstances' in "Soak.Workload" sees these instances as
-- imported — which is staging-safe, unlike discovering same-module splice output.
module Soak.Workload.Defs where

import Control.Monad (replicateM_, void)
import RequireCallStack (provideCallStack)
import Soak.Workload.Types (Blob (..), mkBlob)
import Temporal.Activity
import Temporal.Duration (milliseconds, seconds)
-- Whole-module import: the generated @deriving via WorkflowImpl/ActivityImpl@
-- clauses need those newtype constructors in scope for their coercions.
import Temporal.TH
import Temporal.Workflow


-- | Item count for the per-activity payload blob (~30 KB of JSON at 256).
blobSize :: Int
blobSize = 256


$( register
    [d|
      -- Activity takes and returns a large nested record ('Blob') so both the
      -- inbound arg decode and the outbound result encode move a big JSON /
      -- proto payload. Bumping blobId forces a real decode->transform->encode.
      soakActivity :: Blob -> Activity () Blob
      soakActivity b = pure b {blobId = blobId b + 1}


      soakLeafWorkflow :: Int -> Workflow ()
      soakLeafWorkflow i =
        provideCallStack $
          void (executeActivity SoakActivity (defaultStartActivityOptions $ StartToClose $ seconds 10) (mkBlob i blobSize))


      outboxWorkflow :: Int -> Workflow ()
      outboxWorkflow k =
        provideCallStack $
          replicateM_ k (void (executeActivity SoakActivity (defaultStartActivityOptions $ StartToClose $ seconds 10) (mkBlob k blobSize)))


      syncWorkflow :: Int -> Workflow ()
      syncWorkflow c =
        provideCallStack $
          forConcurrently_ [1 .. c] $ \i ->
            void (executeChildWorkflow SoakLeafWorkflow defaultChildWorkflowOptions i)


      -- Discriminator archetype: exercises the SAME resolution / sequence-map /
      -- IVar path as the activity archetypes (K sequential timer fires → K
      -- resolutions) but with ZERO activity tasks. If this leaks, the leak is in
      -- the shared workflow-side resolution machinery, not activities.
      timerWorkflow :: Int -> Workflow ()
      timerWorkflow k =
        provideCallStack $
          replicateM_ k (sleep (milliseconds 1))
      |]
 )

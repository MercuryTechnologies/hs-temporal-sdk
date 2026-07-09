{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

commands = Lens.field @"commands"
maybe'commands = Lens.field @"commands"
vec'commands = Lens.field @"commands"
failure = Lens.field @"failure"
maybe'failure = Lens.field @"failure"
vec'failure = Lens.field @"failure"
forceCause = Lens.field @"forceCause"
maybe'forceCause = Lens.field @"forceCause"
vec'forceCause = Lens.field @"forceCause"
runId = Lens.field @"runId"
maybe'runId = Lens.field @"runId"
vec'runId = Lens.field @"runId"
status = Lens.field @"status"
maybe'status = Lens.field @"status"
vec'status = Lens.field @"status"
usedInternalFlags = Lens.field @"usedInternalFlags"
maybe'usedInternalFlags = Lens.field @"usedInternalFlags"
vec'usedInternalFlags = Lens.field @"usedInternalFlags"
versioningBehavior = Lens.field @"versioningBehavior"
maybe'versioningBehavior = Lens.field @"versioningBehavior"
vec'versioningBehavior = Lens.field @"versioningBehavior"

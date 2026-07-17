{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Filter.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

earliestTime = Lens.field @"earliestTime"
maybe'earliestTime = Lens.field @"earliestTime"
vec'earliestTime = Lens.field @"earliestTime"
latestTime = Lens.field @"latestTime"
maybe'latestTime = Lens.field @"latestTime"
vec'latestTime = Lens.field @"latestTime"
name = Lens.field @"name"
maybe'name = Lens.field @"name"
vec'name = Lens.field @"name"
runId = Lens.field @"runId"
maybe'runId = Lens.field @"runId"
vec'runId = Lens.field @"runId"
status = Lens.field @"status"
maybe'status = Lens.field @"status"
vec'status = Lens.field @"status"
workflowId = Lens.field @"workflowId"
maybe'workflowId = Lens.field @"workflowId"
vec'workflowId = Lens.field @"workflowId"

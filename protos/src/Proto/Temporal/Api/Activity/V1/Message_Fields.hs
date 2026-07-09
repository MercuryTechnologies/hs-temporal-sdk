{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Activity.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

heartbeatTimeout = Lens.field @"heartbeatTimeout"
maybe'heartbeatTimeout = Lens.field @"heartbeatTimeout"
vec'heartbeatTimeout = Lens.field @"heartbeatTimeout"
retryPolicy = Lens.field @"retryPolicy"
maybe'retryPolicy = Lens.field @"retryPolicy"
vec'retryPolicy = Lens.field @"retryPolicy"
scheduleToCloseTimeout = Lens.field @"scheduleToCloseTimeout"
maybe'scheduleToCloseTimeout = Lens.field @"scheduleToCloseTimeout"
vec'scheduleToCloseTimeout = Lens.field @"scheduleToCloseTimeout"
scheduleToStartTimeout = Lens.field @"scheduleToStartTimeout"
maybe'scheduleToStartTimeout = Lens.field @"scheduleToStartTimeout"
vec'scheduleToStartTimeout = Lens.field @"scheduleToStartTimeout"
startToCloseTimeout = Lens.field @"startToCloseTimeout"
maybe'startToCloseTimeout = Lens.field @"startToCloseTimeout"
vec'startToCloseTimeout = Lens.field @"startToCloseTimeout"
taskQueue = Lens.field @"taskQueue"
maybe'taskQueue = Lens.field @"taskQueue"
vec'taskQueue = Lens.field @"taskQueue"

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Sdk.Core.ExternalData.ExternalData_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

activityId = Lens.field @"activityId"
maybe'activityId = Lens.field @"activityId"
vec'activityId = Lens.field @"activityId"
activityType = Lens.field @"activityType"
maybe'activityType = Lens.field @"activityType"
vec'activityType = Lens.field @"activityType"
attempt = Lens.field @"attempt"
maybe'attempt = Lens.field @"attempt"
vec'attempt = Lens.field @"attempt"
backoff = Lens.field @"backoff"
maybe'backoff = Lens.field @"backoff"
vec'backoff = Lens.field @"backoff"
completeTime = Lens.field @"completeTime"
maybe'completeTime = Lens.field @"completeTime"
vec'completeTime = Lens.field @"completeTime"
deprecated = Lens.field @"deprecated"
maybe'deprecated = Lens.field @"deprecated"
vec'deprecated = Lens.field @"deprecated"
id = Lens.field @"id"
maybe'id = Lens.field @"id"
vec'id = Lens.field @"id"
originalScheduleTime = Lens.field @"originalScheduleTime"
maybe'originalScheduleTime = Lens.field @"originalScheduleTime"
vec'originalScheduleTime = Lens.field @"originalScheduleTime"
seq = Lens.field @"seq"
maybe'seq = Lens.field @"seq"
vec'seq = Lens.field @"seq"

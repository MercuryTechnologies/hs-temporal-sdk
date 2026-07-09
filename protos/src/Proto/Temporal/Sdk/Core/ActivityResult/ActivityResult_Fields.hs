{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

attempt = Lens.field @"attempt"
maybe'attempt = Lens.field @"attempt"
vec'attempt = Lens.field @"attempt"
backoffDuration = Lens.field @"backoffDuration"
maybe'backoffDuration = Lens.field @"backoffDuration"
vec'backoffDuration = Lens.field @"backoffDuration"
failure = Lens.field @"failure"
maybe'failure = Lens.field @"failure"
vec'failure = Lens.field @"failure"
originalScheduleTime = Lens.field @"originalScheduleTime"
maybe'originalScheduleTime = Lens.field @"originalScheduleTime"
vec'originalScheduleTime = Lens.field @"originalScheduleTime"
result = Lens.field @"result"
maybe'result = Lens.field @"result"
vec'result = Lens.field @"result"
status = Lens.field @"status"
maybe'status = Lens.field @"status"
vec'status = Lens.field @"status"

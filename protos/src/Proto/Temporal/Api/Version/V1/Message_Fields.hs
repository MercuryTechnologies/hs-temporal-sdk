{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Version.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

alerts = Lens.field @"alerts"
maybe'alerts = Lens.field @"alerts"
vec'alerts = Lens.field @"alerts"
current = Lens.field @"current"
maybe'current = Lens.field @"current"
vec'current = Lens.field @"current"
instructions = Lens.field @"instructions"
maybe'instructions = Lens.field @"instructions"
vec'instructions = Lens.field @"instructions"
lastUpdateTime = Lens.field @"lastUpdateTime"
maybe'lastUpdateTime = Lens.field @"lastUpdateTime"
vec'lastUpdateTime = Lens.field @"lastUpdateTime"
message = Lens.field @"message"
maybe'message = Lens.field @"message"
vec'message = Lens.field @"message"
notes = Lens.field @"notes"
maybe'notes = Lens.field @"notes"
vec'notes = Lens.field @"notes"
recommended = Lens.field @"recommended"
maybe'recommended = Lens.field @"recommended"
vec'recommended = Lens.field @"recommended"
releaseTime = Lens.field @"releaseTime"
maybe'releaseTime = Lens.field @"releaseTime"
vec'releaseTime = Lens.field @"releaseTime"
severity = Lens.field @"severity"
maybe'severity = Lens.field @"severity"
vec'severity = Lens.field @"severity"
version = Lens.field @"version"
maybe'version = Lens.field @"version"
vec'version = Lens.field @"version"

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

reason = Lens.field @"reason"
maybe'reason = Lens.field @"reason"
vec'reason = Lens.field @"reason"
status = Lens.field @"status"
maybe'status = Lens.field @"status"
vec'status = Lens.field @"status"
taskToken = Lens.field @"taskToken"
maybe'taskToken = Lens.field @"taskToken"
vec'taskToken = Lens.field @"taskToken"
variant = Lens.field @"variant"
maybe'variant = Lens.field @"variant"
vec'variant = Lens.field @"variant"

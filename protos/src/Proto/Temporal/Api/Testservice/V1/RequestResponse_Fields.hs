{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

duration = Lens.field @"duration"
maybe'duration = Lens.field @"duration"
vec'duration = Lens.field @"duration"
time = Lens.field @"time"
maybe'time = Lens.field @"time"
vec'time = Lens.field @"time"
timestamp = Lens.field @"timestamp"
maybe'timestamp = Lens.field @"timestamp"
vec'timestamp = Lens.field @"timestamp"

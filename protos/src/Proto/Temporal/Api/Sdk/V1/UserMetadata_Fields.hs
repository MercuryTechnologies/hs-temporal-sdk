{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Sdk.V1.UserMetadata_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

details = Lens.field @"details"
maybe'details = Lens.field @"details"
vec'details = Lens.field @"details"
summary = Lens.field @"summary"
maybe'summary = Lens.field @"summary"
vec'summary = Lens.field @"summary"

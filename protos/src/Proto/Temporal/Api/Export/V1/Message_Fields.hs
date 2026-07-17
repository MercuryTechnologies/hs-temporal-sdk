{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Export.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

history = Lens.field @"history"
maybe'history = Lens.field @"history"
vec'history = Lens.field @"history"
items = Lens.field @"items"
maybe'items = Lens.field @"items"
vec'items = Lens.field @"items"

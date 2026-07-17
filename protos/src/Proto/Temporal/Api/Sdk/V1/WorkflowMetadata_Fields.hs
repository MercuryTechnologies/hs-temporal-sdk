{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

currentDetails = Lens.field @"currentDetails"
maybe'currentDetails = Lens.field @"currentDetails"
vec'currentDetails = Lens.field @"currentDetails"
definition = Lens.field @"definition"
maybe'definition = Lens.field @"definition"
vec'definition = Lens.field @"definition"
description = Lens.field @"description"
maybe'description = Lens.field @"description"
vec'description = Lens.field @"description"
name = Lens.field @"name"
maybe'name = Lens.field @"name"
vec'name = Lens.field @"name"
queryDefinitions = Lens.field @"queryDefinitions"
maybe'queryDefinitions = Lens.field @"queryDefinitions"
vec'queryDefinitions = Lens.field @"queryDefinitions"
signalDefinitions = Lens.field @"signalDefinitions"
maybe'signalDefinitions = Lens.field @"signalDefinitions"
vec'signalDefinitions = Lens.field @"signalDefinitions"
type' = Lens.field @"type'"
maybe'type' = Lens.field @"type'"
vec'type' = Lens.field @"type'"
updateDefinitions = Lens.field @"updateDefinitions"
maybe'updateDefinitions = Lens.field @"updateDefinitions"
vec'updateDefinitions = Lens.field @"updateDefinitions"

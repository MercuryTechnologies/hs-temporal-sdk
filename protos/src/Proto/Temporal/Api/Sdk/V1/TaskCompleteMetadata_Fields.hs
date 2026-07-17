{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

coreUsedFlags = Lens.field @"coreUsedFlags"
maybe'coreUsedFlags = Lens.field @"coreUsedFlags"
vec'coreUsedFlags = Lens.field @"coreUsedFlags"
langUsedFlags = Lens.field @"langUsedFlags"
maybe'langUsedFlags = Lens.field @"langUsedFlags"
vec'langUsedFlags = Lens.field @"langUsedFlags"
sdkName = Lens.field @"sdkName"
maybe'sdkName = Lens.field @"sdkName"
vec'sdkName = Lens.field @"sdkName"
sdkVersion = Lens.field @"sdkVersion"
maybe'sdkVersion = Lens.field @"sdkVersion"
vec'sdkVersion = Lens.field @"sdkVersion"

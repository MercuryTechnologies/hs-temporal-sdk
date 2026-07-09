{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

initialPollers = Lens.field @"initialPollers"
maybe'initialPollers = Lens.field @"initialPollers"
vec'initialPollers = Lens.field @"initialPollers"
maxPollers = Lens.field @"maxPollers"
maybe'maxPollers = Lens.field @"maxPollers"
vec'maxPollers = Lens.field @"maxPollers"
minPollers = Lens.field @"minPollers"
maybe'minPollers = Lens.field @"minPollers"
vec'minPollers = Lens.field @"minPollers"
pollerBehavior = Lens.field @"pollerBehavior"
maybe'pollerBehavior = Lens.field @"pollerBehavior"
vec'pollerBehavior = Lens.field @"pollerBehavior"
workflowCacheSize = Lens.field @"workflowCacheSize"
maybe'workflowCacheSize = Lens.field @"workflowCacheSize"
vec'workflowCacheSize = Lens.field @"workflowCacheSize"

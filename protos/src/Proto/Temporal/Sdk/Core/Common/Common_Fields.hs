{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Sdk.Core.Common.Common_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

buildId = Lens.field @"buildId"
maybe'buildId = Lens.field @"buildId"
vec'buildId = Lens.field @"buildId"
deploymentName = Lens.field @"deploymentName"
maybe'deploymentName = Lens.field @"deploymentName"
vec'deploymentName = Lens.field @"deploymentName"
namespace = Lens.field @"namespace"
maybe'namespace = Lens.field @"namespace"
vec'namespace = Lens.field @"namespace"
runId = Lens.field @"runId"
maybe'runId = Lens.field @"runId"
vec'runId = Lens.field @"runId"
workflowId = Lens.field @"workflowId"
maybe'workflowId = Lens.field @"workflowId"
vec'workflowId = Lens.field @"workflowId"

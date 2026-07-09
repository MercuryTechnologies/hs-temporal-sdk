{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Sdk.Core.CoreInterface_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

activityType = Lens.field @"activityType"
maybe'activityType = Lens.field @"activityType"
vec'activityType = Lens.field @"activityType"
details = Lens.field @"details"
maybe'details = Lens.field @"details"
vec'details = Lens.field @"details"
isSticky = Lens.field @"isSticky"
maybe'isSticky = Lens.field @"isSticky"
vec'isSticky = Lens.field @"isSticky"
operation = Lens.field @"operation"
maybe'operation = Lens.field @"operation"
vec'operation = Lens.field @"operation"
result = Lens.field @"result"
maybe'result = Lens.field @"result"
vec'result = Lens.field @"result"
service = Lens.field @"service"
maybe'service = Lens.field @"service"
vec'service = Lens.field @"service"
taskToken = Lens.field @"taskToken"
maybe'taskToken = Lens.field @"taskToken"
vec'taskToken = Lens.field @"taskToken"
workflowType = Lens.field @"workflowType"
maybe'workflowType = Lens.field @"workflowType"
vec'workflowType = Lens.field @"workflowType"

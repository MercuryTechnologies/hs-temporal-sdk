{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

failure = Lens.field @"failure"
maybe'failure = Lens.field @"failure"
vec'failure = Lens.field @"failure"
result = Lens.field @"result"
maybe'result = Lens.field @"result"
vec'result = Lens.field @"result"
status = Lens.field @"status"
maybe'status = Lens.field @"status"
vec'status = Lens.field @"status"

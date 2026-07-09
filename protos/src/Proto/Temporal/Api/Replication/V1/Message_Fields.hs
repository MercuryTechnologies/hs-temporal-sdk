{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Replication.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

activeClusterName = Lens.field @"activeClusterName"
maybe'activeClusterName = Lens.field @"activeClusterName"
vec'activeClusterName = Lens.field @"activeClusterName"
clusterName = Lens.field @"clusterName"
maybe'clusterName = Lens.field @"clusterName"
vec'clusterName = Lens.field @"clusterName"
clusters = Lens.field @"clusters"
maybe'clusters = Lens.field @"clusters"
vec'clusters = Lens.field @"clusters"
failoverTime = Lens.field @"failoverTime"
maybe'failoverTime = Lens.field @"failoverTime"
vec'failoverTime = Lens.field @"failoverTime"
failoverVersion = Lens.field @"failoverVersion"
maybe'failoverVersion = Lens.field @"failoverVersion"
vec'failoverVersion = Lens.field @"failoverVersion"
state = Lens.field @"state"
maybe'state = Lens.field @"state"
vec'state = Lens.field @"state"

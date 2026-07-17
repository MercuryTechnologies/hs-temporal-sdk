{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Rules.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

actions = Lens.field @"actions"
maybe'actions = Lens.field @"actions"
vec'actions = Lens.field @"actions"
createTime = Lens.field @"createTime"
maybe'createTime = Lens.field @"createTime"
vec'createTime = Lens.field @"createTime"
createdByIdentity = Lens.field @"createdByIdentity"
maybe'createdByIdentity = Lens.field @"createdByIdentity"
vec'createdByIdentity = Lens.field @"createdByIdentity"
description = Lens.field @"description"
maybe'description = Lens.field @"description"
vec'description = Lens.field @"description"
expirationTime = Lens.field @"expirationTime"
maybe'expirationTime = Lens.field @"expirationTime"
vec'expirationTime = Lens.field @"expirationTime"
id = Lens.field @"id"
maybe'id = Lens.field @"id"
vec'id = Lens.field @"id"
predicate = Lens.field @"predicate"
maybe'predicate = Lens.field @"predicate"
vec'predicate = Lens.field @"predicate"
spec = Lens.field @"spec"
maybe'spec = Lens.field @"spec"
vec'spec = Lens.field @"spec"
trigger = Lens.field @"trigger"
maybe'trigger = Lens.field @"trigger"
vec'trigger = Lens.field @"trigger"
variant = Lens.field @"variant"
maybe'variant = Lens.field @"variant"
vec'variant = Lens.field @"variant"
visibilityQuery = Lens.field @"visibilityQuery"
maybe'visibilityQuery = Lens.field @"visibilityQuery"
vec'visibilityQuery = Lens.field @"visibilityQuery"

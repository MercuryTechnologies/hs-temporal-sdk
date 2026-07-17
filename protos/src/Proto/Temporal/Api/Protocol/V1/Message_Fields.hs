{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Protocol.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

body = Lens.field @"body"
maybe'body = Lens.field @"body"
vec'body = Lens.field @"body"
id = Lens.field @"id"
maybe'id = Lens.field @"id"
vec'id = Lens.field @"id"
protocolInstanceId = Lens.field @"protocolInstanceId"
maybe'protocolInstanceId = Lens.field @"protocolInstanceId"
vec'protocolInstanceId = Lens.field @"protocolInstanceId"
sequencingId = Lens.field @"sequencingId"
maybe'sequencingId = Lens.field @"sequencingId"
vec'sequencingId = Lens.field @"sequencingId"

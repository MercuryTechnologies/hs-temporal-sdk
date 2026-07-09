{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Rpc.Status_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

code = Lens.field @"code"
maybe'code = Lens.field @"code"
vec'code = Lens.field @"code"
details = Lens.field @"details"
maybe'details = Lens.field @"details"
vec'details = Lens.field @"details"
message = Lens.field @"message"
maybe'message = Lens.field @"message"
vec'message = Lens.field @"message"

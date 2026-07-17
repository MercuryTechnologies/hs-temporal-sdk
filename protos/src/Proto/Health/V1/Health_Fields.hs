{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Health.V1.Health_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

check = Lens.field @"check"
maybe'check = Lens.field @"check"
vec'check = Lens.field @"check"
checkHandler = Lens.field @"checkHandler"
maybe'checkHandler = Lens.field @"checkHandler"
vec'checkHandler = Lens.field @"checkHandler"
service = Lens.field @"service"
maybe'service = Lens.field @"service"
vec'service = Lens.field @"service"
status = Lens.field @"status"
maybe'status = Lens.field @"status"
vec'status = Lens.field @"status"
watch = Lens.field @"watch"
maybe'watch = Lens.field @"watch"
vec'watch = Lens.field @"watch"
watchHandler = Lens.field @"watchHandler"
maybe'watchHandler = Lens.field @"watchHandler"
vec'watchHandler = Lens.field @"watchHandler"

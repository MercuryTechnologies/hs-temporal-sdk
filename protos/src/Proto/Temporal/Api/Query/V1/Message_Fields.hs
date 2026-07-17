{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Query.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

answer = Lens.field @"answer"
maybe'answer = Lens.field @"answer"
vec'answer = Lens.field @"answer"
errorMessage = Lens.field @"errorMessage"
maybe'errorMessage = Lens.field @"errorMessage"
vec'errorMessage = Lens.field @"errorMessage"
failure = Lens.field @"failure"
maybe'failure = Lens.field @"failure"
vec'failure = Lens.field @"failure"
header = Lens.field @"header"
maybe'header = Lens.field @"header"
vec'header = Lens.field @"header"
queryArgs = Lens.field @"queryArgs"
maybe'queryArgs = Lens.field @"queryArgs"
vec'queryArgs = Lens.field @"queryArgs"
queryType = Lens.field @"queryType"
maybe'queryType = Lens.field @"queryType"
vec'queryType = Lens.field @"queryType"
resultType = Lens.field @"resultType"
maybe'resultType = Lens.field @"resultType"
vec'resultType = Lens.field @"resultType"
status = Lens.field @"status"
maybe'status = Lens.field @"status"
vec'status = Lens.field @"status"

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DisambiguateRecordFields #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists -Wno-name-shadowing #-}

module Proto.Temporal.Api.Update.V1.Message_Fields where

import Proto.Compat.HasField ()
import Proto.Lens qualified as Lens

acceptedRequest = Lens.field @"acceptedRequest"
maybe'acceptedRequest = Lens.field @"acceptedRequest"
vec'acceptedRequest = Lens.field @"acceptedRequest"
acceptedRequestMessageId = Lens.field @"acceptedRequestMessageId"
maybe'acceptedRequestMessageId = Lens.field @"acceptedRequestMessageId"
vec'acceptedRequestMessageId = Lens.field @"acceptedRequestMessageId"
acceptedRequestSequencingEventId = Lens.field @"acceptedRequestSequencingEventId"
maybe'acceptedRequestSequencingEventId = Lens.field @"acceptedRequestSequencingEventId"
vec'acceptedRequestSequencingEventId = Lens.field @"acceptedRequestSequencingEventId"
args = Lens.field @"args"
maybe'args = Lens.field @"args"
vec'args = Lens.field @"args"
failure = Lens.field @"failure"
maybe'failure = Lens.field @"failure"
vec'failure = Lens.field @"failure"
header = Lens.field @"header"
maybe'header = Lens.field @"header"
vec'header = Lens.field @"header"
identity = Lens.field @"identity"
maybe'identity = Lens.field @"identity"
vec'identity = Lens.field @"identity"
input = Lens.field @"input"
maybe'input = Lens.field @"input"
vec'input = Lens.field @"input"
lifecycleStage = Lens.field @"lifecycleStage"
maybe'lifecycleStage = Lens.field @"lifecycleStage"
vec'lifecycleStage = Lens.field @"lifecycleStage"
meta = Lens.field @"meta"
maybe'meta = Lens.field @"meta"
vec'meta = Lens.field @"meta"
name = Lens.field @"name"
maybe'name = Lens.field @"name"
vec'name = Lens.field @"name"
outcome = Lens.field @"outcome"
maybe'outcome = Lens.field @"outcome"
vec'outcome = Lens.field @"outcome"
rejectedRequest = Lens.field @"rejectedRequest"
maybe'rejectedRequest = Lens.field @"rejectedRequest"
vec'rejectedRequest = Lens.field @"rejectedRequest"
rejectedRequestMessageId = Lens.field @"rejectedRequestMessageId"
maybe'rejectedRequestMessageId = Lens.field @"rejectedRequestMessageId"
vec'rejectedRequestMessageId = Lens.field @"rejectedRequestMessageId"
rejectedRequestSequencingEventId = Lens.field @"rejectedRequestSequencingEventId"
maybe'rejectedRequestSequencingEventId = Lens.field @"rejectedRequestSequencingEventId"
vec'rejectedRequestSequencingEventId = Lens.field @"rejectedRequestSequencingEventId"
updateId = Lens.field @"updateId"
maybe'updateId = Lens.field @"updateId"
vec'updateId = Lens.field @"updateId"
value = Lens.field @"value"
maybe'value = Lens.field @"value"
vec'value = Lens.field @"value"
workflowExecution = Lens.field @"workflowExecution"
maybe'workflowExecution = Lens.field @"workflowExecution"
vec'workflowExecution = Lens.field @"workflowExecution"

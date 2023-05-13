{- This file was auto-generated from temporal/api/failure/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Failure.V1.Message_Fields where
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Workflow
activityFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
activityFailureInfo
  = Data.ProtoLens.Field.field @"activityFailureInfo"
activityId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityId" a) =>
  Lens.Family2.LensLike' f s a
activityId = Data.ProtoLens.Field.field @"activityId"
activityType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "activityType" a) =>
  Lens.Family2.LensLike' f s a
activityType = Data.ProtoLens.Field.field @"activityType"
applicationFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "applicationFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
applicationFailureInfo
  = Data.ProtoLens.Field.field @"applicationFailureInfo"
canceledFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "canceledFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
canceledFailureInfo
  = Data.ProtoLens.Field.field @"canceledFailureInfo"
cause ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "cause" a) =>
  Lens.Family2.LensLike' f s a
cause = Data.ProtoLens.Field.field @"cause"
childWorkflowExecutionFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "childWorkflowExecutionFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
childWorkflowExecutionFailureInfo
  = Data.ProtoLens.Field.field @"childWorkflowExecutionFailureInfo"
details ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "details" a) =>
  Lens.Family2.LensLike' f s a
details = Data.ProtoLens.Field.field @"details"
encodedAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "encodedAttributes" a) =>
  Lens.Family2.LensLike' f s a
encodedAttributes = Data.ProtoLens.Field.field @"encodedAttributes"
identity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "identity" a) =>
  Lens.Family2.LensLike' f s a
identity = Data.ProtoLens.Field.field @"identity"
initiatedEventId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "initiatedEventId" a) =>
  Lens.Family2.LensLike' f s a
initiatedEventId = Data.ProtoLens.Field.field @"initiatedEventId"
lastHeartbeatDetails ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastHeartbeatDetails" a) =>
  Lens.Family2.LensLike' f s a
lastHeartbeatDetails
  = Data.ProtoLens.Field.field @"lastHeartbeatDetails"
maybe'activityFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'activityFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'activityFailureInfo
  = Data.ProtoLens.Field.field @"maybe'activityFailureInfo"
maybe'activityType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'activityType" a) =>
  Lens.Family2.LensLike' f s a
maybe'activityType
  = Data.ProtoLens.Field.field @"maybe'activityType"
maybe'applicationFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'applicationFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'applicationFailureInfo
  = Data.ProtoLens.Field.field @"maybe'applicationFailureInfo"
maybe'canceledFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'canceledFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'canceledFailureInfo
  = Data.ProtoLens.Field.field @"maybe'canceledFailureInfo"
maybe'cause ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'cause" a) =>
  Lens.Family2.LensLike' f s a
maybe'cause = Data.ProtoLens.Field.field @"maybe'cause"
maybe'childWorkflowExecutionFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'childWorkflowExecutionFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'childWorkflowExecutionFailureInfo
  = Data.ProtoLens.Field.field
      @"maybe'childWorkflowExecutionFailureInfo"
maybe'details ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'details" a) =>
  Lens.Family2.LensLike' f s a
maybe'details = Data.ProtoLens.Field.field @"maybe'details"
maybe'encodedAttributes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'encodedAttributes" a) =>
  Lens.Family2.LensLike' f s a
maybe'encodedAttributes
  = Data.ProtoLens.Field.field @"maybe'encodedAttributes"
maybe'failureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'failureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'failureInfo = Data.ProtoLens.Field.field @"maybe'failureInfo"
maybe'lastHeartbeatDetails ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastHeartbeatDetails" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastHeartbeatDetails
  = Data.ProtoLens.Field.field @"maybe'lastHeartbeatDetails"
maybe'resetWorkflowFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'resetWorkflowFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'resetWorkflowFailureInfo
  = Data.ProtoLens.Field.field @"maybe'resetWorkflowFailureInfo"
maybe'serverFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'serverFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'serverFailureInfo
  = Data.ProtoLens.Field.field @"maybe'serverFailureInfo"
maybe'terminatedFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'terminatedFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'terminatedFailureInfo
  = Data.ProtoLens.Field.field @"maybe'terminatedFailureInfo"
maybe'timeoutFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'timeoutFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'timeoutFailureInfo
  = Data.ProtoLens.Field.field @"maybe'timeoutFailureInfo"
maybe'workflowExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowExecution" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowExecution
  = Data.ProtoLens.Field.field @"maybe'workflowExecution"
maybe'workflowType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'workflowType" a) =>
  Lens.Family2.LensLike' f s a
maybe'workflowType
  = Data.ProtoLens.Field.field @"maybe'workflowType"
message ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "message" a) =>
  Lens.Family2.LensLike' f s a
message = Data.ProtoLens.Field.field @"message"
namespace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "namespace" a) =>
  Lens.Family2.LensLike' f s a
namespace = Data.ProtoLens.Field.field @"namespace"
nonRetryable ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "nonRetryable" a) =>
  Lens.Family2.LensLike' f s a
nonRetryable = Data.ProtoLens.Field.field @"nonRetryable"
resetWorkflowFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "resetWorkflowFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
resetWorkflowFailureInfo
  = Data.ProtoLens.Field.field @"resetWorkflowFailureInfo"
retryState ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "retryState" a) =>
  Lens.Family2.LensLike' f s a
retryState = Data.ProtoLens.Field.field @"retryState"
scheduledEventId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "scheduledEventId" a) =>
  Lens.Family2.LensLike' f s a
scheduledEventId = Data.ProtoLens.Field.field @"scheduledEventId"
serverFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "serverFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
serverFailureInfo = Data.ProtoLens.Field.field @"serverFailureInfo"
source ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "source" a) =>
  Lens.Family2.LensLike' f s a
source = Data.ProtoLens.Field.field @"source"
stackTrace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "stackTrace" a) =>
  Lens.Family2.LensLike' f s a
stackTrace = Data.ProtoLens.Field.field @"stackTrace"
startedEventId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startedEventId" a) =>
  Lens.Family2.LensLike' f s a
startedEventId = Data.ProtoLens.Field.field @"startedEventId"
terminatedFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "terminatedFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
terminatedFailureInfo
  = Data.ProtoLens.Field.field @"terminatedFailureInfo"
timeoutFailureInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "timeoutFailureInfo" a) =>
  Lens.Family2.LensLike' f s a
timeoutFailureInfo
  = Data.ProtoLens.Field.field @"timeoutFailureInfo"
timeoutType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "timeoutType" a) =>
  Lens.Family2.LensLike' f s a
timeoutType = Data.ProtoLens.Field.field @"timeoutType"
type' ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "type'" a) =>
  Lens.Family2.LensLike' f s a
type' = Data.ProtoLens.Field.field @"type'"
workflowExecution ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowExecution" a) =>
  Lens.Family2.LensLike' f s a
workflowExecution = Data.ProtoLens.Field.field @"workflowExecution"
workflowType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowType" a) =>
  Lens.Family2.LensLike' f s a
workflowType = Data.ProtoLens.Field.field @"workflowType"
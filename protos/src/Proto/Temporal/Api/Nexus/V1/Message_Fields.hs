{- This file was auto-generated from temporal/api/nexus/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Nexus.V1.Message_Fields where
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message
asyncSuccess ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "asyncSuccess" a) =>
  Lens.Family2.LensLike' f s a
asyncSuccess = Data.ProtoLens.Field.field @"asyncSuccess"
callback ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "callback" a) =>
  Lens.Family2.LensLike' f s a
callback = Data.ProtoLens.Field.field @"callback"
callbackHeader ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "callbackHeader" a) =>
  Lens.Family2.LensLike' f s a
callbackHeader = Data.ProtoLens.Field.field @"callbackHeader"
cancelOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "cancelOperation" a) =>
  Lens.Family2.LensLike' f s a
cancelOperation = Data.ProtoLens.Field.field @"cancelOperation"
createdTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "createdTime" a) =>
  Lens.Family2.LensLike' f s a
createdTime = Data.ProtoLens.Field.field @"createdTime"
description ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "description" a) =>
  Lens.Family2.LensLike' f s a
description = Data.ProtoLens.Field.field @"description"
details ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "details" a) =>
  Lens.Family2.LensLike' f s a
details = Data.ProtoLens.Field.field @"details"
errorType ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "errorType" a) =>
  Lens.Family2.LensLike' f s a
errorType = Data.ProtoLens.Field.field @"errorType"
external ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "external" a) =>
  Lens.Family2.LensLike' f s a
external = Data.ProtoLens.Field.field @"external"
failure ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "failure" a) =>
  Lens.Family2.LensLike' f s a
failure = Data.ProtoLens.Field.field @"failure"
header ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "header" a) =>
  Lens.Family2.LensLike' f s a
header = Data.ProtoLens.Field.field @"header"
id ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "id" a) =>
  Lens.Family2.LensLike' f s a
id = Data.ProtoLens.Field.field @"id"
key ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "key" a) =>
  Lens.Family2.LensLike' f s a
key = Data.ProtoLens.Field.field @"key"
lastModifiedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastModifiedTime" a) =>
  Lens.Family2.LensLike' f s a
lastModifiedTime = Data.ProtoLens.Field.field @"lastModifiedTime"
maybe'asyncSuccess ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'asyncSuccess" a) =>
  Lens.Family2.LensLike' f s a
maybe'asyncSuccess
  = Data.ProtoLens.Field.field @"maybe'asyncSuccess"
maybe'cancelOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'cancelOperation" a) =>
  Lens.Family2.LensLike' f s a
maybe'cancelOperation
  = Data.ProtoLens.Field.field @"maybe'cancelOperation"
maybe'createdTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'createdTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'createdTime = Data.ProtoLens.Field.field @"maybe'createdTime"
maybe'description ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'description" a) =>
  Lens.Family2.LensLike' f s a
maybe'description = Data.ProtoLens.Field.field @"maybe'description"
maybe'external ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'external" a) =>
  Lens.Family2.LensLike' f s a
maybe'external = Data.ProtoLens.Field.field @"maybe'external"
maybe'failure ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'failure" a) =>
  Lens.Family2.LensLike' f s a
maybe'failure = Data.ProtoLens.Field.field @"maybe'failure"
maybe'lastModifiedTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastModifiedTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastModifiedTime
  = Data.ProtoLens.Field.field @"maybe'lastModifiedTime"
maybe'operationError ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'operationError" a) =>
  Lens.Family2.LensLike' f s a
maybe'operationError
  = Data.ProtoLens.Field.field @"maybe'operationError"
maybe'payload ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'payload" a) =>
  Lens.Family2.LensLike' f s a
maybe'payload = Data.ProtoLens.Field.field @"maybe'payload"
maybe'scheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'scheduledTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'scheduledTime
  = Data.ProtoLens.Field.field @"maybe'scheduledTime"
maybe'spec ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'spec" a) =>
  Lens.Family2.LensLike' f s a
maybe'spec = Data.ProtoLens.Field.field @"maybe'spec"
maybe'startOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'startOperation" a) =>
  Lens.Family2.LensLike' f s a
maybe'startOperation
  = Data.ProtoLens.Field.field @"maybe'startOperation"
maybe'syncSuccess ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'syncSuccess" a) =>
  Lens.Family2.LensLike' f s a
maybe'syncSuccess = Data.ProtoLens.Field.field @"maybe'syncSuccess"
maybe'target ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'target" a) =>
  Lens.Family2.LensLike' f s a
maybe'target = Data.ProtoLens.Field.field @"maybe'target"
maybe'variant ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'variant" a) =>
  Lens.Family2.LensLike' f s a
maybe'variant = Data.ProtoLens.Field.field @"maybe'variant"
maybe'worker ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'worker" a) =>
  Lens.Family2.LensLike' f s a
maybe'worker = Data.ProtoLens.Field.field @"maybe'worker"
message ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "message" a) =>
  Lens.Family2.LensLike' f s a
message = Data.ProtoLens.Field.field @"message"
metadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "metadata" a) =>
  Lens.Family2.LensLike' f s a
metadata = Data.ProtoLens.Field.field @"metadata"
name ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "name" a) =>
  Lens.Family2.LensLike' f s a
name = Data.ProtoLens.Field.field @"name"
namespace ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "namespace" a) =>
  Lens.Family2.LensLike' f s a
namespace = Data.ProtoLens.Field.field @"namespace"
operation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operation" a) =>
  Lens.Family2.LensLike' f s a
operation = Data.ProtoLens.Field.field @"operation"
operationError ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operationError" a) =>
  Lens.Family2.LensLike' f s a
operationError = Data.ProtoLens.Field.field @"operationError"
operationId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operationId" a) =>
  Lens.Family2.LensLike' f s a
operationId = Data.ProtoLens.Field.field @"operationId"
operationState ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "operationState" a) =>
  Lens.Family2.LensLike' f s a
operationState = Data.ProtoLens.Field.field @"operationState"
payload ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "payload" a) =>
  Lens.Family2.LensLike' f s a
payload = Data.ProtoLens.Field.field @"payload"
requestId ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "requestId" a) =>
  Lens.Family2.LensLike' f s a
requestId = Data.ProtoLens.Field.field @"requestId"
scheduledTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "scheduledTime" a) =>
  Lens.Family2.LensLike' f s a
scheduledTime = Data.ProtoLens.Field.field @"scheduledTime"
service ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "service" a) =>
  Lens.Family2.LensLike' f s a
service = Data.ProtoLens.Field.field @"service"
spec ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "spec" a) =>
  Lens.Family2.LensLike' f s a
spec = Data.ProtoLens.Field.field @"spec"
startOperation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "startOperation" a) =>
  Lens.Family2.LensLike' f s a
startOperation = Data.ProtoLens.Field.field @"startOperation"
syncSuccess ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "syncSuccess" a) =>
  Lens.Family2.LensLike' f s a
syncSuccess = Data.ProtoLens.Field.field @"syncSuccess"
target ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "target" a) =>
  Lens.Family2.LensLike' f s a
target = Data.ProtoLens.Field.field @"target"
taskQueue ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "taskQueue" a) =>
  Lens.Family2.LensLike' f s a
taskQueue = Data.ProtoLens.Field.field @"taskQueue"
url ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "url" a) =>
  Lens.Family2.LensLike' f s a
url = Data.ProtoLens.Field.field @"url"
urlPrefix ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "urlPrefix" a) =>
  Lens.Family2.LensLike' f s a
urlPrefix = Data.ProtoLens.Field.field @"urlPrefix"
value ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "value" a) =>
  Lens.Family2.LensLike' f s a
value = Data.ProtoLens.Field.field @"value"
version ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "version" a) =>
  Lens.Family2.LensLike' f s a
version = Data.ProtoLens.Field.field @"version"
worker ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "worker" a) =>
  Lens.Family2.LensLike' f s a
worker = Data.ProtoLens.Field.field @"worker"

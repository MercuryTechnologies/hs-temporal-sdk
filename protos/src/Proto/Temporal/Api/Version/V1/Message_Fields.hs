{- This file was auto-generated from temporal/api/version/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Version.V1.Message_Fields where
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
import qualified Proto.Dependencies.Gogoproto.Gogo
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Enums.V1.Common
alerts ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "alerts" a) =>
  Lens.Family2.LensLike' f s a
alerts = Data.ProtoLens.Field.field @"alerts"
current ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "current" a) =>
  Lens.Family2.LensLike' f s a
current = Data.ProtoLens.Field.field @"current"
instructions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "instructions" a) =>
  Lens.Family2.LensLike' f s a
instructions = Data.ProtoLens.Field.field @"instructions"
lastUpdateTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lastUpdateTime" a) =>
  Lens.Family2.LensLike' f s a
lastUpdateTime = Data.ProtoLens.Field.field @"lastUpdateTime"
maybe'current ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'current" a) =>
  Lens.Family2.LensLike' f s a
maybe'current = Data.ProtoLens.Field.field @"maybe'current"
maybe'lastUpdateTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'lastUpdateTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'lastUpdateTime
  = Data.ProtoLens.Field.field @"maybe'lastUpdateTime"
maybe'recommended ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'recommended" a) =>
  Lens.Family2.LensLike' f s a
maybe'recommended = Data.ProtoLens.Field.field @"maybe'recommended"
maybe'releaseTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'releaseTime" a) =>
  Lens.Family2.LensLike' f s a
maybe'releaseTime = Data.ProtoLens.Field.field @"maybe'releaseTime"
message ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "message" a) =>
  Lens.Family2.LensLike' f s a
message = Data.ProtoLens.Field.field @"message"
notes ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "notes" a) =>
  Lens.Family2.LensLike' f s a
notes = Data.ProtoLens.Field.field @"notes"
recommended ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "recommended" a) =>
  Lens.Family2.LensLike' f s a
recommended = Data.ProtoLens.Field.field @"recommended"
releaseTime ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "releaseTime" a) =>
  Lens.Family2.LensLike' f s a
releaseTime = Data.ProtoLens.Field.field @"releaseTime"
severity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "severity" a) =>
  Lens.Family2.LensLike' f s a
severity = Data.ProtoLens.Field.field @"severity"
vec'alerts ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'alerts" a) =>
  Lens.Family2.LensLike' f s a
vec'alerts = Data.ProtoLens.Field.field @"vec'alerts"
version ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "version" a) =>
  Lens.Family2.LensLike' f s a
version = Data.ProtoLens.Field.field @"version"
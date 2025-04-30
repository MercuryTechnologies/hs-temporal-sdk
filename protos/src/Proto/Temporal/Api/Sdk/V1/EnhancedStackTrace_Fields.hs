{- This file was auto-generated from temporal/api/sdk/v1/enhanced_stack_trace.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields where
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
column ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "column" a) =>
  Lens.Family2.LensLike' f s a
column = Data.ProtoLens.Field.field @"column"
content ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "content" a) =>
  Lens.Family2.LensLike' f s a
content = Data.ProtoLens.Field.field @"content"
filePath ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "filePath" a) =>
  Lens.Family2.LensLike' f s a
filePath = Data.ProtoLens.Field.field @"filePath"
functionName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "functionName" a) =>
  Lens.Family2.LensLike' f s a
functionName = Data.ProtoLens.Field.field @"functionName"
internalCode ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "internalCode" a) =>
  Lens.Family2.LensLike' f s a
internalCode = Data.ProtoLens.Field.field @"internalCode"
key ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "key" a) =>
  Lens.Family2.LensLike' f s a
key = Data.ProtoLens.Field.field @"key"
line ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "line" a) =>
  Lens.Family2.LensLike' f s a
line = Data.ProtoLens.Field.field @"line"
lineOffset ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "lineOffset" a) =>
  Lens.Family2.LensLike' f s a
lineOffset = Data.ProtoLens.Field.field @"lineOffset"
locations ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "locations" a) =>
  Lens.Family2.LensLike' f s a
locations = Data.ProtoLens.Field.field @"locations"
maybe'sdk ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'sdk" a) =>
  Lens.Family2.LensLike' f s a
maybe'sdk = Data.ProtoLens.Field.field @"maybe'sdk"
maybe'value ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'value" a) =>
  Lens.Family2.LensLike' f s a
maybe'value = Data.ProtoLens.Field.field @"maybe'value"
name ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "name" a) =>
  Lens.Family2.LensLike' f s a
name = Data.ProtoLens.Field.field @"name"
sdk ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "sdk" a) =>
  Lens.Family2.LensLike' f s a
sdk = Data.ProtoLens.Field.field @"sdk"
sources ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "sources" a) =>
  Lens.Family2.LensLike' f s a
sources = Data.ProtoLens.Field.field @"sources"
stacks ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "stacks" a) =>
  Lens.Family2.LensLike' f s a
stacks = Data.ProtoLens.Field.field @"stacks"
value ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "value" a) =>
  Lens.Family2.LensLike' f s a
value = Data.ProtoLens.Field.field @"value"
vec'locations ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'locations" a) =>
  Lens.Family2.LensLike' f s a
vec'locations = Data.ProtoLens.Field.field @"vec'locations"
vec'stacks ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'stacks" a) =>
  Lens.Family2.LensLike' f s a
vec'stacks = Data.ProtoLens.Field.field @"vec'stacks"
version ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "version" a) =>
  Lens.Family2.LensLike' f s a
version = Data.ProtoLens.Field.field @"version"
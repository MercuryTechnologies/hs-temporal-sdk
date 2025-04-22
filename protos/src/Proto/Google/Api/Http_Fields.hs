{- This file was auto-generated from google/api/http.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Google.Api.Http_Fields where
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
additionalBindings ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "additionalBindings" a) =>
  Lens.Family2.LensLike' f s a
additionalBindings
  = Data.ProtoLens.Field.field @"additionalBindings"
body ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "body" a) =>
  Lens.Family2.LensLike' f s a
body = Data.ProtoLens.Field.field @"body"
custom ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "custom" a) =>
  Lens.Family2.LensLike' f s a
custom = Data.ProtoLens.Field.field @"custom"
delete ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "delete" a) =>
  Lens.Family2.LensLike' f s a
delete = Data.ProtoLens.Field.field @"delete"
fullyDecodeReservedExpansion ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "fullyDecodeReservedExpansion" a) =>
  Lens.Family2.LensLike' f s a
fullyDecodeReservedExpansion
  = Data.ProtoLens.Field.field @"fullyDecodeReservedExpansion"
get ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "get" a) =>
  Lens.Family2.LensLike' f s a
get = Data.ProtoLens.Field.field @"get"
kind ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "kind" a) =>
  Lens.Family2.LensLike' f s a
kind = Data.ProtoLens.Field.field @"kind"
maybe'custom ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'custom" a) =>
  Lens.Family2.LensLike' f s a
maybe'custom = Data.ProtoLens.Field.field @"maybe'custom"
maybe'delete ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'delete" a) =>
  Lens.Family2.LensLike' f s a
maybe'delete = Data.ProtoLens.Field.field @"maybe'delete"
maybe'get ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'get" a) =>
  Lens.Family2.LensLike' f s a
maybe'get = Data.ProtoLens.Field.field @"maybe'get"
maybe'patch ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'patch" a) =>
  Lens.Family2.LensLike' f s a
maybe'patch = Data.ProtoLens.Field.field @"maybe'patch"
maybe'pattern' ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'pattern'" a) =>
  Lens.Family2.LensLike' f s a
maybe'pattern' = Data.ProtoLens.Field.field @"maybe'pattern'"
maybe'post ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'post" a) =>
  Lens.Family2.LensLike' f s a
maybe'post = Data.ProtoLens.Field.field @"maybe'post"
maybe'put ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'put" a) =>
  Lens.Family2.LensLike' f s a
maybe'put = Data.ProtoLens.Field.field @"maybe'put"
patch ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "patch" a) =>
  Lens.Family2.LensLike' f s a
patch = Data.ProtoLens.Field.field @"patch"
path ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "path" a) =>
  Lens.Family2.LensLike' f s a
path = Data.ProtoLens.Field.field @"path"
post ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "post" a) =>
  Lens.Family2.LensLike' f s a
post = Data.ProtoLens.Field.field @"post"
put ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "put" a) =>
  Lens.Family2.LensLike' f s a
put = Data.ProtoLens.Field.field @"put"
responseBody ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "responseBody" a) =>
  Lens.Family2.LensLike' f s a
responseBody = Data.ProtoLens.Field.field @"responseBody"
rules ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "rules" a) =>
  Lens.Family2.LensLike' f s a
rules = Data.ProtoLens.Field.field @"rules"
selector ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "selector" a) =>
  Lens.Family2.LensLike' f s a
selector = Data.ProtoLens.Field.field @"selector"
vec'additionalBindings ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'additionalBindings" a) =>
  Lens.Family2.LensLike' f s a
vec'additionalBindings
  = Data.ProtoLens.Field.field @"vec'additionalBindings"
vec'rules ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'rules" a) =>
  Lens.Family2.LensLike' f s a
vec'rules = Data.ProtoLens.Field.field @"vec'rules"
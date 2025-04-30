{- This file was auto-generated from temporal/api/sdk/v1/workflow_metadata.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields where
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
currentDetails ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "currentDetails" a) =>
  Lens.Family2.LensLike' f s a
currentDetails = Data.ProtoLens.Field.field @"currentDetails"
definition ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "definition" a) =>
  Lens.Family2.LensLike' f s a
definition = Data.ProtoLens.Field.field @"definition"
description ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "description" a) =>
  Lens.Family2.LensLike' f s a
description = Data.ProtoLens.Field.field @"description"
maybe'definition ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'definition" a) =>
  Lens.Family2.LensLike' f s a
maybe'definition = Data.ProtoLens.Field.field @"maybe'definition"
name ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "name" a) =>
  Lens.Family2.LensLike' f s a
name = Data.ProtoLens.Field.field @"name"
queryDefinitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "queryDefinitions" a) =>
  Lens.Family2.LensLike' f s a
queryDefinitions = Data.ProtoLens.Field.field @"queryDefinitions"
signalDefinitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signalDefinitions" a) =>
  Lens.Family2.LensLike' f s a
signalDefinitions = Data.ProtoLens.Field.field @"signalDefinitions"
type' ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "type'" a) =>
  Lens.Family2.LensLike' f s a
type' = Data.ProtoLens.Field.field @"type'"
updateDefinitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "updateDefinitions" a) =>
  Lens.Family2.LensLike' f s a
updateDefinitions = Data.ProtoLens.Field.field @"updateDefinitions"
vec'queryDefinitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'queryDefinitions" a) =>
  Lens.Family2.LensLike' f s a
vec'queryDefinitions
  = Data.ProtoLens.Field.field @"vec'queryDefinitions"
vec'signalDefinitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'signalDefinitions" a) =>
  Lens.Family2.LensLike' f s a
vec'signalDefinitions
  = Data.ProtoLens.Field.field @"vec'signalDefinitions"
vec'updateDefinitions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'updateDefinitions" a) =>
  Lens.Family2.LensLike' f s a
vec'updateDefinitions
  = Data.ProtoLens.Field.field @"vec'updateDefinitions"
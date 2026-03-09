{- This file was auto-generated from temporal/api/sdk/v1/worker_config.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields where
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
autoscalingPollerBehavior ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "autoscalingPollerBehavior" a) =>
  Lens.Family2.LensLike' f s a
autoscalingPollerBehavior
  = Data.ProtoLens.Field.field @"autoscalingPollerBehavior"
initialPollers ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "initialPollers" a) =>
  Lens.Family2.LensLike' f s a
initialPollers = Data.ProtoLens.Field.field @"initialPollers"
maxPollers ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maxPollers" a) =>
  Lens.Family2.LensLike' f s a
maxPollers = Data.ProtoLens.Field.field @"maxPollers"
maybe'autoscalingPollerBehavior ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'autoscalingPollerBehavior" a) =>
  Lens.Family2.LensLike' f s a
maybe'autoscalingPollerBehavior
  = Data.ProtoLens.Field.field @"maybe'autoscalingPollerBehavior"
maybe'pollerBehavior ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'pollerBehavior" a) =>
  Lens.Family2.LensLike' f s a
maybe'pollerBehavior
  = Data.ProtoLens.Field.field @"maybe'pollerBehavior"
maybe'simplePollerBehavior ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'simplePollerBehavior" a) =>
  Lens.Family2.LensLike' f s a
maybe'simplePollerBehavior
  = Data.ProtoLens.Field.field @"maybe'simplePollerBehavior"
minPollers ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "minPollers" a) =>
  Lens.Family2.LensLike' f s a
minPollers = Data.ProtoLens.Field.field @"minPollers"
simplePollerBehavior ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "simplePollerBehavior" a) =>
  Lens.Family2.LensLike' f s a
simplePollerBehavior
  = Data.ProtoLens.Field.field @"simplePollerBehavior"
workflowCacheSize ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "workflowCacheSize" a) =>
  Lens.Family2.LensLike' f s a
workflowCacheSize = Data.ProtoLens.Field.field @"workflowCacheSize"
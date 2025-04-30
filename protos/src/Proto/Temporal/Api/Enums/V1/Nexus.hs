{- This file was auto-generated from temporal/api/enums/v1/nexus.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.Nexus (
        NexusHandlerErrorRetryBehavior(..),
        NexusHandlerErrorRetryBehavior(),
        NexusHandlerErrorRetryBehavior'UnrecognizedValue
    ) where
import qualified Data.ProtoLens.Runtime.Control.DeepSeq as Control.DeepSeq
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Prism as Data.ProtoLens.Prism
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
newtype NexusHandlerErrorRetryBehavior'UnrecognizedValue
  = NexusHandlerErrorRetryBehavior'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data NexusHandlerErrorRetryBehavior
  = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED |
    NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE |
    NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE |
    NexusHandlerErrorRetryBehavior'Unrecognized !NexusHandlerErrorRetryBehavior'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum NexusHandlerErrorRetryBehavior where
  maybeToEnum 0
    = Prelude.Just NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
  maybeToEnum 2
    = Prelude.Just NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
  maybeToEnum k
    = Prelude.Just
        (NexusHandlerErrorRetryBehavior'Unrecognized
           (NexusHandlerErrorRetryBehavior'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
    = "NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED"
  showEnum NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
    = "NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE"
  showEnum NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
    = "NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE"
  showEnum
    (NexusHandlerErrorRetryBehavior'Unrecognized (NexusHandlerErrorRetryBehavior'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED"
    = Prelude.Just NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
    | (Prelude.==) k "NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE"
    = Prelude.Just NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
    | (Prelude.==) k "NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE"
    = Prelude.Just NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded NexusHandlerErrorRetryBehavior where
  minBound = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
  maxBound = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
instance Prelude.Enum NexusHandlerErrorRetryBehavior where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum NexusHandlerErrorRetryBehavior: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED = 0
  fromEnum NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE = 1
  fromEnum NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE = 2
  fromEnum
    (NexusHandlerErrorRetryBehavior'Unrecognized (NexusHandlerErrorRetryBehavior'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
    = Prelude.error
        "NexusHandlerErrorRetryBehavior.succ: bad argument NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE. This value would be out of bounds."
  succ NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
    = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
  succ NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
    = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
  succ (NexusHandlerErrorRetryBehavior'Unrecognized _)
    = Prelude.error
        "NexusHandlerErrorRetryBehavior.succ: bad argument: unrecognized value"
  pred NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
    = Prelude.error
        "NexusHandlerErrorRetryBehavior.pred: bad argument NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED. This value would be out of bounds."
  pred NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
    = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
  pred NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_NON_RETRYABLE
    = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_RETRYABLE
  pred (NexusHandlerErrorRetryBehavior'Unrecognized _)
    = Prelude.error
        "NexusHandlerErrorRetryBehavior.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault NexusHandlerErrorRetryBehavior where
  fieldDefault = NEXUS_HANDLER_ERROR_RETRY_BEHAVIOR_UNSPECIFIED
instance Control.DeepSeq.NFData NexusHandlerErrorRetryBehavior where
  rnf x__ = Prelude.seq x__ ()
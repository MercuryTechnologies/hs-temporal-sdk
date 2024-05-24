{- This file was auto-generated from temporal/api/enums/v1/common.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.Common (
        CallbackState(..), CallbackState(),
        CallbackState'UnrecognizedValue, EncodingType(..), EncodingType(),
        EncodingType'UnrecognizedValue, IndexedValueType(..),
        IndexedValueType(), IndexedValueType'UnrecognizedValue,
        NexusOperationCancellationState(..),
        NexusOperationCancellationState(),
        NexusOperationCancellationState'UnrecognizedValue,
        PendingNexusOperationState(..), PendingNexusOperationState(),
        PendingNexusOperationState'UnrecognizedValue, Severity(..),
        Severity(), Severity'UnrecognizedValue
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
newtype CallbackState'UnrecognizedValue
  = CallbackState'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data CallbackState
  = CALLBACK_STATE_UNSPECIFIED |
    CALLBACK_STATE_STANDBY |
    CALLBACK_STATE_SCHEDULED |
    CALLBACK_STATE_BACKING_OFF |
    CALLBACK_STATE_FAILED |
    CALLBACK_STATE_SUCCEEDED |
    CallbackState'Unrecognized !CallbackState'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum CallbackState where
  maybeToEnum 0 = Prelude.Just CALLBACK_STATE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just CALLBACK_STATE_STANDBY
  maybeToEnum 2 = Prelude.Just CALLBACK_STATE_SCHEDULED
  maybeToEnum 3 = Prelude.Just CALLBACK_STATE_BACKING_OFF
  maybeToEnum 4 = Prelude.Just CALLBACK_STATE_FAILED
  maybeToEnum 5 = Prelude.Just CALLBACK_STATE_SUCCEEDED
  maybeToEnum k
    = Prelude.Just
        (CallbackState'Unrecognized
           (CallbackState'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum CALLBACK_STATE_UNSPECIFIED = "CALLBACK_STATE_UNSPECIFIED"
  showEnum CALLBACK_STATE_STANDBY = "CALLBACK_STATE_STANDBY"
  showEnum CALLBACK_STATE_SCHEDULED = "CALLBACK_STATE_SCHEDULED"
  showEnum CALLBACK_STATE_BACKING_OFF = "CALLBACK_STATE_BACKING_OFF"
  showEnum CALLBACK_STATE_FAILED = "CALLBACK_STATE_FAILED"
  showEnum CALLBACK_STATE_SUCCEEDED = "CALLBACK_STATE_SUCCEEDED"
  showEnum
    (CallbackState'Unrecognized (CallbackState'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "CALLBACK_STATE_UNSPECIFIED"
    = Prelude.Just CALLBACK_STATE_UNSPECIFIED
    | (Prelude.==) k "CALLBACK_STATE_STANDBY"
    = Prelude.Just CALLBACK_STATE_STANDBY
    | (Prelude.==) k "CALLBACK_STATE_SCHEDULED"
    = Prelude.Just CALLBACK_STATE_SCHEDULED
    | (Prelude.==) k "CALLBACK_STATE_BACKING_OFF"
    = Prelude.Just CALLBACK_STATE_BACKING_OFF
    | (Prelude.==) k "CALLBACK_STATE_FAILED"
    = Prelude.Just CALLBACK_STATE_FAILED
    | (Prelude.==) k "CALLBACK_STATE_SUCCEEDED"
    = Prelude.Just CALLBACK_STATE_SUCCEEDED
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded CallbackState where
  minBound = CALLBACK_STATE_UNSPECIFIED
  maxBound = CALLBACK_STATE_SUCCEEDED
instance Prelude.Enum CallbackState where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum CallbackState: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum CALLBACK_STATE_UNSPECIFIED = 0
  fromEnum CALLBACK_STATE_STANDBY = 1
  fromEnum CALLBACK_STATE_SCHEDULED = 2
  fromEnum CALLBACK_STATE_BACKING_OFF = 3
  fromEnum CALLBACK_STATE_FAILED = 4
  fromEnum CALLBACK_STATE_SUCCEEDED = 5
  fromEnum
    (CallbackState'Unrecognized (CallbackState'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ CALLBACK_STATE_SUCCEEDED
    = Prelude.error
        "CallbackState.succ: bad argument CALLBACK_STATE_SUCCEEDED. This value would be out of bounds."
  succ CALLBACK_STATE_UNSPECIFIED = CALLBACK_STATE_STANDBY
  succ CALLBACK_STATE_STANDBY = CALLBACK_STATE_SCHEDULED
  succ CALLBACK_STATE_SCHEDULED = CALLBACK_STATE_BACKING_OFF
  succ CALLBACK_STATE_BACKING_OFF = CALLBACK_STATE_FAILED
  succ CALLBACK_STATE_FAILED = CALLBACK_STATE_SUCCEEDED
  succ (CallbackState'Unrecognized _)
    = Prelude.error
        "CallbackState.succ: bad argument: unrecognized value"
  pred CALLBACK_STATE_UNSPECIFIED
    = Prelude.error
        "CallbackState.pred: bad argument CALLBACK_STATE_UNSPECIFIED. This value would be out of bounds."
  pred CALLBACK_STATE_STANDBY = CALLBACK_STATE_UNSPECIFIED
  pred CALLBACK_STATE_SCHEDULED = CALLBACK_STATE_STANDBY
  pred CALLBACK_STATE_BACKING_OFF = CALLBACK_STATE_SCHEDULED
  pred CALLBACK_STATE_FAILED = CALLBACK_STATE_BACKING_OFF
  pred CALLBACK_STATE_SUCCEEDED = CALLBACK_STATE_FAILED
  pred (CallbackState'Unrecognized _)
    = Prelude.error
        "CallbackState.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault CallbackState where
  fieldDefault = CALLBACK_STATE_UNSPECIFIED
instance Control.DeepSeq.NFData CallbackState where
  rnf x__ = Prelude.seq x__ ()
newtype EncodingType'UnrecognizedValue
  = EncodingType'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data EncodingType
  = ENCODING_TYPE_UNSPECIFIED |
    ENCODING_TYPE_PROTO3 |
    ENCODING_TYPE_JSON |
    EncodingType'Unrecognized !EncodingType'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum EncodingType where
  maybeToEnum 0 = Prelude.Just ENCODING_TYPE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just ENCODING_TYPE_PROTO3
  maybeToEnum 2 = Prelude.Just ENCODING_TYPE_JSON
  maybeToEnum k
    = Prelude.Just
        (EncodingType'Unrecognized
           (EncodingType'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum ENCODING_TYPE_UNSPECIFIED = "ENCODING_TYPE_UNSPECIFIED"
  showEnum ENCODING_TYPE_PROTO3 = "ENCODING_TYPE_PROTO3"
  showEnum ENCODING_TYPE_JSON = "ENCODING_TYPE_JSON"
  showEnum
    (EncodingType'Unrecognized (EncodingType'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "ENCODING_TYPE_UNSPECIFIED"
    = Prelude.Just ENCODING_TYPE_UNSPECIFIED
    | (Prelude.==) k "ENCODING_TYPE_PROTO3"
    = Prelude.Just ENCODING_TYPE_PROTO3
    | (Prelude.==) k "ENCODING_TYPE_JSON"
    = Prelude.Just ENCODING_TYPE_JSON
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded EncodingType where
  minBound = ENCODING_TYPE_UNSPECIFIED
  maxBound = ENCODING_TYPE_JSON
instance Prelude.Enum EncodingType where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum EncodingType: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum ENCODING_TYPE_UNSPECIFIED = 0
  fromEnum ENCODING_TYPE_PROTO3 = 1
  fromEnum ENCODING_TYPE_JSON = 2
  fromEnum
    (EncodingType'Unrecognized (EncodingType'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ ENCODING_TYPE_JSON
    = Prelude.error
        "EncodingType.succ: bad argument ENCODING_TYPE_JSON. This value would be out of bounds."
  succ ENCODING_TYPE_UNSPECIFIED = ENCODING_TYPE_PROTO3
  succ ENCODING_TYPE_PROTO3 = ENCODING_TYPE_JSON
  succ (EncodingType'Unrecognized _)
    = Prelude.error
        "EncodingType.succ: bad argument: unrecognized value"
  pred ENCODING_TYPE_UNSPECIFIED
    = Prelude.error
        "EncodingType.pred: bad argument ENCODING_TYPE_UNSPECIFIED. This value would be out of bounds."
  pred ENCODING_TYPE_PROTO3 = ENCODING_TYPE_UNSPECIFIED
  pred ENCODING_TYPE_JSON = ENCODING_TYPE_PROTO3
  pred (EncodingType'Unrecognized _)
    = Prelude.error
        "EncodingType.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault EncodingType where
  fieldDefault = ENCODING_TYPE_UNSPECIFIED
instance Control.DeepSeq.NFData EncodingType where
  rnf x__ = Prelude.seq x__ ()
newtype IndexedValueType'UnrecognizedValue
  = IndexedValueType'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data IndexedValueType
  = INDEXED_VALUE_TYPE_UNSPECIFIED |
    INDEXED_VALUE_TYPE_TEXT |
    INDEXED_VALUE_TYPE_KEYWORD |
    INDEXED_VALUE_TYPE_INT |
    INDEXED_VALUE_TYPE_DOUBLE |
    INDEXED_VALUE_TYPE_BOOL |
    INDEXED_VALUE_TYPE_DATETIME |
    INDEXED_VALUE_TYPE_KEYWORD_LIST |
    IndexedValueType'Unrecognized !IndexedValueType'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum IndexedValueType where
  maybeToEnum 0 = Prelude.Just INDEXED_VALUE_TYPE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just INDEXED_VALUE_TYPE_TEXT
  maybeToEnum 2 = Prelude.Just INDEXED_VALUE_TYPE_KEYWORD
  maybeToEnum 3 = Prelude.Just INDEXED_VALUE_TYPE_INT
  maybeToEnum 4 = Prelude.Just INDEXED_VALUE_TYPE_DOUBLE
  maybeToEnum 5 = Prelude.Just INDEXED_VALUE_TYPE_BOOL
  maybeToEnum 6 = Prelude.Just INDEXED_VALUE_TYPE_DATETIME
  maybeToEnum 7 = Prelude.Just INDEXED_VALUE_TYPE_KEYWORD_LIST
  maybeToEnum k
    = Prelude.Just
        (IndexedValueType'Unrecognized
           (IndexedValueType'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum INDEXED_VALUE_TYPE_UNSPECIFIED
    = "INDEXED_VALUE_TYPE_UNSPECIFIED"
  showEnum INDEXED_VALUE_TYPE_TEXT = "INDEXED_VALUE_TYPE_TEXT"
  showEnum INDEXED_VALUE_TYPE_KEYWORD = "INDEXED_VALUE_TYPE_KEYWORD"
  showEnum INDEXED_VALUE_TYPE_INT = "INDEXED_VALUE_TYPE_INT"
  showEnum INDEXED_VALUE_TYPE_DOUBLE = "INDEXED_VALUE_TYPE_DOUBLE"
  showEnum INDEXED_VALUE_TYPE_BOOL = "INDEXED_VALUE_TYPE_BOOL"
  showEnum INDEXED_VALUE_TYPE_DATETIME
    = "INDEXED_VALUE_TYPE_DATETIME"
  showEnum INDEXED_VALUE_TYPE_KEYWORD_LIST
    = "INDEXED_VALUE_TYPE_KEYWORD_LIST"
  showEnum
    (IndexedValueType'Unrecognized (IndexedValueType'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "INDEXED_VALUE_TYPE_UNSPECIFIED"
    = Prelude.Just INDEXED_VALUE_TYPE_UNSPECIFIED
    | (Prelude.==) k "INDEXED_VALUE_TYPE_TEXT"
    = Prelude.Just INDEXED_VALUE_TYPE_TEXT
    | (Prelude.==) k "INDEXED_VALUE_TYPE_KEYWORD"
    = Prelude.Just INDEXED_VALUE_TYPE_KEYWORD
    | (Prelude.==) k "INDEXED_VALUE_TYPE_INT"
    = Prelude.Just INDEXED_VALUE_TYPE_INT
    | (Prelude.==) k "INDEXED_VALUE_TYPE_DOUBLE"
    = Prelude.Just INDEXED_VALUE_TYPE_DOUBLE
    | (Prelude.==) k "INDEXED_VALUE_TYPE_BOOL"
    = Prelude.Just INDEXED_VALUE_TYPE_BOOL
    | (Prelude.==) k "INDEXED_VALUE_TYPE_DATETIME"
    = Prelude.Just INDEXED_VALUE_TYPE_DATETIME
    | (Prelude.==) k "INDEXED_VALUE_TYPE_KEYWORD_LIST"
    = Prelude.Just INDEXED_VALUE_TYPE_KEYWORD_LIST
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded IndexedValueType where
  minBound = INDEXED_VALUE_TYPE_UNSPECIFIED
  maxBound = INDEXED_VALUE_TYPE_KEYWORD_LIST
instance Prelude.Enum IndexedValueType where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum IndexedValueType: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum INDEXED_VALUE_TYPE_UNSPECIFIED = 0
  fromEnum INDEXED_VALUE_TYPE_TEXT = 1
  fromEnum INDEXED_VALUE_TYPE_KEYWORD = 2
  fromEnum INDEXED_VALUE_TYPE_INT = 3
  fromEnum INDEXED_VALUE_TYPE_DOUBLE = 4
  fromEnum INDEXED_VALUE_TYPE_BOOL = 5
  fromEnum INDEXED_VALUE_TYPE_DATETIME = 6
  fromEnum INDEXED_VALUE_TYPE_KEYWORD_LIST = 7
  fromEnum
    (IndexedValueType'Unrecognized (IndexedValueType'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ INDEXED_VALUE_TYPE_KEYWORD_LIST
    = Prelude.error
        "IndexedValueType.succ: bad argument INDEXED_VALUE_TYPE_KEYWORD_LIST. This value would be out of bounds."
  succ INDEXED_VALUE_TYPE_UNSPECIFIED = INDEXED_VALUE_TYPE_TEXT
  succ INDEXED_VALUE_TYPE_TEXT = INDEXED_VALUE_TYPE_KEYWORD
  succ INDEXED_VALUE_TYPE_KEYWORD = INDEXED_VALUE_TYPE_INT
  succ INDEXED_VALUE_TYPE_INT = INDEXED_VALUE_TYPE_DOUBLE
  succ INDEXED_VALUE_TYPE_DOUBLE = INDEXED_VALUE_TYPE_BOOL
  succ INDEXED_VALUE_TYPE_BOOL = INDEXED_VALUE_TYPE_DATETIME
  succ INDEXED_VALUE_TYPE_DATETIME = INDEXED_VALUE_TYPE_KEYWORD_LIST
  succ (IndexedValueType'Unrecognized _)
    = Prelude.error
        "IndexedValueType.succ: bad argument: unrecognized value"
  pred INDEXED_VALUE_TYPE_UNSPECIFIED
    = Prelude.error
        "IndexedValueType.pred: bad argument INDEXED_VALUE_TYPE_UNSPECIFIED. This value would be out of bounds."
  pred INDEXED_VALUE_TYPE_TEXT = INDEXED_VALUE_TYPE_UNSPECIFIED
  pred INDEXED_VALUE_TYPE_KEYWORD = INDEXED_VALUE_TYPE_TEXT
  pred INDEXED_VALUE_TYPE_INT = INDEXED_VALUE_TYPE_KEYWORD
  pred INDEXED_VALUE_TYPE_DOUBLE = INDEXED_VALUE_TYPE_INT
  pred INDEXED_VALUE_TYPE_BOOL = INDEXED_VALUE_TYPE_DOUBLE
  pred INDEXED_VALUE_TYPE_DATETIME = INDEXED_VALUE_TYPE_BOOL
  pred INDEXED_VALUE_TYPE_KEYWORD_LIST = INDEXED_VALUE_TYPE_DATETIME
  pred (IndexedValueType'Unrecognized _)
    = Prelude.error
        "IndexedValueType.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault IndexedValueType where
  fieldDefault = INDEXED_VALUE_TYPE_UNSPECIFIED
instance Control.DeepSeq.NFData IndexedValueType where
  rnf x__ = Prelude.seq x__ ()
newtype NexusOperationCancellationState'UnrecognizedValue
  = NexusOperationCancellationState'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data NexusOperationCancellationState
  = NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED |
    NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED |
    NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF |
    NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED |
    NEXUS_OPERATION_CANCELLATION_STATE_FAILED |
    NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT |
    NexusOperationCancellationState'Unrecognized !NexusOperationCancellationState'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum NexusOperationCancellationState where
  maybeToEnum 0
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED
  maybeToEnum 2
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF
  maybeToEnum 3
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED
  maybeToEnum 4
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_FAILED
  maybeToEnum 5
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT
  maybeToEnum k
    = Prelude.Just
        (NexusOperationCancellationState'Unrecognized
           (NexusOperationCancellationState'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
    = "NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED"
  showEnum NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED
    = "NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED"
  showEnum NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF
    = "NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF"
  showEnum NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED
    = "NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED"
  showEnum NEXUS_OPERATION_CANCELLATION_STATE_FAILED
    = "NEXUS_OPERATION_CANCELLATION_STATE_FAILED"
  showEnum NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT
    = "NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT"
  showEnum
    (NexusOperationCancellationState'Unrecognized (NexusOperationCancellationState'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED"
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
    | (Prelude.==) k "NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED"
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED
    | (Prelude.==) k "NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF"
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF
    | (Prelude.==) k "NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED"
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED
    | (Prelude.==) k "NEXUS_OPERATION_CANCELLATION_STATE_FAILED"
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_FAILED
    | (Prelude.==) k "NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT"
    = Prelude.Just NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded NexusOperationCancellationState where
  minBound = NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
  maxBound = NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT
instance Prelude.Enum NexusOperationCancellationState where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum NexusOperationCancellationState: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED = 0
  fromEnum NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED = 1
  fromEnum NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF = 2
  fromEnum NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED = 3
  fromEnum NEXUS_OPERATION_CANCELLATION_STATE_FAILED = 4
  fromEnum NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT = 5
  fromEnum
    (NexusOperationCancellationState'Unrecognized (NexusOperationCancellationState'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT
    = Prelude.error
        "NexusOperationCancellationState.succ: bad argument NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT. This value would be out of bounds."
  succ NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
    = NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED
  succ NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED
    = NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF
  succ NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF
    = NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED
  succ NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED
    = NEXUS_OPERATION_CANCELLATION_STATE_FAILED
  succ NEXUS_OPERATION_CANCELLATION_STATE_FAILED
    = NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT
  succ (NexusOperationCancellationState'Unrecognized _)
    = Prelude.error
        "NexusOperationCancellationState.succ: bad argument: unrecognized value"
  pred NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
    = Prelude.error
        "NexusOperationCancellationState.pred: bad argument NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED. This value would be out of bounds."
  pred NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED
    = NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
  pred NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF
    = NEXUS_OPERATION_CANCELLATION_STATE_SCHEDULED
  pred NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED
    = NEXUS_OPERATION_CANCELLATION_STATE_BACKING_OFF
  pred NEXUS_OPERATION_CANCELLATION_STATE_FAILED
    = NEXUS_OPERATION_CANCELLATION_STATE_SUCCEEDED
  pred NEXUS_OPERATION_CANCELLATION_STATE_TIMED_OUT
    = NEXUS_OPERATION_CANCELLATION_STATE_FAILED
  pred (NexusOperationCancellationState'Unrecognized _)
    = Prelude.error
        "NexusOperationCancellationState.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault NexusOperationCancellationState where
  fieldDefault = NEXUS_OPERATION_CANCELLATION_STATE_UNSPECIFIED
instance Control.DeepSeq.NFData NexusOperationCancellationState where
  rnf x__ = Prelude.seq x__ ()
newtype PendingNexusOperationState'UnrecognizedValue
  = PendingNexusOperationState'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data PendingNexusOperationState
  = PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED |
    PENDING_NEXUS_OPERATION_STATE_SCHEDULED |
    PENDING_NEXUS_OPERATION_STATE_BACKING_OFF |
    PENDING_NEXUS_OPERATION_STATE_STARTED |
    PendingNexusOperationState'Unrecognized !PendingNexusOperationState'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum PendingNexusOperationState where
  maybeToEnum 0
    = Prelude.Just PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just PENDING_NEXUS_OPERATION_STATE_SCHEDULED
  maybeToEnum 2
    = Prelude.Just PENDING_NEXUS_OPERATION_STATE_BACKING_OFF
  maybeToEnum 3 = Prelude.Just PENDING_NEXUS_OPERATION_STATE_STARTED
  maybeToEnum k
    = Prelude.Just
        (PendingNexusOperationState'Unrecognized
           (PendingNexusOperationState'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
    = "PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED"
  showEnum PENDING_NEXUS_OPERATION_STATE_SCHEDULED
    = "PENDING_NEXUS_OPERATION_STATE_SCHEDULED"
  showEnum PENDING_NEXUS_OPERATION_STATE_BACKING_OFF
    = "PENDING_NEXUS_OPERATION_STATE_BACKING_OFF"
  showEnum PENDING_NEXUS_OPERATION_STATE_STARTED
    = "PENDING_NEXUS_OPERATION_STATE_STARTED"
  showEnum
    (PendingNexusOperationState'Unrecognized (PendingNexusOperationState'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED"
    = Prelude.Just PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
    | (Prelude.==) k "PENDING_NEXUS_OPERATION_STATE_SCHEDULED"
    = Prelude.Just PENDING_NEXUS_OPERATION_STATE_SCHEDULED
    | (Prelude.==) k "PENDING_NEXUS_OPERATION_STATE_BACKING_OFF"
    = Prelude.Just PENDING_NEXUS_OPERATION_STATE_BACKING_OFF
    | (Prelude.==) k "PENDING_NEXUS_OPERATION_STATE_STARTED"
    = Prelude.Just PENDING_NEXUS_OPERATION_STATE_STARTED
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded PendingNexusOperationState where
  minBound = PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
  maxBound = PENDING_NEXUS_OPERATION_STATE_STARTED
instance Prelude.Enum PendingNexusOperationState where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum PendingNexusOperationState: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED = 0
  fromEnum PENDING_NEXUS_OPERATION_STATE_SCHEDULED = 1
  fromEnum PENDING_NEXUS_OPERATION_STATE_BACKING_OFF = 2
  fromEnum PENDING_NEXUS_OPERATION_STATE_STARTED = 3
  fromEnum
    (PendingNexusOperationState'Unrecognized (PendingNexusOperationState'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ PENDING_NEXUS_OPERATION_STATE_STARTED
    = Prelude.error
        "PendingNexusOperationState.succ: bad argument PENDING_NEXUS_OPERATION_STATE_STARTED. This value would be out of bounds."
  succ PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
    = PENDING_NEXUS_OPERATION_STATE_SCHEDULED
  succ PENDING_NEXUS_OPERATION_STATE_SCHEDULED
    = PENDING_NEXUS_OPERATION_STATE_BACKING_OFF
  succ PENDING_NEXUS_OPERATION_STATE_BACKING_OFF
    = PENDING_NEXUS_OPERATION_STATE_STARTED
  succ (PendingNexusOperationState'Unrecognized _)
    = Prelude.error
        "PendingNexusOperationState.succ: bad argument: unrecognized value"
  pred PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
    = Prelude.error
        "PendingNexusOperationState.pred: bad argument PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED. This value would be out of bounds."
  pred PENDING_NEXUS_OPERATION_STATE_SCHEDULED
    = PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
  pred PENDING_NEXUS_OPERATION_STATE_BACKING_OFF
    = PENDING_NEXUS_OPERATION_STATE_SCHEDULED
  pred PENDING_NEXUS_OPERATION_STATE_STARTED
    = PENDING_NEXUS_OPERATION_STATE_BACKING_OFF
  pred (PendingNexusOperationState'Unrecognized _)
    = Prelude.error
        "PendingNexusOperationState.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault PendingNexusOperationState where
  fieldDefault = PENDING_NEXUS_OPERATION_STATE_UNSPECIFIED
instance Control.DeepSeq.NFData PendingNexusOperationState where
  rnf x__ = Prelude.seq x__ ()
newtype Severity'UnrecognizedValue
  = Severity'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data Severity
  = SEVERITY_UNSPECIFIED |
    SEVERITY_HIGH |
    SEVERITY_MEDIUM |
    SEVERITY_LOW |
    Severity'Unrecognized !Severity'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum Severity where
  maybeToEnum 0 = Prelude.Just SEVERITY_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just SEVERITY_HIGH
  maybeToEnum 2 = Prelude.Just SEVERITY_MEDIUM
  maybeToEnum 3 = Prelude.Just SEVERITY_LOW
  maybeToEnum k
    = Prelude.Just
        (Severity'Unrecognized
           (Severity'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum SEVERITY_UNSPECIFIED = "SEVERITY_UNSPECIFIED"
  showEnum SEVERITY_HIGH = "SEVERITY_HIGH"
  showEnum SEVERITY_MEDIUM = "SEVERITY_MEDIUM"
  showEnum SEVERITY_LOW = "SEVERITY_LOW"
  showEnum (Severity'Unrecognized (Severity'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "SEVERITY_UNSPECIFIED"
    = Prelude.Just SEVERITY_UNSPECIFIED
    | (Prelude.==) k "SEVERITY_HIGH" = Prelude.Just SEVERITY_HIGH
    | (Prelude.==) k "SEVERITY_MEDIUM" = Prelude.Just SEVERITY_MEDIUM
    | (Prelude.==) k "SEVERITY_LOW" = Prelude.Just SEVERITY_LOW
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded Severity where
  minBound = SEVERITY_UNSPECIFIED
  maxBound = SEVERITY_LOW
instance Prelude.Enum Severity where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum Severity: " (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum SEVERITY_UNSPECIFIED = 0
  fromEnum SEVERITY_HIGH = 1
  fromEnum SEVERITY_MEDIUM = 2
  fromEnum SEVERITY_LOW = 3
  fromEnum (Severity'Unrecognized (Severity'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ SEVERITY_LOW
    = Prelude.error
        "Severity.succ: bad argument SEVERITY_LOW. This value would be out of bounds."
  succ SEVERITY_UNSPECIFIED = SEVERITY_HIGH
  succ SEVERITY_HIGH = SEVERITY_MEDIUM
  succ SEVERITY_MEDIUM = SEVERITY_LOW
  succ (Severity'Unrecognized _)
    = Prelude.error "Severity.succ: bad argument: unrecognized value"
  pred SEVERITY_UNSPECIFIED
    = Prelude.error
        "Severity.pred: bad argument SEVERITY_UNSPECIFIED. This value would be out of bounds."
  pred SEVERITY_HIGH = SEVERITY_UNSPECIFIED
  pred SEVERITY_MEDIUM = SEVERITY_HIGH
  pred SEVERITY_LOW = SEVERITY_MEDIUM
  pred (Severity'Unrecognized _)
    = Prelude.error "Severity.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault Severity where
  fieldDefault = SEVERITY_UNSPECIFIED
instance Control.DeepSeq.NFData Severity where
  rnf x__ = Prelude.seq x__ ()

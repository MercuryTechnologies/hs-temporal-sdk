{- This file was auto-generated from temporal/api/enums/v1/failed_cause.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.FailedCause (
        CancelExternalWorkflowExecutionFailedCause(..),
        CancelExternalWorkflowExecutionFailedCause(),
        CancelExternalWorkflowExecutionFailedCause'UnrecognizedValue,
        ResourceExhaustedCause(..), ResourceExhaustedCause(),
        ResourceExhaustedCause'UnrecognizedValue,
        SignalExternalWorkflowExecutionFailedCause(..),
        SignalExternalWorkflowExecutionFailedCause(),
        SignalExternalWorkflowExecutionFailedCause'UnrecognizedValue,
        StartChildWorkflowExecutionFailedCause(..),
        StartChildWorkflowExecutionFailedCause(),
        StartChildWorkflowExecutionFailedCause'UnrecognizedValue,
        WorkflowTaskFailedCause(..), WorkflowTaskFailedCause(),
        WorkflowTaskFailedCause'UnrecognizedValue
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
newtype CancelExternalWorkflowExecutionFailedCause'UnrecognizedValue
  = CancelExternalWorkflowExecutionFailedCause'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data CancelExternalWorkflowExecutionFailedCause
  = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED |
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND |
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND |
    CancelExternalWorkflowExecutionFailedCause'Unrecognized !CancelExternalWorkflowExecutionFailedCause'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum CancelExternalWorkflowExecutionFailedCause where
  maybeToEnum 0
    = Prelude.Just
        CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just
        CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
  maybeToEnum 2
    = Prelude.Just
        CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
  maybeToEnum k
    = Prelude.Just
        (CancelExternalWorkflowExecutionFailedCause'Unrecognized
           (CancelExternalWorkflowExecutionFailedCause'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = "CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED"
  showEnum
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = "CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND"
  showEnum
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = "CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND"
  showEnum
    (CancelExternalWorkflowExecutionFailedCause'Unrecognized (CancelExternalWorkflowExecutionFailedCause'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==)
        k "CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED"
    = Prelude.Just
        CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    | (Prelude.==)
        k
        "CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND"
    = Prelude.Just
        CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    | (Prelude.==)
        k
        "CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND"
    = Prelude.Just
        CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded CancelExternalWorkflowExecutionFailedCause where
  minBound
    = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  maxBound
    = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
instance Prelude.Enum CancelExternalWorkflowExecutionFailedCause where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum CancelExternalWorkflowExecutionFailedCause: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = 0
  fromEnum
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = 1
  fromEnum
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = 2
  fromEnum
    (CancelExternalWorkflowExecutionFailedCause'Unrecognized (CancelExternalWorkflowExecutionFailedCause'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = Prelude.error
        "CancelExternalWorkflowExecutionFailedCause.succ: bad argument CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND. This value would be out of bounds."
  succ CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
  succ
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
  succ (CancelExternalWorkflowExecutionFailedCause'Unrecognized _)
    = Prelude.error
        "CancelExternalWorkflowExecutionFailedCause.succ: bad argument: unrecognized value"
  pred CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = Prelude.error
        "CancelExternalWorkflowExecutionFailedCause.pred: bad argument CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED. This value would be out of bounds."
  pred
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  pred
    CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
  pred (CancelExternalWorkflowExecutionFailedCause'Unrecognized _)
    = Prelude.error
        "CancelExternalWorkflowExecutionFailedCause.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault CancelExternalWorkflowExecutionFailedCause where
  fieldDefault
    = CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
instance Control.DeepSeq.NFData CancelExternalWorkflowExecutionFailedCause where
  rnf x__ = Prelude.seq x__ ()
newtype ResourceExhaustedCause'UnrecognizedValue
  = ResourceExhaustedCause'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data ResourceExhaustedCause
  = RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED |
    RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT |
    RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT |
    RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED |
    RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT |
    ResourceExhaustedCause'Unrecognized !ResourceExhaustedCause'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum ResourceExhaustedCause where
  maybeToEnum 0 = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT
  maybeToEnum 2
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT
  maybeToEnum 3
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED
  maybeToEnum 4
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT
  maybeToEnum k
    = Prelude.Just
        (ResourceExhaustedCause'Unrecognized
           (ResourceExhaustedCause'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
    = "RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED"
  showEnum RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT
    = "RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT"
  showEnum RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT
    = "RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT"
  showEnum RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED
    = "RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED"
  showEnum RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT
    = "RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT"
  showEnum
    (ResourceExhaustedCause'Unrecognized (ResourceExhaustedCause'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED"
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
    | (Prelude.==) k "RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT"
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT
    | (Prelude.==) k "RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT"
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT
    | (Prelude.==) k "RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED"
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED
    | (Prelude.==) k "RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT"
    = Prelude.Just RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded ResourceExhaustedCause where
  minBound = RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
  maxBound = RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT
instance Prelude.Enum ResourceExhaustedCause where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum ResourceExhaustedCause: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED = 0
  fromEnum RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT = 1
  fromEnum RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT = 2
  fromEnum RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED = 3
  fromEnum RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT = 4
  fromEnum
    (ResourceExhaustedCause'Unrecognized (ResourceExhaustedCause'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT
    = Prelude.error
        "ResourceExhaustedCause.succ: bad argument RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT. This value would be out of bounds."
  succ RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
    = RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT
  succ RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT
    = RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT
  succ RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT
    = RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED
  succ RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED
    = RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT
  succ (ResourceExhaustedCause'Unrecognized _)
    = Prelude.error
        "ResourceExhaustedCause.succ: bad argument: unrecognized value"
  pred RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
    = Prelude.error
        "ResourceExhaustedCause.pred: bad argument RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED. This value would be out of bounds."
  pred RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT
    = RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
  pred RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT
    = RESOURCE_EXHAUSTED_CAUSE_RPS_LIMIT
  pred RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED
    = RESOURCE_EXHAUSTED_CAUSE_CONCURRENT_LIMIT
  pred RESOURCE_EXHAUSTED_CAUSE_PERSISTENCE_LIMIT
    = RESOURCE_EXHAUSTED_CAUSE_SYSTEM_OVERLOADED
  pred (ResourceExhaustedCause'Unrecognized _)
    = Prelude.error
        "ResourceExhaustedCause.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault ResourceExhaustedCause where
  fieldDefault = RESOURCE_EXHAUSTED_CAUSE_UNSPECIFIED
instance Control.DeepSeq.NFData ResourceExhaustedCause where
  rnf x__ = Prelude.seq x__ ()
newtype SignalExternalWorkflowExecutionFailedCause'UnrecognizedValue
  = SignalExternalWorkflowExecutionFailedCause'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data SignalExternalWorkflowExecutionFailedCause
  = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED |
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND |
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND |
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED |
    SignalExternalWorkflowExecutionFailedCause'Unrecognized !SignalExternalWorkflowExecutionFailedCause'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum SignalExternalWorkflowExecutionFailedCause where
  maybeToEnum 0
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
  maybeToEnum 2
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
  maybeToEnum 3
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
  maybeToEnum k
    = Prelude.Just
        (SignalExternalWorkflowExecutionFailedCause'Unrecognized
           (SignalExternalWorkflowExecutionFailedCause'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED"
  showEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND"
  showEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND"
  showEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
    = "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED"
  showEnum
    (SignalExternalWorkflowExecutionFailedCause'Unrecognized (SignalExternalWorkflowExecutionFailedCause'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==)
        k "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED"
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    | (Prelude.==)
        k
        "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND"
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    | (Prelude.==)
        k
        "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND"
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    | (Prelude.==)
        k
        "SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED"
    = Prelude.Just
        SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded SignalExternalWorkflowExecutionFailedCause where
  minBound
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  maxBound
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
instance Prelude.Enum SignalExternalWorkflowExecutionFailedCause where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum SignalExternalWorkflowExecutionFailedCause: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = 0
  fromEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = 1
  fromEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = 2
  fromEnum
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
    = 3
  fromEnum
    (SignalExternalWorkflowExecutionFailedCause'Unrecognized (SignalExternalWorkflowExecutionFailedCause'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
    = Prelude.error
        "SignalExternalWorkflowExecutionFailedCause.succ: bad argument SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED. This value would be out of bounds."
  succ SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
  succ
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
  succ
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
  succ (SignalExternalWorkflowExecutionFailedCause'Unrecognized _)
    = Prelude.error
        "SignalExternalWorkflowExecutionFailedCause.succ: bad argument: unrecognized value"
  pred SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = Prelude.error
        "SignalExternalWorkflowExecutionFailedCause.pred: bad argument SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED. This value would be out of bounds."
  pred
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  pred
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND
  pred
    SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_SIGNAL_COUNT_LIMIT_EXCEEDED
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
  pred (SignalExternalWorkflowExecutionFailedCause'Unrecognized _)
    = Prelude.error
        "SignalExternalWorkflowExecutionFailedCause.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault SignalExternalWorkflowExecutionFailedCause where
  fieldDefault
    = SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
instance Control.DeepSeq.NFData SignalExternalWorkflowExecutionFailedCause where
  rnf x__ = Prelude.seq x__ ()
newtype StartChildWorkflowExecutionFailedCause'UnrecognizedValue
  = StartChildWorkflowExecutionFailedCause'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data StartChildWorkflowExecutionFailedCause
  = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED |
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS |
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND |
    StartChildWorkflowExecutionFailedCause'Unrecognized !StartChildWorkflowExecutionFailedCause'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum StartChildWorkflowExecutionFailedCause where
  maybeToEnum 0
    = Prelude.Just
        START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just
        START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
  maybeToEnum 2
    = Prelude.Just
        START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
  maybeToEnum k
    = Prelude.Just
        (StartChildWorkflowExecutionFailedCause'Unrecognized
           (StartChildWorkflowExecutionFailedCause'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = "START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED"
  showEnum
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
    = "START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS"
  showEnum
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = "START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND"
  showEnum
    (StartChildWorkflowExecutionFailedCause'Unrecognized (StartChildWorkflowExecutionFailedCause'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==)
        k "START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED"
    = Prelude.Just
        START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    | (Prelude.==)
        k
        "START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS"
    = Prelude.Just
        START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
    | (Prelude.==)
        k "START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND"
    = Prelude.Just
        START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded StartChildWorkflowExecutionFailedCause where
  minBound = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  maxBound
    = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
instance Prelude.Enum StartChildWorkflowExecutionFailedCause where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum StartChildWorkflowExecutionFailedCause: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = 0
  fromEnum
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
    = 1
  fromEnum
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = 2
  fromEnum
    (StartChildWorkflowExecutionFailedCause'Unrecognized (StartChildWorkflowExecutionFailedCause'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = Prelude.error
        "StartChildWorkflowExecutionFailedCause.succ: bad argument START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND. This value would be out of bounds."
  succ START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
  succ
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
    = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
  succ (StartChildWorkflowExecutionFailedCause'Unrecognized _)
    = Prelude.error
        "StartChildWorkflowExecutionFailedCause.succ: bad argument: unrecognized value"
  pred START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
    = Prelude.error
        "StartChildWorkflowExecutionFailedCause.pred: bad argument START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED. This value would be out of bounds."
  pred
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
    = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
  pred
    START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_NAMESPACE_NOT_FOUND
    = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS
  pred (StartChildWorkflowExecutionFailedCause'Unrecognized _)
    = Prelude.error
        "StartChildWorkflowExecutionFailedCause.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault StartChildWorkflowExecutionFailedCause where
  fieldDefault
    = START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED
instance Control.DeepSeq.NFData StartChildWorkflowExecutionFailedCause where
  rnf x__ = Prelude.seq x__ ()
newtype WorkflowTaskFailedCause'UnrecognizedValue
  = WorkflowTaskFailedCause'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data WorkflowTaskFailedCause
  = WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED |
    WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID |
    WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE |
    WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND |
    WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE |
    WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY |
    WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES |
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED |
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED |
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED |
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED |
    WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE |
    WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE |
    WorkflowTaskFailedCause'Unrecognized !WorkflowTaskFailedCause'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum WorkflowTaskFailedCause where
  maybeToEnum 0 = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND
  maybeToEnum 2
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
  maybeToEnum 3
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
  maybeToEnum 4
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES
  maybeToEnum 5
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES
  maybeToEnum 6
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
  maybeToEnum 7
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
  maybeToEnum 8
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
  maybeToEnum 9
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
  maybeToEnum 10
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
  maybeToEnum 11
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
  maybeToEnum 12
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID
  maybeToEnum 13
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE
  maybeToEnum 14
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
  maybeToEnum 15
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
  maybeToEnum 16
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
  maybeToEnum 17
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND
  maybeToEnum 18
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND
  maybeToEnum 19
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE
  maybeToEnum 20
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW
  maybeToEnum 21 = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY
  maybeToEnum 22
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
  maybeToEnum 23
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES
  maybeToEnum 24
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR
  maybeToEnum 25
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
  maybeToEnum 26
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
  maybeToEnum 27
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
  maybeToEnum 28
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
  maybeToEnum 29
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
  maybeToEnum 30
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
  maybeToEnum 31
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE
  maybeToEnum k
    = Prelude.Just
        (WorkflowTaskFailedCause'Unrecognized
           (WorkflowTaskFailedCause'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
    = "WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND
    = "WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID
    = "WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE
    = "WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
    = "WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND
    = "WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND
    = "WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW
    = "WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
    = "WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR
    = "WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
    = "WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
    = "WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
    = "WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
    = "WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED"
  showEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
    = "WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE"
  showEnum WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE
    = "WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE"
  showEnum
    (WorkflowTaskFailedCause'Unrecognized (WorkflowTaskFailedCause'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
    | (Prelude.==)
        k "WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
    | (Prelude.==)
        k
        "WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE"
    = Prelude.Just
        WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
    | (Prelude.==) k "WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE"
    = Prelude.Just WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded WorkflowTaskFailedCause where
  minBound = WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
  maxBound = WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE
instance Prelude.Enum WorkflowTaskFailedCause where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum WorkflowTaskFailedCause: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED = 0
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND = 1
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
    = 2
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
    = 3
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES = 4
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES = 5
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
    = 6
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
    = 7
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
    = 8
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
    = 9
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = 10
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
    = 11
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID = 12
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE = 13
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
    = 14
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = 15
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
    = 16
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND = 17
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND = 18
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE = 19
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW = 20
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY = 21
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
    = 22
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES = 23
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR = 24
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
    = 25
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
    = 26
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
    = 27
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
    = 28
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
    = 29
  fromEnum
    WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
    = 30
  fromEnum WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE = 31
  fromEnum
    (WorkflowTaskFailedCause'Unrecognized (WorkflowTaskFailedCause'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE
    = Prelude.error
        "WorkflowTaskFailedCause.succ: bad argument WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE. This value would be out of bounds."
  succ WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
    = WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND
  succ WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID
  succ WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID
    = WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE
  succ WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE
    = WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
  succ WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND
  succ WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND
    = WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND
  succ WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE
    = WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW
  succ WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY
    = WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
  succ WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES
  succ WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR
  succ WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
  succ
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
  succ WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
  succ WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
  succ
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
  succ
    WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
    = WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE
  succ (WorkflowTaskFailedCause'Unrecognized _)
    = Prelude.error
        "WorkflowTaskFailedCause.succ: bad argument: unrecognized value"
  pred WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
    = Prelude.error
        "WorkflowTaskFailedCause.pred: bad argument WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED. This value would be out of bounds."
  pred WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND
    = WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_COMMAND
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE
    = WORKFLOW_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID
  pred WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
    = WORKFLOW_TASK_FAILED_CAUSE_RESET_STICKY_TASK_QUEUE
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND
    = WORKFLOW_TASK_FAILED_CAUSE_FORCE_CLOSE_COMMAND
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE
    = WORKFLOW_TASK_FAILED_CAUSE_FAILOVER_CLOSE_COMMAND
  pred WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY
    = WORKFLOW_TASK_FAILED_CAUSE_RESET_WORKFLOW
  pred WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_BINARY
  pred WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID
  pred WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
    = WORKFLOW_TASK_FAILED_CAUSE_NON_DETERMINISTIC_ERROR
  pred
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_MODIFY_WORKFLOW_PROPERTIES_ATTRIBUTES
  pred WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_CHILD_WORKFLOWS_LIMIT_EXCEEDED
  pred WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_ACTIVITIES_LIMIT_EXCEEDED
  pred
    WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_SIGNALS_LIMIT_EXCEEDED
  pred
    WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
    = WORKFLOW_TASK_FAILED_CAUSE_PENDING_REQUEST_CANCEL_LIMIT_EXCEEDED
  pred WORKFLOW_TASK_FAILED_CAUSE_UNHANDLED_UPDATE
    = WORKFLOW_TASK_FAILED_CAUSE_BAD_UPDATE_WORKFLOW_EXECUTION_MESSAGE
  pred (WorkflowTaskFailedCause'Unrecognized _)
    = Prelude.error
        "WorkflowTaskFailedCause.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault WorkflowTaskFailedCause where
  fieldDefault = WORKFLOW_TASK_FAILED_CAUSE_UNSPECIFIED
instance Control.DeepSeq.NFData WorkflowTaskFailedCause where
  rnf x__ = Prelude.seq x__ ()
{- This file was auto-generated from temporal/api/enums/v1/update.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.Update (
        UpdateAdmittedEventOrigin(..), UpdateAdmittedEventOrigin(),
        UpdateAdmittedEventOrigin'UnrecognizedValue,
        UpdateWorkflowExecutionLifecycleStage(..),
        UpdateWorkflowExecutionLifecycleStage(),
        UpdateWorkflowExecutionLifecycleStage'UnrecognizedValue
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
newtype UpdateAdmittedEventOrigin'UnrecognizedValue
  = UpdateAdmittedEventOrigin'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data UpdateAdmittedEventOrigin
  = UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED |
    UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY |
    UpdateAdmittedEventOrigin'Unrecognized !UpdateAdmittedEventOrigin'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum UpdateAdmittedEventOrigin where
  maybeToEnum 0
    = Prelude.Just UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY
  maybeToEnum k
    = Prelude.Just
        (UpdateAdmittedEventOrigin'Unrecognized
           (UpdateAdmittedEventOrigin'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
    = "UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED"
  showEnum UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY
    = "UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY"
  showEnum
    (UpdateAdmittedEventOrigin'Unrecognized (UpdateAdmittedEventOrigin'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED"
    = Prelude.Just UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
    | (Prelude.==) k "UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY"
    = Prelude.Just UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded UpdateAdmittedEventOrigin where
  minBound = UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
  maxBound = UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY
instance Prelude.Enum UpdateAdmittedEventOrigin where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum UpdateAdmittedEventOrigin: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED = 0
  fromEnum UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY = 1
  fromEnum
    (UpdateAdmittedEventOrigin'Unrecognized (UpdateAdmittedEventOrigin'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY
    = Prelude.error
        "UpdateAdmittedEventOrigin.succ: bad argument UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY. This value would be out of bounds."
  succ UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
    = UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY
  succ (UpdateAdmittedEventOrigin'Unrecognized _)
    = Prelude.error
        "UpdateAdmittedEventOrigin.succ: bad argument: unrecognized value"
  pred UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
    = Prelude.error
        "UpdateAdmittedEventOrigin.pred: bad argument UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED. This value would be out of bounds."
  pred UPDATE_ADMITTED_EVENT_ORIGIN_REAPPLY
    = UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
  pred (UpdateAdmittedEventOrigin'Unrecognized _)
    = Prelude.error
        "UpdateAdmittedEventOrigin.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault UpdateAdmittedEventOrigin where
  fieldDefault = UPDATE_ADMITTED_EVENT_ORIGIN_UNSPECIFIED
instance Control.DeepSeq.NFData UpdateAdmittedEventOrigin where
  rnf x__ = Prelude.seq x__ ()
newtype UpdateWorkflowExecutionLifecycleStage'UnrecognizedValue
  = UpdateWorkflowExecutionLifecycleStage'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data UpdateWorkflowExecutionLifecycleStage
  = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED |
    UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED |
    UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED |
    UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED |
    UpdateWorkflowExecutionLifecycleStage'Unrecognized !UpdateWorkflowExecutionLifecycleStage'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum UpdateWorkflowExecutionLifecycleStage where
  maybeToEnum 0
    = Prelude.Just
        UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
  maybeToEnum 1
    = Prelude.Just UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED
  maybeToEnum 2
    = Prelude.Just UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED
  maybeToEnum 3
    = Prelude.Just UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED
  maybeToEnum k
    = Prelude.Just
        (UpdateWorkflowExecutionLifecycleStage'Unrecognized
           (UpdateWorkflowExecutionLifecycleStage'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
    = "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED"
  showEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED
    = "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED"
  showEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED
    = "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED"
  showEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED
    = "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED"
  showEnum
    (UpdateWorkflowExecutionLifecycleStage'Unrecognized (UpdateWorkflowExecutionLifecycleStage'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==)
        k "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED"
    = Prelude.Just
        UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
    | (Prelude.==)
        k "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED"
    = Prelude.Just UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED
    | (Prelude.==)
        k "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED"
    = Prelude.Just UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED
    | (Prelude.==)
        k "UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED"
    = Prelude.Just UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded UpdateWorkflowExecutionLifecycleStage where
  minBound = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
  maxBound = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED
instance Prelude.Enum UpdateWorkflowExecutionLifecycleStage where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum UpdateWorkflowExecutionLifecycleStage: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED = 0
  fromEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED = 1
  fromEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED = 2
  fromEnum UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED = 3
  fromEnum
    (UpdateWorkflowExecutionLifecycleStage'Unrecognized (UpdateWorkflowExecutionLifecycleStage'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED
    = Prelude.error
        "UpdateWorkflowExecutionLifecycleStage.succ: bad argument UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED. This value would be out of bounds."
  succ UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
    = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED
  succ UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED
    = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED
  succ UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED
    = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED
  succ (UpdateWorkflowExecutionLifecycleStage'Unrecognized _)
    = Prelude.error
        "UpdateWorkflowExecutionLifecycleStage.succ: bad argument: unrecognized value"
  pred UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
    = Prelude.error
        "UpdateWorkflowExecutionLifecycleStage.pred: bad argument UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED. This value would be out of bounds."
  pred UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED
    = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
  pred UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED
    = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ADMITTED
  pred UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_COMPLETED
    = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_ACCEPTED
  pred (UpdateWorkflowExecutionLifecycleStage'Unrecognized _)
    = Prelude.error
        "UpdateWorkflowExecutionLifecycleStage.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault UpdateWorkflowExecutionLifecycleStage where
  fieldDefault
    = UPDATE_WORKFLOW_EXECUTION_LIFECYCLE_STAGE_UNSPECIFIED
instance Control.DeepSeq.NFData UpdateWorkflowExecutionLifecycleStage where
  rnf x__ = Prelude.seq x__ ()

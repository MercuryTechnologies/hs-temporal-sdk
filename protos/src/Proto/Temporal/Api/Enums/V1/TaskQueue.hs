{- This file was auto-generated from temporal/api/enums/v1/task_queue.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.TaskQueue (
        TaskQueueKind(..), TaskQueueKind(),
        TaskQueueKind'UnrecognizedValue, TaskQueueType(..),
        TaskQueueType(), TaskQueueType'UnrecognizedValue,
        TaskReachability(..), TaskReachability(),
        TaskReachability'UnrecognizedValue
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
newtype TaskQueueKind'UnrecognizedValue
  = TaskQueueKind'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data TaskQueueKind
  = TASK_QUEUE_KIND_UNSPECIFIED |
    TASK_QUEUE_KIND_NORMAL |
    TASK_QUEUE_KIND_STICKY |
    TaskQueueKind'Unrecognized !TaskQueueKind'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum TaskQueueKind where
  maybeToEnum 0 = Prelude.Just TASK_QUEUE_KIND_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just TASK_QUEUE_KIND_NORMAL
  maybeToEnum 2 = Prelude.Just TASK_QUEUE_KIND_STICKY
  maybeToEnum k
    = Prelude.Just
        (TaskQueueKind'Unrecognized
           (TaskQueueKind'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum TASK_QUEUE_KIND_UNSPECIFIED
    = "TASK_QUEUE_KIND_UNSPECIFIED"
  showEnum TASK_QUEUE_KIND_NORMAL = "TASK_QUEUE_KIND_NORMAL"
  showEnum TASK_QUEUE_KIND_STICKY = "TASK_QUEUE_KIND_STICKY"
  showEnum
    (TaskQueueKind'Unrecognized (TaskQueueKind'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "TASK_QUEUE_KIND_UNSPECIFIED"
    = Prelude.Just TASK_QUEUE_KIND_UNSPECIFIED
    | (Prelude.==) k "TASK_QUEUE_KIND_NORMAL"
    = Prelude.Just TASK_QUEUE_KIND_NORMAL
    | (Prelude.==) k "TASK_QUEUE_KIND_STICKY"
    = Prelude.Just TASK_QUEUE_KIND_STICKY
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded TaskQueueKind where
  minBound = TASK_QUEUE_KIND_UNSPECIFIED
  maxBound = TASK_QUEUE_KIND_STICKY
instance Prelude.Enum TaskQueueKind where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum TaskQueueKind: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum TASK_QUEUE_KIND_UNSPECIFIED = 0
  fromEnum TASK_QUEUE_KIND_NORMAL = 1
  fromEnum TASK_QUEUE_KIND_STICKY = 2
  fromEnum
    (TaskQueueKind'Unrecognized (TaskQueueKind'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ TASK_QUEUE_KIND_STICKY
    = Prelude.error
        "TaskQueueKind.succ: bad argument TASK_QUEUE_KIND_STICKY. This value would be out of bounds."
  succ TASK_QUEUE_KIND_UNSPECIFIED = TASK_QUEUE_KIND_NORMAL
  succ TASK_QUEUE_KIND_NORMAL = TASK_QUEUE_KIND_STICKY
  succ (TaskQueueKind'Unrecognized _)
    = Prelude.error
        "TaskQueueKind.succ: bad argument: unrecognized value"
  pred TASK_QUEUE_KIND_UNSPECIFIED
    = Prelude.error
        "TaskQueueKind.pred: bad argument TASK_QUEUE_KIND_UNSPECIFIED. This value would be out of bounds."
  pred TASK_QUEUE_KIND_NORMAL = TASK_QUEUE_KIND_UNSPECIFIED
  pred TASK_QUEUE_KIND_STICKY = TASK_QUEUE_KIND_NORMAL
  pred (TaskQueueKind'Unrecognized _)
    = Prelude.error
        "TaskQueueKind.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault TaskQueueKind where
  fieldDefault = TASK_QUEUE_KIND_UNSPECIFIED
instance Control.DeepSeq.NFData TaskQueueKind where
  rnf x__ = Prelude.seq x__ ()
newtype TaskQueueType'UnrecognizedValue
  = TaskQueueType'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data TaskQueueType
  = TASK_QUEUE_TYPE_UNSPECIFIED |
    TASK_QUEUE_TYPE_WORKFLOW |
    TASK_QUEUE_TYPE_ACTIVITY |
    TaskQueueType'Unrecognized !TaskQueueType'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum TaskQueueType where
  maybeToEnum 0 = Prelude.Just TASK_QUEUE_TYPE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just TASK_QUEUE_TYPE_WORKFLOW
  maybeToEnum 2 = Prelude.Just TASK_QUEUE_TYPE_ACTIVITY
  maybeToEnum k
    = Prelude.Just
        (TaskQueueType'Unrecognized
           (TaskQueueType'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum TASK_QUEUE_TYPE_UNSPECIFIED
    = "TASK_QUEUE_TYPE_UNSPECIFIED"
  showEnum TASK_QUEUE_TYPE_WORKFLOW = "TASK_QUEUE_TYPE_WORKFLOW"
  showEnum TASK_QUEUE_TYPE_ACTIVITY = "TASK_QUEUE_TYPE_ACTIVITY"
  showEnum
    (TaskQueueType'Unrecognized (TaskQueueType'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "TASK_QUEUE_TYPE_UNSPECIFIED"
    = Prelude.Just TASK_QUEUE_TYPE_UNSPECIFIED
    | (Prelude.==) k "TASK_QUEUE_TYPE_WORKFLOW"
    = Prelude.Just TASK_QUEUE_TYPE_WORKFLOW
    | (Prelude.==) k "TASK_QUEUE_TYPE_ACTIVITY"
    = Prelude.Just TASK_QUEUE_TYPE_ACTIVITY
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded TaskQueueType where
  minBound = TASK_QUEUE_TYPE_UNSPECIFIED
  maxBound = TASK_QUEUE_TYPE_ACTIVITY
instance Prelude.Enum TaskQueueType where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum TaskQueueType: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum TASK_QUEUE_TYPE_UNSPECIFIED = 0
  fromEnum TASK_QUEUE_TYPE_WORKFLOW = 1
  fromEnum TASK_QUEUE_TYPE_ACTIVITY = 2
  fromEnum
    (TaskQueueType'Unrecognized (TaskQueueType'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ TASK_QUEUE_TYPE_ACTIVITY
    = Prelude.error
        "TaskQueueType.succ: bad argument TASK_QUEUE_TYPE_ACTIVITY. This value would be out of bounds."
  succ TASK_QUEUE_TYPE_UNSPECIFIED = TASK_QUEUE_TYPE_WORKFLOW
  succ TASK_QUEUE_TYPE_WORKFLOW = TASK_QUEUE_TYPE_ACTIVITY
  succ (TaskQueueType'Unrecognized _)
    = Prelude.error
        "TaskQueueType.succ: bad argument: unrecognized value"
  pred TASK_QUEUE_TYPE_UNSPECIFIED
    = Prelude.error
        "TaskQueueType.pred: bad argument TASK_QUEUE_TYPE_UNSPECIFIED. This value would be out of bounds."
  pred TASK_QUEUE_TYPE_WORKFLOW = TASK_QUEUE_TYPE_UNSPECIFIED
  pred TASK_QUEUE_TYPE_ACTIVITY = TASK_QUEUE_TYPE_WORKFLOW
  pred (TaskQueueType'Unrecognized _)
    = Prelude.error
        "TaskQueueType.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault TaskQueueType where
  fieldDefault = TASK_QUEUE_TYPE_UNSPECIFIED
instance Control.DeepSeq.NFData TaskQueueType where
  rnf x__ = Prelude.seq x__ ()
newtype TaskReachability'UnrecognizedValue
  = TaskReachability'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data TaskReachability
  = TASK_REACHABILITY_UNSPECIFIED |
    TASK_REACHABILITY_NEW_WORKFLOWS |
    TASK_REACHABILITY_EXISTING_WORKFLOWS |
    TASK_REACHABILITY_OPEN_WORKFLOWS |
    TASK_REACHABILITY_CLOSED_WORKFLOWS |
    TaskReachability'Unrecognized !TaskReachability'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum TaskReachability where
  maybeToEnum 0 = Prelude.Just TASK_REACHABILITY_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just TASK_REACHABILITY_NEW_WORKFLOWS
  maybeToEnum 2 = Prelude.Just TASK_REACHABILITY_EXISTING_WORKFLOWS
  maybeToEnum 3 = Prelude.Just TASK_REACHABILITY_OPEN_WORKFLOWS
  maybeToEnum 4 = Prelude.Just TASK_REACHABILITY_CLOSED_WORKFLOWS
  maybeToEnum k
    = Prelude.Just
        (TaskReachability'Unrecognized
           (TaskReachability'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum TASK_REACHABILITY_UNSPECIFIED
    = "TASK_REACHABILITY_UNSPECIFIED"
  showEnum TASK_REACHABILITY_NEW_WORKFLOWS
    = "TASK_REACHABILITY_NEW_WORKFLOWS"
  showEnum TASK_REACHABILITY_EXISTING_WORKFLOWS
    = "TASK_REACHABILITY_EXISTING_WORKFLOWS"
  showEnum TASK_REACHABILITY_OPEN_WORKFLOWS
    = "TASK_REACHABILITY_OPEN_WORKFLOWS"
  showEnum TASK_REACHABILITY_CLOSED_WORKFLOWS
    = "TASK_REACHABILITY_CLOSED_WORKFLOWS"
  showEnum
    (TaskReachability'Unrecognized (TaskReachability'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "TASK_REACHABILITY_UNSPECIFIED"
    = Prelude.Just TASK_REACHABILITY_UNSPECIFIED
    | (Prelude.==) k "TASK_REACHABILITY_NEW_WORKFLOWS"
    = Prelude.Just TASK_REACHABILITY_NEW_WORKFLOWS
    | (Prelude.==) k "TASK_REACHABILITY_EXISTING_WORKFLOWS"
    = Prelude.Just TASK_REACHABILITY_EXISTING_WORKFLOWS
    | (Prelude.==) k "TASK_REACHABILITY_OPEN_WORKFLOWS"
    = Prelude.Just TASK_REACHABILITY_OPEN_WORKFLOWS
    | (Prelude.==) k "TASK_REACHABILITY_CLOSED_WORKFLOWS"
    = Prelude.Just TASK_REACHABILITY_CLOSED_WORKFLOWS
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded TaskReachability where
  minBound = TASK_REACHABILITY_UNSPECIFIED
  maxBound = TASK_REACHABILITY_CLOSED_WORKFLOWS
instance Prelude.Enum TaskReachability where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum TaskReachability: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum TASK_REACHABILITY_UNSPECIFIED = 0
  fromEnum TASK_REACHABILITY_NEW_WORKFLOWS = 1
  fromEnum TASK_REACHABILITY_EXISTING_WORKFLOWS = 2
  fromEnum TASK_REACHABILITY_OPEN_WORKFLOWS = 3
  fromEnum TASK_REACHABILITY_CLOSED_WORKFLOWS = 4
  fromEnum
    (TaskReachability'Unrecognized (TaskReachability'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ TASK_REACHABILITY_CLOSED_WORKFLOWS
    = Prelude.error
        "TaskReachability.succ: bad argument TASK_REACHABILITY_CLOSED_WORKFLOWS. This value would be out of bounds."
  succ TASK_REACHABILITY_UNSPECIFIED
    = TASK_REACHABILITY_NEW_WORKFLOWS
  succ TASK_REACHABILITY_NEW_WORKFLOWS
    = TASK_REACHABILITY_EXISTING_WORKFLOWS
  succ TASK_REACHABILITY_EXISTING_WORKFLOWS
    = TASK_REACHABILITY_OPEN_WORKFLOWS
  succ TASK_REACHABILITY_OPEN_WORKFLOWS
    = TASK_REACHABILITY_CLOSED_WORKFLOWS
  succ (TaskReachability'Unrecognized _)
    = Prelude.error
        "TaskReachability.succ: bad argument: unrecognized value"
  pred TASK_REACHABILITY_UNSPECIFIED
    = Prelude.error
        "TaskReachability.pred: bad argument TASK_REACHABILITY_UNSPECIFIED. This value would be out of bounds."
  pred TASK_REACHABILITY_NEW_WORKFLOWS
    = TASK_REACHABILITY_UNSPECIFIED
  pred TASK_REACHABILITY_EXISTING_WORKFLOWS
    = TASK_REACHABILITY_NEW_WORKFLOWS
  pred TASK_REACHABILITY_OPEN_WORKFLOWS
    = TASK_REACHABILITY_EXISTING_WORKFLOWS
  pred TASK_REACHABILITY_CLOSED_WORKFLOWS
    = TASK_REACHABILITY_OPEN_WORKFLOWS
  pred (TaskReachability'Unrecognized _)
    = Prelude.error
        "TaskReachability.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault TaskReachability where
  fieldDefault = TASK_REACHABILITY_UNSPECIFIED
instance Control.DeepSeq.NFData TaskReachability where
  rnf x__ = Prelude.seq x__ ()
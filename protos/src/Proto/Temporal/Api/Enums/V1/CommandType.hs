{- This file was auto-generated from temporal/api/enums/v1/command_type.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.CommandType (
        CommandType(..), CommandType(), CommandType'UnrecognizedValue
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
newtype CommandType'UnrecognizedValue
  = CommandType'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data CommandType
  = COMMAND_TYPE_UNSPECIFIED |
    COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK |
    COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK |
    COMMAND_TYPE_START_TIMER |
    COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION |
    COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION |
    COMMAND_TYPE_CANCEL_TIMER |
    COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION |
    COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION |
    COMMAND_TYPE_RECORD_MARKER |
    COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION |
    COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION |
    COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION |
    COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES |
    COMMAND_TYPE_PROTOCOL_MESSAGE |
    COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES |
    CommandType'Unrecognized !CommandType'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum CommandType where
  maybeToEnum 0 = Prelude.Just COMMAND_TYPE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
  maybeToEnum 2
    = Prelude.Just COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
  maybeToEnum 3 = Prelude.Just COMMAND_TYPE_START_TIMER
  maybeToEnum 4
    = Prelude.Just COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
  maybeToEnum 5 = Prelude.Just COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
  maybeToEnum 6 = Prelude.Just COMMAND_TYPE_CANCEL_TIMER
  maybeToEnum 7 = Prelude.Just COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
  maybeToEnum 8
    = Prelude.Just
        COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
  maybeToEnum 9 = Prelude.Just COMMAND_TYPE_RECORD_MARKER
  maybeToEnum 10
    = Prelude.Just COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
  maybeToEnum 11
    = Prelude.Just COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
  maybeToEnum 12
    = Prelude.Just COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
  maybeToEnum 13
    = Prelude.Just COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
  maybeToEnum 14 = Prelude.Just COMMAND_TYPE_PROTOCOL_MESSAGE
  maybeToEnum 16
    = Prelude.Just COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
  maybeToEnum k
    = Prelude.Just
        (CommandType'Unrecognized
           (CommandType'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum COMMAND_TYPE_UNSPECIFIED = "COMMAND_TYPE_UNSPECIFIED"
  showEnum COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
    = "COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK"
  showEnum COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
    = "COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK"
  showEnum COMMAND_TYPE_START_TIMER = "COMMAND_TYPE_START_TIMER"
  showEnum COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
    = "COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION"
  showEnum COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
    = "COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION"
  showEnum COMMAND_TYPE_CANCEL_TIMER = "COMMAND_TYPE_CANCEL_TIMER"
  showEnum COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
    = "COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION"
  showEnum COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
    = "COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION"
  showEnum COMMAND_TYPE_RECORD_MARKER = "COMMAND_TYPE_RECORD_MARKER"
  showEnum COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
    = "COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION"
  showEnum COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
    = "COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION"
  showEnum COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
    = "COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION"
  showEnum COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    = "COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES"
  showEnum COMMAND_TYPE_PROTOCOL_MESSAGE
    = "COMMAND_TYPE_PROTOCOL_MESSAGE"
  showEnum COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
    = "COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES"
  showEnum
    (CommandType'Unrecognized (CommandType'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "COMMAND_TYPE_UNSPECIFIED"
    = Prelude.Just COMMAND_TYPE_UNSPECIFIED
    | (Prelude.==) k "COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK"
    = Prelude.Just COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
    | (Prelude.==) k "COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK"
    = Prelude.Just COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
    | (Prelude.==) k "COMMAND_TYPE_START_TIMER"
    = Prelude.Just COMMAND_TYPE_START_TIMER
    | (Prelude.==) k "COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION"
    = Prelude.Just COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
    | (Prelude.==) k "COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION"
    = Prelude.Just COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
    | (Prelude.==) k "COMMAND_TYPE_CANCEL_TIMER"
    = Prelude.Just COMMAND_TYPE_CANCEL_TIMER
    | (Prelude.==) k "COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION"
    = Prelude.Just COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
    | (Prelude.==)
        k "COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION"
    = Prelude.Just
        COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
    | (Prelude.==) k "COMMAND_TYPE_RECORD_MARKER"
    = Prelude.Just COMMAND_TYPE_RECORD_MARKER
    | (Prelude.==) k "COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION"
    = Prelude.Just COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
    | (Prelude.==) k "COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION"
    = Prelude.Just COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
    | (Prelude.==) k "COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION"
    = Prelude.Just COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
    | (Prelude.==) k "COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES"
    = Prelude.Just COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    | (Prelude.==) k "COMMAND_TYPE_PROTOCOL_MESSAGE"
    = Prelude.Just COMMAND_TYPE_PROTOCOL_MESSAGE
    | (Prelude.==) k "COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES"
    = Prelude.Just COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded CommandType where
  minBound = COMMAND_TYPE_UNSPECIFIED
  maxBound = COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
instance Prelude.Enum CommandType where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum CommandType: " (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum COMMAND_TYPE_UNSPECIFIED = 0
  fromEnum COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK = 1
  fromEnum COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK = 2
  fromEnum COMMAND_TYPE_START_TIMER = 3
  fromEnum COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION = 4
  fromEnum COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION = 5
  fromEnum COMMAND_TYPE_CANCEL_TIMER = 6
  fromEnum COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION = 7
  fromEnum COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
    = 8
  fromEnum COMMAND_TYPE_RECORD_MARKER = 9
  fromEnum COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION = 10
  fromEnum COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION = 11
  fromEnum COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION = 12
  fromEnum COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES = 13
  fromEnum COMMAND_TYPE_PROTOCOL_MESSAGE = 14
  fromEnum COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES = 16
  fromEnum
    (CommandType'Unrecognized (CommandType'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
    = Prelude.error
        "CommandType.succ: bad argument COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES. This value would be out of bounds."
  succ COMMAND_TYPE_UNSPECIFIED = COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
  succ COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
    = COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
  succ COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
    = COMMAND_TYPE_START_TIMER
  succ COMMAND_TYPE_START_TIMER
    = COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
  succ COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
    = COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
  succ COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_CANCEL_TIMER
  succ COMMAND_TYPE_CANCEL_TIMER
    = COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
  succ COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
  succ COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_RECORD_MARKER
  succ COMMAND_TYPE_RECORD_MARKER
    = COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
  succ COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
    = COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
  succ COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
    = COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
  succ COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
  succ COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    = COMMAND_TYPE_PROTOCOL_MESSAGE
  succ COMMAND_TYPE_PROTOCOL_MESSAGE
    = COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
  succ (CommandType'Unrecognized _)
    = Prelude.error
        "CommandType.succ: bad argument: unrecognized value"
  pred COMMAND_TYPE_UNSPECIFIED
    = Prelude.error
        "CommandType.pred: bad argument COMMAND_TYPE_UNSPECIFIED. This value would be out of bounds."
  pred COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK = COMMAND_TYPE_UNSPECIFIED
  pred COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
    = COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
  pred COMMAND_TYPE_START_TIMER
    = COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
  pred COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
    = COMMAND_TYPE_START_TIMER
  pred COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
  pred COMMAND_TYPE_CANCEL_TIMER
    = COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
  pred COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_CANCEL_TIMER
  pred COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
  pred COMMAND_TYPE_RECORD_MARKER
    = COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
  pred COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
    = COMMAND_TYPE_RECORD_MARKER
  pred COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
    = COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
  pred COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
    = COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
  pred COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    = COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
  pred COMMAND_TYPE_PROTOCOL_MESSAGE
    = COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
  pred COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
    = COMMAND_TYPE_PROTOCOL_MESSAGE
  pred (CommandType'Unrecognized _)
    = Prelude.error
        "CommandType.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault CommandType where
  fieldDefault = COMMAND_TYPE_UNSPECIFIED
instance Control.DeepSeq.NFData CommandType where
  rnf x__ = Prelude.seq x__ ()
{- This file was auto-generated from temporal/api/enums/v1/event_type.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.EventType (
        EventType(..), EventType(), EventType'UnrecognizedValue
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
newtype EventType'UnrecognizedValue
  = EventType'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data EventType
  = EVENT_TYPE_UNSPECIFIED |
    EVENT_TYPE_WORKFLOW_EXECUTION_STARTED |
    EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED |
    EVENT_TYPE_WORKFLOW_EXECUTION_FAILED |
    EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT |
    EVENT_TYPE_WORKFLOW_TASK_SCHEDULED |
    EVENT_TYPE_WORKFLOW_TASK_STARTED |
    EVENT_TYPE_WORKFLOW_TASK_COMPLETED |
    EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT |
    EVENT_TYPE_WORKFLOW_TASK_FAILED |
    EVENT_TYPE_ACTIVITY_TASK_SCHEDULED |
    EVENT_TYPE_ACTIVITY_TASK_STARTED |
    EVENT_TYPE_ACTIVITY_TASK_COMPLETED |
    EVENT_TYPE_ACTIVITY_TASK_FAILED |
    EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT |
    EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED |
    EVENT_TYPE_ACTIVITY_TASK_CANCELED |
    EVENT_TYPE_TIMER_STARTED |
    EVENT_TYPE_TIMER_FIRED |
    EVENT_TYPE_TIMER_CANCELED |
    EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED |
    EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED |
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED |
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED |
    EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED |
    EVENT_TYPE_MARKER_RECORDED |
    EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED |
    EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED |
    EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW |
    EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED |
    EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED |
    EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED |
    EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED |
    EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED |
    EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED |
    EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT |
    EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED |
    EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED |
    EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED |
    EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED |
    EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES |
    EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED |
    EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED |
    EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED |
    EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY |
    EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY |
    EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED |
    EventType'Unrecognized !EventType'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum EventType where
  enumName _ = Data.Text.pack "EventType"
  maybeToEnum 0 = Prelude.Just EVENT_TYPE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_STARTED
  maybeToEnum 2
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
  maybeToEnum 3 = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
  maybeToEnum 4
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
  maybeToEnum 5 = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_SCHEDULED
  maybeToEnum 6 = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_STARTED
  maybeToEnum 7 = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_COMPLETED
  maybeToEnum 8 = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT
  maybeToEnum 9 = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_FAILED
  maybeToEnum 10 = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_SCHEDULED
  maybeToEnum 11 = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_STARTED
  maybeToEnum 12 = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_COMPLETED
  maybeToEnum 13 = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_FAILED
  maybeToEnum 14 = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT
  maybeToEnum 15
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
  maybeToEnum 16 = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_CANCELED
  maybeToEnum 17 = Prelude.Just EVENT_TYPE_TIMER_STARTED
  maybeToEnum 18 = Prelude.Just EVENT_TYPE_TIMER_FIRED
  maybeToEnum 19 = Prelude.Just EVENT_TYPE_TIMER_CANCELED
  maybeToEnum 20
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
  maybeToEnum 21
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
  maybeToEnum 22
    = Prelude.Just
        EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
  maybeToEnum 23
    = Prelude.Just
        EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
  maybeToEnum 24
    = Prelude.Just
        EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
  maybeToEnum 25 = Prelude.Just EVENT_TYPE_MARKER_RECORDED
  maybeToEnum 26
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
  maybeToEnum 27
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
  maybeToEnum 28
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
  maybeToEnum 29
    = Prelude.Just EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
  maybeToEnum 30
    = Prelude.Just EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
  maybeToEnum 31
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
  maybeToEnum 32
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
  maybeToEnum 33
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
  maybeToEnum 34
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
  maybeToEnum 35
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
  maybeToEnum 36
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
  maybeToEnum 37
    = Prelude.Just
        EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
  maybeToEnum 38
    = Prelude.Just EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
  maybeToEnum 39
    = Prelude.Just EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
  maybeToEnum 40
    = Prelude.Just EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
  maybeToEnum 41
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
  maybeToEnum 42
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
  maybeToEnum 43
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
  maybeToEnum 44
    = Prelude.Just EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
  maybeToEnum 45
    = Prelude.Just EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
  maybeToEnum 46
    = Prelude.Just EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
  maybeToEnum k
    = Prelude.Just
        (EventType'Unrecognized
           (EventType'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum EVENT_TYPE_UNSPECIFIED = "EVENT_TYPE_UNSPECIFIED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_STARTED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_STARTED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_FAILED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
    = "EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT"
  showEnum EVENT_TYPE_WORKFLOW_TASK_SCHEDULED
    = "EVENT_TYPE_WORKFLOW_TASK_SCHEDULED"
  showEnum EVENT_TYPE_WORKFLOW_TASK_STARTED
    = "EVENT_TYPE_WORKFLOW_TASK_STARTED"
  showEnum EVENT_TYPE_WORKFLOW_TASK_COMPLETED
    = "EVENT_TYPE_WORKFLOW_TASK_COMPLETED"
  showEnum EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT
    = "EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT"
  showEnum EVENT_TYPE_WORKFLOW_TASK_FAILED
    = "EVENT_TYPE_WORKFLOW_TASK_FAILED"
  showEnum EVENT_TYPE_ACTIVITY_TASK_SCHEDULED
    = "EVENT_TYPE_ACTIVITY_TASK_SCHEDULED"
  showEnum EVENT_TYPE_ACTIVITY_TASK_STARTED
    = "EVENT_TYPE_ACTIVITY_TASK_STARTED"
  showEnum EVENT_TYPE_ACTIVITY_TASK_COMPLETED
    = "EVENT_TYPE_ACTIVITY_TASK_COMPLETED"
  showEnum EVENT_TYPE_ACTIVITY_TASK_FAILED
    = "EVENT_TYPE_ACTIVITY_TASK_FAILED"
  showEnum EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT
    = "EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT"
  showEnum EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
    = "EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED"
  showEnum EVENT_TYPE_ACTIVITY_TASK_CANCELED
    = "EVENT_TYPE_ACTIVITY_TASK_CANCELED"
  showEnum EVENT_TYPE_TIMER_STARTED = "EVENT_TYPE_TIMER_STARTED"
  showEnum EVENT_TYPE_TIMER_FIRED = "EVENT_TYPE_TIMER_FIRED"
  showEnum EVENT_TYPE_TIMER_CANCELED = "EVENT_TYPE_TIMER_CANCELED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED"
  showEnum
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = "EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED"
  showEnum
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    = "EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED"
  showEnum EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    = "EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED"
  showEnum EVENT_TYPE_MARKER_RECORDED = "EVENT_TYPE_MARKER_RECORDED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
    = "EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW"
  showEnum EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
    = "EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED"
  showEnum EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
    = "EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED"
  showEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
    = "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED"
  showEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
    = "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED"
  showEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
    = "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED"
  showEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
    = "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED"
  showEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
    = "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT"
  showEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
    = "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED"
  showEnum EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = "EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED"
  showEnum EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    = "EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED"
  showEnum EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
    = "EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED"
  showEnum EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    = "EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED"
  showEnum EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
    = "EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED"
  showEnum EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
    = "EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY"
  showEnum EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
    = "EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY"
  showEnum EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
    = "EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED"
  showEnum (EventType'Unrecognized (EventType'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "EVENT_TYPE_UNSPECIFIED"
    = Prelude.Just EVENT_TYPE_UNSPECIFIED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_STARTED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_STARTED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_FAILED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_TASK_SCHEDULED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_SCHEDULED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_TASK_STARTED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_STARTED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_TASK_COMPLETED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_COMPLETED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT"
    = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_TASK_FAILED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_TASK_FAILED
    | (Prelude.==) k "EVENT_TYPE_ACTIVITY_TASK_SCHEDULED"
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_SCHEDULED
    | (Prelude.==) k "EVENT_TYPE_ACTIVITY_TASK_STARTED"
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_STARTED
    | (Prelude.==) k "EVENT_TYPE_ACTIVITY_TASK_COMPLETED"
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_COMPLETED
    | (Prelude.==) k "EVENT_TYPE_ACTIVITY_TASK_FAILED"
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_FAILED
    | (Prelude.==) k "EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT"
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT
    | (Prelude.==) k "EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED"
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
    | (Prelude.==) k "EVENT_TYPE_ACTIVITY_TASK_CANCELED"
    = Prelude.Just EVENT_TYPE_ACTIVITY_TASK_CANCELED
    | (Prelude.==) k "EVENT_TYPE_TIMER_STARTED"
    = Prelude.Just EVENT_TYPE_TIMER_STARTED
    | (Prelude.==) k "EVENT_TYPE_TIMER_FIRED"
    = Prelude.Just EVENT_TYPE_TIMER_FIRED
    | (Prelude.==) k "EVENT_TYPE_TIMER_CANCELED"
    = Prelude.Just EVENT_TYPE_TIMER_CANCELED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
    | (Prelude.==)
        k "EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED"
    = Prelude.Just
        EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    | (Prelude.==)
        k "EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED"
    = Prelude.Just
        EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    | (Prelude.==)
        k "EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED"
    = Prelude.Just
        EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    | (Prelude.==) k "EVENT_TYPE_MARKER_RECORDED"
    = Prelude.Just EVENT_TYPE_MARKER_RECORDED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
    | (Prelude.==)
        k "EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED"
    = Prelude.Just EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
    | (Prelude.==) k "EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED"
    = Prelude.Just EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
    | (Prelude.==) k "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED"
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
    | (Prelude.==) k "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED"
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
    | (Prelude.==) k "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED"
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
    | (Prelude.==) k "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED"
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
    | (Prelude.==) k "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT"
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
    | (Prelude.==) k "EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED"
    = Prelude.Just EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
    | (Prelude.==)
        k "EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED"
    = Prelude.Just
        EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    | (Prelude.==)
        k "EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED"
    = Prelude.Just EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    | (Prelude.==) k "EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED"
    = Prelude.Just EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
    | (Prelude.==) k "EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES"
    = Prelude.Just EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
    | (Prelude.==)
        k "EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY"
    = Prelude.Just EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
    | (Prelude.==)
        k "EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY"
    = Prelude.Just EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
    | (Prelude.==) k "EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED"
    = Prelude.Just EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded EventType where
  minBound = EVENT_TYPE_UNSPECIFIED
  maxBound = EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
instance Prelude.Enum EventType where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum EventType: " (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum EVENT_TYPE_UNSPECIFIED = 0
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_STARTED = 1
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED = 2
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_FAILED = 3
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT = 4
  fromEnum EVENT_TYPE_WORKFLOW_TASK_SCHEDULED = 5
  fromEnum EVENT_TYPE_WORKFLOW_TASK_STARTED = 6
  fromEnum EVENT_TYPE_WORKFLOW_TASK_COMPLETED = 7
  fromEnum EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT = 8
  fromEnum EVENT_TYPE_WORKFLOW_TASK_FAILED = 9
  fromEnum EVENT_TYPE_ACTIVITY_TASK_SCHEDULED = 10
  fromEnum EVENT_TYPE_ACTIVITY_TASK_STARTED = 11
  fromEnum EVENT_TYPE_ACTIVITY_TASK_COMPLETED = 12
  fromEnum EVENT_TYPE_ACTIVITY_TASK_FAILED = 13
  fromEnum EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT = 14
  fromEnum EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED = 15
  fromEnum EVENT_TYPE_ACTIVITY_TASK_CANCELED = 16
  fromEnum EVENT_TYPE_TIMER_STARTED = 17
  fromEnum EVENT_TYPE_TIMER_FIRED = 18
  fromEnum EVENT_TYPE_TIMER_CANCELED = 19
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED = 20
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED = 21
  fromEnum
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = 22
  fromEnum
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    = 23
  fromEnum EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    = 24
  fromEnum EVENT_TYPE_MARKER_RECORDED = 25
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED = 26
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED = 27
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW = 28
  fromEnum EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED = 29
  fromEnum EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED = 30
  fromEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED = 31
  fromEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED = 32
  fromEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED = 33
  fromEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED = 34
  fromEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT = 35
  fromEnum EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED = 36
  fromEnum EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = 37
  fromEnum EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED = 38
  fromEnum EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED = 39
  fromEnum EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES = 40
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED = 41
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED = 42
  fromEnum EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED = 43
  fromEnum EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY = 44
  fromEnum EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY = 45
  fromEnum EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED = 46
  fromEnum (EventType'Unrecognized (EventType'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
    = Prelude.error
        "EventType.succ: bad argument EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED. This value would be out of bounds."
  succ EVENT_TYPE_UNSPECIFIED = EVENT_TYPE_WORKFLOW_EXECUTION_STARTED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_STARTED
    = EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
    = EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
  succ EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
    = EVENT_TYPE_WORKFLOW_TASK_SCHEDULED
  succ EVENT_TYPE_WORKFLOW_TASK_SCHEDULED
    = EVENT_TYPE_WORKFLOW_TASK_STARTED
  succ EVENT_TYPE_WORKFLOW_TASK_STARTED
    = EVENT_TYPE_WORKFLOW_TASK_COMPLETED
  succ EVENT_TYPE_WORKFLOW_TASK_COMPLETED
    = EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT
  succ EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT
    = EVENT_TYPE_WORKFLOW_TASK_FAILED
  succ EVENT_TYPE_WORKFLOW_TASK_FAILED
    = EVENT_TYPE_ACTIVITY_TASK_SCHEDULED
  succ EVENT_TYPE_ACTIVITY_TASK_SCHEDULED
    = EVENT_TYPE_ACTIVITY_TASK_STARTED
  succ EVENT_TYPE_ACTIVITY_TASK_STARTED
    = EVENT_TYPE_ACTIVITY_TASK_COMPLETED
  succ EVENT_TYPE_ACTIVITY_TASK_COMPLETED
    = EVENT_TYPE_ACTIVITY_TASK_FAILED
  succ EVENT_TYPE_ACTIVITY_TASK_FAILED
    = EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT
  succ EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT
    = EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
  succ EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
    = EVENT_TYPE_ACTIVITY_TASK_CANCELED
  succ EVENT_TYPE_ACTIVITY_TASK_CANCELED = EVENT_TYPE_TIMER_STARTED
  succ EVENT_TYPE_TIMER_STARTED = EVENT_TYPE_TIMER_FIRED
  succ EVENT_TYPE_TIMER_FIRED = EVENT_TYPE_TIMER_CANCELED
  succ EVENT_TYPE_TIMER_CANCELED
    = EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    = EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
    = EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
  succ
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
  succ EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
  succ EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    = EVENT_TYPE_MARKER_RECORDED
  succ EVENT_TYPE_MARKER_RECORDED
    = EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
    = EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
    = EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
  succ EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
    = EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
  succ EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
    = EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
  succ EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
  succ EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
  succ EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
  succ EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
  succ EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
  succ EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
  succ EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
    = EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
  succ EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
  succ EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
  succ EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
    = EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
  succ EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    = EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
    = EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
    = EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
  succ EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
    = EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
  succ EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
    = EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
  succ EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
    = EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
  succ (EventType'Unrecognized _)
    = Prelude.error "EventType.succ: bad argument: unrecognized value"
  pred EVENT_TYPE_UNSPECIFIED
    = Prelude.error
        "EventType.pred: bad argument EVENT_TYPE_UNSPECIFIED. This value would be out of bounds."
  pred EVENT_TYPE_WORKFLOW_EXECUTION_STARTED = EVENT_TYPE_UNSPECIFIED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
    = EVENT_TYPE_WORKFLOW_EXECUTION_STARTED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
    = EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
  pred EVENT_TYPE_WORKFLOW_TASK_SCHEDULED
    = EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
  pred EVENT_TYPE_WORKFLOW_TASK_STARTED
    = EVENT_TYPE_WORKFLOW_TASK_SCHEDULED
  pred EVENT_TYPE_WORKFLOW_TASK_COMPLETED
    = EVENT_TYPE_WORKFLOW_TASK_STARTED
  pred EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT
    = EVENT_TYPE_WORKFLOW_TASK_COMPLETED
  pred EVENT_TYPE_WORKFLOW_TASK_FAILED
    = EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT
  pred EVENT_TYPE_ACTIVITY_TASK_SCHEDULED
    = EVENT_TYPE_WORKFLOW_TASK_FAILED
  pred EVENT_TYPE_ACTIVITY_TASK_STARTED
    = EVENT_TYPE_ACTIVITY_TASK_SCHEDULED
  pred EVENT_TYPE_ACTIVITY_TASK_COMPLETED
    = EVENT_TYPE_ACTIVITY_TASK_STARTED
  pred EVENT_TYPE_ACTIVITY_TASK_FAILED
    = EVENT_TYPE_ACTIVITY_TASK_COMPLETED
  pred EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT
    = EVENT_TYPE_ACTIVITY_TASK_FAILED
  pred EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
    = EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT
  pred EVENT_TYPE_ACTIVITY_TASK_CANCELED
    = EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
  pred EVENT_TYPE_TIMER_STARTED = EVENT_TYPE_ACTIVITY_TASK_CANCELED
  pred EVENT_TYPE_TIMER_FIRED = EVENT_TYPE_TIMER_STARTED
  pred EVENT_TYPE_TIMER_CANCELED = EVENT_TYPE_TIMER_FIRED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    = EVENT_TYPE_TIMER_CANCELED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
    = EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
  pred
    EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
  pred EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
  pred EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
    = EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
  pred EVENT_TYPE_MARKER_RECORDED
    = EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
    = EVENT_TYPE_MARKER_RECORDED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
    = EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
    = EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
  pred EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
    = EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
  pred EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
  pred EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
    = EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
  pred EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
  pred EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
  pred EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
  pred EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
  pred EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
  pred EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
    = EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
  pred EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
    = EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
  pred EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
    = EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
  pred EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
    = EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
    = EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
  pred EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
    = EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
  pred EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
    = EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
  pred EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
    = EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
  pred EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
    = EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
  pred EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
    = EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
  pred (EventType'Unrecognized _)
    = Prelude.error "EventType.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault EventType where
  fieldDefault = EVENT_TYPE_UNSPECIFIED
instance Control.DeepSeq.NFData EventType where
  rnf x__ = Prelude.seq x__ ()
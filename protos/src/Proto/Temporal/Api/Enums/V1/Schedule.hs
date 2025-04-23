{- This file was auto-generated from temporal/api/enums/v1/schedule.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.Schedule (
        ScheduleOverlapPolicy(..), ScheduleOverlapPolicy(),
        ScheduleOverlapPolicy'UnrecognizedValue
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
newtype ScheduleOverlapPolicy'UnrecognizedValue
  = ScheduleOverlapPolicy'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data ScheduleOverlapPolicy
  = SCHEDULE_OVERLAP_POLICY_UNSPECIFIED |
    SCHEDULE_OVERLAP_POLICY_SKIP |
    SCHEDULE_OVERLAP_POLICY_BUFFER_ONE |
    SCHEDULE_OVERLAP_POLICY_BUFFER_ALL |
    SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER |
    SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER |
    SCHEDULE_OVERLAP_POLICY_ALLOW_ALL |
    ScheduleOverlapPolicy'Unrecognized !ScheduleOverlapPolicy'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum ScheduleOverlapPolicy where
  maybeToEnum 0 = Prelude.Just SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just SCHEDULE_OVERLAP_POLICY_SKIP
  maybeToEnum 2 = Prelude.Just SCHEDULE_OVERLAP_POLICY_BUFFER_ONE
  maybeToEnum 3 = Prelude.Just SCHEDULE_OVERLAP_POLICY_BUFFER_ALL
  maybeToEnum 4 = Prelude.Just SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER
  maybeToEnum 5
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER
  maybeToEnum 6 = Prelude.Just SCHEDULE_OVERLAP_POLICY_ALLOW_ALL
  maybeToEnum k
    = Prelude.Just
        (ScheduleOverlapPolicy'Unrecognized
           (ScheduleOverlapPolicy'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
    = "SCHEDULE_OVERLAP_POLICY_UNSPECIFIED"
  showEnum SCHEDULE_OVERLAP_POLICY_SKIP
    = "SCHEDULE_OVERLAP_POLICY_SKIP"
  showEnum SCHEDULE_OVERLAP_POLICY_BUFFER_ONE
    = "SCHEDULE_OVERLAP_POLICY_BUFFER_ONE"
  showEnum SCHEDULE_OVERLAP_POLICY_BUFFER_ALL
    = "SCHEDULE_OVERLAP_POLICY_BUFFER_ALL"
  showEnum SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER
    = "SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER"
  showEnum SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER
    = "SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER"
  showEnum SCHEDULE_OVERLAP_POLICY_ALLOW_ALL
    = "SCHEDULE_OVERLAP_POLICY_ALLOW_ALL"
  showEnum
    (ScheduleOverlapPolicy'Unrecognized (ScheduleOverlapPolicy'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "SCHEDULE_OVERLAP_POLICY_UNSPECIFIED"
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
    | (Prelude.==) k "SCHEDULE_OVERLAP_POLICY_SKIP"
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_SKIP
    | (Prelude.==) k "SCHEDULE_OVERLAP_POLICY_BUFFER_ONE"
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_BUFFER_ONE
    | (Prelude.==) k "SCHEDULE_OVERLAP_POLICY_BUFFER_ALL"
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_BUFFER_ALL
    | (Prelude.==) k "SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER"
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER
    | (Prelude.==) k "SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER"
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER
    | (Prelude.==) k "SCHEDULE_OVERLAP_POLICY_ALLOW_ALL"
    = Prelude.Just SCHEDULE_OVERLAP_POLICY_ALLOW_ALL
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded ScheduleOverlapPolicy where
  minBound = SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
  maxBound = SCHEDULE_OVERLAP_POLICY_ALLOW_ALL
instance Prelude.Enum ScheduleOverlapPolicy where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum ScheduleOverlapPolicy: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum SCHEDULE_OVERLAP_POLICY_UNSPECIFIED = 0
  fromEnum SCHEDULE_OVERLAP_POLICY_SKIP = 1
  fromEnum SCHEDULE_OVERLAP_POLICY_BUFFER_ONE = 2
  fromEnum SCHEDULE_OVERLAP_POLICY_BUFFER_ALL = 3
  fromEnum SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER = 4
  fromEnum SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER = 5
  fromEnum SCHEDULE_OVERLAP_POLICY_ALLOW_ALL = 6
  fromEnum
    (ScheduleOverlapPolicy'Unrecognized (ScheduleOverlapPolicy'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ SCHEDULE_OVERLAP_POLICY_ALLOW_ALL
    = Prelude.error
        "ScheduleOverlapPolicy.succ: bad argument SCHEDULE_OVERLAP_POLICY_ALLOW_ALL. This value would be out of bounds."
  succ SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
    = SCHEDULE_OVERLAP_POLICY_SKIP
  succ SCHEDULE_OVERLAP_POLICY_SKIP
    = SCHEDULE_OVERLAP_POLICY_BUFFER_ONE
  succ SCHEDULE_OVERLAP_POLICY_BUFFER_ONE
    = SCHEDULE_OVERLAP_POLICY_BUFFER_ALL
  succ SCHEDULE_OVERLAP_POLICY_BUFFER_ALL
    = SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER
  succ SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER
    = SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER
  succ SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER
    = SCHEDULE_OVERLAP_POLICY_ALLOW_ALL
  succ (ScheduleOverlapPolicy'Unrecognized _)
    = Prelude.error
        "ScheduleOverlapPolicy.succ: bad argument: unrecognized value"
  pred SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
    = Prelude.error
        "ScheduleOverlapPolicy.pred: bad argument SCHEDULE_OVERLAP_POLICY_UNSPECIFIED. This value would be out of bounds."
  pred SCHEDULE_OVERLAP_POLICY_SKIP
    = SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
  pred SCHEDULE_OVERLAP_POLICY_BUFFER_ONE
    = SCHEDULE_OVERLAP_POLICY_SKIP
  pred SCHEDULE_OVERLAP_POLICY_BUFFER_ALL
    = SCHEDULE_OVERLAP_POLICY_BUFFER_ONE
  pred SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER
    = SCHEDULE_OVERLAP_POLICY_BUFFER_ALL
  pred SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER
    = SCHEDULE_OVERLAP_POLICY_CANCEL_OTHER
  pred SCHEDULE_OVERLAP_POLICY_ALLOW_ALL
    = SCHEDULE_OVERLAP_POLICY_TERMINATE_OTHER
  pred (ScheduleOverlapPolicy'Unrecognized _)
    = Prelude.error
        "ScheduleOverlapPolicy.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault ScheduleOverlapPolicy where
  fieldDefault = SCHEDULE_OVERLAP_POLICY_UNSPECIFIED
instance Control.DeepSeq.NFData ScheduleOverlapPolicy where
  rnf x__ = Prelude.seq x__ ()
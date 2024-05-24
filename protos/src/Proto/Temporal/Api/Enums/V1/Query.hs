{- This file was auto-generated from temporal/api/enums/v1/query.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.Query (
        QueryRejectCondition(..), QueryRejectCondition(),
        QueryRejectCondition'UnrecognizedValue, QueryResultType(..),
        QueryResultType(), QueryResultType'UnrecognizedValue
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
newtype QueryRejectCondition'UnrecognizedValue
  = QueryRejectCondition'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data QueryRejectCondition
  = QUERY_REJECT_CONDITION_UNSPECIFIED |
    QUERY_REJECT_CONDITION_NONE |
    QUERY_REJECT_CONDITION_NOT_OPEN |
    QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY |
    QueryRejectCondition'Unrecognized !QueryRejectCondition'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum QueryRejectCondition where
  maybeToEnum 0 = Prelude.Just QUERY_REJECT_CONDITION_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just QUERY_REJECT_CONDITION_NONE
  maybeToEnum 2 = Prelude.Just QUERY_REJECT_CONDITION_NOT_OPEN
  maybeToEnum 3
    = Prelude.Just QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY
  maybeToEnum k
    = Prelude.Just
        (QueryRejectCondition'Unrecognized
           (QueryRejectCondition'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum QUERY_REJECT_CONDITION_UNSPECIFIED
    = "QUERY_REJECT_CONDITION_UNSPECIFIED"
  showEnum QUERY_REJECT_CONDITION_NONE
    = "QUERY_REJECT_CONDITION_NONE"
  showEnum QUERY_REJECT_CONDITION_NOT_OPEN
    = "QUERY_REJECT_CONDITION_NOT_OPEN"
  showEnum QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY
    = "QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY"
  showEnum
    (QueryRejectCondition'Unrecognized (QueryRejectCondition'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "QUERY_REJECT_CONDITION_UNSPECIFIED"
    = Prelude.Just QUERY_REJECT_CONDITION_UNSPECIFIED
    | (Prelude.==) k "QUERY_REJECT_CONDITION_NONE"
    = Prelude.Just QUERY_REJECT_CONDITION_NONE
    | (Prelude.==) k "QUERY_REJECT_CONDITION_NOT_OPEN"
    = Prelude.Just QUERY_REJECT_CONDITION_NOT_OPEN
    | (Prelude.==) k "QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY"
    = Prelude.Just QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded QueryRejectCondition where
  minBound = QUERY_REJECT_CONDITION_UNSPECIFIED
  maxBound = QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY
instance Prelude.Enum QueryRejectCondition where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum QueryRejectCondition: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum QUERY_REJECT_CONDITION_UNSPECIFIED = 0
  fromEnum QUERY_REJECT_CONDITION_NONE = 1
  fromEnum QUERY_REJECT_CONDITION_NOT_OPEN = 2
  fromEnum QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY = 3
  fromEnum
    (QueryRejectCondition'Unrecognized (QueryRejectCondition'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY
    = Prelude.error
        "QueryRejectCondition.succ: bad argument QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY. This value would be out of bounds."
  succ QUERY_REJECT_CONDITION_UNSPECIFIED
    = QUERY_REJECT_CONDITION_NONE
  succ QUERY_REJECT_CONDITION_NONE = QUERY_REJECT_CONDITION_NOT_OPEN
  succ QUERY_REJECT_CONDITION_NOT_OPEN
    = QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY
  succ (QueryRejectCondition'Unrecognized _)
    = Prelude.error
        "QueryRejectCondition.succ: bad argument: unrecognized value"
  pred QUERY_REJECT_CONDITION_UNSPECIFIED
    = Prelude.error
        "QueryRejectCondition.pred: bad argument QUERY_REJECT_CONDITION_UNSPECIFIED. This value would be out of bounds."
  pred QUERY_REJECT_CONDITION_NONE
    = QUERY_REJECT_CONDITION_UNSPECIFIED
  pred QUERY_REJECT_CONDITION_NOT_OPEN = QUERY_REJECT_CONDITION_NONE
  pred QUERY_REJECT_CONDITION_NOT_COMPLETED_CLEANLY
    = QUERY_REJECT_CONDITION_NOT_OPEN
  pred (QueryRejectCondition'Unrecognized _)
    = Prelude.error
        "QueryRejectCondition.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault QueryRejectCondition where
  fieldDefault = QUERY_REJECT_CONDITION_UNSPECIFIED
instance Control.DeepSeq.NFData QueryRejectCondition where
  rnf x__ = Prelude.seq x__ ()
newtype QueryResultType'UnrecognizedValue
  = QueryResultType'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data QueryResultType
  = QUERY_RESULT_TYPE_UNSPECIFIED |
    QUERY_RESULT_TYPE_ANSWERED |
    QUERY_RESULT_TYPE_FAILED |
    QueryResultType'Unrecognized !QueryResultType'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum QueryResultType where
  maybeToEnum 0 = Prelude.Just QUERY_RESULT_TYPE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just QUERY_RESULT_TYPE_ANSWERED
  maybeToEnum 2 = Prelude.Just QUERY_RESULT_TYPE_FAILED
  maybeToEnum k
    = Prelude.Just
        (QueryResultType'Unrecognized
           (QueryResultType'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum QUERY_RESULT_TYPE_UNSPECIFIED
    = "QUERY_RESULT_TYPE_UNSPECIFIED"
  showEnum QUERY_RESULT_TYPE_ANSWERED = "QUERY_RESULT_TYPE_ANSWERED"
  showEnum QUERY_RESULT_TYPE_FAILED = "QUERY_RESULT_TYPE_FAILED"
  showEnum
    (QueryResultType'Unrecognized (QueryResultType'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "QUERY_RESULT_TYPE_UNSPECIFIED"
    = Prelude.Just QUERY_RESULT_TYPE_UNSPECIFIED
    | (Prelude.==) k "QUERY_RESULT_TYPE_ANSWERED"
    = Prelude.Just QUERY_RESULT_TYPE_ANSWERED
    | (Prelude.==) k "QUERY_RESULT_TYPE_FAILED"
    = Prelude.Just QUERY_RESULT_TYPE_FAILED
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded QueryResultType where
  minBound = QUERY_RESULT_TYPE_UNSPECIFIED
  maxBound = QUERY_RESULT_TYPE_FAILED
instance Prelude.Enum QueryResultType where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum QueryResultType: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum QUERY_RESULT_TYPE_UNSPECIFIED = 0
  fromEnum QUERY_RESULT_TYPE_ANSWERED = 1
  fromEnum QUERY_RESULT_TYPE_FAILED = 2
  fromEnum
    (QueryResultType'Unrecognized (QueryResultType'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ QUERY_RESULT_TYPE_FAILED
    = Prelude.error
        "QueryResultType.succ: bad argument QUERY_RESULT_TYPE_FAILED. This value would be out of bounds."
  succ QUERY_RESULT_TYPE_UNSPECIFIED = QUERY_RESULT_TYPE_ANSWERED
  succ QUERY_RESULT_TYPE_ANSWERED = QUERY_RESULT_TYPE_FAILED
  succ (QueryResultType'Unrecognized _)
    = Prelude.error
        "QueryResultType.succ: bad argument: unrecognized value"
  pred QUERY_RESULT_TYPE_UNSPECIFIED
    = Prelude.error
        "QueryResultType.pred: bad argument QUERY_RESULT_TYPE_UNSPECIFIED. This value would be out of bounds."
  pred QUERY_RESULT_TYPE_ANSWERED = QUERY_RESULT_TYPE_UNSPECIFIED
  pred QUERY_RESULT_TYPE_FAILED = QUERY_RESULT_TYPE_ANSWERED
  pred (QueryResultType'Unrecognized _)
    = Prelude.error
        "QueryResultType.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault QueryResultType where
  fieldDefault = QUERY_RESULT_TYPE_UNSPECIFIED
instance Control.DeepSeq.NFData QueryResultType where
  rnf x__ = Prelude.seq x__ ()

{- This file was auto-generated from temporal/api/enums/v1/common.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.Common (
        EncodingType(..), EncodingType(), EncodingType'UnrecognizedValue,
        IndexedValueType(..), IndexedValueType(),
        IndexedValueType'UnrecognizedValue, Severity(..), Severity(),
        Severity'UnrecognizedValue
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
  enumName _ = Data.Text.pack "EncodingType"
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
  enumName _ = Data.Text.pack "IndexedValueType"
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
  enumName _ = Data.Text.pack "Severity"
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
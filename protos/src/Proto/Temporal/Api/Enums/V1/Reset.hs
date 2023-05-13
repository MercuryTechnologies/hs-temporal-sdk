{- This file was auto-generated from temporal/api/enums/v1/reset.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Enums.V1.Reset (
        ResetReapplyType(..), ResetReapplyType(),
        ResetReapplyType'UnrecognizedValue
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
newtype ResetReapplyType'UnrecognizedValue
  = ResetReapplyType'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data ResetReapplyType
  = RESET_REAPPLY_TYPE_UNSPECIFIED |
    RESET_REAPPLY_TYPE_SIGNAL |
    RESET_REAPPLY_TYPE_NONE |
    ResetReapplyType'Unrecognized !ResetReapplyType'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum ResetReapplyType where
  maybeToEnum 0 = Prelude.Just RESET_REAPPLY_TYPE_UNSPECIFIED
  maybeToEnum 1 = Prelude.Just RESET_REAPPLY_TYPE_SIGNAL
  maybeToEnum 2 = Prelude.Just RESET_REAPPLY_TYPE_NONE
  maybeToEnum k
    = Prelude.Just
        (ResetReapplyType'Unrecognized
           (ResetReapplyType'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum RESET_REAPPLY_TYPE_UNSPECIFIED
    = "RESET_REAPPLY_TYPE_UNSPECIFIED"
  showEnum RESET_REAPPLY_TYPE_SIGNAL = "RESET_REAPPLY_TYPE_SIGNAL"
  showEnum RESET_REAPPLY_TYPE_NONE = "RESET_REAPPLY_TYPE_NONE"
  showEnum
    (ResetReapplyType'Unrecognized (ResetReapplyType'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "RESET_REAPPLY_TYPE_UNSPECIFIED"
    = Prelude.Just RESET_REAPPLY_TYPE_UNSPECIFIED
    | (Prelude.==) k "RESET_REAPPLY_TYPE_SIGNAL"
    = Prelude.Just RESET_REAPPLY_TYPE_SIGNAL
    | (Prelude.==) k "RESET_REAPPLY_TYPE_NONE"
    = Prelude.Just RESET_REAPPLY_TYPE_NONE
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded ResetReapplyType where
  minBound = RESET_REAPPLY_TYPE_UNSPECIFIED
  maxBound = RESET_REAPPLY_TYPE_NONE
instance Prelude.Enum ResetReapplyType where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum ResetReapplyType: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum RESET_REAPPLY_TYPE_UNSPECIFIED = 0
  fromEnum RESET_REAPPLY_TYPE_SIGNAL = 1
  fromEnum RESET_REAPPLY_TYPE_NONE = 2
  fromEnum
    (ResetReapplyType'Unrecognized (ResetReapplyType'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ RESET_REAPPLY_TYPE_NONE
    = Prelude.error
        "ResetReapplyType.succ: bad argument RESET_REAPPLY_TYPE_NONE. This value would be out of bounds."
  succ RESET_REAPPLY_TYPE_UNSPECIFIED = RESET_REAPPLY_TYPE_SIGNAL
  succ RESET_REAPPLY_TYPE_SIGNAL = RESET_REAPPLY_TYPE_NONE
  succ (ResetReapplyType'Unrecognized _)
    = Prelude.error
        "ResetReapplyType.succ: bad argument: unrecognized value"
  pred RESET_REAPPLY_TYPE_UNSPECIFIED
    = Prelude.error
        "ResetReapplyType.pred: bad argument RESET_REAPPLY_TYPE_UNSPECIFIED. This value would be out of bounds."
  pred RESET_REAPPLY_TYPE_SIGNAL = RESET_REAPPLY_TYPE_UNSPECIFIED
  pred RESET_REAPPLY_TYPE_NONE = RESET_REAPPLY_TYPE_SIGNAL
  pred (ResetReapplyType'Unrecognized _)
    = Prelude.error
        "ResetReapplyType.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault ResetReapplyType where
  fieldDefault = RESET_REAPPLY_TYPE_UNSPECIFIED
instance Control.DeepSeq.NFData ResetReapplyType where
  rnf x__ = Prelude.seq x__ ()
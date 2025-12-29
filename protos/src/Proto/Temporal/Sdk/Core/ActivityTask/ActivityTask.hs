{- This file was auto-generated from temporal/sdk/core/activity_task/activity_task.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask (
        ActivityCancelReason(..), ActivityCancelReason(),
        ActivityCancelReason'UnrecognizedValue,
        ActivityCancellationDetails(), ActivityTask(),
        ActivityTask'Variant(..), _ActivityTask'Start,
        _ActivityTask'Cancel, Cancel(), Start(), Start'HeaderFieldsEntry()
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
import qualified Proto.Google.Protobuf.Duration
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Sdk.Core.Common.Common
newtype ActivityCancelReason'UnrecognizedValue
  = ActivityCancelReason'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data ActivityCancelReason
  = NOT_FOUND |
    CANCELLED |
    TIMED_OUT |
    WORKER_SHUTDOWN |
    PAUSED |
    RESET |
    ActivityCancelReason'Unrecognized !ActivityCancelReason'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum ActivityCancelReason where
  maybeToEnum 0 = Prelude.Just NOT_FOUND
  maybeToEnum 1 = Prelude.Just CANCELLED
  maybeToEnum 2 = Prelude.Just TIMED_OUT
  maybeToEnum 3 = Prelude.Just WORKER_SHUTDOWN
  maybeToEnum 4 = Prelude.Just PAUSED
  maybeToEnum 5 = Prelude.Just RESET
  maybeToEnum k
    = Prelude.Just
        (ActivityCancelReason'Unrecognized
           (ActivityCancelReason'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum NOT_FOUND = "NOT_FOUND"
  showEnum CANCELLED = "CANCELLED"
  showEnum TIMED_OUT = "TIMED_OUT"
  showEnum WORKER_SHUTDOWN = "WORKER_SHUTDOWN"
  showEnum PAUSED = "PAUSED"
  showEnum RESET = "RESET"
  showEnum
    (ActivityCancelReason'Unrecognized (ActivityCancelReason'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "NOT_FOUND" = Prelude.Just NOT_FOUND
    | (Prelude.==) k "CANCELLED" = Prelude.Just CANCELLED
    | (Prelude.==) k "TIMED_OUT" = Prelude.Just TIMED_OUT
    | (Prelude.==) k "WORKER_SHUTDOWN" = Prelude.Just WORKER_SHUTDOWN
    | (Prelude.==) k "PAUSED" = Prelude.Just PAUSED
    | (Prelude.==) k "RESET" = Prelude.Just RESET
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded ActivityCancelReason where
  minBound = NOT_FOUND
  maxBound = RESET
instance Prelude.Enum ActivityCancelReason where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum ActivityCancelReason: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum NOT_FOUND = 0
  fromEnum CANCELLED = 1
  fromEnum TIMED_OUT = 2
  fromEnum WORKER_SHUTDOWN = 3
  fromEnum PAUSED = 4
  fromEnum RESET = 5
  fromEnum
    (ActivityCancelReason'Unrecognized (ActivityCancelReason'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ RESET
    = Prelude.error
        "ActivityCancelReason.succ: bad argument RESET. This value would be out of bounds."
  succ NOT_FOUND = CANCELLED
  succ CANCELLED = TIMED_OUT
  succ TIMED_OUT = WORKER_SHUTDOWN
  succ WORKER_SHUTDOWN = PAUSED
  succ PAUSED = RESET
  succ (ActivityCancelReason'Unrecognized _)
    = Prelude.error
        "ActivityCancelReason.succ: bad argument: unrecognized value"
  pred NOT_FOUND
    = Prelude.error
        "ActivityCancelReason.pred: bad argument NOT_FOUND. This value would be out of bounds."
  pred CANCELLED = NOT_FOUND
  pred TIMED_OUT = CANCELLED
  pred WORKER_SHUTDOWN = TIMED_OUT
  pred PAUSED = WORKER_SHUTDOWN
  pred RESET = PAUSED
  pred (ActivityCancelReason'Unrecognized _)
    = Prelude.error
        "ActivityCancelReason.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault ActivityCancelReason where
  fieldDefault = NOT_FOUND
instance Control.DeepSeq.NFData ActivityCancelReason where
  rnf x__ = Prelude.seq x__ ()
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.isNotFound' @:: Lens' ActivityCancellationDetails Prelude.Bool@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.isCancelled' @:: Lens' ActivityCancellationDetails Prelude.Bool@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.isPaused' @:: Lens' ActivityCancellationDetails Prelude.Bool@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.isTimedOut' @:: Lens' ActivityCancellationDetails Prelude.Bool@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.isWorkerShutdown' @:: Lens' ActivityCancellationDetails Prelude.Bool@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.isReset' @:: Lens' ActivityCancellationDetails Prelude.Bool@ -}
data ActivityCancellationDetails
  = ActivityCancellationDetails'_constructor {_ActivityCancellationDetails'isNotFound :: !Prelude.Bool,
                                              _ActivityCancellationDetails'isCancelled :: !Prelude.Bool,
                                              _ActivityCancellationDetails'isPaused :: !Prelude.Bool,
                                              _ActivityCancellationDetails'isTimedOut :: !Prelude.Bool,
                                              _ActivityCancellationDetails'isWorkerShutdown :: !Prelude.Bool,
                                              _ActivityCancellationDetails'isReset :: !Prelude.Bool,
                                              _ActivityCancellationDetails'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ActivityCancellationDetails where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ActivityCancellationDetails "isNotFound" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityCancellationDetails'isNotFound
           (\ x__ y__ -> x__ {_ActivityCancellationDetails'isNotFound = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityCancellationDetails "isCancelled" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityCancellationDetails'isCancelled
           (\ x__ y__
              -> x__ {_ActivityCancellationDetails'isCancelled = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityCancellationDetails "isPaused" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityCancellationDetails'isPaused
           (\ x__ y__ -> x__ {_ActivityCancellationDetails'isPaused = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityCancellationDetails "isTimedOut" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityCancellationDetails'isTimedOut
           (\ x__ y__ -> x__ {_ActivityCancellationDetails'isTimedOut = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityCancellationDetails "isWorkerShutdown" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityCancellationDetails'isWorkerShutdown
           (\ x__ y__
              -> x__ {_ActivityCancellationDetails'isWorkerShutdown = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityCancellationDetails "isReset" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityCancellationDetails'isReset
           (\ x__ y__ -> x__ {_ActivityCancellationDetails'isReset = y__}))
        Prelude.id
instance Data.ProtoLens.Message ActivityCancellationDetails where
  messageName _
    = Data.Text.pack
        "coresdk.activity_task.ActivityCancellationDetails"
  packedMessageDescriptor _
    = "\n\
      \\ESCActivityCancellationDetails\DC2 \n\
      \\fis_not_found\CAN\SOH \SOH(\bR\n\
      \isNotFound\DC2!\n\
      \\fis_cancelled\CAN\STX \SOH(\bR\visCancelled\DC2\ESC\n\
      \\tis_paused\CAN\ETX \SOH(\bR\bisPaused\DC2 \n\
      \\fis_timed_out\CAN\EOT \SOH(\bR\n\
      \isTimedOut\DC2,\n\
      \\DC2is_worker_shutdown\CAN\ENQ \SOH(\bR\DLEisWorkerShutdown\DC2\EM\n\
      \\bis_reset\CAN\ACK \SOH(\bR\aisReset"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        isNotFound__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_not_found"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isNotFound")) ::
              Data.ProtoLens.FieldDescriptor ActivityCancellationDetails
        isCancelled__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_cancelled"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isCancelled")) ::
              Data.ProtoLens.FieldDescriptor ActivityCancellationDetails
        isPaused__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_paused"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isPaused")) ::
              Data.ProtoLens.FieldDescriptor ActivityCancellationDetails
        isTimedOut__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_timed_out"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isTimedOut")) ::
              Data.ProtoLens.FieldDescriptor ActivityCancellationDetails
        isWorkerShutdown__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_worker_shutdown"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isWorkerShutdown")) ::
              Data.ProtoLens.FieldDescriptor ActivityCancellationDetails
        isReset__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_reset"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"isReset")) ::
              Data.ProtoLens.FieldDescriptor ActivityCancellationDetails
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, isNotFound__field_descriptor),
           (Data.ProtoLens.Tag 2, isCancelled__field_descriptor),
           (Data.ProtoLens.Tag 3, isPaused__field_descriptor),
           (Data.ProtoLens.Tag 4, isTimedOut__field_descriptor),
           (Data.ProtoLens.Tag 5, isWorkerShutdown__field_descriptor),
           (Data.ProtoLens.Tag 6, isReset__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ActivityCancellationDetails'_unknownFields
        (\ x__ y__
           -> x__ {_ActivityCancellationDetails'_unknownFields = y__})
  defMessage
    = ActivityCancellationDetails'_constructor
        {_ActivityCancellationDetails'isNotFound = Data.ProtoLens.fieldDefault,
         _ActivityCancellationDetails'isCancelled = Data.ProtoLens.fieldDefault,
         _ActivityCancellationDetails'isPaused = Data.ProtoLens.fieldDefault,
         _ActivityCancellationDetails'isTimedOut = Data.ProtoLens.fieldDefault,
         _ActivityCancellationDetails'isWorkerShutdown = Data.ProtoLens.fieldDefault,
         _ActivityCancellationDetails'isReset = Data.ProtoLens.fieldDefault,
         _ActivityCancellationDetails'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ActivityCancellationDetails
          -> Data.ProtoLens.Encoding.Bytes.Parser ActivityCancellationDetails
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_not_found"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isNotFound") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_cancelled"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isCancelled") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_paused"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isPaused") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_timed_out"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isTimedOut") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_worker_shutdown"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"isWorkerShutdown") y x)
                        48
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_reset"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"isReset") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ActivityCancellationDetails"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"isNotFound") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                         _v))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"isCancelled") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                            _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"isPaused") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                               _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"isTimedOut") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt
                                  (\ b -> if b then 1 else 0) _v))
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"isWorkerShutdown") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (\ b -> if b then 1 else 0) _v))
                         ((Data.Monoid.<>)
                            (let
                               _v = Lens.Family2.view (Data.ProtoLens.Field.field @"isReset") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 48)
                                     ((Prelude..)
                                        Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (\ b -> if b then 1 else 0) _v))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData ActivityCancellationDetails where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ActivityCancellationDetails'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ActivityCancellationDetails'isNotFound x__)
                (Control.DeepSeq.deepseq
                   (_ActivityCancellationDetails'isCancelled x__)
                   (Control.DeepSeq.deepseq
                      (_ActivityCancellationDetails'isPaused x__)
                      (Control.DeepSeq.deepseq
                         (_ActivityCancellationDetails'isTimedOut x__)
                         (Control.DeepSeq.deepseq
                            (_ActivityCancellationDetails'isWorkerShutdown x__)
                            (Control.DeepSeq.deepseq
                               (_ActivityCancellationDetails'isReset x__) ()))))))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.taskToken' @:: Lens' ActivityTask Data.ByteString.ByteString@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'variant' @:: Lens' ActivityTask (Prelude.Maybe ActivityTask'Variant)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'start' @:: Lens' ActivityTask (Prelude.Maybe Start)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.start' @:: Lens' ActivityTask Start@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'cancel' @:: Lens' ActivityTask (Prelude.Maybe Cancel)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.cancel' @:: Lens' ActivityTask Cancel@ -}
data ActivityTask
  = ActivityTask'_constructor {_ActivityTask'taskToken :: !Data.ByteString.ByteString,
                               _ActivityTask'variant :: !(Prelude.Maybe ActivityTask'Variant),
                               _ActivityTask'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ActivityTask where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data ActivityTask'Variant
  = ActivityTask'Start !Start | ActivityTask'Cancel !Cancel
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField ActivityTask "taskToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTask'taskToken
           (\ x__ y__ -> x__ {_ActivityTask'taskToken = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityTask "maybe'variant" (Prelude.Maybe ActivityTask'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTask'variant
           (\ x__ y__ -> x__ {_ActivityTask'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityTask "maybe'start" (Prelude.Maybe Start) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTask'variant
           (\ x__ y__ -> x__ {_ActivityTask'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ActivityTask'Start x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap ActivityTask'Start y__))
instance Data.ProtoLens.Field.HasField ActivityTask "start" Start where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTask'variant
           (\ x__ y__ -> x__ {_ActivityTask'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ActivityTask'Start x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap ActivityTask'Start y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField ActivityTask "maybe'cancel" (Prelude.Maybe Cancel) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTask'variant
           (\ x__ y__ -> x__ {_ActivityTask'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ActivityTask'Cancel x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap ActivityTask'Cancel y__))
instance Data.ProtoLens.Field.HasField ActivityTask "cancel" Cancel where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTask'variant
           (\ x__ y__ -> x__ {_ActivityTask'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ActivityTask'Cancel x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap ActivityTask'Cancel y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message ActivityTask where
  messageName _ = Data.Text.pack "coresdk.activity_task.ActivityTask"
  packedMessageDescriptor _
    = "\n\
      \\fActivityTask\DC2\GS\n\
      \\n\
      \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC24\n\
      \\ENQstart\CAN\ETX \SOH(\v2\FS.coresdk.activity_task.StartH\NULR\ENQstart\DC27\n\
      \\ACKcancel\CAN\EOT \SOH(\v2\GS.coresdk.activity_task.CancelH\NULR\ACKcancelB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        taskToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskToken")) ::
              Data.ProtoLens.FieldDescriptor ActivityTask
        start__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Start)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'start")) ::
              Data.ProtoLens.FieldDescriptor ActivityTask
        cancel__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Cancel)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancel")) ::
              Data.ProtoLens.FieldDescriptor ActivityTask
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskToken__field_descriptor),
           (Data.ProtoLens.Tag 3, start__field_descriptor),
           (Data.ProtoLens.Tag 4, cancel__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ActivityTask'_unknownFields
        (\ x__ y__ -> x__ {_ActivityTask'_unknownFields = y__})
  defMessage
    = ActivityTask'_constructor
        {_ActivityTask'taskToken = Data.ProtoLens.fieldDefault,
         _ActivityTask'variant = Prelude.Nothing,
         _ActivityTask'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ActivityTask -> Data.ProtoLens.Encoding.Bytes.Parser ActivityTask
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "task_token"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskToken") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"start") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancel"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"cancel") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ActivityTask"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"taskToken") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((\ bs
                          -> (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                  (Prelude.fromIntegral (Data.ByteString.length bs)))
                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (ActivityTask'Start v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (ActivityTask'Cancel v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData ActivityTask where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ActivityTask'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ActivityTask'taskToken x__)
                (Control.DeepSeq.deepseq (_ActivityTask'variant x__) ()))
instance Control.DeepSeq.NFData ActivityTask'Variant where
  rnf (ActivityTask'Start x__) = Control.DeepSeq.rnf x__
  rnf (ActivityTask'Cancel x__) = Control.DeepSeq.rnf x__
_ActivityTask'Start ::
  Data.ProtoLens.Prism.Prism' ActivityTask'Variant Start
_ActivityTask'Start
  = Data.ProtoLens.Prism.prism'
      ActivityTask'Start
      (\ p__
         -> case p__ of
              (ActivityTask'Start p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_ActivityTask'Cancel ::
  Data.ProtoLens.Prism.Prism' ActivityTask'Variant Cancel
_ActivityTask'Cancel
  = Data.ProtoLens.Prism.prism'
      ActivityTask'Cancel
      (\ p__
         -> case p__ of
              (ActivityTask'Cancel p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.reason' @:: Lens' Cancel ActivityCancelReason@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.details' @:: Lens' Cancel ActivityCancellationDetails@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'details' @:: Lens' Cancel (Prelude.Maybe ActivityCancellationDetails)@ -}
data Cancel
  = Cancel'_constructor {_Cancel'reason :: !ActivityCancelReason,
                         _Cancel'details :: !(Prelude.Maybe ActivityCancellationDetails),
                         _Cancel'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Cancel where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Cancel "reason" ActivityCancelReason where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Cancel'reason (\ x__ y__ -> x__ {_Cancel'reason = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Cancel "details" ActivityCancellationDetails where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Cancel'details (\ x__ y__ -> x__ {_Cancel'details = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Cancel "maybe'details" (Prelude.Maybe ActivityCancellationDetails) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Cancel'details (\ x__ y__ -> x__ {_Cancel'details = y__}))
        Prelude.id
instance Data.ProtoLens.Message Cancel where
  messageName _ = Data.Text.pack "coresdk.activity_task.Cancel"
  packedMessageDescriptor _
    = "\n\
      \\ACKCancel\DC2C\n\
      \\ACKreason\CAN\SOH \SOH(\SO2+.coresdk.activity_task.ActivityCancelReasonR\ACKreason\DC2L\n\
      \\adetails\CAN\STX \SOH(\v22.coresdk.activity_task.ActivityCancellationDetailsR\adetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        reason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor ActivityCancelReason)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"reason")) ::
              Data.ProtoLens.FieldDescriptor Cancel
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ActivityCancellationDetails)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'details")) ::
              Data.ProtoLens.FieldDescriptor Cancel
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, reason__field_descriptor),
           (Data.ProtoLens.Tag 2, details__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Cancel'_unknownFields
        (\ x__ y__ -> x__ {_Cancel'_unknownFields = y__})
  defMessage
    = Cancel'_constructor
        {_Cancel'reason = Data.ProtoLens.fieldDefault,
         _Cancel'details = Prelude.Nothing, _Cancel'_unknownFields = []}
  parseMessage
    = let
        loop :: Cancel -> Data.ProtoLens.Encoding.Bytes.Parser Cancel
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "reason"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"reason") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "details"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"details") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Cancel"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"reason") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                         Prelude.fromEnum _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'details") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Cancel where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Cancel'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Cancel'reason x__)
                (Control.DeepSeq.deepseq (_Cancel'details x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.workflowNamespace' @:: Lens' Start Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.workflowType' @:: Lens' Start Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.workflowExecution' @:: Lens' Start Proto.Temporal.Api.Common.V1.Message.WorkflowExecution@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'workflowExecution' @:: Lens' Start (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.activityId' @:: Lens' Start Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.activityType' @:: Lens' Start Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.headerFields' @:: Lens' Start (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.input' @:: Lens' Start [Proto.Temporal.Api.Common.V1.Message.Payload]@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.vec'input' @:: Lens' Start (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.heartbeatDetails' @:: Lens' Start [Proto.Temporal.Api.Common.V1.Message.Payload]@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.vec'heartbeatDetails' @:: Lens' Start (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.scheduledTime' @:: Lens' Start Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'scheduledTime' @:: Lens' Start (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.currentAttemptScheduledTime' @:: Lens' Start Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'currentAttemptScheduledTime' @:: Lens' Start (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.startedTime' @:: Lens' Start Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'startedTime' @:: Lens' Start (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.attempt' @:: Lens' Start Data.Word.Word32@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.scheduleToCloseTimeout' @:: Lens' Start Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'scheduleToCloseTimeout' @:: Lens' Start (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.startToCloseTimeout' @:: Lens' Start Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'startToCloseTimeout' @:: Lens' Start (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.heartbeatTimeout' @:: Lens' Start Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'heartbeatTimeout' @:: Lens' Start (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.retryPolicy' @:: Lens' Start Proto.Temporal.Api.Common.V1.Message.RetryPolicy@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'retryPolicy' @:: Lens' Start (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.priority' @:: Lens' Start Proto.Temporal.Api.Common.V1.Message.Priority@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'priority' @:: Lens' Start (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority)@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.isLocal' @:: Lens' Start Prelude.Bool@ -}
data Start
  = Start'_constructor {_Start'workflowNamespace :: !Data.Text.Text,
                        _Start'workflowType :: !Data.Text.Text,
                        _Start'workflowExecution :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution),
                        _Start'activityId :: !Data.Text.Text,
                        _Start'activityType :: !Data.Text.Text,
                        _Start'headerFields :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload),
                        _Start'input :: !(Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload),
                        _Start'heartbeatDetails :: !(Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload),
                        _Start'scheduledTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                        _Start'currentAttemptScheduledTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                        _Start'startedTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                        _Start'attempt :: !Data.Word.Word32,
                        _Start'scheduleToCloseTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                        _Start'startToCloseTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                        _Start'heartbeatTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                        _Start'retryPolicy :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy),
                        _Start'priority :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority),
                        _Start'isLocal :: !Prelude.Bool,
                        _Start'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Start where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Start "workflowNamespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'workflowNamespace
           (\ x__ y__ -> x__ {_Start'workflowNamespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "workflowType" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'workflowType (\ x__ y__ -> x__ {_Start'workflowType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "workflowExecution" Proto.Temporal.Api.Common.V1.Message.WorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'workflowExecution
           (\ x__ y__ -> x__ {_Start'workflowExecution = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'workflowExecution" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'workflowExecution
           (\ x__ y__ -> x__ {_Start'workflowExecution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "activityId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'activityId (\ x__ y__ -> x__ {_Start'activityId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "activityType" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'activityType (\ x__ y__ -> x__ {_Start'activityType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "headerFields" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'headerFields (\ x__ y__ -> x__ {_Start'headerFields = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "input" [Proto.Temporal.Api.Common.V1.Message.Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'input (\ x__ y__ -> x__ {_Start'input = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Start "vec'input" (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'input (\ x__ y__ -> x__ {_Start'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "heartbeatDetails" [Proto.Temporal.Api.Common.V1.Message.Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'heartbeatDetails
           (\ x__ y__ -> x__ {_Start'heartbeatDetails = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Start "vec'heartbeatDetails" (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'heartbeatDetails
           (\ x__ y__ -> x__ {_Start'heartbeatDetails = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "scheduledTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'scheduledTime
           (\ x__ y__ -> x__ {_Start'scheduledTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'scheduledTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'scheduledTime
           (\ x__ y__ -> x__ {_Start'scheduledTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "currentAttemptScheduledTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'currentAttemptScheduledTime
           (\ x__ y__ -> x__ {_Start'currentAttemptScheduledTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'currentAttemptScheduledTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'currentAttemptScheduledTime
           (\ x__ y__ -> x__ {_Start'currentAttemptScheduledTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "startedTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'startedTime (\ x__ y__ -> x__ {_Start'startedTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'startedTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'startedTime (\ x__ y__ -> x__ {_Start'startedTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "attempt" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'attempt (\ x__ y__ -> x__ {_Start'attempt = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "scheduleToCloseTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'scheduleToCloseTimeout
           (\ x__ y__ -> x__ {_Start'scheduleToCloseTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'scheduleToCloseTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'scheduleToCloseTimeout
           (\ x__ y__ -> x__ {_Start'scheduleToCloseTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "startToCloseTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'startToCloseTimeout
           (\ x__ y__ -> x__ {_Start'startToCloseTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'startToCloseTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'startToCloseTimeout
           (\ x__ y__ -> x__ {_Start'startToCloseTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "heartbeatTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'heartbeatTimeout
           (\ x__ y__ -> x__ {_Start'heartbeatTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'heartbeatTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'heartbeatTimeout
           (\ x__ y__ -> x__ {_Start'heartbeatTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "retryPolicy" Proto.Temporal.Api.Common.V1.Message.RetryPolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'retryPolicy (\ x__ y__ -> x__ {_Start'retryPolicy = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'retryPolicy" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'retryPolicy (\ x__ y__ -> x__ {_Start'retryPolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "priority" Proto.Temporal.Api.Common.V1.Message.Priority where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'priority (\ x__ y__ -> x__ {_Start'priority = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start "maybe'priority" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'priority (\ x__ y__ -> x__ {_Start'priority = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start "isLocal" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'isLocal (\ x__ y__ -> x__ {_Start'isLocal = y__}))
        Prelude.id
instance Data.ProtoLens.Message Start where
  messageName _ = Data.Text.pack "coresdk.activity_task.Start"
  packedMessageDescriptor _
    = "\n\
      \\ENQStart\DC2-\n\
      \\DC2workflow_namespace\CAN\SOH \SOH(\tR\DC1workflowNamespace\DC2#\n\
      \\rworkflow_type\CAN\STX \SOH(\tR\fworkflowType\DC2X\n\
      \\DC2workflow_execution\CAN\ETX \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\DC1workflowExecution\DC2\US\n\
      \\vactivity_id\CAN\EOT \SOH(\tR\n\
      \activityId\DC2#\n\
      \\ractivity_type\CAN\ENQ \SOH(\tR\factivityType\DC2S\n\
      \\rheader_fields\CAN\ACK \ETX(\v2..coresdk.activity_task.Start.HeaderFieldsEntryR\fheaderFields\DC25\n\
      \\ENQinput\CAN\a \ETX(\v2\US.temporal.api.common.v1.PayloadR\ENQinput\DC2L\n\
      \\DC1heartbeat_details\CAN\b \ETX(\v2\US.temporal.api.common.v1.PayloadR\DLEheartbeatDetails\DC2A\n\
      \\SOscheduled_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2_\n\
      \\RScurrent_attempt_scheduled_time\CAN\n\
      \ \SOH(\v2\SUB.google.protobuf.TimestampR\ESCcurrentAttemptScheduledTime\DC2=\n\
      \\fstarted_time\CAN\v \SOH(\v2\SUB.google.protobuf.TimestampR\vstartedTime\DC2\CAN\n\
      \\aattempt\CAN\f \SOH(\rR\aattempt\DC2T\n\
      \\EMschedule_to_close_timeout\CAN\r \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToCloseTimeout\DC2N\n\
      \\SYNstart_to_close_timeout\CAN\SO \SOH(\v2\EM.google.protobuf.DurationR\DC3startToCloseTimeout\DC2F\n\
      \\DC1heartbeat_timeout\CAN\SI \SOH(\v2\EM.google.protobuf.DurationR\DLEheartbeatTimeout\DC2F\n\
      \\fretry_policy\CAN\DLE \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2<\n\
      \\bpriority\CAN\DC2 \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority\DC2\EM\n\
      \\bis_local\CAN\DC1 \SOH(\bR\aisLocal\SUB`\n\
      \\DC1HeaderFieldsEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowNamespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowNamespace")) ::
              Data.ProtoLens.FieldDescriptor Start
        workflowType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowType")) ::
              Data.ProtoLens.FieldDescriptor Start
        workflowExecution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowExecution")) ::
              Data.ProtoLens.FieldDescriptor Start
        activityId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"activityId")) ::
              Data.ProtoLens.FieldDescriptor Start
        activityType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"activityType")) ::
              Data.ProtoLens.FieldDescriptor Start
        headerFields__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header_fields"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Start'HeaderFieldsEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"headerFields")) ::
              Data.ProtoLens.FieldDescriptor Start
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"input")) ::
              Data.ProtoLens.FieldDescriptor Start
        heartbeatDetails__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "heartbeat_details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"heartbeatDetails")) ::
              Data.ProtoLens.FieldDescriptor Start
        scheduledTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scheduled_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduledTime")) ::
              Data.ProtoLens.FieldDescriptor Start
        currentAttemptScheduledTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_attempt_scheduled_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'currentAttemptScheduledTime")) ::
              Data.ProtoLens.FieldDescriptor Start
        startedTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "started_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startedTime")) ::
              Data.ProtoLens.FieldDescriptor Start
        attempt__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attempt"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"attempt")) ::
              Data.ProtoLens.FieldDescriptor Start
        scheduleToCloseTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schedule_to_close_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduleToCloseTimeout")) ::
              Data.ProtoLens.FieldDescriptor Start
        startToCloseTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_to_close_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startToCloseTimeout")) ::
              Data.ProtoLens.FieldDescriptor Start
        heartbeatTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "heartbeat_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'heartbeatTimeout")) ::
              Data.ProtoLens.FieldDescriptor Start
        retryPolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "retry_policy"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.RetryPolicy)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'retryPolicy")) ::
              Data.ProtoLens.FieldDescriptor Start
        priority__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "priority"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Priority)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'priority")) ::
              Data.ProtoLens.FieldDescriptor Start
        isLocal__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_local"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"isLocal")) ::
              Data.ProtoLens.FieldDescriptor Start
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowNamespace__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowType__field_descriptor),
           (Data.ProtoLens.Tag 3, workflowExecution__field_descriptor),
           (Data.ProtoLens.Tag 4, activityId__field_descriptor),
           (Data.ProtoLens.Tag 5, activityType__field_descriptor),
           (Data.ProtoLens.Tag 6, headerFields__field_descriptor),
           (Data.ProtoLens.Tag 7, input__field_descriptor),
           (Data.ProtoLens.Tag 8, heartbeatDetails__field_descriptor),
           (Data.ProtoLens.Tag 9, scheduledTime__field_descriptor),
           (Data.ProtoLens.Tag 10, 
            currentAttemptScheduledTime__field_descriptor),
           (Data.ProtoLens.Tag 11, startedTime__field_descriptor),
           (Data.ProtoLens.Tag 12, attempt__field_descriptor),
           (Data.ProtoLens.Tag 13, scheduleToCloseTimeout__field_descriptor),
           (Data.ProtoLens.Tag 14, startToCloseTimeout__field_descriptor),
           (Data.ProtoLens.Tag 15, heartbeatTimeout__field_descriptor),
           (Data.ProtoLens.Tag 16, retryPolicy__field_descriptor),
           (Data.ProtoLens.Tag 18, priority__field_descriptor),
           (Data.ProtoLens.Tag 17, isLocal__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Start'_unknownFields
        (\ x__ y__ -> x__ {_Start'_unknownFields = y__})
  defMessage
    = Start'_constructor
        {_Start'workflowNamespace = Data.ProtoLens.fieldDefault,
         _Start'workflowType = Data.ProtoLens.fieldDefault,
         _Start'workflowExecution = Prelude.Nothing,
         _Start'activityId = Data.ProtoLens.fieldDefault,
         _Start'activityType = Data.ProtoLens.fieldDefault,
         _Start'headerFields = Data.Map.empty,
         _Start'input = Data.Vector.Generic.empty,
         _Start'heartbeatDetails = Data.Vector.Generic.empty,
         _Start'scheduledTime = Prelude.Nothing,
         _Start'currentAttemptScheduledTime = Prelude.Nothing,
         _Start'startedTime = Prelude.Nothing,
         _Start'attempt = Data.ProtoLens.fieldDefault,
         _Start'scheduleToCloseTimeout = Prelude.Nothing,
         _Start'startToCloseTimeout = Prelude.Nothing,
         _Start'heartbeatTimeout = Prelude.Nothing,
         _Start'retryPolicy = Prelude.Nothing,
         _Start'priority = Prelude.Nothing,
         _Start'isLocal = Data.ProtoLens.fieldDefault,
         _Start'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Start
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Common.V1.Message.Payload
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Common.V1.Message.Payload
                -> Data.ProtoLens.Encoding.Bytes.Parser Start
        loop x mutable'heartbeatDetails mutable'input
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'heartbeatDetails <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                   (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                      mutable'heartbeatDetails)
                      frozen'input <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                        (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'input)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'heartbeatDetails")
                              frozen'heartbeatDetails
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'input") frozen'input x)))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "workflow_namespace"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowNamespace") y x)
                                  mutable'heartbeatDetails mutable'input
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "workflow_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowType") y x)
                                  mutable'heartbeatDetails mutable'input
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_execution"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecution") y x)
                                  mutable'heartbeatDetails mutable'input
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "activity_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"activityId") y x)
                                  mutable'heartbeatDetails mutable'input
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "activity_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activityType") y x)
                                  mutable'heartbeatDetails mutable'input
                        50
                          -> do !(entry :: Start'HeaderFieldsEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                         (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                             Data.ProtoLens.Encoding.Bytes.isolate
                                                                               (Prelude.fromIntegral
                                                                                  len)
                                                                               Data.ProtoLens.parseMessage)
                                                                         "header_fields"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"headerFields")
                                        (\ !t -> Data.Map.insert key value t) x)
                                     mutable'heartbeatDetails mutable'input)
                        58
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "input"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'input y)
                                loop x mutable'heartbeatDetails v
                        66
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "heartbeat_details"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'heartbeatDetails y)
                                loop x v mutable'input
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "scheduled_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduledTime") y x)
                                  mutable'heartbeatDetails mutable'input
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "current_attempt_scheduled_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentAttemptScheduledTime") y
                                     x)
                                  mutable'heartbeatDetails mutable'input
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "started_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"startedTime") y x)
                                  mutable'heartbeatDetails mutable'input
                        96
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attempt"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"attempt") y x)
                                  mutable'heartbeatDetails mutable'input
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "schedule_to_close_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduleToCloseTimeout") y x)
                                  mutable'heartbeatDetails mutable'input
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_to_close_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startToCloseTimeout") y x)
                                  mutable'heartbeatDetails mutable'input
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "heartbeat_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"heartbeatTimeout") y x)
                                  mutable'heartbeatDetails mutable'input
                        130
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "retry_policy"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"retryPolicy") y x)
                                  mutable'heartbeatDetails mutable'input
                        146
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "priority"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"priority") y x)
                                  mutable'heartbeatDetails mutable'input
                        136
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_local"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isLocal") y x)
                                  mutable'heartbeatDetails mutable'input
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'heartbeatDetails mutable'input
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'heartbeatDetails <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                            Data.ProtoLens.Encoding.Growing.new
              mutable'input <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                 Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'heartbeatDetails mutable'input)
          "Start"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"workflowNamespace") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowType") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'workflowExecution") _x
                    of
                      Prelude.Nothing -> Data.Monoid.mempty
                      (Prelude.Just _v)
                        -> (Data.Monoid.<>)
                             (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                             ((Prelude..)
                                (\ bs
                                   -> (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (Prelude.fromIntegral (Data.ByteString.length bs)))
                                        (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                Data.ProtoLens.encodeMessage _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"activityId") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                               ((Prelude..)
                                  (\ bs
                                     -> (Data.Monoid.<>)
                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                             (Prelude.fromIntegral (Data.ByteString.length bs)))
                                          (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                  Data.Text.Encoding.encodeUtf8 _v))
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view (Data.ProtoLens.Field.field @"activityType") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                  ((Prelude..)
                                     (\ bs
                                        -> (Data.Monoid.<>)
                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                (Prelude.fromIntegral (Data.ByteString.length bs)))
                                             (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                     Data.Text.Encoding.encodeUtf8 _v))
                         ((Data.Monoid.<>)
                            (Data.Monoid.mconcat
                               (Prelude.map
                                  (\ _v
                                     -> (Data.Monoid.<>)
                                          (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                          ((Prelude..)
                                             (\ bs
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                        (Prelude.fromIntegral
                                                           (Data.ByteString.length bs)))
                                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                             Data.ProtoLens.encodeMessage
                                             (Lens.Family2.set
                                                (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                                (Lens.Family2.set
                                                   (Data.ProtoLens.Field.field @"value")
                                                   (Prelude.snd _v)
                                                   (Data.ProtoLens.defMessage ::
                                                      Start'HeaderFieldsEntry)))))
                                  (Data.Map.toList
                                     (Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"headerFields") _x))))
                            ((Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                                  (\ _v
                                     -> (Data.Monoid.<>)
                                          (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                                          ((Prelude..)
                                             (\ bs
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                        (Prelude.fromIntegral
                                                           (Data.ByteString.length bs)))
                                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                             Data.ProtoLens.encodeMessage _v))
                                  (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'input") _x))
                               ((Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                                     (\ _v
                                        -> (Data.Monoid.<>)
                                             (Data.ProtoLens.Encoding.Bytes.putVarInt 66)
                                             ((Prelude..)
                                                (\ bs
                                                   -> (Data.Monoid.<>)
                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                           (Prelude.fromIntegral
                                                              (Data.ByteString.length bs)))
                                                        (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                                Data.ProtoLens.encodeMessage _v))
                                     (Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"vec'heartbeatDetails") _x))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'scheduledTime") _x
                                      of
                                        Prelude.Nothing -> Data.Monoid.mempty
                                        (Prelude.Just _v)
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                               ((Prelude..)
                                                  (\ bs
                                                     -> (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             (Prelude.fromIntegral
                                                                (Data.ByteString.length bs)))
                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                             bs))
                                                  Data.ProtoLens.encodeMessage _v))
                                     ((Data.Monoid.<>)
                                        (case
                                             Lens.Family2.view
                                               (Data.ProtoLens.Field.field
                                                  @"maybe'currentAttemptScheduledTime")
                                               _x
                                         of
                                           Prelude.Nothing -> Data.Monoid.mempty
                                           (Prelude.Just _v)
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                                  ((Prelude..)
                                                     (\ bs
                                                        -> (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                (Prelude.fromIntegral
                                                                   (Data.ByteString.length bs)))
                                                             (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                bs))
                                                     Data.ProtoLens.encodeMessage _v))
                                        ((Data.Monoid.<>)
                                           (case
                                                Lens.Family2.view
                                                  (Data.ProtoLens.Field.field @"maybe'startedTime")
                                                  _x
                                            of
                                              Prelude.Nothing -> Data.Monoid.mempty
                                              (Prelude.Just _v)
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                     ((Prelude..)
                                                        (\ bs
                                                           -> (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (Prelude.fromIntegral
                                                                      (Data.ByteString.length bs)))
                                                                (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                   bs))
                                                        Data.ProtoLens.encodeMessage _v))
                                           ((Data.Monoid.<>)
                                              (let
                                                 _v
                                                   = Lens.Family2.view
                                                       (Data.ProtoLens.Field.field @"attempt") _x
                                               in
                                                 if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                     Data.Monoid.mempty
                                                 else
                                                     (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 96)
                                                       ((Prelude..)
                                                          Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          Prelude.fromIntegral _v))
                                              ((Data.Monoid.<>)
                                                 (case
                                                      Lens.Family2.view
                                                        (Data.ProtoLens.Field.field
                                                           @"maybe'scheduleToCloseTimeout")
                                                        _x
                                                  of
                                                    Prelude.Nothing -> Data.Monoid.mempty
                                                    (Prelude.Just _v)
                                                      -> (Data.Monoid.<>)
                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                              106)
                                                           ((Prelude..)
                                                              (\ bs
                                                                 -> (Data.Monoid.<>)
                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         (Prelude.fromIntegral
                                                                            (Data.ByteString.length
                                                                               bs)))
                                                                      (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                         bs))
                                                              Data.ProtoLens.encodeMessage _v))
                                                 ((Data.Monoid.<>)
                                                    (case
                                                         Lens.Family2.view
                                                           (Data.ProtoLens.Field.field
                                                              @"maybe'startToCloseTimeout")
                                                           _x
                                                     of
                                                       Prelude.Nothing -> Data.Monoid.mempty
                                                       (Prelude.Just _v)
                                                         -> (Data.Monoid.<>)
                                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                 114)
                                                              ((Prelude..)
                                                                 (\ bs
                                                                    -> (Data.Monoid.<>)
                                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                            (Prelude.fromIntegral
                                                                               (Data.ByteString.length
                                                                                  bs)))
                                                                         (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                            bs))
                                                                 Data.ProtoLens.encodeMessage _v))
                                                    ((Data.Monoid.<>)
                                                       (case
                                                            Lens.Family2.view
                                                              (Data.ProtoLens.Field.field
                                                                 @"maybe'heartbeatTimeout")
                                                              _x
                                                        of
                                                          Prelude.Nothing -> Data.Monoid.mempty
                                                          (Prelude.Just _v)
                                                            -> (Data.Monoid.<>)
                                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                    122)
                                                                 ((Prelude..)
                                                                    (\ bs
                                                                       -> (Data.Monoid.<>)
                                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                               (Prelude.fromIntegral
                                                                                  (Data.ByteString.length
                                                                                     bs)))
                                                                            (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                               bs))
                                                                    Data.ProtoLens.encodeMessage
                                                                    _v))
                                                       ((Data.Monoid.<>)
                                                          (case
                                                               Lens.Family2.view
                                                                 (Data.ProtoLens.Field.field
                                                                    @"maybe'retryPolicy")
                                                                 _x
                                                           of
                                                             Prelude.Nothing -> Data.Monoid.mempty
                                                             (Prelude.Just _v)
                                                               -> (Data.Monoid.<>)
                                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                       130)
                                                                    ((Prelude..)
                                                                       (\ bs
                                                                          -> (Data.Monoid.<>)
                                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  (Prelude.fromIntegral
                                                                                     (Data.ByteString.length
                                                                                        bs)))
                                                                               (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                  bs))
                                                                       Data.ProtoLens.encodeMessage
                                                                       _v))
                                                          ((Data.Monoid.<>)
                                                             (case
                                                                  Lens.Family2.view
                                                                    (Data.ProtoLens.Field.field
                                                                       @"maybe'priority")
                                                                    _x
                                                              of
                                                                Prelude.Nothing
                                                                  -> Data.Monoid.mempty
                                                                (Prelude.Just _v)
                                                                  -> (Data.Monoid.<>)
                                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                          146)
                                                                       ((Prelude..)
                                                                          (\ bs
                                                                             -> (Data.Monoid.<>)
                                                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                     (Prelude.fromIntegral
                                                                                        (Data.ByteString.length
                                                                                           bs)))
                                                                                  (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                     bs))
                                                                          Data.ProtoLens.encodeMessage
                                                                          _v))
                                                             ((Data.Monoid.<>)
                                                                (let
                                                                   _v
                                                                     = Lens.Family2.view
                                                                         (Data.ProtoLens.Field.field
                                                                            @"isLocal")
                                                                         _x
                                                                 in
                                                                   if (Prelude.==)
                                                                        _v
                                                                        Data.ProtoLens.fieldDefault then
                                                                       Data.Monoid.mempty
                                                                   else
                                                                       (Data.Monoid.<>)
                                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                            136)
                                                                         ((Prelude..)
                                                                            Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                            (\ b
                                                                               -> if b then
                                                                                      1
                                                                                  else
                                                                                      0)
                                                                            _v))
                                                                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                                   (Lens.Family2.view
                                                                      Data.ProtoLens.unknownFields
                                                                      _x)))))))))))))))))))
instance Control.DeepSeq.NFData Start where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Start'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Start'workflowNamespace x__)
                (Control.DeepSeq.deepseq
                   (_Start'workflowType x__)
                   (Control.DeepSeq.deepseq
                      (_Start'workflowExecution x__)
                      (Control.DeepSeq.deepseq
                         (_Start'activityId x__)
                         (Control.DeepSeq.deepseq
                            (_Start'activityType x__)
                            (Control.DeepSeq.deepseq
                               (_Start'headerFields x__)
                               (Control.DeepSeq.deepseq
                                  (_Start'input x__)
                                  (Control.DeepSeq.deepseq
                                     (_Start'heartbeatDetails x__)
                                     (Control.DeepSeq.deepseq
                                        (_Start'scheduledTime x__)
                                        (Control.DeepSeq.deepseq
                                           (_Start'currentAttemptScheduledTime x__)
                                           (Control.DeepSeq.deepseq
                                              (_Start'startedTime x__)
                                              (Control.DeepSeq.deepseq
                                                 (_Start'attempt x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_Start'scheduleToCloseTimeout x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_Start'startToCloseTimeout x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_Start'heartbeatTimeout x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_Start'retryPolicy x__)
                                                             (Control.DeepSeq.deepseq
                                                                (_Start'priority x__)
                                                                (Control.DeepSeq.deepseq
                                                                   (_Start'isLocal x__)
                                                                   ()))))))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.key' @:: Lens' Start'HeaderFieldsEntry Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.value' @:: Lens' Start'HeaderFieldsEntry Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask_Fields.maybe'value' @:: Lens' Start'HeaderFieldsEntry (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data Start'HeaderFieldsEntry
  = Start'HeaderFieldsEntry'_constructor {_Start'HeaderFieldsEntry'key :: !Data.Text.Text,
                                          _Start'HeaderFieldsEntry'value :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload),
                                          _Start'HeaderFieldsEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Start'HeaderFieldsEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Start'HeaderFieldsEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'HeaderFieldsEntry'key
           (\ x__ y__ -> x__ {_Start'HeaderFieldsEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Start'HeaderFieldsEntry "value" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'HeaderFieldsEntry'value
           (\ x__ y__ -> x__ {_Start'HeaderFieldsEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Start'HeaderFieldsEntry "maybe'value" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Start'HeaderFieldsEntry'value
           (\ x__ y__ -> x__ {_Start'HeaderFieldsEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message Start'HeaderFieldsEntry where
  messageName _
    = Data.Text.pack "coresdk.activity_task.Start.HeaderFieldsEntry"
  packedMessageDescriptor _
    = "\n\
      \\DC1HeaderFieldsEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        key__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"key")) ::
              Data.ProtoLens.FieldDescriptor Start'HeaderFieldsEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor Start'HeaderFieldsEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Start'HeaderFieldsEntry'_unknownFields
        (\ x__ y__ -> x__ {_Start'HeaderFieldsEntry'_unknownFields = y__})
  defMessage
    = Start'HeaderFieldsEntry'_constructor
        {_Start'HeaderFieldsEntry'key = Data.ProtoLens.fieldDefault,
         _Start'HeaderFieldsEntry'value = Prelude.Nothing,
         _Start'HeaderFieldsEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Start'HeaderFieldsEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser Start'HeaderFieldsEntry
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "key"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"key") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "value"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"value") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "HeaderFieldsEntry"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"key") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'value") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Start'HeaderFieldsEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Start'HeaderFieldsEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Start'HeaderFieldsEntry'key x__)
                (Control.DeepSeq.deepseq (_Start'HeaderFieldsEntry'value x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \3temporal/sdk/core/activity_task/activity_task.proto\DC2\NAKcoresdk.activity_task\SUB\RSgoogle/protobuf/duration.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB$temporal/api/common/v1/message.proto\SUB%temporal/sdk/core/common/common.proto\"\167\SOH\n\
    \\fActivityTask\DC2\GS\n\
    \\n\
    \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC24\n\
    \\ENQstart\CAN\ETX \SOH(\v2\FS.coresdk.activity_task.StartH\NULR\ENQstart\DC27\n\
    \\ACKcancel\CAN\EOT \SOH(\v2\GS.coresdk.activity_task.CancelH\NULR\ACKcancelB\t\n\
    \\avariant\"\195\t\n\
    \\ENQStart\DC2-\n\
    \\DC2workflow_namespace\CAN\SOH \SOH(\tR\DC1workflowNamespace\DC2#\n\
    \\rworkflow_type\CAN\STX \SOH(\tR\fworkflowType\DC2X\n\
    \\DC2workflow_execution\CAN\ETX \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\DC1workflowExecution\DC2\US\n\
    \\vactivity_id\CAN\EOT \SOH(\tR\n\
    \activityId\DC2#\n\
    \\ractivity_type\CAN\ENQ \SOH(\tR\factivityType\DC2S\n\
    \\rheader_fields\CAN\ACK \ETX(\v2..coresdk.activity_task.Start.HeaderFieldsEntryR\fheaderFields\DC25\n\
    \\ENQinput\CAN\a \ETX(\v2\US.temporal.api.common.v1.PayloadR\ENQinput\DC2L\n\
    \\DC1heartbeat_details\CAN\b \ETX(\v2\US.temporal.api.common.v1.PayloadR\DLEheartbeatDetails\DC2A\n\
    \\SOscheduled_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2_\n\
    \\RScurrent_attempt_scheduled_time\CAN\n\
    \ \SOH(\v2\SUB.google.protobuf.TimestampR\ESCcurrentAttemptScheduledTime\DC2=\n\
    \\fstarted_time\CAN\v \SOH(\v2\SUB.google.protobuf.TimestampR\vstartedTime\DC2\CAN\n\
    \\aattempt\CAN\f \SOH(\rR\aattempt\DC2T\n\
    \\EMschedule_to_close_timeout\CAN\r \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToCloseTimeout\DC2N\n\
    \\SYNstart_to_close_timeout\CAN\SO \SOH(\v2\EM.google.protobuf.DurationR\DC3startToCloseTimeout\DC2F\n\
    \\DC1heartbeat_timeout\CAN\SI \SOH(\v2\EM.google.protobuf.DurationR\DLEheartbeatTimeout\DC2F\n\
    \\fretry_policy\CAN\DLE \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2<\n\
    \\bpriority\CAN\DC2 \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority\DC2\EM\n\
    \\bis_local\CAN\DC1 \SOH(\bR\aisLocal\SUB`\n\
    \\DC1HeaderFieldsEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
    \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH\"\155\SOH\n\
    \\ACKCancel\DC2C\n\
    \\ACKreason\CAN\SOH \SOH(\SO2+.coresdk.activity_task.ActivityCancelReasonR\ACKreason\DC2L\n\
    \\adetails\CAN\STX \SOH(\v22.coresdk.activity_task.ActivityCancellationDetailsR\adetails\"\234\SOH\n\
    \\ESCActivityCancellationDetails\DC2 \n\
    \\fis_not_found\CAN\SOH \SOH(\bR\n\
    \isNotFound\DC2!\n\
    \\fis_cancelled\CAN\STX \SOH(\bR\visCancelled\DC2\ESC\n\
    \\tis_paused\CAN\ETX \SOH(\bR\bisPaused\DC2 \n\
    \\fis_timed_out\CAN\EOT \SOH(\bR\n\
    \isTimedOut\DC2,\n\
    \\DC2is_worker_shutdown\CAN\ENQ \SOH(\bR\DLEisWorkerShutdown\DC2\EM\n\
    \\bis_reset\CAN\ACK \SOH(\bR\aisReset*o\n\
    \\DC4ActivityCancelReason\DC2\r\n\
    \\tNOT_FOUND\DLE\NUL\DC2\r\n\
    \\tCANCELLED\DLE\SOH\DC2\r\n\
    \\tTIMED_OUT\DLE\STX\DC2\DC3\n\
    \\SIWORKER_SHUTDOWN\DLE\ETX\DC2\n\
    \\n\
    \\ACKPAUSED\DLE\EOT\DC2\t\n\
    \\ENQRESET\DLE\ENQB2\234\STX/Temporalio::Internal::Bridge::Api::ActivityTaskJ\144\RS\n\
    \\ACK\DC2\EOT\NUL\NULa\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \a\n\
    \\SOH\STX\DC2\ETX\ENQ\NUL\RS\SUBW*\n\
    \ Definitions of the different activity tasks returned from [crate::Core::poll_task].\n\
    \\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ACK\NULH\n\
    \\t\n\
    \\STX\b-\DC2\ETX\ACK\NULH\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\b\NUL(\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\t\NUL)\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX\n\
    \\NUL.\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX\v\NUL/\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT\r\NUL\SYN\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\r\b\DC4\n\
    \0\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\SI\EOT\EM\SUB# A unique identifier for this task\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\SI\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\SI\n\
    \\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\SI\ETB\CAN\n\
    \\f\n\
    \\EOT\EOT\NUL\b\NUL\DC2\EOT\DLE\EOT\NAK\ENQ\n\
    \\f\n\
    \\ENQ\EOT\NUL\b\NUL\SOH\DC2\ETX\DLE\n\
    \\DC1\n\
    \(\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\DC2\b\CAN\SUB\ESC Start activity execution.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX\DC2\b\r\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\DC2\SO\DC3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\DC2\SYN\ETB\n\
    \4\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX\DC4\b\SUB\SUB' Attempt to cancel activity execution.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX\DC4\b\SO\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX\DC4\SI\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX\DC4\CAN\EM\n\
    \)\n\
    \\STX\EOT\SOH\DC2\EOT\EM\NULA\SOH\SUB\GS Begin executing an activity\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\EM\b\r\n\
    \2\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\ESC\EOT\"\SUB% The namespace the workflow lives in\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\ESC\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\ESC\v\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\ESC !\n\
    \>\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\GS\EOT\GS\SUB1 The workflow's type name or function identifier\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX\GS\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\GS\v\CAN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\GS\ESC\FS\n\
    \C\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX\US\EOTD\SUB6 The workflow execution which requested this activity\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ACK\DC2\ETX\US\EOT,\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX\US-?\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX\USBC\n\
    \ \n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX!\EOT\ESC\SUB\DC3 The activity's ID\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ENQ\DC2\ETX!\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX!\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX!\EM\SUB\n\
    \>\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\ETX#\EOT\GS\SUB1 The activity's type name or function identifier\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ENQ\DC2\ETX#\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\ETX#\v\CAN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\ETX#\ESC\FS\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\ENQ\DC2\ETX$\EOTB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ACK\DC2\ETX$\EOT/\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\SOH\DC2\ETX$0=\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ETX\DC2\ETX$@A\n\
    \(\n\
    \\EOT\EOT\SOH\STX\ACK\DC2\ETX&\EOT6\SUB\ESC Arguments to the activity\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\EOT\DC2\ETX&\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ACK\DC2\ETX&\r+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\SOH\DC2\ETX&,1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ETX\DC2\ETX&45\n\
    \^\n\
    \\EOT\EOT\SOH\STX\a\DC2\ETX(\EOTB\SUBQ The last details that were recorded by a heartbeat when this task was generated\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\a\EOT\DC2\ETX(\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\a\ACK\DC2\ETX(\r+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\a\SOH\DC2\ETX(,=\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\a\ETX\DC2\ETX(@A\n\
    \2\n\
    \\EOT\EOT\SOH\STX\b\DC2\ETX*\EOT1\SUB% When the task was *first* scheduled\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\b\ACK\DC2\ETX*\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\b\SOH\DC2\ETX*\RS,\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\b\ETX\DC2\ETX*/0\n\
    \B\n\
    \\EOT\EOT\SOH\STX\t\DC2\ETX,\EOTB\SUB5 When this current attempt at the task was scheduled\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\t\ACK\DC2\ETX,\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\t\SOH\DC2\ETX,\RS<\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\t\ETX\DC2\ETX,?A\n\
    \_\n\
    \\EOT\EOT\SOH\STX\n\
    \\DC2\ETX.\EOT0\SUBR When this attempt was started, which is to say when core received it by polling.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\n\
    \\ACK\DC2\ETX.\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\n\
    \\SOH\DC2\ETX.\RS*\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\n\
    \\ETX\DC2\ETX.-/\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\v\DC2\ETX/\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\v\ENQ\DC2\ETX/\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\v\SOH\DC2\ETX/\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\v\ETX\DC2\ETX/\NAK\ETB\n\
    \A\n\
    \\EOT\EOT\SOH\STX\f\DC2\ETX2\EOT<\SUB4 Timeout from the first schedule time to completion\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\f\ACK\DC2\ETX2\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\f\SOH\DC2\ETX2\GS6\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\f\ETX\DC2\ETX29;\n\
    \G\n\
    \\EOT\EOT\SOH\STX\r\DC2\ETX4\EOT9\SUB: Timeout from starting an attempt to reporting its result\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\r\ACK\DC2\ETX4\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\r\SOH\DC2\ETX4\GS3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\r\ETX\DC2\ETX468\n\
    \G\n\
    \\EOT\EOT\SOH\STX\SO\DC2\ETX6\EOT4\SUB: If set a heartbeat must be reported within this interval\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SO\ACK\DC2\ETX6\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SO\SOH\DC2\ETX6\GS.\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SO\ETX\DC2\ETX613\n\
    \\134\STX\n\
    \\EOT\EOT\SOH\STX\SI\DC2\ETX:\EOT9\SUB\248\SOH This is an actual retry policy the service uses. It can be different from the one provided\n\
    \ (or not) during activity scheduling as the service can override the provided one in case its\n\
    \ values are not specified or exceed configured system limits.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SI\ACK\DC2\ETX:\EOT&\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SI\SOH\DC2\ETX:'3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SI\ETX\DC2\ETX:68\n\
    \j\n\
    \\EOT\EOT\SOH\STX\DLE\DC2\ETX<\EOT2\SUB] Priority of this activity. Local activities will always have this field set to the default.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\DLE\ACK\DC2\ETX<\EOT#\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\DLE\SOH\DC2\ETX<$,\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\DLE\ETX\DC2\ETX</1\n\
    \s\n\
    \\EOT\EOT\SOH\STX\DC1\DC2\ETX@\EOT\ETB\SUBf Set to true if this is a local activity. Note that heartbeating does not apply to local\n\
    \ activities.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\DC1\ENQ\DC2\ETX@\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\DC1\SOH\DC2\ETX@\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\DC1\ETX\DC2\ETX@\DC4\SYN\n\
    \2\n\
    \\STX\EOT\STX\DC2\EOTD\NULI\SOH\SUB& Attempt to cancel a running activity\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETXD\b\SO\n\
    \*\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETXF\EOT$\SUB\GS Primary cancellation reason\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETXF\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETXF\EM\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETXF\"#\n\
    \P\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETXH\EOT,\SUBC Activity cancellation details, surfaces all cancellation reasons.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETXH\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETXH '\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETXH*+\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOTK\NULR\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXK\b#\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXL\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETXL\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXL\t\NAK\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXL\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXM\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETXM\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXM\t\NAK\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXM\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETXN\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ENQ\DC2\ETXN\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETXN\t\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETXN\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\ETX\DC2\ETXO\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ENQ\DC2\ETXO\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\SOH\DC2\ETXO\t\NAK\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ETX\DC2\ETXO\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\EOT\DC2\ETXP\EOT \n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ENQ\DC2\ETXP\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\SOH\DC2\ETXP\t\ESC\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ETX\DC2\ETXP\RS\US\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\ENQ\DC2\ETXQ\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\ENQ\DC2\ETXQ\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\SOH\DC2\ETXQ\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\ETX\DC2\ETXQ\DC4\NAK\n\
    \\n\
    \\n\
    \\STX\ENQ\NUL\DC2\EOTT\NULa\SOH\n\
    \\n\
    \\n\
    \\ETX\ENQ\NUL\SOH\DC2\ETXT\ENQ\EM\n\
    \[\n\
    \\EOT\ENQ\NUL\STX\NUL\DC2\ETXV\EOT\DC2\SUBN The activity no longer exists according to server (may be already completed)\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\SOH\DC2\ETXV\EOT\r\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\STX\DC2\ETXV\DLE\DC1\n\
    \0\n\
    \\EOT\ENQ\NUL\STX\SOH\DC2\ETXX\EOT\DC2\SUB# Activity was explicitly cancelled\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\SOH\DC2\ETXX\EOT\r\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\STX\DC2\ETXX\DLE\DC1\n\
    \!\n\
    \\EOT\ENQ\NUL\STX\STX\DC2\ETXZ\EOT\DC2\SUB\DC4 Activity timed out\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\STX\SOH\DC2\ETXZ\EOT\r\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\STX\STX\DC2\ETXZ\DLE\DC1\n\
    \I\n\
    \\EOT\ENQ\NUL\STX\ETX\DC2\ETX\\\EOT\CAN\SUB< Core is shutting down and the graceful timeout has elapsed\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\ETX\SOH\DC2\ETX\\\EOT\DC3\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\ETX\STX\DC2\ETX\\\SYN\ETB\n\
    \\"\n\
    \\EOT\ENQ\NUL\STX\EOT\DC2\ETX^\EOT\SI\SUB\NAK Activity was paused\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\EOT\SOH\DC2\ETX^\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\EOT\STX\DC2\ETX^\r\SO\n\
    \!\n\
    \\EOT\ENQ\NUL\STX\ENQ\DC2\ETX`\EOT\SO\SUB\DC4 Activity was reset\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\ENQ\SOH\DC2\ETX`\EOT\t\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\ENQ\STX\DC2\ETX`\f\rb\ACKproto3"
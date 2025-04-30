{- This file was auto-generated from temporal/sdk/core/nexus/nexus.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Sdk.Core.Nexus.Nexus (
        CancelNexusTask(), NexusOperationResult(),
        NexusOperationResult'Status(..), _NexusOperationResult'Completed,
        _NexusOperationResult'Failed, _NexusOperationResult'Cancelled,
        _NexusOperationResult'TimedOut, NexusTask(), NexusTask'Variant(..),
        _NexusTask'Task, _NexusTask'CancelTask, NexusTaskCancelReason(..),
        NexusTaskCancelReason(), NexusTaskCancelReason'UnrecognizedValue,
        NexusTaskCompletion(), NexusTaskCompletion'Status(..),
        _NexusTaskCompletion'Completed, _NexusTaskCompletion'Error,
        _NexusTaskCompletion'AckCancel
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
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Api.Nexus.V1.Message
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse
import qualified Proto.Temporal.Sdk.Core.Common.Common
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.taskToken' @:: Lens' CancelNexusTask Data.ByteString.ByteString@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.reason' @:: Lens' CancelNexusTask NexusTaskCancelReason@ -}
data CancelNexusTask
  = CancelNexusTask'_constructor {_CancelNexusTask'taskToken :: !Data.ByteString.ByteString,
                                  _CancelNexusTask'reason :: !NexusTaskCancelReason,
                                  _CancelNexusTask'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CancelNexusTask where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CancelNexusTask "taskToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelNexusTask'taskToken
           (\ x__ y__ -> x__ {_CancelNexusTask'taskToken = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CancelNexusTask "reason" NexusTaskCancelReason where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelNexusTask'reason
           (\ x__ y__ -> x__ {_CancelNexusTask'reason = y__}))
        Prelude.id
instance Data.ProtoLens.Message CancelNexusTask where
  messageName _ = Data.Text.pack "coresdk.nexus.CancelNexusTask"
  packedMessageDescriptor _
    = "\n\
      \\SICancelNexusTask\DC2\GS\n\
      \\n\
      \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC2<\n\
      \\ACKreason\CAN\STX \SOH(\SO2$.coresdk.nexus.NexusTaskCancelReasonR\ACKreason"
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
              Data.ProtoLens.FieldDescriptor CancelNexusTask
        reason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor NexusTaskCancelReason)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"reason")) ::
              Data.ProtoLens.FieldDescriptor CancelNexusTask
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskToken__field_descriptor),
           (Data.ProtoLens.Tag 2, reason__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CancelNexusTask'_unknownFields
        (\ x__ y__ -> x__ {_CancelNexusTask'_unknownFields = y__})
  defMessage
    = CancelNexusTask'_constructor
        {_CancelNexusTask'taskToken = Data.ProtoLens.fieldDefault,
         _CancelNexusTask'reason = Data.ProtoLens.fieldDefault,
         _CancelNexusTask'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CancelNexusTask
          -> Data.ProtoLens.Encoding.Bytes.Parser CancelNexusTask
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
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "reason"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"reason") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CancelNexusTask"
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
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"reason") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                            Prelude.fromEnum _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData CancelNexusTask where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CancelNexusTask'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CancelNexusTask'taskToken x__)
                (Control.DeepSeq.deepseq (_CancelNexusTask'reason x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'status' @:: Lens' NexusOperationResult (Prelude.Maybe NexusOperationResult'Status)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'completed' @:: Lens' NexusOperationResult (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.completed' @:: Lens' NexusOperationResult Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'failed' @:: Lens' NexusOperationResult (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.failed' @:: Lens' NexusOperationResult Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'cancelled' @:: Lens' NexusOperationResult (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.cancelled' @:: Lens' NexusOperationResult Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'timedOut' @:: Lens' NexusOperationResult (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.timedOut' @:: Lens' NexusOperationResult Proto.Temporal.Api.Failure.V1.Message.Failure@ -}
data NexusOperationResult
  = NexusOperationResult'_constructor {_NexusOperationResult'status :: !(Prelude.Maybe NexusOperationResult'Status),
                                       _NexusOperationResult'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NexusOperationResult where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data NexusOperationResult'Status
  = NexusOperationResult'Completed !Proto.Temporal.Api.Common.V1.Message.Payload |
    NexusOperationResult'Failed !Proto.Temporal.Api.Failure.V1.Message.Failure |
    NexusOperationResult'Cancelled !Proto.Temporal.Api.Failure.V1.Message.Failure |
    NexusOperationResult'TimedOut !Proto.Temporal.Api.Failure.V1.Message.Failure
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField NexusOperationResult "maybe'status" (Prelude.Maybe NexusOperationResult'Status) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusOperationResult "maybe'completed" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusOperationResult'Completed x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusOperationResult'Completed y__))
instance Data.ProtoLens.Field.HasField NexusOperationResult "completed" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusOperationResult'Completed x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusOperationResult'Completed y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField NexusOperationResult "maybe'failed" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusOperationResult'Failed x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusOperationResult'Failed y__))
instance Data.ProtoLens.Field.HasField NexusOperationResult "failed" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusOperationResult'Failed x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusOperationResult'Failed y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField NexusOperationResult "maybe'cancelled" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusOperationResult'Cancelled x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusOperationResult'Cancelled y__))
instance Data.ProtoLens.Field.HasField NexusOperationResult "cancelled" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusOperationResult'Cancelled x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusOperationResult'Cancelled y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField NexusOperationResult "maybe'timedOut" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusOperationResult'TimedOut x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusOperationResult'TimedOut y__))
instance Data.ProtoLens.Field.HasField NexusOperationResult "timedOut" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationResult'status
           (\ x__ y__ -> x__ {_NexusOperationResult'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusOperationResult'TimedOut x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusOperationResult'TimedOut y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message NexusOperationResult where
  messageName _ = Data.Text.pack "coresdk.nexus.NexusOperationResult"
  packedMessageDescriptor _
    = "\n\
      \\DC4NexusOperationResult\DC2?\n\
      \\tcompleted\CAN\SOH \SOH(\v2\US.temporal.api.common.v1.PayloadH\NULR\tcompleted\DC2:\n\
      \\ACKfailed\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\ACKfailed\DC2@\n\
      \\tcancelled\CAN\ETX \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\tcancelled\DC2?\n\
      \\ttimed_out\CAN\EOT \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\btimedOutB\b\n\
      \\ACKstatus"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        completed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "completed"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'completed")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationResult
        failed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failed"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failed")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationResult
        cancelled__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancelled"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancelled")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationResult
        timedOut__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "timed_out"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'timedOut")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationResult
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, completed__field_descriptor),
           (Data.ProtoLens.Tag 2, failed__field_descriptor),
           (Data.ProtoLens.Tag 3, cancelled__field_descriptor),
           (Data.ProtoLens.Tag 4, timedOut__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NexusOperationResult'_unknownFields
        (\ x__ y__ -> x__ {_NexusOperationResult'_unknownFields = y__})
  defMessage
    = NexusOperationResult'_constructor
        {_NexusOperationResult'status = Prelude.Nothing,
         _NexusOperationResult'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NexusOperationResult
          -> Data.ProtoLens.Encoding.Bytes.Parser NexusOperationResult
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
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "completed"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"completed") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "failed"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failed") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancelled"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"cancelled") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "timed_out"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"timedOut") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NexusOperationResult"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'status") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (NexusOperationResult'Completed v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (NexusOperationResult'Failed v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (NexusOperationResult'Cancelled v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (NexusOperationResult'TimedOut v))
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
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData NexusOperationResult where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NexusOperationResult'_unknownFields x__)
             (Control.DeepSeq.deepseq (_NexusOperationResult'status x__) ())
instance Control.DeepSeq.NFData NexusOperationResult'Status where
  rnf (NexusOperationResult'Completed x__) = Control.DeepSeq.rnf x__
  rnf (NexusOperationResult'Failed x__) = Control.DeepSeq.rnf x__
  rnf (NexusOperationResult'Cancelled x__) = Control.DeepSeq.rnf x__
  rnf (NexusOperationResult'TimedOut x__) = Control.DeepSeq.rnf x__
_NexusOperationResult'Completed ::
  Data.ProtoLens.Prism.Prism' NexusOperationResult'Status Proto.Temporal.Api.Common.V1.Message.Payload
_NexusOperationResult'Completed
  = Data.ProtoLens.Prism.prism'
      NexusOperationResult'Completed
      (\ p__
         -> case p__ of
              (NexusOperationResult'Completed p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_NexusOperationResult'Failed ::
  Data.ProtoLens.Prism.Prism' NexusOperationResult'Status Proto.Temporal.Api.Failure.V1.Message.Failure
_NexusOperationResult'Failed
  = Data.ProtoLens.Prism.prism'
      NexusOperationResult'Failed
      (\ p__
         -> case p__ of
              (NexusOperationResult'Failed p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_NexusOperationResult'Cancelled ::
  Data.ProtoLens.Prism.Prism' NexusOperationResult'Status Proto.Temporal.Api.Failure.V1.Message.Failure
_NexusOperationResult'Cancelled
  = Data.ProtoLens.Prism.prism'
      NexusOperationResult'Cancelled
      (\ p__
         -> case p__ of
              (NexusOperationResult'Cancelled p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_NexusOperationResult'TimedOut ::
  Data.ProtoLens.Prism.Prism' NexusOperationResult'Status Proto.Temporal.Api.Failure.V1.Message.Failure
_NexusOperationResult'TimedOut
  = Data.ProtoLens.Prism.prism'
      NexusOperationResult'TimedOut
      (\ p__
         -> case p__ of
              (NexusOperationResult'TimedOut p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'variant' @:: Lens' NexusTask (Prelude.Maybe NexusTask'Variant)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'task' @:: Lens' NexusTask (Prelude.Maybe Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.task' @:: Lens' NexusTask Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'cancelTask' @:: Lens' NexusTask (Prelude.Maybe CancelNexusTask)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.cancelTask' @:: Lens' NexusTask CancelNexusTask@ -}
data NexusTask
  = NexusTask'_constructor {_NexusTask'variant :: !(Prelude.Maybe NexusTask'Variant),
                            _NexusTask'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NexusTask where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data NexusTask'Variant
  = NexusTask'Task !Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse |
    NexusTask'CancelTask !CancelNexusTask
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField NexusTask "maybe'variant" (Prelude.Maybe NexusTask'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTask'variant (\ x__ y__ -> x__ {_NexusTask'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusTask "maybe'task" (Prelude.Maybe Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTask'variant (\ x__ y__ -> x__ {_NexusTask'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusTask'Task x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusTask'Task y__))
instance Data.ProtoLens.Field.HasField NexusTask "task" Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTask'variant (\ x__ y__ -> x__ {_NexusTask'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusTask'Task x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusTask'Task y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField NexusTask "maybe'cancelTask" (Prelude.Maybe CancelNexusTask) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTask'variant (\ x__ y__ -> x__ {_NexusTask'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusTask'CancelTask x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusTask'CancelTask y__))
instance Data.ProtoLens.Field.HasField NexusTask "cancelTask" CancelNexusTask where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTask'variant (\ x__ y__ -> x__ {_NexusTask'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusTask'CancelTask x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusTask'CancelTask y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message NexusTask where
  messageName _ = Data.Text.pack "coresdk.nexus.NexusTask"
  packedMessageDescriptor _
    = "\n\
      \\tNexusTask\DC2Q\n\
      \\EOTtask\CAN\SOH \SOH(\v2;.temporal.api.workflowservice.v1.PollNexusTaskQueueResponseH\NULR\EOTtask\DC2A\n\
      \\vcancel_task\CAN\STX \SOH(\v2\RS.coresdk.nexus.CancelNexusTaskH\NULR\n\
      \cancelTaskB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        task__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'task")) ::
              Data.ProtoLens.FieldDescriptor NexusTask
        cancelTask__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel_task"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CancelNexusTask)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancelTask")) ::
              Data.ProtoLens.FieldDescriptor NexusTask
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, task__field_descriptor),
           (Data.ProtoLens.Tag 2, cancelTask__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NexusTask'_unknownFields
        (\ x__ y__ -> x__ {_NexusTask'_unknownFields = y__})
  defMessage
    = NexusTask'_constructor
        {_NexusTask'variant = Prelude.Nothing,
         _NexusTask'_unknownFields = []}
  parseMessage
    = let
        loop :: NexusTask -> Data.ProtoLens.Encoding.Bytes.Parser NexusTask
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
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "task"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"task") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancel_task"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"cancelTask") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NexusTask"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (NexusTask'Task v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (NexusTask'CancelTask v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData NexusTask where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NexusTask'_unknownFields x__)
             (Control.DeepSeq.deepseq (_NexusTask'variant x__) ())
instance Control.DeepSeq.NFData NexusTask'Variant where
  rnf (NexusTask'Task x__) = Control.DeepSeq.rnf x__
  rnf (NexusTask'CancelTask x__) = Control.DeepSeq.rnf x__
_NexusTask'Task ::
  Data.ProtoLens.Prism.Prism' NexusTask'Variant Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse
_NexusTask'Task
  = Data.ProtoLens.Prism.prism'
      NexusTask'Task
      (\ p__
         -> case p__ of
              (NexusTask'Task p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_NexusTask'CancelTask ::
  Data.ProtoLens.Prism.Prism' NexusTask'Variant CancelNexusTask
_NexusTask'CancelTask
  = Data.ProtoLens.Prism.prism'
      NexusTask'CancelTask
      (\ p__
         -> case p__ of
              (NexusTask'CancelTask p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
newtype NexusTaskCancelReason'UnrecognizedValue
  = NexusTaskCancelReason'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data NexusTaskCancelReason
  = TIMED_OUT |
    WORKER_SHUTDOWN |
    NexusTaskCancelReason'Unrecognized !NexusTaskCancelReason'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum NexusTaskCancelReason where
  maybeToEnum 0 = Prelude.Just TIMED_OUT
  maybeToEnum 1 = Prelude.Just WORKER_SHUTDOWN
  maybeToEnum k
    = Prelude.Just
        (NexusTaskCancelReason'Unrecognized
           (NexusTaskCancelReason'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum TIMED_OUT = "TIMED_OUT"
  showEnum WORKER_SHUTDOWN = "WORKER_SHUTDOWN"
  showEnum
    (NexusTaskCancelReason'Unrecognized (NexusTaskCancelReason'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "TIMED_OUT" = Prelude.Just TIMED_OUT
    | (Prelude.==) k "WORKER_SHUTDOWN" = Prelude.Just WORKER_SHUTDOWN
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded NexusTaskCancelReason where
  minBound = TIMED_OUT
  maxBound = WORKER_SHUTDOWN
instance Prelude.Enum NexusTaskCancelReason where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum NexusTaskCancelReason: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum TIMED_OUT = 0
  fromEnum WORKER_SHUTDOWN = 1
  fromEnum
    (NexusTaskCancelReason'Unrecognized (NexusTaskCancelReason'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ WORKER_SHUTDOWN
    = Prelude.error
        "NexusTaskCancelReason.succ: bad argument WORKER_SHUTDOWN. This value would be out of bounds."
  succ TIMED_OUT = WORKER_SHUTDOWN
  succ (NexusTaskCancelReason'Unrecognized _)
    = Prelude.error
        "NexusTaskCancelReason.succ: bad argument: unrecognized value"
  pred TIMED_OUT
    = Prelude.error
        "NexusTaskCancelReason.pred: bad argument TIMED_OUT. This value would be out of bounds."
  pred WORKER_SHUTDOWN = TIMED_OUT
  pred (NexusTaskCancelReason'Unrecognized _)
    = Prelude.error
        "NexusTaskCancelReason.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault NexusTaskCancelReason where
  fieldDefault = TIMED_OUT
instance Control.DeepSeq.NFData NexusTaskCancelReason where
  rnf x__ = Prelude.seq x__ ()
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.taskToken' @:: Lens' NexusTaskCompletion Data.ByteString.ByteString@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'status' @:: Lens' NexusTaskCompletion (Prelude.Maybe NexusTaskCompletion'Status)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'completed' @:: Lens' NexusTaskCompletion (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Response)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.completed' @:: Lens' NexusTaskCompletion Proto.Temporal.Api.Nexus.V1.Message.Response@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'error' @:: Lens' NexusTaskCompletion (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.HandlerError)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.error' @:: Lens' NexusTaskCompletion Proto.Temporal.Api.Nexus.V1.Message.HandlerError@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.maybe'ackCancel' @:: Lens' NexusTaskCompletion (Prelude.Maybe Prelude.Bool)@
         * 'Proto.Temporal.Sdk.Core.Nexus.Nexus_Fields.ackCancel' @:: Lens' NexusTaskCompletion Prelude.Bool@ -}
data NexusTaskCompletion
  = NexusTaskCompletion'_constructor {_NexusTaskCompletion'taskToken :: !Data.ByteString.ByteString,
                                      _NexusTaskCompletion'status :: !(Prelude.Maybe NexusTaskCompletion'Status),
                                      _NexusTaskCompletion'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NexusTaskCompletion where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data NexusTaskCompletion'Status
  = NexusTaskCompletion'Completed !Proto.Temporal.Api.Nexus.V1.Message.Response |
    NexusTaskCompletion'Error !Proto.Temporal.Api.Nexus.V1.Message.HandlerError |
    NexusTaskCompletion'AckCancel !Prelude.Bool
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "taskToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'taskToken
           (\ x__ y__ -> x__ {_NexusTaskCompletion'taskToken = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "maybe'status" (Prelude.Maybe NexusTaskCompletion'Status) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'status
           (\ x__ y__ -> x__ {_NexusTaskCompletion'status = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "maybe'completed" (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Response) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'status
           (\ x__ y__ -> x__ {_NexusTaskCompletion'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusTaskCompletion'Completed x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusTaskCompletion'Completed y__))
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "completed" Proto.Temporal.Api.Nexus.V1.Message.Response where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'status
           (\ x__ y__ -> x__ {_NexusTaskCompletion'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusTaskCompletion'Completed x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusTaskCompletion'Completed y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "maybe'error" (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.HandlerError) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'status
           (\ x__ y__ -> x__ {_NexusTaskCompletion'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusTaskCompletion'Error x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusTaskCompletion'Error y__))
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "error" Proto.Temporal.Api.Nexus.V1.Message.HandlerError where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'status
           (\ x__ y__ -> x__ {_NexusTaskCompletion'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusTaskCompletion'Error x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusTaskCompletion'Error y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "maybe'ackCancel" (Prelude.Maybe Prelude.Bool) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'status
           (\ x__ y__ -> x__ {_NexusTaskCompletion'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (NexusTaskCompletion'AckCancel x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap NexusTaskCompletion'AckCancel y__))
instance Data.ProtoLens.Field.HasField NexusTaskCompletion "ackCancel" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusTaskCompletion'status
           (\ x__ y__ -> x__ {_NexusTaskCompletion'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (NexusTaskCompletion'AckCancel x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap NexusTaskCompletion'AckCancel y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Message NexusTaskCompletion where
  messageName _ = Data.Text.pack "coresdk.nexus.NexusTaskCompletion"
  packedMessageDescriptor _
    = "\n\
      \\DC3NexusTaskCompletion\DC2\GS\n\
      \\n\
      \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC2?\n\
      \\tcompleted\CAN\STX \SOH(\v2\US.temporal.api.nexus.v1.ResponseH\NULR\tcompleted\DC2;\n\
      \\ENQerror\CAN\ETX \SOH(\v2#.temporal.api.nexus.v1.HandlerErrorH\NULR\ENQerror\DC2\US\n\
      \\n\
      \ack_cancel\CAN\EOT \SOH(\bH\NULR\tackCancelB\b\n\
      \\ACKstatus"
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
              Data.ProtoLens.FieldDescriptor NexusTaskCompletion
        completed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "completed"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.Response)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'completed")) ::
              Data.ProtoLens.FieldDescriptor NexusTaskCompletion
        error__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "error"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.HandlerError)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'error")) ::
              Data.ProtoLens.FieldDescriptor NexusTaskCompletion
        ackCancel__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "ack_cancel"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'ackCancel")) ::
              Data.ProtoLens.FieldDescriptor NexusTaskCompletion
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskToken__field_descriptor),
           (Data.ProtoLens.Tag 2, completed__field_descriptor),
           (Data.ProtoLens.Tag 3, error__field_descriptor),
           (Data.ProtoLens.Tag 4, ackCancel__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NexusTaskCompletion'_unknownFields
        (\ x__ y__ -> x__ {_NexusTaskCompletion'_unknownFields = y__})
  defMessage
    = NexusTaskCompletion'_constructor
        {_NexusTaskCompletion'taskToken = Data.ProtoLens.fieldDefault,
         _NexusTaskCompletion'status = Prelude.Nothing,
         _NexusTaskCompletion'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NexusTaskCompletion
          -> Data.ProtoLens.Encoding.Bytes.Parser NexusTaskCompletion
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
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "completed"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"completed") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "error"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"error") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "ack_cancel"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"ackCancel") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NexusTaskCompletion"
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'status") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (NexusTaskCompletion'Completed v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (NexusTaskCompletion'Error v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (NexusTaskCompletion'AckCancel v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                          ((Prelude..)
                             Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                             v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData NexusTaskCompletion where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NexusTaskCompletion'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NexusTaskCompletion'taskToken x__)
                (Control.DeepSeq.deepseq (_NexusTaskCompletion'status x__) ()))
instance Control.DeepSeq.NFData NexusTaskCompletion'Status where
  rnf (NexusTaskCompletion'Completed x__) = Control.DeepSeq.rnf x__
  rnf (NexusTaskCompletion'Error x__) = Control.DeepSeq.rnf x__
  rnf (NexusTaskCompletion'AckCancel x__) = Control.DeepSeq.rnf x__
_NexusTaskCompletion'Completed ::
  Data.ProtoLens.Prism.Prism' NexusTaskCompletion'Status Proto.Temporal.Api.Nexus.V1.Message.Response
_NexusTaskCompletion'Completed
  = Data.ProtoLens.Prism.prism'
      NexusTaskCompletion'Completed
      (\ p__
         -> case p__ of
              (NexusTaskCompletion'Completed p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_NexusTaskCompletion'Error ::
  Data.ProtoLens.Prism.Prism' NexusTaskCompletion'Status Proto.Temporal.Api.Nexus.V1.Message.HandlerError
_NexusTaskCompletion'Error
  = Data.ProtoLens.Prism.prism'
      NexusTaskCompletion'Error
      (\ p__
         -> case p__ of
              (NexusTaskCompletion'Error p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_NexusTaskCompletion'AckCancel ::
  Data.ProtoLens.Prism.Prism' NexusTaskCompletion'Status Prelude.Bool
_NexusTaskCompletion'AckCancel
  = Data.ProtoLens.Prism.prism'
      NexusTaskCompletion'AckCancel
      (\ p__
         -> case p__ of
              (NexusTaskCompletion'AckCancel p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \#temporal/sdk/core/nexus/nexus.proto\DC2\rcoresdk.nexus\SUB$temporal/api/common/v1/message.proto\SUB%temporal/api/failure/v1/message.proto\SUB#temporal/api/nexus/v1/message.proto\SUB6temporal/api/workflowservice/v1/request_response.proto\SUB%temporal/sdk/core/common/common.proto\"\160\STX\n\
    \\DC4NexusOperationResult\DC2?\n\
    \\tcompleted\CAN\SOH \SOH(\v2\US.temporal.api.common.v1.PayloadH\NULR\tcompleted\DC2:\n\
    \\ACKfailed\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\ACKfailed\DC2@\n\
    \\tcancelled\CAN\ETX \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\tcancelled\DC2?\n\
    \\ttimed_out\CAN\EOT \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\btimedOutB\b\n\
    \\ACKstatus\"\221\SOH\n\
    \\DC3NexusTaskCompletion\DC2\GS\n\
    \\n\
    \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC2?\n\
    \\tcompleted\CAN\STX \SOH(\v2\US.temporal.api.nexus.v1.ResponseH\NULR\tcompleted\DC2;\n\
    \\ENQerror\CAN\ETX \SOH(\v2#.temporal.api.nexus.v1.HandlerErrorH\NULR\ENQerror\DC2\US\n\
    \\n\
    \ack_cancel\CAN\EOT \SOH(\bH\NULR\tackCancelB\b\n\
    \\ACKstatus\"\172\SOH\n\
    \\tNexusTask\DC2Q\n\
    \\EOTtask\CAN\SOH \SOH(\v2;.temporal.api.workflowservice.v1.PollNexusTaskQueueResponseH\NULR\EOTtask\DC2A\n\
    \\vcancel_task\CAN\STX \SOH(\v2\RS.coresdk.nexus.CancelNexusTaskH\NULR\n\
    \cancelTaskB\t\n\
    \\avariant\"n\n\
    \\SICancelNexusTask\DC2\GS\n\
    \\n\
    \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC2<\n\
    \\ACKreason\CAN\STX \SOH(\SO2$.coresdk.nexus.NexusTaskCancelReasonR\ACKreason*;\n\
    \\NAKNexusTaskCancelReason\DC2\r\n\
    \\tTIMED_OUT\DLE\NUL\DC2\DC3\n\
    \\SIWORKER_SHUTDOWN\DLE\SOHB+\234\STX(Temporalio::Internal::Bridge::Api::NexusJ\254\DC3\n\
    \\ACK\DC2\EOT\NUL\NULF\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL\SYN\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ETX\NULA\n\
    \\t\n\
    \\STX\b-\DC2\ETX\ETX\NULA\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\ENQ\NUL.\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\ACK\NUL/\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX\a\NUL-\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX\b\NUL@\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX\t\NUL/\n\
    \7\n\
    \\STX\EOT\NUL\DC2\EOT\f\NUL\DC3\SOH\SUB+ Used by core to resolve nexus operations.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\f\b\FS\n\
    \\f\n\
    \\EOT\EOT\NUL\b\NUL\DC2\EOT\r\EOT\DC2\ENQ\n\
    \\f\n\
    \\ENQ\EOT\NUL\b\NUL\SOH\DC2\ETX\r\n\
    \\DLE\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\SO\b5\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX\SO\b&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\SO'0\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\SO34\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\SI\b3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX\SI\b'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\SI(.\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\SI12\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX\DLE\b6\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX\DLE\b'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX\DLE(1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX\DLE45\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX\DC1\b6\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ACK\DC2\ETX\DC1\b'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX\DC1(1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX\DC145\n\
    \(\n\
    \\STX\EOT\SOH\DC2\EOT\SYN\NUL%\SOH\SUB\FS A response to a Nexus task\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\SYN\b\ESC\n\
    \P\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\CAN\EOT\EM\SUBC The unique identifier for this task provided in the poll response\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\CAN\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\CAN\n\
    \\DC4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\CAN\ETB\CAN\n\
    \\f\n\
    \\EOT\EOT\SOH\b\NUL\DC2\EOT\EM\EOT$\ENQ\n\
    \\f\n\
    \\ENQ\EOT\SOH\b\NUL\SOH\DC2\ETX\EM\n\
    \\DLE\n\
    \\135\SOH\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\FS\b5\SUBz The handler completed (successfully or not). Note that the response kind must match the\n\
    \ request kind (start or cancel).\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX\FS\b&\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\FS'0\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\FS34\n\
    \J\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX\RS\b5\SUB= The handler could not complete the request for some reason.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ACK\DC2\ETX\RS\b*\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX\RS+0\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX\RS34\n\
    \\163\STX\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX#\b\FS\SUB\149\STX The lang SDK acknowledges that it is responding to a `CancelNexusTask` and thus the\n\
    \ response is irrelevant. This is not the only way to respond to a cancel, the other\n\
    \ variants can still be used, but this variant should be used when the handler was aborted\n\
    \ by cancellation.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ENQ\DC2\ETX#\b\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX#\r\ETB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX#\SUB\ESC\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT'\NUL8\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX'\b\DC1\n\
    \\f\n\
    \\EOT\EOT\STX\b\NUL\DC2\EOT(\EOT7\ENQ\n\
    \\f\n\
    \\ENQ\EOT\STX\b\NUL\SOH\DC2\ETX(\n\
    \\DC1\n\
    \'\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX*\bL\SUB\SUB A nexus task from server\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX*\bB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX*CG\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX*JK\n\
    \\178\ENQ\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX6\b(\SUB\164\ENQ A request by Core to notify an in-progress operation handler that it should cancel. This\n\
    \ is distinct from a `CancelOperationRequest` from the server, which results from the user\n\
    \ requesting the cancellation of an operation. Handling this variant should result in\n\
    \ something like cancelling a cancellation token given to the user's operation handler.\n\
    \\n\
    \ These do not count as a separate task for the purposes of completing all issued tasks,\n\
    \ but rather count as a sort of modification to the already-issued task which is being\n\
    \ cancelled.\n\
    \\n\
    \ EX: Core knows the nexus operation has timed out, and it does not make sense for the\n\
    \ user's operation handler to continue doing work.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETX6\b\ETB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX6\CAN#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX6&'\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT:\NUL?\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX:\b\ETB\n\
    \A\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX<\EOT\EM\SUB4 The task token from the PollNexusTaskQueueResponse\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETX<\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX<\n\
    \\DC4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX<\ETB\CAN\n\
    \D\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETX>\EOT%\SUB7 Why Core is asking for this operation to be cancelled\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ACK\DC2\ETX>\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETX>\SUB \n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETX>#$\n\
    \\n\
    \\n\
    \\STX\ENQ\NUL\DC2\EOTA\NULF\SOH\n\
    \\n\
    \\n\
    \\ETX\ENQ\NUL\SOH\DC2\ETXA\ENQ\SUB\n\
    \8\n\
    \\EOT\ENQ\NUL\STX\NUL\DC2\ETXC\EOT\DC2\SUB+ The nexus task is known to have timed out\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\SOH\DC2\ETXC\EOT\r\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\STX\DC2\ETXC\DLE\DC1\n\
    \*\n\
    \\EOT\ENQ\NUL\STX\SOH\DC2\ETXE\EOT\CAN\SUB\GS The worker is shutting down\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\SOH\DC2\ETXE\EOT\DC3\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\STX\DC2\ETXE\SYN\ETBb\ACKproto3"
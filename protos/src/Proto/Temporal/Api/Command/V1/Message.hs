{- This file was auto-generated from temporal/api/command/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Command.V1.Message (
        CancelTimerCommandAttributes(),
        CancelWorkflowExecutionCommandAttributes(), Command(),
        Command'Attributes(..),
        _Command'ScheduleActivityTaskCommandAttributes,
        _Command'StartTimerCommandAttributes,
        _Command'CompleteWorkflowExecutionCommandAttributes,
        _Command'FailWorkflowExecutionCommandAttributes,
        _Command'RequestCancelActivityTaskCommandAttributes,
        _Command'CancelTimerCommandAttributes,
        _Command'CancelWorkflowExecutionCommandAttributes,
        _Command'RequestCancelExternalWorkflowExecutionCommandAttributes,
        _Command'RecordMarkerCommandAttributes,
        _Command'ContinueAsNewWorkflowExecutionCommandAttributes,
        _Command'StartChildWorkflowExecutionCommandAttributes,
        _Command'SignalExternalWorkflowExecutionCommandAttributes,
        _Command'UpsertWorkflowSearchAttributesCommandAttributes,
        _Command'ProtocolMessageCommandAttributes,
        _Command'ModifyWorkflowPropertiesCommandAttributes,
        CompleteWorkflowExecutionCommandAttributes(),
        ContinueAsNewWorkflowExecutionCommandAttributes(),
        FailWorkflowExecutionCommandAttributes(),
        ModifyWorkflowPropertiesCommandAttributes(),
        ProtocolMessageCommandAttributes(),
        RecordMarkerCommandAttributes(),
        RecordMarkerCommandAttributes'DetailsEntry(),
        RequestCancelActivityTaskCommandAttributes(),
        RequestCancelExternalWorkflowExecutionCommandAttributes(),
        ScheduleActivityTaskCommandAttributes(),
        SignalExternalWorkflowExecutionCommandAttributes(),
        StartChildWorkflowExecutionCommandAttributes(),
        StartTimerCommandAttributes(),
        UpsertWorkflowSearchAttributesCommandAttributes()
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
import qualified Proto.Dependencies.Gogoproto.Gogo
import qualified Proto.Google.Protobuf.Duration
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.CommandType
import qualified Proto.Temporal.Api.Enums.V1.Workflow
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Api.Taskqueue.V1.Message
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.timerId' @:: Lens' CancelTimerCommandAttributes Data.Text.Text@ -}
data CancelTimerCommandAttributes
  = CancelTimerCommandAttributes'_constructor {_CancelTimerCommandAttributes'timerId :: !Data.Text.Text,
                                               _CancelTimerCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CancelTimerCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CancelTimerCommandAttributes "timerId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelTimerCommandAttributes'timerId
           (\ x__ y__ -> x__ {_CancelTimerCommandAttributes'timerId = y__}))
        Prelude.id
instance Data.ProtoLens.Message CancelTimerCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.CancelTimerCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \\FSCancelTimerCommandAttributes\DC2\EM\n\
      \\btimer_id\CAN\SOH \SOH(\tR\atimerId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        timerId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "timer_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"timerId")) ::
              Data.ProtoLens.FieldDescriptor CancelTimerCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, timerId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CancelTimerCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__ {_CancelTimerCommandAttributes'_unknownFields = y__})
  defMessage
    = CancelTimerCommandAttributes'_constructor
        {_CancelTimerCommandAttributes'timerId = Data.ProtoLens.fieldDefault,
         _CancelTimerCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CancelTimerCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser CancelTimerCommandAttributes
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
                                       "timer_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"timerId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CancelTimerCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"timerId") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData CancelTimerCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CancelTimerCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CancelTimerCommandAttributes'timerId x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.details' @:: Lens' CancelWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'details' @:: Lens' CancelWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@ -}
data CancelWorkflowExecutionCommandAttributes
  = CancelWorkflowExecutionCommandAttributes'_constructor {_CancelWorkflowExecutionCommandAttributes'details :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                           _CancelWorkflowExecutionCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CancelWorkflowExecutionCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CancelWorkflowExecutionCommandAttributes "details" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelWorkflowExecutionCommandAttributes'details
           (\ x__ y__
              -> x__ {_CancelWorkflowExecutionCommandAttributes'details = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CancelWorkflowExecutionCommandAttributes "maybe'details" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelWorkflowExecutionCommandAttributes'details
           (\ x__ y__
              -> x__ {_CancelWorkflowExecutionCommandAttributes'details = y__}))
        Prelude.id
instance Data.ProtoLens.Message CancelWorkflowExecutionCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.CancelWorkflowExecutionCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \(CancelWorkflowExecutionCommandAttributes\DC2:\n\
      \\adetails\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsR\adetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'details")) ::
              Data.ProtoLens.FieldDescriptor CancelWorkflowExecutionCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, details__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CancelWorkflowExecutionCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_CancelWorkflowExecutionCommandAttributes'_unknownFields = y__})
  defMessage
    = CancelWorkflowExecutionCommandAttributes'_constructor
        {_CancelWorkflowExecutionCommandAttributes'details = Prelude.Nothing,
         _CancelWorkflowExecutionCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CancelWorkflowExecutionCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser CancelWorkflowExecutionCommandAttributes
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
          (do loop Data.ProtoLens.defMessage)
          "CancelWorkflowExecutionCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'details") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData CancelWorkflowExecutionCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CancelWorkflowExecutionCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CancelWorkflowExecutionCommandAttributes'details x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.commandType' @:: Lens' Command Proto.Temporal.Api.Enums.V1.CommandType.CommandType@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'attributes' @:: Lens' Command (Prelude.Maybe Command'Attributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'scheduleActivityTaskCommandAttributes' @:: Lens' Command (Prelude.Maybe ScheduleActivityTaskCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.scheduleActivityTaskCommandAttributes' @:: Lens' Command ScheduleActivityTaskCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'startTimerCommandAttributes' @:: Lens' Command (Prelude.Maybe StartTimerCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.startTimerCommandAttributes' @:: Lens' Command StartTimerCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'completeWorkflowExecutionCommandAttributes' @:: Lens' Command (Prelude.Maybe CompleteWorkflowExecutionCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.completeWorkflowExecutionCommandAttributes' @:: Lens' Command CompleteWorkflowExecutionCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'failWorkflowExecutionCommandAttributes' @:: Lens' Command (Prelude.Maybe FailWorkflowExecutionCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.failWorkflowExecutionCommandAttributes' @:: Lens' Command FailWorkflowExecutionCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'requestCancelActivityTaskCommandAttributes' @:: Lens' Command (Prelude.Maybe RequestCancelActivityTaskCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.requestCancelActivityTaskCommandAttributes' @:: Lens' Command RequestCancelActivityTaskCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'cancelTimerCommandAttributes' @:: Lens' Command (Prelude.Maybe CancelTimerCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.cancelTimerCommandAttributes' @:: Lens' Command CancelTimerCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'cancelWorkflowExecutionCommandAttributes' @:: Lens' Command (Prelude.Maybe CancelWorkflowExecutionCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.cancelWorkflowExecutionCommandAttributes' @:: Lens' Command CancelWorkflowExecutionCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'requestCancelExternalWorkflowExecutionCommandAttributes' @:: Lens' Command (Prelude.Maybe RequestCancelExternalWorkflowExecutionCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.requestCancelExternalWorkflowExecutionCommandAttributes' @:: Lens' Command RequestCancelExternalWorkflowExecutionCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'recordMarkerCommandAttributes' @:: Lens' Command (Prelude.Maybe RecordMarkerCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.recordMarkerCommandAttributes' @:: Lens' Command RecordMarkerCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'continueAsNewWorkflowExecutionCommandAttributes' @:: Lens' Command (Prelude.Maybe ContinueAsNewWorkflowExecutionCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.continueAsNewWorkflowExecutionCommandAttributes' @:: Lens' Command ContinueAsNewWorkflowExecutionCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'startChildWorkflowExecutionCommandAttributes' @:: Lens' Command (Prelude.Maybe StartChildWorkflowExecutionCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.startChildWorkflowExecutionCommandAttributes' @:: Lens' Command StartChildWorkflowExecutionCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'signalExternalWorkflowExecutionCommandAttributes' @:: Lens' Command (Prelude.Maybe SignalExternalWorkflowExecutionCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.signalExternalWorkflowExecutionCommandAttributes' @:: Lens' Command SignalExternalWorkflowExecutionCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'upsertWorkflowSearchAttributesCommandAttributes' @:: Lens' Command (Prelude.Maybe UpsertWorkflowSearchAttributesCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.upsertWorkflowSearchAttributesCommandAttributes' @:: Lens' Command UpsertWorkflowSearchAttributesCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'protocolMessageCommandAttributes' @:: Lens' Command (Prelude.Maybe ProtocolMessageCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.protocolMessageCommandAttributes' @:: Lens' Command ProtocolMessageCommandAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'modifyWorkflowPropertiesCommandAttributes' @:: Lens' Command (Prelude.Maybe ModifyWorkflowPropertiesCommandAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.modifyWorkflowPropertiesCommandAttributes' @:: Lens' Command ModifyWorkflowPropertiesCommandAttributes@ -}
data Command
  = Command'_constructor {_Command'commandType :: !Proto.Temporal.Api.Enums.V1.CommandType.CommandType,
                          _Command'attributes :: !(Prelude.Maybe Command'Attributes),
                          _Command'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Command where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Command'Attributes
  = Command'ScheduleActivityTaskCommandAttributes !ScheduleActivityTaskCommandAttributes |
    Command'StartTimerCommandAttributes !StartTimerCommandAttributes |
    Command'CompleteWorkflowExecutionCommandAttributes !CompleteWorkflowExecutionCommandAttributes |
    Command'FailWorkflowExecutionCommandAttributes !FailWorkflowExecutionCommandAttributes |
    Command'RequestCancelActivityTaskCommandAttributes !RequestCancelActivityTaskCommandAttributes |
    Command'CancelTimerCommandAttributes !CancelTimerCommandAttributes |
    Command'CancelWorkflowExecutionCommandAttributes !CancelWorkflowExecutionCommandAttributes |
    Command'RequestCancelExternalWorkflowExecutionCommandAttributes !RequestCancelExternalWorkflowExecutionCommandAttributes |
    Command'RecordMarkerCommandAttributes !RecordMarkerCommandAttributes |
    Command'ContinueAsNewWorkflowExecutionCommandAttributes !ContinueAsNewWorkflowExecutionCommandAttributes |
    Command'StartChildWorkflowExecutionCommandAttributes !StartChildWorkflowExecutionCommandAttributes |
    Command'SignalExternalWorkflowExecutionCommandAttributes !SignalExternalWorkflowExecutionCommandAttributes |
    Command'UpsertWorkflowSearchAttributesCommandAttributes !UpsertWorkflowSearchAttributesCommandAttributes |
    Command'ProtocolMessageCommandAttributes !ProtocolMessageCommandAttributes |
    Command'ModifyWorkflowPropertiesCommandAttributes !ModifyWorkflowPropertiesCommandAttributes
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Command "commandType" Proto.Temporal.Api.Enums.V1.CommandType.CommandType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'commandType
           (\ x__ y__ -> x__ {_Command'commandType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Command "maybe'attributes" (Prelude.Maybe Command'Attributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Command "maybe'scheduleActivityTaskCommandAttributes" (Prelude.Maybe ScheduleActivityTaskCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'ScheduleActivityTaskCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap Command'ScheduleActivityTaskCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "scheduleActivityTaskCommandAttributes" ScheduleActivityTaskCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'ScheduleActivityTaskCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap Command'ScheduleActivityTaskCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'startTimerCommandAttributes" (Prelude.Maybe StartTimerCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'StartTimerCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Command'StartTimerCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "startTimerCommandAttributes" StartTimerCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'StartTimerCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Command'StartTimerCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'completeWorkflowExecutionCommandAttributes" (Prelude.Maybe CompleteWorkflowExecutionCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'CompleteWorkflowExecutionCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'CompleteWorkflowExecutionCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "completeWorkflowExecutionCommandAttributes" CompleteWorkflowExecutionCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'CompleteWorkflowExecutionCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'CompleteWorkflowExecutionCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'failWorkflowExecutionCommandAttributes" (Prelude.Maybe FailWorkflowExecutionCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'FailWorkflowExecutionCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'FailWorkflowExecutionCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "failWorkflowExecutionCommandAttributes" FailWorkflowExecutionCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'FailWorkflowExecutionCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'FailWorkflowExecutionCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'requestCancelActivityTaskCommandAttributes" (Prelude.Maybe RequestCancelActivityTaskCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'RequestCancelActivityTaskCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'RequestCancelActivityTaskCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "requestCancelActivityTaskCommandAttributes" RequestCancelActivityTaskCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'RequestCancelActivityTaskCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'RequestCancelActivityTaskCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'cancelTimerCommandAttributes" (Prelude.Maybe CancelTimerCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'CancelTimerCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Command'CancelTimerCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "cancelTimerCommandAttributes" CancelTimerCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'CancelTimerCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Command'CancelTimerCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'cancelWorkflowExecutionCommandAttributes" (Prelude.Maybe CancelWorkflowExecutionCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'CancelWorkflowExecutionCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'CancelWorkflowExecutionCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "cancelWorkflowExecutionCommandAttributes" CancelWorkflowExecutionCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'CancelWorkflowExecutionCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'CancelWorkflowExecutionCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'requestCancelExternalWorkflowExecutionCommandAttributes" (Prelude.Maybe RequestCancelExternalWorkflowExecutionCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'RequestCancelExternalWorkflowExecutionCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'RequestCancelExternalWorkflowExecutionCommandAttributes
                   y__))
instance Data.ProtoLens.Field.HasField Command "requestCancelExternalWorkflowExecutionCommandAttributes" RequestCancelExternalWorkflowExecutionCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'RequestCancelExternalWorkflowExecutionCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'RequestCancelExternalWorkflowExecutionCommandAttributes
                      y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'recordMarkerCommandAttributes" (Prelude.Maybe RecordMarkerCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'RecordMarkerCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap Command'RecordMarkerCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "recordMarkerCommandAttributes" RecordMarkerCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'RecordMarkerCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap Command'RecordMarkerCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'continueAsNewWorkflowExecutionCommandAttributes" (Prelude.Maybe ContinueAsNewWorkflowExecutionCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'ContinueAsNewWorkflowExecutionCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'ContinueAsNewWorkflowExecutionCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "continueAsNewWorkflowExecutionCommandAttributes" ContinueAsNewWorkflowExecutionCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'ContinueAsNewWorkflowExecutionCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'ContinueAsNewWorkflowExecutionCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'startChildWorkflowExecutionCommandAttributes" (Prelude.Maybe StartChildWorkflowExecutionCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'StartChildWorkflowExecutionCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'StartChildWorkflowExecutionCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "startChildWorkflowExecutionCommandAttributes" StartChildWorkflowExecutionCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'StartChildWorkflowExecutionCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'StartChildWorkflowExecutionCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'signalExternalWorkflowExecutionCommandAttributes" (Prelude.Maybe SignalExternalWorkflowExecutionCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'SignalExternalWorkflowExecutionCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'SignalExternalWorkflowExecutionCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "signalExternalWorkflowExecutionCommandAttributes" SignalExternalWorkflowExecutionCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'SignalExternalWorkflowExecutionCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'SignalExternalWorkflowExecutionCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'upsertWorkflowSearchAttributesCommandAttributes" (Prelude.Maybe UpsertWorkflowSearchAttributesCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'UpsertWorkflowSearchAttributesCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'UpsertWorkflowSearchAttributesCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "upsertWorkflowSearchAttributesCommandAttributes" UpsertWorkflowSearchAttributesCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'UpsertWorkflowSearchAttributesCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'UpsertWorkflowSearchAttributesCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'protocolMessageCommandAttributes" (Prelude.Maybe ProtocolMessageCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'ProtocolMessageCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap Command'ProtocolMessageCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "protocolMessageCommandAttributes" ProtocolMessageCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'ProtocolMessageCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap Command'ProtocolMessageCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Command "maybe'modifyWorkflowPropertiesCommandAttributes" (Prelude.Maybe ModifyWorkflowPropertiesCommandAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Command'ModifyWorkflowPropertiesCommandAttributes x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   Command'ModifyWorkflowPropertiesCommandAttributes y__))
instance Data.ProtoLens.Field.HasField Command "modifyWorkflowPropertiesCommandAttributes" ModifyWorkflowPropertiesCommandAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'attributes (\ x__ y__ -> x__ {_Command'attributes = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Command'ModifyWorkflowPropertiesCommandAttributes x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      Command'ModifyWorkflowPropertiesCommandAttributes y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message Command where
  messageName _ = Data.Text.pack "temporal.api.command.v1.Command"
  packedMessageDescriptor _
    = "\n\
      \\aCommand\DC2E\n\
      \\fcommand_type\CAN\SOH \SOH(\SO2\".temporal.api.enums.v1.CommandTypeR\vcommandType\DC2\154\SOH\n\
      \)schedule_activity_task_command_attributes\CAN\STX \SOH(\v2>.temporal.api.command.v1.ScheduleActivityTaskCommandAttributesH\NULR%scheduleActivityTaskCommandAttributes\DC2{\n\
      \\RSstart_timer_command_attributes\CAN\ETX \SOH(\v24.temporal.api.command.v1.StartTimerCommandAttributesH\NULR\ESCstartTimerCommandAttributes\DC2\169\SOH\n\
      \.complete_workflow_execution_command_attributes\CAN\EOT \SOH(\v2C.temporal.api.command.v1.CompleteWorkflowExecutionCommandAttributesH\NULR*completeWorkflowExecutionCommandAttributes\DC2\157\SOH\n\
      \*fail_workflow_execution_command_attributes\CAN\ENQ \SOH(\v2?.temporal.api.command.v1.FailWorkflowExecutionCommandAttributesH\NULR&failWorkflowExecutionCommandAttributes\DC2\170\SOH\n\
      \/request_cancel_activity_task_command_attributes\CAN\ACK \SOH(\v2C.temporal.api.command.v1.RequestCancelActivityTaskCommandAttributesH\NULR*requestCancelActivityTaskCommandAttributes\DC2~\n\
      \\UScancel_timer_command_attributes\CAN\a \SOH(\v25.temporal.api.command.v1.CancelTimerCommandAttributesH\NULR\FScancelTimerCommandAttributes\DC2\163\SOH\n\
      \,cancel_workflow_execution_command_attributes\CAN\b \SOH(\v2A.temporal.api.command.v1.CancelWorkflowExecutionCommandAttributesH\NULR(cancelWorkflowExecutionCommandAttributes\DC2\210\SOH\n\
      \=request_cancel_external_workflow_execution_command_attributes\CAN\t \SOH(\v2P.temporal.api.command.v1.RequestCancelExternalWorkflowExecutionCommandAttributesH\NULR7requestCancelExternalWorkflowExecutionCommandAttributes\DC2\129\SOH\n\
      \ record_marker_command_attributes\CAN\n\
      \ \SOH(\v26.temporal.api.command.v1.RecordMarkerCommandAttributesH\NULR\GSrecordMarkerCommandAttributes\DC2\186\SOH\n\
      \5continue_as_new_workflow_execution_command_attributes\CAN\v \SOH(\v2H.temporal.api.command.v1.ContinueAsNewWorkflowExecutionCommandAttributesH\NULR/continueAsNewWorkflowExecutionCommandAttributes\DC2\176\SOH\n\
      \1start_child_workflow_execution_command_attributes\CAN\f \SOH(\v2E.temporal.api.command.v1.StartChildWorkflowExecutionCommandAttributesH\NULR,startChildWorkflowExecutionCommandAttributes\DC2\188\SOH\n\
      \5signal_external_workflow_execution_command_attributes\CAN\r \SOH(\v2I.temporal.api.command.v1.SignalExternalWorkflowExecutionCommandAttributesH\NULR0signalExternalWorkflowExecutionCommandAttributes\DC2\185\SOH\n\
      \4upsert_workflow_search_attributes_command_attributes\CAN\SO \SOH(\v2H.temporal.api.command.v1.UpsertWorkflowSearchAttributesCommandAttributesH\NULR/upsertWorkflowSearchAttributesCommandAttributes\DC2\138\SOH\n\
      \#protocol_message_command_attributes\CAN\SI \SOH(\v29.temporal.api.command.v1.ProtocolMessageCommandAttributesH\NULR protocolMessageCommandAttributes\DC2\166\SOH\n\
      \-modify_workflow_properties_command_attributes\CAN\DC1 \SOH(\v2B.temporal.api.command.v1.ModifyWorkflowPropertiesCommandAttributesH\NULR)modifyWorkflowPropertiesCommandAttributesB\f\n\
      \\n\
      \attributes"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        commandType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "command_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.CommandType.CommandType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"commandType")) ::
              Data.ProtoLens.FieldDescriptor Command
        scheduleActivityTaskCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schedule_activity_task_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ScheduleActivityTaskCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'scheduleActivityTaskCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        startTimerCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_timer_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartTimerCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'startTimerCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        completeWorkflowExecutionCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "complete_workflow_execution_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CompleteWorkflowExecutionCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'completeWorkflowExecutionCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        failWorkflowExecutionCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "fail_workflow_execution_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor FailWorkflowExecutionCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'failWorkflowExecutionCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        requestCancelActivityTaskCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "request_cancel_activity_task_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor RequestCancelActivityTaskCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'requestCancelActivityTaskCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        cancelTimerCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel_timer_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CancelTimerCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'cancelTimerCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        cancelWorkflowExecutionCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel_workflow_execution_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CancelWorkflowExecutionCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'cancelWorkflowExecutionCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        requestCancelExternalWorkflowExecutionCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "request_cancel_external_workflow_execution_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor RequestCancelExternalWorkflowExecutionCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'requestCancelExternalWorkflowExecutionCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        recordMarkerCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "record_marker_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor RecordMarkerCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'recordMarkerCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        continueAsNewWorkflowExecutionCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "continue_as_new_workflow_execution_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ContinueAsNewWorkflowExecutionCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'continueAsNewWorkflowExecutionCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        startChildWorkflowExecutionCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_child_workflow_execution_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartChildWorkflowExecutionCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'startChildWorkflowExecutionCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        signalExternalWorkflowExecutionCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "signal_external_workflow_execution_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor SignalExternalWorkflowExecutionCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'signalExternalWorkflowExecutionCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        upsertWorkflowSearchAttributesCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "upsert_workflow_search_attributes_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor UpsertWorkflowSearchAttributesCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'upsertWorkflowSearchAttributesCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        protocolMessageCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "protocol_message_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ProtocolMessageCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'protocolMessageCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
        modifyWorkflowPropertiesCommandAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "modify_workflow_properties_command_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ModifyWorkflowPropertiesCommandAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'modifyWorkflowPropertiesCommandAttributes")) ::
              Data.ProtoLens.FieldDescriptor Command
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, commandType__field_descriptor),
           (Data.ProtoLens.Tag 2, 
            scheduleActivityTaskCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 3, 
            startTimerCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 4, 
            completeWorkflowExecutionCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 5, 
            failWorkflowExecutionCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 6, 
            requestCancelActivityTaskCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 7, 
            cancelTimerCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 8, 
            cancelWorkflowExecutionCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 9, 
            requestCancelExternalWorkflowExecutionCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 10, 
            recordMarkerCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 11, 
            continueAsNewWorkflowExecutionCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 12, 
            startChildWorkflowExecutionCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 13, 
            signalExternalWorkflowExecutionCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 14, 
            upsertWorkflowSearchAttributesCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 15, 
            protocolMessageCommandAttributes__field_descriptor),
           (Data.ProtoLens.Tag 17, 
            modifyWorkflowPropertiesCommandAttributes__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Command'_unknownFields
        (\ x__ y__ -> x__ {_Command'_unknownFields = y__})
  defMessage
    = Command'_constructor
        {_Command'commandType = Data.ProtoLens.fieldDefault,
         _Command'attributes = Prelude.Nothing,
         _Command'_unknownFields = []}
  parseMessage
    = let
        loop :: Command -> Data.ProtoLens.Encoding.Bytes.Parser Command
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
                                       "command_type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"commandType") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "schedule_activity_task_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"scheduleActivityTaskCommandAttributes")
                                     y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_timer_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startTimerCommandAttributes") y
                                     x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "complete_workflow_execution_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"completeWorkflowExecutionCommandAttributes")
                                     y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "fail_workflow_execution_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"failWorkflowExecutionCommandAttributes")
                                     y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "request_cancel_activity_task_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"requestCancelActivityTaskCommandAttributes")
                                     y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancel_timer_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cancelTimerCommandAttributes") y
                                     x)
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancel_workflow_execution_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"cancelWorkflowExecutionCommandAttributes")
                                     y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "request_cancel_external_workflow_execution_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"requestCancelExternalWorkflowExecutionCommandAttributes")
                                     y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "record_marker_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"recordMarkerCommandAttributes") y
                                     x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "continue_as_new_workflow_execution_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"continueAsNewWorkflowExecutionCommandAttributes")
                                     y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_child_workflow_execution_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"startChildWorkflowExecutionCommandAttributes")
                                     y x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "signal_external_workflow_execution_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"signalExternalWorkflowExecutionCommandAttributes")
                                     y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "upsert_workflow_search_attributes_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"upsertWorkflowSearchAttributesCommandAttributes")
                                     y x)
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "protocol_message_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"protocolMessageCommandAttributes")
                                     y x)
                        138
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "modify_workflow_properties_command_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"modifyWorkflowPropertiesCommandAttributes")
                                     y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Command"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"commandType") _x
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
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'attributes") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (Command'ScheduleActivityTaskCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'StartTimerCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'CompleteWorkflowExecutionCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'FailWorkflowExecutionCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'RequestCancelActivityTaskCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'CancelTimerCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'CancelWorkflowExecutionCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 66)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'RequestCancelExternalWorkflowExecutionCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'RecordMarkerCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'ContinueAsNewWorkflowExecutionCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'StartChildWorkflowExecutionCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'SignalExternalWorkflowExecutionCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 106)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'UpsertWorkflowSearchAttributesCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 114)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'ProtocolMessageCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 122)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (Command'ModifyWorkflowPropertiesCommandAttributes v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 138)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Command where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Command'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Command'commandType x__)
                (Control.DeepSeq.deepseq (_Command'attributes x__) ()))
instance Control.DeepSeq.NFData Command'Attributes where
  rnf (Command'ScheduleActivityTaskCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'StartTimerCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'CompleteWorkflowExecutionCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'FailWorkflowExecutionCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'RequestCancelActivityTaskCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'CancelTimerCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'CancelWorkflowExecutionCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf
    (Command'RequestCancelExternalWorkflowExecutionCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'RecordMarkerCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'ContinueAsNewWorkflowExecutionCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'StartChildWorkflowExecutionCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'SignalExternalWorkflowExecutionCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'UpsertWorkflowSearchAttributesCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'ProtocolMessageCommandAttributes x__)
    = Control.DeepSeq.rnf x__
  rnf (Command'ModifyWorkflowPropertiesCommandAttributes x__)
    = Control.DeepSeq.rnf x__
_Command'ScheduleActivityTaskCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes ScheduleActivityTaskCommandAttributes
_Command'ScheduleActivityTaskCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'ScheduleActivityTaskCommandAttributes
      (\ p__
         -> case p__ of
              (Command'ScheduleActivityTaskCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'StartTimerCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes StartTimerCommandAttributes
_Command'StartTimerCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'StartTimerCommandAttributes
      (\ p__
         -> case p__ of
              (Command'StartTimerCommandAttributes p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'CompleteWorkflowExecutionCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes CompleteWorkflowExecutionCommandAttributes
_Command'CompleteWorkflowExecutionCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'CompleteWorkflowExecutionCommandAttributes
      (\ p__
         -> case p__ of
              (Command'CompleteWorkflowExecutionCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'FailWorkflowExecutionCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes FailWorkflowExecutionCommandAttributes
_Command'FailWorkflowExecutionCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'FailWorkflowExecutionCommandAttributes
      (\ p__
         -> case p__ of
              (Command'FailWorkflowExecutionCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'RequestCancelActivityTaskCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes RequestCancelActivityTaskCommandAttributes
_Command'RequestCancelActivityTaskCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'RequestCancelActivityTaskCommandAttributes
      (\ p__
         -> case p__ of
              (Command'RequestCancelActivityTaskCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'CancelTimerCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes CancelTimerCommandAttributes
_Command'CancelTimerCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'CancelTimerCommandAttributes
      (\ p__
         -> case p__ of
              (Command'CancelTimerCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'CancelWorkflowExecutionCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes CancelWorkflowExecutionCommandAttributes
_Command'CancelWorkflowExecutionCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'CancelWorkflowExecutionCommandAttributes
      (\ p__
         -> case p__ of
              (Command'CancelWorkflowExecutionCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'RequestCancelExternalWorkflowExecutionCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes RequestCancelExternalWorkflowExecutionCommandAttributes
_Command'RequestCancelExternalWorkflowExecutionCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'RequestCancelExternalWorkflowExecutionCommandAttributes
      (\ p__
         -> case p__ of
              (Command'RequestCancelExternalWorkflowExecutionCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'RecordMarkerCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes RecordMarkerCommandAttributes
_Command'RecordMarkerCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'RecordMarkerCommandAttributes
      (\ p__
         -> case p__ of
              (Command'RecordMarkerCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'ContinueAsNewWorkflowExecutionCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes ContinueAsNewWorkflowExecutionCommandAttributes
_Command'ContinueAsNewWorkflowExecutionCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'ContinueAsNewWorkflowExecutionCommandAttributes
      (\ p__
         -> case p__ of
              (Command'ContinueAsNewWorkflowExecutionCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'StartChildWorkflowExecutionCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes StartChildWorkflowExecutionCommandAttributes
_Command'StartChildWorkflowExecutionCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'StartChildWorkflowExecutionCommandAttributes
      (\ p__
         -> case p__ of
              (Command'StartChildWorkflowExecutionCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'SignalExternalWorkflowExecutionCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes SignalExternalWorkflowExecutionCommandAttributes
_Command'SignalExternalWorkflowExecutionCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'SignalExternalWorkflowExecutionCommandAttributes
      (\ p__
         -> case p__ of
              (Command'SignalExternalWorkflowExecutionCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'UpsertWorkflowSearchAttributesCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes UpsertWorkflowSearchAttributesCommandAttributes
_Command'UpsertWorkflowSearchAttributesCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'UpsertWorkflowSearchAttributesCommandAttributes
      (\ p__
         -> case p__ of
              (Command'UpsertWorkflowSearchAttributesCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'ProtocolMessageCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes ProtocolMessageCommandAttributes
_Command'ProtocolMessageCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'ProtocolMessageCommandAttributes
      (\ p__
         -> case p__ of
              (Command'ProtocolMessageCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Command'ModifyWorkflowPropertiesCommandAttributes ::
  Data.ProtoLens.Prism.Prism' Command'Attributes ModifyWorkflowPropertiesCommandAttributes
_Command'ModifyWorkflowPropertiesCommandAttributes
  = Data.ProtoLens.Prism.prism'
      Command'ModifyWorkflowPropertiesCommandAttributes
      (\ p__
         -> case p__ of
              (Command'ModifyWorkflowPropertiesCommandAttributes p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.result' @:: Lens' CompleteWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'result' @:: Lens' CompleteWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@ -}
data CompleteWorkflowExecutionCommandAttributes
  = CompleteWorkflowExecutionCommandAttributes'_constructor {_CompleteWorkflowExecutionCommandAttributes'result :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                             _CompleteWorkflowExecutionCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CompleteWorkflowExecutionCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CompleteWorkflowExecutionCommandAttributes "result" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompleteWorkflowExecutionCommandAttributes'result
           (\ x__ y__
              -> x__ {_CompleteWorkflowExecutionCommandAttributes'result = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CompleteWorkflowExecutionCommandAttributes "maybe'result" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompleteWorkflowExecutionCommandAttributes'result
           (\ x__ y__
              -> x__ {_CompleteWorkflowExecutionCommandAttributes'result = y__}))
        Prelude.id
instance Data.ProtoLens.Message CompleteWorkflowExecutionCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.CompleteWorkflowExecutionCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \*CompleteWorkflowExecutionCommandAttributes\DC28\n\
      \\ACKresult\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsR\ACKresult"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        result__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "result"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'result")) ::
              Data.ProtoLens.FieldDescriptor CompleteWorkflowExecutionCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, result__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CompleteWorkflowExecutionCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_CompleteWorkflowExecutionCommandAttributes'_unknownFields = y__})
  defMessage
    = CompleteWorkflowExecutionCommandAttributes'_constructor
        {_CompleteWorkflowExecutionCommandAttributes'result = Prelude.Nothing,
         _CompleteWorkflowExecutionCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CompleteWorkflowExecutionCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser CompleteWorkflowExecutionCommandAttributes
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
                                       "result"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"result") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "CompleteWorkflowExecutionCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'result") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData CompleteWorkflowExecutionCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CompleteWorkflowExecutionCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CompleteWorkflowExecutionCommandAttributes'result x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowType' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.WorkflowType@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'workflowType' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.taskQueue' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'taskQueue' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.input' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'input' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowRunTimeout' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'workflowRunTimeout' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowTaskTimeout' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'workflowTaskTimeout' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.backoffStartInterval' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'backoffStartInterval' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.retryPolicy' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.RetryPolicy@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'retryPolicy' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.initiator' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.failure' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'failure' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.lastCompletionResult' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'lastCompletionResult' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.cronSchedule' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.header' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'header' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.memo' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Memo@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'memo' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.searchAttributes' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.SearchAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'searchAttributes' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.useCompatibleVersion' @:: Lens' ContinueAsNewWorkflowExecutionCommandAttributes Prelude.Bool@ -}
data ContinueAsNewWorkflowExecutionCommandAttributes
  = ContinueAsNewWorkflowExecutionCommandAttributes'_constructor {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowType :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'taskQueue :: !(Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'input :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'workflowRunTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'workflowTaskTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'backoffStartInterval :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'retryPolicy :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'initiator :: !Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator,
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'failure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'lastCompletionResult :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'cronSchedule :: !Data.Text.Text,
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'memo :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'searchAttributes :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes),
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'useCompatibleVersion :: !Prelude.Bool,
                                                                  _ContinueAsNewWorkflowExecutionCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ContinueAsNewWorkflowExecutionCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "workflowType" Proto.Temporal.Api.Common.V1.Message.WorkflowType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'workflowType
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowType = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'workflowType" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'workflowType
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "taskQueue" Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'taskQueue
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'taskQueue = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'taskQueue" (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'taskQueue
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "input" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'input
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'input = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'input" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'input
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "workflowRunTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'workflowRunTimeout
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowRunTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'workflowRunTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'workflowRunTimeout
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowRunTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "workflowTaskTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'workflowTaskTimeout
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowTaskTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'workflowTaskTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'workflowTaskTimeout
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowTaskTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "backoffStartInterval" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'backoffStartInterval
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'backoffStartInterval = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'backoffStartInterval" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'backoffStartInterval
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'backoffStartInterval = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "retryPolicy" Proto.Temporal.Api.Common.V1.Message.RetryPolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'retryPolicy
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'retryPolicy = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'retryPolicy" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'retryPolicy
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'retryPolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "initiator" Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'initiator
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'initiator = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'failure
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'failure
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "lastCompletionResult" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'lastCompletionResult
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'lastCompletionResult = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'lastCompletionResult" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'lastCompletionResult
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'lastCompletionResult = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "cronSchedule" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'cronSchedule
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'cronSchedule = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'header
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'header
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "memo" Proto.Temporal.Api.Common.V1.Message.Memo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'memo
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'memo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'memo" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'memo
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'memo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "searchAttributes" Proto.Temporal.Api.Common.V1.Message.SearchAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'searchAttributes
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'searchAttributes = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "maybe'searchAttributes" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'searchAttributes
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ContinueAsNewWorkflowExecutionCommandAttributes "useCompatibleVersion" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ContinueAsNewWorkflowExecutionCommandAttributes'useCompatibleVersion
           (\ x__ y__
              -> x__
                   {_ContinueAsNewWorkflowExecutionCommandAttributes'useCompatibleVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Message ContinueAsNewWorkflowExecutionCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.ContinueAsNewWorkflowExecutionCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \/ContinueAsNewWorkflowExecutionCommandAttributes\DC2I\n\
      \\rworkflow_type\CAN\SOH \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\fworkflowType\DC2C\n\
      \\n\
      \task_queue\CAN\STX \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
      \\ENQinput\CAN\ETX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2Q\n\
      \\DC4workflow_run_timeout\CAN\EOT \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2S\n\
      \\NAKworkflow_task_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeoutB\EOT\152\223\US\SOH\DC2U\n\
      \\SYNbackoff_start_interval\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\DC4backoffStartIntervalB\EOT\152\223\US\SOH\DC2F\n\
      \\fretry_policy\CAN\a \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2K\n\
      \\tinitiator\CAN\b \SOH(\SO2-.temporal.api.enums.v1.ContinueAsNewInitiatorR\tinitiator\DC2:\n\
      \\afailure\CAN\t \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\DC2V\n\
      \\SYNlast_completion_result\CAN\n\
      \ \SOH(\v2 .temporal.api.common.v1.PayloadsR\DC4lastCompletionResult\DC2#\n\
      \\rcron_schedule\CAN\v \SOH(\tR\fcronSchedule\DC26\n\
      \\ACKheader\CAN\f \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC20\n\
      \\EOTmemo\CAN\r \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
      \\DC1search_attributes\CAN\SO \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC24\n\
      \\SYNuse_compatible_version\CAN\SI \SOH(\bR\DC4useCompatibleVersion"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_type"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowType)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowType")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'taskQueue")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'input")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        workflowRunTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_run_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        workflowTaskTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_task_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        backoffStartInterval__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "backoff_start_interval"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'backoffStartInterval")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        retryPolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "retry_policy"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.RetryPolicy)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'retryPolicy")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        initiator__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "initiator"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"initiator")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        lastCompletionResult__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_completion_result"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastCompletionResult")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        cronSchedule__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cron_schedule"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"cronSchedule")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        memo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "memo"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Memo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'memo")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.SearchAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
        useCompatibleVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "use_compatible_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"useCompatibleVersion")) ::
              Data.ProtoLens.FieldDescriptor ContinueAsNewWorkflowExecutionCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowType__field_descriptor),
           (Data.ProtoLens.Tag 2, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 3, input__field_descriptor),
           (Data.ProtoLens.Tag 4, workflowRunTimeout__field_descriptor),
           (Data.ProtoLens.Tag 5, workflowTaskTimeout__field_descriptor),
           (Data.ProtoLens.Tag 6, backoffStartInterval__field_descriptor),
           (Data.ProtoLens.Tag 7, retryPolicy__field_descriptor),
           (Data.ProtoLens.Tag 8, initiator__field_descriptor),
           (Data.ProtoLens.Tag 9, failure__field_descriptor),
           (Data.ProtoLens.Tag 10, lastCompletionResult__field_descriptor),
           (Data.ProtoLens.Tag 11, cronSchedule__field_descriptor),
           (Data.ProtoLens.Tag 12, header__field_descriptor),
           (Data.ProtoLens.Tag 13, memo__field_descriptor),
           (Data.ProtoLens.Tag 14, searchAttributes__field_descriptor),
           (Data.ProtoLens.Tag 15, useCompatibleVersion__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ContinueAsNewWorkflowExecutionCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_ContinueAsNewWorkflowExecutionCommandAttributes'_unknownFields = y__})
  defMessage
    = ContinueAsNewWorkflowExecutionCommandAttributes'_constructor
        {_ContinueAsNewWorkflowExecutionCommandAttributes'workflowType = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'taskQueue = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'input = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'workflowRunTimeout = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'workflowTaskTimeout = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'backoffStartInterval = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'retryPolicy = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'initiator = Data.ProtoLens.fieldDefault,
         _ContinueAsNewWorkflowExecutionCommandAttributes'failure = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'lastCompletionResult = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'cronSchedule = Data.ProtoLens.fieldDefault,
         _ContinueAsNewWorkflowExecutionCommandAttributes'header = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'memo = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'searchAttributes = Prelude.Nothing,
         _ContinueAsNewWorkflowExecutionCommandAttributes'useCompatibleVersion = Data.ProtoLens.fieldDefault,
         _ContinueAsNewWorkflowExecutionCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ContinueAsNewWorkflowExecutionCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser ContinueAsNewWorkflowExecutionCommandAttributes
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
                                       "workflow_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowType") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "input"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"input") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_run_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowRunTimeout") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_task_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowTaskTimeout") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "backoff_start_interval"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"backoffStartInterval") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "retry_policy"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"retryPolicy") y x)
                        64
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "initiator"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"initiator") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "failure"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failure") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_completion_result"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastCompletionResult") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "cron_schedule"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cronSchedule") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "memo"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"memo") y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "search_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"searchAttributes") y x)
                        120
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "use_compatible_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"useCompatibleVersion") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ContinueAsNewWorkflowExecutionCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'workflowType") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'taskQueue") _x
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
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'input") _x
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
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just _v)
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage _v))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view
                                (Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just _v)
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         ((Data.Monoid.<>)
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'backoffStartInterval") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (case
                                    Lens.Family2.view
                                      (Data.ProtoLens.Field.field @"maybe'retryPolicy") _x
                                of
                                  Prelude.Nothing -> Data.Monoid.mempty
                                  (Prelude.Just _v)
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
                               ((Data.Monoid.<>)
                                  (let
                                     _v
                                       = Lens.Family2.view
                                           (Data.ProtoLens.Field.field @"initiator") _x
                                   in
                                     if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                         Data.Monoid.mempty
                                     else
                                         (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt 64)
                                           ((Prelude..)
                                              ((Prelude..)
                                                 Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 Prelude.fromIntegral)
                                              Prelude.fromEnum _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'failure") _x
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
                                                  @"maybe'lastCompletionResult")
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
                                           (let
                                              _v
                                                = Lens.Family2.view
                                                    (Data.ProtoLens.Field.field @"cronSchedule") _x
                                            in
                                              if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                  Data.Monoid.mempty
                                              else
                                                  (Data.Monoid.<>)
                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                    ((Prelude..)
                                                       (\ bs
                                                          -> (Data.Monoid.<>)
                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                  (Prelude.fromIntegral
                                                                     (Data.ByteString.length bs)))
                                                               (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                  bs))
                                                       Data.Text.Encoding.encodeUtf8 _v))
                                           ((Data.Monoid.<>)
                                              (case
                                                   Lens.Family2.view
                                                     (Data.ProtoLens.Field.field @"maybe'header") _x
                                               of
                                                 Prelude.Nothing -> Data.Monoid.mempty
                                                 (Prelude.Just _v)
                                                   -> (Data.Monoid.<>)
                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
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
                                                        (Data.ProtoLens.Field.field @"maybe'memo")
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
                                                              @"maybe'searchAttributes")
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
                                                       (let
                                                          _v
                                                            = Lens.Family2.view
                                                                (Data.ProtoLens.Field.field
                                                                   @"useCompatibleVersion")
                                                                _x
                                                        in
                                                          if (Prelude.==)
                                                               _v Data.ProtoLens.fieldDefault then
                                                              Data.Monoid.mempty
                                                          else
                                                              (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   120)
                                                                ((Prelude..)
                                                                   Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (\ b -> if b then 1 else 0) _v))
                                                       (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                          (Lens.Family2.view
                                                             Data.ProtoLens.unknownFields
                                                             _x))))))))))))))))
instance Control.DeepSeq.NFData ContinueAsNewWorkflowExecutionCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ContinueAsNewWorkflowExecutionCommandAttributes'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_ContinueAsNewWorkflowExecutionCommandAttributes'workflowType x__)
                (Control.DeepSeq.deepseq
                   (_ContinueAsNewWorkflowExecutionCommandAttributes'taskQueue x__)
                   (Control.DeepSeq.deepseq
                      (_ContinueAsNewWorkflowExecutionCommandAttributes'input x__)
                      (Control.DeepSeq.deepseq
                         (_ContinueAsNewWorkflowExecutionCommandAttributes'workflowRunTimeout
                            x__)
                         (Control.DeepSeq.deepseq
                            (_ContinueAsNewWorkflowExecutionCommandAttributes'workflowTaskTimeout
                               x__)
                            (Control.DeepSeq.deepseq
                               (_ContinueAsNewWorkflowExecutionCommandAttributes'backoffStartInterval
                                  x__)
                               (Control.DeepSeq.deepseq
                                  (_ContinueAsNewWorkflowExecutionCommandAttributes'retryPolicy x__)
                                  (Control.DeepSeq.deepseq
                                     (_ContinueAsNewWorkflowExecutionCommandAttributes'initiator
                                        x__)
                                     (Control.DeepSeq.deepseq
                                        (_ContinueAsNewWorkflowExecutionCommandAttributes'failure
                                           x__)
                                        (Control.DeepSeq.deepseq
                                           (_ContinueAsNewWorkflowExecutionCommandAttributes'lastCompletionResult
                                              x__)
                                           (Control.DeepSeq.deepseq
                                              (_ContinueAsNewWorkflowExecutionCommandAttributes'cronSchedule
                                                 x__)
                                              (Control.DeepSeq.deepseq
                                                 (_ContinueAsNewWorkflowExecutionCommandAttributes'header
                                                    x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_ContinueAsNewWorkflowExecutionCommandAttributes'memo
                                                       x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_ContinueAsNewWorkflowExecutionCommandAttributes'searchAttributes
                                                          x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_ContinueAsNewWorkflowExecutionCommandAttributes'useCompatibleVersion
                                                             x__)
                                                          ())))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.failure' @:: Lens' FailWorkflowExecutionCommandAttributes Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'failure' @:: Lens' FailWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@ -}
data FailWorkflowExecutionCommandAttributes
  = FailWorkflowExecutionCommandAttributes'_constructor {_FailWorkflowExecutionCommandAttributes'failure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                                         _FailWorkflowExecutionCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show FailWorkflowExecutionCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField FailWorkflowExecutionCommandAttributes "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _FailWorkflowExecutionCommandAttributes'failure
           (\ x__ y__
              -> x__ {_FailWorkflowExecutionCommandAttributes'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField FailWorkflowExecutionCommandAttributes "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _FailWorkflowExecutionCommandAttributes'failure
           (\ x__ y__
              -> x__ {_FailWorkflowExecutionCommandAttributes'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message FailWorkflowExecutionCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.FailWorkflowExecutionCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \&FailWorkflowExecutionCommandAttributes\DC2:\n\
      \\afailure\CAN\SOH \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor FailWorkflowExecutionCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _FailWorkflowExecutionCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_FailWorkflowExecutionCommandAttributes'_unknownFields = y__})
  defMessage
    = FailWorkflowExecutionCommandAttributes'_constructor
        {_FailWorkflowExecutionCommandAttributes'failure = Prelude.Nothing,
         _FailWorkflowExecutionCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          FailWorkflowExecutionCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser FailWorkflowExecutionCommandAttributes
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
                                       "failure"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failure") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "FailWorkflowExecutionCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'failure") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData FailWorkflowExecutionCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_FailWorkflowExecutionCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_FailWorkflowExecutionCommandAttributes'failure x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.upsertedMemo' @:: Lens' ModifyWorkflowPropertiesCommandAttributes Proto.Temporal.Api.Common.V1.Message.Memo@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'upsertedMemo' @:: Lens' ModifyWorkflowPropertiesCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo)@ -}
data ModifyWorkflowPropertiesCommandAttributes
  = ModifyWorkflowPropertiesCommandAttributes'_constructor {_ModifyWorkflowPropertiesCommandAttributes'upsertedMemo :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo),
                                                            _ModifyWorkflowPropertiesCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ModifyWorkflowPropertiesCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ModifyWorkflowPropertiesCommandAttributes "upsertedMemo" Proto.Temporal.Api.Common.V1.Message.Memo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ModifyWorkflowPropertiesCommandAttributes'upsertedMemo
           (\ x__ y__
              -> x__
                   {_ModifyWorkflowPropertiesCommandAttributes'upsertedMemo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ModifyWorkflowPropertiesCommandAttributes "maybe'upsertedMemo" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ModifyWorkflowPropertiesCommandAttributes'upsertedMemo
           (\ x__ y__
              -> x__
                   {_ModifyWorkflowPropertiesCommandAttributes'upsertedMemo = y__}))
        Prelude.id
instance Data.ProtoLens.Message ModifyWorkflowPropertiesCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.ModifyWorkflowPropertiesCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \)ModifyWorkflowPropertiesCommandAttributes\DC2A\n\
      \\rupserted_memo\CAN\SOH \SOH(\v2\FS.temporal.api.common.v1.MemoR\fupsertedMemo"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        upsertedMemo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "upserted_memo"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Memo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'upsertedMemo")) ::
              Data.ProtoLens.FieldDescriptor ModifyWorkflowPropertiesCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, upsertedMemo__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ModifyWorkflowPropertiesCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_ModifyWorkflowPropertiesCommandAttributes'_unknownFields = y__})
  defMessage
    = ModifyWorkflowPropertiesCommandAttributes'_constructor
        {_ModifyWorkflowPropertiesCommandAttributes'upsertedMemo = Prelude.Nothing,
         _ModifyWorkflowPropertiesCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ModifyWorkflowPropertiesCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser ModifyWorkflowPropertiesCommandAttributes
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
                                       "upserted_memo"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"upsertedMemo") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ModifyWorkflowPropertiesCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'upsertedMemo") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData ModifyWorkflowPropertiesCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ModifyWorkflowPropertiesCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ModifyWorkflowPropertiesCommandAttributes'upsertedMemo x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.messageId' @:: Lens' ProtocolMessageCommandAttributes Data.Text.Text@ -}
data ProtocolMessageCommandAttributes
  = ProtocolMessageCommandAttributes'_constructor {_ProtocolMessageCommandAttributes'messageId :: !Data.Text.Text,
                                                   _ProtocolMessageCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ProtocolMessageCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ProtocolMessageCommandAttributes "messageId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ProtocolMessageCommandAttributes'messageId
           (\ x__ y__
              -> x__ {_ProtocolMessageCommandAttributes'messageId = y__}))
        Prelude.id
instance Data.ProtoLens.Message ProtocolMessageCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.ProtocolMessageCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \ ProtocolMessageCommandAttributes\DC2\GS\n\
      \\n\
      \message_id\CAN\SOH \SOH(\tR\tmessageId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        messageId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "message_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"messageId")) ::
              Data.ProtoLens.FieldDescriptor ProtocolMessageCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, messageId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ProtocolMessageCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__ {_ProtocolMessageCommandAttributes'_unknownFields = y__})
  defMessage
    = ProtocolMessageCommandAttributes'_constructor
        {_ProtocolMessageCommandAttributes'messageId = Data.ProtoLens.fieldDefault,
         _ProtocolMessageCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ProtocolMessageCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser ProtocolMessageCommandAttributes
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
                                       "message_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"messageId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ProtocolMessageCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"messageId") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData ProtocolMessageCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ProtocolMessageCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ProtocolMessageCommandAttributes'messageId x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.markerName' @:: Lens' RecordMarkerCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.details' @:: Lens' RecordMarkerCommandAttributes (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.header' @:: Lens' RecordMarkerCommandAttributes Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'header' @:: Lens' RecordMarkerCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.failure' @:: Lens' RecordMarkerCommandAttributes Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'failure' @:: Lens' RecordMarkerCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@ -}
data RecordMarkerCommandAttributes
  = RecordMarkerCommandAttributes'_constructor {_RecordMarkerCommandAttributes'markerName :: !Data.Text.Text,
                                                _RecordMarkerCommandAttributes'details :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                _RecordMarkerCommandAttributes'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                                _RecordMarkerCommandAttributes'failure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                                _RecordMarkerCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RecordMarkerCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes "markerName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'markerName
           (\ x__ y__
              -> x__ {_RecordMarkerCommandAttributes'markerName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes "details" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'details
           (\ x__ y__ -> x__ {_RecordMarkerCommandAttributes'details = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'header
           (\ x__ y__ -> x__ {_RecordMarkerCommandAttributes'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'header
           (\ x__ y__ -> x__ {_RecordMarkerCommandAttributes'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'failure
           (\ x__ y__ -> x__ {_RecordMarkerCommandAttributes'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'failure
           (\ x__ y__ -> x__ {_RecordMarkerCommandAttributes'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message RecordMarkerCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.RecordMarkerCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \\GSRecordMarkerCommandAttributes\DC2\US\n\
      \\vmarker_name\CAN\SOH \SOH(\tR\n\
      \markerName\DC2]\n\
      \\adetails\CAN\STX \ETX(\v2C.temporal.api.command.v1.RecordMarkerCommandAttributes.DetailsEntryR\adetails\DC26\n\
      \\ACKheader\CAN\ETX \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2:\n\
      \\afailure\CAN\EOT \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\SUB\\\n\
      \\fDetailsEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC26\n\
      \\ENQvalue\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        markerName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "marker_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"markerName")) ::
              Data.ProtoLens.FieldDescriptor RecordMarkerCommandAttributes
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor RecordMarkerCommandAttributes'DetailsEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                    Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"details")) ::
              Data.ProtoLens.FieldDescriptor RecordMarkerCommandAttributes
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor RecordMarkerCommandAttributes
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor RecordMarkerCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, markerName__field_descriptor),
           (Data.ProtoLens.Tag 2, details__field_descriptor),
           (Data.ProtoLens.Tag 3, header__field_descriptor),
           (Data.ProtoLens.Tag 4, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RecordMarkerCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__ {_RecordMarkerCommandAttributes'_unknownFields = y__})
  defMessage
    = RecordMarkerCommandAttributes'_constructor
        {_RecordMarkerCommandAttributes'markerName = Data.ProtoLens.fieldDefault,
         _RecordMarkerCommandAttributes'details = Data.Map.empty,
         _RecordMarkerCommandAttributes'header = Prelude.Nothing,
         _RecordMarkerCommandAttributes'failure = Prelude.Nothing,
         _RecordMarkerCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RecordMarkerCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser RecordMarkerCommandAttributes
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
                                       "marker_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"markerName") y x)
                        18
                          -> do !(entry :: RecordMarkerCommandAttributes'DetailsEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                            (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                                Data.ProtoLens.Encoding.Bytes.isolate
                                                                                                  (Prelude.fromIntegral
                                                                                                     len)
                                                                                                  Data.ProtoLens.parseMessage)
                                                                                            "details"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"details")
                                        (\ !t -> Data.Map.insert key value t) x))
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "failure"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failure") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "RecordMarkerCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"markerName") _x
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
                (Data.Monoid.mconcat
                   (Prelude.map
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                    (Lens.Family2.set
                                       (Data.ProtoLens.Field.field @"value") (Prelude.snd _v)
                                       (Data.ProtoLens.defMessage ::
                                          RecordMarkerCommandAttributes'DetailsEntry)))))
                      (Data.Map.toList
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"details") _x))))
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'header") _x
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
                      (case
                           Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'failure") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just _v)
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage _v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData RecordMarkerCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RecordMarkerCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_RecordMarkerCommandAttributes'markerName x__)
                (Control.DeepSeq.deepseq
                   (_RecordMarkerCommandAttributes'details x__)
                   (Control.DeepSeq.deepseq
                      (_RecordMarkerCommandAttributes'header x__)
                      (Control.DeepSeq.deepseq
                         (_RecordMarkerCommandAttributes'failure x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.key' @:: Lens' RecordMarkerCommandAttributes'DetailsEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.value' @:: Lens' RecordMarkerCommandAttributes'DetailsEntry Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'value' @:: Lens' RecordMarkerCommandAttributes'DetailsEntry (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@ -}
data RecordMarkerCommandAttributes'DetailsEntry
  = RecordMarkerCommandAttributes'DetailsEntry'_constructor {_RecordMarkerCommandAttributes'DetailsEntry'key :: !Data.Text.Text,
                                                             _RecordMarkerCommandAttributes'DetailsEntry'value :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                             _RecordMarkerCommandAttributes'DetailsEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RecordMarkerCommandAttributes'DetailsEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes'DetailsEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'DetailsEntry'key
           (\ x__ y__
              -> x__ {_RecordMarkerCommandAttributes'DetailsEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes'DetailsEntry "value" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'DetailsEntry'value
           (\ x__ y__
              -> x__ {_RecordMarkerCommandAttributes'DetailsEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField RecordMarkerCommandAttributes'DetailsEntry "maybe'value" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RecordMarkerCommandAttributes'DetailsEntry'value
           (\ x__ y__
              -> x__ {_RecordMarkerCommandAttributes'DetailsEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message RecordMarkerCommandAttributes'DetailsEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.RecordMarkerCommandAttributes.DetailsEntry"
  packedMessageDescriptor _
    = "\n\
      \\fDetailsEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC26\n\
      \\ENQvalue\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor RecordMarkerCommandAttributes'DetailsEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor RecordMarkerCommandAttributes'DetailsEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RecordMarkerCommandAttributes'DetailsEntry'_unknownFields
        (\ x__ y__
           -> x__
                {_RecordMarkerCommandAttributes'DetailsEntry'_unknownFields = y__})
  defMessage
    = RecordMarkerCommandAttributes'DetailsEntry'_constructor
        {_RecordMarkerCommandAttributes'DetailsEntry'key = Data.ProtoLens.fieldDefault,
         _RecordMarkerCommandAttributes'DetailsEntry'value = Prelude.Nothing,
         _RecordMarkerCommandAttributes'DetailsEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RecordMarkerCommandAttributes'DetailsEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser RecordMarkerCommandAttributes'DetailsEntry
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
          (do loop Data.ProtoLens.defMessage) "DetailsEntry"
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
instance Control.DeepSeq.NFData RecordMarkerCommandAttributes'DetailsEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RecordMarkerCommandAttributes'DetailsEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_RecordMarkerCommandAttributes'DetailsEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_RecordMarkerCommandAttributes'DetailsEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.scheduledEventId' @:: Lens' RequestCancelActivityTaskCommandAttributes Data.Int.Int64@ -}
data RequestCancelActivityTaskCommandAttributes
  = RequestCancelActivityTaskCommandAttributes'_constructor {_RequestCancelActivityTaskCommandAttributes'scheduledEventId :: !Data.Int.Int64,
                                                             _RequestCancelActivityTaskCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RequestCancelActivityTaskCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RequestCancelActivityTaskCommandAttributes "scheduledEventId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RequestCancelActivityTaskCommandAttributes'scheduledEventId
           (\ x__ y__
              -> x__
                   {_RequestCancelActivityTaskCommandAttributes'scheduledEventId = y__}))
        Prelude.id
instance Data.ProtoLens.Message RequestCancelActivityTaskCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.RequestCancelActivityTaskCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \*RequestCancelActivityTaskCommandAttributes\DC2,\n\
      \\DC2scheduled_event_id\CAN\SOH \SOH(\ETXR\DLEscheduledEventId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        scheduledEventId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scheduled_event_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"scheduledEventId")) ::
              Data.ProtoLens.FieldDescriptor RequestCancelActivityTaskCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, scheduledEventId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RequestCancelActivityTaskCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_RequestCancelActivityTaskCommandAttributes'_unknownFields = y__})
  defMessage
    = RequestCancelActivityTaskCommandAttributes'_constructor
        {_RequestCancelActivityTaskCommandAttributes'scheduledEventId = Data.ProtoLens.fieldDefault,
         _RequestCancelActivityTaskCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RequestCancelActivityTaskCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser RequestCancelActivityTaskCommandAttributes
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
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "scheduled_event_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduledEventId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "RequestCancelActivityTaskCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"scheduledEventId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData RequestCancelActivityTaskCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RequestCancelActivityTaskCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_RequestCancelActivityTaskCommandAttributes'scheduledEventId x__)
                ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.namespace' @:: Lens' RequestCancelExternalWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowId' @:: Lens' RequestCancelExternalWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.runId' @:: Lens' RequestCancelExternalWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.control' @:: Lens' RequestCancelExternalWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.childWorkflowOnly' @:: Lens' RequestCancelExternalWorkflowExecutionCommandAttributes Prelude.Bool@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.reason' @:: Lens' RequestCancelExternalWorkflowExecutionCommandAttributes Data.Text.Text@ -}
data RequestCancelExternalWorkflowExecutionCommandAttributes
  = RequestCancelExternalWorkflowExecutionCommandAttributes'_constructor {_RequestCancelExternalWorkflowExecutionCommandAttributes'namespace :: !Data.Text.Text,
                                                                          _RequestCancelExternalWorkflowExecutionCommandAttributes'workflowId :: !Data.Text.Text,
                                                                          _RequestCancelExternalWorkflowExecutionCommandAttributes'runId :: !Data.Text.Text,
                                                                          _RequestCancelExternalWorkflowExecutionCommandAttributes'control :: !Data.Text.Text,
                                                                          _RequestCancelExternalWorkflowExecutionCommandAttributes'childWorkflowOnly :: !Prelude.Bool,
                                                                          _RequestCancelExternalWorkflowExecutionCommandAttributes'reason :: !Data.Text.Text,
                                                                          _RequestCancelExternalWorkflowExecutionCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RequestCancelExternalWorkflowExecutionCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RequestCancelExternalWorkflowExecutionCommandAttributes "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RequestCancelExternalWorkflowExecutionCommandAttributes'namespace
           (\ x__ y__
              -> x__
                   {_RequestCancelExternalWorkflowExecutionCommandAttributes'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RequestCancelExternalWorkflowExecutionCommandAttributes "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RequestCancelExternalWorkflowExecutionCommandAttributes'workflowId
           (\ x__ y__
              -> x__
                   {_RequestCancelExternalWorkflowExecutionCommandAttributes'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RequestCancelExternalWorkflowExecutionCommandAttributes "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RequestCancelExternalWorkflowExecutionCommandAttributes'runId
           (\ x__ y__
              -> x__
                   {_RequestCancelExternalWorkflowExecutionCommandAttributes'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RequestCancelExternalWorkflowExecutionCommandAttributes "control" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RequestCancelExternalWorkflowExecutionCommandAttributes'control
           (\ x__ y__
              -> x__
                   {_RequestCancelExternalWorkflowExecutionCommandAttributes'control = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RequestCancelExternalWorkflowExecutionCommandAttributes "childWorkflowOnly" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RequestCancelExternalWorkflowExecutionCommandAttributes'childWorkflowOnly
           (\ x__ y__
              -> x__
                   {_RequestCancelExternalWorkflowExecutionCommandAttributes'childWorkflowOnly = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RequestCancelExternalWorkflowExecutionCommandAttributes "reason" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RequestCancelExternalWorkflowExecutionCommandAttributes'reason
           (\ x__ y__
              -> x__
                   {_RequestCancelExternalWorkflowExecutionCommandAttributes'reason = y__}))
        Prelude.id
instance Data.ProtoLens.Message RequestCancelExternalWorkflowExecutionCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.RequestCancelExternalWorkflowExecutionCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \7RequestCancelExternalWorkflowExecutionCommandAttributes\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
      \\vworkflow_id\CAN\STX \SOH(\tR\n\
      \workflowId\DC2\NAK\n\
      \\ACKrun_id\CAN\ETX \SOH(\tR\ENQrunId\DC2\CAN\n\
      \\acontrol\CAN\EOT \SOH(\tR\acontrol\DC2.\n\
      \\DC3child_workflow_only\CAN\ENQ \SOH(\bR\DC1childWorkflowOnly\DC2\SYN\n\
      \\ACKreason\CAN\ACK \SOH(\tR\ACKreason"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        namespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"namespace")) ::
              Data.ProtoLens.FieldDescriptor RequestCancelExternalWorkflowExecutionCommandAttributes
        workflowId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowId")) ::
              Data.ProtoLens.FieldDescriptor RequestCancelExternalWorkflowExecutionCommandAttributes
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor RequestCancelExternalWorkflowExecutionCommandAttributes
        control__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "control"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"control")) ::
              Data.ProtoLens.FieldDescriptor RequestCancelExternalWorkflowExecutionCommandAttributes
        childWorkflowOnly__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "child_workflow_only"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"childWorkflowOnly")) ::
              Data.ProtoLens.FieldDescriptor RequestCancelExternalWorkflowExecutionCommandAttributes
        reason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"reason")) ::
              Data.ProtoLens.FieldDescriptor RequestCancelExternalWorkflowExecutionCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 3, runId__field_descriptor),
           (Data.ProtoLens.Tag 4, control__field_descriptor),
           (Data.ProtoLens.Tag 5, childWorkflowOnly__field_descriptor),
           (Data.ProtoLens.Tag 6, reason__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RequestCancelExternalWorkflowExecutionCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_RequestCancelExternalWorkflowExecutionCommandAttributes'_unknownFields = y__})
  defMessage
    = RequestCancelExternalWorkflowExecutionCommandAttributes'_constructor
        {_RequestCancelExternalWorkflowExecutionCommandAttributes'namespace = Data.ProtoLens.fieldDefault,
         _RequestCancelExternalWorkflowExecutionCommandAttributes'workflowId = Data.ProtoLens.fieldDefault,
         _RequestCancelExternalWorkflowExecutionCommandAttributes'runId = Data.ProtoLens.fieldDefault,
         _RequestCancelExternalWorkflowExecutionCommandAttributes'control = Data.ProtoLens.fieldDefault,
         _RequestCancelExternalWorkflowExecutionCommandAttributes'childWorkflowOnly = Data.ProtoLens.fieldDefault,
         _RequestCancelExternalWorkflowExecutionCommandAttributes'reason = Data.ProtoLens.fieldDefault,
         _RequestCancelExternalWorkflowExecutionCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RequestCancelExternalWorkflowExecutionCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser RequestCancelExternalWorkflowExecutionCommandAttributes
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
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "workflow_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"workflowId") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "run_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"runId") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "control"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"control") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "child_workflow_only"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"childWorkflowOnly") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
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
          (do loop Data.ProtoLens.defMessage)
          "RequestCancelExternalWorkflowExecutionCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"namespace") _x
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
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowId") _x
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
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"runId") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   ((Data.Monoid.<>)
                      (let
                         _v = Lens.Family2.view (Data.ProtoLens.Field.field @"control") _x
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
                              = Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"childWorkflowOnly") _x
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
                               _v = Lens.Family2.view (Data.ProtoLens.Field.field @"reason") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                     ((Prelude..)
                                        (\ bs
                                           -> (Data.Monoid.<>)
                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                   (Prelude.fromIntegral
                                                      (Data.ByteString.length bs)))
                                                (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                        Data.Text.Encoding.encodeUtf8 _v))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData RequestCancelExternalWorkflowExecutionCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RequestCancelExternalWorkflowExecutionCommandAttributes'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_RequestCancelExternalWorkflowExecutionCommandAttributes'namespace
                   x__)
                (Control.DeepSeq.deepseq
                   (_RequestCancelExternalWorkflowExecutionCommandAttributes'workflowId
                      x__)
                   (Control.DeepSeq.deepseq
                      (_RequestCancelExternalWorkflowExecutionCommandAttributes'runId
                         x__)
                      (Control.DeepSeq.deepseq
                         (_RequestCancelExternalWorkflowExecutionCommandAttributes'control
                            x__)
                         (Control.DeepSeq.deepseq
                            (_RequestCancelExternalWorkflowExecutionCommandAttributes'childWorkflowOnly
                               x__)
                            (Control.DeepSeq.deepseq
                               (_RequestCancelExternalWorkflowExecutionCommandAttributes'reason
                                  x__)
                               ()))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.activityId' @:: Lens' ScheduleActivityTaskCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.activityType' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Temporal.Api.Common.V1.Message.ActivityType@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'activityType' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ActivityType)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.taskQueue' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'taskQueue' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.header' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'header' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.input' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'input' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.scheduleToCloseTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'scheduleToCloseTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.scheduleToStartTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'scheduleToStartTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.startToCloseTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'startToCloseTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.heartbeatTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'heartbeatTimeout' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.retryPolicy' @:: Lens' ScheduleActivityTaskCommandAttributes Proto.Temporal.Api.Common.V1.Message.RetryPolicy@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'retryPolicy' @:: Lens' ScheduleActivityTaskCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.requestEagerExecution' @:: Lens' ScheduleActivityTaskCommandAttributes Prelude.Bool@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.useCompatibleVersion' @:: Lens' ScheduleActivityTaskCommandAttributes Prelude.Bool@ -}
data ScheduleActivityTaskCommandAttributes
  = ScheduleActivityTaskCommandAttributes'_constructor {_ScheduleActivityTaskCommandAttributes'activityId :: !Data.Text.Text,
                                                        _ScheduleActivityTaskCommandAttributes'activityType :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ActivityType),
                                                        _ScheduleActivityTaskCommandAttributes'taskQueue :: !(Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue),
                                                        _ScheduleActivityTaskCommandAttributes'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                                        _ScheduleActivityTaskCommandAttributes'input :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                        _ScheduleActivityTaskCommandAttributes'scheduleToCloseTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                        _ScheduleActivityTaskCommandAttributes'scheduleToStartTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                        _ScheduleActivityTaskCommandAttributes'startToCloseTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                        _ScheduleActivityTaskCommandAttributes'heartbeatTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                        _ScheduleActivityTaskCommandAttributes'retryPolicy :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy),
                                                        _ScheduleActivityTaskCommandAttributes'requestEagerExecution :: !Prelude.Bool,
                                                        _ScheduleActivityTaskCommandAttributes'useCompatibleVersion :: !Prelude.Bool,
                                                        _ScheduleActivityTaskCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ScheduleActivityTaskCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "activityId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'activityId
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'activityId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "activityType" Proto.Temporal.Api.Common.V1.Message.ActivityType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'activityType
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'activityType = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'activityType" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ActivityType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'activityType
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'activityType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "taskQueue" Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'taskQueue
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'taskQueue = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'taskQueue" (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'taskQueue
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'header
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'header
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "input" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'input
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'input = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'input" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'input
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "scheduleToCloseTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'scheduleToCloseTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'scheduleToCloseTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'scheduleToCloseTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'scheduleToCloseTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'scheduleToCloseTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "scheduleToStartTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'scheduleToStartTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'scheduleToStartTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'scheduleToStartTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'scheduleToStartTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'scheduleToStartTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "startToCloseTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'startToCloseTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'startToCloseTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'startToCloseTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'startToCloseTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'startToCloseTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "heartbeatTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'heartbeatTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'heartbeatTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'heartbeatTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'heartbeatTimeout
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'heartbeatTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "retryPolicy" Proto.Temporal.Api.Common.V1.Message.RetryPolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'retryPolicy
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'retryPolicy = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "maybe'retryPolicy" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'retryPolicy
           (\ x__ y__
              -> x__ {_ScheduleActivityTaskCommandAttributes'retryPolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "requestEagerExecution" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'requestEagerExecution
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'requestEagerExecution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ScheduleActivityTaskCommandAttributes "useCompatibleVersion" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ScheduleActivityTaskCommandAttributes'useCompatibleVersion
           (\ x__ y__
              -> x__
                   {_ScheduleActivityTaskCommandAttributes'useCompatibleVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Message ScheduleActivityTaskCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.ScheduleActivityTaskCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \%ScheduleActivityTaskCommandAttributes\DC2\US\n\
      \\vactivity_id\CAN\SOH \SOH(\tR\n\
      \activityId\DC2I\n\
      \\ractivity_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.ActivityTypeR\factivityType\DC2C\n\
      \\n\
      \task_queue\CAN\EOT \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
      \\ACKheader\CAN\ENQ \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC26\n\
      \\ENQinput\CAN\ACK \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2Z\n\
      \\EMschedule_to_close_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToCloseTimeoutB\EOT\152\223\US\SOH\DC2Z\n\
      \\EMschedule_to_start_timeout\CAN\b \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToStartTimeoutB\EOT\152\223\US\SOH\DC2T\n\
      \\SYNstart_to_close_timeout\CAN\t \SOH(\v2\EM.google.protobuf.DurationR\DC3startToCloseTimeoutB\EOT\152\223\US\SOH\DC2L\n\
      \\DC1heartbeat_timeout\CAN\n\
      \ \SOH(\v2\EM.google.protobuf.DurationR\DLEheartbeatTimeoutB\EOT\152\223\US\SOH\DC2F\n\
      \\fretry_policy\CAN\v \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC26\n\
      \\ETBrequest_eager_execution\CAN\f \SOH(\bR\NAKrequestEagerExecution\DC24\n\
      \\SYNuse_compatible_version\CAN\r \SOH(\bR\DC4useCompatibleVersionJ\EOT\b\ETX\DLE\EOT"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        activityId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"activityId")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        activityType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_type"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.ActivityType)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'activityType")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'taskQueue")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'input")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        scheduleToCloseTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schedule_to_close_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduleToCloseTimeout")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        scheduleToStartTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schedule_to_start_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduleToStartTimeout")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        startToCloseTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_to_close_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startToCloseTimeout")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        heartbeatTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "heartbeat_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'heartbeatTimeout")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        retryPolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "retry_policy"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.RetryPolicy)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'retryPolicy")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        requestEagerExecution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "request_eager_execution"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"requestEagerExecution")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
        useCompatibleVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "use_compatible_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"useCompatibleVersion")) ::
              Data.ProtoLens.FieldDescriptor ScheduleActivityTaskCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, activityId__field_descriptor),
           (Data.ProtoLens.Tag 2, activityType__field_descriptor),
           (Data.ProtoLens.Tag 4, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 5, header__field_descriptor),
           (Data.ProtoLens.Tag 6, input__field_descriptor),
           (Data.ProtoLens.Tag 7, scheduleToCloseTimeout__field_descriptor),
           (Data.ProtoLens.Tag 8, scheduleToStartTimeout__field_descriptor),
           (Data.ProtoLens.Tag 9, startToCloseTimeout__field_descriptor),
           (Data.ProtoLens.Tag 10, heartbeatTimeout__field_descriptor),
           (Data.ProtoLens.Tag 11, retryPolicy__field_descriptor),
           (Data.ProtoLens.Tag 12, requestEagerExecution__field_descriptor),
           (Data.ProtoLens.Tag 13, useCompatibleVersion__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ScheduleActivityTaskCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_ScheduleActivityTaskCommandAttributes'_unknownFields = y__})
  defMessage
    = ScheduleActivityTaskCommandAttributes'_constructor
        {_ScheduleActivityTaskCommandAttributes'activityId = Data.ProtoLens.fieldDefault,
         _ScheduleActivityTaskCommandAttributes'activityType = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'taskQueue = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'header = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'input = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'scheduleToCloseTimeout = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'scheduleToStartTimeout = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'startToCloseTimeout = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'heartbeatTimeout = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'retryPolicy = Prelude.Nothing,
         _ScheduleActivityTaskCommandAttributes'requestEagerExecution = Data.ProtoLens.fieldDefault,
         _ScheduleActivityTaskCommandAttributes'useCompatibleVersion = Data.ProtoLens.fieldDefault,
         _ScheduleActivityTaskCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ScheduleActivityTaskCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser ScheduleActivityTaskCommandAttributes
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
                                       "activity_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"activityId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "activity_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activityType") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "input"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"input") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "schedule_to_close_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduleToCloseTimeout") y x)
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "schedule_to_start_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduleToStartTimeout") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_to_close_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startToCloseTimeout") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "heartbeat_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"heartbeatTimeout") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "retry_policy"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"retryPolicy") y x)
                        96
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "request_eager_execution"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"requestEagerExecution") y x)
                        104
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "use_compatible_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"useCompatibleVersion") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ScheduleActivityTaskCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"activityId") _x
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
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'activityType") _x
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
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'taskQueue") _x
                    of
                      Prelude.Nothing -> Data.Monoid.mempty
                      (Prelude.Just _v)
                        -> (Data.Monoid.<>)
                             (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                             ((Prelude..)
                                (\ bs
                                   -> (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (Prelude.fromIntegral (Data.ByteString.length bs)))
                                        (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                Data.ProtoLens.encodeMessage _v))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'header") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just _v)
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage _v))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'input") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just _v)
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         ((Data.Monoid.<>)
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'scheduleToCloseTimeout") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
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
                            ((Data.Monoid.<>)
                               (case
                                    Lens.Family2.view
                                      (Data.ProtoLens.Field.field @"maybe'scheduleToStartTimeout")
                                      _x
                                of
                                  Prelude.Nothing -> Data.Monoid.mempty
                                  (Prelude.Just _v)
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
                               ((Data.Monoid.<>)
                                  (case
                                       Lens.Family2.view
                                         (Data.ProtoLens.Field.field @"maybe'startToCloseTimeout")
                                         _x
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
                                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                               Data.ProtoLens.encodeMessage _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'heartbeatTimeout")
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
                                               (Data.ProtoLens.Field.field @"maybe'retryPolicy") _x
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
                                                    (Data.ProtoLens.Field.field
                                                       @"requestEagerExecution")
                                                    _x
                                            in
                                              if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                  Data.Monoid.mempty
                                              else
                                                  (Data.Monoid.<>)
                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 96)
                                                    ((Prelude..)
                                                       Data.ProtoLens.Encoding.Bytes.putVarInt
                                                       (\ b -> if b then 1 else 0) _v))
                                           ((Data.Monoid.<>)
                                              (let
                                                 _v
                                                   = Lens.Family2.view
                                                       (Data.ProtoLens.Field.field
                                                          @"useCompatibleVersion")
                                                       _x
                                               in
                                                 if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                     Data.Monoid.mempty
                                                 else
                                                     (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 104)
                                                       ((Prelude..)
                                                          Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          (\ b -> if b then 1 else 0) _v))
                                              (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                 (Lens.Family2.view
                                                    Data.ProtoLens.unknownFields _x)))))))))))))
instance Control.DeepSeq.NFData ScheduleActivityTaskCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ScheduleActivityTaskCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ScheduleActivityTaskCommandAttributes'activityId x__)
                (Control.DeepSeq.deepseq
                   (_ScheduleActivityTaskCommandAttributes'activityType x__)
                   (Control.DeepSeq.deepseq
                      (_ScheduleActivityTaskCommandAttributes'taskQueue x__)
                      (Control.DeepSeq.deepseq
                         (_ScheduleActivityTaskCommandAttributes'header x__)
                         (Control.DeepSeq.deepseq
                            (_ScheduleActivityTaskCommandAttributes'input x__)
                            (Control.DeepSeq.deepseq
                               (_ScheduleActivityTaskCommandAttributes'scheduleToCloseTimeout x__)
                               (Control.DeepSeq.deepseq
                                  (_ScheduleActivityTaskCommandAttributes'scheduleToStartTimeout
                                     x__)
                                  (Control.DeepSeq.deepseq
                                     (_ScheduleActivityTaskCommandAttributes'startToCloseTimeout
                                        x__)
                                     (Control.DeepSeq.deepseq
                                        (_ScheduleActivityTaskCommandAttributes'heartbeatTimeout
                                           x__)
                                        (Control.DeepSeq.deepseq
                                           (_ScheduleActivityTaskCommandAttributes'retryPolicy x__)
                                           (Control.DeepSeq.deepseq
                                              (_ScheduleActivityTaskCommandAttributes'requestEagerExecution
                                                 x__)
                                              (Control.DeepSeq.deepseq
                                                 (_ScheduleActivityTaskCommandAttributes'useCompatibleVersion
                                                    x__)
                                                 ()))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.namespace' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.execution' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.WorkflowExecution@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'execution' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.signalName' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.input' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'input' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.control' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.childWorkflowOnly' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes Prelude.Bool@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.header' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'header' @:: Lens' SignalExternalWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@ -}
data SignalExternalWorkflowExecutionCommandAttributes
  = SignalExternalWorkflowExecutionCommandAttributes'_constructor {_SignalExternalWorkflowExecutionCommandAttributes'namespace :: !Data.Text.Text,
                                                                   _SignalExternalWorkflowExecutionCommandAttributes'execution :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution),
                                                                   _SignalExternalWorkflowExecutionCommandAttributes'signalName :: !Data.Text.Text,
                                                                   _SignalExternalWorkflowExecutionCommandAttributes'input :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                                   _SignalExternalWorkflowExecutionCommandAttributes'control :: !Data.Text.Text,
                                                                   _SignalExternalWorkflowExecutionCommandAttributes'childWorkflowOnly :: !Prelude.Bool,
                                                                   _SignalExternalWorkflowExecutionCommandAttributes'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                                                   _SignalExternalWorkflowExecutionCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SignalExternalWorkflowExecutionCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'namespace
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "execution" Proto.Temporal.Api.Common.V1.Message.WorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'execution
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'execution = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "maybe'execution" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'execution
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'execution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "signalName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'signalName
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'signalName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "input" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'input
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'input = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "maybe'input" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'input
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "control" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'control
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'control = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "childWorkflowOnly" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'childWorkflowOnly
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'childWorkflowOnly = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'header
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SignalExternalWorkflowExecutionCommandAttributes "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalExternalWorkflowExecutionCommandAttributes'header
           (\ x__ y__
              -> x__
                   {_SignalExternalWorkflowExecutionCommandAttributes'header = y__}))
        Prelude.id
instance Data.ProtoLens.Message SignalExternalWorkflowExecutionCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.SignalExternalWorkflowExecutionCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \0SignalExternalWorkflowExecutionCommandAttributes\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2G\n\
      \\texecution\CAN\STX \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\texecution\DC2\US\n\
      \\vsignal_name\CAN\ETX \SOH(\tR\n\
      \signalName\DC26\n\
      \\ENQinput\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2\CAN\n\
      \\acontrol\CAN\ENQ \SOH(\tR\acontrol\DC2.\n\
      \\DC3child_workflow_only\CAN\ACK \SOH(\bR\DC1childWorkflowOnly\DC26\n\
      \\ACKheader\CAN\a \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        namespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"namespace")) ::
              Data.ProtoLens.FieldDescriptor SignalExternalWorkflowExecutionCommandAttributes
        execution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'execution")) ::
              Data.ProtoLens.FieldDescriptor SignalExternalWorkflowExecutionCommandAttributes
        signalName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "signal_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"signalName")) ::
              Data.ProtoLens.FieldDescriptor SignalExternalWorkflowExecutionCommandAttributes
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'input")) ::
              Data.ProtoLens.FieldDescriptor SignalExternalWorkflowExecutionCommandAttributes
        control__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "control"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"control")) ::
              Data.ProtoLens.FieldDescriptor SignalExternalWorkflowExecutionCommandAttributes
        childWorkflowOnly__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "child_workflow_only"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"childWorkflowOnly")) ::
              Data.ProtoLens.FieldDescriptor SignalExternalWorkflowExecutionCommandAttributes
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor SignalExternalWorkflowExecutionCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, execution__field_descriptor),
           (Data.ProtoLens.Tag 3, signalName__field_descriptor),
           (Data.ProtoLens.Tag 4, input__field_descriptor),
           (Data.ProtoLens.Tag 5, control__field_descriptor),
           (Data.ProtoLens.Tag 6, childWorkflowOnly__field_descriptor),
           (Data.ProtoLens.Tag 7, header__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SignalExternalWorkflowExecutionCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_SignalExternalWorkflowExecutionCommandAttributes'_unknownFields = y__})
  defMessage
    = SignalExternalWorkflowExecutionCommandAttributes'_constructor
        {_SignalExternalWorkflowExecutionCommandAttributes'namespace = Data.ProtoLens.fieldDefault,
         _SignalExternalWorkflowExecutionCommandAttributes'execution = Prelude.Nothing,
         _SignalExternalWorkflowExecutionCommandAttributes'signalName = Data.ProtoLens.fieldDefault,
         _SignalExternalWorkflowExecutionCommandAttributes'input = Prelude.Nothing,
         _SignalExternalWorkflowExecutionCommandAttributes'control = Data.ProtoLens.fieldDefault,
         _SignalExternalWorkflowExecutionCommandAttributes'childWorkflowOnly = Data.ProtoLens.fieldDefault,
         _SignalExternalWorkflowExecutionCommandAttributes'header = Prelude.Nothing,
         _SignalExternalWorkflowExecutionCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SignalExternalWorkflowExecutionCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser SignalExternalWorkflowExecutionCommandAttributes
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
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "execution"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"execution") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "signal_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"signalName") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "input"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"input") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "control"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"control") y x)
                        48
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "child_workflow_only"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"childWorkflowOnly") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "SignalExternalWorkflowExecutionCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"namespace") _x
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
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'execution") _x
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
                ((Data.Monoid.<>)
                   (let
                      _v
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"signalName") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'input") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just _v)
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage _v))
                      ((Data.Monoid.<>)
                         (let
                            _v = Lens.Family2.view (Data.ProtoLens.Field.field @"control") _x
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
                            (let
                               _v
                                 = Lens.Family2.view
                                     (Data.ProtoLens.Field.field @"childWorkflowOnly") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 48)
                                     ((Prelude..)
                                        Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (\ b -> if b then 1 else 0) _v))
                            ((Data.Monoid.<>)
                               (case
                                    Lens.Family2.view
                                      (Data.ProtoLens.Field.field @"maybe'header") _x
                                of
                                  Prelude.Nothing -> Data.Monoid.mempty
                                  (Prelude.Just _v)
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
                               (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                  (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))
instance Control.DeepSeq.NFData SignalExternalWorkflowExecutionCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SignalExternalWorkflowExecutionCommandAttributes'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_SignalExternalWorkflowExecutionCommandAttributes'namespace x__)
                (Control.DeepSeq.deepseq
                   (_SignalExternalWorkflowExecutionCommandAttributes'execution x__)
                   (Control.DeepSeq.deepseq
                      (_SignalExternalWorkflowExecutionCommandAttributes'signalName x__)
                      (Control.DeepSeq.deepseq
                         (_SignalExternalWorkflowExecutionCommandAttributes'input x__)
                         (Control.DeepSeq.deepseq
                            (_SignalExternalWorkflowExecutionCommandAttributes'control x__)
                            (Control.DeepSeq.deepseq
                               (_SignalExternalWorkflowExecutionCommandAttributes'childWorkflowOnly
                                  x__)
                               (Control.DeepSeq.deepseq
                                  (_SignalExternalWorkflowExecutionCommandAttributes'header x__)
                                  ())))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.namespace' @:: Lens' StartChildWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowId' @:: Lens' StartChildWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowType' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.WorkflowType@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'workflowType' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.taskQueue' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'taskQueue' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.input' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'input' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowExecutionTimeout' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'workflowExecutionTimeout' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowRunTimeout' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'workflowRunTimeout' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowTaskTimeout' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'workflowTaskTimeout' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.parentClosePolicy' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.control' @:: Lens' StartChildWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.workflowIdReusePolicy' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.retryPolicy' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.RetryPolicy@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'retryPolicy' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.cronSchedule' @:: Lens' StartChildWorkflowExecutionCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.header' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'header' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.memo' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.Memo@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'memo' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.searchAttributes' @:: Lens' StartChildWorkflowExecutionCommandAttributes Proto.Temporal.Api.Common.V1.Message.SearchAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'searchAttributes' @:: Lens' StartChildWorkflowExecutionCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes)@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.useCompatibleVersion' @:: Lens' StartChildWorkflowExecutionCommandAttributes Prelude.Bool@ -}
data StartChildWorkflowExecutionCommandAttributes
  = StartChildWorkflowExecutionCommandAttributes'_constructor {_StartChildWorkflowExecutionCommandAttributes'namespace :: !Data.Text.Text,
                                                               _StartChildWorkflowExecutionCommandAttributes'workflowId :: !Data.Text.Text,
                                                               _StartChildWorkflowExecutionCommandAttributes'workflowType :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType),
                                                               _StartChildWorkflowExecutionCommandAttributes'taskQueue :: !(Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue),
                                                               _StartChildWorkflowExecutionCommandAttributes'input :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                                               _StartChildWorkflowExecutionCommandAttributes'workflowExecutionTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                               _StartChildWorkflowExecutionCommandAttributes'workflowRunTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                               _StartChildWorkflowExecutionCommandAttributes'workflowTaskTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                                               _StartChildWorkflowExecutionCommandAttributes'parentClosePolicy :: !Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy,
                                                               _StartChildWorkflowExecutionCommandAttributes'control :: !Data.Text.Text,
                                                               _StartChildWorkflowExecutionCommandAttributes'workflowIdReusePolicy :: !Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy,
                                                               _StartChildWorkflowExecutionCommandAttributes'retryPolicy :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy),
                                                               _StartChildWorkflowExecutionCommandAttributes'cronSchedule :: !Data.Text.Text,
                                                               _StartChildWorkflowExecutionCommandAttributes'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                                               _StartChildWorkflowExecutionCommandAttributes'memo :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo),
                                                               _StartChildWorkflowExecutionCommandAttributes'searchAttributes :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes),
                                                               _StartChildWorkflowExecutionCommandAttributes'useCompatibleVersion :: !Prelude.Bool,
                                                               _StartChildWorkflowExecutionCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartChildWorkflowExecutionCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'namespace
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowId
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "workflowType" Proto.Temporal.Api.Common.V1.Message.WorkflowType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowType
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowType = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'workflowType" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowType
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "taskQueue" Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'taskQueue
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'taskQueue = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'taskQueue" (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'taskQueue
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "input" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'input
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'input = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'input" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'input
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "workflowExecutionTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowExecutionTimeout
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowExecutionTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'workflowExecutionTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowExecutionTimeout
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowExecutionTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "workflowRunTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowRunTimeout
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowRunTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'workflowRunTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowRunTimeout
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowRunTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "workflowTaskTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowTaskTimeout
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowTaskTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'workflowTaskTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowTaskTimeout
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowTaskTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "parentClosePolicy" Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'parentClosePolicy
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'parentClosePolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "control" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'control
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'control = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "workflowIdReusePolicy" Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'workflowIdReusePolicy
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'workflowIdReusePolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "retryPolicy" Proto.Temporal.Api.Common.V1.Message.RetryPolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'retryPolicy
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'retryPolicy = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'retryPolicy" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'retryPolicy
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'retryPolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "cronSchedule" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'cronSchedule
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'cronSchedule = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'header
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'header
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "memo" Proto.Temporal.Api.Common.V1.Message.Memo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'memo
           (\ x__ y__
              -> x__ {_StartChildWorkflowExecutionCommandAttributes'memo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'memo" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'memo
           (\ x__ y__
              -> x__ {_StartChildWorkflowExecutionCommandAttributes'memo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "searchAttributes" Proto.Temporal.Api.Common.V1.Message.SearchAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'searchAttributes
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'searchAttributes = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "maybe'searchAttributes" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'searchAttributes
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartChildWorkflowExecutionCommandAttributes "useCompatibleVersion" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartChildWorkflowExecutionCommandAttributes'useCompatibleVersion
           (\ x__ y__
              -> x__
                   {_StartChildWorkflowExecutionCommandAttributes'useCompatibleVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartChildWorkflowExecutionCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.StartChildWorkflowExecutionCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \,StartChildWorkflowExecutionCommandAttributes\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
      \\vworkflow_id\CAN\STX \SOH(\tR\n\
      \workflowId\DC2I\n\
      \\rworkflow_type\CAN\ETX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\fworkflowType\DC2C\n\
      \\n\
      \task_queue\CAN\EOT \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
      \\ENQinput\CAN\ENQ \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2]\n\
      \\SUBworkflow_execution_timeout\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeoutB\EOT\152\223\US\SOH\DC2Q\n\
      \\DC4workflow_run_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2S\n\
      \\NAKworkflow_task_timeout\CAN\b \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeoutB\EOT\152\223\US\SOH\DC2X\n\
      \\DC3parent_close_policy\CAN\t \SOH(\SO2(.temporal.api.enums.v1.ParentClosePolicyR\DC1parentClosePolicy\DC2\CAN\n\
      \\acontrol\CAN\n\
      \ \SOH(\tR\acontrol\DC2e\n\
      \\CANworkflow_id_reuse_policy\CAN\v \SOH(\SO2,.temporal.api.enums.v1.WorkflowIdReusePolicyR\NAKworkflowIdReusePolicy\DC2F\n\
      \\fretry_policy\CAN\f \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2#\n\
      \\rcron_schedule\CAN\r \SOH(\tR\fcronSchedule\DC26\n\
      \\ACKheader\CAN\SO \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC20\n\
      \\EOTmemo\CAN\SI \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
      \\DC1search_attributes\CAN\DLE \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC24\n\
      \\SYNuse_compatible_version\CAN\DC1 \SOH(\bR\DC4useCompatibleVersion"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        namespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"namespace")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        workflowId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowId")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        workflowType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_type"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowType)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowType")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'taskQueue")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'input")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        workflowExecutionTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        workflowRunTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_run_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        workflowTaskTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_task_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        parentClosePolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "parent_close_policy"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"parentClosePolicy")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        control__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "control"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"control")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        workflowIdReusePolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id_reuse_policy"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowIdReusePolicy")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        retryPolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "retry_policy"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.RetryPolicy)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'retryPolicy")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        cronSchedule__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cron_schedule"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"cronSchedule")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        memo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "memo"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Memo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'memo")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.SearchAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
        useCompatibleVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "use_compatible_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"useCompatibleVersion")) ::
              Data.ProtoLens.FieldDescriptor StartChildWorkflowExecutionCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 3, workflowType__field_descriptor),
           (Data.ProtoLens.Tag 4, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 5, input__field_descriptor),
           (Data.ProtoLens.Tag 6, workflowExecutionTimeout__field_descriptor),
           (Data.ProtoLens.Tag 7, workflowRunTimeout__field_descriptor),
           (Data.ProtoLens.Tag 8, workflowTaskTimeout__field_descriptor),
           (Data.ProtoLens.Tag 9, parentClosePolicy__field_descriptor),
           (Data.ProtoLens.Tag 10, control__field_descriptor),
           (Data.ProtoLens.Tag 11, workflowIdReusePolicy__field_descriptor),
           (Data.ProtoLens.Tag 12, retryPolicy__field_descriptor),
           (Data.ProtoLens.Tag 13, cronSchedule__field_descriptor),
           (Data.ProtoLens.Tag 14, header__field_descriptor),
           (Data.ProtoLens.Tag 15, memo__field_descriptor),
           (Data.ProtoLens.Tag 16, searchAttributes__field_descriptor),
           (Data.ProtoLens.Tag 17, useCompatibleVersion__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartChildWorkflowExecutionCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_StartChildWorkflowExecutionCommandAttributes'_unknownFields = y__})
  defMessage
    = StartChildWorkflowExecutionCommandAttributes'_constructor
        {_StartChildWorkflowExecutionCommandAttributes'namespace = Data.ProtoLens.fieldDefault,
         _StartChildWorkflowExecutionCommandAttributes'workflowId = Data.ProtoLens.fieldDefault,
         _StartChildWorkflowExecutionCommandAttributes'workflowType = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'taskQueue = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'input = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'workflowExecutionTimeout = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'workflowRunTimeout = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'workflowTaskTimeout = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'parentClosePolicy = Data.ProtoLens.fieldDefault,
         _StartChildWorkflowExecutionCommandAttributes'control = Data.ProtoLens.fieldDefault,
         _StartChildWorkflowExecutionCommandAttributes'workflowIdReusePolicy = Data.ProtoLens.fieldDefault,
         _StartChildWorkflowExecutionCommandAttributes'retryPolicy = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'cronSchedule = Data.ProtoLens.fieldDefault,
         _StartChildWorkflowExecutionCommandAttributes'header = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'memo = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'searchAttributes = Prelude.Nothing,
         _StartChildWorkflowExecutionCommandAttributes'useCompatibleVersion = Data.ProtoLens.fieldDefault,
         _StartChildWorkflowExecutionCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartChildWorkflowExecutionCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser StartChildWorkflowExecutionCommandAttributes
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
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "workflow_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"workflowId") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowType") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "input"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"input") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_execution_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecutionTimeout") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_run_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowRunTimeout") y x)
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_task_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowTaskTimeout") y x)
                        72
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "parent_close_policy"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"parentClosePolicy") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "control"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"control") y x)
                        88
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "workflow_id_reuse_policy"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowIdReusePolicy") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "retry_policy"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"retryPolicy") y x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "cron_schedule"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cronSchedule") y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "memo"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"memo") y x)
                        130
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "search_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"searchAttributes") y x)
                        136
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "use_compatible_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"useCompatibleVersion") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "StartChildWorkflowExecutionCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"namespace") _x
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
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowId") _x
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
                          (Data.ProtoLens.Field.field @"maybe'workflowType") _x
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
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'taskQueue") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just _v)
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage _v))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'input") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just _v)
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         ((Data.Monoid.<>)
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (case
                                    Lens.Family2.view
                                      (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout") _x
                                of
                                  Prelude.Nothing -> Data.Monoid.mempty
                                  (Prelude.Just _v)
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
                               ((Data.Monoid.<>)
                                  (case
                                       Lens.Family2.view
                                         (Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout")
                                         _x
                                   of
                                     Prelude.Nothing -> Data.Monoid.mempty
                                     (Prelude.Just _v)
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
                                  ((Data.Monoid.<>)
                                     (let
                                        _v
                                          = Lens.Family2.view
                                              (Data.ProtoLens.Field.field @"parentClosePolicy") _x
                                      in
                                        if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                            Data.Monoid.mempty
                                        else
                                            (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt 72)
                                              ((Prelude..)
                                                 ((Prelude..)
                                                    Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    Prelude.fromIntegral)
                                                 Prelude.fromEnum _v))
                                     ((Data.Monoid.<>)
                                        (let
                                           _v
                                             = Lens.Family2.view
                                                 (Data.ProtoLens.Field.field @"control") _x
                                         in
                                           if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                               Data.Monoid.mempty
                                           else
                                               (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                                 ((Prelude..)
                                                    (\ bs
                                                       -> (Data.Monoid.<>)
                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                               (Prelude.fromIntegral
                                                                  (Data.ByteString.length bs)))
                                                            (Data.ProtoLens.Encoding.Bytes.putBytes
                                                               bs))
                                                    Data.Text.Encoding.encodeUtf8 _v))
                                        ((Data.Monoid.<>)
                                           (let
                                              _v
                                                = Lens.Family2.view
                                                    (Data.ProtoLens.Field.field
                                                       @"workflowIdReusePolicy")
                                                    _x
                                            in
                                              if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                  Data.Monoid.mempty
                                              else
                                                  (Data.Monoid.<>)
                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 88)
                                                    ((Prelude..)
                                                       ((Prelude..)
                                                          Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          Prelude.fromIntegral)
                                                       Prelude.fromEnum _v))
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
                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
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
                                                 (let
                                                    _v
                                                      = Lens.Family2.view
                                                          (Data.ProtoLens.Field.field
                                                             @"cronSchedule")
                                                          _x
                                                  in
                                                    if (Prelude.==)
                                                         _v Data.ProtoLens.fieldDefault then
                                                        Data.Monoid.mempty
                                                    else
                                                        (Data.Monoid.<>)
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
                                                             Data.Text.Encoding.encodeUtf8 _v))
                                                 ((Data.Monoid.<>)
                                                    (case
                                                         Lens.Family2.view
                                                           (Data.ProtoLens.Field.field
                                                              @"maybe'header")
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
                                                                 @"maybe'memo")
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
                                                                    @"maybe'searchAttributes")
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
                                                             (let
                                                                _v
                                                                  = Lens.Family2.view
                                                                      (Data.ProtoLens.Field.field
                                                                         @"useCompatibleVersion")
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
                                                                         (\ b -> if b then 1 else 0)
                                                                         _v))
                                                             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                                (Lens.Family2.view
                                                                   Data.ProtoLens.unknownFields
                                                                   _x))))))))))))))))))
instance Control.DeepSeq.NFData StartChildWorkflowExecutionCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartChildWorkflowExecutionCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartChildWorkflowExecutionCommandAttributes'namespace x__)
                (Control.DeepSeq.deepseq
                   (_StartChildWorkflowExecutionCommandAttributes'workflowId x__)
                   (Control.DeepSeq.deepseq
                      (_StartChildWorkflowExecutionCommandAttributes'workflowType x__)
                      (Control.DeepSeq.deepseq
                         (_StartChildWorkflowExecutionCommandAttributes'taskQueue x__)
                         (Control.DeepSeq.deepseq
                            (_StartChildWorkflowExecutionCommandAttributes'input x__)
                            (Control.DeepSeq.deepseq
                               (_StartChildWorkflowExecutionCommandAttributes'workflowExecutionTimeout
                                  x__)
                               (Control.DeepSeq.deepseq
                                  (_StartChildWorkflowExecutionCommandAttributes'workflowRunTimeout
                                     x__)
                                  (Control.DeepSeq.deepseq
                                     (_StartChildWorkflowExecutionCommandAttributes'workflowTaskTimeout
                                        x__)
                                     (Control.DeepSeq.deepseq
                                        (_StartChildWorkflowExecutionCommandAttributes'parentClosePolicy
                                           x__)
                                        (Control.DeepSeq.deepseq
                                           (_StartChildWorkflowExecutionCommandAttributes'control
                                              x__)
                                           (Control.DeepSeq.deepseq
                                              (_StartChildWorkflowExecutionCommandAttributes'workflowIdReusePolicy
                                                 x__)
                                              (Control.DeepSeq.deepseq
                                                 (_StartChildWorkflowExecutionCommandAttributes'retryPolicy
                                                    x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_StartChildWorkflowExecutionCommandAttributes'cronSchedule
                                                       x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_StartChildWorkflowExecutionCommandAttributes'header
                                                          x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_StartChildWorkflowExecutionCommandAttributes'memo
                                                             x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_StartChildWorkflowExecutionCommandAttributes'searchAttributes
                                                                x__)
                                                             (Control.DeepSeq.deepseq
                                                                (_StartChildWorkflowExecutionCommandAttributes'useCompatibleVersion
                                                                   x__)
                                                                ())))))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.timerId' @:: Lens' StartTimerCommandAttributes Data.Text.Text@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.startToFireTimeout' @:: Lens' StartTimerCommandAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'startToFireTimeout' @:: Lens' StartTimerCommandAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@ -}
data StartTimerCommandAttributes
  = StartTimerCommandAttributes'_constructor {_StartTimerCommandAttributes'timerId :: !Data.Text.Text,
                                              _StartTimerCommandAttributes'startToFireTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                              _StartTimerCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartTimerCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartTimerCommandAttributes "timerId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartTimerCommandAttributes'timerId
           (\ x__ y__ -> x__ {_StartTimerCommandAttributes'timerId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartTimerCommandAttributes "startToFireTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartTimerCommandAttributes'startToFireTimeout
           (\ x__ y__
              -> x__ {_StartTimerCommandAttributes'startToFireTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartTimerCommandAttributes "maybe'startToFireTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartTimerCommandAttributes'startToFireTimeout
           (\ x__ y__
              -> x__ {_StartTimerCommandAttributes'startToFireTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartTimerCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.StartTimerCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \\ESCStartTimerCommandAttributes\DC2\EM\n\
      \\btimer_id\CAN\SOH \SOH(\tR\atimerId\DC2R\n\
      \\NAKstart_to_fire_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\DC2startToFireTimeoutB\EOT\152\223\US\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        timerId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "timer_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"timerId")) ::
              Data.ProtoLens.FieldDescriptor StartTimerCommandAttributes
        startToFireTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_to_fire_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startToFireTimeout")) ::
              Data.ProtoLens.FieldDescriptor StartTimerCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, timerId__field_descriptor),
           (Data.ProtoLens.Tag 2, startToFireTimeout__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartTimerCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__ {_StartTimerCommandAttributes'_unknownFields = y__})
  defMessage
    = StartTimerCommandAttributes'_constructor
        {_StartTimerCommandAttributes'timerId = Data.ProtoLens.fieldDefault,
         _StartTimerCommandAttributes'startToFireTimeout = Prelude.Nothing,
         _StartTimerCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartTimerCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser StartTimerCommandAttributes
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
                                       "timer_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"timerId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_to_fire_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startToFireTimeout") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "StartTimerCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"timerId") _x
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
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'startToFireTimeout") _x
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
instance Control.DeepSeq.NFData StartTimerCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartTimerCommandAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartTimerCommandAttributes'timerId x__)
                (Control.DeepSeq.deepseq
                   (_StartTimerCommandAttributes'startToFireTimeout x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.searchAttributes' @:: Lens' UpsertWorkflowSearchAttributesCommandAttributes Proto.Temporal.Api.Common.V1.Message.SearchAttributes@
         * 'Proto.Temporal.Api.Command.V1.Message_Fields.maybe'searchAttributes' @:: Lens' UpsertWorkflowSearchAttributesCommandAttributes (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes)@ -}
data UpsertWorkflowSearchAttributesCommandAttributes
  = UpsertWorkflowSearchAttributesCommandAttributes'_constructor {_UpsertWorkflowSearchAttributesCommandAttributes'searchAttributes :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes),
                                                                  _UpsertWorkflowSearchAttributesCommandAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UpsertWorkflowSearchAttributesCommandAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UpsertWorkflowSearchAttributesCommandAttributes "searchAttributes" Proto.Temporal.Api.Common.V1.Message.SearchAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpsertWorkflowSearchAttributesCommandAttributes'searchAttributes
           (\ x__ y__
              -> x__
                   {_UpsertWorkflowSearchAttributesCommandAttributes'searchAttributes = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField UpsertWorkflowSearchAttributesCommandAttributes "maybe'searchAttributes" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpsertWorkflowSearchAttributesCommandAttributes'searchAttributes
           (\ x__ y__
              -> x__
                   {_UpsertWorkflowSearchAttributesCommandAttributes'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Message UpsertWorkflowSearchAttributesCommandAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.command.v1.UpsertWorkflowSearchAttributesCommandAttributes"
  packedMessageDescriptor _
    = "\n\
      \/UpsertWorkflowSearchAttributesCommandAttributes\DC2U\n\
      \\DC1search_attributes\CAN\SOH \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.SearchAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor UpsertWorkflowSearchAttributesCommandAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, searchAttributes__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UpsertWorkflowSearchAttributesCommandAttributes'_unknownFields
        (\ x__ y__
           -> x__
                {_UpsertWorkflowSearchAttributesCommandAttributes'_unknownFields = y__})
  defMessage
    = UpsertWorkflowSearchAttributesCommandAttributes'_constructor
        {_UpsertWorkflowSearchAttributesCommandAttributes'searchAttributes = Prelude.Nothing,
         _UpsertWorkflowSearchAttributesCommandAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UpsertWorkflowSearchAttributesCommandAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser UpsertWorkflowSearchAttributesCommandAttributes
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
                                       "search_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"searchAttributes") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "UpsertWorkflowSearchAttributesCommandAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'searchAttributes") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData UpsertWorkflowSearchAttributesCommandAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UpsertWorkflowSearchAttributesCommandAttributes'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_UpsertWorkflowSearchAttributesCommandAttributes'searchAttributes
                   x__)
                ())
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \%temporal/api/command/v1/message.proto\DC2\ETBtemporal.api.command.v1\SUB\RSgoogle/protobuf/duration.proto\SUB!dependencies/gogoproto/gogo.proto\SUB$temporal/api/enums/v1/workflow.proto\SUB(temporal/api/enums/v1/command_type.proto\SUB$temporal/api/common/v1/message.proto\SUB%temporal/api/failure/v1/message.proto\SUB'temporal/api/taskqueue/v1/message.proto\"\224\ACK\n\
    \%ScheduleActivityTaskCommandAttributes\DC2\US\n\
    \\vactivity_id\CAN\SOH \SOH(\tR\n\
    \activityId\DC2I\n\
    \\ractivity_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.ActivityTypeR\factivityType\DC2C\n\
    \\n\
    \task_queue\CAN\EOT \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
    \\ACKheader\CAN\ENQ \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC26\n\
    \\ENQinput\CAN\ACK \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2Z\n\
    \\EMschedule_to_close_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToCloseTimeoutB\EOT\152\223\US\SOH\DC2Z\n\
    \\EMschedule_to_start_timeout\CAN\b \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToStartTimeoutB\EOT\152\223\US\SOH\DC2T\n\
    \\SYNstart_to_close_timeout\CAN\t \SOH(\v2\EM.google.protobuf.DurationR\DC3startToCloseTimeoutB\EOT\152\223\US\SOH\DC2L\n\
    \\DC1heartbeat_timeout\CAN\n\
    \ \SOH(\v2\EM.google.protobuf.DurationR\DLEheartbeatTimeoutB\EOT\152\223\US\SOH\DC2F\n\
    \\fretry_policy\CAN\v \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC26\n\
    \\ETBrequest_eager_execution\CAN\f \SOH(\bR\NAKrequestEagerExecution\DC24\n\
    \\SYNuse_compatible_version\CAN\r \SOH(\bR\DC4useCompatibleVersionJ\EOT\b\ETX\DLE\EOT\"Z\n\
    \*RequestCancelActivityTaskCommandAttributes\DC2,\n\
    \\DC2scheduled_event_id\CAN\SOH \SOH(\ETXR\DLEscheduledEventId\"\140\SOH\n\
    \\ESCStartTimerCommandAttributes\DC2\EM\n\
    \\btimer_id\CAN\SOH \SOH(\tR\atimerId\DC2R\n\
    \\NAKstart_to_fire_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\DC2startToFireTimeoutB\EOT\152\223\US\SOH\"f\n\
    \*CompleteWorkflowExecutionCommandAttributes\DC28\n\
    \\ACKresult\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsR\ACKresult\"d\n\
    \&FailWorkflowExecutionCommandAttributes\DC2:\n\
    \\afailure\CAN\SOH \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\"9\n\
    \\FSCancelTimerCommandAttributes\DC2\EM\n\
    \\btimer_id\CAN\SOH \SOH(\tR\atimerId\"f\n\
    \(CancelWorkflowExecutionCommandAttributes\DC2:\n\
    \\adetails\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsR\adetails\"\241\SOH\n\
    \7RequestCancelExternalWorkflowExecutionCommandAttributes\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
    \\vworkflow_id\CAN\STX \SOH(\tR\n\
    \workflowId\DC2\NAK\n\
    \\ACKrun_id\CAN\ETX \SOH(\tR\ENQrunId\DC2\CAN\n\
    \\acontrol\CAN\EOT \SOH(\tR\acontrol\DC2.\n\
    \\DC3child_workflow_only\CAN\ENQ \SOH(\bR\DC1childWorkflowOnly\DC2\SYN\n\
    \\ACKreason\CAN\ACK \SOH(\tR\ACKreason\"\244\STX\n\
    \0SignalExternalWorkflowExecutionCommandAttributes\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2G\n\
    \\texecution\CAN\STX \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\texecution\DC2\US\n\
    \\vsignal_name\CAN\ETX \SOH(\tR\n\
    \signalName\DC26\n\
    \\ENQinput\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2\CAN\n\
    \\acontrol\CAN\ENQ \SOH(\tR\acontrol\DC2.\n\
    \\DC3child_workflow_only\CAN\ACK \SOH(\bR\DC1childWorkflowOnly\DC26\n\
    \\ACKheader\CAN\a \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\"\136\SOH\n\
    \/UpsertWorkflowSearchAttributesCommandAttributes\DC2U\n\
    \\DC1search_attributes\CAN\SOH \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\"n\n\
    \)ModifyWorkflowPropertiesCommandAttributes\DC2A\n\
    \\rupserted_memo\CAN\SOH \SOH(\v2\FS.temporal.api.common.v1.MemoR\fupsertedMemo\"\241\STX\n\
    \\GSRecordMarkerCommandAttributes\DC2\US\n\
    \\vmarker_name\CAN\SOH \SOH(\tR\n\
    \markerName\DC2]\n\
    \\adetails\CAN\STX \ETX(\v2C.temporal.api.command.v1.RecordMarkerCommandAttributes.DetailsEntryR\adetails\DC26\n\
    \\ACKheader\CAN\ETX \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2:\n\
    \\afailure\CAN\EOT \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\SUB\\\n\
    \\fDetailsEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC26\n\
    \\ENQvalue\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQvalue:\STX8\SOH\"\189\b\n\
    \/ContinueAsNewWorkflowExecutionCommandAttributes\DC2I\n\
    \\rworkflow_type\CAN\SOH \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\fworkflowType\DC2C\n\
    \\n\
    \task_queue\CAN\STX \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
    \\ENQinput\CAN\ETX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2Q\n\
    \\DC4workflow_run_timeout\CAN\EOT \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2S\n\
    \\NAKworkflow_task_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeoutB\EOT\152\223\US\SOH\DC2U\n\
    \\SYNbackoff_start_interval\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\DC4backoffStartIntervalB\EOT\152\223\US\SOH\DC2F\n\
    \\fretry_policy\CAN\a \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2K\n\
    \\tinitiator\CAN\b \SOH(\SO2-.temporal.api.enums.v1.ContinueAsNewInitiatorR\tinitiator\DC2:\n\
    \\afailure\CAN\t \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\DC2V\n\
    \\SYNlast_completion_result\CAN\n\
    \ \SOH(\v2 .temporal.api.common.v1.PayloadsR\DC4lastCompletionResult\DC2#\n\
    \\rcron_schedule\CAN\v \SOH(\tR\fcronSchedule\DC26\n\
    \\ACKheader\CAN\f \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC20\n\
    \\EOTmemo\CAN\r \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
    \\DC1search_attributes\CAN\SO \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC24\n\
    \\SYNuse_compatible_version\CAN\SI \SOH(\bR\DC4useCompatibleVersion\"\251\b\n\
    \,StartChildWorkflowExecutionCommandAttributes\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
    \\vworkflow_id\CAN\STX \SOH(\tR\n\
    \workflowId\DC2I\n\
    \\rworkflow_type\CAN\ETX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\fworkflowType\DC2C\n\
    \\n\
    \task_queue\CAN\EOT \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
    \\ENQinput\CAN\ENQ \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2]\n\
    \\SUBworkflow_execution_timeout\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeoutB\EOT\152\223\US\SOH\DC2Q\n\
    \\DC4workflow_run_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2S\n\
    \\NAKworkflow_task_timeout\CAN\b \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeoutB\EOT\152\223\US\SOH\DC2X\n\
    \\DC3parent_close_policy\CAN\t \SOH(\SO2(.temporal.api.enums.v1.ParentClosePolicyR\DC1parentClosePolicy\DC2\CAN\n\
    \\acontrol\CAN\n\
    \ \SOH(\tR\acontrol\DC2e\n\
    \\CANworkflow_id_reuse_policy\CAN\v \SOH(\SO2,.temporal.api.enums.v1.WorkflowIdReusePolicyR\NAKworkflowIdReusePolicy\DC2F\n\
    \\fretry_policy\CAN\f \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2#\n\
    \\rcron_schedule\CAN\r \SOH(\tR\fcronSchedule\DC26\n\
    \\ACKheader\CAN\SO \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC20\n\
    \\EOTmemo\CAN\SI \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
    \\DC1search_attributes\CAN\DLE \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC24\n\
    \\SYNuse_compatible_version\CAN\DC1 \SOH(\bR\DC4useCompatibleVersion\"A\n\
    \ ProtocolMessageCommandAttributes\DC2\GS\n\
    \\n\
    \message_id\CAN\SOH \SOH(\tR\tmessageId\"\145\DC4\n\
    \\aCommand\DC2E\n\
    \\fcommand_type\CAN\SOH \SOH(\SO2\".temporal.api.enums.v1.CommandTypeR\vcommandType\DC2\154\SOH\n\
    \)schedule_activity_task_command_attributes\CAN\STX \SOH(\v2>.temporal.api.command.v1.ScheduleActivityTaskCommandAttributesH\NULR%scheduleActivityTaskCommandAttributes\DC2{\n\
    \\RSstart_timer_command_attributes\CAN\ETX \SOH(\v24.temporal.api.command.v1.StartTimerCommandAttributesH\NULR\ESCstartTimerCommandAttributes\DC2\169\SOH\n\
    \.complete_workflow_execution_command_attributes\CAN\EOT \SOH(\v2C.temporal.api.command.v1.CompleteWorkflowExecutionCommandAttributesH\NULR*completeWorkflowExecutionCommandAttributes\DC2\157\SOH\n\
    \*fail_workflow_execution_command_attributes\CAN\ENQ \SOH(\v2?.temporal.api.command.v1.FailWorkflowExecutionCommandAttributesH\NULR&failWorkflowExecutionCommandAttributes\DC2\170\SOH\n\
    \/request_cancel_activity_task_command_attributes\CAN\ACK \SOH(\v2C.temporal.api.command.v1.RequestCancelActivityTaskCommandAttributesH\NULR*requestCancelActivityTaskCommandAttributes\DC2~\n\
    \\UScancel_timer_command_attributes\CAN\a \SOH(\v25.temporal.api.command.v1.CancelTimerCommandAttributesH\NULR\FScancelTimerCommandAttributes\DC2\163\SOH\n\
    \,cancel_workflow_execution_command_attributes\CAN\b \SOH(\v2A.temporal.api.command.v1.CancelWorkflowExecutionCommandAttributesH\NULR(cancelWorkflowExecutionCommandAttributes\DC2\210\SOH\n\
    \=request_cancel_external_workflow_execution_command_attributes\CAN\t \SOH(\v2P.temporal.api.command.v1.RequestCancelExternalWorkflowExecutionCommandAttributesH\NULR7requestCancelExternalWorkflowExecutionCommandAttributes\DC2\129\SOH\n\
    \ record_marker_command_attributes\CAN\n\
    \ \SOH(\v26.temporal.api.command.v1.RecordMarkerCommandAttributesH\NULR\GSrecordMarkerCommandAttributes\DC2\186\SOH\n\
    \5continue_as_new_workflow_execution_command_attributes\CAN\v \SOH(\v2H.temporal.api.command.v1.ContinueAsNewWorkflowExecutionCommandAttributesH\NULR/continueAsNewWorkflowExecutionCommandAttributes\DC2\176\SOH\n\
    \1start_child_workflow_execution_command_attributes\CAN\f \SOH(\v2E.temporal.api.command.v1.StartChildWorkflowExecutionCommandAttributesH\NULR,startChildWorkflowExecutionCommandAttributes\DC2\188\SOH\n\
    \5signal_external_workflow_execution_command_attributes\CAN\r \SOH(\v2I.temporal.api.command.v1.SignalExternalWorkflowExecutionCommandAttributesH\NULR0signalExternalWorkflowExecutionCommandAttributes\DC2\185\SOH\n\
    \4upsert_workflow_search_attributes_command_attributes\CAN\SO \SOH(\v2H.temporal.api.command.v1.UpsertWorkflowSearchAttributesCommandAttributesH\NULR/upsertWorkflowSearchAttributesCommandAttributes\DC2\138\SOH\n\
    \#protocol_message_command_attributes\CAN\SI \SOH(\v29.temporal.api.command.v1.ProtocolMessageCommandAttributesH\NULR protocolMessageCommandAttributes\DC2\166\SOH\n\
    \-modify_workflow_properties_command_attributes\CAN\DC1 \SOH(\v2B.temporal.api.command.v1.ModifyWorkflowPropertiesCommandAttributesH\NULR)modifyWorkflowPropertiesCommandAttributesB\f\n\
    \\n\
    \attributesB\142\SOH\n\
    \\SUBio.temporal.api.command.v1B\fMessageProtoP\SOHZ%go.temporal.io/api/command/v1;command\170\STX\EMTemporalio.Api.Command.V1\234\STX\FSTemporalio::Api::Command::V1J\202^\n\
    \\a\DC2\ENQ\SYN\NUL\130\STX\SOH\n\
    \\241\b\n\
    \\SOH\f\DC2\ETX\SYN\NUL\DC22\230\b The MIT License\n\
    \\n\
    \ Copyright (c) 2020 Temporal Technologies Inc.  All rights reserved.\n\
    \\n\
    \ Permission is hereby granted, free of charge, to any person obtaining a copy\n\
    \ of this software and associated documentation files (the \"Software\"), to deal\n\
    \ in the Software without restriction, including without limitation the rights\n\
    \ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n\
    \ copies of the Software, and to permit persons to whom the Software is\n\
    \ furnished to do so, subject to the following conditions:\n\
    \\n\
    \ The above copyright notice and this permission notice shall be included in\n\
    \ all copies or substantial portions of the Software.\n\
    \\n\
    \ THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n\
    \ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n\
    \ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n\
    \ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n\
    \ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n\
    \ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n\
    \ THE SOFTWARE.\n\
    \\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\CAN\NUL \n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL<\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL<\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL3\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL3\n\
    \\b\n\
    \\SOH\b\DC2\ETX\FS\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\FS\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\GS\NUL-\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\GS\NUL-\n\
    \\b\n\
    \\SOH\b\DC2\ETX\RS\NUL5\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL5\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL6\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL6\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL(\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX#\NUL+\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX%\NUL.\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX&\NUL2\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX'\NUL.\n\
    \\t\n\
    \\STX\ETX\ENQ\DC2\ETX(\NUL/\n\
    \\t\n\
    \\STX\ETX\ACK\DC2\ETX)\NUL1\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT+\NULY\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX+\b-\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX,\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX,\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX,\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX,\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX-\EOT:\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX-\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX-(5\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX-89\n\
    \j\n\
    \\ETX\EOT\NUL\t\DC2\ETX/\EOT\SI\SUB^ This used to be a `namespace` field which allowed to schedule activity in another namespace.\n\
    \\n\
    \\v\n\
    \\EOT\EOT\NUL\t\NUL\DC2\ETX/\r\SO\n\
    \\f\n\
    \\ENQ\EOT\NUL\t\NUL\SOH\DC2\ETX/\r\SO\n\
    \\f\n\
    \\ENQ\EOT\NUL\t\NUL\STX\DC2\ETX/\r\SO\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX0\EOT7\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX0\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX0(2\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX056\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX1\EOT-\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ACK\DC2\ETX1\EOT!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX1\"(\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX1+,\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\EOT\DC2\ETX2\EOT.\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ACK\DC2\ETX2\EOT#\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\SOH\DC2\ETX2$)\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ETX\DC2\ETX2,-\n\
    \\231\ETX\n\
    \\EOT\EOT\NUL\STX\ENQ\DC2\ETX:\EOT\\\SUB\217\ETX Indicates how long the caller is willing to wait for activity completion. The \"schedule\" time\n\
    \ is when the activity is initially scheduled, not when the most recent retry is scheduled.\n\
    \ Limits how long retries will be attempted. Either this or `start_to_close_timeout` must be\n\
    \ specified. When not specified, defaults to the workflow execution timeout.\n\
    \\n\
    \ (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: \"to\" is used to indicate interval. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ACK\DC2\ETX:\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\SOH\DC2\ETX:\GS6\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ETX\DC2\ETX:9:\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\b\DC2\ETX:;[\n\
    \\SI\n\
    \\b\EOT\NUL\STX\ENQ\b\243\251\ETX\DC2\ETX:<Z\n\
    \\175\ENQ\n\
    \\EOT\EOT\NUL\STX\ACK\DC2\ETXE\EOT\\\SUB\161\ENQ Limits the time an activity task can stay in a task queue before a worker picks it up. The\n\
    \ \"schedule\" time is when the most recent retry is scheduled. This timeout should usually not\n\
    \ be set: it's useful in specific scenarios like worker-specific task queues. This timeout is\n\
    \ always non retryable, as all a retry would achieve is to put it back into the same queue.\n\
    \ Defaults to `schedule_to_close_timeout` or workflow execution timeout if that is not\n\
    \ specified. More info:\n\
    \ https://docs.temporal.io/docs/content/what-is-a-schedule-to-start-timeout/\n\
    \\n\
    \ (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: \"to\" is used to indicate interval. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ACK\DC2\ETXE\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\SOH\DC2\ETXE\GS6\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ETX\DC2\ETXE9:\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\b\DC2\ETXE;[\n\
    \\SI\n\
    \\b\EOT\NUL\STX\ACK\b\243\251\ETX\DC2\ETXE<Z\n\
    \\185\STX\n\
    \\EOT\EOT\NUL\STX\a\DC2\ETXK\EOTY\SUB\171\STX Maximum time an activity is allowed to execute after being picked up by a worker. This\n\
    \ timeout is always retryable. Either this or `schedule_to_close_timeout` must be specified.\n\
    \\n\
    \ (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: \"to\" is used to indicate interval. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\ACK\DC2\ETXK\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\SOH\DC2\ETXK\GS3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\ETX\DC2\ETXK67\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\b\DC2\ETXK8X\n\
    \\SI\n\
    \\b\EOT\NUL\STX\a\b\243\251\ETX\DC2\ETXK9W\n\
    \K\n\
    \\EOT\EOT\NUL\STX\b\DC2\ETXM\EOTU\SUB> Maximum permitted time between successful worker heartbeats.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\ACK\DC2\ETXM\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\SOH\DC2\ETXM\GS.\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\ETX\DC2\ETXM13\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\b\DC2\ETXM4T\n\
    \\SI\n\
    \\b\EOT\NUL\STX\b\b\243\251\ETX\DC2\ETXM5S\n\
    \\136\STX\n\
    \\EOT\EOT\NUL\STX\t\DC2\ETXQ\EOT9\SUB\250\SOH Activities are provided by a default retry policy which is controlled through the service's\n\
    \ dynamic configuration. Retries will be attempted until `schedule_to_close_timeout` has\n\
    \ elapsed. To disable retries set retry_policy.maximum_attempts to 1.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\ACK\DC2\ETXQ\EOT&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\SOH\DC2\ETXQ'3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\ETX\DC2\ETXQ68\n\
    \\189\SOH\n\
    \\EOT\EOT\NUL\STX\n\
    \\DC2\ETXT\EOT&\SUB\175\SOH Request to start the activity directly bypassing matching service and worker polling\n\
    \ The slot for executing the activity should be reserved when setting this field to true.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\ENQ\DC2\ETXT\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\SOH\DC2\ETXT\t \n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\ETX\DC2\ETXT#%\n\
    \\213\SOH\n\
    \\EOT\EOT\NUL\STX\v\DC2\ETXX\EOT%\SUB\199\SOH If this is set, the workflow executing this command wishes to start the activity using\n\
    \ a version compatible with the version that this workflow most recently ran on, if such\n\
    \ behavior is possible.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\ENQ\DC2\ETXX\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\SOH\DC2\ETXX\t\US\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\ETX\DC2\ETXX\"$\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT[\NUL^\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX[\b2\n\
    \W\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX]\EOT!\SUBJ The `ACTIVITY_TASK_SCHEDULED` event id for the activity being cancelled.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX]\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX]\n\
    \\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX]\US \n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT`\NULi\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX`\b#\n\
    \w\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETXc\EOT\CAN\SUBj An id for the timer, currently live timers must have different ids. Typically autogenerated\n\
    \ by the SDK.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETXc\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETXc\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETXc\SYN\ETB\n\
    \\199\SOH\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETXh\EOTX\SUB\185\SOH How long until the timer fires, producing a `TIMER_FIRED` event.\n\
    \\n\
    \ (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: \"to\" is used to indicate interval. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETXh\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETXh\GS2\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETXh56\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\b\DC2\ETXh7W\n\
    \\SI\n\
    \\b\EOT\STX\STX\SOH\b\243\251\ETX\DC2\ETXh8V\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOTk\NULm\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXk\b2\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXl\EOT/\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ACK\DC2\ETXl\EOT#\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXl$*\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXl-.\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOTo\NULq\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXo\b.\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXp\EOT0\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETXp\EOT#\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXp$+\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXp./\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOTs\NULv\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXs\b$\n\
    \=\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXu\EOT\CAN\SUB0 The same timer id from the start timer command\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\ETXu\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXu\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXu\SYN\ETB\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOTx\NULz\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXx\b0\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXy\EOT0\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ACK\DC2\ETXy\EOT#\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXy$+\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXy./\n\
    \\v\n\
    \\STX\EOT\a\DC2\ENQ|\NUL\136\SOH\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETX|\b?\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETX}\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETX}\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETX}\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETX}\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\a\STX\SOH\DC2\ETX~\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ENQ\DC2\ETX~\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\ETX~\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\ETX~\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\a\STX\STX\DC2\ETX\DEL\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ENQ\DC2\ETX\DEL\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\SOH\DC2\ETX\DEL\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ETX\DC2\ETX\DEL\DC4\NAK\n\
    \\ESC\n\
    \\EOT\EOT\a\STX\ETX\DC2\EOT\129\SOH\EOT\ETB\SUB\r Deprecated.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\ENQ\DC2\EOT\129\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\SOH\DC2\EOT\129\SOH\v\DC2\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\ETX\DC2\EOT\129\SOH\NAK\SYN\n\
    \\239\SOH\n\
    \\EOT\EOT\a\STX\EOT\DC2\EOT\133\SOH\EOT!\SUB\224\SOH Set this to true if the workflow being cancelled is a child of the workflow originating this\n\
    \ command. The request will be rejected if it is set to true and the target workflow is *not*\n\
    \ a child of the requesting workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\ENQ\DC2\EOT\133\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\SOH\DC2\EOT\133\SOH\t\FS\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\ETX\DC2\EOT\133\SOH\US \n\
    \6\n\
    \\EOT\EOT\a\STX\ENQ\DC2\EOT\135\SOH\EOT\SYN\SUB( Reason for requesting the cancellation\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ENQ\ENQ\DC2\EOT\135\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ENQ\SOH\DC2\EOT\135\SOH\v\DC1\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ENQ\ETX\DC2\EOT\135\SOH\DC4\NAK\n\
    \\f\n\
    \\STX\EOT\b\DC2\ACK\138\SOH\NUL\154\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\b\SOH\DC2\EOT\138\SOH\b8\n\
    \\f\n\
    \\EOT\EOT\b\STX\NUL\DC2\EOT\139\SOH\EOT\EM\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\EOT\139\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\EOT\139\SOH\v\DC4\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\EOT\139\SOH\ETB\CAN\n\
    \\f\n\
    \\EOT\EOT\b\STX\SOH\DC2\EOT\140\SOH\EOT;\n\
    \\r\n\
    \\ENQ\EOT\b\STX\SOH\ACK\DC2\EOT\140\SOH\EOT,\n\
    \\r\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\EOT\140\SOH-6\n\
    \\r\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\EOT\140\SOH9:\n\
    \W\n\
    \\EOT\EOT\b\STX\STX\DC2\EOT\142\SOH\EOT\ESC\SUBI The workflow author-defined name of the signal to send to the workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\STX\ENQ\DC2\EOT\142\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\STX\SOH\DC2\EOT\142\SOH\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\b\STX\STX\ETX\DC2\EOT\142\SOH\EM\SUB\n\
    \?\n\
    \\EOT\EOT\b\STX\ETX\DC2\EOT\144\SOH\EOT.\SUB1 Serialized value(s) to provide with the signal.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ETX\ACK\DC2\EOT\144\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ETX\SOH\DC2\EOT\144\SOH$)\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ETX\ETX\DC2\EOT\144\SOH,-\n\
    \\SUB\n\
    \\EOT\EOT\b\STX\EOT\DC2\EOT\146\SOH\EOT\ETB\SUB\f Deprecated\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\EOT\ENQ\DC2\EOT\146\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\EOT\SOH\DC2\EOT\146\SOH\v\DC2\n\
    \\r\n\
    \\ENQ\EOT\b\STX\EOT\ETX\DC2\EOT\146\SOH\NAK\SYN\n\
    \\239\SOH\n\
    \\EOT\EOT\b\STX\ENQ\DC2\EOT\150\SOH\EOT!\SUB\224\SOH Set this to true if the workflow being cancelled is a child of the workflow originating this\n\
    \ command. The request will be rejected if it is set to true and the target workflow is *not*\n\
    \ a child of the requesting workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ENQ\ENQ\DC2\EOT\150\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ENQ\SOH\DC2\EOT\150\SOH\t\FS\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ENQ\ETX\DC2\EOT\150\SOH\US \n\
    \\138\SOH\n\
    \\EOT\EOT\b\STX\ACK\DC2\EOT\153\SOH\EOT-\SUB| Headers that are passed by the workflow that is sending a signal to the external \n\
    \ workflow that is receiving this signal.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ACK\ACK\DC2\EOT\153\SOH\EOT!\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ACK\SOH\DC2\EOT\153\SOH\"(\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ACK\ETX\DC2\EOT\153\SOH+,\n\
    \\f\n\
    \\STX\EOT\t\DC2\ACK\156\SOH\NUL\158\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\t\SOH\DC2\EOT\156\SOH\b7\n\
    \\f\n\
    \\EOT\EOT\t\STX\NUL\DC2\EOT\157\SOH\EOTB\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ACK\DC2\EOT\157\SOH\EOT+\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\EOT\157\SOH,=\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\EOT\157\SOH@A\n\
    \\f\n\
    \\STX\EOT\n\
    \\DC2\ACK\160\SOH\NUL\165\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\n\
    \\SOH\DC2\EOT\160\SOH\b1\n\
    \\242\SOH\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\EOT\164\SOH\EOT2\SUB\227\SOH If set, update the workflow memo with the provided values. The values will be merged with\n\
    \ the existing memo. If the user wants to delete values, a default/empty Payload should be\n\
    \ used as the value for the key being deleted.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ACK\DC2\EOT\164\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\EOT\164\SOH -\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\EOT\164\SOH01\n\
    \\f\n\
    \\STX\EOT\v\DC2\ACK\167\SOH\NUL\172\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\v\SOH\DC2\EOT\167\SOH\b%\n\
    \\f\n\
    \\EOT\EOT\v\STX\NUL\DC2\EOT\168\SOH\EOT\ESC\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ENQ\DC2\EOT\168\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\EOT\168\SOH\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\EOT\168\SOH\EM\SUB\n\
    \\f\n\
    \\EOT\EOT\v\STX\SOH\DC2\EOT\169\SOH\EOT=\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ACK\DC2\EOT\169\SOH\EOT0\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\EOT\169\SOH18\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\EOT\169\SOH;<\n\
    \\f\n\
    \\EOT\EOT\v\STX\STX\DC2\EOT\170\SOH\EOT-\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ACK\DC2\EOT\170\SOH\EOT!\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\SOH\DC2\EOT\170\SOH\"(\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ETX\DC2\EOT\170\SOH+,\n\
    \\f\n\
    \\EOT\EOT\v\STX\ETX\DC2\EOT\171\SOH\EOT0\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\ACK\DC2\EOT\171\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\SOH\DC2\EOT\171\SOH$+\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\ETX\DC2\EOT\171\SOH./\n\
    \\f\n\
    \\STX\EOT\f\DC2\ACK\174\SOH\NUL\202\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\f\SOH\DC2\EOT\174\SOH\b7\n\
    \\f\n\
    \\EOT\EOT\f\STX\NUL\DC2\EOT\175\SOH\EOT:\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ACK\DC2\EOT\175\SOH\EOT'\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\EOT\175\SOH(5\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\EOT\175\SOH89\n\
    \\f\n\
    \\EOT\EOT\f\STX\SOH\DC2\EOT\176\SOH\EOT7\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ACK\DC2\EOT\176\SOH\EOT'\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\EOT\176\SOH(2\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\EOT\176\SOH56\n\
    \\f\n\
    \\EOT\EOT\f\STX\STX\DC2\EOT\177\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\ACK\DC2\EOT\177\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\SOH\DC2\EOT\177\SOH$)\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\ETX\DC2\EOT\177\SOH,-\n\
    \1\n\
    \\EOT\EOT\f\STX\ETX\DC2\EOT\180\SOH\EOTW\SUB# Timeout of a single workflow run.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ETX\ACK\DC2\EOT\180\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ETX\SOH\DC2\EOT\180\SOH\GS1\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ETX\ETX\DC2\EOT\180\SOH45\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ETX\b\DC2\EOT\180\SOH6V\n\
    \\DLE\n\
    \\b\EOT\f\STX\ETX\b\243\251\ETX\DC2\EOT\180\SOH7U\n\
    \2\n\
    \\EOT\EOT\f\STX\EOT\DC2\EOT\182\SOH\EOTX\SUB$ Timeout of a single workflow task.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\EOT\ACK\DC2\EOT\182\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\f\STX\EOT\SOH\DC2\EOT\182\SOH\GS2\n\
    \\r\n\
    \\ENQ\EOT\f\STX\EOT\ETX\DC2\EOT\182\SOH56\n\
    \\r\n\
    \\ENQ\EOT\f\STX\EOT\b\DC2\EOT\182\SOH7W\n\
    \\DLE\n\
    \\b\EOT\f\STX\EOT\b\243\251\ETX\DC2\EOT\182\SOH8V\n\
    \n\n\
    \\EOT\EOT\f\STX\ENQ\DC2\EOT\184\SOH\EOTY\SUB` How long the workflow start will be delayed - not really a \"backoff\" in the traditional sense.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ENQ\ACK\DC2\EOT\184\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ENQ\SOH\DC2\EOT\184\SOH\GS3\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ENQ\ETX\DC2\EOT\184\SOH67\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ENQ\b\DC2\EOT\184\SOH8X\n\
    \\DLE\n\
    \\b\EOT\f\STX\ENQ\b\243\251\ETX\DC2\EOT\184\SOH9W\n\
    \\f\n\
    \\EOT\EOT\f\STX\ACK\DC2\EOT\185\SOH\EOT8\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ACK\ACK\DC2\EOT\185\SOH\EOT&\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ACK\SOH\DC2\EOT\185\SOH'3\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ACK\ETX\DC2\EOT\185\SOH67\n\
    \!\n\
    \\EOT\EOT\f\STX\a\DC2\EOT\187\SOH\EOT?\SUB\DC3 Should be removed\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\a\ACK\DC2\EOT\187\SOH\EOT0\n\
    \\r\n\
    \\ENQ\EOT\f\STX\a\SOH\DC2\EOT\187\SOH1:\n\
    \\r\n\
    \\ENQ\EOT\f\STX\a\ETX\DC2\EOT\187\SOH=>\n\
    \!\n\
    \\EOT\EOT\f\STX\b\DC2\EOT\189\SOH\EOT0\SUB\DC3 Should be removed\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\b\ACK\DC2\EOT\189\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\f\STX\b\SOH\DC2\EOT\189\SOH$+\n\
    \\r\n\
    \\ENQ\EOT\f\STX\b\ETX\DC2\EOT\189\SOH./\n\
    \!\n\
    \\EOT\EOT\f\STX\t\DC2\EOT\191\SOH\EOT@\SUB\DC3 Should be removed\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\t\ACK\DC2\EOT\191\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\f\STX\t\SOH\DC2\EOT\191\SOH$:\n\
    \\r\n\
    \\ENQ\EOT\f\STX\t\ETX\DC2\EOT\191\SOH=?\n\
    \^\n\
    \\EOT\EOT\f\STX\n\
    \\DC2\EOT\193\SOH\EOT\RS\SUBP Should be removed. Not necessarily unused but unclear and not exposed by SDKs.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\n\
    \\ENQ\DC2\EOT\193\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\n\
    \\SOH\DC2\EOT\193\SOH\v\CAN\n\
    \\r\n\
    \\ENQ\EOT\f\STX\n\
    \\ETX\DC2\EOT\193\SOH\ESC\GS\n\
    \\f\n\
    \\EOT\EOT\f\STX\v\DC2\EOT\194\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\f\STX\v\ACK\DC2\EOT\194\SOH\EOT!\n\
    \\r\n\
    \\ENQ\EOT\f\STX\v\SOH\DC2\EOT\194\SOH\"(\n\
    \\r\n\
    \\ENQ\EOT\f\STX\v\ETX\DC2\EOT\194\SOH+-\n\
    \\f\n\
    \\EOT\EOT\f\STX\f\DC2\EOT\195\SOH\EOT*\n\
    \\r\n\
    \\ENQ\EOT\f\STX\f\ACK\DC2\EOT\195\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\f\STX\f\SOH\DC2\EOT\195\SOH $\n\
    \\r\n\
    \\ENQ\EOT\f\STX\f\ETX\DC2\EOT\195\SOH')\n\
    \\f\n\
    \\EOT\EOT\f\STX\r\DC2\EOT\196\SOH\EOTC\n\
    \\r\n\
    \\ENQ\EOT\f\STX\r\ACK\DC2\EOT\196\SOH\EOT+\n\
    \\r\n\
    \\ENQ\EOT\f\STX\r\SOH\DC2\EOT\196\SOH,=\n\
    \\r\n\
    \\ENQ\EOT\f\STX\r\ETX\DC2\EOT\196\SOH@B\n\
    \\180\SOH\n\
    \\EOT\EOT\f\STX\SO\DC2\EOT\199\SOH\EOT%\SUB\165\SOH If this is set, the workflow executing this command wishes to continue as new using a version\n\
    \ compatible with the version that this workflow most recently ran on.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SO\ENQ\DC2\EOT\199\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SO\SOH\DC2\EOT\199\SOH\t\US\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SO\ETX\DC2\EOT\199\SOH\"$\n\
    \\f\n\
    \\STX\EOT\r\DC2\ACK\204\SOH\NUL\231\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\r\SOH\DC2\EOT\204\SOH\b4\n\
    \\f\n\
    \\EOT\EOT\r\STX\NUL\DC2\EOT\205\SOH\EOT\EM\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ENQ\DC2\EOT\205\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\EOT\205\SOH\v\DC4\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\EOT\205\SOH\ETB\CAN\n\
    \\f\n\
    \\EOT\EOT\r\STX\SOH\DC2\EOT\206\SOH\EOT\ESC\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ENQ\DC2\EOT\206\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\SOH\DC2\EOT\206\SOH\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ETX\DC2\EOT\206\SOH\EM\SUB\n\
    \\f\n\
    \\EOT\EOT\r\STX\STX\DC2\EOT\207\SOH\EOT:\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ACK\DC2\EOT\207\SOH\EOT'\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\SOH\DC2\EOT\207\SOH(5\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ETX\DC2\EOT\207\SOH89\n\
    \\f\n\
    \\EOT\EOT\r\STX\ETX\DC2\EOT\208\SOH\EOT7\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ACK\DC2\EOT\208\SOH\EOT'\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\SOH\DC2\EOT\208\SOH(2\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ETX\DC2\EOT\208\SOH56\n\
    \\f\n\
    \\EOT\EOT\r\STX\EOT\DC2\EOT\209\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\ACK\DC2\EOT\209\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\SOH\DC2\EOT\209\SOH$)\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\ETX\DC2\EOT\209\SOH,-\n\
    \W\n\
    \\EOT\EOT\r\STX\ENQ\DC2\EOT\211\SOH\EOT]\SUBI Total workflow execution timeout including retries and continue as new.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\ACK\DC2\EOT\211\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\SOH\DC2\EOT\211\SOH\GS7\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\ETX\DC2\EOT\211\SOH:;\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\b\DC2\EOT\211\SOH<\\\n\
    \\DLE\n\
    \\b\EOT\r\STX\ENQ\b\243\251\ETX\DC2\EOT\211\SOH=[\n\
    \1\n\
    \\EOT\EOT\r\STX\ACK\DC2\EOT\213\SOH\EOTW\SUB# Timeout of a single workflow run.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\ACK\DC2\EOT\213\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\SOH\DC2\EOT\213\SOH\GS1\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\ETX\DC2\EOT\213\SOH45\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\b\DC2\EOT\213\SOH6V\n\
    \\DLE\n\
    \\b\EOT\r\STX\ACK\b\243\251\ETX\DC2\EOT\213\SOH7U\n\
    \2\n\
    \\EOT\EOT\r\STX\a\DC2\EOT\215\SOH\EOTX\SUB$ Timeout of a single workflow task.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\a\ACK\DC2\EOT\215\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\a\SOH\DC2\EOT\215\SOH\GS2\n\
    \\r\n\
    \\ENQ\EOT\r\STX\a\ETX\DC2\EOT\215\SOH56\n\
    \\r\n\
    \\ENQ\EOT\r\STX\a\b\DC2\EOT\215\SOH7W\n\
    \\DLE\n\
    \\b\EOT\r\STX\a\b\243\251\ETX\DC2\EOT\215\SOH8V\n\
    \7\n\
    \\EOT\EOT\r\STX\b\DC2\EOT\217\SOH\EOTD\SUB) Default: PARENT_CLOSE_POLICY_TERMINATE.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\b\ACK\DC2\EOT\217\SOH\EOT+\n\
    \\r\n\
    \\ENQ\EOT\r\STX\b\SOH\DC2\EOT\217\SOH,?\n\
    \\r\n\
    \\ENQ\EOT\r\STX\b\ETX\DC2\EOT\217\SOHBC\n\
    \\f\n\
    \\EOT\EOT\r\STX\t\DC2\EOT\218\SOH\EOT\CAN\n\
    \\r\n\
    \\ENQ\EOT\r\STX\t\ENQ\DC2\EOT\218\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\t\SOH\DC2\EOT\218\SOH\v\DC2\n\
    \\r\n\
    \\ENQ\EOT\r\STX\t\ETX\DC2\EOT\218\SOH\NAK\ETB\n\
    \B\n\
    \\EOT\EOT\r\STX\n\
    \\DC2\EOT\220\SOH\EOTN\SUB4 Default: WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\n\
    \\ACK\DC2\EOT\220\SOH\EOT/\n\
    \\r\n\
    \\ENQ\EOT\r\STX\n\
    \\SOH\DC2\EOT\220\SOH0H\n\
    \\r\n\
    \\ENQ\EOT\r\STX\n\
    \\ETX\DC2\EOT\220\SOHKM\n\
    \\f\n\
    \\EOT\EOT\r\STX\v\DC2\EOT\221\SOH\EOT9\n\
    \\r\n\
    \\ENQ\EOT\r\STX\v\ACK\DC2\EOT\221\SOH\EOT&\n\
    \\r\n\
    \\ENQ\EOT\r\STX\v\SOH\DC2\EOT\221\SOH'3\n\
    \\r\n\
    \\ENQ\EOT\r\STX\v\ETX\DC2\EOT\221\SOH68\n\
    \A\n\
    \\EOT\EOT\r\STX\f\DC2\EOT\223\SOH\EOT\RS\SUB3 Establish a cron schedule for the child workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\f\ENQ\DC2\EOT\223\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\f\SOH\DC2\EOT\223\SOH\v\CAN\n\
    \\r\n\
    \\ENQ\EOT\r\STX\f\ETX\DC2\EOT\223\SOH\ESC\GS\n\
    \\f\n\
    \\EOT\EOT\r\STX\r\DC2\EOT\224\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\r\STX\r\ACK\DC2\EOT\224\SOH\EOT!\n\
    \\r\n\
    \\ENQ\EOT\r\STX\r\SOH\DC2\EOT\224\SOH\"(\n\
    \\r\n\
    \\ENQ\EOT\r\STX\r\ETX\DC2\EOT\224\SOH+-\n\
    \\f\n\
    \\EOT\EOT\r\STX\SO\DC2\EOT\225\SOH\EOT*\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SO\ACK\DC2\EOT\225\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SO\SOH\DC2\EOT\225\SOH $\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SO\ETX\DC2\EOT\225\SOH')\n\
    \\f\n\
    \\EOT\EOT\r\STX\SI\DC2\EOT\226\SOH\EOTC\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SI\ACK\DC2\EOT\226\SOH\EOT+\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SI\SOH\DC2\EOT\226\SOH,=\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SI\ETX\DC2\EOT\226\SOH@B\n\
    \\220\SOH\n\
    \\EOT\EOT\r\STX\DLE\DC2\EOT\230\SOH\EOT%\SUB\205\SOH If this is set, the workflow executing this command wishes to start the child workflow using\n\
    \ a version compatible with the version that this workflow most recently ran on, if such\n\
    \ behavior is possible.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\DLE\ENQ\DC2\EOT\230\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\r\STX\DLE\SOH\DC2\EOT\230\SOH\t\US\n\
    \\r\n\
    \\ENQ\EOT\r\STX\DLE\ETX\DC2\EOT\230\SOH\"$\n\
    \\f\n\
    \\STX\EOT\SO\DC2\ACK\233\SOH\NUL\236\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\SO\SOH\DC2\EOT\233\SOH\b(\n\
    \Q\n\
    \\EOT\EOT\SO\STX\NUL\DC2\EOT\235\SOH\EOT\SUB\SUBC The message ID of the message to which this command is a pointer.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ENQ\DC2\EOT\235\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\EOT\235\SOH\v\NAK\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\EOT\235\SOH\CAN\EM\n\
    \\f\n\
    \\STX\EOT\SI\DC2\ACK\238\SOH\NUL\130\STX\SOH\n\
    \\v\n\
    \\ETX\EOT\SI\SOH\DC2\EOT\238\SOH\b\SI\n\
    \\f\n\
    \\EOT\EOT\SI\STX\NUL\DC2\EOT\239\SOH\EOT7\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ACK\DC2\EOT\239\SOH\EOT%\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\SOH\DC2\EOT\239\SOH&2\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ETX\DC2\EOT\239\SOH56\n\
    \\SO\n\
    \\EOT\EOT\SI\b\NUL\DC2\ACK\240\SOH\EOT\129\STX\ENQ\n\
    \\r\n\
    \\ENQ\EOT\SI\b\NUL\SOH\DC2\EOT\240\SOH\n\
    \\DC4\n\
    \\f\n\
    \\EOT\EOT\SI\STX\SOH\DC2\EOT\241\SOH\b\\\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ACK\DC2\EOT\241\SOH\b-\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\SOH\DC2\EOT\241\SOH.W\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ETX\DC2\EOT\241\SOHZ[\n\
    \\f\n\
    \\EOT\EOT\SI\STX\STX\DC2\EOT\242\SOH\bG\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\STX\ACK\DC2\EOT\242\SOH\b#\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\STX\SOH\DC2\EOT\242\SOH$B\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\STX\ETX\DC2\EOT\242\SOHEF\n\
    \\f\n\
    \\EOT\EOT\SI\STX\ETX\DC2\EOT\243\SOH\bf\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ETX\ACK\DC2\EOT\243\SOH\b2\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ETX\SOH\DC2\EOT\243\SOH3a\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ETX\ETX\DC2\EOT\243\SOHde\n\
    \\f\n\
    \\EOT\EOT\SI\STX\EOT\DC2\EOT\244\SOH\b^\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\EOT\ACK\DC2\EOT\244\SOH\b.\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\EOT\SOH\DC2\EOT\244\SOH/Y\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\EOT\ETX\DC2\EOT\244\SOH\\]\n\
    \\f\n\
    \\EOT\EOT\SI\STX\ENQ\DC2\EOT\245\SOH\bg\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ENQ\ACK\DC2\EOT\245\SOH\b2\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ENQ\SOH\DC2\EOT\245\SOH3b\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ENQ\ETX\DC2\EOT\245\SOHef\n\
    \\f\n\
    \\EOT\EOT\SI\STX\ACK\DC2\EOT\246\SOH\bI\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ACK\ACK\DC2\EOT\246\SOH\b$\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ACK\SOH\DC2\EOT\246\SOH%D\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\ACK\ETX\DC2\EOT\246\SOHGH\n\
    \\f\n\
    \\EOT\EOT\SI\STX\a\DC2\EOT\247\SOH\bb\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\a\ACK\DC2\EOT\247\SOH\b0\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\a\SOH\DC2\EOT\247\SOH1]\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\a\ETX\DC2\EOT\247\SOH`a\n\
    \\r\n\
    \\EOT\EOT\SI\STX\b\DC2\ENQ\248\SOH\b\130\SOH\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\b\ACK\DC2\EOT\248\SOH\b?\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\b\SOH\DC2\EOT\248\SOH@}\n\
    \\SI\n\
    \\ENQ\EOT\SI\STX\b\ETX\DC2\ACK\248\SOH\128\SOH\129\SOH\n\
    \\f\n\
    \\EOT\EOT\SI\STX\t\DC2\EOT\249\SOH\bL\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\t\ACK\DC2\EOT\249\SOH\b%\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\t\SOH\DC2\EOT\249\SOH&F\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\t\ETX\DC2\EOT\249\SOHIK\n\
    \\f\n\
    \\EOT\EOT\SI\STX\n\
    \\DC2\EOT\250\SOH\bs\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\n\
    \\ACK\DC2\EOT\250\SOH\b7\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\n\
    \\SOH\DC2\EOT\250\SOH8m\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\n\
    \\ETX\DC2\EOT\250\SOHpr\n\
    \\f\n\
    \\EOT\EOT\SI\STX\v\DC2\EOT\251\SOH\bl\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\v\ACK\DC2\EOT\251\SOH\b4\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\v\SOH\DC2\EOT\251\SOH5f\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\v\ETX\DC2\EOT\251\SOHik\n\
    \\f\n\
    \\EOT\EOT\SI\STX\f\DC2\EOT\252\SOH\bt\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\f\ACK\DC2\EOT\252\SOH\b8\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\f\SOH\DC2\EOT\252\SOH9n\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\f\ETX\DC2\EOT\252\SOHqs\n\
    \\f\n\
    \\EOT\EOT\SI\STX\r\DC2\EOT\253\SOH\br\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\r\ACK\DC2\EOT\253\SOH\b7\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\r\SOH\DC2\EOT\253\SOH8l\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\r\ETX\DC2\EOT\253\SOHoq\n\
    \\f\n\
    \\EOT\EOT\SI\STX\SO\DC2\EOT\254\SOH\bR\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SO\ACK\DC2\EOT\254\SOH\b(\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SO\SOH\DC2\EOT\254\SOH)L\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SO\ETX\DC2\EOT\254\SOHOQ\n\
    \n\n\
    \\EOT\EOT\SI\STX\SI\DC2\EOT\128\STX\be\SUB` 16 is available for use - it was used as part of a prototype that never made it into a release\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SI\ACK\DC2\EOT\128\STX\b1\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SI\SOH\DC2\EOT\128\STX2_\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SI\ETX\DC2\EOT\128\STXbdb\ACKproto3"
{- This file was auto-generated from temporal/api/protocol/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Protocol.V1.Message (
        Message(), Message'SequencingId(..), _Message'EventId,
        _Message'CommandIndex
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
import qualified Proto.Google.Protobuf.Any
{- | Fields :
     
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.id' @:: Lens' Message Data.Text.Text@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.protocolInstanceId' @:: Lens' Message Data.Text.Text@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.body' @:: Lens' Message Proto.Google.Protobuf.Any.Any@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.maybe'body' @:: Lens' Message (Prelude.Maybe Proto.Google.Protobuf.Any.Any)@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.maybe'sequencingId' @:: Lens' Message (Prelude.Maybe Message'SequencingId)@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.maybe'eventId' @:: Lens' Message (Prelude.Maybe Data.Int.Int64)@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.eventId' @:: Lens' Message Data.Int.Int64@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.maybe'commandIndex' @:: Lens' Message (Prelude.Maybe Data.Int.Int64)@
         * 'Proto.Temporal.Api.Protocol.V1.Message_Fields.commandIndex' @:: Lens' Message Data.Int.Int64@ -}
data Message
  = Message'_constructor {_Message'id :: !Data.Text.Text,
                          _Message'protocolInstanceId :: !Data.Text.Text,
                          _Message'body :: !(Prelude.Maybe Proto.Google.Protobuf.Any.Any),
                          _Message'sequencingId :: !(Prelude.Maybe Message'SequencingId),
                          _Message'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Message where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Message'SequencingId
  = Message'EventId !Data.Int.Int64 |
    Message'CommandIndex !Data.Int.Int64
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Message "id" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'id (\ x__ y__ -> x__ {_Message'id = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Message "protocolInstanceId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'protocolInstanceId
           (\ x__ y__ -> x__ {_Message'protocolInstanceId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Message "body" Proto.Google.Protobuf.Any.Any where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'body (\ x__ y__ -> x__ {_Message'body = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Message "maybe'body" (Prelude.Maybe Proto.Google.Protobuf.Any.Any) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'body (\ x__ y__ -> x__ {_Message'body = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Message "maybe'sequencingId" (Prelude.Maybe Message'SequencingId) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'sequencingId
           (\ x__ y__ -> x__ {_Message'sequencingId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Message "maybe'eventId" (Prelude.Maybe Data.Int.Int64) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'sequencingId
           (\ x__ y__ -> x__ {_Message'sequencingId = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Message'EventId x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Message'EventId y__))
instance Data.ProtoLens.Field.HasField Message "eventId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'sequencingId
           (\ x__ y__ -> x__ {_Message'sequencingId = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Message'EventId x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Message'EventId y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Field.HasField Message "maybe'commandIndex" (Prelude.Maybe Data.Int.Int64) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'sequencingId
           (\ x__ y__ -> x__ {_Message'sequencingId = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Message'CommandIndex x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Message'CommandIndex y__))
instance Data.ProtoLens.Field.HasField Message "commandIndex" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Message'sequencingId
           (\ x__ y__ -> x__ {_Message'sequencingId = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Message'CommandIndex x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Message'CommandIndex y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Message Message where
  messageName _ = Data.Text.pack "temporal.api.protocol.v1.Message"
  packedMessageDescriptor _
    = "\n\
      \\aMessage\DC2\SO\n\
      \\STXid\CAN\SOH \SOH(\tR\STXid\DC20\n\
      \\DC4protocol_instance_id\CAN\STX \SOH(\tR\DC2protocolInstanceId\DC2\ESC\n\
      \\bevent_id\CAN\ETX \SOH(\ETXH\NULR\aeventId\DC2%\n\
      \\rcommand_index\CAN\EOT \SOH(\ETXH\NULR\fcommandIndex\DC2(\n\
      \\EOTbody\CAN\ENQ \SOH(\v2\DC4.google.protobuf.AnyR\EOTbodyB\SI\n\
      \\rsequencing_id"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        id__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"id")) ::
              Data.ProtoLens.FieldDescriptor Message
        protocolInstanceId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "protocol_instance_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"protocolInstanceId")) ::
              Data.ProtoLens.FieldDescriptor Message
        body__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "body"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Any.Any)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'body")) ::
              Data.ProtoLens.FieldDescriptor Message
        eventId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "event_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'eventId")) ::
              Data.ProtoLens.FieldDescriptor Message
        commandIndex__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "command_index"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'commandIndex")) ::
              Data.ProtoLens.FieldDescriptor Message
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, id__field_descriptor),
           (Data.ProtoLens.Tag 2, protocolInstanceId__field_descriptor),
           (Data.ProtoLens.Tag 5, body__field_descriptor),
           (Data.ProtoLens.Tag 3, eventId__field_descriptor),
           (Data.ProtoLens.Tag 4, commandIndex__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Message'_unknownFields
        (\ x__ y__ -> x__ {_Message'_unknownFields = y__})
  defMessage
    = Message'_constructor
        {_Message'id = Data.ProtoLens.fieldDefault,
         _Message'protocolInstanceId = Data.ProtoLens.fieldDefault,
         _Message'body = Prelude.Nothing,
         _Message'sequencingId = Prelude.Nothing,
         _Message'_unknownFields = []}
  parseMessage
    = let
        loop :: Message -> Data.ProtoLens.Encoding.Bytes.Parser Message
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"id") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "protocol_instance_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"protocolInstanceId") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "body"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"body") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "event_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"eventId") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "command_index"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"commandIndex") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Message"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"id") _x
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
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"protocolInstanceId") _x
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
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'body") _x
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
                             (Data.ProtoLens.Field.field @"maybe'sequencingId") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just (Message'EventId v))
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                                ((Prelude..)
                                   Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral v)
                         (Prelude.Just (Message'CommandIndex v))
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                                ((Prelude..)
                                   Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData Message where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Message'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Message'id x__)
                (Control.DeepSeq.deepseq
                   (_Message'protocolInstanceId x__)
                   (Control.DeepSeq.deepseq
                      (_Message'body x__)
                      (Control.DeepSeq.deepseq (_Message'sequencingId x__) ()))))
instance Control.DeepSeq.NFData Message'SequencingId where
  rnf (Message'EventId x__) = Control.DeepSeq.rnf x__
  rnf (Message'CommandIndex x__) = Control.DeepSeq.rnf x__
_Message'EventId ::
  Data.ProtoLens.Prism.Prism' Message'SequencingId Data.Int.Int64
_Message'EventId
  = Data.ProtoLens.Prism.prism'
      Message'EventId
      (\ p__
         -> case p__ of
              (Message'EventId p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Message'CommandIndex ::
  Data.ProtoLens.Prism.Prism' Message'SequencingId Data.Int.Int64
_Message'CommandIndex
  = Data.ProtoLens.Prism.prism'
      Message'CommandIndex
      (\ p__
         -> case p__ of
              (Message'CommandIndex p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \&temporal/api/protocol/v1/message.proto\DC2\CANtemporal.api.protocol.v1\SUB\EMgoogle/protobuf/any.proto\"\202\SOH\n\
    \\aMessage\DC2\SO\n\
    \\STXid\CAN\SOH \SOH(\tR\STXid\DC20\n\
    \\DC4protocol_instance_id\CAN\STX \SOH(\tR\DC2protocolInstanceId\DC2\ESC\n\
    \\bevent_id\CAN\ETX \SOH(\ETXH\NULR\aeventId\DC2%\n\
    \\rcommand_index\CAN\EOT \SOH(\ETXH\NULR\fcommandIndex\DC2(\n\
    \\EOTbody\CAN\ENQ \SOH(\v2\DC4.google.protobuf.AnyR\EOTbodyB\SI\n\
    \\rsequencing_idB\147\SOH\n\
    \\ESCio.temporal.api.protocol.v1B\fMessageProtoP\SOHZ'go.temporal.io/api/protocol/v1;protocol\170\STX\SUBTemporalio.Api.Protocol.V1\234\STX\GSTemporalio::Api::Protocol::V1J\183\DC1\n\
    \\ACK\DC2\EOT\SYN\NUL8\SOH\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL!\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL>\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL>\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL4\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL4\n\
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
    \\SOH\b\DC2\ETX\RS\NUL6\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL6\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL7\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL7\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL#\n\
    \\135\SOH\n\
    \\STX\EOT\NUL\DC2\EOT%\NUL8\SOH\SUB{ (-- api-linter: core::0146::any=disabled\n\
    \     aip.dev/not-precedent: We want runtime extensibility for the body field --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX%\b\SI\n\
    \/\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX'\EOT\DC2\SUB\" An ID for this specific message.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX'\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX'\v\r\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX'\DLE\DC1\n\
    \]\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX+\EOT$\SUBP Identifies the specific instance of a protocol to which this message\n\
    \ belongs.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX+\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX+\v\US\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX+\"#\n\
    \\233\SOH\n\
    \\EOT\EOT\NUL\b\NUL\DC2\EOT0\EOT3\ENQ\SUB\218\SOH The event ID or command ID after which this message can be delivered. The\n\
    \ effects of history up to and including this event ID should be visible to\n\
    \ the code that handles this message. Omit to opt out of sequencing.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\b\NUL\SOH\DC2\ETX0\n\
    \\ETB\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX1\b\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX1\b\r\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX1\SO\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX1\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX2\b \n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ENQ\DC2\ETX2\b\r\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX2\SO\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX2\RS\US\n\
    \\153\SOH\n\
    \\EOT\EOT\NUL\STX\EOT\DC2\ETX7\EOT!\SUB\139\SOH The opaque data carried by this message. The protocol type can be\n\
    \ extracted from the package name of the message carried inside the Any.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ACK\DC2\ETX7\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\SOH\DC2\ETX7\CAN\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ETX\DC2\ETX7\US b\ACKproto3"
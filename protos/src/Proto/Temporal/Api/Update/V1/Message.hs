{- This file was auto-generated from temporal/api/update/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Update.V1.Message (
        Acceptance(), Input(), Meta(), Outcome(), Outcome'Value(..),
        _Outcome'Success, _Outcome'Failure, Rejection(), Request(),
        Response(), UpdateRef(), WaitPolicy()
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
import qualified Proto.Temporal.Api.Enums.V1.Update
import qualified Proto.Temporal.Api.Failure.V1.Message
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.acceptedRequestMessageId' @:: Lens' Acceptance Data.Text.Text@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.acceptedRequestSequencingEventId' @:: Lens' Acceptance Data.Int.Int64@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.acceptedRequest' @:: Lens' Acceptance Request@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'acceptedRequest' @:: Lens' Acceptance (Prelude.Maybe Request)@ -}
data Acceptance
  = Acceptance'_constructor {_Acceptance'acceptedRequestMessageId :: !Data.Text.Text,
                             _Acceptance'acceptedRequestSequencingEventId :: !Data.Int.Int64,
                             _Acceptance'acceptedRequest :: !(Prelude.Maybe Request),
                             _Acceptance'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Acceptance where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Acceptance "acceptedRequestMessageId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Acceptance'acceptedRequestMessageId
           (\ x__ y__ -> x__ {_Acceptance'acceptedRequestMessageId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Acceptance "acceptedRequestSequencingEventId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Acceptance'acceptedRequestSequencingEventId
           (\ x__ y__
              -> x__ {_Acceptance'acceptedRequestSequencingEventId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Acceptance "acceptedRequest" Request where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Acceptance'acceptedRequest
           (\ x__ y__ -> x__ {_Acceptance'acceptedRequest = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Acceptance "maybe'acceptedRequest" (Prelude.Maybe Request) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Acceptance'acceptedRequest
           (\ x__ y__ -> x__ {_Acceptance'acceptedRequest = y__}))
        Prelude.id
instance Data.ProtoLens.Message Acceptance where
  messageName _ = Data.Text.pack "temporal.api.update.v1.Acceptance"
  packedMessageDescriptor _
    = "\n\
      \\n\
      \Acceptance\DC2=\n\
      \\ESCaccepted_request_message_id\CAN\SOH \SOH(\tR\CANacceptedRequestMessageId\DC2N\n\
      \$accepted_request_sequencing_event_id\CAN\STX \SOH(\ETXR acceptedRequestSequencingEventId\DC2J\n\
      \\DLEaccepted_request\CAN\ETX \SOH(\v2\US.temporal.api.update.v1.RequestR\SIacceptedRequest"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        acceptedRequestMessageId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "accepted_request_message_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"acceptedRequestMessageId")) ::
              Data.ProtoLens.FieldDescriptor Acceptance
        acceptedRequestSequencingEventId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "accepted_request_sequencing_event_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field
                    @"acceptedRequestSequencingEventId")) ::
              Data.ProtoLens.FieldDescriptor Acceptance
        acceptedRequest__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "accepted_request"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Request)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'acceptedRequest")) ::
              Data.ProtoLens.FieldDescriptor Acceptance
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, 
            acceptedRequestMessageId__field_descriptor),
           (Data.ProtoLens.Tag 2, 
            acceptedRequestSequencingEventId__field_descriptor),
           (Data.ProtoLens.Tag 3, acceptedRequest__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Acceptance'_unknownFields
        (\ x__ y__ -> x__ {_Acceptance'_unknownFields = y__})
  defMessage
    = Acceptance'_constructor
        {_Acceptance'acceptedRequestMessageId = Data.ProtoLens.fieldDefault,
         _Acceptance'acceptedRequestSequencingEventId = Data.ProtoLens.fieldDefault,
         _Acceptance'acceptedRequest = Prelude.Nothing,
         _Acceptance'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Acceptance -> Data.ProtoLens.Encoding.Bytes.Parser Acceptance
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
                                       "accepted_request_message_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"acceptedRequestMessageId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "accepted_request_sequencing_event_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"acceptedRequestSequencingEventId")
                                     y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "accepted_request"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"acceptedRequest") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Acceptance"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"acceptedRequestMessageId") _x
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
                         (Data.ProtoLens.Field.field @"acceptedRequestSequencingEventId") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'acceptedRequest") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Acceptance where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Acceptance'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Acceptance'acceptedRequestMessageId x__)
                (Control.DeepSeq.deepseq
                   (_Acceptance'acceptedRequestSequencingEventId x__)
                   (Control.DeepSeq.deepseq (_Acceptance'acceptedRequest x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.header' @:: Lens' Input Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'header' @:: Lens' Input (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.name' @:: Lens' Input Data.Text.Text@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.args' @:: Lens' Input Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'args' @:: Lens' Input (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@ -}
data Input
  = Input'_constructor {_Input'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                        _Input'name :: !Data.Text.Text,
                        _Input'args :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                        _Input'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Input where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Input "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Input'header (\ x__ y__ -> x__ {_Input'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Input "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Input'header (\ x__ y__ -> x__ {_Input'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Input "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Input'name (\ x__ y__ -> x__ {_Input'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Input "args" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Input'args (\ x__ y__ -> x__ {_Input'args = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Input "maybe'args" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Input'args (\ x__ y__ -> x__ {_Input'args = y__}))
        Prelude.id
instance Data.ProtoLens.Message Input where
  messageName _ = Data.Text.pack "temporal.api.update.v1.Input"
  packedMessageDescriptor _
    = "\n\
      \\ENQInput\DC26\n\
      \\ACKheader\CAN\SOH \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2\DC2\n\
      \\EOTname\CAN\STX \SOH(\tR\EOTname\DC24\n\
      \\EOTargs\CAN\ETX \SOH(\v2 .temporal.api.common.v1.PayloadsR\EOTargs"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor Input
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor Input
        args__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "args"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'args")) ::
              Data.ProtoLens.FieldDescriptor Input
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, header__field_descriptor),
           (Data.ProtoLens.Tag 2, name__field_descriptor),
           (Data.ProtoLens.Tag 3, args__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Input'_unknownFields
        (\ x__ y__ -> x__ {_Input'_unknownFields = y__})
  defMessage
    = Input'_constructor
        {_Input'header = Prelude.Nothing,
         _Input'name = Data.ProtoLens.fieldDefault,
         _Input'args = Prelude.Nothing, _Input'_unknownFields = []}
  parseMessage
    = let
        loop :: Input -> Data.ProtoLens.Encoding.Bytes.Parser Input
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
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
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
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "args"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"args") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Input"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'header") _x
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
                (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
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
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'args") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Input where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Input'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Input'header x__)
                (Control.DeepSeq.deepseq
                   (_Input'name x__) (Control.DeepSeq.deepseq (_Input'args x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.updateId' @:: Lens' Meta Data.Text.Text@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.identity' @:: Lens' Meta Data.Text.Text@ -}
data Meta
  = Meta'_constructor {_Meta'updateId :: !Data.Text.Text,
                       _Meta'identity :: !Data.Text.Text,
                       _Meta'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Meta where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Meta "updateId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Meta'updateId (\ x__ y__ -> x__ {_Meta'updateId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Meta "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Meta'identity (\ x__ y__ -> x__ {_Meta'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Message Meta where
  messageName _ = Data.Text.pack "temporal.api.update.v1.Meta"
  packedMessageDescriptor _
    = "\n\
      \\EOTMeta\DC2\ESC\n\
      \\tupdate_id\CAN\SOH \SOH(\tR\bupdateId\DC2\SUB\n\
      \\bidentity\CAN\STX \SOH(\tR\bidentity"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        updateId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "update_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"updateId")) ::
              Data.ProtoLens.FieldDescriptor Meta
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor Meta
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, updateId__field_descriptor),
           (Data.ProtoLens.Tag 2, identity__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Meta'_unknownFields
        (\ x__ y__ -> x__ {_Meta'_unknownFields = y__})
  defMessage
    = Meta'_constructor
        {_Meta'updateId = Data.ProtoLens.fieldDefault,
         _Meta'identity = Data.ProtoLens.fieldDefault,
         _Meta'_unknownFields = []}
  parseMessage
    = let
        loop :: Meta -> Data.ProtoLens.Encoding.Bytes.Parser Meta
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
                                       "update_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"updateId") y x)
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
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Meta"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"updateId") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
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
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Meta where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Meta'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Meta'updateId x__)
                (Control.DeepSeq.deepseq (_Meta'identity x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'value' @:: Lens' Outcome (Prelude.Maybe Outcome'Value)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'success' @:: Lens' Outcome (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.success' @:: Lens' Outcome Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'failure' @:: Lens' Outcome (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.failure' @:: Lens' Outcome Proto.Temporal.Api.Failure.V1.Message.Failure@ -}
data Outcome
  = Outcome'_constructor {_Outcome'value :: !(Prelude.Maybe Outcome'Value),
                          _Outcome'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Outcome where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Outcome'Value
  = Outcome'Success !Proto.Temporal.Api.Common.V1.Message.Payloads |
    Outcome'Failure !Proto.Temporal.Api.Failure.V1.Message.Failure
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Outcome "maybe'value" (Prelude.Maybe Outcome'Value) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Outcome'value (\ x__ y__ -> x__ {_Outcome'value = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Outcome "maybe'success" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Outcome'value (\ x__ y__ -> x__ {_Outcome'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Outcome'Success x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Outcome'Success y__))
instance Data.ProtoLens.Field.HasField Outcome "success" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Outcome'value (\ x__ y__ -> x__ {_Outcome'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Outcome'Success x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Outcome'Success y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Outcome "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Outcome'value (\ x__ y__ -> x__ {_Outcome'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Outcome'Failure x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Outcome'Failure y__))
instance Data.ProtoLens.Field.HasField Outcome "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Outcome'value (\ x__ y__ -> x__ {_Outcome'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Outcome'Failure x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Outcome'Failure y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message Outcome where
  messageName _ = Data.Text.pack "temporal.api.update.v1.Outcome"
  packedMessageDescriptor _
    = "\n\
      \\aOutcome\DC2<\n\
      \\asuccess\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsH\NULR\asuccess\DC2<\n\
      \\afailure\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\afailureB\a\n\
      \\ENQvalue"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        success__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "success"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'success")) ::
              Data.ProtoLens.FieldDescriptor Outcome
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor Outcome
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, success__field_descriptor),
           (Data.ProtoLens.Tag 2, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Outcome'_unknownFields
        (\ x__ y__ -> x__ {_Outcome'_unknownFields = y__})
  defMessage
    = Outcome'_constructor
        {_Outcome'value = Prelude.Nothing, _Outcome'_unknownFields = []}
  parseMessage
    = let
        loop :: Outcome -> Data.ProtoLens.Encoding.Bytes.Parser Outcome
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
                                       "success"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"success") y x)
                        18
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
          (do loop Data.ProtoLens.defMessage) "Outcome"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'value") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (Outcome'Success v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (Outcome'Failure v))
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
instance Control.DeepSeq.NFData Outcome where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Outcome'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Outcome'value x__) ())
instance Control.DeepSeq.NFData Outcome'Value where
  rnf (Outcome'Success x__) = Control.DeepSeq.rnf x__
  rnf (Outcome'Failure x__) = Control.DeepSeq.rnf x__
_Outcome'Success ::
  Data.ProtoLens.Prism.Prism' Outcome'Value Proto.Temporal.Api.Common.V1.Message.Payloads
_Outcome'Success
  = Data.ProtoLens.Prism.prism'
      Outcome'Success
      (\ p__
         -> case p__ of
              (Outcome'Success p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Outcome'Failure ::
  Data.ProtoLens.Prism.Prism' Outcome'Value Proto.Temporal.Api.Failure.V1.Message.Failure
_Outcome'Failure
  = Data.ProtoLens.Prism.prism'
      Outcome'Failure
      (\ p__
         -> case p__ of
              (Outcome'Failure p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.rejectedRequestMessageId' @:: Lens' Rejection Data.Text.Text@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.rejectedRequestSequencingEventId' @:: Lens' Rejection Data.Int.Int64@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.rejectedRequest' @:: Lens' Rejection Request@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'rejectedRequest' @:: Lens' Rejection (Prelude.Maybe Request)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.failure' @:: Lens' Rejection Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'failure' @:: Lens' Rejection (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@ -}
data Rejection
  = Rejection'_constructor {_Rejection'rejectedRequestMessageId :: !Data.Text.Text,
                            _Rejection'rejectedRequestSequencingEventId :: !Data.Int.Int64,
                            _Rejection'rejectedRequest :: !(Prelude.Maybe Request),
                            _Rejection'failure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                            _Rejection'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Rejection where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Rejection "rejectedRequestMessageId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Rejection'rejectedRequestMessageId
           (\ x__ y__ -> x__ {_Rejection'rejectedRequestMessageId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Rejection "rejectedRequestSequencingEventId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Rejection'rejectedRequestSequencingEventId
           (\ x__ y__
              -> x__ {_Rejection'rejectedRequestSequencingEventId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Rejection "rejectedRequest" Request where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Rejection'rejectedRequest
           (\ x__ y__ -> x__ {_Rejection'rejectedRequest = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Rejection "maybe'rejectedRequest" (Prelude.Maybe Request) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Rejection'rejectedRequest
           (\ x__ y__ -> x__ {_Rejection'rejectedRequest = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Rejection "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Rejection'failure (\ x__ y__ -> x__ {_Rejection'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Rejection "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Rejection'failure (\ x__ y__ -> x__ {_Rejection'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message Rejection where
  messageName _ = Data.Text.pack "temporal.api.update.v1.Rejection"
  packedMessageDescriptor _
    = "\n\
      \\tRejection\DC2=\n\
      \\ESCrejected_request_message_id\CAN\SOH \SOH(\tR\CANrejectedRequestMessageId\DC2N\n\
      \$rejected_request_sequencing_event_id\CAN\STX \SOH(\ETXR rejectedRequestSequencingEventId\DC2J\n\
      \\DLErejected_request\CAN\ETX \SOH(\v2\US.temporal.api.update.v1.RequestR\SIrejectedRequest\DC2:\n\
      \\afailure\CAN\EOT \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        rejectedRequestMessageId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rejected_request_message_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"rejectedRequestMessageId")) ::
              Data.ProtoLens.FieldDescriptor Rejection
        rejectedRequestSequencingEventId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rejected_request_sequencing_event_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field
                    @"rejectedRequestSequencingEventId")) ::
              Data.ProtoLens.FieldDescriptor Rejection
        rejectedRequest__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rejected_request"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Request)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'rejectedRequest")) ::
              Data.ProtoLens.FieldDescriptor Rejection
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor Rejection
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, 
            rejectedRequestMessageId__field_descriptor),
           (Data.ProtoLens.Tag 2, 
            rejectedRequestSequencingEventId__field_descriptor),
           (Data.ProtoLens.Tag 3, rejectedRequest__field_descriptor),
           (Data.ProtoLens.Tag 4, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Rejection'_unknownFields
        (\ x__ y__ -> x__ {_Rejection'_unknownFields = y__})
  defMessage
    = Rejection'_constructor
        {_Rejection'rejectedRequestMessageId = Data.ProtoLens.fieldDefault,
         _Rejection'rejectedRequestSequencingEventId = Data.ProtoLens.fieldDefault,
         _Rejection'rejectedRequest = Prelude.Nothing,
         _Rejection'failure = Prelude.Nothing,
         _Rejection'_unknownFields = []}
  parseMessage
    = let
        loop :: Rejection -> Data.ProtoLens.Encoding.Bytes.Parser Rejection
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
                                       "rejected_request_message_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"rejectedRequestMessageId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "rejected_request_sequencing_event_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"rejectedRequestSequencingEventId")
                                     y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "rejected_request"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"rejectedRequest") y x)
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
          (do loop Data.ProtoLens.defMessage) "Rejection"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"rejectedRequestMessageId") _x
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
                         (Data.ProtoLens.Field.field @"rejectedRequestSequencingEventId") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'rejectedRequest") _x
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
instance Control.DeepSeq.NFData Rejection where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Rejection'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Rejection'rejectedRequestMessageId x__)
                (Control.DeepSeq.deepseq
                   (_Rejection'rejectedRequestSequencingEventId x__)
                   (Control.DeepSeq.deepseq
                      (_Rejection'rejectedRequest x__)
                      (Control.DeepSeq.deepseq (_Rejection'failure x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.meta' @:: Lens' Request Meta@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'meta' @:: Lens' Request (Prelude.Maybe Meta)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.input' @:: Lens' Request Input@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'input' @:: Lens' Request (Prelude.Maybe Input)@ -}
data Request
  = Request'_constructor {_Request'meta :: !(Prelude.Maybe Meta),
                          _Request'input :: !(Prelude.Maybe Input),
                          _Request'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Request where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Request "meta" Meta where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'meta (\ x__ y__ -> x__ {_Request'meta = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Request "maybe'meta" (Prelude.Maybe Meta) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'meta (\ x__ y__ -> x__ {_Request'meta = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Request "input" Input where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'input (\ x__ y__ -> x__ {_Request'input = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Request "maybe'input" (Prelude.Maybe Input) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'input (\ x__ y__ -> x__ {_Request'input = y__}))
        Prelude.id
instance Data.ProtoLens.Message Request where
  messageName _ = Data.Text.pack "temporal.api.update.v1.Request"
  packedMessageDescriptor _
    = "\n\
      \\aRequest\DC20\n\
      \\EOTmeta\CAN\SOH \SOH(\v2\FS.temporal.api.update.v1.MetaR\EOTmeta\DC23\n\
      \\ENQinput\CAN\STX \SOH(\v2\GS.temporal.api.update.v1.InputR\ENQinput"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        meta__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "meta"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Meta)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'meta")) ::
              Data.ProtoLens.FieldDescriptor Request
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Input)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'input")) ::
              Data.ProtoLens.FieldDescriptor Request
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, meta__field_descriptor),
           (Data.ProtoLens.Tag 2, input__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Request'_unknownFields
        (\ x__ y__ -> x__ {_Request'_unknownFields = y__})
  defMessage
    = Request'_constructor
        {_Request'meta = Prelude.Nothing, _Request'input = Prelude.Nothing,
         _Request'_unknownFields = []}
  parseMessage
    = let
        loop :: Request -> Data.ProtoLens.Encoding.Bytes.Parser Request
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
                                       "meta"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"meta") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "input"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"input") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Request"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'meta") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'input") _x
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
instance Control.DeepSeq.NFData Request where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Request'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Request'meta x__)
                (Control.DeepSeq.deepseq (_Request'input x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.meta' @:: Lens' Response Meta@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'meta' @:: Lens' Response (Prelude.Maybe Meta)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.outcome' @:: Lens' Response Outcome@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'outcome' @:: Lens' Response (Prelude.Maybe Outcome)@ -}
data Response
  = Response'_constructor {_Response'meta :: !(Prelude.Maybe Meta),
                           _Response'outcome :: !(Prelude.Maybe Outcome),
                           _Response'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Response where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Response "meta" Meta where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'meta (\ x__ y__ -> x__ {_Response'meta = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Response "maybe'meta" (Prelude.Maybe Meta) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'meta (\ x__ y__ -> x__ {_Response'meta = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Response "outcome" Outcome where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'outcome (\ x__ y__ -> x__ {_Response'outcome = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Response "maybe'outcome" (Prelude.Maybe Outcome) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'outcome (\ x__ y__ -> x__ {_Response'outcome = y__}))
        Prelude.id
instance Data.ProtoLens.Message Response where
  messageName _ = Data.Text.pack "temporal.api.update.v1.Response"
  packedMessageDescriptor _
    = "\n\
      \\bResponse\DC20\n\
      \\EOTmeta\CAN\SOH \SOH(\v2\FS.temporal.api.update.v1.MetaR\EOTmeta\DC29\n\
      \\aoutcome\CAN\STX \SOH(\v2\US.temporal.api.update.v1.OutcomeR\aoutcome"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        meta__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "meta"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Meta)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'meta")) ::
              Data.ProtoLens.FieldDescriptor Response
        outcome__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "outcome"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Outcome)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'outcome")) ::
              Data.ProtoLens.FieldDescriptor Response
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, meta__field_descriptor),
           (Data.ProtoLens.Tag 2, outcome__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Response'_unknownFields
        (\ x__ y__ -> x__ {_Response'_unknownFields = y__})
  defMessage
    = Response'_constructor
        {_Response'meta = Prelude.Nothing,
         _Response'outcome = Prelude.Nothing, _Response'_unknownFields = []}
  parseMessage
    = let
        loop :: Response -> Data.ProtoLens.Encoding.Bytes.Parser Response
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
                                       "meta"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"meta") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "outcome"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"outcome") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Response"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'meta") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'outcome") _x
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
instance Control.DeepSeq.NFData Response where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Response'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Response'meta x__)
                (Control.DeepSeq.deepseq (_Response'outcome x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.workflowExecution' @:: Lens' UpdateRef Proto.Temporal.Api.Common.V1.Message.WorkflowExecution@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.maybe'workflowExecution' @:: Lens' UpdateRef (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)@
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.updateId' @:: Lens' UpdateRef Data.Text.Text@ -}
data UpdateRef
  = UpdateRef'_constructor {_UpdateRef'workflowExecution :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution),
                            _UpdateRef'updateId :: !Data.Text.Text,
                            _UpdateRef'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UpdateRef where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UpdateRef "workflowExecution" Proto.Temporal.Api.Common.V1.Message.WorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateRef'workflowExecution
           (\ x__ y__ -> x__ {_UpdateRef'workflowExecution = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField UpdateRef "maybe'workflowExecution" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateRef'workflowExecution
           (\ x__ y__ -> x__ {_UpdateRef'workflowExecution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UpdateRef "updateId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateRef'updateId (\ x__ y__ -> x__ {_UpdateRef'updateId = y__}))
        Prelude.id
instance Data.ProtoLens.Message UpdateRef where
  messageName _ = Data.Text.pack "temporal.api.update.v1.UpdateRef"
  packedMessageDescriptor _
    = "\n\
      \\tUpdateRef\DC2X\n\
      \\DC2workflow_execution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\DC1workflowExecution\DC2\ESC\n\
      \\tupdate_id\CAN\STX \SOH(\tR\bupdateId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowExecution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowExecution")) ::
              Data.ProtoLens.FieldDescriptor UpdateRef
        updateId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "update_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"updateId")) ::
              Data.ProtoLens.FieldDescriptor UpdateRef
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowExecution__field_descriptor),
           (Data.ProtoLens.Tag 2, updateId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UpdateRef'_unknownFields
        (\ x__ y__ -> x__ {_UpdateRef'_unknownFields = y__})
  defMessage
    = UpdateRef'_constructor
        {_UpdateRef'workflowExecution = Prelude.Nothing,
         _UpdateRef'updateId = Data.ProtoLens.fieldDefault,
         _UpdateRef'_unknownFields = []}
  parseMessage
    = let
        loop :: UpdateRef -> Data.ProtoLens.Encoding.Bytes.Parser UpdateRef
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
                                       "workflow_execution"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecution") y x)
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
                                       "update_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"updateId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "UpdateRef"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'workflowExecution") _x
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
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"updateId") _x
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
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData UpdateRef where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UpdateRef'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_UpdateRef'workflowExecution x__)
                (Control.DeepSeq.deepseq (_UpdateRef'updateId x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Update.V1.Message_Fields.lifecycleStage' @:: Lens' WaitPolicy Proto.Temporal.Api.Enums.V1.Update.UpdateWorkflowExecutionLifecycleStage@ -}
data WaitPolicy
  = WaitPolicy'_constructor {_WaitPolicy'lifecycleStage :: !Proto.Temporal.Api.Enums.V1.Update.UpdateWorkflowExecutionLifecycleStage,
                             _WaitPolicy'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WaitPolicy where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WaitPolicy "lifecycleStage" Proto.Temporal.Api.Enums.V1.Update.UpdateWorkflowExecutionLifecycleStage where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WaitPolicy'lifecycleStage
           (\ x__ y__ -> x__ {_WaitPolicy'lifecycleStage = y__}))
        Prelude.id
instance Data.ProtoLens.Message WaitPolicy where
  messageName _ = Data.Text.pack "temporal.api.update.v1.WaitPolicy"
  packedMessageDescriptor _
    = "\n\
      \\n\
      \WaitPolicy\DC2e\n\
      \\SIlifecycle_stage\CAN\SOH \SOH(\SO2<.temporal.api.enums.v1.UpdateWorkflowExecutionLifecycleStageR\SOlifecycleStage"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        lifecycleStage__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "lifecycle_stage"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Update.UpdateWorkflowExecutionLifecycleStage)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"lifecycleStage")) ::
              Data.ProtoLens.FieldDescriptor WaitPolicy
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, lifecycleStage__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WaitPolicy'_unknownFields
        (\ x__ y__ -> x__ {_WaitPolicy'_unknownFields = y__})
  defMessage
    = WaitPolicy'_constructor
        {_WaitPolicy'lifecycleStage = Data.ProtoLens.fieldDefault,
         _WaitPolicy'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WaitPolicy -> Data.ProtoLens.Encoding.Bytes.Parser WaitPolicy
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
                                       "lifecycle_stage"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lifecycleStage") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WaitPolicy"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"lifecycleStage") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData WaitPolicy where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WaitPolicy'_unknownFields x__)
             (Control.DeepSeq.deepseq (_WaitPolicy'lifecycleStage x__) ())
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \$temporal/api/update/v1/message.proto\DC2\SYNtemporal.api.update.v1\SUB$temporal/api/common/v1/message.proto\SUB\"temporal/api/enums/v1/update.proto\SUB%temporal/api/failure/v1/message.proto\"s\n\
    \\n\
    \WaitPolicy\DC2e\n\
    \\SIlifecycle_stage\CAN\SOH \SOH(\SO2<.temporal.api.enums.v1.UpdateWorkflowExecutionLifecycleStageR\SOlifecycleStage\"\130\SOH\n\
    \\tUpdateRef\DC2X\n\
    \\DC2workflow_execution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\DC1workflowExecution\DC2\ESC\n\
    \\tupdate_id\CAN\STX \SOH(\tR\bupdateId\"\142\SOH\n\
    \\aOutcome\DC2<\n\
    \\asuccess\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsH\NULR\asuccess\DC2<\n\
    \\afailure\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureH\NULR\afailureB\a\n\
    \\ENQvalue\"?\n\
    \\EOTMeta\DC2\ESC\n\
    \\tupdate_id\CAN\SOH \SOH(\tR\bupdateId\DC2\SUB\n\
    \\bidentity\CAN\STX \SOH(\tR\bidentity\"\137\SOH\n\
    \\ENQInput\DC26\n\
    \\ACKheader\CAN\SOH \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2\DC2\n\
    \\EOTname\CAN\STX \SOH(\tR\EOTname\DC24\n\
    \\EOTargs\CAN\ETX \SOH(\v2 .temporal.api.common.v1.PayloadsR\EOTargs\"p\n\
    \\aRequest\DC20\n\
    \\EOTmeta\CAN\SOH \SOH(\v2\FS.temporal.api.update.v1.MetaR\EOTmeta\DC23\n\
    \\ENQinput\CAN\STX \SOH(\v2\GS.temporal.api.update.v1.InputR\ENQinput\"\162\STX\n\
    \\tRejection\DC2=\n\
    \\ESCrejected_request_message_id\CAN\SOH \SOH(\tR\CANrejectedRequestMessageId\DC2N\n\
    \$rejected_request_sequencing_event_id\CAN\STX \SOH(\ETXR rejectedRequestSequencingEventId\DC2J\n\
    \\DLErejected_request\CAN\ETX \SOH(\v2\US.temporal.api.update.v1.RequestR\SIrejectedRequest\DC2:\n\
    \\afailure\CAN\EOT \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\"\231\SOH\n\
    \\n\
    \Acceptance\DC2=\n\
    \\ESCaccepted_request_message_id\CAN\SOH \SOH(\tR\CANacceptedRequestMessageId\DC2N\n\
    \$accepted_request_sequencing_event_id\CAN\STX \SOH(\ETXR acceptedRequestSequencingEventId\DC2J\n\
    \\DLEaccepted_request\CAN\ETX \SOH(\v2\US.temporal.api.update.v1.RequestR\SIacceptedRequest\"w\n\
    \\bResponse\DC20\n\
    \\EOTmeta\CAN\SOH \SOH(\v2\FS.temporal.api.update.v1.MetaR\EOTmeta\DC29\n\
    \\aoutcome\CAN\STX \SOH(\v2\US.temporal.api.update.v1.OutcomeR\aoutcomeB\137\SOH\n\
    \\EMio.temporal.api.update.v1B\fMessageProtoP\SOHZ#go.temporal.io/api/update/v1;update\170\STX\CANTemporalio.Api.Update.V1\234\STX\ESCTemporalio::Api::Update::V1J\221\RS\n\
    \\ACK\DC2\EOT\SYN\NULn\SOH\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL\US\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL:\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL:\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL2\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL2\n\
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
    \\SOH\b\DC2\ETX\RS\NUL4\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL4\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL5\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL5\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL.\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\"\NUL,\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX#\NUL/\n\
    \\149\SOH\n\
    \\STX\EOT\NUL\DC2\EOT'\NUL,\SOH\SUB\136\SOH Specifies to the gRPC server how long the client wants the an update-related\n\
    \ RPC call to wait before returning control to the caller.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX'\b\DC2\n\
    \i\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX+\EOTT\SUB\\ Indicates the update lifecycle stage that the gRPC call should wait for\n\
    \ before returning.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX+\EOT?\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX+@O\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX+RS\n\
    \o\n\
    \\STX\EOT\SOH\DC2\EOT0\NUL3\SOH\SUBc The data needed by a client to refer to an previously invoked workflow\n\
    \ execution update process.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX0\b\DC1\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX1\EOTD\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX1\EOT,\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX1-?\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX1BC\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX2\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX2\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX2\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX2\ETB\CAN\n\
    \D\n\
    \\STX\EOT\STX\DC2\EOT6\NUL;\SOH\SUB8 The outcome of a workflow update - success or failure.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX6\b\SI\n\
    \\f\n\
    \\EOT\EOT\STX\b\NUL\DC2\EOT7\EOT:\ENQ\n\
    \\f\n\
    \\ENQ\EOT\STX\b\NUL\SOH\DC2\ETX7\n\
    \\SI\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX8\b4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX8\b'\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX8(/\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX823\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX9\b4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETX9\b'\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX9(/\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX923\n\
    \9\n\
    \\STX\EOT\ETX\DC2\EOT>\NULD\SOH\SUB- Metadata about a workflow execution update.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX>\b\f\n\
    \D\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX@\EOT\EM\SUB7 An ID with workflow-scoped uniqueness for this update\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETX@\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX@\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX@\ETB\CAN\n\
    \I\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXC\EOT\CAN\SUB< A string identifying the agent that requested this update.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETXC\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXC\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXC\SYN\ETB\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOTF\NULP\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXF\b\r\n\
    \\137\SOH\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXI\EOT-\SUB| Headers that are passed with the update from the requesting entity.\n\
    \ These can include things like auth or tracing tokens.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETXI\EOT!\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXI\"(\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXI+,\n\
    \M\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\ETXL\EOT\DC4\SUB@ The name of the input handler to invoke on the target workflow\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ENQ\DC2\ETXL\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\ETXL\v\SI\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\ETXL\DC2\DC3\n\
    \:\n\
    \\EOT\EOT\EOT\STX\STX\DC2\ETXO\EOT-\SUB- The arguments to pass to the named handler.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ACK\DC2\ETXO\EOT#\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\SOH\DC2\ETXO$(\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ETX\DC2\ETXO+,\n\
    \J\n\
    \\STX\EOT\ENQ\DC2\EOTS\NULV\SOH\SUB> The client request that triggers a workflow execution update\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXS\b\SI\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXT\EOT\DC2\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETXT\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXT\t\r\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXT\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETXU\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\ETXU\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETXU\n\
    \\SI\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETXU\DC2\DC3\n\
    \h\n\
    \\STX\EOT\ACK\DC2\EOTZ\NUL_\SOH\SUB\\ An update protocol message indicating that a workflow execution update has\n\
    \ been rejected.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXZ\b\DC1\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETX[\EOT+\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETX[\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETX[\v&\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETX[)*\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETX\\\EOT3\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETX\\\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETX\\\n\
    \.\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETX\\12\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\STX\DC2\ETX]\EOT!\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ACK\DC2\ETX]\EOT\v\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\ETX]\f\FS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\ETX]\US \n\
    \\v\n\
    \\EOT\EOT\ACK\STX\ETX\DC2\ETX^\EOT0\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ETX\ACK\DC2\ETX^\EOT#\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ETX\SOH\DC2\ETX^$+\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ETX\ETX\DC2\ETX^./\n\
    \\152\SOH\n\
    \\STX\EOT\a\DC2\EOTc\NULg\SOH\SUB\139\SOH An update protocol message indicating that a workflow execution update has\n\
    \ been accepted (i.e. passed the worker-side validation phase).\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXc\b\DC2\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXd\EOT+\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETXd\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXd\v&\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXd)*\n\
    \\v\n\
    \\EOT\EOT\a\STX\SOH\DC2\ETXe\EOT3\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ENQ\DC2\ETXe\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\ETXe\n\
    \.\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\ETXe12\n\
    \\v\n\
    \\EOT\EOT\a\STX\STX\DC2\ETXf\EOT!\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ACK\DC2\ETXf\EOT\v\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\SOH\DC2\ETXf\f\FS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ETX\DC2\ETXf\US \n\
    \\DEL\n\
    \\STX\EOT\b\DC2\EOTk\NULn\SOH\SUBs An update protocol message indicating that a workflow execution update has\n\
    \ completed with the contained outcome.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXk\b\DLE\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETXl\EOT\DC2\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ACK\DC2\ETXl\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETXl\t\r\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETXl\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\b\STX\SOH\DC2\ETXm\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ACK\DC2\ETXm\EOT\v\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\ETXm\f\DC3\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\ETXm\SYN\ETBb\ACKproto3"
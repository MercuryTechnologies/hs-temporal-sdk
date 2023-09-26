{- This file was auto-generated from temporal/api/common/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Common.V1.Message (
        ActivityType(), DataBlob(), Header(), Header'FieldsEntry(), Memo(),
        Memo'FieldsEntry(), MeteringMetadata(), Payload(),
        Payload'MetadataEntry(), Payloads(), RetryPolicy(),
        SearchAttributes(), SearchAttributes'IndexedFieldsEntry(),
        WorkerVersionCapabilities(), WorkerVersionStamp(),
        WorkflowExecution(), WorkflowType()
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
import qualified Proto.Temporal.Api.Enums.V1.Common
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.name' @:: Lens' ActivityType Data.Text.Text@ -}
data ActivityType
  = ActivityType'_constructor {_ActivityType'name :: !Data.Text.Text,
                               _ActivityType'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ActivityType where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ActivityType "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityType'name (\ x__ y__ -> x__ {_ActivityType'name = y__}))
        Prelude.id
instance Data.ProtoLens.Message ActivityType where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.ActivityType"
  packedMessageDescriptor _
    = "\n\
      \\fActivityType\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor ActivityType
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, name__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ActivityType'_unknownFields
        (\ x__ y__ -> x__ {_ActivityType'_unknownFields = y__})
  defMessage
    = ActivityType'_constructor
        {_ActivityType'name = Data.ProtoLens.fieldDefault,
         _ActivityType'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ActivityType -> Data.ProtoLens.Encoding.Bytes.Parser ActivityType
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
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ActivityType"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
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
instance Control.DeepSeq.NFData ActivityType where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ActivityType'_unknownFields x__)
             (Control.DeepSeq.deepseq (_ActivityType'name x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.encodingType' @:: Lens' DataBlob Proto.Temporal.Api.Enums.V1.Common.EncodingType@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.data'' @:: Lens' DataBlob Data.ByteString.ByteString@ -}
data DataBlob
  = DataBlob'_constructor {_DataBlob'encodingType :: !Proto.Temporal.Api.Enums.V1.Common.EncodingType,
                           _DataBlob'data' :: !Data.ByteString.ByteString,
                           _DataBlob'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show DataBlob where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField DataBlob "encodingType" Proto.Temporal.Api.Enums.V1.Common.EncodingType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DataBlob'encodingType
           (\ x__ y__ -> x__ {_DataBlob'encodingType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField DataBlob "data'" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DataBlob'data' (\ x__ y__ -> x__ {_DataBlob'data' = y__}))
        Prelude.id
instance Data.ProtoLens.Message DataBlob where
  messageName _ = Data.Text.pack "temporal.api.common.v1.DataBlob"
  packedMessageDescriptor _
    = "\n\
      \\bDataBlob\DC2H\n\
      \\rencoding_type\CAN\SOH \SOH(\SO2#.temporal.api.enums.v1.EncodingTypeR\fencodingType\DC2\DC2\n\
      \\EOTdata\CAN\STX \SOH(\fR\EOTdata"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        encodingType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "encoding_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.EncodingType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"encodingType")) ::
              Data.ProtoLens.FieldDescriptor DataBlob
        data'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "data"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"data'")) ::
              Data.ProtoLens.FieldDescriptor DataBlob
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, encodingType__field_descriptor),
           (Data.ProtoLens.Tag 2, data'__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DataBlob'_unknownFields
        (\ x__ y__ -> x__ {_DataBlob'_unknownFields = y__})
  defMessage
    = DataBlob'_constructor
        {_DataBlob'encodingType = Data.ProtoLens.fieldDefault,
         _DataBlob'data' = Data.ProtoLens.fieldDefault,
         _DataBlob'_unknownFields = []}
  parseMessage
    = let
        loop :: DataBlob -> Data.ProtoLens.Encoding.Bytes.Parser DataBlob
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
                                       "encoding_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"encodingType") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "data"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"data'") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "DataBlob"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"encodingType") _x
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
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"data'") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData DataBlob where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DataBlob'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_DataBlob'encodingType x__)
                (Control.DeepSeq.deepseq (_DataBlob'data' x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.fields' @:: Lens' Header (Data.Map.Map Data.Text.Text Payload)@ -}
data Header
  = Header'_constructor {_Header'fields :: !(Data.Map.Map Data.Text.Text Payload),
                         _Header'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Header where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Header "fields" (Data.Map.Map Data.Text.Text Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Header'fields (\ x__ y__ -> x__ {_Header'fields = y__}))
        Prelude.id
instance Data.ProtoLens.Message Header where
  messageName _ = Data.Text.pack "temporal.api.common.v1.Header"
  packedMessageDescriptor _
    = "\n\
      \\ACKHeader\DC2B\n\
      \\ACKfields\CAN\SOH \ETX(\v2*.temporal.api.common.v1.Header.FieldsEntryR\ACKfields\SUBZ\n\
      \\vFieldsEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        fields__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "fields"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Header'FieldsEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                    Data.ProtoLens.FieldTypeDescriptor Payload)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"fields")) ::
              Data.ProtoLens.FieldDescriptor Header
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, fields__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Header'_unknownFields
        (\ x__ y__ -> x__ {_Header'_unknownFields = y__})
  defMessage
    = Header'_constructor
        {_Header'fields = Data.Map.empty, _Header'_unknownFields = []}
  parseMessage
    = let
        loop :: Header -> Data.ProtoLens.Encoding.Bytes.Parser Header
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
                          -> do !(entry :: Header'FieldsEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                    (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                        Data.ProtoLens.Encoding.Bytes.isolate
                                                                          (Prelude.fromIntegral len)
                                                                          Data.ProtoLens.parseMessage)
                                                                    "fields"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"fields")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Header"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.Monoid.mconcat
                (Prelude.map
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
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
                                    (Data.ProtoLens.defMessage :: Header'FieldsEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"fields") _x))))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData Header where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Header'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Header'fields x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.key' @:: Lens' Header'FieldsEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.value' @:: Lens' Header'FieldsEntry Payload@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'value' @:: Lens' Header'FieldsEntry (Prelude.Maybe Payload)@ -}
data Header'FieldsEntry
  = Header'FieldsEntry'_constructor {_Header'FieldsEntry'key :: !Data.Text.Text,
                                     _Header'FieldsEntry'value :: !(Prelude.Maybe Payload),
                                     _Header'FieldsEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Header'FieldsEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Header'FieldsEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Header'FieldsEntry'key
           (\ x__ y__ -> x__ {_Header'FieldsEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Header'FieldsEntry "value" Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Header'FieldsEntry'value
           (\ x__ y__ -> x__ {_Header'FieldsEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Header'FieldsEntry "maybe'value" (Prelude.Maybe Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Header'FieldsEntry'value
           (\ x__ y__ -> x__ {_Header'FieldsEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message Header'FieldsEntry where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.Header.FieldsEntry"
  packedMessageDescriptor _
    = "\n\
      \\vFieldsEntry\DC2\DLE\n\
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
              Data.ProtoLens.FieldDescriptor Header'FieldsEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor Header'FieldsEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Header'FieldsEntry'_unknownFields
        (\ x__ y__ -> x__ {_Header'FieldsEntry'_unknownFields = y__})
  defMessage
    = Header'FieldsEntry'_constructor
        {_Header'FieldsEntry'key = Data.ProtoLens.fieldDefault,
         _Header'FieldsEntry'value = Prelude.Nothing,
         _Header'FieldsEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Header'FieldsEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser Header'FieldsEntry
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
          (do loop Data.ProtoLens.defMessage) "FieldsEntry"
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
instance Control.DeepSeq.NFData Header'FieldsEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Header'FieldsEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Header'FieldsEntry'key x__)
                (Control.DeepSeq.deepseq (_Header'FieldsEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.fields' @:: Lens' Memo (Data.Map.Map Data.Text.Text Payload)@ -}
data Memo
  = Memo'_constructor {_Memo'fields :: !(Data.Map.Map Data.Text.Text Payload),
                       _Memo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Memo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Memo "fields" (Data.Map.Map Data.Text.Text Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Memo'fields (\ x__ y__ -> x__ {_Memo'fields = y__}))
        Prelude.id
instance Data.ProtoLens.Message Memo where
  messageName _ = Data.Text.pack "temporal.api.common.v1.Memo"
  packedMessageDescriptor _
    = "\n\
      \\EOTMemo\DC2@\n\
      \\ACKfields\CAN\SOH \ETX(\v2(.temporal.api.common.v1.Memo.FieldsEntryR\ACKfields\SUBZ\n\
      \\vFieldsEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        fields__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "fields"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Memo'FieldsEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                    Data.ProtoLens.FieldTypeDescriptor Payload)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"fields")) ::
              Data.ProtoLens.FieldDescriptor Memo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, fields__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Memo'_unknownFields
        (\ x__ y__ -> x__ {_Memo'_unknownFields = y__})
  defMessage
    = Memo'_constructor
        {_Memo'fields = Data.Map.empty, _Memo'_unknownFields = []}
  parseMessage
    = let
        loop :: Memo -> Data.ProtoLens.Encoding.Bytes.Parser Memo
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
                          -> do !(entry :: Memo'FieldsEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                  (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                      Data.ProtoLens.Encoding.Bytes.isolate
                                                                        (Prelude.fromIntegral len)
                                                                        Data.ProtoLens.parseMessage)
                                                                  "fields"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"fields")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Memo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.Monoid.mconcat
                (Prelude.map
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
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
                                    (Data.ProtoLens.defMessage :: Memo'FieldsEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"fields") _x))))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData Memo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Memo'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Memo'fields x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.key' @:: Lens' Memo'FieldsEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.value' @:: Lens' Memo'FieldsEntry Payload@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'value' @:: Lens' Memo'FieldsEntry (Prelude.Maybe Payload)@ -}
data Memo'FieldsEntry
  = Memo'FieldsEntry'_constructor {_Memo'FieldsEntry'key :: !Data.Text.Text,
                                   _Memo'FieldsEntry'value :: !(Prelude.Maybe Payload),
                                   _Memo'FieldsEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Memo'FieldsEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Memo'FieldsEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Memo'FieldsEntry'key
           (\ x__ y__ -> x__ {_Memo'FieldsEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Memo'FieldsEntry "value" Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Memo'FieldsEntry'value
           (\ x__ y__ -> x__ {_Memo'FieldsEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Memo'FieldsEntry "maybe'value" (Prelude.Maybe Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Memo'FieldsEntry'value
           (\ x__ y__ -> x__ {_Memo'FieldsEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message Memo'FieldsEntry where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.Memo.FieldsEntry"
  packedMessageDescriptor _
    = "\n\
      \\vFieldsEntry\DC2\DLE\n\
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
              Data.ProtoLens.FieldDescriptor Memo'FieldsEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor Memo'FieldsEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Memo'FieldsEntry'_unknownFields
        (\ x__ y__ -> x__ {_Memo'FieldsEntry'_unknownFields = y__})
  defMessage
    = Memo'FieldsEntry'_constructor
        {_Memo'FieldsEntry'key = Data.ProtoLens.fieldDefault,
         _Memo'FieldsEntry'value = Prelude.Nothing,
         _Memo'FieldsEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Memo'FieldsEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser Memo'FieldsEntry
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
          (do loop Data.ProtoLens.defMessage) "FieldsEntry"
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
instance Control.DeepSeq.NFData Memo'FieldsEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Memo'FieldsEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Memo'FieldsEntry'key x__)
                (Control.DeepSeq.deepseq (_Memo'FieldsEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.nonfirstLocalActivityExecutionAttempts' @:: Lens' MeteringMetadata Data.Word.Word32@ -}
data MeteringMetadata
  = MeteringMetadata'_constructor {_MeteringMetadata'nonfirstLocalActivityExecutionAttempts :: !Data.Word.Word32,
                                   _MeteringMetadata'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show MeteringMetadata where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField MeteringMetadata "nonfirstLocalActivityExecutionAttempts" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MeteringMetadata'nonfirstLocalActivityExecutionAttempts
           (\ x__ y__
              -> x__
                   {_MeteringMetadata'nonfirstLocalActivityExecutionAttempts = y__}))
        Prelude.id
instance Data.ProtoLens.Message MeteringMetadata where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.MeteringMetadata"
  packedMessageDescriptor _
    = "\n\
      \\DLEMeteringMetadata\DC2Z\n\
      \*nonfirst_local_activity_execution_attempts\CAN\r \SOH(\rR&nonfirstLocalActivityExecutionAttempts"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        nonfirstLocalActivityExecutionAttempts__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "nonfirst_local_activity_execution_attempts"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field
                    @"nonfirstLocalActivityExecutionAttempts")) ::
              Data.ProtoLens.FieldDescriptor MeteringMetadata
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 13, 
            nonfirstLocalActivityExecutionAttempts__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _MeteringMetadata'_unknownFields
        (\ x__ y__ -> x__ {_MeteringMetadata'_unknownFields = y__})
  defMessage
    = MeteringMetadata'_constructor
        {_MeteringMetadata'nonfirstLocalActivityExecutionAttempts = Data.ProtoLens.fieldDefault,
         _MeteringMetadata'_unknownFields = []}
  parseMessage
    = let
        loop ::
          MeteringMetadata
          -> Data.ProtoLens.Encoding.Bytes.Parser MeteringMetadata
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
                        104
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "nonfirst_local_activity_execution_attempts"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"nonfirstLocalActivityExecutionAttempts")
                                     y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "MeteringMetadata"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field
                         @"nonfirstLocalActivityExecutionAttempts")
                      _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 104)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData MeteringMetadata where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_MeteringMetadata'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_MeteringMetadata'nonfirstLocalActivityExecutionAttempts x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.metadata' @:: Lens' Payload (Data.Map.Map Data.Text.Text Data.ByteString.ByteString)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.data'' @:: Lens' Payload Data.ByteString.ByteString@ -}
data Payload
  = Payload'_constructor {_Payload'metadata :: !(Data.Map.Map Data.Text.Text Data.ByteString.ByteString),
                          _Payload'data' :: !Data.ByteString.ByteString,
                          _Payload'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Payload where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Payload "metadata" (Data.Map.Map Data.Text.Text Data.ByteString.ByteString) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Payload'metadata (\ x__ y__ -> x__ {_Payload'metadata = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Payload "data'" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Payload'data' (\ x__ y__ -> x__ {_Payload'data' = y__}))
        Prelude.id
instance Data.ProtoLens.Message Payload where
  messageName _ = Data.Text.pack "temporal.api.common.v1.Payload"
  packedMessageDescriptor _
    = "\n\
      \\aPayload\DC2I\n\
      \\bmetadata\CAN\SOH \ETX(\v2-.temporal.api.common.v1.Payload.MetadataEntryR\bmetadata\DC2\DC2\n\
      \\EOTdata\CAN\STX \SOH(\fR\EOTdata\SUB;\n\
      \\rMetadataEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\fR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        metadata__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "metadata"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Payload'MetadataEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                    Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"metadata")) ::
              Data.ProtoLens.FieldDescriptor Payload
        data'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "data"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"data'")) ::
              Data.ProtoLens.FieldDescriptor Payload
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, metadata__field_descriptor),
           (Data.ProtoLens.Tag 2, data'__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Payload'_unknownFields
        (\ x__ y__ -> x__ {_Payload'_unknownFields = y__})
  defMessage
    = Payload'_constructor
        {_Payload'metadata = Data.Map.empty,
         _Payload'data' = Data.ProtoLens.fieldDefault,
         _Payload'_unknownFields = []}
  parseMessage
    = let
        loop :: Payload -> Data.ProtoLens.Encoding.Bytes.Parser Payload
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
                          -> do !(entry :: Payload'MetadataEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                           Data.ProtoLens.Encoding.Bytes.isolate
                                                                             (Prelude.fromIntegral
                                                                                len)
                                                                             Data.ProtoLens.parseMessage)
                                                                       "metadata"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"metadata")
                                        (\ !t -> Data.Map.insert key value t) x))
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "data"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"data'") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Payload"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.Monoid.mconcat
                (Prelude.map
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
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
                                    (Data.ProtoLens.defMessage :: Payload'MetadataEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"metadata") _x))))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"data'") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Payload where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Payload'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Payload'metadata x__)
                (Control.DeepSeq.deepseq (_Payload'data' x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.key' @:: Lens' Payload'MetadataEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.value' @:: Lens' Payload'MetadataEntry Data.ByteString.ByteString@ -}
data Payload'MetadataEntry
  = Payload'MetadataEntry'_constructor {_Payload'MetadataEntry'key :: !Data.Text.Text,
                                        _Payload'MetadataEntry'value :: !Data.ByteString.ByteString,
                                        _Payload'MetadataEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Payload'MetadataEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Payload'MetadataEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Payload'MetadataEntry'key
           (\ x__ y__ -> x__ {_Payload'MetadataEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Payload'MetadataEntry "value" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Payload'MetadataEntry'value
           (\ x__ y__ -> x__ {_Payload'MetadataEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message Payload'MetadataEntry where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.Payload.MetadataEntry"
  packedMessageDescriptor _
    = "\n\
      \\rMetadataEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\fR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor Payload'MetadataEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor Payload'MetadataEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Payload'MetadataEntry'_unknownFields
        (\ x__ y__ -> x__ {_Payload'MetadataEntry'_unknownFields = y__})
  defMessage
    = Payload'MetadataEntry'_constructor
        {_Payload'MetadataEntry'key = Data.ProtoLens.fieldDefault,
         _Payload'MetadataEntry'value = Data.ProtoLens.fieldDefault,
         _Payload'MetadataEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Payload'MetadataEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser Payload'MetadataEntry
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
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
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
          (do loop Data.ProtoLens.defMessage) "MetadataEntry"
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
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"value") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Payload'MetadataEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Payload'MetadataEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Payload'MetadataEntry'key x__)
                (Control.DeepSeq.deepseq (_Payload'MetadataEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.payloads' @:: Lens' Payloads [Payload]@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.vec'payloads' @:: Lens' Payloads (Data.Vector.Vector Payload)@ -}
data Payloads
  = Payloads'_constructor {_Payloads'payloads :: !(Data.Vector.Vector Payload),
                           _Payloads'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Payloads where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Payloads "payloads" [Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Payloads'payloads (\ x__ y__ -> x__ {_Payloads'payloads = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Payloads "vec'payloads" (Data.Vector.Vector Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Payloads'payloads (\ x__ y__ -> x__ {_Payloads'payloads = y__}))
        Prelude.id
instance Data.ProtoLens.Message Payloads where
  messageName _ = Data.Text.pack "temporal.api.common.v1.Payloads"
  packedMessageDescriptor _
    = "\n\
      \\bPayloads\DC2;\n\
      \\bpayloads\CAN\SOH \ETX(\v2\US.temporal.api.common.v1.PayloadR\bpayloads"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        payloads__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "payloads"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"payloads")) ::
              Data.ProtoLens.FieldDescriptor Payloads
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, payloads__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Payloads'_unknownFields
        (\ x__ y__ -> x__ {_Payloads'_unknownFields = y__})
  defMessage
    = Payloads'_constructor
        {_Payloads'payloads = Data.Vector.Generic.empty,
         _Payloads'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Payloads
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Payload
             -> Data.ProtoLens.Encoding.Bytes.Parser Payloads
        loop x mutable'payloads
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'payloads <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                              mutable'payloads)
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
                              (Data.ProtoLens.Field.field @"vec'payloads") frozen'payloads x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "payloads"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'payloads y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'payloads
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'payloads <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                    Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'payloads)
          "Payloads"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                (\ _v
                   -> (Data.Monoid.<>)
                        (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                        ((Prelude..)
                           (\ bs
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                      (Prelude.fromIntegral (Data.ByteString.length bs)))
                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                           Data.ProtoLens.encodeMessage _v))
                (Lens.Family2.view
                   (Data.ProtoLens.Field.field @"vec'payloads") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData Payloads where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Payloads'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Payloads'payloads x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.initialInterval' @:: Lens' RetryPolicy Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'initialInterval' @:: Lens' RetryPolicy (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.backoffCoefficient' @:: Lens' RetryPolicy Prelude.Double@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maximumInterval' @:: Lens' RetryPolicy Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'maximumInterval' @:: Lens' RetryPolicy (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maximumAttempts' @:: Lens' RetryPolicy Data.Int.Int32@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.nonRetryableErrorTypes' @:: Lens' RetryPolicy [Data.Text.Text]@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.vec'nonRetryableErrorTypes' @:: Lens' RetryPolicy (Data.Vector.Vector Data.Text.Text)@ -}
data RetryPolicy
  = RetryPolicy'_constructor {_RetryPolicy'initialInterval :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                              _RetryPolicy'backoffCoefficient :: !Prelude.Double,
                              _RetryPolicy'maximumInterval :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                              _RetryPolicy'maximumAttempts :: !Data.Int.Int32,
                              _RetryPolicy'nonRetryableErrorTypes :: !(Data.Vector.Vector Data.Text.Text),
                              _RetryPolicy'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RetryPolicy where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RetryPolicy "initialInterval" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'initialInterval
           (\ x__ y__ -> x__ {_RetryPolicy'initialInterval = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField RetryPolicy "maybe'initialInterval" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'initialInterval
           (\ x__ y__ -> x__ {_RetryPolicy'initialInterval = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RetryPolicy "backoffCoefficient" Prelude.Double where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'backoffCoefficient
           (\ x__ y__ -> x__ {_RetryPolicy'backoffCoefficient = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RetryPolicy "maximumInterval" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'maximumInterval
           (\ x__ y__ -> x__ {_RetryPolicy'maximumInterval = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField RetryPolicy "maybe'maximumInterval" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'maximumInterval
           (\ x__ y__ -> x__ {_RetryPolicy'maximumInterval = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RetryPolicy "maximumAttempts" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'maximumAttempts
           (\ x__ y__ -> x__ {_RetryPolicy'maximumAttempts = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RetryPolicy "nonRetryableErrorTypes" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'nonRetryableErrorTypes
           (\ x__ y__ -> x__ {_RetryPolicy'nonRetryableErrorTypes = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField RetryPolicy "vec'nonRetryableErrorTypes" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RetryPolicy'nonRetryableErrorTypes
           (\ x__ y__ -> x__ {_RetryPolicy'nonRetryableErrorTypes = y__}))
        Prelude.id
instance Data.ProtoLens.Message RetryPolicy where
  messageName _ = Data.Text.pack "temporal.api.common.v1.RetryPolicy"
  packedMessageDescriptor _
    = "\n\
      \\vRetryPolicy\DC2J\n\
      \\DLEinitial_interval\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\SIinitialIntervalB\EOT\152\223\US\SOH\DC2/\n\
      \\DC3backoff_coefficient\CAN\STX \SOH(\SOHR\DC2backoffCoefficient\DC2J\n\
      \\DLEmaximum_interval\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\SImaximumIntervalB\EOT\152\223\US\SOH\DC2)\n\
      \\DLEmaximum_attempts\CAN\EOT \SOH(\ENQR\SImaximumAttempts\DC29\n\
      \\EMnon_retryable_error_types\CAN\ENQ \ETX(\tR\SYNnonRetryableErrorTypes"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        initialInterval__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "initial_interval"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'initialInterval")) ::
              Data.ProtoLens.FieldDescriptor RetryPolicy
        backoffCoefficient__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "backoff_coefficient"
              (Data.ProtoLens.ScalarField Data.ProtoLens.DoubleField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"backoffCoefficient")) ::
              Data.ProtoLens.FieldDescriptor RetryPolicy
        maximumInterval__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "maximum_interval"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'maximumInterval")) ::
              Data.ProtoLens.FieldDescriptor RetryPolicy
        maximumAttempts__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "maximum_attempts"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"maximumAttempts")) ::
              Data.ProtoLens.FieldDescriptor RetryPolicy
        nonRetryableErrorTypes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "non_retryable_error_types"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"nonRetryableErrorTypes")) ::
              Data.ProtoLens.FieldDescriptor RetryPolicy
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, initialInterval__field_descriptor),
           (Data.ProtoLens.Tag 2, backoffCoefficient__field_descriptor),
           (Data.ProtoLens.Tag 3, maximumInterval__field_descriptor),
           (Data.ProtoLens.Tag 4, maximumAttempts__field_descriptor),
           (Data.ProtoLens.Tag 5, nonRetryableErrorTypes__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RetryPolicy'_unknownFields
        (\ x__ y__ -> x__ {_RetryPolicy'_unknownFields = y__})
  defMessage
    = RetryPolicy'_constructor
        {_RetryPolicy'initialInterval = Prelude.Nothing,
         _RetryPolicy'backoffCoefficient = Data.ProtoLens.fieldDefault,
         _RetryPolicy'maximumInterval = Prelude.Nothing,
         _RetryPolicy'maximumAttempts = Data.ProtoLens.fieldDefault,
         _RetryPolicy'nonRetryableErrorTypes = Data.Vector.Generic.empty,
         _RetryPolicy'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RetryPolicy
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
             -> Data.ProtoLens.Encoding.Bytes.Parser RetryPolicy
        loop x mutable'nonRetryableErrorTypes
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'nonRetryableErrorTypes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                            mutable'nonRetryableErrorTypes)
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
                              (Data.ProtoLens.Field.field @"vec'nonRetryableErrorTypes")
                              frozen'nonRetryableErrorTypes x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "initial_interval"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"initialInterval") y x)
                                  mutable'nonRetryableErrorTypes
                        17
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToDouble
                                          Data.ProtoLens.Encoding.Bytes.getFixed64)
                                       "backoff_coefficient"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"backoffCoefficient") y x)
                                  mutable'nonRetryableErrorTypes
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "maximum_interval"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"maximumInterval") y x)
                                  mutable'nonRetryableErrorTypes
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "maximum_attempts"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"maximumAttempts") y x)
                                  mutable'nonRetryableErrorTypes
                        42
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "non_retryable_error_types"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'nonRetryableErrorTypes y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'nonRetryableErrorTypes
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'nonRetryableErrorTypes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                  Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'nonRetryableErrorTypes)
          "RetryPolicy"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'initialInterval") _x
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
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"backoffCoefficient") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 17)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putFixed64
                            Data.ProtoLens.Encoding.Bytes.doubleToWord _v))
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'maximumInterval") _x
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
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"maximumAttempts") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                      ((Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.Text.Encoding.encodeUtf8 _v))
                            (Lens.Family2.view
                               (Data.ProtoLens.Field.field @"vec'nonRetryableErrorTypes") _x))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData RetryPolicy where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RetryPolicy'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_RetryPolicy'initialInterval x__)
                (Control.DeepSeq.deepseq
                   (_RetryPolicy'backoffCoefficient x__)
                   (Control.DeepSeq.deepseq
                      (_RetryPolicy'maximumInterval x__)
                      (Control.DeepSeq.deepseq
                         (_RetryPolicy'maximumAttempts x__)
                         (Control.DeepSeq.deepseq
                            (_RetryPolicy'nonRetryableErrorTypes x__) ())))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.indexedFields' @:: Lens' SearchAttributes (Data.Map.Map Data.Text.Text Payload)@ -}
data SearchAttributes
  = SearchAttributes'_constructor {_SearchAttributes'indexedFields :: !(Data.Map.Map Data.Text.Text Payload),
                                   _SearchAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SearchAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SearchAttributes "indexedFields" (Data.Map.Map Data.Text.Text Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SearchAttributes'indexedFields
           (\ x__ y__ -> x__ {_SearchAttributes'indexedFields = y__}))
        Prelude.id
instance Data.ProtoLens.Message SearchAttributes where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.SearchAttributes"
  packedMessageDescriptor _
    = "\n\
      \\DLESearchAttributes\DC2b\n\
      \\SOindexed_fields\CAN\SOH \ETX(\v2;.temporal.api.common.v1.SearchAttributes.IndexedFieldsEntryR\rindexedFields\SUBa\n\
      \\DC2IndexedFieldsEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        indexedFields__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "indexed_fields"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor SearchAttributes'IndexedFieldsEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                    Data.ProtoLens.FieldTypeDescriptor Payload)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"indexedFields")) ::
              Data.ProtoLens.FieldDescriptor SearchAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, indexedFields__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SearchAttributes'_unknownFields
        (\ x__ y__ -> x__ {_SearchAttributes'_unknownFields = y__})
  defMessage
    = SearchAttributes'_constructor
        {_SearchAttributes'indexedFields = Data.Map.empty,
         _SearchAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SearchAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser SearchAttributes
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
                          -> do !(entry :: SearchAttributes'IndexedFieldsEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                     (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                         Data.ProtoLens.Encoding.Bytes.isolate
                                                                                           (Prelude.fromIntegral
                                                                                              len)
                                                                                           Data.ProtoLens.parseMessage)
                                                                                     "indexed_fields"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"indexedFields")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SearchAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.Monoid.mconcat
                (Prelude.map
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
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
                                       SearchAttributes'IndexedFieldsEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view
                         (Data.ProtoLens.Field.field @"indexedFields") _x))))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData SearchAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SearchAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq (_SearchAttributes'indexedFields x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.key' @:: Lens' SearchAttributes'IndexedFieldsEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.value' @:: Lens' SearchAttributes'IndexedFieldsEntry Payload@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'value' @:: Lens' SearchAttributes'IndexedFieldsEntry (Prelude.Maybe Payload)@ -}
data SearchAttributes'IndexedFieldsEntry
  = SearchAttributes'IndexedFieldsEntry'_constructor {_SearchAttributes'IndexedFieldsEntry'key :: !Data.Text.Text,
                                                      _SearchAttributes'IndexedFieldsEntry'value :: !(Prelude.Maybe Payload),
                                                      _SearchAttributes'IndexedFieldsEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SearchAttributes'IndexedFieldsEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SearchAttributes'IndexedFieldsEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SearchAttributes'IndexedFieldsEntry'key
           (\ x__ y__
              -> x__ {_SearchAttributes'IndexedFieldsEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SearchAttributes'IndexedFieldsEntry "value" Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SearchAttributes'IndexedFieldsEntry'value
           (\ x__ y__
              -> x__ {_SearchAttributes'IndexedFieldsEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SearchAttributes'IndexedFieldsEntry "maybe'value" (Prelude.Maybe Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SearchAttributes'IndexedFieldsEntry'value
           (\ x__ y__
              -> x__ {_SearchAttributes'IndexedFieldsEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message SearchAttributes'IndexedFieldsEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.common.v1.SearchAttributes.IndexedFieldsEntry"
  packedMessageDescriptor _
    = "\n\
      \\DC2IndexedFieldsEntry\DC2\DLE\n\
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
              Data.ProtoLens.FieldDescriptor SearchAttributes'IndexedFieldsEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor SearchAttributes'IndexedFieldsEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SearchAttributes'IndexedFieldsEntry'_unknownFields
        (\ x__ y__
           -> x__ {_SearchAttributes'IndexedFieldsEntry'_unknownFields = y__})
  defMessage
    = SearchAttributes'IndexedFieldsEntry'_constructor
        {_SearchAttributes'IndexedFieldsEntry'key = Data.ProtoLens.fieldDefault,
         _SearchAttributes'IndexedFieldsEntry'value = Prelude.Nothing,
         _SearchAttributes'IndexedFieldsEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SearchAttributes'IndexedFieldsEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser SearchAttributes'IndexedFieldsEntry
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
          (do loop Data.ProtoLens.defMessage) "IndexedFieldsEntry"
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
instance Control.DeepSeq.NFData SearchAttributes'IndexedFieldsEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SearchAttributes'IndexedFieldsEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SearchAttributes'IndexedFieldsEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_SearchAttributes'IndexedFieldsEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.buildId' @:: Lens' WorkerVersionCapabilities Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.useVersioning' @:: Lens' WorkerVersionCapabilities Prelude.Bool@ -}
data WorkerVersionCapabilities
  = WorkerVersionCapabilities'_constructor {_WorkerVersionCapabilities'buildId :: !Data.Text.Text,
                                            _WorkerVersionCapabilities'useVersioning :: !Prelude.Bool,
                                            _WorkerVersionCapabilities'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerVersionCapabilities where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerVersionCapabilities "buildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerVersionCapabilities'buildId
           (\ x__ y__ -> x__ {_WorkerVersionCapabilities'buildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerVersionCapabilities "useVersioning" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerVersionCapabilities'useVersioning
           (\ x__ y__
              -> x__ {_WorkerVersionCapabilities'useVersioning = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerVersionCapabilities where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.WorkerVersionCapabilities"
  packedMessageDescriptor _
    = "\n\
      \\EMWorkerVersionCapabilities\DC2\EM\n\
      \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2%\n\
      \\SOuse_versioning\CAN\STX \SOH(\bR\ruseVersioning"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        buildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"buildId")) ::
              Data.ProtoLens.FieldDescriptor WorkerVersionCapabilities
        useVersioning__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "use_versioning"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"useVersioning")) ::
              Data.ProtoLens.FieldDescriptor WorkerVersionCapabilities
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, buildId__field_descriptor),
           (Data.ProtoLens.Tag 2, useVersioning__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerVersionCapabilities'_unknownFields
        (\ x__ y__
           -> x__ {_WorkerVersionCapabilities'_unknownFields = y__})
  defMessage
    = WorkerVersionCapabilities'_constructor
        {_WorkerVersionCapabilities'buildId = Data.ProtoLens.fieldDefault,
         _WorkerVersionCapabilities'useVersioning = Data.ProtoLens.fieldDefault,
         _WorkerVersionCapabilities'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerVersionCapabilities
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerVersionCapabilities
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
                                       "build_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"buildId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "use_versioning"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"useVersioning") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerVersionCapabilities"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"buildId") _x
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
                         (Data.ProtoLens.Field.field @"useVersioning") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                            _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData WorkerVersionCapabilities where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerVersionCapabilities'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerVersionCapabilities'buildId x__)
                (Control.DeepSeq.deepseq
                   (_WorkerVersionCapabilities'useVersioning x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.buildId' @:: Lens' WorkerVersionStamp Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.bundleId' @:: Lens' WorkerVersionStamp Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.useVersioning' @:: Lens' WorkerVersionStamp Prelude.Bool@ -}
data WorkerVersionStamp
  = WorkerVersionStamp'_constructor {_WorkerVersionStamp'buildId :: !Data.Text.Text,
                                     _WorkerVersionStamp'bundleId :: !Data.Text.Text,
                                     _WorkerVersionStamp'useVersioning :: !Prelude.Bool,
                                     _WorkerVersionStamp'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerVersionStamp where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerVersionStamp "buildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerVersionStamp'buildId
           (\ x__ y__ -> x__ {_WorkerVersionStamp'buildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerVersionStamp "bundleId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerVersionStamp'bundleId
           (\ x__ y__ -> x__ {_WorkerVersionStamp'bundleId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerVersionStamp "useVersioning" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerVersionStamp'useVersioning
           (\ x__ y__ -> x__ {_WorkerVersionStamp'useVersioning = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerVersionStamp where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.WorkerVersionStamp"
  packedMessageDescriptor _
    = "\n\
      \\DC2WorkerVersionStamp\DC2\EM\n\
      \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2\ESC\n\
      \\tbundle_id\CAN\STX \SOH(\tR\bbundleId\DC2%\n\
      \\SOuse_versioning\CAN\ETX \SOH(\bR\ruseVersioning"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        buildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"buildId")) ::
              Data.ProtoLens.FieldDescriptor WorkerVersionStamp
        bundleId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "bundle_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"bundleId")) ::
              Data.ProtoLens.FieldDescriptor WorkerVersionStamp
        useVersioning__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "use_versioning"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"useVersioning")) ::
              Data.ProtoLens.FieldDescriptor WorkerVersionStamp
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, buildId__field_descriptor),
           (Data.ProtoLens.Tag 2, bundleId__field_descriptor),
           (Data.ProtoLens.Tag 3, useVersioning__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerVersionStamp'_unknownFields
        (\ x__ y__ -> x__ {_WorkerVersionStamp'_unknownFields = y__})
  defMessage
    = WorkerVersionStamp'_constructor
        {_WorkerVersionStamp'buildId = Data.ProtoLens.fieldDefault,
         _WorkerVersionStamp'bundleId = Data.ProtoLens.fieldDefault,
         _WorkerVersionStamp'useVersioning = Data.ProtoLens.fieldDefault,
         _WorkerVersionStamp'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerVersionStamp
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerVersionStamp
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
                                       "build_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"buildId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "bundle_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"bundleId") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "use_versioning"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"useVersioning") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerVersionStamp"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"buildId") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"bundleId") _x
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
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"useVersioning") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                               _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData WorkerVersionStamp where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerVersionStamp'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerVersionStamp'buildId x__)
                (Control.DeepSeq.deepseq
                   (_WorkerVersionStamp'bundleId x__)
                   (Control.DeepSeq.deepseq
                      (_WorkerVersionStamp'useVersioning x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.workflowId' @:: Lens' WorkflowExecution Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.runId' @:: Lens' WorkflowExecution Data.Text.Text@ -}
data WorkflowExecution
  = WorkflowExecution'_constructor {_WorkflowExecution'workflowId :: !Data.Text.Text,
                                    _WorkflowExecution'runId :: !Data.Text.Text,
                                    _WorkflowExecution'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowExecution where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowExecution "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecution'workflowId
           (\ x__ y__ -> x__ {_WorkflowExecution'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecution "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecution'runId
           (\ x__ y__ -> x__ {_WorkflowExecution'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowExecution where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.WorkflowExecution"
  packedMessageDescriptor _
    = "\n\
      \\DC1WorkflowExecution\DC2\US\n\
      \\vworkflow_id\CAN\SOH \SOH(\tR\n\
      \workflowId\DC2\NAK\n\
      \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecution
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecution
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 2, runId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowExecution'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowExecution'_unknownFields = y__})
  defMessage
    = WorkflowExecution'_constructor
        {_WorkflowExecution'workflowId = Data.ProtoLens.fieldDefault,
         _WorkflowExecution'runId = Data.ProtoLens.fieldDefault,
         _WorkflowExecution'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowExecution
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowExecution
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
                                       "workflow_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"workflowId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "run_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"runId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowExecution"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowId") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"runId") _x
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
instance Control.DeepSeq.NFData WorkflowExecution where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowExecution'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowExecution'workflowId x__)
                (Control.DeepSeq.deepseq (_WorkflowExecution'runId x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.name' @:: Lens' WorkflowType Data.Text.Text@ -}
data WorkflowType
  = WorkflowType'_constructor {_WorkflowType'name :: !Data.Text.Text,
                               _WorkflowType'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowType where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowType "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowType'name (\ x__ y__ -> x__ {_WorkflowType'name = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowType where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.WorkflowType"
  packedMessageDescriptor _
    = "\n\
      \\fWorkflowType\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor WorkflowType
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, name__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowType'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowType'_unknownFields = y__})
  defMessage
    = WorkflowType'_constructor
        {_WorkflowType'name = Data.ProtoLens.fieldDefault,
         _WorkflowType'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowType -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowType
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
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowType"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
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
instance Control.DeepSeq.NFData WorkflowType where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowType'_unknownFields x__)
             (Control.DeepSeq.deepseq (_WorkflowType'name x__) ())
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \$temporal/api/common/v1/message.proto\DC2\SYNtemporal.api.common.v1\SUB\RSgoogle/protobuf/duration.proto\SUB!dependencies/gogoproto/gogo.proto\SUB\"temporal/api/enums/v1/common.proto\"h\n\
    \\bDataBlob\DC2H\n\
    \\rencoding_type\CAN\SOH \SOH(\SO2#.temporal.api.enums.v1.EncodingTypeR\fencodingType\DC2\DC2\n\
    \\EOTdata\CAN\STX \SOH(\fR\EOTdata\"G\n\
    \\bPayloads\DC2;\n\
    \\bpayloads\CAN\SOH \ETX(\v2\US.temporal.api.common.v1.PayloadR\bpayloads\"\165\SOH\n\
    \\aPayload\DC2I\n\
    \\bmetadata\CAN\SOH \ETX(\v2-.temporal.api.common.v1.Payload.MetadataEntryR\bmetadata\DC2\DC2\n\
    \\EOTdata\CAN\STX \SOH(\fR\EOTdata\SUB;\n\
    \\rMetadataEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\fR\ENQvalue:\STX8\SOH\"\217\SOH\n\
    \\DLESearchAttributes\DC2b\n\
    \\SOindexed_fields\CAN\SOH \ETX(\v2;.temporal.api.common.v1.SearchAttributes.IndexedFieldsEntryR\rindexedFields\SUBa\n\
    \\DC2IndexedFieldsEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
    \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH\"\164\SOH\n\
    \\EOTMemo\DC2@\n\
    \\ACKfields\CAN\SOH \ETX(\v2(.temporal.api.common.v1.Memo.FieldsEntryR\ACKfields\SUBZ\n\
    \\vFieldsEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
    \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH\"\168\SOH\n\
    \\ACKHeader\DC2B\n\
    \\ACKfields\CAN\SOH \ETX(\v2*.temporal.api.common.v1.Header.FieldsEntryR\ACKfields\SUBZ\n\
    \\vFieldsEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
    \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH\"K\n\
    \\DC1WorkflowExecution\DC2\US\n\
    \\vworkflow_id\CAN\SOH \SOH(\tR\n\
    \workflowId\DC2\NAK\n\
    \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\"\"\n\
    \\fWorkflowType\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\"\"\n\
    \\fActivityType\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\"\188\STX\n\
    \\vRetryPolicy\DC2J\n\
    \\DLEinitial_interval\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\SIinitialIntervalB\EOT\152\223\US\SOH\DC2/\n\
    \\DC3backoff_coefficient\CAN\STX \SOH(\SOHR\DC2backoffCoefficient\DC2J\n\
    \\DLEmaximum_interval\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\SImaximumIntervalB\EOT\152\223\US\SOH\DC2)\n\
    \\DLEmaximum_attempts\CAN\EOT \SOH(\ENQR\SImaximumAttempts\DC29\n\
    \\EMnon_retryable_error_types\CAN\ENQ \ETX(\tR\SYNnonRetryableErrorTypes\"n\n\
    \\DLEMeteringMetadata\DC2Z\n\
    \*nonfirst_local_activity_execution_attempts\CAN\r \SOH(\rR&nonfirstLocalActivityExecutionAttempts\"s\n\
    \\DC2WorkerVersionStamp\DC2\EM\n\
    \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2\ESC\n\
    \\tbundle_id\CAN\STX \SOH(\tR\bbundleId\DC2%\n\
    \\SOuse_versioning\CAN\ETX \SOH(\bR\ruseVersioning\"]\n\
    \\EMWorkerVersionCapabilities\DC2\EM\n\
    \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2%\n\
    \\SOuse_versioning\CAN\STX \SOH(\bR\ruseVersioningB\137\SOH\n\
    \\EMio.temporal.api.common.v1B\fMessageProtoP\SOHZ#go.temporal.io/api/common/v1;common\170\STX\CANTemporalio.Api.Common.V1\234\STX\ESCTemporalio::Api::Common::V1J\161\&2\n\
    \\a\DC2\ENQ\SYN\NUL\150\SOH\SOH\n\
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
    \\STX\ETX\NUL\DC2\ETX!\NUL(\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX#\NUL+\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX%\NUL,\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT'\NUL*\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX'\b\DLE\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX(\EOT9\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX(\EOT&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX('4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX(78\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX)\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX)\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX)\n\
    \\SO\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX)\DC1\DC2\n\
    \\ESC\n\
    \\STX\EOT\SOH\DC2\EOT-\NUL/\SOH\SUB\SI See `Payload`\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX-\b\DLE\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX.\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\EOT\DC2\ETX.\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX.\r\DC4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX.\NAK\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX. !\n\
    \\239\SOH\n\
    \\STX\EOT\STX\DC2\EOT4\NUL7\SOH\SUB\226\SOH Represents some binary (byte array) data (ex: activity input parameters or workflow result) with\n\
    \ metadata which describes this binary data (format, encoding, encryption, etc). Serialization\n\
    \ of the data may be user-defined.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX4\b\SI\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX5\EOT#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX5\EOT\NAK\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX5\SYN\RS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX5!\"\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX6\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX6\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX6\n\
    \\SO\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX6\DC1\DC2\n\
    \\163\SOH\n\
    \\STX\EOT\ETX\DC2\EOT;\NUL=\SOH\SUB\150\SOH A user-defined set of *indexed* fields that are used/exposed when listing/searching workflows.\n\
    \ The payload is not serialized in a user-defined way.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX;\b\CAN\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX<\EOT,\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ACK\DC2\ETX<\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX<\EM'\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX<*+\n\
    \h\n\
    \\STX\EOT\EOT\DC2\EOT@\NULB\SOH\SUB\\ A user-defined set of *unindexed* fields that are exposed when listing/searching workflows\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX@\b\f\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXA\EOT$\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETXA\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXA\EM\US\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXA\"#\n\
    \\176\SOH\n\
    \\STX\EOT\ENQ\DC2\EOTF\NULH\SOH\SUB\163\SOH Contains metadata that can be attached to a variety of requests, like starting a workflow, and\n\
    \ can be propagated between, for example, workflows and activities.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXF\b\SO\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXG\EOT$\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETXG\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXG\EM\US\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXG\"#\n\
    \\145\STX\n\
    \\STX\EOT\ACK\DC2\EOTM\NULP\SOH\SUB\132\STX Identifies a specific workflow within a namespace. Practically speaking, because run_id is a\n\
    \ uuid, a workflow execution is globally unique. Note that many commands allow specifying an empty\n\
    \ run id as a way of saying \"target the latest run of the workflow\".\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXM\b\EM\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXN\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXN\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXN\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXN\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXO\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXO\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXO\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXO\DC4\NAK\n\
    \\181\SOH\n\
    \\STX\EOT\a\DC2\EOTT\NULV\SOH\SUB\168\SOH Represents the identifier used by a workflow author to define the workflow. Typically, the\n\
    \ name of a function. This is sometimes referred to as the workflow's \"name\"\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXT\b\DC4\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXU\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETXU\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXU\v\SI\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXU\DC2\DC3\n\
    \\181\SOH\n\
    \\STX\EOT\b\DC2\EOTZ\NUL\\\SOH\SUB\168\SOH Represents the identifier used by a activity author to define the activity. Typically, the\n\
    \ name of a function. This is sometimes referred to as the activity's \"name\"\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXZ\b\DC4\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETX[\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\ETX[\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETX[\v\SI\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETX[\DC2\DC3\n\
    \V\n\
    \\STX\EOT\t\DC2\EOT_\NULo\SOH\SUBJ How retries ought to be handled, usable by both workflows and activities\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETX_\b\DC3\n\
    \n\n\
    \\EOT\EOT\t\STX\NUL\DC2\ETXa\EOTS\SUBa Interval of the first retry. If retryBackoffCoefficient is 1.0 then it is used for all retries.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ACK\DC2\ETXa\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\ETXa\GS-\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\ETXa01\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\b\DC2\ETXa2R\n\
    \\SI\n\
    \\b\EOT\t\STX\NUL\b\243\251\ETX\DC2\ETXa3Q\n\
    \\169\SOH\n\
    \\EOT\EOT\t\STX\SOH\DC2\ETXe\EOT#\SUB\155\SOH Coefficient used to calculate the next retry interval.\n\
    \ The next retry interval is previous interval multiplied by the coefficient.\n\
    \ Must be 1 or larger.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ENQ\DC2\ETXe\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\ETXe\v\RS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\ETXe!\"\n\
    \\178\SOH\n\
    \\EOT\EOT\t\STX\STX\DC2\ETXh\EOTS\SUB\164\SOH Maximum interval between retries. Exponential backoff leads to interval increase.\n\
    \ This value is the cap of the increase. Default is 100x of the initial interval.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ACK\DC2\ETXh\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\SOH\DC2\ETXh\GS-\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ETX\DC2\ETXh01\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\b\DC2\ETXh2R\n\
    \\SI\n\
    \\b\EOT\t\STX\STX\b\243\251\ETX\DC2\ETXh3Q\n\
    \\159\SOH\n\
    \\EOT\EOT\t\STX\ETX\DC2\ETXk\EOT\US\SUB\145\SOH Maximum number of attempts. When exceeded the retries stop even if not expired yet.\n\
    \ 1 disables retries. 0 means unlimited (up to the timeouts)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ENQ\DC2\ETXk\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\SOH\DC2\ETXk\n\
    \\SUB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ETX\DC2\ETXk\GS\RS\n\
    \\192\SOH\n\
    \\EOT\EOT\t\STX\EOT\DC2\ETXn\EOT2\SUB\178\SOH Non-Retryable errors types. Will stop retrying if the error type matches this list. Note that\n\
    \ this is not a substring match, the error *type* (not message) must match exactly.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\EOT\DC2\ETXn\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ENQ\DC2\ETXn\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\SOH\DC2\ETXn\DC4-\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ETX\DC2\ETXn01\n\
    \5\n\
    \\STX\EOT\n\
    \\DC2\EOTr\NULz\SOH\SUB) Metadata relevant for metering purposes\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETXr\b\CAN\n\
    \\239\STX\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETXy\EOT;\SUB\225\STX Count of local activities which have begun an execution attempt during this workflow task,\n\
    \ and whose first attempt occurred in some previous task. This is used for metering\n\
    \ purposes, and does not affect workflow state.\n\
    \\n\
    \ (-- api-linter: core::0141::forbidden-types=disabled\n\
    \     aip.dev/not-precedent: Negative values make no sense to represent. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETXy\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETXy\v5\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETXy8:\n\
    \J\n\
    \\STX\EOT\v\DC2\ENQ}\NUL\136\SOH\SOH\SUB= Identifies the version(s) of a worker that processed a task\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETX}\b\SUB\n\
    \\170\SOH\n\
    \\EOT\EOT\v\STX\NUL\DC2\EOT\128\SOH\EOT\CAN\SUB\155\SOH An opaque whole-worker identifier. Replaces the deprecated `binary_checksum` field when this\n\
    \ message is included in requests which previously used that.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ENQ\DC2\EOT\128\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\EOT\128\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\EOT\128\SOH\SYN\ETB\n\
    \\139\SOH\n\
    \\EOT\EOT\v\STX\SOH\DC2\EOT\131\SOH\EOT\EM\SUB} Set if the worker used a dynamically loadable bundle to process\n\
    \ the task. The bundle could be a WASM blob, JS bundle, etc.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ENQ\DC2\EOT\131\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\EOT\131\SOH\v\DC4\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\EOT\131\SOH\ETB\CAN\n\
    \\173\SOH\n\
    \\EOT\EOT\v\STX\STX\DC2\EOT\135\SOH\EOT\FS\SUB\158\SOH If set, the worker is opting in to worker versioning. Otherwise, this is used only as a\n\
    \ marker for workflow reset points and the BuildIDs search attribute.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ENQ\DC2\EOT\135\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\SOH\DC2\EOT\135\SOH\t\ETB\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ETX\DC2\EOT\135\SOH\SUB\ESC\n\
    \\151\STX\n\
    \\STX\EOT\f\DC2\ACK\141\SOH\NUL\150\SOH\SOH\SUB\136\STX Identifies the version(s) that a worker is compatible with when polling or identifying itself,\n\
    \ and whether or not this worker is opting into the build-id based versioning feature. This is\n\
    \ used by matching to determine which workers ought to receive what tasks.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\f\SOH\DC2\EOT\141\SOH\b!\n\
    \1\n\
    \\EOT\EOT\f\STX\NUL\DC2\EOT\143\SOH\EOT\CAN\SUB# An opaque whole-worker identifier\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ENQ\DC2\EOT\143\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\EOT\143\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\EOT\143\SOH\SYN\ETB\n\
    \t\n\
    \\EOT\EOT\f\STX\SOH\DC2\EOT\147\SOH\EOT\FS\SUBf If set, the worker is opting in to worker versioning, and wishes to only receive appropriate\n\
    \ tasks.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ENQ\DC2\EOT\147\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\EOT\147\SOH\t\ETB\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\EOT\147\SOH\SUB\ESCb\ACKproto3"
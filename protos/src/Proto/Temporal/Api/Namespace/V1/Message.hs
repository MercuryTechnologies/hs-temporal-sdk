{- This file was auto-generated from temporal/api/namespace/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Namespace.V1.Message (
        BadBinaries(), BadBinaries'BinariesEntry(), BadBinaryInfo(),
        NamespaceConfig(),
        NamespaceConfig'CustomSearchAttributeAliasesEntry(),
        NamespaceFilter(), NamespaceInfo(), NamespaceInfo'DataEntry(),
        UpdateNamespaceInfo(), UpdateNamespaceInfo'DataEntry()
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
import qualified Proto.Temporal.Api.Enums.V1.Namespace
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.binaries' @:: Lens' BadBinaries (Data.Map.Map Data.Text.Text BadBinaryInfo)@ -}
data BadBinaries
  = BadBinaries'_constructor {_BadBinaries'binaries :: !(Data.Map.Map Data.Text.Text BadBinaryInfo),
                              _BadBinaries'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BadBinaries where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BadBinaries "binaries" (Data.Map.Map Data.Text.Text BadBinaryInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaries'binaries
           (\ x__ y__ -> x__ {_BadBinaries'binaries = y__}))
        Prelude.id
instance Data.ProtoLens.Message BadBinaries where
  messageName _
    = Data.Text.pack "temporal.api.namespace.v1.BadBinaries"
  packedMessageDescriptor _
    = "\n\
      \\vBadBinaries\DC2P\n\
      \\bbinaries\CAN\SOH \ETX(\v24.temporal.api.namespace.v1.BadBinaries.BinariesEntryR\bbinaries\SUBe\n\
      \\rBinariesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2>\n\
      \\ENQvalue\CAN\STX \SOH(\v2(.temporal.api.namespace.v1.BadBinaryInfoR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        binaries__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "binaries"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor BadBinaries'BinariesEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                    Data.ProtoLens.FieldTypeDescriptor BadBinaryInfo)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"binaries")) ::
              Data.ProtoLens.FieldDescriptor BadBinaries
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, binaries__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BadBinaries'_unknownFields
        (\ x__ y__ -> x__ {_BadBinaries'_unknownFields = y__})
  defMessage
    = BadBinaries'_constructor
        {_BadBinaries'binaries = Data.Map.empty,
         _BadBinaries'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BadBinaries -> Data.ProtoLens.Encoding.Bytes.Parser BadBinaries
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
                          -> do !(entry :: BadBinaries'BinariesEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                           (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                               Data.ProtoLens.Encoding.Bytes.isolate
                                                                                 (Prelude.fromIntegral
                                                                                    len)
                                                                                 Data.ProtoLens.parseMessage)
                                                                           "binaries"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"binaries")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BadBinaries"
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
                                    (Data.ProtoLens.defMessage :: BadBinaries'BinariesEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"binaries") _x))))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData BadBinaries where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BadBinaries'_unknownFields x__)
             (Control.DeepSeq.deepseq (_BadBinaries'binaries x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.key' @:: Lens' BadBinaries'BinariesEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.value' @:: Lens' BadBinaries'BinariesEntry BadBinaryInfo@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.maybe'value' @:: Lens' BadBinaries'BinariesEntry (Prelude.Maybe BadBinaryInfo)@ -}
data BadBinaries'BinariesEntry
  = BadBinaries'BinariesEntry'_constructor {_BadBinaries'BinariesEntry'key :: !Data.Text.Text,
                                            _BadBinaries'BinariesEntry'value :: !(Prelude.Maybe BadBinaryInfo),
                                            _BadBinaries'BinariesEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BadBinaries'BinariesEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BadBinaries'BinariesEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaries'BinariesEntry'key
           (\ x__ y__ -> x__ {_BadBinaries'BinariesEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BadBinaries'BinariesEntry "value" BadBinaryInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaries'BinariesEntry'value
           (\ x__ y__ -> x__ {_BadBinaries'BinariesEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BadBinaries'BinariesEntry "maybe'value" (Prelude.Maybe BadBinaryInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaries'BinariesEntry'value
           (\ x__ y__ -> x__ {_BadBinaries'BinariesEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message BadBinaries'BinariesEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.namespace.v1.BadBinaries.BinariesEntry"
  packedMessageDescriptor _
    = "\n\
      \\rBinariesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2>\n\
      \\ENQvalue\CAN\STX \SOH(\v2(.temporal.api.namespace.v1.BadBinaryInfoR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor BadBinaries'BinariesEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor BadBinaryInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor BadBinaries'BinariesEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BadBinaries'BinariesEntry'_unknownFields
        (\ x__ y__
           -> x__ {_BadBinaries'BinariesEntry'_unknownFields = y__})
  defMessage
    = BadBinaries'BinariesEntry'_constructor
        {_BadBinaries'BinariesEntry'key = Data.ProtoLens.fieldDefault,
         _BadBinaries'BinariesEntry'value = Prelude.Nothing,
         _BadBinaries'BinariesEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BadBinaries'BinariesEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser BadBinaries'BinariesEntry
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
          (do loop Data.ProtoLens.defMessage) "BinariesEntry"
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
instance Control.DeepSeq.NFData BadBinaries'BinariesEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BadBinaries'BinariesEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BadBinaries'BinariesEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_BadBinaries'BinariesEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.reason' @:: Lens' BadBinaryInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.operator' @:: Lens' BadBinaryInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.createTime' @:: Lens' BadBinaryInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.maybe'createTime' @:: Lens' BadBinaryInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data BadBinaryInfo
  = BadBinaryInfo'_constructor {_BadBinaryInfo'reason :: !Data.Text.Text,
                                _BadBinaryInfo'operator :: !Data.Text.Text,
                                _BadBinaryInfo'createTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                _BadBinaryInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BadBinaryInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BadBinaryInfo "reason" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaryInfo'reason
           (\ x__ y__ -> x__ {_BadBinaryInfo'reason = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BadBinaryInfo "operator" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaryInfo'operator
           (\ x__ y__ -> x__ {_BadBinaryInfo'operator = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BadBinaryInfo "createTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaryInfo'createTime
           (\ x__ y__ -> x__ {_BadBinaryInfo'createTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BadBinaryInfo "maybe'createTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BadBinaryInfo'createTime
           (\ x__ y__ -> x__ {_BadBinaryInfo'createTime = y__}))
        Prelude.id
instance Data.ProtoLens.Message BadBinaryInfo where
  messageName _
    = Data.Text.pack "temporal.api.namespace.v1.BadBinaryInfo"
  packedMessageDescriptor _
    = "\n\
      \\rBadBinaryInfo\DC2\SYN\n\
      \\ACKreason\CAN\SOH \SOH(\tR\ACKreason\DC2\SUB\n\
      \\boperator\CAN\STX \SOH(\tR\boperator\DC2;\n\
      \\vcreate_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \createTime"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        reason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"reason")) ::
              Data.ProtoLens.FieldDescriptor BadBinaryInfo
        operator__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operator"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operator")) ::
              Data.ProtoLens.FieldDescriptor BadBinaryInfo
        createTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "create_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'createTime")) ::
              Data.ProtoLens.FieldDescriptor BadBinaryInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, reason__field_descriptor),
           (Data.ProtoLens.Tag 2, operator__field_descriptor),
           (Data.ProtoLens.Tag 3, createTime__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BadBinaryInfo'_unknownFields
        (\ x__ y__ -> x__ {_BadBinaryInfo'_unknownFields = y__})
  defMessage
    = BadBinaryInfo'_constructor
        {_BadBinaryInfo'reason = Data.ProtoLens.fieldDefault,
         _BadBinaryInfo'operator = Data.ProtoLens.fieldDefault,
         _BadBinaryInfo'createTime = Prelude.Nothing,
         _BadBinaryInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BadBinaryInfo -> Data.ProtoLens.Encoding.Bytes.Parser BadBinaryInfo
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
                                       "reason"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"reason") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "operator"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"operator") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "create_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"createTime") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BadBinaryInfo"
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"operator") _x
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
                          (Data.ProtoLens.Field.field @"maybe'createTime") _x
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
instance Control.DeepSeq.NFData BadBinaryInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BadBinaryInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BadBinaryInfo'reason x__)
                (Control.DeepSeq.deepseq
                   (_BadBinaryInfo'operator x__)
                   (Control.DeepSeq.deepseq (_BadBinaryInfo'createTime x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.workflowExecutionRetentionTtl' @:: Lens' NamespaceConfig Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.maybe'workflowExecutionRetentionTtl' @:: Lens' NamespaceConfig (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.badBinaries' @:: Lens' NamespaceConfig BadBinaries@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.maybe'badBinaries' @:: Lens' NamespaceConfig (Prelude.Maybe BadBinaries)@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.historyArchivalState' @:: Lens' NamespaceConfig Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.historyArchivalUri' @:: Lens' NamespaceConfig Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.visibilityArchivalState' @:: Lens' NamespaceConfig Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.visibilityArchivalUri' @:: Lens' NamespaceConfig Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.customSearchAttributeAliases' @:: Lens' NamespaceConfig (Data.Map.Map Data.Text.Text Data.Text.Text)@ -}
data NamespaceConfig
  = NamespaceConfig'_constructor {_NamespaceConfig'workflowExecutionRetentionTtl :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                  _NamespaceConfig'badBinaries :: !(Prelude.Maybe BadBinaries),
                                  _NamespaceConfig'historyArchivalState :: !Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState,
                                  _NamespaceConfig'historyArchivalUri :: !Data.Text.Text,
                                  _NamespaceConfig'visibilityArchivalState :: !Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState,
                                  _NamespaceConfig'visibilityArchivalUri :: !Data.Text.Text,
                                  _NamespaceConfig'customSearchAttributeAliases :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                                  _NamespaceConfig'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceConfig where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceConfig "workflowExecutionRetentionTtl" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'workflowExecutionRetentionTtl
           (\ x__ y__
              -> x__ {_NamespaceConfig'workflowExecutionRetentionTtl = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NamespaceConfig "maybe'workflowExecutionRetentionTtl" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'workflowExecutionRetentionTtl
           (\ x__ y__
              -> x__ {_NamespaceConfig'workflowExecutionRetentionTtl = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceConfig "badBinaries" BadBinaries where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'badBinaries
           (\ x__ y__ -> x__ {_NamespaceConfig'badBinaries = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NamespaceConfig "maybe'badBinaries" (Prelude.Maybe BadBinaries) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'badBinaries
           (\ x__ y__ -> x__ {_NamespaceConfig'badBinaries = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceConfig "historyArchivalState" Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'historyArchivalState
           (\ x__ y__ -> x__ {_NamespaceConfig'historyArchivalState = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceConfig "historyArchivalUri" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'historyArchivalUri
           (\ x__ y__ -> x__ {_NamespaceConfig'historyArchivalUri = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceConfig "visibilityArchivalState" Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'visibilityArchivalState
           (\ x__ y__
              -> x__ {_NamespaceConfig'visibilityArchivalState = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceConfig "visibilityArchivalUri" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'visibilityArchivalUri
           (\ x__ y__ -> x__ {_NamespaceConfig'visibilityArchivalUri = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceConfig "customSearchAttributeAliases" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'customSearchAttributeAliases
           (\ x__ y__
              -> x__ {_NamespaceConfig'customSearchAttributeAliases = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceConfig where
  messageName _
    = Data.Text.pack "temporal.api.namespace.v1.NamespaceConfig"
  packedMessageDescriptor _
    = "\n\
      \\SINamespaceConfig\DC2b\n\
      \ workflow_execution_retention_ttl\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\GSworkflowExecutionRetentionTtl\DC2I\n\
      \\fbad_binaries\CAN\STX \SOH(\v2&.temporal.api.namespace.v1.BadBinariesR\vbadBinaries\DC2Z\n\
      \\SYNhistory_archival_state\CAN\ETX \SOH(\SO2$.temporal.api.enums.v1.ArchivalStateR\DC4historyArchivalState\DC20\n\
      \\DC4history_archival_uri\CAN\EOT \SOH(\tR\DC2historyArchivalUri\DC2`\n\
      \\EMvisibility_archival_state\CAN\ENQ \SOH(\SO2$.temporal.api.enums.v1.ArchivalStateR\ETBvisibilityArchivalState\DC26\n\
      \\ETBvisibility_archival_uri\CAN\ACK \SOH(\tR\NAKvisibilityArchivalUri\DC2\147\SOH\n\
      \\UScustom_search_attribute_aliases\CAN\a \ETX(\v2L.temporal.api.namespace.v1.NamespaceConfig.CustomSearchAttributeAliasesEntryR\FScustomSearchAttributeAliases\SUBO\n\
      \!CustomSearchAttributeAliasesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowExecutionRetentionTtl__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution_retention_ttl"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'workflowExecutionRetentionTtl")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig
        badBinaries__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "bad_binaries"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor BadBinaries)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'badBinaries")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig
        historyArchivalState__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "history_archival_state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"historyArchivalState")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig
        historyArchivalUri__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "history_archival_uri"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"historyArchivalUri")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig
        visibilityArchivalState__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "visibility_archival_state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Namespace.ArchivalState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"visibilityArchivalState")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig
        visibilityArchivalUri__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "visibility_archival_uri"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"visibilityArchivalUri")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig
        customSearchAttributeAliases__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "custom_search_attribute_aliases"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor NamespaceConfig'CustomSearchAttributeAliasesEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                    Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"customSearchAttributeAliases")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, 
            workflowExecutionRetentionTtl__field_descriptor),
           (Data.ProtoLens.Tag 2, badBinaries__field_descriptor),
           (Data.ProtoLens.Tag 3, historyArchivalState__field_descriptor),
           (Data.ProtoLens.Tag 4, historyArchivalUri__field_descriptor),
           (Data.ProtoLens.Tag 5, visibilityArchivalState__field_descriptor),
           (Data.ProtoLens.Tag 6, visibilityArchivalUri__field_descriptor),
           (Data.ProtoLens.Tag 7, 
            customSearchAttributeAliases__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceConfig'_unknownFields
        (\ x__ y__ -> x__ {_NamespaceConfig'_unknownFields = y__})
  defMessage
    = NamespaceConfig'_constructor
        {_NamespaceConfig'workflowExecutionRetentionTtl = Prelude.Nothing,
         _NamespaceConfig'badBinaries = Prelude.Nothing,
         _NamespaceConfig'historyArchivalState = Data.ProtoLens.fieldDefault,
         _NamespaceConfig'historyArchivalUri = Data.ProtoLens.fieldDefault,
         _NamespaceConfig'visibilityArchivalState = Data.ProtoLens.fieldDefault,
         _NamespaceConfig'visibilityArchivalUri = Data.ProtoLens.fieldDefault,
         _NamespaceConfig'customSearchAttributeAliases = Data.Map.empty,
         _NamespaceConfig'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceConfig
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceConfig
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
                                       "workflow_execution_retention_ttl"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecutionRetentionTtl") y
                                     x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "bad_binaries"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"badBinaries") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "history_archival_state"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"historyArchivalState") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "history_archival_uri"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"historyArchivalUri") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "visibility_archival_state"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"visibilityArchivalState") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "visibility_archival_uri"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"visibilityArchivalUri") y x)
                        58
                          -> do !(entry :: NamespaceConfig'CustomSearchAttributeAliasesEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                                   (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                                       Data.ProtoLens.Encoding.Bytes.isolate
                                                                                                         (Prelude.fromIntegral
                                                                                                            len)
                                                                                                         Data.ProtoLens.parseMessage)
                                                                                                   "custom_search_attribute_aliases"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"customSearchAttributeAliases")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NamespaceConfig"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'workflowExecutionRetentionTtl")
                    _x
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
                       (Data.ProtoLens.Field.field @"maybe'badBinaries") _x
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
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"historyArchivalState") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                               Prelude.fromEnum _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"historyArchivalUri") _x
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
                                  (Data.ProtoLens.Field.field @"visibilityArchivalState") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                                  ((Prelude..)
                                     ((Prelude..)
                                        Data.ProtoLens.Encoding.Bytes.putVarInt
                                        Prelude.fromIntegral)
                                     Prelude.fromEnum _v))
                         ((Data.Monoid.<>)
                            (let
                               _v
                                 = Lens.Family2.view
                                     (Data.ProtoLens.Field.field @"visibilityArchivalUri") _x
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
                            ((Data.Monoid.<>)
                               (Data.Monoid.mconcat
                                  (Prelude.map
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
                                                Data.ProtoLens.encodeMessage
                                                (Lens.Family2.set
                                                   (Data.ProtoLens.Field.field @"key")
                                                   (Prelude.fst _v)
                                                   (Lens.Family2.set
                                                      (Data.ProtoLens.Field.field @"value")
                                                      (Prelude.snd _v)
                                                      (Data.ProtoLens.defMessage ::
                                                         NamespaceConfig'CustomSearchAttributeAliasesEntry)))))
                                     (Data.Map.toList
                                        (Lens.Family2.view
                                           (Data.ProtoLens.Field.field
                                              @"customSearchAttributeAliases")
                                           _x))))
                               (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                  (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))
instance Control.DeepSeq.NFData NamespaceConfig where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceConfig'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespaceConfig'workflowExecutionRetentionTtl x__)
                (Control.DeepSeq.deepseq
                   (_NamespaceConfig'badBinaries x__)
                   (Control.DeepSeq.deepseq
                      (_NamespaceConfig'historyArchivalState x__)
                      (Control.DeepSeq.deepseq
                         (_NamespaceConfig'historyArchivalUri x__)
                         (Control.DeepSeq.deepseq
                            (_NamespaceConfig'visibilityArchivalState x__)
                            (Control.DeepSeq.deepseq
                               (_NamespaceConfig'visibilityArchivalUri x__)
                               (Control.DeepSeq.deepseq
                                  (_NamespaceConfig'customSearchAttributeAliases x__) ())))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.key' @:: Lens' NamespaceConfig'CustomSearchAttributeAliasesEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.value' @:: Lens' NamespaceConfig'CustomSearchAttributeAliasesEntry Data.Text.Text@ -}
data NamespaceConfig'CustomSearchAttributeAliasesEntry
  = NamespaceConfig'CustomSearchAttributeAliasesEntry'_constructor {_NamespaceConfig'CustomSearchAttributeAliasesEntry'key :: !Data.Text.Text,
                                                                    _NamespaceConfig'CustomSearchAttributeAliasesEntry'value :: !Data.Text.Text,
                                                                    _NamespaceConfig'CustomSearchAttributeAliasesEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceConfig'CustomSearchAttributeAliasesEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceConfig'CustomSearchAttributeAliasesEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'CustomSearchAttributeAliasesEntry'key
           (\ x__ y__
              -> x__
                   {_NamespaceConfig'CustomSearchAttributeAliasesEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceConfig'CustomSearchAttributeAliasesEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceConfig'CustomSearchAttributeAliasesEntry'value
           (\ x__ y__
              -> x__
                   {_NamespaceConfig'CustomSearchAttributeAliasesEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceConfig'CustomSearchAttributeAliasesEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.namespace.v1.NamespaceConfig.CustomSearchAttributeAliasesEntry"
  packedMessageDescriptor _
    = "\n\
      \!CustomSearchAttributeAliasesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor NamespaceConfig'CustomSearchAttributeAliasesEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor NamespaceConfig'CustomSearchAttributeAliasesEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceConfig'CustomSearchAttributeAliasesEntry'_unknownFields
        (\ x__ y__
           -> x__
                {_NamespaceConfig'CustomSearchAttributeAliasesEntry'_unknownFields = y__})
  defMessage
    = NamespaceConfig'CustomSearchAttributeAliasesEntry'_constructor
        {_NamespaceConfig'CustomSearchAttributeAliasesEntry'key = Data.ProtoLens.fieldDefault,
         _NamespaceConfig'CustomSearchAttributeAliasesEntry'value = Data.ProtoLens.fieldDefault,
         _NamespaceConfig'CustomSearchAttributeAliasesEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceConfig'CustomSearchAttributeAliasesEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceConfig'CustomSearchAttributeAliasesEntry
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
                                           Data.ProtoLens.Encoding.Bytes.getText
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
          (do loop Data.ProtoLens.defMessage)
          "CustomSearchAttributeAliasesEntry"
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
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData NamespaceConfig'CustomSearchAttributeAliasesEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceConfig'CustomSearchAttributeAliasesEntry'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_NamespaceConfig'CustomSearchAttributeAliasesEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_NamespaceConfig'CustomSearchAttributeAliasesEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.includeDeleted' @:: Lens' NamespaceFilter Prelude.Bool@ -}
data NamespaceFilter
  = NamespaceFilter'_constructor {_NamespaceFilter'includeDeleted :: !Prelude.Bool,
                                  _NamespaceFilter'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceFilter where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceFilter "includeDeleted" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceFilter'includeDeleted
           (\ x__ y__ -> x__ {_NamespaceFilter'includeDeleted = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceFilter where
  messageName _
    = Data.Text.pack "temporal.api.namespace.v1.NamespaceFilter"
  packedMessageDescriptor _
    = "\n\
      \\SINamespaceFilter\DC2'\n\
      \\SIinclude_deleted\CAN\SOH \SOH(\bR\SOincludeDeleted"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        includeDeleted__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "include_deleted"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"includeDeleted")) ::
              Data.ProtoLens.FieldDescriptor NamespaceFilter
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, includeDeleted__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceFilter'_unknownFields
        (\ x__ y__ -> x__ {_NamespaceFilter'_unknownFields = y__})
  defMessage
    = NamespaceFilter'_constructor
        {_NamespaceFilter'includeDeleted = Data.ProtoLens.fieldDefault,
         _NamespaceFilter'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceFilter
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceFilter
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
                                       "include_deleted"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"includeDeleted") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NamespaceFilter"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"includeDeleted") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                         _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData NamespaceFilter where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceFilter'_unknownFields x__)
             (Control.DeepSeq.deepseq (_NamespaceFilter'includeDeleted x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.name' @:: Lens' NamespaceInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.state' @:: Lens' NamespaceInfo Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.description' @:: Lens' NamespaceInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.ownerEmail' @:: Lens' NamespaceInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.data'' @:: Lens' NamespaceInfo (Data.Map.Map Data.Text.Text Data.Text.Text)@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.id' @:: Lens' NamespaceInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.supportsSchedules' @:: Lens' NamespaceInfo Prelude.Bool@ -}
data NamespaceInfo
  = NamespaceInfo'_constructor {_NamespaceInfo'name :: !Data.Text.Text,
                                _NamespaceInfo'state :: !Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState,
                                _NamespaceInfo'description :: !Data.Text.Text,
                                _NamespaceInfo'ownerEmail :: !Data.Text.Text,
                                _NamespaceInfo'data' :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                                _NamespaceInfo'id :: !Data.Text.Text,
                                _NamespaceInfo'supportsSchedules :: !Prelude.Bool,
                                _NamespaceInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceInfo "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'name (\ x__ y__ -> x__ {_NamespaceInfo'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInfo "state" Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'state
           (\ x__ y__ -> x__ {_NamespaceInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInfo "description" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'description
           (\ x__ y__ -> x__ {_NamespaceInfo'description = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInfo "ownerEmail" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'ownerEmail
           (\ x__ y__ -> x__ {_NamespaceInfo'ownerEmail = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInfo "data'" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'data'
           (\ x__ y__ -> x__ {_NamespaceInfo'data' = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInfo "id" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'id (\ x__ y__ -> x__ {_NamespaceInfo'id = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInfo "supportsSchedules" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'supportsSchedules
           (\ x__ y__ -> x__ {_NamespaceInfo'supportsSchedules = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceInfo where
  messageName _
    = Data.Text.pack "temporal.api.namespace.v1.NamespaceInfo"
  packedMessageDescriptor _
    = "\n\
      \\rNamespaceInfo\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2;\n\
      \\ENQstate\CAN\STX \SOH(\SO2%.temporal.api.enums.v1.NamespaceStateR\ENQstate\DC2 \n\
      \\vdescription\CAN\ETX \SOH(\tR\vdescription\DC2\US\n\
      \\vowner_email\CAN\EOT \SOH(\tR\n\
      \ownerEmail\DC2F\n\
      \\EOTdata\CAN\ENQ \ETX(\v22.temporal.api.namespace.v1.NamespaceInfo.DataEntryR\EOTdata\DC2\SO\n\
      \\STXid\CAN\ACK \SOH(\tR\STXid\DC2-\n\
      \\DC2supports_schedules\CANd \SOH(\bR\DC1supportsSchedules\SUB7\n\
      \\tDataEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor NamespaceInfo
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInfo
        description__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "description"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"description")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInfo
        ownerEmail__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "owner_email"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"ownerEmail")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInfo
        data'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "data"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor NamespaceInfo'DataEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                    Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"data'")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInfo
        id__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"id")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInfo
        supportsSchedules__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "supports_schedules"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"supportsSchedules")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, state__field_descriptor),
           (Data.ProtoLens.Tag 3, description__field_descriptor),
           (Data.ProtoLens.Tag 4, ownerEmail__field_descriptor),
           (Data.ProtoLens.Tag 5, data'__field_descriptor),
           (Data.ProtoLens.Tag 6, id__field_descriptor),
           (Data.ProtoLens.Tag 100, supportsSchedules__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceInfo'_unknownFields
        (\ x__ y__ -> x__ {_NamespaceInfo'_unknownFields = y__})
  defMessage
    = NamespaceInfo'_constructor
        {_NamespaceInfo'name = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'state = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'description = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'ownerEmail = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'data' = Data.Map.empty,
         _NamespaceInfo'id = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'supportsSchedules = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceInfo -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceInfo
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
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "description"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"description") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "owner_email"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"ownerEmail") y x)
                        42
                          -> do !(entry :: NamespaceInfo'DataEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                         (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                             Data.ProtoLens.Encoding.Bytes.isolate
                                                                               (Prelude.fromIntegral
                                                                                  len)
                                                                               Data.ProtoLens.parseMessage)
                                                                         "data"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"data'")
                                        (\ !t -> Data.Map.insert key value t) x))
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"id") y x)
                        800
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "supports_schedules"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"supportsSchedules") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NamespaceInfo"
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
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"state") _x
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
                ((Data.Monoid.<>)
                   (let
                      _v
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"description") _x
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
                         _v
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"ownerEmail") _x
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
                         (Data.Monoid.mconcat
                            (Prelude.map
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
                                          Data.ProtoLens.encodeMessage
                                          (Lens.Family2.set
                                             (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                             (Lens.Family2.set
                                                (Data.ProtoLens.Field.field @"value")
                                                (Prelude.snd _v)
                                                (Data.ProtoLens.defMessage ::
                                                   NamespaceInfo'DataEntry)))))
                               (Data.Map.toList
                                  (Lens.Family2.view (Data.ProtoLens.Field.field @"data'") _x))))
                         ((Data.Monoid.<>)
                            (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"id") _x
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
                            ((Data.Monoid.<>)
                               (let
                                  _v
                                    = Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"supportsSchedules") _x
                                in
                                  if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                      Data.Monoid.mempty
                                  else
                                      (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 800)
                                        ((Prelude..)
                                           Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (\ b -> if b then 1 else 0) _v))
                               (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                  (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))
instance Control.DeepSeq.NFData NamespaceInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespaceInfo'name x__)
                (Control.DeepSeq.deepseq
                   (_NamespaceInfo'state x__)
                   (Control.DeepSeq.deepseq
                      (_NamespaceInfo'description x__)
                      (Control.DeepSeq.deepseq
                         (_NamespaceInfo'ownerEmail x__)
                         (Control.DeepSeq.deepseq
                            (_NamespaceInfo'data' x__)
                            (Control.DeepSeq.deepseq
                               (_NamespaceInfo'id x__)
                               (Control.DeepSeq.deepseq
                                  (_NamespaceInfo'supportsSchedules x__) ())))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.key' @:: Lens' NamespaceInfo'DataEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.value' @:: Lens' NamespaceInfo'DataEntry Data.Text.Text@ -}
data NamespaceInfo'DataEntry
  = NamespaceInfo'DataEntry'_constructor {_NamespaceInfo'DataEntry'key :: !Data.Text.Text,
                                          _NamespaceInfo'DataEntry'value :: !Data.Text.Text,
                                          _NamespaceInfo'DataEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceInfo'DataEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceInfo'DataEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'DataEntry'key
           (\ x__ y__ -> x__ {_NamespaceInfo'DataEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInfo'DataEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInfo'DataEntry'value
           (\ x__ y__ -> x__ {_NamespaceInfo'DataEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceInfo'DataEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.namespace.v1.NamespaceInfo.DataEntry"
  packedMessageDescriptor _
    = "\n\
      \\tDataEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor NamespaceInfo'DataEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInfo'DataEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceInfo'DataEntry'_unknownFields
        (\ x__ y__ -> x__ {_NamespaceInfo'DataEntry'_unknownFields = y__})
  defMessage
    = NamespaceInfo'DataEntry'_constructor
        {_NamespaceInfo'DataEntry'key = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'DataEntry'value = Data.ProtoLens.fieldDefault,
         _NamespaceInfo'DataEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceInfo'DataEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceInfo'DataEntry
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
                                           Data.ProtoLens.Encoding.Bytes.getText
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
          (do loop Data.ProtoLens.defMessage) "DataEntry"
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
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData NamespaceInfo'DataEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceInfo'DataEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespaceInfo'DataEntry'key x__)
                (Control.DeepSeq.deepseq (_NamespaceInfo'DataEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.description' @:: Lens' UpdateNamespaceInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.ownerEmail' @:: Lens' UpdateNamespaceInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.data'' @:: Lens' UpdateNamespaceInfo (Data.Map.Map Data.Text.Text Data.Text.Text)@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.state' @:: Lens' UpdateNamespaceInfo Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState@ -}
data UpdateNamespaceInfo
  = UpdateNamespaceInfo'_constructor {_UpdateNamespaceInfo'description :: !Data.Text.Text,
                                      _UpdateNamespaceInfo'ownerEmail :: !Data.Text.Text,
                                      _UpdateNamespaceInfo'data' :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                                      _UpdateNamespaceInfo'state :: !Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState,
                                      _UpdateNamespaceInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UpdateNamespaceInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UpdateNamespaceInfo "description" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNamespaceInfo'description
           (\ x__ y__ -> x__ {_UpdateNamespaceInfo'description = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UpdateNamespaceInfo "ownerEmail" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNamespaceInfo'ownerEmail
           (\ x__ y__ -> x__ {_UpdateNamespaceInfo'ownerEmail = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UpdateNamespaceInfo "data'" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNamespaceInfo'data'
           (\ x__ y__ -> x__ {_UpdateNamespaceInfo'data' = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UpdateNamespaceInfo "state" Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNamespaceInfo'state
           (\ x__ y__ -> x__ {_UpdateNamespaceInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Message UpdateNamespaceInfo where
  messageName _
    = Data.Text.pack "temporal.api.namespace.v1.UpdateNamespaceInfo"
  packedMessageDescriptor _
    = "\n\
      \\DC3UpdateNamespaceInfo\DC2 \n\
      \\vdescription\CAN\SOH \SOH(\tR\vdescription\DC2\US\n\
      \\vowner_email\CAN\STX \SOH(\tR\n\
      \ownerEmail\DC2L\n\
      \\EOTdata\CAN\ETX \ETX(\v28.temporal.api.namespace.v1.UpdateNamespaceInfo.DataEntryR\EOTdata\DC2;\n\
      \\ENQstate\CAN\EOT \SOH(\SO2%.temporal.api.enums.v1.NamespaceStateR\ENQstate\SUB7\n\
      \\tDataEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        description__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "description"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"description")) ::
              Data.ProtoLens.FieldDescriptor UpdateNamespaceInfo
        ownerEmail__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "owner_email"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"ownerEmail")) ::
              Data.ProtoLens.FieldDescriptor UpdateNamespaceInfo
        data'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "data"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor UpdateNamespaceInfo'DataEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                    Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"data'")) ::
              Data.ProtoLens.FieldDescriptor UpdateNamespaceInfo
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor UpdateNamespaceInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, description__field_descriptor),
           (Data.ProtoLens.Tag 2, ownerEmail__field_descriptor),
           (Data.ProtoLens.Tag 3, data'__field_descriptor),
           (Data.ProtoLens.Tag 4, state__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UpdateNamespaceInfo'_unknownFields
        (\ x__ y__ -> x__ {_UpdateNamespaceInfo'_unknownFields = y__})
  defMessage
    = UpdateNamespaceInfo'_constructor
        {_UpdateNamespaceInfo'description = Data.ProtoLens.fieldDefault,
         _UpdateNamespaceInfo'ownerEmail = Data.ProtoLens.fieldDefault,
         _UpdateNamespaceInfo'data' = Data.Map.empty,
         _UpdateNamespaceInfo'state = Data.ProtoLens.fieldDefault,
         _UpdateNamespaceInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UpdateNamespaceInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser UpdateNamespaceInfo
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
                                       "description"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"description") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "owner_email"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"ownerEmail") y x)
                        26
                          -> do !(entry :: UpdateNamespaceInfo'DataEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                               (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                   Data.ProtoLens.Encoding.Bytes.isolate
                                                                                     (Prelude.fromIntegral
                                                                                        len)
                                                                                     Data.ProtoLens.parseMessage)
                                                                               "data"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"data'")
                                        (\ !t -> Data.Map.insert key value t) x))
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "UpdateNamespaceInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"description") _x
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
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"ownerEmail") _x
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
                   (Data.Monoid.mconcat
                      (Prelude.map
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
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
                                             UpdateNamespaceInfo'DataEntry)))))
                         (Data.Map.toList
                            (Lens.Family2.view (Data.ProtoLens.Field.field @"data'") _x))))
                   ((Data.Monoid.<>)
                      (let
                         _v = Lens.Family2.view (Data.ProtoLens.Field.field @"state") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                               ((Prelude..)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                                  Prelude.fromEnum _v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData UpdateNamespaceInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UpdateNamespaceInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_UpdateNamespaceInfo'description x__)
                (Control.DeepSeq.deepseq
                   (_UpdateNamespaceInfo'ownerEmail x__)
                   (Control.DeepSeq.deepseq
                      (_UpdateNamespaceInfo'data' x__)
                      (Control.DeepSeq.deepseq (_UpdateNamespaceInfo'state x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.key' @:: Lens' UpdateNamespaceInfo'DataEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Namespace.V1.Message_Fields.value' @:: Lens' UpdateNamespaceInfo'DataEntry Data.Text.Text@ -}
data UpdateNamespaceInfo'DataEntry
  = UpdateNamespaceInfo'DataEntry'_constructor {_UpdateNamespaceInfo'DataEntry'key :: !Data.Text.Text,
                                                _UpdateNamespaceInfo'DataEntry'value :: !Data.Text.Text,
                                                _UpdateNamespaceInfo'DataEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UpdateNamespaceInfo'DataEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UpdateNamespaceInfo'DataEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNamespaceInfo'DataEntry'key
           (\ x__ y__ -> x__ {_UpdateNamespaceInfo'DataEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UpdateNamespaceInfo'DataEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNamespaceInfo'DataEntry'value
           (\ x__ y__ -> x__ {_UpdateNamespaceInfo'DataEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message UpdateNamespaceInfo'DataEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.namespace.v1.UpdateNamespaceInfo.DataEntry"
  packedMessageDescriptor _
    = "\n\
      \\tDataEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor UpdateNamespaceInfo'DataEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor UpdateNamespaceInfo'DataEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UpdateNamespaceInfo'DataEntry'_unknownFields
        (\ x__ y__
           -> x__ {_UpdateNamespaceInfo'DataEntry'_unknownFields = y__})
  defMessage
    = UpdateNamespaceInfo'DataEntry'_constructor
        {_UpdateNamespaceInfo'DataEntry'key = Data.ProtoLens.fieldDefault,
         _UpdateNamespaceInfo'DataEntry'value = Data.ProtoLens.fieldDefault,
         _UpdateNamespaceInfo'DataEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UpdateNamespaceInfo'DataEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser UpdateNamespaceInfo'DataEntry
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
                                           Data.ProtoLens.Encoding.Bytes.getText
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
          (do loop Data.ProtoLens.defMessage) "DataEntry"
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
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData UpdateNamespaceInfo'DataEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UpdateNamespaceInfo'DataEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_UpdateNamespaceInfo'DataEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_UpdateNamespaceInfo'DataEntry'value x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \'temporal/api/namespace/v1/message.proto\DC2\EMtemporal.api.namespace.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB%temporal/api/enums/v1/namespace.proto\"\227\STX\n\
    \\rNamespaceInfo\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2;\n\
    \\ENQstate\CAN\STX \SOH(\SO2%.temporal.api.enums.v1.NamespaceStateR\ENQstate\DC2 \n\
    \\vdescription\CAN\ETX \SOH(\tR\vdescription\DC2\US\n\
    \\vowner_email\CAN\EOT \SOH(\tR\n\
    \ownerEmail\DC2F\n\
    \\EOTdata\CAN\ENQ \ETX(\v22.temporal.api.namespace.v1.NamespaceInfo.DataEntryR\EOTdata\DC2\SO\n\
    \\STXid\CAN\ACK \SOH(\tR\STXid\DC2-\n\
    \\DC2supports_schedules\CANd \SOH(\bR\DC1supportsSchedules\SUB7\n\
    \\tDataEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\"\207\ENQ\n\
    \\SINamespaceConfig\DC2b\n\
    \ workflow_execution_retention_ttl\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\GSworkflowExecutionRetentionTtl\DC2I\n\
    \\fbad_binaries\CAN\STX \SOH(\v2&.temporal.api.namespace.v1.BadBinariesR\vbadBinaries\DC2Z\n\
    \\SYNhistory_archival_state\CAN\ETX \SOH(\SO2$.temporal.api.enums.v1.ArchivalStateR\DC4historyArchivalState\DC20\n\
    \\DC4history_archival_uri\CAN\EOT \SOH(\tR\DC2historyArchivalUri\DC2`\n\
    \\EMvisibility_archival_state\CAN\ENQ \SOH(\SO2$.temporal.api.enums.v1.ArchivalStateR\ETBvisibilityArchivalState\DC26\n\
    \\ETBvisibility_archival_uri\CAN\ACK \SOH(\tR\NAKvisibilityArchivalUri\DC2\147\SOH\n\
    \\UScustom_search_attribute_aliases\CAN\a \ETX(\v2L.temporal.api.namespace.v1.NamespaceConfig.CustomSearchAttributeAliasesEntryR\FScustomSearchAttributeAliases\SUBO\n\
    \!CustomSearchAttributeAliasesEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\"\198\SOH\n\
    \\vBadBinaries\DC2P\n\
    \\bbinaries\CAN\SOH \ETX(\v24.temporal.api.namespace.v1.BadBinaries.BinariesEntryR\bbinaries\SUBe\n\
    \\rBinariesEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2>\n\
    \\ENQvalue\CAN\STX \SOH(\v2(.temporal.api.namespace.v1.BadBinaryInfoR\ENQvalue:\STX8\SOH\"\128\SOH\n\
    \\rBadBinaryInfo\DC2\SYN\n\
    \\ACKreason\CAN\SOH \SOH(\tR\ACKreason\DC2\SUB\n\
    \\boperator\CAN\STX \SOH(\tR\boperator\DC2;\n\
    \\vcreate_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \createTime\"\156\STX\n\
    \\DC3UpdateNamespaceInfo\DC2 \n\
    \\vdescription\CAN\SOH \SOH(\tR\vdescription\DC2\US\n\
    \\vowner_email\CAN\STX \SOH(\tR\n\
    \ownerEmail\DC2L\n\
    \\EOTdata\CAN\ETX \ETX(\v28.temporal.api.namespace.v1.UpdateNamespaceInfo.DataEntryR\EOTdata\DC2;\n\
    \\ENQstate\CAN\EOT \SOH(\SO2%.temporal.api.enums.v1.NamespaceStateR\ENQstate\SUB7\n\
    \\tDataEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\":\n\
    \\SINamespaceFilter\DC2'\n\
    \\SIinclude_deleted\CAN\SOH \SOH(\bR\SOincludeDeletedB\152\SOH\n\
    \\FSio.temporal.api.namespace.v1B\fMessageProtoP\SOHZ)go.temporal.io/api/namespace/v1;namespace\170\STX\ESCTemporalio.Api.Namespace.V1\234\STX\RSTemporalio::Api::Namespace::V1J\231\GS\n\
    \\ACK\DC2\EOT\SYN\NUL`\SOH\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL@\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL@\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL5\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL5\n\
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
    \\SOH\b\DC2\ETX\RS\NUL7\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL7\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL8\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL8\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL(\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\"\NUL)\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX$\NUL/\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT'\NUL3\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX'\b\NAK\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX(\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX(\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX(\v\SI\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX(\DC2\DC3\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX)\EOT3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX)\EOT(\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX)).\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX)12\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX*\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX*\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX*\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX*\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX+\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ENQ\DC2\ETX+\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX+\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX+\EM\SUB\n\
    \:\n\
    \\EOT\EOT\NUL\STX\EOT\DC2\ETX-\EOT!\SUB- A key-value map for any customized purpose.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ACK\DC2\ETX-\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\SOH\DC2\ETX-\CAN\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ETX\DC2\ETX-\US \n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ENQ\DC2\ETX.\EOT\DC2\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ENQ\DC2\ETX.\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\SOH\DC2\ETX.\v\r\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ETX\DC2\ETX.\DLE\DC1\n\
    \\174\SOH\n\
    \\EOT\EOT\NUL\STX\ACK\DC2\ETX2\EOT\"\SUB\160\SOH Whether scheduled workflows are supported on this namespace. This is only needed\n\
    \ temporarily while the feature is experimental, so we can give it a high tag.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ENQ\DC2\ETX2\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\SOH\DC2\ETX2\t\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ETX\DC2\ETX2\RS!\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT5\NUL@\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX5\b\ETB\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX6\EOTB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX6\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX6\GS=\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX6@A\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX7\EOT!\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX7\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX7\DLE\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX7\US \n\
    \e\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX9\EOTC\SUBX If unspecified (ARCHIVAL_STATE_UNSPECIFIED) then default server configuration is used.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ACK\DC2\ETX9\EOT'\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX9(>\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX9AB\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX:\EOT$\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ENQ\DC2\ETX:\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX:\v\US\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX:\"#\n\
    \e\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\ETX<\EOTF\SUBX If unspecified (ARCHIVAL_STATE_UNSPECIFIED) then default server configuration is used.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ACK\DC2\ETX<\EOT'\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\ETX<(A\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\ETX<DE\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\ENQ\DC2\ETX=\EOT'\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ENQ\DC2\ETX=\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\SOH\DC2\ETX=\v\"\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ETX\DC2\ETX=%&\n\
    \,\n\
    \\EOT\EOT\SOH\STX\ACK\DC2\ETX?\EOT<\SUB\US Map from field name to alias.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ACK\DC2\ETX?\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\SOH\DC2\ETX?\CAN7\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ETX\DC2\ETX?:;\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOTB\NULD\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETXB\b\DC3\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETXC\EOT,\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETXC\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETXC\US'\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETXC*+\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOTF\NULJ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXF\b\NAK\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXG\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETXG\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXG\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXG\DC4\NAK\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXH\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETXH\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXH\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXH\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETXI\EOT.\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ACK\DC2\ETXI\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETXI\RS)\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETXI,-\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOTL\NULY\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXL\b\ESC\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXM\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETXM\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXM\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXM\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\ETXN\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ENQ\DC2\ETXN\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\ETXN\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\ETXN\EM\SUB\n\
    \\150\SOH\n\
    \\EOT\EOT\EOT\STX\STX\DC2\ETXR\EOT!\SUB\136\SOH A key-value map for any customized purpose.\n\
    \ If data already exists on the namespace, \n\
    \ this will merge with the existing key values. \n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ACK\DC2\ETXR\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\SOH\DC2\ETXR\CAN\FS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ETX\DC2\ETXR\US \n\
    \\134\STX\n\
    \\EOT\EOT\EOT\STX\ETX\DC2\ETXX\EOT3\SUB\248\SOH New namespace state, server will reject if transition is not allowed.\n\
    \ Allowed transitions are:\n\
    \  Registered -> [ Deleted | Deprecated | Handover ]\n\
    \  Handover -> [ Registered ]\n\
    \ Default is NAMESPACE_STATE_UNSPECIFIED which is do not change state.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ACK\DC2\ETXX\EOT(\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\SOH\DC2\ETXX).\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ETX\DC2\ETXX12\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOT[\NUL`\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX[\b\ETB\n\
    \\155\STX\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX_\EOT\GS\SUB\141\STX By default namespaces in NAMESPACE_STATE_DELETED state are not included.\n\
    \ Setting include_deleted to true will include deleted namespaces.\n\
    \ Note: Namespace is in NAMESPACE_STATE_DELETED state when it was deleted from the system but associated data is not deleted yet.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\ETX_\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX_\t\CAN\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX_\ESC\FSb\ACKproto3"
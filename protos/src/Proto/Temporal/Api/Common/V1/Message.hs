{- This file was auto-generated from temporal/api/common/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Common.V1.Message (
        ActivityType(), Callback(), Callback'Variant(..), _Callback'Nexus',
        _Callback'Internal', Callback'Internal(), Callback'Nexus(),
        Callback'Nexus'HeaderEntry(), DataBlob(), Header(),
        Header'FieldsEntry(), Link(), Link'Variant(..),
        _Link'WorkflowEvent', _Link'BatchJob', Link'BatchJob(),
        Link'WorkflowEvent(), Link'WorkflowEvent'Reference(..),
        _Link'WorkflowEvent'EventRef, Link'WorkflowEvent'EventReference(),
        Memo(), Memo'FieldsEntry(), MeteringMetadata(), Payload(),
        Payload'MetadataEntry(), Payloads(), Priority(), ResetOptions(),
        ResetOptions'Target(..), _ResetOptions'FirstWorkflowTask,
        _ResetOptions'LastWorkflowTask, _ResetOptions'WorkflowTaskId,
        _ResetOptions'BuildId, RetryPolicy(), SearchAttributes(),
        SearchAttributes'IndexedFieldsEntry(), WorkerVersionCapabilities(),
        WorkerVersionStamp(), WorkflowExecution(), WorkflowType()
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
import qualified Proto.Google.Protobuf.Empty
import qualified Proto.Temporal.Api.Enums.V1.Common
import qualified Proto.Temporal.Api.Enums.V1.EventType
import qualified Proto.Temporal.Api.Enums.V1.Reset
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
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'variant' @:: Lens' Callback (Prelude.Maybe Callback'Variant)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'nexus' @:: Lens' Callback (Prelude.Maybe Callback'Nexus)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.nexus' @:: Lens' Callback Callback'Nexus@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'internal' @:: Lens' Callback (Prelude.Maybe Callback'Internal)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.internal' @:: Lens' Callback Callback'Internal@ -}
data Callback
  = Callback'_constructor {_Callback'variant :: !(Prelude.Maybe Callback'Variant),
                           _Callback'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Callback where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Callback'Variant
  = Callback'Nexus' !Callback'Nexus |
    Callback'Internal' !Callback'Internal
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Callback "maybe'variant" (Prelude.Maybe Callback'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'variant (\ x__ y__ -> x__ {_Callback'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Callback "maybe'nexus" (Prelude.Maybe Callback'Nexus) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'variant (\ x__ y__ -> x__ {_Callback'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Callback'Nexus' x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Callback'Nexus' y__))
instance Data.ProtoLens.Field.HasField Callback "nexus" Callback'Nexus where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'variant (\ x__ y__ -> x__ {_Callback'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Callback'Nexus' x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Callback'Nexus' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Callback "maybe'internal" (Prelude.Maybe Callback'Internal) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'variant (\ x__ y__ -> x__ {_Callback'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Callback'Internal' x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Callback'Internal' y__))
instance Data.ProtoLens.Field.HasField Callback "internal" Callback'Internal where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'variant (\ x__ y__ -> x__ {_Callback'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Callback'Internal' x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Callback'Internal' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message Callback where
  messageName _ = Data.Text.pack "temporal.api.common.v1.Callback"
  packedMessageDescriptor _
    = "\n\
      \\bCallback\DC2>\n\
      \\ENQnexus\CAN\STX \SOH(\v2&.temporal.api.common.v1.Callback.NexusH\NULR\ENQnexus\DC2G\n\
      \\binternal\CAN\ETX \SOH(\v2).temporal.api.common.v1.Callback.InternalH\NULR\binternal\SUB\160\SOH\n\
      \\ENQNexus\DC2\DLE\n\
      \\ETXurl\CAN\SOH \SOH(\tR\ETXurl\DC2J\n\
      \\ACKheader\CAN\STX \ETX(\v22.temporal.api.common.v1.Callback.Nexus.HeaderEntryR\ACKheader\SUB9\n\
      \\vHeaderEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\SUB\RS\n\
      \\bInternal\DC2\DC2\n\
      \\EOTdata\CAN\SOH \SOH(\fR\EOTdataB\t\n\
      \\avariantJ\EOT\b\SOH\DLE\STX"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        nexus__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "nexus"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Callback'Nexus)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'nexus")) ::
              Data.ProtoLens.FieldDescriptor Callback
        internal__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "internal"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Callback'Internal)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'internal")) ::
              Data.ProtoLens.FieldDescriptor Callback
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 2, nexus__field_descriptor),
           (Data.ProtoLens.Tag 3, internal__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Callback'_unknownFields
        (\ x__ y__ -> x__ {_Callback'_unknownFields = y__})
  defMessage
    = Callback'_constructor
        {_Callback'variant = Prelude.Nothing,
         _Callback'_unknownFields = []}
  parseMessage
    = let
        loop :: Callback -> Data.ProtoLens.Encoding.Bytes.Parser Callback
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
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "nexus"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"nexus") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "internal"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"internal") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Callback"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (Callback'Nexus' v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (Callback'Internal' v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData Callback where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Callback'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Callback'variant x__) ())
instance Control.DeepSeq.NFData Callback'Variant where
  rnf (Callback'Nexus' x__) = Control.DeepSeq.rnf x__
  rnf (Callback'Internal' x__) = Control.DeepSeq.rnf x__
_Callback'Nexus' ::
  Data.ProtoLens.Prism.Prism' Callback'Variant Callback'Nexus
_Callback'Nexus'
  = Data.ProtoLens.Prism.prism'
      Callback'Nexus'
      (\ p__
         -> case p__ of
              (Callback'Nexus' p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Callback'Internal' ::
  Data.ProtoLens.Prism.Prism' Callback'Variant Callback'Internal
_Callback'Internal'
  = Data.ProtoLens.Prism.prism'
      Callback'Internal'
      (\ p__
         -> case p__ of
              (Callback'Internal' p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.data'' @:: Lens' Callback'Internal Data.ByteString.ByteString@ -}
data Callback'Internal
  = Callback'Internal'_constructor {_Callback'Internal'data' :: !Data.ByteString.ByteString,
                                    _Callback'Internal'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Callback'Internal where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Callback'Internal "data'" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'Internal'data'
           (\ x__ y__ -> x__ {_Callback'Internal'data' = y__}))
        Prelude.id
instance Data.ProtoLens.Message Callback'Internal where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.Callback.Internal"
  packedMessageDescriptor _
    = "\n\
      \\bInternal\DC2\DC2\n\
      \\EOTdata\CAN\SOH \SOH(\fR\EOTdata"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        data'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "data"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"data'")) ::
              Data.ProtoLens.FieldDescriptor Callback'Internal
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, data'__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Callback'Internal'_unknownFields
        (\ x__ y__ -> x__ {_Callback'Internal'_unknownFields = y__})
  defMessage
    = Callback'Internal'_constructor
        {_Callback'Internal'data' = Data.ProtoLens.fieldDefault,
         _Callback'Internal'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Callback'Internal
          -> Data.ProtoLens.Encoding.Bytes.Parser Callback'Internal
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
          (do loop Data.ProtoLens.defMessage) "Internal"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"data'") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData Callback'Internal where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Callback'Internal'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Callback'Internal'data' x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.url' @:: Lens' Callback'Nexus Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.header' @:: Lens' Callback'Nexus (Data.Map.Map Data.Text.Text Data.Text.Text)@ -}
data Callback'Nexus
  = Callback'Nexus'_constructor {_Callback'Nexus'url :: !Data.Text.Text,
                                 _Callback'Nexus'header :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                                 _Callback'Nexus'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Callback'Nexus where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Callback'Nexus "url" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'Nexus'url (\ x__ y__ -> x__ {_Callback'Nexus'url = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Callback'Nexus "header" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'Nexus'header
           (\ x__ y__ -> x__ {_Callback'Nexus'header = y__}))
        Prelude.id
instance Data.ProtoLens.Message Callback'Nexus where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.Callback.Nexus"
  packedMessageDescriptor _
    = "\n\
      \\ENQNexus\DC2\DLE\n\
      \\ETXurl\CAN\SOH \SOH(\tR\ETXurl\DC2J\n\
      \\ACKheader\CAN\STX \ETX(\v22.temporal.api.common.v1.Callback.Nexus.HeaderEntryR\ACKheader\SUB9\n\
      \\vHeaderEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        url__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "url"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"url")) ::
              Data.ProtoLens.FieldDescriptor Callback'Nexus
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Callback'Nexus'HeaderEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"header")) ::
              Data.ProtoLens.FieldDescriptor Callback'Nexus
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, url__field_descriptor),
           (Data.ProtoLens.Tag 2, header__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Callback'Nexus'_unknownFields
        (\ x__ y__ -> x__ {_Callback'Nexus'_unknownFields = y__})
  defMessage
    = Callback'Nexus'_constructor
        {_Callback'Nexus'url = Data.ProtoLens.fieldDefault,
         _Callback'Nexus'header = Data.Map.empty,
         _Callback'Nexus'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Callback'Nexus
          -> Data.ProtoLens.Encoding.Bytes.Parser Callback'Nexus
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
                                       "url"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"url") y x)
                        18
                          -> do !(entry :: Callback'Nexus'HeaderEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                            (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                Data.ProtoLens.Encoding.Bytes.isolate
                                                                                  (Prelude.fromIntegral
                                                                                     len)
                                                                                  Data.ProtoLens.parseMessage)
                                                                            "header"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"header")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Nexus"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"url") _x
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
                                       (Data.ProtoLens.defMessage :: Callback'Nexus'HeaderEntry)))))
                      (Data.Map.toList
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"header") _x))))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Callback'Nexus where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Callback'Nexus'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Callback'Nexus'url x__)
                (Control.DeepSeq.deepseq (_Callback'Nexus'header x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.key' @:: Lens' Callback'Nexus'HeaderEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.value' @:: Lens' Callback'Nexus'HeaderEntry Data.Text.Text@ -}
data Callback'Nexus'HeaderEntry
  = Callback'Nexus'HeaderEntry'_constructor {_Callback'Nexus'HeaderEntry'key :: !Data.Text.Text,
                                             _Callback'Nexus'HeaderEntry'value :: !Data.Text.Text,
                                             _Callback'Nexus'HeaderEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Callback'Nexus'HeaderEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Callback'Nexus'HeaderEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'Nexus'HeaderEntry'key
           (\ x__ y__ -> x__ {_Callback'Nexus'HeaderEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Callback'Nexus'HeaderEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Callback'Nexus'HeaderEntry'value
           (\ x__ y__ -> x__ {_Callback'Nexus'HeaderEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message Callback'Nexus'HeaderEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.common.v1.Callback.Nexus.HeaderEntry"
  packedMessageDescriptor _
    = "\n\
      \\vHeaderEntry\DC2\DLE\n\
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
              Data.ProtoLens.FieldDescriptor Callback'Nexus'HeaderEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor Callback'Nexus'HeaderEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Callback'Nexus'HeaderEntry'_unknownFields
        (\ x__ y__
           -> x__ {_Callback'Nexus'HeaderEntry'_unknownFields = y__})
  defMessage
    = Callback'Nexus'HeaderEntry'_constructor
        {_Callback'Nexus'HeaderEntry'key = Data.ProtoLens.fieldDefault,
         _Callback'Nexus'HeaderEntry'value = Data.ProtoLens.fieldDefault,
         _Callback'Nexus'HeaderEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Callback'Nexus'HeaderEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser Callback'Nexus'HeaderEntry
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
          (do loop Data.ProtoLens.defMessage) "HeaderEntry"
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
instance Control.DeepSeq.NFData Callback'Nexus'HeaderEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Callback'Nexus'HeaderEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Callback'Nexus'HeaderEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_Callback'Nexus'HeaderEntry'value x__) ()))
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
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'variant' @:: Lens' Link (Prelude.Maybe Link'Variant)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'workflowEvent' @:: Lens' Link (Prelude.Maybe Link'WorkflowEvent)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.workflowEvent' @:: Lens' Link Link'WorkflowEvent@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'batchJob' @:: Lens' Link (Prelude.Maybe Link'BatchJob)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.batchJob' @:: Lens' Link Link'BatchJob@ -}
data Link
  = Link'_constructor {_Link'variant :: !(Prelude.Maybe Link'Variant),
                       _Link'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Link where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Link'Variant
  = Link'WorkflowEvent' !Link'WorkflowEvent |
    Link'BatchJob' !Link'BatchJob
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Link "maybe'variant" (Prelude.Maybe Link'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'variant (\ x__ y__ -> x__ {_Link'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Link "maybe'workflowEvent" (Prelude.Maybe Link'WorkflowEvent) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'variant (\ x__ y__ -> x__ {_Link'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Link'WorkflowEvent' x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Link'WorkflowEvent' y__))
instance Data.ProtoLens.Field.HasField Link "workflowEvent" Link'WorkflowEvent where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'variant (\ x__ y__ -> x__ {_Link'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Link'WorkflowEvent' x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Link'WorkflowEvent' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Link "maybe'batchJob" (Prelude.Maybe Link'BatchJob) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'variant (\ x__ y__ -> x__ {_Link'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Link'BatchJob' x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Link'BatchJob' y__))
instance Data.ProtoLens.Field.HasField Link "batchJob" Link'BatchJob where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'variant (\ x__ y__ -> x__ {_Link'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Link'BatchJob' x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Link'BatchJob' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message Link where
  messageName _ = Data.Text.pack "temporal.api.common.v1.Link"
  packedMessageDescriptor _
    = "\n\
      \\EOTLink\DC2S\n\
      \\SOworkflow_event\CAN\SOH \SOH(\v2*.temporal.api.common.v1.Link.WorkflowEventH\NULR\rworkflowEvent\DC2D\n\
      \\tbatch_job\CAN\STX \SOH(\v2%.temporal.api.common.v1.Link.BatchJobH\NULR\bbatchJob\SUB\186\STX\n\
      \\rWorkflowEvent\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
      \\vworkflow_id\CAN\STX \SOH(\tR\n\
      \workflowId\DC2\NAK\n\
      \\ACKrun_id\CAN\ETX \SOH(\tR\ENQrunId\DC2X\n\
      \\tevent_ref\CANd \SOH(\v29.temporal.api.common.v1.Link.WorkflowEvent.EventReferenceH\NULR\beventRef\SUBl\n\
      \\SOEventReference\DC2\EM\n\
      \\bevent_id\CAN\SOH \SOH(\ETXR\aeventId\DC2?\n\
      \\n\
      \event_type\CAN\STX \SOH(\SO2 .temporal.api.enums.v1.EventTypeR\teventTypeB\v\n\
      \\treference\SUB!\n\
      \\bBatchJob\DC2\NAK\n\
      \\ACKjob_id\CAN\SOH \SOH(\tR\ENQjobIdB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowEvent__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_event"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Link'WorkflowEvent)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowEvent")) ::
              Data.ProtoLens.FieldDescriptor Link
        batchJob__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "batch_job"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Link'BatchJob)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'batchJob")) ::
              Data.ProtoLens.FieldDescriptor Link
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowEvent__field_descriptor),
           (Data.ProtoLens.Tag 2, batchJob__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Link'_unknownFields
        (\ x__ y__ -> x__ {_Link'_unknownFields = y__})
  defMessage
    = Link'_constructor
        {_Link'variant = Prelude.Nothing, _Link'_unknownFields = []}
  parseMessage
    = let
        loop :: Link -> Data.ProtoLens.Encoding.Bytes.Parser Link
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
                                       "workflow_event"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowEvent") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "batch_job"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"batchJob") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Link"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (Link'WorkflowEvent' v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (Link'BatchJob' v))
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
instance Control.DeepSeq.NFData Link where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Link'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Link'variant x__) ())
instance Control.DeepSeq.NFData Link'Variant where
  rnf (Link'WorkflowEvent' x__) = Control.DeepSeq.rnf x__
  rnf (Link'BatchJob' x__) = Control.DeepSeq.rnf x__
_Link'WorkflowEvent' ::
  Data.ProtoLens.Prism.Prism' Link'Variant Link'WorkflowEvent
_Link'WorkflowEvent'
  = Data.ProtoLens.Prism.prism'
      Link'WorkflowEvent'
      (\ p__
         -> case p__ of
              (Link'WorkflowEvent' p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Link'BatchJob' ::
  Data.ProtoLens.Prism.Prism' Link'Variant Link'BatchJob
_Link'BatchJob'
  = Data.ProtoLens.Prism.prism'
      Link'BatchJob'
      (\ p__
         -> case p__ of
              (Link'BatchJob' p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.jobId' @:: Lens' Link'BatchJob Data.Text.Text@ -}
data Link'BatchJob
  = Link'BatchJob'_constructor {_Link'BatchJob'jobId :: !Data.Text.Text,
                                _Link'BatchJob'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Link'BatchJob where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Link'BatchJob "jobId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'BatchJob'jobId
           (\ x__ y__ -> x__ {_Link'BatchJob'jobId = y__}))
        Prelude.id
instance Data.ProtoLens.Message Link'BatchJob where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.Link.BatchJob"
  packedMessageDescriptor _
    = "\n\
      \\bBatchJob\DC2\NAK\n\
      \\ACKjob_id\CAN\SOH \SOH(\tR\ENQjobId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        jobId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "job_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"jobId")) ::
              Data.ProtoLens.FieldDescriptor Link'BatchJob
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, jobId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Link'BatchJob'_unknownFields
        (\ x__ y__ -> x__ {_Link'BatchJob'_unknownFields = y__})
  defMessage
    = Link'BatchJob'_constructor
        {_Link'BatchJob'jobId = Data.ProtoLens.fieldDefault,
         _Link'BatchJob'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Link'BatchJob -> Data.ProtoLens.Encoding.Bytes.Parser Link'BatchJob
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
                                       "job_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"jobId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BatchJob"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"jobId") _x
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
instance Control.DeepSeq.NFData Link'BatchJob where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Link'BatchJob'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Link'BatchJob'jobId x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.namespace' @:: Lens' Link'WorkflowEvent Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.workflowId' @:: Lens' Link'WorkflowEvent Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.runId' @:: Lens' Link'WorkflowEvent Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'reference' @:: Lens' Link'WorkflowEvent (Prelude.Maybe Link'WorkflowEvent'Reference)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'eventRef' @:: Lens' Link'WorkflowEvent (Prelude.Maybe Link'WorkflowEvent'EventReference)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.eventRef' @:: Lens' Link'WorkflowEvent Link'WorkflowEvent'EventReference@ -}
data Link'WorkflowEvent
  = Link'WorkflowEvent'_constructor {_Link'WorkflowEvent'namespace :: !Data.Text.Text,
                                     _Link'WorkflowEvent'workflowId :: !Data.Text.Text,
                                     _Link'WorkflowEvent'runId :: !Data.Text.Text,
                                     _Link'WorkflowEvent'reference :: !(Prelude.Maybe Link'WorkflowEvent'Reference),
                                     _Link'WorkflowEvent'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Link'WorkflowEvent where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Link'WorkflowEvent'Reference
  = Link'WorkflowEvent'EventRef !Link'WorkflowEvent'EventReference
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'namespace
           (\ x__ y__ -> x__ {_Link'WorkflowEvent'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'workflowId
           (\ x__ y__ -> x__ {_Link'WorkflowEvent'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'runId
           (\ x__ y__ -> x__ {_Link'WorkflowEvent'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent "maybe'reference" (Prelude.Maybe Link'WorkflowEvent'Reference) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'reference
           (\ x__ y__ -> x__ {_Link'WorkflowEvent'reference = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent "maybe'eventRef" (Prelude.Maybe Link'WorkflowEvent'EventReference) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'reference
           (\ x__ y__ -> x__ {_Link'WorkflowEvent'reference = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Link'WorkflowEvent'EventRef x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Link'WorkflowEvent'EventRef y__))
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent "eventRef" Link'WorkflowEvent'EventReference where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'reference
           (\ x__ y__ -> x__ {_Link'WorkflowEvent'reference = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Link'WorkflowEvent'EventRef x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Link'WorkflowEvent'EventRef y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message Link'WorkflowEvent where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.Link.WorkflowEvent"
  packedMessageDescriptor _
    = "\n\
      \\rWorkflowEvent\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
      \\vworkflow_id\CAN\STX \SOH(\tR\n\
      \workflowId\DC2\NAK\n\
      \\ACKrun_id\CAN\ETX \SOH(\tR\ENQrunId\DC2X\n\
      \\tevent_ref\CANd \SOH(\v29.temporal.api.common.v1.Link.WorkflowEvent.EventReferenceH\NULR\beventRef\SUBl\n\
      \\SOEventReference\DC2\EM\n\
      \\bevent_id\CAN\SOH \SOH(\ETXR\aeventId\DC2?\n\
      \\n\
      \event_type\CAN\STX \SOH(\SO2 .temporal.api.enums.v1.EventTypeR\teventTypeB\v\n\
      \\treference"
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
              Data.ProtoLens.FieldDescriptor Link'WorkflowEvent
        workflowId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowId")) ::
              Data.ProtoLens.FieldDescriptor Link'WorkflowEvent
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor Link'WorkflowEvent
        eventRef__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "event_ref"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Link'WorkflowEvent'EventReference)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'eventRef")) ::
              Data.ProtoLens.FieldDescriptor Link'WorkflowEvent
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 3, runId__field_descriptor),
           (Data.ProtoLens.Tag 100, eventRef__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Link'WorkflowEvent'_unknownFields
        (\ x__ y__ -> x__ {_Link'WorkflowEvent'_unknownFields = y__})
  defMessage
    = Link'WorkflowEvent'_constructor
        {_Link'WorkflowEvent'namespace = Data.ProtoLens.fieldDefault,
         _Link'WorkflowEvent'workflowId = Data.ProtoLens.fieldDefault,
         _Link'WorkflowEvent'runId = Data.ProtoLens.fieldDefault,
         _Link'WorkflowEvent'reference = Prelude.Nothing,
         _Link'WorkflowEvent'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Link'WorkflowEvent
          -> Data.ProtoLens.Encoding.Bytes.Parser Link'WorkflowEvent
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
                        802
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "event_ref"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"eventRef") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowEvent"
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
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'reference") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just (Link'WorkflowEvent'EventRef v))
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 802)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData Link'WorkflowEvent where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Link'WorkflowEvent'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Link'WorkflowEvent'namespace x__)
                (Control.DeepSeq.deepseq
                   (_Link'WorkflowEvent'workflowId x__)
                   (Control.DeepSeq.deepseq
                      (_Link'WorkflowEvent'runId x__)
                      (Control.DeepSeq.deepseq (_Link'WorkflowEvent'reference x__) ()))))
instance Control.DeepSeq.NFData Link'WorkflowEvent'Reference where
  rnf (Link'WorkflowEvent'EventRef x__) = Control.DeepSeq.rnf x__
_Link'WorkflowEvent'EventRef ::
  Data.ProtoLens.Prism.Prism' Link'WorkflowEvent'Reference Link'WorkflowEvent'EventReference
_Link'WorkflowEvent'EventRef
  = Data.ProtoLens.Prism.prism'
      Link'WorkflowEvent'EventRef
      (\ p__
         -> case p__ of
              (Link'WorkflowEvent'EventRef p__val) -> Prelude.Just p__val)
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.eventId' @:: Lens' Link'WorkflowEvent'EventReference Data.Int.Int64@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.eventType' @:: Lens' Link'WorkflowEvent'EventReference Proto.Temporal.Api.Enums.V1.EventType.EventType@ -}
data Link'WorkflowEvent'EventReference
  = Link'WorkflowEvent'EventReference'_constructor {_Link'WorkflowEvent'EventReference'eventId :: !Data.Int.Int64,
                                                    _Link'WorkflowEvent'EventReference'eventType :: !Proto.Temporal.Api.Enums.V1.EventType.EventType,
                                                    _Link'WorkflowEvent'EventReference'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Link'WorkflowEvent'EventReference where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent'EventReference "eventId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'EventReference'eventId
           (\ x__ y__
              -> x__ {_Link'WorkflowEvent'EventReference'eventId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Link'WorkflowEvent'EventReference "eventType" Proto.Temporal.Api.Enums.V1.EventType.EventType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Link'WorkflowEvent'EventReference'eventType
           (\ x__ y__
              -> x__ {_Link'WorkflowEvent'EventReference'eventType = y__}))
        Prelude.id
instance Data.ProtoLens.Message Link'WorkflowEvent'EventReference where
  messageName _
    = Data.Text.pack
        "temporal.api.common.v1.Link.WorkflowEvent.EventReference"
  packedMessageDescriptor _
    = "\n\
      \\SOEventReference\DC2\EM\n\
      \\bevent_id\CAN\SOH \SOH(\ETXR\aeventId\DC2?\n\
      \\n\
      \event_type\CAN\STX \SOH(\SO2 .temporal.api.enums.v1.EventTypeR\teventType"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        eventId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "event_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"eventId")) ::
              Data.ProtoLens.FieldDescriptor Link'WorkflowEvent'EventReference
        eventType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "event_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.EventType.EventType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"eventType")) ::
              Data.ProtoLens.FieldDescriptor Link'WorkflowEvent'EventReference
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, eventId__field_descriptor),
           (Data.ProtoLens.Tag 2, eventType__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Link'WorkflowEvent'EventReference'_unknownFields
        (\ x__ y__
           -> x__ {_Link'WorkflowEvent'EventReference'_unknownFields = y__})
  defMessage
    = Link'WorkflowEvent'EventReference'_constructor
        {_Link'WorkflowEvent'EventReference'eventId = Data.ProtoLens.fieldDefault,
         _Link'WorkflowEvent'EventReference'eventType = Data.ProtoLens.fieldDefault,
         _Link'WorkflowEvent'EventReference'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Link'WorkflowEvent'EventReference
          -> Data.ProtoLens.Encoding.Bytes.Parser Link'WorkflowEvent'EventReference
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
                                       "event_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"eventId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "event_type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"eventType") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "EventReference"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"eventId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"eventType") _x
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
instance Control.DeepSeq.NFData Link'WorkflowEvent'EventReference where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Link'WorkflowEvent'EventReference'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Link'WorkflowEvent'EventReference'eventId x__)
                (Control.DeepSeq.deepseq
                   (_Link'WorkflowEvent'EventReference'eventType x__) ()))
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
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.priorityKey' @:: Lens' Priority Data.Int.Int32@ -}
data Priority
  = Priority'_constructor {_Priority'priorityKey :: !Data.Int.Int32,
                           _Priority'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Priority where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Priority "priorityKey" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Priority'priorityKey
           (\ x__ y__ -> x__ {_Priority'priorityKey = y__}))
        Prelude.id
instance Data.ProtoLens.Message Priority where
  messageName _ = Data.Text.pack "temporal.api.common.v1.Priority"
  packedMessageDescriptor _
    = "\n\
      \\bPriority\DC2!\n\
      \\fpriority_key\CAN\SOH \SOH(\ENQR\vpriorityKey"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        priorityKey__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "priority_key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"priorityKey")) ::
              Data.ProtoLens.FieldDescriptor Priority
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, priorityKey__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Priority'_unknownFields
        (\ x__ y__ -> x__ {_Priority'_unknownFields = y__})
  defMessage
    = Priority'_constructor
        {_Priority'priorityKey = Data.ProtoLens.fieldDefault,
         _Priority'_unknownFields = []}
  parseMessage
    = let
        loop :: Priority -> Data.ProtoLens.Encoding.Bytes.Parser Priority
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
                                       "priority_key"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"priorityKey") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Priority"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"priorityKey") _x
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
instance Control.DeepSeq.NFData Priority where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Priority'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Priority'priorityKey x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.resetReapplyType' @:: Lens' ResetOptions Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.currentRunOnly' @:: Lens' ResetOptions Prelude.Bool@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.resetReapplyExcludeTypes' @:: Lens' ResetOptions [Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyExcludeType]@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.vec'resetReapplyExcludeTypes' @:: Lens' ResetOptions (Data.Vector.Vector Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyExcludeType)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'target' @:: Lens' ResetOptions (Prelude.Maybe ResetOptions'Target)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'firstWorkflowTask' @:: Lens' ResetOptions (Prelude.Maybe Proto.Google.Protobuf.Empty.Empty)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.firstWorkflowTask' @:: Lens' ResetOptions Proto.Google.Protobuf.Empty.Empty@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'lastWorkflowTask' @:: Lens' ResetOptions (Prelude.Maybe Proto.Google.Protobuf.Empty.Empty)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.lastWorkflowTask' @:: Lens' ResetOptions Proto.Google.Protobuf.Empty.Empty@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'workflowTaskId' @:: Lens' ResetOptions (Prelude.Maybe Data.Int.Int64)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.workflowTaskId' @:: Lens' ResetOptions Data.Int.Int64@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.maybe'buildId' @:: Lens' ResetOptions (Prelude.Maybe Data.Text.Text)@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.buildId' @:: Lens' ResetOptions Data.Text.Text@ -}
data ResetOptions
  = ResetOptions'_constructor {_ResetOptions'resetReapplyType :: !Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType,
                               _ResetOptions'currentRunOnly :: !Prelude.Bool,
                               _ResetOptions'resetReapplyExcludeTypes :: !(Data.Vector.Vector Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyExcludeType),
                               _ResetOptions'target :: !(Prelude.Maybe ResetOptions'Target),
                               _ResetOptions'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResetOptions where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data ResetOptions'Target
  = ResetOptions'FirstWorkflowTask !Proto.Google.Protobuf.Empty.Empty |
    ResetOptions'LastWorkflowTask !Proto.Google.Protobuf.Empty.Empty |
    ResetOptions'WorkflowTaskId !Data.Int.Int64 |
    ResetOptions'BuildId !Data.Text.Text
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField ResetOptions "resetReapplyType" Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'resetReapplyType
           (\ x__ y__ -> x__ {_ResetOptions'resetReapplyType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetOptions "currentRunOnly" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'currentRunOnly
           (\ x__ y__ -> x__ {_ResetOptions'currentRunOnly = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetOptions "resetReapplyExcludeTypes" [Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyExcludeType] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'resetReapplyExcludeTypes
           (\ x__ y__ -> x__ {_ResetOptions'resetReapplyExcludeTypes = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ResetOptions "vec'resetReapplyExcludeTypes" (Data.Vector.Vector Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyExcludeType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'resetReapplyExcludeTypes
           (\ x__ y__ -> x__ {_ResetOptions'resetReapplyExcludeTypes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetOptions "maybe'target" (Prelude.Maybe ResetOptions'Target) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetOptions "maybe'firstWorkflowTask" (Prelude.Maybe Proto.Google.Protobuf.Empty.Empty) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ResetOptions'FirstWorkflowTask x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap ResetOptions'FirstWorkflowTask y__))
instance Data.ProtoLens.Field.HasField ResetOptions "firstWorkflowTask" Proto.Google.Protobuf.Empty.Empty where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ResetOptions'FirstWorkflowTask x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap ResetOptions'FirstWorkflowTask y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField ResetOptions "maybe'lastWorkflowTask" (Prelude.Maybe Proto.Google.Protobuf.Empty.Empty) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ResetOptions'LastWorkflowTask x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap ResetOptions'LastWorkflowTask y__))
instance Data.ProtoLens.Field.HasField ResetOptions "lastWorkflowTask" Proto.Google.Protobuf.Empty.Empty where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ResetOptions'LastWorkflowTask x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap ResetOptions'LastWorkflowTask y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField ResetOptions "maybe'workflowTaskId" (Prelude.Maybe Data.Int.Int64) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ResetOptions'WorkflowTaskId x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap ResetOptions'WorkflowTaskId y__))
instance Data.ProtoLens.Field.HasField ResetOptions "workflowTaskId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ResetOptions'WorkflowTaskId x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap ResetOptions'WorkflowTaskId y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Field.HasField ResetOptions "maybe'buildId" (Prelude.Maybe Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ResetOptions'BuildId x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap ResetOptions'BuildId y__))
instance Data.ProtoLens.Field.HasField ResetOptions "buildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetOptions'target
           (\ x__ y__ -> x__ {_ResetOptions'target = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ResetOptions'BuildId x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap ResetOptions'BuildId y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Message ResetOptions where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.ResetOptions"
  packedMessageDescriptor _
    = "\n\
      \\fResetOptions\DC2H\n\
      \\DC3first_workflow_task\CAN\SOH \SOH(\v2\SYN.google.protobuf.EmptyH\NULR\DC1firstWorkflowTask\DC2F\n\
      \\DC2last_workflow_task\CAN\STX \SOH(\v2\SYN.google.protobuf.EmptyH\NULR\DLElastWorkflowTask\DC2*\n\
      \\DLEworkflow_task_id\CAN\ETX \SOH(\ETXH\NULR\SOworkflowTaskId\DC2\ESC\n\
      \\bbuild_id\CAN\EOT \SOH(\tH\NULR\abuildId\DC2U\n\
      \\DC2reset_reapply_type\CAN\n\
      \ \SOH(\SO2'.temporal.api.enums.v1.ResetReapplyTypeR\DLEresetReapplyType\DC2(\n\
      \\DLEcurrent_run_only\CAN\v \SOH(\bR\SOcurrentRunOnly\DC2m\n\
      \\ESCreset_reapply_exclude_types\CAN\f \ETX(\SO2..temporal.api.enums.v1.ResetReapplyExcludeTypeR\CANresetReapplyExcludeTypesB\b\n\
      \\ACKtarget"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        resetReapplyType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reset_reapply_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"resetReapplyType")) ::
              Data.ProtoLens.FieldDescriptor ResetOptions
        currentRunOnly__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_run_only"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentRunOnly")) ::
              Data.ProtoLens.FieldDescriptor ResetOptions
        resetReapplyExcludeTypes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reset_reapply_exclude_types"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyExcludeType)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Packed
                 (Data.ProtoLens.Field.field @"resetReapplyExcludeTypes")) ::
              Data.ProtoLens.FieldDescriptor ResetOptions
        firstWorkflowTask__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "first_workflow_task"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Empty.Empty)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'firstWorkflowTask")) ::
              Data.ProtoLens.FieldDescriptor ResetOptions
        lastWorkflowTask__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_workflow_task"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Empty.Empty)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastWorkflowTask")) ::
              Data.ProtoLens.FieldDescriptor ResetOptions
        workflowTaskId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_task_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowTaskId")) ::
              Data.ProtoLens.FieldDescriptor ResetOptions
        buildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'buildId")) ::
              Data.ProtoLens.FieldDescriptor ResetOptions
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 10, resetReapplyType__field_descriptor),
           (Data.ProtoLens.Tag 11, currentRunOnly__field_descriptor),
           (Data.ProtoLens.Tag 12, 
            resetReapplyExcludeTypes__field_descriptor),
           (Data.ProtoLens.Tag 1, firstWorkflowTask__field_descriptor),
           (Data.ProtoLens.Tag 2, lastWorkflowTask__field_descriptor),
           (Data.ProtoLens.Tag 3, workflowTaskId__field_descriptor),
           (Data.ProtoLens.Tag 4, buildId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResetOptions'_unknownFields
        (\ x__ y__ -> x__ {_ResetOptions'_unknownFields = y__})
  defMessage
    = ResetOptions'_constructor
        {_ResetOptions'resetReapplyType = Data.ProtoLens.fieldDefault,
         _ResetOptions'currentRunOnly = Data.ProtoLens.fieldDefault,
         _ResetOptions'resetReapplyExcludeTypes = Data.Vector.Generic.empty,
         _ResetOptions'target = Prelude.Nothing,
         _ResetOptions'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResetOptions
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyExcludeType
             -> Data.ProtoLens.Encoding.Bytes.Parser ResetOptions
        loop x mutable'resetReapplyExcludeTypes
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'resetReapplyExcludeTypes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                              mutable'resetReapplyExcludeTypes)
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
                              (Data.ProtoLens.Field.field @"vec'resetReapplyExcludeTypes")
                              frozen'resetReapplyExcludeTypes x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        80
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "reset_reapply_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"resetReapplyType") y x)
                                  mutable'resetReapplyExcludeTypes
                        88
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "current_run_only"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentRunOnly") y x)
                                  mutable'resetReapplyExcludeTypes
                        96
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (Prelude.fmap
                                           Prelude.toEnum
                                           (Prelude.fmap
                                              Prelude.fromIntegral
                                              Data.ProtoLens.Encoding.Bytes.getVarInt))
                                        "reset_reapply_exclude_types"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'resetReapplyExcludeTypes y)
                                loop x v
                        98
                          -> do y <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                        Data.ProtoLens.Encoding.Bytes.isolate
                                          (Prelude.fromIntegral len)
                                          ((let
                                              ploop qs
                                                = do packedEnd <- Data.ProtoLens.Encoding.Bytes.atEnd
                                                     if packedEnd then
                                                         Prelude.return qs
                                                     else
                                                         do !q <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                    (Prelude.fmap
                                                                       Prelude.toEnum
                                                                       (Prelude.fmap
                                                                          Prelude.fromIntegral
                                                                          Data.ProtoLens.Encoding.Bytes.getVarInt))
                                                                    "reset_reapply_exclude_types"
                                                            qs' <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                                     (Data.ProtoLens.Encoding.Growing.append
                                                                        qs q)
                                                            ploop qs'
                                            in ploop)
                                             mutable'resetReapplyExcludeTypes)
                                loop x y
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "first_workflow_task"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"firstWorkflowTask") y x)
                                  mutable'resetReapplyExcludeTypes
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_workflow_task"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastWorkflowTask") y x)
                                  mutable'resetReapplyExcludeTypes
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "workflow_task_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowTaskId") y x)
                                  mutable'resetReapplyExcludeTypes
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "build_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"buildId") y x)
                                  mutable'resetReapplyExcludeTypes
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'resetReapplyExcludeTypes
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'resetReapplyExcludeTypes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                    Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'resetReapplyExcludeTypes)
          "ResetOptions"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"resetReapplyType") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 80)
                      ((Prelude..)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                         Prelude.fromEnum _v))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"currentRunOnly") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 88)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                            _v))
                ((Data.Monoid.<>)
                   (let
                      p = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"vec'resetReapplyExcludeTypes") _x
                    in
                      if Data.Vector.Generic.null p then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                            ((\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               (Data.ProtoLens.Encoding.Bytes.runBuilder
                                  (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                                     ((Prelude..)
                                        ((Prelude..)
                                           Data.ProtoLens.Encoding.Bytes.putVarInt
                                           Prelude.fromIntegral)
                                        Prelude.fromEnum)
                                     p))))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'target") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just (ResetOptions'FirstWorkflowTask v))
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage v)
                         (Prelude.Just (ResetOptions'LastWorkflowTask v))
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage v)
                         (Prelude.Just (ResetOptions'WorkflowTaskId v))
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                                ((Prelude..)
                                   Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral v)
                         (Prelude.Just (ResetOptions'BuildId v))
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.Text.Encoding.encodeUtf8 v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData ResetOptions where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResetOptions'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResetOptions'resetReapplyType x__)
                (Control.DeepSeq.deepseq
                   (_ResetOptions'currentRunOnly x__)
                   (Control.DeepSeq.deepseq
                      (_ResetOptions'resetReapplyExcludeTypes x__)
                      (Control.DeepSeq.deepseq (_ResetOptions'target x__) ()))))
instance Control.DeepSeq.NFData ResetOptions'Target where
  rnf (ResetOptions'FirstWorkflowTask x__) = Control.DeepSeq.rnf x__
  rnf (ResetOptions'LastWorkflowTask x__) = Control.DeepSeq.rnf x__
  rnf (ResetOptions'WorkflowTaskId x__) = Control.DeepSeq.rnf x__
  rnf (ResetOptions'BuildId x__) = Control.DeepSeq.rnf x__
_ResetOptions'FirstWorkflowTask ::
  Data.ProtoLens.Prism.Prism' ResetOptions'Target Proto.Google.Protobuf.Empty.Empty
_ResetOptions'FirstWorkflowTask
  = Data.ProtoLens.Prism.prism'
      ResetOptions'FirstWorkflowTask
      (\ p__
         -> case p__ of
              (ResetOptions'FirstWorkflowTask p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_ResetOptions'LastWorkflowTask ::
  Data.ProtoLens.Prism.Prism' ResetOptions'Target Proto.Google.Protobuf.Empty.Empty
_ResetOptions'LastWorkflowTask
  = Data.ProtoLens.Prism.prism'
      ResetOptions'LastWorkflowTask
      (\ p__
         -> case p__ of
              (ResetOptions'LastWorkflowTask p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_ResetOptions'WorkflowTaskId ::
  Data.ProtoLens.Prism.Prism' ResetOptions'Target Data.Int.Int64
_ResetOptions'WorkflowTaskId
  = Data.ProtoLens.Prism.prism'
      ResetOptions'WorkflowTaskId
      (\ p__
         -> case p__ of
              (ResetOptions'WorkflowTaskId p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_ResetOptions'BuildId ::
  Data.ProtoLens.Prism.Prism' ResetOptions'Target Data.Text.Text
_ResetOptions'BuildId
  = Data.ProtoLens.Prism.prism'
      ResetOptions'BuildId
      (\ p__
         -> case p__ of
              (ResetOptions'BuildId p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
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
      \\vRetryPolicy\DC2D\n\
      \\DLEinitial_interval\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\SIinitialInterval\DC2/\n\
      \\DC3backoff_coefficient\CAN\STX \SOH(\SOHR\DC2backoffCoefficient\DC2D\n\
      \\DLEmaximum_interval\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\SImaximumInterval\DC2)\n\
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
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.useVersioning' @:: Lens' WorkerVersionCapabilities Prelude.Bool@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.deploymentSeriesName' @:: Lens' WorkerVersionCapabilities Data.Text.Text@ -}
data WorkerVersionCapabilities
  = WorkerVersionCapabilities'_constructor {_WorkerVersionCapabilities'buildId :: !Data.Text.Text,
                                            _WorkerVersionCapabilities'useVersioning :: !Prelude.Bool,
                                            _WorkerVersionCapabilities'deploymentSeriesName :: !Data.Text.Text,
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
instance Data.ProtoLens.Field.HasField WorkerVersionCapabilities "deploymentSeriesName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerVersionCapabilities'deploymentSeriesName
           (\ x__ y__
              -> x__ {_WorkerVersionCapabilities'deploymentSeriesName = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerVersionCapabilities where
  messageName _
    = Data.Text.pack "temporal.api.common.v1.WorkerVersionCapabilities"
  packedMessageDescriptor _
    = "\n\
      \\EMWorkerVersionCapabilities\DC2\EM\n\
      \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2%\n\
      \\SOuse_versioning\CAN\STX \SOH(\bR\ruseVersioning\DC24\n\
      \\SYNdeployment_series_name\CAN\EOT \SOH(\tR\DC4deploymentSeriesName"
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
        deploymentSeriesName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "deployment_series_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"deploymentSeriesName")) ::
              Data.ProtoLens.FieldDescriptor WorkerVersionCapabilities
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, buildId__field_descriptor),
           (Data.ProtoLens.Tag 2, useVersioning__field_descriptor),
           (Data.ProtoLens.Tag 4, deploymentSeriesName__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerVersionCapabilities'_unknownFields
        (\ x__ y__
           -> x__ {_WorkerVersionCapabilities'_unknownFields = y__})
  defMessage
    = WorkerVersionCapabilities'_constructor
        {_WorkerVersionCapabilities'buildId = Data.ProtoLens.fieldDefault,
         _WorkerVersionCapabilities'useVersioning = Data.ProtoLens.fieldDefault,
         _WorkerVersionCapabilities'deploymentSeriesName = Data.ProtoLens.fieldDefault,
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
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "deployment_series_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"deploymentSeriesName") y x)
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
                ((Data.Monoid.<>)
                   (let
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"deploymentSeriesName") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData WorkerVersionCapabilities where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerVersionCapabilities'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerVersionCapabilities'buildId x__)
                (Control.DeepSeq.deepseq
                   (_WorkerVersionCapabilities'useVersioning x__)
                   (Control.DeepSeq.deepseq
                      (_WorkerVersionCapabilities'deploymentSeriesName x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.buildId' @:: Lens' WorkerVersionStamp Data.Text.Text@
         * 'Proto.Temporal.Api.Common.V1.Message_Fields.useVersioning' @:: Lens' WorkerVersionStamp Prelude.Bool@ -}
data WorkerVersionStamp
  = WorkerVersionStamp'_constructor {_WorkerVersionStamp'buildId :: !Data.Text.Text,
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
      \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2%\n\
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
           (Data.ProtoLens.Tag 3, useVersioning__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerVersionStamp'_unknownFields
        (\ x__ y__ -> x__ {_WorkerVersionStamp'_unknownFields = y__})
  defMessage
    = WorkerVersionStamp'_constructor
        {_WorkerVersionStamp'buildId = Data.ProtoLens.fieldDefault,
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
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData WorkerVersionStamp where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerVersionStamp'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerVersionStamp'buildId x__)
                (Control.DeepSeq.deepseq
                   (_WorkerVersionStamp'useVersioning x__) ()))
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
    \$temporal/api/common/v1/message.proto\DC2\SYNtemporal.api.common.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\ESCgoogle/protobuf/empty.proto\SUB\"temporal/api/enums/v1/common.proto\SUB&temporal/api/enums/v1/event_type.proto\SUB!temporal/api/enums/v1/reset.proto\"h\n\
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
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\"\176\STX\n\
    \\vRetryPolicy\DC2D\n\
    \\DLEinitial_interval\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\SIinitialInterval\DC2/\n\
    \\DC3backoff_coefficient\CAN\STX \SOH(\SOHR\DC2backoffCoefficient\DC2D\n\
    \\DLEmaximum_interval\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\SImaximumInterval\DC2)\n\
    \\DLEmaximum_attempts\CAN\EOT \SOH(\ENQR\SImaximumAttempts\DC29\n\
    \\EMnon_retryable_error_types\CAN\ENQ \ETX(\tR\SYNnonRetryableErrorTypes\"n\n\
    \\DLEMeteringMetadata\DC2Z\n\
    \*nonfirst_local_activity_execution_attempts\CAN\r \SOH(\rR&nonfirstLocalActivityExecutionAttempts\"V\n\
    \\DC2WorkerVersionStamp\DC2\EM\n\
    \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2%\n\
    \\SOuse_versioning\CAN\ETX \SOH(\bR\ruseVersioning\"\147\SOH\n\
    \\EMWorkerVersionCapabilities\DC2\EM\n\
    \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2%\n\
    \\SOuse_versioning\CAN\STX \SOH(\bR\ruseVersioning\DC24\n\
    \\SYNdeployment_series_name\CAN\EOT \SOH(\tR\DC4deploymentSeriesName\"\227\ETX\n\
    \\fResetOptions\DC2H\n\
    \\DC3first_workflow_task\CAN\SOH \SOH(\v2\SYN.google.protobuf.EmptyH\NULR\DC1firstWorkflowTask\DC2F\n\
    \\DC2last_workflow_task\CAN\STX \SOH(\v2\SYN.google.protobuf.EmptyH\NULR\DLElastWorkflowTask\DC2*\n\
    \\DLEworkflow_task_id\CAN\ETX \SOH(\ETXH\NULR\SOworkflowTaskId\DC2\ESC\n\
    \\bbuild_id\CAN\EOT \SOH(\tH\NULR\abuildId\DC2U\n\
    \\DC2reset_reapply_type\CAN\n\
    \ \SOH(\SO2'.temporal.api.enums.v1.ResetReapplyTypeR\DLEresetReapplyType\DC2(\n\
    \\DLEcurrent_run_only\CAN\v \SOH(\bR\SOcurrentRunOnly\DC2m\n\
    \\ESCreset_reapply_exclude_types\CAN\f \ETX(\SO2..temporal.api.enums.v1.ResetReapplyExcludeTypeR\CANresetReapplyExcludeTypesB\b\n\
    \\ACKtarget\"\231\STX\n\
    \\bCallback\DC2>\n\
    \\ENQnexus\CAN\STX \SOH(\v2&.temporal.api.common.v1.Callback.NexusH\NULR\ENQnexus\DC2G\n\
    \\binternal\CAN\ETX \SOH(\v2).temporal.api.common.v1.Callback.InternalH\NULR\binternal\SUB\160\SOH\n\
    \\ENQNexus\DC2\DLE\n\
    \\ETXurl\CAN\SOH \SOH(\tR\ETXurl\DC2J\n\
    \\ACKheader\CAN\STX \ETX(\v22.temporal.api.common.v1.Callback.Nexus.HeaderEntryR\ACKheader\SUB9\n\
    \\vHeaderEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\SUB\RS\n\
    \\bInternal\DC2\DC2\n\
    \\EOTdata\CAN\SOH \SOH(\fR\EOTdataB\t\n\
    \\avariantJ\EOT\b\SOH\DLE\STX\"\140\EOT\n\
    \\EOTLink\DC2S\n\
    \\SOworkflow_event\CAN\SOH \SOH(\v2*.temporal.api.common.v1.Link.WorkflowEventH\NULR\rworkflowEvent\DC2D\n\
    \\tbatch_job\CAN\STX \SOH(\v2%.temporal.api.common.v1.Link.BatchJobH\NULR\bbatchJob\SUB\186\STX\n\
    \\rWorkflowEvent\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
    \\vworkflow_id\CAN\STX \SOH(\tR\n\
    \workflowId\DC2\NAK\n\
    \\ACKrun_id\CAN\ETX \SOH(\tR\ENQrunId\DC2X\n\
    \\tevent_ref\CANd \SOH(\v29.temporal.api.common.v1.Link.WorkflowEvent.EventReferenceH\NULR\beventRef\SUBl\n\
    \\SOEventReference\DC2\EM\n\
    \\bevent_id\CAN\SOH \SOH(\ETXR\aeventId\DC2?\n\
    \\n\
    \event_type\CAN\STX \SOH(\SO2 .temporal.api.enums.v1.EventTypeR\teventTypeB\v\n\
    \\treference\SUB!\n\
    \\bBatchJob\DC2\NAK\n\
    \\ACKjob_id\CAN\SOH \SOH(\tR\ENQjobIdB\t\n\
    \\avariant\"-\n\
    \\bPriority\DC2!\n\
    \\fpriority_key\CAN\SOH \SOH(\ENQR\vpriorityKeyB\137\SOH\n\
    \\EMio.temporal.api.common.v1B\fMessageProtoP\SOHZ#go.temporal.io/api/common/v1;common\170\STX\CANTemporalio.Api.Common.V1\234\STX\ESCTemporalio::Api::Common::V1J\248^\n\
    \\a\DC2\ENQ\SYN\NUL\153\STX\SOH\n\
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
    \\STX\ETX\SOH\DC2\ETX\"\NUL%\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX$\NUL,\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX%\NUL0\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX&\NUL+\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT(\NUL+\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX(\b\DLE\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX)\EOT9\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX)\EOT&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX)'4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX)78\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX*\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX*\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX*\n\
    \\SO\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX*\DC1\DC2\n\
    \\ESC\n\
    \\STX\EOT\SOH\DC2\EOT.\NUL0\SOH\SUB\SI See `Payload`\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX.\b\DLE\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX/\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\EOT\DC2\ETX/\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX/\r\DC4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX/\NAK\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX/ !\n\
    \\239\SOH\n\
    \\STX\EOT\STX\DC2\EOT5\NUL8\SOH\SUB\226\SOH Represents some binary (byte array) data (ex: activity input parameters or workflow result) with\n\
    \ metadata which describes this binary data (format, encoding, encryption, etc). Serialization\n\
    \ of the data may be user-defined.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX5\b\SI\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX6\EOT#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX6\EOT\NAK\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX6\SYN\RS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX6!\"\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX7\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX7\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX7\n\
    \\SO\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX7\DC1\DC2\n\
    \\163\SOH\n\
    \\STX\EOT\ETX\DC2\EOT<\NUL>\SOH\SUB\150\SOH A user-defined set of *indexed* fields that are used/exposed when listing/searching workflows.\n\
    \ The payload is not serialized in a user-defined way.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX<\b\CAN\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX=\EOT,\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ACK\DC2\ETX=\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX=\EM'\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX=*+\n\
    \h\n\
    \\STX\EOT\EOT\DC2\EOTA\NULC\SOH\SUB\\ A user-defined set of *unindexed* fields that are exposed when listing/searching workflows\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXA\b\f\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXB\EOT$\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETXB\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXB\EM\US\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXB\"#\n\
    \\176\SOH\n\
    \\STX\EOT\ENQ\DC2\EOTG\NULI\SOH\SUB\163\SOH Contains metadata that can be attached to a variety of requests, like starting a workflow, and\n\
    \ can be propagated between, for example, workflows and activities.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXG\b\SO\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXH\EOT$\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETXH\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXH\EM\US\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXH\"#\n\
    \\145\STX\n\
    \\STX\EOT\ACK\DC2\EOTN\NULQ\SOH\SUB\132\STX Identifies a specific workflow within a namespace. Practically speaking, because run_id is a\n\
    \ uuid, a workflow execution is globally unique. Note that many commands allow specifying an empty\n\
    \ run id as a way of saying \"target the latest run of the workflow\".\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXN\b\EM\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXO\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXO\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXO\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXO\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXP\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXP\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXP\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXP\DC4\NAK\n\
    \\181\SOH\n\
    \\STX\EOT\a\DC2\EOTU\NULW\SOH\SUB\168\SOH Represents the identifier used by a workflow author to define the workflow. Typically, the\n\
    \ name of a function. This is sometimes referred to as the workflow's \"name\"\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXU\b\DC4\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXV\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETXV\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXV\v\SI\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXV\DC2\DC3\n\
    \\181\SOH\n\
    \\STX\EOT\b\DC2\EOT[\NUL]\SOH\SUB\168\SOH Represents the identifier used by a activity author to define the activity. Typically, the\n\
    \ name of a function. This is sometimes referred to as the activity's \"name\"\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETX[\b\DC4\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETX\\\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\ETX\\\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETX\\\v\SI\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETX\\\DC2\DC3\n\
    \V\n\
    \\STX\EOT\t\DC2\EOT`\NULp\SOH\SUBJ How retries ought to be handled, usable by both workflows and activities\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETX`\b\DC3\n\
    \n\n\
    \\EOT\EOT\t\STX\NUL\DC2\ETXb\EOT2\SUBa Interval of the first retry. If retryBackoffCoefficient is 1.0 then it is used for all retries.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ACK\DC2\ETXb\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\ETXb\GS-\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\ETXb01\n\
    \\169\SOH\n\
    \\EOT\EOT\t\STX\SOH\DC2\ETXf\EOT#\SUB\155\SOH Coefficient used to calculate the next retry interval.\n\
    \ The next retry interval is previous interval multiplied by the coefficient.\n\
    \ Must be 1 or larger.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ENQ\DC2\ETXf\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\ETXf\v\RS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\ETXf!\"\n\
    \\178\SOH\n\
    \\EOT\EOT\t\STX\STX\DC2\ETXi\EOT2\SUB\164\SOH Maximum interval between retries. Exponential backoff leads to interval increase.\n\
    \ This value is the cap of the increase. Default is 100x of the initial interval.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ACK\DC2\ETXi\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\SOH\DC2\ETXi\GS-\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ETX\DC2\ETXi01\n\
    \\159\SOH\n\
    \\EOT\EOT\t\STX\ETX\DC2\ETXl\EOT\US\SUB\145\SOH Maximum number of attempts. When exceeded the retries stop even if not expired yet.\n\
    \ 1 disables retries. 0 means unlimited (up to the timeouts)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ENQ\DC2\ETXl\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\SOH\DC2\ETXl\n\
    \\SUB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ETX\DC2\ETXl\GS\RS\n\
    \\192\SOH\n\
    \\EOT\EOT\t\STX\EOT\DC2\ETXo\EOT2\SUB\178\SOH Non-Retryable errors types. Will stop retrying if the error type matches this list. Note that\n\
    \ this is not a substring match, the error *type* (not message) must match exactly.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\EOT\DC2\ETXo\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ENQ\DC2\ETXo\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\SOH\DC2\ETXo\DC4-\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ETX\DC2\ETXo01\n\
    \5\n\
    \\STX\EOT\n\
    \\DC2\EOTs\NUL{\SOH\SUB) Metadata relevant for metering purposes\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETXs\b\CAN\n\
    \\239\STX\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETXz\EOT;\SUB\225\STX Count of local activities which have begun an execution attempt during this workflow task,\n\
    \ and whose first attempt occurred in some previous task. This is used for metering\n\
    \ purposes, and does not affect workflow state.\n\
    \\n\
    \ (-- api-linter: core::0141::forbidden-types=disabled\n\
    \     aip.dev/not-precedent: Negative values make no sense to represent. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETXz\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETXz\v5\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETXz8:\n\
    \\157\SOH\n\
    \\STX\EOT\v\DC2\ENQ\DEL\NUL\137\SOH\SOH\SUB\143\SOH Deprecated. This message is replaced with `Deployment` and `VersioningBehavior`.\n\
    \ Identifies the version(s) of a worker that processed a task\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETX\DEL\b\SUB\n\
    \\170\SOH\n\
    \\EOT\EOT\v\STX\NUL\DC2\EOT\130\SOH\EOT\CAN\SUB\155\SOH An opaque whole-worker identifier. Replaces the deprecated `binary_checksum` field when this\n\
    \ message is included in requests which previously used that.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ENQ\DC2\EOT\130\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\EOT\130\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\EOT\130\SOH\SYN\ETB\n\
    \\173\SOH\n\
    \\EOT\EOT\v\STX\SOH\DC2\EOT\134\SOH\EOT\FS\SUB\158\SOH If set, the worker is opting in to worker versioning. Otherwise, this is used only as a\n\
    \ marker for workflow reset points and the BuildIDs search attribute.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ENQ\DC2\EOT\134\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\EOT\134\SOH\t\ETB\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\EOT\134\SOH\SUB\ESC\n\
    \\198\STX\n\
    \\STX\EOT\f\DC2\ACK\143\SOH\NUL\155\SOH\SOH\SUB\183\STX Identifies the version that a worker is compatible with when polling or identifying itself,\n\
    \ and whether or not this worker is opting into the build-id based versioning feature. This is\n\
    \ used by matching to determine which workers ought to receive what tasks.\n\
    \ Deprecated. Use WorkerDeploymentOptions instead.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\f\SOH\DC2\EOT\143\SOH\b!\n\
    \1\n\
    \\EOT\EOT\f\STX\NUL\DC2\EOT\145\SOH\EOT\CAN\SUB# An opaque whole-worker identifier\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ENQ\DC2\EOT\145\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\EOT\145\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\EOT\145\SOH\SYN\ETB\n\
    \t\n\
    \\EOT\EOT\f\STX\SOH\DC2\EOT\149\SOH\EOT\FS\SUBf If set, the worker is opting in to worker versioning, and wishes to only receive appropriate\n\
    \ tasks.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ENQ\DC2\EOT\149\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\EOT\149\SOH\t\ETB\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\EOT\149\SOH\SUB\ESC\n\
    \U\n\
    \\EOT\EOT\f\STX\STX\DC2\EOT\152\SOH\EOT&\SUBG Must be sent if user has set a deployment series name (versioning-3).\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\ENQ\DC2\EOT\152\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\SOH\DC2\EOT\152\SOH\v!\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\ETX\DC2\EOT\152\SOH$%\n\
    \\141\SOH\n\
    \\STX\EOT\r\DC2\ACK\159\SOH\NUL\188\SOH\SOH\SUB\DEL Describes where and how to reset a workflow, used for batch reset currently\n\
    \ and may be used for single-workflow reset later.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\r\SOH\DC2\EOT\159\SOH\b\DC4\n\
    \2\n\
    \\EOT\EOT\r\b\NUL\DC2\ACK\161\SOH\EOT\176\SOH\ENQ\SUB\" Which workflow task to reset to.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\b\NUL\SOH\DC2\EOT\161\SOH\n\
    \\DLE\n\
    \M\n\
    \\EOT\EOT\r\STX\NUL\DC2\EOT\163\SOH\b6\SUB? Resets to the first workflow task completed or started event.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ACK\DC2\EOT\163\SOH\b\GS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\EOT\163\SOH\RS1\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\EOT\163\SOH45\n\
    \L\n\
    \\EOT\EOT\r\STX\SOH\DC2\EOT\165\SOH\b5\SUB> Resets to the last workflow task completed or started event.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ACK\DC2\EOT\165\SOH\b\GS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\SOH\DC2\EOT\165\SOH\RS0\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ETX\DC2\EOT\165\SOH34\n\
    \\241\SOH\n\
    \\EOT\EOT\r\STX\STX\DC2\EOT\169\SOH\b#\SUB\226\SOH The id of a specific `WORKFLOW_TASK_COMPLETED`,`WORKFLOW_TASK_TIMED_OUT`, `WORKFLOW_TASK_FAILED`, or\n\
    \ `WORKFLOW_TASK_STARTED` event to reset to.\n\
    \ Note that this option doesn't make sense when used as part of a batch request.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ENQ\DC2\EOT\169\SOH\b\r\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\SOH\DC2\EOT\169\SOH\SO\RS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ETX\DC2\EOT\169\SOH!\"\n\
    \\171\STX\n\
    \\EOT\EOT\r\STX\ETX\DC2\EOT\175\SOH\b\FS\SUB\156\STX Resets to the first workflow task processed by this build id.\n\
    \ If the workflow was not processed by the build id, or the workflow task can't be\n\
    \ determined, no reset will be performed.\n\
    \ Note that by default, this reset is allowed to be to a prior run in a chain of\n\
    \ continue-as-new.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ENQ\DC2\EOT\175\SOH\b\SO\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\SOH\DC2\EOT\175\SOH\SI\ETB\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ETX\DC2\EOT\175\SOH\SUB\ESC\n\
    \\\\n\
    \\EOT\EOT\r\STX\EOT\DC2\EOT\180\SOH\EOTC\SUBN Event types to be reapplied (deprecated)\n\
    \ Default: RESET_REAPPLY_TYPE_SIGNAL\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\ACK\DC2\EOT\180\SOH\EOT*\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\SOH\DC2\EOT\180\SOH+=\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\ETX\DC2\EOT\180\SOH@B\n\
    \\138\SOH\n\
    \\EOT\EOT\r\STX\ENQ\DC2\EOT\184\SOH\EOT\US\SUB| If true, limit the reset to only within the current run. (Applies to build_id targets and\n\
    \ possibly others in the future.)\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\ENQ\DC2\EOT\184\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\SOH\DC2\EOT\184\SOH\t\EM\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\ETX\DC2\EOT\184\SOH\FS\RS\n\
    \/\n\
    \\EOT\EOT\r\STX\ACK\DC2\EOT\187\SOH\EOT\\\SUB! Event types not to be reapplied\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\EOT\DC2\EOT\187\SOH\EOT\f\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\ACK\DC2\EOT\187\SOH\r:\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\SOH\DC2\EOT\187\SOH;V\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\ETX\DC2\EOT\187\SOHY[\n\
    \a\n\
    \\STX\EOT\SO\DC2\ACK\191\SOH\NUL\213\SOH\SOH\SUBS Callback to attach to various events in the system, e.g. workflow run completion.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\SO\SOH\DC2\EOT\191\SOH\b\DLE\n\
    \\SO\n\
    \\EOT\EOT\SO\ETX\NUL\DC2\ACK\192\SOH\EOT\197\SOH\ENQ\n\
    \\r\n\
    \\ENQ\EOT\SO\ETX\NUL\SOH\DC2\EOT\192\SOH\f\DC1\n\
    \\US\n\
    \\ACK\EOT\SO\ETX\NUL\STX\NUL\DC2\EOT\194\SOH\b\ETB\SUB\SI Callback URL.\n\
    \\n\
    \\SI\n\
    \\a\EOT\SO\ETX\NUL\STX\NUL\ENQ\DC2\EOT\194\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\SO\ETX\NUL\STX\NUL\SOH\DC2\EOT\194\SOH\SI\DC2\n\
    \\SI\n\
    \\a\EOT\SO\ETX\NUL\STX\NUL\ETX\DC2\EOT\194\SOH\NAK\SYN\n\
    \7\n\
    \\ACK\EOT\SO\ETX\NUL\STX\SOH\DC2\EOT\196\SOH\b'\SUB' Header to attach to callback request.\n\
    \\n\
    \\SI\n\
    \\a\EOT\SO\ETX\NUL\STX\SOH\ACK\DC2\EOT\196\SOH\b\ESC\n\
    \\SI\n\
    \\a\EOT\SO\ETX\NUL\STX\SOH\SOH\DC2\EOT\196\SOH\FS\"\n\
    \\SI\n\
    \\a\EOT\SO\ETX\NUL\STX\SOH\ETX\DC2\EOT\196\SOH%&\n\
    \\222\STX\n\
    \\EOT\EOT\SO\ETX\SOH\DC2\ACK\203\SOH\EOT\206\SOH\ENQ\SUB\205\STX Callbacks to be delivered internally within the system.\n\
    \ This variant is not settable in the API and will be rejected by the service with an INVALID_ARGUMENT error.\n\
    \ The only reason that this is exposed is because callbacks are replicated across clusters via the\n\
    \ WorkflowExecutionStarted event, which is defined in the public API.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\ETX\SOH\SOH\DC2\EOT\203\SOH\f\DC4\n\
    \'\n\
    \\ACK\EOT\SO\ETX\SOH\STX\NUL\DC2\EOT\205\SOH\b\ETB\SUB\ETB Opaque internal data.\n\
    \\n\
    \\SI\n\
    \\a\EOT\SO\ETX\SOH\STX\NUL\ENQ\DC2\EOT\205\SOH\b\r\n\
    \\SI\n\
    \\a\EOT\SO\ETX\SOH\STX\NUL\SOH\DC2\EOT\205\SOH\SO\DC2\n\
    \\SI\n\
    \\a\EOT\SO\ETX\SOH\STX\NUL\ETX\DC2\EOT\205\SOH\NAK\SYN\n\
    \B\n\
    \\ETX\EOT\SO\t\DC2\EOT\208\SOH\EOT\SI\"5 For a generic callback mechanism to be added later.\n\
    \\n\
    \\f\n\
    \\EOT\EOT\SO\t\NUL\DC2\EOT\208\SOH\r\SO\n\
    \\r\n\
    \\ENQ\EOT\SO\t\NUL\SOH\DC2\EOT\208\SOH\r\SO\n\
    \\r\n\
    \\ENQ\EOT\SO\t\NUL\STX\DC2\EOT\208\SOH\r\SO\n\
    \\SO\n\
    \\EOT\EOT\SO\b\NUL\DC2\ACK\209\SOH\EOT\212\SOH\ENQ\n\
    \\r\n\
    \\ENQ\EOT\SO\b\NUL\SOH\DC2\EOT\209\SOH\n\
    \\DC1\n\
    \\f\n\
    \\EOT\EOT\SO\STX\NUL\DC2\EOT\210\SOH\b\CAN\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ACK\DC2\EOT\210\SOH\b\r\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\EOT\210\SOH\SO\DC3\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\EOT\210\SOH\SYN\ETB\n\
    \\f\n\
    \\EOT\EOT\SO\STX\SOH\DC2\EOT\211\SOH\b\RS\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\ACK\DC2\EOT\211\SOH\b\DLE\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\SOH\DC2\EOT\211\SOH\DC1\EM\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\ETX\DC2\EOT\211\SOH\FS\GS\n\
    \\212\STX\n\
    \\STX\EOT\SI\DC2\ACK\219\SOH\NUL\248\SOH\SOH\SUB\197\STX Link can be associated with history events. It might contain information about an external entity\n\
    \ related to the history event. For example, workflow A makes a Nexus call that starts workflow B:\n\
    \ in this case, a history event in workflow A could contain a Link to the workflow started event in\n\
    \ workflow B, and vice-versa.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\SI\SOH\DC2\EOT\219\SOH\b\f\n\
    \\SO\n\
    \\EOT\EOT\SI\ETX\NUL\DC2\ACK\220\SOH\EOT\235\SOH\ENQ\n\
    \\r\n\
    \\ENQ\EOT\SI\ETX\NUL\SOH\DC2\EOT\220\SOH\f\EM\n\
    \\DLE\n\
    \\ACK\EOT\SI\ETX\NUL\ETX\NUL\DC2\ACK\221\SOH\b\224\SOH\t\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\ETX\NUL\SOH\DC2\EOT\221\SOH\DLE\RS\n\
    \\DLE\n\
    \\b\EOT\SI\ETX\NUL\ETX\NUL\STX\NUL\DC2\EOT\222\SOH\f\US\n\
    \\DC1\n\
    \\t\EOT\SI\ETX\NUL\ETX\NUL\STX\NUL\ENQ\DC2\EOT\222\SOH\f\DC1\n\
    \\DC1\n\
    \\t\EOT\SI\ETX\NUL\ETX\NUL\STX\NUL\SOH\DC2\EOT\222\SOH\DC2\SUB\n\
    \\DC1\n\
    \\t\EOT\SI\ETX\NUL\ETX\NUL\STX\NUL\ETX\DC2\EOT\222\SOH\GS\RS\n\
    \\DLE\n\
    \\b\EOT\SI\ETX\NUL\ETX\NUL\STX\SOH\DC2\EOT\223\SOH\f;\n\
    \\DC1\n\
    \\t\EOT\SI\ETX\NUL\ETX\NUL\STX\SOH\ACK\DC2\EOT\223\SOH\f+\n\
    \\DC1\n\
    \\t\EOT\SI\ETX\NUL\ETX\NUL\STX\SOH\SOH\DC2\EOT\223\SOH,6\n\
    \\DC1\n\
    \\t\EOT\SI\ETX\NUL\ETX\NUL\STX\SOH\ETX\DC2\EOT\223\SOH9:\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\NUL\STX\NUL\DC2\EOT\226\SOH\b\GS\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\NUL\ENQ\DC2\EOT\226\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\NUL\SOH\DC2\EOT\226\SOH\SI\CAN\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\NUL\ETX\DC2\EOT\226\SOH\ESC\FS\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\NUL\STX\SOH\DC2\EOT\227\SOH\b\US\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\SOH\ENQ\DC2\EOT\227\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\SOH\SOH\DC2\EOT\227\SOH\SI\SUB\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\SOH\ETX\DC2\EOT\227\SOH\GS\RS\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\NUL\STX\STX\DC2\EOT\228\SOH\b\SUB\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\STX\ENQ\DC2\EOT\228\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\STX\SOH\DC2\EOT\228\SOH\SI\NAK\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\STX\ETX\DC2\EOT\228\SOH\CAN\EM\n\
    \\155\SOH\n\
    \\ACK\EOT\SI\ETX\NUL\b\NUL\DC2\ACK\232\SOH\b\234\SOH\t\SUB\136\SOH Additional information about the workflow event.\n\
    \ Eg: the caller workflow can send the history event details that made the Nexus call.\n\
    \\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\b\NUL\SOH\DC2\EOT\232\SOH\SO\ETB\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\NUL\STX\ETX\DC2\EOT\233\SOH\f+\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\ETX\ACK\DC2\EOT\233\SOH\f\SUB\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\ETX\SOH\DC2\EOT\233\SOH\ESC$\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\ETX\ETX\DC2\EOT\233\SOH'*\n\
    \\249\SOH\n\
    \\EOT\EOT\SI\ETX\SOH\DC2\ACK\240\SOH\EOT\242\SOH\ENQ\SUB\232\SOH A link to a built-in batch job.\n\
    \ Batch jobs can be used to perform operations on a set of workflows (e.g. terminate, signal, cancel, etc).\n\
    \ This link can be put on workflow history events generated by actions taken by a batch job.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\ETX\SOH\SOH\DC2\EOT\240\SOH\f\DC4\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\SOH\STX\NUL\DC2\EOT\241\SOH\b\SUB\n\
    \\SI\n\
    \\a\EOT\SI\ETX\SOH\STX\NUL\ENQ\DC2\EOT\241\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\SI\ETX\SOH\STX\NUL\SOH\DC2\EOT\241\SOH\SI\NAK\n\
    \\SI\n\
    \\a\EOT\SI\ETX\SOH\STX\NUL\ETX\DC2\EOT\241\SOH\CAN\EM\n\
    \\SO\n\
    \\EOT\EOT\SI\b\NUL\DC2\ACK\244\SOH\EOT\247\SOH\ENQ\n\
    \\r\n\
    \\ENQ\EOT\SI\b\NUL\SOH\DC2\EOT\244\SOH\n\
    \\DC1\n\
    \\f\n\
    \\EOT\EOT\SI\STX\NUL\DC2\EOT\245\SOH\b)\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ACK\DC2\EOT\245\SOH\b\NAK\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\SOH\DC2\EOT\245\SOH\SYN$\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ETX\DC2\EOT\245\SOH'(\n\
    \\f\n\
    \\EOT\EOT\SI\STX\SOH\DC2\EOT\246\SOH\b\US\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ACK\DC2\EOT\246\SOH\b\DLE\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\SOH\DC2\EOT\246\SOH\DC1\SUB\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ETX\DC2\EOT\246\SOH\GS\RS\n\
    \\161\b\n\
    \\STX\EOT\DLE\DC2\ACK\141\STX\NUL\153\STX\SOH\SUB\146\b Priority contains metadata that controls relative ordering of task processing\n\
    \ when tasks are backlogged in a queue. Initially, Priority will be used in\n\
    \ activity and workflow task queues, which are typically where backlogs exist.\n\
    \ Other queues in the server (such as transfer and timer queues) and rate\n\
    \ limiting decisions do not use Priority, but may in the future.\n\
    \\n\
    \ Priority is attached to workflows and activities. Activities and child\n\
    \ workflows inherit Priority from the workflow that created them, but may\n\
    \ override fields when they are started or modified. For each field of a\n\
    \ Priority on an activity/workflow, not present or equal to zero/empty string\n\
    \ means to inherit the value from the calling workflow, or if there is no\n\
    \ calling workflow, then use the default (documented below).\n\
    \\n\
    \ Despite being named \"Priority\", this message will also contains fields that\n\
    \ control \"fairness\" mechanisms.\n\
    \\n\
    \ The overall semantics of Priority are:\n\
    \ 1. First, consider \"priority_key\": lower number goes first.\n\
    \ (more will be added here later)\n\
    \\n\
    \\v\n\
    \\ETX\EOT\DLE\SOH\DC2\EOT\141\STX\b\DLE\n\
    \\211\ETX\n\
    \\EOT\EOT\DLE\STX\NUL\DC2\EOT\152\STX\EOT\ESC\SUB\196\ETX Priority key is a positive integer from 1 to n, where smaller integers\n\
    \ correspond to higher priorities (tasks run sooner). In general, tasks in\n\
    \ a queue should be processed in close to priority order, although small\n\
    \ deviations are possible.\n\
    \\n\
    \ The maximum priority value (minimum priority) is determined by server\n\
    \ configuration, and defaults to 5.\n\
    \\n\
    \ The default priority is (min+max)/2. With the default max of 5 and min of\n\
    \ 1, that comes out to 3.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ENQ\DC2\EOT\152\STX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\SOH\DC2\EOT\152\STX\n\
    \\SYN\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ETX\DC2\EOT\152\STX\EM\SUBb\ACKproto3"
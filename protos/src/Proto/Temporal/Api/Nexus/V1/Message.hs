{- This file was auto-generated from temporal/api/nexus/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Nexus.V1.Message (
        CancelOperationRequest(), CancelOperationResponse(), Endpoint(),
        EndpointSpec(), EndpointTarget(), EndpointTarget'Variant(..),
        _EndpointTarget'Worker', _EndpointTarget'External',
        EndpointTarget'External(), EndpointTarget'Worker(), Failure(),
        Failure'MetadataEntry(), HandlerError(), Request(),
        Request'Variant(..), _Request'StartOperation,
        _Request'CancelOperation, Request'HeaderEntry(), Response(),
        Response'Variant(..), _Response'StartOperation,
        _Response'CancelOperation, StartOperationRequest(),
        StartOperationRequest'CallbackHeaderEntry(),
        StartOperationResponse(), StartOperationResponse'Variant(..),
        _StartOperationResponse'SyncSuccess,
        _StartOperationResponse'AsyncSuccess,
        _StartOperationResponse'OperationError,
        StartOperationResponse'Async(), StartOperationResponse'Sync(),
        UnsuccessfulOperationError()
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.service' @:: Lens' CancelOperationRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.operation' @:: Lens' CancelOperationRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.operationId' @:: Lens' CancelOperationRequest Data.Text.Text@ -}
data CancelOperationRequest
  = CancelOperationRequest'_constructor {_CancelOperationRequest'service :: !Data.Text.Text,
                                         _CancelOperationRequest'operation :: !Data.Text.Text,
                                         _CancelOperationRequest'operationId :: !Data.Text.Text,
                                         _CancelOperationRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CancelOperationRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CancelOperationRequest "service" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelOperationRequest'service
           (\ x__ y__ -> x__ {_CancelOperationRequest'service = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CancelOperationRequest "operation" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelOperationRequest'operation
           (\ x__ y__ -> x__ {_CancelOperationRequest'operation = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CancelOperationRequest "operationId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelOperationRequest'operationId
           (\ x__ y__ -> x__ {_CancelOperationRequest'operationId = y__}))
        Prelude.id
instance Data.ProtoLens.Message CancelOperationRequest where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.CancelOperationRequest"
  packedMessageDescriptor _
    = "\n\
      \\SYNCancelOperationRequest\DC2\CAN\n\
      \\aservice\CAN\SOH \SOH(\tR\aservice\DC2\FS\n\
      \\toperation\CAN\STX \SOH(\tR\toperation\DC2!\n\
      \\foperation_id\CAN\ETX \SOH(\tR\voperationId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        service__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "service"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"service")) ::
              Data.ProtoLens.FieldDescriptor CancelOperationRequest
        operation__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operation")) ::
              Data.ProtoLens.FieldDescriptor CancelOperationRequest
        operationId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operationId")) ::
              Data.ProtoLens.FieldDescriptor CancelOperationRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, service__field_descriptor),
           (Data.ProtoLens.Tag 2, operation__field_descriptor),
           (Data.ProtoLens.Tag 3, operationId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CancelOperationRequest'_unknownFields
        (\ x__ y__ -> x__ {_CancelOperationRequest'_unknownFields = y__})
  defMessage
    = CancelOperationRequest'_constructor
        {_CancelOperationRequest'service = Data.ProtoLens.fieldDefault,
         _CancelOperationRequest'operation = Data.ProtoLens.fieldDefault,
         _CancelOperationRequest'operationId = Data.ProtoLens.fieldDefault,
         _CancelOperationRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CancelOperationRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser CancelOperationRequest
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
                                       "service"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"service") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "operation"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"operation") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "operation_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"operationId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CancelOperationRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"service") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"operation") _x
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
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"operationId") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData CancelOperationRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CancelOperationRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CancelOperationRequest'service x__)
                (Control.DeepSeq.deepseq
                   (_CancelOperationRequest'operation x__)
                   (Control.DeepSeq.deepseq
                      (_CancelOperationRequest'operationId x__) ())))
{- | Fields :
      -}
data CancelOperationResponse
  = CancelOperationResponse'_constructor {_CancelOperationResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CancelOperationResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message CancelOperationResponse where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.CancelOperationResponse"
  packedMessageDescriptor _
    = "\n\
      \\ETBCancelOperationResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CancelOperationResponse'_unknownFields
        (\ x__ y__ -> x__ {_CancelOperationResponse'_unknownFields = y__})
  defMessage
    = CancelOperationResponse'_constructor
        {_CancelOperationResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CancelOperationResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser CancelOperationResponse
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CancelOperationResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData CancelOperationResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CancelOperationResponse'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.version' @:: Lens' Endpoint Data.Int.Int64@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.id' @:: Lens' Endpoint Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.spec' @:: Lens' Endpoint EndpointSpec@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'spec' @:: Lens' Endpoint (Prelude.Maybe EndpointSpec)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.createdTime' @:: Lens' Endpoint Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'createdTime' @:: Lens' Endpoint (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.lastModifiedTime' @:: Lens' Endpoint Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'lastModifiedTime' @:: Lens' Endpoint (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.urlPrefix' @:: Lens' Endpoint Data.Text.Text@ -}
data Endpoint
  = Endpoint'_constructor {_Endpoint'version :: !Data.Int.Int64,
                           _Endpoint'id :: !Data.Text.Text,
                           _Endpoint'spec :: !(Prelude.Maybe EndpointSpec),
                           _Endpoint'createdTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                           _Endpoint'lastModifiedTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                           _Endpoint'urlPrefix :: !Data.Text.Text,
                           _Endpoint'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Endpoint where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Endpoint "version" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'version (\ x__ y__ -> x__ {_Endpoint'version = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Endpoint "id" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'id (\ x__ y__ -> x__ {_Endpoint'id = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Endpoint "spec" EndpointSpec where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'spec (\ x__ y__ -> x__ {_Endpoint'spec = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Endpoint "maybe'spec" (Prelude.Maybe EndpointSpec) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'spec (\ x__ y__ -> x__ {_Endpoint'spec = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Endpoint "createdTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'createdTime
           (\ x__ y__ -> x__ {_Endpoint'createdTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Endpoint "maybe'createdTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'createdTime
           (\ x__ y__ -> x__ {_Endpoint'createdTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Endpoint "lastModifiedTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'lastModifiedTime
           (\ x__ y__ -> x__ {_Endpoint'lastModifiedTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Endpoint "maybe'lastModifiedTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'lastModifiedTime
           (\ x__ y__ -> x__ {_Endpoint'lastModifiedTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Endpoint "urlPrefix" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Endpoint'urlPrefix (\ x__ y__ -> x__ {_Endpoint'urlPrefix = y__}))
        Prelude.id
instance Data.ProtoLens.Message Endpoint where
  messageName _ = Data.Text.pack "temporal.api.nexus.v1.Endpoint"
  packedMessageDescriptor _
    = "\n\
      \\bEndpoint\DC2\CAN\n\
      \\aversion\CAN\SOH \SOH(\ETXR\aversion\DC2\SO\n\
      \\STXid\CAN\STX \SOH(\tR\STXid\DC27\n\
      \\EOTspec\CAN\ETX \SOH(\v2#.temporal.api.nexus.v1.EndpointSpecR\EOTspec\DC2=\n\
      \\fcreated_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\vcreatedTime\DC2H\n\
      \\DC2last_modified_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DLElastModifiedTime\DC2\GS\n\
      \\n\
      \url_prefix\CAN\ACK \SOH(\tR\turlPrefix"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor Endpoint
        id__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"id")) ::
              Data.ProtoLens.FieldDescriptor Endpoint
        spec__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "spec"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor EndpointSpec)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'spec")) ::
              Data.ProtoLens.FieldDescriptor Endpoint
        createdTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "created_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'createdTime")) ::
              Data.ProtoLens.FieldDescriptor Endpoint
        lastModifiedTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_modified_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastModifiedTime")) ::
              Data.ProtoLens.FieldDescriptor Endpoint
        urlPrefix__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "url_prefix"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"urlPrefix")) ::
              Data.ProtoLens.FieldDescriptor Endpoint
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, version__field_descriptor),
           (Data.ProtoLens.Tag 2, id__field_descriptor),
           (Data.ProtoLens.Tag 3, spec__field_descriptor),
           (Data.ProtoLens.Tag 4, createdTime__field_descriptor),
           (Data.ProtoLens.Tag 5, lastModifiedTime__field_descriptor),
           (Data.ProtoLens.Tag 6, urlPrefix__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Endpoint'_unknownFields
        (\ x__ y__ -> x__ {_Endpoint'_unknownFields = y__})
  defMessage
    = Endpoint'_constructor
        {_Endpoint'version = Data.ProtoLens.fieldDefault,
         _Endpoint'id = Data.ProtoLens.fieldDefault,
         _Endpoint'spec = Prelude.Nothing,
         _Endpoint'createdTime = Prelude.Nothing,
         _Endpoint'lastModifiedTime = Prelude.Nothing,
         _Endpoint'urlPrefix = Data.ProtoLens.fieldDefault,
         _Endpoint'_unknownFields = []}
  parseMessage
    = let
        loop :: Endpoint -> Data.ProtoLens.Encoding.Bytes.Parser Endpoint
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
                                       "version"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"version") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"id") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "spec"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"spec") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "created_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"createdTime") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_modified_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastModifiedTime") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "url_prefix"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"urlPrefix") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Endpoint"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"version") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"id") _x
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
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'spec") _x
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
                             (Data.ProtoLens.Field.field @"maybe'createdTime") _x
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
                                (Data.ProtoLens.Field.field @"maybe'lastModifiedTime") _x
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
                            (let
                               _v = Lens.Family2.view (Data.ProtoLens.Field.field @"urlPrefix") _x
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
instance Control.DeepSeq.NFData Endpoint where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Endpoint'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Endpoint'version x__)
                (Control.DeepSeq.deepseq
                   (_Endpoint'id x__)
                   (Control.DeepSeq.deepseq
                      (_Endpoint'spec x__)
                      (Control.DeepSeq.deepseq
                         (_Endpoint'createdTime x__)
                         (Control.DeepSeq.deepseq
                            (_Endpoint'lastModifiedTime x__)
                            (Control.DeepSeq.deepseq (_Endpoint'urlPrefix x__) ()))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.name' @:: Lens' EndpointSpec Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.description' @:: Lens' EndpointSpec Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'description' @:: Lens' EndpointSpec (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.target' @:: Lens' EndpointSpec EndpointTarget@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'target' @:: Lens' EndpointSpec (Prelude.Maybe EndpointTarget)@ -}
data EndpointSpec
  = EndpointSpec'_constructor {_EndpointSpec'name :: !Data.Text.Text,
                               _EndpointSpec'description :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload),
                               _EndpointSpec'target :: !(Prelude.Maybe EndpointTarget),
                               _EndpointSpec'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show EndpointSpec where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField EndpointSpec "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointSpec'name (\ x__ y__ -> x__ {_EndpointSpec'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField EndpointSpec "description" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointSpec'description
           (\ x__ y__ -> x__ {_EndpointSpec'description = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField EndpointSpec "maybe'description" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointSpec'description
           (\ x__ y__ -> x__ {_EndpointSpec'description = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField EndpointSpec "target" EndpointTarget where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointSpec'target
           (\ x__ y__ -> x__ {_EndpointSpec'target = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField EndpointSpec "maybe'target" (Prelude.Maybe EndpointTarget) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointSpec'target
           (\ x__ y__ -> x__ {_EndpointSpec'target = y__}))
        Prelude.id
instance Data.ProtoLens.Message EndpointSpec where
  messageName _ = Data.Text.pack "temporal.api.nexus.v1.EndpointSpec"
  packedMessageDescriptor _
    = "\n\
      \\fEndpointSpec\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2A\n\
      \\vdescription\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\vdescription\DC2=\n\
      \\ACKtarget\CAN\ETX \SOH(\v2%.temporal.api.nexus.v1.EndpointTargetR\ACKtarget"
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
              Data.ProtoLens.FieldDescriptor EndpointSpec
        description__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "description"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'description")) ::
              Data.ProtoLens.FieldDescriptor EndpointSpec
        target__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "target"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor EndpointTarget)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'target")) ::
              Data.ProtoLens.FieldDescriptor EndpointSpec
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, description__field_descriptor),
           (Data.ProtoLens.Tag 3, target__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _EndpointSpec'_unknownFields
        (\ x__ y__ -> x__ {_EndpointSpec'_unknownFields = y__})
  defMessage
    = EndpointSpec'_constructor
        {_EndpointSpec'name = Data.ProtoLens.fieldDefault,
         _EndpointSpec'description = Prelude.Nothing,
         _EndpointSpec'target = Prelude.Nothing,
         _EndpointSpec'_unknownFields = []}
  parseMessage
    = let
        loop ::
          EndpointSpec -> Data.ProtoLens.Encoding.Bytes.Parser EndpointSpec
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
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "description"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"description") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "target"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"target") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "EndpointSpec"
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
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'description") _x
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
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'target") _x
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
instance Control.DeepSeq.NFData EndpointSpec where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_EndpointSpec'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_EndpointSpec'name x__)
                (Control.DeepSeq.deepseq
                   (_EndpointSpec'description x__)
                   (Control.DeepSeq.deepseq (_EndpointSpec'target x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'variant' @:: Lens' EndpointTarget (Prelude.Maybe EndpointTarget'Variant)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'worker' @:: Lens' EndpointTarget (Prelude.Maybe EndpointTarget'Worker)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.worker' @:: Lens' EndpointTarget EndpointTarget'Worker@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'external' @:: Lens' EndpointTarget (Prelude.Maybe EndpointTarget'External)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.external' @:: Lens' EndpointTarget EndpointTarget'External@ -}
data EndpointTarget
  = EndpointTarget'_constructor {_EndpointTarget'variant :: !(Prelude.Maybe EndpointTarget'Variant),
                                 _EndpointTarget'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show EndpointTarget where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data EndpointTarget'Variant
  = EndpointTarget'Worker' !EndpointTarget'Worker |
    EndpointTarget'External' !EndpointTarget'External
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField EndpointTarget "maybe'variant" (Prelude.Maybe EndpointTarget'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'variant
           (\ x__ y__ -> x__ {_EndpointTarget'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField EndpointTarget "maybe'worker" (Prelude.Maybe EndpointTarget'Worker) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'variant
           (\ x__ y__ -> x__ {_EndpointTarget'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (EndpointTarget'Worker' x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap EndpointTarget'Worker' y__))
instance Data.ProtoLens.Field.HasField EndpointTarget "worker" EndpointTarget'Worker where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'variant
           (\ x__ y__ -> x__ {_EndpointTarget'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (EndpointTarget'Worker' x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap EndpointTarget'Worker' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField EndpointTarget "maybe'external" (Prelude.Maybe EndpointTarget'External) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'variant
           (\ x__ y__ -> x__ {_EndpointTarget'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (EndpointTarget'External' x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap EndpointTarget'External' y__))
instance Data.ProtoLens.Field.HasField EndpointTarget "external" EndpointTarget'External where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'variant
           (\ x__ y__ -> x__ {_EndpointTarget'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (EndpointTarget'External' x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap EndpointTarget'External' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message EndpointTarget where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.EndpointTarget"
  packedMessageDescriptor _
    = "\n\
      \\SOEndpointTarget\DC2F\n\
      \\ACKworker\CAN\SOH \SOH(\v2,.temporal.api.nexus.v1.EndpointTarget.WorkerH\NULR\ACKworker\DC2L\n\
      \\bexternal\CAN\STX \SOH(\v2..temporal.api.nexus.v1.EndpointTarget.ExternalH\NULR\bexternal\SUBE\n\
      \\ACKWorker\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\GS\n\
      \\n\
      \task_queue\CAN\STX \SOH(\tR\ttaskQueue\SUB\FS\n\
      \\bExternal\DC2\DLE\n\
      \\ETXurl\CAN\SOH \SOH(\tR\ETXurlB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        worker__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "worker"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor EndpointTarget'Worker)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'worker")) ::
              Data.ProtoLens.FieldDescriptor EndpointTarget
        external__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "external"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor EndpointTarget'External)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'external")) ::
              Data.ProtoLens.FieldDescriptor EndpointTarget
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, worker__field_descriptor),
           (Data.ProtoLens.Tag 2, external__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _EndpointTarget'_unknownFields
        (\ x__ y__ -> x__ {_EndpointTarget'_unknownFields = y__})
  defMessage
    = EndpointTarget'_constructor
        {_EndpointTarget'variant = Prelude.Nothing,
         _EndpointTarget'_unknownFields = []}
  parseMessage
    = let
        loop ::
          EndpointTarget
          -> Data.ProtoLens.Encoding.Bytes.Parser EndpointTarget
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
                                       "worker"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"worker") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "external"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"external") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "EndpointTarget"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (EndpointTarget'Worker' v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (EndpointTarget'External' v))
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
instance Control.DeepSeq.NFData EndpointTarget where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_EndpointTarget'_unknownFields x__)
             (Control.DeepSeq.deepseq (_EndpointTarget'variant x__) ())
instance Control.DeepSeq.NFData EndpointTarget'Variant where
  rnf (EndpointTarget'Worker' x__) = Control.DeepSeq.rnf x__
  rnf (EndpointTarget'External' x__) = Control.DeepSeq.rnf x__
_EndpointTarget'Worker' ::
  Data.ProtoLens.Prism.Prism' EndpointTarget'Variant EndpointTarget'Worker
_EndpointTarget'Worker'
  = Data.ProtoLens.Prism.prism'
      EndpointTarget'Worker'
      (\ p__
         -> case p__ of
              (EndpointTarget'Worker' p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_EndpointTarget'External' ::
  Data.ProtoLens.Prism.Prism' EndpointTarget'Variant EndpointTarget'External
_EndpointTarget'External'
  = Data.ProtoLens.Prism.prism'
      EndpointTarget'External'
      (\ p__
         -> case p__ of
              (EndpointTarget'External' p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.url' @:: Lens' EndpointTarget'External Data.Text.Text@ -}
data EndpointTarget'External
  = EndpointTarget'External'_constructor {_EndpointTarget'External'url :: !Data.Text.Text,
                                          _EndpointTarget'External'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show EndpointTarget'External where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField EndpointTarget'External "url" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'External'url
           (\ x__ y__ -> x__ {_EndpointTarget'External'url = y__}))
        Prelude.id
instance Data.ProtoLens.Message EndpointTarget'External where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.EndpointTarget.External"
  packedMessageDescriptor _
    = "\n\
      \\bExternal\DC2\DLE\n\
      \\ETXurl\CAN\SOH \SOH(\tR\ETXurl"
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
              Data.ProtoLens.FieldDescriptor EndpointTarget'External
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, url__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _EndpointTarget'External'_unknownFields
        (\ x__ y__ -> x__ {_EndpointTarget'External'_unknownFields = y__})
  defMessage
    = EndpointTarget'External'_constructor
        {_EndpointTarget'External'url = Data.ProtoLens.fieldDefault,
         _EndpointTarget'External'_unknownFields = []}
  parseMessage
    = let
        loop ::
          EndpointTarget'External
          -> Data.ProtoLens.Encoding.Bytes.Parser EndpointTarget'External
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "External"
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData EndpointTarget'External where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_EndpointTarget'External'_unknownFields x__)
             (Control.DeepSeq.deepseq (_EndpointTarget'External'url x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.namespace' @:: Lens' EndpointTarget'Worker Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.taskQueue' @:: Lens' EndpointTarget'Worker Data.Text.Text@ -}
data EndpointTarget'Worker
  = EndpointTarget'Worker'_constructor {_EndpointTarget'Worker'namespace :: !Data.Text.Text,
                                        _EndpointTarget'Worker'taskQueue :: !Data.Text.Text,
                                        _EndpointTarget'Worker'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show EndpointTarget'Worker where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField EndpointTarget'Worker "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'Worker'namespace
           (\ x__ y__ -> x__ {_EndpointTarget'Worker'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField EndpointTarget'Worker "taskQueue" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EndpointTarget'Worker'taskQueue
           (\ x__ y__ -> x__ {_EndpointTarget'Worker'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Message EndpointTarget'Worker where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.EndpointTarget.Worker"
  packedMessageDescriptor _
    = "\n\
      \\ACKWorker\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\GS\n\
      \\n\
      \task_queue\CAN\STX \SOH(\tR\ttaskQueue"
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
              Data.ProtoLens.FieldDescriptor EndpointTarget'Worker
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskQueue")) ::
              Data.ProtoLens.FieldDescriptor EndpointTarget'Worker
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, taskQueue__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _EndpointTarget'Worker'_unknownFields
        (\ x__ y__ -> x__ {_EndpointTarget'Worker'_unknownFields = y__})
  defMessage
    = EndpointTarget'Worker'_constructor
        {_EndpointTarget'Worker'namespace = Data.ProtoLens.fieldDefault,
         _EndpointTarget'Worker'taskQueue = Data.ProtoLens.fieldDefault,
         _EndpointTarget'Worker'_unknownFields = []}
  parseMessage
    = let
        loop ::
          EndpointTarget'Worker
          -> Data.ProtoLens.Encoding.Bytes.Parser EndpointTarget'Worker
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
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Worker"
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"taskQueue") _x
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
instance Control.DeepSeq.NFData EndpointTarget'Worker where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_EndpointTarget'Worker'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_EndpointTarget'Worker'namespace x__)
                (Control.DeepSeq.deepseq
                   (_EndpointTarget'Worker'taskQueue x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.message' @:: Lens' Failure Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.metadata' @:: Lens' Failure (Data.Map.Map Data.Text.Text Data.Text.Text)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.details' @:: Lens' Failure Data.ByteString.ByteString@ -}
data Failure
  = Failure'_constructor {_Failure'message :: !Data.Text.Text,
                          _Failure'metadata :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                          _Failure'details :: !Data.ByteString.ByteString,
                          _Failure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Failure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Failure "message" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Failure'message (\ x__ y__ -> x__ {_Failure'message = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Failure "metadata" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Failure'metadata (\ x__ y__ -> x__ {_Failure'metadata = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Failure "details" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Failure'details (\ x__ y__ -> x__ {_Failure'details = y__}))
        Prelude.id
instance Data.ProtoLens.Message Failure where
  messageName _ = Data.Text.pack "temporal.api.nexus.v1.Failure"
  packedMessageDescriptor _
    = "\n\
      \\aFailure\DC2\CAN\n\
      \\amessage\CAN\SOH \SOH(\tR\amessage\DC2H\n\
      \\bmetadata\CAN\STX \ETX(\v2,.temporal.api.nexus.v1.Failure.MetadataEntryR\bmetadata\DC2\CAN\n\
      \\adetails\CAN\ETX \SOH(\fR\adetails\SUB;\n\
      \\rMetadataEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        message__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "message"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"message")) ::
              Data.ProtoLens.FieldDescriptor Failure
        metadata__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "metadata"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Failure'MetadataEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"metadata")) ::
              Data.ProtoLens.FieldDescriptor Failure
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"details")) ::
              Data.ProtoLens.FieldDescriptor Failure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, message__field_descriptor),
           (Data.ProtoLens.Tag 2, metadata__field_descriptor),
           (Data.ProtoLens.Tag 3, details__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Failure'_unknownFields
        (\ x__ y__ -> x__ {_Failure'_unknownFields = y__})
  defMessage
    = Failure'_constructor
        {_Failure'message = Data.ProtoLens.fieldDefault,
         _Failure'metadata = Data.Map.empty,
         _Failure'details = Data.ProtoLens.fieldDefault,
         _Failure'_unknownFields = []}
  parseMessage
    = let
        loop :: Failure -> Data.ProtoLens.Encoding.Bytes.Parser Failure
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
                                       "message"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"message") y x)
                        18
                          -> do !(entry :: Failure'MetadataEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
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
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
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
          (do loop Data.ProtoLens.defMessage) "Failure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"message") _x
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
                                       (Data.ProtoLens.defMessage :: Failure'MetadataEntry)))))
                      (Data.Map.toList
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"metadata") _x))))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"details") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Failure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Failure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Failure'message x__)
                (Control.DeepSeq.deepseq
                   (_Failure'metadata x__)
                   (Control.DeepSeq.deepseq (_Failure'details x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.key' @:: Lens' Failure'MetadataEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.value' @:: Lens' Failure'MetadataEntry Data.Text.Text@ -}
data Failure'MetadataEntry
  = Failure'MetadataEntry'_constructor {_Failure'MetadataEntry'key :: !Data.Text.Text,
                                        _Failure'MetadataEntry'value :: !Data.Text.Text,
                                        _Failure'MetadataEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Failure'MetadataEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Failure'MetadataEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Failure'MetadataEntry'key
           (\ x__ y__ -> x__ {_Failure'MetadataEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Failure'MetadataEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Failure'MetadataEntry'value
           (\ x__ y__ -> x__ {_Failure'MetadataEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message Failure'MetadataEntry where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.Failure.MetadataEntry"
  packedMessageDescriptor _
    = "\n\
      \\rMetadataEntry\DC2\DLE\n\
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
              Data.ProtoLens.FieldDescriptor Failure'MetadataEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor Failure'MetadataEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Failure'MetadataEntry'_unknownFields
        (\ x__ y__ -> x__ {_Failure'MetadataEntry'_unknownFields = y__})
  defMessage
    = Failure'MetadataEntry'_constructor
        {_Failure'MetadataEntry'key = Data.ProtoLens.fieldDefault,
         _Failure'MetadataEntry'value = Data.ProtoLens.fieldDefault,
         _Failure'MetadataEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Failure'MetadataEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser Failure'MetadataEntry
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
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Failure'MetadataEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Failure'MetadataEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Failure'MetadataEntry'key x__)
                (Control.DeepSeq.deepseq (_Failure'MetadataEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.errorType' @:: Lens' HandlerError Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.failure' @:: Lens' HandlerError Failure@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'failure' @:: Lens' HandlerError (Prelude.Maybe Failure)@ -}
data HandlerError
  = HandlerError'_constructor {_HandlerError'errorType :: !Data.Text.Text,
                               _HandlerError'failure :: !(Prelude.Maybe Failure),
                               _HandlerError'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show HandlerError where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField HandlerError "errorType" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _HandlerError'errorType
           (\ x__ y__ -> x__ {_HandlerError'errorType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField HandlerError "failure" Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _HandlerError'failure
           (\ x__ y__ -> x__ {_HandlerError'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField HandlerError "maybe'failure" (Prelude.Maybe Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _HandlerError'failure
           (\ x__ y__ -> x__ {_HandlerError'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message HandlerError where
  messageName _ = Data.Text.pack "temporal.api.nexus.v1.HandlerError"
  packedMessageDescriptor _
    = "\n\
      \\fHandlerError\DC2\GS\n\
      \\n\
      \error_type\CAN\SOH \SOH(\tR\terrorType\DC28\n\
      \\afailure\CAN\STX \SOH(\v2\RS.temporal.api.nexus.v1.FailureR\afailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        errorType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "error_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"errorType")) ::
              Data.ProtoLens.FieldDescriptor HandlerError
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor HandlerError
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, errorType__field_descriptor),
           (Data.ProtoLens.Tag 2, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _HandlerError'_unknownFields
        (\ x__ y__ -> x__ {_HandlerError'_unknownFields = y__})
  defMessage
    = HandlerError'_constructor
        {_HandlerError'errorType = Data.ProtoLens.fieldDefault,
         _HandlerError'failure = Prelude.Nothing,
         _HandlerError'_unknownFields = []}
  parseMessage
    = let
        loop ::
          HandlerError -> Data.ProtoLens.Encoding.Bytes.Parser HandlerError
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
                                       "error_type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"errorType") y x)
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
          (do loop Data.ProtoLens.defMessage) "HandlerError"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"errorType") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'failure") _x
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
instance Control.DeepSeq.NFData HandlerError where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_HandlerError'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_HandlerError'errorType x__)
                (Control.DeepSeq.deepseq (_HandlerError'failure x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.header' @:: Lens' Request (Data.Map.Map Data.Text.Text Data.Text.Text)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.scheduledTime' @:: Lens' Request Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'scheduledTime' @:: Lens' Request (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'variant' @:: Lens' Request (Prelude.Maybe Request'Variant)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'startOperation' @:: Lens' Request (Prelude.Maybe StartOperationRequest)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.startOperation' @:: Lens' Request StartOperationRequest@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'cancelOperation' @:: Lens' Request (Prelude.Maybe CancelOperationRequest)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.cancelOperation' @:: Lens' Request CancelOperationRequest@ -}
data Request
  = Request'_constructor {_Request'header :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                          _Request'scheduledTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                          _Request'variant :: !(Prelude.Maybe Request'Variant),
                          _Request'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Request where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Request'Variant
  = Request'StartOperation !StartOperationRequest |
    Request'CancelOperation !CancelOperationRequest
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Request "header" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'header (\ x__ y__ -> x__ {_Request'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Request "scheduledTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'scheduledTime
           (\ x__ y__ -> x__ {_Request'scheduledTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Request "maybe'scheduledTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'scheduledTime
           (\ x__ y__ -> x__ {_Request'scheduledTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Request "maybe'variant" (Prelude.Maybe Request'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'variant (\ x__ y__ -> x__ {_Request'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Request "maybe'startOperation" (Prelude.Maybe StartOperationRequest) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'variant (\ x__ y__ -> x__ {_Request'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Request'StartOperation x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Request'StartOperation y__))
instance Data.ProtoLens.Field.HasField Request "startOperation" StartOperationRequest where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'variant (\ x__ y__ -> x__ {_Request'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Request'StartOperation x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Request'StartOperation y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Request "maybe'cancelOperation" (Prelude.Maybe CancelOperationRequest) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'variant (\ x__ y__ -> x__ {_Request'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Request'CancelOperation x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Request'CancelOperation y__))
instance Data.ProtoLens.Field.HasField Request "cancelOperation" CancelOperationRequest where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'variant (\ x__ y__ -> x__ {_Request'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Request'CancelOperation x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Request'CancelOperation y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message Request where
  messageName _ = Data.Text.pack "temporal.api.nexus.v1.Request"
  packedMessageDescriptor _
    = "\n\
      \\aRequest\DC2B\n\
      \\ACKheader\CAN\SOH \ETX(\v2*.temporal.api.nexus.v1.Request.HeaderEntryR\ACKheader\DC2A\n\
      \\SOscheduled_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2W\n\
      \\SIstart_operation\CAN\ETX \SOH(\v2,.temporal.api.nexus.v1.StartOperationRequestH\NULR\SOstartOperation\DC2Z\n\
      \\DLEcancel_operation\CAN\EOT \SOH(\v2-.temporal.api.nexus.v1.CancelOperationRequestH\NULR\SIcancelOperation\SUB9\n\
      \\vHeaderEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOHB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Request'HeaderEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"header")) ::
              Data.ProtoLens.FieldDescriptor Request
        scheduledTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scheduled_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduledTime")) ::
              Data.ProtoLens.FieldDescriptor Request
        startOperation__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_operation"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartOperationRequest)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startOperation")) ::
              Data.ProtoLens.FieldDescriptor Request
        cancelOperation__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel_operation"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CancelOperationRequest)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancelOperation")) ::
              Data.ProtoLens.FieldDescriptor Request
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, header__field_descriptor),
           (Data.ProtoLens.Tag 2, scheduledTime__field_descriptor),
           (Data.ProtoLens.Tag 3, startOperation__field_descriptor),
           (Data.ProtoLens.Tag 4, cancelOperation__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Request'_unknownFields
        (\ x__ y__ -> x__ {_Request'_unknownFields = y__})
  defMessage
    = Request'_constructor
        {_Request'header = Data.Map.empty,
         _Request'scheduledTime = Prelude.Nothing,
         _Request'variant = Prelude.Nothing, _Request'_unknownFields = []}
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
                          -> do !(entry :: Request'HeaderEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
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
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "scheduled_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduledTime") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_operation"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startOperation") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancel_operation"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cancelOperation") y x)
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
                                    (Data.ProtoLens.defMessage :: Request'HeaderEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"header") _x))))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'scheduledTime") _x
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
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
                    of
                      Prelude.Nothing -> Data.Monoid.mempty
                      (Prelude.Just (Request'StartOperation v))
                        -> (Data.Monoid.<>)
                             (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                             ((Prelude..)
                                (\ bs
                                   -> (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (Prelude.fromIntegral (Data.ByteString.length bs)))
                                        (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                Data.ProtoLens.encodeMessage v)
                      (Prelude.Just (Request'CancelOperation v))
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
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Request where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Request'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Request'header x__)
                (Control.DeepSeq.deepseq
                   (_Request'scheduledTime x__)
                   (Control.DeepSeq.deepseq (_Request'variant x__) ())))
instance Control.DeepSeq.NFData Request'Variant where
  rnf (Request'StartOperation x__) = Control.DeepSeq.rnf x__
  rnf (Request'CancelOperation x__) = Control.DeepSeq.rnf x__
_Request'StartOperation ::
  Data.ProtoLens.Prism.Prism' Request'Variant StartOperationRequest
_Request'StartOperation
  = Data.ProtoLens.Prism.prism'
      Request'StartOperation
      (\ p__
         -> case p__ of
              (Request'StartOperation p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Request'CancelOperation ::
  Data.ProtoLens.Prism.Prism' Request'Variant CancelOperationRequest
_Request'CancelOperation
  = Data.ProtoLens.Prism.prism'
      Request'CancelOperation
      (\ p__
         -> case p__ of
              (Request'CancelOperation p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.key' @:: Lens' Request'HeaderEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.value' @:: Lens' Request'HeaderEntry Data.Text.Text@ -}
data Request'HeaderEntry
  = Request'HeaderEntry'_constructor {_Request'HeaderEntry'key :: !Data.Text.Text,
                                      _Request'HeaderEntry'value :: !Data.Text.Text,
                                      _Request'HeaderEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Request'HeaderEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Request'HeaderEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'HeaderEntry'key
           (\ x__ y__ -> x__ {_Request'HeaderEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Request'HeaderEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Request'HeaderEntry'value
           (\ x__ y__ -> x__ {_Request'HeaderEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message Request'HeaderEntry where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.Request.HeaderEntry"
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
              Data.ProtoLens.FieldDescriptor Request'HeaderEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor Request'HeaderEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Request'HeaderEntry'_unknownFields
        (\ x__ y__ -> x__ {_Request'HeaderEntry'_unknownFields = y__})
  defMessage
    = Request'HeaderEntry'_constructor
        {_Request'HeaderEntry'key = Data.ProtoLens.fieldDefault,
         _Request'HeaderEntry'value = Data.ProtoLens.fieldDefault,
         _Request'HeaderEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Request'HeaderEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser Request'HeaderEntry
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
instance Control.DeepSeq.NFData Request'HeaderEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Request'HeaderEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Request'HeaderEntry'key x__)
                (Control.DeepSeq.deepseq (_Request'HeaderEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'variant' @:: Lens' Response (Prelude.Maybe Response'Variant)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'startOperation' @:: Lens' Response (Prelude.Maybe StartOperationResponse)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.startOperation' @:: Lens' Response StartOperationResponse@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'cancelOperation' @:: Lens' Response (Prelude.Maybe CancelOperationResponse)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.cancelOperation' @:: Lens' Response CancelOperationResponse@ -}
data Response
  = Response'_constructor {_Response'variant :: !(Prelude.Maybe Response'Variant),
                           _Response'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Response where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data Response'Variant
  = Response'StartOperation !StartOperationResponse |
    Response'CancelOperation !CancelOperationResponse
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField Response "maybe'variant" (Prelude.Maybe Response'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'variant (\ x__ y__ -> x__ {_Response'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Response "maybe'startOperation" (Prelude.Maybe StartOperationResponse) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'variant (\ x__ y__ -> x__ {_Response'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Response'StartOperation x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Response'StartOperation y__))
instance Data.ProtoLens.Field.HasField Response "startOperation" StartOperationResponse where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'variant (\ x__ y__ -> x__ {_Response'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Response'StartOperation x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Response'StartOperation y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField Response "maybe'cancelOperation" (Prelude.Maybe CancelOperationResponse) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'variant (\ x__ y__ -> x__ {_Response'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (Response'CancelOperation x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap Response'CancelOperation y__))
instance Data.ProtoLens.Field.HasField Response "cancelOperation" CancelOperationResponse where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Response'variant (\ x__ y__ -> x__ {_Response'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (Response'CancelOperation x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap Response'CancelOperation y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message Response where
  messageName _ = Data.Text.pack "temporal.api.nexus.v1.Response"
  packedMessageDescriptor _
    = "\n\
      \\bResponse\DC2X\n\
      \\SIstart_operation\CAN\SOH \SOH(\v2-.temporal.api.nexus.v1.StartOperationResponseH\NULR\SOstartOperation\DC2[\n\
      \\DLEcancel_operation\CAN\STX \SOH(\v2..temporal.api.nexus.v1.CancelOperationResponseH\NULR\SIcancelOperationB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        startOperation__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_operation"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartOperationResponse)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startOperation")) ::
              Data.ProtoLens.FieldDescriptor Response
        cancelOperation__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel_operation"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CancelOperationResponse)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancelOperation")) ::
              Data.ProtoLens.FieldDescriptor Response
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, startOperation__field_descriptor),
           (Data.ProtoLens.Tag 2, cancelOperation__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Response'_unknownFields
        (\ x__ y__ -> x__ {_Response'_unknownFields = y__})
  defMessage
    = Response'_constructor
        {_Response'variant = Prelude.Nothing,
         _Response'_unknownFields = []}
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
                                       "start_operation"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startOperation") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancel_operation"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cancelOperation") y x)
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
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (Response'StartOperation v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (Response'CancelOperation v))
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
instance Control.DeepSeq.NFData Response where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Response'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Response'variant x__) ())
instance Control.DeepSeq.NFData Response'Variant where
  rnf (Response'StartOperation x__) = Control.DeepSeq.rnf x__
  rnf (Response'CancelOperation x__) = Control.DeepSeq.rnf x__
_Response'StartOperation ::
  Data.ProtoLens.Prism.Prism' Response'Variant StartOperationResponse
_Response'StartOperation
  = Data.ProtoLens.Prism.prism'
      Response'StartOperation
      (\ p__
         -> case p__ of
              (Response'StartOperation p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_Response'CancelOperation ::
  Data.ProtoLens.Prism.Prism' Response'Variant CancelOperationResponse
_Response'CancelOperation
  = Data.ProtoLens.Prism.prism'
      Response'CancelOperation
      (\ p__
         -> case p__ of
              (Response'CancelOperation p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.service' @:: Lens' StartOperationRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.operation' @:: Lens' StartOperationRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.requestId' @:: Lens' StartOperationRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.callback' @:: Lens' StartOperationRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.payload' @:: Lens' StartOperationRequest Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'payload' @:: Lens' StartOperationRequest (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.callbackHeader' @:: Lens' StartOperationRequest (Data.Map.Map Data.Text.Text Data.Text.Text)@ -}
data StartOperationRequest
  = StartOperationRequest'_constructor {_StartOperationRequest'service :: !Data.Text.Text,
                                        _StartOperationRequest'operation :: !Data.Text.Text,
                                        _StartOperationRequest'requestId :: !Data.Text.Text,
                                        _StartOperationRequest'callback :: !Data.Text.Text,
                                        _StartOperationRequest'payload :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload),
                                        _StartOperationRequest'callbackHeader :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                                        _StartOperationRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartOperationRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartOperationRequest "service" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'service
           (\ x__ y__ -> x__ {_StartOperationRequest'service = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartOperationRequest "operation" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'operation
           (\ x__ y__ -> x__ {_StartOperationRequest'operation = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartOperationRequest "requestId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'requestId
           (\ x__ y__ -> x__ {_StartOperationRequest'requestId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartOperationRequest "callback" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'callback
           (\ x__ y__ -> x__ {_StartOperationRequest'callback = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartOperationRequest "payload" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'payload
           (\ x__ y__ -> x__ {_StartOperationRequest'payload = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartOperationRequest "maybe'payload" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'payload
           (\ x__ y__ -> x__ {_StartOperationRequest'payload = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartOperationRequest "callbackHeader" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'callbackHeader
           (\ x__ y__ -> x__ {_StartOperationRequest'callbackHeader = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartOperationRequest where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.StartOperationRequest"
  packedMessageDescriptor _
    = "\n\
      \\NAKStartOperationRequest\DC2\CAN\n\
      \\aservice\CAN\SOH \SOH(\tR\aservice\DC2\FS\n\
      \\toperation\CAN\STX \SOH(\tR\toperation\DC2\GS\n\
      \\n\
      \request_id\CAN\ETX \SOH(\tR\trequestId\DC2\SUB\n\
      \\bcallback\CAN\EOT \SOH(\tR\bcallback\DC29\n\
      \\apayload\CAN\ENQ \SOH(\v2\US.temporal.api.common.v1.PayloadR\apayload\DC2i\n\
      \\SIcallback_header\CAN\ACK \ETX(\v2@.temporal.api.nexus.v1.StartOperationRequest.CallbackHeaderEntryR\SOcallbackHeader\SUBA\n\
      \\DC3CallbackHeaderEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        service__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "service"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"service")) ::
              Data.ProtoLens.FieldDescriptor StartOperationRequest
        operation__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operation")) ::
              Data.ProtoLens.FieldDescriptor StartOperationRequest
        requestId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "request_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"requestId")) ::
              Data.ProtoLens.FieldDescriptor StartOperationRequest
        callback__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "callback"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"callback")) ::
              Data.ProtoLens.FieldDescriptor StartOperationRequest
        payload__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "payload"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'payload")) ::
              Data.ProtoLens.FieldDescriptor StartOperationRequest
        callbackHeader__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "callback_header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartOperationRequest'CallbackHeaderEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"callbackHeader")) ::
              Data.ProtoLens.FieldDescriptor StartOperationRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, service__field_descriptor),
           (Data.ProtoLens.Tag 2, operation__field_descriptor),
           (Data.ProtoLens.Tag 3, requestId__field_descriptor),
           (Data.ProtoLens.Tag 4, callback__field_descriptor),
           (Data.ProtoLens.Tag 5, payload__field_descriptor),
           (Data.ProtoLens.Tag 6, callbackHeader__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartOperationRequest'_unknownFields
        (\ x__ y__ -> x__ {_StartOperationRequest'_unknownFields = y__})
  defMessage
    = StartOperationRequest'_constructor
        {_StartOperationRequest'service = Data.ProtoLens.fieldDefault,
         _StartOperationRequest'operation = Data.ProtoLens.fieldDefault,
         _StartOperationRequest'requestId = Data.ProtoLens.fieldDefault,
         _StartOperationRequest'callback = Data.ProtoLens.fieldDefault,
         _StartOperationRequest'payload = Prelude.Nothing,
         _StartOperationRequest'callbackHeader = Data.Map.empty,
         _StartOperationRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartOperationRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser StartOperationRequest
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
                                       "service"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"service") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "operation"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"operation") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "request_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"requestId") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "callback"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"callback") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "payload"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"payload") y x)
                        50
                          -> do !(entry :: StartOperationRequest'CallbackHeaderEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                           (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                               Data.ProtoLens.Encoding.Bytes.isolate
                                                                                                 (Prelude.fromIntegral
                                                                                                    len)
                                                                                                 Data.ProtoLens.parseMessage)
                                                                                           "callback_header"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"callbackHeader")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "StartOperationRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"service") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"operation") _x
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
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"requestId") _x
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
                         _v = Lens.Family2.view (Data.ProtoLens.Field.field @"callback") _x
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
                         (case
                              Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'payload") _x
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
                                                      StartOperationRequest'CallbackHeaderEntry)))))
                                  (Data.Map.toList
                                     (Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"callbackHeader") _x))))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData StartOperationRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartOperationRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartOperationRequest'service x__)
                (Control.DeepSeq.deepseq
                   (_StartOperationRequest'operation x__)
                   (Control.DeepSeq.deepseq
                      (_StartOperationRequest'requestId x__)
                      (Control.DeepSeq.deepseq
                         (_StartOperationRequest'callback x__)
                         (Control.DeepSeq.deepseq
                            (_StartOperationRequest'payload x__)
                            (Control.DeepSeq.deepseq
                               (_StartOperationRequest'callbackHeader x__) ()))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.key' @:: Lens' StartOperationRequest'CallbackHeaderEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.value' @:: Lens' StartOperationRequest'CallbackHeaderEntry Data.Text.Text@ -}
data StartOperationRequest'CallbackHeaderEntry
  = StartOperationRequest'CallbackHeaderEntry'_constructor {_StartOperationRequest'CallbackHeaderEntry'key :: !Data.Text.Text,
                                                            _StartOperationRequest'CallbackHeaderEntry'value :: !Data.Text.Text,
                                                            _StartOperationRequest'CallbackHeaderEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartOperationRequest'CallbackHeaderEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartOperationRequest'CallbackHeaderEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'CallbackHeaderEntry'key
           (\ x__ y__
              -> x__ {_StartOperationRequest'CallbackHeaderEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartOperationRequest'CallbackHeaderEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationRequest'CallbackHeaderEntry'value
           (\ x__ y__
              -> x__ {_StartOperationRequest'CallbackHeaderEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartOperationRequest'CallbackHeaderEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.nexus.v1.StartOperationRequest.CallbackHeaderEntry"
  packedMessageDescriptor _
    = "\n\
      \\DC3CallbackHeaderEntry\DC2\DLE\n\
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
              Data.ProtoLens.FieldDescriptor StartOperationRequest'CallbackHeaderEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor StartOperationRequest'CallbackHeaderEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartOperationRequest'CallbackHeaderEntry'_unknownFields
        (\ x__ y__
           -> x__
                {_StartOperationRequest'CallbackHeaderEntry'_unknownFields = y__})
  defMessage
    = StartOperationRequest'CallbackHeaderEntry'_constructor
        {_StartOperationRequest'CallbackHeaderEntry'key = Data.ProtoLens.fieldDefault,
         _StartOperationRequest'CallbackHeaderEntry'value = Data.ProtoLens.fieldDefault,
         _StartOperationRequest'CallbackHeaderEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartOperationRequest'CallbackHeaderEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser StartOperationRequest'CallbackHeaderEntry
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
          (do loop Data.ProtoLens.defMessage) "CallbackHeaderEntry"
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
instance Control.DeepSeq.NFData StartOperationRequest'CallbackHeaderEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartOperationRequest'CallbackHeaderEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartOperationRequest'CallbackHeaderEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_StartOperationRequest'CallbackHeaderEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'variant' @:: Lens' StartOperationResponse (Prelude.Maybe StartOperationResponse'Variant)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'syncSuccess' @:: Lens' StartOperationResponse (Prelude.Maybe StartOperationResponse'Sync)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.syncSuccess' @:: Lens' StartOperationResponse StartOperationResponse'Sync@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'asyncSuccess' @:: Lens' StartOperationResponse (Prelude.Maybe StartOperationResponse'Async)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.asyncSuccess' @:: Lens' StartOperationResponse StartOperationResponse'Async@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'operationError' @:: Lens' StartOperationResponse (Prelude.Maybe UnsuccessfulOperationError)@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.operationError' @:: Lens' StartOperationResponse UnsuccessfulOperationError@ -}
data StartOperationResponse
  = StartOperationResponse'_constructor {_StartOperationResponse'variant :: !(Prelude.Maybe StartOperationResponse'Variant),
                                         _StartOperationResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartOperationResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data StartOperationResponse'Variant
  = StartOperationResponse'SyncSuccess !StartOperationResponse'Sync |
    StartOperationResponse'AsyncSuccess !StartOperationResponse'Async |
    StartOperationResponse'OperationError !UnsuccessfulOperationError
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField StartOperationResponse "maybe'variant" (Prelude.Maybe StartOperationResponse'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'variant
           (\ x__ y__ -> x__ {_StartOperationResponse'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartOperationResponse "maybe'syncSuccess" (Prelude.Maybe StartOperationResponse'Sync) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'variant
           (\ x__ y__ -> x__ {_StartOperationResponse'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (StartOperationResponse'SyncSuccess x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap StartOperationResponse'SyncSuccess y__))
instance Data.ProtoLens.Field.HasField StartOperationResponse "syncSuccess" StartOperationResponse'Sync where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'variant
           (\ x__ y__ -> x__ {_StartOperationResponse'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (StartOperationResponse'SyncSuccess x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap StartOperationResponse'SyncSuccess y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField StartOperationResponse "maybe'asyncSuccess" (Prelude.Maybe StartOperationResponse'Async) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'variant
           (\ x__ y__ -> x__ {_StartOperationResponse'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (StartOperationResponse'AsyncSuccess x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap StartOperationResponse'AsyncSuccess y__))
instance Data.ProtoLens.Field.HasField StartOperationResponse "asyncSuccess" StartOperationResponse'Async where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'variant
           (\ x__ y__ -> x__ {_StartOperationResponse'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (StartOperationResponse'AsyncSuccess x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap StartOperationResponse'AsyncSuccess y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField StartOperationResponse "maybe'operationError" (Prelude.Maybe UnsuccessfulOperationError) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'variant
           (\ x__ y__ -> x__ {_StartOperationResponse'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (StartOperationResponse'OperationError x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap StartOperationResponse'OperationError y__))
instance Data.ProtoLens.Field.HasField StartOperationResponse "operationError" UnsuccessfulOperationError where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'variant
           (\ x__ y__ -> x__ {_StartOperationResponse'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (StartOperationResponse'OperationError x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap StartOperationResponse'OperationError y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message StartOperationResponse where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.StartOperationResponse"
  packedMessageDescriptor _
    = "\n\
      \\SYNStartOperationResponse\DC2W\n\
      \\fsync_success\CAN\SOH \SOH(\v22.temporal.api.nexus.v1.StartOperationResponse.SyncH\NULR\vsyncSuccess\DC2Z\n\
      \\rasync_success\CAN\STX \SOH(\v23.temporal.api.nexus.v1.StartOperationResponse.AsyncH\NULR\fasyncSuccess\DC2\\\n\
      \\SIoperation_error\CAN\ETX \SOH(\v21.temporal.api.nexus.v1.UnsuccessfulOperationErrorH\NULR\SOoperationError\SUBA\n\
      \\EOTSync\DC29\n\
      \\apayload\CAN\SOH \SOH(\v2\US.temporal.api.common.v1.PayloadR\apayload\SUB*\n\
      \\ENQAsync\DC2!\n\
      \\foperation_id\CAN\SOH \SOH(\tR\voperationIdB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        syncSuccess__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sync_success"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartOperationResponse'Sync)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'syncSuccess")) ::
              Data.ProtoLens.FieldDescriptor StartOperationResponse
        asyncSuccess__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "async_success"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartOperationResponse'Async)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'asyncSuccess")) ::
              Data.ProtoLens.FieldDescriptor StartOperationResponse
        operationError__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation_error"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor UnsuccessfulOperationError)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'operationError")) ::
              Data.ProtoLens.FieldDescriptor StartOperationResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, syncSuccess__field_descriptor),
           (Data.ProtoLens.Tag 2, asyncSuccess__field_descriptor),
           (Data.ProtoLens.Tag 3, operationError__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartOperationResponse'_unknownFields
        (\ x__ y__ -> x__ {_StartOperationResponse'_unknownFields = y__})
  defMessage
    = StartOperationResponse'_constructor
        {_StartOperationResponse'variant = Prelude.Nothing,
         _StartOperationResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartOperationResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser StartOperationResponse
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
                                       "sync_success"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"syncSuccess") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "async_success"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"asyncSuccess") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "operation_error"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"operationError") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "StartOperationResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (StartOperationResponse'SyncSuccess v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (StartOperationResponse'AsyncSuccess v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (StartOperationResponse'OperationError v))
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
instance Control.DeepSeq.NFData StartOperationResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartOperationResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq (_StartOperationResponse'variant x__) ())
instance Control.DeepSeq.NFData StartOperationResponse'Variant where
  rnf (StartOperationResponse'SyncSuccess x__)
    = Control.DeepSeq.rnf x__
  rnf (StartOperationResponse'AsyncSuccess x__)
    = Control.DeepSeq.rnf x__
  rnf (StartOperationResponse'OperationError x__)
    = Control.DeepSeq.rnf x__
_StartOperationResponse'SyncSuccess ::
  Data.ProtoLens.Prism.Prism' StartOperationResponse'Variant StartOperationResponse'Sync
_StartOperationResponse'SyncSuccess
  = Data.ProtoLens.Prism.prism'
      StartOperationResponse'SyncSuccess
      (\ p__
         -> case p__ of
              (StartOperationResponse'SyncSuccess p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_StartOperationResponse'AsyncSuccess ::
  Data.ProtoLens.Prism.Prism' StartOperationResponse'Variant StartOperationResponse'Async
_StartOperationResponse'AsyncSuccess
  = Data.ProtoLens.Prism.prism'
      StartOperationResponse'AsyncSuccess
      (\ p__
         -> case p__ of
              (StartOperationResponse'AsyncSuccess p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_StartOperationResponse'OperationError ::
  Data.ProtoLens.Prism.Prism' StartOperationResponse'Variant UnsuccessfulOperationError
_StartOperationResponse'OperationError
  = Data.ProtoLens.Prism.prism'
      StartOperationResponse'OperationError
      (\ p__
         -> case p__ of
              (StartOperationResponse'OperationError p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.operationId' @:: Lens' StartOperationResponse'Async Data.Text.Text@ -}
data StartOperationResponse'Async
  = StartOperationResponse'Async'_constructor {_StartOperationResponse'Async'operationId :: !Data.Text.Text,
                                               _StartOperationResponse'Async'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartOperationResponse'Async where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartOperationResponse'Async "operationId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'Async'operationId
           (\ x__ y__
              -> x__ {_StartOperationResponse'Async'operationId = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartOperationResponse'Async where
  messageName _
    = Data.Text.pack
        "temporal.api.nexus.v1.StartOperationResponse.Async"
  packedMessageDescriptor _
    = "\n\
      \\ENQAsync\DC2!\n\
      \\foperation_id\CAN\SOH \SOH(\tR\voperationId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        operationId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operationId")) ::
              Data.ProtoLens.FieldDescriptor StartOperationResponse'Async
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, operationId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartOperationResponse'Async'_unknownFields
        (\ x__ y__
           -> x__ {_StartOperationResponse'Async'_unknownFields = y__})
  defMessage
    = StartOperationResponse'Async'_constructor
        {_StartOperationResponse'Async'operationId = Data.ProtoLens.fieldDefault,
         _StartOperationResponse'Async'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartOperationResponse'Async
          -> Data.ProtoLens.Encoding.Bytes.Parser StartOperationResponse'Async
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
                                       "operation_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"operationId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Async"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"operationId") _x
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
instance Control.DeepSeq.NFData StartOperationResponse'Async where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartOperationResponse'Async'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartOperationResponse'Async'operationId x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.payload' @:: Lens' StartOperationResponse'Sync Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'payload' @:: Lens' StartOperationResponse'Sync (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data StartOperationResponse'Sync
  = StartOperationResponse'Sync'_constructor {_StartOperationResponse'Sync'payload :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload),
                                              _StartOperationResponse'Sync'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartOperationResponse'Sync where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartOperationResponse'Sync "payload" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'Sync'payload
           (\ x__ y__ -> x__ {_StartOperationResponse'Sync'payload = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartOperationResponse'Sync "maybe'payload" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartOperationResponse'Sync'payload
           (\ x__ y__ -> x__ {_StartOperationResponse'Sync'payload = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartOperationResponse'Sync where
  messageName _
    = Data.Text.pack
        "temporal.api.nexus.v1.StartOperationResponse.Sync"
  packedMessageDescriptor _
    = "\n\
      \\EOTSync\DC29\n\
      \\apayload\CAN\SOH \SOH(\v2\US.temporal.api.common.v1.PayloadR\apayload"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        payload__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "payload"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'payload")) ::
              Data.ProtoLens.FieldDescriptor StartOperationResponse'Sync
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, payload__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartOperationResponse'Sync'_unknownFields
        (\ x__ y__
           -> x__ {_StartOperationResponse'Sync'_unknownFields = y__})
  defMessage
    = StartOperationResponse'Sync'_constructor
        {_StartOperationResponse'Sync'payload = Prelude.Nothing,
         _StartOperationResponse'Sync'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartOperationResponse'Sync
          -> Data.ProtoLens.Encoding.Bytes.Parser StartOperationResponse'Sync
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
                                       "payload"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"payload") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Sync"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'payload") _x
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
instance Control.DeepSeq.NFData StartOperationResponse'Sync where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartOperationResponse'Sync'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartOperationResponse'Sync'payload x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.operationState' @:: Lens' UnsuccessfulOperationError Data.Text.Text@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.failure' @:: Lens' UnsuccessfulOperationError Failure@
         * 'Proto.Temporal.Api.Nexus.V1.Message_Fields.maybe'failure' @:: Lens' UnsuccessfulOperationError (Prelude.Maybe Failure)@ -}
data UnsuccessfulOperationError
  = UnsuccessfulOperationError'_constructor {_UnsuccessfulOperationError'operationState :: !Data.Text.Text,
                                             _UnsuccessfulOperationError'failure :: !(Prelude.Maybe Failure),
                                             _UnsuccessfulOperationError'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UnsuccessfulOperationError where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UnsuccessfulOperationError "operationState" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UnsuccessfulOperationError'operationState
           (\ x__ y__
              -> x__ {_UnsuccessfulOperationError'operationState = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UnsuccessfulOperationError "failure" Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UnsuccessfulOperationError'failure
           (\ x__ y__ -> x__ {_UnsuccessfulOperationError'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField UnsuccessfulOperationError "maybe'failure" (Prelude.Maybe Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UnsuccessfulOperationError'failure
           (\ x__ y__ -> x__ {_UnsuccessfulOperationError'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message UnsuccessfulOperationError where
  messageName _
    = Data.Text.pack "temporal.api.nexus.v1.UnsuccessfulOperationError"
  packedMessageDescriptor _
    = "\n\
      \\SUBUnsuccessfulOperationError\DC2'\n\
      \\SIoperation_state\CAN\SOH \SOH(\tR\SOoperationState\DC28\n\
      \\afailure\CAN\STX \SOH(\v2\RS.temporal.api.nexus.v1.FailureR\afailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        operationState__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation_state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operationState")) ::
              Data.ProtoLens.FieldDescriptor UnsuccessfulOperationError
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor UnsuccessfulOperationError
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, operationState__field_descriptor),
           (Data.ProtoLens.Tag 2, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UnsuccessfulOperationError'_unknownFields
        (\ x__ y__
           -> x__ {_UnsuccessfulOperationError'_unknownFields = y__})
  defMessage
    = UnsuccessfulOperationError'_constructor
        {_UnsuccessfulOperationError'operationState = Data.ProtoLens.fieldDefault,
         _UnsuccessfulOperationError'failure = Prelude.Nothing,
         _UnsuccessfulOperationError'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UnsuccessfulOperationError
          -> Data.ProtoLens.Encoding.Bytes.Parser UnsuccessfulOperationError
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
                                       "operation_state"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"operationState") y x)
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
          (do loop Data.ProtoLens.defMessage) "UnsuccessfulOperationError"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"operationState") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'failure") _x
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
instance Control.DeepSeq.NFData UnsuccessfulOperationError where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UnsuccessfulOperationError'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_UnsuccessfulOperationError'operationState x__)
                (Control.DeepSeq.deepseq
                   (_UnsuccessfulOperationError'failure x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \#temporal/api/nexus/v1/message.proto\DC2\NAKtemporal.api.nexus.v1\SUB\USgoogle/protobuf/timestamp.proto\SUB$temporal/api/common/v1/message.proto\"\196\SOH\n\
    \\aFailure\DC2\CAN\n\
    \\amessage\CAN\SOH \SOH(\tR\amessage\DC2H\n\
    \\bmetadata\CAN\STX \ETX(\v2,.temporal.api.nexus.v1.Failure.MetadataEntryR\bmetadata\DC2\CAN\n\
    \\adetails\CAN\ETX \SOH(\fR\adetails\SUB;\n\
    \\rMetadataEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\"g\n\
    \\fHandlerError\DC2\GS\n\
    \\n\
    \error_type\CAN\SOH \SOH(\tR\terrorType\DC28\n\
    \\afailure\CAN\STX \SOH(\v2\RS.temporal.api.nexus.v1.FailureR\afailure\"\DEL\n\
    \\SUBUnsuccessfulOperationError\DC2'\n\
    \\SIoperation_state\CAN\SOH \SOH(\tR\SOoperationState\DC28\n\
    \\afailure\CAN\STX \SOH(\v2\RS.temporal.api.nexus.v1.FailureR\afailure\"\243\STX\n\
    \\NAKStartOperationRequest\DC2\CAN\n\
    \\aservice\CAN\SOH \SOH(\tR\aservice\DC2\FS\n\
    \\toperation\CAN\STX \SOH(\tR\toperation\DC2\GS\n\
    \\n\
    \request_id\CAN\ETX \SOH(\tR\trequestId\DC2\SUB\n\
    \\bcallback\CAN\EOT \SOH(\tR\bcallback\DC29\n\
    \\apayload\CAN\ENQ \SOH(\v2\US.temporal.api.common.v1.PayloadR\apayload\DC2i\n\
    \\SIcallback_header\CAN\ACK \ETX(\v2@.temporal.api.nexus.v1.StartOperationRequest.CallbackHeaderEntryR\SOcallbackHeader\SUBA\n\
    \\DC3CallbackHeaderEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\"s\n\
    \\SYNCancelOperationRequest\DC2\CAN\n\
    \\aservice\CAN\SOH \SOH(\tR\aservice\DC2\FS\n\
    \\toperation\CAN\STX \SOH(\tR\toperation\DC2!\n\
    \\foperation_id\CAN\ETX \SOH(\tR\voperationId\"\139\ETX\n\
    \\aRequest\DC2B\n\
    \\ACKheader\CAN\SOH \ETX(\v2*.temporal.api.nexus.v1.Request.HeaderEntryR\ACKheader\DC2A\n\
    \\SOscheduled_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2W\n\
    \\SIstart_operation\CAN\ETX \SOH(\v2,.temporal.api.nexus.v1.StartOperationRequestH\NULR\SOstartOperation\DC2Z\n\
    \\DLEcancel_operation\CAN\EOT \SOH(\v2-.temporal.api.nexus.v1.CancelOperationRequestH\NULR\SIcancelOperation\SUB9\n\
    \\vHeaderEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOHB\t\n\
    \\avariant\"\165\ETX\n\
    \\SYNStartOperationResponse\DC2W\n\
    \\fsync_success\CAN\SOH \SOH(\v22.temporal.api.nexus.v1.StartOperationResponse.SyncH\NULR\vsyncSuccess\DC2Z\n\
    \\rasync_success\CAN\STX \SOH(\v23.temporal.api.nexus.v1.StartOperationResponse.AsyncH\NULR\fasyncSuccess\DC2\\\n\
    \\SIoperation_error\CAN\ETX \SOH(\v21.temporal.api.nexus.v1.UnsuccessfulOperationErrorH\NULR\SOoperationError\SUBA\n\
    \\EOTSync\DC29\n\
    \\apayload\CAN\SOH \SOH(\v2\US.temporal.api.common.v1.PayloadR\apayload\SUB*\n\
    \\ENQAsync\DC2!\n\
    \\foperation_id\CAN\SOH \SOH(\tR\voperationIdB\t\n\
    \\avariant\"\EM\n\
    \\ETBCancelOperationResponse\"\204\SOH\n\
    \\bResponse\DC2X\n\
    \\SIstart_operation\CAN\SOH \SOH(\v2-.temporal.api.nexus.v1.StartOperationResponseH\NULR\SOstartOperation\DC2[\n\
    \\DLEcancel_operation\CAN\STX \SOH(\v2..temporal.api.nexus.v1.CancelOperationResponseH\NULR\SIcancelOperationB\t\n\
    \\avariant\"\149\STX\n\
    \\bEndpoint\DC2\CAN\n\
    \\aversion\CAN\SOH \SOH(\ETXR\aversion\DC2\SO\n\
    \\STXid\CAN\STX \SOH(\tR\STXid\DC27\n\
    \\EOTspec\CAN\ETX \SOH(\v2#.temporal.api.nexus.v1.EndpointSpecR\EOTspec\DC2=\n\
    \\fcreated_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\vcreatedTime\DC2H\n\
    \\DC2last_modified_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DLElastModifiedTime\DC2\GS\n\
    \\n\
    \url_prefix\CAN\ACK \SOH(\tR\turlPrefix\"\164\SOH\n\
    \\fEndpointSpec\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2A\n\
    \\vdescription\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\vdescription\DC2=\n\
    \\ACKtarget\CAN\ETX \SOH(\v2%.temporal.api.nexus.v1.EndpointTargetR\ACKtarget\"\150\STX\n\
    \\SOEndpointTarget\DC2F\n\
    \\ACKworker\CAN\SOH \SOH(\v2,.temporal.api.nexus.v1.EndpointTarget.WorkerH\NULR\ACKworker\DC2L\n\
    \\bexternal\CAN\STX \SOH(\v2..temporal.api.nexus.v1.EndpointTarget.ExternalH\NULR\bexternal\SUBE\n\
    \\ACKWorker\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\GS\n\
    \\n\
    \task_queue\CAN\STX \SOH(\tR\ttaskQueue\SUB\FS\n\
    \\bExternal\DC2\DLE\n\
    \\ETXurl\CAN\SOH \SOH(\tR\ETXurlB\t\n\
    \\avariantB\132\SOH\n\
    \\CANio.temporal.api.nexus.v1B\fMessageProtoP\SOHZ!go.temporal.io/api/nexus/v1;nexus\170\STX\ETBTemporalio.Api.Nexus.V1\234\STX\SUBTemporalio::Api::Nexus::V1J\224\&9\n\
    \\a\DC2\ENQ\DC4\NUL\192\SOH\SOH\n\
    \\211\a\n\
    \\SOH\f\DC2\ETX\DC4\NUL\DC22\200\a The MIT License\n\
    \\n\
    \ Copyright (c) 2023 Temporal Technologies Inc. All rights reserved.\n\
    \\n\
    \ Permission is hereby granted, free of charge, to any person obtaining a copy\n\
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
    \\SOH\STX\DC2\ETX\SYN\NUL\RS\n\
    \\b\n\
    \\SOH\b\DC2\ETX\CAN\NUL8\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\CAN\NUL8\n\
    \\b\n\
    \\SOH\b\DC2\ETX\EM\NUL1\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\EM\NUL1\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\SUB\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL-\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\ESC\NUL-\n\
    \\b\n\
    \\SOH\b\DC2\ETX\FS\NUL3\n\
    \\t\n\
    \\STX\b-\DC2\ETX\FS\NUL3\n\
    \\b\n\
    \\SOH\b\DC2\ETX\GS\NUL4\n\
    \\t\n\
    \\STX\b%\DC2\ETX\GS\NUL4\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\US\NUL)\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX \NUL.\n\
    \q\n\
    \\STX\EOT\NUL\DC2\EOT$\NUL(\SOH\SUBe A general purpose failure message.\n\
    \ See: https://github.com/nexus-rpc/api/blob/main/SPEC.md#failure\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX$\b\SI\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX%\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX%\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX%\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX%\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX&\EOT%\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX&\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX&\CAN \n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX&#$\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX'\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX'\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX'\n\
    \\DC1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX'\DC4\NAK\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT*\NUL.\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX*\b\DC4\n\
    \`\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX,\EOT\SUB\SUBS See https://github.com/nexus-rpc/api/blob/main/SPEC.md#predefined-handler-errors.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX,\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX,\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX,\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX-\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX-\EOT\v\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX-\f\DC3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX-\SYN\ETB\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT0\NUL4\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX0\b\"\n\
    \T\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX2\EOT\US\SUBG See https://github.com/nexus-rpc/api/blob/main/SPEC.md#operationinfo.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX2\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX2\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX2\GS\RS\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX3\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETX3\EOT\v\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX3\f\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX3\SYN\ETB\n\
    \.\n\
    \\STX\EOT\ETX\DC2\EOT7\NULD\SOH\SUB\" A request to start an operation.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX7\b\GS\n\
    \9\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX9\EOT\ETB\SUB, Name of service to start the operation in.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETX9\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX9\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX9\NAK\SYN\n\
    \*\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETX;\EOT\EM\SUB\GS Type of operation to start.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETX;\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETX;\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETX;\ETB\CAN\n\
    \F\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETX=\EOT\SUB\SUB9 A request ID that can be used as an idempotentency key.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ENQ\DC2\ETX=\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETX=\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETX=\CAN\EM\n\
    \V\n\
    \\EOT\EOT\ETX\STX\ETX\DC2\ETX?\EOT\CAN\SUBI Callback URL to call upon completion if the started operation is async.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ENQ\DC2\ETX?\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\SOH\DC2\ETX?\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ETX\DC2\ETX?\SYN\ETB\n\
    \@\n\
    \\EOT\EOT\ETX\STX\EOT\DC2\ETXA\EOT/\SUB3 Full request body from the incoming HTTP request.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ACK\DC2\ETXA\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\SOH\DC2\ETXA#*\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ETX\DC2\ETXA-.\n\
    \k\n\
    \\EOT\EOT\ETX\STX\ENQ\DC2\ETXC\EOT,\SUB^ Header that is expected to be attached to the callback request when the operation completes.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\ACK\DC2\ETXC\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\SOH\DC2\ETXC\CAN'\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\ETX\DC2\ETXC*+\n\
    \/\n\
    \\STX\EOT\EOT\DC2\EOTG\NULN\SOH\SUB# A request to cancel an operation.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXG\b\RS\n\
    \\FS\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXI\EOT\ETB\SUB\SI Service name.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETXI\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXI\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXI\NAK\SYN\n\
    \+\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\ETXK\EOT\EM\SUB\RS Type of operation to cancel.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ENQ\DC2\ETXK\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\ETXK\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\ETXK\ETB\CAN\n\
    \A\n\
    \\EOT\EOT\EOT\STX\STX\DC2\ETXM\EOT\FS\SUB4 Operation ID as originally generated by a Handler.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ENQ\DC2\ETXM\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\SOH\DC2\ETXM\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ETX\DC2\ETXM\SUB\ESC\n\
    \\RS\n\
    \\STX\EOT\ENQ\DC2\EOTQ\NUL_\SOH\SUB\DC2 A Nexus request.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXQ\b\SI\n\
    \\181\SOH\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXT\EOT#\SUB\167\SOH Headers extracted from the original request in the Temporal frontend.\n\
    \ When using Nexus over HTTP, this includes the request's HTTP headers ignoring multiple values.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETXT\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXT\CAN\RS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXT!\"\n\
    \\192\SOH\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETXY\EOT1\SUB\178\SOH The timestamp when the request was scheduled in the frontend.\n\
    \ (-- api-linter: core::0142::time-field-names=disabled\n\
    \     aip.dev/not-precedent: Not following linter rules. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\ETXY\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETXY\RS,\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETXY/0\n\
    \\f\n\
    \\EOT\EOT\ENQ\b\NUL\DC2\EOT[\EOT^\ENQ\n\
    \\f\n\
    \\ENQ\EOT\ENQ\b\NUL\SOH\DC2\ETX[\n\
    \\DC1\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\ETX\\\b2\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ACK\DC2\ETX\\\b\GS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\ETX\\\RS-\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\ETX\\01\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\ETX\DC2\ETX]\b4\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ACK\DC2\ETX]\b\RS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\SOH\DC2\ETX]\US/\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ETX\DC2\ETX]23\n\
    \9\n\
    \\STX\EOT\ACK\DC2\EOTb\NULt\SOH\SUB- Response variant for StartOperationRequest.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXb\b\RS\n\
    \4\n\
    \\EOT\EOT\ACK\ETX\NUL\DC2\EOTd\EOTf\ENQ\SUB& An operation completed successfully.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\ETX\NUL\SOH\DC2\ETXd\f\DLE\n\
    \\r\n\
    \\ACK\EOT\ACK\ETX\NUL\STX\NUL\DC2\ETXe\b3\n\
    \\SO\n\
    \\a\EOT\ACK\ETX\NUL\STX\NUL\ACK\DC2\ETXe\b&\n\
    \\SO\n\
    \\a\EOT\ACK\ETX\NUL\STX\NUL\SOH\DC2\ETXe'.\n\
    \\SO\n\
    \\a\EOT\ACK\ETX\NUL\STX\NUL\ETX\DC2\ETXe12\n\
    \u\n\
    \\EOT\EOT\ACK\ETX\SOH\DC2\EOTj\EOTl\ENQ\SUBg The operation will complete asynchronously.\n\
    \ The returned ID can be used to reference this operation.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\ETX\SOH\SOH\DC2\ETXj\f\DC1\n\
    \\r\n\
    \\ACK\EOT\ACK\ETX\SOH\STX\NUL\DC2\ETXk\b \n\
    \\SO\n\
    \\a\EOT\ACK\ETX\SOH\STX\NUL\ENQ\DC2\ETXk\b\SO\n\
    \\SO\n\
    \\a\EOT\ACK\ETX\SOH\STX\NUL\SOH\DC2\ETXk\SI\ESC\n\
    \\SO\n\
    \\a\EOT\ACK\ETX\SOH\STX\NUL\ETX\DC2\ETXk\RS\US\n\
    \\f\n\
    \\EOT\EOT\ACK\b\NUL\DC2\EOTn\EOTs\ENQ\n\
    \\f\n\
    \\ENQ\EOT\ACK\b\NUL\SOH\DC2\ETXn\n\
    \\DC1\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXo\b\RS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ACK\DC2\ETXo\b\f\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXo\r\EM\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXo\FS\GS\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXp\b \n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ACK\DC2\ETXp\b\r\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXp\SO\ESC\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXp\RS\US\n\
    \K\n\
    \\EOT\EOT\ACK\STX\STX\DC2\ETXr\b7\SUB> The operation completed unsuccessfully (failed or canceled).\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ACK\DC2\ETXr\b\"\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\ETXr#2\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\ETXr56\n\
    \:\n\
    \\STX\EOT\a\DC2\EOTw\NULx\SOH\SUB. Response variant for CancelOperationRequest.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXw\b\US\n\
    \[\n\
    \\STX\EOT\b\DC2\ENQ{\NUL\129\SOH\SOH\SUBN A response indicating that the handler has successfully processed a request.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETX{\b\DLE\n\
    \O\n\
    \\EOT\EOT\b\b\NUL\DC2\ENQ}\EOT\128\SOH\ENQ\SUB@ Variant must correlate to the corresponding Request's variant.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\b\NUL\SOH\DC2\ETX}\n\
    \\DC1\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETX~\b3\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ACK\DC2\ETX~\b\RS\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETX~\US.\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETX~12\n\
    \\v\n\
    \\EOT\EOT\b\STX\SOH\DC2\ETX\DEL\b5\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ACK\DC2\ETX\DEL\b\US\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\ETX\DEL 0\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\ETX\DEL34\n\
    \q\n\
    \\STX\EOT\t\DC2\ACK\132\SOH\NUL\155\SOH\SOH\SUBc A cluster-global binding from an endpoint ID to a target for dispatching incoming Nexus requests.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\t\SOH\DC2\EOT\132\SOH\b\DLE\n\
    \t\n\
    \\EOT\EOT\t\STX\NUL\DC2\EOT\134\SOH\EOT\SYN\SUBf Data version for this endpoint, incremented for every update issued via the UpdateNexusEndpoint API.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ENQ\DC2\EOT\134\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\EOT\134\SOH\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\EOT\134\SOH\DC4\NAK\n\
    \4\n\
    \\EOT\EOT\t\STX\SOH\DC2\EOT\136\SOH\EOT\DC2\SUB& Unique server-generated endpoint ID.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\SOH\ENQ\DC2\EOT\136\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\EOT\136\SOH\v\r\n\
    \\r\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\EOT\136\SOH\DLE\DC1\n\
    \&\n\
    \\EOT\EOT\t\STX\STX\DC2\EOT\138\SOH\EOT\SUB\SUB\CAN Spec for the endpoint.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\STX\ACK\DC2\EOT\138\SOH\EOT\DLE\n\
    \\r\n\
    \\ENQ\EOT\t\STX\STX\SOH\DC2\EOT\138\SOH\DC1\NAK\n\
    \\r\n\
    \\ENQ\EOT\t\STX\STX\ETX\DC2\EOT\138\SOH\CAN\EM\n\
    \\180\SOH\n\
    \\EOT\EOT\t\STX\ETX\DC2\EOT\143\SOH\EOT/\SUB\165\SOH The date and time when the endpoint was created.\n\
    \ (-- api-linter: core::0142::time-field-names=disabled\n\
    \     aip.dev/not-precedent: Not following linter rules. --)\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\ETX\ACK\DC2\EOT\143\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\t\STX\ETX\SOH\DC2\EOT\143\SOH\RS*\n\
    \\r\n\
    \\ENQ\EOT\t\STX\ETX\ETX\DC2\EOT\143\SOH-.\n\
    \\244\SOH\n\
    \\EOT\EOT\t\STX\EOT\DC2\EOT\149\SOH\EOT5\SUB\229\SOH The date and time when the endpoint was last modified.\n\
    \ Will not be set if the endpoint has never been modified.\n\
    \ (-- api-linter: core::0142::time-field-names=disabled\n\
    \     aip.dev/not-precedent: Not following linter rules. --)\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\EOT\ACK\DC2\EOT\149\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\t\STX\EOT\SOH\DC2\EOT\149\SOH\RS0\n\
    \\r\n\
    \\ENQ\EOT\t\STX\EOT\ETX\DC2\EOT\149\SOH34\n\
    \\130\STX\n\
    \\EOT\EOT\t\STX\ENQ\DC2\EOT\154\SOH\EOT\SUB\SUB\243\SOH Server exposed URL prefix for invocation of operations on this endpoint.\n\
    \ This doesn't include the protocol, hostname or port as the server does not know how it should be accessed\n\
    \ publicly. The URL is stable in the face of endpoint renames.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\ENQ\ENQ\DC2\EOT\154\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\ENQ\SOH\DC2\EOT\154\SOH\v\NAK\n\
    \\r\n\
    \\ENQ\EOT\t\STX\ENQ\ETX\DC2\EOT\154\SOH\CAN\EM\n\
    \8\n\
    \\STX\EOT\n\
    \\DC2\ACK\158\SOH\NUL\168\SOH\SOH\SUB* Contains mutable fields for an Endpoint.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\n\
    \\SOH\DC2\EOT\158\SOH\b\DC4\n\
    \\201\SOH\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\EOT\161\SOH\EOT\DC4\SUB\186\SOH Endpoint name, unique for this cluster. Must match `[a-zA-Z_][a-zA-Z0-9_]*`.\n\
    \ Renaming an endpoint breaks all workflow callers that reference this endpoint, causing operations to fail.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\EOT\161\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\EOT\161\SOH\v\SI\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\EOT\161\SOH\DC2\DC3\n\
    \\173\SOH\n\
    \\EOT\EOT\n\
    \\STX\SOH\DC2\EOT\164\SOH\EOT3\SUB\158\SOH Markdown description serialized as a single JSON string.\n\
    \ If the Payload is encrypted, the UI and CLI may decrypt with the configured codec server endpoint.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ACK\DC2\EOT\164\SOH\EOT\"\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\SOH\SOH\DC2\EOT\164\SOH#.\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ETX\DC2\EOT\164\SOH12\n\
    \,\n\
    \\EOT\EOT\n\
    \\STX\STX\DC2\EOT\167\SOH\EOT\RS\SUB\RS Target to route requests to.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\STX\ACK\DC2\EOT\167\SOH\EOT\DC2\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\STX\SOH\DC2\EOT\167\SOH\DC3\EM\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\STX\ETX\DC2\EOT\167\SOH\FS\GS\n\
    \,\n\
    \\STX\EOT\v\DC2\ACK\171\SOH\NUL\192\SOH\SOH\SUB\RS Target to route requests to.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\v\SOH\DC2\EOT\171\SOH\b\SYN\n\
    \X\n\
    \\EOT\EOT\v\ETX\NUL\DC2\ACK\173\SOH\EOT\178\SOH\ENQ\SUBH Target a worker polling on a Nexus task queue in a specific namespace.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\ETX\NUL\SOH\DC2\EOT\173\SOH\f\DC2\n\
    \1\n\
    \\ACK\EOT\v\ETX\NUL\STX\NUL\DC2\EOT\175\SOH\b\GS\SUB! Namespace to route requests to.\n\
    \\n\
    \\SI\n\
    \\a\EOT\v\ETX\NUL\STX\NUL\ENQ\DC2\EOT\175\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\v\ETX\NUL\STX\NUL\SOH\DC2\EOT\175\SOH\SI\CAN\n\
    \\SI\n\
    \\a\EOT\v\ETX\NUL\STX\NUL\ETX\DC2\EOT\175\SOH\ESC\FS\n\
    \8\n\
    \\ACK\EOT\v\ETX\NUL\STX\SOH\DC2\EOT\177\SOH\b\RS\SUB( Nexus task queue to route requests to.\n\
    \\n\
    \\SI\n\
    \\a\EOT\v\ETX\NUL\STX\SOH\ENQ\DC2\EOT\177\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\v\ETX\NUL\STX\SOH\SOH\DC2\EOT\177\SOH\SI\EM\n\
    \\SI\n\
    \\a\EOT\v\ETX\NUL\STX\SOH\ETX\DC2\EOT\177\SOH\FS\GS\n\
    \\206\SOH\n\
    \\EOT\EOT\v\ETX\SOH\DC2\ACK\183\SOH\EOT\186\SOH\ENQ\SUB\189\SOH Target an external server by URL.\n\
    \ At a later point, this will support providing credentials, in the meantime, an http.RoundTripper can be injected\n\
    \ into the server to modify the request.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\ETX\SOH\SOH\DC2\EOT\183\SOH\f\DC4\n\
    \\RS\n\
    \\ACK\EOT\v\ETX\SOH\STX\NUL\DC2\EOT\185\SOH\b\ETB\SUB\SO URL to call.\n\
    \\n\
    \\SI\n\
    \\a\EOT\v\ETX\SOH\STX\NUL\ENQ\DC2\EOT\185\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\v\ETX\SOH\STX\NUL\SOH\DC2\EOT\185\SOH\SI\DC2\n\
    \\SI\n\
    \\a\EOT\v\ETX\SOH\STX\NUL\ETX\DC2\EOT\185\SOH\NAK\SYN\n\
    \\SO\n\
    \\EOT\EOT\v\b\NUL\DC2\ACK\188\SOH\EOT\191\SOH\ENQ\n\
    \\r\n\
    \\ENQ\EOT\v\b\NUL\SOH\DC2\EOT\188\SOH\n\
    \\DC1\n\
    \\f\n\
    \\EOT\EOT\v\STX\NUL\DC2\EOT\189\SOH\b\SUB\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ACK\DC2\EOT\189\SOH\b\SO\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\EOT\189\SOH\SI\NAK\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\EOT\189\SOH\CAN\EM\n\
    \\f\n\
    \\EOT\EOT\v\STX\SOH\DC2\EOT\190\SOH\b\RS\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ACK\DC2\EOT\190\SOH\b\DLE\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\EOT\190\SOH\DC1\EM\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\EOT\190\SOH\FS\GSb\ACKproto3"

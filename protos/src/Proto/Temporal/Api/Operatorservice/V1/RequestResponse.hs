{- This file was auto-generated from temporal/api/operatorservice/v1/request_response.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Operatorservice.V1.RequestResponse (
        AddOrUpdateRemoteClusterRequest(),
        AddOrUpdateRemoteClusterResponse(), AddSearchAttributesRequest(),
        AddSearchAttributesRequest'SearchAttributesEntry(),
        AddSearchAttributesResponse(), ClusterMetadata(),
        DeleteNamespaceRequest(), DeleteNamespaceResponse(),
        ListClustersRequest(), ListClustersResponse(),
        ListSearchAttributesRequest(), ListSearchAttributesResponse(),
        ListSearchAttributesResponse'CustomAttributesEntry(),
        ListSearchAttributesResponse'StorageSchemaEntry(),
        ListSearchAttributesResponse'SystemAttributesEntry(),
        RemoveRemoteClusterRequest(), RemoveRemoteClusterResponse(),
        RemoveSearchAttributesRequest(), RemoveSearchAttributesResponse()
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
import qualified Proto.Temporal.Api.Enums.V1.Common
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.frontendAddress' @:: Lens' AddOrUpdateRemoteClusterRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.enableRemoteClusterConnection' @:: Lens' AddOrUpdateRemoteClusterRequest Prelude.Bool@ -}
data AddOrUpdateRemoteClusterRequest
  = AddOrUpdateRemoteClusterRequest'_constructor {_AddOrUpdateRemoteClusterRequest'frontendAddress :: !Data.Text.Text,
                                                  _AddOrUpdateRemoteClusterRequest'enableRemoteClusterConnection :: !Prelude.Bool,
                                                  _AddOrUpdateRemoteClusterRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show AddOrUpdateRemoteClusterRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField AddOrUpdateRemoteClusterRequest "frontendAddress" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddOrUpdateRemoteClusterRequest'frontendAddress
           (\ x__ y__
              -> x__ {_AddOrUpdateRemoteClusterRequest'frontendAddress = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField AddOrUpdateRemoteClusterRequest "enableRemoteClusterConnection" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddOrUpdateRemoteClusterRequest'enableRemoteClusterConnection
           (\ x__ y__
              -> x__
                   {_AddOrUpdateRemoteClusterRequest'enableRemoteClusterConnection = y__}))
        Prelude.id
instance Data.ProtoLens.Message AddOrUpdateRemoteClusterRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.AddOrUpdateRemoteClusterRequest"
  packedMessageDescriptor _
    = "\n\
      \\USAddOrUpdateRemoteClusterRequest\DC2)\n\
      \\DLEfrontend_address\CAN\SOH \SOH(\tR\SIfrontendAddress\DC2G\n\
      \ enable_remote_cluster_connection\CAN\STX \SOH(\bR\GSenableRemoteClusterConnection"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        frontendAddress__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "frontend_address"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"frontendAddress")) ::
              Data.ProtoLens.FieldDescriptor AddOrUpdateRemoteClusterRequest
        enableRemoteClusterConnection__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "enable_remote_cluster_connection"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"enableRemoteClusterConnection")) ::
              Data.ProtoLens.FieldDescriptor AddOrUpdateRemoteClusterRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, frontendAddress__field_descriptor),
           (Data.ProtoLens.Tag 2, 
            enableRemoteClusterConnection__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddOrUpdateRemoteClusterRequest'_unknownFields
        (\ x__ y__
           -> x__ {_AddOrUpdateRemoteClusterRequest'_unknownFields = y__})
  defMessage
    = AddOrUpdateRemoteClusterRequest'_constructor
        {_AddOrUpdateRemoteClusterRequest'frontendAddress = Data.ProtoLens.fieldDefault,
         _AddOrUpdateRemoteClusterRequest'enableRemoteClusterConnection = Data.ProtoLens.fieldDefault,
         _AddOrUpdateRemoteClusterRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          AddOrUpdateRemoteClusterRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser AddOrUpdateRemoteClusterRequest
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
                                       "frontend_address"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"frontendAddress") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "enable_remote_cluster_connection"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"enableRemoteClusterConnection") y
                                     x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "AddOrUpdateRemoteClusterRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"frontendAddress") _x
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
                         (Data.ProtoLens.Field.field @"enableRemoteClusterConnection") _x
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
instance Control.DeepSeq.NFData AddOrUpdateRemoteClusterRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_AddOrUpdateRemoteClusterRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_AddOrUpdateRemoteClusterRequest'frontendAddress x__)
                (Control.DeepSeq.deepseq
                   (_AddOrUpdateRemoteClusterRequest'enableRemoteClusterConnection
                      x__)
                   ()))
{- | Fields :
      -}
data AddOrUpdateRemoteClusterResponse
  = AddOrUpdateRemoteClusterResponse'_constructor {_AddOrUpdateRemoteClusterResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show AddOrUpdateRemoteClusterResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message AddOrUpdateRemoteClusterResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.AddOrUpdateRemoteClusterResponse"
  packedMessageDescriptor _
    = "\n\
      \ AddOrUpdateRemoteClusterResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddOrUpdateRemoteClusterResponse'_unknownFields
        (\ x__ y__
           -> x__ {_AddOrUpdateRemoteClusterResponse'_unknownFields = y__})
  defMessage
    = AddOrUpdateRemoteClusterResponse'_constructor
        {_AddOrUpdateRemoteClusterResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          AddOrUpdateRemoteClusterResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser AddOrUpdateRemoteClusterResponse
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
          (do loop Data.ProtoLens.defMessage)
          "AddOrUpdateRemoteClusterResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData AddOrUpdateRemoteClusterResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_AddOrUpdateRemoteClusterResponse'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.searchAttributes' @:: Lens' AddSearchAttributesRequest (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespace' @:: Lens' AddSearchAttributesRequest Data.Text.Text@ -}
data AddSearchAttributesRequest
  = AddSearchAttributesRequest'_constructor {_AddSearchAttributesRequest'searchAttributes :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType),
                                             _AddSearchAttributesRequest'namespace :: !Data.Text.Text,
                                             _AddSearchAttributesRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show AddSearchAttributesRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField AddSearchAttributesRequest "searchAttributes" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddSearchAttributesRequest'searchAttributes
           (\ x__ y__
              -> x__ {_AddSearchAttributesRequest'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField AddSearchAttributesRequest "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddSearchAttributesRequest'namespace
           (\ x__ y__ -> x__ {_AddSearchAttributesRequest'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Message AddSearchAttributesRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.AddSearchAttributesRequest"
  packedMessageDescriptor _
    = "\n\
      \\SUBAddSearchAttributesRequest\DC2~\n\
      \\DC1search_attributes\CAN\SOH \ETX(\v2Q.temporal.api.operatorservice.v1.AddSearchAttributesRequest.SearchAttributesEntryR\DLEsearchAttributes\DC2\FS\n\
      \\tnamespace\CAN\STX \SOH(\tR\tnamespace\SUBl\n\
      \\NAKSearchAttributesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
      \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor AddSearchAttributesRequest'SearchAttributesEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                    Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor AddSearchAttributesRequest
        namespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"namespace")) ::
              Data.ProtoLens.FieldDescriptor AddSearchAttributesRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, searchAttributes__field_descriptor),
           (Data.ProtoLens.Tag 2, namespace__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddSearchAttributesRequest'_unknownFields
        (\ x__ y__
           -> x__ {_AddSearchAttributesRequest'_unknownFields = y__})
  defMessage
    = AddSearchAttributesRequest'_constructor
        {_AddSearchAttributesRequest'searchAttributes = Data.Map.empty,
         _AddSearchAttributesRequest'namespace = Data.ProtoLens.fieldDefault,
         _AddSearchAttributesRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          AddSearchAttributesRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser AddSearchAttributesRequest
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
                          -> do !(entry :: AddSearchAttributesRequest'SearchAttributesEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                                  (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                                      Data.ProtoLens.Encoding.Bytes.isolate
                                                                                                        (Prelude.fromIntegral
                                                                                                           len)
                                                                                                        Data.ProtoLens.parseMessage)
                                                                                                  "search_attributes"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"searchAttributes")
                                        (\ !t -> Data.Map.insert key value t) x))
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "AddSearchAttributesRequest"
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
                                       AddSearchAttributesRequest'SearchAttributesEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view
                         (Data.ProtoLens.Field.field @"searchAttributes") _x))))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"namespace") _x
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
instance Control.DeepSeq.NFData AddSearchAttributesRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_AddSearchAttributesRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_AddSearchAttributesRequest'searchAttributes x__)
                (Control.DeepSeq.deepseq
                   (_AddSearchAttributesRequest'namespace x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.key' @:: Lens' AddSearchAttributesRequest'SearchAttributesEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.value' @:: Lens' AddSearchAttributesRequest'SearchAttributesEntry Proto.Temporal.Api.Enums.V1.Common.IndexedValueType@ -}
data AddSearchAttributesRequest'SearchAttributesEntry
  = AddSearchAttributesRequest'SearchAttributesEntry'_constructor {_AddSearchAttributesRequest'SearchAttributesEntry'key :: !Data.Text.Text,
                                                                   _AddSearchAttributesRequest'SearchAttributesEntry'value :: !Proto.Temporal.Api.Enums.V1.Common.IndexedValueType,
                                                                   _AddSearchAttributesRequest'SearchAttributesEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show AddSearchAttributesRequest'SearchAttributesEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField AddSearchAttributesRequest'SearchAttributesEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddSearchAttributesRequest'SearchAttributesEntry'key
           (\ x__ y__
              -> x__
                   {_AddSearchAttributesRequest'SearchAttributesEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField AddSearchAttributesRequest'SearchAttributesEntry "value" Proto.Temporal.Api.Enums.V1.Common.IndexedValueType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddSearchAttributesRequest'SearchAttributesEntry'value
           (\ x__ y__
              -> x__
                   {_AddSearchAttributesRequest'SearchAttributesEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message AddSearchAttributesRequest'SearchAttributesEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.AddSearchAttributesRequest.SearchAttributesEntry"
  packedMessageDescriptor _
    = "\n\
      \\NAKSearchAttributesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
      \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor AddSearchAttributesRequest'SearchAttributesEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor AddSearchAttributesRequest'SearchAttributesEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddSearchAttributesRequest'SearchAttributesEntry'_unknownFields
        (\ x__ y__
           -> x__
                {_AddSearchAttributesRequest'SearchAttributesEntry'_unknownFields = y__})
  defMessage
    = AddSearchAttributesRequest'SearchAttributesEntry'_constructor
        {_AddSearchAttributesRequest'SearchAttributesEntry'key = Data.ProtoLens.fieldDefault,
         _AddSearchAttributesRequest'SearchAttributesEntry'value = Data.ProtoLens.fieldDefault,
         _AddSearchAttributesRequest'SearchAttributesEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          AddSearchAttributesRequest'SearchAttributesEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser AddSearchAttributesRequest'SearchAttributesEntry
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
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
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
          (do loop Data.ProtoLens.defMessage) "SearchAttributesEntry"
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
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                            Prelude.fromEnum _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData AddSearchAttributesRequest'SearchAttributesEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_AddSearchAttributesRequest'SearchAttributesEntry'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_AddSearchAttributesRequest'SearchAttributesEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_AddSearchAttributesRequest'SearchAttributesEntry'value x__) ()))
{- | Fields :
      -}
data AddSearchAttributesResponse
  = AddSearchAttributesResponse'_constructor {_AddSearchAttributesResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show AddSearchAttributesResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message AddSearchAttributesResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.AddSearchAttributesResponse"
  packedMessageDescriptor _
    = "\n\
      \\ESCAddSearchAttributesResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddSearchAttributesResponse'_unknownFields
        (\ x__ y__
           -> x__ {_AddSearchAttributesResponse'_unknownFields = y__})
  defMessage
    = AddSearchAttributesResponse'_constructor
        {_AddSearchAttributesResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          AddSearchAttributesResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser AddSearchAttributesResponse
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
          (do loop Data.ProtoLens.defMessage) "AddSearchAttributesResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData AddSearchAttributesResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_AddSearchAttributesResponse'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.clusterName' @:: Lens' ClusterMetadata Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.clusterId' @:: Lens' ClusterMetadata Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.address' @:: Lens' ClusterMetadata Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.initialFailoverVersion' @:: Lens' ClusterMetadata Data.Int.Int64@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.historyShardCount' @:: Lens' ClusterMetadata Data.Int.Int32@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.isConnectionEnabled' @:: Lens' ClusterMetadata Prelude.Bool@ -}
data ClusterMetadata
  = ClusterMetadata'_constructor {_ClusterMetadata'clusterName :: !Data.Text.Text,
                                  _ClusterMetadata'clusterId :: !Data.Text.Text,
                                  _ClusterMetadata'address :: !Data.Text.Text,
                                  _ClusterMetadata'initialFailoverVersion :: !Data.Int.Int64,
                                  _ClusterMetadata'historyShardCount :: !Data.Int.Int32,
                                  _ClusterMetadata'isConnectionEnabled :: !Prelude.Bool,
                                  _ClusterMetadata'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ClusterMetadata where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ClusterMetadata "clusterName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterMetadata'clusterName
           (\ x__ y__ -> x__ {_ClusterMetadata'clusterName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ClusterMetadata "clusterId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterMetadata'clusterId
           (\ x__ y__ -> x__ {_ClusterMetadata'clusterId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ClusterMetadata "address" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterMetadata'address
           (\ x__ y__ -> x__ {_ClusterMetadata'address = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ClusterMetadata "initialFailoverVersion" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterMetadata'initialFailoverVersion
           (\ x__ y__ -> x__ {_ClusterMetadata'initialFailoverVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ClusterMetadata "historyShardCount" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterMetadata'historyShardCount
           (\ x__ y__ -> x__ {_ClusterMetadata'historyShardCount = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ClusterMetadata "isConnectionEnabled" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterMetadata'isConnectionEnabled
           (\ x__ y__ -> x__ {_ClusterMetadata'isConnectionEnabled = y__}))
        Prelude.id
instance Data.ProtoLens.Message ClusterMetadata where
  messageName _
    = Data.Text.pack "temporal.api.operatorservice.v1.ClusterMetadata"
  packedMessageDescriptor _
    = "\n\
      \\SIClusterMetadata\DC2!\n\
      \\fcluster_name\CAN\SOH \SOH(\tR\vclusterName\DC2\GS\n\
      \\n\
      \cluster_id\CAN\STX \SOH(\tR\tclusterId\DC2\CAN\n\
      \\aaddress\CAN\ETX \SOH(\tR\aaddress\DC28\n\
      \\CANinitial_failover_version\CAN\EOT \SOH(\ETXR\SYNinitialFailoverVersion\DC2.\n\
      \\DC3history_shard_count\CAN\ENQ \SOH(\ENQR\DC1historyShardCount\DC22\n\
      \\NAKis_connection_enabled\CAN\ACK \SOH(\bR\DC3isConnectionEnabled"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        clusterName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cluster_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"clusterName")) ::
              Data.ProtoLens.FieldDescriptor ClusterMetadata
        clusterId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cluster_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"clusterId")) ::
              Data.ProtoLens.FieldDescriptor ClusterMetadata
        address__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "address"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"address")) ::
              Data.ProtoLens.FieldDescriptor ClusterMetadata
        initialFailoverVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "initial_failover_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"initialFailoverVersion")) ::
              Data.ProtoLens.FieldDescriptor ClusterMetadata
        historyShardCount__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "history_shard_count"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"historyShardCount")) ::
              Data.ProtoLens.FieldDescriptor ClusterMetadata
        isConnectionEnabled__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_connection_enabled"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isConnectionEnabled")) ::
              Data.ProtoLens.FieldDescriptor ClusterMetadata
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, clusterName__field_descriptor),
           (Data.ProtoLens.Tag 2, clusterId__field_descriptor),
           (Data.ProtoLens.Tag 3, address__field_descriptor),
           (Data.ProtoLens.Tag 4, initialFailoverVersion__field_descriptor),
           (Data.ProtoLens.Tag 5, historyShardCount__field_descriptor),
           (Data.ProtoLens.Tag 6, isConnectionEnabled__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ClusterMetadata'_unknownFields
        (\ x__ y__ -> x__ {_ClusterMetadata'_unknownFields = y__})
  defMessage
    = ClusterMetadata'_constructor
        {_ClusterMetadata'clusterName = Data.ProtoLens.fieldDefault,
         _ClusterMetadata'clusterId = Data.ProtoLens.fieldDefault,
         _ClusterMetadata'address = Data.ProtoLens.fieldDefault,
         _ClusterMetadata'initialFailoverVersion = Data.ProtoLens.fieldDefault,
         _ClusterMetadata'historyShardCount = Data.ProtoLens.fieldDefault,
         _ClusterMetadata'isConnectionEnabled = Data.ProtoLens.fieldDefault,
         _ClusterMetadata'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ClusterMetadata
          -> Data.ProtoLens.Encoding.Bytes.Parser ClusterMetadata
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
                                       "cluster_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"clusterName") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "cluster_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"clusterId") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "address"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"address") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "initial_failover_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"initialFailoverVersion") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "history_shard_count"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"historyShardCount") y x)
                        48
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_connection_enabled"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"isConnectionEnabled") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ClusterMetadata"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"clusterName") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"clusterId") _x
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
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"address") _x
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
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"initialFailoverVersion") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"historyShardCount") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral
                                     _v))
                         ((Data.Monoid.<>)
                            (let
                               _v
                                 = Lens.Family2.view
                                     (Data.ProtoLens.Field.field @"isConnectionEnabled") _x
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
instance Control.DeepSeq.NFData ClusterMetadata where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ClusterMetadata'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ClusterMetadata'clusterName x__)
                (Control.DeepSeq.deepseq
                   (_ClusterMetadata'clusterId x__)
                   (Control.DeepSeq.deepseq
                      (_ClusterMetadata'address x__)
                      (Control.DeepSeq.deepseq
                         (_ClusterMetadata'initialFailoverVersion x__)
                         (Control.DeepSeq.deepseq
                            (_ClusterMetadata'historyShardCount x__)
                            (Control.DeepSeq.deepseq
                               (_ClusterMetadata'isConnectionEnabled x__) ()))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespace' @:: Lens' DeleteNamespaceRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespaceId' @:: Lens' DeleteNamespaceRequest Data.Text.Text@ -}
data DeleteNamespaceRequest
  = DeleteNamespaceRequest'_constructor {_DeleteNamespaceRequest'namespace :: !Data.Text.Text,
                                         _DeleteNamespaceRequest'namespaceId :: !Data.Text.Text,
                                         _DeleteNamespaceRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show DeleteNamespaceRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField DeleteNamespaceRequest "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeleteNamespaceRequest'namespace
           (\ x__ y__ -> x__ {_DeleteNamespaceRequest'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField DeleteNamespaceRequest "namespaceId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeleteNamespaceRequest'namespaceId
           (\ x__ y__ -> x__ {_DeleteNamespaceRequest'namespaceId = y__}))
        Prelude.id
instance Data.ProtoLens.Message DeleteNamespaceRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.DeleteNamespaceRequest"
  packedMessageDescriptor _
    = "\n\
      \\SYNDeleteNamespaceRequest\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2!\n\
      \\fnamespace_id\CAN\STX \SOH(\tR\vnamespaceId"
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
              Data.ProtoLens.FieldDescriptor DeleteNamespaceRequest
        namespaceId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"namespaceId")) ::
              Data.ProtoLens.FieldDescriptor DeleteNamespaceRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, namespaceId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DeleteNamespaceRequest'_unknownFields
        (\ x__ y__ -> x__ {_DeleteNamespaceRequest'_unknownFields = y__})
  defMessage
    = DeleteNamespaceRequest'_constructor
        {_DeleteNamespaceRequest'namespace = Data.ProtoLens.fieldDefault,
         _DeleteNamespaceRequest'namespaceId = Data.ProtoLens.fieldDefault,
         _DeleteNamespaceRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          DeleteNamespaceRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser DeleteNamespaceRequest
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
                                       "namespace_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespaceId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "DeleteNamespaceRequest"
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
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"namespaceId") _x
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
instance Control.DeepSeq.NFData DeleteNamespaceRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DeleteNamespaceRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_DeleteNamespaceRequest'namespace x__)
                (Control.DeepSeq.deepseq
                   (_DeleteNamespaceRequest'namespaceId x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.deletedNamespace' @:: Lens' DeleteNamespaceResponse Data.Text.Text@ -}
data DeleteNamespaceResponse
  = DeleteNamespaceResponse'_constructor {_DeleteNamespaceResponse'deletedNamespace :: !Data.Text.Text,
                                          _DeleteNamespaceResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show DeleteNamespaceResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField DeleteNamespaceResponse "deletedNamespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeleteNamespaceResponse'deletedNamespace
           (\ x__ y__
              -> x__ {_DeleteNamespaceResponse'deletedNamespace = y__}))
        Prelude.id
instance Data.ProtoLens.Message DeleteNamespaceResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.DeleteNamespaceResponse"
  packedMessageDescriptor _
    = "\n\
      \\ETBDeleteNamespaceResponse\DC2+\n\
      \\DC1deleted_namespace\CAN\SOH \SOH(\tR\DLEdeletedNamespace"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        deletedNamespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "deleted_namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"deletedNamespace")) ::
              Data.ProtoLens.FieldDescriptor DeleteNamespaceResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, deletedNamespace__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DeleteNamespaceResponse'_unknownFields
        (\ x__ y__ -> x__ {_DeleteNamespaceResponse'_unknownFields = y__})
  defMessage
    = DeleteNamespaceResponse'_constructor
        {_DeleteNamespaceResponse'deletedNamespace = Data.ProtoLens.fieldDefault,
         _DeleteNamespaceResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          DeleteNamespaceResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser DeleteNamespaceResponse
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
                                       "deleted_namespace"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"deletedNamespace") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "DeleteNamespaceResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"deletedNamespace") _x
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
instance Control.DeepSeq.NFData DeleteNamespaceResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DeleteNamespaceResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_DeleteNamespaceResponse'deletedNamespace x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.pageSize' @:: Lens' ListClustersRequest Data.Int.Int32@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.nextPageToken' @:: Lens' ListClustersRequest Data.ByteString.ByteString@ -}
data ListClustersRequest
  = ListClustersRequest'_constructor {_ListClustersRequest'pageSize :: !Data.Int.Int32,
                                      _ListClustersRequest'nextPageToken :: !Data.ByteString.ByteString,
                                      _ListClustersRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListClustersRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListClustersRequest "pageSize" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListClustersRequest'pageSize
           (\ x__ y__ -> x__ {_ListClustersRequest'pageSize = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListClustersRequest "nextPageToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListClustersRequest'nextPageToken
           (\ x__ y__ -> x__ {_ListClustersRequest'nextPageToken = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListClustersRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListClustersRequest"
  packedMessageDescriptor _
    = "\n\
      \\DC3ListClustersRequest\DC2\ESC\n\
      \\tpage_size\CAN\SOH \SOH(\ENQR\bpageSize\DC2&\n\
      \\SInext_page_token\CAN\STX \SOH(\fR\rnextPageToken"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        pageSize__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "page_size"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"pageSize")) ::
              Data.ProtoLens.FieldDescriptor ListClustersRequest
        nextPageToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_page_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"nextPageToken")) ::
              Data.ProtoLens.FieldDescriptor ListClustersRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, pageSize__field_descriptor),
           (Data.ProtoLens.Tag 2, nextPageToken__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListClustersRequest'_unknownFields
        (\ x__ y__ -> x__ {_ListClustersRequest'_unknownFields = y__})
  defMessage
    = ListClustersRequest'_constructor
        {_ListClustersRequest'pageSize = Data.ProtoLens.fieldDefault,
         _ListClustersRequest'nextPageToken = Data.ProtoLens.fieldDefault,
         _ListClustersRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListClustersRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser ListClustersRequest
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
                                       "page_size"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"pageSize") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "next_page_token"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nextPageToken") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ListClustersRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"pageSize") _x
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
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"nextPageToken") _x
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
instance Control.DeepSeq.NFData ListClustersRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListClustersRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ListClustersRequest'pageSize x__)
                (Control.DeepSeq.deepseq
                   (_ListClustersRequest'nextPageToken x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.clusters' @:: Lens' ListClustersResponse [ClusterMetadata]@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.vec'clusters' @:: Lens' ListClustersResponse (Data.Vector.Vector ClusterMetadata)@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.nextPageToken' @:: Lens' ListClustersResponse Data.ByteString.ByteString@ -}
data ListClustersResponse
  = ListClustersResponse'_constructor {_ListClustersResponse'clusters :: !(Data.Vector.Vector ClusterMetadata),
                                       _ListClustersResponse'nextPageToken :: !Data.ByteString.ByteString,
                                       _ListClustersResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListClustersResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListClustersResponse "clusters" [ClusterMetadata] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListClustersResponse'clusters
           (\ x__ y__ -> x__ {_ListClustersResponse'clusters = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ListClustersResponse "vec'clusters" (Data.Vector.Vector ClusterMetadata) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListClustersResponse'clusters
           (\ x__ y__ -> x__ {_ListClustersResponse'clusters = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListClustersResponse "nextPageToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListClustersResponse'nextPageToken
           (\ x__ y__ -> x__ {_ListClustersResponse'nextPageToken = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListClustersResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListClustersResponse"
  packedMessageDescriptor _
    = "\n\
      \\DC4ListClustersResponse\DC2L\n\
      \\bclusters\CAN\SOH \ETX(\v20.temporal.api.operatorservice.v1.ClusterMetadataR\bclusters\DC2&\n\
      \\SInext_page_token\CAN\EOT \SOH(\fR\rnextPageToken"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        clusters__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "clusters"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ClusterMetadata)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"clusters")) ::
              Data.ProtoLens.FieldDescriptor ListClustersResponse
        nextPageToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_page_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"nextPageToken")) ::
              Data.ProtoLens.FieldDescriptor ListClustersResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, clusters__field_descriptor),
           (Data.ProtoLens.Tag 4, nextPageToken__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListClustersResponse'_unknownFields
        (\ x__ y__ -> x__ {_ListClustersResponse'_unknownFields = y__})
  defMessage
    = ListClustersResponse'_constructor
        {_ListClustersResponse'clusters = Data.Vector.Generic.empty,
         _ListClustersResponse'nextPageToken = Data.ProtoLens.fieldDefault,
         _ListClustersResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListClustersResponse
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld ClusterMetadata
             -> Data.ProtoLens.Encoding.Bytes.Parser ListClustersResponse
        loop x mutable'clusters
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'clusters <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                              mutable'clusters)
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
                              (Data.ProtoLens.Field.field @"vec'clusters") frozen'clusters x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "clusters"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'clusters y)
                                loop x v
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "next_page_token"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nextPageToken") y x)
                                  mutable'clusters
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'clusters
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'clusters <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                    Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'clusters)
          "ListClustersResponse"
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
                   (Data.ProtoLens.Field.field @"vec'clusters") _x))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"nextPageToken") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                         ((\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData ListClustersResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListClustersResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ListClustersResponse'clusters x__)
                (Control.DeepSeq.deepseq
                   (_ListClustersResponse'nextPageToken x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespace' @:: Lens' ListSearchAttributesRequest Data.Text.Text@ -}
data ListSearchAttributesRequest
  = ListSearchAttributesRequest'_constructor {_ListSearchAttributesRequest'namespace :: !Data.Text.Text,
                                              _ListSearchAttributesRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListSearchAttributesRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListSearchAttributesRequest "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesRequest'namespace
           (\ x__ y__ -> x__ {_ListSearchAttributesRequest'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListSearchAttributesRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListSearchAttributesRequest"
  packedMessageDescriptor _
    = "\n\
      \\ESCListSearchAttributesRequest\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace"
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
              Data.ProtoLens.FieldDescriptor ListSearchAttributesRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListSearchAttributesRequest'_unknownFields
        (\ x__ y__
           -> x__ {_ListSearchAttributesRequest'_unknownFields = y__})
  defMessage
    = ListSearchAttributesRequest'_constructor
        {_ListSearchAttributesRequest'namespace = Data.ProtoLens.fieldDefault,
         _ListSearchAttributesRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListSearchAttributesRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser ListSearchAttributesRequest
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ListSearchAttributesRequest"
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData ListSearchAttributesRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListSearchAttributesRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ListSearchAttributesRequest'namespace x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.customAttributes' @:: Lens' ListSearchAttributesResponse (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.systemAttributes' @:: Lens' ListSearchAttributesResponse (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.storageSchema' @:: Lens' ListSearchAttributesResponse (Data.Map.Map Data.Text.Text Data.Text.Text)@ -}
data ListSearchAttributesResponse
  = ListSearchAttributesResponse'_constructor {_ListSearchAttributesResponse'customAttributes :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType),
                                               _ListSearchAttributesResponse'systemAttributes :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType),
                                               _ListSearchAttributesResponse'storageSchema :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                                               _ListSearchAttributesResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListSearchAttributesResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse "customAttributes" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'customAttributes
           (\ x__ y__
              -> x__ {_ListSearchAttributesResponse'customAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse "systemAttributes" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Enums.V1.Common.IndexedValueType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'systemAttributes
           (\ x__ y__
              -> x__ {_ListSearchAttributesResponse'systemAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse "storageSchema" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'storageSchema
           (\ x__ y__
              -> x__ {_ListSearchAttributesResponse'storageSchema = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListSearchAttributesResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListSearchAttributesResponse"
  packedMessageDescriptor _
    = "\n\
      \\FSListSearchAttributesResponse\DC2\128\SOH\n\
      \\DC1custom_attributes\CAN\SOH \ETX(\v2S.temporal.api.operatorservice.v1.ListSearchAttributesResponse.CustomAttributesEntryR\DLEcustomAttributes\DC2\128\SOH\n\
      \\DC1system_attributes\CAN\STX \ETX(\v2S.temporal.api.operatorservice.v1.ListSearchAttributesResponse.SystemAttributesEntryR\DLEsystemAttributes\DC2w\n\
      \\SOstorage_schema\CAN\ETX \ETX(\v2P.temporal.api.operatorservice.v1.ListSearchAttributesResponse.StorageSchemaEntryR\rstorageSchema\SUBl\n\
      \\NAKCustomAttributesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
      \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH\SUBl\n\
      \\NAKSystemAttributesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
      \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH\SUB@\n\
      \\DC2StorageSchemaEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        customAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "custom_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ListSearchAttributesResponse'CustomAttributesEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                    Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"customAttributes")) ::
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse
        systemAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "system_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ListSearchAttributesResponse'SystemAttributesEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                    Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"systemAttributes")) ::
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse
        storageSchema__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "storage_schema"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ListSearchAttributesResponse'StorageSchemaEntry)
              (Data.ProtoLens.MapField
                 Data.ProtoLens.MapStringKey
                 (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                    Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"storageSchema")) ::
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, customAttributes__field_descriptor),
           (Data.ProtoLens.Tag 2, systemAttributes__field_descriptor),
           (Data.ProtoLens.Tag 3, storageSchema__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListSearchAttributesResponse'_unknownFields
        (\ x__ y__
           -> x__ {_ListSearchAttributesResponse'_unknownFields = y__})
  defMessage
    = ListSearchAttributesResponse'_constructor
        {_ListSearchAttributesResponse'customAttributes = Data.Map.empty,
         _ListSearchAttributesResponse'systemAttributes = Data.Map.empty,
         _ListSearchAttributesResponse'storageSchema = Data.Map.empty,
         _ListSearchAttributesResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListSearchAttributesResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser ListSearchAttributesResponse
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
                          -> do !(entry :: ListSearchAttributesResponse'CustomAttributesEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                                    (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                                        Data.ProtoLens.Encoding.Bytes.isolate
                                                                                                          (Prelude.fromIntegral
                                                                                                             len)
                                                                                                          Data.ProtoLens.parseMessage)
                                                                                                    "custom_attributes"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"customAttributes")
                                        (\ !t -> Data.Map.insert key value t) x))
                        18
                          -> do !(entry :: ListSearchAttributesResponse'SystemAttributesEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                                    (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                                        Data.ProtoLens.Encoding.Bytes.isolate
                                                                                                          (Prelude.fromIntegral
                                                                                                             len)
                                                                                                          Data.ProtoLens.parseMessage)
                                                                                                    "system_attributes"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"systemAttributes")
                                        (\ !t -> Data.Map.insert key value t) x))
                        26
                          -> do !(entry :: ListSearchAttributesResponse'StorageSchemaEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                                 (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                                     Data.ProtoLens.Encoding.Bytes.isolate
                                                                                                       (Prelude.fromIntegral
                                                                                                          len)
                                                                                                       Data.ProtoLens.parseMessage)
                                                                                                 "storage_schema"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"storageSchema")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ListSearchAttributesResponse"
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
                                       ListSearchAttributesResponse'CustomAttributesEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view
                         (Data.ProtoLens.Field.field @"customAttributes") _x))))
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
                                          ListSearchAttributesResponse'SystemAttributesEntry)))))
                      (Data.Map.toList
                         (Lens.Family2.view
                            (Data.ProtoLens.Field.field @"systemAttributes") _x))))
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
                                             ListSearchAttributesResponse'StorageSchemaEntry)))))
                         (Data.Map.toList
                            (Lens.Family2.view
                               (Data.ProtoLens.Field.field @"storageSchema") _x))))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData ListSearchAttributesResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListSearchAttributesResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ListSearchAttributesResponse'customAttributes x__)
                (Control.DeepSeq.deepseq
                   (_ListSearchAttributesResponse'systemAttributes x__)
                   (Control.DeepSeq.deepseq
                      (_ListSearchAttributesResponse'storageSchema x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.key' @:: Lens' ListSearchAttributesResponse'CustomAttributesEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.value' @:: Lens' ListSearchAttributesResponse'CustomAttributesEntry Proto.Temporal.Api.Enums.V1.Common.IndexedValueType@ -}
data ListSearchAttributesResponse'CustomAttributesEntry
  = ListSearchAttributesResponse'CustomAttributesEntry'_constructor {_ListSearchAttributesResponse'CustomAttributesEntry'key :: !Data.Text.Text,
                                                                     _ListSearchAttributesResponse'CustomAttributesEntry'value :: !Proto.Temporal.Api.Enums.V1.Common.IndexedValueType,
                                                                     _ListSearchAttributesResponse'CustomAttributesEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListSearchAttributesResponse'CustomAttributesEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse'CustomAttributesEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'CustomAttributesEntry'key
           (\ x__ y__
              -> x__
                   {_ListSearchAttributesResponse'CustomAttributesEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse'CustomAttributesEntry "value" Proto.Temporal.Api.Enums.V1.Common.IndexedValueType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'CustomAttributesEntry'value
           (\ x__ y__
              -> x__
                   {_ListSearchAttributesResponse'CustomAttributesEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListSearchAttributesResponse'CustomAttributesEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListSearchAttributesResponse.CustomAttributesEntry"
  packedMessageDescriptor _
    = "\n\
      \\NAKCustomAttributesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
      \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse'CustomAttributesEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse'CustomAttributesEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListSearchAttributesResponse'CustomAttributesEntry'_unknownFields
        (\ x__ y__
           -> x__
                {_ListSearchAttributesResponse'CustomAttributesEntry'_unknownFields = y__})
  defMessage
    = ListSearchAttributesResponse'CustomAttributesEntry'_constructor
        {_ListSearchAttributesResponse'CustomAttributesEntry'key = Data.ProtoLens.fieldDefault,
         _ListSearchAttributesResponse'CustomAttributesEntry'value = Data.ProtoLens.fieldDefault,
         _ListSearchAttributesResponse'CustomAttributesEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListSearchAttributesResponse'CustomAttributesEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser ListSearchAttributesResponse'CustomAttributesEntry
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
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
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
          (do loop Data.ProtoLens.defMessage) "CustomAttributesEntry"
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
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                            Prelude.fromEnum _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData ListSearchAttributesResponse'CustomAttributesEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListSearchAttributesResponse'CustomAttributesEntry'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_ListSearchAttributesResponse'CustomAttributesEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_ListSearchAttributesResponse'CustomAttributesEntry'value x__)
                   ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.key' @:: Lens' ListSearchAttributesResponse'StorageSchemaEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.value' @:: Lens' ListSearchAttributesResponse'StorageSchemaEntry Data.Text.Text@ -}
data ListSearchAttributesResponse'StorageSchemaEntry
  = ListSearchAttributesResponse'StorageSchemaEntry'_constructor {_ListSearchAttributesResponse'StorageSchemaEntry'key :: !Data.Text.Text,
                                                                  _ListSearchAttributesResponse'StorageSchemaEntry'value :: !Data.Text.Text,
                                                                  _ListSearchAttributesResponse'StorageSchemaEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListSearchAttributesResponse'StorageSchemaEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse'StorageSchemaEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'StorageSchemaEntry'key
           (\ x__ y__
              -> x__
                   {_ListSearchAttributesResponse'StorageSchemaEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse'StorageSchemaEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'StorageSchemaEntry'value
           (\ x__ y__
              -> x__
                   {_ListSearchAttributesResponse'StorageSchemaEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListSearchAttributesResponse'StorageSchemaEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListSearchAttributesResponse.StorageSchemaEntry"
  packedMessageDescriptor _
    = "\n\
      \\DC2StorageSchemaEntry\DC2\DLE\n\
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
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse'StorageSchemaEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse'StorageSchemaEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListSearchAttributesResponse'StorageSchemaEntry'_unknownFields
        (\ x__ y__
           -> x__
                {_ListSearchAttributesResponse'StorageSchemaEntry'_unknownFields = y__})
  defMessage
    = ListSearchAttributesResponse'StorageSchemaEntry'_constructor
        {_ListSearchAttributesResponse'StorageSchemaEntry'key = Data.ProtoLens.fieldDefault,
         _ListSearchAttributesResponse'StorageSchemaEntry'value = Data.ProtoLens.fieldDefault,
         _ListSearchAttributesResponse'StorageSchemaEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListSearchAttributesResponse'StorageSchemaEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser ListSearchAttributesResponse'StorageSchemaEntry
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
          (do loop Data.ProtoLens.defMessage) "StorageSchemaEntry"
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
instance Control.DeepSeq.NFData ListSearchAttributesResponse'StorageSchemaEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListSearchAttributesResponse'StorageSchemaEntry'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_ListSearchAttributesResponse'StorageSchemaEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_ListSearchAttributesResponse'StorageSchemaEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.key' @:: Lens' ListSearchAttributesResponse'SystemAttributesEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.value' @:: Lens' ListSearchAttributesResponse'SystemAttributesEntry Proto.Temporal.Api.Enums.V1.Common.IndexedValueType@ -}
data ListSearchAttributesResponse'SystemAttributesEntry
  = ListSearchAttributesResponse'SystemAttributesEntry'_constructor {_ListSearchAttributesResponse'SystemAttributesEntry'key :: !Data.Text.Text,
                                                                     _ListSearchAttributesResponse'SystemAttributesEntry'value :: !Proto.Temporal.Api.Enums.V1.Common.IndexedValueType,
                                                                     _ListSearchAttributesResponse'SystemAttributesEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListSearchAttributesResponse'SystemAttributesEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse'SystemAttributesEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'SystemAttributesEntry'key
           (\ x__ y__
              -> x__
                   {_ListSearchAttributesResponse'SystemAttributesEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListSearchAttributesResponse'SystemAttributesEntry "value" Proto.Temporal.Api.Enums.V1.Common.IndexedValueType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListSearchAttributesResponse'SystemAttributesEntry'value
           (\ x__ y__
              -> x__
                   {_ListSearchAttributesResponse'SystemAttributesEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListSearchAttributesResponse'SystemAttributesEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListSearchAttributesResponse.SystemAttributesEntry"
  packedMessageDescriptor _
    = "\n\
      \\NAKSystemAttributesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
      \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse'SystemAttributesEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.IndexedValueType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor ListSearchAttributesResponse'SystemAttributesEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListSearchAttributesResponse'SystemAttributesEntry'_unknownFields
        (\ x__ y__
           -> x__
                {_ListSearchAttributesResponse'SystemAttributesEntry'_unknownFields = y__})
  defMessage
    = ListSearchAttributesResponse'SystemAttributesEntry'_constructor
        {_ListSearchAttributesResponse'SystemAttributesEntry'key = Data.ProtoLens.fieldDefault,
         _ListSearchAttributesResponse'SystemAttributesEntry'value = Data.ProtoLens.fieldDefault,
         _ListSearchAttributesResponse'SystemAttributesEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListSearchAttributesResponse'SystemAttributesEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser ListSearchAttributesResponse'SystemAttributesEntry
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
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
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
          (do loop Data.ProtoLens.defMessage) "SystemAttributesEntry"
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
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                            Prelude.fromEnum _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData ListSearchAttributesResponse'SystemAttributesEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListSearchAttributesResponse'SystemAttributesEntry'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_ListSearchAttributesResponse'SystemAttributesEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_ListSearchAttributesResponse'SystemAttributesEntry'value x__)
                   ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.clusterName' @:: Lens' RemoveRemoteClusterRequest Data.Text.Text@ -}
data RemoveRemoteClusterRequest
  = RemoveRemoteClusterRequest'_constructor {_RemoveRemoteClusterRequest'clusterName :: !Data.Text.Text,
                                             _RemoveRemoteClusterRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RemoveRemoteClusterRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RemoveRemoteClusterRequest "clusterName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RemoveRemoteClusterRequest'clusterName
           (\ x__ y__ -> x__ {_RemoveRemoteClusterRequest'clusterName = y__}))
        Prelude.id
instance Data.ProtoLens.Message RemoveRemoteClusterRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.RemoveRemoteClusterRequest"
  packedMessageDescriptor _
    = "\n\
      \\SUBRemoveRemoteClusterRequest\DC2!\n\
      \\fcluster_name\CAN\SOH \SOH(\tR\vclusterName"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        clusterName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cluster_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"clusterName")) ::
              Data.ProtoLens.FieldDescriptor RemoveRemoteClusterRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, clusterName__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RemoveRemoteClusterRequest'_unknownFields
        (\ x__ y__
           -> x__ {_RemoveRemoteClusterRequest'_unknownFields = y__})
  defMessage
    = RemoveRemoteClusterRequest'_constructor
        {_RemoveRemoteClusterRequest'clusterName = Data.ProtoLens.fieldDefault,
         _RemoveRemoteClusterRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RemoveRemoteClusterRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser RemoveRemoteClusterRequest
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
                                       "cluster_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"clusterName") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "RemoveRemoteClusterRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"clusterName") _x
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
instance Control.DeepSeq.NFData RemoveRemoteClusterRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RemoveRemoteClusterRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_RemoveRemoteClusterRequest'clusterName x__) ())
{- | Fields :
      -}
data RemoveRemoteClusterResponse
  = RemoveRemoteClusterResponse'_constructor {_RemoveRemoteClusterResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RemoveRemoteClusterResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message RemoveRemoteClusterResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.RemoveRemoteClusterResponse"
  packedMessageDescriptor _
    = "\n\
      \\ESCRemoveRemoteClusterResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RemoveRemoteClusterResponse'_unknownFields
        (\ x__ y__
           -> x__ {_RemoveRemoteClusterResponse'_unknownFields = y__})
  defMessage
    = RemoveRemoteClusterResponse'_constructor
        {_RemoveRemoteClusterResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RemoveRemoteClusterResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser RemoveRemoteClusterResponse
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
          (do loop Data.ProtoLens.defMessage) "RemoveRemoteClusterResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData RemoveRemoteClusterResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RemoveRemoteClusterResponse'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.searchAttributes' @:: Lens' RemoveSearchAttributesRequest [Data.Text.Text]@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.vec'searchAttributes' @:: Lens' RemoveSearchAttributesRequest (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespace' @:: Lens' RemoveSearchAttributesRequest Data.Text.Text@ -}
data RemoveSearchAttributesRequest
  = RemoveSearchAttributesRequest'_constructor {_RemoveSearchAttributesRequest'searchAttributes :: !(Data.Vector.Vector Data.Text.Text),
                                                _RemoveSearchAttributesRequest'namespace :: !Data.Text.Text,
                                                _RemoveSearchAttributesRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RemoveSearchAttributesRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RemoveSearchAttributesRequest "searchAttributes" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RemoveSearchAttributesRequest'searchAttributes
           (\ x__ y__
              -> x__ {_RemoveSearchAttributesRequest'searchAttributes = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField RemoveSearchAttributesRequest "vec'searchAttributes" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RemoveSearchAttributesRequest'searchAttributes
           (\ x__ y__
              -> x__ {_RemoveSearchAttributesRequest'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RemoveSearchAttributesRequest "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RemoveSearchAttributesRequest'namespace
           (\ x__ y__
              -> x__ {_RemoveSearchAttributesRequest'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Message RemoveSearchAttributesRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.RemoveSearchAttributesRequest"
  packedMessageDescriptor _
    = "\n\
      \\GSRemoveSearchAttributesRequest\DC2+\n\
      \\DC1search_attributes\CAN\SOH \ETX(\tR\DLEsearchAttributes\DC2\FS\n\
      \\tnamespace\CAN\STX \SOH(\tR\tnamespace"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor RemoveSearchAttributesRequest
        namespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"namespace")) ::
              Data.ProtoLens.FieldDescriptor RemoveSearchAttributesRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, searchAttributes__field_descriptor),
           (Data.ProtoLens.Tag 2, namespace__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RemoveSearchAttributesRequest'_unknownFields
        (\ x__ y__
           -> x__ {_RemoveSearchAttributesRequest'_unknownFields = y__})
  defMessage
    = RemoveSearchAttributesRequest'_constructor
        {_RemoveSearchAttributesRequest'searchAttributes = Data.Vector.Generic.empty,
         _RemoveSearchAttributesRequest'namespace = Data.ProtoLens.fieldDefault,
         _RemoveSearchAttributesRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RemoveSearchAttributesRequest
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
             -> Data.ProtoLens.Encoding.Bytes.Parser RemoveSearchAttributesRequest
        loop x mutable'searchAttributes
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'searchAttributes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                   (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                      mutable'searchAttributes)
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
                              (Data.ProtoLens.Field.field @"vec'searchAttributes")
                              frozen'searchAttributes x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "search_attributes"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'searchAttributes y)
                                loop x v
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                                  mutable'searchAttributes
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'searchAttributes
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'searchAttributes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                            Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'searchAttributes)
          "RemoveSearchAttributesRequest"
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
                           Data.Text.Encoding.encodeUtf8 _v))
                (Lens.Family2.view
                   (Data.ProtoLens.Field.field @"vec'searchAttributes") _x))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"namespace") _x
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
instance Control.DeepSeq.NFData RemoveSearchAttributesRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RemoveSearchAttributesRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_RemoveSearchAttributesRequest'searchAttributes x__)
                (Control.DeepSeq.deepseq
                   (_RemoveSearchAttributesRequest'namespace x__) ()))
{- | Fields :
      -}
data RemoveSearchAttributesResponse
  = RemoveSearchAttributesResponse'_constructor {_RemoveSearchAttributesResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RemoveSearchAttributesResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message RemoveSearchAttributesResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.RemoveSearchAttributesResponse"
  packedMessageDescriptor _
    = "\n\
      \\RSRemoveSearchAttributesResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RemoveSearchAttributesResponse'_unknownFields
        (\ x__ y__
           -> x__ {_RemoveSearchAttributesResponse'_unknownFields = y__})
  defMessage
    = RemoveSearchAttributesResponse'_constructor
        {_RemoveSearchAttributesResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RemoveSearchAttributesResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser RemoveSearchAttributesResponse
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
          (do loop Data.ProtoLens.defMessage)
          "RemoveSearchAttributesResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData RemoveSearchAttributesResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RemoveSearchAttributesResponse'_unknownFields x__) ()
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \6temporal/api/operatorservice/v1/request_response.proto\DC2\UStemporal.api.operatorservice.v1\SUB\"temporal/api/enums/v1/common.proto\"\168\STX\n\
    \\SUBAddSearchAttributesRequest\DC2~\n\
    \\DC1search_attributes\CAN\SOH \ETX(\v2Q.temporal.api.operatorservice.v1.AddSearchAttributesRequest.SearchAttributesEntryR\DLEsearchAttributes\DC2\FS\n\
    \\tnamespace\CAN\STX \SOH(\tR\tnamespace\SUBl\n\
    \\NAKSearchAttributesEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
    \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH\"\GS\n\
    \\ESCAddSearchAttributesResponse\"j\n\
    \\GSRemoveSearchAttributesRequest\DC2+\n\
    \\DC1search_attributes\CAN\SOH \ETX(\tR\DLEsearchAttributes\DC2\FS\n\
    \\tnamespace\CAN\STX \SOH(\tR\tnamespace\" \n\
    \\RSRemoveSearchAttributesResponse\";\n\
    \\ESCListSearchAttributesRequest\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\"\187\ENQ\n\
    \\FSListSearchAttributesResponse\DC2\128\SOH\n\
    \\DC1custom_attributes\CAN\SOH \ETX(\v2S.temporal.api.operatorservice.v1.ListSearchAttributesResponse.CustomAttributesEntryR\DLEcustomAttributes\DC2\128\SOH\n\
    \\DC1system_attributes\CAN\STX \ETX(\v2S.temporal.api.operatorservice.v1.ListSearchAttributesResponse.SystemAttributesEntryR\DLEsystemAttributes\DC2w\n\
    \\SOstorage_schema\CAN\ETX \ETX(\v2P.temporal.api.operatorservice.v1.ListSearchAttributesResponse.StorageSchemaEntryR\rstorageSchema\SUBl\n\
    \\NAKCustomAttributesEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
    \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH\SUBl\n\
    \\NAKSystemAttributesEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2=\n\
    \\ENQvalue\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.IndexedValueTypeR\ENQvalue:\STX8\SOH\SUB@\n\
    \\DC2StorageSchemaEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\"Y\n\
    \\SYNDeleteNamespaceRequest\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2!\n\
    \\fnamespace_id\CAN\STX \SOH(\tR\vnamespaceId\"F\n\
    \\ETBDeleteNamespaceResponse\DC2+\n\
    \\DC1deleted_namespace\CAN\SOH \SOH(\tR\DLEdeletedNamespace\"\149\SOH\n\
    \\USAddOrUpdateRemoteClusterRequest\DC2)\n\
    \\DLEfrontend_address\CAN\SOH \SOH(\tR\SIfrontendAddress\DC2G\n\
    \ enable_remote_cluster_connection\CAN\STX \SOH(\bR\GSenableRemoteClusterConnection\"\"\n\
    \ AddOrUpdateRemoteClusterResponse\"?\n\
    \\SUBRemoveRemoteClusterRequest\DC2!\n\
    \\fcluster_name\CAN\SOH \SOH(\tR\vclusterName\"\GS\n\
    \\ESCRemoveRemoteClusterResponse\"Z\n\
    \\DC3ListClustersRequest\DC2\ESC\n\
    \\tpage_size\CAN\SOH \SOH(\ENQR\bpageSize\DC2&\n\
    \\SInext_page_token\CAN\STX \SOH(\fR\rnextPageToken\"\140\SOH\n\
    \\DC4ListClustersResponse\DC2L\n\
    \\bclusters\CAN\SOH \ETX(\v20.temporal.api.operatorservice.v1.ClusterMetadataR\bclusters\DC2&\n\
    \\SInext_page_token\CAN\EOT \SOH(\fR\rnextPageToken\"\139\STX\n\
    \\SIClusterMetadata\DC2!\n\
    \\fcluster_name\CAN\SOH \SOH(\tR\vclusterName\DC2\GS\n\
    \\n\
    \cluster_id\CAN\STX \SOH(\tR\tclusterId\DC2\CAN\n\
    \\aaddress\CAN\ETX \SOH(\tR\aaddress\DC28\n\
    \\CANinitial_failover_version\CAN\EOT \SOH(\ETXR\SYNinitialFailoverVersion\DC2.\n\
    \\DC3history_shard_count\CAN\ENQ \SOH(\ENQR\DC1historyShardCount\DC22\n\
    \\NAKis_connection_enabled\CAN\ACK \SOH(\bR\DC3isConnectionEnabledB\190\SOH\n\
    \\"io.temporal.api.operatorservice.v1B\DC4RequestResponseProtoP\SOHZ5go.temporal.io/api/operatorservice/v1;operatorservice\170\STX!Temporalio.Api.OperatorService.V1\234\STX$Temporalio::Api::OperatorService::V1J\155!\n\
    \\ACK\DC2\EOT\SYN\NUL}\SOH\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL(\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NULL\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NULL\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL;\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL;\n\
    \\b\n\
    \\SOH\b\DC2\ETX\FS\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\FS\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\GS\NUL5\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\GS\NUL5\n\
    \\b\n\
    \\SOH\b\DC2\ETX\RS\NUL=\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL=\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL>\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL>\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL,\n\
    \&\n\
    \\STX\EOT\NUL\DC2\EOT%\NUL)\SOH2\SUB (-- Search Attribute --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX%\b\"\n\
    \N\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX'\EOTN\SUBA Mapping between search attribute name and its IndexedValueType.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX'\EOT7\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX'8I\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX'LM\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX(\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX(\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX(\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX(\ETB\CAN\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT+\NUL,\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX+\b#\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT.\NUL2\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX.\b%\n\
    \0\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX0\EOT*\SUB# Search attribute names to delete.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\EOT\DC2\ETX0\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX0\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX0\DC4%\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX0()\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX1\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX1\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX1\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX1\ETB\CAN\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT4\NUL5\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX4\b&\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOT7\NUL9\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX7\b#\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX8\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETX8\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX8\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX8\ETB\CAN\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOT;\NULB\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX;\b$\n\
    \f\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX=\EOTN\SUBY Mapping between custom (user-registered) search attribute name to its IndexedValueType.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETX=\EOT7\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX=8I\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX=LM\n\
    \a\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETX?\EOTN\SUBT Mapping between system (predefined) search attribute name to its IndexedValueType.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\ETX?\EOT7\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETX?8I\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETX?LM\n\
    \U\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\ETXA\EOT+\SUBH Mapping from the attribute name to the visibility storage native type.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ACK\DC2\ETXA\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\ETXA\CAN&\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\ETXA)*\n\
    \\178\STX\n\
    \\STX\EOT\ACK\DC2\EOTH\NULL\SOH\SUB\165\STX (-- api-linter: core::0135::request-unknown-fields=disabled\n\
    \     aip.dev/not-precedent: DeleteNamespace RPC doesn't follow Google API format. --)\n\
    \ (-- api-linter: core::0135::request-name-required=disabled\n\
    \     aip.dev/not-precedent: DeleteNamespace RPC doesn't follow Google API format. --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXH\b\RS\n\
    \]\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXJ\EOT\EM\SUBP Only one of namespace or namespace_id must be specified to identify namespace.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXJ\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXJ\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXJ\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXK\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXK\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXK\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXK\SUB\ESC\n\
    \\n\
    \\n\
    \\STX\EOT\a\DC2\EOTN\NULQ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXN\b\US\n\
    \S\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXP\EOT!\SUBF Temporary namespace name that is used during reclaim resources step.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETXP\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXP\v\FS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXP\US \n\
    \\n\
    \\n\
    \\STX\EOT\b\DC2\EOTS\NULX\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXS\b'\n\
    \F\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETXU\EOT \SUB9 Frontend Address is a cross cluster accessible address.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\ETXU\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETXU\v\ESC\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETXU\RS\US\n\
    \E\n\
    \\EOT\EOT\b\STX\SOH\DC2\ETXW\EOT.\SUB8 Flag to enable / disable the cross cluster connection.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ENQ\DC2\ETXW\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\ETXW\t)\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\ETXW,-\n\
    \\n\
    \\n\
    \\STX\EOT\t\DC2\EOTZ\NUL[\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETXZ\b(\n\
    \\n\
    \\n\
    \\STX\EOT\n\
    \\DC2\EOT]\NUL`\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETX]\b\"\n\
    \1\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETX_\EOT\FS\SUB$ Remote cluster name to be removed.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETX_\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETX_\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETX_\SUB\ESC\n\
    \\n\
    \\n\
    \\STX\EOT\v\DC2\EOTb\NULc\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETXb\b#\n\
    \\n\
    \\n\
    \\STX\EOT\f\DC2\EOTe\NULh\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\f\SOH\DC2\ETXe\b\ESC\n\
    \\v\n\
    \\EOT\EOT\f\STX\NUL\DC2\ETXf\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ENQ\DC2\ETXf\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\ETXf\n\
    \\DC3\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\ETXf\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\f\STX\SOH\DC2\ETXg\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ENQ\DC2\ETXg\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\ETXg\n\
    \\EM\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\ETXg\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\r\DC2\EOTj\NULn\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\r\SOH\DC2\ETXj\b\FS\n\
    \.\n\
    \\EOT\EOT\r\STX\NUL\DC2\ETXl\EOT*\SUB! List of all cluster information\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\EOT\DC2\ETXl\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\ACK\DC2\ETXl\r\FS\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\ETXl\GS%\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\ETXl()\n\
    \\v\n\
    \\EOT\EOT\r\STX\SOH\DC2\ETXm\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\r\STX\SOH\ENQ\DC2\ETXm\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\r\STX\SOH\SOH\DC2\ETXm\n\
    \\EM\n\
    \\f\n\
    \\ENQ\EOT\r\STX\SOH\ETX\DC2\ETXm\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\SO\DC2\EOTp\NUL}\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SO\SOH\DC2\ETXp\b\ETB\n\
    \(\n\
    \\EOT\EOT\SO\STX\NUL\DC2\ETXr\EOT\FS\SUB\ESC Name of the cluster name.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\ENQ\DC2\ETXr\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\ETXr\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\ETXr\SUB\ESC\n\
    \!\n\
    \\EOT\EOT\SO\STX\SOH\DC2\ETXt\EOT\SUB\SUB\DC4 Id of the cluster.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\SOH\ENQ\DC2\ETXt\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\SOH\SOH\DC2\ETXt\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\SOH\ETX\DC2\ETXt\CAN\EM\n\
    \*\n\
    \\EOT\EOT\SO\STX\STX\DC2\ETXv\EOT\ETB\SUB\GS Cluster accessible address.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\STX\ENQ\DC2\ETXv\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\STX\SOH\DC2\ETXv\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\STX\ETX\DC2\ETXv\NAK\SYN\n\
    \G\n\
    \\EOT\EOT\SO\STX\ETX\DC2\ETXx\EOT'\SUB: A unique failover version across all connected clusters.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ETX\ENQ\DC2\ETXx\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ETX\SOH\DC2\ETXx\n\
    \\"\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ETX\ETX\DC2\ETXx%&\n\
    \,\n\
    \\EOT\EOT\SO\STX\EOT\DC2\ETXz\EOT\"\SUB\US History service shard number.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\EOT\ENQ\DC2\ETXz\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\EOT\SOH\DC2\ETXz\n\
    \\GS\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\EOT\ETX\DC2\ETXz !\n\
    \<\n\
    \\EOT\EOT\SO\STX\ENQ\DC2\ETX|\EOT#\SUB/ A flag to indicate if a connection is active.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ENQ\ENQ\DC2\ETX|\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ENQ\SOH\DC2\ETX|\t\RS\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ENQ\ETX\DC2\ETX|!\"b\ACKproto3"
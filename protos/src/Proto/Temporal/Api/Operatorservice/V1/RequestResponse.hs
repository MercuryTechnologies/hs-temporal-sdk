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
        CreateNexusEndpointRequest(), CreateNexusEndpointResponse(),
        DeleteNamespaceRequest(), DeleteNamespaceResponse(),
        DeleteNexusEndpointRequest(), DeleteNexusEndpointResponse(),
        GetNexusEndpointRequest(), GetNexusEndpointResponse(),
        ListClustersRequest(), ListClustersResponse(),
        ListNexusEndpointsRequest(), ListNexusEndpointsResponse(),
        ListSearchAttributesRequest(), ListSearchAttributesResponse(),
        ListSearchAttributesResponse'CustomAttributesEntry(),
        ListSearchAttributesResponse'StorageSchemaEntry(),
        ListSearchAttributesResponse'SystemAttributesEntry(),
        RemoveRemoteClusterRequest(), RemoveRemoteClusterResponse(),
        RemoveSearchAttributesRequest(), RemoveSearchAttributesResponse(),
        UpdateNexusEndpointRequest(), UpdateNexusEndpointResponse()
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
import qualified Proto.Temporal.Api.Enums.V1.Common
import qualified Proto.Temporal.Api.Nexus.V1.Message
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.frontendAddress' @:: Lens' AddOrUpdateRemoteClusterRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.enableRemoteClusterConnection' @:: Lens' AddOrUpdateRemoteClusterRequest Prelude.Bool@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.frontendHttpAddress' @:: Lens' AddOrUpdateRemoteClusterRequest Data.Text.Text@ -}
data AddOrUpdateRemoteClusterRequest
  = AddOrUpdateRemoteClusterRequest'_constructor {_AddOrUpdateRemoteClusterRequest'frontendAddress :: !Data.Text.Text,
                                                  _AddOrUpdateRemoteClusterRequest'enableRemoteClusterConnection :: !Prelude.Bool,
                                                  _AddOrUpdateRemoteClusterRequest'frontendHttpAddress :: !Data.Text.Text,
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
instance Data.ProtoLens.Field.HasField AddOrUpdateRemoteClusterRequest "frontendHttpAddress" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddOrUpdateRemoteClusterRequest'frontendHttpAddress
           (\ x__ y__
              -> x__
                   {_AddOrUpdateRemoteClusterRequest'frontendHttpAddress = y__}))
        Prelude.id
instance Data.ProtoLens.Message AddOrUpdateRemoteClusterRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.AddOrUpdateRemoteClusterRequest"
  packedMessageDescriptor _
    = "\n\
      \\USAddOrUpdateRemoteClusterRequest\DC2)\n\
      \\DLEfrontend_address\CAN\SOH \SOH(\tR\SIfrontendAddress\DC2G\n\
      \ enable_remote_cluster_connection\CAN\STX \SOH(\bR\GSenableRemoteClusterConnection\DC22\n\
      \\NAKfrontend_http_address\CAN\ETX \SOH(\tR\DC3frontendHttpAddress"
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
        frontendHttpAddress__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "frontend_http_address"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"frontendHttpAddress")) ::
              Data.ProtoLens.FieldDescriptor AddOrUpdateRemoteClusterRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, frontendAddress__field_descriptor),
           (Data.ProtoLens.Tag 2, 
            enableRemoteClusterConnection__field_descriptor),
           (Data.ProtoLens.Tag 3, frontendHttpAddress__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddOrUpdateRemoteClusterRequest'_unknownFields
        (\ x__ y__
           -> x__ {_AddOrUpdateRemoteClusterRequest'_unknownFields = y__})
  defMessage
    = AddOrUpdateRemoteClusterRequest'_constructor
        {_AddOrUpdateRemoteClusterRequest'frontendAddress = Data.ProtoLens.fieldDefault,
         _AddOrUpdateRemoteClusterRequest'enableRemoteClusterConnection = Data.ProtoLens.fieldDefault,
         _AddOrUpdateRemoteClusterRequest'frontendHttpAddress = Data.ProtoLens.fieldDefault,
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
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "frontend_http_address"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"frontendHttpAddress") y x)
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
                ((Data.Monoid.<>)
                   (let
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"frontendHttpAddress") _x
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
                   (Control.DeepSeq.deepseq
                      (_AddOrUpdateRemoteClusterRequest'frontendHttpAddress x__) ())))
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
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.httpAddress' @:: Lens' ClusterMetadata Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.initialFailoverVersion' @:: Lens' ClusterMetadata Data.Int.Int64@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.historyShardCount' @:: Lens' ClusterMetadata Data.Int.Int32@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.isConnectionEnabled' @:: Lens' ClusterMetadata Prelude.Bool@ -}
data ClusterMetadata
  = ClusterMetadata'_constructor {_ClusterMetadata'clusterName :: !Data.Text.Text,
                                  _ClusterMetadata'clusterId :: !Data.Text.Text,
                                  _ClusterMetadata'address :: !Data.Text.Text,
                                  _ClusterMetadata'httpAddress :: !Data.Text.Text,
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
instance Data.ProtoLens.Field.HasField ClusterMetadata "httpAddress" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterMetadata'httpAddress
           (\ x__ y__ -> x__ {_ClusterMetadata'httpAddress = y__}))
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
      \\aaddress\CAN\ETX \SOH(\tR\aaddress\DC2!\n\
      \\fhttp_address\CAN\a \SOH(\tR\vhttpAddress\DC28\n\
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
        httpAddress__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "http_address"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"httpAddress")) ::
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
           (Data.ProtoLens.Tag 7, httpAddress__field_descriptor),
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
         _ClusterMetadata'httpAddress = Data.ProtoLens.fieldDefault,
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
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "http_address"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"httpAddress") y x)
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
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"httpAddress") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
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
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral
                                     _v))
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
                                  (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))
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
                         (_ClusterMetadata'httpAddress x__)
                         (Control.DeepSeq.deepseq
                            (_ClusterMetadata'initialFailoverVersion x__)
                            (Control.DeepSeq.deepseq
                               (_ClusterMetadata'historyShardCount x__)
                               (Control.DeepSeq.deepseq
                                  (_ClusterMetadata'isConnectionEnabled x__) ())))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.spec' @:: Lens' CreateNexusEndpointRequest Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.maybe'spec' @:: Lens' CreateNexusEndpointRequest (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec)@ -}
data CreateNexusEndpointRequest
  = CreateNexusEndpointRequest'_constructor {_CreateNexusEndpointRequest'spec :: !(Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec),
                                             _CreateNexusEndpointRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CreateNexusEndpointRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CreateNexusEndpointRequest "spec" Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CreateNexusEndpointRequest'spec
           (\ x__ y__ -> x__ {_CreateNexusEndpointRequest'spec = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CreateNexusEndpointRequest "maybe'spec" (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CreateNexusEndpointRequest'spec
           (\ x__ y__ -> x__ {_CreateNexusEndpointRequest'spec = y__}))
        Prelude.id
instance Data.ProtoLens.Message CreateNexusEndpointRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.CreateNexusEndpointRequest"
  packedMessageDescriptor _
    = "\n\
      \\SUBCreateNexusEndpointRequest\DC27\n\
      \\EOTspec\CAN\SOH \SOH(\v2#.temporal.api.nexus.v1.EndpointSpecR\EOTspec"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        spec__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "spec"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'spec")) ::
              Data.ProtoLens.FieldDescriptor CreateNexusEndpointRequest
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, spec__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CreateNexusEndpointRequest'_unknownFields
        (\ x__ y__
           -> x__ {_CreateNexusEndpointRequest'_unknownFields = y__})
  defMessage
    = CreateNexusEndpointRequest'_constructor
        {_CreateNexusEndpointRequest'spec = Prelude.Nothing,
         _CreateNexusEndpointRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CreateNexusEndpointRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser CreateNexusEndpointRequest
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
                                       "spec"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"spec") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CreateNexusEndpointRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'spec") _x
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
instance Control.DeepSeq.NFData CreateNexusEndpointRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CreateNexusEndpointRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq (_CreateNexusEndpointRequest'spec x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.endpoint' @:: Lens' CreateNexusEndpointResponse Proto.Temporal.Api.Nexus.V1.Message.Endpoint@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.maybe'endpoint' @:: Lens' CreateNexusEndpointResponse (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint)@ -}
data CreateNexusEndpointResponse
  = CreateNexusEndpointResponse'_constructor {_CreateNexusEndpointResponse'endpoint :: !(Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint),
                                              _CreateNexusEndpointResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CreateNexusEndpointResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CreateNexusEndpointResponse "endpoint" Proto.Temporal.Api.Nexus.V1.Message.Endpoint where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CreateNexusEndpointResponse'endpoint
           (\ x__ y__ -> x__ {_CreateNexusEndpointResponse'endpoint = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CreateNexusEndpointResponse "maybe'endpoint" (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CreateNexusEndpointResponse'endpoint
           (\ x__ y__ -> x__ {_CreateNexusEndpointResponse'endpoint = y__}))
        Prelude.id
instance Data.ProtoLens.Message CreateNexusEndpointResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.CreateNexusEndpointResponse"
  packedMessageDescriptor _
    = "\n\
      \\ESCCreateNexusEndpointResponse\DC2;\n\
      \\bendpoint\CAN\SOH \SOH(\v2\US.temporal.api.nexus.v1.EndpointR\bendpoint"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        endpoint__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "endpoint"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.Endpoint)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'endpoint")) ::
              Data.ProtoLens.FieldDescriptor CreateNexusEndpointResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, endpoint__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CreateNexusEndpointResponse'_unknownFields
        (\ x__ y__
           -> x__ {_CreateNexusEndpointResponse'_unknownFields = y__})
  defMessage
    = CreateNexusEndpointResponse'_constructor
        {_CreateNexusEndpointResponse'endpoint = Prelude.Nothing,
         _CreateNexusEndpointResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CreateNexusEndpointResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser CreateNexusEndpointResponse
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
                                       "endpoint"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"endpoint") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CreateNexusEndpointResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'endpoint") _x
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
instance Control.DeepSeq.NFData CreateNexusEndpointResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CreateNexusEndpointResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CreateNexusEndpointResponse'endpoint x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespace' @:: Lens' DeleteNamespaceRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespaceId' @:: Lens' DeleteNamespaceRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.namespaceDeleteDelay' @:: Lens' DeleteNamespaceRequest Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.maybe'namespaceDeleteDelay' @:: Lens' DeleteNamespaceRequest (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@ -}
data DeleteNamespaceRequest
  = DeleteNamespaceRequest'_constructor {_DeleteNamespaceRequest'namespace :: !Data.Text.Text,
                                         _DeleteNamespaceRequest'namespaceId :: !Data.Text.Text,
                                         _DeleteNamespaceRequest'namespaceDeleteDelay :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
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
instance Data.ProtoLens.Field.HasField DeleteNamespaceRequest "namespaceDeleteDelay" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeleteNamespaceRequest'namespaceDeleteDelay
           (\ x__ y__
              -> x__ {_DeleteNamespaceRequest'namespaceDeleteDelay = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField DeleteNamespaceRequest "maybe'namespaceDeleteDelay" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeleteNamespaceRequest'namespaceDeleteDelay
           (\ x__ y__
              -> x__ {_DeleteNamespaceRequest'namespaceDeleteDelay = y__}))
        Prelude.id
instance Data.ProtoLens.Message DeleteNamespaceRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.DeleteNamespaceRequest"
  packedMessageDescriptor _
    = "\n\
      \\SYNDeleteNamespaceRequest\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2!\n\
      \\fnamespace_id\CAN\STX \SOH(\tR\vnamespaceId\DC2O\n\
      \\SYNnamespace_delete_delay\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\DC4namespaceDeleteDelay"
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
        namespaceDeleteDelay__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace_delete_delay"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'namespaceDeleteDelay")) ::
              Data.ProtoLens.FieldDescriptor DeleteNamespaceRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, namespaceId__field_descriptor),
           (Data.ProtoLens.Tag 3, namespaceDeleteDelay__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DeleteNamespaceRequest'_unknownFields
        (\ x__ y__ -> x__ {_DeleteNamespaceRequest'_unknownFields = y__})
  defMessage
    = DeleteNamespaceRequest'_constructor
        {_DeleteNamespaceRequest'namespace = Data.ProtoLens.fieldDefault,
         _DeleteNamespaceRequest'namespaceId = Data.ProtoLens.fieldDefault,
         _DeleteNamespaceRequest'namespaceDeleteDelay = Prelude.Nothing,
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
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "namespace_delete_delay"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"namespaceDeleteDelay") y x)
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
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'namespaceDeleteDelay") _x
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
instance Control.DeepSeq.NFData DeleteNamespaceRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DeleteNamespaceRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_DeleteNamespaceRequest'namespace x__)
                (Control.DeepSeq.deepseq
                   (_DeleteNamespaceRequest'namespaceId x__)
                   (Control.DeepSeq.deepseq
                      (_DeleteNamespaceRequest'namespaceDeleteDelay x__) ())))
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
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.id' @:: Lens' DeleteNexusEndpointRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.version' @:: Lens' DeleteNexusEndpointRequest Data.Int.Int64@ -}
data DeleteNexusEndpointRequest
  = DeleteNexusEndpointRequest'_constructor {_DeleteNexusEndpointRequest'id :: !Data.Text.Text,
                                             _DeleteNexusEndpointRequest'version :: !Data.Int.Int64,
                                             _DeleteNexusEndpointRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show DeleteNexusEndpointRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField DeleteNexusEndpointRequest "id" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeleteNexusEndpointRequest'id
           (\ x__ y__ -> x__ {_DeleteNexusEndpointRequest'id = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField DeleteNexusEndpointRequest "version" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeleteNexusEndpointRequest'version
           (\ x__ y__ -> x__ {_DeleteNexusEndpointRequest'version = y__}))
        Prelude.id
instance Data.ProtoLens.Message DeleteNexusEndpointRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.DeleteNexusEndpointRequest"
  packedMessageDescriptor _
    = "\n\
      \\SUBDeleteNexusEndpointRequest\DC2\SO\n\
      \\STXid\CAN\SOH \SOH(\tR\STXid\DC2\CAN\n\
      \\aversion\CAN\STX \SOH(\ETXR\aversion"
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
              Data.ProtoLens.FieldDescriptor DeleteNexusEndpointRequest
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor DeleteNexusEndpointRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, id__field_descriptor),
           (Data.ProtoLens.Tag 2, version__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DeleteNexusEndpointRequest'_unknownFields
        (\ x__ y__
           -> x__ {_DeleteNexusEndpointRequest'_unknownFields = y__})
  defMessage
    = DeleteNexusEndpointRequest'_constructor
        {_DeleteNexusEndpointRequest'id = Data.ProtoLens.fieldDefault,
         _DeleteNexusEndpointRequest'version = Data.ProtoLens.fieldDefault,
         _DeleteNexusEndpointRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          DeleteNexusEndpointRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser DeleteNexusEndpointRequest
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
                                       "id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"id") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "version"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"version") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "DeleteNexusEndpointRequest"
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"version") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData DeleteNexusEndpointRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DeleteNexusEndpointRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_DeleteNexusEndpointRequest'id x__)
                (Control.DeepSeq.deepseq
                   (_DeleteNexusEndpointRequest'version x__) ()))
{- | Fields :
      -}
data DeleteNexusEndpointResponse
  = DeleteNexusEndpointResponse'_constructor {_DeleteNexusEndpointResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show DeleteNexusEndpointResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message DeleteNexusEndpointResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.DeleteNexusEndpointResponse"
  packedMessageDescriptor _
    = "\n\
      \\ESCDeleteNexusEndpointResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DeleteNexusEndpointResponse'_unknownFields
        (\ x__ y__
           -> x__ {_DeleteNexusEndpointResponse'_unknownFields = y__})
  defMessage
    = DeleteNexusEndpointResponse'_constructor
        {_DeleteNexusEndpointResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          DeleteNexusEndpointResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser DeleteNexusEndpointResponse
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
          (do loop Data.ProtoLens.defMessage) "DeleteNexusEndpointResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData DeleteNexusEndpointResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DeleteNexusEndpointResponse'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.id' @:: Lens' GetNexusEndpointRequest Data.Text.Text@ -}
data GetNexusEndpointRequest
  = GetNexusEndpointRequest'_constructor {_GetNexusEndpointRequest'id :: !Data.Text.Text,
                                          _GetNexusEndpointRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show GetNexusEndpointRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField GetNexusEndpointRequest "id" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetNexusEndpointRequest'id
           (\ x__ y__ -> x__ {_GetNexusEndpointRequest'id = y__}))
        Prelude.id
instance Data.ProtoLens.Message GetNexusEndpointRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.GetNexusEndpointRequest"
  packedMessageDescriptor _
    = "\n\
      \\ETBGetNexusEndpointRequest\DC2\SO\n\
      \\STXid\CAN\SOH \SOH(\tR\STXid"
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
              Data.ProtoLens.FieldDescriptor GetNexusEndpointRequest
      in Data.Map.fromList [(Data.ProtoLens.Tag 1, id__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _GetNexusEndpointRequest'_unknownFields
        (\ x__ y__ -> x__ {_GetNexusEndpointRequest'_unknownFields = y__})
  defMessage
    = GetNexusEndpointRequest'_constructor
        {_GetNexusEndpointRequest'id = Data.ProtoLens.fieldDefault,
         _GetNexusEndpointRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          GetNexusEndpointRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser GetNexusEndpointRequest
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
                                       "id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"id") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "GetNexusEndpointRequest"
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData GetNexusEndpointRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_GetNexusEndpointRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq (_GetNexusEndpointRequest'id x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.endpoint' @:: Lens' GetNexusEndpointResponse Proto.Temporal.Api.Nexus.V1.Message.Endpoint@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.maybe'endpoint' @:: Lens' GetNexusEndpointResponse (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint)@ -}
data GetNexusEndpointResponse
  = GetNexusEndpointResponse'_constructor {_GetNexusEndpointResponse'endpoint :: !(Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint),
                                           _GetNexusEndpointResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show GetNexusEndpointResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField GetNexusEndpointResponse "endpoint" Proto.Temporal.Api.Nexus.V1.Message.Endpoint where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetNexusEndpointResponse'endpoint
           (\ x__ y__ -> x__ {_GetNexusEndpointResponse'endpoint = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField GetNexusEndpointResponse "maybe'endpoint" (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetNexusEndpointResponse'endpoint
           (\ x__ y__ -> x__ {_GetNexusEndpointResponse'endpoint = y__}))
        Prelude.id
instance Data.ProtoLens.Message GetNexusEndpointResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.GetNexusEndpointResponse"
  packedMessageDescriptor _
    = "\n\
      \\CANGetNexusEndpointResponse\DC2;\n\
      \\bendpoint\CAN\SOH \SOH(\v2\US.temporal.api.nexus.v1.EndpointR\bendpoint"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        endpoint__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "endpoint"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.Endpoint)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'endpoint")) ::
              Data.ProtoLens.FieldDescriptor GetNexusEndpointResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, endpoint__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _GetNexusEndpointResponse'_unknownFields
        (\ x__ y__ -> x__ {_GetNexusEndpointResponse'_unknownFields = y__})
  defMessage
    = GetNexusEndpointResponse'_constructor
        {_GetNexusEndpointResponse'endpoint = Prelude.Nothing,
         _GetNexusEndpointResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          GetNexusEndpointResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser GetNexusEndpointResponse
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
                                       "endpoint"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"endpoint") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "GetNexusEndpointResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'endpoint") _x
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
instance Control.DeepSeq.NFData GetNexusEndpointResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_GetNexusEndpointResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_GetNexusEndpointResponse'endpoint x__) ())
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
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.pageSize' @:: Lens' ListNexusEndpointsRequest Data.Int.Int32@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.nextPageToken' @:: Lens' ListNexusEndpointsRequest Data.ByteString.ByteString@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.name' @:: Lens' ListNexusEndpointsRequest Data.Text.Text@ -}
data ListNexusEndpointsRequest
  = ListNexusEndpointsRequest'_constructor {_ListNexusEndpointsRequest'pageSize :: !Data.Int.Int32,
                                            _ListNexusEndpointsRequest'nextPageToken :: !Data.ByteString.ByteString,
                                            _ListNexusEndpointsRequest'name :: !Data.Text.Text,
                                            _ListNexusEndpointsRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListNexusEndpointsRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListNexusEndpointsRequest "pageSize" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListNexusEndpointsRequest'pageSize
           (\ x__ y__ -> x__ {_ListNexusEndpointsRequest'pageSize = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListNexusEndpointsRequest "nextPageToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListNexusEndpointsRequest'nextPageToken
           (\ x__ y__
              -> x__ {_ListNexusEndpointsRequest'nextPageToken = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListNexusEndpointsRequest "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListNexusEndpointsRequest'name
           (\ x__ y__ -> x__ {_ListNexusEndpointsRequest'name = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListNexusEndpointsRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListNexusEndpointsRequest"
  packedMessageDescriptor _
    = "\n\
      \\EMListNexusEndpointsRequest\DC2\ESC\n\
      \\tpage_size\CAN\SOH \SOH(\ENQR\bpageSize\DC2&\n\
      \\SInext_page_token\CAN\STX \SOH(\fR\rnextPageToken\DC2\DC2\n\
      \\EOTname\CAN\ETX \SOH(\tR\EOTname"
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
              Data.ProtoLens.FieldDescriptor ListNexusEndpointsRequest
        nextPageToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_page_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"nextPageToken")) ::
              Data.ProtoLens.FieldDescriptor ListNexusEndpointsRequest
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor ListNexusEndpointsRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, pageSize__field_descriptor),
           (Data.ProtoLens.Tag 2, nextPageToken__field_descriptor),
           (Data.ProtoLens.Tag 3, name__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListNexusEndpointsRequest'_unknownFields
        (\ x__ y__
           -> x__ {_ListNexusEndpointsRequest'_unknownFields = y__})
  defMessage
    = ListNexusEndpointsRequest'_constructor
        {_ListNexusEndpointsRequest'pageSize = Data.ProtoLens.fieldDefault,
         _ListNexusEndpointsRequest'nextPageToken = Data.ProtoLens.fieldDefault,
         _ListNexusEndpointsRequest'name = Data.ProtoLens.fieldDefault,
         _ListNexusEndpointsRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListNexusEndpointsRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser ListNexusEndpointsRequest
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
                        26
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
          (do loop Data.ProtoLens.defMessage) "ListNexusEndpointsRequest"
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
                ((Data.Monoid.<>)
                   (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
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
instance Control.DeepSeq.NFData ListNexusEndpointsRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListNexusEndpointsRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ListNexusEndpointsRequest'pageSize x__)
                (Control.DeepSeq.deepseq
                   (_ListNexusEndpointsRequest'nextPageToken x__)
                   (Control.DeepSeq.deepseq
                      (_ListNexusEndpointsRequest'name x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.nextPageToken' @:: Lens' ListNexusEndpointsResponse Data.ByteString.ByteString@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.endpoints' @:: Lens' ListNexusEndpointsResponse [Proto.Temporal.Api.Nexus.V1.Message.Endpoint]@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.vec'endpoints' @:: Lens' ListNexusEndpointsResponse (Data.Vector.Vector Proto.Temporal.Api.Nexus.V1.Message.Endpoint)@ -}
data ListNexusEndpointsResponse
  = ListNexusEndpointsResponse'_constructor {_ListNexusEndpointsResponse'nextPageToken :: !Data.ByteString.ByteString,
                                             _ListNexusEndpointsResponse'endpoints :: !(Data.Vector.Vector Proto.Temporal.Api.Nexus.V1.Message.Endpoint),
                                             _ListNexusEndpointsResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ListNexusEndpointsResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ListNexusEndpointsResponse "nextPageToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListNexusEndpointsResponse'nextPageToken
           (\ x__ y__
              -> x__ {_ListNexusEndpointsResponse'nextPageToken = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ListNexusEndpointsResponse "endpoints" [Proto.Temporal.Api.Nexus.V1.Message.Endpoint] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListNexusEndpointsResponse'endpoints
           (\ x__ y__ -> x__ {_ListNexusEndpointsResponse'endpoints = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ListNexusEndpointsResponse "vec'endpoints" (Data.Vector.Vector Proto.Temporal.Api.Nexus.V1.Message.Endpoint) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ListNexusEndpointsResponse'endpoints
           (\ x__ y__ -> x__ {_ListNexusEndpointsResponse'endpoints = y__}))
        Prelude.id
instance Data.ProtoLens.Message ListNexusEndpointsResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.ListNexusEndpointsResponse"
  packedMessageDescriptor _
    = "\n\
      \\SUBListNexusEndpointsResponse\DC2&\n\
      \\SInext_page_token\CAN\SOH \SOH(\fR\rnextPageToken\DC2=\n\
      \\tendpoints\CAN\STX \ETX(\v2\US.temporal.api.nexus.v1.EndpointR\tendpoints"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        nextPageToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_page_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"nextPageToken")) ::
              Data.ProtoLens.FieldDescriptor ListNexusEndpointsResponse
        endpoints__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "endpoints"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.Endpoint)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"endpoints")) ::
              Data.ProtoLens.FieldDescriptor ListNexusEndpointsResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, nextPageToken__field_descriptor),
           (Data.ProtoLens.Tag 2, endpoints__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ListNexusEndpointsResponse'_unknownFields
        (\ x__ y__
           -> x__ {_ListNexusEndpointsResponse'_unknownFields = y__})
  defMessage
    = ListNexusEndpointsResponse'_constructor
        {_ListNexusEndpointsResponse'nextPageToken = Data.ProtoLens.fieldDefault,
         _ListNexusEndpointsResponse'endpoints = Data.Vector.Generic.empty,
         _ListNexusEndpointsResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ListNexusEndpointsResponse
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Nexus.V1.Message.Endpoint
             -> Data.ProtoLens.Encoding.Bytes.Parser ListNexusEndpointsResponse
        loop x mutable'endpoints
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'endpoints <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                            (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                               mutable'endpoints)
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
                              (Data.ProtoLens.Field.field @"vec'endpoints") frozen'endpoints x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "next_page_token"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nextPageToken") y x)
                                  mutable'endpoints
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "endpoints"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'endpoints y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'endpoints
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'endpoints <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                     Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'endpoints)
          "ListNexusEndpointsResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"nextPageToken") _x
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
                (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                           ((Prelude..)
                              (\ bs
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                         (Prelude.fromIntegral (Data.ByteString.length bs)))
                                      (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                              Data.ProtoLens.encodeMessage _v))
                   (Lens.Family2.view
                      (Data.ProtoLens.Field.field @"vec'endpoints") _x))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData ListNexusEndpointsResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ListNexusEndpointsResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ListNexusEndpointsResponse'nextPageToken x__)
                (Control.DeepSeq.deepseq
                   (_ListNexusEndpointsResponse'endpoints x__) ()))
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
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.id' @:: Lens' UpdateNexusEndpointRequest Data.Text.Text@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.version' @:: Lens' UpdateNexusEndpointRequest Data.Int.Int64@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.spec' @:: Lens' UpdateNexusEndpointRequest Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.maybe'spec' @:: Lens' UpdateNexusEndpointRequest (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec)@ -}
data UpdateNexusEndpointRequest
  = UpdateNexusEndpointRequest'_constructor {_UpdateNexusEndpointRequest'id :: !Data.Text.Text,
                                             _UpdateNexusEndpointRequest'version :: !Data.Int.Int64,
                                             _UpdateNexusEndpointRequest'spec :: !(Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec),
                                             _UpdateNexusEndpointRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UpdateNexusEndpointRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UpdateNexusEndpointRequest "id" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNexusEndpointRequest'id
           (\ x__ y__ -> x__ {_UpdateNexusEndpointRequest'id = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UpdateNexusEndpointRequest "version" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNexusEndpointRequest'version
           (\ x__ y__ -> x__ {_UpdateNexusEndpointRequest'version = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField UpdateNexusEndpointRequest "spec" Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNexusEndpointRequest'spec
           (\ x__ y__ -> x__ {_UpdateNexusEndpointRequest'spec = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField UpdateNexusEndpointRequest "maybe'spec" (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNexusEndpointRequest'spec
           (\ x__ y__ -> x__ {_UpdateNexusEndpointRequest'spec = y__}))
        Prelude.id
instance Data.ProtoLens.Message UpdateNexusEndpointRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.UpdateNexusEndpointRequest"
  packedMessageDescriptor _
    = "\n\
      \\SUBUpdateNexusEndpointRequest\DC2\SO\n\
      \\STXid\CAN\SOH \SOH(\tR\STXid\DC2\CAN\n\
      \\aversion\CAN\STX \SOH(\ETXR\aversion\DC27\n\
      \\EOTspec\CAN\ETX \SOH(\v2#.temporal.api.nexus.v1.EndpointSpecR\EOTspec"
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
              Data.ProtoLens.FieldDescriptor UpdateNexusEndpointRequest
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor UpdateNexusEndpointRequest
        spec__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "spec"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.EndpointSpec)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'spec")) ::
              Data.ProtoLens.FieldDescriptor UpdateNexusEndpointRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, id__field_descriptor),
           (Data.ProtoLens.Tag 2, version__field_descriptor),
           (Data.ProtoLens.Tag 3, spec__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UpdateNexusEndpointRequest'_unknownFields
        (\ x__ y__
           -> x__ {_UpdateNexusEndpointRequest'_unknownFields = y__})
  defMessage
    = UpdateNexusEndpointRequest'_constructor
        {_UpdateNexusEndpointRequest'id = Data.ProtoLens.fieldDefault,
         _UpdateNexusEndpointRequest'version = Data.ProtoLens.fieldDefault,
         _UpdateNexusEndpointRequest'spec = Prelude.Nothing,
         _UpdateNexusEndpointRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UpdateNexusEndpointRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser UpdateNexusEndpointRequest
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
                                       "id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"id") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "version"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"version") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "spec"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"spec") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "UpdateNexusEndpointRequest"
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"version") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData UpdateNexusEndpointRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UpdateNexusEndpointRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_UpdateNexusEndpointRequest'id x__)
                (Control.DeepSeq.deepseq
                   (_UpdateNexusEndpointRequest'version x__)
                   (Control.DeepSeq.deepseq
                      (_UpdateNexusEndpointRequest'spec x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.endpoint' @:: Lens' UpdateNexusEndpointResponse Proto.Temporal.Api.Nexus.V1.Message.Endpoint@
         * 'Proto.Temporal.Api.Operatorservice.V1.RequestResponse_Fields.maybe'endpoint' @:: Lens' UpdateNexusEndpointResponse (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint)@ -}
data UpdateNexusEndpointResponse
  = UpdateNexusEndpointResponse'_constructor {_UpdateNexusEndpointResponse'endpoint :: !(Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint),
                                              _UpdateNexusEndpointResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UpdateNexusEndpointResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UpdateNexusEndpointResponse "endpoint" Proto.Temporal.Api.Nexus.V1.Message.Endpoint where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNexusEndpointResponse'endpoint
           (\ x__ y__ -> x__ {_UpdateNexusEndpointResponse'endpoint = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField UpdateNexusEndpointResponse "maybe'endpoint" (Prelude.Maybe Proto.Temporal.Api.Nexus.V1.Message.Endpoint) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateNexusEndpointResponse'endpoint
           (\ x__ y__ -> x__ {_UpdateNexusEndpointResponse'endpoint = y__}))
        Prelude.id
instance Data.ProtoLens.Message UpdateNexusEndpointResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.operatorservice.v1.UpdateNexusEndpointResponse"
  packedMessageDescriptor _
    = "\n\
      \\ESCUpdateNexusEndpointResponse\DC2;\n\
      \\bendpoint\CAN\SOH \SOH(\v2\US.temporal.api.nexus.v1.EndpointR\bendpoint"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        endpoint__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "endpoint"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Nexus.V1.Message.Endpoint)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'endpoint")) ::
              Data.ProtoLens.FieldDescriptor UpdateNexusEndpointResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, endpoint__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UpdateNexusEndpointResponse'_unknownFields
        (\ x__ y__
           -> x__ {_UpdateNexusEndpointResponse'_unknownFields = y__})
  defMessage
    = UpdateNexusEndpointResponse'_constructor
        {_UpdateNexusEndpointResponse'endpoint = Prelude.Nothing,
         _UpdateNexusEndpointResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UpdateNexusEndpointResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser UpdateNexusEndpointResponse
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
                                       "endpoint"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"endpoint") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "UpdateNexusEndpointResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'endpoint") _x
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
instance Control.DeepSeq.NFData UpdateNexusEndpointResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UpdateNexusEndpointResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_UpdateNexusEndpointResponse'endpoint x__) ())
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \6temporal/api/operatorservice/v1/request_response.proto\DC2\UStemporal.api.operatorservice.v1\SUB\"temporal/api/enums/v1/common.proto\SUB#temporal/api/nexus/v1/message.proto\SUB\RSgoogle/protobuf/duration.proto\"\168\STX\n\
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
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\"\170\SOH\n\
    \\SYNDeleteNamespaceRequest\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2!\n\
    \\fnamespace_id\CAN\STX \SOH(\tR\vnamespaceId\DC2O\n\
    \\SYNnamespace_delete_delay\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\DC4namespaceDeleteDelay\"F\n\
    \\ETBDeleteNamespaceResponse\DC2+\n\
    \\DC1deleted_namespace\CAN\SOH \SOH(\tR\DLEdeletedNamespace\"\201\SOH\n\
    \\USAddOrUpdateRemoteClusterRequest\DC2)\n\
    \\DLEfrontend_address\CAN\SOH \SOH(\tR\SIfrontendAddress\DC2G\n\
    \ enable_remote_cluster_connection\CAN\STX \SOH(\bR\GSenableRemoteClusterConnection\DC22\n\
    \\NAKfrontend_http_address\CAN\ETX \SOH(\tR\DC3frontendHttpAddress\"\"\n\
    \ AddOrUpdateRemoteClusterResponse\"?\n\
    \\SUBRemoveRemoteClusterRequest\DC2!\n\
    \\fcluster_name\CAN\SOH \SOH(\tR\vclusterName\"\GS\n\
    \\ESCRemoveRemoteClusterResponse\"Z\n\
    \\DC3ListClustersRequest\DC2\ESC\n\
    \\tpage_size\CAN\SOH \SOH(\ENQR\bpageSize\DC2&\n\
    \\SInext_page_token\CAN\STX \SOH(\fR\rnextPageToken\"\140\SOH\n\
    \\DC4ListClustersResponse\DC2L\n\
    \\bclusters\CAN\SOH \ETX(\v20.temporal.api.operatorservice.v1.ClusterMetadataR\bclusters\DC2&\n\
    \\SInext_page_token\CAN\EOT \SOH(\fR\rnextPageToken\"\174\STX\n\
    \\SIClusterMetadata\DC2!\n\
    \\fcluster_name\CAN\SOH \SOH(\tR\vclusterName\DC2\GS\n\
    \\n\
    \cluster_id\CAN\STX \SOH(\tR\tclusterId\DC2\CAN\n\
    \\aaddress\CAN\ETX \SOH(\tR\aaddress\DC2!\n\
    \\fhttp_address\CAN\a \SOH(\tR\vhttpAddress\DC28\n\
    \\CANinitial_failover_version\CAN\EOT \SOH(\ETXR\SYNinitialFailoverVersion\DC2.\n\
    \\DC3history_shard_count\CAN\ENQ \SOH(\ENQR\DC1historyShardCount\DC22\n\
    \\NAKis_connection_enabled\CAN\ACK \SOH(\bR\DC3isConnectionEnabled\")\n\
    \\ETBGetNexusEndpointRequest\DC2\SO\n\
    \\STXid\CAN\SOH \SOH(\tR\STXid\"W\n\
    \\CANGetNexusEndpointResponse\DC2;\n\
    \\bendpoint\CAN\SOH \SOH(\v2\US.temporal.api.nexus.v1.EndpointR\bendpoint\"U\n\
    \\SUBCreateNexusEndpointRequest\DC27\n\
    \\EOTspec\CAN\SOH \SOH(\v2#.temporal.api.nexus.v1.EndpointSpecR\EOTspec\"Z\n\
    \\ESCCreateNexusEndpointResponse\DC2;\n\
    \\bendpoint\CAN\SOH \SOH(\v2\US.temporal.api.nexus.v1.EndpointR\bendpoint\"\DEL\n\
    \\SUBUpdateNexusEndpointRequest\DC2\SO\n\
    \\STXid\CAN\SOH \SOH(\tR\STXid\DC2\CAN\n\
    \\aversion\CAN\STX \SOH(\ETXR\aversion\DC27\n\
    \\EOTspec\CAN\ETX \SOH(\v2#.temporal.api.nexus.v1.EndpointSpecR\EOTspec\"Z\n\
    \\ESCUpdateNexusEndpointResponse\DC2;\n\
    \\bendpoint\CAN\SOH \SOH(\v2\US.temporal.api.nexus.v1.EndpointR\bendpoint\"F\n\
    \\SUBDeleteNexusEndpointRequest\DC2\SO\n\
    \\STXid\CAN\SOH \SOH(\tR\STXid\DC2\CAN\n\
    \\aversion\CAN\STX \SOH(\ETXR\aversion\"\GS\n\
    \\ESCDeleteNexusEndpointResponse\"t\n\
    \\EMListNexusEndpointsRequest\DC2\ESC\n\
    \\tpage_size\CAN\SOH \SOH(\ENQR\bpageSize\DC2&\n\
    \\SInext_page_token\CAN\STX \SOH(\fR\rnextPageToken\DC2\DC2\n\
    \\EOTname\CAN\ETX \SOH(\tR\EOTname\"\131\SOH\n\
    \\SUBListNexusEndpointsResponse\DC2&\n\
    \\SInext_page_token\CAN\SOH \SOH(\fR\rnextPageToken\DC2=\n\
    \\tendpoints\CAN\STX \ETX(\v2\US.temporal.api.nexus.v1.EndpointR\tendpointsB\190\SOH\n\
    \\"io.temporal.api.operatorservice.v1B\DC4RequestResponseProtoP\SOHZ5go.temporal.io/api/operatorservice/v1;operatorservice\170\STX!Temporalio.Api.OperatorService.V1\234\STX$Temporalio::Api::OperatorService::V1J\202\&4\n\
    \\a\DC2\ENQ\SYN\NUL\192\SOH\SOH\n\
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
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\"\NUL-\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX#\NUL(\n\
    \&\n\
    \\STX\EOT\NUL\DC2\EOT'\NUL+\SOH2\SUB (-- Search Attribute --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX'\b\"\n\
    \N\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX)\EOTN\SUBA Mapping between search attribute name and its IndexedValueType.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX)\EOT7\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX)8I\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX)LM\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX*\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX*\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX*\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX*\ETB\CAN\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT-\NUL.\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX-\b#\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT0\NUL4\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX0\b%\n\
    \0\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX2\EOT*\SUB# Search attribute names to delete.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\EOT\DC2\ETX2\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX2\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX2\DC4%\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX2()\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX3\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX3\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX3\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX3\ETB\CAN\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT6\NUL7\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX6\b&\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOT9\NUL;\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX9\b#\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX:\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETX:\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX:\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX:\ETB\CAN\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOT=\NULD\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX=\b$\n\
    \f\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX?\EOTN\SUBY Mapping between custom (user-registered) search attribute name to its IndexedValueType.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETX?\EOT7\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX?8I\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX?LM\n\
    \a\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETXA\EOTN\SUBT Mapping between system (predefined) search attribute name to its IndexedValueType.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\ETXA\EOT7\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETXA8I\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETXALM\n\
    \U\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\ETXC\EOT+\SUBH Mapping from the attribute name to the visibility storage native type.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ACK\DC2\ETXC\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\ETXC\CAN&\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\ETXC)*\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOTF\NULM\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXF\b\RS\n\
    \]\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXH\EOT\EM\SUBP Only one of namespace or namespace_id must be specified to identify namespace.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXH\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXH\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXH\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXI\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXI\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXI\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXI\SUB\ESC\n\
    \\194\SOH\n\
    \\EOT\EOT\ACK\STX\STX\DC2\ETXL\EOT8\SUB\180\SOH If provided, the deletion of namespace info will be delayed for the given duration (0 means no delay).\n\
    \ If not provided, the default delay configured in the cluster will be used.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ACK\DC2\ETXL\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\ETXL\GS3\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\ETXL67\n\
    \\n\
    \\n\
    \\STX\EOT\a\DC2\EOTO\NULR\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXO\b\US\n\
    \S\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXQ\EOT!\SUBF Temporary namespace name that is used during reclaim resources step.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETXQ\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXQ\v\FS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXQ\US \n\
    \\n\
    \\n\
    \\STX\EOT\b\DC2\EOTT\NUL\\\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXT\b'\n\
    \o\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETXV\EOT \SUBb Frontend Address is a cross cluster accessible address for gRPC traffic. This field is required.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\ETXV\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETXV\v\ESC\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETXV\RS\US\n\
    \E\n\
    \\EOT\EOT\b\STX\SOH\DC2\ETXX\EOT.\SUB8 Flag to enable / disable the cross cluster connection.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ENQ\DC2\ETXX\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\ETXX\t)\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\ETXX,-\n\
    \\189\SOH\n\
    \\EOT\EOT\b\STX\STX\DC2\ETX[\EOT%\SUB\175\SOH Frontend HTTP Address is a cross cluster accessible address for HTTP traffic. This field is optional. If not provided\n\
    \  on update, the existing HTTP address will be removed.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\ENQ\DC2\ETX[\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\SOH\DC2\ETX[\v \n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\ETX\DC2\ETX[#$\n\
    \\n\
    \\n\
    \\STX\EOT\t\DC2\EOT^\NUL_\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETX^\b(\n\
    \\n\
    \\n\
    \\STX\EOT\n\
    \\DC2\EOTa\NULd\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETXa\b\"\n\
    \1\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETXc\EOT\FS\SUB$ Remote cluster name to be removed.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETXc\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETXc\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETXc\SUB\ESC\n\
    \\n\
    \\n\
    \\STX\EOT\v\DC2\EOTf\NULg\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETXf\b#\n\
    \\n\
    \\n\
    \\STX\EOT\f\DC2\EOTi\NULl\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\f\SOH\DC2\ETXi\b\ESC\n\
    \\v\n\
    \\EOT\EOT\f\STX\NUL\DC2\ETXj\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ENQ\DC2\ETXj\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\ETXj\n\
    \\DC3\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\ETXj\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\f\STX\SOH\DC2\ETXk\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ENQ\DC2\ETXk\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\ETXk\n\
    \\EM\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\ETXk\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\r\DC2\EOTn\NULr\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\r\SOH\DC2\ETXn\b\FS\n\
    \.\n\
    \\EOT\EOT\r\STX\NUL\DC2\ETXp\EOT*\SUB! List of all cluster information\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\EOT\DC2\ETXp\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\ACK\DC2\ETXp\r\FS\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\ETXp\GS%\n\
    \\f\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\ETXp()\n\
    \\v\n\
    \\EOT\EOT\r\STX\SOH\DC2\ETXq\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\r\STX\SOH\ENQ\DC2\ETXq\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\r\STX\SOH\SOH\DC2\ETXq\n\
    \\EM\n\
    \\f\n\
    \\ENQ\EOT\r\STX\SOH\ETX\DC2\ETXq\FS\GS\n\
    \\v\n\
    \\STX\EOT\SO\DC2\ENQt\NUL\131\SOH\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SO\SOH\DC2\ETXt\b\ETB\n\
    \(\n\
    \\EOT\EOT\SO\STX\NUL\DC2\ETXv\EOT\FS\SUB\ESC Name of the cluster name.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\ENQ\DC2\ETXv\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\ETXv\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\ETXv\SUB\ESC\n\
    \!\n\
    \\EOT\EOT\SO\STX\SOH\DC2\ETXx\EOT\SUB\SUB\DC4 Id of the cluster.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\SOH\ENQ\DC2\ETXx\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\SOH\SOH\DC2\ETXx\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\SOH\ETX\DC2\ETXx\CAN\EM\n\
    \\FS\n\
    \\EOT\EOT\SO\STX\STX\DC2\ETXz\EOT\ETB\SUB\SI gRPC address.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\STX\ENQ\DC2\ETXz\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\STX\SOH\DC2\ETXz\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\STX\ETX\DC2\ETXz\NAK\SYN\n\
    \+\n\
    \\EOT\EOT\SO\STX\ETX\DC2\ETX|\EOT\FS\SUB\RS HTTP address, if one exists.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ETX\ENQ\DC2\ETX|\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ETX\SOH\DC2\ETX|\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\ETX\ETX\DC2\ETX|\SUB\ESC\n\
    \G\n\
    \\EOT\EOT\SO\STX\EOT\DC2\ETX~\EOT'\SUB: A unique failover version across all connected clusters.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\EOT\ENQ\DC2\ETX~\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\EOT\SOH\DC2\ETX~\n\
    \\"\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\EOT\ETX\DC2\ETX~%&\n\
    \-\n\
    \\EOT\EOT\SO\STX\ENQ\DC2\EOT\128\SOH\EOT\"\SUB\US History service shard number.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ENQ\ENQ\DC2\EOT\128\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ENQ\SOH\DC2\EOT\128\SOH\n\
    \\GS\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ENQ\ETX\DC2\EOT\128\SOH !\n\
    \=\n\
    \\EOT\EOT\SO\STX\ACK\DC2\EOT\130\SOH\EOT#\SUB/ A flag to indicate if a connection is active.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ACK\ENQ\DC2\EOT\130\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ACK\SOH\DC2\EOT\130\SOH\t\RS\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ACK\ETX\DC2\EOT\130\SOH!\"\n\
    \\f\n\
    \\STX\EOT\SI\DC2\ACK\133\SOH\NUL\136\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\SI\SOH\DC2\EOT\133\SOH\b\US\n\
    \4\n\
    \\EOT\EOT\SI\STX\NUL\DC2\EOT\135\SOH\EOT\DC2\SUB& Server-generated unique endpoint ID.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ENQ\DC2\EOT\135\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\SOH\DC2\EOT\135\SOH\v\r\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ETX\DC2\EOT\135\SOH\DLE\DC1\n\
    \\f\n\
    \\STX\EOT\DLE\DC2\ACK\138\SOH\NUL\140\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DLE\SOH\DC2\EOT\138\SOH\b \n\
    \\f\n\
    \\EOT\EOT\DLE\STX\NUL\DC2\EOT\139\SOH\EOT0\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ACK\DC2\EOT\139\SOH\EOT\"\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\SOH\DC2\EOT\139\SOH#+\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ETX\DC2\EOT\139\SOH./\n\
    \\f\n\
    \\STX\EOT\DC1\DC2\ACK\142\SOH\NUL\145\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DC1\SOH\DC2\EOT\142\SOH\b\"\n\
    \.\n\
    \\EOT\EOT\DC1\STX\NUL\DC2\EOT\144\SOH\EOT0\SUB  Endpoint definition to create.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ACK\DC2\EOT\144\SOH\EOT&\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\SOH\DC2\EOT\144\SOH'+\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ETX\DC2\EOT\144\SOH./\n\
    \\f\n\
    \\STX\EOT\DC2\DC2\ACK\147\SOH\NUL\150\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DC2\SOH\DC2\EOT\147\SOH\b#\n\
    \]\n\
    \\EOT\EOT\DC2\STX\NUL\DC2\EOT\149\SOH\EOT0\SUBO Data post acceptance. Can be used to issue additional updates to this record.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC2\STX\NUL\ACK\DC2\EOT\149\SOH\EOT\"\n\
    \\r\n\
    \\ENQ\EOT\DC2\STX\NUL\SOH\DC2\EOT\149\SOH#+\n\
    \\r\n\
    \\ENQ\EOT\DC2\STX\NUL\ETX\DC2\EOT\149\SOH./\n\
    \\f\n\
    \\STX\EOT\DC3\DC2\ACK\152\SOH\NUL\159\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DC3\SOH\DC2\EOT\152\SOH\b\"\n\
    \4\n\
    \\EOT\EOT\DC3\STX\NUL\DC2\EOT\154\SOH\EOT\DC2\SUB& Server-generated unique endpoint ID.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\NUL\ENQ\DC2\EOT\154\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\NUL\SOH\DC2\EOT\154\SOH\v\r\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\NUL\ETX\DC2\EOT\154\SOH\DLE\DC1\n\
    \K\n\
    \\EOT\EOT\DC3\STX\SOH\DC2\EOT\156\SOH\EOT\SYN\SUB= Data version for this endpoint. Must match current version.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\SOH\ENQ\DC2\EOT\156\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\SOH\SOH\DC2\EOT\156\SOH\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\SOH\ETX\DC2\EOT\156\SOH\DC4\NAK\n\
    \\f\n\
    \\EOT\EOT\DC3\STX\STX\DC2\EOT\158\SOH\EOT0\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\STX\ACK\DC2\EOT\158\SOH\EOT&\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\STX\SOH\DC2\EOT\158\SOH'+\n\
    \\r\n\
    \\ENQ\EOT\DC3\STX\STX\ETX\DC2\EOT\158\SOH./\n\
    \\f\n\
    \\STX\EOT\DC4\DC2\ACK\161\SOH\NUL\164\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DC4\SOH\DC2\EOT\161\SOH\b#\n\
    \]\n\
    \\EOT\EOT\DC4\STX\NUL\DC2\EOT\163\SOH\EOT0\SUBO Data post acceptance. Can be used to issue additional updates to this record.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC4\STX\NUL\ACK\DC2\EOT\163\SOH\EOT\"\n\
    \\r\n\
    \\ENQ\EOT\DC4\STX\NUL\SOH\DC2\EOT\163\SOH#+\n\
    \\r\n\
    \\ENQ\EOT\DC4\STX\NUL\ETX\DC2\EOT\163\SOH./\n\
    \\f\n\
    \\STX\EOT\NAK\DC2\ACK\166\SOH\NUL\171\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\NAK\SOH\DC2\EOT\166\SOH\b\"\n\
    \4\n\
    \\EOT\EOT\NAK\STX\NUL\DC2\EOT\168\SOH\EOT\DC2\SUB& Server-generated unique endpoint ID.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\NAK\STX\NUL\ENQ\DC2\EOT\168\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\NAK\STX\NUL\SOH\DC2\EOT\168\SOH\v\r\n\
    \\r\n\
    \\ENQ\EOT\NAK\STX\NUL\ETX\DC2\EOT\168\SOH\DLE\DC1\n\
    \K\n\
    \\EOT\EOT\NAK\STX\SOH\DC2\EOT\170\SOH\EOT\SYN\SUB= Data version for this endpoint. Must match current version.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\NAK\STX\SOH\ENQ\DC2\EOT\170\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\NAK\STX\SOH\SOH\DC2\EOT\170\SOH\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\NAK\STX\SOH\ETX\DC2\EOT\170\SOH\DC4\NAK\n\
    \\f\n\
    \\STX\EOT\SYN\DC2\ACK\173\SOH\NUL\174\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\SYN\SOH\DC2\EOT\173\SOH\b#\n\
    \\f\n\
    \\STX\EOT\ETB\DC2\ACK\176\SOH\NUL\186\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\ETB\SOH\DC2\EOT\176\SOH\b!\n\
    \\f\n\
    \\EOT\EOT\ETB\STX\NUL\DC2\EOT\177\SOH\EOT\CAN\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\NUL\ENQ\DC2\EOT\177\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\NUL\SOH\DC2\EOT\177\SOH\n\
    \\DC3\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\NUL\ETX\DC2\EOT\177\SOH\SYN\ETB\n\
    \\159\STX\n\
    \\EOT\EOT\ETB\STX\SOH\DC2\EOT\181\SOH\EOT\RS\SUB\144\STX To get the next page, pass in `ListNexusEndpointsResponse.next_page_token` from the previous page's\n\
    \ response, the token will be empty if there's no other page.\n\
    \ Note: the last page may be empty if the total number of endpoints registered is a multiple of the page size.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\SOH\ENQ\DC2\EOT\181\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\SOH\SOH\DC2\EOT\181\SOH\n\
    \\EM\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\SOH\ETX\DC2\EOT\181\SOH\FS\GS\n\
    \\244\SOH\n\
    \\EOT\EOT\ETB\STX\STX\DC2\EOT\185\SOH\EOT\DC4\SUB\229\SOH Name of the incoming endpoint to filter on - optional. Specifying this will result in zero or one results.\n\
    \ (-- api-linter: core::203::field-behavior-required=disabled\n\
    \     aip.dev/not-precedent: Not following linter rules. --)\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\STX\ENQ\DC2\EOT\185\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\STX\SOH\DC2\EOT\185\SOH\v\SI\n\
    \\r\n\
    \\ENQ\EOT\ETB\STX\STX\ETX\DC2\EOT\185\SOH\DC2\DC3\n\
    \\f\n\
    \\STX\EOT\CAN\DC2\ACK\188\SOH\NUL\192\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\CAN\SOH\DC2\EOT\188\SOH\b\"\n\
    \0\n\
    \\EOT\EOT\CAN\STX\NUL\DC2\EOT\190\SOH\EOT\RS\SUB\" Token for getting the next page.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\CAN\STX\NUL\ENQ\DC2\EOT\190\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\CAN\STX\NUL\SOH\DC2\EOT\190\SOH\n\
    \\EM\n\
    \\r\n\
    \\ENQ\EOT\CAN\STX\NUL\ETX\DC2\EOT\190\SOH\FS\GS\n\
    \\f\n\
    \\EOT\EOT\CAN\STX\SOH\DC2\EOT\191\SOH\EOT:\n\
    \\r\n\
    \\ENQ\EOT\CAN\STX\SOH\EOT\DC2\EOT\191\SOH\EOT\f\n\
    \\r\n\
    \\ENQ\EOT\CAN\STX\SOH\ACK\DC2\EOT\191\SOH\r+\n\
    \\r\n\
    \\ENQ\EOT\CAN\STX\SOH\SOH\DC2\EOT\191\SOH,5\n\
    \\r\n\
    \\ENQ\EOT\CAN\STX\SOH\ETX\DC2\EOT\191\SOH89b\ACKproto3"

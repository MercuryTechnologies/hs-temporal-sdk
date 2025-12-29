{- This file was auto-generated from temporal/api/replication/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Replication.V1.Message (
        ClusterReplicationConfig(), FailoverStatus(),
        NamespaceReplicationConfig()
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
import qualified Proto.Temporal.Api.Enums.V1.Namespace
{- | Fields :
     
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.clusterName' @:: Lens' ClusterReplicationConfig Data.Text.Text@ -}
data ClusterReplicationConfig
  = ClusterReplicationConfig'_constructor {_ClusterReplicationConfig'clusterName :: !Data.Text.Text,
                                           _ClusterReplicationConfig'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ClusterReplicationConfig where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ClusterReplicationConfig "clusterName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClusterReplicationConfig'clusterName
           (\ x__ y__ -> x__ {_ClusterReplicationConfig'clusterName = y__}))
        Prelude.id
instance Data.ProtoLens.Message ClusterReplicationConfig where
  messageName _
    = Data.Text.pack
        "temporal.api.replication.v1.ClusterReplicationConfig"
  packedMessageDescriptor _
    = "\n\
      \\CANClusterReplicationConfig\DC2!\n\
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
              Data.ProtoLens.FieldDescriptor ClusterReplicationConfig
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, clusterName__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ClusterReplicationConfig'_unknownFields
        (\ x__ y__ -> x__ {_ClusterReplicationConfig'_unknownFields = y__})
  defMessage
    = ClusterReplicationConfig'_constructor
        {_ClusterReplicationConfig'clusterName = Data.ProtoLens.fieldDefault,
         _ClusterReplicationConfig'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ClusterReplicationConfig
          -> Data.ProtoLens.Encoding.Bytes.Parser ClusterReplicationConfig
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
          (do loop Data.ProtoLens.defMessage) "ClusterReplicationConfig"
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
instance Control.DeepSeq.NFData ClusterReplicationConfig where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ClusterReplicationConfig'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ClusterReplicationConfig'clusterName x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.failoverTime' @:: Lens' FailoverStatus Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.maybe'failoverTime' @:: Lens' FailoverStatus (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.failoverVersion' @:: Lens' FailoverStatus Data.Int.Int64@ -}
data FailoverStatus
  = FailoverStatus'_constructor {_FailoverStatus'failoverTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                 _FailoverStatus'failoverVersion :: !Data.Int.Int64,
                                 _FailoverStatus'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show FailoverStatus where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField FailoverStatus "failoverTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _FailoverStatus'failoverTime
           (\ x__ y__ -> x__ {_FailoverStatus'failoverTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField FailoverStatus "maybe'failoverTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _FailoverStatus'failoverTime
           (\ x__ y__ -> x__ {_FailoverStatus'failoverTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField FailoverStatus "failoverVersion" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _FailoverStatus'failoverVersion
           (\ x__ y__ -> x__ {_FailoverStatus'failoverVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Message FailoverStatus where
  messageName _
    = Data.Text.pack "temporal.api.replication.v1.FailoverStatus"
  packedMessageDescriptor _
    = "\n\
      \\SOFailoverStatus\DC2?\n\
      \\rfailover_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ffailoverTime\DC2)\n\
      \\DLEfailover_version\CAN\STX \SOH(\ETXR\SIfailoverVersion"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        failoverTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failover_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failoverTime")) ::
              Data.ProtoLens.FieldDescriptor FailoverStatus
        failoverVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failover_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"failoverVersion")) ::
              Data.ProtoLens.FieldDescriptor FailoverStatus
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, failoverTime__field_descriptor),
           (Data.ProtoLens.Tag 2, failoverVersion__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _FailoverStatus'_unknownFields
        (\ x__ y__ -> x__ {_FailoverStatus'_unknownFields = y__})
  defMessage
    = FailoverStatus'_constructor
        {_FailoverStatus'failoverTime = Prelude.Nothing,
         _FailoverStatus'failoverVersion = Data.ProtoLens.fieldDefault,
         _FailoverStatus'_unknownFields = []}
  parseMessage
    = let
        loop ::
          FailoverStatus
          -> Data.ProtoLens.Encoding.Bytes.Parser FailoverStatus
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
                                       "failover_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"failoverTime") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "failover_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"failoverVersion") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "FailoverStatus"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'failoverTime") _x
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
                         (Data.ProtoLens.Field.field @"failoverVersion") _x
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
instance Control.DeepSeq.NFData FailoverStatus where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_FailoverStatus'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_FailoverStatus'failoverTime x__)
                (Control.DeepSeq.deepseq (_FailoverStatus'failoverVersion x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.activeClusterName' @:: Lens' NamespaceReplicationConfig Data.Text.Text@
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.clusters' @:: Lens' NamespaceReplicationConfig [ClusterReplicationConfig]@
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.vec'clusters' @:: Lens' NamespaceReplicationConfig (Data.Vector.Vector ClusterReplicationConfig)@
         * 'Proto.Temporal.Api.Replication.V1.Message_Fields.state' @:: Lens' NamespaceReplicationConfig Proto.Temporal.Api.Enums.V1.Namespace.ReplicationState@ -}
data NamespaceReplicationConfig
  = NamespaceReplicationConfig'_constructor {_NamespaceReplicationConfig'activeClusterName :: !Data.Text.Text,
                                             _NamespaceReplicationConfig'clusters :: !(Data.Vector.Vector ClusterReplicationConfig),
                                             _NamespaceReplicationConfig'state :: !Proto.Temporal.Api.Enums.V1.Namespace.ReplicationState,
                                             _NamespaceReplicationConfig'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceReplicationConfig where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceReplicationConfig "activeClusterName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceReplicationConfig'activeClusterName
           (\ x__ y__
              -> x__ {_NamespaceReplicationConfig'activeClusterName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceReplicationConfig "clusters" [ClusterReplicationConfig] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceReplicationConfig'clusters
           (\ x__ y__ -> x__ {_NamespaceReplicationConfig'clusters = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField NamespaceReplicationConfig "vec'clusters" (Data.Vector.Vector ClusterReplicationConfig) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceReplicationConfig'clusters
           (\ x__ y__ -> x__ {_NamespaceReplicationConfig'clusters = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceReplicationConfig "state" Proto.Temporal.Api.Enums.V1.Namespace.ReplicationState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceReplicationConfig'state
           (\ x__ y__ -> x__ {_NamespaceReplicationConfig'state = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceReplicationConfig where
  messageName _
    = Data.Text.pack
        "temporal.api.replication.v1.NamespaceReplicationConfig"
  packedMessageDescriptor _
    = "\n\
      \\SUBNamespaceReplicationConfig\DC2.\n\
      \\DC3active_cluster_name\CAN\SOH \SOH(\tR\DC1activeClusterName\DC2Q\n\
      \\bclusters\CAN\STX \ETX(\v25.temporal.api.replication.v1.ClusterReplicationConfigR\bclusters\DC2=\n\
      \\ENQstate\CAN\ETX \SOH(\SO2'.temporal.api.enums.v1.ReplicationStateR\ENQstate"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        activeClusterName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "active_cluster_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"activeClusterName")) ::
              Data.ProtoLens.FieldDescriptor NamespaceReplicationConfig
        clusters__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "clusters"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ClusterReplicationConfig)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"clusters")) ::
              Data.ProtoLens.FieldDescriptor NamespaceReplicationConfig
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Namespace.ReplicationState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor NamespaceReplicationConfig
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, activeClusterName__field_descriptor),
           (Data.ProtoLens.Tag 2, clusters__field_descriptor),
           (Data.ProtoLens.Tag 3, state__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceReplicationConfig'_unknownFields
        (\ x__ y__
           -> x__ {_NamespaceReplicationConfig'_unknownFields = y__})
  defMessage
    = NamespaceReplicationConfig'_constructor
        {_NamespaceReplicationConfig'activeClusterName = Data.ProtoLens.fieldDefault,
         _NamespaceReplicationConfig'clusters = Data.Vector.Generic.empty,
         _NamespaceReplicationConfig'state = Data.ProtoLens.fieldDefault,
         _NamespaceReplicationConfig'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceReplicationConfig
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld ClusterReplicationConfig
             -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceReplicationConfig
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
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "active_cluster_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activeClusterName") y x)
                                  mutable'clusters
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "clusters"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'clusters y)
                                loop x v
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
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
          "NamespaceReplicationConfig"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"activeClusterName") _x
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
                      (Data.ProtoLens.Field.field @"vec'clusters") _x))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"state") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData NamespaceReplicationConfig where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceReplicationConfig'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespaceReplicationConfig'activeClusterName x__)
                (Control.DeepSeq.deepseq
                   (_NamespaceReplicationConfig'clusters x__)
                   (Control.DeepSeq.deepseq
                      (_NamespaceReplicationConfig'state x__) ())))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \)temporal/api/replication/v1/message.proto\DC2\ESCtemporal.api.replication.v1\SUB\USgoogle/protobuf/timestamp.proto\SUB%temporal/api/enums/v1/namespace.proto\"=\n\
    \\CANClusterReplicationConfig\DC2!\n\
    \\fcluster_name\CAN\SOH \SOH(\tR\vclusterName\"\222\SOH\n\
    \\SUBNamespaceReplicationConfig\DC2.\n\
    \\DC3active_cluster_name\CAN\SOH \SOH(\tR\DC1activeClusterName\DC2Q\n\
    \\bclusters\CAN\STX \ETX(\v25.temporal.api.replication.v1.ClusterReplicationConfigR\bclusters\DC2=\n\
    \\ENQstate\CAN\ETX \SOH(\SO2'.temporal.api.enums.v1.ReplicationStateR\ENQstate\"|\n\
    \\SOFailoverStatus\DC2?\n\
    \\rfailover_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ffailoverTime\DC2)\n\
    \\DLEfailover_version\CAN\STX \SOH(\ETXR\SIfailoverVersionB\162\SOH\n\
    \\RSio.temporal.api.replication.v1B\fMessageProtoP\SOHZ-go.temporal.io/api/replication/v1;replication\170\STX\GSTemporalio.Api.Replication.V1\234\STX Temporalio::Api::Replication::V1J\214\ENQ\n\
    \\ACK\DC2\EOT\NUL\NUL\RS\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL$\n\
    \\b\n\
    \\SOH\b\DC2\ETX\EOT\NULD\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\EOT\NULD\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ENQ\NUL7\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ENQ\NUL7\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ACK\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\ACK\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\a\NUL-\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\a\NUL-\n\
    \\b\n\
    \\SOH\b\DC2\ETX\b\NUL9\n\
    \\t\n\
    \\STX\b-\DC2\ETX\b\NUL9\n\
    \\b\n\
    \\SOH\b\DC2\ETX\t\NUL:\n\
    \\t\n\
    \\STX\b%\DC2\ETX\t\NUL:\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\v\NUL)\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\r\NUL/\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT\SI\NUL\DC1\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\SI\b \n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\DLE\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\DLE\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\DLE\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\DLE\SUB\ESC\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT\DC3\NUL\ETB\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\DC3\b\"\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\DC4\EOT#\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\DC4\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\DC4\v\RS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\DC4!\"\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\NAK\EOT3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\EOT\DC2\ETX\NAK\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX\NAK\r%\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\NAK&.\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\NAK12\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX\SYN\EOT5\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ACK\DC2\ETX\SYN\EOT*\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX\SYN+0\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX\SYN34\n\
    \G\n\
    \\STX\EOT\STX\DC2\EOT\SUB\NUL\RS\SOH\SUB; Represents a historical replication status of a Namespace\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX\SUB\b\SYN\n\
    \T\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX\FS\EOT0\SUBG Timestamp when the Cluster switched to the following failover_version\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX\FS\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX\FS\RS+\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX\FS./\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX\GS\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX\GS\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX\GS\n\
    \\SUB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX\GS\GS\RSb\ACKproto3"
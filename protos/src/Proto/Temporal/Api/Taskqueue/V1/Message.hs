{- This file was auto-generated from temporal/api/taskqueue/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Taskqueue.V1.Message (
        BuildIdReachability(), CompatibleVersionSet(), PollerInfo(),
        StickyExecutionAttributes(), TaskIdBlock(), TaskQueue(),
        TaskQueueMetadata(), TaskQueuePartitionMetadata(),
        TaskQueueReachability(), TaskQueueStatus()
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Google.Protobuf.Wrappers
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.TaskQueue
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.buildId' @:: Lens' BuildIdReachability Data.Text.Text@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.taskQueueReachability' @:: Lens' BuildIdReachability [TaskQueueReachability]@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.vec'taskQueueReachability' @:: Lens' BuildIdReachability (Data.Vector.Vector TaskQueueReachability)@ -}
data BuildIdReachability
  = BuildIdReachability'_constructor {_BuildIdReachability'buildId :: !Data.Text.Text,
                                      _BuildIdReachability'taskQueueReachability :: !(Data.Vector.Vector TaskQueueReachability),
                                      _BuildIdReachability'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BuildIdReachability where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BuildIdReachability "buildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BuildIdReachability'buildId
           (\ x__ y__ -> x__ {_BuildIdReachability'buildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BuildIdReachability "taskQueueReachability" [TaskQueueReachability] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BuildIdReachability'taskQueueReachability
           (\ x__ y__
              -> x__ {_BuildIdReachability'taskQueueReachability = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField BuildIdReachability "vec'taskQueueReachability" (Data.Vector.Vector TaskQueueReachability) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BuildIdReachability'taskQueueReachability
           (\ x__ y__
              -> x__ {_BuildIdReachability'taskQueueReachability = y__}))
        Prelude.id
instance Data.ProtoLens.Message BuildIdReachability where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.BuildIdReachability"
  packedMessageDescriptor _
    = "\n\
      \\DC3BuildIdReachability\DC2\EM\n\
      \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2h\n\
      \\ETBtask_queue_reachability\CAN\STX \ETX(\v20.temporal.api.taskqueue.v1.TaskQueueReachabilityR\NAKtaskQueueReachability"
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
              Data.ProtoLens.FieldDescriptor BuildIdReachability
        taskQueueReachability__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue_reachability"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor TaskQueueReachability)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"taskQueueReachability")) ::
              Data.ProtoLens.FieldDescriptor BuildIdReachability
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, buildId__field_descriptor),
           (Data.ProtoLens.Tag 2, taskQueueReachability__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BuildIdReachability'_unknownFields
        (\ x__ y__ -> x__ {_BuildIdReachability'_unknownFields = y__})
  defMessage
    = BuildIdReachability'_constructor
        {_BuildIdReachability'buildId = Data.ProtoLens.fieldDefault,
         _BuildIdReachability'taskQueueReachability = Data.Vector.Generic.empty,
         _BuildIdReachability'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BuildIdReachability
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld TaskQueueReachability
             -> Data.ProtoLens.Encoding.Bytes.Parser BuildIdReachability
        loop x mutable'taskQueueReachability
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'taskQueueReachability <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                        (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                           mutable'taskQueueReachability)
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
                              (Data.ProtoLens.Field.field @"vec'taskQueueReachability")
                              frozen'taskQueueReachability x))
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
                                       "build_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"buildId") y x)
                                  mutable'taskQueueReachability
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "task_queue_reachability"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'taskQueueReachability y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'taskQueueReachability
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'taskQueueReachability <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                 Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'taskQueueReachability)
          "BuildIdReachability"
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
                      (Data.ProtoLens.Field.field @"vec'taskQueueReachability") _x))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData BuildIdReachability where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BuildIdReachability'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BuildIdReachability'buildId x__)
                (Control.DeepSeq.deepseq
                   (_BuildIdReachability'taskQueueReachability x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.buildIds' @:: Lens' CompatibleVersionSet [Data.Text.Text]@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.vec'buildIds' @:: Lens' CompatibleVersionSet (Data.Vector.Vector Data.Text.Text)@ -}
data CompatibleVersionSet
  = CompatibleVersionSet'_constructor {_CompatibleVersionSet'buildIds :: !(Data.Vector.Vector Data.Text.Text),
                                       _CompatibleVersionSet'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CompatibleVersionSet where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CompatibleVersionSet "buildIds" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompatibleVersionSet'buildIds
           (\ x__ y__ -> x__ {_CompatibleVersionSet'buildIds = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField CompatibleVersionSet "vec'buildIds" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompatibleVersionSet'buildIds
           (\ x__ y__ -> x__ {_CompatibleVersionSet'buildIds = y__}))
        Prelude.id
instance Data.ProtoLens.Message CompatibleVersionSet where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.CompatibleVersionSet"
  packedMessageDescriptor _
    = "\n\
      \\DC4CompatibleVersionSet\DC2\ESC\n\
      \\tbuild_ids\CAN\SOH \ETX(\tR\bbuildIds"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        buildIds__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "build_ids"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"buildIds")) ::
              Data.ProtoLens.FieldDescriptor CompatibleVersionSet
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, buildIds__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CompatibleVersionSet'_unknownFields
        (\ x__ y__ -> x__ {_CompatibleVersionSet'_unknownFields = y__})
  defMessage
    = CompatibleVersionSet'_constructor
        {_CompatibleVersionSet'buildIds = Data.Vector.Generic.empty,
         _CompatibleVersionSet'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CompatibleVersionSet
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
             -> Data.ProtoLens.Encoding.Bytes.Parser CompatibleVersionSet
        loop x mutable'buildIds
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'buildIds <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                              mutable'buildIds)
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
                              (Data.ProtoLens.Field.field @"vec'buildIds") frozen'buildIds x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                        Data.ProtoLens.Encoding.Bytes.getBytes
                                                          (Prelude.fromIntegral len)
                                            Data.ProtoLens.Encoding.Bytes.runEither
                                              (case Data.Text.Encoding.decodeUtf8' value of
                                                 (Prelude.Left err)
                                                   -> Prelude.Left (Prelude.show err)
                                                 (Prelude.Right r) -> Prelude.Right r))
                                        "build_ids"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'buildIds y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'buildIds
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'buildIds <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                    Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'buildIds)
          "CompatibleVersionSet"
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
                   (Data.ProtoLens.Field.field @"vec'buildIds") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData CompatibleVersionSet where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CompatibleVersionSet'_unknownFields x__)
             (Control.DeepSeq.deepseq (_CompatibleVersionSet'buildIds x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.lastAccessTime' @:: Lens' PollerInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'lastAccessTime' @:: Lens' PollerInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.identity' @:: Lens' PollerInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.ratePerSecond' @:: Lens' PollerInfo Prelude.Double@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.workerVersionCapabilities' @:: Lens' PollerInfo Proto.Temporal.Api.Common.V1.Message.WorkerVersionCapabilities@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'workerVersionCapabilities' @:: Lens' PollerInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionCapabilities)@ -}
data PollerInfo
  = PollerInfo'_constructor {_PollerInfo'lastAccessTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                             _PollerInfo'identity :: !Data.Text.Text,
                             _PollerInfo'ratePerSecond :: !Prelude.Double,
                             _PollerInfo'workerVersionCapabilities :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionCapabilities),
                             _PollerInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PollerInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField PollerInfo "lastAccessTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PollerInfo'lastAccessTime
           (\ x__ y__ -> x__ {_PollerInfo'lastAccessTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PollerInfo "maybe'lastAccessTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PollerInfo'lastAccessTime
           (\ x__ y__ -> x__ {_PollerInfo'lastAccessTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PollerInfo "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PollerInfo'identity
           (\ x__ y__ -> x__ {_PollerInfo'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PollerInfo "ratePerSecond" Prelude.Double where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PollerInfo'ratePerSecond
           (\ x__ y__ -> x__ {_PollerInfo'ratePerSecond = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PollerInfo "workerVersionCapabilities" Proto.Temporal.Api.Common.V1.Message.WorkerVersionCapabilities where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PollerInfo'workerVersionCapabilities
           (\ x__ y__ -> x__ {_PollerInfo'workerVersionCapabilities = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PollerInfo "maybe'workerVersionCapabilities" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionCapabilities) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PollerInfo'workerVersionCapabilities
           (\ x__ y__ -> x__ {_PollerInfo'workerVersionCapabilities = y__}))
        Prelude.id
instance Data.ProtoLens.Message PollerInfo where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.PollerInfo"
  packedMessageDescriptor _
    = "\n\
      \\n\
      \PollerInfo\DC2J\n\
      \\DLElast_access_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\SOlastAccessTimeB\EOT\144\223\US\SOH\DC2\SUB\n\
      \\bidentity\CAN\STX \SOH(\tR\bidentity\DC2&\n\
      \\SIrate_per_second\CAN\ETX \SOH(\SOHR\rratePerSecond\DC2q\n\
      \\ESCworker_version_capabilities\CAN\EOT \SOH(\v21.temporal.api.common.v1.WorkerVersionCapabilitiesR\EMworkerVersionCapabilities"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        lastAccessTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_access_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAccessTime")) ::
              Data.ProtoLens.FieldDescriptor PollerInfo
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor PollerInfo
        ratePerSecond__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rate_per_second"
              (Data.ProtoLens.ScalarField Data.ProtoLens.DoubleField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"ratePerSecond")) ::
              Data.ProtoLens.FieldDescriptor PollerInfo
        workerVersionCapabilities__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "worker_version_capabilities"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkerVersionCapabilities)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workerVersionCapabilities")) ::
              Data.ProtoLens.FieldDescriptor PollerInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, lastAccessTime__field_descriptor),
           (Data.ProtoLens.Tag 2, identity__field_descriptor),
           (Data.ProtoLens.Tag 3, ratePerSecond__field_descriptor),
           (Data.ProtoLens.Tag 4, 
            workerVersionCapabilities__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PollerInfo'_unknownFields
        (\ x__ y__ -> x__ {_PollerInfo'_unknownFields = y__})
  defMessage
    = PollerInfo'_constructor
        {_PollerInfo'lastAccessTime = Prelude.Nothing,
         _PollerInfo'identity = Data.ProtoLens.fieldDefault,
         _PollerInfo'ratePerSecond = Data.ProtoLens.fieldDefault,
         _PollerInfo'workerVersionCapabilities = Prelude.Nothing,
         _PollerInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PollerInfo -> Data.ProtoLens.Encoding.Bytes.Parser PollerInfo
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
                                       "last_access_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAccessTime") y x)
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
                        25
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToDouble
                                          Data.ProtoLens.Encoding.Bytes.getFixed64)
                                       "rate_per_second"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"ratePerSecond") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "worker_version_capabilities"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workerVersionCapabilities") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "PollerInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'lastAccessTime") _x
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
                ((Data.Monoid.<>)
                   (let
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"ratePerSecond") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 25)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putFixed64
                               Data.ProtoLens.Encoding.Bytes.doubleToWord _v))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'workerVersionCapabilities") _x
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
instance Control.DeepSeq.NFData PollerInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PollerInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_PollerInfo'lastAccessTime x__)
                (Control.DeepSeq.deepseq
                   (_PollerInfo'identity x__)
                   (Control.DeepSeq.deepseq
                      (_PollerInfo'ratePerSecond x__)
                      (Control.DeepSeq.deepseq
                         (_PollerInfo'workerVersionCapabilities x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.workerTaskQueue' @:: Lens' StickyExecutionAttributes TaskQueue@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'workerTaskQueue' @:: Lens' StickyExecutionAttributes (Prelude.Maybe TaskQueue)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.scheduleToStartTimeout' @:: Lens' StickyExecutionAttributes Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'scheduleToStartTimeout' @:: Lens' StickyExecutionAttributes (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@ -}
data StickyExecutionAttributes
  = StickyExecutionAttributes'_constructor {_StickyExecutionAttributes'workerTaskQueue :: !(Prelude.Maybe TaskQueue),
                                            _StickyExecutionAttributes'scheduleToStartTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                            _StickyExecutionAttributes'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StickyExecutionAttributes where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StickyExecutionAttributes "workerTaskQueue" TaskQueue where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StickyExecutionAttributes'workerTaskQueue
           (\ x__ y__
              -> x__ {_StickyExecutionAttributes'workerTaskQueue = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StickyExecutionAttributes "maybe'workerTaskQueue" (Prelude.Maybe TaskQueue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StickyExecutionAttributes'workerTaskQueue
           (\ x__ y__
              -> x__ {_StickyExecutionAttributes'workerTaskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StickyExecutionAttributes "scheduleToStartTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StickyExecutionAttributes'scheduleToStartTimeout
           (\ x__ y__
              -> x__ {_StickyExecutionAttributes'scheduleToStartTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StickyExecutionAttributes "maybe'scheduleToStartTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StickyExecutionAttributes'scheduleToStartTimeout
           (\ x__ y__
              -> x__ {_StickyExecutionAttributes'scheduleToStartTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Message StickyExecutionAttributes where
  messageName _
    = Data.Text.pack
        "temporal.api.taskqueue.v1.StickyExecutionAttributes"
  packedMessageDescriptor _
    = "\n\
      \\EMStickyExecutionAttributes\DC2P\n\
      \\DC1worker_task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\SIworkerTaskQueue\DC2Z\n\
      \\EMschedule_to_start_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToStartTimeoutB\EOT\152\223\US\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workerTaskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "worker_task_queue"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor TaskQueue)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workerTaskQueue")) ::
              Data.ProtoLens.FieldDescriptor StickyExecutionAttributes
        scheduleToStartTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schedule_to_start_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduleToStartTimeout")) ::
              Data.ProtoLens.FieldDescriptor StickyExecutionAttributes
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workerTaskQueue__field_descriptor),
           (Data.ProtoLens.Tag 2, scheduleToStartTimeout__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StickyExecutionAttributes'_unknownFields
        (\ x__ y__
           -> x__ {_StickyExecutionAttributes'_unknownFields = y__})
  defMessage
    = StickyExecutionAttributes'_constructor
        {_StickyExecutionAttributes'workerTaskQueue = Prelude.Nothing,
         _StickyExecutionAttributes'scheduleToStartTimeout = Prelude.Nothing,
         _StickyExecutionAttributes'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StickyExecutionAttributes
          -> Data.ProtoLens.Encoding.Bytes.Parser StickyExecutionAttributes
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
                                       "worker_task_queue"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workerTaskQueue") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "schedule_to_start_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduleToStartTimeout") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "StickyExecutionAttributes"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'workerTaskQueue") _x
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
                       (Data.ProtoLens.Field.field @"maybe'scheduleToStartTimeout") _x
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
instance Control.DeepSeq.NFData StickyExecutionAttributes where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StickyExecutionAttributes'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StickyExecutionAttributes'workerTaskQueue x__)
                (Control.DeepSeq.deepseq
                   (_StickyExecutionAttributes'scheduleToStartTimeout x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.startId' @:: Lens' TaskIdBlock Data.Int.Int64@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.endId' @:: Lens' TaskIdBlock Data.Int.Int64@ -}
data TaskIdBlock
  = TaskIdBlock'_constructor {_TaskIdBlock'startId :: !Data.Int.Int64,
                              _TaskIdBlock'endId :: !Data.Int.Int64,
                              _TaskIdBlock'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskIdBlock where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskIdBlock "startId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskIdBlock'startId
           (\ x__ y__ -> x__ {_TaskIdBlock'startId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskIdBlock "endId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskIdBlock'endId (\ x__ y__ -> x__ {_TaskIdBlock'endId = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskIdBlock where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.TaskIdBlock"
  packedMessageDescriptor _
    = "\n\
      \\vTaskIdBlock\DC2\EM\n\
      \\bstart_id\CAN\SOH \SOH(\ETXR\astartId\DC2\NAK\n\
      \\ACKend_id\CAN\STX \SOH(\ETXR\ENQendId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        startId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"startId")) ::
              Data.ProtoLens.FieldDescriptor TaskIdBlock
        endId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "end_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"endId")) ::
              Data.ProtoLens.FieldDescriptor TaskIdBlock
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, startId__field_descriptor),
           (Data.ProtoLens.Tag 2, endId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskIdBlock'_unknownFields
        (\ x__ y__ -> x__ {_TaskIdBlock'_unknownFields = y__})
  defMessage
    = TaskIdBlock'_constructor
        {_TaskIdBlock'startId = Data.ProtoLens.fieldDefault,
         _TaskIdBlock'endId = Data.ProtoLens.fieldDefault,
         _TaskIdBlock'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskIdBlock -> Data.ProtoLens.Encoding.Bytes.Parser TaskIdBlock
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
                                       "start_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"startId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "end_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"endId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "TaskIdBlock"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"startId") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"endId") _x
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
instance Control.DeepSeq.NFData TaskIdBlock where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskIdBlock'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskIdBlock'startId x__)
                (Control.DeepSeq.deepseq (_TaskIdBlock'endId x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.name' @:: Lens' TaskQueue Data.Text.Text@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.kind' @:: Lens' TaskQueue Proto.Temporal.Api.Enums.V1.TaskQueue.TaskQueueKind@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.normalName' @:: Lens' TaskQueue Data.Text.Text@ -}
data TaskQueue
  = TaskQueue'_constructor {_TaskQueue'name :: !Data.Text.Text,
                            _TaskQueue'kind :: !Proto.Temporal.Api.Enums.V1.TaskQueue.TaskQueueKind,
                            _TaskQueue'normalName :: !Data.Text.Text,
                            _TaskQueue'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueue where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueue "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueue'name (\ x__ y__ -> x__ {_TaskQueue'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueue "kind" Proto.Temporal.Api.Enums.V1.TaskQueue.TaskQueueKind where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueue'kind (\ x__ y__ -> x__ {_TaskQueue'kind = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueue "normalName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueue'normalName
           (\ x__ y__ -> x__ {_TaskQueue'normalName = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueue where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.TaskQueue"
  packedMessageDescriptor _
    = "\n\
      \\tTaskQueue\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC28\n\
      \\EOTkind\CAN\STX \SOH(\SO2$.temporal.api.enums.v1.TaskQueueKindR\EOTkind\DC2\US\n\
      \\vnormal_name\CAN\ETX \SOH(\tR\n\
      \normalName"
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
              Data.ProtoLens.FieldDescriptor TaskQueue
        kind__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "kind"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.TaskQueue.TaskQueueKind)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"kind")) ::
              Data.ProtoLens.FieldDescriptor TaskQueue
        normalName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "normal_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"normalName")) ::
              Data.ProtoLens.FieldDescriptor TaskQueue
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, kind__field_descriptor),
           (Data.ProtoLens.Tag 3, normalName__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueue'_unknownFields
        (\ x__ y__ -> x__ {_TaskQueue'_unknownFields = y__})
  defMessage
    = TaskQueue'_constructor
        {_TaskQueue'name = Data.ProtoLens.fieldDefault,
         _TaskQueue'kind = Data.ProtoLens.fieldDefault,
         _TaskQueue'normalName = Data.ProtoLens.fieldDefault,
         _TaskQueue'_unknownFields = []}
  parseMessage
    = let
        loop :: TaskQueue -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueue
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
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "kind"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"kind") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "normal_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"normalName") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "TaskQueue"
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
                (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"kind") _x
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
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"normalName") _x
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
instance Control.DeepSeq.NFData TaskQueue where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueue'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueue'name x__)
                (Control.DeepSeq.deepseq
                   (_TaskQueue'kind x__)
                   (Control.DeepSeq.deepseq (_TaskQueue'normalName x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maxTasksPerSecond' @:: Lens' TaskQueueMetadata Proto.Google.Protobuf.Wrappers.DoubleValue@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'maxTasksPerSecond' @:: Lens' TaskQueueMetadata (Prelude.Maybe Proto.Google.Protobuf.Wrappers.DoubleValue)@ -}
data TaskQueueMetadata
  = TaskQueueMetadata'_constructor {_TaskQueueMetadata'maxTasksPerSecond :: !(Prelude.Maybe Proto.Google.Protobuf.Wrappers.DoubleValue),
                                    _TaskQueueMetadata'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueueMetadata where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueueMetadata "maxTasksPerSecond" Proto.Google.Protobuf.Wrappers.DoubleValue where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueMetadata'maxTasksPerSecond
           (\ x__ y__ -> x__ {_TaskQueueMetadata'maxTasksPerSecond = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField TaskQueueMetadata "maybe'maxTasksPerSecond" (Prelude.Maybe Proto.Google.Protobuf.Wrappers.DoubleValue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueMetadata'maxTasksPerSecond
           (\ x__ y__ -> x__ {_TaskQueueMetadata'maxTasksPerSecond = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueueMetadata where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.TaskQueueMetadata"
  packedMessageDescriptor _
    = "\n\
      \\DC1TaskQueueMetadata\DC2M\n\
      \\DC4max_tasks_per_second\CAN\SOH \SOH(\v2\FS.google.protobuf.DoubleValueR\DC1maxTasksPerSecond"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        maxTasksPerSecond__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "max_tasks_per_second"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Wrappers.DoubleValue)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'maxTasksPerSecond")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueMetadata
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, maxTasksPerSecond__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueueMetadata'_unknownFields
        (\ x__ y__ -> x__ {_TaskQueueMetadata'_unknownFields = y__})
  defMessage
    = TaskQueueMetadata'_constructor
        {_TaskQueueMetadata'maxTasksPerSecond = Prelude.Nothing,
         _TaskQueueMetadata'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueueMetadata
          -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueueMetadata
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
                                       "max_tasks_per_second"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"maxTasksPerSecond") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "TaskQueueMetadata"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'maxTasksPerSecond") _x
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
instance Control.DeepSeq.NFData TaskQueueMetadata where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueueMetadata'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueueMetadata'maxTasksPerSecond x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.key' @:: Lens' TaskQueuePartitionMetadata Data.Text.Text@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.ownerHostName' @:: Lens' TaskQueuePartitionMetadata Data.Text.Text@ -}
data TaskQueuePartitionMetadata
  = TaskQueuePartitionMetadata'_constructor {_TaskQueuePartitionMetadata'key :: !Data.Text.Text,
                                             _TaskQueuePartitionMetadata'ownerHostName :: !Data.Text.Text,
                                             _TaskQueuePartitionMetadata'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueuePartitionMetadata where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueuePartitionMetadata "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueuePartitionMetadata'key
           (\ x__ y__ -> x__ {_TaskQueuePartitionMetadata'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueuePartitionMetadata "ownerHostName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueuePartitionMetadata'ownerHostName
           (\ x__ y__
              -> x__ {_TaskQueuePartitionMetadata'ownerHostName = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueuePartitionMetadata where
  messageName _
    = Data.Text.pack
        "temporal.api.taskqueue.v1.TaskQueuePartitionMetadata"
  packedMessageDescriptor _
    = "\n\
      \\SUBTaskQueuePartitionMetadata\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2&\n\
      \\SIowner_host_name\CAN\STX \SOH(\tR\rownerHostName"
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
              Data.ProtoLens.FieldDescriptor TaskQueuePartitionMetadata
        ownerHostName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "owner_host_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"ownerHostName")) ::
              Data.ProtoLens.FieldDescriptor TaskQueuePartitionMetadata
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, ownerHostName__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueuePartitionMetadata'_unknownFields
        (\ x__ y__
           -> x__ {_TaskQueuePartitionMetadata'_unknownFields = y__})
  defMessage
    = TaskQueuePartitionMetadata'_constructor
        {_TaskQueuePartitionMetadata'key = Data.ProtoLens.fieldDefault,
         _TaskQueuePartitionMetadata'ownerHostName = Data.ProtoLens.fieldDefault,
         _TaskQueuePartitionMetadata'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueuePartitionMetadata
          -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueuePartitionMetadata
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
                                       "key"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"key") y x)
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
                                       "owner_host_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"ownerHostName") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "TaskQueuePartitionMetadata"
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
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"ownerHostName") _x
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
instance Control.DeepSeq.NFData TaskQueuePartitionMetadata where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueuePartitionMetadata'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueuePartitionMetadata'key x__)
                (Control.DeepSeq.deepseq
                   (_TaskQueuePartitionMetadata'ownerHostName x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.taskQueue' @:: Lens' TaskQueueReachability Data.Text.Text@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.reachability' @:: Lens' TaskQueueReachability [Proto.Temporal.Api.Enums.V1.TaskQueue.TaskReachability]@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.vec'reachability' @:: Lens' TaskQueueReachability (Data.Vector.Vector Proto.Temporal.Api.Enums.V1.TaskQueue.TaskReachability)@ -}
data TaskQueueReachability
  = TaskQueueReachability'_constructor {_TaskQueueReachability'taskQueue :: !Data.Text.Text,
                                        _TaskQueueReachability'reachability :: !(Data.Vector.Vector Proto.Temporal.Api.Enums.V1.TaskQueue.TaskReachability),
                                        _TaskQueueReachability'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueueReachability where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueueReachability "taskQueue" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueReachability'taskQueue
           (\ x__ y__ -> x__ {_TaskQueueReachability'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueReachability "reachability" [Proto.Temporal.Api.Enums.V1.TaskQueue.TaskReachability] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueReachability'reachability
           (\ x__ y__ -> x__ {_TaskQueueReachability'reachability = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField TaskQueueReachability "vec'reachability" (Data.Vector.Vector Proto.Temporal.Api.Enums.V1.TaskQueue.TaskReachability) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueReachability'reachability
           (\ x__ y__ -> x__ {_TaskQueueReachability'reachability = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueueReachability where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.TaskQueueReachability"
  packedMessageDescriptor _
    = "\n\
      \\NAKTaskQueueReachability\DC2\GS\n\
      \\n\
      \task_queue\CAN\SOH \SOH(\tR\ttaskQueue\DC2K\n\
      \\freachability\CAN\STX \ETX(\SO2'.temporal.api.enums.v1.TaskReachabilityR\freachability"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskQueue")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueReachability
        reachability__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reachability"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.TaskQueue.TaskReachability)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Packed
                 (Data.ProtoLens.Field.field @"reachability")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueReachability
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 2, reachability__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueueReachability'_unknownFields
        (\ x__ y__ -> x__ {_TaskQueueReachability'_unknownFields = y__})
  defMessage
    = TaskQueueReachability'_constructor
        {_TaskQueueReachability'taskQueue = Data.ProtoLens.fieldDefault,
         _TaskQueueReachability'reachability = Data.Vector.Generic.empty,
         _TaskQueueReachability'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueueReachability
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Enums.V1.TaskQueue.TaskReachability
             -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueueReachability
        loop x mutable'reachability
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'reachability <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                               (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                  mutable'reachability)
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
                              (Data.ProtoLens.Field.field @"vec'reachability")
                              frozen'reachability x))
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
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                                  mutable'reachability
                        16
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (Prelude.fmap
                                           Prelude.toEnum
                                           (Prelude.fmap
                                              Prelude.fromIntegral
                                              Data.ProtoLens.Encoding.Bytes.getVarInt))
                                        "reachability"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'reachability y)
                                loop x v
                        18
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
                                                                    "reachability"
                                                            qs' <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                                     (Data.ProtoLens.Encoding.Growing.append
                                                                        qs q)
                                                            ploop qs'
                                            in ploop)
                                             mutable'reachability)
                                loop x y
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'reachability
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'reachability <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                        Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'reachability)
          "TaskQueueReachability"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"taskQueue") _x
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
                   p = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"vec'reachability") _x
                 in
                   if Data.Vector.Generic.null p then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
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
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData TaskQueueReachability where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueueReachability'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueueReachability'taskQueue x__)
                (Control.DeepSeq.deepseq
                   (_TaskQueueReachability'reachability x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.backlogCountHint' @:: Lens' TaskQueueStatus Data.Int.Int64@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.readLevel' @:: Lens' TaskQueueStatus Data.Int.Int64@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.ackLevel' @:: Lens' TaskQueueStatus Data.Int.Int64@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.ratePerSecond' @:: Lens' TaskQueueStatus Prelude.Double@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.taskIdBlock' @:: Lens' TaskQueueStatus TaskIdBlock@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'taskIdBlock' @:: Lens' TaskQueueStatus (Prelude.Maybe TaskIdBlock)@ -}
data TaskQueueStatus
  = TaskQueueStatus'_constructor {_TaskQueueStatus'backlogCountHint :: !Data.Int.Int64,
                                  _TaskQueueStatus'readLevel :: !Data.Int.Int64,
                                  _TaskQueueStatus'ackLevel :: !Data.Int.Int64,
                                  _TaskQueueStatus'ratePerSecond :: !Prelude.Double,
                                  _TaskQueueStatus'taskIdBlock :: !(Prelude.Maybe TaskIdBlock),
                                  _TaskQueueStatus'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueueStatus where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueueStatus "backlogCountHint" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueStatus'backlogCountHint
           (\ x__ y__ -> x__ {_TaskQueueStatus'backlogCountHint = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueStatus "readLevel" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueStatus'readLevel
           (\ x__ y__ -> x__ {_TaskQueueStatus'readLevel = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueStatus "ackLevel" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueStatus'ackLevel
           (\ x__ y__ -> x__ {_TaskQueueStatus'ackLevel = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueStatus "ratePerSecond" Prelude.Double where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueStatus'ratePerSecond
           (\ x__ y__ -> x__ {_TaskQueueStatus'ratePerSecond = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueStatus "taskIdBlock" TaskIdBlock where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueStatus'taskIdBlock
           (\ x__ y__ -> x__ {_TaskQueueStatus'taskIdBlock = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField TaskQueueStatus "maybe'taskIdBlock" (Prelude.Maybe TaskIdBlock) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueStatus'taskIdBlock
           (\ x__ y__ -> x__ {_TaskQueueStatus'taskIdBlock = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueueStatus where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.TaskQueueStatus"
  packedMessageDescriptor _
    = "\n\
      \\SITaskQueueStatus\DC2,\n\
      \\DC2backlog_count_hint\CAN\SOH \SOH(\ETXR\DLEbacklogCountHint\DC2\GS\n\
      \\n\
      \read_level\CAN\STX \SOH(\ETXR\treadLevel\DC2\ESC\n\
      \\tack_level\CAN\ETX \SOH(\ETXR\backLevel\DC2&\n\
      \\SIrate_per_second\CAN\EOT \SOH(\SOHR\rratePerSecond\DC2J\n\
      \\rtask_id_block\CAN\ENQ \SOH(\v2&.temporal.api.taskqueue.v1.TaskIdBlockR\vtaskIdBlock"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        backlogCountHint__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "backlog_count_hint"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"backlogCountHint")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueStatus
        readLevel__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "read_level"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"readLevel")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueStatus
        ackLevel__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "ack_level"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"ackLevel")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueStatus
        ratePerSecond__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rate_per_second"
              (Data.ProtoLens.ScalarField Data.ProtoLens.DoubleField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"ratePerSecond")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueStatus
        taskIdBlock__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_id_block"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor TaskIdBlock)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'taskIdBlock")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueStatus
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, backlogCountHint__field_descriptor),
           (Data.ProtoLens.Tag 2, readLevel__field_descriptor),
           (Data.ProtoLens.Tag 3, ackLevel__field_descriptor),
           (Data.ProtoLens.Tag 4, ratePerSecond__field_descriptor),
           (Data.ProtoLens.Tag 5, taskIdBlock__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueueStatus'_unknownFields
        (\ x__ y__ -> x__ {_TaskQueueStatus'_unknownFields = y__})
  defMessage
    = TaskQueueStatus'_constructor
        {_TaskQueueStatus'backlogCountHint = Data.ProtoLens.fieldDefault,
         _TaskQueueStatus'readLevel = Data.ProtoLens.fieldDefault,
         _TaskQueueStatus'ackLevel = Data.ProtoLens.fieldDefault,
         _TaskQueueStatus'ratePerSecond = Data.ProtoLens.fieldDefault,
         _TaskQueueStatus'taskIdBlock = Prelude.Nothing,
         _TaskQueueStatus'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueueStatus
          -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueueStatus
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
                                       "backlog_count_hint"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"backlogCountHint") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "read_level"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"readLevel") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "ack_level"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"ackLevel") y x)
                        33
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToDouble
                                          Data.ProtoLens.Encoding.Bytes.getFixed64)
                                       "rate_per_second"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"ratePerSecond") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "task_id_block"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskIdBlock") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "TaskQueueStatus"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"backlogCountHint") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"readLevel") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"ackLevel") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"ratePerSecond") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 33)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putFixed64
                                  Data.ProtoLens.Encoding.Bytes.doubleToWord _v))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view
                                (Data.ProtoLens.Field.field @"maybe'taskIdBlock") _x
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
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData TaskQueueStatus where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueueStatus'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueueStatus'backlogCountHint x__)
                (Control.DeepSeq.deepseq
                   (_TaskQueueStatus'readLevel x__)
                   (Control.DeepSeq.deepseq
                      (_TaskQueueStatus'ackLevel x__)
                      (Control.DeepSeq.deepseq
                         (_TaskQueueStatus'ratePerSecond x__)
                         (Control.DeepSeq.deepseq (_TaskQueueStatus'taskIdBlock x__) ())))))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \'temporal/api/taskqueue/v1/message.proto\DC2\EMtemporal.api.taskqueue.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB\RSgoogle/protobuf/wrappers.proto\SUB!dependencies/gogoproto/gogo.proto\SUB&temporal/api/enums/v1/task_queue.proto\SUB$temporal/api/common/v1/message.proto\"z\n\
    \\tTaskQueue\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC28\n\
    \\EOTkind\CAN\STX \SOH(\SO2$.temporal.api.enums.v1.TaskQueueKindR\EOTkind\DC2\US\n\
    \\vnormal_name\CAN\ETX \SOH(\tR\n\
    \normalName\"b\n\
    \\DC1TaskQueueMetadata\DC2M\n\
    \\DC4max_tasks_per_second\CAN\SOH \SOH(\v2\FS.google.protobuf.DoubleValueR\DC1maxTasksPerSecond\"\239\SOH\n\
    \\SITaskQueueStatus\DC2,\n\
    \\DC2backlog_count_hint\CAN\SOH \SOH(\ETXR\DLEbacklogCountHint\DC2\GS\n\
    \\n\
    \read_level\CAN\STX \SOH(\ETXR\treadLevel\DC2\ESC\n\
    \\tack_level\CAN\ETX \SOH(\ETXR\backLevel\DC2&\n\
    \\SIrate_per_second\CAN\EOT \SOH(\SOHR\rratePerSecond\DC2J\n\
    \\rtask_id_block\CAN\ENQ \SOH(\v2&.temporal.api.taskqueue.v1.TaskIdBlockR\vtaskIdBlock\"?\n\
    \\vTaskIdBlock\DC2\EM\n\
    \\bstart_id\CAN\SOH \SOH(\ETXR\astartId\DC2\NAK\n\
    \\ACKend_id\CAN\STX \SOH(\ETXR\ENQendId\"V\n\
    \\SUBTaskQueuePartitionMetadata\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2&\n\
    \\SIowner_host_name\CAN\STX \SOH(\tR\rownerHostName\"\143\STX\n\
    \\n\
    \PollerInfo\DC2J\n\
    \\DLElast_access_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\SOlastAccessTimeB\EOT\144\223\US\SOH\DC2\SUB\n\
    \\bidentity\CAN\STX \SOH(\tR\bidentity\DC2&\n\
    \\SIrate_per_second\CAN\ETX \SOH(\SOHR\rratePerSecond\DC2q\n\
    \\ESCworker_version_capabilities\CAN\EOT \SOH(\v21.temporal.api.common.v1.WorkerVersionCapabilitiesR\EMworkerVersionCapabilities\"\201\SOH\n\
    \\EMStickyExecutionAttributes\DC2P\n\
    \\DC1worker_task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\SIworkerTaskQueue\DC2Z\n\
    \\EMschedule_to_start_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToStartTimeoutB\EOT\152\223\US\SOH\"3\n\
    \\DC4CompatibleVersionSet\DC2\ESC\n\
    \\tbuild_ids\CAN\SOH \ETX(\tR\bbuildIds\"\131\SOH\n\
    \\NAKTaskQueueReachability\DC2\GS\n\
    \\n\
    \task_queue\CAN\SOH \SOH(\tR\ttaskQueue\DC2K\n\
    \\freachability\CAN\STX \ETX(\SO2'.temporal.api.enums.v1.TaskReachabilityR\freachability\"\154\SOH\n\
    \\DC3BuildIdReachability\DC2\EM\n\
    \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2h\n\
    \\ETBtask_queue_reachability\CAN\STX \ETX(\v20.temporal.api.taskqueue.v1.TaskQueueReachabilityR\NAKtaskQueueReachabilityB\152\SOH\n\
    \\FSio.temporal.api.taskqueue.v1B\fMessageProtoP\SOHZ)go.temporal.io/api/taskqueue/v1;taskqueue\170\STX\ESCTemporalio.Api.TaskQueue.V1\234\STX\RSTemporalio::Api::TaskQueue::V1J\225!\n\
    \\ACK\DC2\EOT\SYN\NULr\SOH\n\
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
    \\STX\ETX\STX\DC2\ETX#\NUL(\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX%\NUL+\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX'\NUL0\n\
    \\t\n\
    \\STX\ETX\ENQ\DC2\ETX(\NUL.\n\
    \E\n\
    \\STX\EOT\NUL\DC2\EOT+\NUL2\SOH\SUB9 See https://docs.temporal.io/docs/concepts/task-queues/\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX+\b\DC1\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX,\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX,\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX,\v\SI\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX,\DC2\DC3\n\
    \/\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX.\EOT1\SUB\" Default: TASK_QUEUE_KIND_NORMAL.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX.\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX.(,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX./0\n\
    \\149\SOH\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX1\EOT\ESC\SUB\135\SOH Iff kind == TASK_QUEUE_KIND_STICKY, then this field contains the name of\n\
    \ the normal task queue that the sticky worker is running on.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX1\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX1\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX1\EM\SUB\n\
    \2\n\
    \\STX\EOT\SOH\DC2\EOT5\NUL8\SOH\SUB& Only applies to activity task queues\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX5\b\EM\n\
    \B\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX7\EOT9\SUB5 Allows throttling dispatch of tasks from this queue\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX7\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX7 4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX778\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT:\NUL@\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX:\b\ETB\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX;\EOT!\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX;\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX;\n\
    \\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX;\US \n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX<\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX<\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX<\n\
    \\DC4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX<\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETX=\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ENQ\DC2\ETX=\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETX=\n\
    \\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETX=\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\STX\STX\ETX\DC2\ETX>\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ENQ\DC2\ETX>\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\ETX>\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\ETX>\GS\RS\n\
    \\v\n\
    \\EOT\EOT\STX\STX\EOT\DC2\ETX?\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ACK\DC2\ETX?\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\SOH\DC2\ETX?\DLE\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ETX\DC2\ETX? !\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOTB\NULE\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXB\b\DC3\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXC\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETXC\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXC\n\
    \\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXC\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXD\EOT\NAK\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETXD\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXD\n\
    \\DLE\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXD\DC3\DC4\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOTG\NULJ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXG\b\"\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXH\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETXH\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXH\v\SO\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXH\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\ETXI\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ENQ\DC2\ETXI\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\ETXI\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\ETXI\GS\RS\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOTL\NULS\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXL\b\DC2\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXM\EOTP\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETXM\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXM\RS.\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXM12\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\b\DC2\ETXM3O\n\
    \\SI\n\
    \\b\EOT\ENQ\STX\NUL\b\242\251\ETX\DC2\ETXM4N\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETXN\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ENQ\DC2\ETXN\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETXN\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETXN\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\ETXO\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ENQ\DC2\ETXO\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\ETXO\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\ETXO\GS\RS\n\
    \z\n\
    \\EOT\EOT\ENQ\STX\ETX\DC2\ETXR\EOTU\SUBm If a worker has opted into the worker versioning feature while polling, its capabilities will\n\
    \ appear here.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ACK\DC2\ETXR\EOT4\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\SOH\DC2\ETXR5P\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ETX\DC2\ETXRST\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOTU\NULZ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXU\b!\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXV\EOT$\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ACK\DC2\ETXV\EOT\r\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXV\SO\US\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXV\"#\n\
    \\131\SOH\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXY\EOT\\\SUBv (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: \"to\" is used to indicate interval. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ACK\DC2\ETXY\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXY\GS6\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXY9:\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\b\DC2\ETXY;[\n\
    \\SI\n\
    \\b\EOT\ACK\STX\SOH\b\243\251\ETX\DC2\ETXY<Z\n\
    \\210\SOH\n\
    \\STX\EOT\a\DC2\EOT^\NULa\SOH\SUB\197\SOH Used by the worker versioning APIs, represents an unordered set of one or more versions which are\n\
    \ considered to be compatible with each other. Currently the versions are always worker build IDs.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETX^\b\FS\n\
    \z\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETX`\EOT\"\SUBm All the compatible versions, unordered, except for the last element, which is considered the set \"default\".\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\EOT\DC2\ETX`\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETX`\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETX`\DC4\GS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETX` !\n\
    \H\n\
    \\STX\EOT\b\DC2\EOTd\NULj\SOH\SUB< Reachability of tasks for a worker on a single task queue.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXd\b\GS\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETXe\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\ETXe\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETXe\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETXe\CAN\EM\n\
    \\232\SOH\n\
    \\EOT\EOT\b\STX\SOH\DC2\ETXi\EOTE\SUB\218\SOH Task reachability for a worker in a single task queue.\n\
    \ See the TaskReachability docstring for information about each enum variant.\n\
    \ If reachability is empty, this worker is considered unreachable in this task queue.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\EOT\DC2\ETXi\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ACK\DC2\ETXi\r3\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\ETXi4@\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\ETXiCD\n\
    \Y\n\
    \\STX\EOT\t\DC2\EOTm\NULr\SOH\SUBM Reachability of tasks for a worker by build id, in one or more task queues.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETXm\b\ESC\n\
    \2\n\
    \\EOT\EOT\t\STX\NUL\DC2\ETXo\EOT\CAN\SUB% A build id or empty if unversioned.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ENQ\DC2\ETXo\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\ETXo\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\ETXo\SYN\ETB\n\
    \+\n\
    \\EOT\EOT\t\STX\SOH\DC2\ETXq\EOT?\SUB\RS Reachability per task queue.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\EOT\DC2\ETXq\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ACK\DC2\ETXq\r\"\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\ETXq#:\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\ETXq=>b\ACKproto3"
{- This file was auto-generated from temporal/api/taskqueue/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Taskqueue.V1.Message (
        BuildIdAssignmentRule(), BuildIdAssignmentRule'Ramp(..),
        _BuildIdAssignmentRule'PercentageRamp, BuildIdReachability(),
        CompatibleBuildIdRedirectRule(), CompatibleVersionSet(),
        PollerInfo(), RampByPercentage(), StickyExecutionAttributes(),
        TaskIdBlock(), TaskQueue(), TaskQueueMetadata(),
        TaskQueuePartitionMetadata(), TaskQueueReachability(),
        TaskQueueStatus(), TaskQueueTypeInfo(), TaskQueueVersionInfo(),
        TaskQueueVersionInfo'TypesInfoEntry(), TaskQueueVersionSelection(),
        TimestampedBuildIdAssignmentRule(),
        TimestampedCompatibleBuildIdRedirectRule()
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
import qualified Proto.Google.Protobuf.Wrappers
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.TaskQueue
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.targetBuildId' @:: Lens' BuildIdAssignmentRule Data.Text.Text@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'ramp' @:: Lens' BuildIdAssignmentRule (Prelude.Maybe BuildIdAssignmentRule'Ramp)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'percentageRamp' @:: Lens' BuildIdAssignmentRule (Prelude.Maybe RampByPercentage)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.percentageRamp' @:: Lens' BuildIdAssignmentRule RampByPercentage@ -}
data BuildIdAssignmentRule
  = BuildIdAssignmentRule'_constructor {_BuildIdAssignmentRule'targetBuildId :: !Data.Text.Text,
                                        _BuildIdAssignmentRule'ramp :: !(Prelude.Maybe BuildIdAssignmentRule'Ramp),
                                        _BuildIdAssignmentRule'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BuildIdAssignmentRule where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data BuildIdAssignmentRule'Ramp
  = BuildIdAssignmentRule'PercentageRamp !RampByPercentage
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField BuildIdAssignmentRule "targetBuildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BuildIdAssignmentRule'targetBuildId
           (\ x__ y__ -> x__ {_BuildIdAssignmentRule'targetBuildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BuildIdAssignmentRule "maybe'ramp" (Prelude.Maybe BuildIdAssignmentRule'Ramp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BuildIdAssignmentRule'ramp
           (\ x__ y__ -> x__ {_BuildIdAssignmentRule'ramp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BuildIdAssignmentRule "maybe'percentageRamp" (Prelude.Maybe RampByPercentage) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BuildIdAssignmentRule'ramp
           (\ x__ y__ -> x__ {_BuildIdAssignmentRule'ramp = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (BuildIdAssignmentRule'PercentageRamp x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap BuildIdAssignmentRule'PercentageRamp y__))
instance Data.ProtoLens.Field.HasField BuildIdAssignmentRule "percentageRamp" RampByPercentage where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BuildIdAssignmentRule'ramp
           (\ x__ y__ -> x__ {_BuildIdAssignmentRule'ramp = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (BuildIdAssignmentRule'PercentageRamp x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap BuildIdAssignmentRule'PercentageRamp y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message BuildIdAssignmentRule where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.BuildIdAssignmentRule"
  packedMessageDescriptor _
    = "\n\
      \\NAKBuildIdAssignmentRule\DC2&\n\
      \\SItarget_build_id\CAN\SOH \SOH(\tR\rtargetBuildId\DC2V\n\
      \\SIpercentage_ramp\CAN\ETX \SOH(\v2+.temporal.api.taskqueue.v1.RampByPercentageH\NULR\SOpercentageRampB\ACK\n\
      \\EOTramp"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        targetBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "target_build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"targetBuildId")) ::
              Data.ProtoLens.FieldDescriptor BuildIdAssignmentRule
        percentageRamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "percentage_ramp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor RampByPercentage)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'percentageRamp")) ::
              Data.ProtoLens.FieldDescriptor BuildIdAssignmentRule
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, targetBuildId__field_descriptor),
           (Data.ProtoLens.Tag 3, percentageRamp__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BuildIdAssignmentRule'_unknownFields
        (\ x__ y__ -> x__ {_BuildIdAssignmentRule'_unknownFields = y__})
  defMessage
    = BuildIdAssignmentRule'_constructor
        {_BuildIdAssignmentRule'targetBuildId = Data.ProtoLens.fieldDefault,
         _BuildIdAssignmentRule'ramp = Prelude.Nothing,
         _BuildIdAssignmentRule'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BuildIdAssignmentRule
          -> Data.ProtoLens.Encoding.Bytes.Parser BuildIdAssignmentRule
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
                                       "target_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"targetBuildId") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "percentage_ramp"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"percentageRamp") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BuildIdAssignmentRule"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"targetBuildId") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'ramp") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (BuildIdAssignmentRule'PercentageRamp v))
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
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData BuildIdAssignmentRule where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BuildIdAssignmentRule'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BuildIdAssignmentRule'targetBuildId x__)
                (Control.DeepSeq.deepseq (_BuildIdAssignmentRule'ramp x__) ()))
instance Control.DeepSeq.NFData BuildIdAssignmentRule'Ramp where
  rnf (BuildIdAssignmentRule'PercentageRamp x__)
    = Control.DeepSeq.rnf x__
_BuildIdAssignmentRule'PercentageRamp ::
  Data.ProtoLens.Prism.Prism' BuildIdAssignmentRule'Ramp RampByPercentage
_BuildIdAssignmentRule'PercentageRamp
  = Data.ProtoLens.Prism.prism'
      BuildIdAssignmentRule'PercentageRamp
      (\ p__
         -> case p__ of
              (BuildIdAssignmentRule'PercentageRamp p__val)
                -> Prelude.Just p__val)
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
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
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
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.sourceBuildId' @:: Lens' CompatibleBuildIdRedirectRule Data.Text.Text@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.targetBuildId' @:: Lens' CompatibleBuildIdRedirectRule Data.Text.Text@ -}
data CompatibleBuildIdRedirectRule
  = CompatibleBuildIdRedirectRule'_constructor {_CompatibleBuildIdRedirectRule'sourceBuildId :: !Data.Text.Text,
                                                _CompatibleBuildIdRedirectRule'targetBuildId :: !Data.Text.Text,
                                                _CompatibleBuildIdRedirectRule'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CompatibleBuildIdRedirectRule where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CompatibleBuildIdRedirectRule "sourceBuildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompatibleBuildIdRedirectRule'sourceBuildId
           (\ x__ y__
              -> x__ {_CompatibleBuildIdRedirectRule'sourceBuildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CompatibleBuildIdRedirectRule "targetBuildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompatibleBuildIdRedirectRule'targetBuildId
           (\ x__ y__
              -> x__ {_CompatibleBuildIdRedirectRule'targetBuildId = y__}))
        Prelude.id
instance Data.ProtoLens.Message CompatibleBuildIdRedirectRule where
  messageName _
    = Data.Text.pack
        "temporal.api.taskqueue.v1.CompatibleBuildIdRedirectRule"
  packedMessageDescriptor _
    = "\n\
      \\GSCompatibleBuildIdRedirectRule\DC2&\n\
      \\SIsource_build_id\CAN\SOH \SOH(\tR\rsourceBuildId\DC2&\n\
      \\SItarget_build_id\CAN\STX \SOH(\tR\rtargetBuildId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        sourceBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "source_build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"sourceBuildId")) ::
              Data.ProtoLens.FieldDescriptor CompatibleBuildIdRedirectRule
        targetBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "target_build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"targetBuildId")) ::
              Data.ProtoLens.FieldDescriptor CompatibleBuildIdRedirectRule
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, sourceBuildId__field_descriptor),
           (Data.ProtoLens.Tag 2, targetBuildId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CompatibleBuildIdRedirectRule'_unknownFields
        (\ x__ y__
           -> x__ {_CompatibleBuildIdRedirectRule'_unknownFields = y__})
  defMessage
    = CompatibleBuildIdRedirectRule'_constructor
        {_CompatibleBuildIdRedirectRule'sourceBuildId = Data.ProtoLens.fieldDefault,
         _CompatibleBuildIdRedirectRule'targetBuildId = Data.ProtoLens.fieldDefault,
         _CompatibleBuildIdRedirectRule'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CompatibleBuildIdRedirectRule
          -> Data.ProtoLens.Encoding.Bytes.Parser CompatibleBuildIdRedirectRule
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
                                       "source_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"sourceBuildId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "target_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"targetBuildId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CompatibleBuildIdRedirectRule"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"sourceBuildId") _x
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
                         (Data.ProtoLens.Field.field @"targetBuildId") _x
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
instance Control.DeepSeq.NFData CompatibleBuildIdRedirectRule where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CompatibleBuildIdRedirectRule'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CompatibleBuildIdRedirectRule'sourceBuildId x__)
                (Control.DeepSeq.deepseq
                   (_CompatibleBuildIdRedirectRule'targetBuildId x__) ()))
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
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
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
      \PollerInfo\DC2D\n\
      \\DLElast_access_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\SOlastAccessTime\DC2\SUB\n\
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
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
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
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.rampPercentage' @:: Lens' RampByPercentage Prelude.Float@ -}
data RampByPercentage
  = RampByPercentage'_constructor {_RampByPercentage'rampPercentage :: !Prelude.Float,
                                   _RampByPercentage'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RampByPercentage where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RampByPercentage "rampPercentage" Prelude.Float where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RampByPercentage'rampPercentage
           (\ x__ y__ -> x__ {_RampByPercentage'rampPercentage = y__}))
        Prelude.id
instance Data.ProtoLens.Message RampByPercentage where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.RampByPercentage"
  packedMessageDescriptor _
    = "\n\
      \\DLERampByPercentage\DC2'\n\
      \\SIramp_percentage\CAN\SOH \SOH(\STXR\SOrampPercentage"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        rampPercentage__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "ramp_percentage"
              (Data.ProtoLens.ScalarField Data.ProtoLens.FloatField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Float)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"rampPercentage")) ::
              Data.ProtoLens.FieldDescriptor RampByPercentage
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, rampPercentage__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RampByPercentage'_unknownFields
        (\ x__ y__ -> x__ {_RampByPercentage'_unknownFields = y__})
  defMessage
    = RampByPercentage'_constructor
        {_RampByPercentage'rampPercentage = Data.ProtoLens.fieldDefault,
         _RampByPercentage'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RampByPercentage
          -> Data.ProtoLens.Encoding.Bytes.Parser RampByPercentage
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
                        13
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToFloat
                                          Data.ProtoLens.Encoding.Bytes.getFixed32)
                                       "ramp_percentage"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"rampPercentage") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "RampByPercentage"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"rampPercentage") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 13)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putFixed32
                         Data.ProtoLens.Encoding.Bytes.floatToWord _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData RampByPercentage where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RampByPercentage'_unknownFields x__)
             (Control.DeepSeq.deepseq (_RampByPercentage'rampPercentage x__) ())
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
      \\DC1worker_task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\SIworkerTaskQueue\DC2T\n\
      \\EMschedule_to_start_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToStartTimeout"
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
                                       "kind"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"kind") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
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
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
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
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.pollers' @:: Lens' TaskQueueTypeInfo [PollerInfo]@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.vec'pollers' @:: Lens' TaskQueueTypeInfo (Data.Vector.Vector PollerInfo)@ -}
data TaskQueueTypeInfo
  = TaskQueueTypeInfo'_constructor {_TaskQueueTypeInfo'pollers :: !(Data.Vector.Vector PollerInfo),
                                    _TaskQueueTypeInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueueTypeInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueueTypeInfo "pollers" [PollerInfo] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueTypeInfo'pollers
           (\ x__ y__ -> x__ {_TaskQueueTypeInfo'pollers = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField TaskQueueTypeInfo "vec'pollers" (Data.Vector.Vector PollerInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueTypeInfo'pollers
           (\ x__ y__ -> x__ {_TaskQueueTypeInfo'pollers = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueueTypeInfo where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.TaskQueueTypeInfo"
  packedMessageDescriptor _
    = "\n\
      \\DC1TaskQueueTypeInfo\DC2?\n\
      \\apollers\CAN\SOH \ETX(\v2%.temporal.api.taskqueue.v1.PollerInfoR\apollers"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        pollers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "pollers"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor PollerInfo)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"pollers")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueTypeInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, pollers__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueueTypeInfo'_unknownFields
        (\ x__ y__ -> x__ {_TaskQueueTypeInfo'_unknownFields = y__})
  defMessage
    = TaskQueueTypeInfo'_constructor
        {_TaskQueueTypeInfo'pollers = Data.Vector.Generic.empty,
         _TaskQueueTypeInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueueTypeInfo
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld PollerInfo
             -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueueTypeInfo
        loop x mutable'pollers
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'pollers <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'pollers)
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
                              (Data.ProtoLens.Field.field @"vec'pollers") frozen'pollers x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "pollers"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'pollers y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'pollers
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'pollers <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'pollers)
          "TaskQueueTypeInfo"
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
                (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'pollers") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData TaskQueueTypeInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueueTypeInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq (_TaskQueueTypeInfo'pollers x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.typesInfo' @:: Lens' TaskQueueVersionInfo (Data.Map.Map Data.Int.Int32 TaskQueueTypeInfo)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.taskReachability' @:: Lens' TaskQueueVersionInfo Proto.Temporal.Api.Enums.V1.TaskQueue.BuildIdTaskReachability@ -}
data TaskQueueVersionInfo
  = TaskQueueVersionInfo'_constructor {_TaskQueueVersionInfo'typesInfo :: !(Data.Map.Map Data.Int.Int32 TaskQueueTypeInfo),
                                       _TaskQueueVersionInfo'taskReachability :: !Proto.Temporal.Api.Enums.V1.TaskQueue.BuildIdTaskReachability,
                                       _TaskQueueVersionInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueueVersionInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueueVersionInfo "typesInfo" (Data.Map.Map Data.Int.Int32 TaskQueueTypeInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionInfo'typesInfo
           (\ x__ y__ -> x__ {_TaskQueueVersionInfo'typesInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueVersionInfo "taskReachability" Proto.Temporal.Api.Enums.V1.TaskQueue.BuildIdTaskReachability where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionInfo'taskReachability
           (\ x__ y__ -> x__ {_TaskQueueVersionInfo'taskReachability = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueueVersionInfo where
  messageName _
    = Data.Text.pack "temporal.api.taskqueue.v1.TaskQueueVersionInfo"
  packedMessageDescriptor _
    = "\n\
      \\DC4TaskQueueVersionInfo\DC2]\n\
      \\n\
      \types_info\CAN\SOH \ETX(\v2>.temporal.api.taskqueue.v1.TaskQueueVersionInfo.TypesInfoEntryR\ttypesInfo\DC2[\n\
      \\DC1task_reachability\CAN\STX \SOH(\SO2..temporal.api.enums.v1.BuildIdTaskReachabilityR\DLEtaskReachability\SUBj\n\
      \\SOTypesInfoEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\ENQR\ETXkey\DC2B\n\
      \\ENQvalue\CAN\STX \SOH(\v2,.temporal.api.taskqueue.v1.TaskQueueTypeInfoR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        typesInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "types_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor TaskQueueVersionInfo'TypesInfoEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"typesInfo")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueVersionInfo
        taskReachability__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_reachability"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.TaskQueue.BuildIdTaskReachability)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskReachability")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueVersionInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, typesInfo__field_descriptor),
           (Data.ProtoLens.Tag 2, taskReachability__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueueVersionInfo'_unknownFields
        (\ x__ y__ -> x__ {_TaskQueueVersionInfo'_unknownFields = y__})
  defMessage
    = TaskQueueVersionInfo'_constructor
        {_TaskQueueVersionInfo'typesInfo = Data.Map.empty,
         _TaskQueueVersionInfo'taskReachability = Data.ProtoLens.fieldDefault,
         _TaskQueueVersionInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueueVersionInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueueVersionInfo
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
                          -> do !(entry :: TaskQueueVersionInfo'TypesInfoEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                     (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                         Data.ProtoLens.Encoding.Bytes.isolate
                                                                                           (Prelude.fromIntegral
                                                                                              len)
                                                                                           Data.ProtoLens.parseMessage)
                                                                                     "types_info"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"typesInfo")
                                        (\ !t -> Data.Map.insert key value t) x))
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "task_reachability"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"taskReachability") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "TaskQueueVersionInfo"
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
                                       TaskQueueVersionInfo'TypesInfoEntry)))))
                   (Data.Map.toList
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"typesInfo") _x))))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"taskReachability") _x
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
instance Control.DeepSeq.NFData TaskQueueVersionInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueueVersionInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueueVersionInfo'typesInfo x__)
                (Control.DeepSeq.deepseq
                   (_TaskQueueVersionInfo'taskReachability x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.key' @:: Lens' TaskQueueVersionInfo'TypesInfoEntry Data.Int.Int32@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.value' @:: Lens' TaskQueueVersionInfo'TypesInfoEntry TaskQueueTypeInfo@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'value' @:: Lens' TaskQueueVersionInfo'TypesInfoEntry (Prelude.Maybe TaskQueueTypeInfo)@ -}
data TaskQueueVersionInfo'TypesInfoEntry
  = TaskQueueVersionInfo'TypesInfoEntry'_constructor {_TaskQueueVersionInfo'TypesInfoEntry'key :: !Data.Int.Int32,
                                                      _TaskQueueVersionInfo'TypesInfoEntry'value :: !(Prelude.Maybe TaskQueueTypeInfo),
                                                      _TaskQueueVersionInfo'TypesInfoEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueueVersionInfo'TypesInfoEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueueVersionInfo'TypesInfoEntry "key" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionInfo'TypesInfoEntry'key
           (\ x__ y__
              -> x__ {_TaskQueueVersionInfo'TypesInfoEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueVersionInfo'TypesInfoEntry "value" TaskQueueTypeInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionInfo'TypesInfoEntry'value
           (\ x__ y__
              -> x__ {_TaskQueueVersionInfo'TypesInfoEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField TaskQueueVersionInfo'TypesInfoEntry "maybe'value" (Prelude.Maybe TaskQueueTypeInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionInfo'TypesInfoEntry'value
           (\ x__ y__
              -> x__ {_TaskQueueVersionInfo'TypesInfoEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueueVersionInfo'TypesInfoEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.taskqueue.v1.TaskQueueVersionInfo.TypesInfoEntry"
  packedMessageDescriptor _
    = "\n\
      \\SOTypesInfoEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\ENQR\ETXkey\DC2B\n\
      \\ENQvalue\CAN\STX \SOH(\v2,.temporal.api.taskqueue.v1.TaskQueueTypeInfoR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        key__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"key")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueVersionInfo'TypesInfoEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor TaskQueueTypeInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueVersionInfo'TypesInfoEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueueVersionInfo'TypesInfoEntry'_unknownFields
        (\ x__ y__
           -> x__ {_TaskQueueVersionInfo'TypesInfoEntry'_unknownFields = y__})
  defMessage
    = TaskQueueVersionInfo'TypesInfoEntry'_constructor
        {_TaskQueueVersionInfo'TypesInfoEntry'key = Data.ProtoLens.fieldDefault,
         _TaskQueueVersionInfo'TypesInfoEntry'value = Prelude.Nothing,
         _TaskQueueVersionInfo'TypesInfoEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueueVersionInfo'TypesInfoEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueueVersionInfo'TypesInfoEntry
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
          (do loop Data.ProtoLens.defMessage) "TypesInfoEntry"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"key") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
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
instance Control.DeepSeq.NFData TaskQueueVersionInfo'TypesInfoEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueueVersionInfo'TypesInfoEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueueVersionInfo'TypesInfoEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_TaskQueueVersionInfo'TypesInfoEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.buildIds' @:: Lens' TaskQueueVersionSelection [Data.Text.Text]@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.vec'buildIds' @:: Lens' TaskQueueVersionSelection (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.unversioned' @:: Lens' TaskQueueVersionSelection Prelude.Bool@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.allActive' @:: Lens' TaskQueueVersionSelection Prelude.Bool@ -}
data TaskQueueVersionSelection
  = TaskQueueVersionSelection'_constructor {_TaskQueueVersionSelection'buildIds :: !(Data.Vector.Vector Data.Text.Text),
                                            _TaskQueueVersionSelection'unversioned :: !Prelude.Bool,
                                            _TaskQueueVersionSelection'allActive :: !Prelude.Bool,
                                            _TaskQueueVersionSelection'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TaskQueueVersionSelection where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TaskQueueVersionSelection "buildIds" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionSelection'buildIds
           (\ x__ y__ -> x__ {_TaskQueueVersionSelection'buildIds = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField TaskQueueVersionSelection "vec'buildIds" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionSelection'buildIds
           (\ x__ y__ -> x__ {_TaskQueueVersionSelection'buildIds = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueVersionSelection "unversioned" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionSelection'unversioned
           (\ x__ y__ -> x__ {_TaskQueueVersionSelection'unversioned = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TaskQueueVersionSelection "allActive" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TaskQueueVersionSelection'allActive
           (\ x__ y__ -> x__ {_TaskQueueVersionSelection'allActive = y__}))
        Prelude.id
instance Data.ProtoLens.Message TaskQueueVersionSelection where
  messageName _
    = Data.Text.pack
        "temporal.api.taskqueue.v1.TaskQueueVersionSelection"
  packedMessageDescriptor _
    = "\n\
      \\EMTaskQueueVersionSelection\DC2\ESC\n\
      \\tbuild_ids\CAN\SOH \ETX(\tR\bbuildIds\DC2 \n\
      \\vunversioned\CAN\STX \SOH(\bR\vunversioned\DC2\GS\n\
      \\n\
      \all_active\CAN\ETX \SOH(\bR\tallActive"
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
              Data.ProtoLens.FieldDescriptor TaskQueueVersionSelection
        unversioned__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "unversioned"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"unversioned")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueVersionSelection
        allActive__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "all_active"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"allActive")) ::
              Data.ProtoLens.FieldDescriptor TaskQueueVersionSelection
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, buildIds__field_descriptor),
           (Data.ProtoLens.Tag 2, unversioned__field_descriptor),
           (Data.ProtoLens.Tag 3, allActive__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TaskQueueVersionSelection'_unknownFields
        (\ x__ y__
           -> x__ {_TaskQueueVersionSelection'_unknownFields = y__})
  defMessage
    = TaskQueueVersionSelection'_constructor
        {_TaskQueueVersionSelection'buildIds = Data.Vector.Generic.empty,
         _TaskQueueVersionSelection'unversioned = Data.ProtoLens.fieldDefault,
         _TaskQueueVersionSelection'allActive = Data.ProtoLens.fieldDefault,
         _TaskQueueVersionSelection'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TaskQueueVersionSelection
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
             -> Data.ProtoLens.Encoding.Bytes.Parser TaskQueueVersionSelection
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
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "build_ids"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'buildIds y)
                                loop x v
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "unversioned"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"unversioned") y x)
                                  mutable'buildIds
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "all_active"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"allActive") y x)
                                  mutable'buildIds
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
          "TaskQueueVersionSelection"
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
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"unversioned") _x
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
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"allActive") _x
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
instance Control.DeepSeq.NFData TaskQueueVersionSelection where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TaskQueueVersionSelection'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TaskQueueVersionSelection'buildIds x__)
                (Control.DeepSeq.deepseq
                   (_TaskQueueVersionSelection'unversioned x__)
                   (Control.DeepSeq.deepseq
                      (_TaskQueueVersionSelection'allActive x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.rule' @:: Lens' TimestampedBuildIdAssignmentRule BuildIdAssignmentRule@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'rule' @:: Lens' TimestampedBuildIdAssignmentRule (Prelude.Maybe BuildIdAssignmentRule)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.createTime' @:: Lens' TimestampedBuildIdAssignmentRule Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'createTime' @:: Lens' TimestampedBuildIdAssignmentRule (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data TimestampedBuildIdAssignmentRule
  = TimestampedBuildIdAssignmentRule'_constructor {_TimestampedBuildIdAssignmentRule'rule :: !(Prelude.Maybe BuildIdAssignmentRule),
                                                   _TimestampedBuildIdAssignmentRule'createTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                   _TimestampedBuildIdAssignmentRule'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TimestampedBuildIdAssignmentRule where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TimestampedBuildIdAssignmentRule "rule" BuildIdAssignmentRule where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedBuildIdAssignmentRule'rule
           (\ x__ y__ -> x__ {_TimestampedBuildIdAssignmentRule'rule = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField TimestampedBuildIdAssignmentRule "maybe'rule" (Prelude.Maybe BuildIdAssignmentRule) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedBuildIdAssignmentRule'rule
           (\ x__ y__ -> x__ {_TimestampedBuildIdAssignmentRule'rule = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TimestampedBuildIdAssignmentRule "createTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedBuildIdAssignmentRule'createTime
           (\ x__ y__
              -> x__ {_TimestampedBuildIdAssignmentRule'createTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField TimestampedBuildIdAssignmentRule "maybe'createTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedBuildIdAssignmentRule'createTime
           (\ x__ y__
              -> x__ {_TimestampedBuildIdAssignmentRule'createTime = y__}))
        Prelude.id
instance Data.ProtoLens.Message TimestampedBuildIdAssignmentRule where
  messageName _
    = Data.Text.pack
        "temporal.api.taskqueue.v1.TimestampedBuildIdAssignmentRule"
  packedMessageDescriptor _
    = "\n\
      \ TimestampedBuildIdAssignmentRule\DC2D\n\
      \\EOTrule\CAN\SOH \SOH(\v20.temporal.api.taskqueue.v1.BuildIdAssignmentRuleR\EOTrule\DC2;\n\
      \\vcreate_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \createTime"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        rule__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rule"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor BuildIdAssignmentRule)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'rule")) ::
              Data.ProtoLens.FieldDescriptor TimestampedBuildIdAssignmentRule
        createTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "create_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'createTime")) ::
              Data.ProtoLens.FieldDescriptor TimestampedBuildIdAssignmentRule
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, rule__field_descriptor),
           (Data.ProtoLens.Tag 2, createTime__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TimestampedBuildIdAssignmentRule'_unknownFields
        (\ x__ y__
           -> x__ {_TimestampedBuildIdAssignmentRule'_unknownFields = y__})
  defMessage
    = TimestampedBuildIdAssignmentRule'_constructor
        {_TimestampedBuildIdAssignmentRule'rule = Prelude.Nothing,
         _TimestampedBuildIdAssignmentRule'createTime = Prelude.Nothing,
         _TimestampedBuildIdAssignmentRule'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TimestampedBuildIdAssignmentRule
          -> Data.ProtoLens.Encoding.Bytes.Parser TimestampedBuildIdAssignmentRule
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
                                       "rule"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"rule") y x)
                        18
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
          (do loop Data.ProtoLens.defMessage)
          "TimestampedBuildIdAssignmentRule"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'rule") _x
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
                       (Data.ProtoLens.Field.field @"maybe'createTime") _x
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
instance Control.DeepSeq.NFData TimestampedBuildIdAssignmentRule where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TimestampedBuildIdAssignmentRule'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TimestampedBuildIdAssignmentRule'rule x__)
                (Control.DeepSeq.deepseq
                   (_TimestampedBuildIdAssignmentRule'createTime x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.rule' @:: Lens' TimestampedCompatibleBuildIdRedirectRule CompatibleBuildIdRedirectRule@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'rule' @:: Lens' TimestampedCompatibleBuildIdRedirectRule (Prelude.Maybe CompatibleBuildIdRedirectRule)@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.createTime' @:: Lens' TimestampedCompatibleBuildIdRedirectRule Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Taskqueue.V1.Message_Fields.maybe'createTime' @:: Lens' TimestampedCompatibleBuildIdRedirectRule (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data TimestampedCompatibleBuildIdRedirectRule
  = TimestampedCompatibleBuildIdRedirectRule'_constructor {_TimestampedCompatibleBuildIdRedirectRule'rule :: !(Prelude.Maybe CompatibleBuildIdRedirectRule),
                                                           _TimestampedCompatibleBuildIdRedirectRule'createTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                           _TimestampedCompatibleBuildIdRedirectRule'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show TimestampedCompatibleBuildIdRedirectRule where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField TimestampedCompatibleBuildIdRedirectRule "rule" CompatibleBuildIdRedirectRule where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedCompatibleBuildIdRedirectRule'rule
           (\ x__ y__
              -> x__ {_TimestampedCompatibleBuildIdRedirectRule'rule = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField TimestampedCompatibleBuildIdRedirectRule "maybe'rule" (Prelude.Maybe CompatibleBuildIdRedirectRule) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedCompatibleBuildIdRedirectRule'rule
           (\ x__ y__
              -> x__ {_TimestampedCompatibleBuildIdRedirectRule'rule = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField TimestampedCompatibleBuildIdRedirectRule "createTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedCompatibleBuildIdRedirectRule'createTime
           (\ x__ y__
              -> x__
                   {_TimestampedCompatibleBuildIdRedirectRule'createTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField TimestampedCompatibleBuildIdRedirectRule "maybe'createTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _TimestampedCompatibleBuildIdRedirectRule'createTime
           (\ x__ y__
              -> x__
                   {_TimestampedCompatibleBuildIdRedirectRule'createTime = y__}))
        Prelude.id
instance Data.ProtoLens.Message TimestampedCompatibleBuildIdRedirectRule where
  messageName _
    = Data.Text.pack
        "temporal.api.taskqueue.v1.TimestampedCompatibleBuildIdRedirectRule"
  packedMessageDescriptor _
    = "\n\
      \(TimestampedCompatibleBuildIdRedirectRule\DC2L\n\
      \\EOTrule\CAN\SOH \SOH(\v28.temporal.api.taskqueue.v1.CompatibleBuildIdRedirectRuleR\EOTrule\DC2;\n\
      \\vcreate_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \createTime"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        rule__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rule"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CompatibleBuildIdRedirectRule)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'rule")) ::
              Data.ProtoLens.FieldDescriptor TimestampedCompatibleBuildIdRedirectRule
        createTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "create_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'createTime")) ::
              Data.ProtoLens.FieldDescriptor TimestampedCompatibleBuildIdRedirectRule
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, rule__field_descriptor),
           (Data.ProtoLens.Tag 2, createTime__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _TimestampedCompatibleBuildIdRedirectRule'_unknownFields
        (\ x__ y__
           -> x__
                {_TimestampedCompatibleBuildIdRedirectRule'_unknownFields = y__})
  defMessage
    = TimestampedCompatibleBuildIdRedirectRule'_constructor
        {_TimestampedCompatibleBuildIdRedirectRule'rule = Prelude.Nothing,
         _TimestampedCompatibleBuildIdRedirectRule'createTime = Prelude.Nothing,
         _TimestampedCompatibleBuildIdRedirectRule'_unknownFields = []}
  parseMessage
    = let
        loop ::
          TimestampedCompatibleBuildIdRedirectRule
          -> Data.ProtoLens.Encoding.Bytes.Parser TimestampedCompatibleBuildIdRedirectRule
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
                                       "rule"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"rule") y x)
                        18
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
          (do loop Data.ProtoLens.defMessage)
          "TimestampedCompatibleBuildIdRedirectRule"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'rule") _x
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
                       (Data.ProtoLens.Field.field @"maybe'createTime") _x
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
instance Control.DeepSeq.NFData TimestampedCompatibleBuildIdRedirectRule where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_TimestampedCompatibleBuildIdRedirectRule'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_TimestampedCompatibleBuildIdRedirectRule'rule x__)
                (Control.DeepSeq.deepseq
                   (_TimestampedCompatibleBuildIdRedirectRule'createTime x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \'temporal/api/taskqueue/v1/message.proto\DC2\EMtemporal.api.taskqueue.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB\RSgoogle/protobuf/wrappers.proto\SUB&temporal/api/enums/v1/task_queue.proto\SUB$temporal/api/common/v1/message.proto\"z\n\
    \\tTaskQueue\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC28\n\
    \\EOTkind\CAN\STX \SOH(\SO2$.temporal.api.enums.v1.TaskQueueKindR\EOTkind\DC2\US\n\
    \\vnormal_name\CAN\ETX \SOH(\tR\n\
    \normalName\"b\n\
    \\DC1TaskQueueMetadata\DC2M\n\
    \\DC4max_tasks_per_second\CAN\SOH \SOH(\v2\FS.google.protobuf.DoubleValueR\DC1maxTasksPerSecond\"y\n\
    \\EMTaskQueueVersionSelection\DC2\ESC\n\
    \\tbuild_ids\CAN\SOH \ETX(\tR\bbuildIds\DC2 \n\
    \\vunversioned\CAN\STX \SOH(\bR\vunversioned\DC2\GS\n\
    \\n\
    \all_active\CAN\ETX \SOH(\bR\tallActive\"\190\STX\n\
    \\DC4TaskQueueVersionInfo\DC2]\n\
    \\n\
    \types_info\CAN\SOH \ETX(\v2>.temporal.api.taskqueue.v1.TaskQueueVersionInfo.TypesInfoEntryR\ttypesInfo\DC2[\n\
    \\DC1task_reachability\CAN\STX \SOH(\SO2..temporal.api.enums.v1.BuildIdTaskReachabilityR\DLEtaskReachability\SUBj\n\
    \\SOTypesInfoEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\ENQR\ETXkey\DC2B\n\
    \\ENQvalue\CAN\STX \SOH(\v2,.temporal.api.taskqueue.v1.TaskQueueTypeInfoR\ENQvalue:\STX8\SOH\"T\n\
    \\DC1TaskQueueTypeInfo\DC2?\n\
    \\apollers\CAN\SOH \ETX(\v2%.temporal.api.taskqueue.v1.PollerInfoR\apollers\"\239\SOH\n\
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
    \\SIowner_host_name\CAN\STX \SOH(\tR\rownerHostName\"\137\STX\n\
    \\n\
    \PollerInfo\DC2D\n\
    \\DLElast_access_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\SOlastAccessTime\DC2\SUB\n\
    \\bidentity\CAN\STX \SOH(\tR\bidentity\DC2&\n\
    \\SIrate_per_second\CAN\ETX \SOH(\SOHR\rratePerSecond\DC2q\n\
    \\ESCworker_version_capabilities\CAN\EOT \SOH(\v21.temporal.api.common.v1.WorkerVersionCapabilitiesR\EMworkerVersionCapabilities\"\195\SOH\n\
    \\EMStickyExecutionAttributes\DC2P\n\
    \\DC1worker_task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\SIworkerTaskQueue\DC2T\n\
    \\EMschedule_to_start_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToStartTimeout\"3\n\
    \\DC4CompatibleVersionSet\DC2\ESC\n\
    \\tbuild_ids\CAN\SOH \ETX(\tR\bbuildIds\"\131\SOH\n\
    \\NAKTaskQueueReachability\DC2\GS\n\
    \\n\
    \task_queue\CAN\SOH \SOH(\tR\ttaskQueue\DC2K\n\
    \\freachability\CAN\STX \ETX(\SO2'.temporal.api.enums.v1.TaskReachabilityR\freachability\"\154\SOH\n\
    \\DC3BuildIdReachability\DC2\EM\n\
    \\bbuild_id\CAN\SOH \SOH(\tR\abuildId\DC2h\n\
    \\ETBtask_queue_reachability\CAN\STX \ETX(\v20.temporal.api.taskqueue.v1.TaskQueueReachabilityR\NAKtaskQueueReachability\";\n\
    \\DLERampByPercentage\DC2'\n\
    \\SIramp_percentage\CAN\SOH \SOH(\STXR\SOrampPercentage\"\159\SOH\n\
    \\NAKBuildIdAssignmentRule\DC2&\n\
    \\SItarget_build_id\CAN\SOH \SOH(\tR\rtargetBuildId\DC2V\n\
    \\SIpercentage_ramp\CAN\ETX \SOH(\v2+.temporal.api.taskqueue.v1.RampByPercentageH\NULR\SOpercentageRampB\ACK\n\
    \\EOTramp\"o\n\
    \\GSCompatibleBuildIdRedirectRule\DC2&\n\
    \\SIsource_build_id\CAN\SOH \SOH(\tR\rsourceBuildId\DC2&\n\
    \\SItarget_build_id\CAN\STX \SOH(\tR\rtargetBuildId\"\165\SOH\n\
    \ TimestampedBuildIdAssignmentRule\DC2D\n\
    \\EOTrule\CAN\SOH \SOH(\v20.temporal.api.taskqueue.v1.BuildIdAssignmentRuleR\EOTrule\DC2;\n\
    \\vcreate_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \createTime\"\181\SOH\n\
    \(TimestampedCompatibleBuildIdRedirectRule\DC2L\n\
    \\EOTrule\CAN\SOH \SOH(\v28.temporal.api.taskqueue.v1.CompatibleBuildIdRedirectRuleR\EOTrule\DC2;\n\
    \\vcreate_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \createTimeB\152\SOH\n\
    \\FSio.temporal.api.taskqueue.v1B\fMessageProtoP\SOHZ)go.temporal.io/api/taskqueue/v1;taskqueue\170\STX\ESCTemporalio.Api.TaskQueue.V1\234\STX\RSTemporalio::Api::TaskQueue::V1J\237H\n\
    \\a\DC2\ENQ\SYN\NUL\228\SOH\SOH\n\
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
    \\STX\ETX\ETX\DC2\ETX%\NUL0\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX&\NUL.\n\
    \E\n\
    \\STX\EOT\NUL\DC2\EOT)\NUL0\SOH\SUB9 See https://docs.temporal.io/docs/concepts/task-queues/\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX)\b\DC1\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX*\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX*\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX*\v\SI\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX*\DC2\DC3\n\
    \/\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX,\EOT1\SUB\" Default: TASK_QUEUE_KIND_NORMAL.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX,\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX,(,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX,/0\n\
    \\149\SOH\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX/\EOT\ESC\SUB\135\SOH Iff kind == TASK_QUEUE_KIND_STICKY, then this field contains the name of\n\
    \ the normal task queue that the sticky worker is running on.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX/\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX/\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX/\EM\SUB\n\
    \2\n\
    \\STX\EOT\SOH\DC2\EOT3\NUL6\SOH\SUB& Only applies to activity task queues\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX3\b\EM\n\
    \B\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX5\EOT9\SUB5 Allows throttling dispatch of tasks from this queue\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX5\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX5 4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX578\n\
    \G\n\
    \\STX\EOT\STX\DC2\EOT9\NULA\SOH\SUB; Used for specifying versions the caller is interested in.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX9\b!\n\
    \*\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX;\EOT\"\SUB\GS Include specific Build IDs.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\EOT\DC2\ETX;\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX;\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX;\DC4\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX; !\n\
    \-\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX=\EOT\EM\SUB  Include the unversioned queue.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX=\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX=\t\DC4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX=\ETB\CAN\n\
    \v\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETX@\EOT\CAN\SUBi Include all active versions. A version is considered active if it has had new\n\
    \ tasks or polls recently.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ENQ\DC2\ETX@\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETX@\t\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETX@\SYN\ETB\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOTC\NULG\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXC\b\FS\n\
    \y\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXE\EOT1\SUBl Task Queue info per Task Type. Key is the numerical value of the temporal.api.enums.v1.TaskQueueType enum.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ACK\DC2\ETXE\EOT!\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXE\",\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXE/0\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXF\EOTH\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ACK\DC2\ETXF\EOT1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXF2C\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXFFG\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOTI\NULL\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXI\b\EM\n\
    \\DEL\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXK\EOT$\SUBr Unversioned workers (with `useVersioning=false`) are reported in unversioned result even if they set a Build ID.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\EOT\DC2\ETXK\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETXK\r\ETB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXK\CAN\US\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXK\"#\n\
    \y\n\
    \\STX\EOT\ENQ\DC2\EOTO\NULU\SOH\SUBm Deprecated. Use `InternalTaskQueueStatus`. This is kept until `DescribeTaskQueue` supports legacy behavior.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXO\b\ETB\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXP\EOT!\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\ETXP\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXP\n\
    \\FS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXP\US \n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETXQ\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ENQ\DC2\ETXQ\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETXQ\n\
    \\DC4\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETXQ\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\ETXR\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ENQ\DC2\ETXR\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\ETXR\n\
    \\DC3\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\ETXR\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\ETX\DC2\ETXS\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ENQ\DC2\ETXS\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\SOH\DC2\ETXS\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ETX\DC2\ETXS\GS\RS\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\EOT\DC2\ETXT\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\EOT\ACK\DC2\ETXT\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\EOT\SOH\DC2\ETXT\DLE\GS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\EOT\ETX\DC2\ETXT !\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOTW\NULZ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXW\b\DC3\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXX\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXX\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXX\n\
    \\DC2\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXX\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXY\EOT\NAK\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXY\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXY\n\
    \\DLE\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXY\DC3\DC4\n\
    \\n\
    \\n\
    \\STX\EOT\a\DC2\EOT\\\NUL_\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETX\\\b\"\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETX]\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETX]\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETX]\v\SO\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETX]\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\a\STX\SOH\DC2\ETX^\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ENQ\DC2\ETX^\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\ETX^\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\ETX^\GS\RS\n\
    \\n\
    \\n\
    \\STX\EOT\b\DC2\EOTa\NULh\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXa\b\DC2\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETXb\EOT3\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ACK\DC2\ETXb\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETXb\RS.\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETXb12\n\
    \\v\n\
    \\EOT\EOT\b\STX\SOH\DC2\ETXc\EOT\CAN\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ENQ\DC2\ETXc\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\ETXc\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\ETXc\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\b\STX\STX\DC2\ETXd\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\ENQ\DC2\ETXd\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\SOH\DC2\ETXd\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\ETX\DC2\ETXd\GS\RS\n\
    \z\n\
    \\EOT\EOT\b\STX\ETX\DC2\ETXg\EOTU\SUBm If a worker has opted into the worker versioning feature while polling, its capabilities will\n\
    \ appear here.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\ETX\ACK\DC2\ETXg\EOT4\n\
    \\f\n\
    \\ENQ\EOT\b\STX\ETX\SOH\DC2\ETXg5P\n\
    \\f\n\
    \\ENQ\EOT\b\STX\ETX\ETX\DC2\ETXgST\n\
    \\n\
    \\n\
    \\STX\EOT\t\DC2\EOTj\NULo\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETXj\b!\n\
    \\v\n\
    \\EOT\EOT\t\STX\NUL\DC2\ETXk\EOT$\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ACK\DC2\ETXk\EOT\r\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\ETXk\SO\US\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\ETXk\"#\n\
    \\131\SOH\n\
    \\EOT\EOT\t\STX\SOH\DC2\ETXn\EOT;\SUBv (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: \"to\" is used to indicate interval. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ACK\DC2\ETXn\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\ETXn\GS6\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\ETXn9:\n\
    \\210\SOH\n\
    \\STX\EOT\n\
    \\DC2\EOTs\NULv\SOH\SUB\197\SOH Used by the worker versioning APIs, represents an unordered set of one or more versions which are\n\
    \ considered to be compatible with each other. Currently the versions are always worker build IDs.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETXs\b\FS\n\
    \z\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETXu\EOT\"\SUBm All the compatible versions, unordered, except for the last element, which is considered the set \"default\".\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\EOT\DC2\ETXu\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETXu\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETXu\DC4\GS\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETXu !\n\
    \H\n\
    \\STX\EOT\v\DC2\EOTy\NUL\DEL\SOH\SUB< Reachability of tasks for a worker on a single task queue.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETXy\b\GS\n\
    \\v\n\
    \\EOT\EOT\v\STX\NUL\DC2\ETXz\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ENQ\DC2\ETXz\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\ETXz\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\ETXz\CAN\EM\n\
    \\232\SOH\n\
    \\EOT\EOT\v\STX\SOH\DC2\ETX~\EOTE\SUB\218\SOH Task reachability for a worker in a single task queue.\n\
    \ See the TaskReachability docstring for information about each enum variant.\n\
    \ If reachability is empty, this worker is considered unreachable in this task queue.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\EOT\DC2\ETX~\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ACK\DC2\ETX~\r3\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\ETX~4@\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\ETX~CD\n\
    \[\n\
    \\STX\EOT\f\DC2\ACK\130\SOH\NUL\135\SOH\SOH\SUBM Reachability of tasks for a worker by build id, in one or more task queues.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\f\SOH\DC2\EOT\130\SOH\b\ESC\n\
    \3\n\
    \\EOT\EOT\f\STX\NUL\DC2\EOT\132\SOH\EOT\CAN\SUB% A build id or empty if unversioned.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ENQ\DC2\EOT\132\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\EOT\132\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\EOT\132\SOH\SYN\ETB\n\
    \,\n\
    \\EOT\EOT\f\STX\SOH\DC2\EOT\134\SOH\EOT?\SUB\RS Reachability per task queue.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\EOT\DC2\EOT\134\SOH\EOT\f\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ACK\DC2\EOT\134\SOH\r\"\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\EOT\134\SOH#:\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\EOT\134\SOH=>\n\
    \\f\n\
    \\STX\EOT\r\DC2\ACK\137\SOH\NUL\140\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\r\SOH\DC2\EOT\137\SOH\b\CAN\n\
    \,\n\
    \\EOT\EOT\r\STX\NUL\DC2\EOT\139\SOH\EOT\RS\SUB\RS Acceptable range is [0,100).\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ENQ\DC2\EOT\139\SOH\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\EOT\139\SOH\n\
    \\EM\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\EOT\139\SOH\FS\GS\n\
    \\216\SI\n\
    \\STX\EOT\SO\DC2\ACK\179\SOH\NUL\192\SOH\SOH\SUB\201\SI These rules assign a Build ID to Unassigned Workflow Executions and\n\
    \ Activities.\n\
    \\n\
    \ Specifically, assignment rules are applied to the following Executions or\n\
    \ Activities when they are scheduled in a Task Queue:\n\
    \    - Generally, any new Workflow Execution, except:\n\
    \      - When A Child Workflow or a Continue-As-New Execution inherits the\n\
    \        Build ID from its parent/previous execution by setting the\n\
    \        `inherit_build_id` flag.\n\
    \      - Workflow Executions started Eagerly are assigned to the Build ID of\n\
    \        the Starter.\n\
    \    - An Activity that is scheduled on a Task Queue different from the one\n\
    \      their Workflow runs on, unless the `use_workflow_build_id` flag is set.\n\
    \\n\
    \ In absence of (applicable) redirect rules (`CompatibleBuildIdRedirectRule`s)\n\
    \ the task will be dispatched to Workers of the Build ID determined by the\n\
    \ assignment rules. Otherwise, the final Build ID will be determined by the\n\
    \ redirect rules.\n\
    \\n\
    \ When using Worker Versioning, in the steady state, for a given Task Queue,\n\
    \ there should typically be exactly one assignment rule to send all Unassigned\n\
    \ tasks to the latest Build ID. Existence of at least one such \"unconditional\"\n\
    \ rule at all times is enforce by the system, unless the `force` flag is used\n\
    \ by the user when replacing/deleting these rules (for exceptional cases).\n\
    \\n\
    \ During a deployment, one or more additional rules can be added to assign a\n\
    \ subset of the tasks to a new Build ID based on a \"ramp percentage\".\n\
    \\n\
    \ When there are multiple assignment rules for a Task Queue, the rules are\n\
    \ evaluated in order, starting from index 0. The first applicable rule will be\n\
    \ applied and the rest will be ignored.\n\
    \\n\
    \ In the event that no assignment rule is applicable on a task (or the Task\n\
    \ Queue is simply not versioned), the tasks will be sent to unversioned\n\
    \ workers, if available. Otherwise, they remain Unassigned, and will be\n\
    \ retried for assignment, or dispatch to unversioned workers, at a later time\n\
    \ depending on the availability of workers.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\SO\SOH\DC2\EOT\179\SOH\b\GS\n\
    \\f\n\
    \\EOT\EOT\SO\STX\NUL\DC2\EOT\180\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ENQ\DC2\EOT\180\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\EOT\180\SOH\v\SUB\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\EOT\180\SOH\GS\RS\n\
    \\240\SOH\n\
    \\EOT\EOT\SO\b\NUL\DC2\ACK\186\SOH\EOT\191\SOH\ENQ\SUB\223\SOH If a ramp is provided, this rule will be applied only to a sample of\n\
    \ tasks according to the provided percentage.\n\
    \ This option can be used only on \"terminal\" Build IDs (the ones not used\n\
    \ as source in any redirect rules).\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\b\NUL\SOH\DC2\EOT\186\SOH\n\
    \\SO\n\
    \\167\SOH\n\
    \\EOT\EOT\SO\STX\SOH\DC2\EOT\190\SOH\b-\SUB\152\SOH This ramp is useful for gradual Blue/Green deployments (and similar)\n\
    \ where you want to send a certain portion of the traffic to the target\n\
    \ Build ID.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\ACK\DC2\EOT\190\SOH\b\CAN\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\SOH\DC2\EOT\190\SOH\EM(\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\ETX\DC2\EOT\190\SOH+,\n\
    \\198\a\n\
    \\STX\EOT\SI\DC2\ACK\215\SOH\NUL\218\SOH\SOH\SUB\183\a These rules apply to tasks assigned to a particular Build ID\n\
    \ (`source_build_id`) to redirect them to another *compatible* Build ID\n\
    \ (`target_build_id`).\n\
    \\n\
    \ It is user's responsibility to ensure that the target Build ID is compatible\n\
    \ with the source Build ID (e.g. by using the Patching API).\n\
    \\n\
    \ Most deployments are not expected to need these rules, however following\n\
    \ situations can greatly benefit from redirects:\n\
    \  - Need to move long-running Workflow Executions from an old Build ID to a\n\
    \    newer one.\n\
    \  - Need to hotfix some broken or stuck Workflow Executions.\n\
    \\n\
    \ In steady state, redirect rules are beneficial when dealing with old\n\
    \ Executions ran on now-decommissioned Build IDs:\n\
    \  - To redirecting the Workflow Queries to the current (compatible) Build ID.\n\
    \  - To be able to Reset an old Execution so it can run on the current\n\
    \    (compatible) Build ID.\n\
    \\n\
    \ Redirect rules can be chained, but only the last rule in the chain can have\n\
    \ a ramp.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\SI\SOH\DC2\EOT\215\SOH\b%\n\
    \\f\n\
    \\EOT\EOT\SI\STX\NUL\DC2\EOT\216\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ENQ\DC2\EOT\216\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\SOH\DC2\EOT\216\SOH\v\SUB\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ETX\DC2\EOT\216\SOH\GS\RS\n\
    \\f\n\
    \\EOT\EOT\SI\STX\SOH\DC2\EOT\217\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ENQ\DC2\EOT\217\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\SOH\DC2\EOT\217\SOH\v\SUB\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ETX\DC2\EOT\217\SOH\GS\RS\n\
    \\f\n\
    \\STX\EOT\DLE\DC2\ACK\220\SOH\NUL\223\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DLE\SOH\DC2\EOT\220\SOH\b(\n\
    \\f\n\
    \\EOT\EOT\DLE\STX\NUL\DC2\EOT\221\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ACK\DC2\EOT\221\SOH\EOT\EM\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\SOH\DC2\EOT\221\SOH\SUB\RS\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ETX\DC2\EOT\221\SOH!\"\n\
    \\f\n\
    \\EOT\EOT\DLE\STX\SOH\DC2\EOT\222\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\ACK\DC2\EOT\222\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\SOH\DC2\EOT\222\SOH\RS)\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\ETX\DC2\EOT\222\SOH,-\n\
    \\f\n\
    \\STX\EOT\DC1\DC2\ACK\225\SOH\NUL\228\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DC1\SOH\DC2\EOT\225\SOH\b0\n\
    \\f\n\
    \\EOT\EOT\DC1\STX\NUL\DC2\EOT\226\SOH\EOT+\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ACK\DC2\EOT\226\SOH\EOT!\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\SOH\DC2\EOT\226\SOH\"&\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ETX\DC2\EOT\226\SOH)*\n\
    \\f\n\
    \\EOT\EOT\DC1\STX\SOH\DC2\EOT\227\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\ACK\DC2\EOT\227\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\SOH\DC2\EOT\227\SOH\RS)\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\ETX\DC2\EOT\227\SOH,-b\ACKproto3"

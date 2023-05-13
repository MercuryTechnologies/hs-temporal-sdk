{- This file was auto-generated from temporal/sdk/core/core_interface.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Sdk.Core.CoreInterface (
        ActivityHeartbeat(), ActivityTaskCompletion()
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult
import qualified Proto.Temporal.Sdk.Core.ActivityTask.ActivityTask
import qualified Proto.Temporal.Sdk.Core.Common.Common
import qualified Proto.Temporal.Sdk.Core.ExternalData.ExternalData
import qualified Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation
import qualified Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands
import qualified Proto.Temporal.Sdk.Core.WorkflowCompletion.WorkflowCompletion
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.CoreInterface_Fields.taskToken' @:: Lens' ActivityHeartbeat Data.ByteString.ByteString@
         * 'Proto.Temporal.Sdk.Core.CoreInterface_Fields.details' @:: Lens' ActivityHeartbeat [Proto.Temporal.Api.Common.V1.Message.Payload]@
         * 'Proto.Temporal.Sdk.Core.CoreInterface_Fields.vec'details' @:: Lens' ActivityHeartbeat (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data ActivityHeartbeat
  = ActivityHeartbeat'_constructor {_ActivityHeartbeat'taskToken :: !Data.ByteString.ByteString,
                                    _ActivityHeartbeat'details :: !(Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload),
                                    _ActivityHeartbeat'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ActivityHeartbeat where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ActivityHeartbeat "taskToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityHeartbeat'taskToken
           (\ x__ y__ -> x__ {_ActivityHeartbeat'taskToken = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityHeartbeat "details" [Proto.Temporal.Api.Common.V1.Message.Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityHeartbeat'details
           (\ x__ y__ -> x__ {_ActivityHeartbeat'details = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ActivityHeartbeat "vec'details" (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityHeartbeat'details
           (\ x__ y__ -> x__ {_ActivityHeartbeat'details = y__}))
        Prelude.id
instance Data.ProtoLens.Message ActivityHeartbeat where
  messageName _ = Data.Text.pack "coresdk.ActivityHeartbeat"
  packedMessageDescriptor _
    = "\n\
      \\DC1ActivityHeartbeat\DC2\GS\n\
      \\n\
      \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC29\n\
      \\adetails\CAN\STX \ETX(\v2\US.temporal.api.common.v1.PayloadR\adetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        taskToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskToken")) ::
              Data.ProtoLens.FieldDescriptor ActivityHeartbeat
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"details")) ::
              Data.ProtoLens.FieldDescriptor ActivityHeartbeat
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskToken__field_descriptor),
           (Data.ProtoLens.Tag 2, details__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ActivityHeartbeat'_unknownFields
        (\ x__ y__ -> x__ {_ActivityHeartbeat'_unknownFields = y__})
  defMessage
    = ActivityHeartbeat'_constructor
        {_ActivityHeartbeat'taskToken = Data.ProtoLens.fieldDefault,
         _ActivityHeartbeat'details = Data.Vector.Generic.empty,
         _ActivityHeartbeat'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ActivityHeartbeat
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Common.V1.Message.Payload
             -> Data.ProtoLens.Encoding.Bytes.Parser ActivityHeartbeat
        loop x mutable'details
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'details <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'details)
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
                              (Data.ProtoLens.Field.field @"vec'details") frozen'details x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "task_token"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskToken") y x)
                                  mutable'details
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "details"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'details y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'details
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'details <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'details)
          "ActivityHeartbeat"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"taskToken") _x
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
                   (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'details") _x))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData ActivityHeartbeat where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ActivityHeartbeat'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ActivityHeartbeat'taskToken x__)
                (Control.DeepSeq.deepseq (_ActivityHeartbeat'details x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.CoreInterface_Fields.taskToken' @:: Lens' ActivityTaskCompletion Data.ByteString.ByteString@
         * 'Proto.Temporal.Sdk.Core.CoreInterface_Fields.result' @:: Lens' ActivityTaskCompletion Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityExecutionResult@
         * 'Proto.Temporal.Sdk.Core.CoreInterface_Fields.maybe'result' @:: Lens' ActivityTaskCompletion (Prelude.Maybe Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityExecutionResult)@ -}
data ActivityTaskCompletion
  = ActivityTaskCompletion'_constructor {_ActivityTaskCompletion'taskToken :: !Data.ByteString.ByteString,
                                         _ActivityTaskCompletion'result :: !(Prelude.Maybe Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityExecutionResult),
                                         _ActivityTaskCompletion'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ActivityTaskCompletion where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ActivityTaskCompletion "taskToken" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTaskCompletion'taskToken
           (\ x__ y__ -> x__ {_ActivityTaskCompletion'taskToken = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ActivityTaskCompletion "result" Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityExecutionResult where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTaskCompletion'result
           (\ x__ y__ -> x__ {_ActivityTaskCompletion'result = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ActivityTaskCompletion "maybe'result" (Prelude.Maybe Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityExecutionResult) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ActivityTaskCompletion'result
           (\ x__ y__ -> x__ {_ActivityTaskCompletion'result = y__}))
        Prelude.id
instance Data.ProtoLens.Message ActivityTaskCompletion where
  messageName _ = Data.Text.pack "coresdk.ActivityTaskCompletion"
  packedMessageDescriptor _
    = "\n\
      \\SYNActivityTaskCompletion\DC2\GS\n\
      \\n\
      \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC2H\n\
      \\ACKresult\CAN\STX \SOH(\v20.coresdk.activity_result.ActivityExecutionResultR\ACKresult"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        taskToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskToken")) ::
              Data.ProtoLens.FieldDescriptor ActivityTaskCompletion
        result__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "result"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityExecutionResult)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'result")) ::
              Data.ProtoLens.FieldDescriptor ActivityTaskCompletion
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskToken__field_descriptor),
           (Data.ProtoLens.Tag 2, result__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ActivityTaskCompletion'_unknownFields
        (\ x__ y__ -> x__ {_ActivityTaskCompletion'_unknownFields = y__})
  defMessage
    = ActivityTaskCompletion'_constructor
        {_ActivityTaskCompletion'taskToken = Data.ProtoLens.fieldDefault,
         _ActivityTaskCompletion'result = Prelude.Nothing,
         _ActivityTaskCompletion'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ActivityTaskCompletion
          -> Data.ProtoLens.Encoding.Bytes.Parser ActivityTaskCompletion
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
                                       "task_token"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskToken") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "result"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"result") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ActivityTaskCompletion"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"taskToken") _x
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
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'result") _x
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
instance Control.DeepSeq.NFData ActivityTaskCompletion where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ActivityTaskCompletion'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ActivityTaskCompletion'taskToken x__)
                (Control.DeepSeq.deepseq (_ActivityTaskCompletion'result x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \&temporal/sdk/core/core_interface.proto\DC2\acoresdk\SUB\RSgoogle/protobuf/duration.proto\SUB\ESCgoogle/protobuf/empty.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB$temporal/api/common/v1/message.proto\SUB7temporal/sdk/core/activity_result/activity_result.proto\SUB3temporal/sdk/core/activity_task/activity_task.proto\SUB%temporal/sdk/core/common/common.proto\SUB3temporal/sdk/core/external_data/external_data.proto\SUB?temporal/sdk/core/workflow_activation/workflow_activation.proto\SUB;temporal/sdk/core/workflow_commands/workflow_commands.proto\SUB?temporal/sdk/core/workflow_completion/workflow_completion.proto\"m\n\
    \\DC1ActivityHeartbeat\DC2\GS\n\
    \\n\
    \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC29\n\
    \\adetails\CAN\STX \ETX(\v2\US.temporal.api.common.v1.PayloadR\adetails\"\129\SOH\n\
    \\SYNActivityTaskCompletion\DC2\GS\n\
    \\n\
    \task_token\CAN\SOH \SOH(\fR\ttaskToken\DC2H\n\
    \\ACKresult\CAN\STX \SOH(\v20.coresdk.activity_result.ActivityExecutionResultR\ACKresultB)\234\STX&Temporalio::Bridge::Api::CoreInterfaceJ\165\ACK\n\
    \\ACK\DC2\EOT\NUL\NUL\RS\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL\DLE\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ETX\NUL?\n\
    \\t\n\
    \\STX\b-\DC2\ETX\ETX\NUL?\n\
    \\130\STX\n\
    \\STX\ETX\NUL\DC2\ETX\b\NUL(\SUB\246\SOH Note: Intellij will think the Google imports don't work because of the slightly odd nature of\n\
    \ the include paths. You can make it work by going to the \"Protobuf Support\" settings section\n\
    \ and adding the \"api_upstream\" subdir as an include path.\n\
    \\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\t\NUL%\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX\n\
    \\NUL)\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX\v\NUL.\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX\f\NULA\n\
    \\t\n\
    \\STX\ETX\ENQ\DC2\ETX\r\NUL=\n\
    \\t\n\
    \\STX\ETX\ACK\DC2\ETX\SO\NUL/\n\
    \\t\n\
    \\STX\ETX\a\DC2\ETX\SI\NUL=\n\
    \\t\n\
    \\STX\ETX\b\DC2\ETX\DLE\NULI\n\
    \\t\n\
    \\STX\ETX\t\DC2\ETX\DC1\NULE\n\
    \\t\n\
    \\STX\ETX\n\
    \\DC2\ETX\DC2\NULI\n\
    \?\n\
    \\STX\EOT\NUL\DC2\EOT\NAK\NUL\CAN\SOH\SUB3 A request as given to `record_activity_heartbeat`\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\NAK\b\EM\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\SYN\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\SYN\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\SYN\n\
    \\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\SYN\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\ETB\EOT8\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\EOT\DC2\ETX\ETB\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX\ETB\r+\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\ETB,3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\ETB67\n\
    \<\n\
    \\STX\EOT\SOH\DC2\EOT\ESC\NUL\RS\SOH\SUB0 A request as given to `complete_activity_task`\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\ESC\b\RS\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\FS\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\FS\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\FS\n\
    \\DC4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\FS\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\GS\EOT7\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX\GS\EOT+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\GS,2\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\GS56b\ACKproto3"
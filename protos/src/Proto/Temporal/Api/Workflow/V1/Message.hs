{- This file was auto-generated from temporal/api/workflow/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Workflow.V1.Message (
        CallbackInfo(), CallbackInfo'Trigger(),
        CallbackInfo'Trigger'Variant(..),
        _CallbackInfo'Trigger'WorkflowClosed,
        CallbackInfo'WorkflowClosed(), DeploymentTransition(),
        DeploymentVersionTransition(), NewWorkflowExecutionInfo(),
        NexusOperationCancellationInfo(), OnConflictOptions(),
        PendingActivityInfo(), PendingActivityInfo'AssignedBuildId(..),
        _PendingActivityInfo'UseWorkflowBuildId,
        _PendingActivityInfo'LastIndependentlyAssignedBuildId,
        PendingActivityInfo'PauseInfo(),
        PendingActivityInfo'PauseInfo'PausedBy(..),
        _PendingActivityInfo'PauseInfo'Manual',
        _PendingActivityInfo'PauseInfo'RuleId,
        PendingActivityInfo'PauseInfo'Manual(),
        PendingChildExecutionInfo(), PendingNexusOperationInfo(),
        PendingWorkflowTaskInfo(), ResetPointInfo(), ResetPoints(),
        VersioningOverride(), WorkflowExecutionConfig(),
        WorkflowExecutionExtendedInfo(), WorkflowExecutionInfo(),
        WorkflowExecutionOptions(), WorkflowExecutionVersioningInfo()
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
import qualified Proto.Temporal.Api.Deployment.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Common
import qualified Proto.Temporal.Api.Enums.V1.Workflow
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Api.Sdk.V1.UserMetadata
import qualified Proto.Temporal.Api.Taskqueue.V1.Message
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.callback' @:: Lens' CallbackInfo Proto.Temporal.Api.Common.V1.Message.Callback@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'callback' @:: Lens' CallbackInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Callback)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.trigger' @:: Lens' CallbackInfo CallbackInfo'Trigger@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'trigger' @:: Lens' CallbackInfo (Prelude.Maybe CallbackInfo'Trigger)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.registrationTime' @:: Lens' CallbackInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'registrationTime' @:: Lens' CallbackInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.state' @:: Lens' CallbackInfo Proto.Temporal.Api.Enums.V1.Common.CallbackState@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attempt' @:: Lens' CallbackInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastAttemptCompleteTime' @:: Lens' CallbackInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastAttemptCompleteTime' @:: Lens' CallbackInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastAttemptFailure' @:: Lens' CallbackInfo Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastAttemptFailure' @:: Lens' CallbackInfo (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.nextAttemptScheduleTime' @:: Lens' CallbackInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'nextAttemptScheduleTime' @:: Lens' CallbackInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.blockedReason' @:: Lens' CallbackInfo Data.Text.Text@ -}
data CallbackInfo
  = CallbackInfo'_constructor {_CallbackInfo'callback :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Callback),
                               _CallbackInfo'trigger :: !(Prelude.Maybe CallbackInfo'Trigger),
                               _CallbackInfo'registrationTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                               _CallbackInfo'state :: !Proto.Temporal.Api.Enums.V1.Common.CallbackState,
                               _CallbackInfo'attempt :: !Data.Int.Int32,
                               _CallbackInfo'lastAttemptCompleteTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                               _CallbackInfo'lastAttemptFailure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                               _CallbackInfo'nextAttemptScheduleTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                               _CallbackInfo'blockedReason :: !Data.Text.Text,
                               _CallbackInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CallbackInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CallbackInfo "callback" Proto.Temporal.Api.Common.V1.Message.Callback where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'callback
           (\ x__ y__ -> x__ {_CallbackInfo'callback = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CallbackInfo "maybe'callback" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Callback) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'callback
           (\ x__ y__ -> x__ {_CallbackInfo'callback = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "trigger" CallbackInfo'Trigger where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'trigger
           (\ x__ y__ -> x__ {_CallbackInfo'trigger = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CallbackInfo "maybe'trigger" (Prelude.Maybe CallbackInfo'Trigger) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'trigger
           (\ x__ y__ -> x__ {_CallbackInfo'trigger = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "registrationTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'registrationTime
           (\ x__ y__ -> x__ {_CallbackInfo'registrationTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CallbackInfo "maybe'registrationTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'registrationTime
           (\ x__ y__ -> x__ {_CallbackInfo'registrationTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "state" Proto.Temporal.Api.Enums.V1.Common.CallbackState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'state (\ x__ y__ -> x__ {_CallbackInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "attempt" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'attempt
           (\ x__ y__ -> x__ {_CallbackInfo'attempt = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "lastAttemptCompleteTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'lastAttemptCompleteTime
           (\ x__ y__ -> x__ {_CallbackInfo'lastAttemptCompleteTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CallbackInfo "maybe'lastAttemptCompleteTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'lastAttemptCompleteTime
           (\ x__ y__ -> x__ {_CallbackInfo'lastAttemptCompleteTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "lastAttemptFailure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'lastAttemptFailure
           (\ x__ y__ -> x__ {_CallbackInfo'lastAttemptFailure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CallbackInfo "maybe'lastAttemptFailure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'lastAttemptFailure
           (\ x__ y__ -> x__ {_CallbackInfo'lastAttemptFailure = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "nextAttemptScheduleTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'nextAttemptScheduleTime
           (\ x__ y__ -> x__ {_CallbackInfo'nextAttemptScheduleTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField CallbackInfo "maybe'nextAttemptScheduleTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'nextAttemptScheduleTime
           (\ x__ y__ -> x__ {_CallbackInfo'nextAttemptScheduleTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo "blockedReason" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'blockedReason
           (\ x__ y__ -> x__ {_CallbackInfo'blockedReason = y__}))
        Prelude.id
instance Data.ProtoLens.Message CallbackInfo where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.CallbackInfo"
  packedMessageDescriptor _
    = "\n\
      \\fCallbackInfo\DC2<\n\
      \\bcallback\CAN\SOH \SOH(\v2 .temporal.api.common.v1.CallbackR\bcallback\DC2H\n\
      \\atrigger\CAN\STX \SOH(\v2..temporal.api.workflow.v1.CallbackInfo.TriggerR\atrigger\DC2G\n\
      \\DC1registration_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\DLEregistrationTime\DC2:\n\
      \\ENQstate\CAN\EOT \SOH(\SO2$.temporal.api.enums.v1.CallbackStateR\ENQstate\DC2\CAN\n\
      \\aattempt\CAN\ENQ \SOH(\ENQR\aattempt\DC2W\n\
      \\SUBlast_attempt_complete_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2R\n\
      \\DC4last_attempt_failure\CAN\a \SOH(\v2 .temporal.api.failure.v1.FailureR\DC2lastAttemptFailure\DC2W\n\
      \\SUBnext_attempt_schedule_time\CAN\b \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2%\n\
      \\SOblocked_reason\CAN\t \SOH(\tR\rblockedReason\SUB\DLE\n\
      \\SOWorkflowClosed\SUBv\n\
      \\aTrigger\DC2`\n\
      \\SIworkflow_closed\CAN\SOH \SOH(\v25.temporal.api.workflow.v1.CallbackInfo.WorkflowClosedH\NULR\SOworkflowClosedB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        callback__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "callback"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Callback)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'callback")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        trigger__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "trigger"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CallbackInfo'Trigger)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'trigger")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        registrationTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "registration_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'registrationTime")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.CallbackState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        attempt__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attempt"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"attempt")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        lastAttemptCompleteTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_attempt_complete_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAttemptCompleteTime")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        lastAttemptFailure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_attempt_failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAttemptFailure")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        nextAttemptScheduleTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_attempt_schedule_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'nextAttemptScheduleTime")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
        blockedReason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "blocked_reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"blockedReason")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, callback__field_descriptor),
           (Data.ProtoLens.Tag 2, trigger__field_descriptor),
           (Data.ProtoLens.Tag 3, registrationTime__field_descriptor),
           (Data.ProtoLens.Tag 4, state__field_descriptor),
           (Data.ProtoLens.Tag 5, attempt__field_descriptor),
           (Data.ProtoLens.Tag 6, lastAttemptCompleteTime__field_descriptor),
           (Data.ProtoLens.Tag 7, lastAttemptFailure__field_descriptor),
           (Data.ProtoLens.Tag 8, nextAttemptScheduleTime__field_descriptor),
           (Data.ProtoLens.Tag 9, blockedReason__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CallbackInfo'_unknownFields
        (\ x__ y__ -> x__ {_CallbackInfo'_unknownFields = y__})
  defMessage
    = CallbackInfo'_constructor
        {_CallbackInfo'callback = Prelude.Nothing,
         _CallbackInfo'trigger = Prelude.Nothing,
         _CallbackInfo'registrationTime = Prelude.Nothing,
         _CallbackInfo'state = Data.ProtoLens.fieldDefault,
         _CallbackInfo'attempt = Data.ProtoLens.fieldDefault,
         _CallbackInfo'lastAttemptCompleteTime = Prelude.Nothing,
         _CallbackInfo'lastAttemptFailure = Prelude.Nothing,
         _CallbackInfo'nextAttemptScheduleTime = Prelude.Nothing,
         _CallbackInfo'blockedReason = Data.ProtoLens.fieldDefault,
         _CallbackInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CallbackInfo -> Data.ProtoLens.Encoding.Bytes.Parser CallbackInfo
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
                                       "callback"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"callback") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "trigger"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"trigger") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "registration_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"registrationTime") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attempt"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"attempt") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_attempt_complete_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAttemptCompleteTime") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_attempt_failure"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAttemptFailure") y x)
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "next_attempt_schedule_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nextAttemptScheduleTime") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "blocked_reason"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"blockedReason") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CallbackInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'callback") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'trigger") _x
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
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'registrationTime") _x
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
                      ((Data.Monoid.<>)
                         (let
                            _v = Lens.Family2.view (Data.ProtoLens.Field.field @"attempt") _x
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
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'lastAttemptCompleteTime") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (case
                                    Lens.Family2.view
                                      (Data.ProtoLens.Field.field @"maybe'lastAttemptFailure") _x
                                of
                                  Prelude.Nothing -> Data.Monoid.mempty
                                  (Prelude.Just _v)
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                                         ((Prelude..)
                                            (\ bs
                                               -> (Data.Monoid.<>)
                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                       (Prelude.fromIntegral
                                                          (Data.ByteString.length bs)))
                                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                            Data.ProtoLens.encodeMessage _v))
                               ((Data.Monoid.<>)
                                  (case
                                       Lens.Family2.view
                                         (Data.ProtoLens.Field.field
                                            @"maybe'nextAttemptScheduleTime")
                                         _x
                                   of
                                     Prelude.Nothing -> Data.Monoid.mempty
                                     (Prelude.Just _v)
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt 66)
                                            ((Prelude..)
                                               (\ bs
                                                  -> (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          (Prelude.fromIntegral
                                                             (Data.ByteString.length bs)))
                                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                               Data.ProtoLens.encodeMessage _v))
                                  ((Data.Monoid.<>)
                                     (let
                                        _v
                                          = Lens.Family2.view
                                              (Data.ProtoLens.Field.field @"blockedReason") _x
                                      in
                                        if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                            Data.Monoid.mempty
                                        else
                                            (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                              ((Prelude..)
                                                 (\ bs
                                                    -> (Data.Monoid.<>)
                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                            (Prelude.fromIntegral
                                                               (Data.ByteString.length bs)))
                                                         (Data.ProtoLens.Encoding.Bytes.putBytes
                                                            bs))
                                                 Data.Text.Encoding.encodeUtf8 _v))
                                     (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                        (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))))
instance Control.DeepSeq.NFData CallbackInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CallbackInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CallbackInfo'callback x__)
                (Control.DeepSeq.deepseq
                   (_CallbackInfo'trigger x__)
                   (Control.DeepSeq.deepseq
                      (_CallbackInfo'registrationTime x__)
                      (Control.DeepSeq.deepseq
                         (_CallbackInfo'state x__)
                         (Control.DeepSeq.deepseq
                            (_CallbackInfo'attempt x__)
                            (Control.DeepSeq.deepseq
                               (_CallbackInfo'lastAttemptCompleteTime x__)
                               (Control.DeepSeq.deepseq
                                  (_CallbackInfo'lastAttemptFailure x__)
                                  (Control.DeepSeq.deepseq
                                     (_CallbackInfo'nextAttemptScheduleTime x__)
                                     (Control.DeepSeq.deepseq
                                        (_CallbackInfo'blockedReason x__) ())))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'variant' @:: Lens' CallbackInfo'Trigger (Prelude.Maybe CallbackInfo'Trigger'Variant)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowClosed' @:: Lens' CallbackInfo'Trigger (Prelude.Maybe CallbackInfo'WorkflowClosed)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowClosed' @:: Lens' CallbackInfo'Trigger CallbackInfo'WorkflowClosed@ -}
data CallbackInfo'Trigger
  = CallbackInfo'Trigger'_constructor {_CallbackInfo'Trigger'variant :: !(Prelude.Maybe CallbackInfo'Trigger'Variant),
                                       _CallbackInfo'Trigger'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CallbackInfo'Trigger where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data CallbackInfo'Trigger'Variant
  = CallbackInfo'Trigger'WorkflowClosed !CallbackInfo'WorkflowClosed
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField CallbackInfo'Trigger "maybe'variant" (Prelude.Maybe CallbackInfo'Trigger'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'Trigger'variant
           (\ x__ y__ -> x__ {_CallbackInfo'Trigger'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CallbackInfo'Trigger "maybe'workflowClosed" (Prelude.Maybe CallbackInfo'WorkflowClosed) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'Trigger'variant
           (\ x__ y__ -> x__ {_CallbackInfo'Trigger'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (CallbackInfo'Trigger'WorkflowClosed x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap CallbackInfo'Trigger'WorkflowClosed y__))
instance Data.ProtoLens.Field.HasField CallbackInfo'Trigger "workflowClosed" CallbackInfo'WorkflowClosed where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CallbackInfo'Trigger'variant
           (\ x__ y__ -> x__ {_CallbackInfo'Trigger'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (CallbackInfo'Trigger'WorkflowClosed x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap CallbackInfo'Trigger'WorkflowClosed y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message CallbackInfo'Trigger where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.CallbackInfo.Trigger"
  packedMessageDescriptor _
    = "\n\
      \\aTrigger\DC2`\n\
      \\SIworkflow_closed\CAN\SOH \SOH(\v25.temporal.api.workflow.v1.CallbackInfo.WorkflowClosedH\NULR\SOworkflowClosedB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowClosed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_closed"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CallbackInfo'WorkflowClosed)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowClosed")) ::
              Data.ProtoLens.FieldDescriptor CallbackInfo'Trigger
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowClosed__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CallbackInfo'Trigger'_unknownFields
        (\ x__ y__ -> x__ {_CallbackInfo'Trigger'_unknownFields = y__})
  defMessage
    = CallbackInfo'Trigger'_constructor
        {_CallbackInfo'Trigger'variant = Prelude.Nothing,
         _CallbackInfo'Trigger'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CallbackInfo'Trigger
          -> Data.ProtoLens.Encoding.Bytes.Parser CallbackInfo'Trigger
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
                                       "workflow_closed"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowClosed") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Trigger"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (CallbackInfo'Trigger'WorkflowClosed v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData CallbackInfo'Trigger where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CallbackInfo'Trigger'_unknownFields x__)
             (Control.DeepSeq.deepseq (_CallbackInfo'Trigger'variant x__) ())
instance Control.DeepSeq.NFData CallbackInfo'Trigger'Variant where
  rnf (CallbackInfo'Trigger'WorkflowClosed x__)
    = Control.DeepSeq.rnf x__
_CallbackInfo'Trigger'WorkflowClosed ::
  Data.ProtoLens.Prism.Prism' CallbackInfo'Trigger'Variant CallbackInfo'WorkflowClosed
_CallbackInfo'Trigger'WorkflowClosed
  = Data.ProtoLens.Prism.prism'
      CallbackInfo'Trigger'WorkflowClosed
      (\ p__
         -> case p__ of
              (CallbackInfo'Trigger'WorkflowClosed p__val)
                -> Prelude.Just p__val)
{- | Fields :
      -}
data CallbackInfo'WorkflowClosed
  = CallbackInfo'WorkflowClosed'_constructor {_CallbackInfo'WorkflowClosed'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CallbackInfo'WorkflowClosed where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message CallbackInfo'WorkflowClosed where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.CallbackInfo.WorkflowClosed"
  packedMessageDescriptor _
    = "\n\
      \\SOWorkflowClosed"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CallbackInfo'WorkflowClosed'_unknownFields
        (\ x__ y__
           -> x__ {_CallbackInfo'WorkflowClosed'_unknownFields = y__})
  defMessage
    = CallbackInfo'WorkflowClosed'_constructor
        {_CallbackInfo'WorkflowClosed'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CallbackInfo'WorkflowClosed
          -> Data.ProtoLens.Encoding.Bytes.Parser CallbackInfo'WorkflowClosed
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
          (do loop Data.ProtoLens.defMessage) "WorkflowClosed"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData CallbackInfo'WorkflowClosed where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CallbackInfo'WorkflowClosed'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.deployment' @:: Lens' DeploymentTransition Proto.Temporal.Api.Deployment.V1.Message.Deployment@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'deployment' @:: Lens' DeploymentTransition (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment)@ -}
data DeploymentTransition
  = DeploymentTransition'_constructor {_DeploymentTransition'deployment :: !(Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment),
                                       _DeploymentTransition'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show DeploymentTransition where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField DeploymentTransition "deployment" Proto.Temporal.Api.Deployment.V1.Message.Deployment where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeploymentTransition'deployment
           (\ x__ y__ -> x__ {_DeploymentTransition'deployment = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField DeploymentTransition "maybe'deployment" (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeploymentTransition'deployment
           (\ x__ y__ -> x__ {_DeploymentTransition'deployment = y__}))
        Prelude.id
instance Data.ProtoLens.Message DeploymentTransition where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.DeploymentTransition"
  packedMessageDescriptor _
    = "\n\
      \\DC4DeploymentTransition\DC2F\n\
      \\n\
      \deployment\CAN\SOH \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\n\
      \deployment"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        deployment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "deployment"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Deployment.V1.Message.Deployment)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'deployment")) ::
              Data.ProtoLens.FieldDescriptor DeploymentTransition
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, deployment__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DeploymentTransition'_unknownFields
        (\ x__ y__ -> x__ {_DeploymentTransition'_unknownFields = y__})
  defMessage
    = DeploymentTransition'_constructor
        {_DeploymentTransition'deployment = Prelude.Nothing,
         _DeploymentTransition'_unknownFields = []}
  parseMessage
    = let
        loop ::
          DeploymentTransition
          -> Data.ProtoLens.Encoding.Bytes.Parser DeploymentTransition
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
                                       "deployment"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"deployment") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "DeploymentTransition"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'deployment") _x
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
instance Control.DeepSeq.NFData DeploymentTransition where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DeploymentTransition'_unknownFields x__)
             (Control.DeepSeq.deepseq (_DeploymentTransition'deployment x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.version' @:: Lens' DeploymentVersionTransition Data.Text.Text@ -}
data DeploymentVersionTransition
  = DeploymentVersionTransition'_constructor {_DeploymentVersionTransition'version :: !Data.Text.Text,
                                              _DeploymentVersionTransition'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show DeploymentVersionTransition where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField DeploymentVersionTransition "version" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _DeploymentVersionTransition'version
           (\ x__ y__ -> x__ {_DeploymentVersionTransition'version = y__}))
        Prelude.id
instance Data.ProtoLens.Message DeploymentVersionTransition where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.DeploymentVersionTransition"
  packedMessageDescriptor _
    = "\n\
      \\ESCDeploymentVersionTransition\DC2\CAN\n\
      \\aversion\CAN\SOH \SOH(\tR\aversion"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor DeploymentVersionTransition
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, version__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _DeploymentVersionTransition'_unknownFields
        (\ x__ y__
           -> x__ {_DeploymentVersionTransition'_unknownFields = y__})
  defMessage
    = DeploymentVersionTransition'_constructor
        {_DeploymentVersionTransition'version = Data.ProtoLens.fieldDefault,
         _DeploymentVersionTransition'_unknownFields = []}
  parseMessage
    = let
        loop ::
          DeploymentVersionTransition
          -> Data.ProtoLens.Encoding.Bytes.Parser DeploymentVersionTransition
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
          (do loop Data.ProtoLens.defMessage) "DeploymentVersionTransition"
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
instance Control.DeepSeq.NFData DeploymentVersionTransition where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_DeploymentVersionTransition'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_DeploymentVersionTransition'version x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowId' @:: Lens' NewWorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowType' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.WorkflowType@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowType' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.taskQueue' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'taskQueue' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.input' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'input' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowExecutionTimeout' @:: Lens' NewWorkflowExecutionInfo Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowExecutionTimeout' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowRunTimeout' @:: Lens' NewWorkflowExecutionInfo Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowRunTimeout' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowTaskTimeout' @:: Lens' NewWorkflowExecutionInfo Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowTaskTimeout' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowIdReusePolicy' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.retryPolicy' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.RetryPolicy@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'retryPolicy' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.cronSchedule' @:: Lens' NewWorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.memo' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.Memo@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'memo' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.searchAttributes' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.SearchAttributes@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'searchAttributes' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.header' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'header' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.userMetadata' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'userMetadata' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.versioningOverride' @:: Lens' NewWorkflowExecutionInfo VersioningOverride@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'versioningOverride' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe VersioningOverride)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.priority' @:: Lens' NewWorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.Priority@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'priority' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority)@ -}
data NewWorkflowExecutionInfo
  = NewWorkflowExecutionInfo'_constructor {_NewWorkflowExecutionInfo'workflowId :: !Data.Text.Text,
                                           _NewWorkflowExecutionInfo'workflowType :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType),
                                           _NewWorkflowExecutionInfo'taskQueue :: !(Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue),
                                           _NewWorkflowExecutionInfo'input :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                           _NewWorkflowExecutionInfo'workflowExecutionTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                           _NewWorkflowExecutionInfo'workflowRunTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                           _NewWorkflowExecutionInfo'workflowTaskTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                           _NewWorkflowExecutionInfo'workflowIdReusePolicy :: !Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy,
                                           _NewWorkflowExecutionInfo'retryPolicy :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy),
                                           _NewWorkflowExecutionInfo'cronSchedule :: !Data.Text.Text,
                                           _NewWorkflowExecutionInfo'memo :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo),
                                           _NewWorkflowExecutionInfo'searchAttributes :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes),
                                           _NewWorkflowExecutionInfo'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                           _NewWorkflowExecutionInfo'userMetadata :: !(Prelude.Maybe Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata),
                                           _NewWorkflowExecutionInfo'versioningOverride :: !(Prelude.Maybe VersioningOverride),
                                           _NewWorkflowExecutionInfo'priority :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority),
                                           _NewWorkflowExecutionInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NewWorkflowExecutionInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowId
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "workflowType" Proto.Temporal.Api.Common.V1.Message.WorkflowType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowType
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'workflowType = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'workflowType" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowType
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'workflowType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "taskQueue" Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'taskQueue
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'taskQueue = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'taskQueue" (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'taskQueue
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "input" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'input
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'input = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'input" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'input
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "workflowExecutionTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowExecutionTimeout
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'workflowExecutionTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'workflowExecutionTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowExecutionTimeout
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'workflowExecutionTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "workflowRunTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowRunTimeout
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'workflowRunTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'workflowRunTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowRunTimeout
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'workflowRunTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "workflowTaskTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowTaskTimeout
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'workflowTaskTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'workflowTaskTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowTaskTimeout
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'workflowTaskTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "workflowIdReusePolicy" Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'workflowIdReusePolicy
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'workflowIdReusePolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "retryPolicy" Proto.Temporal.Api.Common.V1.Message.RetryPolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'retryPolicy
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'retryPolicy = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'retryPolicy" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'retryPolicy
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'retryPolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "cronSchedule" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'cronSchedule
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'cronSchedule = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "memo" Proto.Temporal.Api.Common.V1.Message.Memo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'memo
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'memo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'memo" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'memo
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'memo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "searchAttributes" Proto.Temporal.Api.Common.V1.Message.SearchAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'searchAttributes
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'searchAttributes = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'searchAttributes" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'searchAttributes
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'header
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'header
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "userMetadata" Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'userMetadata
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'userMetadata = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'userMetadata" (Prelude.Maybe Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'userMetadata
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'userMetadata = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "versioningOverride" VersioningOverride where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'versioningOverride
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'versioningOverride = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'versioningOverride" (Prelude.Maybe VersioningOverride) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'versioningOverride
           (\ x__ y__
              -> x__ {_NewWorkflowExecutionInfo'versioningOverride = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "priority" Proto.Temporal.Api.Common.V1.Message.Priority where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'priority
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'priority = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NewWorkflowExecutionInfo "maybe'priority" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewWorkflowExecutionInfo'priority
           (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'priority = y__}))
        Prelude.id
instance Data.ProtoLens.Message NewWorkflowExecutionInfo where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.NewWorkflowExecutionInfo"
  packedMessageDescriptor _
    = "\n\
      \\CANNewWorkflowExecutionInfo\DC2\US\n\
      \\vworkflow_id\CAN\SOH \SOH(\tR\n\
      \workflowId\DC2I\n\
      \\rworkflow_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\fworkflowType\DC2C\n\
      \\n\
      \task_queue\CAN\ETX \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
      \\ENQinput\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2W\n\
      \\SUBworkflow_execution_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeout\DC2K\n\
      \\DC4workflow_run_timeout\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeout\DC2M\n\
      \\NAKworkflow_task_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeout\DC2e\n\
      \\CANworkflow_id_reuse_policy\CAN\b \SOH(\SO2,.temporal.api.enums.v1.WorkflowIdReusePolicyR\NAKworkflowIdReusePolicy\DC2F\n\
      \\fretry_policy\CAN\t \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2#\n\
      \\rcron_schedule\CAN\n\
      \ \SOH(\tR\fcronSchedule\DC20\n\
      \\EOTmemo\CAN\v \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
      \\DC1search_attributes\CAN\f \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC26\n\
      \\ACKheader\CAN\r \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2F\n\
      \\ruser_metadata\CAN\SO \SOH(\v2!.temporal.api.sdk.v1.UserMetadataR\fuserMetadata\DC2]\n\
      \\DC3versioning_override\CAN\SI \SOH(\v2,.temporal.api.workflow.v1.VersioningOverrideR\DC2versioningOverride\DC2<\n\
      \\bpriority\CAN\DLE \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority"
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
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        workflowType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_type"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowType)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowType")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'taskQueue")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'input")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        workflowExecutionTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        workflowRunTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_run_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        workflowTaskTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_task_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        workflowIdReusePolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id_reuse_policy"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.WorkflowIdReusePolicy)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowIdReusePolicy")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        retryPolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "retry_policy"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.RetryPolicy)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'retryPolicy")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        cronSchedule__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cron_schedule"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"cronSchedule")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        memo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "memo"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Memo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'memo")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.SearchAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        userMetadata__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "user_metadata"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'userMetadata")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        versioningOverride__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "versioning_override"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor VersioningOverride)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'versioningOverride")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
        priority__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "priority"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Priority)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'priority")) ::
              Data.ProtoLens.FieldDescriptor NewWorkflowExecutionInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowType__field_descriptor),
           (Data.ProtoLens.Tag 3, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 4, input__field_descriptor),
           (Data.ProtoLens.Tag 5, workflowExecutionTimeout__field_descriptor),
           (Data.ProtoLens.Tag 6, workflowRunTimeout__field_descriptor),
           (Data.ProtoLens.Tag 7, workflowTaskTimeout__field_descriptor),
           (Data.ProtoLens.Tag 8, workflowIdReusePolicy__field_descriptor),
           (Data.ProtoLens.Tag 9, retryPolicy__field_descriptor),
           (Data.ProtoLens.Tag 10, cronSchedule__field_descriptor),
           (Data.ProtoLens.Tag 11, memo__field_descriptor),
           (Data.ProtoLens.Tag 12, searchAttributes__field_descriptor),
           (Data.ProtoLens.Tag 13, header__field_descriptor),
           (Data.ProtoLens.Tag 14, userMetadata__field_descriptor),
           (Data.ProtoLens.Tag 15, versioningOverride__field_descriptor),
           (Data.ProtoLens.Tag 16, priority__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NewWorkflowExecutionInfo'_unknownFields
        (\ x__ y__ -> x__ {_NewWorkflowExecutionInfo'_unknownFields = y__})
  defMessage
    = NewWorkflowExecutionInfo'_constructor
        {_NewWorkflowExecutionInfo'workflowId = Data.ProtoLens.fieldDefault,
         _NewWorkflowExecutionInfo'workflowType = Prelude.Nothing,
         _NewWorkflowExecutionInfo'taskQueue = Prelude.Nothing,
         _NewWorkflowExecutionInfo'input = Prelude.Nothing,
         _NewWorkflowExecutionInfo'workflowExecutionTimeout = Prelude.Nothing,
         _NewWorkflowExecutionInfo'workflowRunTimeout = Prelude.Nothing,
         _NewWorkflowExecutionInfo'workflowTaskTimeout = Prelude.Nothing,
         _NewWorkflowExecutionInfo'workflowIdReusePolicy = Data.ProtoLens.fieldDefault,
         _NewWorkflowExecutionInfo'retryPolicy = Prelude.Nothing,
         _NewWorkflowExecutionInfo'cronSchedule = Data.ProtoLens.fieldDefault,
         _NewWorkflowExecutionInfo'memo = Prelude.Nothing,
         _NewWorkflowExecutionInfo'searchAttributes = Prelude.Nothing,
         _NewWorkflowExecutionInfo'header = Prelude.Nothing,
         _NewWorkflowExecutionInfo'userMetadata = Prelude.Nothing,
         _NewWorkflowExecutionInfo'versioningOverride = Prelude.Nothing,
         _NewWorkflowExecutionInfo'priority = Prelude.Nothing,
         _NewWorkflowExecutionInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NewWorkflowExecutionInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser NewWorkflowExecutionInfo
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
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowType") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "input"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"input") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_execution_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecutionTimeout") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_run_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowRunTimeout") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_task_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowTaskTimeout") y x)
                        64
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "workflow_id_reuse_policy"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowIdReusePolicy") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "retry_policy"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"retryPolicy") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "cron_schedule"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cronSchedule") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "memo"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"memo") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "search_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"searchAttributes") y x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "user_metadata"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"userMetadata") y x)
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "versioning_override"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"versioningOverride") y x)
                        130
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "priority"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"priority") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NewWorkflowExecutionInfo"
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
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'workflowType") _x
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
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'taskQueue") _x
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
                           Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'input") _x
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
                                (Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout") _x
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
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (case
                                    Lens.Family2.view
                                      (Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout") _x
                                of
                                  Prelude.Nothing -> Data.Monoid.mempty
                                  (Prelude.Just _v)
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                                         ((Prelude..)
                                            (\ bs
                                               -> (Data.Monoid.<>)
                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                       (Prelude.fromIntegral
                                                          (Data.ByteString.length bs)))
                                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                            Data.ProtoLens.encodeMessage _v))
                               ((Data.Monoid.<>)
                                  (let
                                     _v
                                       = Lens.Family2.view
                                           (Data.ProtoLens.Field.field @"workflowIdReusePolicy") _x
                                   in
                                     if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                         Data.Monoid.mempty
                                     else
                                         (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt 64)
                                           ((Prelude..)
                                              ((Prelude..)
                                                 Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 Prelude.fromIntegral)
                                              Prelude.fromEnum _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'retryPolicy") _x
                                      of
                                        Prelude.Nothing -> Data.Monoid.mempty
                                        (Prelude.Just _v)
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                               ((Prelude..)
                                                  (\ bs
                                                     -> (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             (Prelude.fromIntegral
                                                                (Data.ByteString.length bs)))
                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                             bs))
                                                  Data.ProtoLens.encodeMessage _v))
                                     ((Data.Monoid.<>)
                                        (let
                                           _v
                                             = Lens.Family2.view
                                                 (Data.ProtoLens.Field.field @"cronSchedule") _x
                                         in
                                           if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                               Data.Monoid.mempty
                                           else
                                               (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                                 ((Prelude..)
                                                    (\ bs
                                                       -> (Data.Monoid.<>)
                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                               (Prelude.fromIntegral
                                                                  (Data.ByteString.length bs)))
                                                            (Data.ProtoLens.Encoding.Bytes.putBytes
                                                               bs))
                                                    Data.Text.Encoding.encodeUtf8 _v))
                                        ((Data.Monoid.<>)
                                           (case
                                                Lens.Family2.view
                                                  (Data.ProtoLens.Field.field @"maybe'memo") _x
                                            of
                                              Prelude.Nothing -> Data.Monoid.mempty
                                              (Prelude.Just _v)
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                     ((Prelude..)
                                                        (\ bs
                                                           -> (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (Prelude.fromIntegral
                                                                      (Data.ByteString.length bs)))
                                                                (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                   bs))
                                                        Data.ProtoLens.encodeMessage _v))
                                           ((Data.Monoid.<>)
                                              (case
                                                   Lens.Family2.view
                                                     (Data.ProtoLens.Field.field
                                                        @"maybe'searchAttributes")
                                                     _x
                                               of
                                                 Prelude.Nothing -> Data.Monoid.mempty
                                                 (Prelude.Just _v)
                                                   -> (Data.Monoid.<>)
                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                                                        ((Prelude..)
                                                           (\ bs
                                                              -> (Data.Monoid.<>)
                                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                      (Prelude.fromIntegral
                                                                         (Data.ByteString.length
                                                                            bs)))
                                                                   (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                      bs))
                                                           Data.ProtoLens.encodeMessage _v))
                                              ((Data.Monoid.<>)
                                                 (case
                                                      Lens.Family2.view
                                                        (Data.ProtoLens.Field.field @"maybe'header")
                                                        _x
                                                  of
                                                    Prelude.Nothing -> Data.Monoid.mempty
                                                    (Prelude.Just _v)
                                                      -> (Data.Monoid.<>)
                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                              106)
                                                           ((Prelude..)
                                                              (\ bs
                                                                 -> (Data.Monoid.<>)
                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         (Prelude.fromIntegral
                                                                            (Data.ByteString.length
                                                                               bs)))
                                                                      (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                         bs))
                                                              Data.ProtoLens.encodeMessage _v))
                                                 ((Data.Monoid.<>)
                                                    (case
                                                         Lens.Family2.view
                                                           (Data.ProtoLens.Field.field
                                                              @"maybe'userMetadata")
                                                           _x
                                                     of
                                                       Prelude.Nothing -> Data.Monoid.mempty
                                                       (Prelude.Just _v)
                                                         -> (Data.Monoid.<>)
                                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                 114)
                                                              ((Prelude..)
                                                                 (\ bs
                                                                    -> (Data.Monoid.<>)
                                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                            (Prelude.fromIntegral
                                                                               (Data.ByteString.length
                                                                                  bs)))
                                                                         (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                            bs))
                                                                 Data.ProtoLens.encodeMessage _v))
                                                    ((Data.Monoid.<>)
                                                       (case
                                                            Lens.Family2.view
                                                              (Data.ProtoLens.Field.field
                                                                 @"maybe'versioningOverride")
                                                              _x
                                                        of
                                                          Prelude.Nothing -> Data.Monoid.mempty
                                                          (Prelude.Just _v)
                                                            -> (Data.Monoid.<>)
                                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                    122)
                                                                 ((Prelude..)
                                                                    (\ bs
                                                                       -> (Data.Monoid.<>)
                                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                               (Prelude.fromIntegral
                                                                                  (Data.ByteString.length
                                                                                     bs)))
                                                                            (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                               bs))
                                                                    Data.ProtoLens.encodeMessage
                                                                    _v))
                                                       ((Data.Monoid.<>)
                                                          (case
                                                               Lens.Family2.view
                                                                 (Data.ProtoLens.Field.field
                                                                    @"maybe'priority")
                                                                 _x
                                                           of
                                                             Prelude.Nothing -> Data.Monoid.mempty
                                                             (Prelude.Just _v)
                                                               -> (Data.Monoid.<>)
                                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                       130)
                                                                    ((Prelude..)
                                                                       (\ bs
                                                                          -> (Data.Monoid.<>)
                                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  (Prelude.fromIntegral
                                                                                     (Data.ByteString.length
                                                                                        bs)))
                                                                               (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                  bs))
                                                                       Data.ProtoLens.encodeMessage
                                                                       _v))
                                                          (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                             (Lens.Family2.view
                                                                Data.ProtoLens.unknownFields
                                                                _x)))))))))))))))))
instance Control.DeepSeq.NFData NewWorkflowExecutionInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NewWorkflowExecutionInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NewWorkflowExecutionInfo'workflowId x__)
                (Control.DeepSeq.deepseq
                   (_NewWorkflowExecutionInfo'workflowType x__)
                   (Control.DeepSeq.deepseq
                      (_NewWorkflowExecutionInfo'taskQueue x__)
                      (Control.DeepSeq.deepseq
                         (_NewWorkflowExecutionInfo'input x__)
                         (Control.DeepSeq.deepseq
                            (_NewWorkflowExecutionInfo'workflowExecutionTimeout x__)
                            (Control.DeepSeq.deepseq
                               (_NewWorkflowExecutionInfo'workflowRunTimeout x__)
                               (Control.DeepSeq.deepseq
                                  (_NewWorkflowExecutionInfo'workflowTaskTimeout x__)
                                  (Control.DeepSeq.deepseq
                                     (_NewWorkflowExecutionInfo'workflowIdReusePolicy x__)
                                     (Control.DeepSeq.deepseq
                                        (_NewWorkflowExecutionInfo'retryPolicy x__)
                                        (Control.DeepSeq.deepseq
                                           (_NewWorkflowExecutionInfo'cronSchedule x__)
                                           (Control.DeepSeq.deepseq
                                              (_NewWorkflowExecutionInfo'memo x__)
                                              (Control.DeepSeq.deepseq
                                                 (_NewWorkflowExecutionInfo'searchAttributes x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_NewWorkflowExecutionInfo'header x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_NewWorkflowExecutionInfo'userMetadata x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_NewWorkflowExecutionInfo'versioningOverride
                                                             x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_NewWorkflowExecutionInfo'priority
                                                                x__)
                                                             ()))))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.requestedTime' @:: Lens' NexusOperationCancellationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'requestedTime' @:: Lens' NexusOperationCancellationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.state' @:: Lens' NexusOperationCancellationInfo Proto.Temporal.Api.Enums.V1.Common.NexusOperationCancellationState@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attempt' @:: Lens' NexusOperationCancellationInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastAttemptCompleteTime' @:: Lens' NexusOperationCancellationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastAttemptCompleteTime' @:: Lens' NexusOperationCancellationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastAttemptFailure' @:: Lens' NexusOperationCancellationInfo Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastAttemptFailure' @:: Lens' NexusOperationCancellationInfo (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.nextAttemptScheduleTime' @:: Lens' NexusOperationCancellationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'nextAttemptScheduleTime' @:: Lens' NexusOperationCancellationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.blockedReason' @:: Lens' NexusOperationCancellationInfo Data.Text.Text@ -}
data NexusOperationCancellationInfo
  = NexusOperationCancellationInfo'_constructor {_NexusOperationCancellationInfo'requestedTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                 _NexusOperationCancellationInfo'state :: !Proto.Temporal.Api.Enums.V1.Common.NexusOperationCancellationState,
                                                 _NexusOperationCancellationInfo'attempt :: !Data.Int.Int32,
                                                 _NexusOperationCancellationInfo'lastAttemptCompleteTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                 _NexusOperationCancellationInfo'lastAttemptFailure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                                 _NexusOperationCancellationInfo'nextAttemptScheduleTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                 _NexusOperationCancellationInfo'blockedReason :: !Data.Text.Text,
                                                 _NexusOperationCancellationInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NexusOperationCancellationInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "requestedTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'requestedTime
           (\ x__ y__
              -> x__ {_NexusOperationCancellationInfo'requestedTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "maybe'requestedTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'requestedTime
           (\ x__ y__
              -> x__ {_NexusOperationCancellationInfo'requestedTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "state" Proto.Temporal.Api.Enums.V1.Common.NexusOperationCancellationState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'state
           (\ x__ y__ -> x__ {_NexusOperationCancellationInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "attempt" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'attempt
           (\ x__ y__ -> x__ {_NexusOperationCancellationInfo'attempt = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "lastAttemptCompleteTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'lastAttemptCompleteTime
           (\ x__ y__
              -> x__
                   {_NexusOperationCancellationInfo'lastAttemptCompleteTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "maybe'lastAttemptCompleteTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'lastAttemptCompleteTime
           (\ x__ y__
              -> x__
                   {_NexusOperationCancellationInfo'lastAttemptCompleteTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "lastAttemptFailure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'lastAttemptFailure
           (\ x__ y__
              -> x__ {_NexusOperationCancellationInfo'lastAttemptFailure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "maybe'lastAttemptFailure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'lastAttemptFailure
           (\ x__ y__
              -> x__ {_NexusOperationCancellationInfo'lastAttemptFailure = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "nextAttemptScheduleTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'nextAttemptScheduleTime
           (\ x__ y__
              -> x__
                   {_NexusOperationCancellationInfo'nextAttemptScheduleTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "maybe'nextAttemptScheduleTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'nextAttemptScheduleTime
           (\ x__ y__
              -> x__
                   {_NexusOperationCancellationInfo'nextAttemptScheduleTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NexusOperationCancellationInfo "blockedReason" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NexusOperationCancellationInfo'blockedReason
           (\ x__ y__
              -> x__ {_NexusOperationCancellationInfo'blockedReason = y__}))
        Prelude.id
instance Data.ProtoLens.Message NexusOperationCancellationInfo where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.NexusOperationCancellationInfo"
  packedMessageDescriptor _
    = "\n\
      \\RSNexusOperationCancellationInfo\DC2A\n\
      \\SOrequested_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\rrequestedTime\DC2L\n\
      \\ENQstate\CAN\STX \SOH(\SO26.temporal.api.enums.v1.NexusOperationCancellationStateR\ENQstate\DC2\CAN\n\
      \\aattempt\CAN\ETX \SOH(\ENQR\aattempt\DC2W\n\
      \\SUBlast_attempt_complete_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2R\n\
      \\DC4last_attempt_failure\CAN\ENQ \SOH(\v2 .temporal.api.failure.v1.FailureR\DC2lastAttemptFailure\DC2W\n\
      \\SUBnext_attempt_schedule_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2%\n\
      \\SOblocked_reason\CAN\a \SOH(\tR\rblockedReason"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        requestedTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "requested_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'requestedTime")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationCancellationInfo
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.NexusOperationCancellationState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationCancellationInfo
        attempt__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attempt"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"attempt")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationCancellationInfo
        lastAttemptCompleteTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_attempt_complete_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAttemptCompleteTime")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationCancellationInfo
        lastAttemptFailure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_attempt_failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAttemptFailure")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationCancellationInfo
        nextAttemptScheduleTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_attempt_schedule_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'nextAttemptScheduleTime")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationCancellationInfo
        blockedReason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "blocked_reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"blockedReason")) ::
              Data.ProtoLens.FieldDescriptor NexusOperationCancellationInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, requestedTime__field_descriptor),
           (Data.ProtoLens.Tag 2, state__field_descriptor),
           (Data.ProtoLens.Tag 3, attempt__field_descriptor),
           (Data.ProtoLens.Tag 4, lastAttemptCompleteTime__field_descriptor),
           (Data.ProtoLens.Tag 5, lastAttemptFailure__field_descriptor),
           (Data.ProtoLens.Tag 6, nextAttemptScheduleTime__field_descriptor),
           (Data.ProtoLens.Tag 7, blockedReason__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NexusOperationCancellationInfo'_unknownFields
        (\ x__ y__
           -> x__ {_NexusOperationCancellationInfo'_unknownFields = y__})
  defMessage
    = NexusOperationCancellationInfo'_constructor
        {_NexusOperationCancellationInfo'requestedTime = Prelude.Nothing,
         _NexusOperationCancellationInfo'state = Data.ProtoLens.fieldDefault,
         _NexusOperationCancellationInfo'attempt = Data.ProtoLens.fieldDefault,
         _NexusOperationCancellationInfo'lastAttemptCompleteTime = Prelude.Nothing,
         _NexusOperationCancellationInfo'lastAttemptFailure = Prelude.Nothing,
         _NexusOperationCancellationInfo'nextAttemptScheduleTime = Prelude.Nothing,
         _NexusOperationCancellationInfo'blockedReason = Data.ProtoLens.fieldDefault,
         _NexusOperationCancellationInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NexusOperationCancellationInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser NexusOperationCancellationInfo
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
                                       "requested_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"requestedTime") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attempt"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"attempt") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_attempt_complete_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAttemptCompleteTime") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_attempt_failure"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAttemptFailure") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "next_attempt_schedule_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nextAttemptScheduleTime") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "blocked_reason"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"blockedReason") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "NexusOperationCancellationInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'requestedTime") _x
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
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"attempt") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'lastAttemptCompleteTime") _x
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
                                (Data.ProtoLens.Field.field @"maybe'lastAttemptFailure") _x
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
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'nextAttemptScheduleTime") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (let
                                  _v
                                    = Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"blockedReason") _x
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
                                                      (Prelude.fromIntegral
                                                         (Data.ByteString.length bs)))
                                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                           Data.Text.Encoding.encodeUtf8 _v))
                               (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                  (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))
instance Control.DeepSeq.NFData NexusOperationCancellationInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NexusOperationCancellationInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NexusOperationCancellationInfo'requestedTime x__)
                (Control.DeepSeq.deepseq
                   (_NexusOperationCancellationInfo'state x__)
                   (Control.DeepSeq.deepseq
                      (_NexusOperationCancellationInfo'attempt x__)
                      (Control.DeepSeq.deepseq
                         (_NexusOperationCancellationInfo'lastAttemptCompleteTime x__)
                         (Control.DeepSeq.deepseq
                            (_NexusOperationCancellationInfo'lastAttemptFailure x__)
                            (Control.DeepSeq.deepseq
                               (_NexusOperationCancellationInfo'nextAttemptScheduleTime x__)
                               (Control.DeepSeq.deepseq
                                  (_NexusOperationCancellationInfo'blockedReason x__) ())))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attachRequestId' @:: Lens' OnConflictOptions Prelude.Bool@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attachCompletionCallbacks' @:: Lens' OnConflictOptions Prelude.Bool@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attachLinks' @:: Lens' OnConflictOptions Prelude.Bool@ -}
data OnConflictOptions
  = OnConflictOptions'_constructor {_OnConflictOptions'attachRequestId :: !Prelude.Bool,
                                    _OnConflictOptions'attachCompletionCallbacks :: !Prelude.Bool,
                                    _OnConflictOptions'attachLinks :: !Prelude.Bool,
                                    _OnConflictOptions'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show OnConflictOptions where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField OnConflictOptions "attachRequestId" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _OnConflictOptions'attachRequestId
           (\ x__ y__ -> x__ {_OnConflictOptions'attachRequestId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField OnConflictOptions "attachCompletionCallbacks" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _OnConflictOptions'attachCompletionCallbacks
           (\ x__ y__
              -> x__ {_OnConflictOptions'attachCompletionCallbacks = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField OnConflictOptions "attachLinks" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _OnConflictOptions'attachLinks
           (\ x__ y__ -> x__ {_OnConflictOptions'attachLinks = y__}))
        Prelude.id
instance Data.ProtoLens.Message OnConflictOptions where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.OnConflictOptions"
  packedMessageDescriptor _
    = "\n\
      \\DC1OnConflictOptions\DC2*\n\
      \\DC1attach_request_id\CAN\SOH \SOH(\bR\SIattachRequestId\DC2>\n\
      \\ESCattach_completion_callbacks\CAN\STX \SOH(\bR\EMattachCompletionCallbacks\DC2!\n\
      \\fattach_links\CAN\ETX \SOH(\bR\vattachLinks"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        attachRequestId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attach_request_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"attachRequestId")) ::
              Data.ProtoLens.FieldDescriptor OnConflictOptions
        attachCompletionCallbacks__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attach_completion_callbacks"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"attachCompletionCallbacks")) ::
              Data.ProtoLens.FieldDescriptor OnConflictOptions
        attachLinks__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attach_links"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"attachLinks")) ::
              Data.ProtoLens.FieldDescriptor OnConflictOptions
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, attachRequestId__field_descriptor),
           (Data.ProtoLens.Tag 2, 
            attachCompletionCallbacks__field_descriptor),
           (Data.ProtoLens.Tag 3, attachLinks__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _OnConflictOptions'_unknownFields
        (\ x__ y__ -> x__ {_OnConflictOptions'_unknownFields = y__})
  defMessage
    = OnConflictOptions'_constructor
        {_OnConflictOptions'attachRequestId = Data.ProtoLens.fieldDefault,
         _OnConflictOptions'attachCompletionCallbacks = Data.ProtoLens.fieldDefault,
         _OnConflictOptions'attachLinks = Data.ProtoLens.fieldDefault,
         _OnConflictOptions'_unknownFields = []}
  parseMessage
    = let
        loop ::
          OnConflictOptions
          -> Data.ProtoLens.Encoding.Bytes.Parser OnConflictOptions
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
                                       "attach_request_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"attachRequestId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attach_completion_callbacks"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"attachCompletionCallbacks") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attach_links"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"attachLinks") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "OnConflictOptions"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"attachRequestId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                         _v))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"attachCompletionCallbacks") _x
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
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"attachLinks") _x
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
instance Control.DeepSeq.NFData OnConflictOptions where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_OnConflictOptions'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_OnConflictOptions'attachRequestId x__)
                (Control.DeepSeq.deepseq
                   (_OnConflictOptions'attachCompletionCallbacks x__)
                   (Control.DeepSeq.deepseq (_OnConflictOptions'attachLinks x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.activityId' @:: Lens' PendingActivityInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.activityType' @:: Lens' PendingActivityInfo Proto.Temporal.Api.Common.V1.Message.ActivityType@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'activityType' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ActivityType)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.state' @:: Lens' PendingActivityInfo Proto.Temporal.Api.Enums.V1.Workflow.PendingActivityState@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.heartbeatDetails' @:: Lens' PendingActivityInfo Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'heartbeatDetails' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastHeartbeatTime' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastHeartbeatTime' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastStartedTime' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastStartedTime' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attempt' @:: Lens' PendingActivityInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maximumAttempts' @:: Lens' PendingActivityInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.scheduledTime' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'scheduledTime' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.expirationTime' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'expirationTime' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastFailure' @:: Lens' PendingActivityInfo Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastFailure' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastWorkerIdentity' @:: Lens' PendingActivityInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastWorkerVersionStamp' @:: Lens' PendingActivityInfo Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastWorkerVersionStamp' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.currentRetryInterval' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'currentRetryInterval' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastAttemptCompleteTime' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastAttemptCompleteTime' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.nextAttemptScheduleTime' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'nextAttemptScheduleTime' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.paused' @:: Lens' PendingActivityInfo Prelude.Bool@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastDeployment' @:: Lens' PendingActivityInfo Proto.Temporal.Api.Deployment.V1.Message.Deployment@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastDeployment' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastWorkerDeploymentVersion' @:: Lens' PendingActivityInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.priority' @:: Lens' PendingActivityInfo Proto.Temporal.Api.Common.V1.Message.Priority@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'priority' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.pauseInfo' @:: Lens' PendingActivityInfo PendingActivityInfo'PauseInfo@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'pauseInfo' @:: Lens' PendingActivityInfo (Prelude.Maybe PendingActivityInfo'PauseInfo)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'assignedBuildId' @:: Lens' PendingActivityInfo (Prelude.Maybe PendingActivityInfo'AssignedBuildId)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'useWorkflowBuildId' @:: Lens' PendingActivityInfo (Prelude.Maybe Proto.Google.Protobuf.Empty.Empty)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.useWorkflowBuildId' @:: Lens' PendingActivityInfo Proto.Google.Protobuf.Empty.Empty@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastIndependentlyAssignedBuildId' @:: Lens' PendingActivityInfo (Prelude.Maybe Data.Text.Text)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastIndependentlyAssignedBuildId' @:: Lens' PendingActivityInfo Data.Text.Text@ -}
data PendingActivityInfo
  = PendingActivityInfo'_constructor {_PendingActivityInfo'activityId :: !Data.Text.Text,
                                      _PendingActivityInfo'activityType :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ActivityType),
                                      _PendingActivityInfo'state :: !Proto.Temporal.Api.Enums.V1.Workflow.PendingActivityState,
                                      _PendingActivityInfo'heartbeatDetails :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                      _PendingActivityInfo'lastHeartbeatTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                      _PendingActivityInfo'lastStartedTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                      _PendingActivityInfo'attempt :: !Data.Int.Int32,
                                      _PendingActivityInfo'maximumAttempts :: !Data.Int.Int32,
                                      _PendingActivityInfo'scheduledTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                      _PendingActivityInfo'expirationTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                      _PendingActivityInfo'lastFailure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                      _PendingActivityInfo'lastWorkerIdentity :: !Data.Text.Text,
                                      _PendingActivityInfo'lastWorkerVersionStamp :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp),
                                      _PendingActivityInfo'currentRetryInterval :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                      _PendingActivityInfo'lastAttemptCompleteTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                      _PendingActivityInfo'nextAttemptScheduleTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                      _PendingActivityInfo'paused :: !Prelude.Bool,
                                      _PendingActivityInfo'lastDeployment :: !(Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment),
                                      _PendingActivityInfo'lastWorkerDeploymentVersion :: !Data.Text.Text,
                                      _PendingActivityInfo'priority :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority),
                                      _PendingActivityInfo'pauseInfo :: !(Prelude.Maybe PendingActivityInfo'PauseInfo),
                                      _PendingActivityInfo'assignedBuildId :: !(Prelude.Maybe PendingActivityInfo'AssignedBuildId),
                                      _PendingActivityInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PendingActivityInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data PendingActivityInfo'AssignedBuildId
  = PendingActivityInfo'UseWorkflowBuildId !Proto.Google.Protobuf.Empty.Empty |
    PendingActivityInfo'LastIndependentlyAssignedBuildId !Data.Text.Text
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "activityId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'activityId
           (\ x__ y__ -> x__ {_PendingActivityInfo'activityId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "activityType" Proto.Temporal.Api.Common.V1.Message.ActivityType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'activityType
           (\ x__ y__ -> x__ {_PendingActivityInfo'activityType = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'activityType" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ActivityType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'activityType
           (\ x__ y__ -> x__ {_PendingActivityInfo'activityType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "state" Proto.Temporal.Api.Enums.V1.Workflow.PendingActivityState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'state
           (\ x__ y__ -> x__ {_PendingActivityInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "heartbeatDetails" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'heartbeatDetails
           (\ x__ y__ -> x__ {_PendingActivityInfo'heartbeatDetails = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'heartbeatDetails" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'heartbeatDetails
           (\ x__ y__ -> x__ {_PendingActivityInfo'heartbeatDetails = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastHeartbeatTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastHeartbeatTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastHeartbeatTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'lastHeartbeatTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastHeartbeatTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastHeartbeatTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastStartedTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastStartedTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastStartedTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'lastStartedTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastStartedTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastStartedTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "attempt" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'attempt
           (\ x__ y__ -> x__ {_PendingActivityInfo'attempt = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maximumAttempts" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'maximumAttempts
           (\ x__ y__ -> x__ {_PendingActivityInfo'maximumAttempts = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "scheduledTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'scheduledTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'scheduledTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'scheduledTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'scheduledTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'scheduledTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "expirationTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'expirationTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'expirationTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'expirationTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'expirationTime
           (\ x__ y__ -> x__ {_PendingActivityInfo'expirationTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastFailure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastFailure
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastFailure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'lastFailure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastFailure
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastFailure = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastWorkerIdentity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastWorkerIdentity
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastWorkerIdentity = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastWorkerVersionStamp" Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastWorkerVersionStamp
           (\ x__ y__
              -> x__ {_PendingActivityInfo'lastWorkerVersionStamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'lastWorkerVersionStamp" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastWorkerVersionStamp
           (\ x__ y__
              -> x__ {_PendingActivityInfo'lastWorkerVersionStamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "currentRetryInterval" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'currentRetryInterval
           (\ x__ y__
              -> x__ {_PendingActivityInfo'currentRetryInterval = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'currentRetryInterval" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'currentRetryInterval
           (\ x__ y__
              -> x__ {_PendingActivityInfo'currentRetryInterval = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastAttemptCompleteTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastAttemptCompleteTime
           (\ x__ y__
              -> x__ {_PendingActivityInfo'lastAttemptCompleteTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'lastAttemptCompleteTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastAttemptCompleteTime
           (\ x__ y__
              -> x__ {_PendingActivityInfo'lastAttemptCompleteTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "nextAttemptScheduleTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'nextAttemptScheduleTime
           (\ x__ y__
              -> x__ {_PendingActivityInfo'nextAttemptScheduleTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'nextAttemptScheduleTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'nextAttemptScheduleTime
           (\ x__ y__
              -> x__ {_PendingActivityInfo'nextAttemptScheduleTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "paused" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'paused
           (\ x__ y__ -> x__ {_PendingActivityInfo'paused = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastDeployment" Proto.Temporal.Api.Deployment.V1.Message.Deployment where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastDeployment
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastDeployment = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'lastDeployment" (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastDeployment
           (\ x__ y__ -> x__ {_PendingActivityInfo'lastDeployment = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastWorkerDeploymentVersion" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'lastWorkerDeploymentVersion
           (\ x__ y__
              -> x__ {_PendingActivityInfo'lastWorkerDeploymentVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "priority" Proto.Temporal.Api.Common.V1.Message.Priority where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'priority
           (\ x__ y__ -> x__ {_PendingActivityInfo'priority = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'priority" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'priority
           (\ x__ y__ -> x__ {_PendingActivityInfo'priority = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "pauseInfo" PendingActivityInfo'PauseInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'pauseInfo
           (\ x__ y__ -> x__ {_PendingActivityInfo'pauseInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'pauseInfo" (Prelude.Maybe PendingActivityInfo'PauseInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'pauseInfo
           (\ x__ y__ -> x__ {_PendingActivityInfo'pauseInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'assignedBuildId" (Prelude.Maybe PendingActivityInfo'AssignedBuildId) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'assignedBuildId
           (\ x__ y__ -> x__ {_PendingActivityInfo'assignedBuildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'useWorkflowBuildId" (Prelude.Maybe Proto.Google.Protobuf.Empty.Empty) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'assignedBuildId
           (\ x__ y__ -> x__ {_PendingActivityInfo'assignedBuildId = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (PendingActivityInfo'UseWorkflowBuildId x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap PendingActivityInfo'UseWorkflowBuildId y__))
instance Data.ProtoLens.Field.HasField PendingActivityInfo "useWorkflowBuildId" Proto.Google.Protobuf.Empty.Empty where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'assignedBuildId
           (\ x__ y__ -> x__ {_PendingActivityInfo'assignedBuildId = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (PendingActivityInfo'UseWorkflowBuildId x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap PendingActivityInfo'UseWorkflowBuildId y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField PendingActivityInfo "maybe'lastIndependentlyAssignedBuildId" (Prelude.Maybe Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'assignedBuildId
           (\ x__ y__ -> x__ {_PendingActivityInfo'assignedBuildId = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (PendingActivityInfo'LastIndependentlyAssignedBuildId x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   PendingActivityInfo'LastIndependentlyAssignedBuildId y__))
instance Data.ProtoLens.Field.HasField PendingActivityInfo "lastIndependentlyAssignedBuildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'assignedBuildId
           (\ x__ y__ -> x__ {_PendingActivityInfo'assignedBuildId = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (PendingActivityInfo'LastIndependentlyAssignedBuildId x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      PendingActivityInfo'LastIndependentlyAssignedBuildId y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Message PendingActivityInfo where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.PendingActivityInfo"
  packedMessageDescriptor _
    = "\n\
      \\DC3PendingActivityInfo\DC2\US\n\
      \\vactivity_id\CAN\SOH \SOH(\tR\n\
      \activityId\DC2I\n\
      \\ractivity_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.ActivityTypeR\factivityType\DC2A\n\
      \\ENQstate\CAN\ETX \SOH(\SO2+.temporal.api.enums.v1.PendingActivityStateR\ENQstate\DC2M\n\
      \\DC1heartbeat_details\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\DLEheartbeatDetails\DC2J\n\
      \\DC3last_heartbeat_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DC1lastHeartbeatTime\DC2F\n\
      \\DC1last_started_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\SIlastStartedTime\DC2\CAN\n\
      \\aattempt\CAN\a \SOH(\ENQR\aattempt\DC2)\n\
      \\DLEmaximum_attempts\CAN\b \SOH(\ENQR\SImaximumAttempts\DC2A\n\
      \\SOscheduled_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2C\n\
      \\SIexpiration_time\CAN\n\
      \ \SOH(\v2\SUB.google.protobuf.TimestampR\SOexpirationTime\DC2C\n\
      \\flast_failure\CAN\v \SOH(\v2 .temporal.api.failure.v1.FailureR\vlastFailure\DC20\n\
      \\DC4last_worker_identity\CAN\f \SOH(\tR\DC2lastWorkerIdentity\DC2K\n\
      \\NAKuse_workflow_build_id\CAN\r \SOH(\v2\SYN.google.protobuf.EmptyH\NULR\DC2useWorkflowBuildId\DC2P\n\
      \$last_independently_assigned_build_id\CAN\SO \SOH(\tH\NULR lastIndependentlyAssignedBuildId\DC2e\n\
      \\EMlast_worker_version_stamp\CAN\SI \SOH(\v2*.temporal.api.common.v1.WorkerVersionStampR\SYNlastWorkerVersionStamp\DC2O\n\
      \\SYNcurrent_retry_interval\CAN\DLE \SOH(\v2\EM.google.protobuf.DurationR\DC4currentRetryInterval\DC2W\n\
      \\SUBlast_attempt_complete_time\CAN\DC1 \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2W\n\
      \\SUBnext_attempt_schedule_time\CAN\DC2 \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2\SYN\n\
      \\ACKpaused\CAN\DC3 \SOH(\bR\ACKpaused\DC2S\n\
      \\SIlast_deployment\CAN\DC4 \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\SOlastDeploymentB\STX\CAN\SOH\DC2C\n\
      \\RSlast_worker_deployment_version\CAN\NAK \SOH(\tR\ESClastWorkerDeploymentVersion\DC2<\n\
      \\bpriority\CAN\SYN \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority\DC2V\n\
      \\n\
      \pause_info\CAN\ETB \SOH(\v27.temporal.api.workflow.v1.PendingActivityInfo.PauseInfoR\tpauseInfo\SUB\134\STX\n\
      \\tPauseInfo\DC29\n\
      \\n\
      \pause_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\tpauseTime\DC2X\n\
      \\ACKmanual\CAN\STX \SOH(\v2>.temporal.api.workflow.v1.PendingActivityInfo.PauseInfo.ManualH\NULR\ACKmanual\DC2\EM\n\
      \\arule_id\CAN\ETX \SOH(\tH\NULR\ACKruleId\SUB<\n\
      \\ACKManual\DC2\SUB\n\
      \\bidentity\CAN\SOH \SOH(\tR\bidentity\DC2\SYN\n\
      \\ACKreason\CAN\STX \SOH(\tR\ACKreasonB\v\n\
      \\tpaused_byB\DC3\n\
      \\DC1assigned_build_id"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        activityId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"activityId")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        activityType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_type"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.ActivityType)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'activityType")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.PendingActivityState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        heartbeatDetails__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "heartbeat_details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'heartbeatDetails")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastHeartbeatTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_heartbeat_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastHeartbeatTime")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastStartedTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_started_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastStartedTime")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        attempt__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attempt"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"attempt")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        maximumAttempts__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "maximum_attempts"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"maximumAttempts")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        scheduledTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scheduled_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduledTime")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        expirationTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "expiration_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'expirationTime")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastFailure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastFailure")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastWorkerIdentity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_worker_identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"lastWorkerIdentity")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastWorkerVersionStamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_worker_version_stamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastWorkerVersionStamp")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        currentRetryInterval__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_retry_interval"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'currentRetryInterval")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastAttemptCompleteTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_attempt_complete_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAttemptCompleteTime")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        nextAttemptScheduleTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_attempt_schedule_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'nextAttemptScheduleTime")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        paused__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "paused"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"paused")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastDeployment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_deployment"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Deployment.V1.Message.Deployment)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastDeployment")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastWorkerDeploymentVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_worker_deployment_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"lastWorkerDeploymentVersion")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        priority__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "priority"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Priority)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'priority")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        pauseInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "pause_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor PendingActivityInfo'PauseInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'pauseInfo")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        useWorkflowBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "use_workflow_build_id"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Empty.Empty)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'useWorkflowBuildId")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
        lastIndependentlyAssignedBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_independently_assigned_build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'lastIndependentlyAssignedBuildId")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, activityId__field_descriptor),
           (Data.ProtoLens.Tag 2, activityType__field_descriptor),
           (Data.ProtoLens.Tag 3, state__field_descriptor),
           (Data.ProtoLens.Tag 4, heartbeatDetails__field_descriptor),
           (Data.ProtoLens.Tag 5, lastHeartbeatTime__field_descriptor),
           (Data.ProtoLens.Tag 6, lastStartedTime__field_descriptor),
           (Data.ProtoLens.Tag 7, attempt__field_descriptor),
           (Data.ProtoLens.Tag 8, maximumAttempts__field_descriptor),
           (Data.ProtoLens.Tag 9, scheduledTime__field_descriptor),
           (Data.ProtoLens.Tag 10, expirationTime__field_descriptor),
           (Data.ProtoLens.Tag 11, lastFailure__field_descriptor),
           (Data.ProtoLens.Tag 12, lastWorkerIdentity__field_descriptor),
           (Data.ProtoLens.Tag 15, lastWorkerVersionStamp__field_descriptor),
           (Data.ProtoLens.Tag 16, currentRetryInterval__field_descriptor),
           (Data.ProtoLens.Tag 17, lastAttemptCompleteTime__field_descriptor),
           (Data.ProtoLens.Tag 18, nextAttemptScheduleTime__field_descriptor),
           (Data.ProtoLens.Tag 19, paused__field_descriptor),
           (Data.ProtoLens.Tag 20, lastDeployment__field_descriptor),
           (Data.ProtoLens.Tag 21, 
            lastWorkerDeploymentVersion__field_descriptor),
           (Data.ProtoLens.Tag 22, priority__field_descriptor),
           (Data.ProtoLens.Tag 23, pauseInfo__field_descriptor),
           (Data.ProtoLens.Tag 13, useWorkflowBuildId__field_descriptor),
           (Data.ProtoLens.Tag 14, 
            lastIndependentlyAssignedBuildId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PendingActivityInfo'_unknownFields
        (\ x__ y__ -> x__ {_PendingActivityInfo'_unknownFields = y__})
  defMessage
    = PendingActivityInfo'_constructor
        {_PendingActivityInfo'activityId = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'activityType = Prelude.Nothing,
         _PendingActivityInfo'state = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'heartbeatDetails = Prelude.Nothing,
         _PendingActivityInfo'lastHeartbeatTime = Prelude.Nothing,
         _PendingActivityInfo'lastStartedTime = Prelude.Nothing,
         _PendingActivityInfo'attempt = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'maximumAttempts = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'scheduledTime = Prelude.Nothing,
         _PendingActivityInfo'expirationTime = Prelude.Nothing,
         _PendingActivityInfo'lastFailure = Prelude.Nothing,
         _PendingActivityInfo'lastWorkerIdentity = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'lastWorkerVersionStamp = Prelude.Nothing,
         _PendingActivityInfo'currentRetryInterval = Prelude.Nothing,
         _PendingActivityInfo'lastAttemptCompleteTime = Prelude.Nothing,
         _PendingActivityInfo'nextAttemptScheduleTime = Prelude.Nothing,
         _PendingActivityInfo'paused = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'lastDeployment = Prelude.Nothing,
         _PendingActivityInfo'lastWorkerDeploymentVersion = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'priority = Prelude.Nothing,
         _PendingActivityInfo'pauseInfo = Prelude.Nothing,
         _PendingActivityInfo'assignedBuildId = Prelude.Nothing,
         _PendingActivityInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PendingActivityInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser PendingActivityInfo
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
                                       "activity_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"activityId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "activity_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activityType") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "heartbeat_details"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"heartbeatDetails") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_heartbeat_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastHeartbeatTime") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_started_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastStartedTime") y x)
                        56
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attempt"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"attempt") y x)
                        64
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "maximum_attempts"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"maximumAttempts") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "scheduled_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduledTime") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "expiration_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"expirationTime") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_failure"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"lastFailure") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "last_worker_identity"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastWorkerIdentity") y x)
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_worker_version_stamp"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastWorkerVersionStamp") y x)
                        130
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "current_retry_interval"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentRetryInterval") y x)
                        138
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_attempt_complete_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAttemptCompleteTime") y x)
                        146
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "next_attempt_schedule_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nextAttemptScheduleTime") y x)
                        152
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "paused"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"paused") y x)
                        162
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_deployment"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastDeployment") y x)
                        170
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "last_worker_deployment_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastWorkerDeploymentVersion") y
                                     x)
                        178
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "priority"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"priority") y x)
                        186
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "pause_info"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"pauseInfo") y x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "use_workflow_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"useWorkflowBuildId") y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "last_independently_assigned_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"lastIndependentlyAssignedBuildId")
                                     y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "PendingActivityInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"activityId") _x
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
                       (Data.ProtoLens.Field.field @"maybe'activityType") _x
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
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'heartbeatDetails") _x
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
                                (Data.ProtoLens.Field.field @"maybe'lastHeartbeatTime") _x
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
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'lastStartedTime") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (let
                                  _v = Lens.Family2.view (Data.ProtoLens.Field.field @"attempt") _x
                                in
                                  if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                      Data.Monoid.mempty
                                  else
                                      (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 56)
                                        ((Prelude..)
                                           Data.ProtoLens.Encoding.Bytes.putVarInt
                                           Prelude.fromIntegral _v))
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
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt 64)
                                           ((Prelude..)
                                              Data.ProtoLens.Encoding.Bytes.putVarInt
                                              Prelude.fromIntegral _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'scheduledTime") _x
                                      of
                                        Prelude.Nothing -> Data.Monoid.mempty
                                        (Prelude.Just _v)
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                               ((Prelude..)
                                                  (\ bs
                                                     -> (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             (Prelude.fromIntegral
                                                                (Data.ByteString.length bs)))
                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                             bs))
                                                  Data.ProtoLens.encodeMessage _v))
                                     ((Data.Monoid.<>)
                                        (case
                                             Lens.Family2.view
                                               (Data.ProtoLens.Field.field @"maybe'expirationTime")
                                               _x
                                         of
                                           Prelude.Nothing -> Data.Monoid.mempty
                                           (Prelude.Just _v)
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                                  ((Prelude..)
                                                     (\ bs
                                                        -> (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                (Prelude.fromIntegral
                                                                   (Data.ByteString.length bs)))
                                                             (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                bs))
                                                     Data.ProtoLens.encodeMessage _v))
                                        ((Data.Monoid.<>)
                                           (case
                                                Lens.Family2.view
                                                  (Data.ProtoLens.Field.field @"maybe'lastFailure")
                                                  _x
                                            of
                                              Prelude.Nothing -> Data.Monoid.mempty
                                              (Prelude.Just _v)
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                     ((Prelude..)
                                                        (\ bs
                                                           -> (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (Prelude.fromIntegral
                                                                      (Data.ByteString.length bs)))
                                                                (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                   bs))
                                                        Data.ProtoLens.encodeMessage _v))
                                           ((Data.Monoid.<>)
                                              (let
                                                 _v
                                                   = Lens.Family2.view
                                                       (Data.ProtoLens.Field.field
                                                          @"lastWorkerIdentity")
                                                       _x
                                               in
                                                 if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                     Data.Monoid.mempty
                                                 else
                                                     (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                                                       ((Prelude..)
                                                          (\ bs
                                                             -> (Data.Monoid.<>)
                                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                     (Prelude.fromIntegral
                                                                        (Data.ByteString.length
                                                                           bs)))
                                                                  (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                     bs))
                                                          Data.Text.Encoding.encodeUtf8 _v))
                                              ((Data.Monoid.<>)
                                                 (case
                                                      Lens.Family2.view
                                                        (Data.ProtoLens.Field.field
                                                           @"maybe'lastWorkerVersionStamp")
                                                        _x
                                                  of
                                                    Prelude.Nothing -> Data.Monoid.mempty
                                                    (Prelude.Just _v)
                                                      -> (Data.Monoid.<>)
                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                              122)
                                                           ((Prelude..)
                                                              (\ bs
                                                                 -> (Data.Monoid.<>)
                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         (Prelude.fromIntegral
                                                                            (Data.ByteString.length
                                                                               bs)))
                                                                      (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                         bs))
                                                              Data.ProtoLens.encodeMessage _v))
                                                 ((Data.Monoid.<>)
                                                    (case
                                                         Lens.Family2.view
                                                           (Data.ProtoLens.Field.field
                                                              @"maybe'currentRetryInterval")
                                                           _x
                                                     of
                                                       Prelude.Nothing -> Data.Monoid.mempty
                                                       (Prelude.Just _v)
                                                         -> (Data.Monoid.<>)
                                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                 130)
                                                              ((Prelude..)
                                                                 (\ bs
                                                                    -> (Data.Monoid.<>)
                                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                            (Prelude.fromIntegral
                                                                               (Data.ByteString.length
                                                                                  bs)))
                                                                         (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                            bs))
                                                                 Data.ProtoLens.encodeMessage _v))
                                                    ((Data.Monoid.<>)
                                                       (case
                                                            Lens.Family2.view
                                                              (Data.ProtoLens.Field.field
                                                                 @"maybe'lastAttemptCompleteTime")
                                                              _x
                                                        of
                                                          Prelude.Nothing -> Data.Monoid.mempty
                                                          (Prelude.Just _v)
                                                            -> (Data.Monoid.<>)
                                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                    138)
                                                                 ((Prelude..)
                                                                    (\ bs
                                                                       -> (Data.Monoid.<>)
                                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                               (Prelude.fromIntegral
                                                                                  (Data.ByteString.length
                                                                                     bs)))
                                                                            (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                               bs))
                                                                    Data.ProtoLens.encodeMessage
                                                                    _v))
                                                       ((Data.Monoid.<>)
                                                          (case
                                                               Lens.Family2.view
                                                                 (Data.ProtoLens.Field.field
                                                                    @"maybe'nextAttemptScheduleTime")
                                                                 _x
                                                           of
                                                             Prelude.Nothing -> Data.Monoid.mempty
                                                             (Prelude.Just _v)
                                                               -> (Data.Monoid.<>)
                                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                       146)
                                                                    ((Prelude..)
                                                                       (\ bs
                                                                          -> (Data.Monoid.<>)
                                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  (Prelude.fromIntegral
                                                                                     (Data.ByteString.length
                                                                                        bs)))
                                                                               (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                  bs))
                                                                       Data.ProtoLens.encodeMessage
                                                                       _v))
                                                          ((Data.Monoid.<>)
                                                             (let
                                                                _v
                                                                  = Lens.Family2.view
                                                                      (Data.ProtoLens.Field.field
                                                                         @"paused")
                                                                      _x
                                                              in
                                                                if (Prelude.==)
                                                                     _v
                                                                     Data.ProtoLens.fieldDefault then
                                                                    Data.Monoid.mempty
                                                                else
                                                                    (Data.Monoid.<>)
                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         152)
                                                                      ((Prelude..)
                                                                         Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         (\ b -> if b then 1 else 0)
                                                                         _v))
                                                             ((Data.Monoid.<>)
                                                                (case
                                                                     Lens.Family2.view
                                                                       (Data.ProtoLens.Field.field
                                                                          @"maybe'lastDeployment")
                                                                       _x
                                                                 of
                                                                   Prelude.Nothing
                                                                     -> Data.Monoid.mempty
                                                                   (Prelude.Just _v)
                                                                     -> (Data.Monoid.<>)
                                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                             162)
                                                                          ((Prelude..)
                                                                             (\ bs
                                                                                -> (Data.Monoid.<>)
                                                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                        (Prelude.fromIntegral
                                                                                           (Data.ByteString.length
                                                                                              bs)))
                                                                                     (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                        bs))
                                                                             Data.ProtoLens.encodeMessage
                                                                             _v))
                                                                ((Data.Monoid.<>)
                                                                   (let
                                                                      _v
                                                                        = Lens.Family2.view
                                                                            (Data.ProtoLens.Field.field
                                                                               @"lastWorkerDeploymentVersion")
                                                                            _x
                                                                    in
                                                                      if (Prelude.==)
                                                                           _v
                                                                           Data.ProtoLens.fieldDefault then
                                                                          Data.Monoid.mempty
                                                                      else
                                                                          (Data.Monoid.<>)
                                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                               170)
                                                                            ((Prelude..)
                                                                               (\ bs
                                                                                  -> (Data.Monoid.<>)
                                                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                          (Prelude.fromIntegral
                                                                                             (Data.ByteString.length
                                                                                                bs)))
                                                                                       (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                          bs))
                                                                               Data.Text.Encoding.encodeUtf8
                                                                               _v))
                                                                   ((Data.Monoid.<>)
                                                                      (case
                                                                           Lens.Family2.view
                                                                             (Data.ProtoLens.Field.field
                                                                                @"maybe'priority")
                                                                             _x
                                                                       of
                                                                         Prelude.Nothing
                                                                           -> Data.Monoid.mempty
                                                                         (Prelude.Just _v)
                                                                           -> (Data.Monoid.<>)
                                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                   178)
                                                                                ((Prelude..)
                                                                                   (\ bs
                                                                                      -> (Data.Monoid.<>)
                                                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                              (Prelude.fromIntegral
                                                                                                 (Data.ByteString.length
                                                                                                    bs)))
                                                                                           (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                              bs))
                                                                                   Data.ProtoLens.encodeMessage
                                                                                   _v))
                                                                      ((Data.Monoid.<>)
                                                                         (case
                                                                              Lens.Family2.view
                                                                                (Data.ProtoLens.Field.field
                                                                                   @"maybe'pauseInfo")
                                                                                _x
                                                                          of
                                                                            Prelude.Nothing
                                                                              -> Data.Monoid.mempty
                                                                            (Prelude.Just _v)
                                                                              -> (Data.Monoid.<>)
                                                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                      186)
                                                                                   ((Prelude..)
                                                                                      (\ bs
                                                                                         -> (Data.Monoid.<>)
                                                                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                 (Prelude.fromIntegral
                                                                                                    (Data.ByteString.length
                                                                                                       bs)))
                                                                                              (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                 bs))
                                                                                      Data.ProtoLens.encodeMessage
                                                                                      _v))
                                                                         ((Data.Monoid.<>)
                                                                            (case
                                                                                 Lens.Family2.view
                                                                                   (Data.ProtoLens.Field.field
                                                                                      @"maybe'assignedBuildId")
                                                                                   _x
                                                                             of
                                                                               Prelude.Nothing
                                                                                 -> Data.Monoid.mempty
                                                                               (Prelude.Just (PendingActivityInfo'UseWorkflowBuildId v))
                                                                                 -> (Data.Monoid.<>)
                                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                         106)
                                                                                      ((Prelude..)
                                                                                         (\ bs
                                                                                            -> (Data.Monoid.<>)
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                    (Prelude.fromIntegral
                                                                                                       (Data.ByteString.length
                                                                                                          bs)))
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                    bs))
                                                                                         Data.ProtoLens.encodeMessage
                                                                                         v)
                                                                               (Prelude.Just (PendingActivityInfo'LastIndependentlyAssignedBuildId v))
                                                                                 -> (Data.Monoid.<>)
                                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                         114)
                                                                                      ((Prelude..)
                                                                                         (\ bs
                                                                                            -> (Data.Monoid.<>)
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                    (Prelude.fromIntegral
                                                                                                       (Data.ByteString.length
                                                                                                          bs)))
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                    bs))
                                                                                         Data.Text.Encoding.encodeUtf8
                                                                                         v))
                                                                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                                               (Lens.Family2.view
                                                                                  Data.ProtoLens.unknownFields
                                                                                  _x)))))))))))))))))))))))
instance Control.DeepSeq.NFData PendingActivityInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PendingActivityInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_PendingActivityInfo'activityId x__)
                (Control.DeepSeq.deepseq
                   (_PendingActivityInfo'activityType x__)
                   (Control.DeepSeq.deepseq
                      (_PendingActivityInfo'state x__)
                      (Control.DeepSeq.deepseq
                         (_PendingActivityInfo'heartbeatDetails x__)
                         (Control.DeepSeq.deepseq
                            (_PendingActivityInfo'lastHeartbeatTime x__)
                            (Control.DeepSeq.deepseq
                               (_PendingActivityInfo'lastStartedTime x__)
                               (Control.DeepSeq.deepseq
                                  (_PendingActivityInfo'attempt x__)
                                  (Control.DeepSeq.deepseq
                                     (_PendingActivityInfo'maximumAttempts x__)
                                     (Control.DeepSeq.deepseq
                                        (_PendingActivityInfo'scheduledTime x__)
                                        (Control.DeepSeq.deepseq
                                           (_PendingActivityInfo'expirationTime x__)
                                           (Control.DeepSeq.deepseq
                                              (_PendingActivityInfo'lastFailure x__)
                                              (Control.DeepSeq.deepseq
                                                 (_PendingActivityInfo'lastWorkerIdentity x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_PendingActivityInfo'lastWorkerVersionStamp
                                                       x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_PendingActivityInfo'currentRetryInterval
                                                          x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_PendingActivityInfo'lastAttemptCompleteTime
                                                             x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_PendingActivityInfo'nextAttemptScheduleTime
                                                                x__)
                                                             (Control.DeepSeq.deepseq
                                                                (_PendingActivityInfo'paused x__)
                                                                (Control.DeepSeq.deepseq
                                                                   (_PendingActivityInfo'lastDeployment
                                                                      x__)
                                                                   (Control.DeepSeq.deepseq
                                                                      (_PendingActivityInfo'lastWorkerDeploymentVersion
                                                                         x__)
                                                                      (Control.DeepSeq.deepseq
                                                                         (_PendingActivityInfo'priority
                                                                            x__)
                                                                         (Control.DeepSeq.deepseq
                                                                            (_PendingActivityInfo'pauseInfo
                                                                               x__)
                                                                            (Control.DeepSeq.deepseq
                                                                               (_PendingActivityInfo'assignedBuildId
                                                                                  x__)
                                                                               ()))))))))))))))))))))))
instance Control.DeepSeq.NFData PendingActivityInfo'AssignedBuildId where
  rnf (PendingActivityInfo'UseWorkflowBuildId x__)
    = Control.DeepSeq.rnf x__
  rnf (PendingActivityInfo'LastIndependentlyAssignedBuildId x__)
    = Control.DeepSeq.rnf x__
_PendingActivityInfo'UseWorkflowBuildId ::
  Data.ProtoLens.Prism.Prism' PendingActivityInfo'AssignedBuildId Proto.Google.Protobuf.Empty.Empty
_PendingActivityInfo'UseWorkflowBuildId
  = Data.ProtoLens.Prism.prism'
      PendingActivityInfo'UseWorkflowBuildId
      (\ p__
         -> case p__ of
              (PendingActivityInfo'UseWorkflowBuildId p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_PendingActivityInfo'LastIndependentlyAssignedBuildId ::
  Data.ProtoLens.Prism.Prism' PendingActivityInfo'AssignedBuildId Data.Text.Text
_PendingActivityInfo'LastIndependentlyAssignedBuildId
  = Data.ProtoLens.Prism.prism'
      PendingActivityInfo'LastIndependentlyAssignedBuildId
      (\ p__
         -> case p__ of
              (PendingActivityInfo'LastIndependentlyAssignedBuildId p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.pauseTime' @:: Lens' PendingActivityInfo'PauseInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'pauseTime' @:: Lens' PendingActivityInfo'PauseInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'pausedBy' @:: Lens' PendingActivityInfo'PauseInfo (Prelude.Maybe PendingActivityInfo'PauseInfo'PausedBy)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'manual' @:: Lens' PendingActivityInfo'PauseInfo (Prelude.Maybe PendingActivityInfo'PauseInfo'Manual)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.manual' @:: Lens' PendingActivityInfo'PauseInfo PendingActivityInfo'PauseInfo'Manual@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'ruleId' @:: Lens' PendingActivityInfo'PauseInfo (Prelude.Maybe Data.Text.Text)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.ruleId' @:: Lens' PendingActivityInfo'PauseInfo Data.Text.Text@ -}
data PendingActivityInfo'PauseInfo
  = PendingActivityInfo'PauseInfo'_constructor {_PendingActivityInfo'PauseInfo'pauseTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                _PendingActivityInfo'PauseInfo'pausedBy :: !(Prelude.Maybe PendingActivityInfo'PauseInfo'PausedBy),
                                                _PendingActivityInfo'PauseInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PendingActivityInfo'PauseInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data PendingActivityInfo'PauseInfo'PausedBy
  = PendingActivityInfo'PauseInfo'Manual' !PendingActivityInfo'PauseInfo'Manual |
    PendingActivityInfo'PauseInfo'RuleId !Data.Text.Text
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo "pauseTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'pauseTime
           (\ x__ y__
              -> x__ {_PendingActivityInfo'PauseInfo'pauseTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo "maybe'pauseTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'pauseTime
           (\ x__ y__
              -> x__ {_PendingActivityInfo'PauseInfo'pauseTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo "maybe'pausedBy" (Prelude.Maybe PendingActivityInfo'PauseInfo'PausedBy) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'pausedBy
           (\ x__ y__ -> x__ {_PendingActivityInfo'PauseInfo'pausedBy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo "maybe'manual" (Prelude.Maybe PendingActivityInfo'PauseInfo'Manual) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'pausedBy
           (\ x__ y__ -> x__ {_PendingActivityInfo'PauseInfo'pausedBy = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (PendingActivityInfo'PauseInfo'Manual' x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap PendingActivityInfo'PauseInfo'Manual' y__))
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo "manual" PendingActivityInfo'PauseInfo'Manual where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'pausedBy
           (\ x__ y__ -> x__ {_PendingActivityInfo'PauseInfo'pausedBy = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (PendingActivityInfo'PauseInfo'Manual' x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap PendingActivityInfo'PauseInfo'Manual' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo "maybe'ruleId" (Prelude.Maybe Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'pausedBy
           (\ x__ y__ -> x__ {_PendingActivityInfo'PauseInfo'pausedBy = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (PendingActivityInfo'PauseInfo'RuleId x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap PendingActivityInfo'PauseInfo'RuleId y__))
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo "ruleId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'pausedBy
           (\ x__ y__ -> x__ {_PendingActivityInfo'PauseInfo'pausedBy = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (PendingActivityInfo'PauseInfo'RuleId x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap PendingActivityInfo'PauseInfo'RuleId y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Message PendingActivityInfo'PauseInfo where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.PendingActivityInfo.PauseInfo"
  packedMessageDescriptor _
    = "\n\
      \\tPauseInfo\DC29\n\
      \\n\
      \pause_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\tpauseTime\DC2X\n\
      \\ACKmanual\CAN\STX \SOH(\v2>.temporal.api.workflow.v1.PendingActivityInfo.PauseInfo.ManualH\NULR\ACKmanual\DC2\EM\n\
      \\arule_id\CAN\ETX \SOH(\tH\NULR\ACKruleId\SUB<\n\
      \\ACKManual\DC2\SUB\n\
      \\bidentity\CAN\SOH \SOH(\tR\bidentity\DC2\SYN\n\
      \\ACKreason\CAN\STX \SOH(\tR\ACKreasonB\v\n\
      \\tpaused_by"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        pauseTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "pause_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'pauseTime")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo'PauseInfo
        manual__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "manual"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor PendingActivityInfo'PauseInfo'Manual)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'manual")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo'PauseInfo
        ruleId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rule_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'ruleId")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo'PauseInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, pauseTime__field_descriptor),
           (Data.ProtoLens.Tag 2, manual__field_descriptor),
           (Data.ProtoLens.Tag 3, ruleId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PendingActivityInfo'PauseInfo'_unknownFields
        (\ x__ y__
           -> x__ {_PendingActivityInfo'PauseInfo'_unknownFields = y__})
  defMessage
    = PendingActivityInfo'PauseInfo'_constructor
        {_PendingActivityInfo'PauseInfo'pauseTime = Prelude.Nothing,
         _PendingActivityInfo'PauseInfo'pausedBy = Prelude.Nothing,
         _PendingActivityInfo'PauseInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PendingActivityInfo'PauseInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser PendingActivityInfo'PauseInfo
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
                                       "pause_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"pauseTime") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "manual"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"manual") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "rule_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"ruleId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "PauseInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'pauseTime") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'pausedBy") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (PendingActivityInfo'PauseInfo'Manual' v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (PendingActivityInfo'PauseInfo'RuleId v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.Text.Encoding.encodeUtf8 v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData PendingActivityInfo'PauseInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PendingActivityInfo'PauseInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_PendingActivityInfo'PauseInfo'pauseTime x__)
                (Control.DeepSeq.deepseq
                   (_PendingActivityInfo'PauseInfo'pausedBy x__) ()))
instance Control.DeepSeq.NFData PendingActivityInfo'PauseInfo'PausedBy where
  rnf (PendingActivityInfo'PauseInfo'Manual' x__)
    = Control.DeepSeq.rnf x__
  rnf (PendingActivityInfo'PauseInfo'RuleId x__)
    = Control.DeepSeq.rnf x__
_PendingActivityInfo'PauseInfo'Manual' ::
  Data.ProtoLens.Prism.Prism' PendingActivityInfo'PauseInfo'PausedBy PendingActivityInfo'PauseInfo'Manual
_PendingActivityInfo'PauseInfo'Manual'
  = Data.ProtoLens.Prism.prism'
      PendingActivityInfo'PauseInfo'Manual'
      (\ p__
         -> case p__ of
              (PendingActivityInfo'PauseInfo'Manual' p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_PendingActivityInfo'PauseInfo'RuleId ::
  Data.ProtoLens.Prism.Prism' PendingActivityInfo'PauseInfo'PausedBy Data.Text.Text
_PendingActivityInfo'PauseInfo'RuleId
  = Data.ProtoLens.Prism.prism'
      PendingActivityInfo'PauseInfo'RuleId
      (\ p__
         -> case p__ of
              (PendingActivityInfo'PauseInfo'RuleId p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.identity' @:: Lens' PendingActivityInfo'PauseInfo'Manual Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.reason' @:: Lens' PendingActivityInfo'PauseInfo'Manual Data.Text.Text@ -}
data PendingActivityInfo'PauseInfo'Manual
  = PendingActivityInfo'PauseInfo'Manual'_constructor {_PendingActivityInfo'PauseInfo'Manual'identity :: !Data.Text.Text,
                                                       _PendingActivityInfo'PauseInfo'Manual'reason :: !Data.Text.Text,
                                                       _PendingActivityInfo'PauseInfo'Manual'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PendingActivityInfo'PauseInfo'Manual where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo'Manual "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'Manual'identity
           (\ x__ y__
              -> x__ {_PendingActivityInfo'PauseInfo'Manual'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingActivityInfo'PauseInfo'Manual "reason" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingActivityInfo'PauseInfo'Manual'reason
           (\ x__ y__
              -> x__ {_PendingActivityInfo'PauseInfo'Manual'reason = y__}))
        Prelude.id
instance Data.ProtoLens.Message PendingActivityInfo'PauseInfo'Manual where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.PendingActivityInfo.PauseInfo.Manual"
  packedMessageDescriptor _
    = "\n\
      \\ACKManual\DC2\SUB\n\
      \\bidentity\CAN\SOH \SOH(\tR\bidentity\DC2\SYN\n\
      \\ACKreason\CAN\STX \SOH(\tR\ACKreason"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo'PauseInfo'Manual
        reason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"reason")) ::
              Data.ProtoLens.FieldDescriptor PendingActivityInfo'PauseInfo'Manual
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, identity__field_descriptor),
           (Data.ProtoLens.Tag 2, reason__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PendingActivityInfo'PauseInfo'Manual'_unknownFields
        (\ x__ y__
           -> x__
                {_PendingActivityInfo'PauseInfo'Manual'_unknownFields = y__})
  defMessage
    = PendingActivityInfo'PauseInfo'Manual'_constructor
        {_PendingActivityInfo'PauseInfo'Manual'identity = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'PauseInfo'Manual'reason = Data.ProtoLens.fieldDefault,
         _PendingActivityInfo'PauseInfo'Manual'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PendingActivityInfo'PauseInfo'Manual
          -> Data.ProtoLens.Encoding.Bytes.Parser PendingActivityInfo'PauseInfo'Manual
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
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "reason"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"reason") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Manual"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"reason") _x
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
instance Control.DeepSeq.NFData PendingActivityInfo'PauseInfo'Manual where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PendingActivityInfo'PauseInfo'Manual'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_PendingActivityInfo'PauseInfo'Manual'identity x__)
                (Control.DeepSeq.deepseq
                   (_PendingActivityInfo'PauseInfo'Manual'reason x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowId' @:: Lens' PendingChildExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.runId' @:: Lens' PendingChildExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowTypeName' @:: Lens' PendingChildExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.initiatedId' @:: Lens' PendingChildExecutionInfo Data.Int.Int64@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.parentClosePolicy' @:: Lens' PendingChildExecutionInfo Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy@ -}
data PendingChildExecutionInfo
  = PendingChildExecutionInfo'_constructor {_PendingChildExecutionInfo'workflowId :: !Data.Text.Text,
                                            _PendingChildExecutionInfo'runId :: !Data.Text.Text,
                                            _PendingChildExecutionInfo'workflowTypeName :: !Data.Text.Text,
                                            _PendingChildExecutionInfo'initiatedId :: !Data.Int.Int64,
                                            _PendingChildExecutionInfo'parentClosePolicy :: !Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy,
                                            _PendingChildExecutionInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PendingChildExecutionInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField PendingChildExecutionInfo "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingChildExecutionInfo'workflowId
           (\ x__ y__ -> x__ {_PendingChildExecutionInfo'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingChildExecutionInfo "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingChildExecutionInfo'runId
           (\ x__ y__ -> x__ {_PendingChildExecutionInfo'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingChildExecutionInfo "workflowTypeName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingChildExecutionInfo'workflowTypeName
           (\ x__ y__
              -> x__ {_PendingChildExecutionInfo'workflowTypeName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingChildExecutionInfo "initiatedId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingChildExecutionInfo'initiatedId
           (\ x__ y__ -> x__ {_PendingChildExecutionInfo'initiatedId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingChildExecutionInfo "parentClosePolicy" Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingChildExecutionInfo'parentClosePolicy
           (\ x__ y__
              -> x__ {_PendingChildExecutionInfo'parentClosePolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Message PendingChildExecutionInfo where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.PendingChildExecutionInfo"
  packedMessageDescriptor _
    = "\n\
      \\EMPendingChildExecutionInfo\DC2\US\n\
      \\vworkflow_id\CAN\SOH \SOH(\tR\n\
      \workflowId\DC2\NAK\n\
      \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\DC2,\n\
      \\DC2workflow_type_name\CAN\ETX \SOH(\tR\DLEworkflowTypeName\DC2!\n\
      \\finitiated_id\CAN\EOT \SOH(\ETXR\vinitiatedId\DC2X\n\
      \\DC3parent_close_policy\CAN\ENQ \SOH(\SO2(.temporal.api.enums.v1.ParentClosePolicyR\DC1parentClosePolicy"
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
              Data.ProtoLens.FieldDescriptor PendingChildExecutionInfo
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor PendingChildExecutionInfo
        workflowTypeName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_type_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowTypeName")) ::
              Data.ProtoLens.FieldDescriptor PendingChildExecutionInfo
        initiatedId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "initiated_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"initiatedId")) ::
              Data.ProtoLens.FieldDescriptor PendingChildExecutionInfo
        parentClosePolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "parent_close_policy"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.ParentClosePolicy)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"parentClosePolicy")) ::
              Data.ProtoLens.FieldDescriptor PendingChildExecutionInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 2, runId__field_descriptor),
           (Data.ProtoLens.Tag 3, workflowTypeName__field_descriptor),
           (Data.ProtoLens.Tag 4, initiatedId__field_descriptor),
           (Data.ProtoLens.Tag 5, parentClosePolicy__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PendingChildExecutionInfo'_unknownFields
        (\ x__ y__
           -> x__ {_PendingChildExecutionInfo'_unknownFields = y__})
  defMessage
    = PendingChildExecutionInfo'_constructor
        {_PendingChildExecutionInfo'workflowId = Data.ProtoLens.fieldDefault,
         _PendingChildExecutionInfo'runId = Data.ProtoLens.fieldDefault,
         _PendingChildExecutionInfo'workflowTypeName = Data.ProtoLens.fieldDefault,
         _PendingChildExecutionInfo'initiatedId = Data.ProtoLens.fieldDefault,
         _PendingChildExecutionInfo'parentClosePolicy = Data.ProtoLens.fieldDefault,
         _PendingChildExecutionInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PendingChildExecutionInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser PendingChildExecutionInfo
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
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "workflow_type_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowTypeName") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "initiated_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"initiatedId") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "parent_close_policy"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"parentClosePolicy") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "PendingChildExecutionInfo"
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
                ((Data.Monoid.<>)
                   (let
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"workflowTypeName") _x
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
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"initiatedId") _x
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
                                  (Data.ProtoLens.Field.field @"parentClosePolicy") _x
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
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData PendingChildExecutionInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PendingChildExecutionInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_PendingChildExecutionInfo'workflowId x__)
                (Control.DeepSeq.deepseq
                   (_PendingChildExecutionInfo'runId x__)
                   (Control.DeepSeq.deepseq
                      (_PendingChildExecutionInfo'workflowTypeName x__)
                      (Control.DeepSeq.deepseq
                         (_PendingChildExecutionInfo'initiatedId x__)
                         (Control.DeepSeq.deepseq
                            (_PendingChildExecutionInfo'parentClosePolicy x__) ())))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.endpoint' @:: Lens' PendingNexusOperationInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.service' @:: Lens' PendingNexusOperationInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.operation' @:: Lens' PendingNexusOperationInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.operationId' @:: Lens' PendingNexusOperationInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.scheduleToCloseTimeout' @:: Lens' PendingNexusOperationInfo Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'scheduleToCloseTimeout' @:: Lens' PendingNexusOperationInfo (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.scheduledTime' @:: Lens' PendingNexusOperationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'scheduledTime' @:: Lens' PendingNexusOperationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.state' @:: Lens' PendingNexusOperationInfo Proto.Temporal.Api.Enums.V1.Common.PendingNexusOperationState@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attempt' @:: Lens' PendingNexusOperationInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastAttemptCompleteTime' @:: Lens' PendingNexusOperationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastAttemptCompleteTime' @:: Lens' PendingNexusOperationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastAttemptFailure' @:: Lens' PendingNexusOperationInfo Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastAttemptFailure' @:: Lens' PendingNexusOperationInfo (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.nextAttemptScheduleTime' @:: Lens' PendingNexusOperationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'nextAttemptScheduleTime' @:: Lens' PendingNexusOperationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.cancellationInfo' @:: Lens' PendingNexusOperationInfo NexusOperationCancellationInfo@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'cancellationInfo' @:: Lens' PendingNexusOperationInfo (Prelude.Maybe NexusOperationCancellationInfo)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.scheduledEventId' @:: Lens' PendingNexusOperationInfo Data.Int.Int64@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.blockedReason' @:: Lens' PendingNexusOperationInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.operationToken' @:: Lens' PendingNexusOperationInfo Data.Text.Text@ -}
data PendingNexusOperationInfo
  = PendingNexusOperationInfo'_constructor {_PendingNexusOperationInfo'endpoint :: !Data.Text.Text,
                                            _PendingNexusOperationInfo'service :: !Data.Text.Text,
                                            _PendingNexusOperationInfo'operation :: !Data.Text.Text,
                                            _PendingNexusOperationInfo'operationId :: !Data.Text.Text,
                                            _PendingNexusOperationInfo'scheduleToCloseTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                            _PendingNexusOperationInfo'scheduledTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                            _PendingNexusOperationInfo'state :: !Proto.Temporal.Api.Enums.V1.Common.PendingNexusOperationState,
                                            _PendingNexusOperationInfo'attempt :: !Data.Int.Int32,
                                            _PendingNexusOperationInfo'lastAttemptCompleteTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                            _PendingNexusOperationInfo'lastAttemptFailure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                            _PendingNexusOperationInfo'nextAttemptScheduleTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                            _PendingNexusOperationInfo'cancellationInfo :: !(Prelude.Maybe NexusOperationCancellationInfo),
                                            _PendingNexusOperationInfo'scheduledEventId :: !Data.Int.Int64,
                                            _PendingNexusOperationInfo'blockedReason :: !Data.Text.Text,
                                            _PendingNexusOperationInfo'operationToken :: !Data.Text.Text,
                                            _PendingNexusOperationInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PendingNexusOperationInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "endpoint" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'endpoint
           (\ x__ y__ -> x__ {_PendingNexusOperationInfo'endpoint = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "service" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'service
           (\ x__ y__ -> x__ {_PendingNexusOperationInfo'service = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "operation" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'operation
           (\ x__ y__ -> x__ {_PendingNexusOperationInfo'operation = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "operationId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'operationId
           (\ x__ y__ -> x__ {_PendingNexusOperationInfo'operationId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "scheduleToCloseTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'scheduleToCloseTimeout
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'scheduleToCloseTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "maybe'scheduleToCloseTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'scheduleToCloseTimeout
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'scheduleToCloseTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "scheduledTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'scheduledTime
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'scheduledTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "maybe'scheduledTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'scheduledTime
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'scheduledTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "state" Proto.Temporal.Api.Enums.V1.Common.PendingNexusOperationState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'state
           (\ x__ y__ -> x__ {_PendingNexusOperationInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "attempt" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'attempt
           (\ x__ y__ -> x__ {_PendingNexusOperationInfo'attempt = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "lastAttemptCompleteTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'lastAttemptCompleteTime
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'lastAttemptCompleteTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "maybe'lastAttemptCompleteTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'lastAttemptCompleteTime
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'lastAttemptCompleteTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "lastAttemptFailure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'lastAttemptFailure
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'lastAttemptFailure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "maybe'lastAttemptFailure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'lastAttemptFailure
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'lastAttemptFailure = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "nextAttemptScheduleTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'nextAttemptScheduleTime
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'nextAttemptScheduleTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "maybe'nextAttemptScheduleTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'nextAttemptScheduleTime
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'nextAttemptScheduleTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "cancellationInfo" NexusOperationCancellationInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'cancellationInfo
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'cancellationInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "maybe'cancellationInfo" (Prelude.Maybe NexusOperationCancellationInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'cancellationInfo
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'cancellationInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "scheduledEventId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'scheduledEventId
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'scheduledEventId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "blockedReason" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'blockedReason
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'blockedReason = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingNexusOperationInfo "operationToken" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingNexusOperationInfo'operationToken
           (\ x__ y__
              -> x__ {_PendingNexusOperationInfo'operationToken = y__}))
        Prelude.id
instance Data.ProtoLens.Message PendingNexusOperationInfo where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.PendingNexusOperationInfo"
  packedMessageDescriptor _
    = "\n\
      \\EMPendingNexusOperationInfo\DC2\SUB\n\
      \\bendpoint\CAN\SOH \SOH(\tR\bendpoint\DC2\CAN\n\
      \\aservice\CAN\STX \SOH(\tR\aservice\DC2\FS\n\
      \\toperation\CAN\ETX \SOH(\tR\toperation\DC2!\n\
      \\foperation_id\CAN\EOT \SOH(\tR\voperationId\DC2T\n\
      \\EMschedule_to_close_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToCloseTimeout\DC2A\n\
      \\SOscheduled_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2G\n\
      \\ENQstate\CAN\a \SOH(\SO21.temporal.api.enums.v1.PendingNexusOperationStateR\ENQstate\DC2\CAN\n\
      \\aattempt\CAN\b \SOH(\ENQR\aattempt\DC2W\n\
      \\SUBlast_attempt_complete_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2R\n\
      \\DC4last_attempt_failure\CAN\n\
      \ \SOH(\v2 .temporal.api.failure.v1.FailureR\DC2lastAttemptFailure\DC2W\n\
      \\SUBnext_attempt_schedule_time\CAN\v \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2e\n\
      \\DC1cancellation_info\CAN\f \SOH(\v28.temporal.api.workflow.v1.NexusOperationCancellationInfoR\DLEcancellationInfo\DC2,\n\
      \\DC2scheduled_event_id\CAN\r \SOH(\ETXR\DLEscheduledEventId\DC2%\n\
      \\SOblocked_reason\CAN\SO \SOH(\tR\rblockedReason\DC2'\n\
      \\SIoperation_token\CAN\SI \SOH(\tR\SOoperationToken"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        endpoint__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "endpoint"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"endpoint")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        service__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "service"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"service")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        operation__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operation")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        operationId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operationId")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        scheduleToCloseTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schedule_to_close_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduleToCloseTimeout")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        scheduledTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scheduled_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduledTime")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.PendingNexusOperationState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        attempt__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attempt"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"attempt")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        lastAttemptCompleteTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_attempt_complete_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAttemptCompleteTime")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        lastAttemptFailure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_attempt_failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastAttemptFailure")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        nextAttemptScheduleTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "next_attempt_schedule_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'nextAttemptScheduleTime")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        cancellationInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancellation_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor NexusOperationCancellationInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancellationInfo")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        scheduledEventId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scheduled_event_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"scheduledEventId")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        blockedReason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "blocked_reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"blockedReason")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
        operationToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operationToken")) ::
              Data.ProtoLens.FieldDescriptor PendingNexusOperationInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, endpoint__field_descriptor),
           (Data.ProtoLens.Tag 2, service__field_descriptor),
           (Data.ProtoLens.Tag 3, operation__field_descriptor),
           (Data.ProtoLens.Tag 4, operationId__field_descriptor),
           (Data.ProtoLens.Tag 5, scheduleToCloseTimeout__field_descriptor),
           (Data.ProtoLens.Tag 6, scheduledTime__field_descriptor),
           (Data.ProtoLens.Tag 7, state__field_descriptor),
           (Data.ProtoLens.Tag 8, attempt__field_descriptor),
           (Data.ProtoLens.Tag 9, lastAttemptCompleteTime__field_descriptor),
           (Data.ProtoLens.Tag 10, lastAttemptFailure__field_descriptor),
           (Data.ProtoLens.Tag 11, nextAttemptScheduleTime__field_descriptor),
           (Data.ProtoLens.Tag 12, cancellationInfo__field_descriptor),
           (Data.ProtoLens.Tag 13, scheduledEventId__field_descriptor),
           (Data.ProtoLens.Tag 14, blockedReason__field_descriptor),
           (Data.ProtoLens.Tag 15, operationToken__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PendingNexusOperationInfo'_unknownFields
        (\ x__ y__
           -> x__ {_PendingNexusOperationInfo'_unknownFields = y__})
  defMessage
    = PendingNexusOperationInfo'_constructor
        {_PendingNexusOperationInfo'endpoint = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'service = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'operation = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'operationId = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'scheduleToCloseTimeout = Prelude.Nothing,
         _PendingNexusOperationInfo'scheduledTime = Prelude.Nothing,
         _PendingNexusOperationInfo'state = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'attempt = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'lastAttemptCompleteTime = Prelude.Nothing,
         _PendingNexusOperationInfo'lastAttemptFailure = Prelude.Nothing,
         _PendingNexusOperationInfo'nextAttemptScheduleTime = Prelude.Nothing,
         _PendingNexusOperationInfo'cancellationInfo = Prelude.Nothing,
         _PendingNexusOperationInfo'scheduledEventId = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'blockedReason = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'operationToken = Data.ProtoLens.fieldDefault,
         _PendingNexusOperationInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PendingNexusOperationInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser PendingNexusOperationInfo
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
                                       "endpoint"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"endpoint") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "service"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"service") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "operation"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"operation") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "operation_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"operationId") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "schedule_to_close_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduleToCloseTimeout") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "scheduled_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduledTime") y x)
                        56
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                        64
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attempt"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"attempt") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_attempt_complete_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAttemptCompleteTime") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_attempt_failure"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastAttemptFailure") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "next_attempt_schedule_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nextAttemptScheduleTime") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancellation_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cancellationInfo") y x)
                        104
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "scheduled_event_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"scheduledEventId") y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "blocked_reason"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"blockedReason") y x)
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "operation_token"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"operationToken") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "PendingNexusOperationInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"endpoint") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"service") _x
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
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"operation") _x
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
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"operationId") _x
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
                              Lens.Family2.view
                                (Data.ProtoLens.Field.field @"maybe'scheduleToCloseTimeout") _x
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
                            (case
                                 Lens.Family2.view
                                   (Data.ProtoLens.Field.field @"maybe'scheduledTime") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (let
                                  _v = Lens.Family2.view (Data.ProtoLens.Field.field @"state") _x
                                in
                                  if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                      Data.Monoid.mempty
                                  else
                                      (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 56)
                                        ((Prelude..)
                                           ((Prelude..)
                                              Data.ProtoLens.Encoding.Bytes.putVarInt
                                              Prelude.fromIntegral)
                                           Prelude.fromEnum _v))
                               ((Data.Monoid.<>)
                                  (let
                                     _v
                                       = Lens.Family2.view
                                           (Data.ProtoLens.Field.field @"attempt") _x
                                   in
                                     if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                         Data.Monoid.mempty
                                     else
                                         (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt 64)
                                           ((Prelude..)
                                              Data.ProtoLens.Encoding.Bytes.putVarInt
                                              Prelude.fromIntegral _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field
                                               @"maybe'lastAttemptCompleteTime")
                                            _x
                                      of
                                        Prelude.Nothing -> Data.Monoid.mempty
                                        (Prelude.Just _v)
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                               ((Prelude..)
                                                  (\ bs
                                                     -> (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             (Prelude.fromIntegral
                                                                (Data.ByteString.length bs)))
                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                             bs))
                                                  Data.ProtoLens.encodeMessage _v))
                                     ((Data.Monoid.<>)
                                        (case
                                             Lens.Family2.view
                                               (Data.ProtoLens.Field.field
                                                  @"maybe'lastAttemptFailure")
                                               _x
                                         of
                                           Prelude.Nothing -> Data.Monoid.mempty
                                           (Prelude.Just _v)
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                                  ((Prelude..)
                                                     (\ bs
                                                        -> (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                (Prelude.fromIntegral
                                                                   (Data.ByteString.length bs)))
                                                             (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                bs))
                                                     Data.ProtoLens.encodeMessage _v))
                                        ((Data.Monoid.<>)
                                           (case
                                                Lens.Family2.view
                                                  (Data.ProtoLens.Field.field
                                                     @"maybe'nextAttemptScheduleTime")
                                                  _x
                                            of
                                              Prelude.Nothing -> Data.Monoid.mempty
                                              (Prelude.Just _v)
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                     ((Prelude..)
                                                        (\ bs
                                                           -> (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (Prelude.fromIntegral
                                                                      (Data.ByteString.length bs)))
                                                                (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                   bs))
                                                        Data.ProtoLens.encodeMessage _v))
                                           ((Data.Monoid.<>)
                                              (case
                                                   Lens.Family2.view
                                                     (Data.ProtoLens.Field.field
                                                        @"maybe'cancellationInfo")
                                                     _x
                                               of
                                                 Prelude.Nothing -> Data.Monoid.mempty
                                                 (Prelude.Just _v)
                                                   -> (Data.Monoid.<>)
                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                                                        ((Prelude..)
                                                           (\ bs
                                                              -> (Data.Monoid.<>)
                                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                      (Prelude.fromIntegral
                                                                         (Data.ByteString.length
                                                                            bs)))
                                                                   (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                      bs))
                                                           Data.ProtoLens.encodeMessage _v))
                                              ((Data.Monoid.<>)
                                                 (let
                                                    _v
                                                      = Lens.Family2.view
                                                          (Data.ProtoLens.Field.field
                                                             @"scheduledEventId")
                                                          _x
                                                  in
                                                    if (Prelude.==)
                                                         _v Data.ProtoLens.fieldDefault then
                                                        Data.Monoid.mempty
                                                    else
                                                        (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             104)
                                                          ((Prelude..)
                                                             Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             Prelude.fromIntegral _v))
                                                 ((Data.Monoid.<>)
                                                    (let
                                                       _v
                                                         = Lens.Family2.view
                                                             (Data.ProtoLens.Field.field
                                                                @"blockedReason")
                                                             _x
                                                     in
                                                       if (Prelude.==)
                                                            _v Data.ProtoLens.fieldDefault then
                                                           Data.Monoid.mempty
                                                       else
                                                           (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                114)
                                                             ((Prelude..)
                                                                (\ bs
                                                                   -> (Data.Monoid.<>)
                                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                           (Prelude.fromIntegral
                                                                              (Data.ByteString.length
                                                                                 bs)))
                                                                        (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                           bs))
                                                                Data.Text.Encoding.encodeUtf8 _v))
                                                    ((Data.Monoid.<>)
                                                       (let
                                                          _v
                                                            = Lens.Family2.view
                                                                (Data.ProtoLens.Field.field
                                                                   @"operationToken")
                                                                _x
                                                        in
                                                          if (Prelude.==)
                                                               _v Data.ProtoLens.fieldDefault then
                                                              Data.Monoid.mempty
                                                          else
                                                              (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   122)
                                                                ((Prelude..)
                                                                   (\ bs
                                                                      -> (Data.Monoid.<>)
                                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                              (Prelude.fromIntegral
                                                                                 (Data.ByteString.length
                                                                                    bs)))
                                                                           (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                              bs))
                                                                   Data.Text.Encoding.encodeUtf8
                                                                   _v))
                                                       (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                          (Lens.Family2.view
                                                             Data.ProtoLens.unknownFields
                                                             _x))))))))))))))))
instance Control.DeepSeq.NFData PendingNexusOperationInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PendingNexusOperationInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_PendingNexusOperationInfo'endpoint x__)
                (Control.DeepSeq.deepseq
                   (_PendingNexusOperationInfo'service x__)
                   (Control.DeepSeq.deepseq
                      (_PendingNexusOperationInfo'operation x__)
                      (Control.DeepSeq.deepseq
                         (_PendingNexusOperationInfo'operationId x__)
                         (Control.DeepSeq.deepseq
                            (_PendingNexusOperationInfo'scheduleToCloseTimeout x__)
                            (Control.DeepSeq.deepseq
                               (_PendingNexusOperationInfo'scheduledTime x__)
                               (Control.DeepSeq.deepseq
                                  (_PendingNexusOperationInfo'state x__)
                                  (Control.DeepSeq.deepseq
                                     (_PendingNexusOperationInfo'attempt x__)
                                     (Control.DeepSeq.deepseq
                                        (_PendingNexusOperationInfo'lastAttemptCompleteTime x__)
                                        (Control.DeepSeq.deepseq
                                           (_PendingNexusOperationInfo'lastAttemptFailure x__)
                                           (Control.DeepSeq.deepseq
                                              (_PendingNexusOperationInfo'nextAttemptScheduleTime
                                                 x__)
                                              (Control.DeepSeq.deepseq
                                                 (_PendingNexusOperationInfo'cancellationInfo x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_PendingNexusOperationInfo'scheduledEventId
                                                       x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_PendingNexusOperationInfo'blockedReason
                                                          x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_PendingNexusOperationInfo'operationToken
                                                             x__)
                                                          ())))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.state' @:: Lens' PendingWorkflowTaskInfo Proto.Temporal.Api.Enums.V1.Workflow.PendingWorkflowTaskState@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.scheduledTime' @:: Lens' PendingWorkflowTaskInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'scheduledTime' @:: Lens' PendingWorkflowTaskInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.originalScheduledTime' @:: Lens' PendingWorkflowTaskInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'originalScheduledTime' @:: Lens' PendingWorkflowTaskInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.startedTime' @:: Lens' PendingWorkflowTaskInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'startedTime' @:: Lens' PendingWorkflowTaskInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.attempt' @:: Lens' PendingWorkflowTaskInfo Data.Int.Int32@ -}
data PendingWorkflowTaskInfo
  = PendingWorkflowTaskInfo'_constructor {_PendingWorkflowTaskInfo'state :: !Proto.Temporal.Api.Enums.V1.Workflow.PendingWorkflowTaskState,
                                          _PendingWorkflowTaskInfo'scheduledTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                          _PendingWorkflowTaskInfo'originalScheduledTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                          _PendingWorkflowTaskInfo'startedTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                          _PendingWorkflowTaskInfo'attempt :: !Data.Int.Int32,
                                          _PendingWorkflowTaskInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PendingWorkflowTaskInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "state" Proto.Temporal.Api.Enums.V1.Workflow.PendingWorkflowTaskState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'state
           (\ x__ y__ -> x__ {_PendingWorkflowTaskInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "scheduledTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'scheduledTime
           (\ x__ y__ -> x__ {_PendingWorkflowTaskInfo'scheduledTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "maybe'scheduledTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'scheduledTime
           (\ x__ y__ -> x__ {_PendingWorkflowTaskInfo'scheduledTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "originalScheduledTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'originalScheduledTime
           (\ x__ y__
              -> x__ {_PendingWorkflowTaskInfo'originalScheduledTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "maybe'originalScheduledTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'originalScheduledTime
           (\ x__ y__
              -> x__ {_PendingWorkflowTaskInfo'originalScheduledTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "startedTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'startedTime
           (\ x__ y__ -> x__ {_PendingWorkflowTaskInfo'startedTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "maybe'startedTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'startedTime
           (\ x__ y__ -> x__ {_PendingWorkflowTaskInfo'startedTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField PendingWorkflowTaskInfo "attempt" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PendingWorkflowTaskInfo'attempt
           (\ x__ y__ -> x__ {_PendingWorkflowTaskInfo'attempt = y__}))
        Prelude.id
instance Data.ProtoLens.Message PendingWorkflowTaskInfo where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.PendingWorkflowTaskInfo"
  packedMessageDescriptor _
    = "\n\
      \\ETBPendingWorkflowTaskInfo\DC2E\n\
      \\ENQstate\CAN\SOH \SOH(\SO2/.temporal.api.enums.v1.PendingWorkflowTaskStateR\ENQstate\DC2A\n\
      \\SOscheduled_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2R\n\
      \\ETBoriginal_scheduled_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\NAKoriginalScheduledTime\DC2=\n\
      \\fstarted_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\vstartedTime\DC2\CAN\n\
      \\aattempt\CAN\ENQ \SOH(\ENQR\aattempt"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.PendingWorkflowTaskState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor PendingWorkflowTaskInfo
        scheduledTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scheduled_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'scheduledTime")) ::
              Data.ProtoLens.FieldDescriptor PendingWorkflowTaskInfo
        originalScheduledTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "original_scheduled_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'originalScheduledTime")) ::
              Data.ProtoLens.FieldDescriptor PendingWorkflowTaskInfo
        startedTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "started_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startedTime")) ::
              Data.ProtoLens.FieldDescriptor PendingWorkflowTaskInfo
        attempt__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attempt"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"attempt")) ::
              Data.ProtoLens.FieldDescriptor PendingWorkflowTaskInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, state__field_descriptor),
           (Data.ProtoLens.Tag 2, scheduledTime__field_descriptor),
           (Data.ProtoLens.Tag 3, originalScheduledTime__field_descriptor),
           (Data.ProtoLens.Tag 4, startedTime__field_descriptor),
           (Data.ProtoLens.Tag 5, attempt__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PendingWorkflowTaskInfo'_unknownFields
        (\ x__ y__ -> x__ {_PendingWorkflowTaskInfo'_unknownFields = y__})
  defMessage
    = PendingWorkflowTaskInfo'_constructor
        {_PendingWorkflowTaskInfo'state = Data.ProtoLens.fieldDefault,
         _PendingWorkflowTaskInfo'scheduledTime = Prelude.Nothing,
         _PendingWorkflowTaskInfo'originalScheduledTime = Prelude.Nothing,
         _PendingWorkflowTaskInfo'startedTime = Prelude.Nothing,
         _PendingWorkflowTaskInfo'attempt = Data.ProtoLens.fieldDefault,
         _PendingWorkflowTaskInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PendingWorkflowTaskInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser PendingWorkflowTaskInfo
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
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
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
                                       "original_scheduled_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"originalScheduledTime") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "started_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"startedTime") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attempt"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"attempt") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "PendingWorkflowTaskInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"state") _x
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
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'originalScheduledTime") _x
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
                             (Data.ProtoLens.Field.field @"maybe'startedTime") _x
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
                         (let
                            _v = Lens.Family2.view (Data.ProtoLens.Field.field @"attempt") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral
                                     _v))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData PendingWorkflowTaskInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PendingWorkflowTaskInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_PendingWorkflowTaskInfo'state x__)
                (Control.DeepSeq.deepseq
                   (_PendingWorkflowTaskInfo'scheduledTime x__)
                   (Control.DeepSeq.deepseq
                      (_PendingWorkflowTaskInfo'originalScheduledTime x__)
                      (Control.DeepSeq.deepseq
                         (_PendingWorkflowTaskInfo'startedTime x__)
                         (Control.DeepSeq.deepseq
                            (_PendingWorkflowTaskInfo'attempt x__) ())))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.buildId' @:: Lens' ResetPointInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.binaryChecksum' @:: Lens' ResetPointInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.runId' @:: Lens' ResetPointInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.firstWorkflowTaskCompletedId' @:: Lens' ResetPointInfo Data.Int.Int64@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.createTime' @:: Lens' ResetPointInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'createTime' @:: Lens' ResetPointInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.expireTime' @:: Lens' ResetPointInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'expireTime' @:: Lens' ResetPointInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.resettable' @:: Lens' ResetPointInfo Prelude.Bool@ -}
data ResetPointInfo
  = ResetPointInfo'_constructor {_ResetPointInfo'buildId :: !Data.Text.Text,
                                 _ResetPointInfo'binaryChecksum :: !Data.Text.Text,
                                 _ResetPointInfo'runId :: !Data.Text.Text,
                                 _ResetPointInfo'firstWorkflowTaskCompletedId :: !Data.Int.Int64,
                                 _ResetPointInfo'createTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                 _ResetPointInfo'expireTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                 _ResetPointInfo'resettable :: !Prelude.Bool,
                                 _ResetPointInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResetPointInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResetPointInfo "buildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'buildId
           (\ x__ y__ -> x__ {_ResetPointInfo'buildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetPointInfo "binaryChecksum" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'binaryChecksum
           (\ x__ y__ -> x__ {_ResetPointInfo'binaryChecksum = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetPointInfo "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'runId
           (\ x__ y__ -> x__ {_ResetPointInfo'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetPointInfo "firstWorkflowTaskCompletedId" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'firstWorkflowTaskCompletedId
           (\ x__ y__
              -> x__ {_ResetPointInfo'firstWorkflowTaskCompletedId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetPointInfo "createTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'createTime
           (\ x__ y__ -> x__ {_ResetPointInfo'createTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ResetPointInfo "maybe'createTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'createTime
           (\ x__ y__ -> x__ {_ResetPointInfo'createTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetPointInfo "expireTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'expireTime
           (\ x__ y__ -> x__ {_ResetPointInfo'expireTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ResetPointInfo "maybe'expireTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'expireTime
           (\ x__ y__ -> x__ {_ResetPointInfo'expireTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResetPointInfo "resettable" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPointInfo'resettable
           (\ x__ y__ -> x__ {_ResetPointInfo'resettable = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResetPointInfo where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.ResetPointInfo"
  packedMessageDescriptor _
    = "\n\
      \\SOResetPointInfo\DC2\EM\n\
      \\bbuild_id\CAN\a \SOH(\tR\abuildId\DC2'\n\
      \\SIbinary_checksum\CAN\SOH \SOH(\tR\SObinaryChecksum\DC2\NAK\n\
      \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\DC2F\n\
      \ first_workflow_task_completed_id\CAN\ETX \SOH(\ETXR\FSfirstWorkflowTaskCompletedId\DC2;\n\
      \\vcreate_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \createTime\DC2;\n\
      \\vexpire_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \expireTime\DC2\RS\n\
      \\n\
      \resettable\CAN\ACK \SOH(\bR\n\
      \resettable"
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
              Data.ProtoLens.FieldDescriptor ResetPointInfo
        binaryChecksum__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "binary_checksum"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"binaryChecksum")) ::
              Data.ProtoLens.FieldDescriptor ResetPointInfo
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor ResetPointInfo
        firstWorkflowTaskCompletedId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "first_workflow_task_completed_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"firstWorkflowTaskCompletedId")) ::
              Data.ProtoLens.FieldDescriptor ResetPointInfo
        createTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "create_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'createTime")) ::
              Data.ProtoLens.FieldDescriptor ResetPointInfo
        expireTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "expire_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'expireTime")) ::
              Data.ProtoLens.FieldDescriptor ResetPointInfo
        resettable__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "resettable"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"resettable")) ::
              Data.ProtoLens.FieldDescriptor ResetPointInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 7, buildId__field_descriptor),
           (Data.ProtoLens.Tag 1, binaryChecksum__field_descriptor),
           (Data.ProtoLens.Tag 2, runId__field_descriptor),
           (Data.ProtoLens.Tag 3, 
            firstWorkflowTaskCompletedId__field_descriptor),
           (Data.ProtoLens.Tag 4, createTime__field_descriptor),
           (Data.ProtoLens.Tag 5, expireTime__field_descriptor),
           (Data.ProtoLens.Tag 6, resettable__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResetPointInfo'_unknownFields
        (\ x__ y__ -> x__ {_ResetPointInfo'_unknownFields = y__})
  defMessage
    = ResetPointInfo'_constructor
        {_ResetPointInfo'buildId = Data.ProtoLens.fieldDefault,
         _ResetPointInfo'binaryChecksum = Data.ProtoLens.fieldDefault,
         _ResetPointInfo'runId = Data.ProtoLens.fieldDefault,
         _ResetPointInfo'firstWorkflowTaskCompletedId = Data.ProtoLens.fieldDefault,
         _ResetPointInfo'createTime = Prelude.Nothing,
         _ResetPointInfo'expireTime = Prelude.Nothing,
         _ResetPointInfo'resettable = Data.ProtoLens.fieldDefault,
         _ResetPointInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResetPointInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser ResetPointInfo
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
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "build_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"buildId") y x)
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "binary_checksum"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"binaryChecksum") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "run_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"runId") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "first_workflow_task_completed_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"firstWorkflowTaskCompletedId") y
                                     x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "create_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"createTime") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "expire_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"expireTime") y x)
                        48
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "resettable"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"resettable") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ResetPointInfo"
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
                         (Data.ProtoLens.Field.field @"binaryChecksum") _x
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
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"firstWorkflowTaskCompletedId") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view
                                (Data.ProtoLens.Field.field @"maybe'createTime") _x
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
                                   (Data.ProtoLens.Field.field @"maybe'expireTime") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            ((Data.Monoid.<>)
                               (let
                                  _v
                                    = Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"resettable") _x
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
instance Control.DeepSeq.NFData ResetPointInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResetPointInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResetPointInfo'buildId x__)
                (Control.DeepSeq.deepseq
                   (_ResetPointInfo'binaryChecksum x__)
                   (Control.DeepSeq.deepseq
                      (_ResetPointInfo'runId x__)
                      (Control.DeepSeq.deepseq
                         (_ResetPointInfo'firstWorkflowTaskCompletedId x__)
                         (Control.DeepSeq.deepseq
                            (_ResetPointInfo'createTime x__)
                            (Control.DeepSeq.deepseq
                               (_ResetPointInfo'expireTime x__)
                               (Control.DeepSeq.deepseq (_ResetPointInfo'resettable x__) ())))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.points' @:: Lens' ResetPoints [ResetPointInfo]@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.vec'points' @:: Lens' ResetPoints (Data.Vector.Vector ResetPointInfo)@ -}
data ResetPoints
  = ResetPoints'_constructor {_ResetPoints'points :: !(Data.Vector.Vector ResetPointInfo),
                              _ResetPoints'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResetPoints where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResetPoints "points" [ResetPointInfo] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPoints'points (\ x__ y__ -> x__ {_ResetPoints'points = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ResetPoints "vec'points" (Data.Vector.Vector ResetPointInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResetPoints'points (\ x__ y__ -> x__ {_ResetPoints'points = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResetPoints where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.ResetPoints"
  packedMessageDescriptor _
    = "\n\
      \\vResetPoints\DC2@\n\
      \\ACKpoints\CAN\SOH \ETX(\v2(.temporal.api.workflow.v1.ResetPointInfoR\ACKpoints"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        points__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "points"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResetPointInfo)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"points")) ::
              Data.ProtoLens.FieldDescriptor ResetPoints
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, points__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResetPoints'_unknownFields
        (\ x__ y__ -> x__ {_ResetPoints'_unknownFields = y__})
  defMessage
    = ResetPoints'_constructor
        {_ResetPoints'points = Data.Vector.Generic.empty,
         _ResetPoints'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResetPoints
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld ResetPointInfo
             -> Data.ProtoLens.Encoding.Bytes.Parser ResetPoints
        loop x mutable'points
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'points <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'points)
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
                              (Data.ProtoLens.Field.field @"vec'points") frozen'points x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "points"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'points y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'points
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'points <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'points)
          "ResetPoints"
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
                (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'points") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData ResetPoints where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResetPoints'_unknownFields x__)
             (Control.DeepSeq.deepseq (_ResetPoints'points x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.behavior' @:: Lens' VersioningOverride Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.deployment' @:: Lens' VersioningOverride Proto.Temporal.Api.Deployment.V1.Message.Deployment@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'deployment' @:: Lens' VersioningOverride (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.pinnedVersion' @:: Lens' VersioningOverride Data.Text.Text@ -}
data VersioningOverride
  = VersioningOverride'_constructor {_VersioningOverride'behavior :: !Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior,
                                     _VersioningOverride'deployment :: !(Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment),
                                     _VersioningOverride'pinnedVersion :: !Data.Text.Text,
                                     _VersioningOverride'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show VersioningOverride where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField VersioningOverride "behavior" Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersioningOverride'behavior
           (\ x__ y__ -> x__ {_VersioningOverride'behavior = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField VersioningOverride "deployment" Proto.Temporal.Api.Deployment.V1.Message.Deployment where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersioningOverride'deployment
           (\ x__ y__ -> x__ {_VersioningOverride'deployment = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField VersioningOverride "maybe'deployment" (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersioningOverride'deployment
           (\ x__ y__ -> x__ {_VersioningOverride'deployment = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField VersioningOverride "pinnedVersion" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersioningOverride'pinnedVersion
           (\ x__ y__ -> x__ {_VersioningOverride'pinnedVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Message VersioningOverride where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.VersioningOverride"
  packedMessageDescriptor _
    = "\n\
      \\DC2VersioningOverride\DC2E\n\
      \\bbehavior\CAN\SOH \SOH(\SO2).temporal.api.enums.v1.VersioningBehaviorR\bbehavior\DC2J\n\
      \\n\
      \deployment\CAN\STX \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\n\
      \deploymentB\STX\CAN\SOH\DC2%\n\
      \\SOpinned_version\CAN\t \SOH(\tR\rpinnedVersion"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        behavior__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "behavior"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"behavior")) ::
              Data.ProtoLens.FieldDescriptor VersioningOverride
        deployment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "deployment"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Deployment.V1.Message.Deployment)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'deployment")) ::
              Data.ProtoLens.FieldDescriptor VersioningOverride
        pinnedVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "pinned_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"pinnedVersion")) ::
              Data.ProtoLens.FieldDescriptor VersioningOverride
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, behavior__field_descriptor),
           (Data.ProtoLens.Tag 2, deployment__field_descriptor),
           (Data.ProtoLens.Tag 9, pinnedVersion__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _VersioningOverride'_unknownFields
        (\ x__ y__ -> x__ {_VersioningOverride'_unknownFields = y__})
  defMessage
    = VersioningOverride'_constructor
        {_VersioningOverride'behavior = Data.ProtoLens.fieldDefault,
         _VersioningOverride'deployment = Prelude.Nothing,
         _VersioningOverride'pinnedVersion = Data.ProtoLens.fieldDefault,
         _VersioningOverride'_unknownFields = []}
  parseMessage
    = let
        loop ::
          VersioningOverride
          -> Data.ProtoLens.Encoding.Bytes.Parser VersioningOverride
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
                                       "behavior"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"behavior") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "deployment"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"deployment") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "pinned_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"pinnedVersion") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "VersioningOverride"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"behavior") _x
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
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'deployment") _x
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
                            (Data.ProtoLens.Field.field @"pinnedVersion") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData VersioningOverride where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_VersioningOverride'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_VersioningOverride'behavior x__)
                (Control.DeepSeq.deepseq
                   (_VersioningOverride'deployment x__)
                   (Control.DeepSeq.deepseq
                      (_VersioningOverride'pinnedVersion x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.taskQueue' @:: Lens' WorkflowExecutionConfig Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'taskQueue' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowExecutionTimeout' @:: Lens' WorkflowExecutionConfig Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowExecutionTimeout' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowRunTimeout' @:: Lens' WorkflowExecutionConfig Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowRunTimeout' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.defaultWorkflowTaskTimeout' @:: Lens' WorkflowExecutionConfig Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'defaultWorkflowTaskTimeout' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.userMetadata' @:: Lens' WorkflowExecutionConfig Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'userMetadata' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata)@ -}
data WorkflowExecutionConfig
  = WorkflowExecutionConfig'_constructor {_WorkflowExecutionConfig'taskQueue :: !(Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue),
                                          _WorkflowExecutionConfig'workflowExecutionTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                          _WorkflowExecutionConfig'workflowRunTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                          _WorkflowExecutionConfig'defaultWorkflowTaskTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                          _WorkflowExecutionConfig'userMetadata :: !(Prelude.Maybe Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata),
                                          _WorkflowExecutionConfig'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowExecutionConfig where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "taskQueue" Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'taskQueue
           (\ x__ y__ -> x__ {_WorkflowExecutionConfig'taskQueue = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "maybe'taskQueue" (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'taskQueue
           (\ x__ y__ -> x__ {_WorkflowExecutionConfig'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "workflowExecutionTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'workflowExecutionTimeout
           (\ x__ y__
              -> x__ {_WorkflowExecutionConfig'workflowExecutionTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "maybe'workflowExecutionTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'workflowExecutionTimeout
           (\ x__ y__
              -> x__ {_WorkflowExecutionConfig'workflowExecutionTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "workflowRunTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'workflowRunTimeout
           (\ x__ y__
              -> x__ {_WorkflowExecutionConfig'workflowRunTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "maybe'workflowRunTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'workflowRunTimeout
           (\ x__ y__
              -> x__ {_WorkflowExecutionConfig'workflowRunTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "defaultWorkflowTaskTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'defaultWorkflowTaskTimeout
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionConfig'defaultWorkflowTaskTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "maybe'defaultWorkflowTaskTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'defaultWorkflowTaskTimeout
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionConfig'defaultWorkflowTaskTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "userMetadata" Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'userMetadata
           (\ x__ y__ -> x__ {_WorkflowExecutionConfig'userMetadata = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionConfig "maybe'userMetadata" (Prelude.Maybe Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionConfig'userMetadata
           (\ x__ y__ -> x__ {_WorkflowExecutionConfig'userMetadata = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowExecutionConfig where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.WorkflowExecutionConfig"
  packedMessageDescriptor _
    = "\n\
      \\ETBWorkflowExecutionConfig\DC2C\n\
      \\n\
      \task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC2W\n\
      \\SUBworkflow_execution_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeout\DC2K\n\
      \\DC4workflow_run_timeout\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeout\DC2\\\n\
      \\GSdefault_workflow_task_timeout\CAN\EOT \SOH(\v2\EM.google.protobuf.DurationR\SUBdefaultWorkflowTaskTimeout\DC2F\n\
      \\ruser_metadata\CAN\ENQ \SOH(\v2!.temporal.api.sdk.v1.UserMetadataR\fuserMetadata"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'taskQueue")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionConfig
        workflowExecutionTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionConfig
        workflowRunTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_run_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionConfig
        defaultWorkflowTaskTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "default_workflow_task_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'defaultWorkflowTaskTimeout")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionConfig
        userMetadata__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "user_metadata"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Sdk.V1.UserMetadata.UserMetadata)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'userMetadata")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionConfig
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowExecutionTimeout__field_descriptor),
           (Data.ProtoLens.Tag 3, workflowRunTimeout__field_descriptor),
           (Data.ProtoLens.Tag 4, 
            defaultWorkflowTaskTimeout__field_descriptor),
           (Data.ProtoLens.Tag 5, userMetadata__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowExecutionConfig'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowExecutionConfig'_unknownFields = y__})
  defMessage
    = WorkflowExecutionConfig'_constructor
        {_WorkflowExecutionConfig'taskQueue = Prelude.Nothing,
         _WorkflowExecutionConfig'workflowExecutionTimeout = Prelude.Nothing,
         _WorkflowExecutionConfig'workflowRunTimeout = Prelude.Nothing,
         _WorkflowExecutionConfig'defaultWorkflowTaskTimeout = Prelude.Nothing,
         _WorkflowExecutionConfig'userMetadata = Prelude.Nothing,
         _WorkflowExecutionConfig'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowExecutionConfig
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowExecutionConfig
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
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_execution_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecutionTimeout") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_run_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowRunTimeout") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "default_workflow_task_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"defaultWorkflowTaskTimeout") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "user_metadata"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"userMetadata") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowExecutionConfig"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'taskQueue") _x
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
                       (Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout") _x
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
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout") _x
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
                             (Data.ProtoLens.Field.field @"maybe'defaultWorkflowTaskTimeout") _x
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
                                (Data.ProtoLens.Field.field @"maybe'userMetadata") _x
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
instance Control.DeepSeq.NFData WorkflowExecutionConfig where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowExecutionConfig'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowExecutionConfig'taskQueue x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowExecutionConfig'workflowExecutionTimeout x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowExecutionConfig'workflowRunTimeout x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowExecutionConfig'defaultWorkflowTaskTimeout x__)
                         (Control.DeepSeq.deepseq
                            (_WorkflowExecutionConfig'userMetadata x__) ())))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.executionExpirationTime' @:: Lens' WorkflowExecutionExtendedInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'executionExpirationTime' @:: Lens' WorkflowExecutionExtendedInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.runExpirationTime' @:: Lens' WorkflowExecutionExtendedInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'runExpirationTime' @:: Lens' WorkflowExecutionExtendedInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.cancelRequested' @:: Lens' WorkflowExecutionExtendedInfo Prelude.Bool@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastResetTime' @:: Lens' WorkflowExecutionExtendedInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'lastResetTime' @:: Lens' WorkflowExecutionExtendedInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.originalStartTime' @:: Lens' WorkflowExecutionExtendedInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'originalStartTime' @:: Lens' WorkflowExecutionExtendedInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.resetRunId' @:: Lens' WorkflowExecutionExtendedInfo Data.Text.Text@ -}
data WorkflowExecutionExtendedInfo
  = WorkflowExecutionExtendedInfo'_constructor {_WorkflowExecutionExtendedInfo'executionExpirationTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                _WorkflowExecutionExtendedInfo'runExpirationTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                _WorkflowExecutionExtendedInfo'cancelRequested :: !Prelude.Bool,
                                                _WorkflowExecutionExtendedInfo'lastResetTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                _WorkflowExecutionExtendedInfo'originalStartTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                                _WorkflowExecutionExtendedInfo'resetRunId :: !Data.Text.Text,
                                                _WorkflowExecutionExtendedInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowExecutionExtendedInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "executionExpirationTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'executionExpirationTime
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionExtendedInfo'executionExpirationTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "maybe'executionExpirationTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'executionExpirationTime
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionExtendedInfo'executionExpirationTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "runExpirationTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'runExpirationTime
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'runExpirationTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "maybe'runExpirationTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'runExpirationTime
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'runExpirationTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "cancelRequested" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'cancelRequested
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'cancelRequested = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "lastResetTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'lastResetTime
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'lastResetTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "maybe'lastResetTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'lastResetTime
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'lastResetTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "originalStartTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'originalStartTime
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'originalStartTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "maybe'originalStartTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'originalStartTime
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'originalStartTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionExtendedInfo "resetRunId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionExtendedInfo'resetRunId
           (\ x__ y__
              -> x__ {_WorkflowExecutionExtendedInfo'resetRunId = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowExecutionExtendedInfo where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.WorkflowExecutionExtendedInfo"
  packedMessageDescriptor _
    = "\n\
      \\GSWorkflowExecutionExtendedInfo\DC2V\n\
      \\EMexecution_expiration_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ETBexecutionExpirationTime\DC2J\n\
      \\DC3run_expiration_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\DC1runExpirationTime\DC2)\n\
      \\DLEcancel_requested\CAN\ETX \SOH(\bR\SIcancelRequested\DC2B\n\
      \\SIlast_reset_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\rlastResetTime\DC2J\n\
      \\DC3original_start_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DC1originalStartTime\DC2 \n\
      \\freset_run_id\CAN\ACK \SOH(\tR\n\
      \resetRunId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        executionExpirationTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "execution_expiration_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'executionExpirationTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionExtendedInfo
        runExpirationTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_expiration_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'runExpirationTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionExtendedInfo
        cancelRequested__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel_requested"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"cancelRequested")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionExtendedInfo
        lastResetTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_reset_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastResetTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionExtendedInfo
        originalStartTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "original_start_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'originalStartTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionExtendedInfo
        resetRunId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reset_run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"resetRunId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionExtendedInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, executionExpirationTime__field_descriptor),
           (Data.ProtoLens.Tag 2, runExpirationTime__field_descriptor),
           (Data.ProtoLens.Tag 3, cancelRequested__field_descriptor),
           (Data.ProtoLens.Tag 4, lastResetTime__field_descriptor),
           (Data.ProtoLens.Tag 5, originalStartTime__field_descriptor),
           (Data.ProtoLens.Tag 6, resetRunId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowExecutionExtendedInfo'_unknownFields
        (\ x__ y__
           -> x__ {_WorkflowExecutionExtendedInfo'_unknownFields = y__})
  defMessage
    = WorkflowExecutionExtendedInfo'_constructor
        {_WorkflowExecutionExtendedInfo'executionExpirationTime = Prelude.Nothing,
         _WorkflowExecutionExtendedInfo'runExpirationTime = Prelude.Nothing,
         _WorkflowExecutionExtendedInfo'cancelRequested = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionExtendedInfo'lastResetTime = Prelude.Nothing,
         _WorkflowExecutionExtendedInfo'originalStartTime = Prelude.Nothing,
         _WorkflowExecutionExtendedInfo'resetRunId = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionExtendedInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowExecutionExtendedInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowExecutionExtendedInfo
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
                                       "execution_expiration_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"executionExpirationTime") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "run_expiration_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"runExpirationTime") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "cancel_requested"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cancelRequested") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_reset_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastResetTime") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "original_start_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"originalStartTime") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "reset_run_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"resetRunId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowExecutionExtendedInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'executionExpirationTime") _x
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
                       (Data.ProtoLens.Field.field @"maybe'runExpirationTime") _x
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
                            (Data.ProtoLens.Field.field @"cancelRequested") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                               _v))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'lastResetTime") _x
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
                                (Data.ProtoLens.Field.field @"maybe'originalStartTime") _x
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
                               _v
                                 = Lens.Family2.view (Data.ProtoLens.Field.field @"resetRunId") _x
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
instance Control.DeepSeq.NFData WorkflowExecutionExtendedInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowExecutionExtendedInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowExecutionExtendedInfo'executionExpirationTime x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowExecutionExtendedInfo'runExpirationTime x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowExecutionExtendedInfo'cancelRequested x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowExecutionExtendedInfo'lastResetTime x__)
                         (Control.DeepSeq.deepseq
                            (_WorkflowExecutionExtendedInfo'originalStartTime x__)
                            (Control.DeepSeq.deepseq
                               (_WorkflowExecutionExtendedInfo'resetRunId x__) ()))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.execution' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.WorkflowExecution@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'execution' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.type'' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.WorkflowType@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'type'' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.startTime' @:: Lens' WorkflowExecutionInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'startTime' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.closeTime' @:: Lens' WorkflowExecutionInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'closeTime' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.status' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.historyLength' @:: Lens' WorkflowExecutionInfo Data.Int.Int64@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.parentNamespaceId' @:: Lens' WorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.parentExecution' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.WorkflowExecution@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'parentExecution' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.executionTime' @:: Lens' WorkflowExecutionInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'executionTime' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.memo' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.Memo@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'memo' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.searchAttributes' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.SearchAttributes@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'searchAttributes' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.autoResetPoints' @:: Lens' WorkflowExecutionInfo ResetPoints@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'autoResetPoints' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe ResetPoints)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.taskQueue' @:: Lens' WorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.stateTransitionCount' @:: Lens' WorkflowExecutionInfo Data.Int.Int64@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.historySizeBytes' @:: Lens' WorkflowExecutionInfo Data.Int.Int64@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.mostRecentWorkerVersionStamp' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'mostRecentWorkerVersionStamp' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.executionDuration' @:: Lens' WorkflowExecutionInfo Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'executionDuration' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.rootExecution' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.WorkflowExecution@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'rootExecution' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.assignedBuildId' @:: Lens' WorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.inheritedBuildId' @:: Lens' WorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.firstRunId' @:: Lens' WorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.versioningInfo' @:: Lens' WorkflowExecutionInfo WorkflowExecutionVersioningInfo@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'versioningInfo' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe WorkflowExecutionVersioningInfo)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workerDeploymentName' @:: Lens' WorkflowExecutionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.priority' @:: Lens' WorkflowExecutionInfo Proto.Temporal.Api.Common.V1.Message.Priority@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'priority' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority)@ -}
data WorkflowExecutionInfo
  = WorkflowExecutionInfo'_constructor {_WorkflowExecutionInfo'execution :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution),
                                        _WorkflowExecutionInfo'type' :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType),
                                        _WorkflowExecutionInfo'startTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                        _WorkflowExecutionInfo'closeTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                        _WorkflowExecutionInfo'status :: !Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus,
                                        _WorkflowExecutionInfo'historyLength :: !Data.Int.Int64,
                                        _WorkflowExecutionInfo'parentNamespaceId :: !Data.Text.Text,
                                        _WorkflowExecutionInfo'parentExecution :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution),
                                        _WorkflowExecutionInfo'executionTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                        _WorkflowExecutionInfo'memo :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo),
                                        _WorkflowExecutionInfo'searchAttributes :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes),
                                        _WorkflowExecutionInfo'autoResetPoints :: !(Prelude.Maybe ResetPoints),
                                        _WorkflowExecutionInfo'taskQueue :: !Data.Text.Text,
                                        _WorkflowExecutionInfo'stateTransitionCount :: !Data.Int.Int64,
                                        _WorkflowExecutionInfo'historySizeBytes :: !Data.Int.Int64,
                                        _WorkflowExecutionInfo'mostRecentWorkerVersionStamp :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp),
                                        _WorkflowExecutionInfo'executionDuration :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                        _WorkflowExecutionInfo'rootExecution :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution),
                                        _WorkflowExecutionInfo'assignedBuildId :: !Data.Text.Text,
                                        _WorkflowExecutionInfo'inheritedBuildId :: !Data.Text.Text,
                                        _WorkflowExecutionInfo'firstRunId :: !Data.Text.Text,
                                        _WorkflowExecutionInfo'versioningInfo :: !(Prelude.Maybe WorkflowExecutionVersioningInfo),
                                        _WorkflowExecutionInfo'workerDeploymentName :: !Data.Text.Text,
                                        _WorkflowExecutionInfo'priority :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority),
                                        _WorkflowExecutionInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowExecutionInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "execution" Proto.Temporal.Api.Common.V1.Message.WorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'execution
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'execution = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'execution" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'execution
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'execution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "type'" Proto.Temporal.Api.Common.V1.Message.WorkflowType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'type'
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'type' = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'type'" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'type'
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'type' = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "startTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'startTime
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'startTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'startTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'startTime
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'startTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "closeTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'closeTime
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'closeTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'closeTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'closeTime
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'closeTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "status" Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'status
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'status = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "historyLength" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'historyLength
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'historyLength = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "parentNamespaceId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'parentNamespaceId
           (\ x__ y__
              -> x__ {_WorkflowExecutionInfo'parentNamespaceId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "parentExecution" Proto.Temporal.Api.Common.V1.Message.WorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'parentExecution
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'parentExecution = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'parentExecution" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'parentExecution
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'parentExecution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "executionTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'executionTime
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'executionTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'executionTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'executionTime
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'executionTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "memo" Proto.Temporal.Api.Common.V1.Message.Memo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'memo
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'memo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'memo" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'memo
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'memo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "searchAttributes" Proto.Temporal.Api.Common.V1.Message.SearchAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'searchAttributes
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'searchAttributes = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'searchAttributes" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'searchAttributes
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "autoResetPoints" ResetPoints where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'autoResetPoints
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'autoResetPoints = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'autoResetPoints" (Prelude.Maybe ResetPoints) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'autoResetPoints
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'autoResetPoints = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "taskQueue" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'taskQueue
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "stateTransitionCount" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'stateTransitionCount
           (\ x__ y__
              -> x__ {_WorkflowExecutionInfo'stateTransitionCount = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "historySizeBytes" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'historySizeBytes
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'historySizeBytes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "mostRecentWorkerVersionStamp" Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'mostRecentWorkerVersionStamp
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionInfo'mostRecentWorkerVersionStamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'mostRecentWorkerVersionStamp" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'mostRecentWorkerVersionStamp
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionInfo'mostRecentWorkerVersionStamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "executionDuration" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'executionDuration
           (\ x__ y__
              -> x__ {_WorkflowExecutionInfo'executionDuration = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'executionDuration" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'executionDuration
           (\ x__ y__
              -> x__ {_WorkflowExecutionInfo'executionDuration = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "rootExecution" Proto.Temporal.Api.Common.V1.Message.WorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'rootExecution
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'rootExecution = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'rootExecution" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'rootExecution
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'rootExecution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "assignedBuildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'assignedBuildId
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'assignedBuildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "inheritedBuildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'inheritedBuildId
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'inheritedBuildId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "firstRunId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'firstRunId
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'firstRunId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "versioningInfo" WorkflowExecutionVersioningInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'versioningInfo
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'versioningInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'versioningInfo" (Prelude.Maybe WorkflowExecutionVersioningInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'versioningInfo
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'versioningInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "workerDeploymentName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'workerDeploymentName
           (\ x__ y__
              -> x__ {_WorkflowExecutionInfo'workerDeploymentName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "priority" Proto.Temporal.Api.Common.V1.Message.Priority where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'priority
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'priority = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionInfo "maybe'priority" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Priority) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionInfo'priority
           (\ x__ y__ -> x__ {_WorkflowExecutionInfo'priority = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowExecutionInfo where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.WorkflowExecutionInfo"
  packedMessageDescriptor _
    = "\n\
      \\NAKWorkflowExecutionInfo\DC2G\n\
      \\texecution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\texecution\DC28\n\
      \\EOTtype\CAN\STX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\EOTtype\DC29\n\
      \\n\
      \start_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\DC29\n\
      \\n\
      \close_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\tcloseTime\DC2F\n\
      \\ACKstatus\CAN\ENQ \SOH(\SO2..temporal.api.enums.v1.WorkflowExecutionStatusR\ACKstatus\DC2%\n\
      \\SOhistory_length\CAN\ACK \SOH(\ETXR\rhistoryLength\DC2.\n\
      \\DC3parent_namespace_id\CAN\a \SOH(\tR\DC1parentNamespaceId\DC2T\n\
      \\DLEparent_execution\CAN\b \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\SIparentExecution\DC2A\n\
      \\SOexecution_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rexecutionTime\DC20\n\
      \\EOTmemo\CAN\n\
      \ \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
      \\DC1search_attributes\CAN\v \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC2Q\n\
      \\DC1auto_reset_points\CAN\f \SOH(\v2%.temporal.api.workflow.v1.ResetPointsR\SIautoResetPoints\DC2\GS\n\
      \\n\
      \task_queue\CAN\r \SOH(\tR\ttaskQueue\DC24\n\
      \\SYNstate_transition_count\CAN\SO \SOH(\ETXR\DC4stateTransitionCount\DC2,\n\
      \\DC2history_size_bytes\CAN\SI \SOH(\ETXR\DLEhistorySizeBytes\DC2r\n\
      \ most_recent_worker_version_stamp\CAN\DLE \SOH(\v2*.temporal.api.common.v1.WorkerVersionStampR\FSmostRecentWorkerVersionStamp\DC2H\n\
      \\DC2execution_duration\CAN\DC1 \SOH(\v2\EM.google.protobuf.DurationR\DC1executionDuration\DC2P\n\
      \\SOroot_execution\CAN\DC2 \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\rrootExecution\DC2*\n\
      \\DC1assigned_build_id\CAN\DC3 \SOH(\tR\SIassignedBuildId\DC2,\n\
      \\DC2inherited_build_id\CAN\DC4 \SOH(\tR\DLEinheritedBuildId\DC2 \n\
      \\ffirst_run_id\CAN\NAK \SOH(\tR\n\
      \firstRunId\DC2b\n\
      \\SIversioning_info\CAN\SYN \SOH(\v29.temporal.api.workflow.v1.WorkflowExecutionVersioningInfoR\SOversioningInfo\DC24\n\
      \\SYNworker_deployment_name\CAN\ETB \SOH(\tR\DC4workerDeploymentName\DC2<\n\
      \\bpriority\CAN\CAN \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        execution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'execution")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        type'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "type"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowType)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'type'")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        startTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        closeTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "close_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'closeTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        status__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "status"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"status")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        historyLength__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "history_length"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"historyLength")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        parentNamespaceId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "parent_namespace_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"parentNamespaceId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        parentExecution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "parent_execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'parentExecution")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        executionTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "execution_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'executionTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        memo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "memo"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Memo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'memo")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.SearchAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        autoResetPoints__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "auto_reset_points"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResetPoints)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'autoResetPoints")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskQueue")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        stateTransitionCount__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state_transition_count"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"stateTransitionCount")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        historySizeBytes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "history_size_bytes"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"historySizeBytes")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        mostRecentWorkerVersionStamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "most_recent_worker_version_stamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'mostRecentWorkerVersionStamp")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        executionDuration__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "execution_duration"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'executionDuration")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        rootExecution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "root_execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'rootExecution")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        assignedBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "assigned_build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"assignedBuildId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        inheritedBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "inherited_build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"inheritedBuildId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        firstRunId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "first_run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"firstRunId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        versioningInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "versioning_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowExecutionVersioningInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'versioningInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        workerDeploymentName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "worker_deployment_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workerDeploymentName")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
        priority__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "priority"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Priority)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'priority")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, execution__field_descriptor),
           (Data.ProtoLens.Tag 2, type'__field_descriptor),
           (Data.ProtoLens.Tag 3, startTime__field_descriptor),
           (Data.ProtoLens.Tag 4, closeTime__field_descriptor),
           (Data.ProtoLens.Tag 5, status__field_descriptor),
           (Data.ProtoLens.Tag 6, historyLength__field_descriptor),
           (Data.ProtoLens.Tag 7, parentNamespaceId__field_descriptor),
           (Data.ProtoLens.Tag 8, parentExecution__field_descriptor),
           (Data.ProtoLens.Tag 9, executionTime__field_descriptor),
           (Data.ProtoLens.Tag 10, memo__field_descriptor),
           (Data.ProtoLens.Tag 11, searchAttributes__field_descriptor),
           (Data.ProtoLens.Tag 12, autoResetPoints__field_descriptor),
           (Data.ProtoLens.Tag 13, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 14, stateTransitionCount__field_descriptor),
           (Data.ProtoLens.Tag 15, historySizeBytes__field_descriptor),
           (Data.ProtoLens.Tag 16, 
            mostRecentWorkerVersionStamp__field_descriptor),
           (Data.ProtoLens.Tag 17, executionDuration__field_descriptor),
           (Data.ProtoLens.Tag 18, rootExecution__field_descriptor),
           (Data.ProtoLens.Tag 19, assignedBuildId__field_descriptor),
           (Data.ProtoLens.Tag 20, inheritedBuildId__field_descriptor),
           (Data.ProtoLens.Tag 21, firstRunId__field_descriptor),
           (Data.ProtoLens.Tag 22, versioningInfo__field_descriptor),
           (Data.ProtoLens.Tag 23, workerDeploymentName__field_descriptor),
           (Data.ProtoLens.Tag 24, priority__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowExecutionInfo'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowExecutionInfo'_unknownFields = y__})
  defMessage
    = WorkflowExecutionInfo'_constructor
        {_WorkflowExecutionInfo'execution = Prelude.Nothing,
         _WorkflowExecutionInfo'type' = Prelude.Nothing,
         _WorkflowExecutionInfo'startTime = Prelude.Nothing,
         _WorkflowExecutionInfo'closeTime = Prelude.Nothing,
         _WorkflowExecutionInfo'status = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'historyLength = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'parentNamespaceId = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'parentExecution = Prelude.Nothing,
         _WorkflowExecutionInfo'executionTime = Prelude.Nothing,
         _WorkflowExecutionInfo'memo = Prelude.Nothing,
         _WorkflowExecutionInfo'searchAttributes = Prelude.Nothing,
         _WorkflowExecutionInfo'autoResetPoints = Prelude.Nothing,
         _WorkflowExecutionInfo'taskQueue = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'stateTransitionCount = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'historySizeBytes = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'mostRecentWorkerVersionStamp = Prelude.Nothing,
         _WorkflowExecutionInfo'executionDuration = Prelude.Nothing,
         _WorkflowExecutionInfo'rootExecution = Prelude.Nothing,
         _WorkflowExecutionInfo'assignedBuildId = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'inheritedBuildId = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'firstRunId = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'versioningInfo = Prelude.Nothing,
         _WorkflowExecutionInfo'workerDeploymentName = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionInfo'priority = Prelude.Nothing,
         _WorkflowExecutionInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowExecutionInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowExecutionInfo
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
                                       "execution"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"execution") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "type"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"type'") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"startTime") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "close_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"closeTime") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "status"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"status") y x)
                        48
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "history_length"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"historyLength") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "parent_namespace_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"parentNamespaceId") y x)
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "parent_execution"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"parentExecution") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "execution_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"executionTime") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "memo"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"memo") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "search_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"searchAttributes") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "auto_reset_points"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"autoResetPoints") y x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        112
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "state_transition_count"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"stateTransitionCount") y x)
                        120
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "history_size_bytes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"historySizeBytes") y x)
                        130
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "most_recent_worker_version_stamp"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"mostRecentWorkerVersionStamp") y
                                     x)
                        138
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "execution_duration"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"executionDuration") y x)
                        146
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "root_execution"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"rootExecution") y x)
                        154
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "assigned_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"assignedBuildId") y x)
                        162
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "inherited_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"inheritedBuildId") y x)
                        170
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "first_run_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"firstRunId") y x)
                        178
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "versioning_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"versioningInfo") y x)
                        186
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "worker_deployment_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workerDeploymentName") y x)
                        194
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "priority"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"priority") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowExecutionInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'execution") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'type'") _x
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
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'startTime") _x
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
                             (Data.ProtoLens.Field.field @"maybe'closeTime") _x
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
                         (let
                            _v = Lens.Family2.view (Data.ProtoLens.Field.field @"status") _x
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
                                     (Data.ProtoLens.Field.field @"historyLength") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 48)
                                     ((Prelude..)
                                        Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral
                                        _v))
                            ((Data.Monoid.<>)
                               (let
                                  _v
                                    = Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"parentNamespaceId") _x
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
                                                      (Prelude.fromIntegral
                                                         (Data.ByteString.length bs)))
                                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                           Data.Text.Encoding.encodeUtf8 _v))
                               ((Data.Monoid.<>)
                                  (case
                                       Lens.Family2.view
                                         (Data.ProtoLens.Field.field @"maybe'parentExecution") _x
                                   of
                                     Prelude.Nothing -> Data.Monoid.mempty
                                     (Prelude.Just _v)
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt 66)
                                            ((Prelude..)
                                               (\ bs
                                                  -> (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          (Prelude.fromIntegral
                                                             (Data.ByteString.length bs)))
                                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                               Data.ProtoLens.encodeMessage _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'executionTime") _x
                                      of
                                        Prelude.Nothing -> Data.Monoid.mempty
                                        (Prelude.Just _v)
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                               ((Prelude..)
                                                  (\ bs
                                                     -> (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             (Prelude.fromIntegral
                                                                (Data.ByteString.length bs)))
                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                             bs))
                                                  Data.ProtoLens.encodeMessage _v))
                                     ((Data.Monoid.<>)
                                        (case
                                             Lens.Family2.view
                                               (Data.ProtoLens.Field.field @"maybe'memo") _x
                                         of
                                           Prelude.Nothing -> Data.Monoid.mempty
                                           (Prelude.Just _v)
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                                  ((Prelude..)
                                                     (\ bs
                                                        -> (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                (Prelude.fromIntegral
                                                                   (Data.ByteString.length bs)))
                                                             (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                bs))
                                                     Data.ProtoLens.encodeMessage _v))
                                        ((Data.Monoid.<>)
                                           (case
                                                Lens.Family2.view
                                                  (Data.ProtoLens.Field.field
                                                     @"maybe'searchAttributes")
                                                  _x
                                            of
                                              Prelude.Nothing -> Data.Monoid.mempty
                                              (Prelude.Just _v)
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                     ((Prelude..)
                                                        (\ bs
                                                           -> (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (Prelude.fromIntegral
                                                                      (Data.ByteString.length bs)))
                                                                (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                   bs))
                                                        Data.ProtoLens.encodeMessage _v))
                                           ((Data.Monoid.<>)
                                              (case
                                                   Lens.Family2.view
                                                     (Data.ProtoLens.Field.field
                                                        @"maybe'autoResetPoints")
                                                     _x
                                               of
                                                 Prelude.Nothing -> Data.Monoid.mempty
                                                 (Prelude.Just _v)
                                                   -> (Data.Monoid.<>)
                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                                                        ((Prelude..)
                                                           (\ bs
                                                              -> (Data.Monoid.<>)
                                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                      (Prelude.fromIntegral
                                                                         (Data.ByteString.length
                                                                            bs)))
                                                                   (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                      bs))
                                                           Data.ProtoLens.encodeMessage _v))
                                              ((Data.Monoid.<>)
                                                 (let
                                                    _v
                                                      = Lens.Family2.view
                                                          (Data.ProtoLens.Field.field @"taskQueue")
                                                          _x
                                                  in
                                                    if (Prelude.==)
                                                         _v Data.ProtoLens.fieldDefault then
                                                        Data.Monoid.mempty
                                                    else
                                                        (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             106)
                                                          ((Prelude..)
                                                             (\ bs
                                                                -> (Data.Monoid.<>)
                                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                        (Prelude.fromIntegral
                                                                           (Data.ByteString.length
                                                                              bs)))
                                                                     (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                        bs))
                                                             Data.Text.Encoding.encodeUtf8 _v))
                                                 ((Data.Monoid.<>)
                                                    (let
                                                       _v
                                                         = Lens.Family2.view
                                                             (Data.ProtoLens.Field.field
                                                                @"stateTransitionCount")
                                                             _x
                                                     in
                                                       if (Prelude.==)
                                                            _v Data.ProtoLens.fieldDefault then
                                                           Data.Monoid.mempty
                                                       else
                                                           (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                112)
                                                             ((Prelude..)
                                                                Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                Prelude.fromIntegral _v))
                                                    ((Data.Monoid.<>)
                                                       (let
                                                          _v
                                                            = Lens.Family2.view
                                                                (Data.ProtoLens.Field.field
                                                                   @"historySizeBytes")
                                                                _x
                                                        in
                                                          if (Prelude.==)
                                                               _v Data.ProtoLens.fieldDefault then
                                                              Data.Monoid.mempty
                                                          else
                                                              (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   120)
                                                                ((Prelude..)
                                                                   Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   Prelude.fromIntegral _v))
                                                       ((Data.Monoid.<>)
                                                          (case
                                                               Lens.Family2.view
                                                                 (Data.ProtoLens.Field.field
                                                                    @"maybe'mostRecentWorkerVersionStamp")
                                                                 _x
                                                           of
                                                             Prelude.Nothing -> Data.Monoid.mempty
                                                             (Prelude.Just _v)
                                                               -> (Data.Monoid.<>)
                                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                       130)
                                                                    ((Prelude..)
                                                                       (\ bs
                                                                          -> (Data.Monoid.<>)
                                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  (Prelude.fromIntegral
                                                                                     (Data.ByteString.length
                                                                                        bs)))
                                                                               (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                  bs))
                                                                       Data.ProtoLens.encodeMessage
                                                                       _v))
                                                          ((Data.Monoid.<>)
                                                             (case
                                                                  Lens.Family2.view
                                                                    (Data.ProtoLens.Field.field
                                                                       @"maybe'executionDuration")
                                                                    _x
                                                              of
                                                                Prelude.Nothing
                                                                  -> Data.Monoid.mempty
                                                                (Prelude.Just _v)
                                                                  -> (Data.Monoid.<>)
                                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                          138)
                                                                       ((Prelude..)
                                                                          (\ bs
                                                                             -> (Data.Monoid.<>)
                                                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                     (Prelude.fromIntegral
                                                                                        (Data.ByteString.length
                                                                                           bs)))
                                                                                  (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                     bs))
                                                                          Data.ProtoLens.encodeMessage
                                                                          _v))
                                                             ((Data.Monoid.<>)
                                                                (case
                                                                     Lens.Family2.view
                                                                       (Data.ProtoLens.Field.field
                                                                          @"maybe'rootExecution")
                                                                       _x
                                                                 of
                                                                   Prelude.Nothing
                                                                     -> Data.Monoid.mempty
                                                                   (Prelude.Just _v)
                                                                     -> (Data.Monoid.<>)
                                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                             146)
                                                                          ((Prelude..)
                                                                             (\ bs
                                                                                -> (Data.Monoid.<>)
                                                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                        (Prelude.fromIntegral
                                                                                           (Data.ByteString.length
                                                                                              bs)))
                                                                                     (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                        bs))
                                                                             Data.ProtoLens.encodeMessage
                                                                             _v))
                                                                ((Data.Monoid.<>)
                                                                   (let
                                                                      _v
                                                                        = Lens.Family2.view
                                                                            (Data.ProtoLens.Field.field
                                                                               @"assignedBuildId")
                                                                            _x
                                                                    in
                                                                      if (Prelude.==)
                                                                           _v
                                                                           Data.ProtoLens.fieldDefault then
                                                                          Data.Monoid.mempty
                                                                      else
                                                                          (Data.Monoid.<>)
                                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                               154)
                                                                            ((Prelude..)
                                                                               (\ bs
                                                                                  -> (Data.Monoid.<>)
                                                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                          (Prelude.fromIntegral
                                                                                             (Data.ByteString.length
                                                                                                bs)))
                                                                                       (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                          bs))
                                                                               Data.Text.Encoding.encodeUtf8
                                                                               _v))
                                                                   ((Data.Monoid.<>)
                                                                      (let
                                                                         _v
                                                                           = Lens.Family2.view
                                                                               (Data.ProtoLens.Field.field
                                                                                  @"inheritedBuildId")
                                                                               _x
                                                                       in
                                                                         if (Prelude.==)
                                                                              _v
                                                                              Data.ProtoLens.fieldDefault then
                                                                             Data.Monoid.mempty
                                                                         else
                                                                             (Data.Monoid.<>)
                                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  162)
                                                                               ((Prelude..)
                                                                                  (\ bs
                                                                                     -> (Data.Monoid.<>)
                                                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                             (Prelude.fromIntegral
                                                                                                (Data.ByteString.length
                                                                                                   bs)))
                                                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                             bs))
                                                                                  Data.Text.Encoding.encodeUtf8
                                                                                  _v))
                                                                      ((Data.Monoid.<>)
                                                                         (let
                                                                            _v
                                                                              = Lens.Family2.view
                                                                                  (Data.ProtoLens.Field.field
                                                                                     @"firstRunId")
                                                                                  _x
                                                                          in
                                                                            if (Prelude.==)
                                                                                 _v
                                                                                 Data.ProtoLens.fieldDefault then
                                                                                Data.Monoid.mempty
                                                                            else
                                                                                (Data.Monoid.<>)
                                                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                     170)
                                                                                  ((Prelude..)
                                                                                     (\ bs
                                                                                        -> (Data.Monoid.<>)
                                                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                (Prelude.fromIntegral
                                                                                                   (Data.ByteString.length
                                                                                                      bs)))
                                                                                             (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                bs))
                                                                                     Data.Text.Encoding.encodeUtf8
                                                                                     _v))
                                                                         ((Data.Monoid.<>)
                                                                            (case
                                                                                 Lens.Family2.view
                                                                                   (Data.ProtoLens.Field.field
                                                                                      @"maybe'versioningInfo")
                                                                                   _x
                                                                             of
                                                                               Prelude.Nothing
                                                                                 -> Data.Monoid.mempty
                                                                               (Prelude.Just _v)
                                                                                 -> (Data.Monoid.<>)
                                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                         178)
                                                                                      ((Prelude..)
                                                                                         (\ bs
                                                                                            -> (Data.Monoid.<>)
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                    (Prelude.fromIntegral
                                                                                                       (Data.ByteString.length
                                                                                                          bs)))
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                    bs))
                                                                                         Data.ProtoLens.encodeMessage
                                                                                         _v))
                                                                            ((Data.Monoid.<>)
                                                                               (let
                                                                                  _v
                                                                                    = Lens.Family2.view
                                                                                        (Data.ProtoLens.Field.field
                                                                                           @"workerDeploymentName")
                                                                                        _x
                                                                                in
                                                                                  if (Prelude.==)
                                                                                       _v
                                                                                       Data.ProtoLens.fieldDefault then
                                                                                      Data.Monoid.mempty
                                                                                  else
                                                                                      (Data.Monoid.<>)
                                                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                           186)
                                                                                        ((Prelude..)
                                                                                           (\ bs
                                                                                              -> (Data.Monoid.<>)
                                                                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                      (Prelude.fromIntegral
                                                                                                         (Data.ByteString.length
                                                                                                            bs)))
                                                                                                   (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                      bs))
                                                                                           Data.Text.Encoding.encodeUtf8
                                                                                           _v))
                                                                               ((Data.Monoid.<>)
                                                                                  (case
                                                                                       Lens.Family2.view
                                                                                         (Data.ProtoLens.Field.field
                                                                                            @"maybe'priority")
                                                                                         _x
                                                                                   of
                                                                                     Prelude.Nothing
                                                                                       -> Data.Monoid.mempty
                                                                                     (Prelude.Just _v)
                                                                                       -> (Data.Monoid.<>)
                                                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                               194)
                                                                                            ((Prelude..)
                                                                                               (\ bs
                                                                                                  -> (Data.Monoid.<>)
                                                                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                          (Prelude.fromIntegral
                                                                                                             (Data.ByteString.length
                                                                                                                bs)))
                                                                                                       (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                          bs))
                                                                                               Data.ProtoLens.encodeMessage
                                                                                               _v))
                                                                                  (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                                                     (Lens.Family2.view
                                                                                        Data.ProtoLens.unknownFields
                                                                                        _x)))))))))))))))))))))))))
instance Control.DeepSeq.NFData WorkflowExecutionInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowExecutionInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowExecutionInfo'execution x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowExecutionInfo'type' x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowExecutionInfo'startTime x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowExecutionInfo'closeTime x__)
                         (Control.DeepSeq.deepseq
                            (_WorkflowExecutionInfo'status x__)
                            (Control.DeepSeq.deepseq
                               (_WorkflowExecutionInfo'historyLength x__)
                               (Control.DeepSeq.deepseq
                                  (_WorkflowExecutionInfo'parentNamespaceId x__)
                                  (Control.DeepSeq.deepseq
                                     (_WorkflowExecutionInfo'parentExecution x__)
                                     (Control.DeepSeq.deepseq
                                        (_WorkflowExecutionInfo'executionTime x__)
                                        (Control.DeepSeq.deepseq
                                           (_WorkflowExecutionInfo'memo x__)
                                           (Control.DeepSeq.deepseq
                                              (_WorkflowExecutionInfo'searchAttributes x__)
                                              (Control.DeepSeq.deepseq
                                                 (_WorkflowExecutionInfo'autoResetPoints x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_WorkflowExecutionInfo'taskQueue x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_WorkflowExecutionInfo'stateTransitionCount
                                                          x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_WorkflowExecutionInfo'historySizeBytes
                                                             x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_WorkflowExecutionInfo'mostRecentWorkerVersionStamp
                                                                x__)
                                                             (Control.DeepSeq.deepseq
                                                                (_WorkflowExecutionInfo'executionDuration
                                                                   x__)
                                                                (Control.DeepSeq.deepseq
                                                                   (_WorkflowExecutionInfo'rootExecution
                                                                      x__)
                                                                   (Control.DeepSeq.deepseq
                                                                      (_WorkflowExecutionInfo'assignedBuildId
                                                                         x__)
                                                                      (Control.DeepSeq.deepseq
                                                                         (_WorkflowExecutionInfo'inheritedBuildId
                                                                            x__)
                                                                         (Control.DeepSeq.deepseq
                                                                            (_WorkflowExecutionInfo'firstRunId
                                                                               x__)
                                                                            (Control.DeepSeq.deepseq
                                                                               (_WorkflowExecutionInfo'versioningInfo
                                                                                  x__)
                                                                               (Control.DeepSeq.deepseq
                                                                                  (_WorkflowExecutionInfo'workerDeploymentName
                                                                                     x__)
                                                                                  (Control.DeepSeq.deepseq
                                                                                     (_WorkflowExecutionInfo'priority
                                                                                        x__)
                                                                                     ()))))))))))))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.versioningOverride' @:: Lens' WorkflowExecutionOptions VersioningOverride@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'versioningOverride' @:: Lens' WorkflowExecutionOptions (Prelude.Maybe VersioningOverride)@ -}
data WorkflowExecutionOptions
  = WorkflowExecutionOptions'_constructor {_WorkflowExecutionOptions'versioningOverride :: !(Prelude.Maybe VersioningOverride),
                                           _WorkflowExecutionOptions'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowExecutionOptions where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowExecutionOptions "versioningOverride" VersioningOverride where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionOptions'versioningOverride
           (\ x__ y__
              -> x__ {_WorkflowExecutionOptions'versioningOverride = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionOptions "maybe'versioningOverride" (Prelude.Maybe VersioningOverride) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionOptions'versioningOverride
           (\ x__ y__
              -> x__ {_WorkflowExecutionOptions'versioningOverride = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowExecutionOptions where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.WorkflowExecutionOptions"
  packedMessageDescriptor _
    = "\n\
      \\CANWorkflowExecutionOptions\DC2]\n\
      \\DC3versioning_override\CAN\SOH \SOH(\v2,.temporal.api.workflow.v1.VersioningOverrideR\DC2versioningOverride"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        versioningOverride__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "versioning_override"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor VersioningOverride)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'versioningOverride")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionOptions
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, versioningOverride__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowExecutionOptions'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowExecutionOptions'_unknownFields = y__})
  defMessage
    = WorkflowExecutionOptions'_constructor
        {_WorkflowExecutionOptions'versioningOverride = Prelude.Nothing,
         _WorkflowExecutionOptions'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowExecutionOptions
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowExecutionOptions
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
                                       "versioning_override"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"versioningOverride") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowExecutionOptions"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'versioningOverride") _x
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
instance Control.DeepSeq.NFData WorkflowExecutionOptions where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowExecutionOptions'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowExecutionOptions'versioningOverride x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.behavior' @:: Lens' WorkflowExecutionVersioningInfo Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.deployment' @:: Lens' WorkflowExecutionVersioningInfo Proto.Temporal.Api.Deployment.V1.Message.Deployment@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'deployment' @:: Lens' WorkflowExecutionVersioningInfo (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.version' @:: Lens' WorkflowExecutionVersioningInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.versioningOverride' @:: Lens' WorkflowExecutionVersioningInfo VersioningOverride@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'versioningOverride' @:: Lens' WorkflowExecutionVersioningInfo (Prelude.Maybe VersioningOverride)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.deploymentTransition' @:: Lens' WorkflowExecutionVersioningInfo DeploymentTransition@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'deploymentTransition' @:: Lens' WorkflowExecutionVersioningInfo (Prelude.Maybe DeploymentTransition)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.versionTransition' @:: Lens' WorkflowExecutionVersioningInfo DeploymentVersionTransition@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'versionTransition' @:: Lens' WorkflowExecutionVersioningInfo (Prelude.Maybe DeploymentVersionTransition)@ -}
data WorkflowExecutionVersioningInfo
  = WorkflowExecutionVersioningInfo'_constructor {_WorkflowExecutionVersioningInfo'behavior :: !Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior,
                                                  _WorkflowExecutionVersioningInfo'deployment :: !(Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment),
                                                  _WorkflowExecutionVersioningInfo'version :: !Data.Text.Text,
                                                  _WorkflowExecutionVersioningInfo'versioningOverride :: !(Prelude.Maybe VersioningOverride),
                                                  _WorkflowExecutionVersioningInfo'deploymentTransition :: !(Prelude.Maybe DeploymentTransition),
                                                  _WorkflowExecutionVersioningInfo'versionTransition :: !(Prelude.Maybe DeploymentVersionTransition),
                                                  _WorkflowExecutionVersioningInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowExecutionVersioningInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "behavior" Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'behavior
           (\ x__ y__
              -> x__ {_WorkflowExecutionVersioningInfo'behavior = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "deployment" Proto.Temporal.Api.Deployment.V1.Message.Deployment where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'deployment
           (\ x__ y__
              -> x__ {_WorkflowExecutionVersioningInfo'deployment = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "maybe'deployment" (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.Deployment) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'deployment
           (\ x__ y__
              -> x__ {_WorkflowExecutionVersioningInfo'deployment = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "version" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'version
           (\ x__ y__
              -> x__ {_WorkflowExecutionVersioningInfo'version = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "versioningOverride" VersioningOverride where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'versioningOverride
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionVersioningInfo'versioningOverride = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "maybe'versioningOverride" (Prelude.Maybe VersioningOverride) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'versioningOverride
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionVersioningInfo'versioningOverride = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "deploymentTransition" DeploymentTransition where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'deploymentTransition
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionVersioningInfo'deploymentTransition = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "maybe'deploymentTransition" (Prelude.Maybe DeploymentTransition) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'deploymentTransition
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionVersioningInfo'deploymentTransition = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "versionTransition" DeploymentVersionTransition where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'versionTransition
           (\ x__ y__
              -> x__ {_WorkflowExecutionVersioningInfo'versionTransition = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowExecutionVersioningInfo "maybe'versionTransition" (Prelude.Maybe DeploymentVersionTransition) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionVersioningInfo'versionTransition
           (\ x__ y__
              -> x__ {_WorkflowExecutionVersioningInfo'versionTransition = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowExecutionVersioningInfo where
  messageName _
    = Data.Text.pack
        "temporal.api.workflow.v1.WorkflowExecutionVersioningInfo"
  packedMessageDescriptor _
    = "\n\
      \\USWorkflowExecutionVersioningInfo\DC2E\n\
      \\bbehavior\CAN\SOH \SOH(\SO2).temporal.api.enums.v1.VersioningBehaviorR\bbehavior\DC2J\n\
      \\n\
      \deployment\CAN\STX \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\n\
      \deploymentB\STX\CAN\SOH\DC2\CAN\n\
      \\aversion\CAN\ENQ \SOH(\tR\aversion\DC2]\n\
      \\DC3versioning_override\CAN\ETX \SOH(\v2,.temporal.api.workflow.v1.VersioningOverrideR\DC2versioningOverride\DC2g\n\
      \\NAKdeployment_transition\CAN\EOT \SOH(\v2..temporal.api.workflow.v1.DeploymentTransitionR\DC4deploymentTransitionB\STX\CAN\SOH\DC2d\n\
      \\DC2version_transition\CAN\ACK \SOH(\v25.temporal.api.workflow.v1.DeploymentVersionTransitionR\DC1versionTransition"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        behavior__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "behavior"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.VersioningBehavior)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"behavior")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionVersioningInfo
        deployment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "deployment"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Deployment.V1.Message.Deployment)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'deployment")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionVersioningInfo
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionVersioningInfo
        versioningOverride__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "versioning_override"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor VersioningOverride)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'versioningOverride")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionVersioningInfo
        deploymentTransition__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "deployment_transition"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor DeploymentTransition)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'deploymentTransition")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionVersioningInfo
        versionTransition__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version_transition"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor DeploymentVersionTransition)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'versionTransition")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionVersioningInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, behavior__field_descriptor),
           (Data.ProtoLens.Tag 2, deployment__field_descriptor),
           (Data.ProtoLens.Tag 5, version__field_descriptor),
           (Data.ProtoLens.Tag 3, versioningOverride__field_descriptor),
           (Data.ProtoLens.Tag 4, deploymentTransition__field_descriptor),
           (Data.ProtoLens.Tag 6, versionTransition__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowExecutionVersioningInfo'_unknownFields
        (\ x__ y__
           -> x__ {_WorkflowExecutionVersioningInfo'_unknownFields = y__})
  defMessage
    = WorkflowExecutionVersioningInfo'_constructor
        {_WorkflowExecutionVersioningInfo'behavior = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionVersioningInfo'deployment = Prelude.Nothing,
         _WorkflowExecutionVersioningInfo'version = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionVersioningInfo'versioningOverride = Prelude.Nothing,
         _WorkflowExecutionVersioningInfo'deploymentTransition = Prelude.Nothing,
         _WorkflowExecutionVersioningInfo'versionTransition = Prelude.Nothing,
         _WorkflowExecutionVersioningInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowExecutionVersioningInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowExecutionVersioningInfo
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
                                       "behavior"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"behavior") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "deployment"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"deployment") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "version"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"version") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "versioning_override"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"versioningOverride") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "deployment_transition"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"deploymentTransition") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "version_transition"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"versionTransition") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "WorkflowExecutionVersioningInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"behavior") _x
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
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'deployment") _x
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
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"version") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
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
                             (Data.ProtoLens.Field.field @"maybe'versioningOverride") _x
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
                                (Data.ProtoLens.Field.field @"maybe'deploymentTransition") _x
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
                                   (Data.ProtoLens.Field.field @"maybe'versionTransition") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData WorkflowExecutionVersioningInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowExecutionVersioningInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowExecutionVersioningInfo'behavior x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowExecutionVersioningInfo'deployment x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowExecutionVersioningInfo'version x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowExecutionVersioningInfo'versioningOverride x__)
                         (Control.DeepSeq.deepseq
                            (_WorkflowExecutionVersioningInfo'deploymentTransition x__)
                            (Control.DeepSeq.deepseq
                               (_WorkflowExecutionVersioningInfo'versionTransition x__) ()))))))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \&temporal/api/workflow/v1/message.proto\DC2\CANtemporal.api.workflow.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\ESCgoogle/protobuf/empty.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB\"temporal/api/enums/v1/common.proto\SUB$temporal/api/enums/v1/workflow.proto\SUB$temporal/api/common/v1/message.proto\SUB(temporal/api/deployment/v1/message.proto\SUB%temporal/api/failure/v1/message.proto\SUB'temporal/api/taskqueue/v1/message.proto\SUB'temporal/api/sdk/v1/user_metadata.proto\"\139\f\n\
    \\NAKWorkflowExecutionInfo\DC2G\n\
    \\texecution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\texecution\DC28\n\
    \\EOTtype\CAN\STX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\EOTtype\DC29\n\
    \\n\
    \start_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\DC29\n\
    \\n\
    \close_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\tcloseTime\DC2F\n\
    \\ACKstatus\CAN\ENQ \SOH(\SO2..temporal.api.enums.v1.WorkflowExecutionStatusR\ACKstatus\DC2%\n\
    \\SOhistory_length\CAN\ACK \SOH(\ETXR\rhistoryLength\DC2.\n\
    \\DC3parent_namespace_id\CAN\a \SOH(\tR\DC1parentNamespaceId\DC2T\n\
    \\DLEparent_execution\CAN\b \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\SIparentExecution\DC2A\n\
    \\SOexecution_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rexecutionTime\DC20\n\
    \\EOTmemo\CAN\n\
    \ \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
    \\DC1search_attributes\CAN\v \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC2Q\n\
    \\DC1auto_reset_points\CAN\f \SOH(\v2%.temporal.api.workflow.v1.ResetPointsR\SIautoResetPoints\DC2\GS\n\
    \\n\
    \task_queue\CAN\r \SOH(\tR\ttaskQueue\DC24\n\
    \\SYNstate_transition_count\CAN\SO \SOH(\ETXR\DC4stateTransitionCount\DC2,\n\
    \\DC2history_size_bytes\CAN\SI \SOH(\ETXR\DLEhistorySizeBytes\DC2r\n\
    \ most_recent_worker_version_stamp\CAN\DLE \SOH(\v2*.temporal.api.common.v1.WorkerVersionStampR\FSmostRecentWorkerVersionStamp\DC2H\n\
    \\DC2execution_duration\CAN\DC1 \SOH(\v2\EM.google.protobuf.DurationR\DC1executionDuration\DC2P\n\
    \\SOroot_execution\CAN\DC2 \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\rrootExecution\DC2*\n\
    \\DC1assigned_build_id\CAN\DC3 \SOH(\tR\SIassignedBuildId\DC2,\n\
    \\DC2inherited_build_id\CAN\DC4 \SOH(\tR\DLEinheritedBuildId\DC2 \n\
    \\ffirst_run_id\CAN\NAK \SOH(\tR\n\
    \firstRunId\DC2b\n\
    \\SIversioning_info\CAN\SYN \SOH(\v29.temporal.api.workflow.v1.WorkflowExecutionVersioningInfoR\SOversioningInfo\DC24\n\
    \\SYNworker_deployment_name\CAN\ETB \SOH(\tR\DC4workerDeploymentName\DC2<\n\
    \\bpriority\CAN\CAN \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority\"\160\ETX\n\
    \\GSWorkflowExecutionExtendedInfo\DC2V\n\
    \\EMexecution_expiration_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ETBexecutionExpirationTime\DC2J\n\
    \\DC3run_expiration_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\DC1runExpirationTime\DC2)\n\
    \\DLEcancel_requested\CAN\ETX \SOH(\bR\SIcancelRequested\DC2B\n\
    \\SIlast_reset_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\rlastResetTime\DC2J\n\
    \\DC3original_start_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DC1originalStartTime\DC2 \n\
    \\freset_run_id\CAN\ACK \SOH(\tR\n\
    \resetRunId\"\252\ETX\n\
    \\USWorkflowExecutionVersioningInfo\DC2E\n\
    \\bbehavior\CAN\SOH \SOH(\SO2).temporal.api.enums.v1.VersioningBehaviorR\bbehavior\DC2J\n\
    \\n\
    \deployment\CAN\STX \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\n\
    \deploymentB\STX\CAN\SOH\DC2\CAN\n\
    \\aversion\CAN\ENQ \SOH(\tR\aversion\DC2]\n\
    \\DC3versioning_override\CAN\ETX \SOH(\v2,.temporal.api.workflow.v1.VersioningOverrideR\DC2versioningOverride\DC2g\n\
    \\NAKdeployment_transition\CAN\EOT \SOH(\v2..temporal.api.workflow.v1.DeploymentTransitionR\DC4deploymentTransitionB\STX\CAN\SOH\DC2d\n\
    \\DC2version_transition\CAN\ACK \SOH(\v25.temporal.api.workflow.v1.DeploymentVersionTransitionR\DC1versionTransition\"^\n\
    \\DC4DeploymentTransition\DC2F\n\
    \\n\
    \deployment\CAN\SOH \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\n\
    \deployment\"7\n\
    \\ESCDeploymentVersionTransition\DC2\CAN\n\
    \\aversion\CAN\SOH \SOH(\tR\aversion\"\170\ETX\n\
    \\ETBWorkflowExecutionConfig\DC2C\n\
    \\n\
    \task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC2W\n\
    \\SUBworkflow_execution_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeout\DC2K\n\
    \\DC4workflow_run_timeout\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeout\DC2\\\n\
    \\GSdefault_workflow_task_timeout\CAN\EOT \SOH(\v2\EM.google.protobuf.DurationR\SUBdefaultWorkflowTaskTimeout\DC2F\n\
    \\ruser_metadata\CAN\ENQ \SOH(\v2!.temporal.api.sdk.v1.UserMetadataR\fuserMetadata\"\218\SO\n\
    \\DC3PendingActivityInfo\DC2\US\n\
    \\vactivity_id\CAN\SOH \SOH(\tR\n\
    \activityId\DC2I\n\
    \\ractivity_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.ActivityTypeR\factivityType\DC2A\n\
    \\ENQstate\CAN\ETX \SOH(\SO2+.temporal.api.enums.v1.PendingActivityStateR\ENQstate\DC2M\n\
    \\DC1heartbeat_details\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\DLEheartbeatDetails\DC2J\n\
    \\DC3last_heartbeat_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DC1lastHeartbeatTime\DC2F\n\
    \\DC1last_started_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\SIlastStartedTime\DC2\CAN\n\
    \\aattempt\CAN\a \SOH(\ENQR\aattempt\DC2)\n\
    \\DLEmaximum_attempts\CAN\b \SOH(\ENQR\SImaximumAttempts\DC2A\n\
    \\SOscheduled_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2C\n\
    \\SIexpiration_time\CAN\n\
    \ \SOH(\v2\SUB.google.protobuf.TimestampR\SOexpirationTime\DC2C\n\
    \\flast_failure\CAN\v \SOH(\v2 .temporal.api.failure.v1.FailureR\vlastFailure\DC20\n\
    \\DC4last_worker_identity\CAN\f \SOH(\tR\DC2lastWorkerIdentity\DC2K\n\
    \\NAKuse_workflow_build_id\CAN\r \SOH(\v2\SYN.google.protobuf.EmptyH\NULR\DC2useWorkflowBuildId\DC2P\n\
    \$last_independently_assigned_build_id\CAN\SO \SOH(\tH\NULR lastIndependentlyAssignedBuildId\DC2e\n\
    \\EMlast_worker_version_stamp\CAN\SI \SOH(\v2*.temporal.api.common.v1.WorkerVersionStampR\SYNlastWorkerVersionStamp\DC2O\n\
    \\SYNcurrent_retry_interval\CAN\DLE \SOH(\v2\EM.google.protobuf.DurationR\DC4currentRetryInterval\DC2W\n\
    \\SUBlast_attempt_complete_time\CAN\DC1 \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2W\n\
    \\SUBnext_attempt_schedule_time\CAN\DC2 \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2\SYN\n\
    \\ACKpaused\CAN\DC3 \SOH(\bR\ACKpaused\DC2S\n\
    \\SIlast_deployment\CAN\DC4 \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\SOlastDeploymentB\STX\CAN\SOH\DC2C\n\
    \\RSlast_worker_deployment_version\CAN\NAK \SOH(\tR\ESClastWorkerDeploymentVersion\DC2<\n\
    \\bpriority\CAN\SYN \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority\DC2V\n\
    \\n\
    \pause_info\CAN\ETB \SOH(\v27.temporal.api.workflow.v1.PendingActivityInfo.PauseInfoR\tpauseInfo\SUB\134\STX\n\
    \\tPauseInfo\DC29\n\
    \\n\
    \pause_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\tpauseTime\DC2X\n\
    \\ACKmanual\CAN\STX \SOH(\v2>.temporal.api.workflow.v1.PendingActivityInfo.PauseInfo.ManualH\NULR\ACKmanual\DC2\EM\n\
    \\arule_id\CAN\ETX \SOH(\tH\NULR\ACKruleId\SUB<\n\
    \\ACKManual\DC2\SUB\n\
    \\bidentity\CAN\SOH \SOH(\tR\bidentity\DC2\SYN\n\
    \\ACKreason\CAN\STX \SOH(\tR\ACKreasonB\v\n\
    \\tpaused_byB\DC3\n\
    \\DC1assigned_build_id\"\254\SOH\n\
    \\EMPendingChildExecutionInfo\DC2\US\n\
    \\vworkflow_id\CAN\SOH \SOH(\tR\n\
    \workflowId\DC2\NAK\n\
    \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\DC2,\n\
    \\DC2workflow_type_name\CAN\ETX \SOH(\tR\DLEworkflowTypeName\DC2!\n\
    \\finitiated_id\CAN\EOT \SOH(\ETXR\vinitiatedId\DC2X\n\
    \\DC3parent_close_policy\CAN\ENQ \SOH(\SO2(.temporal.api.enums.v1.ParentClosePolicyR\DC1parentClosePolicy\"\208\STX\n\
    \\ETBPendingWorkflowTaskInfo\DC2E\n\
    \\ENQstate\CAN\SOH \SOH(\SO2/.temporal.api.enums.v1.PendingWorkflowTaskStateR\ENQstate\DC2A\n\
    \\SOscheduled_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2R\n\
    \\ETBoriginal_scheduled_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\NAKoriginalScheduledTime\DC2=\n\
    \\fstarted_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\vstartedTime\DC2\CAN\n\
    \\aattempt\CAN\ENQ \SOH(\ENQR\aattempt\"O\n\
    \\vResetPoints\DC2@\n\
    \\ACKpoints\CAN\SOH \ETX(\v2(.temporal.api.workflow.v1.ResetPointInfoR\ACKpoints\"\205\STX\n\
    \\SOResetPointInfo\DC2\EM\n\
    \\bbuild_id\CAN\a \SOH(\tR\abuildId\DC2'\n\
    \\SIbinary_checksum\CAN\SOH \SOH(\tR\SObinaryChecksum\DC2\NAK\n\
    \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\DC2F\n\
    \ first_workflow_task_completed_id\CAN\ETX \SOH(\ETXR\FSfirstWorkflowTaskCompletedId\DC2;\n\
    \\vcreate_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \createTime\DC2;\n\
    \\vexpire_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \expireTime\DC2\RS\n\
    \\n\
    \resettable\CAN\ACK \SOH(\bR\n\
    \resettable\"\242\b\n\
    \\CANNewWorkflowExecutionInfo\DC2\US\n\
    \\vworkflow_id\CAN\SOH \SOH(\tR\n\
    \workflowId\DC2I\n\
    \\rworkflow_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\fworkflowType\DC2C\n\
    \\n\
    \task_queue\CAN\ETX \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
    \\ENQinput\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2W\n\
    \\SUBworkflow_execution_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeout\DC2K\n\
    \\DC4workflow_run_timeout\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeout\DC2M\n\
    \\NAKworkflow_task_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeout\DC2e\n\
    \\CANworkflow_id_reuse_policy\CAN\b \SOH(\SO2,.temporal.api.enums.v1.WorkflowIdReusePolicyR\NAKworkflowIdReusePolicy\DC2F\n\
    \\fretry_policy\CAN\t \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2#\n\
    \\rcron_schedule\CAN\n\
    \ \SOH(\tR\fcronSchedule\DC20\n\
    \\EOTmemo\CAN\v \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
    \\DC1search_attributes\CAN\f \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC26\n\
    \\ACKheader\CAN\r \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2F\n\
    \\ruser_metadata\CAN\SO \SOH(\v2!.temporal.api.sdk.v1.UserMetadataR\fuserMetadata\DC2]\n\
    \\DC3versioning_override\CAN\SI \SOH(\v2,.temporal.api.workflow.v1.VersioningOverrideR\DC2versioningOverride\DC2<\n\
    \\bpriority\CAN\DLE \SOH(\v2 .temporal.api.common.v1.PriorityR\bpriority\"\236\ENQ\n\
    \\fCallbackInfo\DC2<\n\
    \\bcallback\CAN\SOH \SOH(\v2 .temporal.api.common.v1.CallbackR\bcallback\DC2H\n\
    \\atrigger\CAN\STX \SOH(\v2..temporal.api.workflow.v1.CallbackInfo.TriggerR\atrigger\DC2G\n\
    \\DC1registration_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\DLEregistrationTime\DC2:\n\
    \\ENQstate\CAN\EOT \SOH(\SO2$.temporal.api.enums.v1.CallbackStateR\ENQstate\DC2\CAN\n\
    \\aattempt\CAN\ENQ \SOH(\ENQR\aattempt\DC2W\n\
    \\SUBlast_attempt_complete_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2R\n\
    \\DC4last_attempt_failure\CAN\a \SOH(\v2 .temporal.api.failure.v1.FailureR\DC2lastAttemptFailure\DC2W\n\
    \\SUBnext_attempt_schedule_time\CAN\b \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2%\n\
    \\SOblocked_reason\CAN\t \SOH(\tR\rblockedReason\SUB\DLE\n\
    \\SOWorkflowClosed\SUBv\n\
    \\aTrigger\DC2`\n\
    \\SIworkflow_closed\CAN\SOH \SOH(\v25.temporal.api.workflow.v1.CallbackInfo.WorkflowClosedH\NULR\SOworkflowClosedB\t\n\
    \\avariant\"\249\ACK\n\
    \\EMPendingNexusOperationInfo\DC2\SUB\n\
    \\bendpoint\CAN\SOH \SOH(\tR\bendpoint\DC2\CAN\n\
    \\aservice\CAN\STX \SOH(\tR\aservice\DC2\FS\n\
    \\toperation\CAN\ETX \SOH(\tR\toperation\DC2!\n\
    \\foperation_id\CAN\EOT \SOH(\tR\voperationId\DC2T\n\
    \\EMschedule_to_close_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\SYNscheduleToCloseTimeout\DC2A\n\
    \\SOscheduled_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTime\DC2G\n\
    \\ENQstate\CAN\a \SOH(\SO21.temporal.api.enums.v1.PendingNexusOperationStateR\ENQstate\DC2\CAN\n\
    \\aattempt\CAN\b \SOH(\ENQR\aattempt\DC2W\n\
    \\SUBlast_attempt_complete_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2R\n\
    \\DC4last_attempt_failure\CAN\n\
    \ \SOH(\v2 .temporal.api.failure.v1.FailureR\DC2lastAttemptFailure\DC2W\n\
    \\SUBnext_attempt_schedule_time\CAN\v \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2e\n\
    \\DC1cancellation_info\CAN\f \SOH(\v28.temporal.api.workflow.v1.NexusOperationCancellationInfoR\DLEcancellationInfo\DC2,\n\
    \\DC2scheduled_event_id\CAN\r \SOH(\ETXR\DLEscheduledEventId\DC2%\n\
    \\SOblocked_reason\CAN\SO \SOH(\tR\rblockedReason\DC2'\n\
    \\SIoperation_token\CAN\SI \SOH(\tR\SOoperationToken\"\248\ETX\n\
    \\RSNexusOperationCancellationInfo\DC2A\n\
    \\SOrequested_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\rrequestedTime\DC2L\n\
    \\ENQstate\CAN\STX \SOH(\SO26.temporal.api.enums.v1.NexusOperationCancellationStateR\ENQstate\DC2\CAN\n\
    \\aattempt\CAN\ETX \SOH(\ENQR\aattempt\DC2W\n\
    \\SUBlast_attempt_complete_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\ETBlastAttemptCompleteTime\DC2R\n\
    \\DC4last_attempt_failure\CAN\ENQ \SOH(\v2 .temporal.api.failure.v1.FailureR\DC2lastAttemptFailure\DC2W\n\
    \\SUBnext_attempt_schedule_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\ETBnextAttemptScheduleTime\DC2%\n\
    \\SOblocked_reason\CAN\a \SOH(\tR\rblockedReason\"y\n\
    \\CANWorkflowExecutionOptions\DC2]\n\
    \\DC3versioning_override\CAN\SOH \SOH(\v2,.temporal.api.workflow.v1.VersioningOverrideR\DC2versioningOverride\"\206\SOH\n\
    \\DC2VersioningOverride\DC2E\n\
    \\bbehavior\CAN\SOH \SOH(\SO2).temporal.api.enums.v1.VersioningBehaviorR\bbehavior\DC2J\n\
    \\n\
    \deployment\CAN\STX \SOH(\v2&.temporal.api.deployment.v1.DeploymentR\n\
    \deploymentB\STX\CAN\SOH\DC2%\n\
    \\SOpinned_version\CAN\t \SOH(\tR\rpinnedVersion\"\162\SOH\n\
    \\DC1OnConflictOptions\DC2*\n\
    \\DC1attach_request_id\CAN\SOH \SOH(\bR\SIattachRequestId\DC2>\n\
    \\ESCattach_completion_callbacks\CAN\STX \SOH(\bR\EMattachCompletionCallbacks\DC2!\n\
    \\fattach_links\CAN\ETX \SOH(\bR\vattachLinksB\147\SOH\n\
    \\ESCio.temporal.api.workflow.v1B\fMessageProtoP\SOHZ'go.temporal.io/api/workflow/v1;workflow\170\STX\SUBTemporalio.Api.Workflow.V1\234\STX\GSTemporalio::Api::Workflow::V1J\134\223\SOH\n\
    \\a\DC2\ENQ\SYN\NUL\167\EOT\SOH\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL!\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL>\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL>\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL4\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL4\n\
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
    \\SOH\b\DC2\ETX\RS\NUL6\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL6\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL7\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL7\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL(\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\"\NUL%\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX#\NUL)\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX%\NUL,\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX&\NUL.\n\
    \\t\n\
    \\STX\ETX\ENQ\DC2\ETX'\NUL.\n\
    \\t\n\
    \\STX\ETX\ACK\DC2\ETX(\NUL2\n\
    \\t\n\
    \\STX\ETX\a\DC2\ETX)\NUL/\n\
    \\t\n\
    \\STX\ETX\b\DC2\ETX*\NUL1\n\
    \\t\n\
    \\STX\ETX\t\DC2\ETX+\NUL1\n\
    \\156\SOH\n\
    \\STX\EOT\NUL\DC2\EOT0\NULw\SOH\SUB\143\SOH Hold basic information about a workflow execution.\n\
    \ This structure is a part of visibility, and thus contain a limited subset of information.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX0\b\GS\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX1\EOT;\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX1\EOT,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX1-6\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX19:\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX2\EOT1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX2\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX2(,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX2/0\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX3\EOT-\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX3\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX3\RS(\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX3+,\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX4\EOT-\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ACK\DC2\ETX4\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX4\RS(\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX4+,\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\EOT\DC2\ETX5\EOT=\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ACK\DC2\ETX5\EOT1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\SOH\DC2\ETX528\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ETX\DC2\ETX5;<\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ENQ\DC2\ETX6\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ENQ\DC2\ETX6\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\SOH\DC2\ETX6\n\
    \\CAN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ETX\DC2\ETX6\ESC\FS\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ACK\DC2\ETX7\EOT#\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ENQ\DC2\ETX7\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\SOH\DC2\ETX7\v\RS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ETX\DC2\ETX7!\"\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\a\DC2\ETX8\EOTB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\ACK\DC2\ETX8\EOT,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\SOH\DC2\ETX8-=\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\ETX\DC2\ETX8@A\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\b\DC2\ETX9\EOT1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\ACK\DC2\ETX9\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\SOH\DC2\ETX9\RS,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\ETX\DC2\ETX9/0\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\t\DC2\ETX:\EOT*\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\ACK\DC2\ETX:\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\SOH\DC2\ETX: $\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\ETX\DC2\ETX:')\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\n\
    \\DC2\ETX;\EOTC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\ACK\DC2\ETX;\EOT+\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\SOH\DC2\ETX;,=\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\ETX\DC2\ETX;@B\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\v\DC2\ETX<\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\ACK\DC2\ETX<\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\SOH\DC2\ETX<\DLE!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\ETX\DC2\ETX<$&\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\f\DC2\ETX=\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\f\ENQ\DC2\ETX=\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\f\SOH\DC2\ETX=\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\f\ETX\DC2\ETX=\CAN\SUB\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\r\DC2\ETX>\EOT&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\r\ENQ\DC2\ETX>\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\r\SOH\DC2\ETX>\n\
    \ \n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\r\ETX\DC2\ETX>#%\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SO\DC2\ETX?\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SO\ENQ\DC2\ETX?\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SO\SOH\DC2\ETX?\n\
    \\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SO\ETX\DC2\ETX?\US!\n\
    \\209\SOH\n\
    \\EOT\EOT\NUL\STX\SI\DC2\ETXB\EOTT\SUB\195\SOH If set, the most recent worker version stamp that appeared in a workflow task completion\n\
    \ Deprecated. This field should be cleaned up when versioning-2 API is removed. [cleanup-experimental-wv]\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SI\ACK\DC2\ETXB\EOT-\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SI\SOH\DC2\ETXB.N\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SI\ETX\DC2\ETXBQS\n\
    \\164\SOH\n\
    \\EOT\EOT\NUL\STX\DLE\DC2\ETXE\EOT5\SUB\150\SOH Workflow execution duration is defined as difference between close time and execution time.\n\
    \ This field is only populated if the workflow is closed.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DLE\ACK\DC2\ETXE\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DLE\SOH\DC2\ETXE\GS/\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DLE\ETX\DC2\ETXE24\n\
    \\153\b\n\
    \\EOT\EOT\NUL\STX\DC1\DC2\ETXW\EOTA\SUB\139\b Contains information about the root workflow execution.\n\
    \ The root workflow execution is defined as follows:\n\
    \ 1. A workflow without parent workflow is its own root workflow.\n\
    \ 2. A workflow that has a parent workflow has the same root workflow as its parent workflow.\n\
    \ Note: workflows continued as new or reseted may or may not have parents, check examples below.\n\
    \\n\
    \ Examples:\n\
    \   Scenario 1: Workflow W1 starts child workflow W2, and W2 starts child workflow W3.\n\
    \     - The root workflow of all three workflows is W1.\n\
    \   Scenario 2: Workflow W1 starts child workflow W2, and W2 continued as new W3.\n\
    \     - The root workflow of all three workflows is W1.\n\
    \   Scenario 3: Workflow W1 continued as new W2.\n\
    \     - The root workflow of W1 is W1 and the root workflow of W2 is W2.\n\
    \   Scenario 4: Workflow W1 starts child workflow W2, and W2 is reseted, creating W3\n\
    \     - The root workflow of all three workflows is W1.\n\
    \   Scenario 5: Workflow W1 is reseted, creating W2.\n\
    \     - The root workflow of W1 is W1 and the root workflow of W2 is W2.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC1\ACK\DC2\ETXW\EOT,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC1\SOH\DC2\ETXW-;\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC1\ETX\DC2\ETXW>@\n\
    \\129\ENQ\n\
    \\EOT\EOT\NUL\STX\DC2\DC2\ETX_\EOT\"\SUB\243\EOT The currently assigned build ID for this execution. Presence of this value means worker versioning is used\n\
    \ for this execution. Assigned build ID is selected based on Worker Versioning Assignment Rules\n\
    \ when the first workflow task of the execution is scheduled. If the first workflow task fails and is scheduled\n\
    \ again, the assigned build ID may change according to the latest versioning rules.\n\
    \ Assigned build ID can also change in the middle of a execution if Compatible Redirect Rules are applied to\n\
    \ this execution.\n\
    \ Deprecated. This field should be cleaned up when versioning-2 API is removed. [cleanup-experimental-wv]\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC2\ENQ\DC2\ETX_\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC2\SOH\DC2\ETX_\v\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC2\ETX\DC2\ETX_\US!\n\
    \\136\STX\n\
    \\EOT\EOT\NUL\STX\DC3\DC2\ETXc\EOT#\SUB\250\SOH Build ID inherited from a previous/parent execution. If present, assigned_build_id will be set to this, instead\n\
    \ of using the assignment rules.\n\
    \ Deprecated. This field should be cleaned up when versioning-2 API is removed. [cleanup-experimental-wv]\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC3\ENQ\DC2\ETXc\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC3\SOH\DC2\ETXc\v\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC3\ETX\DC2\ETXc \"\n\
    \\214\SOH\n\
    \\EOT\EOT\NUL\STX\DC4\DC2\ETXj\EOT\GS\SUB\200\SOH The first run ID in the execution chain.\n\
    \ Executions created via the following operations are considered to be in the same chain\n\
    \ - ContinueAsNew\n\
    \ - Workflow Retry\n\
    \ - Workflow Reset\n\
    \ - Cron Schedule\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC4\ENQ\DC2\ETXj\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC4\SOH\DC2\ETXj\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\DC4\ETX\DC2\ETXj\SUB\FS\n\
    \\173\STX\n\
    \\EOT\EOT\NUL\STX\NAK\DC2\ETXo\EOT9\SUB\159\STX Absent value means the workflow execution is not versioned. When present, the execution might\n\
    \ be versioned or unversioned, depending on `versioning_info.behavior` and `versioning_info.versioning_override`.\n\
    \ Experimental. Versioning info is experimental and might change in the future.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NAK\ACK\DC2\ETXo\EOT#\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NAK\SOH\DC2\ETXo$3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NAK\ETX\DC2\ETXo68\n\
    \\174\SOH\n\
    \\EOT\EOT\NUL\STX\SYN\DC2\ETXs\EOT'\SUB\160\SOH The name of Worker Deployment that completed the most recent workflow task.\n\
    \ Experimental. Worker Deployments are experimental and might change in the future.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SYN\ENQ\DC2\ETXs\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SYN\SOH\DC2\ETXs\v!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SYN\ETX\DC2\ETXs$&\n\
    \ \n\
    \\EOT\EOT\NUL\STX\ETB\DC2\ETXv\EOT2\SUB\DC3 Priority metadata\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETB\ACK\DC2\ETXv\EOT#\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETB\SOH\DC2\ETXv$,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETB\ETX\DC2\ETXv/1\n\
    \g\n\
    \\STX\EOT\SOH\DC2\ENQz\NUL\141\SOH\SOH\SUBZ Holds all the extra information about workflow execution that is not part of Visibility.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETXz\b%\n\
    \\163\SOH\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX}\EOT<\SUB\149\SOH Workflow execution expiration time is defined as workflow start time plus expiration timeout.\n\
    \ Workflow start time may change after workflow reset.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX}\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX}\RS7\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX}:;\n\
    \u\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\EOT\128\SOH\EOT6\SUBg Workflow run expiration time is defined as current workflow run start time plus workflow run timeout.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\EOT\128\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\EOT\128\SOH\RS1\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\EOT\128\SOH45\n\
    \C\n\
    \\EOT\EOT\SOH\STX\STX\DC2\EOT\131\SOH\EOT\RS\SUB5 indicates if the workflow received a cancel request\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\STX\ENQ\DC2\EOT\131\SOH\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\EOT\131\SOH\t\EM\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\EOT\131\SOH\FS\GS\n\
    \N\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\EOT\134\SOH\EOT2\SUB@ Last workflow reset time. Nil if the workflow was never reset.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\ETX\ACK\DC2\EOT\134\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\EOT\134\SOH\RS-\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\EOT\134\SOH01\n\
    \-\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\EOT\137\SOH\EOT6\SUB\US Original workflow start time.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\EOT\ACK\DC2\EOT\137\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\EOT\137\SOH\RS1\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\EOT\137\SOH45\n\
    \\152\SOH\n\
    \\EOT\EOT\SOH\STX\ENQ\DC2\EOT\140\SOH\EOT\FS\SUB\137\SOH Reset Run ID points to the new run when this execution is reset. If the execution is reset multiple times, it points to the latest run.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\ENQ\ENQ\DC2\EOT\140\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\ENQ\SOH\DC2\EOT\140\SOH\v\ETB\n\
    \\r\n\
    \\ENQ\EOT\SOH\STX\ENQ\ETX\DC2\EOT\140\SOH\SUB\ESC\n\
    \\182\SOH\n\
    \\STX\EOT\STX\DC2\ACK\145\SOH\NUL\219\SOH\SOH\SUB\167\SOH Holds all the information about worker versioning for a particular workflow execution.\n\
    \ Experimental. Versioning info is experimental and might change in the future.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\STX\SOH\DC2\EOT\145\SOH\b'\n\
    \\148\a\n\
    \\EOT\EOT\STX\STX\NUL\DC2\EOT\157\SOH\EOT:\SUB\133\a Versioning behavior determines how the server should treat this execution when workers are\n\
    \ upgraded. When present it means this workflow execution is versioned; UNSPECIFIED means\n\
    \ unversioned. See the comments in `VersioningBehavior` enum for more info about different\n\
    \ behaviors.\n\
    \ This field is first set after an execution completes its first workflow task on a versioned\n\
    \ worker, and set again on completion of every subsequent workflow task.\n\
    \ For child workflows of Pinned parents, this will be set to Pinned (along with `version`) when\n\
    \ the the child starts so that child's first workflow task goes to the same Version as the\n\
    \ parent. After the first workflow task, it depends on the child workflow itself if it wants\n\
    \ to stay pinned or become unpinned (according to Versioning Behavior set in the worker).\n\
    \ Note that `behavior` is overridden by `versioning_override` if the latter is present.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\EOT\157\SOH\EOT,\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\EOT\157\SOH-5\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\EOT\157\SOH89\n\
    \\196\EOT\n\
    \\EOT\EOT\STX\STX\SOH\DC2\EOT\165\SOH\EOTM\SUB\181\EOT The worker deployment that completed the last workflow task of this workflow execution. Must\n\
    \ be present if `behavior` is set. Absent value means no workflow task is completed, or the\n\
    \ last workflow task was completed by an unversioned worker. Unversioned workers may still send\n\
    \ a deployment value which will be stored here, so the right way to check if an execution is\n\
    \ versioned if an execution is versioned or not is via the `behavior` field.\n\
    \ Note that `deployment` is overridden by `versioning_override` if the latter is present.\n\
    \ Deprecated. Use `version`.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\EOT\165\SOH\EOT)\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\EOT\165\SOH*4\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\EOT\165\SOH78\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\SOH\b\DC2\EOT\165\SOH9L\n\
    \\SO\n\
    \\ACK\EOT\STX\STX\SOH\b\ETX\DC2\EOT\165\SOH:K\n\
    \\221\EOT\n\
    \\EOT\EOT\STX\STX\STX\DC2\EOT\174\SOH\EOT\ETB\SUB\206\EOT The Worker Deployment Version that completed the last workflow task of this workflow\n\
    \ execution, in the form \"<deployment_name>.<build_id>\".\n\
    \ Must be present if and only if `behavior` is set. An absent value means no workflow task is\n\
    \ completed, or the workflow is unversioned.\n\
    \ For child workflows of Pinned parents, this will be set to parent's Pinned Version when the\n\
    \ the child starts so that child's first workflow task goes to the same Version as the parent.\n\
    \ Note that if `versioning_override.behavior` is PINNED then `versioning_override.pinned_version`\n\
    \ will override this value.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\STX\ENQ\DC2\EOT\174\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\EOT\174\SOH\v\DC2\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\EOT\174\SOH\NAK\SYN\n\
    \\250\STX\n\
    \\EOT\EOT\STX\STX\ETX\DC2\EOT\180\SOH\EOT/\SUB\235\STX Present if user has set an execution-specific versioning override. This override takes\n\
    \ precedence over SDK-sent `behavior` (and `version` when override is PINNED). An\n\
    \ override can be set when starting a new execution, as well as afterwards by calling the\n\
    \ `UpdateWorkflowExecutionOptions` API.\n\
    \ Pinned overrides are automatically inherited by child workflows.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\ETX\ACK\DC2\EOT\180\SOH\EOT\SYN\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\EOT\180\SOH\ETB*\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\EOT\180\SOH-.\n\
    \\244\n\
    \\n\
    \\EOT\EOT\STX\STX\EOT\DC2\EOT\199\SOH\EOTG\SUB\229\n\
    \ When present, indicates the workflow is transitioning to a different deployment. Can\n\
    \ indicate one of the following transitions: unversioned -> versioned, versioned -> versioned\n\
    \ on a different deployment, or versioned -> unversioned.\n\
    \ Not applicable to workflows with PINNED behavior.\n\
    \ When a workflow with AUTO_UPGRADE behavior creates a new workflow task, it will automatically\n\
    \ start a transition to the task queue's current deployment if the task queue's current\n\
    \ deployment is different from the workflow's deployment.\n\
    \ If the AUTO_UPGRADE workflow is stuck due to backlogged activity or workflow tasks, those\n\
    \ tasks will be redirected to the task queue's current deployment. As soon as a poller from\n\
    \ that deployment is available to receive the task, the workflow will automatically start a\n\
    \ transition to that deployment and continue execution there.\n\
    \ A deployment transition can only exist while there is a pending or started workflow task.\n\
    \ Once the pending workflow task completes on the transition's target deployment, the\n\
    \ transition completes and the workflow's `deployment` and `behavior` fields are updated per\n\
    \ the worker's task completion response.\n\
    \ Pending activities will not start new attempts during a transition. Once the transition is\n\
    \ completed, pending activities will start their next attempt on the new deployment.\n\
    \ Deprecated. Use version_transition.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\EOT\ACK\DC2\EOT\199\SOH\EOT\CAN\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\EOT\SOH\DC2\EOT\199\SOH\EM.\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\EOT\ETX\DC2\EOT\199\SOH12\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\EOT\b\DC2\EOT\199\SOH3F\n\
    \\SO\n\
    \\ACK\EOT\STX\STX\EOT\b\ETX\DC2\EOT\199\SOH4E\n\
    \\155\v\n\
    \\EOT\EOT\STX\STX\ENQ\DC2\EOT\218\SOH\EOT7\SUB\140\v When present, indicates the workflow is transitioning to a different deployment version\n\
    \ (which may belong to the same deployment name or another). Can indicate one of the following\n\
    \ transitions: unversioned -> versioned, versioned -> versioned\n\
    \ on a different deployment version, or versioned -> unversioned.\n\
    \ Not applicable to workflows with PINNED behavior.\n\
    \ When a workflow with AUTO_UPGRADE behavior creates a new workflow task, it will automatically\n\
    \ start a transition to the task queue's current version if the task queue's current version is\n\
    \ different from the workflow's current deployment version.\n\
    \ If the AUTO_UPGRADE workflow is stuck due to backlogged activity or workflow tasks, those\n\
    \ tasks will be redirected to the task queue's current version. As soon as a poller from\n\
    \ that deployment version is available to receive the task, the workflow will automatically\n\
    \ start a transition to that version and continue execution there.\n\
    \ A version transition can only exist while there is a pending or started workflow task.\n\
    \ Once the pending workflow task completes on the transition's target version, the\n\
    \ transition completes and the workflow's `behavior`, and `version` fields are updated per the\n\
    \ worker's task completion response.\n\
    \ Pending activities will not start new attempts during a transition. Once the transition is\n\
    \ completed, pending activities will start their next attempt on the new version.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\ENQ\ACK\DC2\EOT\218\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\ENQ\SOH\DC2\EOT\218\SOH 2\n\
    \\r\n\
    \\ENQ\EOT\STX\STX\ENQ\ETX\DC2\EOT\218\SOH56\n\
    \\161\SOH\n\
    \\STX\EOT\ETX\DC2\ACK\223\SOH\NUL\229\SOH\SOH\SUB\146\SOH Holds information about ongoing transition of a workflow execution from one deployment to another.\n\
    \ Deprecated. Use DeploymentVersionTransition.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\ETX\SOH\DC2\EOT\223\SOH\b\FS\n\
    \\137\SOH\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\EOT\226\SOH\EOT9\SUB{ The target deployment of the transition. Null means a so-far-versioned workflow is\n\
    \ transitioning to unversioned workers.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NUL\ACK\DC2\EOT\226\SOH\EOT)\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\EOT\226\SOH*4\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\EOT\226\SOH78\n\
    \\174\SOH\n\
    \\STX\EOT\EOT\DC2\ACK\234\SOH\NUL\240\SOH\SOH\SUB\159\SOH Holds information about ongoing transition of a workflow execution from one worker\n\
    \ deployment version to another.\n\
    \ Experimental. Might change in the future.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\EOT\SOH\DC2\EOT\234\SOH\b#\n\
    \\171\SOH\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\EOT\237\SOH\EOT\ETB\SUB\156\SOH Required. The target Version of the transition. May be `__unversioned__` which means a\n\
    \ so-far-versioned workflow is transitioning to unversioned workers.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\EOT\237\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\EOT\237\SOH\v\DC2\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\EOT\237\SOH\NAK\SYN\n\
    \\f\n\
    \\STX\EOT\ENQ\DC2\ACK\242\SOH\NUL\249\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\ENQ\SOH\DC2\EOT\242\SOH\b\US\n\
    \\f\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\EOT\243\SOH\EOT7\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\EOT\243\SOH\EOT'\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\EOT\243\SOH(2\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\EOT\243\SOH56\n\
    \\f\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\EOT\244\SOH\EOT<\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\EOT\244\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\EOT\244\SOH\GS7\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\EOT\244\SOH:;\n\
    \\f\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\EOT\245\SOH\EOT6\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\STX\ACK\DC2\EOT\245\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\EOT\245\SOH\GS1\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\EOT\245\SOH45\n\
    \\f\n\
    \\EOT\EOT\ENQ\STX\ETX\DC2\EOT\246\SOH\EOT?\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\ETX\ACK\DC2\EOT\246\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\ETX\SOH\DC2\EOT\246\SOH\GS:\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\ETX\ETX\DC2\EOT\246\SOH=>\n\
    \9\n\
    \\EOT\EOT\ENQ\STX\EOT\DC2\EOT\248\SOH\EOT7\SUB+ User metadata provided on start workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\EOT\ACK\DC2\EOT\248\SOH\EOT$\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\EOT\SOH\DC2\EOT\248\SOH%2\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\EOT\ETX\DC2\EOT\248\SOH56\n\
    \\f\n\
    \\STX\EOT\ACK\DC2\ACK\251\SOH\NUL\199\STX\SOH\n\
    \\v\n\
    \\ETX\EOT\ACK\SOH\DC2\EOT\251\SOH\b\ESC\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\EOT\252\SOH\EOT\ESC\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\EOT\252\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\EOT\252\SOH\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\EOT\252\SOH\EM\SUB\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\EOT\253\SOH\EOT:\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SOH\ACK\DC2\EOT\253\SOH\EOT'\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\EOT\253\SOH(5\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\EOT\253\SOH89\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\STX\DC2\EOT\254\SOH\EOT9\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\STX\ACK\DC2\EOT\254\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\EOT\254\SOH/4\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\EOT\254\SOH78\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\ETX\DC2\EOT\255\SOH\EOT:\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ETX\ACK\DC2\EOT\255\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ETX\SOH\DC2\EOT\255\SOH$5\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ETX\ETX\DC2\EOT\255\SOH89\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\EOT\DC2\EOT\128\STX\EOT6\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\EOT\ACK\DC2\EOT\128\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\EOT\SOH\DC2\EOT\128\STX\RS1\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\EOT\ETX\DC2\EOT\128\STX45\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\ENQ\DC2\EOT\129\STX\EOT4\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ENQ\ACK\DC2\EOT\129\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ENQ\SOH\DC2\EOT\129\STX\RS/\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ENQ\ETX\DC2\EOT\129\STX23\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\ACK\DC2\EOT\130\STX\EOT\SYN\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ACK\ENQ\DC2\EOT\130\STX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ACK\SOH\DC2\EOT\130\STX\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\ACK\ETX\DC2\EOT\130\STX\DC4\NAK\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\a\DC2\EOT\131\STX\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\a\ENQ\DC2\EOT\131\STX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\a\SOH\DC2\EOT\131\STX\n\
    \\SUB\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\a\ETX\DC2\EOT\131\STX\GS\RS\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\b\DC2\EOT\132\STX\EOT1\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\b\ACK\DC2\EOT\132\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\b\SOH\DC2\EOT\132\STX\RS,\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\b\ETX\DC2\EOT\132\STX/0\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\t\DC2\EOT\133\STX\EOT3\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\t\ACK\DC2\EOT\133\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\t\SOH\DC2\EOT\133\STX\RS-\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\t\ETX\DC2\EOT\133\STX02\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\n\
    \\DC2\EOT\134\STX\EOT6\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\n\
    \\ACK\DC2\EOT\134\STX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\n\
    \\SOH\DC2\EOT\134\STX$0\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\n\
    \\ETX\DC2\EOT\134\STX35\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\v\DC2\EOT\135\STX\EOT%\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\v\ENQ\DC2\EOT\135\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\v\SOH\DC2\EOT\135\STX\v\US\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\v\ETX\DC2\EOT\135\STX\"$\n\
    \\168\ETX\n\
    \\EOT\EOT\ACK\b\NUL\DC2\ACK\140\STX\EOT\148\STX\ENQ\SUB\151\ETX Absence of `assigned_build_id` generally means this task is on an \"unversioned\" task queue.\n\
    \ In rare cases, it can also mean that the task queue is versioned but we failed to write activity's\n\
    \ independently-assigned build ID to the database. This case heals automatically once the task is dispatched.\n\
    \ Deprecated. This field should be cleaned up when versioning-2 API is removed. [cleanup-experimental-wv]\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\b\NUL\SOH\DC2\EOT\140\STX\n\
    \\ESC\n\
    \a\n\
    \\EOT\EOT\ACK\STX\f\DC2\EOT\142\STX\b9\SUBS When present, it means this activity is assigned to the build ID of its workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\f\ACK\DC2\EOT\142\STX\b\GS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\f\SOH\DC2\EOT\142\STX\RS3\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\f\ETX\DC2\EOT\142\STX68\n\
    \\164\STX\n\
    \\EOT\EOT\ACK\STX\r\DC2\EOT\147\STX\b9\SUB\149\STX This means the activity is independently versioned and not bound to the build ID of its workflow.\n\
    \ The activity will use the build id in this field instead.\n\
    \ If the task fails and is scheduled again, the assigned build ID may change according to the latest versioning\n\
    \ rules.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\r\ENQ\DC2\EOT\147\STX\b\SO\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\r\SOH\DC2\EOT\147\STX\SI3\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\r\ETX\DC2\EOT\147\STX68\n\
    \\204\SOH\n\
    \\EOT\EOT\ACK\STX\SO\DC2\EOT\151\STX\EOTM\SUB\189\SOH The version stamp of the worker to whom this activity was most recently dispatched\n\
    \ Deprecated. This field should be cleaned up when versioning-2 API is removed. [cleanup-experimental-wv]\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SO\ACK\DC2\EOT\151\STX\EOT-\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SO\SOH\DC2\EOT\151\STX.G\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SO\ETX\DC2\EOT\151\STXJL\n\
    \\136\STX\n\
    \\EOT\EOT\ACK\STX\SI\DC2\EOT\157\STX\EOT9\SUB\249\SOH The time activity will wait until the next retry.\n\
    \ If activity is currently running it will be next retry interval if activity failed.\n\
    \ If activity is currently waiting it will be current retry interval.\n\
    \ If there will be no retry it will be null.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SI\ACK\DC2\EOT\157\STX\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SI\SOH\DC2\EOT\157\STX\GS3\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SI\ETX\DC2\EOT\157\STX68\n\
    \\131\SOH\n\
    \\EOT\EOT\ACK\STX\DLE\DC2\EOT\160\STX\EOT>\SUBu The time when the last activity attempt was completed. If activity has not been completed yet then it will be null.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DLE\ACK\DC2\EOT\160\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DLE\SOH\DC2\EOT\160\STX\RS8\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DLE\ETX\DC2\EOT\160\STX;=\n\
    \z\n\
    \\EOT\EOT\ACK\STX\DC1\DC2\EOT\164\STX\EOT>\SUBl Next time when activity will be scheduled.\n\
    \ If activity is currently scheduled or started it will be null.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC1\ACK\DC2\EOT\164\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC1\SOH\DC2\EOT\164\STX\RS8\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC1\ETX\DC2\EOT\164\STX;=\n\
    \0\n\
    \\EOT\EOT\ACK\STX\DC2\DC2\EOT\167\STX\EOT\NAK\SUB\" Indicates if activity is paused.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC2\ENQ\DC2\EOT\167\STX\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC2\SOH\DC2\EOT\167\STX\t\SI\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC2\ETX\DC2\EOT\167\STX\DC2\DC4\n\
    \\197\SOH\n\
    \\EOT\EOT\ACK\STX\DC3\DC2\EOT\172\STX\EOTS\SUB\182\SOH The deployment this activity was dispatched to most recently. Present only if the activity\n\
    \ was dispatched to a versioned worker.\n\
    \ Deprecated. Use `last_worker_deployment_version`.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC3\ACK\DC2\EOT\172\STX\EOT)\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC3\SOH\DC2\EOT\172\STX*9\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC3\ETX\DC2\EOT\172\STX<>\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC3\b\DC2\EOT\172\STX?R\n\
    \\SO\n\
    \\ACK\EOT\ACK\STX\DC3\b\ETX\DC2\EOT\172\STX@Q\n\
    \\\\n\
    \\EOT\EOT\ACK\STX\DC4\DC2\EOT\174\STX\EOT/\SUBN The Worker Deployment Version this activity was dispatched to most recently.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC4\ENQ\DC2\EOT\174\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC4\SOH\DC2\EOT\174\STX\v)\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\DC4\ETX\DC2\EOT\174\STX,.\n\
    \!\n\
    \\EOT\EOT\ACK\STX\NAK\DC2\EOT\177\STX\EOT2\SUB\DC3 Priority metadata\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NAK\ACK\DC2\EOT\177\STX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NAK\SOH\DC2\EOT\177\STX$,\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NAK\ETX\DC2\EOT\177\STX/1\n\
    \\SO\n\
    \\EOT\EOT\ACK\ETX\NUL\DC2\ACK\179\STX\EOT\196\STX\ENQ\n\
    \\r\n\
    \\ENQ\EOT\ACK\ETX\NUL\SOH\DC2\EOT\179\STX\f\NAK\n\
    \8\n\
    \\ACK\EOT\ACK\ETX\NUL\STX\NUL\DC2\EOT\181\STX\b1\SUB( The time when the activity was paused.\n\
    \\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\NUL\ACK\DC2\EOT\181\STX\b!\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\NUL\SOH\DC2\EOT\181\STX\",\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\NUL\ETX\DC2\EOT\181\STX/0\n\
    \\DLE\n\
    \\ACK\EOT\ACK\ETX\NUL\ETX\NUL\DC2\ACK\183\STX\b\188\STX\t\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\ETX\NUL\SOH\DC2\EOT\183\STX\DLE\SYN\n\
    \G\n\
    \\b\EOT\ACK\ETX\NUL\ETX\NUL\STX\NUL\DC2\EOT\185\STX\f \SUB5 The identity of the actor that paused the activity.\n\
    \\n\
    \\DC1\n\
    \\t\EOT\ACK\ETX\NUL\ETX\NUL\STX\NUL\ENQ\DC2\EOT\185\STX\f\DC2\n\
    \\DC1\n\
    \\t\EOT\ACK\ETX\NUL\ETX\NUL\STX\NUL\SOH\DC2\EOT\185\STX\DC3\ESC\n\
    \\DC1\n\
    \\t\EOT\ACK\ETX\NUL\ETX\NUL\STX\NUL\ETX\DC2\EOT\185\STX\RS\US\n\
    \4\n\
    \\b\EOT\ACK\ETX\NUL\ETX\NUL\STX\SOH\DC2\EOT\187\STX\f\RS\SUB\" Reason for pausing the activity.\n\
    \\n\
    \\DC1\n\
    \\t\EOT\ACK\ETX\NUL\ETX\NUL\STX\SOH\ENQ\DC2\EOT\187\STX\f\DC2\n\
    \\DC1\n\
    \\t\EOT\ACK\ETX\NUL\ETX\NUL\STX\SOH\SOH\DC2\EOT\187\STX\DC3\EM\n\
    \\DC1\n\
    \\t\EOT\ACK\ETX\NUL\ETX\NUL\STX\SOH\ETX\DC2\EOT\187\STX\FS\GS\n\
    \\DLE\n\
    \\ACK\EOT\ACK\ETX\NUL\b\NUL\DC2\ACK\189\STX\b\195\STX\t\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\b\NUL\SOH\DC2\EOT\189\STX\SO\ETB\n\
    \@\n\
    \\ACK\EOT\ACK\ETX\NUL\STX\SOH\DC2\EOT\191\STX\f\RS\SUB0 activity was paused by the manual intervention\n\
    \\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\SOH\ACK\DC2\EOT\191\STX\f\DC2\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\SOH\SOH\DC2\EOT\191\STX\DC3\EM\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\SOH\ETX\DC2\EOT\191\STX\FS\GS\n\
    \:\n\
    \\ACK\EOT\ACK\ETX\NUL\STX\STX\DC2\EOT\194\STX\f\US\SUB* Id of the rule that paused the activity.\n\
    \\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\STX\ENQ\DC2\EOT\194\STX\f\DC2\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\STX\SOH\DC2\EOT\194\STX\DC3\SUB\n\
    \\SI\n\
    \\a\EOT\ACK\ETX\NUL\STX\STX\ETX\DC2\EOT\194\STX\GS\RS\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\SYN\DC2\EOT\198\STX\EOT\RS\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SYN\ACK\DC2\EOT\198\STX\EOT\r\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SYN\SOH\DC2\EOT\198\STX\SO\CAN\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\SYN\ETX\DC2\EOT\198\STX\ESC\GS\n\
    \\f\n\
    \\STX\EOT\a\DC2\ACK\201\STX\NUL\208\STX\SOH\n\
    \\v\n\
    \\ETX\EOT\a\SOH\DC2\EOT\201\STX\b!\n\
    \\f\n\
    \\EOT\EOT\a\STX\NUL\DC2\EOT\202\STX\EOT\ESC\n\
    \\r\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\EOT\202\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\EOT\202\STX\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\EOT\202\STX\EM\SUB\n\
    \\f\n\
    \\EOT\EOT\a\STX\SOH\DC2\EOT\203\STX\EOT\SYN\n\
    \\r\n\
    \\ENQ\EOT\a\STX\SOH\ENQ\DC2\EOT\203\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\EOT\203\STX\v\DC1\n\
    \\r\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\EOT\203\STX\DC4\NAK\n\
    \\f\n\
    \\EOT\EOT\a\STX\STX\DC2\EOT\204\STX\EOT\"\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\ENQ\DC2\EOT\204\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\SOH\DC2\EOT\204\STX\v\GS\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\ETX\DC2\EOT\204\STX !\n\
    \\f\n\
    \\EOT\EOT\a\STX\ETX\DC2\EOT\205\STX\EOT\ESC\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\ENQ\DC2\EOT\205\STX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\SOH\DC2\EOT\205\STX\n\
    \\SYN\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\ETX\DC2\EOT\205\STX\EM\SUB\n\
    \7\n\
    \\EOT\EOT\a\STX\EOT\DC2\EOT\207\STX\EOTD\SUB) Default: PARENT_CLOSE_POLICY_TERMINATE.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\ACK\DC2\EOT\207\STX\EOT+\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\SOH\DC2\EOT\207\STX,?\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\ETX\DC2\EOT\207\STXBC\n\
    \\f\n\
    \\STX\EOT\b\DC2\ACK\210\STX\NUL\220\STX\SOH\n\
    \\v\n\
    \\ETX\EOT\b\SOH\DC2\EOT\210\STX\b\US\n\
    \\f\n\
    \\EOT\EOT\b\STX\NUL\DC2\EOT\211\STX\EOT=\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\ACK\DC2\EOT\211\STX\EOT2\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\EOT\211\STX38\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\EOT\211\STX;<\n\
    \\f\n\
    \\EOT\EOT\b\STX\SOH\DC2\EOT\212\STX\EOT1\n\
    \\r\n\
    \\ENQ\EOT\b\STX\SOH\ACK\DC2\EOT\212\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\EOT\212\STX\RS,\n\
    \\r\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\EOT\212\STX/0\n\
    \\151\ETX\n\
    \\EOT\EOT\b\STX\STX\DC2\EOT\217\STX\EOT:\SUB\136\ETX original_scheduled_time is the scheduled time of the first workflow task during workflow task heartbeat.\n\
    \ Heartbeat workflow task is done by RespondWorkflowTaskComplete with ForceCreateNewWorkflowTask == true and no command\n\
    \ In this case, OriginalScheduledTime won't change. Then when current time - original_scheduled_time exceeds\n\
    \ some threshold, the workflow task will be forced timeout.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\b\STX\STX\ACK\DC2\EOT\217\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\b\STX\STX\SOH\DC2\EOT\217\STX\RS5\n\
    \\r\n\
    \\ENQ\EOT\b\STX\STX\ETX\DC2\EOT\217\STX89\n\
    \\f\n\
    \\EOT\EOT\b\STX\ETX\DC2\EOT\218\STX\EOT/\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ETX\ACK\DC2\EOT\218\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ETX\SOH\DC2\EOT\218\STX\RS*\n\
    \\r\n\
    \\ENQ\EOT\b\STX\ETX\ETX\DC2\EOT\218\STX-.\n\
    \\f\n\
    \\EOT\EOT\b\STX\EOT\DC2\EOT\219\STX\EOT\SYN\n\
    \\r\n\
    \\ENQ\EOT\b\STX\EOT\ENQ\DC2\EOT\219\STX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\b\STX\EOT\SOH\DC2\EOT\219\STX\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\b\STX\EOT\ETX\DC2\EOT\219\STX\DC4\NAK\n\
    \\f\n\
    \\STX\EOT\t\DC2\ACK\222\STX\NUL\224\STX\SOH\n\
    \\v\n\
    \\ETX\EOT\t\SOH\DC2\EOT\222\STX\b\DC3\n\
    \\f\n\
    \\EOT\EOT\t\STX\NUL\DC2\EOT\223\STX\EOT'\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\EOT\DC2\EOT\223\STX\EOT\f\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ACK\DC2\EOT\223\STX\r\ESC\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\EOT\223\STX\FS\"\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\EOT\223\STX%&\n\
    \\155\STX\n\
    \\STX\EOT\n\
    \\DC2\ACK\229\STX\NUL\245\STX\SOH\SUB\140\STX ResetPointInfo records the workflow event id that is the first one processed by a given\n\
    \ build id or binary checksum. A new reset point will be created if either build id or binary\n\
    \ checksum changes (although in general only one or the other will be used at a time).\n\
    \\n\
    \\v\n\
    \\ETX\EOT\n\
    \\SOH\DC2\EOT\229\STX\b\SYN\n\
    \ \n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\EOT\231\STX\EOT\CAN\SUB\DC2 Worker build id.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\EOT\231\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\EOT\231\STX\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\EOT\231\STX\SYN\ETB\n\
    \@\n\
    \\EOT\EOT\n\
    \\STX\SOH\DC2\EOT\233\STX\EOT\US\SUB2 A worker binary version identifier (deprecated).\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ENQ\DC2\EOT\233\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\SOH\SOH\DC2\EOT\233\STX\v\SUB\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ETX\DC2\EOT\233\STX\GS\RS\n\
    \^\n\
    \\EOT\EOT\n\
    \\STX\STX\DC2\EOT\235\STX\EOT\SYN\SUBP The first run ID in the execution chain that was touched by this worker build.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\STX\ENQ\DC2\EOT\235\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\STX\SOH\DC2\EOT\235\STX\v\DC1\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\STX\ETX\DC2\EOT\235\STX\DC4\NAK\n\
    \a\n\
    \\EOT\EOT\n\
    \\STX\ETX\DC2\EOT\237\STX\EOT/\SUBS Event ID of the first WorkflowTaskCompleted event processed by this worker build.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ETX\ENQ\DC2\EOT\237\STX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ETX\SOH\DC2\EOT\237\STX\n\
    \*\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ETX\ETX\DC2\EOT\237\STX-.\n\
    \\f\n\
    \\EOT\EOT\n\
    \\STX\EOT\DC2\EOT\238\STX\EOT.\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\EOT\ACK\DC2\EOT\238\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\EOT\SOH\DC2\EOT\238\STX\RS)\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\EOT\ETX\DC2\EOT\238\STX,-\n\
    \\192\SOH\n\
    \\EOT\EOT\n\
    \\STX\ENQ\DC2\EOT\242\STX\EOT.\SUB\177\SOH (-- api-linter: core::0214::resource-expiry=disabled\n\
    \     aip.dev/not-precedent: TTL is not defined for ResetPointInfo. --)\n\
    \ The time that the run is deleted due to retention.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\ACK\DC2\EOT\242\STX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\SOH\DC2\EOT\242\STX\RS)\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\ETX\DC2\EOT\242\STX,-\n\
    \Y\n\
    \\EOT\EOT\n\
    \\STX\ACK\DC2\EOT\244\STX\EOT\CAN\SUBK false if the reset point has pending childWFs/reqCancels/signalExternals.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ACK\ENQ\DC2\EOT\244\STX\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ACK\SOH\DC2\EOT\244\STX\t\DC3\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\ACK\ETX\DC2\EOT\244\STX\SYN\ETB\n\
    \\153\SOH\n\
    \\STX\EOT\v\DC2\ACK\249\STX\NUL\151\ETX\SOH\SUB\138\SOH NewWorkflowExecutionInfo is a shared message that encapsulates all the\n\
    \ required arguments to starting a workflow in different contexts.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\v\SOH\DC2\EOT\249\STX\b \n\
    \\f\n\
    \\EOT\EOT\v\STX\NUL\DC2\EOT\250\STX\EOT\ESC\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ENQ\DC2\EOT\250\STX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\EOT\250\STX\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\EOT\250\STX\EM\SUB\n\
    \\f\n\
    \\EOT\EOT\v\STX\SOH\DC2\EOT\251\STX\EOT:\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ACK\DC2\EOT\251\STX\EOT'\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\EOT\251\STX(5\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\EOT\251\STX89\n\
    \\f\n\
    \\EOT\EOT\v\STX\STX\DC2\EOT\252\STX\EOT7\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ACK\DC2\EOT\252\STX\EOT'\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\SOH\DC2\EOT\252\STX(2\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ETX\DC2\EOT\252\STX56\n\
    \5\n\
    \\EOT\EOT\v\STX\ETX\DC2\EOT\254\STX\EOT.\SUB' Serialized arguments to the workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\ACK\DC2\EOT\254\STX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\SOH\DC2\EOT\254\STX$)\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\ETX\DC2\EOT\254\STX,-\n\
    \W\n\
    \\EOT\EOT\v\STX\EOT\DC2\EOT\128\ETX\EOT<\SUBI Total workflow execution timeout including retries and continue as new.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\EOT\ACK\DC2\EOT\128\ETX\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\v\STX\EOT\SOH\DC2\EOT\128\ETX\GS7\n\
    \\r\n\
    \\ENQ\EOT\v\STX\EOT\ETX\DC2\EOT\128\ETX:;\n\
    \1\n\
    \\EOT\EOT\v\STX\ENQ\DC2\EOT\130\ETX\EOT6\SUB# Timeout of a single workflow run.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ENQ\ACK\DC2\EOT\130\ETX\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ENQ\SOH\DC2\EOT\130\ETX\GS1\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ENQ\ETX\DC2\EOT\130\ETX45\n\
    \2\n\
    \\EOT\EOT\v\STX\ACK\DC2\EOT\132\ETX\EOT7\SUB$ Timeout of a single workflow task.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ACK\ACK\DC2\EOT\132\ETX\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ACK\SOH\DC2\EOT\132\ETX\GS2\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ACK\ETX\DC2\EOT\132\ETX56\n\
    \B\n\
    \\EOT\EOT\v\STX\a\DC2\EOT\134\ETX\EOTM\SUB4 Default: WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\a\ACK\DC2\EOT\134\ETX\EOT/\n\
    \\r\n\
    \\ENQ\EOT\v\STX\a\SOH\DC2\EOT\134\ETX0H\n\
    \\r\n\
    \\ENQ\EOT\v\STX\a\ETX\DC2\EOT\134\ETXKL\n\
    \b\n\
    \\EOT\EOT\v\STX\b\DC2\EOT\136\ETX\EOT8\SUBT The retry policy for the workflow. Will never exceed `workflow_execution_timeout`.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\b\ACK\DC2\EOT\136\ETX\EOT&\n\
    \\r\n\
    \\ENQ\EOT\v\STX\b\SOH\DC2\EOT\136\ETX'3\n\
    \\r\n\
    \\ENQ\EOT\v\STX\b\ETX\DC2\EOT\136\ETX67\n\
    \V\n\
    \\EOT\EOT\v\STX\t\DC2\EOT\138\ETX\EOT\RS\SUBH See https://docs.temporal.io/docs/content/what-is-a-temporal-cron-job/\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\t\ENQ\DC2\EOT\138\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\t\SOH\DC2\EOT\138\ETX\v\CAN\n\
    \\r\n\
    \\ENQ\EOT\v\STX\t\ETX\DC2\EOT\138\ETX\ESC\GS\n\
    \\f\n\
    \\EOT\EOT\v\STX\n\
    \\DC2\EOT\139\ETX\EOT*\n\
    \\r\n\
    \\ENQ\EOT\v\STX\n\
    \\ACK\DC2\EOT\139\ETX\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\v\STX\n\
    \\SOH\DC2\EOT\139\ETX $\n\
    \\r\n\
    \\ENQ\EOT\v\STX\n\
    \\ETX\DC2\EOT\139\ETX')\n\
    \\f\n\
    \\EOT\EOT\v\STX\v\DC2\EOT\140\ETX\EOTC\n\
    \\r\n\
    \\ENQ\EOT\v\STX\v\ACK\DC2\EOT\140\ETX\EOT+\n\
    \\r\n\
    \\ENQ\EOT\v\STX\v\SOH\DC2\EOT\140\ETX,=\n\
    \\r\n\
    \\ENQ\EOT\v\STX\v\ETX\DC2\EOT\140\ETX@B\n\
    \\f\n\
    \\EOT\EOT\v\STX\f\DC2\EOT\141\ETX\EOT.\n\
    \\r\n\
    \\ENQ\EOT\v\STX\f\ACK\DC2\EOT\141\ETX\EOT!\n\
    \\r\n\
    \\ENQ\EOT\v\STX\f\SOH\DC2\EOT\141\ETX\"(\n\
    \\r\n\
    \\ENQ\EOT\v\STX\f\ETX\DC2\EOT\141\ETX+-\n\
    \\210\SOH\n\
    \\EOT\EOT\v\STX\r\DC2\EOT\145\ETX\EOT8\SUB\195\SOH Metadata on the workflow if it is started. This is carried over to the WorkflowExecutionConfig\n\
    \ for use by user interfaces to display the fixed as-of-start summary and details of the\n\
    \ workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\r\ACK\DC2\EOT\145\ETX\EOT$\n\
    \\r\n\
    \\ENQ\EOT\v\STX\r\SOH\DC2\EOT\145\ETX%2\n\
    \\r\n\
    \\ENQ\EOT\v\STX\r\ETX\DC2\EOT\145\ETX57\n\
    \\205\SOH\n\
    \\EOT\EOT\v\STX\SO\DC2\EOT\148\ETX\EOT0\SUB\190\SOH If set, takes precedence over the Versioning Behavior sent by the SDK on Workflow Task completion.\n\
    \ To unset the override after the workflow is running, use UpdateWorkflowExecutionOptions.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SO\ACK\DC2\EOT\148\ETX\EOT\SYN\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SO\SOH\DC2\EOT\148\ETX\ETB*\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SO\ETX\DC2\EOT\148\ETX-/\n\
    \!\n\
    \\EOT\EOT\v\STX\SI\DC2\EOT\150\ETX\EOT2\SUB\DC3 Priority metadata\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SI\ACK\DC2\EOT\150\ETX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SI\SOH\DC2\EOT\150\ETX$,\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SI\ETX\DC2\EOT\150\ETX/1\n\
    \Q\n\
    \\STX\EOT\f\DC2\ACK\154\ETX\NUL\185\ETX\SOH\SUBC CallbackInfo contains the state of an attached workflow callback.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\f\SOH\DC2\EOT\154\ETX\b\DC4\n\
    \8\n\
    \\EOT\EOT\f\ETX\NUL\DC2\EOT\156\ETX\EOT\GS\SUB* Trigger for when the workflow is closed.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\ETX\NUL\SOH\DC2\EOT\156\ETX\f\SUB\n\
    \\SO\n\
    \\EOT\EOT\f\ETX\SOH\DC2\ACK\158\ETX\EOT\162\ETX\ENQ\n\
    \\r\n\
    \\ENQ\EOT\f\ETX\SOH\SOH\DC2\EOT\158\ETX\f\DC3\n\
    \\DLE\n\
    \\ACK\EOT\f\ETX\SOH\b\NUL\DC2\ACK\159\ETX\b\161\ETX\t\n\
    \\SI\n\
    \\a\EOT\f\ETX\SOH\b\NUL\SOH\DC2\EOT\159\ETX\SO\NAK\n\
    \\SO\n\
    \\ACK\EOT\f\ETX\SOH\STX\NUL\DC2\EOT\160\ETX\f/\n\
    \\SI\n\
    \\a\EOT\f\ETX\SOH\STX\NUL\ACK\DC2\EOT\160\ETX\f\SUB\n\
    \\SI\n\
    \\a\EOT\f\ETX\SOH\STX\NUL\SOH\DC2\EOT\160\ETX\ESC*\n\
    \\SI\n\
    \\a\EOT\f\ETX\SOH\STX\NUL\ETX\DC2\EOT\160\ETX-.\n\
    \[\n\
    \\EOT\EOT\f\STX\NUL\DC2\EOT\165\ETX\EOT1\SUBM Information on how this callback should be invoked (e.g. its URL and type).\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ACK\DC2\EOT\165\ETX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\EOT\165\ETX$,\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\EOT\165\ETX/0\n\
    \*\n\
    \\EOT\EOT\f\STX\SOH\DC2\EOT\167\ETX\EOT\CAN\SUB\FS Trigger for this callback.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ACK\DC2\EOT\167\ETX\EOT\v\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\EOT\167\ETX\f\DC3\n\
    \\r\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\EOT\167\ETX\SYN\ETB\n\
    \:\n\
    \\EOT\EOT\f\STX\STX\DC2\EOT\169\ETX\EOT4\SUB, The time when the callback was registered.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\ACK\DC2\EOT\169\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\SOH\DC2\EOT\169\ETX\RS/\n\
    \\r\n\
    \\ENQ\EOT\f\STX\STX\ETX\DC2\EOT\169\ETX23\n\
    \\f\n\
    \\EOT\EOT\f\STX\ETX\DC2\EOT\171\ETX\EOT2\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ETX\ACK\DC2\EOT\171\ETX\EOT'\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ETX\SOH\DC2\EOT\171\ETX(-\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ETX\ETX\DC2\EOT\171\ETX01\n\
    \\180\SOH\n\
    \\EOT\EOT\f\STX\EOT\DC2\EOT\174\ETX\EOT\SYN\SUB\165\SOH The number of attempts made to deliver the callback.\n\
    \ This number represents a minimum bound since the attempt is incremented after the callback request completes.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\EOT\ENQ\DC2\EOT\174\ETX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\f\STX\EOT\SOH\DC2\EOT\174\ETX\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\f\STX\EOT\ETX\DC2\EOT\174\ETX\DC4\NAK\n\
    \9\n\
    \\EOT\EOT\f\STX\ENQ\DC2\EOT\177\ETX\EOT=\SUB+ The time when the last attempt completed.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ENQ\ACK\DC2\EOT\177\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ENQ\SOH\DC2\EOT\177\ETX\RS8\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ENQ\ETX\DC2\EOT\177\ETX;<\n\
    \3\n\
    \\EOT\EOT\f\STX\ACK\DC2\EOT\179\ETX\EOT=\SUB% The last attempt's failure, if any.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ACK\ACK\DC2\EOT\179\ETX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ACK\SOH\DC2\EOT\179\ETX$8\n\
    \\r\n\
    \\ENQ\EOT\f\STX\ACK\ETX\DC2\EOT\179\ETX;<\n\
    \<\n\
    \\EOT\EOT\f\STX\a\DC2\EOT\181\ETX\EOT=\SUB. The time when the next attempt is scheduled.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\a\ACK\DC2\EOT\181\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\f\STX\a\SOH\DC2\EOT\181\ETX\RS8\n\
    \\r\n\
    \\ENQ\EOT\f\STX\a\ETX\DC2\EOT\181\ETX;<\n\
    \X\n\
    \\EOT\EOT\f\STX\b\DC2\EOT\184\ETX\EOT\RS\SUBJ If the state is BLOCKED, blocked reason provides additional information.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\b\ENQ\DC2\EOT\184\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\b\SOH\DC2\EOT\184\ETX\v\EM\n\
    \\r\n\
    \\ENQ\EOT\f\STX\b\ETX\DC2\EOT\184\ETX\FS\GS\n\
    \Z\n\
    \\STX\EOT\r\DC2\ACK\188\ETX\NUL\235\ETX\SOH\SUBL PendingNexusOperationInfo contains the state of a pending Nexus operation.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\r\SOH\DC2\EOT\188\ETX\b!\n\
    \V\n\
    \\EOT\EOT\r\STX\NUL\DC2\EOT\191\ETX\EOT\CAN\SUBH Endpoint name.\n\
    \ Resolved to a URL via the cluster's endpoint registry.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ENQ\DC2\EOT\191\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\EOT\191\ETX\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\EOT\191\ETX\SYN\ETB\n\
    \\GS\n\
    \\EOT\EOT\r\STX\SOH\DC2\EOT\193\ETX\EOT\ETB\SUB\SI Service name.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ENQ\DC2\EOT\193\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\SOH\DC2\EOT\193\ETX\v\DC2\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ETX\DC2\EOT\193\ETX\NAK\SYN\n\
    \\US\n\
    \\EOT\EOT\r\STX\STX\DC2\EOT\195\ETX\EOT\EM\SUB\DC1 Operation name.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ENQ\DC2\EOT\195\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\SOH\DC2\EOT\195\ETX\v\DC4\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ETX\DC2\EOT\195\ETX\ETB\CAN\n\
    \\149\SOH\n\
    \\EOT\EOT\r\STX\ETX\DC2\EOT\200\ETX\EOT\FS\SUB\134\SOH Operation ID. Only set for asynchronous operations after a successful StartOperation call.\n\
    \\n\
    \ Deprecated: Renamed to operation_token.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ENQ\DC2\EOT\200\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\SOH\DC2\EOT\200\ETX\v\ETB\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ETX\DC2\EOT\200\ETX\SUB\ESC\n\
    \\230\SOH\n\
    \\EOT\EOT\r\STX\EOT\DC2\EOT\206\ETX\EOT;\SUB\215\SOH Schedule-to-close timeout for this operation.\n\
    \ This is the only timeout settable by a workflow.\n\
    \ (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: \"to\" is used to indicate interval. --)\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\ACK\DC2\EOT\206\ETX\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\SOH\DC2\EOT\206\ETX\GS6\n\
    \\r\n\
    \\ENQ\EOT\r\STX\EOT\ETX\DC2\EOT\206\ETX9:\n\
    \:\n\
    \\EOT\EOT\r\STX\ENQ\DC2\EOT\209\ETX\EOT1\SUB, The time when the operation was scheduled.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\ACK\DC2\EOT\209\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\SOH\DC2\EOT\209\ETX\RS,\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ENQ\ETX\DC2\EOT\209\ETX/0\n\
    \\f\n\
    \\EOT\EOT\r\STX\ACK\DC2\EOT\211\ETX\EOT?\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\ACK\DC2\EOT\211\ETX\EOT4\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\SOH\DC2\EOT\211\ETX5:\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ACK\ETX\DC2\EOT\211\ETX=>\n\
    \\186\SOH\n\
    \\EOT\EOT\r\STX\a\DC2\EOT\215\ETX\EOT\SYN\SUB\171\SOH The number of attempts made to deliver the start operation request.\n\
    \ This number represents a minimum bound since the attempt is incremented after the request completes.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\a\ENQ\DC2\EOT\215\ETX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\r\STX\a\SOH\DC2\EOT\215\ETX\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\r\STX\a\ETX\DC2\EOT\215\ETX\DC4\NAK\n\
    \9\n\
    \\EOT\EOT\r\STX\b\DC2\EOT\218\ETX\EOT=\SUB+ The time when the last attempt completed.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\b\ACK\DC2\EOT\218\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\b\SOH\DC2\EOT\218\ETX\RS8\n\
    \\r\n\
    \\ENQ\EOT\r\STX\b\ETX\DC2\EOT\218\ETX;<\n\
    \3\n\
    \\EOT\EOT\r\STX\t\DC2\EOT\220\ETX\EOT>\SUB% The last attempt's failure, if any.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\t\ACK\DC2\EOT\220\ETX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\r\STX\t\SOH\DC2\EOT\220\ETX$8\n\
    \\r\n\
    \\ENQ\EOT\r\STX\t\ETX\DC2\EOT\220\ETX;=\n\
    \<\n\
    \\EOT\EOT\r\STX\n\
    \\DC2\EOT\222\ETX\EOT>\SUB. The time when the next attempt is scheduled.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\n\
    \\ACK\DC2\EOT\222\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\n\
    \\SOH\DC2\EOT\222\ETX\RS8\n\
    \\r\n\
    \\ENQ\EOT\r\STX\n\
    \\ETX\DC2\EOT\222\ETX;=\n\
    \\f\n\
    \\EOT\EOT\r\STX\v\DC2\EOT\224\ETX\EOT:\n\
    \\r\n\
    \\ENQ\EOT\r\STX\v\ACK\DC2\EOT\224\ETX\EOT\"\n\
    \\r\n\
    \\ENQ\EOT\r\STX\v\SOH\DC2\EOT\224\ETX#4\n\
    \\r\n\
    \\ENQ\EOT\r\STX\v\ETX\DC2\EOT\224\ETX79\n\
    \\171\SOH\n\
    \\EOT\EOT\r\STX\f\DC2\EOT\228\ETX\EOT\"\SUB\156\SOH The event ID of the NexusOperationScheduled event. Can be used to correlate an operation in the\n\
    \ DescribeWorkflowExecution response with workflow history.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\f\ENQ\DC2\EOT\228\ETX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\r\STX\f\SOH\DC2\EOT\228\ETX\n\
    \\FS\n\
    \\r\n\
    \\ENQ\EOT\r\STX\f\ETX\DC2\EOT\228\ETX\US!\n\
    \X\n\
    \\EOT\EOT\r\STX\r\DC2\EOT\231\ETX\EOT\US\SUBJ If the state is BLOCKED, blocked reason provides additional information.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\r\ENQ\DC2\EOT\231\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\r\SOH\DC2\EOT\231\ETX\v\EM\n\
    \\r\n\
    \\ENQ\EOT\r\STX\r\ETX\DC2\EOT\231\ETX\FS\RS\n\
    \m\n\
    \\EOT\EOT\r\STX\SO\DC2\EOT\234\ETX\EOT \SUB_ Operation token. Only set for asynchronous operations after a successful StartOperation call.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SO\ENQ\DC2\EOT\234\ETX\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SO\SOH\DC2\EOT\234\ETX\v\SUB\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SO\ETX\DC2\EOT\234\ETX\GS\US\n\
    \d\n\
    \\STX\EOT\SO\DC2\ACK\238\ETX\NUL\129\EOT\SOH\SUBV NexusOperationCancellationInfo contains the state of a nexus operation cancellation.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\SO\SOH\DC2\EOT\238\ETX\b&\n\
    \9\n\
    \\EOT\EOT\SO\STX\NUL\DC2\EOT\240\ETX\EOT1\SUB+ The time when cancellation was requested.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ACK\DC2\EOT\240\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\EOT\240\ETX\RS,\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\EOT\240\ETX/0\n\
    \\f\n\
    \\EOT\EOT\SO\STX\SOH\DC2\EOT\242\ETX\EOTD\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\ACK\DC2\EOT\242\ETX\EOT9\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\SOH\DC2\EOT\242\ETX:?\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\SOH\ETX\DC2\EOT\242\ETXBC\n\
    \\187\SOH\n\
    \\EOT\EOT\SO\STX\STX\DC2\EOT\246\ETX\EOT\SYN\SUB\172\SOH The number of attempts made to deliver the cancel operation request.\n\
    \ This number represents a minimum bound since the attempt is incremented after the request completes.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\STX\ENQ\DC2\EOT\246\ETX\EOT\t\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\STX\SOH\DC2\EOT\246\ETX\n\
    \\DC1\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\STX\ETX\DC2\EOT\246\ETX\DC4\NAK\n\
    \9\n\
    \\EOT\EOT\SO\STX\ETX\DC2\EOT\249\ETX\EOT=\SUB+ The time when the last attempt completed.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ETX\ACK\DC2\EOT\249\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ETX\SOH\DC2\EOT\249\ETX\RS8\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ETX\ETX\DC2\EOT\249\ETX;<\n\
    \3\n\
    \\EOT\EOT\SO\STX\EOT\DC2\EOT\251\ETX\EOT=\SUB% The last attempt's failure, if any.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\EOT\ACK\DC2\EOT\251\ETX\EOT#\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\EOT\SOH\DC2\EOT\251\ETX$8\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\EOT\ETX\DC2\EOT\251\ETX;<\n\
    \<\n\
    \\EOT\EOT\SO\STX\ENQ\DC2\EOT\253\ETX\EOT=\SUB. The time when the next attempt is scheduled.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ENQ\ACK\DC2\EOT\253\ETX\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ENQ\SOH\DC2\EOT\253\ETX\RS8\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ENQ\ETX\DC2\EOT\253\ETX;<\n\
    \X\n\
    \\EOT\EOT\SO\STX\ACK\DC2\EOT\128\EOT\EOT\RS\SUBJ If the state is BLOCKED, blocked reason provides additional information.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ACK\ENQ\DC2\EOT\128\EOT\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ACK\SOH\DC2\EOT\128\EOT\v\EM\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\ACK\ETX\DC2\EOT\128\EOT\FS\GS\n\
    \\f\n\
    \\STX\EOT\SI\DC2\ACK\131\EOT\NUL\134\EOT\SOH\n\
    \\v\n\
    \\ETX\EOT\SI\SOH\DC2\EOT\131\EOT\b \n\
    \r\n\
    \\EOT\EOT\SI\STX\NUL\DC2\EOT\133\EOT\EOT/\SUBd If set, takes precedence over the Versioning Behavior sent by the SDK on Workflow Task completion.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ACK\DC2\EOT\133\EOT\EOT\SYN\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\SOH\DC2\EOT\133\EOT\ETB*\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ETX\DC2\EOT\133\EOT-.\n\
    \\166\ETX\n\
    \\STX\EOT\DLE\DC2\ACK\141\EOT\NUL\154\EOT\SOH\SUB\151\ETX Used to override the versioning behavior (and pinned deployment version, if applicable) of a\n\
    \ specific workflow execution. If set, takes precedence over the worker-sent values. See\n\
    \ `WorkflowExecutionInfo.VersioningInfo` for more information. To remove the override, call\n\
    \ `UpdateWorkflowExecutionOptions` with a null `VersioningOverride`, and use the `update_mask`\n\
    \ to indicate that it should be mutated.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\DLE\SOH\DC2\EOT\141\EOT\b\SUB\n\
    \\EM\n\
    \\EOT\EOT\DLE\STX\NUL\DC2\EOT\143\EOT\EOT:\SUB\v Required.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ACK\DC2\EOT\143\EOT\EOT,\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\SOH\DC2\EOT\143\EOT-5\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ETX\DC2\EOT\143\EOT89\n\
    \\187\SOH\n\
    \\EOT\EOT\DLE\STX\SOH\DC2\EOT\148\EOT\EOTM\SUB\172\SOH Required if behavior is `PINNED`. Must be null if behavior is `AUTO_UPGRADE`.\n\
    \ Identifies the worker deployment to pin the workflow to.\n\
    \ Deprecated. Use `pinned_version`.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\ACK\DC2\EOT\148\EOT\EOT)\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\SOH\DC2\EOT\148\EOT*4\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\ETX\DC2\EOT\148\EOT78\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\b\DC2\EOT\148\EOT9L\n\
    \\SO\n\
    \\ACK\EOT\DLE\STX\SOH\b\ETX\DC2\EOT\148\EOT:K\n\
    \\207\SOH\n\
    \\EOT\EOT\DLE\STX\STX\DC2\EOT\153\EOT\EOT\RS\SUB\192\SOH Required if behavior is `PINNED`. Must be absent if behavior is not `PINNED`.\n\
    \ Identifies the worker deployment version to pin the workflow to, in the format\n\
    \ \"<deployment_name>.<build_id>\".\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\STX\ENQ\DC2\EOT\153\EOT\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\STX\SOH\DC2\EOT\153\EOT\v\EM\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\STX\ETX\DC2\EOT\153\EOT\FS\GS\n\
    \\137\ETX\n\
    \\STX\EOT\DC1\DC2\ACK\160\EOT\NUL\167\EOT\SOH\SUB\250\STX When StartWorkflowExecution uses the conflict policy WORKFLOW_ID_CONFLICT_POLICY_USE_EXISTING and\n\
    \ there is already an existing running workflow, OnConflictOptions defines actions to be taken on\n\
    \ the existing running workflow. In this case, it will create a WorkflowExecutionOptionsUpdatedEvent\n\
    \ history event in the running workflow with the changes requested in this object.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\DC1\SOH\DC2\EOT\160\EOT\b\EM\n\
    \@\n\
    \\EOT\EOT\DC1\STX\NUL\DC2\EOT\162\EOT\EOT\US\SUB2 Attaches the request ID to the running workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ENQ\DC2\EOT\162\EOT\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\SOH\DC2\EOT\162\EOT\t\SUB\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ETX\DC2\EOT\162\EOT\GS\RS\n\
    \J\n\
    \\EOT\EOT\DC1\STX\SOH\DC2\EOT\164\EOT\EOT)\SUB< Attaches the completion callbacks to the running workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\ENQ\DC2\EOT\164\EOT\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\SOH\DC2\EOT\164\EOT\t$\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\ETX\DC2\EOT\164\EOT'(\n\
    \]\n\
    \\EOT\EOT\DC1\STX\STX\DC2\EOT\166\EOT\EOT\SUB\SUBO Attaches the links to the WorkflowExecutionOptionsUpdatedEvent history event.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\STX\ENQ\DC2\EOT\166\EOT\EOT\b\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\STX\SOH\DC2\EOT\166\EOT\t\NAK\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\STX\ETX\DC2\EOT\166\EOT\CAN\EMb\ACKproto3"
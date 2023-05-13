{- This file was auto-generated from temporal/api/workflow/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Workflow.V1.Message (
        NewWorkflowExecutionInfo(), PendingActivityInfo(),
        PendingChildExecutionInfo(), PendingWorkflowTaskInfo(),
        ResetPointInfo(), ResetPoints(), WorkflowExecutionConfig(),
        WorkflowExecutionInfo()
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
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Workflow
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Api.Taskqueue.V1.Message
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
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'header' @:: Lens' NewWorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@ -}
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
      \\ENQinput\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2]\n\
      \\SUBworkflow_execution_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeoutB\EOT\152\223\US\SOH\DC2Q\n\
      \\DC4workflow_run_timeout\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2S\n\
      \\NAKworkflow_task_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeoutB\EOT\152\223\US\SOH\DC2e\n\
      \\CANworkflow_id_reuse_policy\CAN\b \SOH(\SO2,.temporal.api.enums.v1.WorkflowIdReusePolicyR\NAKworkflowIdReusePolicy\DC2F\n\
      \\fretry_policy\CAN\t \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2#\n\
      \\rcron_schedule\CAN\n\
      \ \SOH(\tR\fcronSchedule\DC20\n\
      \\EOTmemo\CAN\v \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
      \\DC1search_attributes\CAN\f \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC26\n\
      \\ACKheader\CAN\r \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader"
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
           (Data.ProtoLens.Tag 13, header__field_descriptor)]
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
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
                                                 (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                    (Lens.Family2.view
                                                       Data.ProtoLens.unknownFields _x))))))))))))))
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
                                                    ())))))))))))))
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
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.lastWorkerIdentity' @:: Lens' PendingActivityInfo Data.Text.Text@ -}
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
                                      _PendingActivityInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PendingActivityInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
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
      \\DC1heartbeat_details\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\DLEheartbeatDetails\DC2P\n\
      \\DC3last_heartbeat_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DC1lastHeartbeatTimeB\EOT\144\223\US\SOH\DC2L\n\
      \\DC1last_started_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\SIlastStartedTimeB\EOT\144\223\US\SOH\DC2\CAN\n\
      \\aattempt\CAN\a \SOH(\ENQR\aattempt\DC2)\n\
      \\DLEmaximum_attempts\CAN\b \SOH(\ENQR\SImaximumAttempts\DC2G\n\
      \\SOscheduled_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTimeB\EOT\144\223\US\SOH\DC2I\n\
      \\SIexpiration_time\CAN\n\
      \ \SOH(\v2\SUB.google.protobuf.TimestampR\SOexpirationTimeB\EOT\144\223\US\SOH\DC2C\n\
      \\flast_failure\CAN\v \SOH(\v2 .temporal.api.failure.v1.FailureR\vlastFailure\DC20\n\
      \\DC4last_worker_identity\CAN\f \SOH(\tR\DC2lastWorkerIdentity"
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
           (Data.ProtoLens.Tag 12, lastWorkerIdentity__field_descriptor)]
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "last_worker_identity"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastWorkerIdentity") y x)
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
                                              (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                 (Lens.Family2.view
                                                    Data.ProtoLens.unknownFields _x)))))))))))))
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
                                                 ()))))))))))))
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "workflow_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"workflowId") y x)
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
                                       "run_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"runId") y x)
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
      \\ENQstate\CAN\SOH \SOH(\SO2/.temporal.api.enums.v1.PendingWorkflowTaskStateR\ENQstate\DC2G\n\
      \\SOscheduled_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTimeB\EOT\144\223\US\SOH\DC2X\n\
      \\ETBoriginal_scheduled_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\NAKoriginalScheduledTimeB\EOT\144\223\US\SOH\DC2C\n\
      \\fstarted_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\vstartedTimeB\EOT\144\223\US\SOH\DC2\CAN\n\
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
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.binaryChecksum' @:: Lens' ResetPointInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.runId' @:: Lens' ResetPointInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.firstWorkflowTaskCompletedId' @:: Lens' ResetPointInfo Data.Int.Int64@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.createTime' @:: Lens' ResetPointInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'createTime' @:: Lens' ResetPointInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.expireTime' @:: Lens' ResetPointInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'expireTime' @:: Lens' ResetPointInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.resettable' @:: Lens' ResetPointInfo Prelude.Bool@ -}
data ResetPointInfo
  = ResetPointInfo'_constructor {_ResetPointInfo'binaryChecksum :: !Data.Text.Text,
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
      \\SOResetPointInfo\DC2'\n\
      \\SIbinary_checksum\CAN\SOH \SOH(\tR\SObinaryChecksum\DC2\NAK\n\
      \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\DC2F\n\
      \ first_workflow_task_completed_id\CAN\ETX \SOH(\ETXR\FSfirstWorkflowTaskCompletedId\DC2A\n\
      \\vcreate_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \createTimeB\EOT\144\223\US\SOH\DC2A\n\
      \\vexpire_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \expireTimeB\EOT\144\223\US\SOH\DC2\RS\n\
      \\n\
      \resettable\CAN\ACK \SOH(\bR\n\
      \resettable"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
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
          [(Data.ProtoLens.Tag 1, binaryChecksum__field_descriptor),
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
        {_ResetPointInfo'binaryChecksum = Data.ProtoLens.fieldDefault,
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
                                       "binary_checksum"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"binaryChecksum") y x)
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
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         ((Data.Monoid.<>)
                            (let
                               _v
                                 = Lens.Family2.view (Data.ProtoLens.Field.field @"resettable") _x
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
instance Control.DeepSeq.NFData ResetPointInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResetPointInfo'_unknownFields x__)
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
                            (Control.DeepSeq.deepseq (_ResetPointInfo'resettable x__) ()))))))
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
     
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.taskQueue' @:: Lens' WorkflowExecutionConfig Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'taskQueue' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowExecutionTimeout' @:: Lens' WorkflowExecutionConfig Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowExecutionTimeout' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.workflowRunTimeout' @:: Lens' WorkflowExecutionConfig Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'workflowRunTimeout' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.defaultWorkflowTaskTimeout' @:: Lens' WorkflowExecutionConfig Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'defaultWorkflowTaskTimeout' @:: Lens' WorkflowExecutionConfig (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@ -}
data WorkflowExecutionConfig
  = WorkflowExecutionConfig'_constructor {_WorkflowExecutionConfig'taskQueue :: !(Prelude.Maybe Proto.Temporal.Api.Taskqueue.V1.Message.TaskQueue),
                                          _WorkflowExecutionConfig'workflowExecutionTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                          _WorkflowExecutionConfig'workflowRunTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                          _WorkflowExecutionConfig'defaultWorkflowTaskTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
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
instance Data.ProtoLens.Message WorkflowExecutionConfig where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.WorkflowExecutionConfig"
  packedMessageDescriptor _
    = "\n\
      \\ETBWorkflowExecutionConfig\DC2C\n\
      \\n\
      \task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC2]\n\
      \\SUBworkflow_execution_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeoutB\EOT\152\223\US\SOH\DC2Q\n\
      \\DC4workflow_run_timeout\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2b\n\
      \\GSdefault_workflow_task_timeout\CAN\EOT \SOH(\v2\EM.google.protobuf.DurationR\SUBdefaultWorkflowTaskTimeoutB\EOT\152\223\US\SOH"
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
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowExecutionTimeout__field_descriptor),
           (Data.ProtoLens.Tag 3, workflowRunTimeout__field_descriptor),
           (Data.ProtoLens.Tag 4, 
            defaultWorkflowTaskTimeout__field_descriptor)]
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
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
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
                         (_WorkflowExecutionConfig'defaultWorkflowTaskTimeout x__) ()))))
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
         * 'Proto.Temporal.Api.Workflow.V1.Message_Fields.maybe'mostRecentWorkerVersionStamp' @:: Lens' WorkflowExecutionInfo (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkerVersionStamp)@ -}
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
instance Data.ProtoLens.Message WorkflowExecutionInfo where
  messageName _
    = Data.Text.pack "temporal.api.workflow.v1.WorkflowExecutionInfo"
  packedMessageDescriptor _
    = "\n\
      \\NAKWorkflowExecutionInfo\DC2G\n\
      \\texecution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\texecution\DC28\n\
      \\EOTtype\CAN\STX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\EOTtype\DC2?\n\
      \\n\
      \start_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTimeB\EOT\144\223\US\SOH\DC2?\n\
      \\n\
      \close_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\tcloseTimeB\EOT\144\223\US\SOH\DC2F\n\
      \\ACKstatus\CAN\ENQ \SOH(\SO2..temporal.api.enums.v1.WorkflowExecutionStatusR\ACKstatus\DC2%\n\
      \\SOhistory_length\CAN\ACK \SOH(\ETXR\rhistoryLength\DC2.\n\
      \\DC3parent_namespace_id\CAN\a \SOH(\tR\DC1parentNamespaceId\DC2T\n\
      \\DLEparent_execution\CAN\b \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\SIparentExecution\DC2G\n\
      \\SOexecution_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rexecutionTimeB\EOT\144\223\US\SOH\DC20\n\
      \\EOTmemo\CAN\n\
      \ \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
      \\DC1search_attributes\CAN\v \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC2Q\n\
      \\DC1auto_reset_points\CAN\f \SOH(\v2%.temporal.api.workflow.v1.ResetPointsR\SIautoResetPoints\DC2\GS\n\
      \\n\
      \task_queue\CAN\r \SOH(\tR\ttaskQueue\DC24\n\
      \\SYNstate_transition_count\CAN\SO \SOH(\ETXR\DC4stateTransitionCount\DC2,\n\
      \\DC2history_size_bytes\CAN\SI \SOH(\ETXR\DLEhistorySizeBytes\DC2r\n\
      \ most_recent_worker_version_stamp\CAN\DLE \SOH(\v2*.temporal.api.common.v1.WorkerVersionStampR\FSmostRecentWorkerVersionStamp"
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
            mostRecentWorkerVersionStamp__field_descriptor)]
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
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
                                                          (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                             (Lens.Family2.view
                                                                Data.ProtoLens.unknownFields
                                                                _x)))))))))))))))))
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
                                                             ()))))))))))))))))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \&temporal/api/workflow/v1/message.proto\DC2\CANtemporal.api.workflow.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB!dependencies/gogoproto/gogo.proto\SUB$temporal/api/enums/v1/workflow.proto\SUB$temporal/api/common/v1/message.proto\SUB%temporal/api/failure/v1/message.proto\SUB'temporal/api/taskqueue/v1/message.proto\"\173\b\n\
    \\NAKWorkflowExecutionInfo\DC2G\n\
    \\texecution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\texecution\DC28\n\
    \\EOTtype\CAN\STX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\EOTtype\DC2?\n\
    \\n\
    \start_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTimeB\EOT\144\223\US\SOH\DC2?\n\
    \\n\
    \close_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\tcloseTimeB\EOT\144\223\US\SOH\DC2F\n\
    \\ACKstatus\CAN\ENQ \SOH(\SO2..temporal.api.enums.v1.WorkflowExecutionStatusR\ACKstatus\DC2%\n\
    \\SOhistory_length\CAN\ACK \SOH(\ETXR\rhistoryLength\DC2.\n\
    \\DC3parent_namespace_id\CAN\a \SOH(\tR\DC1parentNamespaceId\DC2T\n\
    \\DLEparent_execution\CAN\b \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\SIparentExecution\DC2G\n\
    \\SOexecution_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rexecutionTimeB\EOT\144\223\US\SOH\DC20\n\
    \\EOTmemo\CAN\n\
    \ \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
    \\DC1search_attributes\CAN\v \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC2Q\n\
    \\DC1auto_reset_points\CAN\f \SOH(\v2%.temporal.api.workflow.v1.ResetPointsR\SIautoResetPoints\DC2\GS\n\
    \\n\
    \task_queue\CAN\r \SOH(\tR\ttaskQueue\DC24\n\
    \\SYNstate_transition_count\CAN\SO \SOH(\ETXR\DC4stateTransitionCount\DC2,\n\
    \\DC2history_size_bytes\CAN\SI \SOH(\ETXR\DLEhistorySizeBytes\DC2r\n\
    \ most_recent_worker_version_stamp\CAN\DLE \SOH(\v2*.temporal.api.common.v1.WorkerVersionStampR\FSmostRecentWorkerVersionStamp\"\244\STX\n\
    \\ETBWorkflowExecutionConfig\DC2C\n\
    \\n\
    \task_queue\CAN\SOH \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC2]\n\
    \\SUBworkflow_execution_timeout\CAN\STX \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeoutB\EOT\152\223\US\SOH\DC2Q\n\
    \\DC4workflow_run_timeout\CAN\ETX \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2b\n\
    \\GSdefault_workflow_task_timeout\CAN\EOT \SOH(\v2\EM.google.protobuf.DurationR\SUBdefaultWorkflowTaskTimeoutB\EOT\152\223\US\SOH\"\131\ACK\n\
    \\DC3PendingActivityInfo\DC2\US\n\
    \\vactivity_id\CAN\SOH \SOH(\tR\n\
    \activityId\DC2I\n\
    \\ractivity_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.ActivityTypeR\factivityType\DC2A\n\
    \\ENQstate\CAN\ETX \SOH(\SO2+.temporal.api.enums.v1.PendingActivityStateR\ENQstate\DC2M\n\
    \\DC1heartbeat_details\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\DLEheartbeatDetails\DC2P\n\
    \\DC3last_heartbeat_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\DC1lastHeartbeatTimeB\EOT\144\223\US\SOH\DC2L\n\
    \\DC1last_started_time\CAN\ACK \SOH(\v2\SUB.google.protobuf.TimestampR\SIlastStartedTimeB\EOT\144\223\US\SOH\DC2\CAN\n\
    \\aattempt\CAN\a \SOH(\ENQR\aattempt\DC2)\n\
    \\DLEmaximum_attempts\CAN\b \SOH(\ENQR\SImaximumAttempts\DC2G\n\
    \\SOscheduled_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTimeB\EOT\144\223\US\SOH\DC2I\n\
    \\SIexpiration_time\CAN\n\
    \ \SOH(\v2\SUB.google.protobuf.TimestampR\SOexpirationTimeB\EOT\144\223\US\SOH\DC2C\n\
    \\flast_failure\CAN\v \SOH(\v2 .temporal.api.failure.v1.FailureR\vlastFailure\DC20\n\
    \\DC4last_worker_identity\CAN\f \SOH(\tR\DC2lastWorkerIdentity\"\254\SOH\n\
    \\EMPendingChildExecutionInfo\DC2\US\n\
    \\vworkflow_id\CAN\SOH \SOH(\tR\n\
    \workflowId\DC2\NAK\n\
    \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\DC2,\n\
    \\DC2workflow_type_name\CAN\ETX \SOH(\tR\DLEworkflowTypeName\DC2!\n\
    \\finitiated_id\CAN\EOT \SOH(\ETXR\vinitiatedId\DC2X\n\
    \\DC3parent_close_policy\CAN\ENQ \SOH(\SO2(.temporal.api.enums.v1.ParentClosePolicyR\DC1parentClosePolicy\"\226\STX\n\
    \\ETBPendingWorkflowTaskInfo\DC2E\n\
    \\ENQstate\CAN\SOH \SOH(\SO2/.temporal.api.enums.v1.PendingWorkflowTaskStateR\ENQstate\DC2G\n\
    \\SOscheduled_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\rscheduledTimeB\EOT\144\223\US\SOH\DC2X\n\
    \\ETBoriginal_scheduled_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\NAKoriginalScheduledTimeB\EOT\144\223\US\SOH\DC2C\n\
    \\fstarted_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\vstartedTimeB\EOT\144\223\US\SOH\DC2\CAN\n\
    \\aattempt\CAN\ENQ \SOH(\ENQR\aattempt\"O\n\
    \\vResetPoints\DC2@\n\
    \\ACKpoints\CAN\SOH \ETX(\v2(.temporal.api.workflow.v1.ResetPointInfoR\ACKpoints\"\190\STX\n\
    \\SOResetPointInfo\DC2'\n\
    \\SIbinary_checksum\CAN\SOH \SOH(\tR\SObinaryChecksum\DC2\NAK\n\
    \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\DC2F\n\
    \ first_workflow_task_completed_id\CAN\ETX \SOH(\ETXR\FSfirstWorkflowTaskCompletedId\DC2A\n\
    \\vcreate_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \createTimeB\EOT\144\223\US\SOH\DC2A\n\
    \\vexpire_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \expireTimeB\EOT\144\223\US\SOH\DC2\RS\n\
    \\n\
    \resettable\CAN\ACK \SOH(\bR\n\
    \resettable\"\159\a\n\
    \\CANNewWorkflowExecutionInfo\DC2\US\n\
    \\vworkflow_id\CAN\SOH \SOH(\tR\n\
    \workflowId\DC2I\n\
    \\rworkflow_type\CAN\STX \SOH(\v2$.temporal.api.common.v1.WorkflowTypeR\fworkflowType\DC2C\n\
    \\n\
    \task_queue\CAN\ETX \SOH(\v2$.temporal.api.taskqueue.v1.TaskQueueR\ttaskQueue\DC26\n\
    \\ENQinput\CAN\EOT \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC2]\n\
    \\SUBworkflow_execution_timeout\CAN\ENQ \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeoutB\EOT\152\223\US\SOH\DC2Q\n\
    \\DC4workflow_run_timeout\CAN\ACK \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeoutB\EOT\152\223\US\SOH\DC2S\n\
    \\NAKworkflow_task_timeout\CAN\a \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeoutB\EOT\152\223\US\SOH\DC2e\n\
    \\CANworkflow_id_reuse_policy\CAN\b \SOH(\SO2,.temporal.api.enums.v1.WorkflowIdReusePolicyR\NAKworkflowIdReusePolicy\DC2F\n\
    \\fretry_policy\CAN\t \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2#\n\
    \\rcron_schedule\CAN\n\
    \ \SOH(\tR\fcronSchedule\DC20\n\
    \\EOTmemo\CAN\v \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
    \\DC1search_attributes\CAN\f \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC26\n\
    \\ACKheader\CAN\r \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheaderB\147\SOH\n\
    \\ESCio.temporal.api.workflow.v1B\fMessageProtoP\SOHZ'go.temporal.io/api/workflow/v1;workflow\170\STX\SUBTemporalio.Api.Workflow.V1\234\STX\GSTemporalio::Api::Workflow::V1J\139\&6\n\
    \\a\DC2\ENQ\SYN\NUL\146\SOH\SOH\n\
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
    \\STX\ETX\SOH\DC2\ETX\"\NUL)\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX$\NUL+\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX&\NUL.\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX'\NUL.\n\
    \\t\n\
    \\STX\ETX\ENQ\DC2\ETX(\NUL/\n\
    \\t\n\
    \\STX\ETX\ACK\DC2\ETX)\NUL1\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT+\NUL=\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX+\b\GS\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX,\EOT;\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX,\EOT,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX,-6\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX,9:\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX-\EOT1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX-\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX-(,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX-/0\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX.\EOTJ\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX.\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX.\RS(\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX.+,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\b\DC2\ETX.-I\n\
    \\SI\n\
    \\b\EOT\NUL\STX\STX\b\242\251\ETX\DC2\ETX..H\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX/\EOTJ\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ACK\DC2\ETX/\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX/\RS(\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX/+,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\b\DC2\ETX/-I\n\
    \\SI\n\
    \\b\EOT\NUL\STX\ETX\b\242\251\ETX\DC2\ETX/.H\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\EOT\DC2\ETX0\EOT=\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ACK\DC2\ETX0\EOT1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\SOH\DC2\ETX028\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ETX\DC2\ETX0;<\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ENQ\DC2\ETX1\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ENQ\DC2\ETX1\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\SOH\DC2\ETX1\n\
    \\CAN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ETX\DC2\ETX1\ESC\FS\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\ACK\DC2\ETX2\EOT#\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ENQ\DC2\ETX2\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\SOH\DC2\ETX2\v\RS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ACK\ETX\DC2\ETX2!\"\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\a\DC2\ETX3\EOTB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\ACK\DC2\ETX3\EOT,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\SOH\DC2\ETX3-=\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\a\ETX\DC2\ETX3@A\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\b\DC2\ETX4\EOTN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\ACK\DC2\ETX4\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\SOH\DC2\ETX4\RS,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\ETX\DC2\ETX4/0\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\b\b\DC2\ETX41M\n\
    \\SI\n\
    \\b\EOT\NUL\STX\b\b\242\251\ETX\DC2\ETX42L\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\t\DC2\ETX5\EOT*\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\ACK\DC2\ETX5\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\SOH\DC2\ETX5 $\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\t\ETX\DC2\ETX5')\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\n\
    \\DC2\ETX6\EOTC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\ACK\DC2\ETX6\EOT+\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\SOH\DC2\ETX6,=\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\n\
    \\ETX\DC2\ETX6@B\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\v\DC2\ETX7\EOT'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\ACK\DC2\ETX7\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\SOH\DC2\ETX7\DLE!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\v\ETX\DC2\ETX7$&\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\f\DC2\ETX8\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\f\ENQ\DC2\ETX8\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\f\SOH\DC2\ETX8\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\f\ETX\DC2\ETX8\CAN\SUB\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\r\DC2\ETX9\EOT&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\r\ENQ\DC2\ETX9\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\r\SOH\DC2\ETX9\n\
    \ \n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\r\ETX\DC2\ETX9#%\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SO\DC2\ETX:\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SO\ENQ\DC2\ETX:\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SO\SOH\DC2\ETX:\n\
    \\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SO\ETX\DC2\ETX:\US!\n\
    \g\n\
    \\EOT\EOT\NUL\STX\SI\DC2\ETX<\EOTT\SUBZ If set, the most recent worker version stamp that appeared in a workflow task completion\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SI\ACK\DC2\ETX<\EOT-\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SI\SOH\DC2\ETX<.N\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SI\ETX\DC2\ETX<QS\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT?\NULD\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX?\b\US\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX@\EOT7\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX@\EOT'\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX@(2\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX@56\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETXA\EOT]\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETXA\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETXA\GS7\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETXA:;\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\b\DC2\ETXA<\\\n\
    \\SI\n\
    \\b\EOT\SOH\STX\SOH\b\243\251\ETX\DC2\ETXA=[\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETXB\EOTW\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ACK\DC2\ETXB\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETXB\GS1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETXB45\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\b\DC2\ETXB6V\n\
    \\SI\n\
    \\b\EOT\SOH\STX\STX\b\243\251\ETX\DC2\ETXB7U\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETXC\EOT`\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ACK\DC2\ETXC\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETXC\GS:\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETXC=>\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\b\DC2\ETXC?_\n\
    \\SI\n\
    \\b\EOT\SOH\STX\ETX\b\243\251\ETX\DC2\ETXC@^\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOTF\NULS\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETXF\b\ESC\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETXG\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETXG\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETXG\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETXG\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETXH\EOT:\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETXH\EOT'\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETXH(5\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETXH89\n\
    \\v\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETXI\EOT9\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ACK\DC2\ETXI\EOT.\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETXI/4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETXI78\n\
    \\v\n\
    \\EOT\EOT\STX\STX\ETX\DC2\ETXJ\EOT:\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ACK\DC2\ETXJ\EOT#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\ETXJ$5\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\ETXJ89\n\
    \\v\n\
    \\EOT\EOT\STX\STX\EOT\DC2\ETXK\EOTS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ACK\DC2\ETXK\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\SOH\DC2\ETXK\RS1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ETX\DC2\ETXK45\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\b\DC2\ETXK6R\n\
    \\SI\n\
    \\b\EOT\STX\STX\EOT\b\242\251\ETX\DC2\ETXK7Q\n\
    \\v\n\
    \\EOT\EOT\STX\STX\ENQ\DC2\ETXL\EOTQ\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\ACK\DC2\ETXL\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\SOH\DC2\ETXL\RS/\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\ETX\DC2\ETXL23\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\b\DC2\ETXL4P\n\
    \\SI\n\
    \\b\EOT\STX\STX\ENQ\b\242\251\ETX\DC2\ETXL5O\n\
    \\v\n\
    \\EOT\EOT\STX\STX\ACK\DC2\ETXM\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ACK\ENQ\DC2\ETXM\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ACK\SOH\DC2\ETXM\n\
    \\DC1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ACK\ETX\DC2\ETXM\DC4\NAK\n\
    \\v\n\
    \\EOT\EOT\STX\STX\a\DC2\ETXN\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\a\ENQ\DC2\ETXN\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\a\SOH\DC2\ETXN\n\
    \\SUB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\a\ETX\DC2\ETXN\GS\RS\n\
    \\v\n\
    \\EOT\EOT\STX\STX\b\DC2\ETXO\EOTN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\b\ACK\DC2\ETXO\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\b\SOH\DC2\ETXO\RS,\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\b\ETX\DC2\ETXO/0\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\b\b\DC2\ETXO1M\n\
    \\SI\n\
    \\b\EOT\STX\STX\b\b\242\251\ETX\DC2\ETXO2L\n\
    \\v\n\
    \\EOT\EOT\STX\STX\t\DC2\ETXP\EOTP\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\t\ACK\DC2\ETXP\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\t\SOH\DC2\ETXP\RS-\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\t\ETX\DC2\ETXP02\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\t\b\DC2\ETXP3O\n\
    \\SI\n\
    \\b\EOT\STX\STX\t\b\242\251\ETX\DC2\ETXP4N\n\
    \\v\n\
    \\EOT\EOT\STX\STX\n\
    \\DC2\ETXQ\EOT6\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\n\
    \\ACK\DC2\ETXQ\EOT#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\n\
    \\SOH\DC2\ETXQ$0\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\n\
    \\ETX\DC2\ETXQ35\n\
    \\v\n\
    \\EOT\EOT\STX\STX\v\DC2\ETXR\EOT%\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\v\ENQ\DC2\ETXR\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\v\SOH\DC2\ETXR\v\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\v\ETX\DC2\ETXR\"$\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOTU\NUL\\\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXU\b!\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXV\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETXV\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXV\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXV\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXW\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETXW\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXW\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXW\DC4\NAK\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETXX\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ENQ\DC2\ETXX\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETXX\v\GS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETXX !\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\ETX\DC2\ETXY\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ENQ\DC2\ETXY\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\SOH\DC2\ETXY\n\
    \\SYN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ETX\DC2\ETXY\EM\SUB\n\
    \6\n\
    \\EOT\EOT\ETX\STX\EOT\DC2\ETX[\EOTD\SUB) Default: PARENT_CLOSE_POLICY_TERMINATE.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ACK\DC2\ETX[\EOT+\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\SOH\DC2\ETX[,?\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ETX\DC2\ETX[BC\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOT^\NULh\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX^\b\US\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX_\EOT=\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETX_\EOT2\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX_38\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX_;<\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\ETX`\EOTN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ACK\DC2\ETX`\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\ETX`\RS,\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\ETX`/0\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\b\DC2\ETX`1M\n\
    \\SI\n\
    \\b\EOT\EOT\STX\SOH\b\242\251\ETX\DC2\ETX`2L\n\
    \\150\ETX\n\
    \\EOT\EOT\EOT\STX\STX\DC2\ETXe\EOTW\SUB\136\ETX original_scheduled_time is the scheduled time of the first workflow task during workflow task heartbeat.\n\
    \ Heartbeat workflow task is done by RespondWorkflowTaskComplete with ForceCreateNewWorkflowTask == true and no command\n\
    \ In this case, OriginalScheduledTime won't change. Then when current time - original_scheduled_time exceeds\n\
    \ some threshold, the workflow task will be forced timeout.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ACK\DC2\ETXe\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\SOH\DC2\ETXe\RS5\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ETX\DC2\ETXe89\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\b\DC2\ETXe:V\n\
    \\SI\n\
    \\b\EOT\EOT\STX\STX\b\242\251\ETX\DC2\ETXe;U\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\ETX\DC2\ETXf\EOTL\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ACK\DC2\ETXf\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\SOH\DC2\ETXf\RS*\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ETX\DC2\ETXf-.\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\b\DC2\ETXf/K\n\
    \\SI\n\
    \\b\EOT\EOT\STX\ETX\b\242\251\ETX\DC2\ETXf0J\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\EOT\DC2\ETXg\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\ENQ\DC2\ETXg\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\SOH\DC2\ETXg\n\
    \\DC1\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\ETX\DC2\ETXg\DC4\NAK\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOTj\NULl\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXj\b\DC3\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETXk\EOT'\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\EOT\DC2\ETXk\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETXk\r\ESC\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETXk\FS\"\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETXk%&\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOTn\NULy\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXn\b\SYN\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXo\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXo\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXo\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXo\GS\RS\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXp\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXp\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXp\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXp\DC4\NAK\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\STX\DC2\ETXq\EOT/\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ENQ\DC2\ETXq\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\ETXq\n\
    \*\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\ETXq-.\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\ETX\DC2\ETXr\EOTK\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ETX\ACK\DC2\ETXr\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ETX\SOH\DC2\ETXr\RS)\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ETX\ETX\DC2\ETXr,-\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ETX\b\DC2\ETXr.J\n\
    \\SI\n\
    \\b\EOT\ACK\STX\ETX\b\242\251\ETX\DC2\ETXr/I\n\
    \\191\SOH\n\
    \\EOT\EOT\ACK\STX\EOT\DC2\ETXv\EOTK\SUB\177\SOH (-- api-linter: core::0214::resource-expiry=disabled\n\
    \     aip.dev/not-precedent: TTL is not defined for ResetPointInfo. --)\n\
    \ The time that the run is deleted due to retention.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\EOT\ACK\DC2\ETXv\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\EOT\SOH\DC2\ETXv\RS)\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\EOT\ETX\DC2\ETXv,-\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\EOT\b\DC2\ETXv.J\n\
    \\SI\n\
    \\b\EOT\ACK\STX\EOT\b\242\251\ETX\DC2\ETXv/I\n\
    \X\n\
    \\EOT\EOT\ACK\STX\ENQ\DC2\ETXx\EOT\CAN\SUBK false if the reset point has pending childWFs/reqCancels/signalExternals.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ENQ\ENQ\DC2\ETXx\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ENQ\SOH\DC2\ETXx\t\DC3\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\ENQ\ETX\DC2\ETXx\SYN\ETB\n\
    \\152\SOH\n\
    \\STX\EOT\a\DC2\ENQ}\NUL\146\SOH\SOH\SUB\138\SOH NewWorkflowExecutionInfo is a shared message that encapsulates all the\n\
    \ required arguments to starting a workflow in different contexts.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETX}\b \n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETX~\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETX~\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETX~\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETX~\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\a\STX\SOH\DC2\ETX\DEL\EOT:\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ACK\DC2\ETX\DEL\EOT'\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\ETX\DEL(5\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\ETX\DEL89\n\
    \\f\n\
    \\EOT\EOT\a\STX\STX\DC2\EOT\128\SOH\EOT7\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\ACK\DC2\EOT\128\SOH\EOT'\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\SOH\DC2\EOT\128\SOH(2\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\ETX\DC2\EOT\128\SOH56\n\
    \5\n\
    \\EOT\EOT\a\STX\ETX\DC2\EOT\130\SOH\EOT.\SUB' Serialized arguments to the workflow.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\ACK\DC2\EOT\130\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\SOH\DC2\EOT\130\SOH$)\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ETX\ETX\DC2\EOT\130\SOH,-\n\
    \W\n\
    \\EOT\EOT\a\STX\EOT\DC2\EOT\132\SOH\EOT]\SUBI Total workflow execution timeout including retries and continue as new.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\ACK\DC2\EOT\132\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\SOH\DC2\EOT\132\SOH\GS7\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\ETX\DC2\EOT\132\SOH:;\n\
    \\r\n\
    \\ENQ\EOT\a\STX\EOT\b\DC2\EOT\132\SOH<\\\n\
    \\DLE\n\
    \\b\EOT\a\STX\EOT\b\243\251\ETX\DC2\EOT\132\SOH=[\n\
    \1\n\
    \\EOT\EOT\a\STX\ENQ\DC2\EOT\134\SOH\EOTW\SUB# Timeout of a single workflow run.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ENQ\ACK\DC2\EOT\134\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ENQ\SOH\DC2\EOT\134\SOH\GS1\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ENQ\ETX\DC2\EOT\134\SOH45\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ENQ\b\DC2\EOT\134\SOH6V\n\
    \\DLE\n\
    \\b\EOT\a\STX\ENQ\b\243\251\ETX\DC2\EOT\134\SOH7U\n\
    \2\n\
    \\EOT\EOT\a\STX\ACK\DC2\EOT\136\SOH\EOTX\SUB$ Timeout of a single workflow task.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ACK\ACK\DC2\EOT\136\SOH\EOT\FS\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ACK\SOH\DC2\EOT\136\SOH\GS2\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ACK\ETX\DC2\EOT\136\SOH56\n\
    \\r\n\
    \\ENQ\EOT\a\STX\ACK\b\DC2\EOT\136\SOH7W\n\
    \\DLE\n\
    \\b\EOT\a\STX\ACK\b\243\251\ETX\DC2\EOT\136\SOH8V\n\
    \B\n\
    \\EOT\EOT\a\STX\a\DC2\EOT\138\SOH\EOTM\SUB4 Default: WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\a\ACK\DC2\EOT\138\SOH\EOT/\n\
    \\r\n\
    \\ENQ\EOT\a\STX\a\SOH\DC2\EOT\138\SOH0H\n\
    \\r\n\
    \\ENQ\EOT\a\STX\a\ETX\DC2\EOT\138\SOHKL\n\
    \b\n\
    \\EOT\EOT\a\STX\b\DC2\EOT\140\SOH\EOT8\SUBT The retry policy for the workflow. Will never exceed `workflow_execution_timeout`.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\b\ACK\DC2\EOT\140\SOH\EOT&\n\
    \\r\n\
    \\ENQ\EOT\a\STX\b\SOH\DC2\EOT\140\SOH'3\n\
    \\r\n\
    \\ENQ\EOT\a\STX\b\ETX\DC2\EOT\140\SOH67\n\
    \V\n\
    \\EOT\EOT\a\STX\t\DC2\EOT\142\SOH\EOT\RS\SUBH See https://docs.temporal.io/docs/content/what-is-a-temporal-cron-job/\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\t\ENQ\DC2\EOT\142\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\t\SOH\DC2\EOT\142\SOH\v\CAN\n\
    \\r\n\
    \\ENQ\EOT\a\STX\t\ETX\DC2\EOT\142\SOH\ESC\GS\n\
    \\f\n\
    \\EOT\EOT\a\STX\n\
    \\DC2\EOT\143\SOH\EOT*\n\
    \\r\n\
    \\ENQ\EOT\a\STX\n\
    \\ACK\DC2\EOT\143\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\a\STX\n\
    \\SOH\DC2\EOT\143\SOH $\n\
    \\r\n\
    \\ENQ\EOT\a\STX\n\
    \\ETX\DC2\EOT\143\SOH')\n\
    \\f\n\
    \\EOT\EOT\a\STX\v\DC2\EOT\144\SOH\EOTC\n\
    \\r\n\
    \\ENQ\EOT\a\STX\v\ACK\DC2\EOT\144\SOH\EOT+\n\
    \\r\n\
    \\ENQ\EOT\a\STX\v\SOH\DC2\EOT\144\SOH,=\n\
    \\r\n\
    \\ENQ\EOT\a\STX\v\ETX\DC2\EOT\144\SOH@B\n\
    \\f\n\
    \\EOT\EOT\a\STX\f\DC2\EOT\145\SOH\EOT.\n\
    \\r\n\
    \\ENQ\EOT\a\STX\f\ACK\DC2\EOT\145\SOH\EOT!\n\
    \\r\n\
    \\ENQ\EOT\a\STX\f\SOH\DC2\EOT\145\SOH\"(\n\
    \\r\n\
    \\ENQ\EOT\a\STX\f\ETX\DC2\EOT\145\SOH+-b\ACKproto3"
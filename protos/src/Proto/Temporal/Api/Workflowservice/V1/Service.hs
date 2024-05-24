{- This file was auto-generated from temporal/api/workflowservice/v1/service.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Workflowservice.V1.Service (
        WorkflowService(..)
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
import qualified Proto.Google.Api.Annotations
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse
data WorkflowService = WorkflowService {}
instance Data.ProtoLens.Service.Types.Service WorkflowService where
  type ServiceName WorkflowService = "WorkflowService"
  type ServicePackage WorkflowService = "temporal.api.workflowservice.v1"
  type ServiceMethods WorkflowService = '["countWorkflowExecutions",
                                          "createSchedule",
                                          "deleteSchedule",
                                          "deleteWorkflowExecution",
                                          "deprecateNamespace",
                                          "describeBatchOperation",
                                          "describeNamespace",
                                          "describeSchedule",
                                          "describeTaskQueue",
                                          "describeWorkflowExecution",
                                          "executeMultiOperation",
                                          "getClusterInfo",
                                          "getSearchAttributes",
                                          "getSystemInfo",
                                          "getWorkerBuildIdCompatibility",
                                          "getWorkerTaskReachability",
                                          "getWorkerVersioningRules",
                                          "getWorkflowExecutionHistory",
                                          "getWorkflowExecutionHistoryReverse",
                                          "listArchivedWorkflowExecutions",
                                          "listBatchOperations",
                                          "listClosedWorkflowExecutions",
                                          "listNamespaces",
                                          "listOpenWorkflowExecutions",
                                          "listScheduleMatchingTimes",
                                          "listSchedules",
                                          "listTaskQueuePartitions",
                                          "listWorkflowExecutions",
                                          "patchSchedule",
                                          "pollActivityTaskQueue",
                                          "pollNexusTaskQueue",
                                          "pollWorkflowExecutionUpdate",
                                          "pollWorkflowTaskQueue",
                                          "queryWorkflow",
                                          "recordActivityTaskHeartbeat",
                                          "recordActivityTaskHeartbeatById",
                                          "registerNamespace",
                                          "requestCancelWorkflowExecution",
                                          "resetStickyTaskQueue",
                                          "resetWorkflowExecution",
                                          "respondActivityTaskCanceled",
                                          "respondActivityTaskCanceledById",
                                          "respondActivityTaskCompleted",
                                          "respondActivityTaskCompletedById",
                                          "respondActivityTaskFailed",
                                          "respondActivityTaskFailedById",
                                          "respondNexusTaskCompleted",
                                          "respondNexusTaskFailed",
                                          "respondQueryTaskCompleted",
                                          "respondWorkflowTaskCompleted",
                                          "respondWorkflowTaskFailed",
                                          "scanWorkflowExecutions",
                                          "signalWithStartWorkflowExecution",
                                          "signalWorkflowExecution",
                                          "startBatchOperation",
                                          "startWorkflowExecution",
                                          "stopBatchOperation",
                                          "terminateWorkflowExecution",
                                          "updateNamespace",
                                          "updateSchedule",
                                          "updateWorkerBuildIdCompatibility",
                                          "updateWorkerVersioningRules",
                                          "updateWorkflowExecution"]
  packedServiceDescriptor _
    = "\n\
      \\SIWorkflowService\DC2\169\SOH\n\
      \\DC1RegisterNamespace\DC29.temporal.api.workflowservice.v1.RegisterNamespaceRequest\SUB:.temporal.api.workflowservice.v1.RegisterNamespaceResponse\"\GS\130\211\228\147\STX\ETB\"\DC2/api/v1/namespaces:\SOH*\DC2\178\SOH\n\
      \\DC1DescribeNamespace\DC29.temporal.api.workflowservice.v1.DescribeNamespaceRequest\SUB:.temporal.api.workflowservice.v1.DescribeNamespaceResponse\"&\130\211\228\147\STX \DC2\RS/api/v1/namespaces/{namespace}\DC2\157\SOH\n\
      \\SOListNamespaces\DC26.temporal.api.workflowservice.v1.ListNamespacesRequest\SUB7.temporal.api.workflowservice.v1.ListNamespacesResponse\"\SUB\130\211\228\147\STX\DC4\DC2\DC2/api/v1/namespaces\DC2\182\SOH\n\
      \\SIUpdateNamespace\DC27.temporal.api.workflowservice.v1.UpdateNamespaceRequest\SUB8.temporal.api.workflowservice.v1.UpdateNamespaceResponse\"0\130\211\228\147\STX*\"%/api/v1/namespaces/{namespace}/update:\SOH*\DC2\143\SOH\n\
      \\DC2DeprecateNamespace\DC2:.temporal.api.workflowservice.v1.DeprecateNamespaceRequest\SUB;.temporal.api.workflowservice.v1.DeprecateNamespaceResponse\"\NUL\DC2\220\SOH\n\
      \\SYNStartWorkflowExecution\DC2>.temporal.api.workflowservice.v1.StartWorkflowExecutionRequest\SUB?.temporal.api.workflowservice.v1.StartWorkflowExecutionResponse\"A\130\211\228\147\STX;\"6/api/v1/namespaces/{namespace}/workflows/{workflow_id}:\SOH*\DC2\227\SOH\n\
      \\NAKExecuteMultiOperation\DC2=.temporal.api.workflowservice.v1.ExecuteMultiOperationRequest\SUB>.temporal.api.workflowservice.v1.ExecuteMultiOperationResponse\"K\130\211\228\147\STXE\"@/api/v1/namespaces/{namespace}/workflows/execute-multi-operation:\SOH*\DC2\250\SOH\n\
      \\ESCGetWorkflowExecutionHistory\DC2C.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryRequest\SUBD.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryResponse\"P\130\211\228\147\STXJ\DC2H/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}/history\DC2\151\STX\n\
      \\"GetWorkflowExecutionHistoryReverse\DC2J.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryReverseRequest\SUBK.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryReverseResponse\"X\130\211\228\147\STXR\DC2P/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}/history-reverse\DC2\152\SOH\n\
      \\NAKPollWorkflowTaskQueue\DC2=.temporal.api.workflowservice.v1.PollWorkflowTaskQueueRequest\SUB>.temporal.api.workflowservice.v1.PollWorkflowTaskQueueResponse\"\NUL\DC2\173\SOH\n\
      \\FSRespondWorkflowTaskCompleted\DC2D.temporal.api.workflowservice.v1.RespondWorkflowTaskCompletedRequest\SUBE.temporal.api.workflowservice.v1.RespondWorkflowTaskCompletedResponse\"\NUL\DC2\164\SOH\n\
      \\EMRespondWorkflowTaskFailed\DC2A.temporal.api.workflowservice.v1.RespondWorkflowTaskFailedRequest\SUBB.temporal.api.workflowservice.v1.RespondWorkflowTaskFailedResponse\"\NUL\DC2\152\SOH\n\
      \\NAKPollActivityTaskQueue\DC2=.temporal.api.workflowservice.v1.PollActivityTaskQueueRequest\SUB>.temporal.api.workflowservice.v1.PollActivityTaskQueueResponse\"\NUL\DC2\232\SOH\n\
      \\ESCRecordActivityTaskHeartbeat\DC2C.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatRequest\SUBD.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatResponse\">\130\211\228\147\STX8\"3/api/v1/namespaces/{namespace}/activities/heartbeat:\SOH*\DC2\250\SOH\n\
      \\USRecordActivityTaskHeartbeatById\DC2G.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatByIdRequest\SUBH.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatByIdResponse\"D\130\211\228\147\STX>\"9/api/v1/namespaces/{namespace}/activities/heartbeat-by-id:\SOH*\DC2\234\SOH\n\
      \\FSRespondActivityTaskCompleted\DC2D.temporal.api.workflowservice.v1.RespondActivityTaskCompletedRequest\SUBE.temporal.api.workflowservice.v1.RespondActivityTaskCompletedResponse\"=\130\211\228\147\STX7\"2/api/v1/namespaces/{namespace}/activities/complete:\SOH*\DC2\252\SOH\n\
      \ RespondActivityTaskCompletedById\DC2H.temporal.api.workflowservice.v1.RespondActivityTaskCompletedByIdRequest\SUBI.temporal.api.workflowservice.v1.RespondActivityTaskCompletedByIdResponse\"C\130\211\228\147\STX=\"8/api/v1/namespaces/{namespace}/activities/complete-by-id:\SOH*\DC2\221\SOH\n\
      \\EMRespondActivityTaskFailed\DC2A.temporal.api.workflowservice.v1.RespondActivityTaskFailedRequest\SUBB.temporal.api.workflowservice.v1.RespondActivityTaskFailedResponse\"9\130\211\228\147\STX3\"./api/v1/namespaces/{namespace}/activities/fail:\SOH*\DC2\239\SOH\n\
      \\GSRespondActivityTaskFailedById\DC2E.temporal.api.workflowservice.v1.RespondActivityTaskFailedByIdRequest\SUBF.temporal.api.workflowservice.v1.RespondActivityTaskFailedByIdResponse\"?\130\211\228\147\STX9\"4/api/v1/namespaces/{namespace}/activities/fail-by-id:\SOH*\DC2\229\SOH\n\
      \\ESCRespondActivityTaskCanceled\DC2C.temporal.api.workflowservice.v1.RespondActivityTaskCanceledRequest\SUBD.temporal.api.workflowservice.v1.RespondActivityTaskCanceledResponse\";\130\211\228\147\STX5\"0/api/v1/namespaces/{namespace}/activities/cancel:\SOH*\DC2\247\SOH\n\
      \\USRespondActivityTaskCanceledById\DC2G.temporal.api.workflowservice.v1.RespondActivityTaskCanceledByIdRequest\SUBH.temporal.api.workflowservice.v1.RespondActivityTaskCanceledByIdResponse\"A\130\211\228\147\STX;\"6/api/v1/namespaces/{namespace}/activities/cancel-by-id:\SOH*\DC2\142\STX\n\
      \\RSRequestCancelWorkflowExecution\DC2F.temporal.api.workflowservice.v1.RequestCancelWorkflowExecutionRequest\SUBG.temporal.api.workflowservice.v1.RequestCancelWorkflowExecutionResponse\"[\130\211\228\147\STXU\"P/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/cancel:\SOH*\DC2\135\STX\n\
      \\ETBSignalWorkflowExecution\DC2?.temporal.api.workflowservice.v1.SignalWorkflowExecutionRequest\SUB@.temporal.api.workflowservice.v1.SignalWorkflowExecutionResponse\"i\130\211\228\147\STXc\"^/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/signal/{signal_name}:\SOH*\DC2\154\STX\n\
      \ SignalWithStartWorkflowExecution\DC2H.temporal.api.workflowservice.v1.SignalWithStartWorkflowExecutionRequest\SUBI.temporal.api.workflowservice.v1.SignalWithStartWorkflowExecutionResponse\"a\130\211\228\147\STX[\"V/api/v1/namespaces/{namespace}/workflows/{workflow_id}/signal-with-start/{signal_name}:\SOH*\DC2\245\SOH\n\
      \\SYNResetWorkflowExecution\DC2>.temporal.api.workflowservice.v1.ResetWorkflowExecutionRequest\SUB?.temporal.api.workflowservice.v1.ResetWorkflowExecutionResponse\"Z\130\211\228\147\STXT\"O/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/reset:\SOH*\DC2\133\STX\n\
      \\SUBTerminateWorkflowExecution\DC2B.temporal.api.workflowservice.v1.TerminateWorkflowExecutionRequest\SUBC.temporal.api.workflowservice.v1.TerminateWorkflowExecutionResponse\"^\130\211\228\147\STXX\"S/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/terminate:\SOH*\DC2\158\SOH\n\
      \\ETBDeleteWorkflowExecution\DC2?.temporal.api.workflowservice.v1.DeleteWorkflowExecutionRequest\SUB@.temporal.api.workflowservice.v1.DeleteWorkflowExecutionResponse\"\NUL\DC2\167\SOH\n\
      \\SUBListOpenWorkflowExecutions\DC2B.temporal.api.workflowservice.v1.ListOpenWorkflowExecutionsRequest\SUBC.temporal.api.workflowservice.v1.ListOpenWorkflowExecutionsResponse\"\NUL\DC2\173\SOH\n\
      \\FSListClosedWorkflowExecutions\DC2D.temporal.api.workflowservice.v1.ListClosedWorkflowExecutionsRequest\SUBE.temporal.api.workflowservice.v1.ListClosedWorkflowExecutionsResponse\"\NUL\DC2\203\SOH\n\
      \\SYNListWorkflowExecutions\DC2>.temporal.api.workflowservice.v1.ListWorkflowExecutionsRequest\SUB?.temporal.api.workflowservice.v1.ListWorkflowExecutionsResponse\"0\130\211\228\147\STX*\DC2(/api/v1/namespaces/{namespace}/workflows\DC2\236\SOH\n\
      \\RSListArchivedWorkflowExecutions\DC2F.temporal.api.workflowservice.v1.ListArchivedWorkflowExecutionsRequest\SUBG.temporal.api.workflowservice.v1.ListArchivedWorkflowExecutionsResponse\"9\130\211\228\147\STX3\DC21/api/v1/namespaces/{namespace}/archived-workflows\DC2\155\SOH\n\
      \\SYNScanWorkflowExecutions\DC2>.temporal.api.workflowservice.v1.ScanWorkflowExecutionsRequest\SUB?.temporal.api.workflowservice.v1.ScanWorkflowExecutionsResponse\"\NUL\DC2\211\SOH\n\
      \\ETBCountWorkflowExecutions\DC2?.temporal.api.workflowservice.v1.CountWorkflowExecutionsRequest\SUB@.temporal.api.workflowservice.v1.CountWorkflowExecutionsResponse\"5\130\211\228\147\STX/\DC2-/api/v1/namespaces/{namespace}/workflow-count\DC2\146\SOH\n\
      \\DC3GetSearchAttributes\DC2;.temporal.api.workflowservice.v1.GetSearchAttributesRequest\SUB<.temporal.api.workflowservice.v1.GetSearchAttributesResponse\"\NUL\DC2\164\SOH\n\
      \\EMRespondQueryTaskCompleted\DC2A.temporal.api.workflowservice.v1.RespondQueryTaskCompletedRequest\SUBB.temporal.api.workflowservice.v1.RespondQueryTaskCompletedResponse\"\NUL\DC2\149\SOH\n\
      \\DC4ResetStickyTaskQueue\DC2<.temporal.api.workflowservice.v1.ResetStickyTaskQueueRequest\SUB=.temporal.api.workflowservice.v1.ResetStickyTaskQueueResponse\"\NUL\DC2\228\SOH\n\
      \\rQueryWorkflow\DC25.temporal.api.workflowservice.v1.QueryWorkflowRequest\SUB6.temporal.api.workflowservice.v1.QueryWorkflowResponse\"d\130\211\228\147\STX^\"Y/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}/query/{query.query_type}:\SOH*\DC2\236\SOH\n\
      \\EMDescribeWorkflowExecution\DC2A.temporal.api.workflowservice.v1.DescribeWorkflowExecutionRequest\SUBB.temporal.api.workflowservice.v1.DescribeWorkflowExecutionResponse\"H\130\211\228\147\STXB\DC2@/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}\DC2\208\SOH\n\
      \\DC1DescribeTaskQueue\DC29.temporal.api.workflowservice.v1.DescribeTaskQueueRequest\SUB:.temporal.api.workflowservice.v1.DescribeTaskQueueResponse\"D\130\211\228\147\STX>\DC2</api/v1/namespaces/{namespace}/task-queues/{task_queue.name}\DC2\159\SOH\n\
      \\SOGetClusterInfo\DC26.temporal.api.workflowservice.v1.GetClusterInfoRequest\SUB7.temporal.api.workflowservice.v1.GetClusterInfoResponse\"\FS\130\211\228\147\STX\SYN\DC2\DC4/api/v1/cluster-info\DC2\155\SOH\n\
      \\rGetSystemInfo\DC25.temporal.api.workflowservice.v1.GetSystemInfoRequest\SUB6.temporal.api.workflowservice.v1.GetSystemInfoResponse\"\ESC\130\211\228\147\STX\NAK\DC2\DC3/api/v1/system-info\DC2\158\SOH\n\
      \\ETBListTaskQueuePartitions\DC2?.temporal.api.workflowservice.v1.ListTaskQueuePartitionsRequest\SUB@.temporal.api.workflowservice.v1.ListTaskQueuePartitionsResponse\"\NUL\DC2\196\SOH\n\
      \\SOCreateSchedule\DC26.temporal.api.workflowservice.v1.CreateScheduleRequest\SUB7.temporal.api.workflowservice.v1.CreateScheduleResponse\"A\130\211\228\147\STX;\"6/api/v1/namespaces/{namespace}/schedules/{schedule_id}:\SOH*\DC2\199\SOH\n\
      \\DLEDescribeSchedule\DC28.temporal.api.workflowservice.v1.DescribeScheduleRequest\SUB9.temporal.api.workflowservice.v1.DescribeScheduleResponse\">\130\211\228\147\STX8\DC26/api/v1/namespaces/{namespace}/schedules/{schedule_id}\DC2\203\SOH\n\
      \\SOUpdateSchedule\DC26.temporal.api.workflowservice.v1.UpdateScheduleRequest\SUB7.temporal.api.workflowservice.v1.UpdateScheduleResponse\"H\130\211\228\147\STXB\"=/api/v1/namespaces/{namespace}/schedules/{schedule_id}/update:\SOH*\DC2\199\SOH\n\
      \\rPatchSchedule\DC25.temporal.api.workflowservice.v1.PatchScheduleRequest\SUB6.temporal.api.workflowservice.v1.PatchScheduleResponse\"G\130\211\228\147\STXA\"</api/v1/namespaces/{namespace}/schedules/{schedule_id}/patch:\SOH*\DC2\241\SOH\n\
      \\EMListScheduleMatchingTimes\DC2A.temporal.api.workflowservice.v1.ListScheduleMatchingTimesRequest\SUBB.temporal.api.workflowservice.v1.ListScheduleMatchingTimesResponse\"M\130\211\228\147\STXG\DC2E/api/v1/namespaces/{namespace}/schedules/{schedule_id}/matching-times\DC2\193\SOH\n\
      \\SODeleteSchedule\DC26.temporal.api.workflowservice.v1.DeleteScheduleRequest\SUB7.temporal.api.workflowservice.v1.DeleteScheduleResponse\">\130\211\228\147\STX8*6/api/v1/namespaces/{namespace}/schedules/{schedule_id}\DC2\176\SOH\n\
      \\rListSchedules\DC25.temporal.api.workflowservice.v1.ListSchedulesRequest\SUB6.temporal.api.workflowservice.v1.ListSchedulesResponse\"0\130\211\228\147\STX*\DC2(/api/v1/namespaces/{namespace}/schedules\DC2\185\SOH\n\
      \ UpdateWorkerBuildIdCompatibility\DC2H.temporal.api.workflowservice.v1.UpdateWorkerBuildIdCompatibilityRequest\SUBI.temporal.api.workflowservice.v1.UpdateWorkerBuildIdCompatibilityResponse\"\NUL\DC2\141\STX\n\
      \\GSGetWorkerBuildIdCompatibility\DC2E.temporal.api.workflowservice.v1.GetWorkerBuildIdCompatibilityRequest\SUBF.temporal.api.workflowservice.v1.GetWorkerBuildIdCompatibilityResponse\"]\130\211\228\147\STXW\DC2U/api/v1/namespaces/{namespace}/task-queues/{task_queue}/worker-build-id-compatibility\DC2\170\SOH\n\
      \\ESCUpdateWorkerVersioningRules\DC2C.temporal.api.workflowservice.v1.UpdateWorkerVersioningRulesRequest\SUBD.temporal.api.workflowservice.v1.UpdateWorkerVersioningRulesResponse\"\NUL\DC2\248\SOH\n\
      \\CANGetWorkerVersioningRules\DC2@.temporal.api.workflowservice.v1.GetWorkerVersioningRulesRequest\SUBA.temporal.api.workflowservice.v1.GetWorkerVersioningRulesResponse\"W\130\211\228\147\STXQ\DC2O/api/v1/namespaces/{namespace}/task-queues/{task_queue}/worker-versioning-rules\DC2\227\SOH\n\
      \\EMGetWorkerTaskReachability\DC2A.temporal.api.workflowservice.v1.GetWorkerTaskReachabilityRequest\SUBB.temporal.api.workflowservice.v1.GetWorkerTaskReachabilityResponse\"?\130\211\228\147\STX9\DC27/api/v1/namespaces/{namespace}/worker-task-reachability\DC2\142\STX\n\
      \\ETBUpdateWorkflowExecution\DC2?.temporal.api.workflowservice.v1.UpdateWorkflowExecutionRequest\SUB@.temporal.api.workflowservice.v1.UpdateWorkflowExecutionResponse\"p\130\211\228\147\STXj\"e/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/update/{request.input.name}:\SOH*\DC2\170\SOH\n\
      \\ESCPollWorkflowExecutionUpdate\DC2C.temporal.api.workflowservice.v1.PollWorkflowExecutionUpdateRequest\SUBD.temporal.api.workflowservice.v1.PollWorkflowExecutionUpdateResponse\"\NUL\DC2\213\SOH\n\
      \\DC3StartBatchOperation\DC2;.temporal.api.workflowservice.v1.StartBatchOperationRequest\SUB<.temporal.api.workflowservice.v1.StartBatchOperationResponse\"C\130\211\228\147\STX=\"8/api/v1/namespaces/{namespace}/batch-operations/{job_id}:\SOH*\DC2\215\SOH\n\
      \\DC2StopBatchOperation\DC2:.temporal.api.workflowservice.v1.StopBatchOperationRequest\SUB;.temporal.api.workflowservice.v1.StopBatchOperationResponse\"H\130\211\228\147\STXB\"=/api/v1/namespaces/{namespace}/batch-operations/{job_id}/stop:\SOH*\DC2\219\SOH\n\
      \\SYNDescribeBatchOperation\DC2>.temporal.api.workflowservice.v1.DescribeBatchOperationRequest\SUB?.temporal.api.workflowservice.v1.DescribeBatchOperationResponse\"@\130\211\228\147\STX:\DC28/api/v1/namespaces/{namespace}/batch-operations/{job_id}\DC2\201\SOH\n\
      \\DC3ListBatchOperations\DC2;.temporal.api.workflowservice.v1.ListBatchOperationsRequest\SUB<.temporal.api.workflowservice.v1.ListBatchOperationsResponse\"7\130\211\228\147\STX1\DC2//api/v1/namespaces/{namespace}/batch-operations\DC2\143\SOH\n\
      \\DC2PollNexusTaskQueue\DC2:.temporal.api.workflowservice.v1.PollNexusTaskQueueRequest\SUB;.temporal.api.workflowservice.v1.PollNexusTaskQueueResponse\"\NUL\DC2\164\SOH\n\
      \\EMRespondNexusTaskCompleted\DC2A.temporal.api.workflowservice.v1.RespondNexusTaskCompletedRequest\SUBB.temporal.api.workflowservice.v1.RespondNexusTaskCompletedResponse\"\NUL\DC2\155\SOH\n\
      \\SYNRespondNexusTaskFailed\DC2>.temporal.api.workflowservice.v1.RespondNexusTaskFailedRequest\SUB?.temporal.api.workflowservice.v1.RespondNexusTaskFailedResponse\"\NUL"
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "registerNamespace" where
  type MethodName WorkflowService "registerNamespace" = "RegisterNamespace"
  type MethodInput WorkflowService "registerNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RegisterNamespaceRequest
  type MethodOutput WorkflowService "registerNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RegisterNamespaceResponse
  type MethodStreamingType WorkflowService "registerNamespace" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeNamespace" where
  type MethodName WorkflowService "describeNamespace" = "DescribeNamespace"
  type MethodInput WorkflowService "describeNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeNamespaceRequest
  type MethodOutput WorkflowService "describeNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeNamespaceResponse
  type MethodStreamingType WorkflowService "describeNamespace" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listNamespaces" where
  type MethodName WorkflowService "listNamespaces" = "ListNamespaces"
  type MethodInput WorkflowService "listNamespaces" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListNamespacesRequest
  type MethodOutput WorkflowService "listNamespaces" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListNamespacesResponse
  type MethodStreamingType WorkflowService "listNamespaces" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateNamespace" where
  type MethodName WorkflowService "updateNamespace" = "UpdateNamespace"
  type MethodInput WorkflowService "updateNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateNamespaceRequest
  type MethodOutput WorkflowService "updateNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateNamespaceResponse
  type MethodStreamingType WorkflowService "updateNamespace" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "deprecateNamespace" where
  type MethodName WorkflowService "deprecateNamespace" = "DeprecateNamespace"
  type MethodInput WorkflowService "deprecateNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeprecateNamespaceRequest
  type MethodOutput WorkflowService "deprecateNamespace" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeprecateNamespaceResponse
  type MethodStreamingType WorkflowService "deprecateNamespace" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "startWorkflowExecution" where
  type MethodName WorkflowService "startWorkflowExecution" = "StartWorkflowExecution"
  type MethodInput WorkflowService "startWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.StartWorkflowExecutionRequest
  type MethodOutput WorkflowService "startWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.StartWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "startWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "executeMultiOperation" where
  type MethodName WorkflowService "executeMultiOperation" = "ExecuteMultiOperation"
  type MethodInput WorkflowService "executeMultiOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ExecuteMultiOperationRequest
  type MethodOutput WorkflowService "executeMultiOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ExecuteMultiOperationResponse
  type MethodStreamingType WorkflowService "executeMultiOperation" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getWorkflowExecutionHistory" where
  type MethodName WorkflowService "getWorkflowExecutionHistory" = "GetWorkflowExecutionHistory"
  type MethodInput WorkflowService "getWorkflowExecutionHistory" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkflowExecutionHistoryRequest
  type MethodOutput WorkflowService "getWorkflowExecutionHistory" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkflowExecutionHistoryResponse
  type MethodStreamingType WorkflowService "getWorkflowExecutionHistory" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getWorkflowExecutionHistoryReverse" where
  type MethodName WorkflowService "getWorkflowExecutionHistoryReverse" = "GetWorkflowExecutionHistoryReverse"
  type MethodInput WorkflowService "getWorkflowExecutionHistoryReverse" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkflowExecutionHistoryReverseRequest
  type MethodOutput WorkflowService "getWorkflowExecutionHistoryReverse" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkflowExecutionHistoryReverseResponse
  type MethodStreamingType WorkflowService "getWorkflowExecutionHistoryReverse" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "pollWorkflowTaskQueue" where
  type MethodName WorkflowService "pollWorkflowTaskQueue" = "PollWorkflowTaskQueue"
  type MethodInput WorkflowService "pollWorkflowTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollWorkflowTaskQueueRequest
  type MethodOutput WorkflowService "pollWorkflowTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollWorkflowTaskQueueResponse
  type MethodStreamingType WorkflowService "pollWorkflowTaskQueue" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondWorkflowTaskCompleted" where
  type MethodName WorkflowService "respondWorkflowTaskCompleted" = "RespondWorkflowTaskCompleted"
  type MethodInput WorkflowService "respondWorkflowTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondWorkflowTaskCompletedRequest
  type MethodOutput WorkflowService "respondWorkflowTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondWorkflowTaskCompletedResponse
  type MethodStreamingType WorkflowService "respondWorkflowTaskCompleted" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondWorkflowTaskFailed" where
  type MethodName WorkflowService "respondWorkflowTaskFailed" = "RespondWorkflowTaskFailed"
  type MethodInput WorkflowService "respondWorkflowTaskFailed" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondWorkflowTaskFailedRequest
  type MethodOutput WorkflowService "respondWorkflowTaskFailed" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondWorkflowTaskFailedResponse
  type MethodStreamingType WorkflowService "respondWorkflowTaskFailed" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "pollActivityTaskQueue" where
  type MethodName WorkflowService "pollActivityTaskQueue" = "PollActivityTaskQueue"
  type MethodInput WorkflowService "pollActivityTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollActivityTaskQueueRequest
  type MethodOutput WorkflowService "pollActivityTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollActivityTaskQueueResponse
  type MethodStreamingType WorkflowService "pollActivityTaskQueue" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "recordActivityTaskHeartbeat" where
  type MethodName WorkflowService "recordActivityTaskHeartbeat" = "RecordActivityTaskHeartbeat"
  type MethodInput WorkflowService "recordActivityTaskHeartbeat" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RecordActivityTaskHeartbeatRequest
  type MethodOutput WorkflowService "recordActivityTaskHeartbeat" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RecordActivityTaskHeartbeatResponse
  type MethodStreamingType WorkflowService "recordActivityTaskHeartbeat" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "recordActivityTaskHeartbeatById" where
  type MethodName WorkflowService "recordActivityTaskHeartbeatById" = "RecordActivityTaskHeartbeatById"
  type MethodInput WorkflowService "recordActivityTaskHeartbeatById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RecordActivityTaskHeartbeatByIdRequest
  type MethodOutput WorkflowService "recordActivityTaskHeartbeatById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RecordActivityTaskHeartbeatByIdResponse
  type MethodStreamingType WorkflowService "recordActivityTaskHeartbeatById" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondActivityTaskCompleted" where
  type MethodName WorkflowService "respondActivityTaskCompleted" = "RespondActivityTaskCompleted"
  type MethodInput WorkflowService "respondActivityTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCompletedRequest
  type MethodOutput WorkflowService "respondActivityTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCompletedResponse
  type MethodStreamingType WorkflowService "respondActivityTaskCompleted" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondActivityTaskCompletedById" where
  type MethodName WorkflowService "respondActivityTaskCompletedById" = "RespondActivityTaskCompletedById"
  type MethodInput WorkflowService "respondActivityTaskCompletedById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCompletedByIdRequest
  type MethodOutput WorkflowService "respondActivityTaskCompletedById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCompletedByIdResponse
  type MethodStreamingType WorkflowService "respondActivityTaskCompletedById" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondActivityTaskFailed" where
  type MethodName WorkflowService "respondActivityTaskFailed" = "RespondActivityTaskFailed"
  type MethodInput WorkflowService "respondActivityTaskFailed" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskFailedRequest
  type MethodOutput WorkflowService "respondActivityTaskFailed" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskFailedResponse
  type MethodStreamingType WorkflowService "respondActivityTaskFailed" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondActivityTaskFailedById" where
  type MethodName WorkflowService "respondActivityTaskFailedById" = "RespondActivityTaskFailedById"
  type MethodInput WorkflowService "respondActivityTaskFailedById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskFailedByIdRequest
  type MethodOutput WorkflowService "respondActivityTaskFailedById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskFailedByIdResponse
  type MethodStreamingType WorkflowService "respondActivityTaskFailedById" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondActivityTaskCanceled" where
  type MethodName WorkflowService "respondActivityTaskCanceled" = "RespondActivityTaskCanceled"
  type MethodInput WorkflowService "respondActivityTaskCanceled" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCanceledRequest
  type MethodOutput WorkflowService "respondActivityTaskCanceled" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCanceledResponse
  type MethodStreamingType WorkflowService "respondActivityTaskCanceled" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondActivityTaskCanceledById" where
  type MethodName WorkflowService "respondActivityTaskCanceledById" = "RespondActivityTaskCanceledById"
  type MethodInput WorkflowService "respondActivityTaskCanceledById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCanceledByIdRequest
  type MethodOutput WorkflowService "respondActivityTaskCanceledById" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondActivityTaskCanceledByIdResponse
  type MethodStreamingType WorkflowService "respondActivityTaskCanceledById" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "requestCancelWorkflowExecution" where
  type MethodName WorkflowService "requestCancelWorkflowExecution" = "RequestCancelWorkflowExecution"
  type MethodInput WorkflowService "requestCancelWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RequestCancelWorkflowExecutionRequest
  type MethodOutput WorkflowService "requestCancelWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RequestCancelWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "requestCancelWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "signalWorkflowExecution" where
  type MethodName WorkflowService "signalWorkflowExecution" = "SignalWorkflowExecution"
  type MethodInput WorkflowService "signalWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SignalWorkflowExecutionRequest
  type MethodOutput WorkflowService "signalWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SignalWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "signalWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "signalWithStartWorkflowExecution" where
  type MethodName WorkflowService "signalWithStartWorkflowExecution" = "SignalWithStartWorkflowExecution"
  type MethodInput WorkflowService "signalWithStartWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SignalWithStartWorkflowExecutionRequest
  type MethodOutput WorkflowService "signalWithStartWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SignalWithStartWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "signalWithStartWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "resetWorkflowExecution" where
  type MethodName WorkflowService "resetWorkflowExecution" = "ResetWorkflowExecution"
  type MethodInput WorkflowService "resetWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ResetWorkflowExecutionRequest
  type MethodOutput WorkflowService "resetWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ResetWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "resetWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "terminateWorkflowExecution" where
  type MethodName WorkflowService "terminateWorkflowExecution" = "TerminateWorkflowExecution"
  type MethodInput WorkflowService "terminateWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.TerminateWorkflowExecutionRequest
  type MethodOutput WorkflowService "terminateWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.TerminateWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "terminateWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "deleteWorkflowExecution" where
  type MethodName WorkflowService "deleteWorkflowExecution" = "DeleteWorkflowExecution"
  type MethodInput WorkflowService "deleteWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkflowExecutionRequest
  type MethodOutput WorkflowService "deleteWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "deleteWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listOpenWorkflowExecutions" where
  type MethodName WorkflowService "listOpenWorkflowExecutions" = "ListOpenWorkflowExecutions"
  type MethodInput WorkflowService "listOpenWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListOpenWorkflowExecutionsRequest
  type MethodOutput WorkflowService "listOpenWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListOpenWorkflowExecutionsResponse
  type MethodStreamingType WorkflowService "listOpenWorkflowExecutions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listClosedWorkflowExecutions" where
  type MethodName WorkflowService "listClosedWorkflowExecutions" = "ListClosedWorkflowExecutions"
  type MethodInput WorkflowService "listClosedWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListClosedWorkflowExecutionsRequest
  type MethodOutput WorkflowService "listClosedWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListClosedWorkflowExecutionsResponse
  type MethodStreamingType WorkflowService "listClosedWorkflowExecutions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listWorkflowExecutions" where
  type MethodName WorkflowService "listWorkflowExecutions" = "ListWorkflowExecutions"
  type MethodInput WorkflowService "listWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkflowExecutionsRequest
  type MethodOutput WorkflowService "listWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkflowExecutionsResponse
  type MethodStreamingType WorkflowService "listWorkflowExecutions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listArchivedWorkflowExecutions" where
  type MethodName WorkflowService "listArchivedWorkflowExecutions" = "ListArchivedWorkflowExecutions"
  type MethodInput WorkflowService "listArchivedWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListArchivedWorkflowExecutionsRequest
  type MethodOutput WorkflowService "listArchivedWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListArchivedWorkflowExecutionsResponse
  type MethodStreamingType WorkflowService "listArchivedWorkflowExecutions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "scanWorkflowExecutions" where
  type MethodName WorkflowService "scanWorkflowExecutions" = "ScanWorkflowExecutions"
  type MethodInput WorkflowService "scanWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ScanWorkflowExecutionsRequest
  type MethodOutput WorkflowService "scanWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ScanWorkflowExecutionsResponse
  type MethodStreamingType WorkflowService "scanWorkflowExecutions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "countWorkflowExecutions" where
  type MethodName WorkflowService "countWorkflowExecutions" = "CountWorkflowExecutions"
  type MethodInput WorkflowService "countWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.CountWorkflowExecutionsRequest
  type MethodOutput WorkflowService "countWorkflowExecutions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.CountWorkflowExecutionsResponse
  type MethodStreamingType WorkflowService "countWorkflowExecutions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getSearchAttributes" where
  type MethodName WorkflowService "getSearchAttributes" = "GetSearchAttributes"
  type MethodInput WorkflowService "getSearchAttributes" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetSearchAttributesRequest
  type MethodOutput WorkflowService "getSearchAttributes" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetSearchAttributesResponse
  type MethodStreamingType WorkflowService "getSearchAttributes" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondQueryTaskCompleted" where
  type MethodName WorkflowService "respondQueryTaskCompleted" = "RespondQueryTaskCompleted"
  type MethodInput WorkflowService "respondQueryTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondQueryTaskCompletedRequest
  type MethodOutput WorkflowService "respondQueryTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondQueryTaskCompletedResponse
  type MethodStreamingType WorkflowService "respondQueryTaskCompleted" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "resetStickyTaskQueue" where
  type MethodName WorkflowService "resetStickyTaskQueue" = "ResetStickyTaskQueue"
  type MethodInput WorkflowService "resetStickyTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ResetStickyTaskQueueRequest
  type MethodOutput WorkflowService "resetStickyTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ResetStickyTaskQueueResponse
  type MethodStreamingType WorkflowService "resetStickyTaskQueue" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "queryWorkflow" where
  type MethodName WorkflowService "queryWorkflow" = "QueryWorkflow"
  type MethodInput WorkflowService "queryWorkflow" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.QueryWorkflowRequest
  type MethodOutput WorkflowService "queryWorkflow" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.QueryWorkflowResponse
  type MethodStreamingType WorkflowService "queryWorkflow" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeWorkflowExecution" where
  type MethodName WorkflowService "describeWorkflowExecution" = "DescribeWorkflowExecution"
  type MethodInput WorkflowService "describeWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkflowExecutionRequest
  type MethodOutput WorkflowService "describeWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "describeWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeTaskQueue" where
  type MethodName WorkflowService "describeTaskQueue" = "DescribeTaskQueue"
  type MethodInput WorkflowService "describeTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeTaskQueueRequest
  type MethodOutput WorkflowService "describeTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeTaskQueueResponse
  type MethodStreamingType WorkflowService "describeTaskQueue" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getClusterInfo" where
  type MethodName WorkflowService "getClusterInfo" = "GetClusterInfo"
  type MethodInput WorkflowService "getClusterInfo" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetClusterInfoRequest
  type MethodOutput WorkflowService "getClusterInfo" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetClusterInfoResponse
  type MethodStreamingType WorkflowService "getClusterInfo" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getSystemInfo" where
  type MethodName WorkflowService "getSystemInfo" = "GetSystemInfo"
  type MethodInput WorkflowService "getSystemInfo" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetSystemInfoRequest
  type MethodOutput WorkflowService "getSystemInfo" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetSystemInfoResponse
  type MethodStreamingType WorkflowService "getSystemInfo" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listTaskQueuePartitions" where
  type MethodName WorkflowService "listTaskQueuePartitions" = "ListTaskQueuePartitions"
  type MethodInput WorkflowService "listTaskQueuePartitions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListTaskQueuePartitionsRequest
  type MethodOutput WorkflowService "listTaskQueuePartitions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListTaskQueuePartitionsResponse
  type MethodStreamingType WorkflowService "listTaskQueuePartitions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "createSchedule" where
  type MethodName WorkflowService "createSchedule" = "CreateSchedule"
  type MethodInput WorkflowService "createSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.CreateScheduleRequest
  type MethodOutput WorkflowService "createSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.CreateScheduleResponse
  type MethodStreamingType WorkflowService "createSchedule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeSchedule" where
  type MethodName WorkflowService "describeSchedule" = "DescribeSchedule"
  type MethodInput WorkflowService "describeSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeScheduleRequest
  type MethodOutput WorkflowService "describeSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeScheduleResponse
  type MethodStreamingType WorkflowService "describeSchedule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateSchedule" where
  type MethodName WorkflowService "updateSchedule" = "UpdateSchedule"
  type MethodInput WorkflowService "updateSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateScheduleRequest
  type MethodOutput WorkflowService "updateSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateScheduleResponse
  type MethodStreamingType WorkflowService "updateSchedule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "patchSchedule" where
  type MethodName WorkflowService "patchSchedule" = "PatchSchedule"
  type MethodInput WorkflowService "patchSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PatchScheduleRequest
  type MethodOutput WorkflowService "patchSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PatchScheduleResponse
  type MethodStreamingType WorkflowService "patchSchedule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listScheduleMatchingTimes" where
  type MethodName WorkflowService "listScheduleMatchingTimes" = "ListScheduleMatchingTimes"
  type MethodInput WorkflowService "listScheduleMatchingTimes" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListScheduleMatchingTimesRequest
  type MethodOutput WorkflowService "listScheduleMatchingTimes" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListScheduleMatchingTimesResponse
  type MethodStreamingType WorkflowService "listScheduleMatchingTimes" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "deleteSchedule" where
  type MethodName WorkflowService "deleteSchedule" = "DeleteSchedule"
  type MethodInput WorkflowService "deleteSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteScheduleRequest
  type MethodOutput WorkflowService "deleteSchedule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteScheduleResponse
  type MethodStreamingType WorkflowService "deleteSchedule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listSchedules" where
  type MethodName WorkflowService "listSchedules" = "ListSchedules"
  type MethodInput WorkflowService "listSchedules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListSchedulesRequest
  type MethodOutput WorkflowService "listSchedules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListSchedulesResponse
  type MethodStreamingType WorkflowService "listSchedules" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateWorkerBuildIdCompatibility" where
  type MethodName WorkflowService "updateWorkerBuildIdCompatibility" = "UpdateWorkerBuildIdCompatibility"
  type MethodInput WorkflowService "updateWorkerBuildIdCompatibility" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkerBuildIdCompatibilityRequest
  type MethodOutput WorkflowService "updateWorkerBuildIdCompatibility" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkerBuildIdCompatibilityResponse
  type MethodStreamingType WorkflowService "updateWorkerBuildIdCompatibility" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getWorkerBuildIdCompatibility" where
  type MethodName WorkflowService "getWorkerBuildIdCompatibility" = "GetWorkerBuildIdCompatibility"
  type MethodInput WorkflowService "getWorkerBuildIdCompatibility" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkerBuildIdCompatibilityRequest
  type MethodOutput WorkflowService "getWorkerBuildIdCompatibility" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkerBuildIdCompatibilityResponse
  type MethodStreamingType WorkflowService "getWorkerBuildIdCompatibility" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateWorkerVersioningRules" where
  type MethodName WorkflowService "updateWorkerVersioningRules" = "UpdateWorkerVersioningRules"
  type MethodInput WorkflowService "updateWorkerVersioningRules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkerVersioningRulesRequest
  type MethodOutput WorkflowService "updateWorkerVersioningRules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkerVersioningRulesResponse
  type MethodStreamingType WorkflowService "updateWorkerVersioningRules" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getWorkerVersioningRules" where
  type MethodName WorkflowService "getWorkerVersioningRules" = "GetWorkerVersioningRules"
  type MethodInput WorkflowService "getWorkerVersioningRules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkerVersioningRulesRequest
  type MethodOutput WorkflowService "getWorkerVersioningRules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkerVersioningRulesResponse
  type MethodStreamingType WorkflowService "getWorkerVersioningRules" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getWorkerTaskReachability" where
  type MethodName WorkflowService "getWorkerTaskReachability" = "GetWorkerTaskReachability"
  type MethodInput WorkflowService "getWorkerTaskReachability" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkerTaskReachabilityRequest
  type MethodOutput WorkflowService "getWorkerTaskReachability" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetWorkerTaskReachabilityResponse
  type MethodStreamingType WorkflowService "getWorkerTaskReachability" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateWorkflowExecution" where
  type MethodName WorkflowService "updateWorkflowExecution" = "UpdateWorkflowExecution"
  type MethodInput WorkflowService "updateWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkflowExecutionRequest
  type MethodOutput WorkflowService "updateWorkflowExecution" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkflowExecutionResponse
  type MethodStreamingType WorkflowService "updateWorkflowExecution" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "pollWorkflowExecutionUpdate" where
  type MethodName WorkflowService "pollWorkflowExecutionUpdate" = "PollWorkflowExecutionUpdate"
  type MethodInput WorkflowService "pollWorkflowExecutionUpdate" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollWorkflowExecutionUpdateRequest
  type MethodOutput WorkflowService "pollWorkflowExecutionUpdate" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollWorkflowExecutionUpdateResponse
  type MethodStreamingType WorkflowService "pollWorkflowExecutionUpdate" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "startBatchOperation" where
  type MethodName WorkflowService "startBatchOperation" = "StartBatchOperation"
  type MethodInput WorkflowService "startBatchOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.StartBatchOperationRequest
  type MethodOutput WorkflowService "startBatchOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.StartBatchOperationResponse
  type MethodStreamingType WorkflowService "startBatchOperation" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "stopBatchOperation" where
  type MethodName WorkflowService "stopBatchOperation" = "StopBatchOperation"
  type MethodInput WorkflowService "stopBatchOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.StopBatchOperationRequest
  type MethodOutput WorkflowService "stopBatchOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.StopBatchOperationResponse
  type MethodStreamingType WorkflowService "stopBatchOperation" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeBatchOperation" where
  type MethodName WorkflowService "describeBatchOperation" = "DescribeBatchOperation"
  type MethodInput WorkflowService "describeBatchOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeBatchOperationRequest
  type MethodOutput WorkflowService "describeBatchOperation" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeBatchOperationResponse
  type MethodStreamingType WorkflowService "describeBatchOperation" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listBatchOperations" where
  type MethodName WorkflowService "listBatchOperations" = "ListBatchOperations"
  type MethodInput WorkflowService "listBatchOperations" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListBatchOperationsRequest
  type MethodOutput WorkflowService "listBatchOperations" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListBatchOperationsResponse
  type MethodStreamingType WorkflowService "listBatchOperations" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "pollNexusTaskQueue" where
  type MethodName WorkflowService "pollNexusTaskQueue" = "PollNexusTaskQueue"
  type MethodInput WorkflowService "pollNexusTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueRequest
  type MethodOutput WorkflowService "pollNexusTaskQueue" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PollNexusTaskQueueResponse
  type MethodStreamingType WorkflowService "pollNexusTaskQueue" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondNexusTaskCompleted" where
  type MethodName WorkflowService "respondNexusTaskCompleted" = "RespondNexusTaskCompleted"
  type MethodInput WorkflowService "respondNexusTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondNexusTaskCompletedRequest
  type MethodOutput WorkflowService "respondNexusTaskCompleted" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondNexusTaskCompletedResponse
  type MethodStreamingType WorkflowService "respondNexusTaskCompleted" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "respondNexusTaskFailed" where
  type MethodName WorkflowService "respondNexusTaskFailed" = "RespondNexusTaskFailed"
  type MethodInput WorkflowService "respondNexusTaskFailed" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondNexusTaskFailedRequest
  type MethodOutput WorkflowService "respondNexusTaskFailed" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RespondNexusTaskFailedResponse
  type MethodStreamingType WorkflowService "respondNexusTaskFailed" = 'Data.ProtoLens.Service.Types.NonStreaming

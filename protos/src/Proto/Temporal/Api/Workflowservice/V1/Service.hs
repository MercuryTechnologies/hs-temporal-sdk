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
                                          "createWorkflowRule",
                                          "deleteSchedule",
                                          "deleteWorkerDeployment",
                                          "deleteWorkerDeploymentVersion",
                                          "deleteWorkflowExecution",
                                          "deleteWorkflowRule",
                                          "deprecateNamespace",
                                          "describeBatchOperation",
                                          "describeDeployment",
                                          "describeNamespace",
                                          "describeSchedule",
                                          "describeTaskQueue",
                                          "describeWorkerDeployment",
                                          "describeWorkerDeploymentVersion",
                                          "describeWorkflowExecution",
                                          "describeWorkflowRule",
                                          "executeMultiOperation",
                                          "getClusterInfo",
                                          "getCurrentDeployment",
                                          "getDeploymentReachability",
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
                                          "listDeployments",
                                          "listNamespaces",
                                          "listOpenWorkflowExecutions",
                                          "listScheduleMatchingTimes",
                                          "listSchedules",
                                          "listTaskQueuePartitions",
                                          "listWorkerDeployments",
                                          "listWorkers",
                                          "listWorkflowExecutions",
                                          "listWorkflowRules",
                                          "patchSchedule",
                                          "pauseActivity",
                                          "pollActivityTaskQueue",
                                          "pollNexusTaskQueue",
                                          "pollWorkflowExecutionUpdate",
                                          "pollWorkflowTaskQueue",
                                          "queryWorkflow",
                                          "recordActivityTaskHeartbeat",
                                          "recordActivityTaskHeartbeatById",
                                          "recordWorkerHeartbeat",
                                          "registerNamespace",
                                          "requestCancelWorkflowExecution",
                                          "resetActivity",
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
                                          "setCurrentDeployment",
                                          "setWorkerDeploymentCurrentVersion",
                                          "setWorkerDeploymentRampingVersion",
                                          "shutdownWorker",
                                          "signalWithStartWorkflowExecution",
                                          "signalWorkflowExecution",
                                          "startBatchOperation",
                                          "startWorkflowExecution",
                                          "stopBatchOperation",
                                          "terminateWorkflowExecution",
                                          "triggerWorkflowRule",
                                          "unpauseActivity",
                                          "updateActivityOptions",
                                          "updateNamespace",
                                          "updateSchedule",
                                          "updateWorkerBuildIdCompatibility",
                                          "updateWorkerDeploymentVersionMetadata",
                                          "updateWorkerVersioningRules",
                                          "updateWorkflowExecution",
                                          "updateWorkflowExecutionOptions"]
  packedServiceDescriptor _
    = "\n\
      \\SIWorkflowService\DC2\195\SOH\n\
      \\DC1RegisterNamespace\DC29.temporal.api.workflowservice.v1.RegisterNamespaceRequest\SUB:.temporal.api.workflowservice.v1.RegisterNamespaceResponse\"7\130\211\228\147\STX1\"\DC3/cluster/namespaces:\SOH*Z\ETB\"\DC2/api/v1/namespaces:\SOH*\DC2\213\SOH\n\
      \\DC1DescribeNamespace\DC29.temporal.api.workflowservice.v1.DescribeNamespaceRequest\SUB:.temporal.api.workflowservice.v1.DescribeNamespaceResponse\"I\130\211\228\147\STXC\DC2\US/cluster/namespaces/{namespace}Z \DC2\RS/api/v1/namespaces/{namespace}\DC2\180\SOH\n\
      \\SOListNamespaces\DC26.temporal.api.workflowservice.v1.ListNamespacesRequest\SUB7.temporal.api.workflowservice.v1.ListNamespacesResponse\"1\130\211\228\147\STX+\DC2\DC3/cluster/namespacesZ\DC4\DC2\DC2/api/v1/namespaces\DC2\227\SOH\n\
      \\SIUpdateNamespace\DC27.temporal.api.workflowservice.v1.UpdateNamespaceRequest\SUB8.temporal.api.workflowservice.v1.UpdateNamespaceResponse\"]\130\211\228\147\STXW\"&/cluster/namespaces/{namespace}/update:\SOH*Z*\"%/api/v1/namespaces/{namespace}/update:\SOH*\DC2\143\SOH\n\
      \\DC2DeprecateNamespace\DC2:.temporal.api.workflowservice.v1.DeprecateNamespaceRequest\SUB;.temporal.api.workflowservice.v1.DeprecateNamespaceResponse\"\NUL\DC2\146\STX\n\
      \\SYNStartWorkflowExecution\DC2>.temporal.api.workflowservice.v1.StartWorkflowExecutionRequest\SUB?.temporal.api.workflowservice.v1.StartWorkflowExecutionResponse\"w\130\211\228\147\STXq\"//namespaces/{namespace}/workflows/{workflow_id}:\SOH*Z;\"6/api/v1/namespaces/{namespace}/workflows/{workflow_id}:\SOH*\DC2\165\STX\n\
      \\NAKExecuteMultiOperation\DC2=.temporal.api.workflowservice.v1.ExecuteMultiOperationRequest\SUB>.temporal.api.workflowservice.v1.ExecuteMultiOperationResponse\"\140\SOH\130\211\228\147\STX\133\SOH\"9/namespaces/{namespace}/workflows/execute-multi-operation:\SOH*ZE\"@/api/v1/namespaces/{namespace}/workflows/execute-multi-operation:\SOH*\DC2\193\STX\n\
      \\ESCGetWorkflowExecutionHistory\DC2C.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryRequest\SUBD.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryResponse\"\150\SOH\130\211\228\147\STX\143\SOH\DC2A/namespaces/{namespace}/workflows/{execution.workflow_id}/historyZJ\DC2H/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}/history\DC2\230\STX\n\
      \\"GetWorkflowExecutionHistoryReverse\DC2J.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryReverseRequest\SUBK.temporal.api.workflowservice.v1.GetWorkflowExecutionHistoryReverseResponse\"\166\SOH\130\211\228\147\STX\159\SOH\DC2I/namespaces/{namespace}/workflows/{execution.workflow_id}/history-reverseZR\DC2P/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}/history-reverse\DC2\152\SOH\n\
      \\NAKPollWorkflowTaskQueue\DC2=.temporal.api.workflowservice.v1.PollWorkflowTaskQueueRequest\SUB>.temporal.api.workflowservice.v1.PollWorkflowTaskQueueResponse\"\NUL\DC2\173\SOH\n\
      \\FSRespondWorkflowTaskCompleted\DC2D.temporal.api.workflowservice.v1.RespondWorkflowTaskCompletedRequest\SUBE.temporal.api.workflowservice.v1.RespondWorkflowTaskCompletedResponse\"\NUL\DC2\164\SOH\n\
      \\EMRespondWorkflowTaskFailed\DC2A.temporal.api.workflowservice.v1.RespondWorkflowTaskFailedRequest\SUBB.temporal.api.workflowservice.v1.RespondWorkflowTaskFailedResponse\"\NUL\DC2\152\SOH\n\
      \\NAKPollActivityTaskQueue\DC2=.temporal.api.workflowservice.v1.PollActivityTaskQueueRequest\SUB>.temporal.api.workflowservice.v1.PollActivityTaskQueueResponse\"\NUL\DC2\155\STX\n\
      \\ESCRecordActivityTaskHeartbeat\DC2C.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatRequest\SUBD.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatResponse\"q\130\211\228\147\STXk\",/namespaces/{namespace}/activities/heartbeat:\SOH*Z8\"3/api/v1/namespaces/{namespace}/activities/heartbeat:\SOH*\DC2\179\STX\n\
      \\USRecordActivityTaskHeartbeatById\DC2G.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatByIdRequest\SUBH.temporal.api.workflowservice.v1.RecordActivityTaskHeartbeatByIdResponse\"}\130\211\228\147\STXw\"2/namespaces/{namespace}/activities/heartbeat-by-id:\SOH*Z>\"9/api/v1/namespaces/{namespace}/activities/heartbeat-by-id:\SOH*\DC2\156\STX\n\
      \\FSRespondActivityTaskCompleted\DC2D.temporal.api.workflowservice.v1.RespondActivityTaskCompletedRequest\SUBE.temporal.api.workflowservice.v1.RespondActivityTaskCompletedResponse\"o\130\211\228\147\STXi\"+/namespaces/{namespace}/activities/complete:\SOH*Z7\"2/api/v1/namespaces/{namespace}/activities/complete:\SOH*\DC2\180\STX\n\
      \ RespondActivityTaskCompletedById\DC2H.temporal.api.workflowservice.v1.RespondActivityTaskCompletedByIdRequest\SUBI.temporal.api.workflowservice.v1.RespondActivityTaskCompletedByIdResponse\"{\130\211\228\147\STXu\"1/namespaces/{namespace}/activities/complete-by-id:\SOH*Z=\"8/api/v1/namespaces/{namespace}/activities/complete-by-id:\SOH*\DC2\139\STX\n\
      \\EMRespondActivityTaskFailed\DC2A.temporal.api.workflowservice.v1.RespondActivityTaskFailedRequest\SUBB.temporal.api.workflowservice.v1.RespondActivityTaskFailedResponse\"g\130\211\228\147\STXa\"'/namespaces/{namespace}/activities/fail:\SOH*Z3\"./api/v1/namespaces/{namespace}/activities/fail:\SOH*\DC2\163\STX\n\
      \\GSRespondActivityTaskFailedById\DC2E.temporal.api.workflowservice.v1.RespondActivityTaskFailedByIdRequest\SUBF.temporal.api.workflowservice.v1.RespondActivityTaskFailedByIdResponse\"s\130\211\228\147\STXm\"-/namespaces/{namespace}/activities/fail-by-id:\SOH*Z9\"4/api/v1/namespaces/{namespace}/activities/fail-by-id:\SOH*\DC2\149\STX\n\
      \\ESCRespondActivityTaskCanceled\DC2C.temporal.api.workflowservice.v1.RespondActivityTaskCanceledRequest\SUBD.temporal.api.workflowservice.v1.RespondActivityTaskCanceledResponse\"k\130\211\228\147\STXe\")/namespaces/{namespace}/activities/cancel:\SOH*Z5\"0/api/v1/namespaces/{namespace}/activities/cancel:\SOH*\DC2\173\STX\n\
      \\USRespondActivityTaskCanceledById\DC2G.temporal.api.workflowservice.v1.RespondActivityTaskCanceledByIdRequest\SUBH.temporal.api.workflowservice.v1.RespondActivityTaskCanceledByIdResponse\"w\130\211\228\147\STXq\"//namespaces/{namespace}/activities/cancel-by-id:\SOH*Z;\"6/api/v1/namespaces/{namespace}/activities/cancel-by-id:\SOH*\DC2\224\STX\n\
      \\RSRequestCancelWorkflowExecution\DC2F.temporal.api.workflowservice.v1.RequestCancelWorkflowExecutionRequest\SUBG.temporal.api.workflowservice.v1.RequestCancelWorkflowExecutionResponse\"\172\SOH\130\211\228\147\STX\165\SOH\"I/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/cancel:\SOH*ZU\"P/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/cancel:\SOH*\DC2\231\STX\n\
      \\ETBSignalWorkflowExecution\DC2?.temporal.api.workflowservice.v1.SignalWorkflowExecutionRequest\SUB@.temporal.api.workflowservice.v1.SignalWorkflowExecutionResponse\"\200\SOH\130\211\228\147\STX\193\SOH\"W/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/signal/{signal_name}:\SOH*Zc\"^/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/signal/{signal_name}:\SOH*\DC2\242\STX\n\
      \ SignalWithStartWorkflowExecution\DC2H.temporal.api.workflowservice.v1.SignalWithStartWorkflowExecutionRequest\SUBI.temporal.api.workflowservice.v1.SignalWithStartWorkflowExecutionResponse\"\184\SOH\130\211\228\147\STX\177\SOH\"O/namespaces/{namespace}/workflows/{workflow_id}/signal-with-start/{signal_name}:\SOH*Z[\"V/api/v1/namespaces/{namespace}/workflows/{workflow_id}/signal-with-start/{signal_name}:\SOH*\DC2\198\STX\n\
      \\SYNResetWorkflowExecution\DC2>.temporal.api.workflowservice.v1.ResetWorkflowExecutionRequest\SUB?.temporal.api.workflowservice.v1.ResetWorkflowExecutionResponse\"\170\SOH\130\211\228\147\STX\163\SOH\"H/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/reset:\SOH*ZT\"O/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/reset:\SOH*\DC2\218\STX\n\
      \\SUBTerminateWorkflowExecution\DC2B.temporal.api.workflowservice.v1.TerminateWorkflowExecutionRequest\SUBC.temporal.api.workflowservice.v1.TerminateWorkflowExecutionResponse\"\178\SOH\130\211\228\147\STX\171\SOH\"L/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/terminate:\SOH*ZX\"S/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/terminate:\SOH*\DC2\158\SOH\n\
      \\ETBDeleteWorkflowExecution\DC2?.temporal.api.workflowservice.v1.DeleteWorkflowExecutionRequest\SUB@.temporal.api.workflowservice.v1.DeleteWorkflowExecutionResponse\"\NUL\DC2\167\SOH\n\
      \\SUBListOpenWorkflowExecutions\DC2B.temporal.api.workflowservice.v1.ListOpenWorkflowExecutionsRequest\SUBC.temporal.api.workflowservice.v1.ListOpenWorkflowExecutionsResponse\"\NUL\DC2\173\SOH\n\
      \\FSListClosedWorkflowExecutions\DC2D.temporal.api.workflowservice.v1.ListClosedWorkflowExecutionsRequest\SUBE.temporal.api.workflowservice.v1.ListClosedWorkflowExecutionsResponse\"\NUL\DC2\240\SOH\n\
      \\SYNListWorkflowExecutions\DC2>.temporal.api.workflowservice.v1.ListWorkflowExecutionsRequest\SUB?.temporal.api.workflowservice.v1.ListWorkflowExecutionsResponse\"U\130\211\228\147\STXO\DC2!/namespaces/{namespace}/workflowsZ*\DC2(/api/v1/namespaces/{namespace}/workflows\DC2\154\STX\n\
      \\RSListArchivedWorkflowExecutions\DC2F.temporal.api.workflowservice.v1.ListArchivedWorkflowExecutionsRequest\SUBG.temporal.api.workflowservice.v1.ListArchivedWorkflowExecutionsResponse\"g\130\211\228\147\STXa\DC2*/namespaces/{namespace}/archived-workflowsZ3\DC21/api/v1/namespaces/{namespace}/archived-workflows\DC2\155\SOH\n\
      \\SYNScanWorkflowExecutions\DC2>.temporal.api.workflowservice.v1.ScanWorkflowExecutionsRequest\SUB?.temporal.api.workflowservice.v1.ScanWorkflowExecutionsResponse\"\NUL\DC2\253\SOH\n\
      \\ETBCountWorkflowExecutions\DC2?.temporal.api.workflowservice.v1.CountWorkflowExecutionsRequest\SUB@.temporal.api.workflowservice.v1.CountWorkflowExecutionsResponse\"_\130\211\228\147\STXY\DC2&/namespaces/{namespace}/workflow-countZ/\DC2-/api/v1/namespaces/{namespace}/workflow-count\DC2\146\SOH\n\
      \\DC3GetSearchAttributes\DC2;.temporal.api.workflowservice.v1.GetSearchAttributesRequest\SUB<.temporal.api.workflowservice.v1.GetSearchAttributesResponse\"\NUL\DC2\164\SOH\n\
      \\EMRespondQueryTaskCompleted\DC2A.temporal.api.workflowservice.v1.RespondQueryTaskCompletedRequest\SUBB.temporal.api.workflowservice.v1.RespondQueryTaskCompletedResponse\"\NUL\DC2\149\SOH\n\
      \\DC4ResetStickyTaskQueue\DC2<.temporal.api.workflowservice.v1.ResetStickyTaskQueueRequest\SUB=.temporal.api.workflowservice.v1.ResetStickyTaskQueueResponse\"\NUL\DC2\131\SOH\n\
      \\SOShutdownWorker\DC26.temporal.api.workflowservice.v1.ShutdownWorkerRequest\SUB7.temporal.api.workflowservice.v1.ShutdownWorkerResponse\"\NUL\DC2\191\STX\n\
      \\rQueryWorkflow\DC25.temporal.api.workflowservice.v1.QueryWorkflowRequest\SUB6.temporal.api.workflowservice.v1.QueryWorkflowResponse\"\190\SOH\130\211\228\147\STX\183\SOH\"R/namespaces/{namespace}/workflows/{execution.workflow_id}/query/{query.query_type}:\SOH*Z^\"Y/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}/query/{query.query_type}:\SOH*\DC2\170\STX\n\
      \\EMDescribeWorkflowExecution\DC2A.temporal.api.workflowservice.v1.DescribeWorkflowExecutionRequest\SUBB.temporal.api.workflowservice.v1.DescribeWorkflowExecutionResponse\"\133\SOH\130\211\228\147\STX\DEL\DC29/namespaces/{namespace}/workflows/{execution.workflow_id}ZB\DC2@/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}\DC2\137\STX\n\
      \\DC1DescribeTaskQueue\DC29.temporal.api.workflowservice.v1.DescribeTaskQueueRequest\SUB:.temporal.api.workflowservice.v1.DescribeTaskQueueResponse\"}\130\211\228\147\STXw\DC25/namespaces/{namespace}/task-queues/{task_queue.name}Z>\DC2</api/v1/namespaces/{namespace}/task-queues/{task_queue.name}\DC2\171\SOH\n\
      \\SOGetClusterInfo\DC26.temporal.api.workflowservice.v1.GetClusterInfoRequest\SUB7.temporal.api.workflowservice.v1.GetClusterInfoResponse\"(\130\211\228\147\STX\"\DC2\b/clusterZ\SYN\DC2\DC4/api/v1/cluster-info\DC2\171\SOH\n\
      \\rGetSystemInfo\DC25.temporal.api.workflowservice.v1.GetSystemInfoRequest\SUB6.temporal.api.workflowservice.v1.GetSystemInfoResponse\"+\130\211\228\147\STX%\DC2\f/system-infoZ\NAK\DC2\DC3/api/v1/system-info\DC2\158\SOH\n\
      \\ETBListTaskQueuePartitions\DC2?.temporal.api.workflowservice.v1.ListTaskQueuePartitionsRequest\SUB@.temporal.api.workflowservice.v1.ListTaskQueuePartitionsResponse\"\NUL\DC2\250\SOH\n\
      \\SOCreateSchedule\DC26.temporal.api.workflowservice.v1.CreateScheduleRequest\SUB7.temporal.api.workflowservice.v1.CreateScheduleResponse\"w\130\211\228\147\STXq\"//namespaces/{namespace}/schedules/{schedule_id}:\SOH*Z;\"6/api/v1/namespaces/{namespace}/schedules/{schedule_id}:\SOH*\DC2\250\SOH\n\
      \\DLEDescribeSchedule\DC28.temporal.api.workflowservice.v1.DescribeScheduleRequest\SUB9.temporal.api.workflowservice.v1.DescribeScheduleResponse\"q\130\211\228\147\STXk\DC2//namespaces/{namespace}/schedules/{schedule_id}Z8\DC26/api/v1/namespaces/{namespace}/schedules/{schedule_id}\DC2\137\STX\n\
      \\SOUpdateSchedule\DC26.temporal.api.workflowservice.v1.UpdateScheduleRequest\SUB7.temporal.api.workflowservice.v1.UpdateScheduleResponse\"\133\SOH\130\211\228\147\STX\DEL\"6/namespaces/{namespace}/schedules/{schedule_id}/update:\SOH*ZB\"=/api/v1/namespaces/{namespace}/schedules/{schedule_id}/update:\SOH*\DC2\132\STX\n\
      \\rPatchSchedule\DC25.temporal.api.workflowservice.v1.PatchScheduleRequest\SUB6.temporal.api.workflowservice.v1.PatchScheduleResponse\"\131\SOH\130\211\228\147\STX}\"5/namespaces/{namespace}/schedules/{schedule_id}/patch:\SOH*ZA\"</api/v1/namespaces/{namespace}/schedules/{schedule_id}/patch:\SOH*\DC2\181\STX\n\
      \\EMListScheduleMatchingTimes\DC2A.temporal.api.workflowservice.v1.ListScheduleMatchingTimesRequest\SUBB.temporal.api.workflowservice.v1.ListScheduleMatchingTimesResponse\"\144\SOH\130\211\228\147\STX\137\SOH\DC2>/namespaces/{namespace}/schedules/{schedule_id}/matching-timesZG\DC2E/api/v1/namespaces/{namespace}/schedules/{schedule_id}/matching-times\DC2\244\SOH\n\
      \\SODeleteSchedule\DC26.temporal.api.workflowservice.v1.DeleteScheduleRequest\SUB7.temporal.api.workflowservice.v1.DeleteScheduleResponse\"q\130\211\228\147\STXk*//namespaces/{namespace}/schedules/{schedule_id}Z8*6/api/v1/namespaces/{namespace}/schedules/{schedule_id}\DC2\213\SOH\n\
      \\rListSchedules\DC25.temporal.api.workflowservice.v1.ListSchedulesRequest\SUB6.temporal.api.workflowservice.v1.ListSchedulesResponse\"U\130\211\228\147\STXO\DC2!/namespaces/{namespace}/schedulesZ*\DC2(/api/v1/namespaces/{namespace}/schedules\DC2\185\SOH\n\
      \ UpdateWorkerBuildIdCompatibility\DC2H.temporal.api.workflowservice.v1.UpdateWorkerBuildIdCompatibilityRequest\SUBI.temporal.api.workflowservice.v1.UpdateWorkerBuildIdCompatibilityResponse\"\NUL\DC2\225\STX\n\
      \\GSGetWorkerBuildIdCompatibility\DC2E.temporal.api.workflowservice.v1.GetWorkerBuildIdCompatibilityRequest\SUBF.temporal.api.workflowservice.v1.GetWorkerBuildIdCompatibilityResponse\"\176\SOH\130\211\228\147\STX\169\SOH\DC2N/namespaces/{namespace}/task-queues/{task_queue}/worker-build-id-compatibilityZW\DC2U/api/v1/namespaces/{namespace}/task-queues/{task_queue}/worker-build-id-compatibility\DC2\170\SOH\n\
      \\ESCUpdateWorkerVersioningRules\DC2C.temporal.api.workflowservice.v1.UpdateWorkerVersioningRulesRequest\SUBD.temporal.api.workflowservice.v1.UpdateWorkerVersioningRulesResponse\"\NUL\DC2\198\STX\n\
      \\CANGetWorkerVersioningRules\DC2@.temporal.api.workflowservice.v1.GetWorkerVersioningRulesRequest\SUBA.temporal.api.workflowservice.v1.GetWorkerVersioningRulesResponse\"\164\SOH\130\211\228\147\STX\157\SOH\DC2H/namespaces/{namespace}/task-queues/{task_queue}/worker-versioning-rulesZQ\DC2O/api/v1/namespaces/{namespace}/task-queues/{task_queue}/worker-versioning-rules\DC2\151\STX\n\
      \\EMGetWorkerTaskReachability\DC2A.temporal.api.workflowservice.v1.GetWorkerTaskReachabilityRequest\SUBB.temporal.api.workflowservice.v1.GetWorkerTaskReachabilityResponse\"s\130\211\228\147\STXm\DC20/namespaces/{namespace}/worker-task-reachabilityZ9\DC27/api/v1/namespaces/{namespace}/worker-task-reachability\DC2\200\STX\n\
      \\DC2DescribeDeployment\DC2:.temporal.api.workflowservice.v1.DescribeDeploymentRequest\SUB;.temporal.api.workflowservice.v1.DescribeDeploymentResponse\"\184\SOH\130\211\228\147\STX\177\SOH\DC2R/namespaces/{namespace}/deployments/{deployment.series_name}/{deployment.build_id}Z[\DC2Y/api/v1/namespaces/{namespace}/deployments/{deployment.series_name}/{deployment.build_id}\DC2\181\ETX\n\
      \\USDescribeWorkerDeploymentVersion\DC2G.temporal.api.workflowservice.v1.DescribeWorkerDeploymentVersionRequest\SUBH.temporal.api.workflowservice.v1.DescribeWorkerDeploymentVersionResponse\"\254\SOH\130\211\228\147\STX\247\SOH\DC2u/namespaces/{namespace}/worker-deployment-versions/{deployment_version.deployment_name}/{deployment_version.build_id}Z~\DC2|/api/v1/namespaces/{namespace}/worker-deployment-versions/{deployment_version.deployment_name}/{deployment_version.build_id}\DC2\223\SOH\n\
      \\SIListDeployments\DC27.temporal.api.workflowservice.v1.ListDeploymentsRequest\SUB8.temporal.api.workflowservice.v1.ListDeploymentsResponse\"Y\130\211\228\147\STXS\DC2#/namespaces/{namespace}/deploymentsZ,\DC2*/api/v1/namespaces/{namespace}/deployments\DC2\247\STX\n\
      \\EMGetDeploymentReachability\DC2A.temporal.api.workflowservice.v1.GetDeploymentReachabilityRequest\SUBB.temporal.api.workflowservice.v1.GetDeploymentReachabilityResponse\"\210\SOH\130\211\228\147\STX\203\SOH\DC2_/namespaces/{namespace}/deployments/{deployment.series_name}/{deployment.build_id}/reachabilityZh\DC2f/api/v1/namespaces/{namespace}/deployments/{deployment.series_name}/{deployment.build_id}/reachability\DC2\153\STX\n\
      \\DC4GetCurrentDeployment\DC2<.temporal.api.workflowservice.v1.GetCurrentDeploymentRequest\SUB=.temporal.api.workflowservice.v1.GetCurrentDeploymentResponse\"\131\SOH\130\211\228\147\STX}\DC28/namespaces/{namespace}/current-deployment/{series_name}ZA\DC2?/api/v1/namespaces/{namespace}/current-deployment/{series_name}\DC2\182\STX\n\
      \\DC4SetCurrentDeployment\DC2<.temporal.api.workflowservice.v1.SetCurrentDeploymentRequest\SUB=.temporal.api.workflowservice.v1.SetCurrentDeploymentResponse\"\160\SOH\130\211\228\147\STX\153\SOH\"C/namespaces/{namespace}/current-deployment/{deployment.series_name}:\SOH*ZO\"J/api/v1/namespaces/{namespace}/current-deployment/{deployment.series_name}:\SOH*\DC2\247\STX\n\
      \!SetWorkerDeploymentCurrentVersion\DC2I.temporal.api.workflowservice.v1.SetWorkerDeploymentCurrentVersionRequest\SUBJ.temporal.api.workflowservice.v1.SetWorkerDeploymentCurrentVersionResponse\"\186\SOH\130\211\228\147\STX\179\SOH\"P/namespaces/{namespace}/worker-deployments/{deployment_name}/set-current-version:\SOH*Z\\\"W/api/v1/namespaces/{namespace}/worker-deployments/{deployment_name}/set-current-version:\SOH*\DC2\174\STX\n\
      \\CANDescribeWorkerDeployment\DC2@.temporal.api.workflowservice.v1.DescribeWorkerDeploymentRequest\SUBA.temporal.api.workflowservice.v1.DescribeWorkerDeploymentResponse\"\140\SOH\130\211\228\147\STX\133\SOH\DC2</namespaces/{namespace}/worker-deployments/{deployment_name}ZE\DC2C/api/v1/namespaces/{namespace}/worker-deployments/{deployment_name}\DC2\168\STX\n\
      \\SYNDeleteWorkerDeployment\DC2>.temporal.api.workflowservice.v1.DeleteWorkerDeploymentRequest\SUB?.temporal.api.workflowservice.v1.DeleteWorkerDeploymentResponse\"\140\SOH\130\211\228\147\STX\133\SOH*</namespaces/{namespace}/worker-deployments/{deployment_name}ZE*C/api/v1/namespaces/{namespace}/worker-deployments/{deployment_name}\DC2\175\ETX\n\
      \\GSDeleteWorkerDeploymentVersion\DC2E.temporal.api.workflowservice.v1.DeleteWorkerDeploymentVersionRequest\SUBF.temporal.api.workflowservice.v1.DeleteWorkerDeploymentVersionResponse\"\254\SOH\130\211\228\147\STX\247\SOH*u/namespaces/{namespace}/worker-deployment-versions/{deployment_version.deployment_name}/{deployment_version.build_id}Z~*|/api/v1/namespaces/{namespace}/worker-deployment-versions/{deployment_version.deployment_name}/{deployment_version.build_id}\DC2\247\STX\n\
      \!SetWorkerDeploymentRampingVersion\DC2I.temporal.api.workflowservice.v1.SetWorkerDeploymentRampingVersionRequest\SUBJ.temporal.api.workflowservice.v1.SetWorkerDeploymentRampingVersionResponse\"\186\SOH\130\211\228\147\STX\179\SOH\"P/namespaces/{namespace}/worker-deployments/{deployment_name}/set-ramping-version:\SOH*Z\\\"W/api/v1/namespaces/{namespace}/worker-deployments/{deployment_name}/set-ramping-version:\SOH*\DC2\255\SOH\n\
      \\NAKListWorkerDeployments\DC2=.temporal.api.workflowservice.v1.ListWorkerDeploymentsRequest\SUB>.temporal.api.workflowservice.v1.ListWorkerDeploymentsResponse\"g\130\211\228\147\STXa\DC2*/namespaces/{namespace}/worker-deploymentsZ3\DC21/api/v1/namespaces/{namespace}/worker-deployments\DC2\240\ETX\n\
      \%UpdateWorkerDeploymentVersionMetadata\DC2M.temporal.api.workflowservice.v1.UpdateWorkerDeploymentVersionMetadataRequest\SUBN.temporal.api.workflowservice.v1.UpdateWorkerDeploymentVersionMetadataResponse\"\167\STX\130\211\228\147\STX\160\STX\"\133\SOH/namespaces/{namespace}/worker-deployment-versions/{deployment_version.deployment_name}/{deployment_version.build_id}/update-metadata:\SOH*Z\146\SOH\"\140\SOH/api/v1/namespaces/{namespace}/worker-deployment-versions/{deployment_version.deployment_name}/{deployment_version.build_id}/update-metadata:\SOH*\DC2\245\STX\n\
      \\ETBUpdateWorkflowExecution\DC2?.temporal.api.workflowservice.v1.UpdateWorkflowExecutionRequest\SUB@.temporal.api.workflowservice.v1.UpdateWorkflowExecutionResponse\"\214\SOH\130\211\228\147\STX\207\SOH\"^/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/update/{request.input.name}:\SOH*Zj\"e/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/update/{request.input.name}:\SOH*\DC2\170\SOH\n\
      \\ESCPollWorkflowExecutionUpdate\DC2C.temporal.api.workflowservice.v1.PollWorkflowExecutionUpdateRequest\SUBD.temporal.api.workflowservice.v1.PollWorkflowExecutionUpdateResponse\"\NUL\DC2\141\STX\n\
      \\DC3StartBatchOperation\DC2;.temporal.api.workflowservice.v1.StartBatchOperationRequest\SUB<.temporal.api.workflowservice.v1.StartBatchOperationResponse\"{\130\211\228\147\STXu\"1/namespaces/{namespace}/batch-operations/{job_id}:\SOH*Z=\"8/api/v1/namespaces/{namespace}/batch-operations/{job_id}:\SOH*\DC2\149\STX\n\
      \\DC2StopBatchOperation\DC2:.temporal.api.workflowservice.v1.StopBatchOperationRequest\SUB;.temporal.api.workflowservice.v1.StopBatchOperationResponse\"\133\SOH\130\211\228\147\STX\DEL\"6/namespaces/{namespace}/batch-operations/{job_id}/stop:\SOH*ZB\"=/api/v1/namespaces/{namespace}/batch-operations/{job_id}/stop:\SOH*\DC2\144\STX\n\
      \\SYNDescribeBatchOperation\DC2>.temporal.api.workflowservice.v1.DescribeBatchOperationRequest\SUB?.temporal.api.workflowservice.v1.DescribeBatchOperationResponse\"u\130\211\228\147\STXo\DC21/namespaces/{namespace}/batch-operations/{job_id}Z:\DC28/api/v1/namespaces/{namespace}/batch-operations/{job_id}\DC2\245\SOH\n\
      \\DC3ListBatchOperations\DC2;.temporal.api.workflowservice.v1.ListBatchOperationsRequest\SUB<.temporal.api.workflowservice.v1.ListBatchOperationsResponse\"c\130\211\228\147\STX]\DC2(/namespaces/{namespace}/batch-operationsZ1\DC2//api/v1/namespaces/{namespace}/batch-operations\DC2\143\SOH\n\
      \\DC2PollNexusTaskQueue\DC2:.temporal.api.workflowservice.v1.PollNexusTaskQueueRequest\SUB;.temporal.api.workflowservice.v1.PollNexusTaskQueueResponse\"\NUL\DC2\164\SOH\n\
      \\EMRespondNexusTaskCompleted\DC2A.temporal.api.workflowservice.v1.RespondNexusTaskCompletedRequest\SUBB.temporal.api.workflowservice.v1.RespondNexusTaskCompletedResponse\"\NUL\DC2\155\SOH\n\
      \\SYNRespondNexusTaskFailed\DC2>.temporal.api.workflowservice.v1.RespondNexusTaskFailedRequest\SUB?.temporal.api.workflowservice.v1.RespondNexusTaskFailedResponse\"\NUL\DC2\147\STX\n\
      \\NAKUpdateActivityOptions\DC2=.temporal.api.workflowservice.v1.UpdateActivityOptionsRequest\SUB>.temporal.api.workflowservice.v1.UpdateActivityOptionsResponse\"{\130\211\228\147\STXu\"1/namespaces/{namespace}/activities/update-options:\SOH*Z=\"8/api/v1/namespaces/{namespace}/activities/update-options:\SOH*\DC2\240\STX\n\
      \\RSUpdateWorkflowExecutionOptions\DC2F.temporal.api.workflowservice.v1.UpdateWorkflowExecutionOptionsRequest\SUBG.temporal.api.workflowservice.v1.UpdateWorkflowExecutionOptionsResponse\"\188\SOH\130\211\228\147\STX\181\SOH\"Q/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/update-options:\SOH*Z]\"X/api/v1/namespaces/{namespace}/workflows/{workflow_execution.workflow_id}/update-options:\SOH*\DC2\233\SOH\n\
      \\rPauseActivity\DC25.temporal.api.workflowservice.v1.PauseActivityRequest\SUB6.temporal.api.workflowservice.v1.PauseActivityResponse\"i\130\211\228\147\STXc\"(/namespaces/{namespace}/activities/pause:\SOH*Z4\"//api/v1/namespaces/{namespace}/activities/pause:\SOH*\DC2\243\SOH\n\
      \\SIUnpauseActivity\DC27.temporal.api.workflowservice.v1.UnpauseActivityRequest\SUB8.temporal.api.workflowservice.v1.UnpauseActivityResponse\"m\130\211\228\147\STXg\"*/namespaces/{namespace}/activities/unpause:\SOH*Z6\"1/api/v1/namespaces/{namespace}/activities/unpause:\SOH*\DC2\233\SOH\n\
      \\rResetActivity\DC25.temporal.api.workflowservice.v1.ResetActivityRequest\SUB6.temporal.api.workflowservice.v1.ResetActivityResponse\"i\130\211\228\147\STXc\"(/namespaces/{namespace}/activities/reset:\SOH*Z4\"//api/v1/namespaces/{namespace}/activities/reset:\SOH*\DC2\244\SOH\n\
      \\DC2CreateWorkflowRule\DC2:.temporal.api.workflowservice.v1.CreateWorkflowRuleRequest\SUB;.temporal.api.workflowservice.v1.CreateWorkflowRuleResponse\"e\130\211\228\147\STX_\"&/namespaces/{namespace}/workflow-rules:\SOH*Z2\"-/api/v1/namespaces/{namespace}/workflow-rules:\SOH*\DC2\136\STX\n\
      \\DC4DescribeWorkflowRule\DC2<.temporal.api.workflowservice.v1.DescribeWorkflowRuleRequest\SUB=.temporal.api.workflowservice.v1.DescribeWorkflowRuleResponse\"s\130\211\228\147\STXm\DC20/namespaces/{namespace}/workflow-rules/{rule_id}Z9\DC27/api/v1/namespaces/{namespace}/workflow-rules/{rule_id}\DC2\130\STX\n\
      \\DC2DeleteWorkflowRule\DC2:.temporal.api.workflowservice.v1.DeleteWorkflowRuleRequest\SUB;.temporal.api.workflowservice.v1.DeleteWorkflowRuleResponse\"s\130\211\228\147\STXm*0/namespaces/{namespace}/workflow-rules/{rule_id}Z9*7/api/v1/namespaces/{namespace}/workflow-rules/{rule_id}\DC2\235\SOH\n\
      \\DC1ListWorkflowRules\DC29.temporal.api.workflowservice.v1.ListWorkflowRulesRequest\SUB:.temporal.api.workflowservice.v1.ListWorkflowRulesResponse\"_\130\211\228\147\STXY\DC2&/namespaces/{namespace}/workflow-rulesZ/\DC2-/api/v1/namespaces/{namespace}/workflow-rules\DC2\185\STX\n\
      \\DC3TriggerWorkflowRule\DC2;.temporal.api.workflowservice.v1.TriggerWorkflowRuleRequest\SUB<.temporal.api.workflowservice.v1.TriggerWorkflowRuleResponse\"\166\SOH\130\211\228\147\STX\159\SOH\"F/namespaces/{namespace}/workflows/{execution.workflow_id}/trigger-rule:\SOH*ZR\"M/api/v1/namespaces/{namespace}/workflows/{execution.workflow_id}/trigger-rule:\SOH*\DC2\131\STX\n\
      \\NAKRecordWorkerHeartbeat\DC2=.temporal.api.workflowservice.v1.RecordWorkerHeartbeatRequest\SUB>.temporal.api.workflowservice.v1.RecordWorkerHeartbeatResponse\"k\130\211\228\147\STXe\")/namespaces/{namespace}/workers/heartbeat:\SOH*Z5\"0/api/v1/namespaces/{namespace}/workers/heartbeat:\SOH*\DC2\203\SOH\n\
      \\vListWorkers\DC23.temporal.api.workflowservice.v1.ListWorkersRequest\SUB4.temporal.api.workflowservice.v1.ListWorkersResponse\"Q\130\211\228\147\STXK\DC2\US/namespaces/{namespace}/workersZ(\DC2&/api/v1/namespaces/{namespace}/workers"
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
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "shutdownWorker" where
  type MethodName WorkflowService "shutdownWorker" = "ShutdownWorker"
  type MethodInput WorkflowService "shutdownWorker" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ShutdownWorkerRequest
  type MethodOutput WorkflowService "shutdownWorker" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ShutdownWorkerResponse
  type MethodStreamingType WorkflowService "shutdownWorker" = 'Data.ProtoLens.Service.Types.NonStreaming
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
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeDeployment" where
  type MethodName WorkflowService "describeDeployment" = "DescribeDeployment"
  type MethodInput WorkflowService "describeDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeDeploymentRequest
  type MethodOutput WorkflowService "describeDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeDeploymentResponse
  type MethodStreamingType WorkflowService "describeDeployment" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeWorkerDeploymentVersion" where
  type MethodName WorkflowService "describeWorkerDeploymentVersion" = "DescribeWorkerDeploymentVersion"
  type MethodInput WorkflowService "describeWorkerDeploymentVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkerDeploymentVersionRequest
  type MethodOutput WorkflowService "describeWorkerDeploymentVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkerDeploymentVersionResponse
  type MethodStreamingType WorkflowService "describeWorkerDeploymentVersion" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listDeployments" where
  type MethodName WorkflowService "listDeployments" = "ListDeployments"
  type MethodInput WorkflowService "listDeployments" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListDeploymentsRequest
  type MethodOutput WorkflowService "listDeployments" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListDeploymentsResponse
  type MethodStreamingType WorkflowService "listDeployments" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getDeploymentReachability" where
  type MethodName WorkflowService "getDeploymentReachability" = "GetDeploymentReachability"
  type MethodInput WorkflowService "getDeploymentReachability" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetDeploymentReachabilityRequest
  type MethodOutput WorkflowService "getDeploymentReachability" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetDeploymentReachabilityResponse
  type MethodStreamingType WorkflowService "getDeploymentReachability" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "getCurrentDeployment" where
  type MethodName WorkflowService "getCurrentDeployment" = "GetCurrentDeployment"
  type MethodInput WorkflowService "getCurrentDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetCurrentDeploymentRequest
  type MethodOutput WorkflowService "getCurrentDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.GetCurrentDeploymentResponse
  type MethodStreamingType WorkflowService "getCurrentDeployment" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "setCurrentDeployment" where
  type MethodName WorkflowService "setCurrentDeployment" = "SetCurrentDeployment"
  type MethodInput WorkflowService "setCurrentDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SetCurrentDeploymentRequest
  type MethodOutput WorkflowService "setCurrentDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SetCurrentDeploymentResponse
  type MethodStreamingType WorkflowService "setCurrentDeployment" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "setWorkerDeploymentCurrentVersion" where
  type MethodName WorkflowService "setWorkerDeploymentCurrentVersion" = "SetWorkerDeploymentCurrentVersion"
  type MethodInput WorkflowService "setWorkerDeploymentCurrentVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SetWorkerDeploymentCurrentVersionRequest
  type MethodOutput WorkflowService "setWorkerDeploymentCurrentVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SetWorkerDeploymentCurrentVersionResponse
  type MethodStreamingType WorkflowService "setWorkerDeploymentCurrentVersion" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeWorkerDeployment" where
  type MethodName WorkflowService "describeWorkerDeployment" = "DescribeWorkerDeployment"
  type MethodInput WorkflowService "describeWorkerDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkerDeploymentRequest
  type MethodOutput WorkflowService "describeWorkerDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkerDeploymentResponse
  type MethodStreamingType WorkflowService "describeWorkerDeployment" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "deleteWorkerDeployment" where
  type MethodName WorkflowService "deleteWorkerDeployment" = "DeleteWorkerDeployment"
  type MethodInput WorkflowService "deleteWorkerDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkerDeploymentRequest
  type MethodOutput WorkflowService "deleteWorkerDeployment" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkerDeploymentResponse
  type MethodStreamingType WorkflowService "deleteWorkerDeployment" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "deleteWorkerDeploymentVersion" where
  type MethodName WorkflowService "deleteWorkerDeploymentVersion" = "DeleteWorkerDeploymentVersion"
  type MethodInput WorkflowService "deleteWorkerDeploymentVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkerDeploymentVersionRequest
  type MethodOutput WorkflowService "deleteWorkerDeploymentVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkerDeploymentVersionResponse
  type MethodStreamingType WorkflowService "deleteWorkerDeploymentVersion" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "setWorkerDeploymentRampingVersion" where
  type MethodName WorkflowService "setWorkerDeploymentRampingVersion" = "SetWorkerDeploymentRampingVersion"
  type MethodInput WorkflowService "setWorkerDeploymentRampingVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SetWorkerDeploymentRampingVersionRequest
  type MethodOutput WorkflowService "setWorkerDeploymentRampingVersion" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.SetWorkerDeploymentRampingVersionResponse
  type MethodStreamingType WorkflowService "setWorkerDeploymentRampingVersion" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listWorkerDeployments" where
  type MethodName WorkflowService "listWorkerDeployments" = "ListWorkerDeployments"
  type MethodInput WorkflowService "listWorkerDeployments" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkerDeploymentsRequest
  type MethodOutput WorkflowService "listWorkerDeployments" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkerDeploymentsResponse
  type MethodStreamingType WorkflowService "listWorkerDeployments" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateWorkerDeploymentVersionMetadata" where
  type MethodName WorkflowService "updateWorkerDeploymentVersionMetadata" = "UpdateWorkerDeploymentVersionMetadata"
  type MethodInput WorkflowService "updateWorkerDeploymentVersionMetadata" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkerDeploymentVersionMetadataRequest
  type MethodOutput WorkflowService "updateWorkerDeploymentVersionMetadata" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkerDeploymentVersionMetadataResponse
  type MethodStreamingType WorkflowService "updateWorkerDeploymentVersionMetadata" = 'Data.ProtoLens.Service.Types.NonStreaming
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
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateActivityOptions" where
  type MethodName WorkflowService "updateActivityOptions" = "UpdateActivityOptions"
  type MethodInput WorkflowService "updateActivityOptions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateActivityOptionsRequest
  type MethodOutput WorkflowService "updateActivityOptions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateActivityOptionsResponse
  type MethodStreamingType WorkflowService "updateActivityOptions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "updateWorkflowExecutionOptions" where
  type MethodName WorkflowService "updateWorkflowExecutionOptions" = "UpdateWorkflowExecutionOptions"
  type MethodInput WorkflowService "updateWorkflowExecutionOptions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkflowExecutionOptionsRequest
  type MethodOutput WorkflowService "updateWorkflowExecutionOptions" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UpdateWorkflowExecutionOptionsResponse
  type MethodStreamingType WorkflowService "updateWorkflowExecutionOptions" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "pauseActivity" where
  type MethodName WorkflowService "pauseActivity" = "PauseActivity"
  type MethodInput WorkflowService "pauseActivity" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PauseActivityRequest
  type MethodOutput WorkflowService "pauseActivity" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.PauseActivityResponse
  type MethodStreamingType WorkflowService "pauseActivity" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "unpauseActivity" where
  type MethodName WorkflowService "unpauseActivity" = "UnpauseActivity"
  type MethodInput WorkflowService "unpauseActivity" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UnpauseActivityRequest
  type MethodOutput WorkflowService "unpauseActivity" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.UnpauseActivityResponse
  type MethodStreamingType WorkflowService "unpauseActivity" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "resetActivity" where
  type MethodName WorkflowService "resetActivity" = "ResetActivity"
  type MethodInput WorkflowService "resetActivity" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ResetActivityRequest
  type MethodOutput WorkflowService "resetActivity" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ResetActivityResponse
  type MethodStreamingType WorkflowService "resetActivity" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "createWorkflowRule" where
  type MethodName WorkflowService "createWorkflowRule" = "CreateWorkflowRule"
  type MethodInput WorkflowService "createWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.CreateWorkflowRuleRequest
  type MethodOutput WorkflowService "createWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.CreateWorkflowRuleResponse
  type MethodStreamingType WorkflowService "createWorkflowRule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "describeWorkflowRule" where
  type MethodName WorkflowService "describeWorkflowRule" = "DescribeWorkflowRule"
  type MethodInput WorkflowService "describeWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkflowRuleRequest
  type MethodOutput WorkflowService "describeWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DescribeWorkflowRuleResponse
  type MethodStreamingType WorkflowService "describeWorkflowRule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "deleteWorkflowRule" where
  type MethodName WorkflowService "deleteWorkflowRule" = "DeleteWorkflowRule"
  type MethodInput WorkflowService "deleteWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkflowRuleRequest
  type MethodOutput WorkflowService "deleteWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.DeleteWorkflowRuleResponse
  type MethodStreamingType WorkflowService "deleteWorkflowRule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listWorkflowRules" where
  type MethodName WorkflowService "listWorkflowRules" = "ListWorkflowRules"
  type MethodInput WorkflowService "listWorkflowRules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkflowRulesRequest
  type MethodOutput WorkflowService "listWorkflowRules" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkflowRulesResponse
  type MethodStreamingType WorkflowService "listWorkflowRules" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "triggerWorkflowRule" where
  type MethodName WorkflowService "triggerWorkflowRule" = "TriggerWorkflowRule"
  type MethodInput WorkflowService "triggerWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.TriggerWorkflowRuleRequest
  type MethodOutput WorkflowService "triggerWorkflowRule" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.TriggerWorkflowRuleResponse
  type MethodStreamingType WorkflowService "triggerWorkflowRule" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "recordWorkerHeartbeat" where
  type MethodName WorkflowService "recordWorkerHeartbeat" = "RecordWorkerHeartbeat"
  type MethodInput WorkflowService "recordWorkerHeartbeat" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RecordWorkerHeartbeatRequest
  type MethodOutput WorkflowService "recordWorkerHeartbeat" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.RecordWorkerHeartbeatResponse
  type MethodStreamingType WorkflowService "recordWorkerHeartbeat" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl WorkflowService "listWorkers" where
  type MethodName WorkflowService "listWorkers" = "ListWorkers"
  type MethodInput WorkflowService "listWorkers" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkersRequest
  type MethodOutput WorkflowService "listWorkers" = Proto.Temporal.Api.Workflowservice.V1.RequestResponse.ListWorkersResponse
  type MethodStreamingType WorkflowService "listWorkers" = 'Data.ProtoLens.Service.Types.NonStreaming
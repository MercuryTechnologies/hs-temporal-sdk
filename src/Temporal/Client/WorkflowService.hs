{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}
module Temporal.Client.WorkflowService where
import Data.Word
import Foreign.C.String
import Foreign.C.Types
import Foreign.Ptr
import Foreign.Storable
import GHC.TypeLits
import Temporal.Client
import Temporal.Internal.FFI
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse
import Proto.Temporal.Api.Workflowservice.V1.Service
import Data.ProtoLens.Encoding
import Data.ProtoLens.Service.Types

{-
withForeignPtr c $ \cPtr -> alloca $ \rpcPtr -> do
  poke rpcPtr (RpcCall (methodId @svc @t) (encodeMessage req))
  makeTokioAsyncCall 
    (f cPtr)
    (fromRust (Proxy :: Proxy _))
    (fromRust (Proxy :: Proxy _))
-}

-- TODO the way that the generated protobuf code is structured, it might be nicer to just have a single
-- workflow service call that ensures the protobuf in question is the right one.
foreign import ccall "hs_count_workflow_executions" hs_count_workflow_executions :: PrimRpcCall
countWorkflowExecutions :: Client -> CountWorkflowExecutionsRequest -> IO (Either RpcError CountWorkflowExecutionsResponse)
countWorkflowExecutions = call @WorkflowService @"countWorkflowExecutions" hs_count_workflow_executions

foreign import ccall "hs_create_schedule" hs_create_schedule :: PrimRpcCall
createSchedule :: Client -> CreateScheduleRequest -> IO (Either RpcError CreateScheduleResponse)
createSchedule = call @WorkflowService @"createSchedule" hs_create_schedule

foreign import ccall "hs_delete_schedule" hs_delete_schedule :: PrimRpcCall
deleteSchedule :: Client -> DeleteScheduleRequest -> IO (Either RpcError DeleteScheduleResponse)
deleteSchedule = call @WorkflowService @"deleteSchedule" hs_delete_schedule

foreign import ccall "hs_deprecate_namespace" hs_deprecate_namespace :: PrimRpcCall
deprecateNamespace :: Client -> DeprecateNamespaceRequest -> IO (Either RpcError DeprecateNamespaceResponse)
deprecateNamespace = call @WorkflowService @"deprecateNamespace" hs_deprecate_namespace

foreign import ccall "hs_describe_namespace" hs_describe_namespace :: PrimRpcCall
describeNamespace :: Client -> DescribeNamespaceRequest -> IO (Either RpcError DescribeNamespaceResponse)
describeNamespace = call @WorkflowService @"describeNamespace" hs_describe_namespace

foreign import ccall "hs_describe_schedule" hs_describe_schedule :: PrimRpcCall
describeSchedule :: Client -> DescribeScheduleRequest -> IO (Either RpcError DescribeScheduleResponse)
describeSchedule = call @WorkflowService @"describeSchedule" hs_describe_schedule

foreign import ccall "hs_describe_task_queue" hs_describe_task_queue :: PrimRpcCall
describeTaskQueue :: Client -> DescribeTaskQueueRequest -> IO (Either RpcError DescribeTaskQueueResponse)
describeTaskQueue = call @WorkflowService @"describeTaskQueue" hs_describe_task_queue

foreign import ccall "hs_describe_workflow_execution" hs_describe_workflow_execution :: PrimRpcCall
describeWorkflowExecution :: Client -> DescribeWorkflowExecutionRequest -> IO (Either RpcError DescribeWorkflowExecutionResponse)
describeWorkflowExecution = call @WorkflowService @"describeWorkflowExecution" hs_describe_workflow_execution

foreign import ccall "hs_get_cluster_info" hs_get_cluster_info :: PrimRpcCall
getClusterInfo :: Client -> GetClusterInfoRequest -> IO (Either RpcError GetClusterInfoResponse)
getClusterInfo = call @WorkflowService @"getClusterInfo" hs_get_cluster_info

foreign import ccall "hs_get_search_attributes" hs_get_search_attributes :: PrimRpcCall
getSearchAttributes :: Client -> GetSearchAttributesRequest -> IO (Either RpcError GetSearchAttributesResponse)
getSearchAttributes = call @WorkflowService @"getSearchAttributes" hs_get_search_attributes

foreign import ccall "hs_get_system_info" hs_get_system_info :: PrimRpcCall
getSystemInfo :: Client -> GetSystemInfoRequest -> IO (Either RpcError GetSystemInfoResponse)
getSystemInfo = call @WorkflowService @"getSystemInfo" hs_get_system_info

foreign import ccall "hs_get_worker_build_id_compatibility" hs_get_worker_build_id_compatibility :: PrimRpcCall
getWorkerBuildIdCompatibility :: Client -> GetWorkerBuildIdCompatibilityRequest -> IO (Either RpcError GetWorkerBuildIdCompatibilityResponse)
getWorkerBuildIdCompatibility = call @WorkflowService @"getWorkerBuildIdCompatibility" hs_get_worker_build_id_compatibility

foreign import ccall "hs_get_workflow_execution_history" hs_get_workflow_execution_history :: PrimRpcCall
getWorkflowExecutionHistory :: Client -> GetWorkflowExecutionHistoryRequest -> IO (Either RpcError GetWorkflowExecutionHistoryResponse)
getWorkflowExecutionHistory = call @WorkflowService @"getWorkflowExecutionHistory" hs_get_workflow_execution_history

foreign import ccall "hs_get_workflow_execution_history_reverse" hs_get_workflow_execution_history_reverse :: PrimRpcCall
getWorkflowExecutionHistoryReverse :: Client -> GetWorkflowExecutionHistoryReverseRequest -> IO (Either RpcError GetWorkflowExecutionHistoryReverseResponse)
getWorkflowExecutionHistoryReverse = call @WorkflowService @"getWorkflowExecutionHistoryReverse" hs_get_workflow_execution_history_reverse

foreign import ccall "hs_list_archived_workflow_executions" hs_list_archived_workflow_executions :: PrimRpcCall
listArchivedWorkflowExecutions :: Client -> ListArchivedWorkflowExecutionsRequest -> IO (Either RpcError ListArchivedWorkflowExecutionsResponse)
listArchivedWorkflowExecutions = call @WorkflowService @"listArchivedWorkflowExecutions" hs_list_archived_workflow_executions

foreign import ccall "hs_list_closed_workflow_executions" hs_list_closed_workflow_executions :: PrimRpcCall
listClosedWorkflowExecutions :: Client -> ListClosedWorkflowExecutionsRequest -> IO (Either RpcError ListClosedWorkflowExecutionsResponse)
listClosedWorkflowExecutions = call @WorkflowService @"listClosedWorkflowExecutions" hs_list_closed_workflow_executions

foreign import ccall "hs_list_namespaces" hs_list_namespaces :: PrimRpcCall
listNamespaces :: Client -> ListNamespacesRequest -> IO (Either RpcError ListNamespacesResponse)
listNamespaces = call @WorkflowService @"listNamespaces" hs_list_namespaces

foreign import ccall "hs_list_open_workflow_executions" hs_list_open_workflow_executions :: PrimRpcCall
listOpenWorkflowExecutions :: Client -> ListOpenWorkflowExecutionsRequest -> IO (Either RpcError ListOpenWorkflowExecutionsResponse)
listOpenWorkflowExecutions = call @WorkflowService @"listOpenWorkflowExecutions" hs_list_open_workflow_executions

foreign import ccall "hs_list_schedule_matching_times" hs_list_schedule_matching_times :: PrimRpcCall
listScheduleMatchingTimes :: Client -> ListScheduleMatchingTimesRequest -> IO (Either RpcError ListScheduleMatchingTimesResponse)
listScheduleMatchingTimes = call @WorkflowService @"listScheduleMatchingTimes" hs_list_schedule_matching_times

foreign import ccall "hs_list_schedules" hs_list_schedules :: PrimRpcCall
listSchedules :: Client -> ListSchedulesRequest -> IO (Either RpcError ListSchedulesResponse)
listSchedules = call @WorkflowService @"listSchedules" hs_list_schedules

foreign import ccall "hs_list_task_queue_partitions" hs_list_task_queue_partitions :: PrimRpcCall
listTaskQueuePartitions :: Client -> ListTaskQueuePartitionsRequest -> IO (Either RpcError ListTaskQueuePartitionsResponse)
listTaskQueuePartitions = call @WorkflowService @"listTaskQueuePartitions" hs_list_task_queue_partitions

foreign import ccall "hs_list_workflow_executions" hs_list_workflow_executions :: PrimRpcCall
listWorkflowExecutions :: Client -> ListWorkflowExecutionsRequest -> IO (Either RpcError ListWorkflowExecutionsResponse)
listWorkflowExecutions = call @WorkflowService @"listWorkflowExecutions" hs_list_workflow_executions

foreign import ccall "hs_patch_schedule" hs_patch_schedule :: PrimRpcCall
patchSchedule :: Client -> PatchScheduleRequest -> IO (Either RpcError PatchScheduleResponse)
patchSchedule = call @WorkflowService @"patchSchedule" hs_patch_schedule

foreign import ccall "hs_poll_activity_task_queue" hs_poll_activity_task_queue :: PrimRpcCall
pollActivityTaskQueue :: Client -> PollActivityTaskQueueRequest -> IO (Either RpcError PollActivityTaskQueueResponse)
pollActivityTaskQueue = call @WorkflowService @"pollActivityTaskQueue" hs_poll_activity_task_queue

foreign import ccall "hs_poll_workflow_execution_update" hs_poll_workflow_execution_update :: PrimRpcCall
pollWorkflowExecutionUpdate :: Client -> PollWorkflowExecutionUpdateRequest -> IO (Either RpcError PollWorkflowExecutionUpdateResponse)
pollWorkflowExecutionUpdate = call @WorkflowService @"pollWorkflowExecutionUpdate" hs_poll_workflow_execution_update

foreign import ccall "hs_poll_workflow_task_queue" hs_poll_workflow_task_queue :: PrimRpcCall
pollWorkflowTaskQueue :: Client -> PollWorkflowTaskQueueRequest -> IO (Either RpcError PollWorkflowTaskQueueResponse)
pollWorkflowTaskQueue = call @WorkflowService @"pollWorkflowTaskQueue" hs_poll_workflow_task_queue

foreign import ccall "hs_query_workflow" hs_query_workflow :: PrimRpcCall
queryWorkflow :: Client -> QueryWorkflowRequest -> IO (Either RpcError QueryWorkflowResponse)
queryWorkflow = call @WorkflowService @"queryWorkflow" hs_query_workflow

foreign import ccall "hs_record_activity_task_heartbeat" hs_record_activity_task_heartbeat :: PrimRpcCall
recordActivityTaskHeartbeat :: Client -> RecordActivityTaskHeartbeatRequest -> IO (Either RpcError RecordActivityTaskHeartbeatResponse)
recordActivityTaskHeartbeat = call @WorkflowService @"recordActivityTaskHeartbeat" hs_record_activity_task_heartbeat

foreign import ccall "hs_record_activity_task_heartbeat_by_id" hs_record_activity_task_heartbeat_by_id :: PrimRpcCall
recordActivityTaskHeartbeatById :: Client -> RecordActivityTaskHeartbeatByIdRequest -> IO (Either RpcError RecordActivityTaskHeartbeatByIdResponse)
recordActivityTaskHeartbeatById = call @WorkflowService @"recordActivityTaskHeartbeatById" hs_record_activity_task_heartbeat_by_id

foreign import ccall "hs_register_namespace" hs_register_namespace :: PrimRpcCall
registerNamespace :: Client -> RegisterNamespaceRequest -> IO (Either RpcError RegisterNamespaceResponse)
registerNamespace = call @WorkflowService @"registerNamespace" hs_register_namespace

foreign import ccall "hs_request_cancel_workflow_execution" hs_request_cancel_workflow_execution :: PrimRpcCall
requestCancelWorkflowExecution :: Client -> RequestCancelWorkflowExecutionRequest -> IO (Either RpcError RequestCancelWorkflowExecutionResponse)
requestCancelWorkflowExecution = call @WorkflowService @"requestCancelWorkflowExecution" hs_request_cancel_workflow_execution

foreign import ccall "hs_reset_sticky_task_queue" hs_reset_sticky_task_queue :: PrimRpcCall
resetStickyTaskQueue :: Client -> ResetStickyTaskQueueRequest -> IO (Either RpcError ResetStickyTaskQueueResponse)
resetStickyTaskQueue = call @WorkflowService @"resetStickyTaskQueue" hs_reset_sticky_task_queue

foreign import ccall "hs_reset_workflow_execution" hs_reset_workflow_execution :: PrimRpcCall
resetWorkflowExecution :: Client -> ResetWorkflowExecutionRequest -> IO (Either RpcError ResetWorkflowExecutionResponse)
resetWorkflowExecution = call @WorkflowService @"resetWorkflowExecution" hs_reset_workflow_execution

foreign import ccall "hs_respond_activity_task_canceled" hs_respond_activity_task_canceled :: PrimRpcCall
respondActivityTaskCanceled :: Client -> RespondActivityTaskCanceledRequest -> IO (Either RpcError RespondActivityTaskCanceledResponse)
respondActivityTaskCanceled = call @WorkflowService @"respondActivityTaskCanceled" hs_respond_activity_task_canceled

foreign import ccall "hs_respond_activity_task_canceled_by_id" hs_respond_activity_task_canceled_by_id :: PrimRpcCall
respondActivityTaskCanceledById :: Client -> RespondActivityTaskCanceledByIdRequest -> IO (Either RpcError RespondActivityTaskCanceledByIdResponse)
respondActivityTaskCanceledById = call @WorkflowService @"respondActivityTaskCanceledById" hs_respond_activity_task_canceled_by_id

foreign import ccall "hs_respond_activity_task_completed" hs_respond_activity_task_completed :: PrimRpcCall
respondActivityTaskCompleted :: Client -> RespondActivityTaskCompletedRequest -> IO (Either RpcError RespondActivityTaskCompletedResponse)
respondActivityTaskCompleted = call @WorkflowService @"respondActivityTaskCompleted" hs_respond_activity_task_completed

foreign import ccall "hs_respond_activity_task_completed_by_id" hs_respond_activity_task_completed_by_id :: PrimRpcCall
respondActivityTaskCompletedById :: Client -> RespondActivityTaskCompletedByIdRequest -> IO (Either RpcError RespondActivityTaskCompletedByIdResponse)
respondActivityTaskCompletedById = call @WorkflowService @"respondActivityTaskCompletedById" hs_respond_activity_task_completed_by_id

foreign import ccall "hs_respond_activity_task_failed" hs_respond_activity_task_failed :: PrimRpcCall
respondActivityTaskFailed :: Client -> RespondActivityTaskFailedRequest -> IO (Either RpcError RespondActivityTaskFailedResponse)
respondActivityTaskFailed = call @WorkflowService @"respondActivityTaskFailed" hs_respond_activity_task_failed

foreign import ccall "hs_respond_activity_task_failed_by_id" hs_respond_activity_task_failed_by_id :: PrimRpcCall
respondActivityTaskFailedById :: Client -> RespondActivityTaskFailedByIdRequest -> IO (Either RpcError RespondActivityTaskFailedByIdResponse)
respondActivityTaskFailedById = call @WorkflowService @"respondActivityTaskFailedById" hs_respond_activity_task_failed_by_id

foreign import ccall "hs_respond_query_task_completed" hs_respond_query_task_completed :: PrimRpcCall
respondQueryTaskCompleted :: Client -> RespondQueryTaskCompletedRequest -> IO (Either RpcError RespondQueryTaskCompletedResponse)
respondQueryTaskCompleted = call @WorkflowService @"respondQueryTaskCompleted" hs_respond_query_task_completed

foreign import ccall "hs_respond_workflow_task_completed" hs_respond_workflow_task_completed :: PrimRpcCall
respondWorkflowTaskCompleted :: Client -> RespondWorkflowTaskCompletedRequest -> IO (Either RpcError RespondWorkflowTaskCompletedResponse)
respondWorkflowTaskCompleted = call @WorkflowService @"respondWorkflowTaskCompleted" hs_respond_workflow_task_completed

foreign import ccall "hs_respond_workflow_task_failed" hs_respond_workflow_task_failed :: PrimRpcCall
respondWorkflowTaskFailed :: Client -> RespondWorkflowTaskFailedRequest -> IO (Either RpcError RespondWorkflowTaskFailedResponse)
respondWorkflowTaskFailed = call @WorkflowService @"respondWorkflowTaskFailed" hs_respond_workflow_task_failed

foreign import ccall "hs_scan_workflow_executions" hs_scan_workflow_executions :: PrimRpcCall
scanWorkflowExecutions :: Client -> ScanWorkflowExecutionsRequest -> IO (Either RpcError ScanWorkflowExecutionsResponse)
scanWorkflowExecutions = call @WorkflowService @"scanWorkflowExecutions" hs_scan_workflow_executions

foreign import ccall "hs_signal_with_start_workflow_execution" hs_signal_with_start_workflow_execution :: PrimRpcCall
signalWithStartWorkflowExecution :: Client -> SignalWithStartWorkflowExecutionRequest -> IO (Either RpcError SignalWithStartWorkflowExecutionResponse)
signalWithStartWorkflowExecution = call @WorkflowService @"signalWithStartWorkflowExecution" hs_signal_with_start_workflow_execution

foreign import ccall "hs_signal_workflow_execution" hs_signal_workflow_execution :: PrimRpcCall
signalWorkflowExecution :: Client -> SignalWorkflowExecutionRequest -> IO (Either RpcError SignalWorkflowExecutionResponse)
signalWorkflowExecution = call @WorkflowService @"signalWorkflowExecution" hs_signal_workflow_execution

foreign import ccall "hs_start_workflow_execution" hs_start_workflow_execution :: PrimRpcCall
startWorkflowExecution :: Client -> StartWorkflowExecutionRequest -> IO (Either RpcError StartWorkflowExecutionResponse)
startWorkflowExecution = call @WorkflowService @"startWorkflowExecution" hs_start_workflow_execution

foreign import ccall "hs_terminate_workflow_execution" hs_terminate_workflow_execution :: PrimRpcCall
terminateWorkflowExecution :: Client -> TerminateWorkflowExecutionRequest -> IO (Either RpcError TerminateWorkflowExecutionResponse)
terminateWorkflowExecution = call @WorkflowService @"terminateWorkflowExecution" hs_terminate_workflow_execution

foreign import ccall "hs_update_namespace" hs_update_namespace :: PrimRpcCall
updateNamespace :: Client -> UpdateNamespaceRequest -> IO (Either RpcError UpdateNamespaceResponse)
updateNamespace = call @WorkflowService @"updateNamespace" hs_update_namespace

foreign import ccall "hs_update_schedule" hs_update_schedule :: PrimRpcCall
updateSchedule :: Client -> UpdateScheduleRequest -> IO (Either RpcError UpdateScheduleResponse)
updateSchedule = call @WorkflowService @"updateSchedule" hs_update_schedule

foreign import ccall "hs_update_workflow_execution" hs_update_workflow_execution :: PrimRpcCall
updateWorkflowExecution :: Client -> UpdateWorkflowExecutionRequest -> IO (Either RpcError UpdateWorkflowExecutionResponse)
updateWorkflowExecution = call @WorkflowService @"updateWorkflowExecution" hs_update_workflow_execution

foreign import ccall "hs_update_worker_build_id_compatibility" hs_update_worker_build_id_compatibility :: PrimRpcCall
updateWorkerBuildIdCompatibility :: Client -> UpdateWorkerBuildIdCompatibilityRequest -> IO (Either RpcError UpdateWorkerBuildIdCompatibilityResponse)
updateWorkerBuildIdCompatibility = call @WorkflowService @"updateWorkerBuildIdCompatibility" hs_update_worker_build_id_compatibility
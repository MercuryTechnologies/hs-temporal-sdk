{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}

module Temporal.Core.Client.WorkflowService (
  countWorkflowExecutions,
  createSchedule,
  deleteSchedule,
  deprecateNamespace,
  describeNamespace,
  describeSchedule,
  describeTaskQueue,
  describeWorkflowExecution,
  getClusterInfo,
  getSearchAttributes,
  getSystemInfo,
  getWorkerBuildIdCompatibility,
  getWorkflowExecutionHistory,
  getWorkflowExecutionHistoryReverse,
  listArchivedWorkflowExecutions,
  listClosedWorkflowExecutions,
  listNamespaces,
  listOpenWorkflowExecutions,
  listScheduleMatchingTimes,
  listSchedules,
  listTaskQueuePartitions,
  listWorkflowExecutions,
  patchSchedule,
  pollActivityTaskQueue,
  pollWorkflowExecutionUpdate,
  pollWorkflowTaskQueue,
  queryWorkflow,
  recordActivityTaskHeartbeat,
  recordActivityTaskHeartbeatById,
  registerNamespace,
  requestCancelWorkflowExecution,
  resetStickyTaskQueue,
  resetWorkflowExecution,
  respondActivityTaskCanceled,
  respondActivityTaskCanceledById,
  respondActivityTaskCompleted,
  respondActivityTaskCompletedById,
  respondActivityTaskFailed,
  respondActivityTaskFailedById,
  respondQueryTaskCompleted,
  respondWorkflowTaskCompleted,
  respondWorkflowTaskFailed,
  scanWorkflowExecutions,
  signalWithStartWorkflowExecution,
  signalWorkflowExecution,
  startWorkflowExecution,
  terminateWorkflowExecution,
  updateNamespace,
  updateSchedule,
  updateWorkflowExecution,
  updateWorkerBuildIdCompatibility,
) where

import Proto.Temporal.Api.Workflowservice.V1.RequestResponse
import Proto.Temporal.Api.Workflowservice.V1.Service
import Temporal.Core.Client


-- TODO the way that the generated protobuf code is structured, it might be nicer to just have a single
-- workflow service call that ensures the protobuf in question is the right one.
foreign import ccall "hs_count_workflow_executions" hs_count_workflow_executions :: PrimRpcCall


-- | CountWorkflowExecutions is a visibility API to count of workflow executions in a specific namespace.
countWorkflowExecutions :: Client -> CountWorkflowExecutionsRequest -> IO (Either RpcError CountWorkflowExecutionsResponse)
countWorkflowExecutions = call @WorkflowService @"countWorkflowExecutions" hs_count_workflow_executions


foreign import ccall "hs_create_schedule" hs_create_schedule :: PrimRpcCall


-- | Creates a new schedule.
createSchedule :: Client -> CreateScheduleRequest -> IO (Either RpcError CreateScheduleResponse)
createSchedule = call @WorkflowService @"createSchedule" hs_create_schedule


foreign import ccall "hs_delete_schedule" hs_delete_schedule :: PrimRpcCall


-- | Deletes a schedule, removing it from the system.
deleteSchedule :: Client -> DeleteScheduleRequest -> IO (Either RpcError DeleteScheduleResponse)
deleteSchedule = call @WorkflowService @"deleteSchedule" hs_delete_schedule


foreign import ccall "hs_deprecate_namespace" hs_deprecate_namespace :: PrimRpcCall


-- | Returns the schedule description and current state of an existing schedule.
deprecateNamespace :: Client -> DeprecateNamespaceRequest -> IO (Either RpcError DeprecateNamespaceResponse)
deprecateNamespace = call @WorkflowService @"deprecateNamespace" hs_deprecate_namespace


foreign import ccall "hs_describe_namespace" hs_describe_namespace :: PrimRpcCall


-- |  DescribeNamespace returns the information and configuration for a registered namespace.
describeNamespace :: Client -> DescribeNamespaceRequest -> IO (Either RpcError DescribeNamespaceResponse)
describeNamespace = call @WorkflowService @"describeNamespace" hs_describe_namespace


foreign import ccall "hs_describe_schedule" hs_describe_schedule :: PrimRpcCall


describeSchedule :: Client -> DescribeScheduleRequest -> IO (Either RpcError DescribeScheduleResponse)
describeSchedule = call @WorkflowService @"describeSchedule" hs_describe_schedule


foreign import ccall "hs_describe_task_queue" hs_describe_task_queue :: PrimRpcCall


-- | DescribeTaskQueue returns information about the target task queue.
describeTaskQueue :: Client -> DescribeTaskQueueRequest -> IO (Either RpcError DescribeTaskQueueResponse)
describeTaskQueue = call @WorkflowService @"describeTaskQueue" hs_describe_task_queue


foreign import ccall "hs_describe_workflow_execution" hs_describe_workflow_execution :: PrimRpcCall


-- | DescribeWorkflowExecution returns information about the specified workflow execution.
describeWorkflowExecution :: Client -> DescribeWorkflowExecutionRequest -> IO (Either RpcError DescribeWorkflowExecutionResponse)
describeWorkflowExecution = call @WorkflowService @"describeWorkflowExecution" hs_describe_workflow_execution


foreign import ccall "hs_get_cluster_info" hs_get_cluster_info :: PrimRpcCall


-- | GetClusterInfo returns information about temporal cluster
getClusterInfo :: Client -> GetClusterInfoRequest -> IO (Either RpcError GetClusterInfoResponse)
getClusterInfo = call @WorkflowService @"getClusterInfo" hs_get_cluster_info


foreign import ccall "hs_get_search_attributes" hs_get_search_attributes :: PrimRpcCall


-- | GetSearchAttributes is a visibility API to get all legal keys that could be used in list APIs
getSearchAttributes :: Client -> GetSearchAttributesRequest -> IO (Either RpcError GetSearchAttributesResponse)
getSearchAttributes = call @WorkflowService @"getSearchAttributes" hs_get_search_attributes


foreign import ccall "hs_get_system_info" hs_get_system_info :: PrimRpcCall


-- | GetSystemInfo returns information about the system.
getSystemInfo :: Client -> GetSystemInfoRequest -> IO (Either RpcError GetSystemInfoResponse)
getSystemInfo = call @WorkflowService @"getSystemInfo" hs_get_system_info


foreign import ccall "hs_get_worker_build_id_compatibility" hs_get_worker_build_id_compatibility :: PrimRpcCall


-- | Fetches the worker build id versioning sets for some task queue and related metadata.
getWorkerBuildIdCompatibility :: Client -> GetWorkerBuildIdCompatibilityRequest -> IO (Either RpcError GetWorkerBuildIdCompatibilityResponse)
getWorkerBuildIdCompatibility = call @WorkflowService @"getWorkerBuildIdCompatibility" hs_get_worker_build_id_compatibility


foreign import ccall "hs_get_workflow_execution_history" hs_get_workflow_execution_history :: PrimRpcCall


{- |
GetWorkflowExecutionHistory returns the history of specified workflow execution. Fails with
`NotFound` if the specified workflow execution is unknown to the service.
-}
getWorkflowExecutionHistory :: Client -> GetWorkflowExecutionHistoryRequest -> IO (Either RpcError GetWorkflowExecutionHistoryResponse)
getWorkflowExecutionHistory = call @WorkflowService @"getWorkflowExecutionHistory" hs_get_workflow_execution_history


foreign import ccall "hs_get_workflow_execution_history_reverse" hs_get_workflow_execution_history_reverse :: PrimRpcCall


{- |
GetWorkflowExecutionHistoryReverse returns the history of specified workflow execution in reverse
order (starting from last event). Fails with`NotFound` if the specified workflow execution is
unknown to the service.
-}
getWorkflowExecutionHistoryReverse :: Client -> GetWorkflowExecutionHistoryReverseRequest -> IO (Either RpcError GetWorkflowExecutionHistoryReverseResponse)
getWorkflowExecutionHistoryReverse = call @WorkflowService @"getWorkflowExecutionHistoryReverse" hs_get_workflow_execution_history_reverse


foreign import ccall "hs_list_archived_workflow_executions" hs_list_archived_workflow_executions :: PrimRpcCall


-- | ListArchivedWorkflowExecutions is a visibility API to list archived workflow executions in a specific namespace.
listArchivedWorkflowExecutions :: Client -> ListArchivedWorkflowExecutionsRequest -> IO (Either RpcError ListArchivedWorkflowExecutionsResponse)
listArchivedWorkflowExecutions = call @WorkflowService @"listArchivedWorkflowExecutions" hs_list_archived_workflow_executions


foreign import ccall "hs_list_closed_workflow_executions" hs_list_closed_workflow_executions :: PrimRpcCall


-- | ListClosedWorkflowExecutions is a visibility API to list the closed executions in a specific namespace.
listClosedWorkflowExecutions :: Client -> ListClosedWorkflowExecutionsRequest -> IO (Either RpcError ListClosedWorkflowExecutionsResponse)
listClosedWorkflowExecutions = call @WorkflowService @"listClosedWorkflowExecutions" hs_list_closed_workflow_executions


foreign import ccall "hs_list_namespaces" hs_list_namespaces :: PrimRpcCall


-- | ListNamespaces returns the information and configuration for all namespaces.
listNamespaces :: Client -> ListNamespacesRequest -> IO (Either RpcError ListNamespacesResponse)
listNamespaces = call @WorkflowService @"listNamespaces" hs_list_namespaces


foreign import ccall "hs_list_open_workflow_executions" hs_list_open_workflow_executions :: PrimRpcCall


-- | ListOpenWorkflowExecutions is a visibility API to list the open executions in a specific namespace.
listOpenWorkflowExecutions :: Client -> ListOpenWorkflowExecutionsRequest -> IO (Either RpcError ListOpenWorkflowExecutionsResponse)
listOpenWorkflowExecutions = call @WorkflowService @"listOpenWorkflowExecutions" hs_list_open_workflow_executions


foreign import ccall "hs_list_schedule_matching_times" hs_list_schedule_matching_times :: PrimRpcCall


-- | ListWorkflowExecutions is a visibility API to list workflow executions in a specific namespace.
listScheduleMatchingTimes :: Client -> ListScheduleMatchingTimesRequest -> IO (Either RpcError ListScheduleMatchingTimesResponse)
listScheduleMatchingTimes = call @WorkflowService @"listScheduleMatchingTimes" hs_list_schedule_matching_times


foreign import ccall "hs_list_schedules" hs_list_schedules :: PrimRpcCall


-- | Lists matching times within a range.
listSchedules :: Client -> ListSchedulesRequest -> IO (Either RpcError ListSchedulesResponse)
listSchedules = call @WorkflowService @"listSchedules" hs_list_schedules


foreign import ccall "hs_list_task_queue_partitions" hs_list_task_queue_partitions :: PrimRpcCall


listTaskQueuePartitions :: Client -> ListTaskQueuePartitionsRequest -> IO (Either RpcError ListTaskQueuePartitionsResponse)
listTaskQueuePartitions = call @WorkflowService @"listTaskQueuePartitions" hs_list_task_queue_partitions


foreign import ccall "hs_list_workflow_executions" hs_list_workflow_executions :: PrimRpcCall


-- |  ListWorkflowExecutions is a visibility API to list workflow executions in a specific namespace.
listWorkflowExecutions :: Client -> ListWorkflowExecutionsRequest -> IO (Either RpcError ListWorkflowExecutionsResponse)
listWorkflowExecutions = call @WorkflowService @"listWorkflowExecutions" hs_list_workflow_executions


foreign import ccall "hs_patch_schedule" hs_patch_schedule :: PrimRpcCall


-- | Makes a specific change to a schedule or triggers an immediate action.
patchSchedule :: Client -> PatchScheduleRequest -> IO (Either RpcError PatchScheduleResponse)
patchSchedule = call @WorkflowService @"patchSchedule" hs_patch_schedule


foreign import ccall "hs_poll_activity_task_queue" hs_poll_activity_task_queue :: PrimRpcCall


{- |
PollActivityTaskQueue is called by workers to process activity tasks from a specific task
queue.

The worker is expected to call one of the `RespondActivityTaskXXX` methods when it is done
processing the task.

An activity task is dispatched whenever a `SCHEDULE_ACTIVITY_TASK` command is produced during
workflow execution. An in memory `ACTIVITY_TASK_STARTED` event is written to mutable state
before the task is dispatched to the worker. The started event, and the final event
(`ACTIVITY_TASK_COMPLETED` / `ACTIVITY_TASK_FAILED` / `ACTIVITY_TASK_TIMED_OUT`) will both be
written permanently to Workflow execution history when Activity is finished. This is done to
avoid writing many events in the case of a failure/retry loop.
-}
pollActivityTaskQueue :: Client -> PollActivityTaskQueueRequest -> IO (Either RpcError PollActivityTaskQueueResponse)
pollActivityTaskQueue = call @WorkflowService @"pollActivityTaskQueue" hs_poll_activity_task_queue


foreign import ccall "hs_poll_workflow_execution_update" hs_poll_workflow_execution_update :: PrimRpcCall


pollWorkflowExecutionUpdate :: Client -> PollWorkflowExecutionUpdateRequest -> IO (Either RpcError PollWorkflowExecutionUpdateResponse)
pollWorkflowExecutionUpdate = call @WorkflowService @"pollWorkflowExecutionUpdate" hs_poll_workflow_execution_update


foreign import ccall "hs_poll_workflow_task_queue" hs_poll_workflow_task_queue :: PrimRpcCall


{- |
PollWorkflowTaskQueue is called by workers to make progress on workflows.

A WorkflowTask is dispatched to callers for active workflow executions with pending workflow
tasks. The worker is expected to call `RespondWorkflowTaskCompleted` when it is done
processing the task. The service will create a `WorkflowTaskStarted` event in the history for
this task before handing it to the worker.
-}
pollWorkflowTaskQueue :: Client -> PollWorkflowTaskQueueRequest -> IO (Either RpcError PollWorkflowTaskQueueResponse)
pollWorkflowTaskQueue = call @WorkflowService @"pollWorkflowTaskQueue" hs_poll_workflow_task_queue


foreign import ccall "hs_query_workflow" hs_query_workflow :: PrimRpcCall


{- |
QueryWorkflow requests a query be executed for a specified workflow execution.
-}
queryWorkflow :: Client -> QueryWorkflowRequest -> IO (Either RpcError QueryWorkflowResponse)
queryWorkflow = call @WorkflowService @"queryWorkflow" hs_query_workflow


foreign import ccall "hs_record_activity_task_heartbeat" hs_record_activity_task_heartbeat :: PrimRpcCall


{- |
RecordActivityTaskHeartbeat is optionally called by workers while they execute activities.

If worker fails to heartbeat within the `heartbeat_timeout` interval for the activity task,
then it will be marked as timed out and an `ACTIVITY_TASK_TIMED_OUT` event will be written to
the workflow history. Calling `RecordActivityTaskHeartbeat` will fail with `NotFound` in
such situations, in that event, the SDK should request cancellation of the activity.
-}
recordActivityTaskHeartbeat :: Client -> RecordActivityTaskHeartbeatRequest -> IO (Either RpcError RecordActivityTaskHeartbeatResponse)
recordActivityTaskHeartbeat = call @WorkflowService @"recordActivityTaskHeartbeat" hs_record_activity_task_heartbeat


foreign import ccall "hs_record_activity_task_heartbeat_by_id" hs_record_activity_task_heartbeat_by_id :: PrimRpcCall


{- |
See `RecordActivityTaskHeartbeat`. This version allows clients to record heartbeats by
namespace/workflow id/activity id instead of task token.
-}
recordActivityTaskHeartbeatById :: Client -> RecordActivityTaskHeartbeatByIdRequest -> IO (Either RpcError RecordActivityTaskHeartbeatByIdResponse)
recordActivityTaskHeartbeatById = call @WorkflowService @"recordActivityTaskHeartbeatById" hs_record_activity_task_heartbeat_by_id


foreign import ccall "hs_register_namespace" hs_register_namespace :: PrimRpcCall


{-
RegisterNamespace creates a new namespace which can be used as a container for all resources.

A Namespace is a top level entity within Temporal, and is used as a container for resources
like workflow executions, task queues, etc. A Namespace acts as a sandbox and provides
isolation for all resources within the namespace. All resources belongs to exactly one namespace.
-}
registerNamespace :: Client -> RegisterNamespaceRequest -> IO (Either RpcError RegisterNamespaceResponse)
registerNamespace = call @WorkflowService @"registerNamespace" hs_register_namespace


foreign import ccall "hs_request_cancel_workflow_execution" hs_request_cancel_workflow_execution :: PrimRpcCall


{- |
RequestCancelWorkflowExecution is called by workers when they want to request cancellation of
a workflow execution.

This results in a new `WORKFLOW_EXECUTION_CANCEL_REQUESTED` event being written to the
workflow history and a new workflow task created for the workflow. It returns success if the requested
workflow is already closed. It fails with 'NotFound' if the requested workflow doesn't exist.
-}
requestCancelWorkflowExecution :: Client -> RequestCancelWorkflowExecutionRequest -> IO (Either RpcError RequestCancelWorkflowExecutionResponse)
requestCancelWorkflowExecution = call @WorkflowService @"requestCancelWorkflowExecution" hs_request_cancel_workflow_execution


foreign import ccall "hs_reset_sticky_task_queue" hs_reset_sticky_task_queue :: PrimRpcCall


{- |
ResetStickyTaskQueue resets the sticky task queue related information in the mutable state of
a given workflow. This is prudent for workers to perform if a workflow has been paged out of
their cache.

Things cleared are:
1. StickyTaskQueue
2. StickyScheduleToStartTimeout
-}
resetStickyTaskQueue :: Client -> ResetStickyTaskQueueRequest -> IO (Either RpcError ResetStickyTaskQueueResponse)
resetStickyTaskQueue = call @WorkflowService @"resetStickyTaskQueue" hs_reset_sticky_task_queue


foreign import ccall "hs_reset_workflow_execution" hs_reset_workflow_execution :: PrimRpcCall


{- |
ResetWorkflowExecution will reset an existing workflow execution to a specified
`WORKFLOW_TASK_COMPLETED` event (exclusive). It will immediately terminate the current
execution instance.
-}

-- TODO: Does exclusive here mean *just* the completed event, or also WFT started? Otherwise the task is doomed to time out?
resetWorkflowExecution :: Client -> ResetWorkflowExecutionRequest -> IO (Either RpcError ResetWorkflowExecutionResponse)
resetWorkflowExecution = call @WorkflowService @"resetWorkflowExecution" hs_reset_workflow_execution


foreign import ccall "hs_respond_activity_task_canceled" hs_respond_activity_task_canceled :: PrimRpcCall


{- |
RespondActivityTaskFailed is called by workers when processing an activity task fails.

This results in a new `ACTIVITY_TASK_CANCELED` event being written to the workflow history
and a new workflow task created for the workflow. Fails with `NotFound` if the task token is
no longer valid due to activity timeout, already being completed, or never having existed.
-}
respondActivityTaskCanceled :: Client -> RespondActivityTaskCanceledRequest -> IO (Either RpcError RespondActivityTaskCanceledResponse)
respondActivityTaskCanceled = call @WorkflowService @"respondActivityTaskCanceled" hs_respond_activity_task_canceled


foreign import ccall "hs_respond_activity_task_canceled_by_id" hs_respond_activity_task_canceled_by_id :: PrimRpcCall


{- |
See `RecordActivityTaskCanceled`. This version allows clients to record failures by
namespace/workflow id/activity id instead of task token.
-}
respondActivityTaskCanceledById :: Client -> RespondActivityTaskCanceledByIdRequest -> IO (Either RpcError RespondActivityTaskCanceledByIdResponse)
respondActivityTaskCanceledById = call @WorkflowService @"respondActivityTaskCanceledById" hs_respond_activity_task_canceled_by_id


foreign import ccall "hs_respond_activity_task_completed" hs_respond_activity_task_completed :: PrimRpcCall


{- |
RespondActivityTaskCompleted is called by workers when they successfully complete an activity
task.

This results in a new `ACTIVITY_TASK_COMPLETED` event being written to the workflow history
and a new workflow task created for the workflow. Fails with `NotFound` if the task token is
no longer valid due to activity timeout, already being completed, or never having existed.
-}
respondActivityTaskCompleted :: Client -> RespondActivityTaskCompletedRequest -> IO (Either RpcError RespondActivityTaskCompletedResponse)
respondActivityTaskCompleted = call @WorkflowService @"respondActivityTaskCompleted" hs_respond_activity_task_completed


foreign import ccall "hs_respond_activity_task_completed_by_id" hs_respond_activity_task_completed_by_id :: PrimRpcCall


{- |
See `RecordActivityTaskCompleted`. This version allows clients to record completions by
namespace/workflow id/activity id instead of task token.
-}
respondActivityTaskCompletedById :: Client -> RespondActivityTaskCompletedByIdRequest -> IO (Either RpcError RespondActivityTaskCompletedByIdResponse)
respondActivityTaskCompletedById = call @WorkflowService @"respondActivityTaskCompletedById" hs_respond_activity_task_completed_by_id


foreign import ccall "hs_respond_activity_task_failed" hs_respond_activity_task_failed :: PrimRpcCall


{- |
RespondActivityTaskFailed is called by workers when processing an activity task fails.

This results in a new `ACTIVITY_TASK_FAILED` event being written to the workflow history and
a new workflow task created for the workflow. Fails with `NotFound` if the task token is no
longer valid due to activity timeout, already being completed, or never having existed.
-}
respondActivityTaskFailed :: Client -> RespondActivityTaskFailedRequest -> IO (Either RpcError RespondActivityTaskFailedResponse)
respondActivityTaskFailed = call @WorkflowService @"respondActivityTaskFailed" hs_respond_activity_task_failed


foreign import ccall "hs_respond_activity_task_failed_by_id" hs_respond_activity_task_failed_by_id :: PrimRpcCall


{- |
See `RecordActivityTaskCompleted`. This version allows clients to record completions by
namespace/workflow id/activity id instead of task token.
-}
respondActivityTaskFailedById :: Client -> RespondActivityTaskFailedByIdRequest -> IO (Either RpcError RespondActivityTaskFailedByIdResponse)
respondActivityTaskFailedById = call @WorkflowService @"respondActivityTaskFailedById" hs_respond_activity_task_failed_by_id


foreign import ccall "hs_respond_query_task_completed" hs_respond_query_task_completed :: PrimRpcCall


{- |
RespondQueryTaskCompleted is called by workers to complete queries which were delivered on
the `query` (not `queries`) field of a `PollWorkflowTaskQueueResponse`.

Completing the query will unblock the corresponding client call to `QueryWorkflow` and return
the query result a response.
-}
respondQueryTaskCompleted :: Client -> RespondQueryTaskCompletedRequest -> IO (Either RpcError RespondQueryTaskCompletedResponse)
respondQueryTaskCompleted = call @WorkflowService @"respondQueryTaskCompleted" hs_respond_query_task_completed


foreign import ccall "hs_respond_workflow_task_completed" hs_respond_workflow_task_completed :: PrimRpcCall


{- |
RespondWorkflowTaskCompleted is called by workers to successfully complete workflow tasks
they received from `PollWorkflowTaskQueue`.

Completing a WorkflowTask will write a `WORKFLOW_TASK_COMPLETED` event to the workflow's
history, along with events corresponding to whatever commands the SDK generated while
executing the task (ex timer started, activity task scheduled, etc).
-}
respondWorkflowTaskCompleted :: Client -> RespondWorkflowTaskCompletedRequest -> IO (Either RpcError RespondWorkflowTaskCompletedResponse)
respondWorkflowTaskCompleted = call @WorkflowService @"respondWorkflowTaskCompleted" hs_respond_workflow_task_completed


foreign import ccall "hs_respond_workflow_task_failed" hs_respond_workflow_task_failed :: PrimRpcCall


{- |
RespondWorkflowTaskFailed is called by workers to indicate the processing of a workflow task
failed.

This results in a `WORKFLOW_TASK_FAILED` event written to the history, and a new workflow
task will be scheduled. This API can be used to report unhandled failures resulting from
applying the workflow task.

Temporal will only append first WorkflowTaskFailed event to the history of workflow execution
for consecutive failures.
-}
respondWorkflowTaskFailed :: Client -> RespondWorkflowTaskFailedRequest -> IO (Either RpcError RespondWorkflowTaskFailedResponse)
respondWorkflowTaskFailed = call @WorkflowService @"respondWorkflowTaskFailed" hs_respond_workflow_task_failed


foreign import ccall "hs_scan_workflow_executions" hs_scan_workflow_executions :: PrimRpcCall


-- | ScanWorkflowExecutions is a visibility API to list large amount of workflow executions in a specific namespace without order.
scanWorkflowExecutions :: Client -> ScanWorkflowExecutionsRequest -> IO (Either RpcError ScanWorkflowExecutionsResponse)
scanWorkflowExecutions = call @WorkflowService @"scanWorkflowExecutions" hs_scan_workflow_executions


foreign import ccall "hs_signal_with_start_workflow_execution" hs_signal_with_start_workflow_execution :: PrimRpcCall


{- |
SignalWithStartWorkflowExecution is used to ensure a signal is sent to a workflow, even if
it isn't yet started.

If the workflow is running, a `WORKFLOW_EXECUTION_SIGNALED` event is recorded in the history
and a workflow task is generated.

If the workflow is not running or not found, then the workflow is created with
`WORKFLOW_EXECUTION_STARTED` and `WORKFLOW_EXECUTION_SIGNALED` events in its history, and a
workflow task is generated.
-}
signalWithStartWorkflowExecution :: Client -> SignalWithStartWorkflowExecutionRequest -> IO (Either RpcError SignalWithStartWorkflowExecutionResponse)
signalWithStartWorkflowExecution = call @WorkflowService @"signalWithStartWorkflowExecution" hs_signal_with_start_workflow_execution


foreign import ccall "hs_signal_workflow_execution" hs_signal_workflow_execution :: PrimRpcCall


{- |
SignalWorkflowExecution is used to send a signal to a running workflow execution.

This results in a `WORKFLOW_EXECUTION_SIGNALED` event recorded in the history and a workflow
task being created for the execution.
-}
signalWorkflowExecution :: Client -> SignalWorkflowExecutionRequest -> IO (Either RpcError SignalWorkflowExecutionResponse)
signalWorkflowExecution = call @WorkflowService @"signalWorkflowExecution" hs_signal_workflow_execution


foreign import ccall "hs_start_workflow_execution" hs_start_workflow_execution :: PrimRpcCall


{-
  Starts a new workflow execution.

  It will create the execution with a `WORKFLOW_EXECUTION_STARTED` event in its history and
  also schedule the first workflow task. Returns `WorkflowExecutionAlreadyStarted`, if an
  instance already exists with same workflow id.
-}
startWorkflowExecution :: Client -> StartWorkflowExecutionRequest -> IO (Either RpcError StartWorkflowExecutionResponse)
startWorkflowExecution = call @WorkflowService @"startWorkflowExecution" hs_start_workflow_execution


foreign import ccall "hs_terminate_workflow_execution" hs_terminate_workflow_execution :: PrimRpcCall


{- |
terminates an existing workflow execution by recording a
`WORKFLOW_EXECUTION_TERMINATED` event in the history and immediately terminating the
execution instance.
-}
terminateWorkflowExecution :: Client -> TerminateWorkflowExecutionRequest -> IO (Either RpcError TerminateWorkflowExecutionResponse)
terminateWorkflowExecution = call @WorkflowService @"terminateWorkflowExecution" hs_terminate_workflow_execution


foreign import ccall "hs_update_namespace" hs_update_namespace :: PrimRpcCall


{- | UpdateNamespace is used to update the information and configuration of a registered
namespace.
-}
updateNamespace :: Client -> UpdateNamespaceRequest -> IO (Either RpcError UpdateNamespaceResponse)
updateNamespace = call @WorkflowService @"updateNamespace" hs_update_namespace


foreign import ccall "hs_update_schedule" hs_update_schedule :: PrimRpcCall


-- |  Changes the configuration or state of an existing schedule.
updateSchedule :: Client -> UpdateScheduleRequest -> IO (Either RpcError UpdateScheduleResponse)
updateSchedule = call @WorkflowService @"updateSchedule" hs_update_schedule


foreign import ccall "hs_update_workflow_execution" hs_update_workflow_execution :: PrimRpcCall


-- | Invokes the specified update function on user workflow code.
updateWorkflowExecution :: Client -> UpdateWorkflowExecutionRequest -> IO (Either RpcError UpdateWorkflowExecutionResponse)
updateWorkflowExecution = call @WorkflowService @"updateWorkflowExecution" hs_update_workflow_execution


foreign import ccall "hs_update_worker_build_id_compatibility" hs_update_worker_build_id_compatibility :: PrimRpcCall


{- |
Allows users to specify sets of worker build id versions on a per task queue basis. Versions
are ordered, and may be either compatible with some extant version, or a new incompatible
version, forming sets of ids which are incompatible with each other, but whose contained
members are compatible with one another.
-}
updateWorkerBuildIdCompatibility :: Client -> UpdateWorkerBuildIdCompatibilityRequest -> IO (Either RpcError UpdateWorkerBuildIdCompatibilityResponse)
updateWorkerBuildIdCompatibility = call @WorkflowService @"updateWorkerBuildIdCompatibility" hs_update_worker_build_id_compatibility

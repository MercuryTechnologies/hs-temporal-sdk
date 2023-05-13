module Temporal.Client where

newtype Client = Client { client :: ForeignPtr Client }


data ClientConfig = ClientConfig
  { targetUrl :: String
  , clientName :: String
  , clientVersion :: String
  , metadata :: HashMap String String
  , identity :: String
  , tls_config :: Maybe ClientTlsConfig
  , retry_config :: Maybe ClientRetryConfig
  }

data ClientTlsConfig = ClientTlsConfig
  { server_root_ca_cert: Maybe ByteString
  , domain: Maybe Text
  , client_cert: Maybe ByteString
  , client_private_key: Maybe ByteString
  }

data ClientRetryConfig = ClientRetryConfig
  { initialIntervalMillis :: Word64
  , randomizationFactor :: Double
  , multiplier :: Double
  , maxIntervalMillis :: Word64
  , maxElapsedTimeMillis :: Maybe Word64
  , maxRetries :: CUSize
  }

data RpcCall = RpcCall
  { rpc :: Text
  , req :: ByteString
  , retry :: Bool
  , metadata :: HashMap String String
  , timeoutMillis :: Maybe Word64
  }

-- TODO async
connectClient :: Runtime -> ClientConfig -> IO (Either ClientConnectionError Client)
connectClient = undefined

updateMetadata :: Client -> HashMap String String -> IO ()
updateMetadata = undefined

{-
The following RPC calls use the workflow service:
count_workflow_executions
create_schedule
delete_schedule
deprecate_namespace
describe_namespace
describe_schedule
describe_task_queue
describe_workflow_execution
get_cluster_info
get_search_attributes
get_system_info
get_worker_build_id_compatibility
get_workflow_execution_history
get_workflow_execution_history_reverse
list_archived_workflow_executions
list_closed_workflow_executions
list_namespaces
list_open_workflow_executions
list_schedule_matching_times
list_schedules
list_task_queue_partitions
list_workflow_executions
patch_schedule
poll_activity_task_queue
poll_workflow_execution_update
poll_workflow_task_queue
query_workflow
record_activity_task_heartbeat
record_activity_task_heartbeat_by_id
register_namespace
request_cancel_workflow_execution
reset_sticky_task_queue
reset_workflow_execution
respond_activity_task_canceled
respond_activity_task_canceled_by_id
respond_activity_task_completed
respond_activity_task_completed_by_id
respond_activity_task_failed
respond_activity_task_failed_by_id
respond_query_task_completed
respond_workflow_task_completed
respond_workflow_task_failed
scan_workflow_executions
signal_with_start_workflow_execution
signal_workflow_execution
start_workflow_execution
terminate_workflow_execution
update_namespace
update_schedule
update_workflow_execution
update_worker_build_id_compatibility
-}
callWorkflowService :: Client -> RpcCall -> IO (Either RpcError ByteString)
callWorkflowService = undefined

{-
add_or_update_remote_cluster
add_search_attributes
delete_namespace
delete_workflow_execution
list_clusters
list_search_attributes
remove_remote_cluster
remove_search_attributes
-}
callOperatorService :: Client -> RpcCall -> IO (Either RpcError ByteString)
callOperatorService = undefined

{-
get_current_time
lock_time_skipping
sleep_until
sleep
unlock_time_skipping_with_sleep
unlock_time_skipping
-}
callTestService :: Client -> RpcCall -> IO (Either RpcError ByteString)
callTestService = undefined

{-
check
-}
callHealthService :: Client -> RpcCall -> IO (Either RpcError ByteString)
callHealthService = undefined


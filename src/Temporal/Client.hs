{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
module Temporal.Client where

import Control.Exception
import Data.Aeson
import Data.Aeson.TH
import Data.ByteString (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Proxy
import Data.Text (Text)
import Data.Word
import Foreign.C.String
import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.Storable
import Temporal.Runtime
import Temporal.Internal.FFI
import qualified Data.ByteString          as BS
import qualified Data.ByteString.Internal as BS
import qualified Data.ByteString          as BL
import qualified Data.Vector.Storable     as V

foreign import ccall "hs_temporal_connect_client" raw_connectClient :: Ptr Runtime -> CString -> TokioCall RustCStringLen Client
foreign import ccall "&hs_temporal_drop_client" raw_freeClient :: FunPtr (Ptr Client -> IO ())

newtype Client = Client { client :: ForeignPtr Client }
instance ManagedRustValue Client where
  type RustRef Client = Ptr Client
  type HaskellRep Client = Client
  fromRust _ rustPtr = mask_ $ do
    fp <- newForeignPtr raw_freeClient rustPtr
    pure $ Client fp

newtype ByteVector = ByteVector { byteVector :: ByteString }

byteStringToVector :: BS.ByteString -> V.Vector Word8
byteStringToVector bs = vec 
  where
    vec = V.unsafeFromForeignPtr (castForeignPtr fptr) off len
    (fptr, off, len) = BS.toForeignPtr bs

vectorToByteString :: V.Vector Word8 -> BS.ByteString
vectorToByteString vec = BS.fromForeignPtr (castForeignPtr fptr) off len 
  where
    (fptr, off, len) = V.unsafeToForeignPtr vec

instance ToJSON ByteVector where
  toJSON = toJSON . byteStringToVector . byteVector
instance FromJSON ByteVector where
  parseJSON = fmap ByteVector . fmap vectorToByteString . parseJSON

data ClientTlsConfig = ClientTlsConfig
  { serverRootCaCert:: Maybe ByteVector
  , domain:: Maybe Text
  , clientCert:: Maybe ByteVector
  , clientPrivateKey:: Maybe ByteVector
  }
deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientTlsConfig

data ClientRetryConfig = ClientRetryConfig
  { initialIntervalMillis :: Word64
  , randomizationFactor :: Double
  , multiplier :: Double
  , maxIntervalMillis :: Word64
  , maxElapsedTimeMillis :: Maybe Word64
  , maxRetries :: Word64
  }
deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientRetryConfig

data ClientConfig = ClientConfig
  { targetUrl :: Text
  , clientName :: Text
  , clientVersion :: Text
  , metadata :: HashMap Text Text
  , identity :: Text
  , tlsConfig :: Maybe ClientTlsConfig
  , retryConfig :: Maybe ClientRetryConfig
  }
deriveJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''ClientConfig

data RpcCall a = RpcCall
  { req :: a
  , retry :: Bool
  , metadata :: HashMap Text Text
  , timeoutMillis :: Maybe Word64
  }

data ClientConnectionError = ClientConnectionError Text
  deriving (Show)
data RpcError = RpcError

defaultClientConfig :: ClientConfig
defaultClientConfig = ClientConfig
  { targetUrl = "http://localhost:7233"
  , clientName = "temporal-haskell"
  , clientVersion = "0.0.1"
  , metadata = mempty
  , identity = ""
  , tlsConfig = Nothing
  , retryConfig = Nothing
  }

connectClient :: Runtime -> ClientConfig -> IO (Either ClientConnectionError Client)
connectClient rt conf = withRuntime rt $ \rtPtr -> BS.useAsCString (BL.toStrict $ encode conf) $ \confPtr -> do
  putStrLn "connectClient"
  makeTokioAsyncCall 
    (raw_connectClient rtPtr confPtr)
    (\cstrLen -> do
      msg <- fromRust (Proxy :: Proxy RustCStringLen) cstrLen
      pure $ ClientConnectionError msg
    )
    (fmap Client . newForeignPtr raw_freeClient)

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
-- callWorkflowService :: Client -> RpcCall call -> IO (Either RpcError (MethodOutput call))
-- callWorkflowService c call = undefined

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
-- callOperatorService :: Client -> RpcCall OperatorService -> IO (Either RpcError ByteString)
-- callOperatorService = undefined

{-
get_current_time
lock_time_skipping
sleep_until
sleep
unlock_time_skipping_with_sleep
unlock_time_skipping
-}
-- callTestService :: Client -> RpcCall a -> IO (Either RpcError ByteString)
-- callTestService = undefined

{-
check
-}
-- callHealthService :: Client -> RpcCall a -> IO (Either RpcError ByteString)
-- callHealthService = undefined


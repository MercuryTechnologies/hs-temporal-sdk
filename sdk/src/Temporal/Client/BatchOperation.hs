{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

{- |
Module: Temporal.Client.BatchOperation
Description: Batch operations for performing actions on multiple workflow executions

Batch operations allow you to perform actions (terminate, cancel, signal, delete, reset)
on multiple workflow executions that match a visibility query. This is useful for:

- Mass termination of workflows matching certain criteria
- Canceling multiple workflows at once
- Sending signals to many workflows
- Bulk deletion of closed workflows
- Resetting multiple workflows to a specific point

= Usage Example

@
import Temporal.Client.BatchOperation
import Temporal.Client.VisibilityQuery
import Temporal.Client.Types (WorkflowExecutionStatus(..))
import Data.Time.Clock (addUTCTime, getCurrentTime)

-- Terminate all failed workflows in the last 30 days
now <- getCurrentTime
let thirtyDaysAgo = addUTCTime (-30 * 24 * 60 * 60) now
    query = AndQuery
      [ StatusQuery Failed
      , CloseTimeQuery (After thirtyDaysAgo)
      ]

-- Server generates a job ID
startBatchTerminate query "Cleaning up failed workflows" Nothing

-- Or provide your own job ID for tracking/idempotency
startBatchTerminate query "Cleaning up failed workflows" (Just (BatchJobId "cleanup-2023-01"))

-- Check the progress of a batch operation
info <- describeBatch (BatchJobId "job-123")
print (jobId info, state info)
@
-}
module Temporal.Client.BatchOperation (
  -- * Batch Operation Types
  BatchOperationState (..),
  BatchOperationInfo (..),
  BatchJobId (..),
  Reason (..),

  -- * Starting Batch Operations
  startBatchTerminate,
  startBatchCancel,
  startBatchSignal,
  startBatchDelete,
  startBatchReset,

  -- * Managing Batch Operations
  stopBatch,
  describeBatch,
  listBatchOperations,

  -- * Query Options
  ListBatchOptions (..),
  defaultListBatchOptions,
) where

import qualified Data.ByteString as BS
import Data.Int (Int32)
import Data.ProtoLens (defMessage)
import Data.String (IsString)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import Data.Time.Clock (UTCTime)
import Lens.Family2 ((&), (.~), (^.))
import qualified Proto.Temporal.Api.Batch.V1.Message as Batch
import qualified Proto.Temporal.Api.Batch.V1.Message_Fields as Batch
import qualified Proto.Temporal.Api.Common.V1.Message_Fields as Common
import qualified Proto.Temporal.Api.Enums.V1.BatchOperation as Enums
import qualified Proto.Temporal.Api.Enums.V1.Reset as ResetEnums
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse as RR
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as RR
import Temporal.Client (HasWorkflowClient (..))
import Temporal.Client.Types (WorkflowClient (..), WorkflowClientConfig (WorkflowClientConfig, namespace, payloadProcessor))
import Temporal.Client.VisibilityQuery (VisibilityQuery, renderQuery)
import Temporal.Common (Namespace (..))
import Temporal.Core.Client (RpcError)
import qualified Temporal.Core.Client as Core
import qualified Temporal.Core.Client.WorkflowService as CoreWS
import Temporal.Exception (coreRpcErrorToRpcError)
import Temporal.Payload (convertToProtoPayload, processorEncodePayloads, withArgs, (:->:))
import Temporal.Timestamp (protoToUTCTime)
import Temporal.Workflow (KnownSignal (..), SignalArgs, SignalRef (..))
import UnliftIO (MonadIO, liftIO, throwIO)


-- | Unique identifier for a batch operation job.
newtype BatchJobId = BatchJobId {unBatchJobId :: Text}
  deriving stock (Show, Eq, Ord)


{- | Human-readable reason for a batch operation.

Used to provide context for why a batch operation was started or stopped,
which is useful for auditing and debugging purposes.
-}
newtype Reason = Reason {unReason :: Text}
  deriving stock (Show, Eq, Ord)
  deriving newtype (IsString)


{- | Current state of a batch operation.

Batch operations progress through these states as they execute.
-}
data BatchOperationState
  = -- | State is unspecified or unknown
    BatchStateUnspecified
  | -- | Batch operation is currently running
    BatchStateRunning
  | -- | Batch operation completed successfully
    BatchStateCompleted
  | -- | Batch operation failed
    BatchStateFailed
  deriving stock (Show, Eq, Ord)


{- | Information about a batch operation.

Contains basic metadata about the operation's state and timing.
-}
data BatchOperationInfo = BatchOperationInfo
  { jobId :: !BatchJobId
  -- ^ Unique identifier for this batch job
  , state :: !BatchOperationState
  -- ^ Current state of the batch operation
  , startTime :: !(Maybe UTCTime)
  -- ^ When the batch operation started
  , closeTime :: !(Maybe UTCTime)
  -- ^ When the batch operation completed or failed
  }
  deriving stock (Show, Eq)


{- | Options for listing batch operations.

These options control filtering and pagination of batch operation results.
-}
data ListBatchOptions = ListBatchOptions
  { pageSize :: !Int32
  -- ^ Maximum number of results per page
  , nextPageToken :: !(Maybe Text)
  -- ^ Token for fetching the next page of results
  }
  deriving stock (Show, Eq)


-- | Default options for listing batch operations.
defaultListBatchOptions :: ListBatchOptions
defaultListBatchOptions =
  ListBatchOptions
    { pageSize = 100
    , nextPageToken = Nothing
    }


{- | Start a batch terminate operation.

Terminates all workflow executions matching the visibility query.

@
let query = AndQuery
      [ WorkflowTypeQuery "MyWorkflow"
      , StatusQuery Running
      ]
-- Server generates a job ID
startBatchTerminate query "Emergency shutdown" Nothing
-- Or provide your own job ID for tracking/idempotency
startBatchTerminate query "Emergency shutdown" (Just (BatchJobId "my-custom-job-id"))
@
-}
startBatchTerminate
  :: (HasWorkflowClient m, MonadIO m)
  => VisibilityQuery
  -> Reason
  -> Maybe BatchJobId
  -> m ()
startBatchTerminate query (Reason reason) mJobId = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient
  let terminationOp = defMessage & Batch.identity .~ Core.identity (Core.clientConfig clientCore)
      req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.visibilityQuery .~ renderQuery query
          & RR.jobId .~ maybe "" unBatchJobId mJobId
          & RR.reason .~ reason
          & RR.terminationOperation .~ terminationOp

  _ <- liftIO $ CoreWS.startBatchOperation clientCore req >>= handleRpcError
  pure ()


{- | Start a batch cancel operation.

Requests cancellation of all workflow executions matching the visibility query.

@
let query = WorkflowTypeQuery "LongRunningTask"
startBatchCancel query "Canceling long-running tasks" Nothing
@
-}
startBatchCancel
  :: (HasWorkflowClient m, MonadIO m)
  => VisibilityQuery
  -> Reason
  -> Maybe BatchJobId
  -> m ()
startBatchCancel query (Reason reason) mJobId = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient
  let cancellationOp = defMessage & Batch.identity .~ Core.identity (Core.clientConfig clientCore)
      req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.visibilityQuery .~ renderQuery query
          & RR.jobId .~ maybe "" unBatchJobId mJobId
          & RR.reason .~ reason
          & RR.cancellationOperation .~ cancellationOp

  _ <- liftIO $ CoreWS.startBatchOperation clientCore req >>= handleRpcError
  pure ()


{- | Start a batch signal operation.

Sends a signal to all workflow executions matching the visibility query.

This function uses the same signal encoding and interceptor logic as the regular
signal function, ensuring consistent behavior across the SDK.

@
let query = WorkflowTypeQuery "ProcessingJob"
startBatchSignal query mySignal "Updating configuration" Nothing arg1 arg2 arg3
@
-}
startBatchSignal
  :: forall sig m
   . (SignalRef sig, HasWorkflowClient m, MonadIO m)
  => VisibilityQuery
  -> sig
  -> Reason
  -> Maybe BatchJobId
  -> (SignalArgs sig :->: m ())
startBatchSignal query (signalRef -> KnownSignal sName sCodec) (Reason reason) mJobId = withArgs @(SignalArgs sig) @(m ()) sCodec $ \inputs -> do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns, payloadProcessor = processor}} <- askWorkflowClient
  -- Encode signal arguments using the payload processor
  inputs' <- processorEncodePayloads processor =<< liftIO (sequence inputs)

  let signalOp =
        defMessage
          & Batch.signal .~ sName
          & Batch.input .~ (defMessage & Common.vec'payloads .~ fmap convertToProtoPayload inputs')
      req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.visibilityQuery .~ renderQuery query
          & RR.jobId .~ maybe "" unBatchJobId mJobId
          & RR.reason .~ reason
          & RR.signalOperation .~ signalOp

  _ <- liftIO $ CoreWS.startBatchOperation clientCore req >>= handleRpcError
  pure ()


{- | Start a batch delete operation.

Deletes all closed workflow executions matching the visibility query.

Note: Only closed workflows can be deleted. This is useful for cleanup of old workflow data.

@
let query = RawQuery "CloseTime < '2023-01-01T00:00:00Z'"
startBatchDelete query "Cleaning up old workflows" Nothing
@
-}
startBatchDelete
  :: (HasWorkflowClient m, MonadIO m)
  => VisibilityQuery
  -> Reason
  -> Maybe BatchJobId
  -> m ()
startBatchDelete query (Reason reason) mJobId = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient
  let deletionOp = defMessage
      req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.visibilityQuery .~ renderQuery query
          & RR.jobId .~ maybe "" unBatchJobId mJobId
          & RR.reason .~ reason
          & RR.deletionOperation .~ deletionOp

  _ <- liftIO $ CoreWS.startBatchOperation clientCore req >>= handleRpcError
  pure ()


{- | Start a batch reset operation.

Resets all workflow executions matching the visibility query to a specific event.

@
let query = AndQuery
      [ WorkflowTypeQuery "MyWorkflow"
      , StatusQuery Failed
      ]
startBatchReset query "Resetting failed workflows" Nothing
@
-}
startBatchReset
  :: (HasWorkflowClient m, MonadIO m)
  => VisibilityQuery
  -> Reason
  -> Maybe BatchJobId
  -> m ()
startBatchReset query (Reason reason) mJobId = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient
  let resetOp =
        defMessage
          & Batch.resetType .~ ResetEnums.RESET_TYPE_FIRST_WORKFLOW_TASK
      req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.visibilityQuery .~ renderQuery query
          & RR.jobId .~ maybe "" unBatchJobId mJobId
          & RR.reason .~ reason
          & RR.resetOperation .~ resetOp

  _ <- liftIO $ CoreWS.startBatchOperation clientCore req >>= handleRpcError
  pure ()


{- | Stop a running batch operation.

This prevents the batch operation from processing any additional workflow executions,
but does not undo operations that have already been performed.

@
stopBatch jobId' "Operation no longer needed"
@
-}
stopBatch
  :: (HasWorkflowClient m, MonadIO m)
  => BatchJobId
  -> Reason
  -> m ()
stopBatch (BatchJobId jobId') (Reason reason) = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient
  let req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.jobId .~ jobId'
          & RR.reason .~ reason

  _ <- liftIO $ CoreWS.stopBatchOperation clientCore req >>= handleRpcError
  pure ()


{- | Get detailed information about a batch operation.

Returns the current state, progress statistics, and metadata.

@
info <- describeBatch jobId'
putStrLn $ "Job: " <> show (jobId info) <> ", State: " <> show (state info)
@
-}
describeBatch
  :: (HasWorkflowClient m, MonadIO m)
  => BatchJobId
  -> m BatchOperationInfo
describeBatch (BatchJobId jobId') = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient
  let req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.jobId .~ jobId'

  resp <- liftIO $ CoreWS.describeBatchOperation clientCore req >>= handleRpcError
  liftIO $ protoToBatchInfo resp


{- | List all batch operations in a namespace.

Results can be paginated using the options parameter.

@
let opts = defaultListBatchOptions
(operations, nextToken) <- listBatchOperations opts
@
-}
listBatchOperations
  :: (HasWorkflowClient m, MonadIO m)
  => ListBatchOptions
  -> m ([BatchOperationInfo], Maybe Text)
listBatchOperations opts = do
  WorkflowClient {clientCore, clientConfig = WorkflowClientConfig {namespace = ns}} <- askWorkflowClient
  let req =
        defMessage
          & RR.namespace .~ rawNamespace ns
          & RR.pageSize .~ pageSize opts
          & RR.nextPageToken .~ maybe BS.empty TE.encodeUtf8 (nextPageToken opts)

  resp <- liftIO $ CoreWS.listBatchOperations clientCore req >>= handleRpcError
  let operations = resp ^. RR.operationInfo
      nextToken =
        let token = TE.decodeUtf8 (resp ^. RR.nextPageToken)
        in if T.null token then Nothing else Just token

  let infos = map batchOpInfoFromProto operations
  pure (infos, nextToken)


-- | Convert protobuf BatchOperationInfo to domain type (from DescribeBatchOperationResponse)
protoToBatchInfo :: RR.DescribeBatchOperationResponse -> IO BatchOperationInfo
protoToBatchInfo resp = do
  let jobId' = resp ^. RR.jobId
      state' = protoToState (resp ^. RR.state)
      startTime' = fmap protoToUTCTime (resp ^. RR.maybe'startTime)
      closeTime' = fmap protoToUTCTime (resp ^. RR.maybe'closeTime)

  pure
    BatchOperationInfo
      { jobId = BatchJobId jobId'
      , state = state'
      , startTime = startTime'
      , closeTime = closeTime'
      }


-- | Convert Batch.BatchOperationInfo to domain type
batchOpInfoFromProto :: Batch.BatchOperationInfo -> BatchOperationInfo
batchOpInfoFromProto info =
  BatchOperationInfo
    { jobId = BatchJobId (info ^. Batch.jobId)
    , state = protoToState (info ^. Batch.state)
    , startTime = fmap protoToUTCTime (info ^. Batch.maybe'startTime)
    , closeTime = fmap protoToUTCTime (info ^. Batch.maybe'closeTime)
    }


-- | Convert protobuf state enum to domain type
protoToState :: Enums.BatchOperationState -> BatchOperationState
protoToState = \case
  Enums.BATCH_OPERATION_STATE_UNSPECIFIED -> BatchStateUnspecified
  Enums.BATCH_OPERATION_STATE_RUNNING -> BatchStateRunning
  Enums.BATCH_OPERATION_STATE_COMPLETED -> BatchStateCompleted
  Enums.BATCH_OPERATION_STATE_FAILED -> BatchStateFailed
  Enums.BatchOperationState'Unrecognized _ -> BatchStateUnspecified


-- | Handle RPC errors by converting and throwing them
handleRpcError :: Either Temporal.Core.Client.RpcError a -> IO a
handleRpcError (Right a) = pure a
handleRpcError (Left err) = throwIO $ coreRpcErrorToRpcError err

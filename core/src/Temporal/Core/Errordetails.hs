{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
module Temporal.Core.Errordetails where

import Data.ByteString (ByteString)
import Proto.Temporal.Api.Errordetails.V1.Message

-- TODO: 
data RpcErrorDetails =
    RED_CancellationAlreadyRequestedFailure CancellationAlreadyRequestedFailure
  | RED_ClientVersionNotSupportedFailure ClientVersionNotSupportedFailure
  | RED_MultiOperationExecutionFailure MultiOperationExecutionFailure
  | RED_MultiOperationExecutionFailure'OperationStatus MultiOperationExecutionFailure'OperationStatus
  | RED_NamespaceAlreadyExistsFailure NamespaceAlreadyExistsFailure
  | RED_NamespaceInvalidStateFailure NamespaceInvalidStateFailure
  | RED_NamespaceNotActiveFailure NamespaceNotActiveFailure
  | RED_NamespaceNotFoundFailure NamespaceNotFoundFailure
  | RED_NewerBuildExistsFailure NewerBuildExistsFailure
  | RED_NotFoundFailure NotFoundFailure
  | RED_PermissionDeniedFailure PermissionDeniedFailure
  | RED_QueryFailedFailure QueryFailedFailure
  | RED_ResourceExhaustedFailure ResourceExhaustedFailure
  | RED_ServerVersionNotSupportedFailure ServerVersionNotSupportedFailure
  | RED_SystemWorkflowFailure SystemWorkflowFailure
  | RED_WorkflowExecutionAlreadyStartedFailure WorkflowExecutionAlreadyStartedFailure
  | RED_WorkflowNotReadyFailure WorkflowNotReadyFailure
  | RED_UnknownErrordetails ByteString

{-# LANGUAGE TypeApplications #-}
module Temporal.Contrib.OpenTelemetry where

import Control.Monad.IO.Class
import qualified Data.Text as T
import qualified Data.HashMap.Strict as HashMap
import Data.Int
import Paths_temporal_sdk
import qualified OpenTelemetry.Context as Ctxt
import OpenTelemetry.Propagator
import OpenTelemetry.Trace.Core
import qualified Data.Map.Strict as Map
import Data.Version (showVersion)
import Temporal.Duration
import Temporal.Interceptor
import Temporal.Payload (RawPayload(..))
import OpenTelemetry.Propagator.W3CTraceContext
import OpenTelemetry.Context.ThreadLocal (adjustContext)
import Temporal.Workflow 
  ( WorkflowId(..)
  , RunId(..)
  , Info(..)
  , WorkflowType (..)
  , Namespace(..)
  , TaskQueue(..)
  , ParentInfo(..)
  )
import Temporal.Common

-- | "_tracer-data"
defaultHeaderKey :: T.Text
defaultHeaderKey = "_tracer-data"

data OpenTelemetryInterceptorOptions = OpenTelemetryInterceptorOptions
  { tracerProvider :: Maybe TracerProvider
  , headerKey :: T.Text
  }

defaultOpenTelemetryInterceptorOptions :: OpenTelemetryInterceptorOptions
defaultOpenTelemetryInterceptorOptions = OpenTelemetryInterceptorOptions
  { tracerProvider = Nothing
  , headerKey = defaultHeaderKey
  }

headersPropagator :: Propagator Ctxt.Context (Map.Map T.Text RawPayload) (Map.Map T.Text RawPayload)
headersPropagator = Propagator
  { propagatorNames = ["tracecontext"]
  , extractor = \hs c -> do
    let traceParentHeader = inputPayloadData <$> Map.lookup "traceparent" hs
        traceStateHeader = inputPayloadData <$> Map.lookup "tracestate" hs
        mspanContext = decodeSpanContext traceParentHeader traceStateHeader
    pure $! case mspanContext of
      Nothing -> c
      Just s -> Ctxt.insertSpan (wrapSpanContext (s {isRemote = True})) c

  , injector = \c hs -> case Ctxt.lookupSpan c of
    Nothing -> pure hs
    Just s -> do
      (traceParentHeader, traceStateHeader) <- encodeSpanContext s
      pure 
        $ Map.insert "traceparent" (RawPayload traceParentHeader mempty)
        $ Map.insert "tracestate" (RawPayload traceStateHeader mempty) hs
  }

-- TODO, we will need to account for replays when we support them
makeOpenTelemetryInterceptor :: MonadIO m => m Interceptors
makeOpenTelemetryInterceptor = do
  tracerProvider <- getGlobalTracerProvider
  let tracer = makeTracer 
        tracerProvider 
        (InstrumentationLibrary "temporal-sdk" (T.pack $ showVersion Paths_temporal_sdk.version))
        (TracerOptions Nothing)
  return $ Interceptors
    { workflowInboundInterceptors = WorkflowInboundInterceptor
      { executeWorkflow = \input next -> do
          execution <- next input
          ctxt <- extract headersPropagator input.executeWorkflowInputHeaders Ctxt.empty
          pure $ do
            workflowSpan <- createSpanWithoutCallStack
              tracer
              ctxt
              ("RunWorkflow:" <> input.executeWorkflowInputType) 
              (defaultSpanArguments 
                { kind = Server 
                , attributes = HashMap.fromList $
                  concat
                    [ 
                      [ ("temporal.workflow_id", toAttribute $ rawWorkflowId $ input.executeWorkflowInputInfo.workflowId)
                      , ("temporal.run_id", toAttribute $ rawRunId $ input.executeWorkflowInputInfo.runId)
                      , ("temporal.workflow_type", toAttribute $ input.executeWorkflowInputType)
                      , ("temporal.attempt", toAttribute $ input.executeWorkflowInputInfo.attempt)
                      , ("temporal.namespace", toAttribute $ rawNamespace $ input.executeWorkflowInputInfo.namespace)
                      , ("temporal.task_queue", toAttribute $ rawTaskQueue $ input.executeWorkflowInputInfo.taskQueue)
                      ]
                    , maybe
                      []
                      (\executionTimeout -> [("temporal.execution_timeout_ms", toAttribute $ durationToMilliseconds executionTimeout )])
                      input.executeWorkflowInputInfo.executionTimeout
                    , maybe
                      []
                      (\continuedRunId -> 
                        [ ("temporal.continued_run_id", toAttribute $ rawRunId continuedRunId)
                        ])
                      input.executeWorkflowInputInfo.continuedRunId
                    , maybe
                      []
                      (\cronSchedule -> 
                        [("temporal.cron_schedule", toAttribute cronSchedule)]
                      )
                      input.executeWorkflowInputInfo.cronSchedule
                    , maybe 
                      [] 
                      (\parentInfo ->
                        [ ("temporal.parent.namespace", toAttribute $ rawNamespace $ parentInfo.parentNamespace)
                        , ("temporal.parent.run_id", toAttribute $ rawRunId $ parentInfo.parentRunId)
                        , ("temporal.parent.workflow_id", toAttribute $ rawWorkflowId $ parentInfo.parentWorkflowId)
                        ])
                      input.executeWorkflowInputInfo.parent
                    , maybe
                      []
                      (\retryPolicy ->
                        (maybe 
                          id
                          (\maxInterval -> (("temporal.retry_policy.maximum_interval_ms", toAttribute $ durationToMilliseconds $ maxInterval) :))
                          retryPolicy.maximumInterval
                        )
                        [ ("temporal.retry_policy.initial_interval_ms", toAttribute $ durationToMilliseconds $ retryPolicy.initialInterval)
                        , ("temporal.retry_policy.backoff_coefficient", toAttribute $ retryPolicy.backoffCoefficient)
                        , ("temporal.retry_policy.maximum_attempts", toAttribute $ fromIntegral @Int32 @Int $ retryPolicy.maximumAttempts)
                        ]
                      )
                      input.executeWorkflowInputInfo.retryPolicy
                    ]
                })
            adjustContext $ Ctxt.insertSpan workflowSpan
            execution
      }
    , workflowOutboundInterceptors = WorkflowOutboundInterceptor
    , activityInboundInterceptors = ActivityInboundInterceptor
    , activityOutboundInterceptors = ActivityOutboundInterceptor
    }
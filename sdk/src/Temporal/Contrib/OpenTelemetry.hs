{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeApplications #-}

{- |
Module: Temporal.Contrib.OpenTelemetry
Description: OpenTelemetry instrumentation for Temporal workflows and activities.

OpenTelemetry instrumentation for Temporal workflows and activities.

This module provides an interceptor for Temporal workflows and activities that
automatically instruments them with OpenTelemetry tracing. It also provides
functions for extracting and injecting OpenTelemetry context from and to
Temporal headers.

To use, initialize the OpenTelemetry 'globalTracerProvider'. Then, add
the interceptor to your Temporal client and worker configuration.
-}
module Temporal.Contrib.OpenTelemetry where

import Control.Monad (void)
import Control.Monad.Catch
import Control.Monad.IO.Class
import qualified Data.HashMap.Strict as HashMap
import Data.Int
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Vault.Strict as Vault
import Data.Word (Word32)
import GHC.IO (unsafePerformIO)
import OpenTelemetry.Context (Context)
import qualified OpenTelemetry.Context as Ctxt
import OpenTelemetry.Context.ThreadLocal (attachContext, getContext)
import OpenTelemetry.Propagator
import OpenTelemetry.Propagator.W3CBaggage (decodeBaggage, encodeBaggage)
import OpenTelemetry.Propagator.W3CTraceContext (decodeSpanContext, encodeSpanContext)
import OpenTelemetry.Trace.Core
import Temporal.Activity.Types
-- TODO rework WorkflowExitVariant to not expose internals
import qualified Temporal.Client.Types as C
import Temporal.Common
import Temporal.Duration
import Temporal.Interceptor
import Temporal.Payload (Payload (..))
import Temporal.Workflow (Workflow)
import Temporal.Workflow.Types
import Temporal.Workflow.Unsafe
import Prelude hiding (span)


-- | "_tracer-data"
defaultHeaderKey :: Text
defaultHeaderKey = "_tracer-data"


data OpenTelemetryInterceptorOptions = OpenTelemetryInterceptorOptions
  { tracerProvider :: Maybe TracerProvider
  , headerKey :: Text
  }


defaultOpenTelemetryInterceptorOptions :: OpenTelemetryInterceptorOptions
defaultOpenTelemetryInterceptorOptions =
  OpenTelemetryInterceptorOptions
    { tracerProvider = Nothing
    , headerKey = defaultHeaderKey
    }


headersPropagator :: Propagator Context (Map Text Payload) (Map Text Payload)
headersPropagator =
  Propagator
    { propagatorNames = ["tracecontext"]
    , extractor = \hs c -> do
        let traceParentHeader = payloadData <$> Map.lookup "traceparent" hs
            traceStateHeader = payloadData <$> Map.lookup "tracestate" hs
            mspanContext = decodeSpanContext traceParentHeader traceStateHeader
        pure $! case mspanContext of
          Nothing -> c
          Just s -> Ctxt.insertSpan (wrapSpanContext (s {isRemote = True})) c
    , injector = \c hs -> case Ctxt.lookupSpan c of
        Nothing -> pure hs
        Just s -> do
          (traceParentHeader, traceStateHeader) <- encodeSpanContext s
          pure
            . Map.insert "traceparent" (Payload traceParentHeader mempty)
            . Map.insert "tracestate" (Payload traceStateHeader mempty)
            $ hs
    }


headersBaggagePropagator :: Propagator Context (Map Text Payload) (Map Text Payload)
headersBaggagePropagator =
  Propagator
    { propagatorNames = ["baggage"]
    , extractor = \headers ctxt ->
        let payload = payloadData <$> Map.lookup "baggage" headers
        in pure $! case payload >>= decodeBaggage of
            Nothing -> ctxt
            Just baggage -> Ctxt.insertBaggage baggage ctxt
    , injector = \ctxt headers ->
        pure $! case Ctxt.lookupBaggage ctxt of
          Nothing -> headers
          Just baggage ->
            let payload = Payload (encodeBaggage baggage) mempty
            in Map.insert "baggage" payload headers
    }


tracerKey :: Vault.Key Tracer
tracerKey = unsafePerformIO Vault.newKey
{-# NOINLINE tracerKey #-}


{- | Run a (possibly suspending) workflow handler under a span.

If the incoming headers carry a remote trace context, the span is parented
there (linking the client's SignalWorkflow\/UpdateWorkflow span to the
handler); otherwise it is parented to the workflow's own context. The span
is inserted into the fiber-local OpenTelemetry context for the duration of
the handler, so spans created inside it (e.g. @StartActivity@) nest under
it — even across suspension points, since the scheduler snapshots and
restores the context per fiber.
-}
inWorkflowHandlerSpan :: Tracer -> Text -> SpanArguments -> Map Text Payload -> Workflow a -> Workflow a
inWorkflowHandlerSpan tracer spanName spanArgs headers action = do
  (span, prevCtxt) <- performUnsafeNonDeterministicIO $ do
    hdrCtxt <- extract headersPropagator headers Ctxt.empty
    prevCtxt <- getContext
    let parentCtxt = maybe prevCtxt (const hdrCtxt) (Ctxt.lookupSpan hdrCtxt)
    span <- createSpan tracer parentCtxt spanName spanArgs
    _ <- attachContext (Ctxt.insertSpan span parentCtxt)
    pure (span, prevCtxt)
  result <- Control.Monad.Catch.try action
  performUnsafeNonDeterministicIO $ do
    case result of
      Left err -> do
        setStatus span (Error $ T.pack $ show err)
        recordException span mempty Nothing err
      Right _ -> pure ()
    endSpan span Nothing
    _ <- attachContext prevCtxt
    pure ()
  either (throwM @_ @SomeException) pure result


--    * Workflow is scheduled by a client
--    */
--   WORKFLOW_START = 'StartWorkflow',

--   /**
--    * Workflow is client calls signalWithStart
--    */
--   WORKFLOW_SIGNAL_WITH_START = 'SignalWithStartWorkflow',

--   /**
--    * Workflow run is executing
--    */
--   WORKFLOW_EXECUTE = 'RunWorkflow',
--   /**
--    * Child Workflow is started (by parent Workflow)
--    */
--   CHILD_WORKFLOW_START = 'StartChildWorkflow',
--   /**
--    * Activity is scheduled by a Workflow
--    */
--   ACTIVITY_START = 'StartActivity',
--   /**
--    * Activity is executing
--    */
--   ACTIVITY_EXECUTE = 'RunActivity',
--   /**
--    * Workflow is continuing as new
--    */
-- CONTINUE_AS_NEW = 'ContinueAsNew',

-- TODO, we will need to account for replays when we support them
makeOpenTelemetryInterceptor :: MonadIO m => m (Interceptors env)
makeOpenTelemetryInterceptor = makeOpenTelemetryInterceptorWithOptions defaultOpenTelemetryInterceptorOptions


{- | Like 'makeOpenTelemetryInterceptor', but allows configuring the
'TracerProvider' instead of implicitly using the global one. Useful for
tests and applications that manage tracer providers explicitly.
-}
makeOpenTelemetryInterceptorWithOptions :: MonadIO m => OpenTelemetryInterceptorOptions -> m (Interceptors env)
makeOpenTelemetryInterceptorWithOptions opts = do
  tracerProvider <- maybe getGlobalTracerProvider pure opts.tracerProvider
  let tracer =
        makeTracer
          tracerProvider
          "temporal-sdk"
          (TracerOptions Nothing)
  pure $
    Interceptors
      { workflowInboundInterceptors =
          WorkflowInboundInterceptor
            { executeWorkflow = \input next -> do
                ctxt <- extract headersPropagator input.executeWorkflowInputHeaders Ctxt.empty
                _ <- attachContext ctxt
                let spanArgs =
                      defaultSpanArguments
                        { kind = Server
                        , attributes =
                            HashMap.fromList $
                              concat
                                [
                                  [ ("temporal.workflow_id", toAttribute $ rawWorkflowId input.executeWorkflowInputInfo.workflowId)
                                  , ("temporal.run_id", toAttribute $ rawRunId input.executeWorkflowInputInfo.runId)
                                  , ("temporal.workflow_type", toAttribute $ rawWorkflowType input.executeWorkflowInputType)
                                  , ("temporal.attempt", toAttribute input.executeWorkflowInputInfo.attempt)
                                  , ("temporal.namespace", toAttribute $ rawNamespace input.executeWorkflowInputInfo.namespace)
                                  , ("temporal.task_queue", toAttribute $ rawTaskQueue input.executeWorkflowInputInfo.taskQueue)
                                  ]
                                , maybe
                                    []
                                    (\executionTimeout -> [("temporal.execution_timeout_ms", toAttribute $ durationToMilliseconds executionTimeout)])
                                    input.executeWorkflowInputInfo.executionTimeout
                                , maybe
                                    []
                                    ( \continuedRunId ->
                                        [ ("temporal.continued_run_id", toAttribute $ rawRunId continuedRunId)
                                        ]
                                    )
                                    input.executeWorkflowInputInfo.continuedRunId
                                , maybe
                                    []
                                    ( \cronSchedule ->
                                        [("temporal.cron_schedule", toAttribute cronSchedule)]
                                    )
                                    input.executeWorkflowInputInfo.cronSchedule
                                , maybe
                                    []
                                    ( \parentInfo ->
                                        [ ("temporal.parent.namespace", toAttribute $ rawNamespace parentInfo.parentNamespace)
                                        , ("temporal.parent.run_id", toAttribute $ rawRunId parentInfo.parentRunId)
                                        , ("temporal.parent.workflow_id", toAttribute $ rawWorkflowId parentInfo.parentWorkflowId)
                                        ]
                                    )
                                    input.executeWorkflowInputInfo.parent
                                , maybe
                                    []
                                    ( \retryPolicy ->
                                        maybe
                                          id
                                          (\maxInterval -> (("temporal.retry_policy.maximum_interval_ms", toAttribute $ durationToMilliseconds maxInterval) :))
                                          retryPolicy.maximumInterval
                                          [ ("temporal.retry_policy.initial_interval_ms", toAttribute $ durationToMilliseconds retryPolicy.initialInterval)
                                          , ("temporal.retry_policy.backoff_coefficient", toAttribute retryPolicy.backoffCoefficient)
                                          , ("temporal.retry_policy.maximum_attempts", toAttribute $ fromIntegral @Int32 @Int $ retryPolicy.maximumAttempts)
                                          ]
                                    )
                                    input.executeWorkflowInputInfo.retryPolicy
                                ]
                        }
                inSpan'' tracer ("RunWorkflow:" <> rawWorkflowType input.executeWorkflowInputType) spanArgs $ \span -> do
                  execution <- next input
                  case execution of
                    WorkflowExitFailed e -> do
                      -- TODO use our enrichment handlers here
                      setStatus span (Error $ T.pack $ show e)
                      recordException span mempty Nothing e
                    _ -> pure ()
                  pure execution
            , handleQuery = \input next -> do
                -- Only trace this if there is a header, and make that span the parent.
                -- We do not put anything that happens in a query handler on the workflow
                -- span.
                --
                -- However, we do _link_ the query span to the workflow span if we have the
                -- context for it.
                let spanArgs =
                      defaultSpanArguments
                        { kind = Server
                        , attributes = mempty
                        -- HashMap.fromList
                        --   [ ("temporal.workflow_id", toAttribute $ rawWorkflowId $ input.handleQueryInputInfo.workflowId)
                        --   , ("temporal.run_id", toAttribute $ rawRunId $ input.handleQueryInputInfo.runId)
                        --   , ("temporal.workflow_type", toAttribute $ input.handleQueryInputType)
                        --   ]
                        }
                ctxt <- extract headersPropagator input.handleQueryInputHeaders Ctxt.empty
                _ <- attachContext ctxt
                case Ctxt.lookupSpan ctxt of
                  Nothing -> next input
                  Just _ ->
                    inSpan'' tracer ("HandleQuery:" <> input.handleQueryInputType) spanArgs $ \_ -> do
                      next input
            , handleUpdate = \input next -> do
                -- Run the whole (possibly suspending) update handler under a
                -- HandleUpdate span. If the client propagated a trace context
                -- in the update headers, it becomes the parent; otherwise the
                -- span is parented to the workflow's context. Spans created
                -- inside the handler nest under it via the fiber-local
                -- context.
                let spanArgs =
                      defaultSpanArguments
                        { kind = Server
                        , attributes =
                            HashMap.fromList
                              [ ("temporal.update_id", toAttribute $ rawUpdateId input.handleUpdateId)
                              , ("temporal.update_type", toAttribute input.handleUpdateInputType)
                              , ("temporal.workflow_id", toAttribute $ rawWorkflowId input.handleUpdateWorkflowInfo.workflowId)
                              , ("temporal.run_id", toAttribute $ rawRunId input.handleUpdateWorkflowInfo.runId)
                              ]
                        }
                inWorkflowHandlerSpan tracer ("HandleUpdate:" <> input.handleUpdateInputType) spanArgs input.handleUpdateInputHeaders $
                  next input
            , handleSignal = \input next -> do
                let spanArgs =
                      defaultSpanArguments
                        { kind = Server
                        , attributes =
                            HashMap.fromList
                              [ ("temporal.signal_type", toAttribute input.handleSignalInputType)
                              , ("temporal.workflow_id", toAttribute $ rawWorkflowId input.handleSignalWorkflowInfo.workflowId)
                              , ("temporal.run_id", toAttribute $ rawRunId input.handleSignalWorkflowInfo.runId)
                              ]
                        }
                inWorkflowHandlerSpan tracer ("HandleSignal:" <> input.handleSignalInputType) spanArgs input.handleSignalInputHeaders $
                  next input
            , validateUpdate = \input next -> do
                let spanArgs =
                      defaultSpanArguments
                        { kind = Server
                        , attributes =
                            HashMap.fromList
                              [ ("temporal.update_id", toAttribute $ rawUpdateId input.handleUpdateId)
                              , ("temporal.update_type", toAttribute input.handleUpdateInputType)
                              ]
                        }
                prevCtxt <- getContext
                hdrCtxt <- extract headersPropagator input.handleUpdateInputHeaders Ctxt.empty
                let parentCtxt = maybe prevCtxt (const hdrCtxt) (Ctxt.lookupSpan hdrCtxt)
                _ <- attachContext parentCtxt
                ( inSpan'' tracer ("ValidateUpdate:" <> input.handleUpdateInputType) spanArgs $ \_ ->
                    next input
                  )
                  `Control.Monad.Catch.finally` void (attachContext prevCtxt)
            }
      , workflowOutboundInterceptors =
          WorkflowOutboundInterceptor
            { scheduleActivity = \input next -> do
                let StartActivityOptions {..} = input.options
                    spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        }
                inSpan'' tracer ("StartActivity:" <> input.activityType) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt headers
                  next $ input {options = StartActivityOptions {headers = hdrs, ..}}
            , continueAsNew = \n ContinueAsNewOptions {..} next -> do
                ctxt <- getContext
                hdrs <- inject headersPropagator ctxt headers
                next n (ContinueAsNewOptions {headers = hdrs, ..})
            , startChildWorkflowExecution = \wfName input next -> do
                let StartChildWorkflowOptions {..} = input
                    spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        }
                inSpan'' tracer ("StartChildWorkflow:" <> wfName) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt headers
                  next wfName $ StartChildWorkflowOptions {headers = hdrs, ..}
            , scheduleLocalActivity = \input next -> do
                let StartLocalActivityOptions {..} = input.localOptions
                    spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        }
                inSpan'' tracer ("StartLocalActivity:" <> input.localActivityType) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt headers
                  next $ input {localOptions = StartLocalActivityOptions {headers = hdrs, ..}}
            }
      , activityInboundInterceptors =
          ActivityInboundInterceptor
            { executeActivity = \env input next -> do
                let ActivityInfo {..} = input.activityInfo
                    spanArgs =
                      defaultSpanArguments
                        { kind = Server
                        , attributes =
                            HashMap.fromList
                              [ ("temporal.workflow_id", toAttribute $ rawWorkflowId workflowId)
                              , ("temporal.workflow_type", toAttribute $ rawWorkflowType workflowType)
                              , ("temporal.run_id", toAttribute $ rawRunId runId)
                              , ("temporal.activity_id", toAttribute $ rawActivityId activityId)
                              , ("temporal.activity_type", toAttribute activityType)
                              , ("temporal.attempt", toAttribute $ fromIntegral @Word32 @Int attempt)
                              , -- , ("temporal.namespace", toAttribute $ rawNamespace $ input.activityInfo.namespace)
                                ("temporal.activity_is_local", toAttribute isLocal)
                              , ("temporal.task_queue", toAttribute $ rawTaskQueue taskQueue)
                              ]
                        }

                ctxt <- extract headersPropagator input.activityHeaders Ctxt.empty
                _ <- attachContext ctxt
                inSpan'' tracer ("RunActivity:" <> input.activityInfo.activityType) spanArgs $ \_span -> do
                  next env input
            }
      , activityOutboundInterceptors = ActivityOutboundInterceptor
      , clientInterceptors =
          ClientInterceptors
            { start = \ty wfId StartWorkflowOptions {..} ps next -> do
                let spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        , attributes =
                            HashMap.fromList
                              [ ("temporal.task_queue", toAttribute $ rawTaskQueue taskQueue)
                              , ("temporal.workflow_id", toAttribute $ rawWorkflowId wfId)
                              , ("temporal.workflow_type", toAttribute $ rawWorkflowType ty)
                              ]
                        }
                inSpan'' tracer ("StartWorkflow:" <> rawWorkflowType ty) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt headers
                  next ty wfId (StartWorkflowOptions {headers = hdrs, ..}) ps
            , queryWorkflow = \input next -> do
                let spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        }
                inSpan'' tracer ("QueryWorkflow:" <> queryWorkflowType input) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt input.queryWorkflowHeaders
                  next (input {queryWorkflowHeaders = hdrs})
            , signalWithStart = \input next -> do
                let spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        }
                inSpan'' tracer ("SignalWithStartWorkflow:" <> rawWorkflowType (signalWithStartWorkflowType input)) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt input.signalWithStartOptions.headers
                  next (input {signalWithStartOptions = (signalWithStartOptions input) {C.headers = hdrs}})
            , updateWorkflow = \input next -> do
                let spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        }
                inSpan'' tracer ("UpdateWorkflow:" <> updateWorkflowType input) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt input.updateWorkflowHeaders
                  next (input {updateWorkflowHeaders = hdrs})
            , signal = \input next -> do
                let spanArgs =
                      defaultSpanArguments
                        { kind = Client
                        , attributes =
                            HashMap.fromList
                              [ ("temporal.workflow_id", toAttribute $ rawWorkflowId input.signalWorkflowWorkflowId)
                              , ("temporal.signal_type", toAttribute input.signalWorkflowSignalName)
                              ]
                        }
                inSpan'' tracer ("SignalWorkflow:" <> input.signalWorkflowSignalName) spanArgs $ \_ -> do
                  ctxt <- getContext
                  hdrs <- inject headersPropagator ctxt input.signalWorkflowHeaders
                  next (input {signalWorkflowHeaders = hdrs})
            }
      , -- Not really anything to do here since new cron jobs should be in their own context
        scheduleClientInterceptors = mempty
      , interceptorVault = Vault.insert tracerKey tracer mempty
      }

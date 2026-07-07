{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

{- | End-to-end assertions on the OpenTelemetry spans produced by the SDK
interceptors.

These tests install an in-memory synchronous span processor as the global
tracer provider so that the interceptor installed by 'TestHelpers.setup'
records real spans. They exercise the per-fiber OpenTelemetry context that
the delimited-continuation scheduler maintains: handler spans must join the
client's trace via propagated headers, and spans created inside a
(suspendable) update/signal handler must nest under the handler's span
rather than leaking onto the workflow's main fiber.
-}
module OpenTelemetrySpec where

import Control.Concurrent.Async (async)
import Control.Exception (SomeException, finally)
import Data.IORef
import Data.Text (Text)
import qualified Data.Text as Text
import GHC.IO (unsafePerformIO)
import OpenTelemetry.Internal.Common.Types (ShutdownResult (..))
import OpenTelemetry.Processor.Span (SpanProcessor (..))
import OpenTelemetry.Trace.Core
import RequireCallStack (provideCallStack)
import Temporal.Activity
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


-- | All spans ended while the capture provider is installed, newest first.
capturedSpans :: IORef [ImmutableSpan]
capturedSpans = unsafePerformIO (newIORef [])
{-# NOINLINE capturedSpans #-}


{- | A fully synchronous span processor: spans land in 'capturedSpans' the
moment they end, so tests can assert without polling.
-}
captureProcessor :: SpanProcessor
captureProcessor =
  SpanProcessor
    { spanProcessorOnStart = \_ _ -> pure ()
    , spanProcessorOnEnd = \spanRef -> do
        s <- readIORef spanRef
        modifyIORef' capturedSpans (s :)
    , spanProcessorShutdown = async (pure ShutdownSuccess)
    , spanProcessorForceFlush = pure ()
    }


withCaptureTracerProvider :: IO () -> IO ()
withCaptureTracerProvider action = do
  prev <- getGlobalTracerProvider
  tp <- createTracerProvider [captureProcessor] emptyTracerProviderOptions
  setGlobalTracerProvider tp
  action `finally` setGlobalTracerProvider prev


drainSpans :: IO ()
drainSpans = writeIORef capturedSpans []


spanNamed :: Text -> IO ImmutableSpan
spanNamed name = do
  spans <- readIORef capturedSpans
  case filter (\s -> spanName s == name) spans of
    (s : _) -> pure s
    [] -> do
      expectationFailure $
        "no span named " <> Text.unpack name <> "; captured: " <> show (map spanName spans)
      error "unreachable"


parentSpanContext :: ImmutableSpan -> IO SpanContext
parentSpanContext s = case spanParent s of
  Nothing -> do
    expectationFailure $ "span " <> Text.unpack (spanName s) <> " has no parent"
    error "unreachable"
  Just p -> getSpanContext p


shouldBeChildOf :: ImmutableSpan -> ImmutableSpan -> Expectation
shouldBeChildOf child parent = do
  traceId (spanContext child) `shouldBe` traceId (spanContext parent)
  parentCtx <- parentSpanContext child
  spanId parentCtx `shouldBe` spanId (spanContext parent)


spec :: Spec
spec = aroundAll_ withCaptureTracerProvider $ withTestServer_ tests


tests :: SpecWith TestEnv
tests = describe "OpenTelemetry spans" $ do
  it "parents update handler spans to the client and nests activity spans inside them" $ \TestEnv {..} -> do
    drainSpans
    let addOneAct :: Int -> Activity () Int
        addOneAct n = pure (n + 1)
        actDef = provideActivity defaultCodec "otelAddOne" addOneAct
        updateDef :: W.KnownUpdate '[Int] Int SomeException
        updateDef = W.KnownUpdate {knownUpdateCodec = defaultCodec, knownUpdateName = "otelActUpdate"}
        workflow :: MyWorkflow Int
        workflow = do
          st <- W.newStateVar (0 :: Int)
          W.setUpdateHandler
            updateDef
            ( \n -> do
                result <-
                  W.executeActivity
                    actDef.reference
                    (W.defaultStartActivityOptions $ W.StartToClose $ seconds 5)
                    n
                W.writeStateVar st result
                pure result
            )
            Nothing
          W.waitCondition $ (/= 0) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "otelUpdateWithActivity" workflow
        conf = provideCallStack $ configure () (wf, actDef) $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
          updateOpts = C.UpdateOptions {updateId = "otel-act-update", updateHeaders = mempty}
      (ur, wr) <- useClient do
        h <- C.start wf.reference "otelUpdateWithActivityWf" opts
        updateResult <- C.executeUpdate h updateDef updateOpts 41
        wfResult <- C.waitWorkflowResult h
        pure (updateResult, wfResult)
      ur `shouldBe` 42
      wr `shouldBe` 42
    clientUpdate <- spanNamed "UpdateWorkflow:otelActUpdate"
    handleUpdate <- spanNamed "HandleUpdate:otelActUpdate"
    startActivity <- spanNamed "StartActivity:otelAddOne"
    runActivity <- spanNamed "RunActivity:otelAddOne"
    -- The handler span joins the client's trace through the update headers.
    handleUpdate `shouldBeChildOf` clientUpdate
    -- The activity scheduled inside the (suspending) update handler nests
    -- under the HandleUpdate span via the fiber-local context, not under
    -- the workflow's own span.
    startActivity `shouldBeChildOf` handleUpdate
    -- And the activity execution continues that same trace.
    runActivity `shouldBeChildOf` startActivity

  it "parents signal handler spans to the client's SignalWorkflow span" $ \TestEnv {..} -> do
    drainSpans
    let unblockSig = W.KnownSignal @'[] "otelUnblock" defaultCodec
        workflow :: W.Workflow ()
        workflow = provideCallStack $ do
          st <- W.newStateVar False
          W.setSignalHandler unblockSig $ W.writeStateVar st True
          W.waitCondition (W.readStateVar st)
        wf = W.provideWorkflow defaultCodec "otelSignalWorkflow" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient (C.start wf.reference "otelSignal" opts)
      waitForWorkflowStart wfH
      C.signal wfH unblockSig C.defaultSignalOptions
      C.waitWorkflowResult wfH `shouldReturn` ()
    clientSignal <- spanNamed "SignalWorkflow:otelUnblock"
    handleSignal <- spanNamed "HandleSignal:otelUnblock"
    handleSignal `shouldBeChildOf` clientSignal

  it "keeps buffered signalWithStart signals in the workflow's trace" $ \TestEnv {..} -> do
    drainSpans
    let intSig = W.KnownSignal @'[Int] "otelBufferedSig" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar ([] :: [Int])
          W.setSignalHandler intSig $ \n -> W.modifyStateVar st (<> [n])
          W.waitCondition $ not . null <$> W.readStateVar st
          sum <$> W.readStateVar st
        wf = W.provideWorkflow defaultCodec "otelBufferedSignal" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient $ C.signalWithStart wf "otelBufferedSignal" opts intSig 7
      C.waitWorkflowResult wfH `shouldReturn` 7
    -- The signal is delivered before the handler is registered, so it is
    -- buffered and replayed through the interceptor when setSignalHandler
    -- runs. SignalWithStart cannot carry per-signal headers at the proto
    -- level, so the handler span parents to the workflow's own context,
    -- which itself joins the client's SignalWithStartWorkflow trace via the
    -- workflow start headers.
    clientSws <- spanNamed "SignalWithStartWorkflow:otelBufferedSignal"
    runWorkflow <- spanNamed "RunWorkflow:otelBufferedSignal"
    handleSignal <- spanNamed "HandleSignal:otelBufferedSig"
    runWorkflow `shouldBeChildOf` clientSws
    handleSignal `shouldBeChildOf` runWorkflow

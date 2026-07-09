module ReplaySpec where

import Control.Monad (void, when)
import qualified Control.Monad.Catch as Catch
import Data.Either (isLeft, isRight)
import Data.ProtoLens.Encoding (encodeMessage)
import qualified Data.Text as Text
import Data.Word (Word32)
import Lens.Family2 ((&), (.~), (^.))
import qualified Proto.Temporal.Api.History.V1.Message_Fields as HistoryF
import qualified Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields as SdkMetaF
import RequireCallStack (provideCallStack)
import System.Directory (getTemporaryDirectory, removeFile)
import Temporal.Activity
import qualified Temporal.Client as C
import qualified Temporal.Core.Worker as Core
import Temporal.Duration
import Temporal.Payload
import Temporal.Replay (readHistoryProtobufFile, writeHistoryProtobufFile)
import Temporal.Worker
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


replayActivity :: Activity () Int
replayActivity = pure 1


replayActivityDef :: ProvidedActivity () (Activity () Int)
replayActivityDef = provideActivity JSON "replayAct" replayActivity


tests :: SpecWith TestEnv
tests = describe "Workflow Replay" $ do
  specify "compatible replay succeeds" $ \TestEnv {..} -> do
    let originalWorkflow :: W.ProvidedWorkflow (W.Workflow ())
        originalWorkflow = W.provideWorkflow JSON "replay-wf" $ provideCallStack $ do
          W.sleep $ milliseconds 10
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          W.sleep $ milliseconds 10
        defs = (replayActivityDef, originalWorkflow)
        originalConf = provideCallStack $ configure () defs baseConf

    history <- withWorker originalConf $ do
      uuid <- uuidText
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient $ do
        wfHandle <- C.start originalWorkflow (W.WorkflowId uuid) opts
        C.waitWorkflowResult wfHandle
        C.fetchHistory wfHandle

    replayResult <- runReplayHistory globalRuntime originalConf history
    replayResult `shouldSatisfy` isRight

  specify "patched replay succeeds" $ \TestEnv {..} -> do
    let originalWorkflow :: W.ProvidedWorkflow (W.Workflow ())
        originalWorkflow = W.provideWorkflow JSON "replay-patch-wf" $ provideCallStack $ do
          W.sleep $ milliseconds 10
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          W.sleep $ milliseconds 10
        originalDefs = (replayActivityDef, originalWorkflow)
        originalConf = provideCallStack $ configure () originalDefs baseConf

    history <- withWorker originalConf $ do
      uuid <- uuidText
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient $ do
        wfHandle <- C.start originalWorkflow (W.WorkflowId uuid) opts
        C.waitWorkflowResult wfHandle
        C.fetchHistory wfHandle

    let patchedWorkflow :: W.ProvidedWorkflow (W.Workflow ())
        patchedWorkflow = W.provideWorkflow JSON "replay-patch-wf" $ provideCallStack $ do
          W.sleep $ milliseconds 10
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          hasPatch <- W.patched "new-feature"
          when hasPatch $
            void $
              W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          W.sleep $ milliseconds 10
        patchedDefs = (replayActivityDef, patchedWorkflow)
        patchedConf = configure () patchedDefs baseConf

    patchedResult <- runReplayHistory globalRuntime patchedConf history
    patchedResult `shouldSatisfy` isRight

  specify "incompatible replay fails" $ \TestEnv {..} -> do
    let originalWorkflow :: W.ProvidedWorkflow (W.Workflow ())
        originalWorkflow = W.provideWorkflow JSON "replay-incompat-wf" $ provideCallStack $ do
          W.sleep $ milliseconds 10
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          W.sleep $ milliseconds 10
        originalDefs = (replayActivityDef, originalWorkflow)
        originalConf = provideCallStack $ configure () originalDefs baseConf

    history <- withWorker originalConf $ do
      uuid <- uuidText
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient $ do
        wfHandle <- C.start originalWorkflow (W.WorkflowId uuid) opts
        C.waitWorkflowResult wfHandle
        C.fetchHistory wfHandle

    let incompatibleWorkflow :: W.ProvidedWorkflow (W.Workflow ())
        incompatibleWorkflow = W.provideWorkflow JSON "replay-incompat-wf" $ provideCallStack $ do
          W.sleep $ milliseconds 10
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          W.sleep $ milliseconds 10
        incompatibleDefs = (replayActivityDef, incompatibleWorkflow)
        incompatibleConf = configure () incompatibleDefs baseConf

    incompatibleResult <- runReplayHistory globalRuntime incompatibleConf history
    incompatibleResult `shouldSatisfy` isLeft

  specify "replay from protobuf file round-trip" $ \TestEnv {..} -> do
    let workflow :: W.ProvidedWorkflow (W.Workflow ())
        workflow = W.provideWorkflow JSON "replay-file-wf" $ provideCallStack $ do
          W.sleep $ milliseconds 10
        conf = provideCallStack $ configure () workflow baseConf

    history <- withWorker conf $ do
      uuid <- uuidText
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient $ do
        wfHandle <- C.start workflow (W.WorkflowId uuid) opts
        C.waitWorkflowResult wfHandle
        C.fetchHistory wfHandle

    tmpDir <- getTemporaryDirectory
    let filePath = tmpDir ++ "/temporal-replay-test-history.bin"
    writeHistoryProtobufFile filePath history
    loadedHistory <- readHistoryProtobufFile filePath
    removeFile filePath
    replayResult <- runReplayHistory globalRuntime conf loadedHistory
    replayResult `shouldSatisfy` isRight

  specify "replay multiple histories sequentially" $ \TestEnv {..} -> do
    let mkWorkflow name = W.provideWorkflow JSON name $ provideCallStack $ do
          W.sleep $ milliseconds 10
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          pure ()
        wf1 = mkWorkflow "replay-multi-1"
        wf2 = mkWorkflow "replay-multi-2"
        conf = provideCallStack $ configure () (replayActivityDef, wf1, wf2) baseConf

    (h1, h2) <- withWorker conf $ do
      uuid1 <- uuidText
      uuid2 <- uuidText
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient $ do
        handle1 <- C.start wf1 (W.WorkflowId uuid1) opts
        handle2 <- C.start wf2 (W.WorkflowId uuid2) opts
        C.waitWorkflowResult handle1
        C.waitWorkflowResult handle2
        (,) <$> C.fetchHistory handle1 <*> C.fetchHistory handle2

    r1 <- runReplayHistory globalRuntime conf h1
    r1 `shouldSatisfy` isRight
    r2 <- runReplayHistory globalRuntime conf h2
    r2 `shouldSatisfy` isRight

  specify "incompatible replay returns structured error" $ \TestEnv {..} -> do
    let originalWorkflow :: W.ProvidedWorkflow (W.Workflow ())
        originalWorkflow = W.provideWorkflow JSON "replay-error-wf" $ provideCallStack $ do
          W.sleep $ milliseconds 10
        originalConf = provideCallStack $ configure () originalWorkflow baseConf

    history <- withWorker originalConf $ do
      uuid <- uuidText
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
      useClient $ do
        wfHandle <- C.start originalWorkflow (W.WorkflowId uuid) opts
        C.waitWorkflowResult wfHandle
        C.fetchHistory wfHandle

    let modifiedWorkflow :: W.ProvidedWorkflow (W.Workflow ())
        modifiedWorkflow = W.provideWorkflow JSON "replay-error-wf" $ provideCallStack $ do
          _ <- W.executeActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
          W.sleep $ milliseconds 10
        modifiedConf = provideCallStack $ configure () (replayActivityDef, modifiedWorkflow) baseConf

    result <- runReplayHistory globalRuntime modifiedConf history
    result `shouldSatisfy` isLeft
    case result of
      Left err -> err.message `shouldSatisfy` (not . Text.null)
      Right () -> expectationFailure "Expected replay failure"

  describe "Replay from raw protobuf bytes" $ do
    specify "replays a simple workflow" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow ())
          workflow = W.provideWorkflow JSON "replay-proto-wf" $ provideCallStack $ do
            W.sleep $ milliseconds 10
          conf = provideCallStack $ configure () workflow baseConf

      history <- withWorker conf $ do
        uuid <- uuidText
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
        useClient $ do
          wfHandle <- C.start workflow (W.WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      result <- runReplayHistoryProto globalRuntime conf (WorkflowId "replay-proto") (encodeMessage history)
      result `shouldSatisfy` isRight

    specify "replays a workflow with activities" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow Int)
          workflow = W.provideWorkflow JSON "replay-proto-act-wf" $ provideCallStack $ do
            W.sleep $ milliseconds 10
            h <- W.startActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            W.wait h
          conf = provideCallStack $ configure () (replayActivityDef, workflow) baseConf

      history <- withWorker conf $ do
        uuid <- uuidText
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
        useClient $ do
          wfHandle <- C.start workflow (W.WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      result <- runReplayHistoryProto globalRuntime conf (WorkflowId "replay-proto-act") (encodeMessage history)
      result `shouldSatisfy` isRight

    specify "rejects invalid protobuf bytes" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow ())
          workflow = W.provideWorkflow JSON "replay-proto-invalid-wf" $ provideCallStack $ pure ()
          conf = provideCallStack $ configure () workflow baseConf
      result <- runReplayHistoryProto globalRuntime conf (WorkflowId "fake-wf-id") "this is not valid protobuf"
      result `shouldSatisfy` isLeft

  describe "Replay from JSON history" $ do
    specify "replays a simple workflow via JSON" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow ())
          workflow = W.provideWorkflow JSON "replay-json-wf" $ provideCallStack $ do
            W.sleep $ milliseconds 10
          conf = provideCallStack $ configure () workflow baseConf

      history <- withWorker conf $ do
        uuid <- uuidText
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
        useClient $ do
          wfHandle <- C.start workflow (W.WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      Right jsonBytes <- pure =<< Core.historyProtoToJson (encodeMessage history)
      result <- runReplayHistoryJson globalRuntime conf (WorkflowId "replay-json") jsonBytes
      result `shouldSatisfy` isRight

    specify "replays a workflow with activities via JSON" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow Int)
          workflow = W.provideWorkflow JSON "replay-json-act-wf" $ provideCallStack $ do
            W.sleep $ milliseconds 10
            h <- W.startActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            W.wait h
          conf = provideCallStack $ configure () (replayActivityDef, workflow) baseConf

      history <- withWorker conf $ do
        uuid <- uuidText
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
        useClient $ do
          wfHandle <- C.start workflow (W.WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      Right jsonBytes <- pure =<< Core.historyProtoToJson (encodeMessage history)
      result <- runReplayHistoryJson globalRuntime conf (WorkflowId "replay-json-act") jsonBytes
      result `shouldSatisfy` isRight

    specify "rejects invalid JSON" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow ())
          workflow = W.provideWorkflow JSON "replay-json-invalid-wf" $ provideCallStack $ pure ()
          conf = provideCallStack $ configure () workflow baseConf
      result <- runReplayHistoryJson globalRuntime conf (WorkflowId "fake-wf-id") "{ definitely not valid history json }"
      result `shouldSatisfy` isLeft

    specify "rejects empty JSON object" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow ())
          workflow = W.provideWorkflow JSON "replay-json-empty-wf" $ provideCallStack $ pure ()
          conf = provideCallStack $ configure () workflow baseConf
      result <- runReplayHistoryJson globalRuntime conf (WorkflowId "fake-wf-id") "{}"
      result `shouldSatisfy` isLeft

  describe "historyProtoToJson" $ do
    specify "converts proto bytes to valid JSON" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow Int)
          workflow = W.provideWorkflow JSON "replay-h2j-wf" $ provideCallStack $ do
            W.sleep $ milliseconds 10
            h <- W.startActivity replayActivityDef.reference (W.defaultStartActivityOptions $ W.StartToClose $ seconds 3)
            W.wait h
          conf = provideCallStack $ configure () (replayActivityDef, workflow) baseConf

      history <- withWorker conf $ do
        uuid <- uuidText
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 10)
        useClient $ do
          wfHandle <- C.start workflow (W.WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      result <- Core.historyProtoToJson (encodeMessage history)
      result `shouldSatisfy` isRight

    specify "rejects garbage proto bytes" $ \_env -> do
      result <- Core.historyProtoToJson "not valid protobuf at all"
      result `shouldSatisfy` isLeft

  describe "race loser cancellation SDK flag" $ do
    -- Contract: a live run of @race winner loser@ whose dropped loser has a
    -- finalizer records the race-loser-cancellation SDK flag (id 1) in
    -- history, so replays of that history keep the new behavior. The winner
    -- sleeps a timer so the race resolves in a LATER workflow task; the flag
    -- is used (and its id recorded) in that task's completion.
    specify "records flag id 1 in history when a race drops a loser with a finalizer" $ \TestEnv {..} -> do
      let workflow :: W.ProvidedWorkflow (W.Workflow ())
          workflow = W.provideWorkflow JSON "flag-emit-race-wf" $ provideCallStack $ do
            gate <- W.newStateVar False
            cleanupRan <- W.newStateVar False
            let winner :: MyWorkflow ()
                winner = W.sleep (milliseconds 5)
                loser :: MyWorkflow ()
                loser =
                  W.waitCondition (W.readStateVar gate)
                    `Catch.finally` W.writeStateVar cleanupRan True
            _ <- winner `W.race` loser
            pure ()
          conf = provideCallStack $ configure () workflow baseConf

      history <- withWorker conf $ do
        uuid <- uuidText
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
        useClient $ do
          wfHandle <- C.start workflow (W.WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      -- Every langUsedFlags list carried by a WorkflowTaskCompleted event's
      -- sdkMetadata; flag id 1 must appear in at least one of them.
      let recordedFlags =
            concat
              [ meta ^. SdkMetaF.langUsedFlags
              | ev <- history ^. HistoryF.events
              , Just attrs <- [ev ^. HistoryF.maybe'workflowTaskCompletedEventAttributes]
              , Just meta <- [attrs ^. HistoryF.maybe'sdkMetadata]
              ]
      recordedFlags `shouldSatisfy` elem (1 :: Word32)

    -- Contract: the flag is LOAD-BEARING on replay. When the loser's finalizer
    -- schedules a (compensation) activity, cancelling the loser shows up in
    -- history as an ActivityTaskScheduled. With flag id 1 present the SDK
    -- reproduces the cancellation and schedules that activity, so replay is
    -- consistent (Right). Strip flag id 1 from every WorkflowTaskCompleted
    -- event and the SDK no longer knows the flag on replay: it takes the OLD
    -- (pre-flag) behavior, drops the loser silently, and never schedules the
    -- compensation activity the recorded history contains -> non-determinism
    -- (Left). A genuine pre-flag history looks exactly like the stripped one
    -- (no id 1 AND no compensation), so it deterministically gets the old
    -- behavior: the migration is safe.
    specify "flag id 1 gates whether the loser's compensation activity replays" $ \TestEnv {..} -> do
      let actOpts = W.defaultStartActivityOptions $ W.StartToClose $ seconds 10
          workflow :: W.ProvidedWorkflow (W.Workflow ())
          workflow = W.provideWorkflow JSON "flag-gate-replay-wf" $ provideCallStack $ do
            gate <- W.newStateVar False
            let winner :: MyWorkflow ()
                winner = W.sleep (milliseconds 5)
                loser :: MyWorkflow ()
                loser =
                  Catch.bracket
                    (pure ())
                    (\_ -> void (W.executeActivity replayActivityDef.reference actOpts))
                    (\_ -> W.waitCondition (W.readStateVar gate))
            _ <- winner `W.race` loser
            pure ()
          conf = provideCallStack $ configure () (replayActivityDef, workflow) baseConf

      history <- withWorker conf $ do
        uuid <- uuidText
        let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
        useClient $ do
          wfHandle <- C.start workflow (W.WorkflowId uuid) opts
          C.waitWorkflowResult wfHandle
          C.fetchHistory wfHandle

      -- (a) With flag id 1 present, the cancellation (and its compensation
      -- activity) replays consistently.
      withFlag <- runReplayHistory globalRuntime conf history
      withFlag `shouldSatisfy` isRight

      -- (b) Strip all lang flags (id 1 included) from every
      -- WorkflowTaskCompleted event's sdkMetadata, leaving everything else
      -- (including the recorded compensation activity) untouched.
      let stripEvent ev = case ev ^. HistoryF.maybe'workflowTaskCompletedEventAttributes of
            Nothing -> ev
            Just attrs -> case attrs ^. HistoryF.maybe'sdkMetadata of
              Nothing -> ev
              Just meta ->
                ev
                  & HistoryF.maybe'workflowTaskCompletedEventAttributes
                    .~ Just (attrs & HistoryF.maybe'sdkMetadata .~ Just (meta & SdkMetaF.langUsedFlags .~ []))
          strippedHistory = history & HistoryF.events .~ map stripEvent (history ^. HistoryF.events)
      withoutFlag <- runReplayHistory globalRuntime conf strippedHistory
      withoutFlag `shouldSatisfy` isLeft

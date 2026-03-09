module ReplaySpec where

import Control.Monad (void, when)
import Data.Either (isLeft, isRight)
import qualified Data.Text as Text
import RequireCallStack (provideCallStack)
import System.Directory (getTemporaryDirectory, removeFile)
import Temporal.Activity
import qualified Temporal.Client as C
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

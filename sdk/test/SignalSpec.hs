module SignalSpec where

import Data.Text (Text)
import qualified Data.Text as Text
import RequireCallStack (provideCallStack)
import Test.Hspec
import TestHelpers
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.Exception
import qualified Temporal.Workflow as W
import Temporal.Worker


spec :: Spec
spec = withTestServer_ tests


tests :: SpecWith TestEnv
tests = describe "Signals" $ do
  it "send signal to workflow" $ \TestEnv {..} -> do
    let unblockSig = W.KnownSignal @'[] "unblock" defaultCodec
        workflow :: W.Workflow ()
        workflow = provideCallStack $ do
          st <- W.newStateVar False
          W.setSignalHandler unblockSig $ W.writeStateVar st True
          W.waitCondition (W.readStateVar st)
        wf = W.provideWorkflow defaultCodec "SignalSpec.sendSignal" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "sendSignal" opts)
      C.signal wfH unblockSig C.defaultSignalOptions
      C.waitWorkflowResult wfH `shouldReturn` ()

  it "signal with arguments" $ \TestEnv {..} -> do
    let intSig = W.KnownSignal @'[Int] "intSignal" defaultCodec
        workflow :: Int -> W.Workflow Int
        workflow initial = provideCallStack $ do
          st <- W.newStateVar initial
          W.setSignalHandler intSig $ \n -> W.modifyStateVar st (+ n)
          W.waitCondition $ (/= initial) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "SignalSpec.signalWithArgs" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "signalWithArgs" opts 10)
      C.signal wfH intSig C.defaultSignalOptions 5
      C.waitWorkflowResult wfH `shouldReturn` 15

  it "signal handler updates state" $ \TestEnv {..} -> do
    let intSig = W.KnownSignal @'[Int] "intSignal" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar (0 :: Int)
          W.setSignalHandler intSig $ \n -> W.writeStateVar st n
          W.waitCondition $ (> 0) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "SignalSpec.signalUpdatesState" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "signalUpdatesState" opts)
      C.signal wfH intSig C.defaultSignalOptions 42
      C.waitWorkflowResult wfH `shouldReturn` 42

  it "multiple signals delivered in order" $ \TestEnv {..} -> do
    let intSig = W.KnownSignal @'[Int] "intSignal" defaultCodec
        workflow :: W.Workflow [Int]
        workflow = provideCallStack $ do
          st <- W.newStateVar ([] :: [Int])
          W.setSignalHandler intSig $ \n -> W.modifyStateVar st (<> [n])
          W.waitCondition $ (>= 3) . length <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "SignalSpec.multipleSignals" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "multipleSignals" opts)
      C.signal wfH intSig C.defaultSignalOptions 1
      C.signal wfH intSig C.defaultSignalOptions 2
      C.signal wfH intSig C.defaultSignalOptions 3
      C.waitWorkflowResult wfH `shouldReturn` [1, 2, 3]

  it "signal buffered before handler registered" $ \TestEnv {..} -> do
    let intSig = W.KnownSignal @'[Int] "intSignal" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar ([] :: [Int])
          W.setSignalHandler intSig $ \n -> W.modifyStateVar st (<> [n])
          W.waitCondition $ not . null <$> W.readStateVar st
          sum <$> W.readStateVar st
        wf = W.provideWorkflow defaultCodec "SignalSpec.signalBuffered" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient $ C.signalWithStart wf "signalBuffered" opts intSig 7
      C.waitWorkflowResult wfH `shouldReturn` 7

  it "signal with start works" $ \TestEnv {..} -> do
    let unblockSig = W.KnownSignal @'[] "unblock" defaultCodec
        workflow :: W.Workflow ()
        workflow = provideCallStack $ do
          st <- W.newStateVar False
          W.setSignalHandler unblockSig $ W.writeStateVar st True
          W.waitCondition (W.readStateVar st)
        wf = W.provideWorkflow defaultCodec "SignalSpec.waitCondition" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient $ C.signalWithStart wf "signalWithStart" opts unblockSig
      C.waitWorkflowResult wfH `shouldReturn` ()

  it "signal with start and arguments" $ \TestEnv {..} -> do
    let intSig = W.KnownSignal @'[Int] "intSignal" defaultCodec
        workflow :: Int -> W.Workflow Int
        workflow initial = provideCallStack $ do
          st <- W.newStateVar initial
          W.setSignalHandler intSig $ \n -> W.modifyStateVar st (* n)
          W.waitCondition $ (/= initial) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "SignalSpec.signalWithStartArgs" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient $ C.signalWithStart wf "signalWithStartArgs" opts intSig 10 3
      C.waitWorkflowResult wfH `shouldReturn` 30

  it "signal unblocks waitCondition" $ \TestEnv {..} -> do
    let unblockSig = W.KnownSignal @'[] "unblock" defaultCodec
        workflow :: W.Workflow ()
        workflow = provideCallStack $ do
          st <- W.newStateVar False
          W.setSignalHandler unblockSig $ W.writeStateVar st True
          W.waitCondition (W.readStateVar st)
        wf = W.provideWorkflow defaultCodec "SignalSpec.unblockWait" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "waitCondition" opts)
      C.signal wfH unblockSig C.defaultSignalOptions
      C.waitWorkflowResult wfH `shouldReturn` ()

  it "multiple signal handlers" $ \TestEnv {..} -> do
    let sigA = W.KnownSignal @'[Int] "signalA" defaultCodec
        sigB = W.KnownSignal @'[Int] "signalB" defaultCodec
        workflow :: W.Workflow (Int, Int)
        workflow = provideCallStack $ do
          stA <- W.newStateVar (0 :: Int)
          stB <- W.newStateVar (0 :: Int)
          W.setSignalHandler sigA $ \n -> W.writeStateVar stA n
          W.setSignalHandler sigB $ \n -> W.writeStateVar stB n
          W.waitCondition $ do
            a <- W.readStateVar stA
            b <- W.readStateVar stB
            pure $ a > 0 && b > 0
          (,) <$> W.readStateVar stA <*> W.readStateVar stB
        wf = W.provideWorkflow defaultCodec "SignalSpec.multipleHandlers" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "multipleHandlers" opts)
      C.signal wfH sigA C.defaultSignalOptions 10
      C.signal wfH sigB C.defaultSignalOptions 20
      C.waitWorkflowResult wfH `shouldReturn` (10, 20)

  it "signal to running workflow" $ \TestEnv {..} -> do
    let intSig = W.KnownSignal @'[Int] "intSignal" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar (0 :: Int)
          W.setSignalHandler intSig $ \n -> W.writeStateVar st n
          W.sleep (seconds 2)
          W.waitCondition $ (> 0) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "SignalSpec.signalDuringSleep" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient (C.start wf.reference "signalDuringSleep" opts)
      C.signal wfH intSig C.defaultSignalOptions 99
      C.waitWorkflowResult wfH `shouldReturn` 99

  it "signal with complex argument types (lists, tuples)" $ \TestEnv {..} -> do
    let complexSig = W.KnownSignal @'[([Int], (Int, Text))] "complexArgs" defaultCodec
        workflow :: W.Workflow ([Int], (Int, Text))
        workflow = provideCallStack $ do
          st <- W.newStateVar (Nothing :: Maybe ([Int], (Int, Text)))
          W.setSignalHandler complexSig $ \arg -> W.writeStateVar st (Just arg)
          W.waitCondition $ do
            v <- W.readStateVar st
            pure $ case v of
              Just _ -> True
              Nothing -> False
          v <- W.readStateVar st
          pure $ case v of
            Just x -> x
            Nothing -> ([], (0, ""))
        wf = W.provideWorkflow defaultCodec "SignalSpec.complexArgs" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "complexArgs" opts)
      C.signal wfH complexSig C.defaultSignalOptions ([1, 2, 3], (42, "hello"))
      C.waitWorkflowResult wfH `shouldReturn` ([1, 2, 3], (42, "hello"))

  it "signal handler combined with query handler" $ \TestEnv {..} -> do
    let intSig = W.KnownSignal @'[Int] "intSignal" defaultCodec
        stateQ = W.KnownQuery @'[()] "state" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar (0 :: Int)
          W.setSignalHandler intSig $ \n -> W.modifyStateVar st (+ n)
          W.setQueryHandler stateQ $ \_ -> W.readStateVar st
          W.waitCondition $ (>= 3) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "SignalSpec.signalAndQuery" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOpts taskQueue
      wfH <- useClient (C.start wf.reference "signalAndQuery" opts)
      r0 <- C.query wfH stateQ C.defaultQueryOptions ()
      r0 `shouldBe` Right 0
      C.signal wfH intSig C.defaultSignalOptions 1
      r1 <- C.query wfH stateQ C.defaultQueryOptions ()
      r1 `shouldBe` Right 1
      C.signal wfH intSig C.defaultSignalOptions 2
      C.waitWorkflowResult wfH `shouldReturn` 3

  it "signalWithStart starts new workflow and delivers signal" $ \TestEnv {..} -> do
    let sig = W.KnownSignal @'[Int] "swsSignal" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar (0 :: Int)
          W.setSignalHandler sig $ \n -> W.writeStateVar st n
          W.waitCondition $ (/= 0) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "signalWithStartWf" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfId <- W.WorkflowId <$> uuidText
      h <- useClient (C.signalWithStart wf wfId opts sig 99)
      C.waitWorkflowResult h `shouldReturn` 99

  it "signalWithStart delivers signal to existing workflow" $ \TestEnv {..} -> do
    let sig = W.KnownSignal @'[Int] "swsExistingSig" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar (0 :: Int)
          W.setSignalHandler sig $ \n -> W.writeStateVar st n
          W.waitCondition $ (/= 0) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "signalWithStartExistingWf" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfId <- W.WorkflowId <$> uuidText
      h1 <- useClient (C.start wf.reference wfId opts)
      _ <- useClient (C.signalWithStart wf wfId opts sig 42)
      C.waitWorkflowResult h1 `shouldReturn` 42

  it "signalWithStart with conflict policy UseExisting delivers to existing" $ \TestEnv {..} -> do
    let sig = W.KnownSignal @'[Int] "swsConflictSig" defaultCodec
        workflow :: W.Workflow Int
        workflow = provideCallStack $ do
          st <- W.newStateVar (0 :: Int)
          W.setSignalHandler sig $ \n -> W.writeStateVar st n
          W.waitCondition $ (/= 0) <$> W.readStateVar st
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "signalWithStartConflictWf" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = (C.startWorkflowOptions taskQueue)
            { C.workflowIdConflictPolicy = Just C.WorkflowIdConflictPolicyUseExisting
            , C.timeouts = C.TimeoutOptions {C.runTimeout = Just (seconds 10), C.executionTimeout = Nothing, C.taskTimeout = Nothing}
            }
      wfId <- W.WorkflowId <$> uuidText
      h1 <- useClient (C.start wf.reference wfId opts)
      _ <- useClient (C.signalWithStart wf.reference wfId opts sig 55)
      C.waitWorkflowResult h1 `shouldReturn` 55

  it "signal and timer in same workflow task" $ \TestEnv {..} -> do
    let timerSig = W.KnownSignal @'[Int] "timerSig" defaultCodec
        workflow :: W.Workflow Text
        workflow = provideCallStack $ do
          st <- W.newStateVar ("init" :: Text)
          W.setSignalHandler timerSig $ \n -> W.writeStateVar st (Text.pack $ show (n :: Int))
          W.sleep (seconds 1)
          W.readStateVar st
        wf = W.provideWorkflow defaultCodec "signalTimerTask" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient (C.start wf.reference "signalTimerTask" opts)
      C.signal wfH timerSig C.defaultSignalOptions 99
      C.waitWorkflowResult wfH `shouldReturn` "99"

  it "signal triggers workflow failure via state" $ \TestEnv {..} -> do
    let failSig = W.KnownSignal @'[] "failSig" defaultCodec
        workflow :: W.Workflow ()
        workflow = provideCallStack $ do
          shouldFail <- W.newStateVar False
          W.setSignalHandler failSig $ W.writeStateVar shouldFail True
          W.waitCondition (W.readStateVar shouldFail)
          error "signal requested failure"
        wf = W.provideWorkflow defaultCodec "SignalSpec.failSignal" workflow
        conf = configure () wf $ do baseConf
    withWorker conf $ do
      let opts = defaultStartOptsWithTimeout taskQueue (seconds 30)
      wfH <- useClient (C.start wf.reference "failSignal" opts)
      C.signal wfH failSig C.defaultSignalOptions
      C.waitWorkflowResult wfH
        `shouldThrow` \case
          WorkflowExecutionFailed _ -> True
          _ -> False

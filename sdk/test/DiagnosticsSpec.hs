module DiagnosticsSpec (spec) where

import Data.Int (Int32)
import Data.Time.Clock.System (SystemTime (..))
import qualified Data.Vector as V
import Test.Hspec
import Temporal.Ops


now :: SystemTime
now = MkSystemTime 1000000 0


mkDesc :: Maybe PendingWorkflowTaskDescription -> V.Vector PendingActivityDescription -> WorkflowExecutionDescription
mkDesc mTask activities =
  WorkflowExecutionDescription
    { workflowType = WorkflowType "test-workflow"
    , workflowId = WorkflowId "wf-1"
    , runId = RunId "run-1"
    , taskQueue = TaskQueue "test-queue"
    , startTime = Just (MkSystemTime 999000 0)
    , closeTime = Nothing
    , executionTime = Just (MkSystemTime 999000 0)
    , pendingActivities = activities
    , pendingWorkflowTask = mTask
    }


mkActivity :: PendingActivityState -> Int32 -> Int32 -> Maybe SystemTime -> Maybe SystemTime -> Maybe SystemTime -> PendingActivityDescription
mkActivity = mkActivity' "act-1"


mkActivity' :: ActivityId -> PendingActivityState -> Int32 -> Int32 -> Maybe SystemTime -> Maybe SystemTime -> Maybe SystemTime -> PendingActivityDescription
mkActivity' aid st att maxAtt schedTime startTime hbTime =
  PendingActivityDescription
    { activityType = ActivityType "test-activity"
    , activityId = aid
    , state = st
    , attempt = att
    , maximumAttempts = maxAtt
    , scheduledTime = schedTime
    , lastStartedTime = startTime
    , lastHeartbeatTime = hbTime
    , expirationTime = Nothing
    }


opts :: DiagnosticOptions
opts = defaultDiagnosticOptions


spec :: Spec
spec = describe "Temporal.Ops.Diagnostics" $ do
  describe "checkNondeterminism" $ do
    it "returns empty when no pending workflow task" $ do
      let desc = mkDesc Nothing V.empty
      checkNondeterminism opts desc `shouldBe` []

    it "returns empty when attempt is below threshold" $ do
      let task = PendingWorkflowTaskDescription 2 Nothing Nothing Nothing
      checkNondeterminism opts (mkDesc (Just task) V.empty) `shouldBe` []

    it "detects nondeterminism at threshold" $ do
      let task = PendingWorkflowTaskDescription 3 Nothing Nothing Nothing
      checkNondeterminism opts (mkDesc (Just task) V.empty) `shouldBe`
        [NondeterminismError 3]

    it "detects nondeterminism above threshold" $ do
      let task = PendingWorkflowTaskDescription 10 Nothing Nothing Nothing
      checkNondeterminism opts (mkDesc (Just task) V.empty) `shouldBe`
        [NondeterminismError 10]

  describe "checkWorkflowTaskTimeouts" $ do
    it "returns empty when no pending workflow task" $ do
      let desc = mkDesc Nothing V.empty
      checkWorkflowTaskTimeouts opts desc `shouldBe` []

    it "returns empty when attempt is below threshold" $ do
      let task = PendingWorkflowTaskDescription 4 Nothing Nothing Nothing
      checkWorkflowTaskTimeouts opts (mkDesc (Just task) V.empty) `shouldBe` []

    it "detects workflow task timeouts at threshold" $ do
      let task = PendingWorkflowTaskDescription 5 Nothing Nothing Nothing
      checkWorkflowTaskTimeouts opts (mkDesc (Just task) V.empty) `shouldBe`
        [WorkflowTaskTimeouts 5]

  describe "checkStuckActivities" $ do
    it "returns empty with no activities" $ do
      checkStuckActivities opts now (mkDesc Nothing V.empty) `shouldBe` []

    it "returns empty for low-attempt STARTED activity" $ do
      let act = mkActivity PENDING_ACTIVITY_STATE_STARTED 1 0 (Just (MkSystemTime 999000 0)) Nothing Nothing
      checkStuckActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

    it "detects stuck activity with high attempts and old schedule" $ do
      let schedTime = MkSystemTime (1000000 - 600) 0
          act = mkActivity PENDING_ACTIVITY_STATE_STARTED 5 0 (Just schedTime) Nothing (Just (MkSystemTime 999500 0))
      checkStuckActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe`
        [StuckActivity (ActivityType "test-activity") (ActivityId "act-1") 5 (Just schedTime) (Just (MkSystemTime 999500 0))]

    it "ignores CANCEL_REQUESTED activities" $ do
      let schedTime = MkSystemTime (1000000 - 600) 0
          act = mkActivity PENDING_ACTIVITY_STATE_CANCEL_REQUESTED 5 0 (Just schedTime) Nothing Nothing
      checkStuckActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

    it "ignores SCHEDULED activities" $ do
      let schedTime = MkSystemTime (1000000 - 600) 0
          act = mkActivity PENDING_ACTIVITY_STATE_SCHEDULED 5 0 (Just schedTime) Nothing Nothing
      checkStuckActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

  describe "checkStarvedActivities" $ do
    it "returns empty with no activities" $ do
      checkStarvedActivities opts now (mkDesc Nothing V.empty) `shouldBe` []

    it "returns empty for recently scheduled activity" $ do
      let act = mkActivity PENDING_ACTIVITY_STATE_SCHEDULED 1 0 (Just (MkSystemTime (1000000 - 60) 0)) Nothing Nothing
      checkStarvedActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

    it "detects starved activity past threshold" $ do
      let schedTime = MkSystemTime (1000000 - 600) 0
          act = mkActivity PENDING_ACTIVITY_STATE_SCHEDULED 1 0 (Just schedTime) Nothing Nothing
      checkStarvedActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe`
        [StarvedActivity (ActivityType "test-activity") (ActivityId "act-1") (Just schedTime)]

    it "ignores STARTED activities" $ do
      let schedTime = MkSystemTime (1000000 - 600) 0
          act = mkActivity PENDING_ACTIVITY_STATE_STARTED 1 0 (Just schedTime) Nothing Nothing
      checkStarvedActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

    it "detects starved activity with no scheduled time" $ do
      let act = mkActivity PENDING_ACTIVITY_STATE_SCHEDULED 1 0 Nothing Nothing Nothing
      checkStarvedActivities opts now (mkDesc Nothing (V.singleton act)) `shouldBe`
        [StarvedActivity (ActivityType "test-activity") (ActivityId "act-1") Nothing]

  describe "checkStaleHeartbeats" $ do
    it "returns empty with no activities" $ do
      checkStaleHeartbeats opts now (mkDesc Nothing V.empty) `shouldBe` []

    it "returns empty for STARTED activity with recent heartbeat" $ do
      let act = mkActivity PENDING_ACTIVITY_STATE_STARTED 1 0 Nothing (Just (MkSystemTime 999900 0)) (Just (MkSystemTime 999950 0))
      checkStaleHeartbeats opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

    it "detects stale heartbeat" $ do
      let hbTime = MkSystemTime (1000000 - 700) 0
          startTime = MkSystemTime (1000000 - 800) 0
          act = mkActivity PENDING_ACTIVITY_STATE_STARTED 1 0 Nothing (Just startTime) (Just hbTime)
      checkStaleHeartbeats opts now (mkDesc Nothing (V.singleton act)) `shouldBe`
        [StaleHeartbeat (ActivityType "test-activity") (ActivityId "act-1") (Just startTime) (Just hbTime)]

    it "detects stale when no heartbeat but old start time" $ do
      let startTime = MkSystemTime (1000000 - 700) 0
          act = mkActivity PENDING_ACTIVITY_STATE_STARTED 1 0 Nothing (Just startTime) Nothing
      checkStaleHeartbeats opts now (mkDesc Nothing (V.singleton act)) `shouldBe`
        [StaleHeartbeat (ActivityType "test-activity") (ActivityId "act-1") (Just startTime) Nothing]

    it "returns empty when no heartbeat and no start time" $ do
      let act = mkActivity PENDING_ACTIVITY_STATE_STARTED 1 0 Nothing Nothing Nothing
      checkStaleHeartbeats opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

    it "ignores SCHEDULED activities" $ do
      let hbTime = MkSystemTime (1000000 - 700) 0
          act = mkActivity PENDING_ACTIVITY_STATE_SCHEDULED 1 0 Nothing Nothing (Just hbTime)
      checkStaleHeartbeats opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

  describe "checkStalledCancellations" $ do
    it "returns empty with no activities" $ do
      checkStalledCancellations opts now (mkDesc Nothing V.empty) `shouldBe` []

    it "returns empty for recently cancel-requested activity" $ do
      let act = mkActivity PENDING_ACTIVITY_STATE_CANCEL_REQUESTED 1 0 (Just (MkSystemTime (1000000 - 60) 0)) Nothing Nothing
      checkStalledCancellations opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

    it "detects stalled cancellation past threshold" $ do
      let schedTime = MkSystemTime (1000000 - 600) 0
          act = mkActivity PENDING_ACTIVITY_STATE_CANCEL_REQUESTED 3 0 (Just schedTime) Nothing Nothing
      checkStalledCancellations opts now (mkDesc Nothing (V.singleton act)) `shouldBe`
        [StalledCancellation (ActivityType "test-activity") (ActivityId "act-1") 3 (Just schedTime)]

    it "ignores STARTED activities" $ do
      let schedTime = MkSystemTime (1000000 - 600) 0
          act = mkActivity PENDING_ACTIVITY_STATE_STARTED 3 0 (Just schedTime) Nothing Nothing
      checkStalledCancellations opts now (mkDesc Nothing (V.singleton act)) `shouldBe` []

  describe "classifyWorkflow" $ do
    it "returns multiple reasons for a multi-problem workflow" $ do
      let task = PendingWorkflowTaskDescription 10 Nothing Nothing Nothing
          schedTime = MkSystemTime (1000000 - 600) 0
          stuckAct = mkActivity PENDING_ACTIVITY_STATE_STARTED 5 0 (Just schedTime) Nothing (Just (MkSystemTime 999500 0))
          starvedAct = mkActivity' "act-2" PENDING_ACTIVITY_STATE_SCHEDULED 1 0 (Just schedTime) Nothing Nothing
          desc = mkDesc (Just task) (V.fromList [stuckAct, starvedAct])
          reasons = classifyWorkflow opts now desc
      length reasons `shouldSatisfy` (>= 3)

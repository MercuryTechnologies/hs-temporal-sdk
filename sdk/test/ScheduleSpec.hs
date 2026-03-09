module ScheduleSpec where

import Conduit
import Control.Concurrent (threadDelay)
import Control.Monad (unless)
import qualified Data.Vector as V
import qualified Temporal.Client as C
import Temporal.Client.Schedule (ScheduleSpec(interval), SchedulePolicies(overlapPolicy))
import qualified Temporal.Client.Schedule as Sched
import Temporal.Duration
import Temporal.Worker (configure)
import qualified Temporal.Workflow as W
import Test.Hspec
import TestHelpers


spec :: Spec
spec = withTestServer_ tests


mkInterval :: [Sched.IntervalSpec] -> Sched.ScheduleSpec
mkInterval ivs =
  Sched.scheduleSpec
    { interval = ivs
    }


defaultPolicies :: Sched.SchedulePolicies
defaultPolicies =
  Sched.SchedulePolicies
    { Sched.overlapPolicy = Sched.Skip
    , Sched.catchupWindow = Nothing
    , Sched.pauseOnFailure = False
    }


defaultState :: Sched.ScheduleState
defaultState =
  Sched.ScheduleState
    { Sched.notes = ""
    , Sched.paused = False
    , Sched.limitedActions = False
    , Sched.remainingActions = 0
    }


tests :: SpecWith TestEnv
tests = describe "Schedules" $ do
  specify "basic schedule CRUD" $ \TestEnv {..} -> do
    let workflow :: W.Workflow Int
        workflow = pure 42
        wf = W.provideWorkflow defaultCodec "scheduleCrudWf" workflow
        conf = configure () wf baseConf
    withWorker conf $ do
      scheduleId <- Sched.ScheduleId <$> uuidText
      requestId <- uuidText
      let sc = Sched.mkScheduleClient coreClient (W.Namespace "default")
          iv = Sched.IntervalSpec {Sched.interval = hours 1, Sched.phase = Nothing}
          action :: IO Sched.ScheduleAction
          action = Sched.mkScheduleAction wf.reference (W.WorkflowId "sched-crud-wf") (C.startWorkflowOptions taskQueue)
      action' <- action
      let sched =
            Sched.Schedule
              { Sched.spec = mkInterval [iv]
              , Sched.action = action'
              , Sched.policies = defaultPolicies
              , Sched.state = defaultState
              }
          req =
            Sched.CreateScheduleRequest
              { Sched.scheduleId = scheduleId
              , Sched.schedule = sched
              , Sched.initialPatch = Nothing
              , Sched.memo = mempty
              , Sched.requestId = requestId
              , Sched.searchAttributes = mempty
              }
      _ <- Sched.createSchedule sc req
      desc <- Sched.describeSchedule sc scheduleId
      desc.schedule.state.paused `shouldBe` False
      Sched.deleteSchedule sc scheduleId

  specify "trigger schedule" $ \TestEnv {..} -> do
    let workflow :: W.Workflow Int
        workflow = pure 99
        wf = W.provideWorkflow defaultCodec "scheduleTriggerWf" workflow
        conf = configure () wf baseConf
    withWorker conf $ do
      scheduleId <- Sched.ScheduleId <$> uuidText
      requestId <- uuidText
      let sc = Sched.mkScheduleClient coreClient (W.Namespace "default")
          iv = Sched.IntervalSpec {Sched.interval = hours 1, Sched.phase = Nothing}
      action' <- Sched.mkScheduleAction wf.reference (W.WorkflowId "sched-trigger-wf") (C.startWorkflowOptions taskQueue)
      let patch =
            Sched.SchedulePatch
              { Sched.triggerImmediately =
                  Just
                    Sched.TriggerImmediatelyRequest
                      { Sched.overlapPolicy = Sched.AllowAll
                      }
              , Sched.backfillRequest = []
              , Sched.pauseState = Nothing
              , Sched.requestId = requestId
              }
          sched =
            Sched.Schedule
              { Sched.spec = mkInterval [iv]
              , Sched.action = action'
              , Sched.policies = defaultPolicies {overlapPolicy = Sched.AllowAll}
              , Sched.state = defaultState
              }
          req =
            Sched.CreateScheduleRequest
              { Sched.scheduleId = scheduleId
              , Sched.schedule = sched
              , Sched.initialPatch = Just patch
              , Sched.memo = mempty
              , Sched.requestId = requestId
              , Sched.searchAttributes = mempty
              }
      _ <- Sched.createSchedule sc req
      desc <- Sched.describeSchedule sc scheduleId
      length desc.info.recentActions `shouldSatisfy` (>= 0)
      Sched.deleteSchedule sc scheduleId

  specify "pause/unpause schedule" $ \TestEnv {..} -> do
    let workflow :: W.Workflow Int
        workflow = pure 0
        wf = W.provideWorkflow defaultCodec "schedulePauseWf" workflow
        conf = configure () wf baseConf
    withWorker conf $ do
      scheduleId <- Sched.ScheduleId <$> uuidText
      requestId <- uuidText
      let sc = Sched.mkScheduleClient coreClient (W.Namespace "default")
          iv = Sched.IntervalSpec {Sched.interval = hours 1, Sched.phase = Nothing}
      action' <- Sched.mkScheduleAction wf.reference (W.WorkflowId "sched-pause-wf") (C.startWorkflowOptions taskQueue)
      let sched =
            Sched.Schedule
              { Sched.spec = mkInterval [iv]
              , Sched.action = action'
              , Sched.policies = defaultPolicies
              , Sched.state = defaultState
              }
          req =
            Sched.CreateScheduleRequest
              { Sched.scheduleId = scheduleId
              , Sched.schedule = sched
              , Sched.initialPatch = Nothing
              , Sched.memo = mempty
              , Sched.requestId = requestId
              , Sched.searchAttributes = mempty
              }
      _ <- Sched.createSchedule sc req
      pauseReqId <- uuidText
      let pausePatch =
            Sched.SchedulePatch
              { Sched.triggerImmediately = Nothing
              , Sched.backfillRequest = []
              , Sched.pauseState = Just (Sched.Pause "test pause")
              , Sched.requestId = pauseReqId
              }
      Sched.patchSchedule sc scheduleId pausePatch
      descPaused <- Sched.describeSchedule sc scheduleId
      descPaused.schedule.state.paused `shouldBe` True
      unpauseReqId <- uuidText
      let unpausePatch =
            Sched.SchedulePatch
              { Sched.triggerImmediately = Nothing
              , Sched.backfillRequest = []
              , Sched.pauseState = Just (Sched.Unpause "test unpause")
              , Sched.requestId = unpauseReqId
              }
      Sched.patchSchedule sc scheduleId unpausePatch
      descUnpaused <- Sched.describeSchedule sc scheduleId
      descUnpaused.schedule.state.paused `shouldBe` False
      Sched.deleteSchedule sc scheduleId

  specify "list schedules" $ \TestEnv {..} -> do
    let workflow :: W.Workflow Int
        workflow = pure 1
        wf = W.provideWorkflow defaultCodec "scheduleListWf" workflow
        conf = configure () wf baseConf
    withWorker conf $ do
      scheduleId <- Sched.ScheduleId <$> uuidText
      requestId <- uuidText
      let sc = Sched.mkScheduleClient coreClient (W.Namespace "default")
          iv = Sched.IntervalSpec {Sched.interval = hours 1, Sched.phase = Nothing}
      action' <- Sched.mkScheduleAction wf.reference (W.WorkflowId "sched-list-wf") (C.startWorkflowOptions taskQueue)
      let sched =
            Sched.Schedule
              { Sched.spec = mkInterval [iv]
              , Sched.action = action'
              , Sched.policies = defaultPolicies
              , Sched.state = defaultState
              }
          req =
            Sched.CreateScheduleRequest
              { Sched.scheduleId = scheduleId
              , Sched.schedule = sched
              , Sched.initialPatch = Nothing
              , Sched.memo = mempty
              , Sched.requestId = requestId
              , Sched.searchAttributes = mempty
              }
      _ <- Sched.createSchedule sc req
      let poll :: Int -> IO Bool
          poll 0 = pure False
          poll n = do
            chunks <-
              runConduit $
                Sched.listSchedules sc (Sched.ListSchedulesOptions {Sched.maximumPageSize = 100})
                  .| sinkList
            let entries = concatMap V.toList chunks
                found = any (\e -> e.scheduleId == scheduleId) entries
            unless found $ threadDelay 200_000
            if found then pure True else poll (n - 1)
      result <- poll (10 :: Int)
      result `shouldBe` True
      Sched.deleteSchedule sc scheduleId

{-# LANGUAGE OverloadedStrings #-}

module ClientHistorySpec where

import Conduit (runConduit, sinkList, (.|))
import Data.IORef
import Data.ProtoLens (defMessage)
import Lens.Family2 ((&), (.~), (^.))
import Proto.Temporal.Api.History.V1.Message (HistoryEvent)
import qualified Proto.Temporal.Api.History.V1.Message_Fields as History
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse
  ( GetWorkflowExecutionHistoryRequest
  , GetWorkflowExecutionHistoryResponse
  )
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse_Fields as RR
import Temporal.Client (FollowOption (..), streamEventsWith)
import Test.Hspec


spec :: Spec
spec = describe "streamEvents follow/pagination loop" $ do
  it "carries the followed run's id across pages and paginates fully" $ do
    let historyResp evs tok =
          defMessage
            & RR.history .~ (defMessage & History.events .~ evs)
            & RR.nextPageToken .~ tok ::
            GetWorkflowExecutionHistoryResponse
        canEvent runId =
          defMessage
            & History.workflowExecutionContinuedAsNewEventAttributes
              .~ (defMessage & History.newExecutionRunId .~ runId) ::
            HistoryEvent
        wftEvent = defMessage & History.workflowTaskCompletedEventAttributes .~ defMessage :: HistoryEvent
        completedEvent = defMessage & History.workflowExecutionCompletedEventAttributes .~ defMessage :: HistoryEvent
        req0 =
          defMessage & RR.execution .~ (defMessage & RR.runId .~ "run-A") ::
            GetWorkflowExecutionHistoryRequest
        responses =
          [ historyResp [canEvent "run-B"] "" -- run A ends by continuing as new to run B
          , historyResp [wftEvent] "page-2-token" -- run B, first page: more to come
          , historyResp [completedEvent] "" -- run B, final page
          ]
    respsRef <- newIORef responses
    reqsRef <- newIORef []
    let fetch req = do
          modifyIORef' reqsRef (<> [req])
          readIORef respsRef >>= \case
            (r : rest) -> writeIORef respsRef rest >> pure r
            [] -> pure (historyResp [completedEvent] "") -- terminate if over-fetched
    _ <- runConduit (streamEventsWith fetch FollowRuns req0 .| sinkList)
    reqs <- readIORef reqsRef
    -- Did not truncate on the non-terminal middle page (all three pages fetched).
    length reqs `shouldBe` 3
    -- The page after the continue-as-new targets run B, not the original run A.
    ((reqs !! 2) ^. RR.execution . RR.runId) `shouldBe` "run-B"

{-# LANGUAGE OverloadedStrings #-}

module ClientHistorySpec where

import Conduit (runConduit, sinkList, (.|))
import Data.IORef
import qualified Data.Vector as V
import qualified Proto.Temporal.Api.Common.V1.Message as Common
import Proto.Temporal.Api.History.V1.Message (HistoryEvent)
import qualified Proto.Temporal.Api.History.V1.Message as History
import Proto.Temporal.Api.Workflowservice.V1.RequestResponse (
  GetWorkflowExecutionHistoryRequest,
  GetWorkflowExecutionHistoryResponse,
 )
import qualified Proto.Temporal.Api.Workflowservice.V1.RequestResponse as RR
import Temporal.Client (FollowOption (..), streamEventsWith)
import Test.Hspec


spec :: Spec
spec = describe "streamEvents follow/pagination loop" $ do
  it "carries the followed run's id across pages and paginates fully" $ do
    let historyResp evs tok =
          RR.defaultGetWorkflowExecutionHistoryResponse
            { RR.history =
                Just
                  History.defaultHistory
                    { History.events = V.fromList evs
                    }
            , RR.nextPageToken = Just tok
            }
            :: GetWorkflowExecutionHistoryResponse
        canEvent runId =
          History.defaultHistoryEvent
            { History.attributes =
                Just
                  ( History.HistoryEvent'Attributes'WorkflowExecutionContinuedAsNewEventAttributes
                      History.defaultWorkflowExecutionContinuedAsNewEventAttributes
                        { History.newExecutionRunId = Just runId
                        }
                  )
            }
            :: HistoryEvent
        wftEvent =
          History.defaultHistoryEvent
            { History.attributes =
                Just
                  ( History.HistoryEvent'Attributes'WorkflowTaskCompletedEventAttributes
                      History.defaultWorkflowTaskCompletedEventAttributes
                  )
            }
            :: HistoryEvent
        completedEvent =
          History.defaultHistoryEvent
            { History.attributes =
                Just
                  ( History.HistoryEvent'Attributes'WorkflowExecutionCompletedEventAttributes
                      History.defaultWorkflowExecutionCompletedEventAttributes
                  )
            }
            :: HistoryEvent
        req0 =
          RR.defaultGetWorkflowExecutionHistoryRequest
            { RR.execution =
                Just
                  (Common.defaultWorkflowExecution :: Common.WorkflowExecution)
                    { Common.runId = Just "run-A"
                    }
            }
            :: GetWorkflowExecutionHistoryRequest
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
    case reqs !! 2 of
      RR.GetWorkflowExecutionHistoryRequest _ (Just (Common.WorkflowExecution _ runId _)) _ _ _ _ _ _ ->
        runId `shouldBe` Just "run-B"
      _ -> expectationFailure "expected the followed request to include a workflow execution"

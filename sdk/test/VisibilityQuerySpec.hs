module VisibilityQuerySpec where

import Data.Text (Text)
import qualified Data.Text as T
import Data.Time.Calendar (fromGregorian)
import Data.Time.Clock (UTCTime (..))
import Hedgehog
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
import Temporal.Client (
  TimeRange (..),
  VisibilityQuery (..),
  WorkflowExecutionStatus (..),
  WorkflowId (..),
  WorkflowType (..),
  combineQueries,
  queryByCloseTime,
  queryByExecutionTime,
  queryByStartTime,
  queryByStatus,
  queryByWorkflowId,
  queryByWorkflowType,
  renderQuery,
 )
import Test.Hspec
import Test.Hspec.Hedgehog


-- | Sample UTCTime for testing
sampleTime1 :: UTCTime
sampleTime1 = UTCTime (fromGregorian 2024 1 1) 0


sampleTime2 :: UTCTime
sampleTime2 = UTCTime (fromGregorian 2024 12 31) 86399


spec :: Spec
spec = describe "VisibilityQuery" $ do
  describe "Primitive Query Builders" $ do
    describe "queryByWorkflowType" $ do
      it "renders a simple workflow type" $ do
        queryByWorkflowType "MyWorkflow"
          `shouldBe` "WorkflowType='MyWorkflow'"

      it "escapes single quotes in workflow type" $ do
        queryByWorkflowType "My'Workflow"
          `shouldBe` "WorkflowType='My''Workflow'"

      it "handles empty workflow type" $ do
        queryByWorkflowType ""
          `shouldBe` "WorkflowType=''"

    describe "queryByWorkflowId" $ do
      it "renders a simple workflow ID" $ do
        queryByWorkflowId "workflow-123"
          `shouldBe` "WorkflowId='workflow-123'"

      it "escapes single quotes in workflow ID" $ do
        queryByWorkflowId "workflow-'123'"
          `shouldBe` "WorkflowId='workflow-''123'''"

      it "handles UUID-style workflow IDs" $ do
        queryByWorkflowId "550e8400-e29b-41d4-a716-446655440000"
          `shouldBe` "WorkflowId='550e8400-e29b-41d4-a716-446655440000'"

    describe "queryByStatus" $ do
      it "renders Running status" $ do
        queryByStatus Running
          `shouldBe` "WorkflowStatus='Running'"

      it "renders Completed status" $ do
        queryByStatus Completed
          `shouldBe` "WorkflowStatus='Completed'"

      it "renders Failed status" $ do
        queryByStatus Failed
          `shouldBe` "WorkflowStatus='Failed'"

      it "renders Canceled status" $ do
        queryByStatus Canceled
          `shouldBe` "WorkflowStatus='Canceled'"

      it "renders Terminated status" $ do
        queryByStatus Terminated
          `shouldBe` "WorkflowStatus='Terminated'"

      it "renders ContinuedAsNew status" $ do
        queryByStatus ContinuedAsNew
          `shouldBe` "WorkflowStatus='ContinuedAsNew'"

      it "renders TimedOut status" $ do
        queryByStatus TimedOut
          `shouldBe` "WorkflowStatus='TimedOut'"

      it "renders UnknownStatus" $ do
        queryByStatus UnknownStatus
          `shouldBe` "WorkflowStatus='Unspecified'"

    describe "queryByStartTime" $ do
      it "renders After time range" $ do
        queryByStartTime (After sampleTime1)
          `shouldBe` "StartTime>'2024-01-01T00:00:00Z'"

      it "renders Before time range" $ do
        queryByStartTime (Before sampleTime2)
          `shouldBe` "StartTime<'2024-12-31T23:59:59Z'"

      it "renders Between time range" $ do
        queryByStartTime (Between sampleTime1 sampleTime2)
          `shouldBe` "StartTime BETWEEN '2024-01-01T00:00:00Z' AND '2024-12-31T23:59:59Z'"

    describe "queryByCloseTime" $ do
      it "renders After time range" $ do
        queryByCloseTime (After sampleTime1)
          `shouldBe` "CloseTime>'2024-01-01T00:00:00Z'"

      it "renders Before time range" $ do
        queryByCloseTime (Before sampleTime2)
          `shouldBe` "CloseTime<'2024-12-31T23:59:59Z'"

      it "renders Between time range" $ do
        queryByCloseTime (Between sampleTime1 sampleTime2)
          `shouldBe` "CloseTime BETWEEN '2024-01-01T00:00:00Z' AND '2024-12-31T23:59:59Z'"

    describe "queryByExecutionTime" $ do
      it "renders After time range" $ do
        queryByExecutionTime (After sampleTime1)
          `shouldBe` "ExecutionTime>'2024-01-01T00:00:00Z'"

      it "renders Before time range" $ do
        queryByExecutionTime (Before sampleTime2)
          `shouldBe` "ExecutionTime<'2024-12-31T23:59:59Z'"

      it "renders Between time range" $ do
        queryByExecutionTime (Between sampleTime1 sampleTime2)
          `shouldBe` "ExecutionTime BETWEEN '2024-01-01T00:00:00Z' AND '2024-12-31T23:59:59Z'"

    describe "combineQueries" $ do
      it "combines two queries" $ do
        combineQueries
          [ queryByWorkflowType "MyWorkflow"
          , queryByStatus Running
          ]
          `shouldBe` "WorkflowType='MyWorkflow' AND WorkflowStatus='Running'"

      it "combines multiple queries" $ do
        combineQueries
          [ queryByWorkflowType "MyWorkflow"
          , queryByStatus Running
          , queryByWorkflowId "workflow-123"
          ]
          `shouldBe` "WorkflowType='MyWorkflow' AND WorkflowStatus='Running' AND WorkflowId='workflow-123'"

      it "handles empty list" $ do
        combineQueries []
          `shouldBe` ""

      it "handles single query" $ do
        combineQueries [queryByWorkflowType "MyWorkflow"]
          `shouldBe` "WorkflowType='MyWorkflow'"

  describe "ADT Query Rendering" $ do
    describe "renderQuery" $ do
      it "renders WorkflowTypeQuery" $ do
        renderQuery (WorkflowTypeQuery "MyWorkflow")
          `shouldBe` "WorkflowType='MyWorkflow'"

      it "renders WorkflowIdQuery" $ do
        renderQuery (WorkflowIdQuery "workflow-123")
          `shouldBe` "WorkflowId='workflow-123'"

      it "renders StatusQuery" $ do
        renderQuery (StatusQuery Running)
          `shouldBe` "WorkflowStatus='Running'"

      it "renders StartTimeQuery with After" $ do
        renderQuery (StartTimeQuery (After sampleTime1))
          `shouldBe` "StartTime>'2024-01-01T00:00:00Z'"

      it "renders CloseTimeQuery with Between" $ do
        renderQuery (CloseTimeQuery (Between sampleTime1 sampleTime2))
          `shouldBe` "CloseTime BETWEEN '2024-01-01T00:00:00Z' AND '2024-12-31T23:59:59Z'"

      it "renders ExecutionTimeQuery with Before" $ do
        renderQuery (ExecutionTimeQuery (Before sampleTime2))
          `shouldBe` "ExecutionTime<'2024-12-31T23:59:59Z'"

      it "renders AndQuery with two queries" $ do
        renderQuery
          ( AndQuery
              [ WorkflowTypeQuery "MyWorkflow"
              , StatusQuery Running
              ]
          )
          `shouldBe` "WorkflowType='MyWorkflow' AND WorkflowStatus='Running'"

      it "renders AndQuery with multiple queries" $ do
        renderQuery
          ( AndQuery
              [ WorkflowTypeQuery "MyWorkflow"
              , StatusQuery Running
              , WorkflowIdQuery "workflow-123"
              ]
          )
          `shouldBe` "WorkflowType='MyWorkflow' AND WorkflowStatus='Running' AND WorkflowId='workflow-123'"

      it "renders nested AndQuery" $ do
        renderQuery
          ( AndQuery
              [ WorkflowTypeQuery "MyWorkflow"
              , AndQuery
                  [ StatusQuery Running
                  , WorkflowIdQuery "workflow-123"
                  ]
              ]
          )
          `shouldBe` "WorkflowType='MyWorkflow' AND WorkflowStatus='Running' AND WorkflowId='workflow-123'"

      it "renders OrQuery with two queries" $ do
        renderQuery
          ( OrQuery
              [ StatusQuery Running
              , StatusQuery Completed
              ]
          )
          `shouldBe` "(WorkflowStatus='Running' OR WorkflowStatus='Completed')"

      it "renders OrQuery with multiple queries" $ do
        renderQuery
          ( OrQuery
              [ StatusQuery Running
              , StatusQuery Completed
              , StatusQuery Failed
              ]
          )
          `shouldBe` "(WorkflowStatus='Running' OR WorkflowStatus='Completed' OR WorkflowStatus='Failed')"

      it "renders RawQuery" $ do
        renderQuery (RawQuery "CustomField='value'")
          `shouldBe` "CustomField='value'"

      it "renders complex nested query with AND and OR" $ do
        renderQuery
          ( AndQuery
              [ WorkflowTypeQuery "MyWorkflow"
              , OrQuery
                  [ StatusQuery Running
                  , StatusQuery Completed
                  ]
              , StartTimeQuery (After sampleTime1)
              ]
          )
          `shouldBe` "WorkflowType='MyWorkflow' AND (WorkflowStatus='Running' OR WorkflowStatus='Completed') AND StartTime>'2024-01-01T00:00:00Z'"

      it "renders deeply nested query" $ do
        renderQuery
          ( AndQuery
              [ WorkflowTypeQuery "MyWorkflow"
              , OrQuery
                  [ AndQuery
                      [ StatusQuery Running
                      , StartTimeQuery (After sampleTime1)
                      ]
                  , StatusQuery Completed
                  ]
              ]
          )
          `shouldBe` "WorkflowType='MyWorkflow' AND (WorkflowStatus='Running' AND StartTime>'2024-01-01T00:00:00Z' OR WorkflowStatus='Completed')"

  describe "Edge Cases" $ do
    it "escapes multiple single quotes" $ do
      queryByWorkflowType "My''Workflow"
        `shouldBe` "WorkflowType='My''''Workflow'"

    it "handles workflow type with special characters" $ do
      queryByWorkflowType "My-Workflow_123"
        `shouldBe` "WorkflowType='My-Workflow_123'"

    it "handles workflow ID with dots" $ do
      queryByWorkflowId "workflow.123.456"
        `shouldBe` "WorkflowId='workflow.123.456'"

    it "combines raw query with structured queries" $ do
      renderQuery
        ( AndQuery
            [ WorkflowTypeQuery "MyWorkflow"
            , RawQuery "CustomAttribute='custom-value'"
            , StatusQuery Running
            ]
        )
        `shouldBe` "WorkflowType='MyWorkflow' AND CustomAttribute='custom-value' AND WorkflowStatus='Running'"

  describe "Real-world Query Examples" $ do
    it "finds running workflows of a specific type" $ do
      renderQuery
        ( AndQuery
            [ WorkflowTypeQuery "PaymentProcessing"
            , StatusQuery Running
            ]
        )
        `shouldBe` "WorkflowType='PaymentProcessing' AND WorkflowStatus='Running'"

    it "finds completed workflows in a time range" $ do
      renderQuery
        ( AndQuery
            [ StatusQuery Completed
            , CloseTimeQuery (Between sampleTime1 sampleTime2)
            ]
        )
        `shouldBe` "WorkflowStatus='Completed' AND CloseTime BETWEEN '2024-01-01T00:00:00Z' AND '2024-12-31T23:59:59Z'"

    it "finds workflows by ID or type" $ do
      renderQuery
        ( OrQuery
            [ WorkflowIdQuery "workflow-123"
            , WorkflowTypeQuery "MyWorkflow"
            ]
        )
        `shouldBe` "(WorkflowId='workflow-123' OR WorkflowType='MyWorkflow')"

    it "finds failed or terminated workflows started recently" $ do
      renderQuery
        ( AndQuery
            [ OrQuery
                [ StatusQuery Failed
                , StatusQuery Terminated
                ]
            , StartTimeQuery (After sampleTime1)
            ]
        )
        `shouldBe` "(WorkflowStatus='Failed' OR WorkflowStatus='Terminated') AND StartTime>'2024-01-01T00:00:00Z'"

  describe "Property Tests" $ do
    it "renderQuery and primitive builders produce the same result for WorkflowType" $ hedgehog $ do
      wfType <- forAll $ WorkflowType <$> Gen.text (Range.linear 1 50) Gen.alphaNum
      renderQuery (WorkflowTypeQuery wfType) === queryByWorkflowType wfType

    it "renderQuery and primitive builders produce the same result for WorkflowId" $ hedgehog $ do
      wfId <- forAll $ WorkflowId <$> Gen.text (Range.linear 1 50) Gen.alphaNum
      renderQuery (WorkflowIdQuery wfId) === queryByWorkflowId wfId

    it "renderQuery and primitive builders produce the same result for Status" $ hedgehog $ do
      status <- forAll $ Gen.element [Running, Completed, Failed, Canceled, Terminated, ContinuedAsNew, TimedOut, UnknownStatus]
      renderQuery (StatusQuery status) === queryByStatus status

    it "AndQuery with empty list produces empty string" $ do
      renderQuery (AndQuery []) `shouldBe` ""

    it "all rendered queries are non-empty for non-empty inputs" $ hedgehog $ do
      wfType <- forAll $ WorkflowType <$> Gen.text (Range.linear 1 50) Gen.alphaNum
      let query = queryByWorkflowType wfType
      assert $ not (T.null query)

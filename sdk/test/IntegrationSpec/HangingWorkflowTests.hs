{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}

module IntegrationSpec.HangingWorkflowTests (spec) where

import qualified Data.Map as Map
import Data.Time.Calendar (Day (ModifiedJulianDay))
import DiscoverInstances (discoverInstances)
import IntegrationSpec.HangingWorkflow
import IntegrationSpec.Utils
import RequireCallStack (provideCallStack)
import qualified Temporal.Client as C
import Temporal.Duration
import Temporal.TH (ActivityFn, WorkflowFn, discoverDefinitions)
import qualified Temporal.Workflow as W
import Test.Hspec


-- | Hanging workflow integration test
spec :: SpecWith TestEnv
spec = describe "Hanging Workflow" $ do
  specify "works" $ \TestEnv {..} -> do
    let conf = provideCallStack $ configure () (discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ do
          baseConf
    withWorker conf $ do
      let opts =
            (C.startWorkflowOptions taskQueue)
              { C.workflowIdReusePolicy = Just W.WorkflowIdReusePolicyAllowDuplicate
              , C.timeouts = C.TimeoutOptions {C.runTimeout = Just $ seconds 10, C.executionTimeout = Nothing, C.taskTimeout = Nothing}
              }
      useClient
        ( C.execute PerformPartnerBankRollover "hanging-workflow" opts $
            RolloverRequest
              { orgId = 1
              , rolloverId = 1
              , originBank = Bank1
              , targetBank = Bank2
              , createdAccounts =
                  Accounts
                    { rolledOverDepositoryAccounts = Map.fromList [(1, 100), (2, 200)]
                    }
              , expectedSettlementDate = ModifiedJulianDay 1
              , effectiveDate = ModifiedJulianDay 1
              , transferRequests =
                  [ RolloverTransferFundsRequest
                      { transactionMetadataId = 1
                      , toAccountId = 1
                      , fromAccountId = 2
                      , amount = 100
                      }
                  ]
              }
        )
        `shouldReturn` ()

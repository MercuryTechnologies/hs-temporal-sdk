{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module IntegrationSpec.HangingWorkflow where

import Control.Applicative
import Control.Monad
import Control.Monad.Except
import Data.Aeson.TH
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Time
import Data.Time.Calendar
import Data.Traversable
import RequireCallStack
import Temporal.Activity
import Temporal.Client (TimeoutOptions (..))
import Temporal.Duration (Duration, minutes, nominalDiffTimeToDuration, seconds)
import Temporal.TH
import Temporal.Workflow


data SomeBank = Bank1 | Bank2
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''SomeBank)


data Accounts = Accounts
  { rolledOverDepositoryAccounts :: Map Int Int
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''Accounts)


data RolloverTransferFundsRequest = RolloverTransferFundsRequest
  { transactionMetadataId :: Int
  , toAccountId :: Int
  , fromAccountId :: Int
  , amount :: Int
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverTransferFundsRequest)


data RolloverRequest = RolloverRequest
  { orgId :: Int
  , -- this rollover's unique id (corresponds to the Temporal workflow id)
    rolloverId :: Int
  , -- the existing partner bank
    originBank :: SomeBank
  , -- the new partner bank for the organization
    targetBank :: SomeBank
  , -- existing accounts that should be mirrored at the new partner bank
    createdAccounts :: Accounts
  , -- date fund transfers are expected to settle in new accounts
    expectedSettlementDate :: Day
  , -- the effectiveDate of changes to credit autopay accounts
    effectiveDate :: Day
  , -- funds that the user wants to transfer
    transferRequests :: [RolloverTransferFundsRequest]
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverRequest)


defaultActivityOptions :: StartActivityOptions
defaultActivityOptions = defaultStartActivityOptions $ StartToClose $ minutes 1


opts :: StartChildWorkflowOptions
opts =
  defaultChildWorkflowOptions
    { timeoutOptions =
        TimeoutOptions
          { -- Total time allowed across all workflow runs, including retries.
            executionTimeout = Just $ minutes 5
          , -- Inherits from executionTimeout.
            runTimeout = Nothing
          , -- Defaults to 10 seconds.
            taskTimeout = Just $ minutes 1
          }
    , workflowIdReusePolicy = WorkflowIdReusePolicyAllowDuplicate
    }


timeUntilMidnightOn :: Day -> UTCTime -> Duration
timeUntilMidnightOn date now =
  nominalDiffTimeToDuration $ diffUTCTime midnight now
  where
    midnight = midnightOfDay date
    midnightOfDay day = UTCTime day 0


data RolloverTransferFundsResult = RolloverTransferFundsResult
  { transactionMetadataId :: Int
  , amount :: Int
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverTransferFundsResult)


data RolloverTransferFundsError = RequestedZeroAmountTransfer
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverTransferFundsError)


type PartnerBankRolloverId = Int


data RolloverInitialFundsTransferParams = RolloverInitialFundsTransferParams
  { rolloverId :: PartnerBankRolloverId
  , organizationId :: Int
  , minimumBalance :: Int
  , fromAccountId :: Int
  , toAccountId :: Int
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverInitialFundsTransferParams)


-- trigger transfer of funds from old to new accounts
rolloverInternalFundsTransfer :: RolloverInitialFundsTransferParams -> Activity () (Either RolloverTransferFundsError RolloverTransferFundsResult)
rolloverInternalFundsTransfer params = pure (Left RequestedZeroAmountTransfer)


data RolloverLowBalanceAlertsRequest = RolloverLowBalanceAlertsRequest
  { fromAccountId :: Int
  , toAccountId :: Int
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverLowBalanceAlertsRequest)


data RolloverScheduledPaymentParams = RolloverScheduledPaymentParams
  { accountMap :: [(Int, Int)]
  , effectiveOn :: Maybe Day
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverScheduledPaymentParams)


data RolledOverDepositoryAccounts = RolledOverDepositoryAccounts
  {
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolledOverDepositoryAccounts)


type RolledOverACHAuthorizations = ()


-- disable Low Balance Alerts on the existing accounts and copy them over to the new accounts
rolloverLowBalanceAlerts :: PartnerBankRolloverId -> RolloverLowBalanceAlertsRequest -> Activity () ()
rolloverLowBalanceAlerts rolloverId req = pure ()


type RolloverScheduledPaymentResult = ()


rolloverScheduledPayments :: PartnerBankRolloverId -> RolloverScheduledPaymentParams -> Activity () RolloverScheduledPaymentResult
rolloverScheduledPayments rolloverId params = pure ()


rolloverACHAuthorizations :: PartnerBankRolloverId -> Accounts -> Activity () RolledOverACHAuthorizations
rolloverACHAuthorizations rolloverId accounts = pure ()


data RollOverCreditPaymentRulesParams = RollOverCreditPaymentRulesParams
  { rolloverId :: PartnerBankRolloverId
  , organizationId :: Int
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RollOverCreditPaymentRulesParams)


type RollOverCreditPaymentRulesResult = ()


rolloverCreditPaymentRulesActivity :: RollOverCreditPaymentRulesParams -> Activity () (Maybe RollOverCreditPaymentRulesResult)
rolloverCreditPaymentRulesActivity _ = pure Nothing


data RolloverBillingEngineRequest = RolloverBillingEngineRequest
  { orgId :: Int
  , accountMap :: [(Int, Int)]
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''RolloverBillingEngineRequest)


type BillingEngineSubscriptionUnchanged = ()


type BillingEngineSubscriptionChanged = ()


rolloverBillingEngine
  :: PartnerBankRolloverId
  -> RolloverBillingEngineRequest
  -> Activity () (Either BillingEngineSubscriptionUnchanged BillingEngineSubscriptionChanged)
rolloverBillingEngine rolloverId request = pure (Right ())


type UpdateRolloverStatusError = ()


data Status = Good | Bad
  deriving stock (Eq, Show)


deriveJSON defaultOptions ''Status


data PartnerBankRolloverStatusUpdate = PartnerBankRolloverStatusUpdate
  { rolloverId :: PartnerBankRolloverId
  , status :: Status
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''PartnerBankRolloverStatusUpdate)


-- update the status of the rollover
setRolloverStatus :: PartnerBankRolloverStatusUpdate -> Activity () (Either UpdateRolloverStatusError ())
setRolloverStatus _ = pure $ Right ()


type TransactionMetadataId = Int


getMetadataStatus :: TransactionMetadataId -> Activity () Status
getMetadataStatus transactionMetadataId = pure Good


registerActivity 'rolloverInternalFundsTransfer
registerActivity 'rolloverLowBalanceAlerts
registerActivity 'rolloverScheduledPayments
registerActivity 'rolloverACHAuthorizations
registerActivity 'rolloverCreditPaymentRulesActivity
registerActivity 'rolloverBillingEngine
registerActivity 'setRolloverStatus
registerActivity 'getMetadataStatus
pure []


data ActivateAccountRequest = ActivateAccountRequest
  { rolloverId :: PartnerBankRolloverId
  , organizationId :: Int
  , originalDepositoryAccountId :: Int
  , newDepositoryAccountId :: Int
  }
  deriving stock (Eq, Show)


$(deriveJSON defaultOptions ''ActivateAccountRequest)


activateAccountWorkflow :: ActivateAccountRequest -> Workflow ()
activateAccountWorkflow ActivateAccountRequest {..} = do
  pure ()


registerWorkflow 'activateAccountWorkflow
pure []


attemptFundTransfer :: RequireCallStack => RolloverInitialFundsTransferParams -> Workflow (Either RolloverTransferFundsError RolloverTransferFundsResult)
attemptFundTransfer transferParams = do
  transferResult <-
    executeActivity
      RolloverInternalFundsTransfer
      defaultActivityOptions
      transferParams

  transactionStatus <-
    for transferResult $ \result -> executeActivity GetMetadataStatus defaultActivityOptions result.transactionMetadataId

  let hasTransactionAlreadySucceeded = transactionStatus `elem` (Right <$> [Good])

  -- If the transfer was successful, or if the transfer was requested with a zero amount, we make sure to rerun
  -- the ActivateAccount workflow. Otherwise, this workflow only runs when a balance transfer completes, which
  -- would never happen in these cases.
  when (transferResult == Left RequestedZeroAmountTransfer || hasTransactionAlreadySucceeded) do
    let requestData =
          ActivateAccountRequest
            { rolloverId = transferParams.rolloverId
            , organizationId = transferParams.organizationId
            , originalDepositoryAccountId = transferParams.fromAccountId
            , newDepositoryAccountId = transferParams.toAccountId
            }

    executeChildWorkflow
      ActivateAccountWorkflow
      opts
      requestData

  pure transferResult


-- migrate an organization to a new partner bank
performPartnerBankRollover :: RolloverRequest -> Workflow ()
performPartnerBankRollover RolloverRequest {..} = provideCallStack do
  _updatedACHAuth <-
    executeActivity
      RolloverACHAuthorizations
      defaultActivityOptions
      rolloverId
      createdAccounts

  _lowBalanceAlerts <-
    for (Map.toList createdAccounts.rolledOverDepositoryAccounts) \(fromAccountId, toAccountId) -> do
      executeActivity
        RolloverLowBalanceAlerts
        defaultActivityOptions
        rolloverId
        RolloverLowBalanceAlertsRequest
          { fromAccountId = fromAccountId
          , toAccountId = toAccountId
          }

  _billingEngineSubscription <-
    executeActivity
      RolloverBillingEngine
      defaultActivityOptions
      rolloverId
      RolloverBillingEngineRequest
        { orgId = orgId
        , accountMap = Map.toList createdAccounts.rolledOverDepositoryAccounts
        }

  void $
    executeActivity
      SetRolloverStatus
      defaultActivityOptions
      PartnerBankRolloverStatusUpdate
        { rolloverId
        , status = Good
        }

  _transferFunds <-
    for transferRequests \req -> runExceptT do
      toAccountId <-
        case Map.lookup req.fromAccountId createdAccounts.rolledOverDepositoryAccounts of
          Nothing -> ExceptT $ pure $ Left RequestedZeroAmountTransfer
          Just accountId -> pure accountId

      ExceptT $
        attemptFundTransfer
          RolloverInitialFundsTransferParams
            { rolloverId
            , organizationId = orgId
            , minimumBalance = req.amount
            , fromAccountId = req.fromAccountId
            , toAccountId = req.toAccountId
            }

  let postSettlementDate = addDays 1 expectedSettlementDate

  _updateScheduledPayments <-
    executeActivity
      RolloverScheduledPayments
      defaultActivityOptions
      rolloverId
      RolloverScheduledPaymentParams
        { accountMap = Map.toList createdAccounts.rolledOverDepositoryAccounts
        , effectiveOn = Just postSettlementDate
        }

  t <- now
  sleep $ timeUntilMidnightOn postSettlementDate t

  _updateRemainingScheduledPayments <-
    executeActivity
      RolloverScheduledPayments
      defaultActivityOptions
      rolloverId
      RolloverScheduledPaymentParams
        { accountMap = Map.toList createdAccounts.rolledOverDepositoryAccounts
        , effectiveOn = Nothing
        }

  _creditPaymentRules <-
    executeActivity
      RolloverCreditPaymentRulesActivity
      defaultActivityOptions
      RollOverCreditPaymentRulesParams
        { rolloverId
        , organizationId = orgId
        }

  pure ()


registerWorkflow
  'performPartnerBankRollover

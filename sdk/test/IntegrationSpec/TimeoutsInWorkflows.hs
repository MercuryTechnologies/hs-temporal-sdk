{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}
module IntegrationSpec.TimeoutsInWorkflows where

import Control.Exception (SomeException)
import Control.Exception.Annotated
import Control.Monad.Logger
import qualified Data.Text as T
import RequireCallStack
import Temporal.Activity (Activity)
import Temporal.Duration
import Temporal.Exception
import Temporal.TH
import Temporal.Workflow


timeoutActivity :: Activity () Bool
timeoutActivity = provideCallStack $ error "Wombats"


registerActivity 'timeoutActivity
pure []


activityOpts :: StartActivityOptions
activityOpts =
  (defaultStartActivityOptions $ StartToClose $ seconds 5)
    { retryPolicy =
        Just
          ( defaultRetryPolicy
              { maximumAttempts = 1
              }
          )
    }


activityTimeoutInWorkflow :: Workflow Bool
activityTimeoutInWorkflow = provideCallStack $ do
  foo <- try $ executeActivity TimeoutActivity activityOpts
  case foo of
    Left e -> do
      $(logError) (T.pack $ show (e :: ActivityFailure))
      -- Your exception type here, if you're picky about the error type
      if e.cause.type' == "ErrorCallWithLocation" && e.retryState == RetryStateMaximumAttemptsReached
        then pure False
        else throw e
    Right ok -> pure ok


registerWorkflow 'activityTimeoutInWorkflow

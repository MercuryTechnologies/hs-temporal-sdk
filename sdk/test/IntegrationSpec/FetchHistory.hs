{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module IntegrationSpec.FetchHistory where

import Data.ProtoLens.Field ()
import RequireCallStack (provideCallStack)
import Data.Foldable (for_)
import Temporal.Activity (Activity)
import Temporal.Duration (seconds)
import qualified Temporal.TH as TH
import Temporal.Workflow (Workflow, StartToClose(..))
import qualified Temporal.Workflow as Workflow

noopActivity :: Activity () ()
noopActivity = pure ()

TH.registerActivity 'noopActivity

noopWorkflow :: Workflow ()
noopWorkflow = provideCallStack do
  for_ [(1 :: Int)..200] \_ ->
    Workflow.executeActivity NoopActivity $ Workflow.defaultStartActivityOptions $ StartToClose $ seconds 1

TH.registerWorkflow 'noopWorkflow

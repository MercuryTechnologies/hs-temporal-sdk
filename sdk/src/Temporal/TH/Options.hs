{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveLift #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE RankNTypes #-}

module Temporal.TH.Options (
  WorkflowConfiguration (..),
  defaultWorkflowConfiguration,
  ActivityConfiguration (..),
  defaultActivityConfiguration,
) where

import Data.Data
import Data.Text
import Language.Haskell.TH.Syntax (Lift)


data WorkflowConfiguration = WorkflowConfiguration
  { wfNameOverride :: Maybe Text
  , wfAliases :: [Text]
  }
  deriving stock (Show, Eq, Data, Lift)


defaultWorkflowConfiguration :: WorkflowConfiguration
defaultWorkflowConfiguration =
  WorkflowConfiguration
    { wfNameOverride = Nothing
    , wfAliases = []
    }


data ActivityConfiguration = ActivityConfiguration
  { actNameOverride :: Maybe Text
  , actAliases :: [Text]
  }
  deriving stock (Show, Eq, Data, Lift)


defaultActivityConfiguration :: ActivityConfiguration
defaultActivityConfiguration =
  ActivityConfiguration
    { actNameOverride = Nothing
    , actAliases = []
    }

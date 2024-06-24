{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE TemplateHaskell #-}

module Temporal.Workflow.TH (
  execute,
  execute',
  start,
  start',
) where

import Control.Monad.IO.Class
import Data.Maybe
import qualified Language.Haskell.TH as TH
import qualified Language.Haskell.TH.Syntax as TH
import Temporal.TH.Classes
import Temporal.TH.Internal


execute :: (TH.Quote m, TH.Quasi m) => TH.Name -> m TH.Exp
execute n = do
  let ncon = fnSingDataAndConName n
  nconT <- TH.conT ncon
  nconE <- mkNconE ncon
  isActivity <- not . null <$> TH.qReifyInstances ''ActivityFn [nconT]
  hasDefaultTimeout <- not . null <$> TH.qReifyInstances ''ActivityTimeout [nconT]
  isWorkflow <- not . null <$> TH.qReifyInstances ''WorkflowFn [nconT]
  liftIO $ print (n, isActivity, hasDefaultTimeout, isWorkflow)
  if
    | isActivity -> do
        -- Determine if the Activity has a default timeout. If so,
        -- use that to construct the options. Otherwise, the user must provide
        -- the activityTimeout themselves.
        if hasDefaultTimeout
          then
            [|
              executeActivity
                (activityRef $(pure nconE))
                (activityOptions $(pure nconE) $ defaultStartActivityOptions $ Temporal.TH.Classes.activityTimeout $(pure nconE))
              |]
          else
            [|
              executeActivity (activityRef $(pure nconE)) . activityOptions $(pure nconE) . defaultStartActivityOptions
              |]
    | isWorkflow ->
        [|
          executeChildWorkflow
            (workflowRef $(pure nconE))
            (fromMaybe defaultChildWorkflowOptions (childWorkflowDefaultOptions $ workflowConfig $(pure nconE)))
          |]
    | otherwise -> error "Not a known Activity or Workflow"


start :: (TH.Quote m, TH.Quasi m) => TH.Name -> m TH.Exp
start n = do
  let ncon = fnSingDataAndConName n
  nconT <- TH.conT ncon
  nconE <- mkNconE ncon
  isActivity <- not . null <$> TH.qReifyInstances ''ActivityFn [nconT]
  hasDefaultTimeout <- not . null <$> TH.qReifyInstances ''ActivityTimeout [nconT]
  isWorkflow <- not . null <$> TH.qReifyInstances ''WorkflowFn [nconT]
  if
    | isActivity ->
        if hasDefaultTimeout
          then
            [|
              startActivity
                (activityRef $(pure nconE))
                (activityOptions $(pure nconE) $ defaultStartActivityOptions $ Temporal.TH.Classes.activityTimeout $(pure nconE))
              |]
          else
            [|
              startActivity (activityRef $(pure nconE)) . activityOptions $(pure nconE) . defaultStartActivityOptions
              |]
    | isWorkflow ->
        [|
          startChildWorkflow
            (workflowRef $(pure nconE))
            (fromMaybe defaultChildWorkflowOptions (childWorkflowDefaultOptions $ workflowConfig $(pure nconE)))
          |]
    | otherwise -> error "Not a known Activity or Workflow"


execute' :: (TH.Quote m, TH.Quasi m) => TH.Name -> m TH.Exp
execute' n = do
  let ncon = fnSingDataAndConName n
  nconT <- TH.conT ncon
  nconE <- mkNconE ncon
  isActivity <- not . null <$> TH.qReifyInstances ''ActivityFn [nconT]
  isWorkflow <- not . null <$> TH.qReifyInstances ''WorkflowFn [nconT]
  if
    | isActivity -> [|executeActivity (activityRef $(pure nconE))|]
    | isWorkflow -> [|executeChildWorkflow (workflowRef $(pure nconE))|]
    | otherwise -> error "Not a known Activity or Workflow"


start' :: (TH.Quote m, TH.Quasi m) => TH.Name -> m TH.Exp
start' n = do
  let ncon = fnSingDataAndConName n
  nconT <- TH.conT ncon
  nconE <- mkNconE ncon
  isActivity <- not . null <$> TH.qReifyInstances ''ActivityFn [nconT]
  isWorkflow <- not . null <$> TH.qReifyInstances ''WorkflowFn [nconT]
  if
    | isActivity -> do
        [|startActivity (activityRef $(pure nconE))|]
    | isWorkflow -> [|startChildWorkflow (workflowRef $(pure nconE))|]
    | otherwise -> error "Not a known Activity or Workflow"

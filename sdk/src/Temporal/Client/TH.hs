{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ViewPatterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant bracket" #-}

module Temporal.Client.TH where

import Data.Proxy
import qualified Language.Haskell.TH.Lib as TH
import qualified Language.Haskell.TH.Syntax as TH
import Temporal.Client
import Temporal.TH
import Temporal.TH.Classes
import Temporal.TH.Internal
import Temporal.Workflow hiding (workflowRef)


-- makeGenericMSig :: Name -> Name -> ([TH.Type], TH.Type) -> m TH.Dec
-- makeGenericMSig fName mName (args, res) =
--   TH.sigD fName $

renderType :: TH.Q TH.Type -> TH.Q TH.Exp
renderType t = do
  t' <- t
  TH.runIO $ print t'
  pure $ TH.LitE $ TH.StringL $ show t'


execute :: (TH.Quote m, TH.Quasi m) => TH.Name -> m TH.Exp
execute n = do
  let ncon = fnSingDataAndConName n
  nconT <- TH.conT ncon

  isActivity <- not . null <$> TH.qReifyInstances ''ActivityFn [nconT]
  isWorkflow <- not . null <$> TH.qReifyInstances ''WorkflowFn [nconT]
  t <- TH.qReifyType n
  let (args, res) = splitArgsAndResult t
      argsAsPromotedList = foldr (\a b -> [t|$(pure a) ': $b|]) TH.promotedNilT args

  if
    | isActivity -> error "Activities cannot be invoked here. They must be invoked from within a Workflow."
    | isWorkflow -> do
        hasDefaultTaskQueue <- not . null <$> TH.qReifyInstances ''WorkflowRootTaskQueue [nconT]
        let baseExecution =
              [|
                Temporal.Client.execute
                  ( let refProxy :: Proxy $(pure nconT)
                        refProxy = Proxy

                        ref :: ProvidedWorkflow (FnType $(pure nconT))
                        ref = workflowRef refProxy

                        kwf :: KnownWorkflow $argsAsPromotedList $(pure $ extractWorkflowResultType res)
                        kwf = reference ref
                    in kwf
                  )
                |]
        if hasDefaultTaskQueue
          then
            [|
              \wfId ->
                $(baseExecution)
                  wfId
                  (workflowClientStartOptions (Proxy :: Proxy $(pure nconT)) $ startWorkflowOptions $ workflowRootTaskQueue (Proxy :: Proxy $(pure nconT)))
              |]
          else [|\wfId -> $(baseExecution) wfId . workflowClientStartOptions (Proxy :: Proxy $(pure nconT)) . startWorkflowOptions|]
    | otherwise -> error "Not a known Workflow"


start :: (TH.Quote m, TH.Quasi m) => TH.Name -> m TH.Exp
start n = do
  let ncon = fnSingDataAndConName n
  nconT <- TH.conT ncon

  isActivity <- not . null <$> TH.qReifyInstances ''ActivityFn [nconT]
  isWorkflow <- not . null <$> TH.qReifyInstances ''WorkflowFn [nconT]
  t <- TH.qReifyType n
  let (args, res) = splitArgsAndResult t
      argsAsPromotedList = foldr (\a b -> [t|$(pure a) ': $b|]) TH.promotedNilT args

  if
    | isActivity -> error "Activities cannot be invoked here. They must be invoked from within a Workflow."
    | isWorkflow -> do
        hasDefaultTaskQueue <- not . null <$> TH.qReifyInstances ''WorkflowRootTaskQueue [nconT]
        let baseExecution =
              [|
                Temporal.Client.start
                  ( let refProxy :: Proxy $(pure nconT)
                        refProxy = Proxy

                        ref :: ProvidedWorkflow (FnType $(pure nconT))
                        ref = workflowRef refProxy

                        kwf :: KnownWorkflow $argsAsPromotedList $(pure $ extractWorkflowResultType res)
                        kwf = reference ref
                    in kwf
                  )
                |]
        if hasDefaultTaskQueue
          then
            [|
              \wfId ->
                $(baseExecution)
                  wfId
                  (workflowClientStartOptions (Proxy :: Proxy $(pure nconT)) $ startWorkflowOptions $ workflowRootTaskQueue (Proxy :: Proxy $(pure nconT)))
              |]
          else [|\wfId -> $(baseExecution) wfId . workflowClientStartOptions (Proxy :: Proxy $(pure nconT)) . startWorkflowOptions|]
    | otherwise -> error "Not a known Workflow"

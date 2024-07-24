{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveLift #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE UndecidableSuperClasses #-}

module Temporal.TH.Internal where

import Data.Char
import qualified Data.Text as Text
import qualified Language.Haskell.TH as TH
import Language.Haskell.TH.Lib
import qualified Language.Haskell.TH.Syntax as TH
import Temporal.Activity (Activity)
import Temporal.TH.Classes
import Temporal.Workflow


isOperator :: TH.Name -> Bool
isOperator name =
  case TH.nameBase name of
    (c : _) -> (isSymbol c || isPunctuation c) && c /= '_'
    _ -> False


-- N.B. This is used for declaring an instance in the current module,
-- so it can't be used outside of local instance declaration code, as it will
-- be out of scope.
fnSingDataAndConName :: TH.Name -> TH.Name
fnSingDataAndConName n
  | isOperator n = TH.mkName $ ":" ++ TH.nameBase n
  | otherwise = TH.mkName $ case TH.nameBase n of
      (c : rest) -> toUpper c : rest
      [] -> error "fnSingDataAndConName: empty name"


makeFnDecls :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> TH.Type -> m [TH.Dec]
makeFnDecls n t = do
  let dName = fnSingDataAndConName n
  dataDec <-
    dataD
      (cxt [])
      dName
      []
      Nothing
      [ normalC dName []
      ]
      []
  instDecs <-
    [d|
      instance Fn $(conT dName) where
        type FnType $(conT dName) = $(pure t)
        fnName _ = Text.pack $(TH.litE (TH.stringL $ show n))
        fnDefinition _ = $(varE n)
        fnSing = $(TH.conE dName)
      |]
  pure $ dataDec : instDecs


-- Safe to use in other modules, because we're using the Symbol to find it.
fnSingE :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> m TH.Exp
fnSingE n = [e|fnSing :: $(conT $ fnSingDataAndConName n)|]


splitArgsAndResult :: TH.Type -> ([TH.Type], TH.Type)
splitArgsAndResult (TH.AppT (TH.AppT TH.ArrowT arg) res) = let (args, result) = splitArgsAndResult res in (arg : args, result)
splitArgsAndResult res = ([], res)


-- Get the 'a' out of 'Activity env a'
extractActivityResultType :: TH.Type -> TH.Type
extractActivityResultType (TH.AppT (TH.AppT (TH.ConT _) _) res) = res
extractActivityResultType _ = error "Not a type application on Activity"


-- Get the 'a' out of 'Workflow a'
extractWorkflowResultType :: TH.Type -> TH.Type
extractWorkflowResultType (TH.AppT (TH.ConT _) res) = res
extractWorkflowResultType _ = error "Not a type application on Workflow"


isWorkflowFunction :: TH.Type -> Bool
isWorkflowFunction t = case splitArgsAndResult t of
  (_, TH.AppT (TH.ConT n) _) -> n == ''Workflow
  _ -> False


isActivityFunction :: TH.Type -> Bool
isActivityFunction t = case splitArgsAndResult t of
  (_, TH.AppT (TH.AppT (TH.ConT n) _) _) -> n == ''Activity
  _ -> False


makeWorkflowWrapped :: TH.Type -> TH.Type
makeWorkflowWrapped = TH.AppT (TH.ConT ''Workflow)


makeWorkflowResultWrapped :: TH.Type -> TH.Type
makeWorkflowResultWrapped = TH.AppT (TH.ConT ''WorkflowResult)


makeTaskWrapped :: TH.Type -> TH.Type
makeTaskWrapped = TH.AppT (TH.ConT ''Task)


reapplyArgs :: ([TH.Type], TH.Type) -> TH.Type
reapplyArgs (args, res) =
  -- add an arrow between all of the args into the result
  foldr (TH.AppT . TH.AppT TH.ArrowT) res args


retypeAsWorkflow
  :: Monad m
  => (TH.Type -> TH.Type)
  -- ^ Result extractor
  -> (TH.Type -> TH.Type)
  -- ^ Result wrapper
  -> TH.Type
  -> m TH.Type
retypeAsWorkflow extract wrap t = pure $ reapplyArgs (args, makeWorkflowWrapped $ wrap $ extract res)
  where
    (args, res) = splitArgsAndResult t


mkNconE :: (TH.Quote m) => TH.Name -> m TH.Exp
mkNconE n = TH.varE 'pure `TH.appE` TH.conE n

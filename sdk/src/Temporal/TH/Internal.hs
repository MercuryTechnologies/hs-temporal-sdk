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

import Control.Monad.IO.Class
import Data.Char
-- import qualified Language.Haskell.TH.Datatype as TH

import Data.Data (Data)
import Data.Kind (Type)
import Data.Maybe
import Data.Proxy (Proxy)
import qualified Data.Text as Text
import Data.Typeable
import qualified Language.Haskell.TH as TH
import Language.Haskell.TH.Lib
import qualified Language.Haskell.TH.Syntax as TH
import Temporal.Activity (Activity, ProvidedActivity, provideActivity)
import Temporal.Bundle (Def, Ref)
import Temporal.Client (StartWorkflowOptions)
import Temporal.Payload
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
  | otherwise = TH.mkName $ "Fn_" ++ TH.nameBase n


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
        fnTHName _ = $(TH.liftData n)
      |]
  pure $ dataDec : instDecs


-- [
-- , instanceD (cxt []) [t|Fn $(conT dName)|]
--   [ tySynInstD $ tySynEqn Nothing [t|FnType $(conT dName)|] (TH.qReifyType n)
--   , funD 'fnName [clause [wildP] (normalB $ TH.varE 'Text.pack `TH.appE` TH.litE (TH.stringL $ show n)) []]
--   , funD 'fnDefinition [clause [wildP] (normalB $ varE n) []]
--   , funD 'fnSing [clause [] (normalB $ TH.conE dName) []]
--   -- , funD 'fnTHName [clause [wildP] (normalB $(n)) []]
--   ]
-- ]

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


-- reifyActivityTimeout :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> m (Maybe ActivityTimeoutPolicy)
-- reifyActivityTimeout n = do
--   TH.qReifyAnnotations @m @ActivityTimeoutPolicy (TH.AnnLookupName n) >>= \case
--     [] -> pure Nothing
--     [timeout] -> pure $ Just timeout
--     _ -> error "Multiple ActivityTimeout annotations, not sure which to use"

materializeActivityConfig :: forall m. (TH.Quote m, TH.Quasi m) => TH.Name -> m (TH.TExp (Maybe ActivityConfig))
materializeActivityConfig n =
  TH.qReifyInstances ''ActivityFn [TH.ConT $ fnSingDataAndConName n] >>= \case
    [] -> TH.examineCode [||Nothing||]
    _ -> TH.examineCode [||Just $$(TH.unsafeCodeCoerce $ varE 'activityConfig `appE` fnSingE n)||]


mkNconE :: (TH.Quote m) => TH.Name -> m TH.Exp
mkNconE n = TH.varE 'pure `TH.appE` TH.conE n

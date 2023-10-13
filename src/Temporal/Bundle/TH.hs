{-# LANGUAGE CPP #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE RecordWildCards #-}
-- | 
-- Module: Temporal.Bundle.TH
-- Description: Reduce Temporal.Bundle boilerplate with Template Haskell.
--
-- This module provides Template Haskell functions for generating the
-- boilerplate required to use the Temporal.Bundle module.
--
-- This is generally the easiest way to define groups of related
-- activities and workflows with minimal boilerplate.
--
-- See 'Temporal.Bundle' for more example code.
module Temporal.Bundle.TH 
  ( temporalBundle
  , temporalBundleWithoutSynonyms
  , declareBareBWith
  , declareBareBWithOtherBarbies
  , DeclareBareBConfig(..)
  ) where
-- This file is a modified version of Barbies.TH from the barbies-th package.
-- The original license is reproduced below.
--
-- Copyright Fumiaki Kinoshita (c) 2019

-- All rights reserved.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:

--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.

--     * Redistributions in binary form must reproduce the above
--       copyright notice, this list of conditions and the following
--       disclaimer in the documentation and/or other materials provided
--       with the distribution.

--     * Neither the name of Fumiaki Kinoshita nor the names of other
--       contributors may be used to endorse or promote products derived
--       from this software without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-- OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-- LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-- THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
import Language.Haskell.TH hiding (cxt)
import Language.Haskell.TH.Syntax (VarBangType, Name(..), mkOccName, occString)
import Data.Bifunctor (first)
import Data.String
import Data.Foldable (foldl')
import Data.List (partition, nub)
import qualified Data.List.NonEmpty as NE
import Barbies
import Barbies.Constraints
import Barbies.Bare
import Data.Functor.Product
import GHC.Generics (Generic)
import Control.Applicative
import Data.Functor.Identity (Identity(..))
import Data.Functor.Compose (Compose(..))
import Data.List.Split
import Data.Maybe
import Temporal.Bundle

data DeclareBareBConfig = DeclareBareBConfig
  { friends :: [Name] -- ^ Members with these types won't be wrapped with 'Wear'
  , bareName :: String -> Maybe String
  -- ^ generate a type synonym for the 'Barbies.Bare.Bare' type?
  , coveredName :: String -> Maybe String
  -- ^ generate a type synonym for the 'Barbies.Bare.Covered' type?
  , barbieName :: String -> String
  -- ^ modify the name of the datatype
  , switchName :: Q Name
  -- ^ the name of the type parameter to toggle between Bare and covered
  , wrapperName :: Q Name
  -- ^ the name of the type parameter of the wrapper for each field
  }

-- | Does not define any type synonyms
classic :: DeclareBareBConfig
classic = DeclareBareBConfig
  { friends = []
  , bareName = const Nothing
  , coveredName = const Nothing
  , barbieName = id
  , switchName = newName "sw"
  , wrapperName = newName "h"
  }

-- | Defines a synonym for the bare type with the same name.
-- The strippable definition is suffixed by B, and the covered type is suffixed by H.
passthrough :: DeclareBareBConfig
passthrough = DeclareBareBConfig
  { friends = []
  , bareName = Just
  , coveredName = Just . (++"H")
  , barbieName = (++"B")
  , switchName = newName "sw"
  , wrapperName = newName "h"
  }


-- | Transform a regular Haskell record declaration into HKD form.
-- 'BareB', 'FieldNamesB', 'FunctorB', 'DistributiveB',
-- 'TraversableB', 'ApplicativeB' and 'ConstraintsB' instances are
-- derived.
--
-- For example,
--
-- @declareBareB [d|data User = User { uid :: Int, name :: String}|]@
--
-- becomes
--
-- @data User t f = User { uid :: Wear t f Int, name :: Wear t f String }@
--
temporalBundleWithoutSynonyms :: DecsQ -> DecsQ
temporalBundleWithoutSynonyms = declareBareBWith classic

-- | Defines a synonym for the bare type with the same name.
-- The strippable definition is suffixed by B, and the covered type is suffixed by H.
temporalBundle :: DecsQ -> DecsQ
temporalBundle = declareBareBWith passthrough

-- | Like 'declareBareB' except that one can specify the 'Name's of other
-- barbies. Members with these types won't be wrapped with 'Wear'.
declareBareBWithOtherBarbies :: [Name] -> DecsQ -> DecsQ
declareBareBWithOtherBarbies xs = declareBareBWith classic { friends = xs }

-- | Generate a higher-kinded data declaration using a custom config
declareBareBWith :: DeclareBareBConfig -> DecsQ -> DecsQ
declareBareBWith DeclareBareBConfig{..} decsQ = do
  decs <- decsQ
  let otherBarbieNames = [ (k, mkName $ barbieName $ nameBase k) | k <- dataDecNames decs ]
          ++ map (\x -> (x, x)) friends
  decs' <- traverse (go otherBarbieNames) decs
  return $ concat decs'
  where
    go otherBarbieNames (DataD _ dataName0 tvbs _ [con@(RecC nDataCon mangledfields)] classes) = do
      let dataName = mkName $ barbieName $ nameBase dataName0
      let fields = [(unmangle name, c, t) | (name, c, t) <- mangledfields]
      nSwitch <- switchName
      nWrap <- wrapperName
      let xs = varNames "x" fields
      let ys = varNames "y" fields
      -- 'mapMembers' applies one of two functions to elements of a list
      -- according to whether or not they align with another barbie
      let otherBarbieMask = [ case t of
                                ConT n | Just v <- lookup n otherBarbieNames -> Just v
                                _ -> Nothing
                            | (_, _, t) <- fields
                            ]
      let mapMembers :: (b -> c) -> (b -> c) -> [b] -> [c]
          mapMembers normal otherBarbie = zipWith (maybe normal (const otherBarbie)) otherBarbieMask
      nData <- newName "b"
      nConstr <- newName "c"
      nX <- newName "x"
      let transformed = transformCon otherBarbieNames nSwitch nWrap con
      let reconE = foldl' appE (conE nDataCon)
          -- field names for FieldNamesB
          strLit str = [|fromString $(litE $ StringL str)|]
          fieldNamesE = reconE $ mapMembers
            (\(name,_,_) -> conE 'Const `appE` strLit (nameBase name))
            (\_ -> [|bfieldNames|])
            fields
          nestedFieldNamesE = reconE $ mapMembers
            (\(name,_,_) -> [|Const $ pure $(strLit $ nameBase name)|])
            (\(name,_,_) -> [|first (NE.cons $(strLit $ nameBase name)) `bmap` bnestedFieldNames|])
            fields

          -- Turn TyVarBndr into just a Name such that we can
          -- reconstruct the constructor applied to already-present
          -- type variables below.
#if MIN_VERSION_template_haskell(2,17,0)
          varName (PlainTV n _) = n
          varName (KindedTV n _ _) = n
#else
          varName (PlainTV n) = n
          varName (KindedTV n _) = n
#endif

          -- The type name as present originally along with its type
          -- variables.
          vanillaType = foldl' appT (conT dataName) (varT . varName <$> tvbs)

      -- bare/covered types
      bareType <- [t| $(vanillaType) Bare Identity |]
      coveredType <- [t| $(vanillaType) Covered |]

      -- max arity = 62
      let typeChunks = chunksOf 62
            [ case mask of
              Just t' -> [t| AllB $(varT nConstr) ($(conT t') Covered)|]
              Nothing -> varT nConstr `appT` pure t
            | ((_, _, t), mask) <- zip fields otherBarbieMask
            ]
          mkConstraints ps = foldl appT (tupleT $ length ps) ps
          allConstr = case typeChunks of
            [ps] -> mkConstraints ps
            pss -> mkConstraints $ map mkConstraints pss


      let datC = pure coveredType
      decs <- [d|
        instance BareB $(vanillaType) where
          bcover $(conP nDataCon $ map varP xs)
            = $(reconE $ mapMembers (appE (conE 'Identity)) (appE (varE 'bcover)) (varE <$> xs))
          {-# INLINE bcover #-}
          bstrip $(conP nDataCon $ map varP xs)
            = $(reconE $ mapMembers (appE (varE 'runIdentity)) (appE (varE 'bstrip)) (varE <$> xs))
          {-# INLINE bstrip #-}
        instance FieldNamesB $(pure coveredType) where
          bfieldNames = $(fieldNamesE)
          bnestedFieldNames = $(nestedFieldNamesE)
        instance Label $(pure coveredType) where
          fieldNames = bfieldNames
        instance FunctorB $(pure coveredType) where
          bmap f $(conP nDataCon $ map varP xs)
            = $(reconE (mapMembers (appE (varE 'f)) (appE [|bmap f|]) (varE <$> xs)))
        instance DistributiveB $(pure coveredType) where
          bdistribute fb = $(reconE $
              -- TODO: NoFieldSelectors
              mapMembers
                (\fd -> [| Compose ($fd <$> fb) |])
                (\fd -> [| bdistribute ($fd <$> fb) |])
                [varE fd | (fd, _, _) <- fields]
            )
        instance TraversableB $(pure coveredType) where
          btraverse f $(conP nDataCon $ map varP xs) = $(fst $ foldl'
              (\(l, op) r -> (infixE (Just l) (varE op) (Just r), '(<*>)))
              (conE nDataCon, '(<$>))
              (mapMembers (appE (varE 'f)) (\x -> [|btraverse f $x|]) (varE <$> xs))
            )
          {-# INLINE btraverse #-}
        instance ConstraintsB $(pure coveredType) where
          type AllB $(varT nConstr) $(pure coveredType) = $(allConstr)
          baddDicts $(conP nDataCon $ map varP xs)
            = $(reconE $ mapMembers
                (\x -> [|Pair Dict $x|])
                (\x -> [|baddDicts $x|])
                (varE <$> xs)
              )
        instance ApplicativeB $(pure coveredType) where
          bpure $(varP nX) = $(reconE $ mapMembers
                                (const (varE nX))
                                (const [|bpure $(varE nX)|])
                                xs
                              )
          bprod $(conP nDataCon $ map varP xs) $(conP nDataCon $ map varP ys) = $(foldl'
            (\r (isOtherBarbie, x, y) ->
              if isJust isOtherBarbie
                then [|$r (bprod $(varE x) $(varE y))|]
                else [|$r (Pair $(varE x) $(varE y))|])
            (conE nDataCon) (zip3 otherBarbieMask xs ys))
        |]
      -- strip deriving Generic
      let classes' = map (\(DerivClause strat cs) -> fmap (DerivClause strat) $ partition (== ConT ''Generic) cs) classes

      -- For the covered type, derive instances via 'Barbie' wrapper instead.
      coverDrvs <- traverse (\cls ->
        [d|deriving via Barbie $(datC) $(varT nWrap)
            instance ($(cls) (Barbie $(datC) $(varT nWrap))) => $(cls) ($(datC) $(varT nWrap))|])
        [ pure t | (_, DerivClause _ preds) <- classes', t <- preds ]
      -- Redefine instances of the bare type with the original strategy
      bareDrvs <- traverse (\(strat, cls) ->
        standaloneDerivWithStrategyD strat (pure []) [t|$(cls) $(pure bareType)|])
        [ (strat, pure t) | (_, DerivClause strat preds) <- classes', t <- preds ]
      return $ DataD [] dataName
#if MIN_VERSION_template_haskell(2,17,0)
        (tvbs ++ [PlainTV nSwitch (), PlainTV nWrap ()])
#else
        (tvbs ++ [PlainTV nSwitch, PlainTV nWrap])
#endif
        Nothing
        [transformed]
        [DerivClause Nothing $ concatMap fst classes']
        : decs ++ concat coverDrvs ++ bareDrvs
        ++ [ TySynD (mkName name) tvbs bareType | name <- maybeToList $ bareName $ nameBase dataName0]
        ++ [ TySynD (mkName name) tvbs coveredType | name <- maybeToList $ coveredName $ nameBase dataName0]
    go _ d = pure [d]

dataDecNames :: [Dec] -> [Name]
dataDecNames = nub . mapMaybe decName
 where
  decName :: Dec -> Maybe Name
  decName = \case
    DataD    _ n _ _ _ _ -> Just n
    _                    -> Nothing

varNames :: String -> [VarBangType] -> [Name]
varNames p vbt = [mkName (p ++ nameBase v) | (v, _, _) <- vbt]

transformCon :: [(Name, Name)] -- ^ Names of other barbies
  -> Name -- ^ switch variable
  -> Name -- ^ wrapper variable
  -> Con -- ^ original constructor
  -> Con
transformCon otherBarbieNames switchName wrapperName (RecC name xs) = RecC
  name
  [ (unmangle v, b, t')
  | (v, b, t) <- xs
  , let
    t' = case t of
      ConT n | Just n' <- lookup n otherBarbieNames ->
        ConT n' `AppT` VarT switchName `AppT` VarT wrapperName
      _ -> ConT ''Wear `AppT` VarT switchName `AppT` VarT wrapperName `AppT` t
  ]
transformCon otherBarbieNames var w (ForallC tvbs cxt con) =
  ForallC tvbs cxt $ transformCon otherBarbieNames var w con
transformCon _ _ _ con = error $ "transformCon: unsupported " ++ show con

-- | Unmangle record field names
--
-- When 'DuplicateRecordFields' is turned on, record field names are mangled.
-- (see https://gitlab.haskell.org/ghc/ghc/-/wikis/records/overloaded-record-fields/duplicate-record-fields#mangling-selector-names)
-- We undo that because these mangled field names don't round-trip through TH splices.
unmangle :: Name -> Name
unmangle (Name occ flavour) = Name occ' flavour
  where
    occ' = case wordsBy (== ':') (occString occ) of
        ["$sel", fd, _qual] -> mkOccName fd
        _ -> occ
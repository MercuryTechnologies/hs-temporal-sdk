{-# LANGUAGE CPP #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE RecordWildCards #-}
module Data.EvalRecord.TH 
  ( mkEvalRecord
  , mkEvalRecordWith
  , DeclareRecordConfig(..)
  , passthrough
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
import Language.Haskell.TH.Syntax (Name(..), mkOccName, occString)
import Control.Monad (void)
import Data.String
import Data.Foldable (foldl')
import Data.List (partition, nub)
import qualified Data.List.NonEmpty as NE
import qualified Data.EvalRecord as Rec
import GHC.Generics (Generic)
import Data.List.Split
import Data.Maybe
import Fcf

data DeclareRecordConfig = DeclareRecordConfig
  { friends :: [Name] -- ^ Members with these types won't be wrapped with 'f @@'
  , unwrappedName :: String -> Maybe String
  -- ^ generate a type synonym for the 'Pure' version of the type?
  , baseName :: String -> String
  -- ^ modify the name of the datatype
  , wrapperName :: Q Name
  -- ^ the name of the type parameter of the wrapper for each field
  }

-- | Defines a synonym for the bare type with the same name.
-- The basic definition is suffixed by F, and the unwrapped basic type has no suffix.
passthrough :: DeclareRecordConfig
passthrough = DeclareRecordConfig
  { friends = []
  , unwrappedName = Just
  , baseName = (++"F")
  , wrapperName = newName "f"
  }

-- | Doesn't define a synonym for the bare type.
classic :: DeclareRecordConfig
classic = DeclareRecordConfig
  { friends = []
  , unwrappedName = const Nothing
  , baseName = id
  , wrapperName = newName "f"
  }

-- | Defines a synonym for the bare type with the same name.
-- The strippable definition is suffixed by B, and the covered type is suffixed by H.
mkEvalRecord :: DecsQ -> DecsQ
mkEvalRecord = mkEvalRecordWith classic

-- | Generate a higher-kinded data declaration using a custom config.
--
-- Note that sum types are not currently supported.
mkEvalRecordWith :: DeclareRecordConfig -> DecsQ -> DecsQ
mkEvalRecordWith DeclareRecordConfig{..} decsQ = do
  decs <- decsQ
  let otherBarbieNames = [ (k, mkName $ baseName $ nameBase k) | k <- dataDecNames decs ]
          ++ map (\x -> (x, x)) friends
  decs' <- traverse (go otherBarbieNames) decs
  return $ concat decs'
  where
    go otherBarbieNames (DataD _ dataName0 tvbs _ [con@(RecC nDataCon mangledfields)] classes) = do
      let dataName = mkName $ baseName $ nameBase dataName0
      let fields = [(unmangle name, c, t) | (name, c, t) <- mangledfields]
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
      let transformed = transformCon otherBarbieNames nWrap con
      let reconE = foldl' appE (conE nDataCon)
          -- field names for FieldNamesB
          strLit str = [| fromString $(litE $ StringL str)|]
          fieldNamesE = reconE $ mapMembers
            (\(name,_,_) -> conE 'Rec.Metadata `appE` strLit (nameBase name))
            (\_ -> [|Rec.typeProxies|])
            fields
          nestedFieldNamesE = reconE $ mapMembers
            (\(name,_,_) -> [|pure $(strLit $ nameBase name)|])
            (\(name,_,_) -> [|(\_ -> NE.cons $(strLit $ nameBase name)) `Rec.map` Rec.nestedFieldNames|])
            fields
          accessorsE = reconE $ mapMembers
            (\name -> [|Rec.LensRec
                $(varE name)
                (\ $(varP nX) $(varP nData) -> $(recUpdE (varE nData) [pure (name, VarE nX)])) |]
            )
            (\name -> [|
                          (\_ -> nestLens
                             (\ $(varP nData) -> (\ $(varP nX) -> $(recUpdE (varE nData) [pure (name, VarE nX)])
                                                 , $(varE name) $(varE nData)
                                                 )
                             )
                          )
                          `Rec.map`
                          getAccessors
                      |]
            )
            [name | (name,_,_) <- fields]

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
      bareType <- [t| $(vanillaType) Pure |]
      coveredType <- [t| $(vanillaType) |]

      -- max arity = 62
      let typeChunks = chunksOf 62
            [ case mask of
              Just t' -> [t| Rec.AllRec $(varT nConstr) ($(conT t'))|]
              Nothing -> varT nConstr `appT` pure t
            | ((_, _, t), mask) <- zip fields otherBarbieMask
            ]
          mkConstraints ps = foldl appT (tupleT $ length ps) ps
          allConstr = case typeChunks of
            [ps] -> mkConstraints ps
            pss -> mkConstraints $ map mkConstraints pss
          fieldNamesAndTypesAsTupleList = foldr 
            (\(n, _, t) fs -> PromotedConsT `AppT` (PromotedTupleT 2 `AppT` LitT (StrTyLit $ nameBase n) `AppT` t) `AppT` fs)
            PromotedNilT 
            fields
            --strTyLit 

      -- let datC = pure coveredType
      decs <- [d|
        instance Rec.WitnessFieldTypes $(pure coveredType) where
          type FieldMetadata $(pure coveredType) = $(pure fieldNamesAndTypesAsTupleList)
          typeProxies = $(fieldNamesE)
          getAccessors = $(accessorsE)
          nestedFieldNames = $(nestedFieldNamesE)

        instance Rec.FunctorRec $(pure coveredType) where
          map f $(conP nDataCon $ map varP xs)
            = $(reconE $ mapMembers 
                  (\tup@(n, _, _) -> [|f ($(varE n) Rec.typeProxies) $(varE $ mkVarName "x" tup)|] )
                  (\tup -> appE [|Rec.map f|] (varE $ mkVarName "x" tup))
                  fields
               )

        instance Rec.DistributiveRec $(pure coveredType) where
          distribute fb = $(reconE $
              -- TODO: NoFieldSelectors
              mapMembers
                (\fd -> [| ($fd <$> fb) |])
                (\fd -> [| distribute ($fd <$> fb) |])
                [varE fd | (fd, _, _) <- fields]
            )

        instance Rec.TraversableRec $(pure coveredType) where
          traverse f $(conP nDataCon $ map varP xs) = $(fst $ foldl'
              (\(l, op) r -> (infixE (Just l) (varE op) (Just r), '(<*>)))
              (conE nDataCon, '(<$>))
              (mapMembers 
                (\tup@(n, _, _) -> [|f ($(varE n) Rec.typeProxies) $(varE $ mkVarName "x" tup)|]) 
                (\tup -> [|Rec.traverse f $(varE $ mkVarName "x" tup)|]) 
                fields
              )
            )
          {-# INLINE Rec.traverse #-}
          traverse_ f $(conP nDataCon $ map varP xs) = $(
              case 
                mapMembers 
                  (\tup@(n, _, _) -> [|f ($(varE n) Rec.typeProxies) $(varE $ mkVarName "x" tup)|]) 
                  (\tup -> [|Rec.traverse_ f $(varE $ mkVarName "x" tup)|]) 
                  fields
                of
                  [] -> varE 'pure `appE` conE '()
                  exprs -> varE 'void `appE` 
                    foldr1
                      (\l r -> (infixE (Just l) (varE '(*>)) (Just r)))
                      exprs
              
            )
          {-# INLINE Rec.traverse_ #-}

        instance Rec.ConstraintsRec $(pure coveredType) where
          type AllRec $(varT nConstr) $(pure coveredType) = $(allConstr)
          addDicts $(conP nDataCon $ map varP xs)
            = $(reconE $ mapMembers
                (\x -> [|(Rec.Dict, $x)|])
                (\x -> [|addDicts $x|])
                (varE <$> xs)
              )
        instance Rec.ApplicativeRec $(pure coveredType) where
          pure $(varP nX) = $(reconE $ mapMembers
                              (\(n, _, _) -> [|($(varE nX) ($(varE n) Rec.typeProxies))|])
                              (const [|Rec.pure $(varE nX)|])
                              fields
                            )
          prod $(conP nDataCon $ map varP xs) $(conP nDataCon $ map varP ys) = $(foldl'
            (\r (isOtherBarbie, x, y) ->
              if isJust isOtherBarbie
                then [|$r (Rec.prod $(varE x) $(varE y))|]
                else [|$r ($(varE x), $(varE y))|])
            (conE nDataCon) (zip3 otherBarbieMask xs ys))
        |]
      -- strip deriving Generic
      let classes' = map (\(DerivClause strat cs) -> fmap (DerivClause strat) $ partition (== ConT ''Generic) cs) classes


      specifyStockStrategy <- isExtEnabled DerivingStrategies
      -- Redefine instances of the bare type with the original strategy
      bareDrvs <- traverse (\(strat, cls) -> do
        param <- newName "f"
        standaloneDerivWithStrategyD 
          strat 
          (sequence 
            [ conT ''Rec.AllRecF `appT` cls `appT` varT param `appT` pure coveredType
            ]) 
          [t|$(cls) ($(pure coveredType) $(varT param)) |])
        [ (strat, pure t) | (_, DerivClause strat preds) <- classes', t <- preds ]

      return $ DataD [] dataName
#if MIN_VERSION_template_haskell(2,17,0)
        (tvbs ++ [PlainTV nWrap ()])
#else
        (tvbs ++ [PlainTV nWrap])
#endif
        Nothing
        [transformed]
        [DerivClause (if specifyStockStrategy then Just StockStrategy else Nothing) $ concatMap fst classes']
        : decs ++ bareDrvs
        ++ [ TySynD (mkName name) tvbs bareType | name <- maybeToList $ unwrappedName $ nameBase dataName0]
    go _ d = pure [d]

dataDecNames :: [Dec] -> [Name]
dataDecNames = nub . mapMaybe decName
 where
  decName :: Dec -> Maybe Name
  decName = \case
    DataD    _ n _ _ _ _ -> Just n
    _                    -> Nothing

mkVarName :: String -> VarBangType -> Name
mkVarName p (v, _, _) = mkName (p ++ nameBase v)

varNames :: String -> [VarBangType] -> [Name]
varNames p vbt = [mkVarName p tup | tup <- vbt]

transformCon :: [(Name, Name)] -- ^ Names of other barbies
  -> Name -- ^ wrapper variable
  -> Con -- ^ original constructor
  -> Con
transformCon otherBarbieNames wrapperName (RecC name xs) = RecC
  name
  [ (unmangle v, b, t')
  | (v, b, t) <- xs
  , let
    t' = case t of
      ConT n | Just n' <- lookup n otherBarbieNames ->
        ConT n' `AppT` VarT wrapperName
      _ -> InfixT (VarT wrapperName) ''(@@) t
  ]
transformCon otherBarbieNames w (ForallC tvbs cxt con) =
  ForallC tvbs cxt $ transformCon otherBarbieNames w con
transformCon _ _ con = error $ "transformCon: unsupported " ++ show con

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

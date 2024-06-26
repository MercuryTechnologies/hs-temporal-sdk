{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

{- | Temporal.Replay supports replaying a workflow from its event history. Use for troubleshooting and backwards compatibility unit tests.

For example, if a workflow fails, in production, then its history can be downloaded through the UI or CLI and replayed in a debugger as many times as necessary.

Use 'newReplayWorker' to create unit tests that check if workflow changes are backwards compatible. It is important to maintain backwards compatibility to ensure that new deployments are not going to break open workflows.
-}
module Temporal.Replay (
  newReplayWorker,
  pushHistory,
  closeHistory,
  readHistoryFromJSONFile,
  feedWorkflowHistoryFromJSONFile,
  HistoryEvent,
  WorkflowId (..),
) where

import Control.Monad.IO.Class
import Data.Aeson
-- import Data.List.Split (wordsBy)

import qualified Data.ByteString.Lazy as BS
import Data.Char
import Data.List (intersperse)
import Data.ProtoLens
import Data.ProtoLens.Json
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import Data.Vector (Vector)
import Lens.Family2
import Proto.Temporal.Api.History.V1.Message
import Proto.Temporal.Api.History.V1.Message_Fields
import Temporal.Common (WorkflowId (..))
import Temporal.Core.Worker (HistoryPusher, closeHistory, newReplayWorker, pushHistory)


instance FromJSON History where
  parseJSON = do
    let opts =
          defaultFromJsonMessageOptions
            { fromJsonMessageEnumModifier = \_msg enumInfo str ->
                toScreamingSnake (fromHumps (T.unpack (enumName enumInfo) <> str))
            }
    withObject "History" $ \o -> parseJsonMessage opts o


-- | An opaque type that represents a parsed identifier.
newtype Identifier a = Identifier {unIdentifier :: [a]}
  deriving newtype (Monad, Functor, Applicative, Show, Eq)
  deriving stock (Foldable, Traversable)


-- wordCase :: String -> String
-- wordCase "" = ""
-- wordCase (x:xs) = toUpper x : map toLower xs

-- | Convert from "humped" casing (@camelCase@ or @PascalCase@)
fromHumps :: String -> Identifier String
fromHumps = Identifier . go
  where
    go "" = [""]
    go [x] = [[x]]
    go xxs@(x : _)
      | isUpper x =
          let lhs = takeWhile isUpper xxs
              rhs = dropWhile isUpper xxs
          in if null rhs
              then [lhs]
              else
                let curLen = length lhs - 1
                    cur = take curLen lhs
                    rec = go rhs
                    nxt = drop curLen lhs ++ concat (take 1 rec)
                    remaining = drop 1 rec
                    curL = if null cur then [] else [cur]
                    nxtL = if null nxt then [] else [nxt]
                in curL ++ nxtL ++ remaining
      | otherwise =
          let cur = takeWhile (not . isUpper) xxs
              remaining = dropWhile (not . isUpper) xxs
          in if null remaining
              then [cur]
              else cur : go remaining


-- fromWords :: String -> Identifier String
-- fromWords = Identifier . words

-- -- | Convert from @kebab-cased-identifiers@
-- fromKebab :: String -> Identifier String
-- fromKebab = Identifier . wordsBy (== '-')

-- -- | Convert from @snake_cased@ (either flavor)
-- fromSnake :: String -> Identifier String
-- fromSnake = Identifier . wordsBy (== '_')

-- -- | Convert from anything, including mixed casing.
-- fromAny :: String -> Identifier String
-- fromAny str = fromHumps str >>= fromKebab >>= fromSnake >>= fromWords

-- -- | To @PascalCase@
-- toPascal :: Identifier String -> String
-- toPascal = concat . map wordCase . unIdentifier

-- -- | To @camelCase@
-- toCamel :: Identifier String -> String
-- toCamel (Identifier []) = ""
-- toCamel (Identifier (x:xs)) = concat $ map toLower x:map wordCase xs

-- | To @snake_Case@
toSnake :: Identifier String -> String
toSnake = intercalate "_" . unIdentifier


-- | To @SCREAMING_SNAKE_CASE@
toScreamingSnake :: Identifier String -> String
toScreamingSnake = map toUpper . toSnake


-- -- | To @word Case@
-- toWords :: Identifier String -> String
-- toWords = unwords . unIdentifier

-- -- | Directly convert to @PascalCase@ through 'fromAny'
-- pascal :: String -> String
-- pascal = toPascal . fromAny

-- -- | Directly convert to @camelCase@ through 'fromAny'
-- camel :: String -> String
-- camel = toCamel . fromAny

-- -- | Directly convert to @snake_Case@ through 'fromAny'
-- snake :: String -> String
-- snake = toSnake . fromAny

readHistoryFromJSONFile :: MonadIO m => FilePath -> m (Either String (Vector HistoryEvent))
readHistoryFromJSONFile fp = liftIO $ do
  bs <- BS.readFile fp
  pure $ (\msg -> (msg :: History) ^. vec'events) <$> eitherDecode bs


feedWorkflowHistoryFromJSONFile :: MonadIO m => WorkflowId -> FilePath -> HistoryPusher -> m ()
feedWorkflowHistoryFromJSONFile (WorkflowId wf) fp hp = liftIO $ do
  res <- readHistoryFromJSONFile fp
  case res of
    Left err -> fail err
    Right evs -> mapM_ (pushHistory hp $ T.encodeUtf8 wf) evs

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.SearchAttributes where

import qualified Data.Aeson as A
import Data.Scientific (floatingOrInteger)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import Data.Vector (Vector)
import Data.Int
import Data.Word
import GHC.TypeLits

class ToSearchAttribute a where
  toSearchAttribute :: a -> SearchAttributeType

instance ToSearchAttribute Bool where
  toSearchAttribute = Bool

instance ToSearchAttribute UTCTime where
  toSearchAttribute = Datetime

instance ToSearchAttribute Double where
  toSearchAttribute = Double

instance ToSearchAttribute Float where
  toSearchAttribute = Double . realToFrac

instance ToSearchAttribute Int where
  toSearchAttribute = Int . fromIntegral

instance ToSearchAttribute Int64 where
  toSearchAttribute = Int

instance ToSearchAttribute Int32 where
  toSearchAttribute = Int . fromIntegral

instance ToSearchAttribute Int16 where
  toSearchAttribute = Int . fromIntegral

instance ToSearchAttribute Int8 where
  toSearchAttribute = Int . fromIntegral

instance (TypeError ('Text "Converting a Word to a search attribute can cause a signed value overflow")) => ToSearchAttribute Word where
  toSearchAttribute = error "Converting a Word to a search attribute can cause a signed value overflow"

instance (TypeError ('Text "Converting a Word64 to a search attribute can cause a signed value overflow")) => ToSearchAttribute Word64 where
  toSearchAttribute = error "Converting a Word64 to a search attribute can cause a signed value overflow"

instance ToSearchAttribute Word32 where
  toSearchAttribute = Int . fromIntegral

instance ToSearchAttribute Word16 where
  toSearchAttribute = Int . fromIntegral

instance ToSearchAttribute Word8 where
  toSearchAttribute = Int . fromIntegral

instance ToSearchAttribute Text where
  toSearchAttribute = KeywordOrText

-- | A search attribute is a key-value pair that can be used to filter workflows.
--
-- Search attributes are indexed by the Temporal server
-- 
-- See <https://docs.temporal.io/visibility#types> for more information about search attributes.
data SearchAttributeType 
  = Bool Bool
  | Datetime UTCTime
  | Double Double
  | Int Int64
  | KeywordOrText Text
  -- ^ Keyword and Text types are concepts taken from Elasticsearch. 
  -- Each word in a Text is considered a searchable keyword. 
  -- For a UUID, that can be problematic because Elasticsearch 
  -- indexes each portion of the UUID separately. To have the whole string 
  -- considered as a searchable keyword, use the Keyword type. 
  --
  -- For example, if the key ProductId has the value of 2dd29ab7-2dd8-4668-83e0-89cae261cfb1:
  -- 
  -- - As a Keyword it would be matched only by ProductId = "2dd29ab7-2dd8-4668-83e0-89cae261cfb1"
  -- - As a Text it would be matched by ProductId = 2dd8, which could cause unwanted matches.
  | KeywordList (Vector Text)
  deriving stock (Show, Eq)

instance A.ToJSON SearchAttributeType where
  toJSON (Bool b) = A.toJSON b
  toJSON (Datetime t) = A.toJSON t
  toJSON (Double d) = A.toJSON d
  toJSON (Int i) = A.toJSON i
  toJSON (KeywordOrText t) = A.toJSON t
  toJSON (KeywordList ts) = A.toJSON ts

instance A.FromJSON SearchAttributeType where
  parseJSON x = case x of
    A.Bool b -> pure $ Bool b
    A.String t -> pure $ KeywordOrText t
    A.Number n -> case floatingOrInteger n of
      Left d -> pure $ Double d
      Right i -> pure $ Int i
    A.Array arr -> KeywordList <$> mapM A.parseJSON arr
    _ -> fail "Invalid search attribute type"

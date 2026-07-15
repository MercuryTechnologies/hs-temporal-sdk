{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

-- | Payload types for the soak workload's activity. Kept in a separate module
-- (imported, not defined locally) so the 'register' splice in
-- "Soak.Workload.Defs" can reify them without a TH stage restriction.
--
-- 'Blob' is deliberately a nested record with a large item list so it
-- serializes (via the default JSON codec) to a big JSON blob / proto payload —
-- letting the soak harness probe whether the activity-worker leak scales with
-- payload size.
module Soak.Workload.Types
  ( Blob (..)
  , BlobItem (..)
  , mkBlob
  ) where

import Data.Aeson (FromJSON, ToJSON)
import Data.Text (Text)
import qualified Data.Text as T
import GHC.Generics (Generic)


data BlobItem = BlobItem
  { itemKey :: Text
  , itemValue :: Text
  , itemTags :: [Text]
  }
  deriving stock (Show, Eq, Generic)
  deriving anyclass (ToJSON, FromJSON)


data Blob = Blob
  { blobId :: Int
  , blobLabel :: Text
  , blobItems :: [BlobItem]
  }
  deriving stock (Show, Eq, Generic)
  deriving anyclass (ToJSON, FromJSON)


-- | Build a 'Blob' with @n@ items. Each item is ~100+ bytes of JSON, so
-- @mkBlob _ 256@ is a ~30 KB payload once serialized.
mkBlob :: Int -> Int -> Blob
mkBlob seed n =
  Blob
    { blobId = seed
    , blobLabel = "soak-blob"
    , blobItems =
        [ BlobItem
            { itemKey = T.pack ("item-key-" <> show i)
            , itemValue = T.pack ("item-value-payload-" <> show (seed + i) <> "-lorem-ipsum-dolor-sit-amet")
            , itemTags = [T.pack ("tag-" <> show t) | t <- [i .. i + 3]]
            }
        | i <- [1 .. n]
        ]
    }

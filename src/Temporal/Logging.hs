module Temporal.Logging where

import Data.Text (Text)
import Data.HashMap.Strict (HashMap)
import Data.Time.Clock


data Level = Debug | Info | Warn | Error | Fatal
  deriving stock (Eq, Ord, Show, Read, Enum, Bounded)

data LogItem = LogItem
  { message :: !Text
  , timestamp :: !UTCTime
  , level :: !Level
  , fields :: !(HashMap Text Text)
  }
    -- -- The module this message originated from
    -- pub target: String,
    -- -- Log message
    -- pub message: String,
    -- -- Time log was generated (not when it was exported to lang)
    -- pub timestamp: SystemTime,
    -- -- Message level
    -- pub level: Level,
    -- -- Arbitrary k/v pairs (span k/vs are collapsed with event k/vs here). We could change this
    -- -- to include them in `span_contexts` instead, but there's probably not much value for log
    -- -- forwarding.
    -- pub fields: HashMap<String, serde_json::Value>,
    -- /// A list of the outermost to the innermost span names
    -- pub span_contexts: Vec<String>,
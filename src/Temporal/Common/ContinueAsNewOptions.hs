module Temporal.Common.ContinueAsNewOptions where
import Data.Map.Strict (Map)
import Temporal.Payload
import Data.Text (Text)
import Temporal.SearchAttributes
import Temporal.Common
import Temporal.Duration

data ContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue :: Maybe TaskQueue
  , runTimeout :: Maybe Duration
  , taskTimeout :: Maybe Duration
  , retryPolicy :: Maybe RetryPolicy
  , memo :: Map Text RawPayload
  , searchAttributes :: Map Text SearchAttributeType
  , headers :: Map Text RawPayload
  }

defaultContinueAsNewOptions :: ContinueAsNewOptions
defaultContinueAsNewOptions = ContinueAsNewOptions
  { taskQueue = Nothing
  , runTimeout = Nothing
  , taskTimeout = Nothing
  , retryPolicy = Nothing
  , memo = mempty
  , searchAttributes = mempty
  , headers = mempty
  }

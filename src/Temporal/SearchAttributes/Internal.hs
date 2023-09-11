module Temporal.SearchAttributes.Internal where

import qualified Data.Map.Strict as Map
import Data.Text (Text)
import Temporal.SearchAttributes
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import Control.Monad.Except
import Temporal.Payload

searchAttributesToProto :: Map.Map Text SearchAttributeType -> IO (Map.Map Text Message.Payload)
searchAttributesToProto searchAttrs = traverse (fmap convertToProtoPayload . encode JSON) searchAttrs

searchAttributesFromProto :: Map.Map Text Message.Payload -> IO (Either String (Map.Map Text SearchAttributeType))
searchAttributesFromProto fs = runExceptT $ traverse (ExceptT . decode JSON . convertFromProtoPayload) $ fs
module Temporal.SearchAttributes.Internal where

import Control.Monad.Except
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import Temporal.Payload
import Temporal.SearchAttributes


searchAttributesToProto :: Map.Map Text SearchAttributeType -> IO (Map.Map Text Message.Payload)
searchAttributesToProto searchAttrs = traverse (fmap convertToProtoPayload . encode JSON) searchAttrs


searchAttributesFromProto :: Map.Map Text Message.Payload -> IO (Either String (Map.Map Text SearchAttributeType))
searchAttributesFromProto fs = runExceptT $ traverse (ExceptT . decode JSON . convertFromProtoPayload) $ fs

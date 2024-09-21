module Temporal.SearchAttributes.Internal where

import Control.Monad.Except
import Data.Coerce
import qualified Data.Map.Strict as Map
import Data.Text (Text)
import qualified Proto.Temporal.Api.Common.V1.Message as Message
import Temporal.Payload
import Temporal.SearchAttributes
import Unsafe.Coerce (unsafeCoerce)


-- This is only safe if Eq/Ord instances are the same results for a and b
unsafeCoerceMapKeys :: forall a b c. Coercible a b => Map.Map a c -> Map.Map b c
unsafeCoerceMapKeys = unsafeCoerce


rawKeys :: Map.Map SearchAttributeKey a -> Map.Map Text a
rawKeys = unsafeCoerceMapKeys


wrappedKeys :: Map.Map Text a -> Map.Map SearchAttributeKey a
wrappedKeys = unsafeCoerceMapKeys


searchAttributesToProto :: Map.Map SearchAttributeKey SearchAttributeType -> IO (Map.Map Text Message.Payload)
searchAttributesToProto = fmap rawKeys . traverse (fmap convertToProtoPayload . encode JSON)


searchAttributesFromProto :: Map.Map Text Message.Payload -> IO (Either String (Map.Map SearchAttributeKey SearchAttributeType))
searchAttributesFromProto = fmap (fmap wrappedKeys) . runExceptT . traverse (ExceptT . decode JSON . convertFromProtoPayload)

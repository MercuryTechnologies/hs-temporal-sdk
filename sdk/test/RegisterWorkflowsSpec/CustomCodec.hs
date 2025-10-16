{-# LANGUAGE DeriveLift #-}

module RegisterWorkflowsSpec.CustomCodec (CustomCodec (..)) where

import Language.Haskell.TH.Syntax (Lift)
import Temporal.Payload (Codec (..))


-- | A custom codec wrapper for testing
data CustomCodec inner = CustomCodec inner
  deriving stock (Eq, Show, Lift)


instance Codec inner a => Codec (CustomCodec inner) a where
  encoding (CustomCodec inner) = encoding inner
  messageType (CustomCodec inner) = messageType inner
  encode (CustomCodec inner) = encode inner
  decode (CustomCodec inner) = decode inner

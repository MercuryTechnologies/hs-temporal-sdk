module Temporal.Workflow.Update where

import Data.Kind
import Data.Text (Text)
import Temporal.Payload


{- | A 'KnownUpdate' is a handle that contains all the information needed to start a
Update either as a child workflow or as a top-level workflow via a 'Client'.
-}
data KnownUpdate (args :: [Type]) (result :: Type) = forall codec.
  ( FunctionSupportsCodec codec args result
  ) =>
  KnownUpdate
  { knownUpdateCodec :: codec
  , knownUpdateName :: Text
  }


class UpdateRef query where
  type UpdateArgs query :: [Type]
  type UpdateResult query :: Type
  updateRef :: query -> KnownUpdate (UpdateArgs query) (UpdateResult query)


instance UpdateRef (KnownUpdate args result) where
  type UpdateArgs (KnownUpdate args result) = args
  type UpdateResult (KnownUpdate args result) = result
  updateRef = id

{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Generic.Using where

import Data.Functor.Identity
import Temporal.Generic.GenericN
import Temporal.Generic.GUsing
import Data.Proxy

data Covered
data Bare

type family Using t f a where
  Using Bare f a = a
  Using Covered f a = f a

-- | Class that supports promoting a record of functions to a record of functions wrapped in a functor
class UsingB b where
  unwrap :: b Covered Identity -> b Bare Identity
  default unwrap :: CanDeriveUsingB b => b Covered Identity -> b Bare Identity
  unwrap = gunwrapDefault

  wrap :: b Bare Identity -> b Covered Identity
  default wrap :: CanDeriveUsingB b => b Bare Identity -> b Covered Identity
  wrap = gwrapDefault

gunwrapDefault :: CanDeriveUsingB b => b Covered Identity -> b Bare Identity
gunwrapDefault
  = toP (Proxy @0) . gunwrap (Proxy @0) . fromP (Proxy @0)
{-# INLINE gunwrapDefault #-}

-- | Default implementation of 'bstrip' based on 'Generic'.
gwrapDefault :: CanDeriveUsingB b => b Bare Identity -> b Covered Identity
gwrapDefault
  = toP (Proxy @0) . gwrap (Proxy @0) . fromP (Proxy @0)
{-# INLINE gwrapDefault #-}

-- unwrapFrom :: UsingB b => (forall a. f a -> a) -> b f -> b Id
-- unwrapFrom = undefined

-- wrapWith :: UsingB b => (forall a. a -> f a) -> b Id -> b (Using f)
-- wrapWith = undefined

-- | All types that admit a generic 'FunctorB' instance, and have all
--   their occurrences of @f@ under an '@@ Using _' admit a generic 'UsingB'
--   instance.
type CanDeriveUsingB b
  = ( GenericP 0 (b Bare Identity)
    , GenericP 0 (b Covered Identity)
    , GUsing 0 (RepP 0 (b Covered Identity)) (RepP 0 (b Bare Identity))
    )


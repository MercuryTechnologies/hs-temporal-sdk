{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Generic.TyFun where
import Data.Kind

data TyFun a b
type a ~> b = TyFun a b -> Type
infixr 0 ~>

type family Apply (f :: a ~> b) (x :: a) :: b
type f @@ a = Apply f a
infixl 9 @@

data Id :: a ~> a
type instance Apply Id x = x

data Compose :: (b ~> c) -> (a ~> b) -> (a ~> c)
type instance Apply (Compose f g) x = f @@ (g @@ x)

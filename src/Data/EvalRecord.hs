{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE UndecidableSuperClasses #-}
-----------------------------------------------------------------------------
-- |
-- Module:  Data.EvalRecord
--
-- This module is intended to be imported qualified, to avoid name clashes with
-- Prelude and base functions:
--
-- @
-- import qualified Data.EvalRecord as Rec
-- @
--
-- A common Haskell idiom is to parameterise a datatype by a functor or GADT
-- (or any "indexed type" @k -> 'Data.Kind.Type'@), a pattern
-- sometimes called <https://reasonablypolymorphic.com/blog/higher-kinded-data/ HKD>).
-- This parameter acts as a wrapper of the base type, turning it into a record
-- that serves a different purpose. The canonical example would be:
--
-- @
-- data Person f
--   = Person
--       { name :: f 'String'
--       , age  :: f 'Int'
--       }
-- @
--
-- However, this library uses a different approach, where the parameter is
-- a type-level function @Type -> Exp Type@, from the @first-class-families@ package.
-- The type of each field is then given by applying 'Eval (f x)' (also known as '@@') to the field:
--
-- @
-- data Person (f :: Type -> 'Exp' Type)
--   = Person
--       { name :: f '@@' 'String'
--       , age  :: f '@@' 'Int'
--       }
-- @
--
-- Let's say that we are writing an application where @Person@ data
-- will be read from a web form, validated, and stored in a database. Some
-- possibles outfits that we could use along the way are:
--
-- @
-- -- for the raw input from the web-form,
-- webInput :: Person ('ConstFn' 'String')
-- webInput = Person "John" "30b"
--
-- -- for the result of parsing and validating,
-- validated :: Person ('Pure1' ('Either' 'String'))
-- validated = Person (Right "John") (Left "Not a number")
--
-- -- Person 'Pure' for the actual data,
-- domainModel :: Person 'Pure'
-- domainModel = Person "John" 30
--
-- dbModel :: Person ('Pure1' DbColumn) -- To describe how to read / write a @Person@ to the db
-- dbModel = Person
--   { name = DbColumn "name" (Right . fromString) toDbString
--   , age  = DbColumn "age"  (readEither . fromString) show
--   }
--
-- data DbColumn a
--   = DbColumn
--       { colName :: 'String'
--       , fromDb  :: DbDataParser a
--       , toDb    :: a -> DbData
--       }
-- @
--
-- In such application it is likely that one will have lots of types like
-- @Person@ so we will like to handle these transformations uniformly,
-- without boilerplate or repetitions.  This package provides classes to
-- manipulate these types, using notions that are familiar to haskellers like
-- 'Functor', 'Applicative' or 'Traversable'. For example, instead of writing
-- an ad-hoc function that checks that all fields have a correct value, like
--
-- @
-- checkPerson :: Person ('Either' 'String') -> 'Either' ['String'] (Person 'Pure')
-- @
--
-- we can write only one such function:
--
-- @
-- check :: 'TraversableRec' rec => rec ('Either' 'String') -> 'Either' ['String'] (rec 'Pure')
-- check be
--   = case 'traverse' ('either' ('const' 'Nothing') 'Just') be of
--       'Just' bi -> 'Right' bi
--       'Nothing' -> 'Left' ('foldMap' ('either' (:[]) ('const' [])) be)
-- @
--
-- Moreover, these classes come with template-haskell functions to derive
-- the instances automatically, so that one can write:
--
-- @
-- import Data.EvalRecord
-- import Data.EvalRecord.TH
-- 
-- mkEvalRecord [d|
--   data Bump = Bump
--     { bump :: Maybe Int
--     , bomp :: Bool
--     , bamp :: String
--     } deriving (Read, Show, Eq, Ord)
--   |]
-- @

-----------------------------------------------------------------------------
module Data.EvalRecord 
  ( -- * Type Witnesses
    WitnessFieldTypes(..)
  , Metadata(..)
    -- ** Lenses
  , LensRec(..)
  , getLens
  , nestLens
    -- * Functor
  , FunctorRec(..)
    -- * Traversable
  , TraversableRec(..)
    -- ** Utility functions
  , Data.EvalRecord.for
  , Data.EvalRecord.for_
  , Data.EvalRecord.foldMap
  , Data.EvalRecord.sequence
  , Data.EvalRecord.sequence'
    -- * Distributive
  , DistributiveRec(..)
  , Data.EvalRecord.distribute'
  , Data.EvalRecord.cotraverse
  , Data.EvalRecord.decompose
  , Data.EvalRecord.recompose
    -- * Applicative
  , ApplicativeRec(..)
  , Tuple2
    -- ** Utility functions
  , Data.EvalRecord.zip
  , Data.EvalRecord.unzip
  , Data.EvalRecord.zipWith
  , Data.EvalRecord.zipWith3
  , Data.EvalRecord.zipWith4
    -- * Constraints
  , ConstraintsRec(..)
  , AllRecF
  , ClassF
  , ClassFG
  , type (&)
  , Dict(..)
    -- ** Utility functions
  , dicts
  , requiringDict
  , mapC
  , foldMapC
  , traverseC
  , forC
  , zipWithC
  , zipWith3C
  , zipWith4C
  , pureC
  , Data.EvalRecord.mempty
    -- * Partial record mapping
  , MapMatches
  , ValueOnMatch
  , ApplyOnMatch
  , mapMatching
  , applyPred
    -- * Reexports
  , module Fcf
  ) where
import qualified Data.List.NonEmpty as NE
import Data.Kind
import Data.Proxy
import Data.Typeable
import Prelude hiding
  ( zipWith
  , zipWith3
  , map
  , pure
  )
import qualified Prelude 
import Fcf
import Unsafe.Coerce


-- ---------------------------------------------------------------------
-- We roll our own State/efficient-Writer monad, not to add dependencies
-- ---------------------------------------------------------------------

newtype St s a
  = St (s -> (a, s))

runSt :: s -> St s a -> (a, s)
runSt s (St f)
  = f s

instance Functor (St s) where
  fmap f (St g)
    = St $ (\(a, s') -> (f a, s')) . g
  {-# INLINE fmap #-}

instance Applicative (St s) where
  pure
    = St . (,)
  {-# INLINE pure #-}

  St l <*> St r
    = St $ \s ->
        let (f, s')  = l s
            (x, s'') = r s'
        in (f x, s'')
  {-# INLINE (<*>) #-}

instance Monad (St s) where
  return = Prelude.pure
  {-# INLINE return #-}

  St action >>= f
    = St $ \s ->
        let
          (a, s') = action s
          St go  = f a
        in
          go s'
  {-# INLINE (>>=) #-}

type Wr = St

execWr :: Monoid w => Wr w a -> w
execWr
  = snd . runSt Prelude.mempty

tell :: Monoid w => w -> Wr w ()
tell w
  = St (\s -> ((), seq s s `mappend` w))

-- | A first-class-families version of 'Data.Functor.Product.Product'.
--
-- When used with `Eval`, it resolves in a tuple of the applied type-level functions.
data Tuple2 :: (Type -> Exp Type) -> (Type -> Exp Type) -> Type -> Exp Type 

type instance Eval (Tuple2 f g x) = (f @@ x, g @@ x)

data LensRec rec a = LensRec
  { view :: forall f. rec f -> f @@ a
  , set :: forall f. f @@ a -> rec f -> rec f
  }

nestLens :: (forall h . a h -> (b h -> a h, b h)) -> LensRec b c -> LensRec a c
nestLens l (LensRec lv ls) =
  LensRec (lv . snd . l) (\n h -> let (s, x) = l h in s (ls n x))
{-# INLINE nestLens #-}

-- | Obtain a van-laarhoven lens (compatible with the lens library) from 'LensRec'
getLens :: Functor f => LensRec rec a -> (h @@ a -> f (h @@ a)) -> rec h -> f (rec h)
getLens (LensRec v s) f b = (\x -> s x b) <$> f (v b)
{-# INLINE getLens #-}

-- | A type witness for a field of type @a@.
--
-- For convenience, it also carries `Typeable` evidence and the name of the field.
data Metadata a where
  Metadata :: Typeable a =>
    { name :: String
    } -> Metadata a

-- | Functions that try to convert from f @@ a to some other type don't work without a little
-- help due to injectivity. This class provides that help by providing a function that provides
-- a witness of the type of a for each field of the record.
class WitnessFieldTypes (rec :: (Type -> Exp Type) -> Type) where
  typeName :: Proxy rec -> String
  default typeName :: Typeable rec => Proxy rec -> String
  typeName p = concat [tyConModule tc, ".", tyConName tc]
    where
      tc = typeRepTyCon $ typeRep p
  typeProxies :: rec (Pure1 Metadata)
  getAccessors :: rec (Pure1 (LensRec rec))
  nestedFieldNames :: rec (ConstFn (NE.NonEmpty String))

-- | Record-types that can be mapped over. Instances of 'FunctorRec' should
--   satisfy the following laws:
--
-- @
-- 'map' 'id' = 'id'
-- 'map' f . 'map' g = 'map' (f . g)
-- @
class FunctorRec (rec :: (Type -> Exp Type) -> Type) where
  map :: (forall a. Metadata a -> f @@ a -> g @@ a) -> rec f -> rec g

-- | Record-types that can be traversed from left to right. Instances should
--   satisfy the following laws:
--
-- @
--  t . 'traverse' f   = 'traverse' (t . f)  -- naturality
-- 'traverse' 'Data.Functor.Identity' = 'Data.Functor.Identity'           -- identity
-- 'traverse' ('fmap' g . f) = 'fmap' ('traverse' g) . 'traverse' f -- composition
-- @
class FunctorRec rec => TraversableRec (rec :: (Type -> Exp Type) -> Type) where
  traverse :: Applicative e => (forall a. Metadata a -> f @@ a -> e (g @@ a)) -> rec f -> e (rec g)
  -- | Map each element to an action, evaluate these actions from left to right,
  --   and ignore the results.
  traverse_ :: Applicative e => (forall a. Metadata a -> f @@ a -> e c) -> rec f -> e ()

-- | A 'FunctorRec' with application, providing operations to:
--
--     * embed an "empty" value ('pure')
--
--     * align and combine values ('prod')
--
--  It should satisfy the following laws:
--
--  [Naturality of 'prod']
--
-- @
-- 'map' (\(a, b) -> (f a, g b)) (u `'prod'` v) = 'map' f u `'prod'` 'map' g v
-- @
--
--
--  [Left and right identity]
--
-- @
-- 'map' (\(_, b) -> b) ('pure' e `'prod'` v) = v
-- 'map' (\(a, _) -> a) (u `'prod'` 'pure' e) = u
-- @
--
-- [Associativity]
--
-- @
-- 'map' (\(a, (b, c)) -> ((a, b), c) (u `'prod'` (v `'prod'` w)) = (u `'prod'` v) `'prod'` w
-- @
--
--  It is to 'FunctorRec' in the same way as 'Applicative'
--  relates to 'Functor'. For a presentation of 'Applicative' as
--  a monoidal functor, see Section 7 of
--  <http://www.soi.city.ac.uk/~ross/papers/Applicative.html Applicative Programming with Effects>.
class FunctorRec rec => ApplicativeRec (rec :: (Type -> Exp Type) -> Type) where
  pure :: (forall a. Metadata a -> f @@ a) -> rec f
  prod :: rec f -> rec g -> rec (Tuple2 f g)

-- | 'traverse' with the arguments flipped. Useful when the traversing function is a large lambda:
--
-- @
-- for someRecord $ \fa -> ...
-- @
--
-- @since 0.0.1.0 
for 
  :: (TraversableRec rec, Applicative e) 
  => rec f
  -> (forall a. Metadata a -> f @@ a -> e (g @@ a))
  -> e (rec g)
for b f = Data.EvalRecord.traverse f b

for_
  :: (TraversableRec rec, Applicative e)
  => rec f
  -> (forall a. Metadata a -> f @@ a -> e c)
  -> e ()
for_ b f = Data.EvalRecord.traverse_ f b

-- | Evaluate each action in the structure from left to right,
--   and collect the results.
sequence :: (Applicative e, TraversableRec rec) => rec (Pure1 e <=< f) -> e (rec f)
sequence = Data.EvalRecord.traverse (\_ x -> x)

-- | A version of 'sequence' with @f@ specialized to 'Pure'.
sequence' :: (Applicative e, TraversableRec rec) => rec (Pure1 e) -> e (rec Pure)
sequence' = Data.EvalRecord.traverse (\_ x -> x)

-- | Map each element to a monoid, and combine the results.
foldMap :: (TraversableRec rec, Monoid m) => (forall a. Metadata a -> f @@ a -> m) -> rec f -> m
foldMap f = execWr . Data.EvalRecord.traverse_ (\p x -> tell (f p x))

-- | An alias of 'prod', since this is like a 'zip'.
zip :: ApplicativeRec rec => rec f -> rec g -> rec (Tuple2 f g)
zip = prod

-- | An equivalent of 'unzip'.
unzip :: ApplicativeRec rec => rec (Tuple2 f g) -> (rec f, rec g)
unzip f = (Data.EvalRecord.map (\_ (l, _) -> l) f, Data.EvalRecord.map (\_ (_, r) -> r) f)

-- | An equivalent of 'Data.List.zipWith'.
zipWith 
  :: ApplicativeRec rec 
  => (forall a. Metadata a -> f @@ a -> g @@ a -> h @@ a) 
  -> rec f 
  -> rec g 
  -> rec h
zipWith f bf bg = 
  Data.EvalRecord.map 
    (\p (fa, ga) -> f p fa ga) 
    (bf `prod` bg)

-- | An equivalent of 'Data.List.zipWith3'.
zipWith3
  :: ApplicativeRec rec
  => (forall a. Metadata a -> f @@ a -> g @@ a -> h @@ a -> i @@ a)
  -> rec f
  -> rec g
  -> rec h
  -> rec i
zipWith3 f bf bg bh = 
  Data.EvalRecord.map 
    (\p ((fa, ga), ha) -> f p fa ga ha) 
    (bf `prod` bg `prod` bh)

-- | An equivalent of 'Data.List.zipWith4'.
zipWith4
  :: ApplicativeRec rec
  => (forall a. Metadata a -> f @@ a -> g @@ a -> h @@ a -> i @@ a -> j @@ a)
  -> rec f
  -> rec g
  -> rec h
  -> rec i
  -> rec j
zipWith4 f bf bg bh bi =
  Data.EvalRecord.map
    (\p (((fa, ga), ha), ia) -> f p fa ga ha ia)
    (bf `prod` bg `prod` bh `prod` bi)

-- | @'Dict' c a@ is evidence that there exists an instance of @c a@.
--
--   It is essentially equivalent to @Dict (c a)@ from the
--   <http://hackage.haskell.org/package/constraints constraints> package,
--   but because of its kind, it allows us to define things like @'Dict' 'Show'@.
data Dict c a where
  Dict :: c a => Dict c a

instance Eq (Dict c a) where
  _ == _ = True

instance Show (Dict c a) where
  showsPrec _ Dict = showString "Dict"

-- instance Show1 (Dict c)  where
--   liftShowsPrec _ _ = showsPrec

-- | Turn a constrained-function into an unconstrained one
--   that uses the packed instance dictionary instead.
requiringDict :: (c a => r) -> (Dict c a -> r)
requiringDict r = \Dict -> r

-- | Instances of this class provide means to talk about constraints,
--   both at compile-time, using 'AllRec', and at run-time, in the form
--   of 'Dict', via 'addDicts'.
--
--   A manual definition would look like this:
--
-- @
-- data T f = A (f 'Int') (f 'String') | B (f 'Bool') (f 'Int')
--
-- instance 'ConstraintsB' T where
--   type 'AllRec' c T = (c 'Int', c 'String', c 'Bool')
--
--   'addDicts' t = case t of
--     A x y -> A ('Dict', x) ('Dict', y)
--     B z w -> B ('Dict', z) ('Dict', w)
-- @
--
-- Now, when we given a @T f@, if we need to use the 'Show' instance of
-- their fields, we can use:
--
-- @
-- addDicts' :: AllRec Show b => b f -> b ('Dict' 'Show' `'Tuple2'` f)
-- @
class FunctorRec rec => ConstraintsRec (rec :: (Type -> Exp Type) -> Type) where
  type AllRec (c :: k -> Constraint) rec :: Constraint

  addDicts
    :: forall c f
    .  AllRec c rec
    => rec f
    -> rec (Pure1 (Dict c) `Tuple2` f)

class (c a, d a) => (c & d) a where
instance (c a, d a) => (c & d) a where

-- | Like 'map' but a constraint is allowed to be required on
--   each element of @rec@
--
-- E.g. If all fields of @rec@ are 'Show'able then you
-- could store each shown value in it's slot using 'ConstFn String':
--
-- > showFields :: (AllRec Show rec, ConstraintsRec rec) => b Pure -> b (ConstFn String)
-- > showFields = mapC @Show showField
-- >   where
-- >     showField :: forall a. Show a => Metadata a -> a -> String
-- >     showField _ = show
--
-- Notice that one can use the '(&)' class as a way to require several
-- constraints to hold simultaneously:
--
-- > map @(Show & Eq & Enum) r
mapC 
  :: forall c b f g
  .  (AllRec c b, ConstraintsRec b)
  => (forall a. c a => Metadata a -> f @@ a -> g @@ a)
  -> b f
  -> b g
mapC f bf = Data.EvalRecord.map go (addDicts bf)
  where
    go :: forall a. Metadata a -> (Pure1 (Dict c) `Tuple2` f) @@ a -> g @@ a
    go p (d, fa) = requiringDict (f p fa) d

-- | Like 'traverse' but with a constraint on the elements of @b@.
traverseC
  :: forall c b f g e
  .  (TraversableRec b, ConstraintsRec b, AllRec c b, Applicative e)
  => (forall a. c a => Metadata a -> f @@ a -> e (g @@ a))
  -> b f
  -> e (b g)
traverseC f bf = 
  Data.EvalRecord.traverse (\p (Dict :: Dict c a, x) -> f p x) (addDicts bf)

-- | 'traverseC' with the arguments flipped. Useful when the traversing function is a large lambda:
--
-- @
-- forC someRec $ \fa -> ...
-- @
--
-- @since 0.0.1.0
forC
  :: forall c b f g e
  .  (TraversableRec b, ConstraintsRec b, AllRec c b, Applicative e)
  => b f
  -> (forall a. c a => Metadata a -> f @@ a -> e (g @@ a))
  -> e (b g)
forC b f = traverseC @c f b

foldMapC
  :: forall c b m f
  .  (TraversableRec b, ConstraintsRec b, AllRec c b, Monoid m)
  => (forall a. c a => Metadata a -> f @@ a -> m)
  -> b f
  -> m
foldMapC f = execWr . traverseC @c @b @f @(ConstFn ()) @(St m) (\p x -> tell $ f p x)

-- | Like 'zipWith' but with a constraint on the elements of @b@.
zipWithC
  :: forall c b f g h
  .  (AllRec c b, ConstraintsRec b, ApplicativeRec b)
  => (forall a. c a => Metadata a -> f @@ a -> g @@ a -> h @@ a)
  -> b f
  -> b g
  -> b h
zipWithC f bf bg =
  mapC @c go (bf `prod` bg)
  where
    go :: forall a. c a => Metadata a -> (Tuple2 f g) @@ a -> h @@ a
    go p (fa, ga) = f p fa ga

-- | Like 'zipWith3' but with a constraint on the elements of @b@.
zipWith3C
  :: forall c b f g h i
  .  (AllRec c b, ConstraintsRec b, ApplicativeRec b)
  => (forall a. c a => Metadata a -> f @@ a -> g @@ a -> h @@ a -> i @@ a)
  -> b f
  -> b g
  -> b h
  -> b i
zipWith3C f bf bg bh =
  mapC @c go (bf `prod` bg `prod` bh)
  where
    go :: forall a. c a => Metadata a -> (Tuple2 f g `Tuple2` h) @@ a -> i @@ a
    go p ((fa, ga), ha) = f p fa ga ha

-- | Like 'zipWith4' but with a constraint on the elements of @b@.
zipWith4C
  :: forall c b f g h i j
  .  (AllRec c b, ConstraintsRec b, ApplicativeRec b)
  => (forall a. c a => Metadata a -> f @@ a -> g @@ a -> h @@ a -> i @@ a -> j @@ a)
  -> b f
  -> b g
  -> b h
  -> b i
  -> b j
zipWith4C f bf bg bh bi =
  mapC @c go (bf `prod` bg `prod` bh `prod` bi)
  where
    go :: forall a. c a => Metadata a -> (Tuple2 f g `Tuple2` h `Tuple2` i) @@ a -> j @@ a
    go p (((fa, ga), ha), ia) = f p fa ga ha ia

-- | 'ClassF' has one universal instance that makes @'ClassF' c f a@
--   equivalent to @c (f a)@. However, we have
--
-- @
-- 'ClassF c f :: k -> 'Data.Kind.Constraint'
-- @
--
-- This is useful since it allows to define constraint-constructors like
-- @'ClassF' 'Monoid' 'Pure1 Maybe'@
class c (f @@ a) => ClassF c f a where
instance c (f @@ a) => ClassF c f a

-- | Like 'ClassF' but for binary relations.
class c (f @@ a) (g @@ a) => ClassFG c f g a where
instance c (f @@ a) (g @@ a) => ClassFG c f g a

-- | Similar to 'AllRec' but will put the functor argument @f@
--   between the constraint @c@ and the type @a@. For example:
--
--   @
--   'AllRec'  'Show'   Person ~ ('Show'    'String',  'Show'    'Int')
--   'AllRecF' 'Show' f Person ~ ('Show' (f @@ 'String'), 'Show' (f @@ 'Int'))
--   @
type AllRecF c f b = AllRec (ClassF c f) b

-- | Similar to 'addDicts' but can produce the instance dictionaries
--   "out of the blue".
dicts
  :: forall c b
  .  (AllRec c b, ApplicativeRec b, ConstraintsRec b)
  => b (Pure1 (Dict c))
dicts = dicts'
  where
    dicts' :: b (Pure1 (Dict c))
    dicts' = Data.EvalRecord.map (\_ (c, _) -> c) addedDicts
    addedDicts :: b (Tuple2 (Pure1 (Dict c)) (Pure1 Proxy))
    addedDicts = 
      addDicts @b @c @(Pure1 Proxy) $ 
      proxyRec
    proxyRec = Data.EvalRecord.pure @b @(Pure1 Proxy) (\_ -> Proxy)

-- | Like 'pure' but a constraint is allowed to be required on
--   each element of @b@.
pureC
  :: forall c f b
  .  ( AllRecF c f b
     , ConstraintsRec b
     , ApplicativeRec b
     )
  => (forall a. c (f @@ a) => Metadata a -> f @@ a)
  -> b f
pureC fa = 
  Data.EvalRecord.map (\p -> requiringDict @(ClassF c f) (fa p)) (dicts @(ClassF c f) @b)

-- | Builds a @b f@, by applying 'mempty' on every field of @b@.
mempty
  :: forall f b
  .  ( AllRecF Monoid f b
     , ConstraintsRec b
     , ApplicativeRec b
     )
  => b f
mempty =
  Data.EvalRecord.pureC @Monoid $ \_ -> Prelude.mempty


-- | A 'FunctorRec' where the effects can be distributed to the fields:
--  `distribute` turns an effectful way of building a Record-type
--  into a pure Record-type with effectful ways of computing the
--  values of its fields.
--
--  This class is the categorical dual of `TraversableRec`,
--  with `distribute` the dual of `sequence`
--  and `cotraverse` the dual of `traverse`. As such,
--  instances need to satisfy these laws:
--
-- @
-- 'distribute' . h = 'map' h) . 'distribute'    -- naturality
-- 'distribute' . 'Data.Functor.Identity' = 'map' 'Data.Functor.Identity'                 -- identity
-- @
--
-- By specializing @f@ to @((->) a)@ and @g@ to 'Identity', we can define a function that
-- decomposes a function on distributive records into a collection of simpler functions:
--
-- @
-- 'decompose' :: 'DistributiveRec' b => (a -> b 'Identity') -> b ((->) a)
-- 'decompose' = 'map' ('fmap' 'runIdentity' . 'getCompose') . 'distribute'
-- @
--
-- Lawful instances of the class can then be characterized as those that satisfy:
--
-- @
-- 'recompose' . 'decompose' = 'id'
-- 'decompose' . 'recompose' = 'id'
-- @
--
-- This means intuitively that instances need to have a fixed shape (i.e. no sum-types can be involved).
-- Typically, this means record types, as long as they don't contain fields where the functor argument is not applied.
class FunctorRec rec => DistributiveRec (rec :: (Type -> Exp Type) -> Type) where
  distribute :: Functor f => f (rec g) -> rec (Pure1 f <=< g)

dropPureBind :: rec (f <=< Pure) -> rec f
dropPureBind = unsafeCoerce

-- | A version of `distribute` with @g@ specialized to `Pure`.
distribute' :: (DistributiveRec rec, Functor f) => f (rec Pure) -> rec (Pure1 f)
distribute' f = dropPureBind (distribute f)
{-# INLINE distribute' #-}

-- Dual of 'traverse'
cotraverse :: (DistributiveRec rec, Functor f) => (forall a. f (g @@ a) -> f a) -> f (rec g) -> rec (Pure1 f)
cotraverse h = map (\_ -> h) . distribute
{-# INLINE cotraverse #-}

-- | Decompose a function returning a distributive record into
--   a collection of simpler functions.
decompose :: (DistributiveRec rec) => (a -> rec Pure) -> rec (Pure1 ((->) a))
decompose f = dropPureBind (distribute f)
{-# INLINE decompose #-}

-- | Recompose a decomposed function.
recompose :: FunctorRec rec => rec (Pure1 ((->) a)) -> a -> rec Pure
recompose bfs = \a -> map (\_ f -> f a) bfs
{-# INLINE recompose #-}

-- | A wrapper for Eval Record-types, providing useful instances.
newtype EvalRecord b (f :: Type -> Exp Type)
  = EvalRecord { evalRecord :: b f }
  deriving newtype (FunctorRec, ApplicativeRec)

instance (WitnessFieldTypes b, FunctorRec b) => WitnessFieldTypes (EvalRecord b) where
  typeName _ = typeName (Proxy :: Proxy b)
  typeProxies = typeProxies
  getAccessors = EvalRecord $
    map 
      (\_ (LensRec getter setter) -> LensRec 
        { view = getter . evalRecord
        , set = \x (EvalRecord record) -> EvalRecord $ setter x record
        }
      )
      (getAccessors :: b (Pure1 (LensRec b)))
  nestedFieldNames = EvalRecord nestedFieldNames

-- Need to derive it manually to make GHC 8.0.2 happy
instance ConstraintsRec b => ConstraintsRec (EvalRecord b) where
  type AllRec c (EvalRecord b) = AllRec c b
  addDicts = EvalRecord . addDicts . evalRecord

instance TraversableRec b => TraversableRec (EvalRecord b) where
  traverse f = fmap EvalRecord . Data.EvalRecord.traverse f . evalRecord
  traverse_ f = Data.EvalRecord.traverse_ f . evalRecord

instance (ConstraintsRec b, ApplicativeRec b, AllRecF Semigroup f b) => Semigroup (EvalRecord b f) where
  (<>) = zipWith3 mk dicts
    where
      mk :: Metadata a -> Dict (ClassF Semigroup f) a -> f @@ a -> f @@ a -> f @@ a
      mk _ = requiringDict (<>)

instance (ConstraintsRec b, ApplicativeRec b, AllRecF Semigroup f b, AllRecF Monoid f b) => Monoid (EvalRecord b f) where
  mempty  = Data.EvalRecord.mempty
  mappend = (<>)

data MapMatches pred f :: Type -> Exp Type

type instance Eval (MapMatches pred f a) = ValueOnMatch (pred @@ a) (f @@ a) a

type family ValueOnMatch cond b a where
  ValueOnMatch 'True b _ = b
  ValueOnMatch 'False _ a = a

class ApplyOnMatch (cond :: Bool) where
  applyOnMatch :: Proxy cond -> (a -> b) -> a -> ValueOnMatch cond b a

instance ApplyOnMatch 'True where
  applyOnMatch _ f x = f x

instance ApplyOnMatch 'False where
  applyOnMatch _ _ x = x

mapMatching 
  :: forall (pred :: Type -> Exp Bool) (f :: Type -> Exp Type) (g :: Type -> Exp Type) rec
  .  (FunctorRec rec, ConstraintsRec rec, AllRecF ApplyOnMatch (pred <=< f) rec)
  => Proxy (pred :: Type -> Exp Bool) 
  -> (forall a. Metadata a -> f @@ a -> (g <=< f) @@ a)
  -> rec f 
  -> rec (MapMatches pred g <=< f)
mapMatching p f record = Data.EvalRecord.mapC @(ClassF ApplyOnMatch (pred <=< f))
  applyIfRelevant
  record
  where
    applyIfRelevant :: forall a. ApplyOnMatch ((pred <=< f) @@ a) => Metadata a -> f @@ a -> (MapMatches pred g <=< f) @@ a
    applyIfRelevant meta x = 
      let 
        predAppProxy :: Proxy (pred @@ (f @@ a))
        predAppProxy = applyPred p x

        mapFn :: f @@ a -> (g <=< f) @@ a
        mapFn = f meta
      in 
        applyOnMatch predAppProxy mapFn x

applyPred :: Proxy pred -> a -> Proxy (pred @@ a)
applyPred _ _ = Proxy
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-redundant-constraints #-}

module Temporal.Contrib.BoundedConcurrency
  ( -- * Bounded concurrency
    ActionResult (..),
    traverseWaitConcurrentlyBounded,
    traverseWaitConcurrentlyBounded_,
    unfoldWaitableFoldResultConcurrentlyBounded,
    unfoldConcurrentlyBounded,
    unfoldConcurrentlyBounded_,
    waitConcurrentlyBounded,
    waitConcurrentlyBounded_,
    withDynamicConcurrency,

    -- * "Continue as new"
    safelyRecursive,
    handleActionResult,
  )
where

import Control.Monad.Catch (MonadCatch,)
import Data.Aeson.TH
import Data.Functor (void, (<&>))
import Data.Proxy (Proxy (..))
import Data.Traversable (for)
import GHC.Exts (proxy#)
import GHC.TypeLits
import RequireCallStack
import Temporal.Contrib.BoundedConcurrency.Select
import Temporal.Payload
import Temporal.Workflow
import qualified Temporal.Workflow as Workflow
import Prelude

-- | The @*ConcurrentlyBounded@ functions return this type which either returns
--
-- 1. The completed action and final result
-- 2. The running state and partial result
--
-- We return (2) if temporal suggests that the workflow continue-as-new to avoid
-- event history limits. You can handle the HistoryExhausted variant yourself or
-- use something like @handleActionResult@ to do so for you.
data ActionResult a b = ActionResult'Done b | ActionResult'HistoryExhausted a b
  deriving stock (Show, Eq, Functor, Foldable, Traversable)

deriveJSON defaultOptions ''ActionResult

-- | Helper to transform a function that returns @Workflow (ActionResult a b)@
-- into one that returns @Workflow b@. So, this handles calling continue-as-new
-- when appropriate.
--
-- Example usage:
-- @
-- sumConcurrentlyBoundedCan :: Int -> Int -> Int -> Workflow Int
-- sumConcurrentlyBoundedCan = provideCallStack $
--   handleActionResult
--     SumConcurrentlyBoundedCan
--     defaultContinueAsNewOptions
--     selfApply
--     \lowerBound upperBound sumSoFar ->
--       let unfold :: (Int, Int) -> Workflow (Maybe (Task Int, (Int, Int)))
--           unfold (i, _ub) = case i > upperBound of
--             True -> pure Nothing
--             False -> provideCallStack do
--               task <- startActivity EchoInt activityOptions i
--               pure (Just (task, (i + 1, upperBound)))
--        in unfoldFoldConcurrentlyBounded @100 unfold (lowerBound, upperBound) (+) sumSoFar
--   where
--     selfApply :: forall r. (Int -> Int -> Int -> r) -> (Int, Int) -> Int -> r
--     selfApply go (i, ub) sumSoFar = go i ub sumSoFar
-- @
--
-- See the spec for a typechecked usage.
handleActionResult ::
  forall f g gRef a b.
  ( f ~ (ArgsOf f :->: Workflow (ResultOf Workflow f))
  , ResultOf Workflow f ~ ActionResult a b
  , g ~ (ArgsOf f :->: Workflow b)
  , ArgsOf f ~ ArgsOf g
  , ResultOf Workflow g ~ b
  , WorkflowRef gRef
  , WorkflowArgs gRef ~ ArgsOf g
  , WorkflowResult gRef ~ b
  , VarArgs (ArgsOf f)
  ) =>
  gRef ->
  ContinueAsNewOptions ->
  -- | How to apply our workflow function given the intermediate action state
  -- and result
  (forall r. (ArgsOf g :->: r) -> a -> b -> r) ->
  -- | Some workflow function that returns an @ActionResult a b@
  f ->
  -- | Some workflow function that returns @b@
  g
handleActionResult gRef opts applySelf action =
  let loopOrContinueAsNew :: Workflow (ActionResult a b) -> Workflow b
      loopOrContinueAsNew mRes =
        mRes >>= \case
          ActionResult'Done b -> pure b
          ActionResult'HistoryExhausted a b -> applySelf (continueAsNew gRef opts) a b
   in mapResult @(ArgsOf f) loopOrContinueAsNew action

-- | A helper for defining recursive workflows that respect event history limits
-- by automatically calling continue-as-new when appropriate. This is
-- essentially the @fix@ operator, but the "self" argument will check if it
-- should continue-as-new and do so if temporal suggests that it should.
--
-- Example usage:
-- @
--  register
--    [d|
--      echoInt :: Int -> Activity App Int
--      echoInt i = pure i
--
--      sumSafelyRecursive :: Int -> Int -> Workflow Int
--      sumSafelyRecursive = provideCallStack $
--        safelyRecursive
--          SumSafelyRecursive
--          defaultContinueAsNewOptions
--          \go i acc ->
--            case i == 0 of
--              True -> pure acc
--              False -> do
--                _ <- executeActivity EchoInt activityOptions i
--                let !i' = i - 1
--                    !acc' = acc + i
--                go i' acc'
--      |]
--    MercuryWorkflowOptions
--      { alertChannel = AccountingIntegrationsAlerts
--      }
-- @
safelyRecursive ::
  forall f fRef.
  ( f ~ (ArgsOf f :->: Workflow (ResultOf Workflow f))
  , WorkflowRef fRef
  , WorkflowArgs fRef ~ ArgsOf f
  , WorkflowResult fRef ~ ResultOf Workflow f
  , VarArgs (ArgsOf f)
  ) =>
  fRef -> ContinueAsNewOptions -> (f -> f) -> f
safelyRecursive fRef opts f2f =
  let f :: f
      f = sequenceWorkflowArgs (f2f <$> loopOrContinueAsNew)

      sequenceWorkflowArgs :: Workflow f -> f
      sequenceWorkflowArgs = sequenceArgs @(ArgsOf f) (Proxy @(Workflow (ResultOf Workflow f)))

      loopOrContinueAsNew =
        Workflow.continueAsNewSuggested <$> Workflow.info <&> \case
          True -> continueAsNew fRef opts
          False -> f
   in f

-- | Pass a dynamic integer to the '*ConcurrentlyBounded*' functions in this
-- module.
--
-- If the dynamic integer exceeds the bounds it will be defaulted to either 0 or
-- 2000. It's probably a good idea to ensure the value passed is sensible by
-- other means, this is just the behavior required in order to typecheck.
--
--
-- Usage:
-- @
-- withDynamicConcurrency someIntegerVariable \(_ :: Proxy i) ->
--   traverseWaitConcurrentlyBounded @i
--     ...
-- @
withDynamicConcurrency :: Integral n => n -> (forall i. (KnownNat i, 0 <= i, i <= 2000) => Proxy i -> a) -> a
withDynamicConcurrency i f =
  withSomeSNat (toInteger i) \case
    Nothing -> f $ Proxy @0
    Just (sn :: SNat n) ->
      withKnownNat sn $
        case cmpNat @n @2000 Proxy Proxy of
          EQI -> f $ Proxy @2000
          GTI -> f $ Proxy @2000
          LTI -> case cmpNat @0 @n Proxy Proxy of
            EQI -> f $ Proxy @0
            GTI -> f $ Proxy @0
            LTI -> f $ Proxy @n

-- | Execute a list of tasks, by running @n@ concurrently. This is useful
-- when you want to run many instances of an activity or child workflow and want
-- to process them concurrently.
--
-- example usage:
-- @
-- traverseWaitConcurrentlyBounded @5 activityArgList (startActivity SomeActivity activityOptions)
-- @
--
-- This will run @SomeActivity@ @length activityArgList@ times, by running 5
-- activities concurrently, returning the results in the same order as @traverse
-- (executeActivity SomeActivity activityOptions) activityArgList@.
traverseWaitConcurrentlyBounded ::
  forall n a w b.
  ( RequireCallStack
  , Wait w
  , WaitResult w ~ Workflow b
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  [a] ->
  (a -> Workflow w) ->
  Workflow (ActionResult [a] [b])
traverseWaitConcurrentlyBounded pending startTask = unfoldConcurrentlyBounded @n unfold pending
  where
    unfold = \case
      [] -> pure Nothing
      x : xs -> do
        task <- startTask x
        pure (Just (task, xs))

-- | A variant of @traverseWaitConcurrentlyBounded@ that returns @()@
traverseWaitConcurrentlyBounded_ ::
  forall n a w b.
  ( RequireCallStack
  , Wait w
  , WaitResult w ~ Workflow b
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  [a] ->
  (a -> Workflow w) ->
  Workflow (ActionResult [a] ())
traverseWaitConcurrentlyBounded_ pending startTask = unfoldConcurrentlyBounded_ @n unfold pending
  where
    unfold = \case
      [] -> pure Nothing
      x : xs -> do
        task <- startTask x
        pure (Just (task, xs))

-- | Like @unfoldConcurrentlyBounded@, but we strictly fold the wait results as
-- they return
unfoldWaitableFoldResultConcurrentlyBounded ::
  forall n st w waitResult unfoldElem a b.
  ( RequireCallStack
  , Wait w
  , WaitResult w ~ Workflow waitResult
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  (st -> Workflow (Maybe (unfoldElem, st))) ->
  st ->
  (b -> a -> Workflow b) ->
  b ->
  (forall m. MonadCatch m => (w -> m waitResult) -> unfoldElem -> m a) ->
  Workflow (ActionResult st b)
unfoldWaitableFoldResultConcurrentlyBounded unfoldAction initialUnfoldState finishedWaiterAction initialRunningState waitModifier =
  waitConcurrentlyBoundedGen @n $ waitConcurrentlyBoundedArgsFoldResult unfoldAction initialUnfoldState finishedWaiterAction initialRunningState waitModifier

waitConcurrentlyBoundedArgsFoldResult ::
  ( RequireCallStack
  , Wait w
  , WaitResult w ~ Workflow waitResult
  ) =>
  (unfoldState -> Workflow (Maybe (a, unfoldState))) ->
  unfoldState ->
  (runningState -> b -> Workflow runningState) ->
  runningState ->
  (forall m. MonadCatch m => (w -> m waitResult) -> a -> m b) ->
  WaitConcurrentlyBoundedArgs unfoldState runningState runningState a b
waitConcurrentlyBoundedArgsFoldResult unfoldAction initialUnfoldState finishedWaiterAction initialRunningState waitModifier =
  WaitConcurrentlyBoundedArgs
    { unfoldAction
    , initialUnfoldState
    , newWaiterAction = \a _ -> pure a
    , finishedWaiterAction
    , initialRunningState
    , prepareResult = pure
    , waitAction = waitModifier Workflow.wait
    }

-- | Like @traverseWaitConcurrentlyBounded@, except the list of @a@s is computed
-- statefully as elements are required.
unfoldConcurrentlyBounded ::
  forall n st w b.
  ( RequireCallStack
  , Wait w
  , WaitResult w ~ Workflow b
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  (st -> Workflow (Maybe (w, st))) ->
  st ->
  Workflow (ActionResult st [b])
unfoldConcurrentlyBounded unfold initialUnfoldState = waitConcurrentlyBounded @n unfold initialUnfoldState Workflow.wait

-- | A variant of @unfoldConcurrentlyBounded@ that returns @()@
--
-- This is most useful when you want to run many activities for their side
-- effects. For example, the unfold state could be a database cursor, and for
-- each row emitted we want to issue an http request.
unfoldConcurrentlyBounded_ ::
  forall n st w b.
  ( RequireCallStack
  , Wait w
  , WaitResult w ~ Workflow b
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  (st -> Workflow (Maybe (w, st))) ->
  st ->
  Workflow (ActionResult st ())
unfoldConcurrentlyBounded_ unfold initialUnfoldState = waitConcurrentlyBounded_ @n unfold initialUnfoldState (void . Workflow.wait)

-- | A variant of 'waitConcurrentlyBounded' that returns @()@
waitConcurrentlyBounded_ ::
  forall n st a.
  ( RequireCallStack
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  -- | Unfold action
  (st -> Workflow (Maybe (a, st))) ->
  -- | Initial unfold state
  st ->
  -- | The waiting action. This will commonly just be @wait@.
  (a -> Workflow ()) ->
  Workflow (ActionResult st ())
waitConcurrentlyBounded_ unfold initialUnfoldState waitA =
  waitConcurrentlyBoundedGen @n $ waitConcurrentlyBoundedArgs_ unfold initialUnfoldState waitA

waitConcurrentlyBoundedArgs_ ::
  RequireCallStack =>
  -- | Unfold action
  (unfoldState -> Workflow (Maybe (a, unfoldState))) ->
  -- | Initial unfold state
  unfoldState ->
  -- | The waiting action. This will commonly just be @wait@, but you may want
  -- to catch exceptions. See @runChildWorkflowsMaxConcurrent@ for example.
  (a -> Workflow ()) ->
  WaitConcurrentlyBoundedArgs unfoldState () () a ()
waitConcurrentlyBoundedArgs_ unfoldAction initialUnfoldState waitAction =
  WaitConcurrentlyBoundedArgs
    { unfoldAction
    , initialUnfoldState
    , newWaiterAction = \a _ -> pure a
    , finishedWaiterAction = \a _ -> pure a
    , initialRunningState = ()
    , prepareResult = pure
    , waitAction
    }

-- | Generalization of @unfoldConcurrentlyBounded@
waitConcurrentlyBounded ::
  forall n st a b.
  ( RequireCallStack
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  -- | Unfold action
  (st -> Workflow (Maybe (a, st))) ->
  -- | Initial unfold state
  st ->
  -- | The waiting action. This will commonly just be @wait@, but you may want
  -- to catch exceptions. See @runChildWorkflowsMaxConcurrent@ for example.
  (a -> Workflow b) ->
  Workflow (ActionResult st [b])
waitConcurrentlyBounded unfold initialUnfoldState waitA = do
  waitConcurrentlyBoundedGen @n $ waitConcurrentlyBoundedArgsList unfold initialUnfoldState waitA

waitConcurrentlyBoundedArgsList ::
  RequireCallStack =>
  -- | Unfold action
  (unfoldState -> Workflow (Maybe (a, unfoldState))) ->
  -- | Initial unfold state
  unfoldState ->
  -- | The waiting action. This will commonly just be @wait@, but you may want
  -- to catch exceptions. See @runChildWorkflowsMaxConcurrent@ for example.
  (a -> Workflow b) ->
  WaitConcurrentlyBoundedArgs unfoldState [StateVar b] [b] (StateVar b, a) ()
waitConcurrentlyBoundedArgsList unfold initialUnfoldState waitA =
  WaitConcurrentlyBoundedArgs
    { unfoldAction = \st -> do
        mNext <- unfold st
        for mNext \(next, st') -> do
          var <- newStateVar (error "waitConcurrentlyBounded: failed to ensure all actions completed")
          pure ((var, next), st')
    , initialUnfoldState
    , newWaiterAction = \vars (var, _) -> pure (var : vars)
    , finishedWaiterAction = \a _ -> pure a
    , initialRunningState = []
    , prepareResult = traverse readStateVar . reverse
    , waitAction = \(var, a) -> writeStateVar var =<< waitA a
    }

data WaitConcurrentlyBoundedArgs unfoldState runningState result a b
  = WaitConcurrentlyBoundedArgs
  { unfoldAction :: unfoldState -> Workflow (Maybe (a, unfoldState))
  -- ^ The unfold action, this probably spawns a child workflow or an activity.
  , initialUnfoldState :: unfoldState
  -- ^ Initial unfold state
  , newWaiterAction :: runningState -> a -> Workflow runningState
  -- ^ how to add unfolded elems (new Waitable things) to the running state
  , finishedWaiterAction :: runningState -> b -> Workflow runningState
  -- ^ how to add wait results to the running state
  , initialRunningState :: runningState
  -- ^ Initial running state
  , prepareResult :: runningState -> Workflow result
  -- ^ converting the runningState to the final return value
  , waitAction :: a -> Workflow b
  -- ^ The waiting action. This will commonly just be @wait@
  }

-- | General bounded concurrency function. The others bounded concurrency
-- functions in this module are implemented by calling this function.
waitConcurrentlyBoundedGen ::
  forall n unfoldState runningState result a b.
  ( RequireCallStack
  , KnownNat n
  , 0 <= n
  , n <= 2000
  ) =>
  WaitConcurrentlyBoundedArgs unfoldState runningState result a b ->
  Workflow (ActionResult unfoldState result)
waitConcurrentlyBoundedGen WaitConcurrentlyBoundedArgs {..} = do
  let maxConcurrent :: Int = fromIntegral (natVal' (proxy# @n))
      step :: RequireCallStack => Select a -> runningState -> ActionResult unfoldState runningState -> (Select a -> runningState -> Workflow (ActionResult unfoldState result)) -> Workflow (ActionResult unfoldState result)
      step sel runningState nothingK justK = do
        (mfirstResult, sel') <- awaitAction sel waitAction
        case mfirstResult of
          Nothing -> traverse prepareResult nothingK
          Just firstResult -> justK sel' =<< finishedWaiterAction runningState firstResult

      drain :: RequireCallStack => Select a -> runningState -> (runningState -> ActionResult unfoldState runningState) -> Workflow (ActionResult unfoldState result)
      drain sel runningState mkResult = step sel runningState (mkResult runningState) (\sel' runningState' -> drain sel' runningState' mkResult)

      decide :: RequireCallStack => Select a -> unfoldState -> runningState -> Workflow (ActionResult unfoldState result)
      decide sel unfoldState runningState = do
        historyExhausted <- continueAsNewSuggested <$> info
        case historyExhausted of
          True -> drain sel runningState (ActionResult'HistoryExhausted unfoldState)
          False -> step sel runningState (ActionResult'Done runningState) \sel' runningState' ->
            unfoldAction unfoldState >>= \case
              Nothing -> drain sel' runningState' ActionResult'Done
              Just (a, unfoldState') -> do
                decide (push sel' a) unfoldState' =<< newWaiterAction runningState' a

  let initLoop :: Int -> unfoldState -> runningState -> [a] -> Workflow (runningState, unfoldState, [a])
      initLoop remainingIters unfoldState runningState selectList = case remainingIters <= 0 of
        True -> pure (runningState, unfoldState, selectList)
        False ->
          unfoldAction unfoldState >>= \case
            Nothing -> pure (runningState, unfoldState, selectList)
            Just (a, unfoldState') -> do
              let !remainingIters' = remainingIters - 1
              runningState' <- newWaiterAction runningState a
              initLoop remainingIters' unfoldState' runningState' (a : selectList)

  (runningState, unfoldState, selectList) <- initLoop maxConcurrent initialUnfoldState initialRunningState []
  decide (mkSelect selectList) unfoldState runningState


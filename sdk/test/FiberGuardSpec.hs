module FiberGuardSpec where

import Data.IORef (readIORef, writeIORef)
import Data.List (isInfixOf)
import Temporal.Exception (RuntimeError (..))
import Temporal.Workflow.Internal.DelimCC (PromptTag, newPromptTag, prompt)
import Temporal.Workflow.Internal.Monad (
  IVar (..),
  IVarContents (..),
  ResultVal (..),
  Status (..),
  newIVar,
  suspendVia,
 )
import Test.Hspec


{- | Run a fiber whose whole body is @suspendVia tag ivar@, fill the IVar it
parked on with @rv0@, and hand @body@ the resume action (the captured
continuation applied to the IVar's contents). Filling the concretely-typed
handle and reading back through the existential one carried by 'SBlocked' is
exactly the pairing the scheduler relies on in @runFiberTask@.
-}
withSuspendedFiber :: ResultVal Int -> (IO (Status (ResultVal Int)) -> Expectation) -> Expectation
withSuspendedFiber rv0 body = do
  tag <- newPromptTag
  ivar <- newIVar :: IO (IVar Int)
  st <- prompt tag (SDone <$> suspendVia tag ivar)
  case st of
    SDone _ -> expectationFailure "fiber completed without suspending"
    SBlocked bivar k -> do
      writeIORef (ivarRef ivar) (IVarFull rv0)
      contents <- readIORef (ivarRef bivar)
      case contents of
        IVarEmpty _ -> expectationFailure "SBlocked did not carry the IVar the fiber blocked on"
        IVarFull rv -> body (k rv)


-- | 'ResultVal' has no 'Eq'; match the @SDone (Ok n)@ shape by hand.
shouldResumeTo :: Status (ResultVal Int) -> ResultVal Int -> Expectation
shouldResumeTo (SDone (Ok actual)) (Ok expected) = actual `shouldBe` expected
shouldResumeTo st _ = expectationFailure ("resumed fiber did not finish with SDone (Ok _): " <> statusShape st)
  where
    statusShape :: Status (ResultVal Int) -> String
    statusShape (SDone (Ok _)) = "SDone (Ok _)"
    statusShape (SDone (ThrowInternal e)) = "SDone (ThrowInternal " <> show e <> ")"
    statusShape (SDone (ThrowWorkflow e)) = "SDone (ThrowWorkflow " <> show e <> ")"
    statusShape (SBlocked _ _) = "SBlocked"


spec :: Spec
spec = describe "Fiber suspension guards" $ do
  specify "blocking outside a delimiter raises a domain error, not NoMatchingContinuationPrompt" $ do
    tag <- newPromptTag :: IO (PromptTag (Status ()))
    ivar <- newIVar :: IO (IVar Int)
    -- No enclosing 'prompt tag': control0 has nothing to capture up to. The
    -- guard must surface this as a diagnosable RuntimeError; a raw
    -- NoMatchingContinuationPrompt would escape shouldThrow and fail the test.
    suspendVia tag ivar
      `shouldThrow` \(RuntimeError msg) -> "outside the workflow scheduler" `isInfixOf` msg

  specify "suspending parks on the IVar and resuming delivers its ResultVal" $
    withSuspendedFiber (Ok 42) $ \resume -> do
      st <- resume
      st `shouldResumeTo` Ok 42

  specify "resuming the same continuation twice raises the invariant error" $
    withSuspendedFiber (Ok 1) $ \resume -> do
      st <- resume -- first resume must run to completion
      st `shouldResumeTo` Ok 1
      resume
        `shouldThrow` \(RuntimeError msg) -> "resumed more than once" `isInfixOf` msg

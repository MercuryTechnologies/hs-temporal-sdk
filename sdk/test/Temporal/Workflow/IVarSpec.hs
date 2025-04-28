{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE NamedFieldPuns #-}
module Temporal.Workflow.IVarSpec where

import Control.Monad
import Test.Hspec
import UnliftIO
import UnliftIO.Concurrent
import qualified Data.HashMap.Strict as HashMap
import Control.Monad.Logger
import Control.Monad.Reader
import Temporal.Workflow.IVar
import Control.Concurrent.STM (retry, check)

-- Mock environment for testing
data TestRuntime = TestRuntime
  { testThreadManager :: TVar (HashMap.HashMap ThreadId WorkflowThread)
  }

instance HasThreadManager TestRuntime where
  getThreadManager = ThreadManager . testThreadManager

newtype TestMonad a = TestMonad { unTestMonad :: ReaderT TestRuntime IO a }
  deriving newtype (Functor, Applicative, Monad, MonadReader TestRuntime, MonadIO, MonadUnliftIO)

runTestMonad :: TestRuntime -> TestMonad a -> IO a
runTestMonad runtime testMonad = runReaderT (unTestMonad testMonad) runtime

instance MonadLogger TestMonad where
  monadLoggerLog loc src lvl msg = liftIO $ defaultOutput stdout loc src lvl (toLogStr msg)

-- | Create a new test runtime
newTestRuntime :: IO TestRuntime
newTestRuntime = do
  threadManagerVar <- newTVarIO HashMap.empty
  pure TestRuntime
    { testThreadManager = threadManagerVar
    }

-- -- | Creates a new thread in the test runtime
forkTestThread :: TestRuntime -> TestMonad a -> IO (Async a)
forkTestThread runtime action = do
  async $ do
    tid <- myThreadId
    atomically $ do
      workflowThreadBlocked <- newTVar False
      modifyTVar' runtime.testThreadManager $
        HashMap.insert tid (WorkflowThread workflowThreadBlocked)
    runTestMonad runtime action
      `finally` atomically (modifyTVar' runtime.testThreadManager $ HashMap.delete tid)

-- -- | Check if a thread is blocked in the runtime
isThreadBlocked :: TestRuntime -> ThreadId -> IO Bool
isThreadBlocked runtime tid = atomically $ do
  threads <- readTVar runtime.testThreadManager
  case HashMap.lookup tid threads of
    Just thread -> readTVar thread.workflowThreadBlocked
    Nothing -> pure False

waitThreadBlocked :: TestRuntime -> ThreadId -> IO ()
waitThreadBlocked runtime tid = atomically $ do
  thread <- readTVar runtime.testThreadManager
  case HashMap.lookup tid thread of
    Just thread -> do
      isBlocked <- readTVar thread.workflowThreadBlocked
      unless isBlocked retry
    Nothing -> retry

waitThreadUnblocked :: TestRuntime -> ThreadId -> IO ()
waitThreadUnblocked runtime tid = atomically $ do
  thread <- readTVar runtime.testThreadManager
  case HashMap.lookup tid thread of
    Just thread -> do
      isBlocked <- readTVar thread.workflowThreadBlocked
      when isBlocked retry
    Nothing -> pure ()

spec :: Spec
spec = do
  describe "IVar" $ do
    it "should be able to put and get a value immediately" $ do
      runtime <- newTestRuntime
      result <- runTestMonad runtime $ do
        ivar <- newIVar $ getThreadManager runtime
        atomically $ putIVar ivar ("Hello, World!" :: String)
        waitIVar ivar
      result `shouldBe` "Hello, World!"

    it "should block a thread waiting for an empty IVar" $ do
      runtime <- newTestRuntime
      ivar <- newIVar $ getThreadManager runtime

      -- Fork a thread that waits on the IVar
      waitingThread <- forkTestThread runtime do
        waitIVar ivar

      -- Wait for the thread to block
      waitThreadBlocked runtime (asyncThreadId waitingThread)

      -- Put a value and check that the thread unblocks
      atomically $ putIVar ivar ("Value" :: String)

      waitThreadUnblocked runtime (asyncThreadId waitingThread)

      -- Check the result is correct
      result <- wait waitingThread
      result `shouldBe` "Value"

    it "should not block a thread if the IVar already has a value" $ do
      runtime <- newTestRuntime
      ivar <- newIVar $ getThreadManager runtime
      atomically $ putIVar ivar ("I've been here the whole time" :: String)

      -- Fork a thread that gets the IVar value
      waitingThread <- forkTestThread runtime $ waitIVar ivar

      waitThreadUnblocked runtime (asyncThreadId waitingThread)

      -- Check the result is correct
      result <- wait waitingThread
      result `shouldBe` "I've been here the whole time"

    it "should allow multiple threads to read the same IVar" $ do
      runtime <- newTestRuntime
      ivar <- newIVar $ getThreadManager runtime

      -- Fork multiple threads waiting on the IVar
      thread1 <- forkTestThread runtime $ waitIVar ivar
      thread2 <- forkTestThread runtime $ waitIVar ivar
      thread3 <- forkTestThread runtime $ waitIVar ivar

      -- Check that all threads are blocked
      waitThreadBlocked runtime $ asyncThreadId thread1
      waitThreadBlocked runtime $ asyncThreadId thread2
      waitThreadBlocked runtime $ asyncThreadId thread3

      -- Put a value and check that all threads unblock
      atomically $ putIVar ivar "Shared Value"

      -- Check results
      result1 <- wait thread1
      result2 <- wait thread2
      result3 <- wait thread3

      result1 `shouldBe` ("Shared Value" :: String)
      result2 `shouldBe` "Shared Value"
      result3 `shouldBe` "Shared Value"

    it "should handle multiple puts gracefully (only first succeeds)" $ do
      runtime <- newTestRuntime
      ivar <- newIVar $ getThreadManager runtime

      -- First put should succeed
      atomically $ putIVar ivar ("First Value" :: String)

      -- Second put should be a no-op
      atomically $ putIVar ivar "Second Value"

      -- Value should still be the first one
      result <- runTestMonad runtime (waitIVar ivar)
      result `shouldBe` "First Value"

    it "should detect when all threads are blocked" $ do
      runtime <- newTestRuntime
      ivar1 <- newIVar $ getThreadManager runtime
      ivar2 <- newIVar $ getThreadManager runtime

      -- Fork multiple threads waiting on different IVars
      thread1 <- forkTestThread runtime $ waitIVar ivar1
      thread2 <- forkTestThread runtime $ waitIVar ivar2

      waitThreadBlocked runtime $ asyncThreadId thread1
      waitThreadBlocked runtime $ asyncThreadId thread2

      -- Verify that waitAllBlocked completes when all threads are blocked
      _everythingIsInFactBlocked <- atomically $ waitAllBlocked runtime

      -- Unblock the first thread. Once it has completed,
      -- waitAllBlocked should block again.
      atomically $ putIVar ivar1 ("Value 1" :: String)
      wait thread1 `shouldReturn` "Value 1"

      atomically $ waitAllBlocked runtime
      atomically $ putIVar ivar2 ("Value 2" :: String)
      wait thread2 `shouldReturn` "Value 2"

    it "should not block if no threads exist" $ do
      runtime <- newTestRuntime
      atomically $ waitAllBlocked runtime

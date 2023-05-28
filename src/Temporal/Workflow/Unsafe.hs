{-# LANGUAGE DataKinds #-}
{-# LANGUAGE UndecidableInstances #-}
module Temporal.Workflow.Unsafe where
import Control.Monad.Reader
import Data.Int (Int32)
import Data.Text (Text)
import GHC.TypeLits
import System.Clock (TimeSpec)
import Temporal.Common
import UnliftIO (MonadUnliftIO(..))

data ParentInfo = ParentInfo
  { parentNamespace :: Namespace
  , parentRunId :: RunId
  , parentWorkflowId :: WorkflowId
  }

data RetryPolicy = RetryPolicy
  { initialInterval :: TimeSpec
  , backoffCoefficient :: Double
  , maximumInterval :: Maybe TimeSpec
  , maximumAttempts :: Int32
  , nonRetryableErrorTypes :: [Text]
  }

data Context env = Context
  { contextNamespace :: Namespace
  -- , contextTaskQueue :: Text
  -- , contextArgs :: Vector Payload
  -- , contextCancelled :: IORef Bool
  -- , contextSequences :: IORef Sequences
  -- , contextShared :: IORef SharedData
  -- , contextRandomnessSeed :: IORef Word32
  -- , contextAppEnv :: env
  }

newtype Workflow env a = Workflow { unWorkflow :: ReaderT (Context env) IO a }
  deriving (Functor, Applicative, Monad)

runWorkflow :: Context env -> Workflow env a -> IO a
runWorkflow ctxt = flip runReaderT ctxt . unWorkflow

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadIO (Workflow env) where
  liftIO = error "Unreachable"

instance TypeError ('Text "A workflow definition cannot directly perform IO. Use executeActivity or executeLocalActivity instead.") => MonadUnliftIO (Workflow env) where
  withRunInIO _ = error "Unreachable"

-- execWorkflow :: MonadIO m => Context env -> Workflow env a -> m a
-- execWorkflow env = liftIO . flip runReaderT env . unWorkflow

{- |
Module: Temporal.EphemeralServer
Description: Run an Temporal server in a programatically for testing and development.

Run an Temporal server in a programatically for testing and development.
-}
module Temporal.EphemeralServer 
  ( launchTestServer
  , launchDevServer
  , withDevServer
  , withDevServer'
  , withTestServer
  , withTestServer'
  , getFreePort
  , openFreePort
  , EphemeralServerError(..)
  -- * Core configuration
  , EphemeralExeVersion(..)
  , EphemeralExe(..)
  , SDKDefault(..)
  , TemporalDevServerConfig(..)
  , defaultTemporalDevServerConfig
  , EphemeralServer
  , shutdownEphemeralServer
  , N.PortNumber
  ) where

import Temporal.Core.EphemeralServer
import Temporal.Runtime
import Data.ByteString (ByteString)
import Data.Bifunctor
import qualified Network.Socket as N
import qualified Control.Exception as E
import qualified System.IO.Error as Error
import UnliftIO

data EphemeralServerError = EphemeralServerError ByteString
  deriving stock (Show)

instance E.Exception EphemeralServerError

withDevServer :: MonadUnliftIO m => TemporalDevServerConfig -> (EphemeralServer -> m a) -> m a
withDevServer = withDevServer' globalRuntime

withDevServer' :: MonadUnliftIO m => Runtime -> TemporalDevServerConfig -> (EphemeralServer -> m a) -> m a
withDevServer' rt conf = bracket 
  (liftIO (startDevServer rt conf) >>= either (throwIO . EphemeralServerError) pure) 
  (\e -> liftIO (shutdownEphemeralServer e) >>= either (throwIO . EphemeralServerError) pure)

withTestServer :: MonadUnliftIO m => TestServerConfig -> (EphemeralServer -> m a) -> m a
withTestServer = withTestServer' globalRuntime

withTestServer' :: MonadUnliftIO m => Runtime -> TestServerConfig -> (EphemeralServer -> m a) -> m a
withTestServer' rt conf = bracket 
  (liftIO (startTestServer rt conf) >>= either (throwIO . EphemeralServerError) pure) 
  (\e -> liftIO (shutdownEphemeralServer e) >>= either (throwIO . EphemeralServerError) pure)

-- | Open a TCP socket on a random free port. This is like 'warp''s
--   openFreePort.
openFreePort :: IO (N.PortNumber, N.Socket)
openFreePort =
  E.bracketOnError (N.socket N.AF_INET N.Stream N.defaultProtocol) N.close
    $ \sock -> do
      N.bind sock $ N.SockAddrInet 0 $ N.tupleToHostAddress (127,0,0,1)
      N.getSocketName sock >>= \case
        N.SockAddrInet port _ -> pure (port, sock)
        addr -> E.throwIO
          $ Error.mkIOError Error.userErrorType
            (  "openFreePort was unable to create socket with a SockAddrInet. "
            <> "Got " <> show addr
            )
            Nothing
            Nothing

-- | Open a TCP socket, get its port and close the socket.
--   Useful when you have an external service that needs a fresh port.
--
--   There is a small race condition present:
--   It's possible to get a free port only for it to
--   be bound by some other process or thread before used
getFreePort :: IO N.PortNumber
getFreePort = do
  (port, socket) <- openFreePort
  N.close socket
  pure port

launchTestServer :: [String] -> IO (Either EphemeralServerError (N.PortNumber, EphemeralServer))
launchTestServer extraArgs = do
  freePort <- getFreePort
  bimap EphemeralServerError (\srv -> (freePort, srv)) <$> startTestServer globalRuntime (hackyConfig freePort)
  where
    hackyConfig port = TestServerConfig 
      { exe = CachedDownload (Default $ SDKDefault "community-haskell" "0.1.0.0") Nothing 
      , port = Just $ fromIntegral port
      , extraArgs
      }

launchDevServer :: TemporalDevServerConfig -> IO (Either EphemeralServerError EphemeralServer)
launchDevServer conf = first EphemeralServerError <$> startDevServer globalRuntime conf
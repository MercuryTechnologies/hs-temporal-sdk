module Temporal.EphemeralServer 
  ( launchTestServer
  , module Temporal.Core.EphemeralServer
  ) where

import Temporal.Core.EphemeralServer
import Temporal.Runtime
import Data.ByteString (ByteString)
import Data.Bifunctor
import qualified Network.Socket as N
import qualified Control.Exception as E
import qualified System.IO.Error as Error

data EphemeralServerError = EphemeralServerError ByteString

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

launchTestServer :: IO (Either EphemeralServerError (N.PortNumber, EphemeralServer))
launchTestServer = do
  freePort <- getFreePort
  bimap EphemeralServerError (\srv -> (freePort, srv)) <$> startTestServer globalRuntime (hackyConfig freePort)
  where
    hackyConfig port = TestServerConfig 
      { exe = CachedDownload (Default $ SDKDefault "sdk-typescript" "1.8.6") Nothing 
      , port = Just $ fromIntegral port
      , extraArgs = []
      }

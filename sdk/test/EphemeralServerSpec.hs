module EphemeralServerSpec where

import Control.Monad.Logger
import Test.Hspec
import TestHelpers
import Temporal.Core.Client
import Temporal.EphemeralServer
import qualified Temporal.EphemeralServer as TemporalDevServerConfig (TemporalDevServerConfig (..))
import qualified Temporal.EphemeralServer as TemporalTestServerConfig (TemporalTestServerConfig (..))
import Temporal.Runtime
import System.Directory (findExecutable)


spec :: Spec
spec = describe "Ephemeral Server" $ do
  specify "start dev server with custom port" $ do
    mTemporalPath <- findExecutable "temporal"
    case mTemporalPath of
      Nothing -> pendingWith "temporal executable not in PATH"
      Just temporalPath -> do
        fp <- getFreePort
        let conf = defaultTemporalDevServerConfig
              { TemporalDevServerConfig.port = Just $ fromIntegral fp
              , TemporalDevServerConfig.exe = ExistingPath temporalPath
              }
        withDevServer globalRuntime conf $ \_ -> do
          _ <- runStdoutLoggingT $ connectClient globalRuntime (configWithRetry fp)
          pure ()

  specify "start test server (time-skipping)" $ do
    mTemporalPath <- findExecutable "temporal-test-server"
    case mTemporalPath of
      Nothing -> pendingWith "temporal-test-server executable not in PATH"
      Just temporalPath -> do
        fp <- getFreePort
        let conf = TemporalTestServerConfig
              { TemporalTestServerConfig.exe = ExistingPath temporalPath
              , TemporalTestServerConfig.port = Just $ fromIntegral fp
              , TemporalTestServerConfig.extraArgs = []
              }
        withTestServer globalRuntime conf $ \_ -> do
          _ <- runStdoutLoggingT $ connectClient globalRuntime (configWithRetry fp)
          pure ()

  specify "dev server options (namespace, extra args)" $ do
    mTemporalPath <- findExecutable "temporal"
    case mTemporalPath of
      Nothing -> pendingWith "temporal executable not in PATH"
      Just temporalPath -> do
        fp <- getFreePort
        let conf = defaultTemporalDevServerConfig
              { TemporalDevServerConfig.port = Just $ fromIntegral fp
              , TemporalDevServerConfig.exe = ExistingPath temporalPath
              , TemporalDevServerConfig.namespace = "custom-test-ns"
              }
        withDevServer globalRuntime conf $ \_ -> do
          _ <- runStdoutLoggingT $ connectClient globalRuntime (configWithRetry fp)
          pure ()


  describe "Runtime" $ do
    specify "runtime initialization and destruction" $ do
      rt <- initializeRuntime NoTelemetry
      destroyRuntime rt

    specify "runtime bracket lifecycle" $ do
      bracketRuntime NoTelemetry $ \_rt ->
        pure ()

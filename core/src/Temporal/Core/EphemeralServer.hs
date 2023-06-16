{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
module Temporal.Core.EphemeralServer where

import Data.Aeson
import Data.Aeson.TH
import Data.Text
import Data.Text.Foreign
import Data.ByteString (ByteString, useAsCString)
import qualified Data.ByteString.Lazy as BL
import Data.Proxy
import Data.Word
import Foreign.C.String hiding (withCString)
import Foreign.Ptr
import Foreign.ForeignPtr
import Temporal.Runtime
import Temporal.Internal.FFI

data SDKDefault = SDKDefault { sdkName :: String, sdkVersion :: String }

data EphemeralExeVersion 
  = Default SDKDefault
    -- ^ Use a default version for the given SDK name and version.
  | Fixed String
    -- ^ Specific version.

instance ToJSON EphemeralExeVersion where
  toJSON (Default (SDKDefault name version)) = object 
    [ "type" .=  String "Default"
    , "contents" .= object
      [ "sdk_name" .= name
      , "sdk_version" .= version
      ]
    ]
  toJSON (Fixed version) = object 
    [ "type" .=  String "Fixed"
    , "contents" .= version
    ]

data EphemeralExe 
  = ExistingPath FilePath
    -- ^ Existing path on the filesystem for the executable.
  | CachedDownload EphemeralExeVersion (Maybe FilePath)
    -- ^ Download the executable if not already there.

instance ToJSON EphemeralExe where
  toJSON (ExistingPath path) = object 
    [ "type" .=  String "ExistingPath"
    , "contents" .= path
    ]
  toJSON (CachedDownload version destDir) = object 
    [ "type" .=  String "CachedDownload"
    , "contents" .= object
      [ "version" .= version
      , "dest_dir" .= destDir
      ]
    ]

data TemporalDevServerConfig = TemporalDevServerConfig
  { exe :: EphemeralExe
  , namespace :: FilePath
  , ip :: String
  , port :: Maybe Word16
  , dbFilename :: Maybe FilePath
  , ui :: Bool
  , log :: (String, String)
  , extraArgs :: [String]
  }

deriveToJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''TemporalDevServerConfig

defaultTemporalDevServerConfig :: TemporalDevServerConfig
defaultTemporalDevServerConfig = TemporalDevServerConfig
  { exe = ExistingPath "temporal"
  , namespace = "default"
  , ip = "127.0.0.1"
  , port = Nothing
  , dbFilename = Nothing
  , ui = False
  , log = ("pretty", "warn")
  , extraArgs = []
  }

newtype EphemeralServer = EphemeralServer { ephemeralServerPtr :: ForeignPtr EphemeralServer }

instance ManagedRustValue EphemeralServer where
  type RustRef EphemeralServer = Ptr EphemeralServer
  type HaskellRep EphemeralServer = EphemeralServer
  fromRust _ ptr = 
    EphemeralServer <$> newForeignPtr raw_shutdownEphemeralServer ptr

foreign import ccall "hs_temporal_start_dev_server" raw_startDevServer 
  :: Ptr Runtime
  -> CString 
  -> TokioCall (CArray Word8) EphemeralServer

startDevServer :: Runtime -> TemporalDevServerConfig -> IO (Either ByteString EphemeralServer)
startDevServer r c = withRuntime r $ \rp -> useAsCString (BL.toStrict (encode c )) $ \cstr -> do
  makeTokioAsyncCall 
    (raw_startDevServer rp cstr)
    (fromRust (Proxy @(CArray Word8)))
    (fromRust (Proxy @EphemeralServer))

foreign import ccall "&hs_temporal_shutdown_ephemeral_server" raw_shutdownEphemeralServer :: FunPtr (Ptr EphemeralServer -> IO ())

shutdownEphemeralServer :: EphemeralServer -> IO ()
shutdownEphemeralServer (EphemeralServer e) = finalizeForeignPtr e

-- TODO
-- startDevServerWithOutput

data TestServerConfig = TestServerConfig
  { serverConfig :: EphemeralExe
  , port :: Maybe Word16
  , extraArgs :: [String]
  }

deriveToJSON (defaultOptions {fieldLabelModifier = camelTo2 '_'}) ''TestServerConfig

foreign import ccall "hs_temporal_start_test_server" raw_startTestServer :: CString -> IO (Ptr EphemeralServer)

startTestServer :: TestServerConfig -> IO EphemeralServer
startTestServer = undefined
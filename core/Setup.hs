{-# LANGUAGE CPP #-}

import Control.Monad (when)
import Data.Maybe (fromMaybe)
import Distribution.PackageDescription
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo (
  InstallDirs (libdir),
  LocalBuildInfo (configFlags, localPkgDescr),
  absoluteInstallDirs,
  buildDir,
 )
import Distribution.Simple.Program.Find (
  defaultProgramSearchPath,
  findProgramOnSearchPath,
 )
import Distribution.Simple.Setup
import Distribution.Simple.Utils (
  IODataMode (IODataModeBinary),
  info,
  installExecutableFile,
  maybeExit,
  notice,
  rawSystemStdInOut,
 )
import Distribution.System (OS (..), buildOS)
import Distribution.Verbosity (Verbosity)
import qualified Distribution.Verbosity as Verbosity
import System.Directory (doesFileExist, getCurrentDirectory, getModificationTime)
import System.FilePath ((</>))

#if MIN_VERSION_Cabal(3,14,0)
import Distribution.Utils.Path (coerceSymbolicPath, getSymbolicPath)
#else
getSymbolicPath :: a -> a
getSymbolicPath = id
#endif


--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

libraryName :: String
libraryName = "temporal_bridge"


rsFolder :: FilePath
rsFolder = "rust"


externalLibFlag :: FlagName
externalLibFlag = mkFlagName "external_lib"


staticLibExt :: String
staticLibExt = "a"


sharedLibExt :: String
sharedLibExt = case buildOS of
  Windows -> "dll"
  OSX -> "dylib"
  _ -> "so"


libFileName :: String -> String
libFileName ext = "lib" ++ libraryName ++ "." ++ ext


rustLibPath :: String -> FilePath
rustLibPath ext = rsFolder </> "target" </> "release" </> libFileName ext


-- Keep in sync with extra-source-files in package.yaml.
rustSources :: [FilePath]
rustSources =
  [ rsFolder </> "Cargo.toml"
  , rsFolder </> "Cargo.lock"
  , rsFolder </> "src" </> "lib.rs"
  , rsFolder </> "src" </> "client.rs"
  , rsFolder </> "src" </> "ephemeral_server.rs"
  , rsFolder </> "src" </> "rpc.rs"
  , rsFolder </> "src" </> "runtime.rs"
  , rsFolder </> "src" </> "worker.rs"
  ]


--------------------------------------------------------------------------------
-- Hooks
--------------------------------------------------------------------------------

main :: IO ()
main = defaultMainWithHooks hooks
  where
    hooks =
      simpleUserHooks
        { preConf = \_ flags -> do
            withInternalLib flags $
              rsBuild (fromFlag $ configVerbosity flags)
            pure emptyHookedBuildInfo
        , confHook = \a flags -> do
            lbi <- confHook simpleUserHooks a flags >>= rsAddLibraryInfo flags
            withInternalLib flags $
              copyStaticLibToBuildDir lbi
            pure lbi
        , buildHook = \pkgDescr lbi userHooks flags -> do
            withInternalLibLBI lbi $ do
              let verb = fromFlag $ buildVerbosity flags
              changed <- rsBuildIfStale verb
              when changed $
                copyStaticLibToBuildDir lbi
            buildHook simpleUserHooks pkgDescr lbi userHooks flags
        , postClean = \_ flags _ _ ->
            rsClean (fromFlag $ cleanVerbosity flags)
        , postCopy = installTemporalBridge
        }


--------------------------------------------------------------------------------
-- Flag helpers
--------------------------------------------------------------------------------

hasFlag :: FlagName -> ConfigFlags -> Bool
hasFlag name = fromMaybe False . lookupFlagAssignment name . configConfigurationsFlags


withInternalLib :: ConfigFlags -> IO () -> IO ()
withInternalLib flags action
  | hasFlag externalLibFlag flags = pure ()
  | otherwise = action


withInternalLibLBI :: LocalBuildInfo -> IO () -> IO ()
withInternalLibLBI = withInternalLib . configFlags


--------------------------------------------------------------------------------
-- Cargo interaction
--------------------------------------------------------------------------------

execCargo :: Verbosity -> String -> [String] -> IO ()
execCargo verbosity command args = do
  cargoPath <- findProgramOnSearchPath Verbosity.silent defaultProgramSearchPath "cargo"
  dir <- getCurrentDirectory
  let cargoExec = maybe "cargo" fst cargoPath
      workingDir = Just (dir </> rsFolder)
      thirdOf3 (_, _, c) = c
  maybeExit . fmap thirdOf3 $
    rawSystemStdInOut verbosity cargoExec (command : args) workingDir Nothing Nothing IODataModeBinary


rsBuild :: Verbosity -> IO ()
rsBuild verb = execCargo verb "build" ["--release", "--lib"]


rsClean :: Verbosity -> IO ()
rsClean verb = execCargo verb "clean" []


-- | Run @cargo build@ only when tracked Rust sources are newer than the
-- compiled static library. Returns 'True' if a build was triggered.
rsBuildIfStale :: Verbosity -> IO Bool
rsBuildIfStale verb = do
  stale <- isRustOutputStale
  if stale
    then do
      notice verb "Rust sources changed, rebuilding temporal_bridge..."
      rsBuild verb
      pure True
    else do
      info verb "Rust library up to date, skipping cargo build"
      pure False


-- | 'True' when any tracked source is newer than the static library output,
-- or the output does not yet exist.
isRustOutputStale :: IO Bool
isRustOutputStale = do
  let outputPath = rustLibPath staticLibExt
  outputExists <- doesFileExist outputPath
  if not outputExists
    then pure True
    else do
      outputTime <- getModificationTime outputPath
      anySourceNewer outputTime rustSources
  where
    anySourceNewer _ [] = pure False
    anySourceNewer ref (src : rest) = do
      exists <- doesFileExist src
      if not exists
        then anySourceNewer ref rest
        else do
          srcTime <- getModificationTime src
          if srcTime > ref
            then pure True
            else anySourceNewer ref rest


--------------------------------------------------------------------------------
-- Library path configuration
--------------------------------------------------------------------------------

rsAddLibraryInfo :: ConfigFlags -> LocalBuildInfo -> IO LocalBuildInfo
rsAddLibraryInfo flags lbi = do
#if MIN_VERSION_Cabal(3,14,0)
  let dir = coerceSymbolicPath $ buildDir lbi
#else
  cwd <- getCurrentDirectory
  let dir = cwd </> buildDir lbi
#endif
  let updatePd pd = pd {library = fmap updateLib (library pd)}
      updateLib lib = lib {libBuildInfo = updateBi (libBuildInfo lib)}
      updateBi bi = bi {extraLibDirs = dir : extraLibDirs bi}
  pure $
    if hasFlag externalLibFlag flags
      then lbi
      else lbi {localPkgDescr = updatePd (localPkgDescr lbi)}


--------------------------------------------------------------------------------
-- Library copying & installation
--------------------------------------------------------------------------------

copyStaticLibToBuildDir :: LocalBuildInfo -> IO ()
copyStaticLibToBuildDir lbi =
  installExecutableFile verb src dest
  where
    verb = fromFlag $ configVerbosity $ configFlags lbi
    src = rustLibPath staticLibExt
    dest = getSymbolicPath (buildDir lbi) </> libFileName staticLibExt


installTemporalBridge :: Args -> CopyFlags -> PackageDescription -> LocalBuildInfo -> IO ()
installTemporalBridge _ flags pkgDescr lbi =
  withInternalLibLBI lbi $ do
    let verb = fromFlag $ configVerbosity $ configFlags lbi
        libPref =
          libdir
            . absoluteInstallDirs pkgDescr lbi
            . fromFlag
            . copyDest
            $ flags
    installExecutableFile verb (rustLibPath staticLibExt) (libPref </> libFileName staticLibExt)
    installExecutableFile verb (rustLibPath sharedLibExt) (libPref </> libFileName sharedLibExt)

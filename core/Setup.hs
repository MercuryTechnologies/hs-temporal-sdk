import Control.Monad
import Data.Char (toLower)
import Data.Functor (($>))
import Data.Maybe (fromMaybe)
import Distribution.PackageDescription
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo (
  InstallDirs (..),
  LocalBuildInfo (..),
  absoluteInstallDirs,
  buildDir,
  localPkgDescr,
 )
import Distribution.Simple.Program.Find (
  defaultProgramSearchPath,
  findProgramOnSearchPath,
 )
import Distribution.Simple.Setup
import Distribution.Simple.Utils (
  IODataMode (IODataModeBinary),
  installExecutableFile,
  maybeExit,
  rawSystemStdInOut,
 )
import Distribution.System
import Distribution.Utils.Path (coerceSymbolicPath, getSymbolicPath, (</>))
import Distribution.Verbosity (Verbosity)
import qualified Distribution.Verbosity as Verbosity
import System.Directory (
  getCurrentDirectory,
 )
import System.Environment (getEnv)
import System.Posix.Files (createSymbolicLink)


main :: IO ()
main = defaultMainWithHooks hooks
  where
    hooks =
      simpleUserHooks
        { preConf = \_ flags -> do
            unlessFlagM externalLibFlag flags $ rsMake (fromFlag $ configVerbosity flags)
            pure emptyHookedBuildInfo
        , confHook = \a flags -> do
            lbi <- confHook simpleUserHooks a flags >>= rsAddLibraryInfo flags
            unless (cabalFlag externalLibFlag flags) $ do
              copyTemporalBridge lbi (getSymbolicPath (buildDir lbi))
            pure lbi
        , postClean = \_ flags _ _ ->
            rsClean (fromFlag $ cleanVerbosity flags)
        , postCopy =
            installTemporalBridge
        }


rsFolder :: FilePath
rsFolder = "rust"


externalLibFlagStr :: String
externalLibFlagStr = "external_lib"


externalLibFlag :: FlagName
externalLibFlag = mkFlagName externalLibFlagStr


execCargo :: Verbosity -> String -> [String] -> IO ()
execCargo verbosity command args = do
  cargoPath <- findProgramOnSearchPath Verbosity.silent defaultProgramSearchPath "cargo"
  dir <- getCurrentDirectory
  let cargoExec = case cargoPath of
        Just (p, _) -> p
        Nothing -> "cargo"
      cargoArgs = command : args
      workingDir = Just (dir </> rsFolder)
      thirdComponent (_, _, c) = c
  maybeExit . fmap thirdComponent $ rawSystemStdInOut verbosity cargoExec cargoArgs workingDir Nothing Nothing IODataModeBinary


rsMake :: Verbosity -> IO ()
rsMake verbosity = execCargo verbosity "build" ["--release", "--lib"]


rsAddLibraryInfo :: ConfigFlags -> LocalBuildInfo -> IO LocalBuildInfo
rsAddLibraryInfo fl lbi' = do
  dir <- getCurrentDirectory
  let external = getCabalFlag externalLibFlagStr fl
  let updateLbi lbi =
        lbi
          { localPkgDescr = updatePkgDescr (localPkgDescr lbi)
          }
      updatePkgDescr pkgDescr =
        pkgDescr
          { library = updateLib <$> library pkgDescr
          }
      updateLib lib =
        lib
          { libBuildInfo = updateLibBi (libBuildInfo lib)
          }
      updateLibBi libBuild =
        libBuild
          { extraLibs = "temporal_bridge" : extraLibs libBuild
          , extraLibDirs =
              if external
                then extraLibDirs libBuild
                else (coerceSymbolicPath (buildDir lbi')) : extraLibDirs libBuild
          }
  pure $ updateLbi lbi'


rsClean :: Verbosity -> IO ()
rsClean verbosity = execCargo verbosity "clean" []


cabalFlag :: FlagName -> ConfigFlags -> Bool
cabalFlag name = fromMaybe False . lookupFlagAssignment name . configConfigurationsFlags


unlessFlagM :: FlagName -> ConfigFlags -> IO () -> IO ()
unlessFlagM name flags action
  | cabalFlag name flags = do
      putStrLn "Skipping cargo action because external_lib flag is set"
      pure ()
  | otherwise = do
      putStrLn ("Running cargo action because we don't have the flag: " ++ show name)
      action


copyLib :: ConfigFlags -> FilePath -> Bool -> IO ()
copyLib fl libPref shared = do
  libraryPath <- getLibraryPath
  installExecutableFile
    verb
    libraryPath
    (libPref ++ "/libtemporal_bridge." ++ ext)
  where
    verb = fromFlag $ configVerbosity fl
    external = getCabalFlag externalLibFlagStr fl
    ext =
      if shared
        then case buildOS of
          Windows -> "dll"
          OSX -> "dylib"
          _ -> "so"
        else "a"
    getLibraryPath =
      pure ("rust/target/release/libtemporal_bridge." ++ ext)


copyTemporalBridge :: LocalBuildInfo -> FilePath -> IO ()
copyTemporalBridge lbi fp = do
  copyLib config fp False
  where
    config = configFlags lbi


installTemporalBridge :: Args -> CopyFlags -> PackageDescription -> LocalBuildInfo -> IO ()
installTemporalBridge _ flags pkg_descr lbi = do
  let
    libPref =
      libdir
        . absoluteInstallDirs pkg_descr lbi
        . fromFlag
        . copyDest
        $ flags
    config = configFlags lbi

  unless (cabalFlag externalLibFlag $ configFlags lbi) $ do
    copyLib config libPref True
    copyLib config libPref False


getCabalFlag :: String -> ConfigFlags -> Bool
getCabalFlag name flags = fromMaybe False (lookupFlagAssignment (mkFlagName name') allFlags)
  where
    allFlags = configConfigurationsFlags flags
    name' = map toLower name

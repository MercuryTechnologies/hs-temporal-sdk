import Data.Functor (($>))
import Data.Maybe (fromMaybe)
import Distribution.PackageDescription
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo (
    LocalBuildInfo (..),
    localPkgDescr,
 )
import Distribution.Simple.Program.Find (
    defaultProgramSearchPath,
    findProgramOnSearchPath,
 )
import Distribution.Simple.Setup
import Distribution.Simple.Utils (
    IODataMode (IODataModeBinary),
    maybeExit,
    rawSystemStdInOut,
 )
import Distribution.Verbosity (Verbosity)
import qualified Distribution.Verbosity as Verbosity
import System.Directory (
    getCurrentDirectory,
 )
import System.FilePath ((</>))

main :: IO ()
main = defaultMainWithHooks hooks
  where
    hooks =
        simpleUserHooks
            { preConf = \_ flags -> do
                unlessFlagM externalLibFlag flags $ rsMake (fromFlag $ configVerbosity flags)
                pure emptyHookedBuildInfo
            , confHook = \a flags ->
                confHook simpleUserHooks a flags
                    >>= applyUnlessM externalLibFlag flags rsAddDirs
            , postClean = \_ flags _ _ ->
                rsClean (fromFlag $ cleanVerbosity flags)
            }

rsFolder :: FilePath
rsFolder = "rust"

externalLibFlag :: FlagName
externalLibFlag = mkFlagName "external_lib"

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

rsAddDirs :: LocalBuildInfo -> IO LocalBuildInfo
rsAddDirs lbi' = do
    dir <- getCurrentDirectory
    let rustIncludeDir = dir </> rsFolder
        rustLibDir = dir </> rsFolder </> "target/release"
        updateLbi lbi = lbi{localPkgDescr = updatePkgDescr (localPkgDescr lbi)}
        updatePkgDescr pkgDescr = pkgDescr{library = updateLib <$> library pkgDescr}
        updateLib lib = lib{libBuildInfo = updateLibBi (libBuildInfo lib)}
        updateLibBi libBuild =
            libBuild
                { includeDirs = rustIncludeDir : includeDirs libBuild
                , extraLibDirs = rustLibDir : extraLibDirs libBuild
                }
    pure $ updateLbi lbi'

rsClean :: Verbosity -> IO ()
rsClean verbosity = execCargo verbosity "clean" []

cabalFlag :: FlagName -> ConfigFlags -> Bool
cabalFlag name = fromMaybe False . lookupFlagAssignment name . configConfigurationsFlags

unlessFlagM :: FlagName -> ConfigFlags -> IO () -> IO ()
unlessFlagM name flags action
    | cabalFlag name flags = pure ()
    | otherwise = action

applyUnlessM :: FlagName -> ConfigFlags -> (a -> IO a) -> a -> IO a
applyUnlessM name flags apply a
    | cabalFlag name flags = pure a
    | otherwise = apply a

module Main where

import Control.Exception (SomeException, catch)
import Data.List (sortBy)
import Data.Maybe (catMaybes)
import Data.Ord (comparing)
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, hSetEncoding, stderr, stdout, utf8)
import Text.Printf (printf)
import Trace.Hpc.Mix (BoxLabel (..), Mix (..), readMix)
import Trace.Hpc.Tix (Tix (..), TixModule (..), readTix)


-- | Coverage statistics broken down by category
data CoverageStats = CoverageStats
  { topLevelDefs :: (Int, Int)
  -- ^ (covered, total) top-level definitions
  , localDefs :: (Int, Int)
  -- ^ (covered, total) local definitions
  , expressions :: (Int, Int)
  -- ^ (covered, total) expressions
  , alternatives :: (Int, Int)
  -- ^ (covered, total) alternatives
  , otherTicks :: (Int, Int)
  -- ^ (covered, total) other ticks
  }
  deriving (Show)


-- | Coverage information for a module
data ModuleCoverage = ModuleCoverage
  { moduleName :: String
  , stats :: CoverageStats
  }
  deriving (Show)


-- | Empty coverage stats
emptyCoverageStats :: CoverageStats
emptyCoverageStats = CoverageStats (0, 0) (0, 0) (0, 0) (0, 0) (0, 0)


-- | Add a tick to coverage stats based on its box label
addTick :: BoxLabel -> Bool -> CoverageStats -> CoverageStats
addTick label covered stats =
  let inc (c, t) = if covered then (c + 1, t + 1) else (c, t + 1)
  in case label of
      TopLevelBox {} -> stats {topLevelDefs = inc (topLevelDefs stats)}
      LocalBox {} -> stats {localDefs = inc (localDefs stats)}
      ExpBox {} -> stats {expressions = inc (expressions stats)}
      BinBox _ True -> stats {alternatives = inc (alternatives stats)}
      _ -> stats {otherTicks = inc (otherTicks stats)}


-- | Calculate total coverage stats
totalStats :: CoverageStats -> (Int, Int)
totalStats (CoverageStats tld ld exps alt oth) =
  let (c1, t1) = tld
      (c2, t2) = ld
      (c3, t3) = exps
      (c4, t4) = alt
      (c5, t5) = oth
  in (c1 + c2 + c3 + c4 + c5, t1 + t2 + t3 + t4 + t5)


-- | Calculate percentage
percentage :: Int -> Int -> Double
percentage covered total
  | total == 0 = 0
  | otherwise = (fromIntegral covered / fromIntegral total) * 100


-- | Calculate module coverage with detailed breakdown
calculateModuleCoverage :: FilePath -> TixModule -> IO (Maybe ModuleCoverage)
calculateModuleCoverage hpcDir (TixModule name _hash _count ticks) = do
  -- Try to read the mix file - readMix returns IO Mix and throws on error
  result <- catch (Just <$> readMix [hpcDir] (Left name)) (\(_e :: SomeException) -> return Nothing)
  case result of
    Nothing -> do
      -- If we can't read mix file, skip this module
      return Nothing
    Just (Mix _filepath _timestamp _hash _tabstop boxes) -> do
      -- Combine ticks with box labels
      let ticksWithLabels = zip (map snd boxes) ticks
          stats = foldr (\(label, tick) acc -> addTick label (tick > 0) acc) emptyCoverageStats ticksWithLabels
      return $ Just $ ModuleCoverage name stats


-- | Format coverage percentage with color emoji
formatCoverage :: Double -> String
formatCoverage pct
  | pct >= 80 = printf "🟢 %.1f%%" pct
  | pct >= 60 = printf "🟡 %.1f%%" pct
  | pct >= 40 = printf "🟠 %.1f%%" pct
  | otherwise = printf "🔴 %.1f%%" pct


-- | Format a stat pair as "covered/total (percent%)"
formatStat :: (Int, Int) -> String
formatStat (0, 0) = "N/A"
formatStat (covered, total) =
  let pct = percentage covered total
  in printf "%d/%d" covered total ++ " " ++ formatCoverage pct


-- | Generate markdown report from coverage data
generateMarkdown :: [ModuleCoverage] -> String
generateMarkdown modules =
  let
    -- Calculate overall stats
    allStats = map stats modules
    overallStats =
      foldr
        ( \s acc ->
            CoverageStats
              { topLevelDefs = add (topLevelDefs s) (topLevelDefs acc)
              , localDefs = add (localDefs s) (localDefs acc)
              , expressions = add (expressions s) (expressions acc)
              , alternatives = add (alternatives s) (alternatives acc)
              , otherTicks = add (otherTicks s) (otherTicks acc)
              }
        )
        emptyCoverageStats
        allStats
      where
        add (c1, t1) (c2, t2) = (c1 + c2, t1 + t2)

    (overallCovered, overallTotal) = totalStats overallStats
    overallPercent = percentage overallCovered overallTotal

    -- Sort by total coverage percentage (lowest first), but put N/A (0/0) at the end
    sortKey m =
      let (c, t) = totalStats (stats m)
      in if t == 0 then 200.0 else percentage c t -- 200% ensures N/A modules sort to end
    sortedModules = sortBy (comparing sortKey) modules

    header =
      [ "## 📊 Code Coverage Report"
      , ""
      , printf "**Overall Coverage:** %s" (formatCoverage overallPercent)
      , printf "- **%d** / **%d** expressions covered" overallCovered overallTotal
      , ""
      , "### Overall Summary"
      , ""
      , "| Category | Coverage |"
      , "|----------|----------|"
      , printf "| Top-level definitions | %s |" (formatStat (topLevelDefs overallStats))
      , printf "| Alternatives | %s |" (formatStat (alternatives overallStats))
      , printf "| Expressions | %s |" (formatStat (expressions overallStats))
      , printf "| Local definitions | %s |" (formatStat (localDefs overallStats))
      , if snd (otherTicks overallStats) > 0
          then printf "| Other | %s |" (formatStat (otherTicks overallStats))
          else ""
      , ""
      , "### Coverage by Module"
      , ""
      , "| Module | Coverage | Top-level | Alternatives | Expressions | Local |"
      , "|--------|----------|-----------|--------------|-------------|-------|"
      ]

    moduleRows =
      [ let s = stats m
            (c, t) = totalStats s
            overallDisplay = if t == 0 then "N/A" else formatCoverage (percentage c t)
        in printf
            "| `%s` | %s | %s | %s | %s | %s |"
            (moduleName m)
            overallDisplay
            (formatStat (topLevelDefs s))
            (formatStat (alternatives s))
            (formatStat (expressions s))
            (formatStat (localDefs s))
      | m <- sortedModules
      ]

    footer =
      [ ""
      , "---"
      , ""
      , "🟢 ≥80%  🟡 ≥60%  🟠 ≥40%  🔴 <40%"
      ]
  in
    unlines (filter (not . null) $ header ++ moduleRows ++ footer)


main :: IO ()
main = do
  -- Set stdout encoding to UTF-8 to support emoji characters
  hSetEncoding stdout utf8

  args <- getArgs
  case args of
    ["--hpcdir", hpcDir, tixFile] -> do
      -- Read the .tix file
      maybeTix <- readTix tixFile
      case maybeTix of
        Nothing -> do
          hPutStrLn stderr $ "Error: Could not read .tix file: " ++ tixFile
          exitFailure
        Just (Tix tixModules) -> do
          -- Calculate coverage for each module with mix file data
          coverages <- mapM (calculateModuleCoverage hpcDir) tixModules
          let validCoverages = catMaybes coverages

          if null validCoverages
            then do
              hPutStrLn stderr "Warning: No valid coverage data found"
              hPutStrLn stderr $ "  .tix file: " ++ tixFile
              hPutStrLn stderr $ "  .mix dir: " ++ hpcDir
              exitFailure
            else do
              -- Generate and print markdown
              putStr $ generateMarkdown validCoverages
    _ -> do
      progName <- getProgName
      hPutStrLn stderr $ "Usage: " ++ progName ++ " --hpcdir <dir> <file.tix>"
      hPutStrLn stderr ""
      hPutStrLn stderr "Converts a Haskell HPC .tix file to a markdown coverage report with detailed breakdown."
      hPutStrLn stderr ""
      hPutStrLn stderr "Arguments:"
      hPutStrLn stderr "  --hpcdir <dir>  Directory containing .mix files"
      hPutStrLn stderr "  <file.tix>      The .tix file to process"
      exitFailure

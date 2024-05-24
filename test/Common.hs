module Common where

import qualified Data.Map.Strict as M
import System.IO.Unsafe
import Temporal.Runtime


globalRuntime :: Runtime
globalRuntime = unsafePerformIO $ initializeRuntime NoTelemetry


{- $ OtelTelemetryOptions
  { url = "https://api.honeycomb.io"
  , headers = M.fromList
    [ ("x-honeycomb-team", "FIXME")
    , ("x-honeycomb-dataset", "temporal-sdk-tests-metrics")
    ]
  , metricPeriodicity = Nothing
  , globalTags = M.empty
  }
-}


{-# NOINLINE globalRuntime #-}

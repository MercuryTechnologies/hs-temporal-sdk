{- | This module uses Template Haskell and the GHC compiler plugin
to generate the registry of local workflows and activities. This
helps ensure that the registry is always up to date with the exported
functions in the codebase.
-}
module Temporal.Discover where

import Language.Haskell.TH

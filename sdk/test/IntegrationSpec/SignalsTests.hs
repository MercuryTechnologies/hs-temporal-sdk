module IntegrationSpec.SignalsTests (spec) where

import IntegrationSpec.Utils
import Test.Hspec


-- | Signals tests (all currently pending implementation)
spec :: SpecWith TestEnv
spec = describe "Signals" $ do
  specify "send" $ const pending
  specify "interrupt" $ const pending
  specify "fail" $ const pending
  specify "async fail signal?" $ const pending
  specify "always delivered" $ const pending

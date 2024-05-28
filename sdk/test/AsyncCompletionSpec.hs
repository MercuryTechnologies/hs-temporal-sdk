module AsyncCompletionSpec where

import Test.Hspec


spec :: Spec
spec = do
  specify "Activity can complete asynchronously" pending
  specify "Activity can complete asynchronously by ID" pending
  specify "Non existing activity async completion throws meaningful message" pending
  specify "Non existing activity async completion by ID throws meaningful message" pending
  specify "Activity can fail asynchronously" pending
  specify "Activity can fail asynchronously by ID" pending
  specify "Non existing activity async failure throws meaningful message" pending
  specify "Non existing activity async failure by ID throws meaningful message" pending
  specify "Non existing activity async cancellation throws meaningful message" pending
  specify "Non existing activity async cancellation by ID throws meaningful message" pending
  specify "Activity can heartbeat and get cancelled with AsyncCompletionClient" pending
  specify "Activity can heartbeat and get cancelled by ID with AsyncCompletionClient" pending
  specify "Non existing activity async heartbeat throws meaningful message" pending
  specify "Non existing activity async heartbeat by ID throws meaningful message" pending

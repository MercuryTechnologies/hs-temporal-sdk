{ haskell, ... }:
hfinal: hprev:
let
  inherit (haskell.lib.compose) markUnbroken packageSourceOverrides;
in
{
  if-instance = markUnbroken hprev.if-instance;
  hs-opentelemetry-propagator-datadog = markUnbroken hprev.hs-opentelemetry-propagator-datadog;
}
// (packageSourceOverrides {
  # any package version pins reflected in 'all-cabal-hashes' should go here.
} hfinal hprev)

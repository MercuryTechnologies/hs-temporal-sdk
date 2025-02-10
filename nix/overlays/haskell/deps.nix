{
  haskell,
  ...
}:
hfinal: hprev:
let
  inherit (haskell.lib.compose) markUnbroken;
in
{
  hs-opentelemetry-propagator-datadog = markUnbroken hprev.hs-opentelemetry-propagator-datadog;
}

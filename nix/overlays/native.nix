final: prev:
let
  temporalBridgeDrvs = final.callPackage ../packages/temporal-bridge.nix { };
in
{
  temporal-test-server = final.callPackage ../packages/temporal-test-server { };
  inherit (temporalBridgeDrvs) temporal_bridge temporal-sdk-core-src;
}

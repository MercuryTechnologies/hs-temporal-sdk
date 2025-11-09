{
  lib,
  haskell,
  ...
}: _hfinal: hprev: let
  inherit (haskell.lib.compose) doCoverage;
  # Disable haddock documentation
  disableHaddock = drv: drv.overrideAttrs (_: {doHaddock = false;});
  # Apply coverage and disable haddocks
  coverageNoHaddock = drv: disableHaddock (doCoverage drv);
in {
  # Only enable coverage for temporal-sdk (the main SDK package)
  # Disable haddocks for all packages to speed up builds
  temporal-api-protos = disableHaddock hprev.temporal-api-protos;
  temporal-sdk-core = disableHaddock hprev.temporal-sdk-core;
  temporal-sdk = coverageNoHaddock hprev.temporal-sdk;
  temporal-sdk-codec-server = disableHaddock hprev.temporal-sdk-codec-server;
  temporal-codec-encryption = disableHaddock hprev.temporal-codec-encryption;
  temporal-sdk-optimal-codec = disableHaddock hprev.temporal-sdk-optimal-codec;
}

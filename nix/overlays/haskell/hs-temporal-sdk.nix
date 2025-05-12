{
  lib,
  haskell,
  stdenv,
  darwin,
  temporal-cli,
  ...
}: hfinal: _hprev: let
  inherit (haskell.lib.compose) addTestToolDepend enableCabalFlag overrideCabal;
in {
  temporal-api-protos = hfinal.callCabal2nix "temporal-api-protos" ../../../protos {};

  temporal-sdk-core = lib.pipe (hfinal.callCabal2nix "temporal-sdk-core" ../../../core {}) [
    (enableCabalFlag "external_lib")
    (overrideCabal (_attrs: {
      libraryFrameworkDepends = lib.optionals stdenv.hostPlatform.isDarwin (
        with darwin.apple_sdk.frameworks; [
          CoreFoundation
          Security
          SystemConfiguration
        ]
      );
    }))
  ];

  temporal-sdk = lib.pipe (hfinal.callCabal2nix "temporal-sdk" ../../../sdk {}) [
    (addTestToolDepend temporal-cli)
    (
      drv:
        drv.overrideAttrs (_: {
          __darwinAllowLocalNetworking = true;
        })
    )
  ];

  temporal-sdk-codec-server =
    hfinal.callCabal2nix "temporal-sdk-codec-server" ../../../codec-server
    {};

  temporal-codec-encryption =
    hfinal.callCabal2nix "temporal-codec-encryption" ../../../codec-encryption
    {};

  temporal-sdk-optimal-codec =
    hfinal.callCabal2nix "temporal-sdk-optimal-codec" ../../../optimal-codec
    {};
}

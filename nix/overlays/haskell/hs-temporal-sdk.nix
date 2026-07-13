{
  lib,
  haskell,
  temporal-cli,
  fetchFromGitHub,
  temporal-test-server,
  ...
}:
hfinal: _hprev:
let
  inherit (haskell.lib.compose)
    addTestToolDepends
    disableOptimization
    dontCheck
    enableCabalFlag
    setBuildTarget
    ;
  wireformSrc = fetchFromGitHub {
    owner = "iand675";
    repo = "wireform-";
    rev = "a3bae259ae4e35d1940a98e86ce460b1cefbbf81";
    hash = "sha256-Qwx2MZ5r3g99piRjDFFGFS+0kqbense11rNtMs11kCE=";
  };
in
{
  wireform-core = dontCheck (hfinal.callCabal2nix "wireform-core" "${wireformSrc}/wireform-core" { });

  wireform-derive = dontCheck (
    hfinal.callCabal2nix "wireform-derive" "${wireformSrc}/wireform-derive" { }
  );

  wireform-proto = setBuildTarget "lib:wireform-proto" (
    dontCheck (hfinal.callCabal2nix "wireform-proto" "${wireformSrc}/wireform-proto" { })
  );

  temporal-api-protos = disableOptimization (
    hfinal.callCabal2nix "temporal-api-protos" ../../../protos { }
  );

  temporal-sdk-core = lib.pipe (hfinal.callCabal2nix "temporal-sdk-core" ../../../core { }) [
    (enableCabalFlag "external_lib")
  ];

  temporal-sdk = lib.pipe (hfinal.callCabal2nix "temporal-sdk" ../../../sdk { }) [
    dontCheck
    (addTestToolDepends [
      temporal-cli
      temporal-test-server
    ])
    (
      drv:
      drv.overrideAttrs (_: {
        __darwinAllowLocalNetworking = true;
      })
    )
  ];

  temporal-sdk-codec-server =
    hfinal.callCabal2nix "temporal-sdk-codec-server" ../../../codec-server
      { };

  temporal-codec-encryption =
    hfinal.callCabal2nix "temporal-codec-encryption" ../../../codec-encryption
      { };

  temporal-sdk-optimal-codec =
    hfinal.callCabal2nix "temporal-sdk-optimal-codec" ../../../optimal-codec
      { };

  temporal-protogen-wireform =
    hfinal.callCabal2nix "temporal-protogen-wireform" ../../../tools/protogen-wireform
      { };

  tix-to-markdown = hfinal.callCabal2nix "tix-to-markdown" ../../../tools/tix-to-markdown { };
}

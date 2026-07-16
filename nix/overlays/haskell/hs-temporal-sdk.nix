{
  lib,
  haskell,
  temporal-cli,
  fetchzip,
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
  wireformCoreSrc = fetchzip {
    url = "https://hackage.haskell.org/package/wireform-core-0.2.0.1/wireform-core-0.2.0.1.tar.gz";
    hash = "sha256-sGt6Pul+Z/G7mp94aZAgMBKp3e/dgUHLQg75ORB6rsI=";
  };
  wireformDeriveSrc = fetchzip {
    url = "https://hackage.haskell.org/package/wireform-derive-0.2.0.0/wireform-derive-0.2.0.0.tar.gz";
    hash = "sha256-LmrzgWl3QCpLJQH+k5J/430Z5CD3Q4Hap95Nw91OCSk=";
  };
  wireformProtoSrc = fetchzip {
    url = "https://hackage.haskell.org/package/wireform-proto-0.2.0.0/wireform-proto-0.2.0.0.tar.gz";
    hash = "sha256-kojP1AT2NLwC0cMMNRAVPaI2cxyET8NHjr+NThH9Z78=";
  };
in
{
  wireform-core = dontCheck (hfinal.callCabal2nix "wireform-core" wireformCoreSrc { });

  wireform-derive = dontCheck (
    hfinal.callCabal2nix "wireform-derive" wireformDeriveSrc { }
  );

  wireform-proto = setBuildTarget "lib:wireform-proto" (
    dontCheck (hfinal.callCabal2nix "wireform-proto" wireformProtoSrc { })
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

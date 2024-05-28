{
  pkgs,
  temporal-bridge,
}: final: _prev: let
  inherit
    (pkgs.haskell.lib.compose)
    addTestToolDepend
    enableCabalFlag
    overrideCabal
    ;

  inherit
    (pkgs)
    darwin
    lib
    stdenv
    ;
in {
  temporal-sdk-core = overrideCabal (_attrs: {
    extraLibraries = [
      temporal-bridge.lib
    ];
    libraryFrameworkDepends = lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
      CoreFoundation
      Security
      SystemConfiguration
    ]);
  }) (enableCabalFlag "external_lib" (final.callCabal2nix "temporal-sdk-core" ../core {}));
  temporal-sdk = (addTestToolDepend pkgs.temporal-cli (final.callCabal2nix "temporal-sdk" ../sdk {})).overrideAttrs (_: {
    __darwinAllowLocalNetworking = true;
  });
  temporal-sdk-codec-server = final.callCabal2nix "temporal-sdk-codec-server" ../codec-server {};
  temporal-codec-encryption = final.callCabal2nix "temporal-codec-encryption" ../codec-encryption {};
  temporal-sdk-optimal-codec = final.callCabal2nix "temporal-sdk-optimal-codec" ../optimal-codec {};
  temporal-api-protos = final.callCabal2nix "temporal-api-protos" ../protos {};

  # ghc-source-gen = final.callCabal2nix "ghc-source-gen" "${ghc-source-gen-src}" {

  # };
  # proto-lens = final.callCabal2nix "proto-lens" "${proto-lens-src}/proto-lens" {};
  # proto-lens-runtime = final.callCabal2nix "proto-lens-runtime" "${proto-lens-src}/proto-lens-runtime" {};
  # proto-lens-json = final.callCabal2nix "proto-lens-json" "${proto-lens-src}/proto-lens-json" {};
  # proto-lens-protoc = final.callCabal2nix "proto-lens-json" "${proto-lens-src}/proto-lens-protoc" {};
}

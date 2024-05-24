{
  pkgs,
  temporal-bridge,
}: final: _prev: let
  inherit
    (pkgs.haskell.lib.compose)
    enableCabalFlag
    overrideCabal
    ;

  inherit
    (pkgs)
    lib
    ;
in {
  temporal-sdk-core = overrideCabal (old: {
    postUnpack = ''
      ${old.postUnpack or ""}
      echo "Setting temporal bridge lib dir to ${temporal-bridge}/lib"
      export TEMPORAL_BRIDGE_LIB_DIR=${temporal-bridge}/lib
    '';
    extraLibraries = [
      temporal-bridge
    ];
    libraryFrameworkDepends = with pkgs.darwin.apple_sdk.frameworks; [
      CoreFoundation
      Security
      SystemConfiguration
    ];
  }) (enableCabalFlag "external_lib" (final.callCabal2nix "temporal-sdk-core" ../../core {}));
  temporal-sdk = final.callCabal2nix "temporal-sdk" ../.. {};
  temporal-sdk-codec-server = final.callCabal2nix "temporal-sdk-codec-server" ../../codec-server {};
  temporal-codec-encryption = final.callCabal2nix "temporal-codec-encryption" ../../codec-encryption {};
  temporal-sdk-optimal-codec = final.callCabal2nix "temporal-sdk-optimal-codec" ../../optimal-codec {};
  temporal-api-protos = final.callCabal2nix "temporal-api-protos" ../../protos {};

  # ghc-source-gen = final.callCabal2nix "ghc-source-gen" "${ghc-source-gen-src}" {

  # };
  # proto-lens = final.callCabal2nix "proto-lens" "${proto-lens-src}/proto-lens" {};
  # proto-lens-runtime = final.callCabal2nix "proto-lens-runtime" "${proto-lens-src}/proto-lens-runtime" {};
  # proto-lens-json = final.callCabal2nix "proto-lens-json" "${proto-lens-src}/proto-lens-json" {};
  # proto-lens-protoc = final.callCabal2nix "proto-lens-json" "${proto-lens-src}/proto-lens-protoc" {};
}

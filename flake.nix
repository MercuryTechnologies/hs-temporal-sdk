{
  description = "Example of a Rust library built and used by a Haskell package";
  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.temporal-sdk-core = {
    url = "github:temporalio/sdk-core";
    flake = false;
  };
  outputs = { self, nixpkgs, flake-utils, haskellNix, temporal-sdk-core, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        overlays = [
          haskellNix.overlay
          (final: prev: {
            hs_temporal_bridge = final.rustPlatform.buildRustPackage {
              name = "hs_temporal_bridge";
              src = ./rust;
              PROTOC = "${pkgs.protobuf}/bin/protoc";
              PROTOC_INCLUDE = "${pkgs.protobuf}/include";

              buildInputs = [
                pkgs.protobuf
              ];
              cargoLock = {
                lockFile = ./rust/Cargo.lock;
                outputHashes = {
                  "rustfsm-0.1.0" = "sha256-hGhGm+My3ghaCzEv8ehAm1Mhy1uWVu0mZhiynvFlFDc=";
                };
              };

              doCheck = false;
              # wow, this is ugly
              preBuild = ''
                mkdir -p ../cargo-vendor-dir
                ln -s ${temporal-sdk-core}/protos ../cargo-vendor-dir/protos
              '';
            };
          })
          (final: prev: {
            hs_temporal_sdk =
              final.haskell-nix.project' {
                src = ./.;
                compiler-nix-name = "ghc961";
                modules = [{
                  packages.temporal-sdk.flags.external_lib = true;
                }];
                shell.tools = {
                  cabal = { };
                };
                shell.buildInputs = with pkgs; [
                  nixpkgs-fmt
                  # Allows Cabal to build the Rust library itself when in the Devshell.
                  cargo
                ];
              };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
        flake = pkgs.hs_temporal_sdk.flake { };
      in
      flake // rec {
        packages = {
          inherit (pkgs) hs_temporal_bridge;
          hs_temporal_sdk = flake.packages."temporal-sdk:exe:hello";
        };

        # Built by `nix build .`
        defaultPackage = packages.hs_temporal_sdk;
      });

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    # This sets the flake to use the IOG nix cache.
    # Nix should ask for permission before using it,
    # but remove it here if you do not want it to.
    extra-substituters = [ "https://cache.iog.io" ];
    extra-trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
    allow-import-from-derivation = "true";
  };
}

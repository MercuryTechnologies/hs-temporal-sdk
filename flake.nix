{
  description = "Haskell bindings to the Temporal Core library as well as an SDK built on top of it.";
  inputs.haskellNix.url = "github:iand675/haskell.nix";
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
            temporal_bridge = final.rustPlatform.buildRustPackage {
              name = "temporal_bridge";
              src = ./core/rust;
              PROTOC = "${pkgs.protobuf}/bin/protoc";
              PROTOC_INCLUDE = "${pkgs.protobuf}/include";

              buildInputs = with pkgs; [
                protobuf
                pkgconfig 
                openssl 
                protobuf
              ] ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
                Security
                CoreFoundation
              ]);
              cargoLock = {
                lockFile = ./core/rust/Cargo.lock;
                outputHashes = {
                  "rustfsm-0.1.0" = "sha256-L0rCBnCfhR3D5ku1ItCzIE9nOk9wXaMcxV2I11uhrRc=";
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
          #   proto-lens-protoc = prev.proto-lens-protoc.overrideAttrs (attrs: {
          #     preBuild = ''
          #       export PATH=${pkgs.protobuf}/bin:$PATH
          #       ${attrs.preBuild or ""}
          #     '';
          #     propagatedBuildInputs = attrs.propagatedBuildInputs ++ [ pkgs.protoc ];
          #   });
          #   proto-lens-setup = prev.proto-lens-setup.overrideAttrs (attrs: {
          #     preBuild = ''
          #       export PATH=${pkgs.protobuf}/bin:$PATH
          #       ${attrs.preBuild or ""}
          #     '';
          #     propagatedBuildInputs = attrs.propagatedBuildInputs ++ [ pkgs.protoc ];
          #   });
          #   proto-lens-protobuf-types = prev.proto-lens-protobuf-types.overrideAttrs (attrs: {
          #     preBuild = ''
          #       export PATH=${pkgs.protobuf}/bin:$PATH
          #       ${attrs.preBuild or ""}
          #     '';
          #     buildInputs = attrs.propagatedBuildInputs ++ [ pkgs.protoc ];
          #   });
          # })

          
          (final: prev: let
          in {
            hs_temporal_sdk = final.haskell-nix.project' {
                src = ./.;
                # compiler-nix-name = "ghc962";
                projectFileName = "stack.yaml";
                modules = [{
                  packages = {
                    temporal-sdk.flags.external_lib = true;
                    proto-lens-setup.components.library.build-tools = [
                      pkgs.protobuf
                    ];
                    proto-lens-protobuf-types.components.library.build-tools = [
                      pkgs.protobuf
                    ];
                  };
                }];
                shell.tools = {
                  cabal = { };
                  ghcid = { };
                  haskell-language-server = { };
                };
                shell.buildInputs = with pkgs; [
                  nixpkgs-fmt
                  # Allows Cabal to build the Rust library itself when in the Devshell.
                  cargo
                  darwin.apple_sdk.frameworks.Security 
                  darwin.apple_sdk.frameworks.CoreFoundation 
                  darwin.apple_sdk.frameworks.SystemConfiguration
                  pkgconfig 
                  openssl 
                  protobuf
                ];
              };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
        flake = pkgs.hs_temporal_sdk.flake { };
      in
      flake // rec {
        packages = {
          inherit (pkgs) temporal_bridge;
          # Built by `nix build .`
          default = flake.packages."temporal-sdk:test:temporal-sdk-tests";
        };

        devShells = let 
            protogen = pkgs.writeShellScriptBin "protogen" ''
              shopt -s globstar
              ${pkgs.protobuf}/bin/protoc \
                --plugin=protoc-gen-haskell=${pkgs.haskellPackages.proto-lens-protoc}/bin/proto-lens-protoc \
                --haskell_out=./protos/src \
                --proto_path=${pkgs.protobuf}/include \
                --proto_path=${temporal-sdk-core}/protos/local \
                --proto_path=${temporal-sdk-core}/protos/api_upstream \
                --proto_path=${temporal-sdk-core}/protos/grpc \
                --proto_path=${temporal-sdk-core}/protos/testsrv_upstream \
                ${temporal-sdk-core}/protos/local/**/*.proto \
                ${temporal-sdk-core}/protos/api_upstream/**/*.proto \
                ${temporal-sdk-core}/protos/grpc/**/*.proto \
                ${temporal-sdk-core}/protos/testsrv_upstream/temporal/**/*.proto \
                ${pkgs.protobuf}/include/**/*.proto
            '';
          in flake.devShells // {
            # Used to generate the protobufs. We just need GHC stuff out of the path, or it seems to confuse proto-lens-protoc
            # Example: nix develop .\#devShells.aarch64-darwin.generator -i --command protogen
            generator = pkgs.mkShell {
              packages = [
                protogen
              ];
            };
          };
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

{
  description = "Haskell bindings to the Temporal Core library as well as an SDK built on top of it.";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.temporal-sdk-core = {
    url = "github:temporalio/sdk-core";
    flake = false;
  };
  outputs = { self, nixpkgs, flake-utils, temporal-sdk-core, ... }:
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
          (final: prev: {
            temporal_bridge = final.rustPlatform.buildRustPackage {
              name = "temporal_bridge";
              src = ./core/rust;
              PROTOC = "${pkgs.protobuf}/bin/protoc";
              PROTOC_INCLUDE = "${pkgs.protobuf}/include";

              buildInputs = with pkgs; [
                protobuf
                pkg-config
                openssl
                protobuf
              ] ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
                Security
                CoreFoundation
              ]);
              cargoLock = {
                lockFile = ./core/rust/Cargo.lock;
                outputHashes = {
                  "rustfsm-0.1.0" = "sha256-EVF+P+8zTNGsDOlBlttZme84buH+1rAHxez2qXVpXgI=";
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
          (final: prev: {
            all-cabal-hashes =
              let
                rev = "ace4a2e1b51cd80b1838d63650ee6a2a60b123d9";
                hash = "sha256-jJmh5K4MRDsKV0PfaDzRmdWkPlVpiFiaCRMOAD5YFqA=";
              in
              final.fetchurl {
                url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/${rev}.tar.gz";
                inherit hash;
              };
          })
          (final: prev: {
            haskellPackages = prev.haskellPackages.override (h: {
              overrides =
                let
                  hs-opentelemetry = final.fetchFromGitHub {
                    owner = "iand675";
                    repo = "hs-opentelemetry";
                    rev = "e07f598b6ec1e36ad2f6e597bd0bd6342c166093";
                    hash = "sha256-nDmFm9fLW6+0QMZfjmQOgge5r78LkJA4LAFrbhvJMgY=";
                  };
                  proto-lens = final.fetchFromGitHub {
                    owner = "iand675";
                    repo = "proto-lens";
                    rev = "191f384b5329f0231844ae8405695fcdc29eab44";
                    hash = "sha256-e2lSKUsitYl5RoMfn5cIkAMSMrJ64xsuXB0vWZka76Y=";
                  };
                in
                final.lib.composeExtensions
                  (h.overrides or (_: _: { }))
                  (prev.haskell.lib.compose.packageSourceOverrides {
                    temporal-api-protos = ./protos;
                    temporal-codec-encryption = ./codec-encryption;
                    temporal-sdk = ./.;
                    temporal-sdk-codec-server = ./codec-server;
                    temporal-sdk-core = ./core;
                    temporal-sdk-optimal-codec = ./optimal-codec;

                    ghc-source-gen = "0.4.4.0";
                    hs-opentelemetry-api = "${hs-opentelemetry}/api";
                    hs-opentelemetry-exporter-otlp = "${hs-opentelemetry}/exporters/otlp";
                    hs-opentelemetry-otlp = "${hs-opentelemetry}/otlp";
                    hs-opentelemetry-propagator-b3 = "${hs-opentelemetry}/propagators/b3";
                    hs-opentelemetry-propagator-w3c = "${hs-opentelemetry}/propagators/w3c";
                    hs-opentelemetry-sdk = "${hs-opentelemetry}/sdk";
                    proto-lens = "${proto-lens}/proto-lens";
                    proto-lens-json = "${proto-lens}/proto-lens-json";
                    proto-lens-protobuf-types = "${proto-lens}/proto-lens-protobuf-types";
                    proto-lens-protoc = "${proto-lens}/proto-lens-protoc";
                    proto-lens-runtime = "${proto-lens}/proto-lens-runtime";
                  });
            });
          })
          (final: prev: {
            haskellPackages = prev.haskellPackages.override (h: {
              overrides =
                final.lib.composeExtensions
                  (h.overrides or (_: _: { }))
                  (hfinal: hprev: {
                    temporal-sdk-core =
                      final.lib.pipe hprev.temporal-sdk-core [
                        (final.haskell.lib.compose.appendConfigureFlag "-fexternal_lib")
                        (drv: drv.overrideAttrs (attrs: {
                          nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [
                          ] ++ final.lib.optionals final.stdenv.isDarwin [
                            final.removeReferencesTo
                          ];
                          buildInputs = (attrs.buildInputs or [ ]) ++ [
                            final.temporal_bridge
                          ] ++ final.lib.optionals final.stdenv.isDarwin [
                            final.darwin.apple_sdk.frameworks.Security
                          ];
                          TEMPORAL_BRIDGE_LIB_DIR = "${final.temporal_bridge}/lib";
                        }))
                      ];
                  });
            });
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; };
      in
      rec {
        packages = {
          inherit (pkgs) temporal_bridge;

          inherit (pkgs.haskellPackages)
            temporal-api-protos
            temporal-codec-encryption
            temporal-sdk
            temporal-sdk-codec-server
            temporal-sdk-core
            temporal-sdk-optimal-codec;

          # Built by `nix build .`
          default = pkgs.haskellPackages.temporal-sdk;
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
          in {
            default = pkgs.mkShell {
              inputsFrom = [
                pkgs.haskellPackages.temporal-api-protos
                pkgs.haskellPackages.temporal-codec-encryption
                pkgs.haskellPackages.temporal-sdk
                pkgs.haskellPackages.temporal-sdk-codec-server
                pkgs.haskellPackages.temporal-sdk-core
                pkgs.haskellPackages.temporal-sdk-optimal-codec
              ];
              packages = with pkgs; [
                cabal-install
                ghcid
                haskell-language-server
                nixpkgs-fmt
                # Allows Cabal to build the Rust library itself when in the Devshell.
                cargo
                darwin.apple_sdk.frameworks.Security
                darwin.apple_sdk.frameworks.CoreFoundation
                pkg-config
                openssl
                protobuf
              ];
            };

            # Used to generate the protobufs. We just need GHC stuff out of the path, or it seems to confuse proto-lens-protoc
            # Example: nix develop .\#devShells.aarch64-darwin.generator -i --command protogen
            generator = pkgs.mkShell {
              packages = [
                protogen
              ];
            };
          };
      });
}

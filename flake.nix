{
  description = "Haskell bindings to the Temporal Core library as well as an SDK built on top of it.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv/v1.0.5";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    devenv,
    flake-utils,
    ...
  }: let
    inherit
      (builtins)
      attrNames
      listToAttrs
      map
      ;
    inherit (nixpkgs) lib;

    supportedSystems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    supportedGHCVersions = [
      "ghc96"
      "ghc98"
      # Currently not working.
      # "ghc910"
    ];

    ignoreGeneratedCode = attrs:
      attrs
      // {
        excludes =
          [
            "^protos/"
            "^dist-newstyle/"
            "^src/Data/EvalRecord/TH\\.hs"
          ]
          ++ attrs.excludes or [];
      };

    ignoreCrate2Nix = attrs:
      attrs
      // {
        excludes =
          [
            "^core/rust/Cargo\\.nix"
            "^core/rust/crate-hashes\\.json"
          ]
          ++ attrs.excludes or [];
      };

    ignoreConflictingFormatting = attrs:
      attrs
      // {
        excludes =
          [
            "^src/Temporal/Client/Namespace\\.hs"
            "^src/Temporal/Client/Workflow\\.hs"
            "^test/Spec\\.hs"
          ]
          ++ attrs.excludes or [];
      };

    pre-commit-hooks = {
      alejandra = ignoreCrate2Nix {
        enable = true;
      };
      shellcheck.enable = true;
      # clippy.enable = true;
      fourmolu = ignoreConflictingFormatting (ignoreGeneratedCode {
        enable = true;
      });
      hlint = ignoreGeneratedCode {
        enable = true;
      };
      deadnix = ignoreCrate2Nix {
        enable = true;
      };
      hpack.enable = true;
      end-of-file-fixer = ignoreCrate2Nix (ignoreGeneratedCode {
        enable = true;
      });
      shfmt.enable = true;
      check-shebang-scripts-are-executable.enable = true;
      check-symlinks.enable = true;
      check-merge-conflicts.enable = true;
      # Not smart enough to find the location of the Cargo.toml
      cargo-check.enable = false;
    };
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      temporal-bridge-and-friends = import ./nix/temporal-bridge.nix {
        inherit
          pkgs
          ;
      };
      temporal-bridge = temporal-bridge-and-friends.temporal-bridge;
      extendedPackageSetByGHCVersions = listToAttrs (
        map (ghcVersion: {
          name = ghcVersion;
          value = pkgs.haskell.packages.${ghcVersion}.extend (import ./nix/overlays/temporal-sdk-pkgs.nix {
            inherit
              pkgs
              temporal-bridge
              ;
          });
        })
        supportedGHCVersions
      );
      pluckLocalPackages = hpkgs: {
        inherit
          (hpkgs)
          temporal-sdk
          temporal-sdk-core
          temporal-sdk-codec-server
          temporal-codec-encryption
          temporal-sdk-optimal-codec
          temporal-api-protos
          ;
      };
      localPackageMatrix = listToAttrs (
        lib.concatMap (
          ghcVersion: let
            myLocalPackages = pluckLocalPackages extendedPackageSetByGHCVersions.${ghcVersion};
          in
            map (localPackage: {
              name = "${localPackage}-${ghcVersion}";
              value = myLocalPackages.${localPackage};
            })
            (attrNames myLocalPackages)
        )
        supportedGHCVersions
      );
      localDevPackageDeps = hsPackageSet:
        lib.concatMapAttrs (_: v:
          listToAttrs (
            map (p: {
              name = p.pname;
              value = p;
            })
            v.getBuildInputs.haskellBuildInputs
          ))
        (pluckLocalPackages hsPackageSet);
      localDevPackageDepsAsAttrSet = hsPackageSet:
        lib.filterAttrs (k: _: !builtins.hasAttr k (pluckLocalPackages hsPackageSet))
        (localDevPackageDeps hsPackageSet);

      protogen = ghcVersion: let
        inherit
          (extendedPackageSetByGHCVersions.${ghcVersion})
          proto-lens-protoc
          ;
        temporal-sdk-core = temporal-bridge-and-friends.temporal-sdk-core-src;
      in
        pkgs.writeShellScriptBin "protogen" ''
          shopt -s globstar
          ${pkgs.protobuf}/bin/protoc \
            --plugin=protoc-gen-haskell=${proto-lens-protoc}/bin/proto-lens-protoc \
            --haskell_out=./protos/src \
            --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/local \
            --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/api_upstream \
            --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/grpc \
            --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/testsrv_upstream \
            ${temporal-sdk-core}/sdk-core-protos/protos/local/**/*.proto \
            ${temporal-sdk-core}/sdk-core-protos/protos/api_upstream/**/*.proto \
            ${temporal-sdk-core}/sdk-core-protos/protos/grpc/**/*.proto \
            ${temporal-sdk-core}/sdk-core-protos/protos/testsrv_upstream/temporal/**/*.proto
        '';

      mkShellForGHC = ghcVersion: let
        myHaskellPackages = extendedPackageSetByGHCVersions.${ghcVersion};
      in
        devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            ({
              # pkgs,
              # config,
              ...
            }: {
              # There should be a way to get this from the flake in the future.
              # devenv.root = "/Users/ian/Code/mercury/hs-temporal-sdk";
              packages = with pkgs;
                [
                  (protogen ghcVersion)
                  ghciwatch
                ]
                ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
                  Security
                  CoreFoundation
                  SystemConfiguration
                ]);
              env.LIBRARY_PATH = "${temporal-bridge.lib}/lib";
              env.TEMPORAL_BRIDGE_LIB_DIR = "${temporal-bridge.lib}/lib";

              languages.haskell = {
                enable = true;
                package = myHaskellPackages.ghc.withHoogle (hpkgs:
                  [
                    hpkgs.proto-lens-protoc
                  ]
                  ++ lib.attrVals (attrNames (localDevPackageDepsAsAttrSet myHaskellPackages)) hpkgs);
              };
              languages.rust.enable = true;
              services.temporal.enable = true;

              pre-commit.hooks = pre-commit-hooks;
            })
            ({...}: {
              pre-commit.hooks = {
                crate2nix = {
                  enable = true;
                  name = "crate2nix";
                  files = "Cargo\\.(toml|lock)$";
                  language = "system";
                  pass_filenames = true;
                  entry = ''
                    cd $(dirname $1)
                    ${pkgs.crate2nix}/bin/crate2nix generate
                  '';
                };
              };
            })
          ];
        };
    in {
      debug = {
        # inherit pkgs localDevPackages localDevPackageDeps localDevPackageDepsAsAttrSet;
        inherit (temporal-bridge-and-friends) cargoNix temporal-bridge;
      };

      packages =
        {
          devenv-up = self.devShells.${system}.default.config.procfileScript;
          # temporal-bridge = temporal-bridge;
          temporal-bridge = temporal-bridge-and-friends.cargoNix.rootCrate.build;
          # temporal-bridge-better-2 = temporal-bridge-and-friends.cargoNix2.rootCrate.build;
        }
        // pluckLocalPackages extendedPackageSetByGHCVersions.ghc96
        // localPackageMatrix;

      devShells = rec {
        default = ghc96;
        ghc96 = mkShellForGHC "ghc96";
        ghc98 = mkShellForGHC "ghc98";
        # ghc910 = mkShellForGHC "ghc910";
      };

      checks = {
        pre-commit-check = devenv.inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = pre-commit-hooks;
        };
      };
    });

  #       # Used to generate the protobufs. We just need GHC stuff out of the path, or it seems to confuse proto-lens-protoc
  #       # Example: nix develop .\#devShells.aarch64-darwin.generator -i --command protogen
  #       generator = pkgs.mkShell {
  #         packages = [
  #           protogen
  #         ];
  #       };

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    # This sets the flake to use the IOG nix cache.
    # Nix should ask for permission before using it,
    # but remove it here if you do not want it to.
    extra-substituters = [
      "https://cache.iog.io"
      "https://cache.garnix.io"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    allow-import-from-derivation = "true";
  };
}

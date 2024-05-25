{
  description = "Haskell bindings to the Temporal Core library as well as an SDK built on top of it.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv/v1.0.5";
    temporal-sdk-core = {
      url = "github:temporalio/sdk-core";
      flake = false;
    };
    ghc-source-gen-src = {
      url = "github:circuithub/ghc-source-gen/7a6aac047b706508e85ba2054b5bedbecfd7eb7a";
      flake = false;
    };
    proto-lens-src = {
      url = "github:iand675/proto-lens/191f384b5329f0231844ae8405695fcdc29eab44";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    devenv,
    flake-utils,
    # ghc-source-gen-src,
    # , proto-lens-src
    temporal-sdk-core,
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
        excludes = [
          "^protos/"
          "^dist-newstyle/"
          "^src/Data/EvalRecord/TH.hs"
        ];
      };

    pre-commit-hooks = {
      alejandra.enable = true;
      shellcheck.enable = true;
      # clippy.enable = true;
      fourmolu = ignoreGeneratedCode {
        enable = true;
      };
      hlint = ignoreGeneratedCode {
        enable = true;
      };
      deadnix.enable = true;
      hpack.enable = true;
      end-of-file-fixer = ignoreGeneratedCode {
        enable = true;
      };
      shfmt.enable = true;
      check-shebang-scripts-are-executable.enable = true;
      check-symlinks.enable = true;
      check-merge-conflicts.enable = true;
      # Not smart enough to find the location of the Cargo.toml
      cargo-check.enable = false;
    };
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      overlays = [
      ];
      pkgs = import nixpkgs {inherit system overlays;};
      temporal-bridge = (import ./nix/temporal-bridge.nix {inherit pkgs temporal-sdk-core;}).temporal-bridge;
      # myHaskellPackages = pkgs.haskellPackages.extend (import ./nix/overlays/temporal-sdk-pkgs.nix {
      #   inherit
      #     pkgs
      #     # ghc-source-gen-src

      #     temporal-bridge
      #     ;
      # });
      extendedPackageSetByGHCVersions = listToAttrs (
        map (ghcVersion: {
          name = ghcVersion;
          value = pkgs.haskell.packages.${ghcVersion}.extend (import ./nix/overlays/temporal-sdk-pkgs.nix {
            inherit
              pkgs
              # ghc-source-gen-src
              
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
          temporal-sdk-core
          ;
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

              languages.haskell = {
                enable = true;
                package = myHaskellPackages.ghc.withHoogle (hpkgs:
                  [
                    # We want to use temporal-sdk-core from the flake
                    # when possible.
                    hpkgs.temporal-sdk-core
                    hpkgs.proto-lens-protoc
                  ]
                  ++ lib.attrVals (attrNames (localDevPackageDepsAsAttrSet myHaskellPackages)) hpkgs);
              };
              languages.rust.enable = true;
              services.temporal.enable = true;

              pre-commit.hooks = pre-commit-hooks;
            })
          ];
        };
    in {
      # debug = {
      #   inherit pkgs myHaskellPackages localDevPackages localDevPackageDeps localDevPackageDepsAsAttrSet;
      # };

      packages =
        {
          devenv-up = self.devShells.${system}.default.config.procfileScript;
          temporal-bridge = temporal-bridge;
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

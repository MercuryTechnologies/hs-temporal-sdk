{
  description = "Haskell bindings to the Temporal Core library as well as an SDK built on top of it.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # devenv.url = "git+file:///Users/ian/Code/devenv";
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
    ghc-source-gen-src,
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
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      overlays = [
      ];
      pkgs = import nixpkgs {inherit system overlays;};
      temporal-bridge = (import ./nix/temporal-bridge.nix {inherit pkgs temporal-sdk-core;}).temporal-bridge;
      myHaskellPackages = pkgs.haskellPackages.extend (import ./nix/overlays/temporal-sdk-pkgs.nix {
        inherit
          pkgs
          ghc-source-gen-src
          temporal-bridge
          ;
      });
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
      localDevPackages = pluckLocalPackages myHaskellPackages;
      localDevPackageDeps = lib.concatMapAttrs (_: v:
        listToAttrs (
          map (p: {
            name = p.pname;
            value = p;
          })
          v.getBuildInputs.haskellBuildInputs
        ))
      localDevPackages;
      localDevPackageDepsAsAttrSet =
        lib.filterAttrs (k: _: !builtins.hasAttr k localDevPackages)
        localDevPackageDeps;

      protogen = pkgs.writeShellScriptBin "protogen" ''
        shopt -s globstar
        ${pkgs.protobuf}/bin/protoc \
          --plugin=protoc-gen-haskell=${myHaskellPackages.proto-lens-protoc}/bin/proto-lens-protoc \
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
    in {
      debug = {
        inherit myHaskellPackages localDevPackages localDevPackageDeps localDevPackageDepsAsAttrSet;
      };

      packages = {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
        default = pkgs.buildEnv {
          name = "temporal-sdk-all-packages";
          paths = localDevPackages myHaskellPackages;
        };
        temporal-bridge = temporal-bridge;
        temporal-sdk = myHaskellPackages.temporal-sdk;
        temporal-sdk-core = myHaskellPackages.temporal-sdk-core;
        temporal-sdk-codec-server = myHaskellPackages.temporal-sdk-codec-server;
        temporal-codec-encryption = myHaskellPackages.temporal-codec-encryption;
        temporal-sdk-optimal-codec = myHaskellPackages.temporal-sdk-optimal-codec;
        temporal-api-protos = myHaskellPackages.temporal-api-protos;
      };
      devShells.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        # packages = [myHaskellPackages.temporal-sdk];
        modules = [
          ({
            # pkgs,
            # config,
            ...
          }: {
            # This is your devenv configuration
            packages = [
              protogen
            ];

            languages.haskell = {
              enable = true;
              package = myHaskellPackages.ghc.withHoogle (hpkgs:
                [
                  # We want to use temporal-sdk-core from the flake
                  # when possible.
                  # hpkgs.temporal-sdk-core
                  hpkgs.proto-lens-protoc
                ]
                ++ lib.attrVals (attrNames localDevPackageDepsAsAttrSet) hpkgs);
            };
            languages.rust.enable = true;
            services.temporal.enable = true;

            pre-commit.hooks = {
              alejandra.enable = true;
              shellcheck.enable = true;
              # clippy.enable = true;
              fourmolu = {
                enable = true;
                excludes = ["protos"];
              };
              hlint = {
                enable = true;
                excludes = ["protos"];
              };
              deadnix.enable = true;
              hpack.enable = true;
              end-of-file-fixer.enable = true;
              shfmt.enable = true;
              check-shebang-scripts-are-executable.enable = true;
              check-symlinks.enable = true;
              check-merge-conflicts.enable = true;
              cargo-check.enable = true;
            };
          })
        ];
      };
    });
  # flake // rec {
  #   packages = {
  #     # inherit (pkgs) temporal_bridge;
  #     # Built by `nix build .`
  #     # default = flake.packages.temporal-sdk;
  #   };

  #   devShells = let
  #     in flake.devShells // {
  #       # Used to generate the protobufs. We just need GHC stuff out of the path, or it seems to confuse proto-lens-protoc
  #       # Example: nix develop .\#devShells.aarch64-darwin.generator -i --command protogen
  #       generator = pkgs.mkShell {
  #         packages = [
  #           protogen
  #         ];
  #       };
  #     };
  # });

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

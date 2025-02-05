{
  description = "Haskell bindings to the Temporal Core library as well as an SDK built on top of it.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv/v1.0.5";
    fenix = {
      url = "github:nix-community/fenix";
      inputs = {nixpkgs.follows = "nixpkgs";};
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    devenv,
    flake-utils,
    ...
  }: let
    inherit (nixpkgs) lib;
    inherit
      (import ./nix/matrix.nix)
      supportedSystems
      ;
  in
    {
      lib = {
        haskellOverlay = import ./nix/overlays/temporal-sdk.nix;
      };
    }
    // flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      temporalBridgeAndFriends = import ./nix/temporal-bridge.nix {
        inherit
          pkgs
          ;
      };
      temporal-bridge = temporalBridgeAndFriends.temporal-bridge;
      haskellPackageUtils = import ./nix/haskell-packages.nix {
        inherit
          lib
          pkgs
          temporal-bridge
          ;
      };
      inherit (haskellPackageUtils) extendedPackageSetByGHCVersions;

      mkShellForGHC = ghcVersion: let
        myHaskellPackages = extendedPackageSetByGHCVersions.${ghcVersion};
      in
        devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            ({...}: {
              packages = with pkgs; [
                ghciwatch
              ];
              env.LIBRARY_PATH = "${temporal-bridge.lib}/lib";
              env.TEMPORAL_BRIDGE_LIB_DIR = "${temporal-bridge.lib}/lib";

              languages.haskell = {
                enable = true;
                package = myHaskellPackages.ghc.withHoogle (
                  hpkgs:
                    lib.attrVals (builtins.attrNames (haskellPackageUtils.localDevPackageDepsAsAttrSet myHaskellPackages)) hpkgs
                );
              };
            })
            (import ./nix/devenv/temporal-dev-server.nix)
            (import ./nix/devenv/temporal-bridge.nix {
              proto-lens-protoc = extendedPackageSetByGHCVersions.${ghcVersion}.proto-lens-protoc;
              temporal-sdk-core = temporalBridgeAndFriends.temporal-sdk-core-src;
            })
            (import ./nix/devenv/repo-wide-checks.nix)
          ];
        };
    in {
      packages =
        {
          inherit temporal-bridge;
          devenv-up = self.devShells.${system}.default.config.procfileScript;
        }
        // haskellPackageUtils.localPackageMatrix;

      devShells = rec {
        default = ghc96;
        ghc96 = mkShellForGHC "ghc96";
        ghc98 = mkShellForGHC "ghc98";
      };

      checks = {
        # pre-commit-check = devenv.inputs.pre-commit-hooks.lib.${system}.run {
        #   src = ./.;
        #   hooks = pre-commit-hooks;
        # };
      };
    });

  # --- Flake Local Nix Configuration -----------------------------------------
  nixConfig = {
    # This sets the flake to use several upstream substituters that have cached
    # artifacts for some of our dependencies.
    # 
    # Nix should ask for permission before using it, but remove it here if you
    # do not want it to.
    extra-substituters = [
      "https://cache.garnix.io"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    allow-import-from-derivation = "true";
  };
}

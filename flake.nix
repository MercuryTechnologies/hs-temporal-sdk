{
  description = "Haskell bindings to the Temporal Core library as well as an SDK built on top of it.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv/v1.0.5";
    flake-parts.url = "github:hercules-ci/flake-parts";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # TODO: add the `devenv` shell environment back.
  outputs =
    inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      imports = [ ];
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            # TODO: factor this out into a development overlay that injects
            # `temporal_bridge` & extends GHC package sets in our test matrix.
            overlays = [
              self.overlays.temporal-bridge
              (final: prev: {
                haskell = (prev.haskell or { }) // {
                  packages = (prev.haskell.packages or { }) // {
                    ghc96 = prev.haskell.packages.ghc96.extend (self.haskellOverlay final);
                    ghc98 = prev.haskell.packages.ghc98.extend (self.haskellOverlay final);
                    ghc910 = prev.haskell.packages.ghc910.extend (self.haskellOverlay final);
                  };
                };
              })
            ];
          };
          # TODO: factor this out to generate the flake package outputs we want
          # to include in our test matrix.
          packages.temporal_bridge = pkgs.temporal_bridge;
          packages.temporal-sdk-core-ghc98 = pkgs.haskell.packages.ghc98.temporal-sdk-core;
          packages.temporal-sdk-core-ghc910 = pkgs.haskell.packages.ghc910.temporal-sdk-core;
        };

      flake = {
        # TODO: factor this out into its own file so it can be consumed without
        # having to import the flake.
        overlays = {
          # top-level nixpkgs overlay providing `temporal_bridge`.
          temporal-bridge = final: _prev: {
            temporal_bridge = final.callPackage ./core/rust { };
          };
        };
        # TODO: factor this out into its own file so it can be consumed without
        # having to import the flake.
        #
        # Haskell overlay providing the non-Rust `hs-temporal-sdk` packages.
        #
        # NOTE: This can't be included in 'flake.overlays' directly, as we need
        # the top-level `pkgs` argument for `pkgs.haskell.lib` + some system
        # libraries that are outside of the Haskell package overlay.
        haskellOverlay = pkgs: hfinal: _hprev: {
          temporal-api-protos = hfinal.callCabal2nix "temporal-api-protos" ./protos { };
          temporal-sdk-core = pkgs.lib.pipe (hfinal.callCabal2nix "temporal-sdk-core" ./core { }) [
            (pkgs.haskell.lib.compose.enableCabalFlag "external_lib")
            (pkgs.haskell.lib.compose.overrideCabal (_attrs: {
              libraryFrameworkDepends = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin (
                with pkgs.darwin.apple_sdk.frameworks;
                [
                  CoreFoundation
                  Security
                  SystemConfiguration
                ]
              );
            }))
          ];
        };
      };
    };

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

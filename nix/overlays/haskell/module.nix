{ self, ... }:
{
  flake = {
    # Haskell overlays providing the non-Rust `hs-temporal-sdk` packages.
    #
    # NOTE: This can't be included in 'flake.overlays' directly, as we need the
    # top-level `pkgs` argument for `pkgs.haskell.lib` + some system libraries
    # that are outside the scope of the Haskell package set.
    haskellOverlays = {
      hs-temporal-sdk = import ./hs-temporal-sdk.nix;
      dependencies = {
        default = import ./deps.nix;
        ghc910 = import ./ghc910-deps.nix;
      };
    };

    # A top-level nixpkgs overlay that extends supported GHC package sets with
    # `hs-temporal-sdk` packages & any dependency modifications required for
    # development.
    #
    # NOTE: This should _not_ be used by downstream consumers, and is primarily
    # exposed to  support our development & CI environments.
    overlays.development = final: prev: {
      haskell = (prev.haskell or { }) // {
        packages = (prev.haskell.packages or { }) // {
          ghc96 = prev.haskell.packages.ghc96.extend (
            prev.lib.composeManyExtensions [
              (self.haskellOverlays.dependencies.default final)
              (self.haskellOverlays.hs-temporal-sdk final)
            ]
          );
          ghc98 = prev.haskell.packages.ghc98.extend (
            prev.lib.composeManyExtensions [
              (self.haskellOverlays.dependencies.default final)
              (self.haskellOverlays.hs-temporal-sdk final)
            ]
          );
          ghc910 = prev.haskell.packages.ghc910.extend (
            prev.lib.composeManyExtensions [
              (self.haskellOverlays.dependencies.default final)
              (self.haskellOverlays.dependencies.ghc910 final)
              (self.haskellOverlays.hs-temporal-sdk final)
            ]
          );
        };
      };
    };
  };
}

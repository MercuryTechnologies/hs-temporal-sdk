{
  # Haskell overlays providing the non-Rust `hs-temporal-sdk` packages.
  #
  # NOTE: This can't be included in 'flake.overlays' directly, as we need the
  # top-level `pkgs` argument for `pkgs.haskell.lib` + some system libraries
  # that are outside the scope of the Haskell package set.
  flake.haskellOverlays = {
    hs-temporal-sdk = import ./hs-temporal-sdk.nix;
    dependencies = {
      ghc910 = import ./ghc910.nix;
    };
  };
}

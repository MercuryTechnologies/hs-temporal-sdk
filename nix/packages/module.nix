{ inputs, self, ... }:
let
  mkPkgsFor = { pkgset, system }:
    import pkgset {
      inherit system;
      overlays = [
        self.overlays.temporal-bridge
        self.overlays.development
      ];
    };
in
{
  perSystem =
    { system, pkgs, ... }:
    {
      _module.args.pkgs = mkPkgsFor {
        inherit system;
        pkgset = inputs.nixpkgs;
      };
      packages = {
        # TODO: factor this out to generate the flake package outputs we want
        # to include in our test matrix.
        temporal-bridge = pkgs.temporal_bridge;
        temporal-sdk-ghc96 = pkgs.haskell.packages.ghc96.temporal-sdk;
        temporal-sdk-ghc98 = pkgs.haskell.packages.ghc98.temporal-sdk;
        temporal-sdk-ghc910 = pkgs.haskell.packages.ghc910.temporal-sdk;
      };
    };
}

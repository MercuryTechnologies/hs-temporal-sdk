{ inputs, self, ... }:
let
  mkPkgsFor = { pkgset, system }:
    import pkgset {
      inherit system;
      overlays = [
        self.overlays.temporal-bridge
        (final: prev: {
          haskell = (prev.haskell or { }) // {
            packages = (prev.haskell.packages or { }) // {
              ghc96 = prev.haskell.packages.ghc96.extend (self.haskellOverlays.hs-temporal-sdk final);
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
        })
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
        temporal_bridge = pkgs.temporal_bridge;
        temporal-sdk-ghc96 = pkgs.haskell.packages.ghc96.temporal-sdk;
        temporal-sdk-ghc98 = pkgs.haskell.packages.ghc98.temporal-sdk;
        temporal-sdk-ghc910 = pkgs.haskell.packages.ghc910.temporal-sdk;
      };
    };
}

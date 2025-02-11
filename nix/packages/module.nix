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
      # TODO: There's almost definitely a cleaner way to do this, but for now
      # it's quicker to copy the previous implementation and shim it in here.
      packages = let
        haskellUtils = (import ../utils/haskell.nix) pkgs;
      in haskellUtils.localPackageMatrix // {
        temporal-bridge = pkgs.temporal_bridge;
      };
    };
}

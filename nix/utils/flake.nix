{
  nixpkgs,
  self,
  ...
}: let
  inherit (import ./matrix.nix) systems;
in {
  forAllSystems = withPkgs:
    nixpkgs.lib.genAttrs systems (
      system:
        withPkgs {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.temporal-bridge
              self.overlays.haskell-development
            ];
          };
        }
    );
}

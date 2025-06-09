{ nixpkgs, self, ... }:

let
  forAllSystems = forTheseSystems (import ./matrix.nix).systems;
  forTheseSystems =
    systems:
    withPkgs:
    nixpkgs.lib.genAttrs systems (
      system:
      withPkgs {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.temporal-bridge
            self.overlays.temporal-test-server
            self.overlays.haskell-development
          ];
        };
      }
    );
in {
  inherit forAllSystems forTheseSystems;
}

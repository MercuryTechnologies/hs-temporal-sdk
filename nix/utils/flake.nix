{ nixpkgs, self, ... }:

let
  forAllSystems =
    withPkgs:
    nixpkgs.lib.genAttrs
      [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ]
      (
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
in {
  inherit forAllSystems;
}

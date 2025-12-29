{
  nixpkgs,
  self,
  fenix,
  ...
}:

let
  forAllSystems = forTheseSystems (import ./matrix.nix).systems;
  forTheseSystems =
    systems: withPkgs:
    nixpkgs.lib.genAttrs systems (
      system:
      withPkgs {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            fenix.overlays.default
            self.overlays.development
            self.overlays.native
            self.overlays.haskell-development
          ];
        };
      }
    );
in
{
  inherit forAllSystems forTheseSystems;
}

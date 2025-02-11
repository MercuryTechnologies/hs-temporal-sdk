{ inputs, ... }: {
  perSystem =
    { pkgs, ... }:
    let
      # TODO: There's almost definitely a cleaner way to do this, but for now
      # it's quicker to copy the previous implementation and shim it in here.
      inherit (import ../utils/matrix.nix) ghcVersions;
      haskellUtils = (import ../utils/haskell.nix) pkgs;
      mkShell = ghcVersion: inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          ./temporal-bridge.nix
          ./temporal-dev-server.nix
          ({pkgs, ...}: {
            # XXX: Do we need to pull `proto-lens-protoc` from the selected package
            # set or will any version work? If it doesn't need to be from the same
            # package set as the dev shell, then this a flake package output.
            #
            packages = [
              (pkgs.callPackage ../packages/protogen.nix {
                inherit (pkgs.haskell.packages.${ghcVersion}) proto-lens-protoc;
              })
            ];
            languages.haskell = {
              languageServer = null;
              enable = true;
              package = pkgs.haskell.packages.${ghcVersion}.ghc.withHoogle (
                hpkgs: builtins.attrValues (haskellUtils.localDevPackageDepsAttrSet hpkgs)
              );
            };
          })
        ];
      };
    in {
      devShells = rec {
        default = ghc910;
        ghc96 = mkShell "ghc96";
        ghc98 = mkShell "ghc98";
        ghc910 = mkShell "ghc910";
      };
    };
}

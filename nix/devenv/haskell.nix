ghcVersion: { pkgs, ... }:
let
  haskellUtils = import ../utils/haskell.nix pkgs;
in
{
  # XXX: Do we need to pull `proto-lens-protoc` from the
  # selected package set or will any version work?
  #
  # If it doesn't need to be from the same package set as the
  # dev shell, then this can be a flake package output.
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
}

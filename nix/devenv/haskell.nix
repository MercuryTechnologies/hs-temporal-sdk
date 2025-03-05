ghcVersion:
{ pkgs, ... }:
let
  haskellUtils = import ../utils/haskell.nix pkgs;
in
{
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

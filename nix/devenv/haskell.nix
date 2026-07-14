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
    pkgs.ghciwatch
    pkgs.haskell.packages.${ghcVersion}.eventlog2html
    pkgs.haskell.packages.${ghcVersion}.hp2pretty
  ];
  languages.haskell = {
    languageServer = pkgs.haskell.packages.${ghcVersion}.haskell-language-server;
    enable = true;
    package = pkgs.haskell.packages.${ghcVersion}.ghc.withHoogle (
      hpkgs: builtins.attrValues (haskellUtils.localDevPackageDepsAttrSet hpkgs)
    );
  };
}

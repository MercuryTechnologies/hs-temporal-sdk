{
  lib,
  pkgs,
  temporal-bridge,
  ...
}: let
  inherit
    (builtins)
    attrNames
    listToAttrs
    map
    ;
  inherit (import ./matrix.nix) supportedGHCVersions;
in rec {
  pluckLocalPackages = hpkgs: {
    inherit
      (hpkgs)
      temporal-sdk
      temporal-sdk-core
      temporal-sdk-codec-server
      temporal-codec-encryption
      temporal-sdk-optimal-codec
      temporal-api-protos
      ;
  };

  extendedPackageSetByGHCVersions = listToAttrs (
    map (ghcVersion: {
      name = ghcVersion;
      value = pkgs.haskell.packages.${ghcVersion}.extend (import ./temporal-sdk-pkgs.nix {
        inherit
          pkgs
          temporal-bridge
          ;
      });
    })
    supportedGHCVersions
  );

  localPackageMatrix = listToAttrs (
    lib.concatMap (
      ghcVersion: let
        myLocalPackages = pluckLocalPackages extendedPackageSetByGHCVersions.${ghcVersion};
      in
        map (localPackage: {
          name = "${localPackage}-${ghcVersion}";
          value = myLocalPackages.${localPackage};
        })
        (attrNames myLocalPackages)
    )
    supportedGHCVersions
  );

  localDevPackageDeps = hsPackageSet:
    lib.concatMapAttrs (_: v:
      listToAttrs (
        map (p: {
          name = p.pname;
          value = p;
        })
        v.getBuildInputs.haskellBuildInputs
      ))
    (pluckLocalPackages hsPackageSet);

  localDevPackageDepsAsAttrSet = hsPackageSet:
    lib.filterAttrs (k: _: !builtins.hasAttr k (pluckLocalPackages hsPackageSet))
    (localDevPackageDeps hsPackageSet);
}

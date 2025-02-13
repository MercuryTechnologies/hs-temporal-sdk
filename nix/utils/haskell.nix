{ lib, haskell, ... }:
let
  inherit (import ./matrix.nix) ghcVersions;
in rec {
  pluckLocalPackages = hpkgs: {
    inherit (hpkgs)
      temporal-sdk
      temporal-sdk-core
      temporal-sdk-codec-server
      temporal-codec-encryption
      temporal-sdk-optimal-codec
      temporal-api-protos
    ;
  };

  localPackageMatrix = builtins.listToAttrs (
    lib.concatMap (
      ghcVersion: let
        localPackages = pluckLocalPackages haskell.packages.${ghcVersion};
      in
        builtins.map (localPackage: {
          name = "${localPackage}-${ghcVersion}";
          value = localPackages.${localPackage};
        })
        (builtins.attrNames localPackages)
    )
    ghcVersions
  );

  localDevPackageDeps = hsPackageSet:
    lib.concatMapAttrs (_: v:
      builtins.listToAttrs (
        builtins.map (p: {
          name = p.pname;
          value = p;
        })
        v.getBuildInputs.haskellBuildInputs
      ))
    (pluckLocalPackages hsPackageSet);

  localDevPackageDepsAttrSet = hsPackageSet:
    lib.filterAttrs (k: _: !builtins.hasAttr k (pluckLocalPackages hsPackageSet))
    (localDevPackageDeps hsPackageSet);
}

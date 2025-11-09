{
  lib,
  haskell,
  buildEnv,
  ...
}: let
  inherit (import ./matrix.nix) ghcVersions;
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
      tix-to-markdown
      ;
  };

  localPackageMatrix = builtins.listToAttrs (
    lib.map (
      ghcVersion: let
        localPackages = pluckLocalPackages haskell.packages.${ghcVersion};
        name = "hs-temporal-suite-${ghcVersion}";
      in {
        inherit name;
        value = buildEnv {
          inherit name;
          paths = lib.attrValues localPackages;
        };
      }
    )
    ghcVersions
  );

  localDevPackageDeps = hsPackageSet:
    lib.concatMapAttrs (
      _: v:
        builtins.listToAttrs (
          builtins.map (p: {
            name = p.pname;
            value = p;
          })
          v.getBuildInputs.haskellBuildInputs
        )
    ) (pluckLocalPackages hsPackageSet);

  localDevPackageDepsAttrSet = hsPackageSet:
    lib.filterAttrs (k: _: !builtins.hasAttr k (pluckLocalPackages hsPackageSet)) (
      localDevPackageDeps hsPackageSet
    );
}

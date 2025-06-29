{
  stdenv,
  fetchurl,
  lib,
  autoPatchelfHook,
  fixDarwinDylibNames,
  ...
}: let
  # The 'temporal-test-server' is a component of the Java SDK, with compiled
  # artifacts distributed on each tagged release.
  hashes = import ./hashes.nix;
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "temporal-test-server";
    version = "1.30.1";
    src = fetchurl {
      inherit (hashes.${finalAttrs.version}.${stdenv.hostPlatform.system}) url hash;
    };

    nativeBuildInputs = lib.optionals stdenv.hostPlatform.isDarwin [
      fixDarwinDylibNames
    ] ++ lib.optionals stdenv.hostPlatform.isLinux [
      autoPatchelfHook
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      mv temporal-test-server $out/bin/temporal-test-server
      chmod +x $out/bin/temporal-test-server

      runHook postInstall
    '';

    meta = {
      description = "Temporal Test Workflow Server";
      homepage = "https://github.com/temporalio/sdk-java/tree/master/temporal-test-server";
      platforms = builtins.attrNames hashes.${finalAttrs.version};
    };
  })

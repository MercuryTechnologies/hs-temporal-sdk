{
  stdenv,
  fetchurl,
  lib,
  autoPatchelfHook,
  fixDarwinDylibNames,
  ...
}: let
  version = "1.32.1";
  systems = {
    "aarch64-darwin" = {
      hash = "sha256-he3VMEWRC+w1DdDZr7/8Vnl/ozgQpaB3Y/OhSo6TAKM=";
      url = "https://github.com/temporalio/sdk-java/releases/download/v${version}/temporal-test-server_${version}_macOS_arm64.tar.gz";
    };
    "x86_64-darwin" = {
      hash = "sha256-JmAciyfJg0yz/9F71jv5ASazjc8wjbzN+yZn+5Kqyvg=";
      url = "https://github.com/temporalio/sdk-java/releases/download/v${version}/temporal-test-server_${version}_macOS_amd64.tar.gz";
    };
    "aarch64-linux" = {
      hash = "sha256-2NVu905FD5zbv+ZXDjS4FnZR39/zWQ1ZJhnatEYFWxc=";
      url = "https://github.com/temporalio/sdk-java/releases/download/v${version}/temporal-test-server_${version}_linux_arm64.tar.gz";
    };
    "x86_64-linux" = {
      hash = "sha256-mH83Wo1CkKg3ipmNzPq6azGzuZrTdXryg8aVWmr9gp8=";
      url = "https://github.com/temporalio/sdk-java/releases/download/v${version}/temporal-test-server_${version}_linux_amd64.tar.gz";
    };
  };

  srcFor = system: fetchurl { inherit (systems.${system}) url hash; };
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "temporal-test-server";
    inherit version;
    src = srcFor stdenv.system;

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

    # dummy target that can be built with `nix build` to get hash mismatches
    # for all systems whenever we need to bump the version.
    passthru.sources = lib.mapAttrs (name: _: srcFor name) systems;

    meta = {
      description = "Temporal Test Workflow Server";
      homepage = "https://github.com/temporalio/sdk-java/tree/master/temporal-test-server";
      platforms = builtins.attrNames systems;
      license = lib.licenses.asl20;
    };
  })

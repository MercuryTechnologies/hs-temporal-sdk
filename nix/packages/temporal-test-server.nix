{
  stdenv,
  fetchurl,
  ...
}: let
  # The 'temporal-test-server' is a component of the Java SDK, with compiled
  # artifacts distributed on each tagged release.
  #
  # Unfortunately they only publish x86_64 artifacts at the moment, which means
  # 'aarch64-linux' is unsupported & 'aarch64-darwin' depends on Rosetta2 on
  # the host machine.
  osMap = {
    "aarch64-darwin" = "macOS";
    "x86_64-darwin" = "macOS";
    "x86_64-linux" = "linux";
  };
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "temporal-test-server";
    version = "1.29.0";
    src = fetchurl {
      url = "https://github.com/temporalio/sdk-java/releases/download/v${finalAttrs.version}/temporal-test-server_${finalAttrs.version}_${builtins.getAttr stdenv.hostPlatform.system osMap}_amd64.tar.gz";
      hash = if stdenv.hostPlatform.isDarwin then "sha256-0EO5nmotVM8RjVPjJfN3oK9pr+9e3oo23rBm65T4Cs4=" else "sha256-cE83Dp8ZFofpiDs6d7TyshUynylOYq1rsehHpw2i9Lk=";
    };

    installPhase = ''
      mkdir -p $out/bin
      mv temporal-test-server $out/bin/temporal-test-server
      chmod +x $out/bin/temporal-test-server
    '';

    meta = {
      description = "Temporal Test Workflow Server";
      homepage = "https://github.com/temporalio/sdk-java/tree/master/temporal-test-server";
      platforms = builtins.attrNames osMap;
    };
  })

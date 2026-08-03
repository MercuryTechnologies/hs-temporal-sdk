{
  stdenv,
  fetchurl,
  lib,
  autoPatchelfHook,
  fixDarwinDylibNames,
  ...
}:
let
  # Generated; run `nix run .#update-temporal-binaries -- test-server`. Do
  # not edit 'nix/sources/temporal-test-server.json' by hand.
  sources = lib.importJSON ../sources/temporal-test-server.json;
  inherit (sources) version;

  srcFor = system: fetchurl { inherit (sources.systems.${system}) url hash; };
in
stdenv.mkDerivation {
  pname = "temporal-test-server";
  inherit version;
  src = srcFor stdenv.system;

  nativeBuildInputs =
    lib.optionals stdenv.hostPlatform.isDarwin [
      fixDarwinDylibNames
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      autoPatchelfHook
    ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv temporal-test-server $out/bin/temporal-test-server
    chmod +x $out/bin/temporal-test-server

    runHook postInstall
  '';

  # Verification target: `nix build .#temporal-test-server.sources.<system>`
  # fetches and hash-checks that platform's tarball even when it's not the
  # one you're building on, since 'fetchurl' is built by the local system.
  passthru.sources = lib.mapAttrs (name: _: srcFor name) sources.systems;

  meta = {
    description = "Temporal Test Workflow Server";
    homepage = "https://github.com/temporalio/sdk-java/tree/master/temporal-test-server";
    platforms = builtins.attrNames sources.systems;
    license = lib.licenses.asl20;
  };
}

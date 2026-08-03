{
  stdenvNoCC,
  lib,
  fetchurl,
  versionCheckHook,
}:

let
  # NOTE(jkachmar): Wow I hate Go! It turns out that if any dependencies of
  # some project has a requirement on a newer Go toolchain than what you
  # provide, there's no way to patch this without forking the dependency
  # and modifying /its/ 'go.mod' file.
  #
  # In lieu of forking the 'temporal' Go package just to make a one-line edit
  # (or trying to override that and then shim it into the 'temporal-cli'
  # module derivation), just download pre-build artifacts for now.
  #
  # We can probably switch back to the source build once we update to a version
  # of nixpkgs that has Go 1.25, but the general problem is just going to show
  # up again once upstream uses a newer version of Go than we have on hand.

  # Generated; run `nix run .#update-temporal-binaries -- cli`. Do not edit
  # 'nix/sources/temporal-cli.json' by hand.
  sources = lib.importJSON ../sources/temporal-cli.json;
  inherit (sources) version;

  srcFor = system: fetchurl { inherit (sources.systems.${system}) url hash; };
in
stdenvNoCC.mkDerivation {
  pname = "temporal";
  inherit version;

  src = srcFor stdenvNoCC.system;
  sourceRoot = ".";

  doInstallCheck = true;
  doCheck = true;
  dontPatch = true;
  dontBuild = true;
  dontConfigure = true;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 temporal $out/bin/temporal
  '';

  nativeCheckInputs = [ versionCheckHook ];

  # Verification target: `nix build .#temporal-cli.sources.<system>` fetches
  # and hash-checks that platform's tarball even when it's not the one
  # you're building on, since 'fetchurl' is built by the local system.
  passthru.sources = lib.mapAttrs (name: _: srcFor name) sources.systems;

  meta = {
    description = "Command-line interface for running Temporal Server and interacting with Workflows, Activities, Namespaces, and other parts of Temporal";
    mainProgram = "temporal";
    license = lib.licenses.mit;
    platforms = builtins.attrNames sources.systems;
  };
}

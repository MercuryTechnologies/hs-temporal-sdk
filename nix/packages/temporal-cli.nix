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

  version = "1.6.1-server-1.31.0-151.0";
  systems = {
    x86_64-linux = {
      url = "https://github.com/temporalio/cli/releases/download/v${version}/temporal_cli_${version}_linux_amd64.tar.gz";
      hash = "sha256-i0pbalGnkOPsVgw0MxN09HNtvpUIEAA1/q0fytmNaiI=";
    };
    aarch64-linux = {
      url = "https://github.com/temporalio/cli/releases/download/v${version}/temporal_cli_${version}_linux_arm64.tar.gz";
      hash = "sha256-V52toYpQPqoigMZ5e/3KFJXelM8OetAvlxEiNdKExk8=";
    };
    x86_64-darwin = {
      url = "https://github.com/temporalio/cli/releases/download/v${version}/temporal_cli_${version}_darwin_amd64.tar.gz";
      hash = "sha256-29+NDhzqYW1t4wO8Rg+fp3fFO/uEEI0IoXf4iTW5x1A=";
    };
    aarch64-darwin = {
      url = "https://github.com/temporalio/cli/releases/download/v${version}/temporal_cli_${version}_darwin_arm64.tar.gz";
      hash = "sha256-OVFOjxe+x/grbgCx1O1coh1/zVfwG/AA4p9vzOy7hQ0=";
    };
  };

  srcFor =
    system:
    fetchurl {
      url = systems.${system}.url;
      hash = systems.${system}.hash;
    };
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

  passthru.sources = lib.mapAttrs (name: _: srcFor name) systems;

  meta = {
    description = "Command-line interface for running Temporal Server and interacting with Workflows, Activities, Namespaces, and other parts of Temporal";
    mainProgram = "temporal";
    license = lib.licenses.mit;
  };
}

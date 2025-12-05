{
  stdenvNoCC,
  lib,
  fetchurl,
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

  version = "1.5.1";
  systems = {
    x86_64-linux = {
      url = "https://github.com/temporalio/cli/releases/download/v1.5.1/temporal_cli_${version}_linux_amd64.tar.gz";
      hash = "sha256-3cleCLCwdu/U6pczo/SI630r6HX4g05hbNKjc1i0hS0=";
    };
    aarch64-linux = {
      url = "https://github.com/temporalio/cli/releases/download/v1.5.1/temporal_cli_${version}_linux_arm64.tar.gz";
      hash = "sha256-vRsNufGLBRAm3ov2zBUF8lEPFLu3qLmkqR//Rsd0VPU=";
    };
    x86_64-darwin = {
      url = "https://github.com/temporalio/cli/releases/download/v1.5.1/temporal_cli_${version}_darwin_amd64.tar.gz";
      hash = "sha256-u7c+KjETWr5QofHNs1AwxClh32GOjOnGCuifIBVAxdk=";
    };
    aarch64-darwin = {
      url = "https://github.com/temporalio/cli/releases/download/v1.5.1/temporal_cli_${version}_darwin_arm64.tar.gz";
      hash = "sha256-zKAbfqNa1W4qMo2a5Za/cWvSIxPvY8enYciDVEV8JBU=";
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
  dontPatch = true;
  dontBuild = true;
  dontConfigure = true;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 temporal $out/bin/temporal
  '';

  passthru.sources = lib.mapAttrs (name: _: srcFor name) systems;

  meta = {
    description = "Command-line interface for running Temporal Server and interacting with Workflows, Activities, Namespaces, and other parts of Temporal";
    mainProgram = "temporal";
    license = lib.licenses.mit;
  };
}

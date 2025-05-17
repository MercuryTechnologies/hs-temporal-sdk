{ buildGoModule, fetchFromGitHub, lib, stdenvNoCC, installShellFiles, ... }:

buildGoModule (finalAttrs: {
  pname = "tcld";
  version = "0.40.0";
  src = fetchFromGitHub {
    owner = "temporalio";
    repo = "tcld";
    rev = "refs/tags/v${finalAttrs.version}";
    hash = "sha256-bIJSvop1T3yiLs/LTgFxIMmObfkVfvvnONyY4Bsjj8g=";
  };
  vendorHash = "sha256-GOko8nboj7eN4W84dqP3yLD6jK7GA0bANV0Tj+1GpgY=";
  ldFlags = ["-s" "-w"];

  # TODO: PR upstream.
  patches = [ ./compgen.patch ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = lib.optionalString (stdenvNoCC.buildPlatform.canExecute stdenvNoCC.hostPlatform) ''
    installShellCompletion --cmd tcld --bash ${./bash_autocomplete}
    installShellCompletion --cmd tcld --zsh ${./zsh_autocomplete}
  '';


  # NOTE: Test suite appears to require some form of (local) networking, which
  # doesn't work with the Nix sandbox.
  doCheck = false;

  meta = {
    description = "todo";
    homepage = "https://www.github.com/temporalio/tcld";
    license = lib.licenses.mit;
  };
})

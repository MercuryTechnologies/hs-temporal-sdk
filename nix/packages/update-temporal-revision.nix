{pkgs}:
pkgs.writeShellApplication {
  name = "update-temporal-revision";
  runtimeInputs = with pkgs; [bash curl jq yq cargo crate2nix];
  text = builtins.readFile ../../scripts/update-temporal-revision.sh;
}

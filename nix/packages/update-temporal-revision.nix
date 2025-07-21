{pkgs}:
pkgs.writeShellApplication {
  name = "update-temporal-revision";
  runtimeInputs = with pkgs; [bash curl jq yq cargo crate2nix];
  text = builtins.readFile ../../scripts/update-temporal-revision.sh;
  # Export PROTOC environment variable
  runtimeEnv = {
    PROTOC = "${pkgs.protobuf}/bin/protoc";
  };
}

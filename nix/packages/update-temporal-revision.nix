{
  pkgs,
  rustToolchain,
}:
pkgs.writeShellApplication {
  name = "update-temporal-revision";
  runtimeInputs = with pkgs; [bash curl jq yq crate2nix protobuf rustToolchain];
  text = builtins.readFile ../../scripts/update-temporal-revision.sh;
  # Export PROTOC environment variable
  runtimeEnv = {
    PROTOC = "${pkgs.protobuf}/bin/protoc";
  };
}

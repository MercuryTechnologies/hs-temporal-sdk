{
  proto-lens-protoc,
  temporal-sdk-core,
}: {pkgs, ...}: let
  protogen = pkgs.writeShellScriptBin "protogen" ''
    shopt -s globstar
    ${pkgs.protobuf}/bin/protoc \
      --plugin=protoc-gen-haskell=${proto-lens-protoc}/bin/proto-lens-protoc \
      --haskell_out=${../../protos} \
      --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/local \
      --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/api_upstream \
      --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/grpc \
      --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/testsrv_upstream \
      ${temporal-sdk-core}/sdk-core-protos/protos/local/**/*.proto \
      ${temporal-sdk-core}/sdk-core-protos/protos/api_upstream/**/*.proto \
      ${temporal-sdk-core}/sdk-core-protos/protos/grpc/**/*.proto \
      ${temporal-sdk-core}/sdk-core-protos/protos/testsrv_upstream/temporal/**/*.proto
  '';
in {
  packages =
    [
      protogen
    ]
    ++ (with pkgs;
      lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
        Security
        CoreFoundation
        SystemConfiguration
      ]));

  languages.rust.enable = true;

  pre-commit.hooks = {
    crate2nix = {
      enable = true;
      name = "crate2nix";
      files = "Cargo\\.(toml|lock)$";
      language = "system";
      pass_filenames = true;
      entry = ''
        cd $(dirname $1)
        ${pkgs.crate2nix}/bin/crate2nix generate
      '';
    };

    # Not smart enough to find the location of the Cargo.toml
    cargo-check.enable = false;
  };
}

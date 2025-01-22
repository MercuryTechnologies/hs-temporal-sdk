{
  proto-lens-protoc,
  temporal-sdk-core,
}: {pkgs, ...}: let
  protogen = pkgs.writeShellApplication {
    name = "protogen";
    runtimeInputs = [pkgs.protobuf pkgs.hpack];
    text = ''
      shopt -s globstar

      repo_root="$( git rev-parse --show-toplevel )"
      package_dir="$repo_root/protos"

      protoc \
        --plugin=protoc-gen-haskell=${pkgs.lib.getExe proto-lens-protoc} \
        --haskell_out="$package_dir/src" \
        --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/local \
        --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/api_upstream \
        --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/grpc \
        --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/google \
        --proto_path=${temporal-sdk-core}/sdk-core-protos/protos/testsrv_upstream \
        ${temporal-sdk-core}/sdk-core-protos/protos/local/**/*.proto \
        ${temporal-sdk-core}/sdk-core-protos/protos/api_upstream/**/*.proto \
        ${temporal-sdk-core}/sdk-core-protos/protos/grpc/**/*.proto \
        ${temporal-sdk-core}/sdk-core-protos/protos/google/**/*.proto \
        ${temporal-sdk-core}/sdk-core-protos/protos/testsrv_upstream/temporal/**/*.proto

      # Remove codegen for well-known types (`proto-lens` provides these).
      rm -rf "$package_dir/src/Proto/Google/Protobuf"
      # Re-generate cabal file to include new/updated modules. 
      hpack "$package_dir"
    '';
  };
in {
  packages =
    [
      protogen
      pkgs.crate2nix
      pkgs.protobuf
      pkgs.rust-cbindgen
    ]
    ++ (with pkgs;
      lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
        Security
        CoreFoundation
        SystemConfiguration
      ]));

  languages.rust = {
    enable = true;
    channel = "nightly";
  };

  pre-commit.hooks = {
    crate2nix = {
      enable = false;
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

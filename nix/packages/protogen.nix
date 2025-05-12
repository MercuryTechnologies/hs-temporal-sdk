{
  writeShellApplication,
  lib,
  temporal-sdk-core-src,
  proto-lens-protoc,
  protobuf,
  hpack,
  ...
}:
writeShellApplication {
  name = "protogen";
  runtimeInputs = [
    protobuf
    hpack
  ];
  text = ''
    shopt -s globstar
    repo_root="$( git rev-parse --show-toplevel )"
    package_dir="$repo_root/protos"
    protoc \
      --plugin=protoc-gen-haskell=${lib.getExe proto-lens-protoc} \
      --haskell_out="$package_dir/src" \
      --proto_path=${temporal-sdk-core-src}/sdk-core-protos/protos/local \
      --proto_path=${temporal-sdk-core-src}/sdk-core-protos/protos/api_upstream \
      --proto_path=${temporal-sdk-core-src}/sdk-core-protos/protos/grpc \
      --proto_path=${temporal-sdk-core-src}/sdk-core-protos/protos/google \
      --proto_path=${temporal-sdk-core-src}/sdk-core-protos/protos/testsrv_upstream \
      ${temporal-sdk-core-src}/sdk-core-protos/protos/local/**/*.proto \
      ${temporal-sdk-core-src}/sdk-core-protos/protos/api_upstream/**/*.proto \
      ${temporal-sdk-core-src}/sdk-core-protos/protos/grpc/**/*.proto \
      ${temporal-sdk-core-src}/sdk-core-protos/protos/google/**/*.proto \
      ${temporal-sdk-core-src}/sdk-core-protos/protos/testsrv_upstream/temporal/**/*.proto
    # Remove codegen for well-known types (`proto-lens` provides these).
    rm -rf "$package_dir/src/Proto/Google/Protobuf"
    # Re-generate cabal file to include new/updated modules.
    hpack "$package_dir"
  '';
}

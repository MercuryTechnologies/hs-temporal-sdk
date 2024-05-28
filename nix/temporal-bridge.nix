{pkgs}: let
  customBuildRustCrateForPkgs = pkgs:
    pkgs.buildRustCrate.override {
      defaultCrateOverrides =
        pkgs.defaultCrateOverrides
        // {
          prost = _attrs: {
            PROTOC = "${pkgs.protobuf}/bin/protoc";
            PROTOC_INCLUDE = "${pkgs.protobuf}/include";
          };
          prost-wkt-types = _attrs: {
            PROTOC = "${pkgs.protobuf}/bin/protoc";
            PROTOC_INCLUDE = "${pkgs.protobuf}/include";
          };
          temporal-sdk-core-protos = _attrs: {
            PROTOC = "${pkgs.protobuf}/bin/protoc";
            PROTOC_INCLUDE = "${pkgs.protobuf}/include";
          };
          temporal_bridge = attrs: {
            buildInputs = pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk.frameworks; [
              Security
              CoreFoundation
              SystemConfiguration
            ]);
            postInstall = ''
              ${attrs.postInstall or ""}
              ${pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
                for library in $lib/lib/*.so $lib/lib/*.dylib; do #*/
                  echo "Trying to fix library paths for $library"
                  if [ -f "$library" ] && [ ! -L "$library" ]; then
                    install_name_tool -id "$library" "$library"
                  fi
                done
              ''}
            '';
          };
          ring = attrs: {
            CARGO_MANIFEST_LINKS = attrs.links;
          };
        };
    };
  cargoNix = pkgs.callPackage ../core/rust/Cargo.nix {
    buildRustCrateForPkgs = customBuildRustCrateForPkgs;
  };
in {
  inherit cargoNix;
  temporal-bridge = cargoNix.rootCrate.build;
  temporal-sdk-core-src = cargoNix.internal.crates.temporal-sdk-core.src;
}

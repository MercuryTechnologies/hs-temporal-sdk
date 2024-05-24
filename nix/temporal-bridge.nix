{
  pkgs,
  temporal-sdk-core,
}: {
  temporal-bridge = pkgs.rustPlatform.buildRustPackage {
    name = "temporal_bridge";
    src = ../core/rust;
    PROTOC = "${pkgs.protobuf}/bin/protoc";
    PROTOC_INCLUDE = "${pkgs.protobuf}/include";

    buildInputs = with pkgs;
      [
        protobuf
        pkg-config
        openssl
        protobuf
      ]
      ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
        Security
        CoreFoundation
        SystemConfiguration
      ]);

    cargoLock = {
      lockFile = ../core/rust/Cargo.lock;
      outputHashes = {
        "rustfsm-0.1.0" = "sha256-L0rCBnCfhR3D5ku1ItCzIE9nOk9wXaMcxV2I11uhrRc=";
      };
    };

    doCheck = false;
    # wow, this is ugly
    preBuild = ''
      mkdir -p ../cargo-vendor-dir
      ln -s ${temporal-sdk-core}/protos ../cargo-vendor-dir/protos
    '';

    postInstall = ''
      ${pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
        install_name_tool -id $out/lib/libtemporal_bridge.dylib $out/lib/libtemporal_bridge.dylib
      ''}
    '';
    # ${pkgs.lib.optionalString pkgs.stdenv.isLinux ''
    #   patchelf --set-rpath $out/lib $out/lib/libtemporal_bridge.so
    #   patchelf --set-soname libtemporal_bridge.so $out/lib/libtemporal_bridge.so
    # ''}
  };
}

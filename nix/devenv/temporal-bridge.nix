{pkgs, ...}: {
  packages =
    [
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

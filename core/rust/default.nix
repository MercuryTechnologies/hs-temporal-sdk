{
  lib,
  rustPlatform,
  stdenv,
  protobuf,
  darwin,
  fixDarwinDylibNames,
  ...
}:
let
  cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
  crateHashes = builtins.fromJSON (builtins.readFile ./crate-hashes.json);
in
rustPlatform.buildRustPackage {
  pname = cargoToml.package.name;
  version = cargoToml.package.version;
  # TODO(jkachmar): Apply some sort of Rust source filter to clean this.
  src = ./.;

  nativeBuildInputs =
    [ protobuf ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      fixDarwinDylibNames
    ];
  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  # Work around a `buildRustPackage` bug where it fails when workspace lints
  # are present in a dependency's `Cargo.toml`.
  #
  # FIXME: Remove after https://github.com/NixOS/nixpkgs/pull/300532 lands.
  cargoDepsHook = ''
    fixRustFSM() {
      sed -i '/lints/,$d' $cargoDepsCopy/rustfsm-0.1.0/Cargo.toml
    }
    prePatchHooks+=(fixRustFSM)
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
    # NOTE: `cargo2nix` generates crate hashes (roughly) as follows:
    #
    # ```
    # {
    #   ...
    #   "git+<GIT URL>?rev=<GIT REV>#<NAME>@<VERSION>": "<HASH>",
    #   ...
    # }
    # ```
    #
    # `crateHashes` is parsed from this JSON file, and the following bit of
    # string manipulation can be used to populate `outputHashes` with the
    # format that it expects.
    outputHashes = lib.mapAttrs' (name: value: {
      inherit value;
      name = lib.pipe name [
        (builtins.split "#")
        (xs: builtins.elemAt xs 2)
        (builtins.replaceStrings [ "@" ] [ "-" ])
      ];
    }) crateHashes;
  };
}

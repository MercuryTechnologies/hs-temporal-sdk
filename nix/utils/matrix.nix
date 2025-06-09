{
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
    # FIXME: re-enable this once we have aarch64 support for the time-skipping server.
    # "aarch64-linux" 
  ];

  ghcVersions = [
    "ghc96"
    "ghc98"
    "ghc910"
  ];
}

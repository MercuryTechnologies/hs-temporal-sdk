{
  perSystem =
    { pkgs, ... }:
    {
      devenv.shells.default = {
        packages = [
          pkgs.protobuf
          pkgs.rust-cbindgen
        ];
        languages.rust.enable = true;
        languages.haskell = {
          languageServer = null;
          enable = true;
          package = pkgs.haskell.packages.ghc98.ghc.withHoogle (
            hpkgs: with hpkgs; [
              base64
              time-compat
            ]
          );
        };
      };
    };
}

pkgs: let
  rustCore = import ../temporal-bridge.nix {
    inherit pkgs;
  };
  sdkPackages = import ../temporal-sdk-pkgs.nix {
    inherit pkgs;
    temporal-bridge = rustCore.temporal-bridge;
  };
in
  sdkPackages

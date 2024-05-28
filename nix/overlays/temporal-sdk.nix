_self: super: let
  rustCore = import ../temporal-bridge.nix {
    pkgs = super;
  };
  sdkPackages = import ../temporal-sdk-packages.nix {
    pkgs = super;
    temporal-bridge = rustCore.temporal-bridge;
  };
in {
  haskellPackages = super.haskellPackages.extend sdkPackages;
}

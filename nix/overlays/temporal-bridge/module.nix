{
  flake.overlays = {
    temporal-bridge = import ./overlay.nix;
  };
}

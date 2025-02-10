{
  flake.overlays = {
    temporal-bridge = final: _prev: (import ./derivation.nix) final;
  };
}

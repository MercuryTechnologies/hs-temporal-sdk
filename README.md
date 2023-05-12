# Temporal Haskell SDK

Pre-alpha

## Notes

- The Cabal package is configured to automatically build the Rust dependency while developing the library.

## Commands

- `nix build .` builds the Haskell program.
- `nix build .#hs_temporal_bridge` builds the Rust library.
- `nix develop` enters the development Shell for the Haskell program.

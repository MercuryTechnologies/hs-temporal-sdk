# Temporal Haskell SDK

This SDK requires Temporal Server >= 1.20

Tested GHC versions:

- GHC 9.2.x
- GHC 9.6.x

## Notes

- The Cabal package is configured to automatically build the Rust dependency while developing the library.

## Commands

- `nix build .` builds the Haskell program.
- `nix build .#hs_temporal_bridge` builds the Rust library.
- `nix develop` enters the development Shell for the Haskell program.
  - `stack` supports a GHC 9.2.x build environment
  - `cabal` supports a GHC 9.6.x build environment

## Brainstorm

Maybe support workflow vars instead of putting state into the monadic context. Would need to refactor the condition waiting logic.
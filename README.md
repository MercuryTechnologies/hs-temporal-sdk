[Temporal](https://temporal.io) is a durable execution system that transparently makes your code durable, fault-tolerant, and simple.

"Temporal Haskell SDK" is the framework for authoring workflows and activities using the Haskell programming language with the GHC compiler.

This SDK requires Temporal Server >= 1.20

Tested GHC versions:

- GHC 9.2.x
- GHC 9.6.x

## Notes

- The Cabal package is configured to automatically build the Rust dependency while developing the library. You must have `cargo` installed
  in order for this to work.

## Handy Development Commands

- `nix build .` builds the Haskell program.
- `nix build .#hs_temporal_bridge` builds the Rust library.
- `nix develop` enters the development Shell for the Haskell program.
  - `stack` supports a GHC 9.2.x build environment
  - `cabal` supports a GHC 9.6.x build environment

## Pending work for v0.0.1.0

- [ ] Interceptors
- [ ] OTel, Prometheus, core logging support
- [ ] Better shutdown testing
- [ ] Tested replay support
- [ ] Ephemeral test environments
- [ ] Tutorial Module(s)
- [ ] Indefinite blocking pending cancellation signals
- [ ] State vars
- [ ] Awaiting condition change
- [ ] Signal support

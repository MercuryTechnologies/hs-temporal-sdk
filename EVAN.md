Building `temporal-sdk-core` succeeds, but building `temporal-sdk` fails:

```
$ nix build .#temporal-sdk
error: builder for '/nix/store/kfl6qsf59y4nl47yasx6avwwi09jdzg2-temporal-sdk-0.0.1.0.drv' failed with exit code 1;
       last 10 log lines:
       >
       > <no location info>: error:
       >     dlopen(/nix/store/f572pjninjdrmk0f9y1764mkcsgpfh1r-temporal-sdk-0.0.1.0/lib/links/libHStemporal-sdk-core-0.1.0.0-A9SLtkitCskC7xDSA6230G-ghc9.4.8.dylib, 0x0005): Library not loaded: /private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib
       >   Referenced from: <B0BB74FA-A7D3-3931-A5C7-136D722BB60C> /nix/store/jr5hgxxqyipb7yzl7kj6lzr54z2yadkv-temporal-sdk-core-0.1.0.0/lib/ghc-9.4.8/aarch64-osx-ghc-9.4.8/libHStemporal-sdk-core-0.1.0.0-A9SLtkitCskC7xDSA6230G-ghc9.4.8.dylib
       >   Reason: tried: '/private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib' (no such file), '/private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib' (no such file), '/usr/local/lib/libtemporal_bridge.dylib' (no such file), '/usr/lib/libtemporal_bridge.dylib' (no such file, not in dyld cache)
       >
       > <no location info>: error:
       >     dlopen(/nix/store/f572pjninjdrmk0f9y1764mkcsgpfh1r-temporal-sdk-0.0.1.0/lib/links/libHStemporal-sdk-core-0.1.0.0-A9SLtkitCskC7xDSA6230G-ghc9.4.8.dylib, 0x0005): Library not loaded: /private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib
       >   Referenced from: <B0BB74FA-A7D3-3931-A5C7-136D722BB60C> /nix/store/jr5hgxxqyipb7yzl7kj6lzr54z2yadkv-temporal-sdk-core-0.1.0.0/lib/ghc-9.4.8/aarch64-osx-ghc-9.4.8/libHStemporal-sdk-core-0.1.0.0-A9SLtkitCskC7xDSA6230G-ghc9.4.8.dylib
       >   Reason: tried: '/private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib' (no such file), '/private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib' (no such file), '/usr/local/lib/libtemporal_bridge.dylib' (no such file), '/usr/lib/libtemporal_bridge.dylib' (no such file, not in dyld cache)
       For full logs, run 'nix log /nix/store/kfl6qsf59y4nl47yasx6avwwi09jdzg2-temporal-sdk-0.0.1.0.drv'.
```

Looking at the `dylib` being `dlopen`ed, it appears it's referencing libraries
present in the ephemeral build environment:

```
$ otool -L /nix/store/f572pjninjdrmk0f9y1764mkcsgpfh1r-temporal-sdk-0.0.1.0/lib/links/libHStemporal-sdk-core-0.1.0.0-A9SLtkitCskC7xDSA6230G-ghc9.4.8.dylib
/nix/store/f572pjninjdrmk0f9y1764mkcsgpfh1r-temporal-sdk-0.0.1.0/lib/links/libHStemporal-sdk-core-0.1.0.0-A9SLtkitCskC7xDSA6230G-ghc9.4.8.dylib:
        @rpath/libHStemporal-sdk-core-0.1.0.0-A9SLtkitCskC7xDSA6230G-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        /private/tmp/nix-build-temporal_bridge.drv-0/rust/target/aarch64-apple-darwin/release/deps/libtemporal_bridge.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHStemporal-api-protos-1.0.0.0-FtuHB6iR3EO5coWzeXr9y9-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSproto-lens-protobuf-types-0.8.0.0-87Ro4YgBV3GJJCyf8W9wqN-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSproto-lens-0.7.1.3-KKL3oaYQLQd4SbmWfAjodI-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSnetwork-bsd-2.8.1.0-CNAKep9HEZkI12RhUUw3Vb-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSasync-2.2.5-AnfjgshVSRz4fkcMix9fTy-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSaeson-2.1.2.1-D1u1vV2y3RV6U7EQJgtGqW-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSvector-0.13.1.0-JFkNJllqEIa8XP3B7cNhrn-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSunordered-containers-0.2.19.1-3EH05YYx0lf5ml8nFPcMKW-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHShashable-1.4.3.0-KZ8CbQb9NiI5FuVKm4DSS3-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHStext-2.0.2-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSbytestring-0.11.5.3-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHScontainers-0.6.7-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSbase-4.17.2.1-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        @rpath/libHSghc-prim-0.9.1-ghc9.4.8.dylib (compatibility version 0.0.0, current version 0.0.0)
        /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1292.60.1)
```

The second `dylib` under `/private/tmp/` is a problem.

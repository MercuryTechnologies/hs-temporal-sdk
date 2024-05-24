<p align="center">
  <img src="./docs/hs.png" alt="Haskell TypeScript SDK" />
</p>
<p align="center">
  <!-- <a href="https://www.npmjs.com/search?q=author%3Atemporal-sdk-team">
    <img src="https://img.shields.io/npm/v/temporalio.svg?style=for-the-badge" alt="NPM" />
  </a> -->
  <a href="https://github.com/temporalio/sdk-typescript/blob/main/LICENSE.md">
    <img src="https://img.shields.io/npm/l/temporalio?style=for-the-badge" alt="LICENSE" />
  </a>
</p>

[Temporal](https://temporal.io) is a durable execution system that transparently makes your code durable, fault-tolerant, and simple.

This project provides an unofficial Haskell SDK along with supporting packages for authoring workflows and activities.

> [!WARNING]
> This project is still under heavy development. It is in production use at [Mercury](https://mercury.com), but we currently make no stability guarantees for
> external users of the project.

For documentation and samples, see:

- [General Temporal docs](https://docs.temporal.io)

## Packages

This monorepo contains the following packages:

| Subfolder | Package | Description |
|-----------|---------|-------------|
| [`./`](./)                                        | `temporal-sdk`               | The developer-facing core package. Use this to author and execute Temporal Workflows and Activities. |
| [`core/`](core/)                                  | `temporal-sdk-core`          | Core FFI bindings that interface with the rust core library. |
| [`codec-encryption/`](codec-encryption/)          | `temporal-codec-encryption`  | A simple implementation of at-rest encryption for payloads. |
| [`codec-server`](codec-server/)                   | `temporal-sdk-codec-server`  | A WAI middleware to transform payloads for use with the Temporal Web UI.
| [`optimal-codec/`](optimal-codec/)                | `temporal-sdk-optimal-codec` | Given a set of preferred codecs for Activity and Workflow inputs and outputs, choose the optimal codec for each value. |
| [`protos/`](protos/)                              | `temporal-api-protos`        | Raw protocol buffer modules for exotic use cases. |

## Development Environment

This project uses [Nix](https://nixos.org/guides/nix-package-manager.html) to manage the development environment and dependencies. Nix ensures a reproducible and consistent build environment across different systems.

> [!NOTE]
> Stack support is for convenience, but not guaranteed by CI to compile consistently.

It is recommended to set up [direnv](https://direnv.net/) and [nix-direnv](https://github.com/nix-community/nix-direnv) to automatically load the Nix environment when you enter the project directory. After installing `direnv`, run the following command in the project root to bootstrap the development environment.

```bash
direnv allow
```

### Useful Development Commands

`nix develop --impure` enters the development shell for the Haskell program if you aren't
using `direnv`. This shell includes the necessary tools and dependencies for development, such as GHC, Cabal, and the Rust toolchain.

Inside the development shell, you can use cabal commands as usual. Cabal is the official build tool for this project.

- `nix build .\#{packageName}-{ghcVersion}` builds the given package for a given GHC version.
- `nix build .\#temporal-bridge` builds the Rust library (temporal-bridge) that provides bindings to the Temporal Core library.
- `devenv up` starts a local Temporal server for development and testing purposes.

The flake.nix file defines different shells for each supported GHC version (`ghc96`, `ghc98`). You can enter the shell for a specific GHC version with the following command:

```bash
nix develop .\#{ghcVersion} --impure
```

Replace {ghcVersion} with the desired GHC version (e.g., `ghc96`, `ghc98`).

> [!NOTE]
> The first time you run nix develop or nix build, Nix will download and build all the necessary dependencies, which may take some time. Subsequent runs will be faster as Nix will reuse the cached dependencies.

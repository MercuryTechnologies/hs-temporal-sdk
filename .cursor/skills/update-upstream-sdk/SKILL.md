---
name: update-upstream-sdk
description: Update the hs-temporal-sdk project against the upstream Rust core SDK (temporalio/sdk-core). Covers revision bumps, Rust compilation, C header regeneration via bindgen, Haskell FFI bridge updates, protobuf regeneration, SDK module propagation, and nix build verification across GHC versions. Use when updating, bumping, syncing, or upgrading the upstream Temporal SDK dependency.
---

# Update Upstream Temporal Rust Core SDK

This skill walks through updating the project's pinned revision of
[temporalio/sdk-core](https://github.com/temporalio/sdk-core) and propagating
all downstream effects through the Rust bridge, Haskell core bindings, protobuf
definitions, and the high-level SDK.

## Repository layout (quick reference)

```
core/rust/          Rust bridge crate (temporal_bridge) — FFI to sdk-core
core/rust/Cargo.toml    Pinned sdk-core rev lives here
core/rust/Cargo.nix     crate2nix generated lockfile for Nix
core/rust/bindgen.sh    Regenerates temporal_bridge.h via cbindgen
core/rust/temporal_bridge.h  C header consumed by Haskell hsc2hs

core/src/           Haskell core FFI package (temporal-sdk-core)
core/src/Temporal/Core/CTypes.hsc   hsc2hs bindings using temporal_bridge.h
core/src/Temporal/Core/Client.hs    Client FFI wrappers
core/src/Temporal/Core/Worker.hs    Worker FFI wrappers
core/src/Temporal/Internal/FFI.hs   Low-level FFI helpers

protos/             Haskell protobuf package (temporal-api-protos)
protos/src/Proto/   Generated proto-lens modules

sdk/                High-level Haskell SDK (temporal-sdk)
sdk/src/Temporal/   Public API modules

scripts/update-temporal-revision.sh   Automated revision-bump script
nix/packages/protogen.nix             Nix derivation for protobuf codegen
nix/utils/matrix.nix                  GHC version matrix: ghc96, ghc98, ghc910
```

## Workflow

Follow these phases **in order**. Each phase must succeed before moving to the
next.

### Phase 0 — Understand the upstream changes

Before touching any files, determine what changed upstream.

1. Identify the **current** pinned revision from `core/rust/Cargo.toml`
   (look for the `rev = "..."` on any `temporalio/sdk-core` dependency).
2. Identify the **target** revision (user-supplied, or latest master, or "next"
   commit).
3. Fetch the upstream diff between those two revisions:
   ```
   https://github.com/temporalio/sdk-core/compare/{old_rev}...{new_rev}
   ```
   Read the commit messages and changed files. Classify changes:
   - **Proto changes** — files under `sdk-core-protos/protos/` changed.
     Protobuf regeneration will be required.
   - **Public API changes** — new/changed types or functions in
     `temporal-client`, `temporal-sdk-core`, `temporal-sdk-core-api`.
     These may require Rust bridge and/or Haskell FFI updates.
   - **Config/option changes** — new fields on `WorkerConfig`,
     `ClientConfig`, `RuntimeConfig`, etc. These need to propagate through
     `core/rust/src/*.rs` -> `core/src/Temporal/Core/CTypes.hsc` ->
     `sdk/src/Temporal/`.
   - **Breaking changes** — removed or renamed types/functions. The Rust
     bridge will fail to compile until adapted.
   - **Internal-only changes** — bug fixes or perf improvements inside
     sdk-core that don't change the external API. No Haskell-side changes
     needed beyond the rev bump.

   Document your classification before proceeding.

4. **Cross-reference sibling SDKs** for any new functionality exposed by the
   core change. Check how the feature is surfaced in the official SDKs that
   also wrap sdk-core:

   | SDK | Repository | Key paths |
   |---|---|---|
   | **TypeScript** (primary reference) | `temporalio/sdk-typescript` | `packages/worker/src/`, `packages/client/src/`, `packages/workflow/src/`, `packages/test/src/` |
   | **Python** | `temporalio/sdk-python` | `temporalio/worker/`, `temporalio/client/`, `temporalio/workflow/`, `tests/` |
   | **.NET** | `temporalio/sdk-dotnet` | `src/Temporalio/Worker/`, `src/Temporalio/Client/`, `tests/Temporalio.Tests/` |

   For each new or changed feature, note:
   - **Naming conventions** — function/method names, option field names,
     enum variant names. Prefer matching the TypeScript SDK naming where
     language-appropriate, as it's the most mature core-based SDK.
   - **Default values** — what defaults do the other SDKs use for new
     config fields?
   - **Validation** — do they validate inputs? What errors do they throw?
   - **Documentation** — how do they describe the feature in docstrings?
     Port the intent, adapt for Haskell conventions.
   - **Test cases** — identify which tests cover the feature. These will
     be ported in Phase 6b.

### Phase 1 — Bump the revision

Read `scripts/update-temporal-revision.sh` for the mechanical steps. The script:
- Updates `rev = "..."` for all five sdk-core dependencies in
  `core/rust/Cargo.toml` (`temporal-client`, `temporal-sdk-core`,
  `temporal-sdk-core-api`, `temporal-sdk-core-protos`, `rustfsm`).
- Runs `cargo build` in `core/rust/` to update `Cargo.lock`.
- Runs `crate2nix generate` in `core/rust/` to regenerate `Cargo.nix`.

You can either run the script directly:
```bash
./scripts/update-temporal-revision.sh <target-rev>
```
Or perform the steps manually if finer control is needed.

### Phase 2 — Get the Rust bridge compiling

If upstream made breaking changes, `cargo build` in Phase 1 will fail. Fix
compilation errors in `core/rust/src/`:

| Rust source file | Wraps |
|---|---|
| `client.rs` | Client creation, RPC calls |
| `worker.rs` | Worker creation, polling, completions |
| `runtime.rs` | Tokio runtime init, telemetry config |
| `ephemeral_server.rs` | Test server management |
| `rpc.rs` | Low-level gRPC plumbing |

Common patterns for fixes:
- New config fields → add them to the relevant Rust struct and the FFI
  function that constructs it from C arguments.
- Renamed types → update `use` imports.
- Changed function signatures → adapt call sites.

Re-run `cargo build` in `core/rust/` until it succeeds.
Then re-run `crate2nix generate` in `core/rust/` to update `Cargo.nix`.

### Phase 3 — Regenerate the C header (bindgen)

Once the Rust bridge compiles, regenerate the C header:

```bash
cd core/rust && bash bindgen.sh
```

This runs `cbindgen` with `cbindgen.toml` configuration to produce
`temporal_bridge.h`. Diff the old and new header to identify:

- New FFI functions that need Haskell `foreign import ccall` declarations.
- Changed struct layouts that need `Storable` instance updates.
- New enum variants that need Haskell-side representation.
- Removed functions/types that should be cleaned up.

### Phase 4 — Update Haskell core FFI bindings

With the new `temporal_bridge.h`, update the Haskell core package
(`core/src/Temporal/`):

1. **`Core/CTypes.hsc`** — This is the main FFI types file. It uses hsc2hs
   `#include "temporal_bridge.h"` and `#{peek ...}` / `#{poke ...}` macros.
   Update `Storable` instances for any changed C structs. Add new FFI imports
   for new functions. Remove stale ones.

2. **`Core/Client.hs`** — High-level wrappers around client FFI calls.
   Propagate new client options, new RPC methods, etc.

3. **`Core/Worker.hs`** — Worker lifecycle FFI wrappers.
   Propagate new worker config fields, new poll/completion types.

4. **`Core/EphemeralServer.hs`** — Test/dev server FFI.

5. **`Internal/FFI.hs`** — Shared FFI utilities.

6. **`Runtime.hs`** — Runtime config and initialization.

### Phase 5 — Regenerate protobufs (if needed)

Only required if Phase 0 identified proto file changes.

From inside a nix devshell, run:
```bash
protogen
```

This is a shell command provided by the devshell (defined in
`nix/packages/protogen.nix`). It:
- Runs `protoc` with `proto-lens-protoc` plugin against the upstream proto
  files (sourced from the sdk-core-protos crate via Nix).
- Outputs generated Haskell modules to `protos/src/Proto/`.
- Removes well-known Google Protobuf types (proto-lens provides these).
- Runs `hpack` on `protos/` to update the cabal file with new modules.

**Important**: Because the proto source files come from the `temporal-sdk-core-src`
Nix derivation (see `nix/packages/temporal-bridge.nix`), you need the Nix
build of the new Cargo.nix to succeed first, so that the correct proto source
tree is available. If it doesn't build in Nix yet, you may need to iterate on
Phase 2 first.

After regeneration, check for:
- New proto modules that need re-exporting from `temporal-api-protos.cabal`.
- Changed message types that are used in `core/` or `sdk/` Haskell code.

### Phase 6a — Propagate to the SDK

Changes from Phases 3-5 may need to flow into `sdk/src/Temporal/`:

| Area | SDK modules |
|---|---|
| Client configuration | `Client.hs`, `Client/` |
| Worker configuration | `Worker.hs`, `Worker/` |
| Workflow types | `Workflow.hs`, `Workflow/` |
| Activity types | `Activity.hs`, `Activity/` |
| Common/Payload types | `Common.hs`, `Common/`, `Payload.hs` |
| Search attributes | `SearchAttributes.hs`, `SearchAttributes/` |
| Duration handling | `Duration.hs` |
| Nexus | `Nexus/` |

#### Naming and style conventions

This SDK follows the naming conventions of the official Temporal SDKs that
wrap sdk-core, with the **TypeScript SDK as the primary reference**, adapted
for Haskell idioms:

- **Function/method names**: Match the TS SDK name, converted to
  `camelCase`. E.g., TS `startWorkflow` → Haskell `startWorkflow`,
  TS `signalWithStart` → Haskell `signalWithStart`.
- **Config field names**: Match the TS/Python option names. E.g., TS
  `WorkerOptions.maxConcurrentActivityTaskExecutions` → Haskell
  `maxConcurrentActivityTaskExecutions`. Use record fields, not positional.
- **Enum/ADT variants**: Match the TS/Python names in PascalCase. E.g.,
  TS `VersioningIntent.COMPATIBLE` → Haskell `Compatible`.
- **Defaults**: Use the same defaults as the TypeScript SDK unless there's
  a Haskell-specific reason to differ. Document any intentional deviations
  in Haddock.
- **Validation**: If TS/Python validate a config field (range check,
  non-empty, etc.), replicate that validation. Prefer returning structured
  errors over throwing.
- **Haddock docs**: Port the intent of TS/Python docstrings. Reference
  the Temporal docs URL where applicable. Don't copy verbatim — adapt
  for Haskell types and idioms.

When in doubt about a name or behavior, check the SDKs in this priority:
1. TypeScript (`temporalio/sdk-typescript`)
2. Python (`temporalio/sdk-python`)
3. .NET (`temporalio/sdk-dotnet`)

#### Adding new configuration options

- Add the field to the relevant Haskell record type.
- Set a sensible default matching the TypeScript SDK.
- Update any smart constructors or builder functions.
- Add Haddock documentation referencing what the option does.

#### Adding new functionality

- Expose it through the appropriate SDK module.
- Name it consistently with the TypeScript SDK (see conventions above).
- Update Haddock docs.

### Phase 6b — Port tests from sibling SDKs

For any new functionality introduced by the upstream change, port the
corresponding tests from the official SDKs. This is **not optional** — new
features must ship with tests.

#### Where to find reference tests

| SDK | Test locations |
|---|---|
| TypeScript | `packages/test/src/test-*.ts` — integration tests, one file per feature area |
| Python | `tests/` — `test_workflow.py`, `test_activity.py`, `test_client.py`, `test_worker.py`, etc. |
| .NET | `tests/Temporalio.Tests/` — `WorkflowTests.cs`, `ActivityTests.cs`, etc. |

#### How to port tests

1. Identify the test cases in the sibling SDKs that exercise the new
   feature. The TypeScript SDK is the primary source; cross-reference with
   Python for additional edge cases.

2. Map each test to the appropriate Haskell test module:

   | Feature area | Haskell test file |
   |---|---|
   | Workflow basics, info, patching | `sdk/test/WorkflowSpec.hs` |
   | Activities | `sdk/test/ActivitySpec.hs` |
   | Local activities | `sdk/test/LocalActivitySpec.hs` |
   | Signals | `sdk/test/SignalSpec.hs` |
   | Queries | `sdk/test/QuerySpec.hs` |
   | Updates | `sdk/test/UpdateSpec.hs` |
   | Child workflows | `sdk/test/ChildWorkflowSpec.hs` |
   | Continue-as-new | `sdk/test/ContinueAsNewSpec.hs` |
   | Cancellation | `sdk/test/CancellationSpec.hs` |
   | Timers | `sdk/test/TimerSpec.hs` |
   | Replay | `sdk/test/ReplaySpec.hs` |
   | Termination | `sdk/test/TerminateSpec.hs` |
   | Time skipping | `sdk/test/TimeSkippingSpec.hs` |
   | Schedules | `sdk/test/ScheduleSpec.hs` |
   | Nexus | `sdk/test/NexusSpec.hs` |
   | Async completion | `sdk/test/AsyncCompletionSpec.hs` |

3. Translate the test logic into Haskell, following existing patterns:
   - Use `TestHelpers` (`withTestServer_`, `TestEnv`, `withWorker`,
     `makeClient`, `defaultStartOpts`, etc.).
   - Use hspec `describe`/`it` structure matching the TS test name
     where reasonable.
   - Workflows and activities under test go in the same file or in a
     companion module under `sdk/test/IntegrationSpec/`.
   - Use `temporalBundle` TH macro for declaring test workflow/activity
     bundles.
   - **Never use `threadDelay`** for coordination. Use query-based
     readiness probes (e.g., `waitForWorkflowStart`) or other
     synchronization primitives.
   - Prefer `shouldBe`, `shouldSatisfy`, `shouldThrow` for assertions.

4. If the feature is not yet implementable in Haskell (e.g., requires SDK
   support that isn't in this update), add the tests as `pending` stubs
   in `sdk/test/PendingFeaturesSpec.hs` with a comment noting which
   upstream SDK test they correspond to. Include the source SDK and test
   name:
   ```haskell
   it "feature name (TS: test-foo.ts)" $ const pending
   ```

5. Remove any corresponding entries from `PendingFeaturesSpec.hs` when
   promoting them to real tests.

### Phase 7 — Verify builds across GHC versions

The project targets three GHC versions (defined in `nix/utils/matrix.nix`):
- `ghc96`
- `ghc98`
- `ghc910`

Run:
```bash
nix build .#hs-temporal-suite-ghc96
nix build .#hs-temporal-suite-ghc98
nix build .#hs-temporal-suite-ghc910
```

Each of these builds all local Haskell packages (`temporal-sdk`,
`temporal-sdk-core`, `temporal-api-protos`, `temporal-sdk-codec-server`,
`temporal-codec-encryption`, `temporal-sdk-optimal-codec`, `tix-to-markdown`)
for that GHC version.

You can also build the Rust bridge independently:
```bash
nix build .#temporal-bridge
```

Fix any version-specific compilation issues (e.g., different `base` API
across GHC versions, CPP conditionals).

All three GHC version builds must pass before the update is considered
complete.

## Decision tree

```
Start
  │
  ├─ Phase 0: Read upstream diff + cross-reference sibling SDKs (TS/Py/.NET)
  │   ├─ Proto changes? ──────────► Flag for Phase 5
  │   ├─ Public API changes? ─────► Flag for Phases 2-4, 6a, 6b
  │   └─ Internal only? ──────────► Phases 1, 3, 7 may suffice
  │
  ├─ Phase 1: Bump rev in Cargo.toml, cargo build, crate2nix generate
  │   └─ Build fails? ────────────► Phase 2
  │
  ├─ Phase 2: Fix Rust bridge compilation
  │
  ├─ Phase 3: cd core/rust && bash bindgen.sh
  │   └─ Header changed? ─────────► Phase 4
  │
  ├─ Phase 4: Update Haskell core FFI
  │
  ├─ Phase 5: protogen (if proto changes flagged)
  │
  ├─ Phase 6a: Propagate to sdk/ modules (match TS naming/defaults/validation)
  │
  ├─ Phase 6b: Port tests from TS/Py SDKs; promote pending stubs if applicable
  │
  └─ Phase 7: nix build for ghc96, ghc98, ghc910
```

## Common pitfalls

- **Cargo.nix out of sync**: Always run `crate2nix generate` in `core/rust/`
  after any `Cargo.toml` or `Cargo.lock` change. Nix builds use `Cargo.nix`,
  not `Cargo.lock` directly.
- **Stale temporal_bridge.h**: If you change Rust FFI signatures but forget
  `bindgen.sh`, the Haskell hsc2hs step will use the old header and produce
  wrong offsets or missing symbols.
- **Proto source mismatch**: `protogen` pulls proto files from the Nix store
  path of the sdk-core source. If `Cargo.nix` hasn't been regenerated with
  the new rev, you'll codegen against old protos.
- **hpack**: After `protogen`, the `protos/` cabal file is regenerated by
  `hpack`. If new proto modules appear, they should show up automatically.
  Verify with `git diff protos/temporal-api-protos.cabal`.
- **GHC version compat**: Some base library functions differ across GHC 9.6,
  9.8, 9.10. Use CPP `#if` guards if needed.

# Soak / leak-detection harness — implementation plan

**Status:** plan (for review) · **Complements:** the replay/allocation suite (`notes/perf-suite-design.md`).
**Decisions locked (with the user):** prod-shaped workload mix · both run modes (`--iterations` default + `--duration`) · leak signal = residency *slope + samples*.

## Goal & what makes it different

The replay/allocation suite measures *bytes allocated per activation* on a fresh, torn-down worker
— it cannot see a leak (retention growth over time). This harness is the complement: a **long-lived
worker** driven against a **local ephemeral dev server**, executing **real workflows + activities**
in a churn loop over many **distinct** executions, sampling **residency over time** to surface leaks
that only manifest in production over long runs.

Not a replacement for anything. Separate executable, separate build config, separate output tree.

## The scoping question that shapes the metric (RESOLVED by review)

**Correction (Fable):** an earlier draft claimed WorkflowInstances live only in the Rust core. That's
wrong. `Temporal.Workflow.Worker` holds `runningWorkflows :: StmMap.Map RunId WorkflowInstance`
(`sdk/src/Temporal/Workflow/Worker.hs`), and `WorkflowInstance` is a large Haskell record of
IORefs/TVars/handler maps, pruned only when a `RemoveFromCache` job arrives. The Rust core owns the
cache *policy* (what stays sticky, when to evict) and its own native per-run state; the Haskell side
**mirrors every cached run with a live Haskell `WorkflowInstance`**.

Consequences for the metric:

- `GHC.Stats` live bytes (Haskell heap) **directly sees** the prime suspect — Haskell state keyed by
  runId that fails to be pruned on eviction. So Haskell live-bytes is the **primary, gated** metric.
- Native/Rust-core retention still needs **process RSS** (total resident memory) — the only view
  into the core's own per-run state machines/history buffers.

**Resolved plan:** sample *both* per tick — (a) Haskell live bytes via `GHC.Stats` (post-`performGC`,
**gated**), and (b) process RSS via `ps -o rss= -p <pid>` (**advisory only** — RSS conflates allocator
fragmentation / lazy OS-return with true leaks, so it gets a much larger threshold and never drives
the exit code). Two columns, two slopes; reporting them separately tells us *which side* leaks.

## Layout

```
scripts/perf/soak.sh          # build (cabal.project.soak) + run + slope/verdict (+ heap mode)
cabal.project.soak            # NEW: -O2 + -finfo-table-map, NO profiling (clean residency + -hi)
sdk/bench/
  Soak.hs                     # NEW executable main: arg parse, server+worker, churn loop, sampling
  Soak/Workload.hs            # NEW: prod-shaped workflows + activities + soak worker config
  Bench/Common.hs             # reuse benchRuntime + fixtureNs only
  Bench/Stats.hs              # + residencySample helper (performGC; live/mem-in-use/max-live)
perf-out/soak/<run-id>/       # gitignored: residency.csv, summary.csv, run.json, stdout.log,
                              #             soak.eventlog + .html (heap mode)
```

## Workload — prod-shaped mix (`Soak/Workload/Defs.hs` + `Soak/Workload.hs`)

Registered with Temporal's Template Haskell `$(register [d| … |])` splice, which generates a
PascalCase reference type per function (`SoakActivity`, `OutboxWorkflow`, `SyncWorkflow`,
`SoakLeafWorkflow`) carrying the `ActivityRef`/`WorkflowRef` instances. This is the idiom the test
suite uses (`RegisterWorkflowsSpec`, `THCompiles`) and it lets activities be called **with
arguments** directly (`executeActivity SoakActivity opts n`) — the plain `provideActivity` +
`.reference` form leaves `ArgsOf`/`ResultOf` type families stuck at the variadic apply site when the
activity is top-level, producing ambiguous-type errors. The register block lives in its own module
(`Soak.Workload.Defs`, no export list) so `discoverInstances` sees the generated instances as
*imported* — staging-safe, vs. discovering same-module splice output. `import Temporal.TH` (whole
module) is required for the generated `deriving via WorkflowImpl/ActivityImpl` coercions.

Two archetypes, each exercising the **real** poll→execute→complete→**evict** cycle + the activity
path, fired as distinct executions with unique workflow ids:

- **Activity** (shared): `soakActivity :: Int -> Activity () Int` — trivial work.
- **Outbox** (sequential state machine): `outboxWorkflow k` runs `SoakActivity` K times in series.
- **Scheduled-sync** (fan-out): `syncWorkflow c` fans out C child workflows (`SoakLeafWorkflow`)
  concurrently (`forConcurrently_` + `executeChildWorkflow`), each leaf calling `SoakActivity` once —
  multiplies instance-cache pressure (parent + C children, each a distinct cache entry to evict).

`Soak.Workload.soakWorkerConfig maxCached tq` = `provideCallStack $ configure ()
(discoverDefinitions @() $$(discoverInstances) $$(discoverInstances)) $ …` with discarding logger,
`setNamespace`/`setTaskQueue`, and the leak lever **`setMaxCachedWorkflows`** set *low* (default 32)
so the cache churns and eviction runs hard within a short soak. Reuses `fixtureNs` from `Bench.Common`.

Execution mixes archetypes round-robin (configurable ratio; default 3 outbox : 1 sync).

## Run loop (`Soak.hs`)

```
parse args
start dev server (withDevServer) + worker (startWorker) + workflow client
WARMUP: run `--warmup` executions (bounded concurrency) to fill the cache to steady state
sample baseline residency
loop:
  run a BATCH of `--sample-every` executions at bounded `--concurrency` (pooledForConcurrentlyN),
    each a unique wfId, archetype chosen round-robin
  done += batch
  performGC; sample residency; append a row
  stop when  (iterations mode) done >= N   OR   (duration mode) elapsed >= T
write residency.csv; print tail
```

- **Concurrency** (`--concurrency`, default 16): fires multiple executions in flight so the worker
  actually caches several instances at once (cache pressure vs `maxCachedWorkflows` is the point).
  `UnliftIO.Async.pooledForConcurrentlyN`.
- **Batches = sampling cadence:** sampling after each batch of `--sample-every` (default 200)
  executions gives an even residency time series without a separate sampler thread.
- **Modes:** `--iterations N` (default, e.g. 5000 — repeatable/comparable) and `--duration 10m`
  (real soak). Mutually exclusive; iterations is the default when neither is given.
- `WorkflowIdReusePolicyAllowDuplicate` + monotonic unique ids (`soak-<archetype>-<n>`).

## Metrics & `residency.csv`

One row per sample (post-GC):

| column | source |
|---|---|
| `elapsed_ms` | wall clock since loop start |
| `executions_done` | cumulative count (the slope's x-axis) |
| `live_bytes` | `gcdetails_live_bytes (gc stats)` — Haskell heap, post-GC |
| `max_live_bytes` | `max_live_bytes stats` — peak Haskell live (monotone) |
| `rts_mem_in_use_bytes` | `gcdetails_mem_in_use_bytes (gc stats)` — RTS heap incl. slop |
| `rss_bytes` | `ps -o rss= -p <pid>` × 1024 — total process (catches Rust core) |
| `evictions` | cumulative count drained from `subscribeToEvictions` TChan |

## Leak signal — slope + samples (mechanical, in `soak.sh`)

Same philosophy as `report.sh`: raw data from the tool, verdict from a fixed formula, no prose
interpretation. `soak.sh` fits an ordinary-least-squares line to the **post-warmup** samples via
`awk`:

- `slope_live_bytes_per_exec` over (`executions_done`, `live_bytes`)
- `slope_rss_bytes_per_exec` over (`executions_done`, `rss_bytes`)

Emits `summary.csv` (`metric, slope_bytes_per_exec, r_squared, first, last, delta, n_samples`) and a
**verdict**: flags a leak if a slope exceeds `--slope-threshold` (default e.g. 512 B/exec) *and* R²
is high enough to be a real trend (default 0.8) — the R² guard stops GC sawtooth noise from
tripping a false positive. Exit nonzero on flag when `--gate` is passed (CI-able). Reporting live
and RSS separately answers *which side* is leaking.

## Build config — `cabal.project.soak`

```
import: cabal.project
optimization: 2
package temporal-sdk        { ghc-options: -finfo-table-map -fdistinct-constructor-tables }
package temporal-sdk-core   { ghc-options: -finfo-table-map -fdistinct-constructor-tables }
```

No `profiling: True` — info-table maps add negligible *runtime* overhead (static tables in the
binary), so residency is **undistorted**, unlike a `-prof` build. This one config serves both:
- **detection** (default): `+RTS -T` → `GHC.Stats` residency slope.
- **attribution** (`soak.sh --mode heap`): `+RTS -hi -l-au -ol<f>.eventlog` → `eventlog2html` shows
  *what closures by source location* are retained — no cost centres needed (that's what
  `-finfo-table-map` buys). Reuses the eventlog handling from `profile.sh`.

## `scripts/perf/soak.sh`

Sources `_common.sh`. Builds `temporal-sdk-soak` under `cabal.project.soak`, runs it (needs
`temporal` on PATH — preflight like `record-fixtures.sh`), writes to `perf-out/soak/<run-id>/`.
Args pass through: `--iterations/--duration/--concurrency/--sample-every/--warmup/--max-cached/
--ratio/--slope-threshold/--gate/--mode plain|heap`. `run.json` records `build: soak`. Computes the
slope/verdict from `residency.csv` at the end.

## Cabal stanza + integration

New `executable temporal-sdk-soak` in `sdk/package.yaml` (+ hand-synced `temporal-sdk.cabal`, no
hpack on PATH). `source-dirs: bench`, `other-modules: Bench.Common, Bench.Stats, Soak.Workload`,
`ghc-options: -threaded -rtsopts "-with-rtsopts=-T -N"`. Deps ≈ the record stanza (base, temporal-sdk,
temporal-sdk-core, text, directory, monad-logger, mtl, unliftio, require-callstack) + whatever the
workload/args parsing needs. Coexists with the two existing stanzas; the allocation gate is untouched.

## Open questions for Fable

1. **RSS worth it?** Shell-out `ps` per sample to catch Rust-core/native leaks, or keep it
   Haskell-heap-only and accept we only see Haskell-side retention? (My lean: keep RSS — cheap, and
   distinguishing Haskell vs core is the whole diagnostic value.)
2. **Child workflows in the sync archetype** — do they over-weight cache pressure vs a simpler
   fan-out of concurrent *activities*? Which better models "scheduled-sync"?
3. **Slope robustness** — is OLS + R² guard on post-warmup samples enough, or do we want a
   Theil–Sen / median-based slope to resist GC-sawtooth outliers?
4. **Warmup sizing** — fixed count vs. "until live-bytes stabilizes across K samples"?
5. **`maxCachedWorkflows` default** — 32 to force eviction fast, or mirror prod's setting? A leak on
   the eviction path only shows if eviction actually runs.
6. Anything structurally wrong with driving a real (non-replay) worker + client in-process for long
   runs — GC interaction, client backpressure, dev-server limits at high `--iterations`.

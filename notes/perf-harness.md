# Performance benchmark harness — runbook + baseline

**Status:** initial macro harness landed · **Baseline commit:** `3e84de79` (main) · **Opt level:** `-O`

Companion to `notes/perf-optimization-plan.md`. This is the measurement scaffold that
work item "profiling harness" in the plan calls for. Allocation-first (deterministic);
time is secondary.

See `notes/perf-suite-design.md` for the design rationale and the full script/report
schema. This file is the operational runbook.

## Layout

```
scripts/perf/
  _common.sh          -- sourced prelude (repo-root cd, RUN_ID, run.json)
  bench.sh            -- allocation gate run (+ baseline compare/save)
  profile.sh          -- profiling-build attribution (cc / heap)
  record-fixtures.sh  -- fixture regeneration (needs `temporal` dev server)
  report.sh           -- raw run dir -> report.csv / summary.csv (awk + jq)
cabal.project.bench   -- ENFORCED -O2 measurement build (ignores cabal.project.local)
cabal.project.profiling -- -O2 -fprof-late + info-table maps (attribution)
sdk/bench/
  Bench/Common.hs   -- shared: runtime, workflows, worker config, and the FIXTURE MANIFEST
  Bench/Stats.hs    -- GHC.Stats allocation helper (global/cross-thread, GC-flushed)
  Record.hs         -- fixture recorder (`--list` prints expected paths; needs `temporal`)
  Bench.hs          -- tasty-bench replay driver (server-free; runReplayHistoryProto + raw bytes)
  fixtures/         -- checked-in histories: sleeps-{1,10,100} + fanout-{10,50,100,200,500,1000}
  baselines/        -- committed baselines, one CSV per commit + a CURRENT pointer
perf-out/           -- gitignored: runs/<run-id>/ and profiles/<run-id>/ artifacts
```

Two cabal stanzas in `sdk/package.yaml`: executable `temporal-sdk-bench-record`,
benchmark `temporal-sdk-bench` (dep `tasty-bench`, fetched by cabal — not in the nix
shell, which is fine). The scripts always `cd` to the **repo root** so the
`sdk/bench/fixtures` relative path resolves for record + replay alike.

> **Fixture set = single source of truth.** `Bench.Common.benchFixtures` is the one
> manifest both the recorder and the benchmark read; there is no second size list to
> keep matched by hand. `temporal-sdk-bench-record --list` prints the expected paths.

## Commands

Drive everything through `scripts/perf/`; don't hand-type `cabal` for measurement (a
bare `cabal run temporal-sdk-bench` picks up `cabal.project.local`'s `optimization: 0`
and produces numbers incomparable with the baseline).

```sh
# Record any missing fixtures (needs `temporal` on PATH; idempotent).
scripts/perf/record-fixtures.sh
scripts/perf/record-fixtures.sh --only fanout      # re-record a family
scripts/perf/record-fixtures.sh --force --yes      # re-record ALL (slow)
scripts/perf/record-fixtures.sh --check            # CI: verify all present

# Allocation run (server-free). Writes perf-out/runs/<run-id>/{bench,oneshot,report,summary}.csv
scripts/perf/bench.sh                               # + report vs CURRENT baseline
scripts/perf/bench.sh --gate 2                      # CI: fail if alloc regresses >2%
scripts/perf/bench.sh --save-baseline               # promote this run (clean tree only)
scripts/perf/bench.sh --baseline 3e84de79           # compare vs a specific baseline

# Attribution (profiling build). Writes perf-out/profiles/<run-id>/.
scripts/perf/profile.sh fanout-1000                 # cost-centre -> profile-top.csv
scripts/perf/profile.sh sleeps-100 --mode heap      # info-table heap -> .eventlog

# Report an existing run dir on its own / as a markdown table.
scripts/perf/report.sh perf-out/runs/<run-id> --baseline sdk/bench/baselines/3e84de79.csv --md
```

The equivalent raw invocations (for debugging): the scripts run `cabal run -v0
--project-file=cabal.project.bench temporal-sdk-bench -- --csv <f>` with
`BENCH_ONESHOT_CSV` set, and `BENCH_PROFILE=<key> cabal run
--project-file=cabal.project.profiling temporal-sdk-bench -- +RTS -pj -po<stem> -RTS`.

> **Baseline pending re-record.** `baselines/3e84de79.csv` was captured at `-O`. The
> enforced measurement build is now `-O2`, so the baseline must be re-recorded once at
> `-O2` (`scripts/perf/bench.sh --save-baseline` on a clean checkout of the baseline
> commit) before `CURRENT` is set and the gate is trustworthy. Until then, `bench.sh`
> reports "no baseline resolved" rather than a bogus `-O` vs `-O2` delta.

## What it measures

Two fixture families, both replayed server-free (history fed into the in-process Rust core):
- **`sleeps-seq/N`** — `benchWorkflow`: `N` sequential 1 ms timer sleeps → `N` workflow
  tasks → `N` activations through the Haskell dispatch/apply path. Models a sequential
  state machine (≈ the outbox-worker archetype).
- **`fanout-conc/C`** — parent fans out `C` child workflows concurrently and awaits all.
  Replaying the parent drives its `C`-way concurrent scheduling (children don't run — their
  results come from recorded history). Models a fan-out (≈ the scheduled-sync archetype).

Logger is a no-op (message *construction* still runs — opportunity #2's cost — but nothing
is written). Targets the per-activation macro signal: **#1** (dispatch), **#2** (logging),
**#4** (`Info` rebuild), and — via the profiling build — **#3** (payload encode).

> **Harness correction (important).** The replay path originally called
> `runReplayHistory`, which does `encodeMessage history` **on every call** — re-encoding the
> whole event history via proto-lens (`runBuilder`) to push into the core. That was a
> measurement artifact (a production worker never re-encodes full histories), and profiling
> showed it was **~50%+ of allocation**. Fixed: the benchmark now reads the raw on-disk bytes
> (`readHistoryProtobufFileRaw`) and replays via **`runReplayHistoryProto`** (pushes
> pre-encoded bytes, no re-encode). This removed **~½–¾ of the measured allocation**. All
> numbers below are post-fix.
>
> Also: each `replay` spins up/tears down a full core replay worker, so it is not a cheap
> repeatable action — tasty-bench's adaptive loop would churn workers until the core blocks.
> The benchmark pins `localOption (RelStDev 100)` so tasty accepts the first measurement
> (bounded worker count, safe by default). Consequence: reported *times* are noisy;
> **allocation is the metric** (deterministic — verified byte-identical across repeated runs).

## Baseline (`3e84de79`, `-O`, post-fix, one-shot GHC.Stats — deterministic)

| sequential N | allocated | | fan-out C | allocated |
|---|---|---|---|---|
| 1   | 0.89 MB | | 10   | 2.29 MB |
| 10  | 2.69 MB | | 50   | 7.71 MB |
| 100 | 21.8 MB | | 100  | 13.1 MB |
|     |         | | 200  | 25.8 MB |
|     |         | | 500  | 62.0 MB |
|     |         | | 1000 | 121.6 MB |

**Marginal ≈ 0.21 MB/activation (sequential), ≈ 0.12 MB/child (fan-out)**, both linear
(fan-out c=500→1000 = 1.96× — no O(n²)). These are the numbers Tier-1 (#1/#2/#4) must move;
re-run `--baseline` after each change and watch the `Allocated` column.

(Pre-fix, inflated-by-artifact figures were ~0.42 MB/activation and ~0.47 MB/child — do not
use; superseded.)

## Caveats / next steps

- **#6 run-queue did NOT manifest** in fan-out even at C=1000 (allocation linear) — confirmed
  by both the time-based sweep and the profile. Fan-out-and-await keeps run-queue depth low.
  A yield/`waitCondition`-heavy fixture would be needed to trigger #6, if it's worth it.
- **Recording cost:** sequential 1 ms timers cost ~1 s wall-clock each on the dev server
  (n=100 ≈ 2 min); n capped at 100. Fan-out children complete instantly, so large C is cheap.
- **Profiling build:** `cabal.project.profiling` (`-O2` + `-fprof-late` + info-table maps),
  driven by `scripts/perf/profile.sh <key>` — a `-pj` (JSON) cost-centre profile of one
  fixture in isolation via `BENCH_PROFILE`, parsed mechanically into `profile-top.csv`.
- **Profile headline:** even post-fix, proto-lens command encoding (`runBuilder`/`putVarInt`/
  `$fMessage*`/`lens`) is the largest allocation bucket (~20–25% + lenses) — the real
  per-activation command-completion serialization, which the static Core review under-weighted.
- The one-shot `GHC.Stats` figure and tasty-bench's `Allocated` column agree; either is fine.

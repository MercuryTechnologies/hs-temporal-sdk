# Profiling suite design — hs-temporal-sdk

**Status:** design agreed, implementing · **Consulted:** Fable (architecture) · **Decisions locked:** baseline builds at `-O2`; report generator is `awk`/`jq` (shell), promote to a typed exe only if the logic grows.

Companion to `notes/perf-harness.md` (runbook) and `notes/perf-optimization-plan.md` (the
allocation-optimization work this suite gates). This file is the *why*; the runbook is the *how*.

## Goal

Turn the ad-hoc bench artifacts (hand-driven `cabal run`, a loose baseline CSV, human-prose
profiler output) into a scripted suite where:
1. runs are invoked via `scripts/perf/`, never by hand-typing `cabal`;
2. regenerating fixtures is one scripted step;
3. reports are produced **mechanically** from the tools' own structured output — no model or
   human interpretation of raw profiler text, which can hallucinate or bury the signal.

Two measurement axes, complementary (not substitutes):
- **Replay / allocation** (exists, kept): feed recorded histories into the in-process core,
  measure *bytes allocated per activation* — deterministic, byte-identical across runs,
  CI-gateable. Regression gate for the optimization plan. Its *time* numbers are noise
  (pinned with `RelStDev 100`); allocation is the only signal.
- **Soak / residency** (future, separate): long-lived worker, churning distinct executions,
  *residency over time* to chase the suspected production leak. Not built here — the suite is
  laid out so it slots in without another teardown (see "Soak slot-in").

## Two fragilities this design fixes first

1. **`cabal.project.local` silently changes the opt level.** The untracked `cabal.project.local`
   pins `optimization: 0` for fast dev builds. A plain `cabal run temporal-sdk-bench` therefore
   builds at `-O0`, while the committed baseline was recorded at `-O` — incomparable allocation
   numbers, no error. Fix: a committed **`cabal.project.bench`** (`import: cabal.project` +
   `optimization: 2`). `--project-file` skips the `.local` (same trick `cabal.project.profiling`
   already uses), so the opt level becomes authoritative instead of ambient. **Baseline moves to
   `-O2`** so the gate and the `-O2 -fprof-late` attribution build agree, and neither can miss
   `-O2`-only effects like SPECIALIZE (opportunity #1).
2. **Both harness binaries exit 0 on failure.** `Bench.hs` prints "No history fixtures found" and
   succeeds when fixtures are missing (e.g. wrong cwd — `fixtureDir` is repo-root-relative);
   `Record.hs` catches per-fixture failures with `tryAny`, prints `FAILED …`, still exits 0. A CI
   gate on these passes vacuously. Fix in Haskell: nonzero exit when zero fixtures load / any
   record fails. Scripts additionally pin cwd, but the binaries must not lie about success.

## Layout

```
scripts/perf/
  _common.sh              # sourced prelude (repo-root cd, run-id, run.json helper)
  bench.sh                # allocation gate run (+ baseline compare/save)
  profile.sh              # profiling-build attribution (cost-centre / heap)
  record-fixtures.sh      # fixture regeneration
  report.sh               # raw run dir -> report.csv/summary.csv/profile-top.csv (+ --md)
cabal.project.bench       # NEW: committed -O2, immune to cabal.project.local
cabal.project.profiling   # existing, unchanged
sdk/bench/                # Haskell unchanged in location
  Bench.hs Bench/Common.hs Bench/Stats.hs Record.hs
  fixtures/*.history.bin
  baselines/              # baseline CSVs, one per commit
    3e84de79.csv
    CURRENT               # one line: the sha whose CSV is the active baseline
perf-out/                 # gitignored; all generated artifacts
  runs/<run-id>/          # bench.csv oneshot.csv stdout.log run.json report.csv summary.csv
  profiles/<run-id>/      # <fixture>.prof(json) <fixture>.eventlog rts-s.txt profile-top.csv
```

`run-id` = `<UTC-timestamp>-<short-sha>` (sortable, attributable). Per-run context lives in
`run.json` so the per-row CSV stays lean. Conventions match existing scripts: `#!/usr/bin/env
bash`, `set -euo pipefail`. `_common.sh` cds to repo root (makes `fixtureDir` resolve), computes
`run-id`, detects a dirty tree, and writes `run.json`
(`{run_id, commit, dirty, build, project_file, ghc_version, timestamp}`).

## Scripts

Focused scripts, not one dispatcher — record (needs dev server, minutes), bench (fast, CI), and
profile (slow build) have disjoint dependencies/runtimes/failure modes.

### `bench.sh` — regression gate run
Wraps `cabal run -v0 --project-file=cabal.project.bench temporal-sdk-bench -- --csv <run>/bench.csv`,
with `BENCH_ONESHOT_CSV=<run>/oneshot.csv` exported and stdout teed to `<run>/stdout.log`. Then
invokes `report.sh <run>`.
- `--baseline <file|sha>` — default resolves `sdk/bench/baselines/CURRENT`. Delta is computed by
  `report.sh` from the two CSVs (on the `Allocated` column), **not** by tasty-bench's `--baseline`
  (that gates *time*, which `RelStDev 100` made meaningless).
- `--save-baseline` — copy `bench.csv` to `baselines/<sha>.csv` (named for the current commit)
  and update `CURRENT`.
- `--gate <pct>` — CI entrypoint; exit nonzero if any fixture's allocation regresses beyond `pct`.
- `--pattern <p>` — tasty `-p` passthrough for a subset run (never gates/saves).

### `profile.sh` — attribution run (profiling build)
Args: `<fixture-key>` (`sleeps-<n>` | `fanout-<c>`, validated against `record --list`),
`--mode cc|heap` (default `cc`). Builds first with `--project-file=cabal.project.profiling`
(slow the first time).
- `cc`: `BENCH_PROFILE=<key> cabal run … -- +RTS -pj -po<prof>/<key> -s<prof>/rts-s.txt -RTS`.
  Uses the `BENCH_PROFILE` path (`profileOne` in `Bench.hs`) to attribute only the target fixture,
  and **`-pj` (JSON cost-centre profile)** so the report parses structured output, not `.prof`
  prose. Then writes `profile-top.csv`.
- `heap`: `… +RTS -hi -l-au -ol<prof>/<key>.eventlog -RTS`, then `eventlog2html` if on PATH
  (else print the command). Heap profiles stay a human/visual artifact — out of the CSV report;
  this is the piece the soak harness reuses.

`run.json` records `build: profiling`; `report.sh` refuses cross-build deltas (cost-centre
overhead inflates allocation, per `cabal.project.profiling`'s own note).

### `record-fixtures.sh` — fixture regeneration
- (no args) record any missing fixtures (recorder is idempotent/skips existing).
- `--only <key|family>` — delete matching fixtures then record (delete-then-run is the selective
  regen mechanism; recorder skips-if-exists).
- `--force` — delete all then record; requires `--yes`; prints the wall-clock warning (sequential
  timers ~1 s each; `sleeps-100` ≈ 2 min).
- `--check` — verify every expected fixture exists (CI-friendly; no recording).

Preflight `command -v temporal` with an actionable error *before* deleting anything. Documents in
`--help`: regenerated histories shift byte counts, so **regen + re-baseline belong in one commit**.

### `report.sh` — mechanical report (`awk` + `jq`)
`report.sh <run-dir> [--baseline <csv>] [--fail-if-alloc-regress <pct>] [--md]`. Every number is
copied verbatim from a tool-emitted structured file or a fixed formula; rows sorted `(family,
size)`; fixed decimal formatting; run context from `run.json`. No step interprets prose. Outputs:

- **`report.csv`** — one row per fixture, joining `bench.csv`
  (`Name,Mean (ps),2*Stdev (ps),Allocated,Copied,Peak Memory`) with `oneshot.csv` on the
  `All.replay/<family>.<size>` key, plus `run.json`:

  | column | source |
  |---|---|
  | `commit`, `dirty`, `timestamp`, `build`, `opt` | run.json |
  | `family`, `size` | parsed from tasty `Name` |
  | `alloc_oneshot_bytes` | oneshot.csv (GHC.Stats) — headline deterministic figure |
  | `alloc_tasty_bytes`, `copied_bytes`, `peak_mem_bytes` | bench.csv |
  | `alloc_per_unit_bytes` | computed = oneshot / size |
  | `baseline_alloc_bytes`, `alloc_delta_bytes`, `alloc_delta_pct` | join vs baseline `Allocated` |
  | `mean_time_ms_NOISY`, `stdev2_ms_NOISY` | bench.csv (name flags them as advisory-only) |

  One-shot vs tasty allocation should agree (per the runbook); report warns if they diverge >5%.

- **`summary.csv`** — one row per family: `marginal_alloc_bytes_per_unit` (slope between the two
  largest sizes — the "0.21 MB/activation, 0.12 MB/child" number), `baseline_marginal`,
  `delta_pct`. This is the figure tracked against the optimization plan's Tier-1 items.

- **`profile-top.csv`** (cc mode) — from `-pj` JSON via `jq`: `fixture, commit, rank, cost_centre,
  module, src_loc, alloc_pct_inherited, time_pct_inherited, alloc_pct_individual`; top 30 by
  individual alloc, ties broken by name (stable). Mechanizes the "proto-lens `runBuilder` ~20-25%"
  headline currently hand-extracted.

`--md` renders the same rows as a GitHub table for notes/PRs. Gate mode exits 1 if any fixture's
`alloc_delta_pct` exceeds the threshold; refuses to compare across differing `build`.

## Haskell changes (backward compatible, no new modules/deps)

1. **Single fixture manifest** in `Bench/Common.hs` (`benchFixtures :: [Fixture]`), consumed by
   `Record.hs` and `Bench.hs` — deletes the duplicated `sizes`/`fanoutSizes` and the "must match
   the recorder" comment.
2. **`BENCH_ONESHOT_CSV`** in `Bench.hs`: when set, write `family,size,allocated_bytes` there in
   addition to the existing stdout lines. Env var (tasty owns argv — same pattern as `BENCH_PROFILE`).
3. **`--list`** on `temporal-sdk-bench-record`: print expected fixture paths, one per line, from
   the manifest. Consumed by `record-fixtures.sh --check/--only` and `profile.sh` key validation —
   scripts never re-encode size lists.
4. **Honest exit codes**: `Bench.hs` exits nonzero when zero fixtures load; `Record.hs` counts
   `tryAny` failures and `exitFailure` if any.

## Integration & soak slot-in

- Three committed project files with distinct roles: `cabal.project` (dev, may be overridden by
  `.local`), `cabal.project.bench` (`-O2`, measurement/gate), `cabal.project.profiling`
  (`-O2 -fprof-late` + info-table maps, attribution). Both measurement and attribution are immune
  to `.local`.
- Cabal stanzas untouched (no new modules/deps). Hand-driving `cabal run` still works; the runbook
  keeps one "what the scripts run" block for debuggability.
- **Soak:** a future `temporal-sdk-bench-soak` exe reuses `Bench/Common.hs` wholesale (already
  serves record + replay). It gets `scripts/perf/soak.sh` sourcing `_common.sh`, writes to
  `perf-out/soak/<run-id>/`, and extends the report with a `residency.csv` table (allocation gate
  untouched). Factor the eventlog handling out of `profile.sh --mode heap` into `_common.sh` now so
  soak reuses it. Soak likely wants residency under a non-prof `-finfo-table-map` build (prof
  overhead distorts residency) — a possible fourth project file, decided when soak is designed.
- **CI gate:** `scripts/perf/bench.sh --gate <pct>` — server-free, deterministic, no `temporal`
  binary needed. `record-fixtures.sh --check` can also run in CI.

## Migration (do moves before first commit to avoid rename churn)

1. `git mv sdk/bench/baseline-3e84de79.csv sdk/bench/baselines/3e84de79.csv`; add `baselines/CURRENT`.
2. `.gitignore`: add `perf-out/`, `*.prof`, `*.eventlog`, `*.hp`, eventlog2html HTML.
3. Add `cabal.project.bench`; land the four Haskell changes.
4. Add `scripts/perf/*`.
5. Update `notes/perf-harness.md`: replace hand-cabal "Commands" with script invocations (keep one
   raw block); fix the layout tree and the baseline path.
6. **Re-record the baseline once** under `cabal.project.bench` (`bench.sh --save-baseline`) so the
   `-O2` enforcement is structural, not just documented. Keep `3e84de79.csv` until it lands.

## Risks / open questions

- **`-pj` JSON shape** — stable since GHC 8.x, but verify the `jq` paths against this repo's GHC
  before committing the parser; sanity-check individual-vs-inherited alloc ranking on one real profile.
- **`jq` / `eventlog2html` in the dev shell** — report assumes `jq` (confirm it's present / add it);
  `eventlog2html` is optional-with-instructions.
- **Fixture regen shifts baselines** — new histories → slightly different byte counts; "regen +
  re-baseline in one commit" must be loud in `--help` and the runbook.
- **Determinism scope** — "byte-identical allocation" is asserted per fixture set on one machine;
  the gate threshold (start ~2%) absorbs environment drift; tune after a few CI runs.

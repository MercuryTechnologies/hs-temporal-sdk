#!/usr/bin/env bash
# Allocation benchmark run — the regression gate for notes/perf-optimization-plan.md.
#
# Builds/runs the replay benchmark at an ENFORCED -O2 (cabal.project.bench, which
# ignores cabal.project.local), captures both the tasty-bench CSV and the
# deterministic one-shot GHC.Stats CSV, then produces a mechanical report.
#
#   scripts/perf/bench.sh                         # run + report vs CURRENT baseline
#   scripts/perf/bench.sh --save-baseline         # run + promote this run to baseline
#   scripts/perf/bench.sh --gate 2                # run + fail if alloc regresses >2%
#   scripts/perf/bench.sh --baseline 3e84de79     # compare vs a specific baseline
#   scripts/perf/bench.sh --pattern fanout        # subset run (never gates/saves)
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/_common.sh"

PROJECT_FILE="cabal.project.bench"
BASELINE_DIR="sdk/bench/baselines"

BASELINE=""
SAVE_BASELINE=false
GATE_PCT=""
PATTERN=""

usage() { sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --baseline) BASELINE="${2:?--baseline needs a value}"; shift 2 ;;
    --save-baseline) SAVE_BASELINE=true; shift ;;
    --gate) GATE_PCT="${2:?--gate needs a percentage}"; shift 2 ;;
    --pattern) PATTERN="${2:?--pattern needs a value}"; shift 2 ;;
    -h | --help) usage; exit 0 ;;
    *) die "unknown arg: $1 (see --help)" ;;
  esac
done

if $SAVE_BASELINE && [[ -n "$GATE_PCT" ]]; then
  die "--save-baseline and --gate are mutually exclusive (gating against a just-saved baseline is a no-op)"
fi
if [[ -n "$PATTERN" ]] && { $SAVE_BASELINE || [[ -n "$GATE_PCT" ]]; }; then
  die "--pattern runs a subset; it cannot be combined with --save-baseline or --gate"
fi

# Resolve a baseline reference to a CSV path (empty string = none).
resolve_baseline() {
  local b="$1"
  if [[ -z "$b" ]]; then
    if [[ -f "$BASELINE_DIR/CURRENT" ]]; then
      local sha
      sha="$(tr -d '[:space:]' <"$BASELINE_DIR/CURRENT")"
      [[ -n "$sha" && -f "$BASELINE_DIR/$sha.csv" ]] && echo "$BASELINE_DIR/$sha.csv"
    fi
  elif [[ -f "$b" ]]; then
    echo "$b"
  elif [[ -f "$BASELINE_DIR/$b.csv" ]]; then
    echo "$BASELINE_DIR/$b.csv"
  fi
}

RUN_DIR="$PERF_OUT/runs/$RUN_ID"
mkdir -p "$RUN_DIR"
write_run_json "$RUN_DIR" "bench" "$PROJECT_FILE"
log "run $RUN_ID -> $RUN_DIR"

TASTY_ARGS=(--csv "$RUN_DIR/bench.csv")
[[ -n "$PATTERN" ]] && TASTY_ARGS+=(--pattern "$PATTERN")

log "building + running benchmark at -O2 ($PROJECT_FILE)…"
BENCH_ONESHOT_CSV="$RUN_DIR/oneshot.csv" \
  cabal run -v0 --project-file="$PROJECT_FILE" temporal-sdk-bench -- "${TASTY_ARGS[@]}" \
  2>&1 | tee "$RUN_DIR/stdout.log"

if $SAVE_BASELINE; then
  mkdir -p "$BASELINE_DIR"
  cp "$RUN_DIR/bench.csv" "$BASELINE_DIR/$COMMIT_SHORT.csv"
  echo "$COMMIT_SHORT" >"$BASELINE_DIR/CURRENT"
  log "saved baseline $BASELINE_DIR/$COMMIT_SHORT.csv; CURRENT -> $COMMIT_SHORT"
fi

REPORT_ARGS=("$RUN_DIR")
if ! $SAVE_BASELINE; then
  RESOLVED="$(resolve_baseline "$BASELINE")"
  if [[ -n "$RESOLVED" ]]; then
    REPORT_ARGS+=(--baseline "$RESOLVED")
    log "baseline: $RESOLVED"
  else
    [[ -n "$GATE_PCT" ]] && die "--gate requires a baseline, but none was resolved (record one with --save-baseline)"
    warn "no baseline resolved; delta columns will be blank"
  fi
fi
[[ -n "$GATE_PCT" ]] && REPORT_ARGS+=(--fail-if-alloc-regress "$GATE_PCT")

exec "$REPO_ROOT/scripts/perf/report.sh" "${REPORT_ARGS[@]}"

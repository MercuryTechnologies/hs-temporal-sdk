#!/usr/bin/env bash
# Attribution run on the profiling build (cabal.project.profiling: -O2
# -fprof-late + info-table maps). Two modes:
#   cc   (default) cost-centre profile -> profile-top.csv (WHERE allocation goes)
#   heap           info-table heap profile -> <key>.eventlog (WHAT is on the heap)
#
# Under -prof, timings are inflated and allocation is slightly higher (cost-centre
# overhead) — use this for ATTRIBUTION only; bench.sh gives the headline numbers.
#
#   scripts/perf/profile.sh fanout-1000            # cost-centre profile
#   scripts/perf/profile.sh sleeps-100 --mode heap # info-table heap profile
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/_common.sh"

PROJECT_FILE="cabal.project.profiling"
MODE=cc
KEY=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode) MODE="${2:?}"; shift 2 ;;
    -h | --help) sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) die "unknown flag: $1" ;;
    *) KEY="$1"; shift ;;
  esac
done
[[ -n "$KEY" ]] || die "usage: profile.sh <fixture-key> [--mode cc|heap]"

# Valid keys = fixture filename stems on disk (no build needed to validate).
valid_keys() { ls sdk/bench/fixtures/*.history.bin 2>/dev/null | sed -E 's#.*/##; s#\.history\.bin$##'; }
if ! valid_keys | grep -qx "$KEY"; then
  die "unknown fixture key '$KEY'. Available: $(valid_keys | paste -sd' ' -)"
fi

PROF_DIR="$PERF_OUT/profiles/$RUN_ID"
mkdir -p "$PROF_DIR"
write_run_json "$PROF_DIR" "profiling" "$PROJECT_FILE"

log "building profiling benchmark (slow on first run — builds profiled deps)…"
cabal build -v0 --project-file="$PROJECT_FILE" temporal-sdk-bench

# Emit the top allocators from a GHC -pj (JSON) cost-centre profile as CSV.
# Ranks cost centres by INDIVIDUAL allocation (aggregated across tree nodes).
# Inherited alloc is intentionally omitted: aggregating it across recursive
# occurrences of the same centre is ambiguous, and a dubious number is worse
# than none for a report meant to be trusted verbatim.
make_profile_top() {
  local prof_json="$1" out="$2"
  echo "fixture,commit,rank,cost_centre,module,src_loc,alloc_bytes_individual,alloc_pct_individual,ticks_individual,time_pct_individual" >"$out"
  jq -r --arg fixture "$KEY" --arg commit "$COMMIT_SHORT" '
    def walk: ., (.children[]? | walk);
    (.total_alloc // 0) as $ta
    | (.total_ticks // 0) as $tt
    | (reduce (.cost_centres[]?) as $c ({}; .[$c.id | tostring] = $c)) as $cc
    | [ .profile | walk | {id: .id, alloc: (.alloc // 0), ticks: (.ticks // 0)} ]
    | group_by(.id)
    | map({id: .[0].id, alloc: (map(.alloc) | add), ticks: (map(.ticks) | add)})
    | sort_by(-.alloc)
    | .[0:30]
    | to_entries[]
    | .key as $rank | .value as $v | $cc[($v.id | tostring)] as $c
    | [ $fixture, $commit, ($rank + 1),
        ($c.label // "?"), ($c.module // "?"), ($c.src_loc // "?"),
        $v.alloc,
        (if $ta > 0 then ((($v.alloc * 10000 / $ta) | round) / 100) else 0 end),
        $v.ticks,
        (if $tt > 0 then ((($v.ticks * 10000 / $tt) | round) / 100) else 0 end) ]
    | @csv
  ' "$prof_json" >>"$out"
}

case "$MODE" in
  cc)
    log "cost-centre profile: $KEY"
    BENCH_PROFILE="$KEY" cabal run -v0 --project-file="$PROJECT_FILE" temporal-sdk-bench -- \
      +RTS -pj "-po$PROF_DIR/$KEY" "-s$PROF_DIR/rts-s.txt" -RTS
    if [[ -f "$PROF_DIR/$KEY.prof" ]]; then
      if make_profile_top "$PROF_DIR/$KEY.prof" "$PROF_DIR/profile-top.csv"; then
        log "wrote $PROF_DIR/profile-top.csv"
        column -t -s, "$PROF_DIR/profile-top.csv" 2>/dev/null || cat "$PROF_DIR/profile-top.csv"
      else
        warn "could not parse $PROF_DIR/$KEY.prof as -pj JSON — inspect it directly (schema may differ on this GHC)"
      fi
    else
      die "expected profile $PROF_DIR/$KEY.prof was not produced"
    fi
    ;;
  heap)
    log "info-table heap profile: $KEY"
    BENCH_PROFILE="$KEY" cabal run -v0 --project-file="$PROJECT_FILE" temporal-sdk-bench -- \
      +RTS -hi -l-au "-ol$PROF_DIR/$KEY.eventlog" -RTS
    log "wrote $PROF_DIR/$KEY.eventlog"
    if command -v eventlog2html >/dev/null 2>&1; then
      eventlog2html "$PROF_DIR/$KEY.eventlog"
      log "wrote $PROF_DIR/$KEY.eventlog.html"
    else
      warn "eventlog2html not on PATH; view manually: eventlog2html $PROF_DIR/$KEY.eventlog"
    fi
    ;;
  *) die "unknown mode: $MODE (want cc|heap)" ;;
esac

#!/usr/bin/env bash
# Soak / leak-detection run. Builds the harness under cabal.project.soak (-O2 +
# info-table-map, NO profiling → undistorted residency), runs a long-lived worker
# firing many distinct executions against a local dev server, then fits a residency
# slope and issues a verdict. Needs a `temporal` dev server on PATH.
#
#   scripts/perf/soak.sh                          # 5000 executions, report + verdict
#   scripts/perf/soak.sh --iterations 20000 --gate # fail (exit 1) on a detected leak
#   scripts/perf/soak.sh --duration 600           # 10-minute time-bounded soak
#   scripts/perf/soak.sh --max-cached 200         # mirror a prod cache size
#   scripts/perf/soak.sh --iterations 8000 --mode heap  # + info-table heap eventlog
#
# Primary signal: Haskell live-bytes slope (bytes/execution) — gates. RSS slope is
# reported but advisory (conflates allocator fragmentation with true native leaks).
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/_common.sh"

PROJECT_FILE="cabal.project.soak"
MODE=plain
GATE=false
SLOPE_THRESHOLD=512   # bytes/exec (live) — FAIL/WARN boundary
R2_MIN=0.8            # min R² for a FAIL (else WARN: grew but not linear)
MIN_SAMPLES=10        # min post-warmup samples before any verdict
EXE_ARGS=()

usage() { sed -n '2,16p' "$0" | sed 's/^# \{0,1\}//'; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode) MODE="${2:?}"; shift 2 ;;
    --gate) GATE=true; shift ;;
    --slope-threshold) SLOPE_THRESHOLD="${2:?}"; shift 2 ;;
    --r2-min) R2_MIN="${2:?}"; shift 2 ;;
    --iterations | --duration | --concurrency | --sample-every | --warmup | --max-cached | --outbox-k | --fanout-c | --ratio | --timer)
      EXE_ARGS+=("$1" "${2:?}"); shift 2 ;;
    -h | --help) usage; exit 0 ;;
    *) die "unknown arg: $1 (see --help)" ;;
  esac
done

command -v temporal >/dev/null 2>&1 \
  || die "'temporal' not found on PATH — install the Temporal CLI / enter the dev shell first"

OUT="$PERF_OUT/soak/$RUN_ID"
mkdir -p "$OUT"
write_run_json "$OUT" "soak" "$PROJECT_FILE"
EXE_ARGS+=(--out "$OUT")

log "building soak harness (-O2 + info-table-map, non-prof)…"
cabal build -v0 --project-file="$PROJECT_FILE" temporal-sdk-soak

RTS=()
[[ "$MODE" == heap ]] && RTS=(+RTS -hi -l-au "-ol$OUT/soak.eventlog" -RTS)

log "soak run $RUN_ID -> $OUT"
cabal run -v0 --project-file="$PROJECT_FILE" temporal-sdk-soak -- "${EXE_ARGS[@]}" "${RTS[@]}" \
  2>&1 | tee "$OUT/stdout.log"

[[ "$MODE" == heap && -f "$OUT/soak.eventlog" ]] && render_eventlog "$OUT/soak.eventlog"

CSV="$OUT/residency.csv"
[[ -f "$CSV" ]] || die "no residency.csv produced at $CSV"

# Ordinary-least-squares slope + R² over post-warmup samples. $2 = executions_done
# (x); column $ycol = y. Skips rows with an empty y (RSS can be blank). Emits:
#   slope r2 n first last
ols() {
  awk -F, -v ycol="$2" '
    NR > 1 {
      ys = $ycol; if (ys == "") next
      y = ys + 0; x = $2 + 0
      n++; sx += x; sy += y; sxx += x * x; sxy += x * y; syy += y * y
      if (n == 1) first = y; last = y
    }
    END {
      if (n < 2) { printf "0 0 %d %.0f %.0f\n", n + 0, first + 0, last + 0; exit }
      denom = n * sxx - sx * sx
      slope = (denom != 0) ? (n * sxy - sx * sy) / denom : 0
      rden = sqrt((n * sxx - sx * sx) * (n * syy - sy * sy))
      r = (rden != 0) ? (n * sxy - sx * sy) / rden : 0
      printf "%.4f %.4f %d %.0f %.0f\n", slope, r * r, n, first, last
    }' "$1"
}

read -r slope_live r2_live n_live first_live last_live < <(ols "$CSV" 3)
read -r slope_rss r2_rss n_rss first_rss last_rss < <(ols "$CSV" 6)

SUMMARY="$OUT/summary.csv"
{
  echo "metric,slope_bytes_per_exec,r_squared,n_samples,first_bytes,last_bytes,delta_bytes"
  echo "live_bytes,$slope_live,$r2_live,$n_live,$first_live,$last_live,$((last_live - first_live))"
  echo "rss_bytes,$slope_rss,$r2_rss,$n_rss,$first_rss,$last_rss,$((last_rss - first_rss))"
} >"$SUMMARY"

# Verdict from the LIVE slope only (RSS is advisory).
verdict=OK
if awk "BEGIN{ exit !($slope_live > $SLOPE_THRESHOLD) }"; then
  if awk "BEGIN{ exit !($r2_live >= $R2_MIN && $n_live >= $MIN_SAMPLES) }"; then
    verdict=FAIL
  else
    verdict=WARN
  fi
fi

log "wrote $SUMMARY"
column -t -s, "$SUMMARY" 2>/dev/null || cat "$SUMMARY"
echo
case "$verdict" in
  FAIL) warn "VERDICT: FAIL — live-heap grew ${slope_live} B/exec (R²=${r2_live}, n=${n_live}) > ${SLOPE_THRESHOLD}" ;;
  WARN) warn "VERDICT: WARN — live-heap slope ${slope_live} B/exec but R²=${r2_live} / n=${n_live}; inspect $CSV (or --mode heap)" ;;
  OK) log "VERDICT: OK — live-heap slope ${slope_live} B/exec (R²=${r2_live}, n=${n_live}) <= ${SLOPE_THRESHOLD}" ;;
esac
log "RSS slope ${slope_rss} B/exec (advisory; R²=${r2_rss})"

if $GATE && [[ "$verdict" == FAIL ]]; then
  die "leak gate: FAIL"
fi
exit 0

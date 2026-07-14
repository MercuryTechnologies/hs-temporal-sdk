#!/usr/bin/env bash
# Mechanical report generator. Turns a bench run directory into deterministic,
# machine-readable CSVs. Every number is copied verbatim from a tool-emitted
# structured file (tasty-bench --csv, the one-shot GHC.Stats CSV) or a fixed
# formula — NOTHING is parsed from human-readable prose, so there is no room for
# interpretation/hallucination.
#
# Inputs (in <run-dir>): bench.csv, oneshot.csv, run.json
# Outputs (in <run-dir>): report.csv, summary.csv
#
#   scripts/perf/report.sh <run-dir> [--baseline <csv>] \
#     [--fail-if-alloc-regress <pct>] [--md]
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/_common.sh"

command -v jq >/dev/null 2>&1 || die "jq is required (add it to the dev shell)"

RUN_DIR=""
BASELINE_CSV=""
GATE_PCT=""
EMIT_MD=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --baseline) BASELINE_CSV="${2:?}"; shift 2 ;;
    --fail-if-alloc-regress) GATE_PCT="${2:?}"; shift 2 ;;
    --md) EMIT_MD=true; shift ;;
    -h | --help) sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) die "unknown flag: $1" ;;
    *) RUN_DIR="$1"; shift ;;
  esac
done

[[ -n "$RUN_DIR" && -d "$RUN_DIR" ]] || die "usage: report.sh <run-dir> [...]"
BENCH="$RUN_DIR/bench.csv"
ONESHOT="$RUN_DIR/oneshot.csv"
RUN_JSON="$RUN_DIR/run.json"
[[ -f "$BENCH" ]] || die "missing $BENCH"
[[ -f "$RUN_JSON" ]] || die "missing $RUN_JSON"
[[ -f "$ONESHOT" ]] || warn "no $ONESHOT — alloc_oneshot columns will be blank"

# --- run-level context (from our own run.json; not from tool prose) ---
R_COMMIT="$(jq -r '.commit_short' "$RUN_JSON")"
R_DIRTY="$(jq -r '.dirty' "$RUN_JSON")"
R_TS="$(jq -r '.timestamp' "$RUN_JSON")"
R_BUILD="$(jq -r '.build' "$RUN_JSON")"
R_PROJ="$(jq -r '.project_file' "$RUN_JSON")"
case "$R_PROJ" in
  *bench*) R_OPT="O2" ;;
  *profiling*) R_OPT="O2-prof" ;;
  *) R_OPT="unknown" ;;
esac

# A baseline is only meaningful against a same-build (bench) run.
if [[ -n "$BASELINE_CSV" && "$R_BUILD" != "bench" ]]; then
  warn "run build is '$R_BUILD', not 'bench'; ignoring baseline (cross-build deltas are meaningless)"
  BASELINE_CSV=""
fi
[[ -n "$BASELINE_CSV" && ! -f "$BASELINE_CSV" ]] && die "baseline not found: $BASELINE_CSV"

REPORT="$RUN_DIR/report.csv"
SUMMARY="$RUN_DIR/summary.csv"

REPORT_HEADER="commit,dirty,timestamp,build,opt,family,size,alloc_oneshot_bytes,alloc_tasty_bytes,copied_bytes,peak_mem_bytes,alloc_per_unit_bytes,baseline_alloc_bytes,alloc_delta_bytes,alloc_delta_pct,mean_time_ms_NOISY,stdev2_ms_NOISY"

# Files fed to awk; routed by exact FILENAME match inside the program.
AWK_FILES=()
[[ -f "$ONESHOT" ]] && AWK_FILES+=("$ONESHOT")
[[ -n "$BASELINE_CSV" ]] && AWK_FILES+=("$BASELINE_CSV")
AWK_FILES+=("$BENCH")

{
  echo "$REPORT_HEADER"
  awk -F, \
    -v onefile="$ONESHOT" -v basefile="$BASELINE_CSV" -v benchfile="$BENCH" \
    -v commit="$R_COMMIT" -v dirty="$R_DIRTY" -v ts="$R_TS" -v build="$R_BUILD" -v opt="$R_OPT" '
    # oneshot.csv: family,size,allocated_bytes
    FILENAME == onefile && FNR > 1 { one[$1 SUBSEP $2] = $3; next }
    # baseline: tasty-bench CSV, key by Name (col1) -> Allocated (col4)
    basefile != "" && FILENAME == basefile && FNR > 1 { base[$1] = $4; next }
    # bench.csv (tasty-bench): Name,Mean(ps),2*Stdev(ps),Allocated,Copied,Peak
    FILENAME == benchfile && FNR > 1 {
      name = $1; meanps = $2; stdps = $3; alloc = $4; copied = $5; peak = $6
      fam = name; sub(/^.*\//, "", fam); n = split(fam, a, ".")
      family = a[1]; size = a[2]
      oneshot = ((family SUBSEP size) in one) ? one[family SUBSEP size] : ""
      perunit = (size + 0 > 0 && oneshot != "") ? sprintf("%.1f", oneshot / size) : ""
      if (name in base) {
        balloc = base[name]; ddelta = alloc - balloc
        dpct = (balloc + 0 > 0) ? sprintf("%.2f", (alloc - balloc) / balloc * 100) : ""
      } else { balloc = ""; ddelta = ""; dpct = "" }
      meanms = sprintf("%.3f", meanps / 1e9)
      stdms = sprintf("%.3f", stdps / 1e9)
      # cross-check: one-shot vs tasty allocation should agree (runbook claim).
      # Require BOTH a >5% relative gap AND a >256KB absolute gap: sub-MB fixtures
      # carry fixed tasty-harness overhead that inflates the relative gap without
      # signalling a real disagreement.
      if (oneshot != "" && alloc + 0 > 0) {
        d = (oneshot - alloc); if (d < 0) d = -d
        if (d / alloc > 0.05 && d > 262144)
          printf("[perf] WARN %s: one-shot alloc %s vs tasty %s diverge >5%% (%d bytes)\n", name, oneshot, alloc, d) > "/dev/stderr"
      }
      print commit","dirty","ts","build","opt","family","size","oneshot","alloc","copied","peak","perunit","balloc","ddelta","dpct","meanms","stdms
    }
  ' "${AWK_FILES[@]}" | sort -t, -k6,6 -k7,7n
} >"$REPORT"

# --- summary.csv: marginal allocation (slope between the two largest sizes) ---
# Uses tasty Allocated for both current and baseline so the two are comparable.
{
  echo "family,marginal_alloc_bytes_per_unit,baseline_marginal,delta_pct"
  awk -F, 'NR > 1 {
    fam = $6; size = $7 + 0; tasty = $9 + 0; base = $13
    if (size > m1s[fam]) {
      m2s[fam] = m1s[fam]; m2t[fam] = m1t[fam]; m2b[fam] = m1b[fam]
      m1s[fam] = size; m1t[fam] = tasty; m1b[fam] = base
    } else if (size > m2s[fam]) {
      m2s[fam] = size; m2t[fam] = tasty; m2b[fam] = base
    }
    fams[fam] = 1
  }
  END {
    for (f in fams) {
      if (m2s[f] + 0 <= 0) continue   # need two distinct sizes
      ds = m1s[f] - m2s[f]
      marg = sprintf("%.1f", (m1t[f] - m2t[f]) / ds)
      if (m1b[f] != "" && m2b[f] != "") {
        bmarg = (m1b[f] - m2b[f]) / ds
        dpct = (bmarg > 0) ? sprintf("%.2f", ((m1t[f] - m2t[f]) / ds - bmarg) / bmarg * 100) : ""
        bmargs = sprintf("%.1f", bmarg)
      } else { bmargs = ""; dpct = "" }
      print f","marg","bmargs","dpct
    }
  }' "$REPORT" | sort -t, -k1,1
} >"$SUMMARY"

log "wrote $REPORT"
log "wrote $SUMMARY"

# Human-facing echo (advisory; the CSVs are the source of truth).
if $EMIT_MD; then
  awk -F, 'NR==1 { for (i=1;i<=NF;i++) printf "| %s ", $i; print "|";
                   for (i=1;i<=NF;i++) printf "|---"; print "|"; next }
           { for (i=1;i<=NF;i++) printf "| %s ", $i; print "|" }' "$REPORT"
else
  column -t -s, "$REPORT" 2>/dev/null || cat "$REPORT"
fi

# --- gate ---
if [[ -n "$GATE_PCT" ]]; then
  worst="$(awk -F, 'NR>1 && $15!="" { v=$15+0; if (v>max) { max=v; who=$6"."$7 } } END { print (max+0)","who }' "$REPORT")"
  worst_pct="${worst%%,*}"
  worst_who="${worst#*,}"
  if awk "BEGIN{ exit !(${worst_pct:-0} > $GATE_PCT) }"; then
    die "ALLOCATION REGRESSION: $worst_who is +${worst_pct}% (gate ${GATE_PCT}%)"
  fi
  log "gate ok: worst allocation delta ${worst_pct:-0}% <= ${GATE_PCT}%"
fi

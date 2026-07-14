#!/usr/bin/env bash
# Regenerate replay history fixtures. Wraps temporal-sdk-bench-record, which needs
# a `temporal` dev server on PATH and drives each workflow in the Haskell fixture
# manifest (Bench.Common.benchFixtures) to produce sdk/bench/fixtures/*.history.bin.
#
#   scripts/perf/record-fixtures.sh                 # record any MISSING fixtures
#   scripts/perf/record-fixtures.sh --only fanout   # re-record a family
#   scripts/perf/record-fixtures.sh --only sleeps-100
#   scripts/perf/record-fixtures.sh --force --yes   # re-record ALL (slow)
#   scripts/perf/record-fixtures.sh --check          # verify all present (no server)
#
# NB: regenerated histories carry new timestamps/IDs, so absolute allocation
# numbers shift slightly. After an intentional regeneration, re-save the baseline
# (scripts/perf/bench.sh --save-baseline) in the SAME commit, or a phantom
# "regression" will show up later.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/_common.sh"

FIXDIR="sdk/bench/fixtures"
MODE=missing # missing | only | force | check
ONLY=""
YES=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --only) MODE=only; ONLY="${2:?--only needs a key or family}"; shift 2 ;;
    --force) MODE=force; shift ;;
    --check) MODE=check; shift ;;
    --yes) YES=true; shift ;;
    -h | --help) sed -n '2,17p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) die "unknown arg: $1 (see --help)" ;;
  esac
done

# Expected fixture paths come straight from the Haskell manifest (--list), so
# scripts never re-encode the size lists.
expected() { cabal run -v0 temporal-sdk-bench-record -- --list; }

if [[ "$MODE" == check ]]; then
  missing=0
  while IFS= read -r fp; do
    if [[ -f "$fp" ]]; then
      echo "ok   $fp"
    else
      echo "MISS $fp"
      missing=$((missing + 1))
    fi
  done < <(expected)
  [[ "$missing" -eq 0 ]] || die "$missing fixture(s) missing — run scripts/perf/record-fixtures.sh"
  log "all fixtures present"
  exit 0
fi

# Recording modes need the dev server. Fail before deleting anything.
command -v temporal >/dev/null 2>&1 \
  || die "'temporal' not found on PATH — install the Temporal CLI / enter the dev shell first"

warn "sequential-timer fixtures record ~1s per timer on the dev server (sleeps-100 ≈ 2 min)"

case "$MODE" in
  only)
    if [[ "$ONLY" == "sleeps" || "$ONLY" == "fanout" ]]; then
      log "removing family '$ONLY'"
      rm -f "$FIXDIR/$ONLY"-*.history.bin
    else
      local_fp="$FIXDIR/$ONLY.history.bin"
      [[ -f "$local_fp" ]] || warn "no existing fixture $local_fp (will record if it is in the manifest)"
      log "removing $local_fp"
      rm -f "$local_fp"
    fi
    ;;
  force)
    $YES || die "--force deletes ALL fixtures and re-records them (slow); pass --yes to confirm"
    log "removing all fixtures in $FIXDIR"
    rm -f "$FIXDIR"/*.history.bin
    ;;
  missing) : ;; # recorder skips existing; only missing ones get recorded
esac

log "recording (missing) fixtures…"
cabal run -v0 temporal-sdk-bench-record

# Postflight: confirm the manifest is fully satisfied.
missing=0
while IFS= read -r fp; do [[ -f "$fp" ]] || missing=$((missing + 1)); done < <(expected)
[[ "$missing" -eq 0 ]] || die "$missing fixture(s) still missing after recording"
log "done — all manifest fixtures present"

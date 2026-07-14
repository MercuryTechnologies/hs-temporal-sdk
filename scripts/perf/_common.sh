#!/usr/bin/env bash
# Shared prelude for scripts/perf/*. SOURCE this file; do not execute it.
#
# Guarantees for every perf script:
#   * cwd is the repo root — the benchmark/recorder resolve `sdk/bench/fixtures`
#     via a repo-root-relative path, so running from anywhere else silently finds
#     no fixtures.
#   * a sortable, commit-attributable RUN_ID and a run.json capturing the build
#     context, so a report can never be misattributed to the wrong commit/opt.

set -euo pipefail

# Repo root = two levels up from this file (scripts/perf/_common.sh).
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

PERF_OUT="${PERF_OUT:-perf-out}"

COMMIT_SHORT="$(git rev-parse --short=8 HEAD 2>/dev/null || echo unknown)"
COMMIT_FULL="$(git rev-parse HEAD 2>/dev/null || echo unknown)"

if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
  DIRTY=true
else
  DIRTY=false
fi

# UTC timestamp; works on both BSD/macOS and GNU date.
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
RUN_ID="${TIMESTAMP}-${COMMIT_SHORT}"

GHC_VERSION="$(ghc --numeric-version 2>/dev/null || echo unknown)"

# write_run_json <dir> <build> <project_file>
write_run_json() {
  local dir="$1" build="$2" project_file="$3"
  mkdir -p "$dir"
  cat >"$dir/run.json" <<EOF
{
  "run_id": "$RUN_ID",
  "commit": "$COMMIT_FULL",
  "commit_short": "$COMMIT_SHORT",
  "dirty": $DIRTY,
  "build": "$build",
  "project_file": "$project_file",
  "ghc_version": "$GHC_VERSION",
  "timestamp": "$TIMESTAMP"
}
EOF
}

log() { printf '\033[0;34m[perf]\033[0m %s\n' "$*" >&2; }
warn() { printf '\033[1;33m[perf]\033[0m %s\n' "$*" >&2; }
die() {
  printf '\033[0;31m[perf]\033[0m %s\n' "$*" >&2
  exit 1
}

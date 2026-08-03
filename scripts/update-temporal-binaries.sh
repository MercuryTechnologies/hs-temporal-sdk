#!/usr/bin/env bash
set -euo pipefail

# Bumps the version + per-platform hashes recorded in
# 'nix/sources/temporal-cli.json' and 'nix/sources/temporal-test-server.json'.
#
# Usage: update-temporal-binaries [cli|test-server|all] [version]
#   - no args: bump both to their latest upstream release
#   - "cli" or "test-server": bump just that one
#   - a version as the second arg: pin that version instead of "latest"
#     (only valid with a single target, since the two version lines are
#     unrelated)

readonly SYSTEMS=(x86_64-linux aarch64-linux aarch64-darwin)

# target_repo TARGET -> upstream GitHub repo
target_repo() {
  case "$1" in
  cli) echo "temporalio/cli" ;;
  test-server) echo "temporalio/sdk-java" ;;
  *)
    echo "unknown target: $1" >&2
    exit 1
    ;;
  esac
}

# target_pin TARGET -> path to the generated pin file
target_pin() {
  case "$1" in
  cli) echo "nix/sources/temporal-cli.json" ;;
  test-server) echo "nix/sources/temporal-test-server.json" ;;
  esac
}

# asset TARGET VERSION SYSTEM -> release tarball filename for that platform
asset() {
  local target="$1" version="$2" system="$3" arch os

  case "$system" in
  x86_64-*) arch=amd64 ;;
  aarch64-*) arch=arm64 ;;
  *)
    echo "unsupported system: $system" >&2
    exit 1
    ;;
  esac

  case "$target" in
  cli)
    case "$system" in
    *-linux) os=linux ;;
    *-darwin) os=darwin ;;
    esac
    echo "temporal_cli_${version}_${os}_${arch}.tar.gz"
    ;;
  test-server)
    # NOTE: the Java SDK's release assets use 'macOS', not 'darwin'.
    case "$system" in
    *-linux) os=linux ;;
    *-darwin) os=macOS ;;
    esac
    echo "temporal-test-server_${version}_${os}_${arch}.tar.gz"
    ;;
  esac
}

# latest_version REPO -> latest non-draft, non-prerelease tag (no leading 'v')
latest_version() {
  local repo="$1" auth=()
  if [[ -n ${GITHUB_TOKEN:-} ]]; then
    auth=(-H "Authorization: Bearer $GITHUB_TOKEN")
  fi
  curl -fsSL "${auth[@]}" "https://api.github.com/repos/$repo/releases/latest" |
    jq -r '.tag_name | ltrimstr("v")'
}

# update TARGET [VERSION]
update() {
  local target="$1" version="${2:-}" repo pin current json url hash system

  repo=$(target_repo "$target")
  pin=$(target_pin "$target")
  current=$(jq -r .version "$pin")

  if [[ -z $version ]]; then
    version=$(latest_version "$repo")
  fi

  echo "$target: $current -> $version" >&2

  json=$(jq -n --arg v "$version" '{version: $v, systems: {}}')
  for system in "${SYSTEMS[@]}"; do
    url="https://github.com/$repo/releases/download/v$version/$(asset "$target" "$version" "$system")"
    echo "  $system: $url" >&2

    # nix-prefetch-url prints the flat (non-recursive) sha256 of the file in
    # base32, which is what 'fetchurl' wants; nix-hash --to-sri auto-detects
    # base32 vs hex and converts either to SRI.
    hash=$(nix-hash --to-sri --type sha256 "$(nix-prefetch-url --type sha256 "$url")")

    json=$(jq --arg s "$system" --arg u "$url" --arg h "$hash" \
      '.systems[$s] = { url: $u, hash: $h }' <<<"$json")
  done

  jq -S . <<<"$json" >"$pin"
}

main() {
  if [[ ! -f flake.nix ]]; then
    echo "run this from the repository root" >&2
    exit 1
  fi

  for tool in curl jq nix-prefetch-url nix-hash; do
    if ! command -v "$tool" >/dev/null 2>&1; then
      echo "missing required tool: $tool" >&2
      exit 1
    fi
  done

  case "${1:-all}" in
  all)
    if [[ -n ${2:-} ]]; then
      echo "a version can only be pinned for a single target, not 'all'" >&2
      exit 1
    fi
    update cli
    update test-server
    ;;
  cli | test-server)
    update "$1" "${2:-}"
    ;;
  *)
    echo "usage: $0 [cli|test-server|all] [version]" >&2
    exit 1
    ;;
  esac
}

main "$@"

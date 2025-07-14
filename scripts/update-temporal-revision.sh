#!/usr/bin/env bash
set -euo pipefail

# Script to update Temporal SDK dependencies to a specific revision
# Usage: ./update-temporal-revision.sh [revision|next]
#   - no args: update to latest master
#   - "next": update to next commit after current
#   - <hash>: update to specific commit hash

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configuration
readonly GITHUB_REPO="temporalio/sdk-core"
readonly DEFAULT_BRANCH="master"
readonly CARGO_TOML_PATH="core/rust/Cargo.toml"
readonly TEMPORAL_DEPENDENCIES=(
  "temporal-client"
  "temporal-sdk-core"
  "temporal-sdk-core-api"
  "temporal-sdk-core-protos"
  "rustfsm"
)

# Function to print colored output
log_info() {
  echo -e "${BLUE}[INFO]${NC} $*"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $*" >&2
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $*"
}

# Function to show usage
show_usage() {
  cat <<EOF
Usage: $0 [OPTION] [REVISION]

Update Temporal SDK dependencies to a specific revision.

Options:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    -d, --dry-run       Show what would be done without making changes

Arguments:
    REVISION            Specific commit hash to update to
    next                Update to the next commit after current
    (no argument)       Update to latest commit on master branch

Examples:
    $0                    # Update to latest master
    $0 next              # Update to next commit after current
    $0 abc123def         # Update to specific commit hash
    $0 --dry-run next    # Show what would be done

Environment Variables:
    GITHUB_TOKEN         GitHub personal access token (optional, increases rate limits)

EOF
}

# Function to check if required tools are available
check_dependencies() {
  local missing_tools=()

  for tool in curl jq cargo crate2nix; do
    if ! command -v "$tool" >/dev/null 2>&1; then
      missing_tools+=("$tool")
    fi
  done

  if [[ ${#missing_tools[@]} -gt 0 ]]; then
    log_error "Missing required tools: ${missing_tools[*]}"
    log_error "Please install the missing tools and try again."
    exit 1
  fi
}

# Function to validate we're in the correct directory
check_working_directory() {
  if [[ ! -f $CARGO_TOML_PATH ]]; then
    log_error "Cargo.toml not found at $CARGO_TOML_PATH"
    log_error "Please run this script from the project root directory."
    exit 1
  fi
}

# Function to check GitHub API rate limits
check_rate_limit() {
  local curl_args=("-s" "https://api.github.com/rate_limit")

  if [[ -n ${GITHUB_TOKEN:-} ]]; then
    curl_args+=("-H" "Authorization: token $GITHUB_TOKEN")
  fi

  local rate_limit_info
  if ! rate_limit_info=$(curl "${curl_args[@]}"); then
    log_warn "Could not check rate limit"
    return 0
  fi

  local remaining reset_time
  remaining=$(echo "$rate_limit_info" | jq -r ".resources.core.remaining")
  reset_time=$(echo "$rate_limit_info" | jq -r ".resources.core.reset")

  if [[ $remaining == "null" || -z $remaining ]]; then
    log_warn "Could not check rate limit"
    return 0
  fi

  log_info "API rate limit: $remaining requests remaining"

  if [[ $remaining -lt 10 ]]; then
    local reset_date
    reset_date=$(date -r "$reset_time" 2>/dev/null || echo "unknown")
    log_warn "Low API rate limit remaining. Reset time: $reset_date"
  fi
}

# Function to make GitHub API requests safely
github_api_request() {
  local endpoint="$1"
  local curl_args=("-s" "https://api.github.com/$endpoint")

  if [[ -n ${GITHUB_TOKEN:-} ]]; then
    curl_args+=("-H" "Authorization: token $GITHUB_TOKEN")
  fi

  local response
  if ! response=$(curl "${curl_args[@]}"); then
    log_error "Failed to make GitHub API request to $endpoint"
    return 1
  fi

  echo "$response"
}

# Function to get the latest commit hash from GitHub API
get_latest_revision() {
  local branch="${1:-$DEFAULT_BRANCH}"
  log_info "Fetching latest revision from $GITHUB_REPO $branch branch..." >&2

  local response
  if ! response=$(github_api_request "repos/$GITHUB_REPO/commits/$branch"); then
    return 1
  fi

  local latest_commit
  latest_commit=$(echo "$response" | jq -r ".sha")

  if [[ $latest_commit == "null" || -z $latest_commit ]]; then
    log_error "Failed to fetch latest revision from GitHub API" >&2
    return 1
  fi

  log_info "Latest commit: $latest_commit" >&2
  echo "$latest_commit"
}

# Function to get the next commit hash after the current one
get_next_revision() {
  local current_revision="$1"
  local branch="${2:-$DEFAULT_BRANCH}"
  log_info "Fetching next revision after $current_revision from $GITHUB_REPO $branch branch..." >&2

  local page=1
  local found_current=false
  local next_commit=""

  while [[ $page -le 10 ]]; do # Limit to 10 pages to avoid infinite loops
    log_info "Checking page $page..." >&2

    local response
    if ! response=$(github_api_request "repos/$GITHUB_REPO/commits?sha=$branch&per_page=100&page=$page"); then
      return 1
    fi

    # Check if we got a valid response
    if [[ $(echo "$response" | jq -r "type") != "array" ]]; then
      log_error "Invalid response from GitHub API" >&2
      return 1
    fi

    # Process each commit in the page
    local commit_count
    commit_count=$(echo "$response" | jq "length")

    if [[ $commit_count -eq 0 ]]; then
      break # No more commits
    fi

    # Check if current revision is in this page
    local current_index=-1
    for i in $(seq 0 $((commit_count - 1))); do
      local commit_sha
      commit_sha=$(echo "$response" | jq -r ".[$i].sha")
      if [[ $commit_sha == "$current_revision" ]]; then
        current_index=$i
        log_info "Found current revision at index $i on page $page" >&2
        break
      fi
    done

    if [[ $current_index -ge 0 ]]; then
      # Found the current revision, get the prior commit (previous in the array since it's reverse chronological)
      if [[ $current_index -gt 0 ]]; then
        next_commit=$(echo "$response" | jq -r ".[$((current_index - 1))].sha")
        log_info "Found next commit: $next_commit" >&2
        found_current=true
        break
      else
        # Current revision is the first commit on this page, check next page
        log_info "Current revision is first on page $page, checking next page..." >&2
        page=$((page + 1))
        continue
      fi
    fi

    log_info "Current revision not found on page $page, checking next page..." >&2
    page=$((page + 1))
  done

  if [[ $found_current != "true" ]]; then
    log_error "Could not find current revision $current_revision in recent commit history" >&2
    return 1
  fi

  if [[ $next_commit == "null" || -z $next_commit ]]; then
    log_error "No next revision found after $current_revision" >&2
    return 1
  fi

  echo "$next_commit"
}

# Function to extract current revision from Cargo.toml
get_current_revision() {
  local cargo_toml="$1"

  # Look for any temporal dependency and extract its revision
  local current_revision
  current_revision=$(grep -A 1 "temporal.*= { git = " "$cargo_toml" | grep "rev = " | head -1 | sed 's/.*rev = "\([^"]*\)".*/\1/' | tr -d '\n')

  if [[ -z $current_revision ]]; then
    log_warn "No current revision found in $cargo_toml"
    return 1
  fi

  echo "$current_revision"
}

# Function to update Cargo.toml with new revision
update_cargo_toml() {
  local cargo_toml="$1"
  local new_revision="$2"
  local dry_run="${3:-false}"

  log_info "Updating $cargo_toml with revision $new_revision"

  if [[ $dry_run == "true" ]]; then
    log_info "DRY RUN: Would update the following dependencies:"
    for dep in "${TEMPORAL_DEPENDENCIES[@]}"; do
      log_info "  - $dep"
    done
    return 0
  fi

  # Create a backup
  cp "$cargo_toml" "$cargo_toml.backup"
  log_info "Backup created at $cargo_toml.backup"

  # Use the simplest possible approach: process each dependency individually
  local temp_file
  temp_file=$(mktemp)

  # Copy the original file
  cp "$cargo_toml" "$temp_file"

  # Update each temporal dependency individually
  for dep in "${TEMPORAL_DEPENDENCIES[@]}"; do
    # Use sed to replace only lines that contain this specific dependency
    if sed -i.bak "/$dep = { git = \"https:\/\/github\.com\/temporalio\/sdk-core\"/s/rev = \"[a-f0-9]*\"/rev = \"$new_revision\"/" "$temp_file"; then
      log_info "Updated dependency: $dep"
    else
      log_warn "Failed to update dependency: $dep"
    fi
    # Remove the backup file created by sed
    rm -f "$temp_file.bak" 2>/dev/null || true
  done

  # Replace the original file
  mv "$temp_file" "$cargo_toml"

  # Remove the backup after a successful update
  rm -f "$cargo_toml.backup" 2>/dev/null || true

  log_success "Updated $cargo_toml with revision $new_revision"
}

# Function to verify changes
verify_changes() {
  local cargo_toml="$1"
  local expected_revision="$2"

  log_info "Verifying changes..."
  local updated_deps
  updated_deps=$(grep -A 1 -B 1 "temporalio/sdk-core" "$cargo_toml" || true)

  if [[ -n $updated_deps ]]; then
    log_info "Updated dependencies:"
    echo "$updated_deps"
  fi

  # Verify all dependencies were updated
  for dep in "${TEMPORAL_DEPENDENCIES[@]}"; do
    # Escape special characters in the dependency name for grep
    local escaped_dep
    escaped_dep="${dep//[][.*^$()+?{|]/\\&}"
    local escaped_repo
    escaped_repo="${GITHUB_REPO//[][.*^$()+?{|]/\\&}"
    local escaped_revision
    escaped_revision="${expected_revision//[][.*^$()+?{|]/\\&}"

    if ! grep -q "$escaped_dep = { git = \"https://github.com/$escaped_repo\", rev = \"$escaped_revision\"" "$cargo_toml"; then
      log_warn "Dependency $dep may not have been updated correctly"
    fi
  done
}

# Function to update Cargo.lock and regenerate crate2nix files
update_dependencies() {
  local dry_run="${1:-false}"

  if [[ $dry_run == "true" ]]; then
    log_info "DRY RUN: Would run 'cargo build' and 'crate2nix generate'"
    return 0
  fi

  log_info "Building project to update Cargo.lock and verify dependencies..."
  cd core/rust || exit 1

  if ! cargo build; then
    log_error "Failed to build project - dependencies may be incompatible"
    return 1
  fi

  log_info "Running crate2nix generate..."
  if ! crate2nix generate; then
    log_error "Failed to generate crate2nix files"
    return 1
  fi

  log_success "Successfully built project and regenerated crate2nix files"
}

# Main script logic
main() {
  local verbose=false
  local dry_run=false
  local revision=""

  # Parse command line arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
      show_usage
      exit 0
      ;;
    -v | --verbose)
      verbose=true
      shift
      ;;
    -d | --dry-run)
      dry_run=true
      shift
      ;;
    -*)
      log_error "Unknown option: $1"
      show_usage
      exit 1
      ;;
    *)
      revision="$1"
      shift
      ;;
    esac
  done

  # Set verbose mode
  if [[ $verbose == "true" ]]; then
    set -x
  fi

  # Check dependencies and working directory
  check_dependencies
  check_working_directory

  # Check for GitHub token and rate limits
  if [[ -z ${GITHUB_TOKEN:-} ]]; then
    log_warn "No GITHUB_TOKEN environment variable found."
    log_warn "You can set it to increase API rate limits from 60/hour to 5000/hour:"
    log_warn "  export GITHUB_TOKEN=your_github_personal_access_token"
    log_warn "  # or add it to your shell profile"
    echo
  fi

  check_rate_limit

  # Determine the revision to update to
  local target_revision
  if [[ -z $revision ]]; then
    # No arguments provided, fetch latest from master branch
    if ! target_revision=$(get_latest_revision "$DEFAULT_BRANCH"); then
      exit 1
    fi
  elif [[ $revision == "next" ]]; then
    # Get the current revision from Cargo.toml
    local current_revision
    if ! current_revision=$(get_current_revision "$CARGO_TOML_PATH"); then
      log_info "No current revision found, getting latest from $DEFAULT_BRANCH..."
      if ! target_revision=$(get_latest_revision "$DEFAULT_BRANCH"); then
        exit 1
      fi
    else
      log_info "Current revision: $current_revision"
      if ! target_revision=$(get_next_revision "$current_revision" "$DEFAULT_BRANCH"); then
        exit 1
      fi
    fi
  else
    # Treat the argument as a commit hash
    target_revision="$revision"
  fi

  log_info "Target revision: $target_revision"

  # Update Cargo.toml
  if ! update_cargo_toml "$CARGO_TOML_PATH" "$target_revision" "$dry_run"; then
    exit 1
  fi

  # Verify the changes
  if [[ $dry_run != "true" ]]; then
    verify_changes "$CARGO_TOML_PATH" "$target_revision"
  fi

  # Update dependencies
  if ! update_dependencies "$dry_run"; then
    exit 1
  fi

  log_success "Successfully updated Temporal SDK to revision $target_revision"
}

# Run main function with all arguments
main "$@"

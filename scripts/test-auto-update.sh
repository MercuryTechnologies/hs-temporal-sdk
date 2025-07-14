#!/usr/bin/env bash
set -euo pipefail

# Test script for the auto-update Temporal workflow
# This script simulates the workflow logic locally for testing

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

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

show_usage() {
  cat <<EOF
Usage: $0 [OPTION]

Test the auto-update Temporal workflow logic locally.

Options:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    --dry-run           Only check for updates, don't make changes

Examples:
    $0                    # Test the full workflow
    $0 --dry-run         # Only check for updates
    $0 --verbose         # Run with verbose output

EOF
}

main() {
  local verbose=false
  local dry_run=false

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
    --dry-run)
      dry_run=true
      shift
      ;;
    -*)
      log_error "Unknown option: $1"
      show_usage
      exit 1
      ;;
    *)
      log_error "Unexpected argument: $1"
      show_usage
      exit 1
      ;;
    esac
  done

  # Set verbose mode
  if [[ $verbose == "true" ]]; then
    set -x
  fi

  log_info "Testing auto-update Temporal workflow..."

  # Check if we're in the right directory
  if [[ ! -f "scripts/update-temporal-revision.sh" ]]; then
    log_error "update-temporal-revision.sh not found"
    log_error "Please run this script from the project root directory"
    exit 1
  fi

  # Check if devenv is available
  if ! command -v devenv >/dev/null 2>&1; then
    log_error "devenv not found"
    log_error "Please install devenv: nix profile install nixpkgs#devenv"
    exit 1
  fi

  # Make sure the script is executable
  chmod +x scripts/update-temporal-revision.sh

  # Get current revision using devenv
  log_info "Getting current revision..."
  local current_revision
  if ! current_revision=$(devenv shell -- bash -c './scripts/update-temporal-revision.sh --dry-run next 2>&1 | grep "Target revision:" | cut -d" " -f3'); then
    log_error "Failed to get current revision"
    exit 1
  fi

  log_info "Current revision: $current_revision"

  # Get next revision using devenv
  log_info "Getting next revision..."
  local next_revision
  if ! next_revision=$(devenv shell -- bash -c './scripts/update-temporal-revision.sh --dry-run next 2>&1 | grep "Target revision:" | cut -d" " -f3'); then
    log_error "Failed to get next revision"
    exit 1
  fi

  log_info "Next revision: $next_revision"

  # Check if there's an update
  if [[ $current_revision == "$next_revision" ]]; then
    log_success "No update needed - already at latest revision"
    exit 0
  fi

  log_info "Update available: $current_revision -> $next_revision"

  if [[ $dry_run == "true" ]]; then
    log_info "DRY RUN: Would update to revision $next_revision"
    log_info "DRY RUN: Would create branch: update-temporal-to-$next_revision"
    log_info "DRY RUN: Would create PR with title: Update Temporal SDK to revision $next_revision"
    exit 0
  fi

  # Check if we're in a git repository
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    log_error "Not in a git repository"
    exit 1
  fi

  # Check if we have uncommitted changes
  if ! git diff-index --quiet HEAD --; then
    log_warn "You have uncommitted changes"
    log_warn "Please commit or stash them before running the update"
    exit 1
  fi

  # Create branch name
  local branch_name="update-temporal-to-$next_revision"
  log_info "Creating branch: $branch_name"

  # Check if branch already exists
  if git show-ref --verify --quiet refs/heads/"$branch_name"; then
    log_warn "Branch $branch_name already exists"
    log_warn "You may want to delete it first: git branch -D $branch_name"
    exit 1
  fi

  # Create and checkout the branch
  git checkout -b "$branch_name"

  # Run the update using devenv
  log_info "Running update script..."
  if ! devenv shell -- bash -c "./scripts/update-temporal-revision.sh $next_revision"; then
    log_error "Update failed"
    git checkout -
    git branch -D "$branch_name"
    exit 1
  fi

  # Check if there are changes
  if git diff --quiet; then
    log_warn "No changes detected after update"
    git checkout -
    git branch -D "$branch_name"
    exit 0
  fi

  # Show the changes
  log_info "Changes to be committed:"
  git diff --stat

  log_success "Update completed successfully!"
  log_info "Branch created: $branch_name"
  log_info "Changes are staged and ready to commit"
  log_info ""
  log_info "Next steps:"
  log_info "1. Review the changes: git diff --cached"
  log_info "2. Commit the changes: git commit -m 'Update Temporal SDK to revision $next_revision'"
  log_info "3. Push the branch: git push origin $branch_name"
  log_info "4. Create a pull request on GitHub"
}

main "$@"

{pkgs, ...}: {
  packages =
    [
      pkgs.crate2nix
      pkgs.protobuf
      pkgs.rust-cbindgen
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      pkgs.apple-sdk
    ];

  languages.rust = {
    enable = true;
    channel = "nightly";
  };

  scripts.update-temporal-revision.exec = ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Check for GitHub token and provide helpful information
    if [[ -z "''${GITHUB_TOKEN:-}" ]]; then
      echo "Note: No GITHUB_TOKEN environment variable found." >&2
      echo "You can set it to increase API rate limits from 60/hour to 5000/hour:" >&2
      echo "  export GITHUB_TOKEN=your_github_personal_access_token" >&2
      echo "  # or add it to your shell profile" >&2
      echo "" >&2
    fi

                # Function to check GitHub API rate limits
    check_rate_limit() {
      local curl_cmd="curl -s"
      if [[ -n "''${GITHUB_TOKEN:-}" ]]; then
        curl_cmd="$curl_cmd -H \"Authorization: token $GITHUB_TOKEN\""
      fi

      local rate_limit_info=$(eval "$curl_cmd \"https://api.github.com/rate_limit\"")
      local remaining=$(echo "$rate_limit_info" | jq -r ".resources.core.remaining")
      local reset_time=$(echo "$rate_limit_info" | jq -r ".resources.core.reset")

      if [[ "$remaining" == "null" || -z "$remaining" ]]; then
        echo "Warning: Could not check rate limit" >&2
        return 0
      fi

      echo "API rate limit: $remaining requests remaining" >&2

      if [[ $remaining -lt 10 ]]; then
        local reset_date=$(date -r "$reset_time" 2>/dev/null || echo "unknown")
        echo "Warning: Low API rate limit remaining. Reset time: $reset_date" >&2
      fi
    }

    # Function to get the latest commit hash from GitHub API
    get_latest_revision() {
      local branch="''${1:-master}"
      echo "Fetching latest revision from temporalio/sdk-core $branch branch..." >&2

      local api_url="https://api.github.com/repos/temporalio/sdk-core/commits/$branch"
      echo "Making curl request to: $api_url" >&2

      # Build curl command with optional authentication
      local curl_cmd="curl -s"
      if [[ -n "''${GITHUB_TOKEN:-}" ]]; then
        curl_cmd="$curl_cmd -H \"Authorization: token $GITHUB_TOKEN\""
        echo "Using GitHub token for authentication" >&2
      else
        echo "No GitHub token found, using unauthenticated requests (rate limited to 60/hour)" >&2
      fi

      # Use curl to fetch the latest commit hash from GitHub API
      local latest_commit=$(eval "$curl_cmd \"$api_url\"" | jq -r ".sha")

      echo "Received commit hash: $latest_commit" >&2

      if [[ "$latest_commit" == "null" || -z "$latest_commit" ]]; then
        echo "Error: Failed to fetch latest revision from GitHub API" >&2
        exit 1
      fi

      echo "$latest_commit"
    }

                            # Function to get the next commit hash after the current one
    get_next_revision() {
      local current_revision="$1"
      local branch="''${2:-master}"
      echo "Fetching next revision after $current_revision from temporalio/sdk-core $branch branch..." >&2

      # Start from the head of the branch and paginate through commits
      local page=1
      local found_current=false
      local next_commit=""

      while [[ $page -le 10 ]]; do  # Limit to 10 pages to avoid infinite loops
        echo "Checking page $page..." >&2

        local api_url="https://api.github.com/repos/temporalio/sdk-core/commits?sha=$branch&per_page=100&page=$page"
        echo "Making curl request to: $api_url" >&2

        # Build curl command with optional authentication
        local curl_cmd="curl -s"
        if [[ -n "''${GITHUB_TOKEN:-}" ]]; then
          curl_cmd="$curl_cmd -H \"Authorization: token $GITHUB_TOKEN\""
        fi

        local commits=$(eval "$curl_cmd \"$api_url\"")

        echo "Received response type: $(echo "$commits" | jq -r "type")" >&2
        echo "First few characters of response: $(echo "$commits" | head -c 100)" >&2

        # Check if we got a valid response
        if [[ $(echo "$commits" | jq -r "type") != "array" ]]; then
          echo "Error: Invalid response from GitHub API" >&2
          echo "Response content: $commits" >&2
          exit 1
        fi

        # Process each commit in the page
        local commit_count=$(echo "$commits" | jq "length")
        echo "Found $commit_count commits on page $page" >&2

        # Debug: show first commit structure
        if [[ $commit_count -gt 0 ]]; then
          echo "First commit structure: $(echo "$commits" | jq -r ".[0] | keys" | head -5)" >&2
          echo "First commit sha: $(echo "$commits" | jq -r ".[0].sha")" >&2
        fi
        if [[ $commit_count -eq 0 ]]; then
          break  # No more commits
        fi

        # Check if current revision is in this page
        echo "Searching for current revision: $current_revision" >&2
        local current_index=-1
        for i in $(seq 0 $((commit_count - 1))); do
          local commit_sha=$(echo "$commits" | jq -r ".[$i].sha")
          if [[ "$commit_sha" == "$current_revision" ]]; then
            current_index=$i
            echo "Found current revision at index $i on page $page" >&2
            break
          fi
        done

        if [[ $current_index -ge 0 ]]; then
          # Found the current revision, get the prior commit (previous in the array since it's reverse chronological)
          if [[ $current_index -gt 0 ]]; then
            next_commit=$(echo "$commits" | jq -r ".[$((current_index - 1))].sha")
            echo "Found next commit: $next_commit" >&2
            found_current=true
            break
          else
            # Current revision is the first commit on this page, check next page
            echo "Current revision is first on page $page, checking next page..." >&2
            page=$((page + 1))
            continue
          fi
        fi

        echo "Current revision not found on page $page, checking next page..." >&2
        page=$((page + 1))
      done

      if [[ "$found_current" != "true" ]]; then
        echo "Error: Could not find current revision $current_revision in recent commit history" >&2
        exit 1
      fi

      if [[ "$next_commit" == "null" || -z "$next_commit" ]]; then
        echo "Error: No next revision found after $current_revision" >&2
        exit 1
      fi

      echo "$next_commit"
    }

    # Check rate limits before making requests
    check_rate_limit

    # Parse command line arguments
    if [[ $# -eq 0 ]]; then
      # No arguments provided, fetch latest from master branch
      REVISION=$(get_latest_revision "master")
    elif [[ "$1" == "next" ]]; then
      # Get the current revision from Cargo.toml
      current_revision=$(grep -A 1 "temporal-client = { git = " core/rust/Cargo.toml | grep "rev = " | sed "s/.*rev = \"\\([^\"]*\\)\".*/\\1/" | tr -d '\n')

      echo "Raw extracted revision: '$current_revision'" >&2

      if [[ -z "$current_revision" ]]; then
        # No current revision found, get the latest from master
        echo "No current revision found, getting latest from master..." >&2
        REVISION=$(get_latest_revision "master")
      else
        echo "Current revision: $current_revision" >&2
        REVISION=$(get_next_revision "$current_revision" "master")
      fi
    else
      # Always treat the argument as a commit hash
      REVISION="$1"
    fi

    echo "Updating Temporal SDK dependencies to revision: $REVISION"

    # Path to the Cargo.toml file
    CARGO_TOML="core/rust/Cargo.toml"

    # Check if Cargo.toml exists
    if [[ ! -f "$CARGO_TOML" ]]; then
        echo "Error: $CARGO_TOML not found"
        exit 1
    fi

    # Create a backup of the original Cargo.toml
    cp "$CARGO_TOML" "$CARGO_TOML.backup"

    echo "Backup created at $CARGO_TOML.backup"

    # Update all temporalio/sdk-core dependencies to the specified revision
    # This uses sed to replace the rev = "..." line for each temporal dependency
    sed -i.tmp \
        -e "s|temporal-client = { git = \"https://github.com/temporalio/sdk-core\", rev = \"[^\"]*\"|temporal-client = { git = \"https://github.com/temporalio/sdk-core\", rev = \"$REVISION\"|g" \
        -e "s|temporal-sdk-core = { git = \"https://github.com/temporalio/sdk-core\", rev = \"[^\"]*\"|temporal-sdk-core = { git = \"https://github.com/temporalio/sdk-core\", rev = \"$REVISION\"|g" \
        -e "s|temporal-sdk-core-api = { git = \"https://github.com/temporalio/sdk-core\", rev = \"[^\"]*\"|temporal-sdk-core-api = { git = \"https://github.com/temporalio/sdk-core\", rev = \"$REVISION\"|g" \
        -e "s|temporal-sdk-core-protos = { git = \"https://github.com/temporalio/sdk-core\", rev = \"[^\"]*\"|temporal-sdk-core-protos = { git = \"https://github.com/temporalio/sdk-core\", rev = \"$REVISION\"|g" \
        -e "s|rustfsm = { git = \"https://github.com/temporalio/sdk-core\", rev = \"[^\"]*\"|rustfsm = { git = \"https://github.com/temporalio/sdk-core\", rev = \"$REVISION\"|g" \
        "$CARGO_TOML"

    # Remove the temporary file created by sed
    rm -f "$CARGO_TOML.tmp"

    echo "Updated Cargo.toml with revision $REVISION"

    # Verify the changes
    echo "Verifying changes..."
    grep -A 1 -B 1 "temporalio/sdk-core" "$CARGO_TOML" || true

    # Run crate2nix generate
    echo "Running crate2nix generate..."
    cd core/rust
    crate2nix generate

    echo "Successfully updated Temporal SDK to revision $REVISION and regenerated crate2nix files"
  '';

  pre-commit.hooks = {
    crate2nix = {
      enable = false;
      name = "crate2nix";
      files = "Cargo\\.(toml|lock)$";
      language = "system";
      pass_filenames = true;
      entry = ''
        cd $(dirname $1)
        ${pkgs.crate2nix}/bin/crate2nix generate
      '';
    };

    # Not smart enough to find the location of the Cargo.toml
    cargo-check.enable = false;
  };
}

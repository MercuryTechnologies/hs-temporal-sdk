#!/bin/bash
#
# Script to update the vendored temporal-sdk-core to a new revision
#
# Usage: ./scripts/update-temporal-sdk-core.sh <git-revision>
#
# Example: ./scripts/update-temporal-sdk-core.sh 97093c5ea4b0d933513f4c8999f7960f0c16f05f
#

set -e  # Exit on error

if [ -z "$1" ]; then
    echo "Error: Please provide a git revision (commit hash, tag, or branch)"
    echo "Usage: $0 <git-revision>"
    echo "Example: $0 97093c5ea4b0d933513f4c8999f7960f0c16f05f"
    exit 1
fi

REVISION="$1"
VENDOR_DIR="vendor/temporal-sdk-core"
REPO_URL="https://github.com/temporalio/sdk-core.git"

echo "Updating temporal-sdk-core to revision: $REVISION"

# Remove existing vendor directory
if [ -d "$VENDOR_DIR" ]; then
    echo "Removing existing vendor directory..."
    rm -rf "$VENDOR_DIR"
fi

# Create vendor directory if it doesn't exist
mkdir -p vendor

# Clone the repository
echo "Cloning temporal-sdk-core repository..."
git clone "$REPO_URL" "$VENDOR_DIR"

# Checkout the specific revision
echo "Checking out revision $REVISION..."
cd "$VENDOR_DIR"
git checkout "$REVISION"

# Remove .git directory to avoid nested git repos
echo "Removing .git directory..."
rm -rf .git

cd ../..

echo "Successfully updated temporal-sdk-core to revision $REVISION"
echo ""
echo "Now you should:"
echo "1. Test the build: cabal clean && cabal build all"
echo "2. If successful, commit the changes: git add vendor/ && git commit -m \"Update temporal-sdk-core to $REVISION\""

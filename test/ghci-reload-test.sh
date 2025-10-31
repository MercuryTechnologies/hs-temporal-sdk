#!/usr/bin/env bash
# GHCi Reload Test Script
#
# This script automates testing that the Temporal runtime survives GHCi reloads
# without crashing due to stale tracing spans or other persistent Rust state issues.
#
# Requirements:
#   - expect (install with: brew install expect on macOS)
#   - GHCi (part of GHC installation)
#
# Usage:
#   ./test/ghci-reload-test.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEST_MAIN="$PROJECT_ROOT/sdk/test/Main.hs"

echo "=== Temporal GHCi Reload Test ==="
echo "Testing that runtime survives GHCi :reload without crashes"
echo "Running full temporal-sdk test suite before and after reload"
echo ""

# Check if expect is installed
if ! command -v expect &> /dev/null; then
    echo "ERROR: 'expect' is not installed"
    echo "Install it with: brew install expect (macOS) or apt-get install expect (Linux)"
    exit 1
fi

# Create the expect script
EXPECT_SCRIPT=$(cat <<EOF
#!/usr/bin/expect -f

set timeout 60
set test_main "$TEST_MAIN"

# Start GHCi with test-suite so all test dependencies are available
spawn cabal repl temporal-sdk:test:temporal-sdk-tests
expect_before {
    timeout { puts "\nERROR: Timeout waiting for GHCi"; exit 1 }
    eof { puts "\nERROR: GHCi exited unexpectedly"; exit 1 }
}

# Wait for GHCi prompt (handle control sequences)
expect {
    -re "ghci>.*$" { }
    timeout { puts "\nERROR: Timeout waiting for initial prompt"; exit 1 }
}

# Load the test suite Main module
puts "\n>>> Loading test suite..."
send ":load \$test_main\r"
expect {
    -re "ghci>.*$" { puts "✓ Test suite loaded successfully" }
    "Failed, " { puts "✗ Test suite failed to load"; exit 1 }
    timeout { puts "\nERROR: Timeout waiting for prompt after load"; exit 1 }
}

# Run the test suite (first time)
puts "\n>>> Running test suite (first time)..."
send "Main.main\r"
expect {
    -re "examples, 0 failures" { puts "✓ First test run succeeded - all tests passed" }
    "panic" { puts "✗ PANIC detected on first run!"; exit 1 }
    "segfault" { puts "✗ Segfault detected on first run!"; exit 1 }
    timeout { puts "✗ Timeout during first test run"; exit 1 }
}
send "\r"
expect -re "ghci>"

# Reload the test suite
puts "\n>>> Reloading test suite..."
send ":reload\r"
expect {
    -re "ghci>.*$" { puts "✓ Test suite reloaded successfully" }
    "Failed, " { puts "✗ Test suite failed to reload"; exit 1 }
    "panic" { puts "✗ PANIC detected during reload!"; exit 1 }
    timeout { puts "✗ Timeout during reload"; exit 1 }
}

# Run the test suite again (after reload - this is the critical test)
puts "\n>>> Running test suite (after reload - CRITICAL TEST)..."
send "Main.main\r"
expect {
    -re "examples, 0 failures" { puts "✓ Second test run succeeded - all tests passed after reload!" }
    "panic" { puts "✗ PANIC detected on second run!"; exit 1 }
    "segfault" { puts "✗ Segfault detected on second run!"; exit 1 }
    timeout { puts "✗ Timeout during second test run"; exit 1 }
}
send "\r"
expect -re "ghci>"

# Exit GHCi
puts "\n>>> Exiting GHCi..."
send ":quit\r"
expect {
    "Leaving GHCi" { }
    eof { }
}

puts "\n=== ALL TESTS PASSED ==="
puts "The full temporal-sdk test suite ran successfully before and after GHCi reload!"
puts "The Temporal runtime is stable across GHCi reloads."
exit 0
EOF
)

# Write the expect script to a temp file
TEMP_EXPECT="/tmp/ghci-reload-test-$$.exp"
echo "$EXPECT_SCRIPT" > "$TEMP_EXPECT"
chmod +x "$TEMP_EXPECT"

# Run the expect script from the project root
cd "$PROJECT_ROOT"
echo "Running automated GHCi test..."
echo ""

if "$TEMP_EXPECT"; then
    echo ""
    echo "========================================"
    echo "SUCCESS: GHCi reload test passed!"
    echo "Full temporal-sdk test suite ran"
    echo "successfully before and after reload."
    echo "The fix is working correctly."
    echo "========================================"
    rm "$TEMP_EXPECT"
    exit 0
else
    EXIT_CODE=$?
    echo ""
    echo "========================================"
    echo "FAILURE: GHCi reload test failed!"
    echo "Exit code: $EXIT_CODE"
    echo "========================================"
    rm "$TEMP_EXPECT"
    exit $EXIT_CODE
fi

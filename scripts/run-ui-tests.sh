#!/bin/bash

# Run all UI tests for Tokopedia
# This script executes all UI test plans sequentially

set -e

ENVIRONMENT="${1:-default}"
SCRIPTS_DIR="scripts"
TEST_PLANS_DIR="test-plans/ui"

echo "=========================================="
echo "Tokopedia UI Test Suite Runner"
echo "=========================================="
echo "Environment: $ENVIRONMENT"
echo "=========================================="

# Check if test plans directory exists
if [ ! -d "$TEST_PLANS_DIR" ]; then
    echo "Error: Test plans directory '$TEST_PLANS_DIR' not found"
    exit 1
fi

# Find all .jmx files in the UI test plans directory
TEST_FILES=$(find "$TEST_PLANS_DIR" -name "*.jmx" -type f)

if [ -z "$TEST_FILES" ]; then
    echo "No test plan files found in $TEST_PLANS_DIR"
    exit 1
fi

echo "Found test plans:"
for test_file in $TEST_FILES; do
    echo "  - $(basename "$test_file")"
done
echo "=========================================="

# Execute each test plan
for test_file in $TEST_FILES; do
    echo ""
    echo "Executing: $(basename "$test_file")"
    echo "----------------------------------------"
    
    # Run the test with light load settings for suite execution
    $SCRIPTS_DIR/run-test.sh "$test_file" "$ENVIRONMENT" "-Jusers=5 -Jrampup=30 -Jduration=120"
    
    if [ $? -ne 0 ]; then
        echo "Test failed: $(basename "$test_file")"
        echo "Stopping test suite execution"
        exit 1
    fi
    
    echo "----------------------------------------"
    echo "Completed: $(basename "$test_file")"
    
    # Wait between tests to avoid overwhelming the server
    echo "Waiting 30 seconds before next test..."
    sleep 30
done

echo ""
echo "=========================================="
echo "All UI tests completed successfully!"
echo "=========================================="
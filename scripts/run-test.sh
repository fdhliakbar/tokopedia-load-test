#!/bin/bash

# Tokopedia Load Test Runner
# Usage: ./run-test.sh <test-plan> [environment] [additional-params]

set -e

# Default values
ENVIRONMENT="${2:-default}"
REPORTS_DIR="reports"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Check if JMeter is installed
if ! command -v jmeter &> /dev/null; then
    echo "Error: JMeter is not installed or not in PATH"
    echo "Please install JMeter and ensure it's accessible via 'jmeter' command"
    exit 1
fi

# Check if test plan file exists
if [ ! -f "$1" ]; then
    echo "Error: Test plan file '$1' not found"
    echo "Usage: $0 <test-plan> [environment] [additional-params]"
    exit 1
fi

TEST_PLAN="$1"
TEST_NAME=$(basename "$TEST_PLAN" .jmx)
RESULT_FILE="${REPORTS_DIR}/${TEST_NAME}_${ENVIRONMENT}_${TIMESTAMP}.jtl"
HTML_REPORT_DIR="${REPORTS_DIR}/${TEST_NAME}_${ENVIRONMENT}_${TIMESTAMP}_html"

# Create reports directory if it doesn't exist
mkdir -p "$REPORTS_DIR"

echo "=========================================="
echo "Tokopedia Load Test Runner"
echo "=========================================="
echo "Test Plan: $TEST_PLAN"
echo "Environment: $ENVIRONMENT"
echo "Result File: $RESULT_FILE"
echo "HTML Report: $HTML_REPORT_DIR"
echo "=========================================="

# Load environment-specific properties
PROPS_FILE="config/environments.properties"
if [ -f "$PROPS_FILE" ]; then
    echo "Loading configuration from: $PROPS_FILE"
    JMETER_PROPS="-p $PROPS_FILE"
else
    echo "Warning: Configuration file $PROPS_FILE not found"
    JMETER_PROPS=""
fi

# Run the test
echo "Starting test execution..."
jmeter -n -t "$TEST_PLAN" -l "$RESULT_FILE" $JMETER_PROPS $3

# Check if test was successful
if [ $? -eq 0 ]; then
    echo "Test execution completed successfully!"
    
    # Generate HTML report
    echo "Generating HTML report..."
    jmeter -g "$RESULT_FILE" -o "$HTML_REPORT_DIR"
    
    if [ $? -eq 0 ]; then
        echo "HTML report generated successfully!"
        echo "Report location: $HTML_REPORT_DIR/index.html"
    else
        echo "Warning: Failed to generate HTML report"
    fi
    
    # Display basic statistics
    echo ""
    echo "=========================================="
    echo "Test Summary"
    echo "=========================================="
    if command -v awk &> /dev/null && [ -f "$RESULT_FILE" ]; then
        total_samples=$(tail -n +2 "$RESULT_FILE" | wc -l)
        success_samples=$(tail -n +2 "$RESULT_FILE" | awk -F',' '$8=="true" {count++} END {print count+0}')
        error_rate=$(awk -v total="$total_samples" -v success="$success_samples" 'BEGIN {printf "%.2f", ((total-success)/total)*100}')
        
        echo "Total Samples: $total_samples"
        echo "Successful Samples: $success_samples"
        echo "Error Rate: $error_rate%"
    fi
    echo "=========================================="
    
else
    echo "Test execution failed!"
    exit 1
fi
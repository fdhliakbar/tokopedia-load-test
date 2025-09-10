#!/bin/bash

# JMeter Load Testing Execution Script for Tokopedia
# Usage: ./run-test.sh [test-type] [environment] [report-name]

set -e

# Default values
TEST_TYPE=${1:-baseline}
ENVIRONMENT=${2:-dev}
REPORT_NAME=${3:-"tokopedia-test-$(date +%Y%m%d-%H%M%S)"}

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
TEST_PLANS_DIR="$PROJECT_DIR/test-plans"
RESULTS_DIR="$PROJECT_DIR/results"
CONFIG_DIR="$PROJECT_DIR/config"

# Create results directories
mkdir -p "$RESULTS_DIR/logs"
mkdir -p "$RESULTS_DIR/reports"

# Function to check if JMeter is installed
check_jmeter() {
    if ! command -v jmeter &> /dev/null; then
        echo "Error: JMeter is not installed or not in PATH"
        echo "Please install Apache JMeter and ensure it's in your PATH"
        exit 1
    fi
}

# Function to validate test type
validate_test_type() {
    case $TEST_TYPE in
        baseline|stress|spike|endurance|api)
            echo "Running $TEST_TYPE test..."
            ;;
        *)
            echo "Error: Invalid test type '$TEST_TYPE'"
            echo "Valid options: baseline, stress, spike, endurance, api"
            exit 1
            ;;
    esac
}

# Function to find test plan file
get_test_plan() {
    case $TEST_TYPE in
        baseline)
            if [ -f "$TEST_PLANS_DIR/baseline/tokopedia-homepage-baseline.jmx" ]; then
                echo "$TEST_PLANS_DIR/baseline/tokopedia-homepage-baseline.jmx"
            elif [ -f "$TEST_PLANS_DIR/baseline/tokopedia-search-baseline.jmx" ]; then
                echo "$TEST_PLANS_DIR/baseline/tokopedia-search-baseline.jmx"
            else
                echo "Error: No baseline test plan found"
                exit 1
            fi
            ;;
        stress)
            echo "$TEST_PLANS_DIR/stress/tokopedia-stress-test.jmx"
            ;;
        spike)
            echo "$TEST_PLANS_DIR/spike/tokopedia-spike-test.jmx"
            ;;
        endurance)
            echo "$TEST_PLANS_DIR/endurance/tokopedia-endurance-test.jmx"
            ;;
        api)
            echo "$TEST_PLANS_DIR/api/tokopedia-api-test.jmx"
            ;;
    esac
}

# Function to run JMeter test
run_test() {
    local test_plan="$1"
    local log_file="$RESULTS_DIR/logs/${REPORT_NAME}.jtl"
    local report_dir="$RESULTS_DIR/reports/$REPORT_NAME"
    local properties_file="$CONFIG_DIR/environments/${ENVIRONMENT}.properties"
    
    echo "=================================================="
    echo "Tokopedia Load Testing Execution"
    echo "=================================================="
    echo "Test Type: $TEST_TYPE"
    echo "Environment: $ENVIRONMENT"
    echo "Test Plan: $test_plan"
    echo "Log File: $log_file"
    echo "Report Directory: $report_dir"
    echo "=================================================="
    
    # Check if test plan exists
    if [ ! -f "$test_plan" ]; then
        echo "Error: Test plan file not found: $test_plan"
        exit 1
    fi
    
    # Check if properties file exists
    if [ ! -f "$properties_file" ]; then
        echo "Warning: Properties file not found: $properties_file"
        echo "Using default JMeter properties"
        properties_file=""
    fi
    
    # Build JMeter command
    jmeter_cmd="jmeter -n"
    jmeter_cmd="$jmeter_cmd -t \"$test_plan\""
    jmeter_cmd="$jmeter_cmd -l \"$log_file\""
    jmeter_cmd="$jmeter_cmd -e -o \"$report_dir\""
    
    if [ -n "$properties_file" ]; then
        jmeter_cmd="$jmeter_cmd -q \"$properties_file\""
    fi
    
    # Add additional JMeter properties
    jmeter_cmd="$jmeter_cmd -Juser.dir=\"$PROJECT_DIR\""
    
    echo "Executing: $jmeter_cmd"
    echo ""
    
    # Execute JMeter test
    eval $jmeter_cmd
    
    echo ""
    echo "=================================================="
    echo "Test execution completed!"
    echo "Results available at: $report_dir"
    echo "Raw data available at: $log_file"
    echo "=================================================="
}

# Main execution
main() {
    echo "Starting Tokopedia Load Testing..."
    
    check_jmeter
    validate_test_type
    
    test_plan=$(get_test_plan)
    run_test "$test_plan"
}

# Run main function
main "$@"
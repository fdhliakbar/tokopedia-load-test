# Tokopedia Load Testing with JMeter

<div align="center">
<img src="https://d2ksis2z2ke2jq.cloudfront.net/uploads/2020/06/Tokopedia-Logo-Vector-VisualLogo-e1593035543226.png" width="80%" alt="Tokopedia Banner"/>
</div>

This repository contains comprehensive performance and load testing scripts for the Tokopedia website using Apache JMeter.

## Project Structure

```
├── test-plans/          # JMeter test plan files (.jmx)
│   ├── baseline/        # Normal load testing scenarios
│   ├── stress/          # High load stress testing
│   ├── spike/           # Sudden load spike testing
│   ├── endurance/       # Long duration testing
│   └── api/            # API endpoint testing
├── test-data/          # Test data files (CSV, JSON)
│   ├── users/          # User credentials and profiles
│   ├── products/       # Product data for testing
│   └── search-terms/   # Search keywords and parameters
├── config/             # Configuration files
│   ├── environments/   # Environment-specific settings
│   └── properties/     # JMeter properties files
├── results/            # Test execution results
│   ├── reports/        # HTML reports and dashboards
│   └── logs/          # JMeter execution logs
├── scripts/            # Utility and analysis scripts
│   ├── utilities/      # Helper scripts for test execution
│   └── analysis/       # Result analysis scripts
└── docs/              # Documentation and guides
```

## Prerequisites

- Java 8 or higher
- Apache JMeter 5.0 or higher
- Internet connection for testing Tokopedia website

## Quick Start

1. Install Apache JMeter from [https://jmeter.apache.org/](https://jmeter.apache.org/)
2. Clone this repository
3. Navigate to the test-plans directory
4. Open any .jmx file with JMeter GUI or run via command line

## Test Scenarios

### 1. Baseline Performance Testing
- Normal user load simulation
- Response time validation
- Throughput measurement

### 2. Stress Testing
- High concurrent user load
- System breaking point identification
- Resource utilization monitoring

### 3. Spike Testing
- Sudden traffic increase simulation
- System recovery validation
- Auto-scaling behavior testing

### 4. Endurance Testing
- Extended duration load testing
- Memory leak detection
- Performance degradation analysis

### 5. API Testing
- Backend service performance
- Database query optimization
- Microservice response times

## Running Tests

### GUI Mode (Development)
```bash
jmeter -t test-plans/baseline/tokopedia-homepage-baseline.jmx
```

### Command Line Mode (CI/CD)
```bash
jmeter -n -t test-plans/baseline/tokopedia-homepage-baseline.jmx -l results/logs/homepage-test.jtl -e -o results/reports/homepage-report/
```

## Test Data

Test data files are provided in CSV format for easy parameterization:
- User credentials for login testing
- Product IDs for detail page testing
- Search terms for search functionality testing

## Reporting

JMeter generates comprehensive HTML reports including:
- Response time graphs
- Throughput charts
- Error rate analysis
- Performance metrics summary

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your test scenarios
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

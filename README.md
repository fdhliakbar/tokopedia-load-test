# Tokopedia Load Testing with JMeter

A comprehensive performance testing suite for Tokopedia e-commerce platform using Apache JMeter.

## Overview

This repository contains JMeter test plans and configurations for performance testing various aspects of the Tokopedia website including:
- Homepage load testing
- Search functionality performance
- Product page response times
- Category browsing performance
- API endpoint testing

## Repository Structure

```
├── test-plans/           # JMeter test plan files (.jmx)
│   ├── api/             # API-specific test plans
│   └── ui/              # UI/Web interface test plans
├── config/              # Configuration files for different environments
├── data/                # Test data files (CSV, JSON)
├── reports/             # Generated test reports and results
├── scripts/             # Utility scripts for running tests
└── docs/                # Additional documentation
```

## Prerequisites

- Apache JMeter 5.5 or higher
- Java 8 or higher
- Basic understanding of performance testing concepts

## Quick Start

1. **Install JMeter**
   ```bash
   # Download from https://jmeter.apache.org/download_jmeter.cgi
   # Or using package manager (macOS)
   brew install jmeter
   ```

2. **Clone the repository**
   ```bash
   git clone https://github.com/fdhliakbar/tokopedia-load-test.git
   cd tokopedia-load-test
   ```

3. **Run a basic test**
   ```bash
   # Run homepage load test
   jmeter -n -t test-plans/ui/tokopedia-homepage-test.jmx -l reports/homepage-results.jtl
   ```

## Test Plans

### UI Test Plans
- `tokopedia-homepage-test.jmx` - Homepage performance testing
- `tokopedia-search-test.jmx` - Search functionality testing
- `tokopedia-product-test.jmx` - Product page performance testing
- `tokopedia-category-test.jmx` - Category browsing performance

### API Test Plans
- `tokopedia-api-search.jmx` - Search API performance testing
- `tokopedia-api-product.jmx` - Product API performance testing

## Configuration

Configuration files in the `config/` directory allow you to customize test parameters:
- `environments.properties` - Environment-specific settings
- `user-config.properties` - User simulation parameters
- `load-config.properties` - Load testing configuration

## Test Data

The `data/` directory contains:
- `search-terms.csv` - Sample search terms for testing
- `product-ids.csv` - Sample product IDs
- `user-agents.csv` - Various user agent strings

## Running Tests

### Command Line Execution
```bash
# Basic test execution
jmeter -n -t test-plans/ui/tokopedia-homepage-test.jmx -l reports/results.jtl

# Test with custom properties
jmeter -n -t test-plans/ui/tokopedia-homepage-test.jmx -l reports/results.jtl -Jusers=50 -Jrampup=300

# Generate HTML report
jmeter -g reports/results.jtl -o reports/html-report/
```

### Using Scripts
```bash
# Run all UI tests
./scripts/run-ui-tests.sh

# Run specific test with environment
./scripts/run-test.sh test-plans/ui/tokopedia-homepage-test.jmx production
```

## Test Results and Reporting

Test results are stored in the `reports/` directory:
- `.jtl` files contain raw test results
- HTML reports provide detailed analysis
- CSV files for data analysis in external tools

## Best Practices

1. **Test Environment**: Always test against appropriate environments (staging/pre-production)
2. **Rate Limiting**: Respect Tokopedia's rate limits and terms of service
3. **Data Privacy**: Never use real customer data in tests
4. **Monitoring**: Monitor system resources during test execution
5. **Baseline**: Establish baseline performance metrics before optimization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your test plans with proper documentation
4. Test your changes
5. Submit a pull request

## Disclaimer

This repository is for educational and testing purposes only. Ensure you have proper authorization before conducting performance tests against any website. Always follow ethical testing practices and respect website terms of service.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
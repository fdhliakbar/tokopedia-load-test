# JMeter Test Execution Guide

## Prerequisites

1. **Java Installation**
   - Java 8 or higher required
   - Verify with: `java -version`

2. **Apache JMeter Installation**
   - Download from: https://jmeter.apache.org/download_jmeter.cgi
   - Add JMeter bin directory to PATH
   - Verify with: `jmeter -v`

3. **System Requirements**
   - Minimum 4GB RAM
   - Good network connection
   - Sufficient disk space for results

## Quick Start

### Using the Automated Script (Recommended)

```bash
# Make script executable
chmod +x scripts/utilities/run-test.sh

# Run baseline test in development environment
./scripts/utilities/run-test.sh baseline dev

# Run stress test in production environment
./scripts/utilities/run-test.sh stress prod

# Run spike test with custom report name
./scripts/utilities/run-test.sh spike dev my-spike-test-001
```

### Manual Execution

#### GUI Mode (For Development and Debugging)
```bash
# Open JMeter GUI with a test plan
jmeter -t test-plans/baseline/tokopedia-homepage-baseline.jmx

# Open JMeter GUI with properties
jmeter -q config/environments/dev.properties -t test-plans/baseline/tokopedia-homepage-baseline.jmx
```

#### Command Line Mode (For Production Testing)
```bash
# Basic command line execution
jmeter -n -t test-plans/baseline/tokopedia-homepage-baseline.jmx \
       -l results/logs/baseline-test.jtl \
       -e -o results/reports/baseline-report/

# With environment configuration
jmeter -n -t test-plans/stress/tokopedia-stress-test.jmx \
       -q config/environments/prod.properties \
       -l results/logs/stress-test.jtl \
       -e -o results/reports/stress-report/

# With custom parameters
jmeter -n -t test-plans/spike/tokopedia-spike-test.jmx \
       -JTHREADS=50 -JRAMP_UP=120 -JDURATION=600 \
       -l results/logs/spike-test.jtl \
       -e -o results/reports/spike-report/
```

## Test Plan Details

### 1. Baseline Testing (`test-plans/baseline/`)

**Purpose:** Establish performance baseline under normal load conditions

**Test Plans:**
- `tokopedia-homepage-baseline.jmx` - Homepage performance testing
- `tokopedia-search-baseline.jmx` - Search functionality testing

**Default Parameters:**
- Threads: 10 users
- Ramp-up: 60 seconds
- Duration: 300 seconds (5 minutes)

**Key Scenarios:**
- Homepage loading
- Category browsing
- Search functionality
- Product listing

### 2. Stress Testing (`test-plans/stress/`)

**Purpose:** Identify system breaking points under high load

**Test Plans:**
- `tokopedia-stress-test.jmx` - High load stress testing

**Default Parameters:**
- Threads: 100 users
- Ramp-up: 300 seconds
- Duration: 900 seconds (15 minutes)

**Key Features:**
- Random user behavior simulation
- Multiple concurrent scenarios
- Resource monitoring integration
- Performance degradation analysis

### 3. Spike Testing (`test-plans/spike/`)

**Purpose:** Test system behavior under sudden traffic surges

**Test Plans:**
- `tokopedia-spike-test.jmx` - Traffic spike simulation

**Test Phases:**
1. **Normal Load** (10 users, 15 minutes)
2. **Spike Load** (200 users, 2 minutes, starts after 5 minutes)
3. **Recovery Load** (10 users, 5 minutes, starts after spike)

**Key Metrics:**
- Response time during spike
- Error rate increase
- System recovery time
- Resource utilization

### 4. API Testing (`test-plans/api/`)

**Purpose:** Performance testing of backend GraphQL and REST APIs

**Test Plans:**
- `tokopedia-api-test.jmx` - API endpoint performance

**Default Parameters:**
- Threads: 20 users
- Ramp-up: 120 seconds
- Duration: 600 seconds (10 minutes)

**Tested Endpoints:**
- GraphQL Search API
- Category List API
- Product Details API
- User Authentication API

## Configuration

### Environment Files

**Development (`config/environments/dev.properties`)**
- Lower thread counts
- Longer response time thresholds
- Suitable for initial testing

**Production (`config/environments/prod.properties`)**
- Production-like load parameters
- Strict performance thresholds
- Full-scale testing configuration

### Custom Parameters

Override default values using JMeter properties:

```bash
jmeter -n -t test-plan.jmx \
       -JTHREADS=50 \
       -JRAMP_UP=300 \
       -JDURATION=1800 \
       -JBASE_URL=https://staging.tokopedia.com
```

## Test Data

### Search Terms (`test-data/search-terms/search-keywords.csv`)
- 30+ popular search terms
- Category classifications
- Expected result counts

### User Data (`test-data/users/test-users.csv`)
- Test user credentials
- User types (regular, premium)
- Geographic locations

### Product Data (`test-data/products/test-products.csv`)
- Sample product IDs
- Product categories
- Price ranges

## Results and Reporting

### Automated Reports

JMeter generates comprehensive HTML reports including:
- **Dashboard** - Overview of test execution
- **Statistics** - Detailed performance metrics
- **Response Time Charts** - Performance over time
- **Throughput Graphs** - Request/second analysis
- **Error Analysis** - Failure rate and error types

### Key Metrics to Monitor

1. **Response Time**
   - Average response time
   - 90th, 95th, 99th percentiles
   - Response time over time

2. **Throughput**
   - Requests per second
   - Transactions per second
   - Data transfer rates

3. **Error Rate**
   - Percentage of failed requests
   - Error types and causes
   - Error rate over time

4. **Resource Utilization**
   - CPU usage
   - Memory consumption
   - Network bandwidth

### Performance Thresholds

**Acceptable Limits:**
- Homepage: < 5 seconds
- Search: < 8 seconds
- API calls: < 3 seconds
- Error rate: < 5%

**Critical Limits:**
- Any response > 15 seconds
- Error rate > 10%
- System unresponsive

## Best Practices

### Test Execution

1. **Start Small**
   - Begin with baseline tests
   - Gradually increase load
   - Validate test environment

2. **Monitor Resources**
   - Watch system metrics
   - Monitor application logs
   - Check database performance

3. **Document Results**
   - Record test conditions
   - Note any anomalies
   - Save configuration used

### Test Environment

1. **Network Considerations**
   - Use stable internet connection
   - Consider network latency
   - Account for geographical distance

2. **System Resources**
   - Ensure adequate JMeter resources
   - Monitor JMeter machine performance
   - Use distributed testing for high loads

3. **Test Data Management**
   - Use realistic test data
   - Rotate user credentials
   - Update search terms regularly

## Troubleshooting

### Common Issues

1. **Connection Timeouts**
   - Increase timeout values
   - Check network connectivity
   - Verify target system availability

2. **Memory Issues**
   - Increase JMeter heap size: `export HEAP="-Xms1g -Xmx4g"`
   - Reduce sample storage
   - Use command line mode

3. **High Error Rates**
   - Check rate limiting
   - Verify test data validity
   - Monitor target system health

### JMeter Optimization

```bash
# Increase JMeter memory
export HEAP="-Xms2g -Xmx4g -XX:MaxMetaspaceSize=256m"

# Disable GUI components in command line
jmeter -n -t test-plan.jmx -l results.jtl

# Use minimal result collection
jmeter.save.saveservice.output_format=csv
jmeter.save.saveservice.response_data=false
```

## Support and Resources

- [Apache JMeter Documentation](https://jmeter.apache.org/usermanual/)
- [JMeter Best Practices](https://jmeter.apache.org/usermanual/best-practices.html)
- [Performance Testing Guide](https://jmeter.apache.org/usermanual/jmeter_distributed_testing_step_by_step.html)
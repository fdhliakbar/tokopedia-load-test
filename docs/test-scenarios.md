# Test Scenarios Overview

## Scenario Descriptions

### 1. Baseline Performance Testing

**Objective:** Establish performance benchmarks under normal user load

**Test Plan:** `tokopedia-homepage-baseline.jmx` & `tokopedia-search-baseline.jmx`

**Load Profile:**
- Users: 10 concurrent users
- Ramp-up: 60 seconds
- Duration: 5 minutes
- Think time: 2-5 seconds between requests

**User Journey:**
1. Load homepage
2. Browse category pages
3. Perform searches
4. View search results

**Success Criteria:**
- Response time < 5 seconds (homepage)
- Response time < 8 seconds (search)
- Error rate < 1%
- Successful completion of all transactions

### 2. Stress Testing

**Objective:** Identify system breaking points and maximum capacity

**Test Plan:** `tokopedia-stress-test.jmx`

**Load Profile:**
- Users: 100 concurrent users
- Ramp-up: 5 minutes
- Duration: 15 minutes
- Think time: 0.5-2 seconds between requests

**User Behavior:**
- Random selection of user actions
- Higher request frequency
- Multiple concurrent scenarios

**Success Criteria:**
- System remains responsive
- Error rate < 5%
- Response time degradation < 200%
- No system crashes or timeouts

### 3. Spike Testing

**Objective:** Test system behavior under sudden traffic increases

**Test Plan:** `tokopedia-spike-test.jmx`

**Load Profile:**
- Phase 1: 10 users for 15 minutes (baseline)
- Phase 2: 200 users for 2 minutes (spike)
- Phase 3: 10 users for 5 minutes (recovery)

**Key Measurements:**
- Response time during spike
- Error rate increase
- System recovery time
- Performance stabilization

**Success Criteria:**
- System handles spike without crashing
- Recovery to baseline performance within 5 minutes
- Error rate during spike < 10%
- No data loss or corruption

### 4. Endurance Testing

**Objective:** Validate system stability over extended periods

**Test Plan:** `tokopedia-endurance-test.jmx`

**Load Profile:**
- Users: 20 concurrent users
- Ramp-up: 2 minutes
- Duration: 60 minutes (1 hour)
- Think time: 5-15 seconds between requests

**Focus Areas:**
- Memory leak detection
- Performance degradation over time
- Resource consumption patterns
- System stability

**Success Criteria:**
- No performance degradation > 10%
- Memory usage remains stable
- No memory leaks detected
- Error rate < 2%

### 5. API Performance Testing

**Objective:** Test backend API performance and scalability

**Test Plan:** `tokopedia-api-test.jmx`

**Load Profile:**
- Users: 20 concurrent users
- Ramp-up: 2 minutes
- Duration: 10 minutes
- Think time: 1-3 seconds between requests

**API Endpoints Tested:**
- GraphQL Search API
- Category List API
- Product Details API
- Authentication endpoints

**Success Criteria:**
- API response time < 3 seconds
- Data integrity maintained
- Proper error handling
- Rate limiting respected

## Performance Thresholds

### Response Time Targets

| Component | Excellent | Acceptable | Poor |
|-----------|-----------|------------|------|
| Homepage | < 2s | < 5s | > 5s |
| Search | < 3s | < 8s | > 8s |
| Category | < 2.5s | < 6s | > 6s |
| API Calls | < 1s | < 3s | > 3s |

### Throughput Targets

| Test Type | Target RPS | Min RPS | Max Users |
|-----------|------------|---------|-----------|
| Baseline | 5-10 | 3 | 10 |
| Stress | 20-50 | 10 | 100 |
| Spike | 50-100 | 20 | 200 |
| Endurance | 8-15 | 5 | 20 |
| API | 10-30 | 5 | 20 |

### Error Rate Thresholds

- **Baseline:** < 1%
- **Stress:** < 5%
- **Spike:** < 10% (during spike), < 1% (recovery)
- **Endurance:** < 2%
- **API:** < 1%

## Test Execution Strategy

### Pre-Test Preparation

1. **Environment Setup**
   - Verify JMeter installation
   - Check network connectivity
   - Validate test data files
   - Configure monitoring tools

2. **Test Data Preparation**
   - Refresh search terms
   - Update user credentials
   - Verify product data

3. **Baseline Establishment**
   - Run single user test
   - Verify all functionality
   - Document baseline metrics

### Test Execution Order

1. **Baseline Testing** (Start here)
   - Establish performance benchmarks
   - Validate test scenarios
   - Confirm system health

2. **API Testing** (Parallel or sequential)
   - Test backend performance
   - Validate data integrity
   - Check rate limiting

3. **Stress Testing** (After baseline)
   - Gradually increase load
   - Monitor system resources
   - Identify breaking points

4. **Spike Testing** (After stress)
   - Test sudden load increases
   - Validate recovery mechanisms
   - Check auto-scaling behavior

5. **Endurance Testing** (Final)
   - Long-duration stability test
   - Monitor for memory leaks
   - Validate sustained performance

### Post-Test Analysis

1. **Performance Metrics**
   - Response time analysis
   - Throughput calculation
   - Error rate investigation
   - Resource utilization review

2. **Bottleneck Identification**
   - Database performance
   - Network latency
   - Server capacity
   - Application efficiency

3. **Recommendations**
   - Performance improvements
   - Capacity planning
   - Infrastructure scaling
   - Code optimization

## Monitoring and Alerting

### Key Metrics to Monitor

1. **Application Metrics**
   - Response times
   - Throughput (RPS/TPS)
   - Error rates
   - Active users

2. **System Metrics**
   - CPU utilization
   - Memory usage
   - Disk I/O
   - Network bandwidth

3. **Database Metrics**
   - Query response time
   - Connection pool usage
   - Lock contention
   - Transaction rates

### Alert Thresholds

- Response time > 10 seconds
- Error rate > 5%
- CPU usage > 80%
- Memory usage > 85%
- Disk usage > 90%

## Risk Mitigation

### Potential Risks

1. **System Overload**
   - Gradual load increase
   - Real-time monitoring
   - Emergency stop procedures

2. **Data Corruption**
   - Use read-only operations
   - Test data isolation
   - Regular backups

3. **Network Issues**
   - Multiple test locations
   - Network redundancy
   - Bandwidth monitoring

### Contingency Plans

1. **Test Abortion**
   - Immediate stop procedures
   - System health checks
   - Recovery validation

2. **System Recovery**
   - Service restart procedures
   - Database recovery
   - Performance validation

3. **Result Analysis**
   - Alternative metrics
   - Manual verification
   - Trend analysis
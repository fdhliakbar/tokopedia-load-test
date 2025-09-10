# JMeter Setup and Installation Guide

This guide provides step-by-step instructions for setting up Apache JMeter for Tokopedia performance testing.

## Prerequisites

- Java 8 or higher (Java 11+ recommended)
- At least 4GB RAM available for testing
- Stable internet connection

## Installation

### Option 1: Download from Apache JMeter Website

1. Visit [Apache JMeter Downloads](https://jmeter.apache.org/download_jmeter.cgi)
2. Download the latest binary release (apache-jmeter-x.x.tgz or apache-jmeter-x.x.zip)
3. Extract the archive to your preferred location
4. Add JMeter's `bin` directory to your system PATH

### Option 2: Package Manager Installation

#### macOS (using Homebrew)
```bash
brew install jmeter
```

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install jmeter
```

#### Windows (using Chocolatey)
```bash
choco install jmeter
```

## Verification

Verify your installation by running:
```bash
jmeter -version
```

You should see output showing the JMeter version and Java version.

## JMeter Configuration

### Memory Settings

For better performance during load testing, increase JMeter's memory allocation:

Edit `jmeter.bat` (Windows) or `jmeter` (Unix/Linux) in the JMeter `bin` directory:

```bash
# Increase heap size
HEAP="-Xms1g -Xmx4g -XX:MaxMetaspaceSize=256m"
```

### JMeter Properties

Create or edit `user.properties` in the JMeter `bin` directory:

```properties
# Increase timeout values
httpclient.timeout=60000
httpclient.reset_state_on_thread_group_iteration=true

# Improve performance
jmeter.save.saveservice.thread_counts=true
jmeter.save.saveservice.subresults=false
jmeter.save.saveservice.response_data=false

# Enable SSL debugging if needed (for development only)
# javax.net.debug=ssl
```

## Running Tests

### GUI Mode (for test development)
```bash
jmeter
```

### Command Line Mode (for actual testing)
```bash
jmeter -n -t test-plan.jmx -l results.jtl
```

### Generate HTML Report
```bash
jmeter -g results.jtl -o html-report/
```

## Best Practices

1. **Always use command-line mode for actual load testing** - GUI mode is only for test development
2. **Monitor system resources** during test execution
3. **Use appropriate heap size** based on your test requirements
4. **Clean up old result files** regularly to save disk space
5. **Test on dedicated machines** when possible to avoid interference

## Troubleshooting

### Common Issues

#### Java Version Errors
Ensure you have Java 8 or higher installed:
```bash
java -version
```

#### Out of Memory Errors
Increase heap size in JMeter startup scripts or use:
```bash
export JVM_ARGS="-Xms1g -Xmx4g"
jmeter -n -t test-plan.jmx -l results.jtl
```

#### SSL Certificate Issues
For testing HTTPS sites with self-signed certificates:
```bash
jmeter -Jhttps.default.protocol=TLSv1.2 -n -t test-plan.jmx -l results.jtl
```

## Additional Resources

- [Apache JMeter User Manual](https://jmeter.apache.org/usermanual/index.html)
- [JMeter Best Practices](https://jmeter.apache.org/usermanual/best-practices.html)
- [Performance Testing with JMeter](https://jmeter.apache.org/usermanual/jmeter_distributed_testing_step_by_step.html)
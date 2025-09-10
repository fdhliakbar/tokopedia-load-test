# Test Results and Reports

This directory contains generated test results and HTML reports from JMeter test executions.

## File Types

- `*.jtl` - Raw JMeter test results in JTL format
- `*.html` - Generated HTML reports with detailed analysis
- `*.csv` - CSV format results for data analysis
- `*.log` - JMeter execution logs

## Report Structure

Each test execution generates files with the naming convention:
```
{test-name}_{environment}_{timestamp}.{extension}
```

Example:
```
tokopedia-homepage-test_production_20231201_143045.jtl
tokopedia-homepage-test_production_20231201_143045_html/
```

## Viewing Reports

Open the `index.html` file in any HTML report directory to view detailed performance analysis including:
- Response time charts
- Throughput graphs
- Error analysis
- Performance metrics over time

## Note

This directory is excluded from version control via `.gitignore` to prevent large result files from being committed to the repository.
const report = require('multiple-cucumber-html-reporter');

report.generate({
    jsonDir: 'test-reports/cucumber-js/step-definitions',
    reportPath: 'test-reports/cucumber-js/reports/step-definitions',
    reportName: 'Stap definities tests',
    hideMetadata: true
});

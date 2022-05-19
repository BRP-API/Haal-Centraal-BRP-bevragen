const reporter = require('cucumber-html-reporter');

const options = {
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result.json',
    output: 'docs/features/test-report.html',
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'Haal Centraal BRP Bevragen API specificaties',
    brandTitle:'Haal Centraal'
};

reporter.generate(options);

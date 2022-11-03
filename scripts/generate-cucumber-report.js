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

const optionsDev = {
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-dev.json',
    output: 'docs/features/test-report-dev.html',
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'Haal Centraal BRP Bevragen API specificaties (DEV)',
    brandTitle:'Haal Centraal'
};

reporter.generate(optionsDev);

const optionsGba = {
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-gba.json',
    output: 'docs/features/test-report-gba.html',
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'Haal Centraal BRP Bevragen API specificaties (GBA)',
    brandTitle:'Haal Centraal'
};

reporter.generate(optionsGba);

const reporter = require('cucumber-html-reporter');
const apiName = 'Haal Centraal BRP Bevragen API';
const gbaVersion = 'GBA 2.0.25'
const proxyVersion = 'Proxy 2.0.14'

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-raadpleeg-en-zoek-gba.json',
    output: 'docs/features/test-report-raadpleeg-en-zoek-gba.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'raadpleeg & zoek features',
    brandTitle: `${apiName} - ${gbaVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-raadpleeg-en-zoek.json',
    output: 'docs/features/test-report-raadpleeg-en-zoek.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'raadpleeg & zoek features',
    brandTitle: `${apiName} - ${proxyVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-persoon-beperkt-gba.json',
    output: 'docs/features/test-report-persoon-beperkt-gba.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'persoon beperkt features',
    brandTitle: `${apiName} - ${gbaVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-persoon-beperkt.json',
    output: 'docs/features/test-report-persoon-beperkt.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'persoon beperkt features',
    brandTitle: `${apiName} - ${proxyVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-persoon-gba.json',
    output: 'docs/features/test-report-persoon-gba.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'persoon features',
    brandTitle: `${apiName} - ${gbaVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-persoon.json',
    output: 'docs/features/test-report-persoon.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'persoon features',
    brandTitle: `${apiName} - ${proxyVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-persoon-verblijfplaats.json',
    output: 'docs/features/test-report-persoon-verblijfplaats.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'persoon verblijfplaats features',
    brandTitle: `${apiName} - ${proxyVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-persoon-verblijfstitel.json',
    output: 'docs/features/test-report-persoon-verblijfstitel.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'persoon verblijfstitel features',
    brandTitle: `${apiName} - ${proxyVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-persoon-verificatie.json',
    output: 'docs/features/test-report-persoon-verificatie.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'persoon verificatie features',
    brandTitle: `${apiName} - ${proxyVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-autorisatie.json',
    output: 'docs/features/test-report-autorisatie.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'v 2.0.24',
    brandTitle:'Haal Centraal BRP Bevragen API - autorisatie'
});

const fs = require('fs');
const path = require('path');
const { processFile } = require('./process-cucumber-file');

const outputFile = path.join(__dirname, './../test-reports/cucumber-js/step-summary.txt');
fs.writeFileSync(outputFile, '', 'utf8');

const fileMap = new Map([
    ["./../test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt", "docs (zonder integratie)"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-integratie-summary.txt", "docs (integratie)"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-informatie-api-summary.txt", "docs informatie api context"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-data-api-summary.txt", "docs data api context"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-gezag-api-summary.txt", "docs gezag api context"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated-summary.txt", "docs gezag api deprecated context"]
]);

fileMap.forEach((caption, filePath) => {
    processFile(path.join(__dirname, filePath), outputFile, caption);
});

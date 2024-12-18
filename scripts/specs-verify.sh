#!/bin/bash

echo "### Cucumber Test Reports"

echo "#### Step definitions validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                features/docs \
                --tags "not @integratie" \
                --tags "not @skip-verify" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

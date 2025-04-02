#!/bin/bash

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                features/docs \
                -p UnitTest \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-integratie-summary.txt \
                -f summary \
                features/docs \
                -p Integratie \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-informatie-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-informatie-api-summary.txt \
                -f summary \
                features/docs \
                -p InfoApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-data-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-data-api-summary.txt \
                -f summary \
                features/docs \
                -p DataApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-gezag-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-summary.txt \
                -f summary \
                features/docs \
                -p GezagApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated-summary.txt \
                -f summary \
                features/docs \
                -p GezagApiDeprecated \
                > /dev/null

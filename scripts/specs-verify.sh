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

npx cucumber-js -f json:./test-reports/cucumber-js/personen/test-result-gezag-service.json \
                -f summary:./test-reports/cucumber-js/personen/test-result-gezag-service-summary.txt \
                -f summary \
                features/gezag \
                -p GezagApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/personen/test-result-gezag-service-deprecated.json \
                -f summary:./test-reports/cucumber-js/personen/test-result-gezag-service-deprecated-summary.txt \
                -f summary \
                features/gezag \
                -p GezagApiDeprecated \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/personen/test-result-data-service.json \
                -f summary:./test-reports/cucumber-js/personen/test-result-data-service-summary.txt \
                -f summary \
                features/adressering \
                features/zoeken \
                -p DataApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/personen/test-result-informatie-service.json \
                -f summary:./test-reports/cucumber-js/personen/test-result-informatie-service-summary.txt \
                -f summary \
                features/adressering \
                features/zoeken \
                -p InfoApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/personen/test-result-autorisatie-protocollering.json \
                -f summary:./test-reports/cucumber-js/personen/test-result-autorisatie-protocollering-summary.txt \
                -f summary \
                features/adressering \
                features/zoeken \
                features/input-validatie/velden-vragen-met-fields \
                -p AenP \
                > /dev/null

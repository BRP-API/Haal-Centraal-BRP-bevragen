#!/bin/bash

npx cucumber-js -f json:./test-reports/cucumber-js/docs-features-test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/docs-features-test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                features/docs \
                --tags "not @integratie"

npx cucumber-js -f json:./test-reports/cucumber-js/input-validatie-personen-test-result.json \
                -f summary:./test-reports/cucumber-js/input-validatie-personen-test-result-summary.txt \
                -f summary \
                features/validatie/personen \
                --tags @fout-case

npx cucumber-js -f json:./test-reports/cucumber-js/autorisatie-personen-test-result.json \
                -f summary:./test-reports/cucumber-js/autorisatie-personen-test-result-summary.txt \
                -f summary \
                features/autorisatie/personen \
                --tags @fout-case

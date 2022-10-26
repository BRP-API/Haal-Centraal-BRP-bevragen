#!/bin/bash

mkdir -p docs/features

cucumber-js -f html:docs/features/test-result-dev.html \
            -f json:docs/features/test-result-dev.json \
            features/dev/*.feature \
            --tags "not @skip-verify"

cucumber-js -f html:docs/features/test-result-gba.html \
            -f json:docs/features/test-result-gba.json \
            features/gba-dev/*.feature \
            --tags "not @skip-verify"

cucumber-js -f html:docs/features/test-result.html \
            -f json:docs/features/test-result.json \
            features/aanhef.feature \
            features/aanschrijfwijze/**/*.feature \
            features/immigratie.feature \
            features/kinderen.feature \
            features/nationaliteit.feature \
            features/ouders.feature \
            features/overlijden-indicatie-overleden.feature \
            features/rni.feature \
            features/verblijfstitel.feature \
            --tags "not @proxy" --tags "not @skip-verify"
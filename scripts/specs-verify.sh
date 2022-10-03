#!/bin/bash

mkdir -p docs/features

cucumber-js -f html:docs/features/test-result.html \
            -f json:docs/features/test-result.json \
            gba-dev/kinderen-gba.feature \
            gba-dev/verblijfstitel.feature \
            features/aanhef.feature \
            features/aanschrijfwijze/**/*.feature \
            features/kinderen.feature \
            features/verblijfstitel.feature \
            --tags "not @gba" --tags "not @skip-verify"
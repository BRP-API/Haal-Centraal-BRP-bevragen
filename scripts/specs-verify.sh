#!/bin/bash

mkdir -p docs/features

cucumber-js -f html:docs/features/test-result.html \
            -f json:docs/features/test-result.json \
            features/dev/europees-kiesrecht.feature \
            features/dev/geboorte.feature \
            features/dev/gezagsverhouding.feature \
            features/dev/immigratie.feature \
            features/dev/kind*.feature \
            features/dev/leeftijd.feature \
            features/dev/naam.feature \
            features/dev/nationaliteit*.feature \
            features/dev/opschorting-bijhouding.feature \
            features/dev/ouder*.feature \
            features/dev/overlijden.feature \
            features/dev/partner*.feature \
            features/dev/persoon.feature \
            features/dev/rni.feature \
            features/dev/uitsluiting-kiesrecht.feature \
            features/dev/verblijfplaats-binnenland.feature \
            features/gba-dev/*.feature \
            features/aanhef.feature \
            features/aanschrijfwijze/**/*.feature \
            features/immigratie.feature \
            features/kiesrecht.feature \
            features/kinderen.feature \
            features/nationaliteit.feature \
            features/ouders.feature \
            features/overlijden-indicatie-overleden.feature \
            features/partners.feature \
            features/rni.feature \
            features/verblijfstitel.feature \
            --tags "not @gba" --tags "not @skip-verify"
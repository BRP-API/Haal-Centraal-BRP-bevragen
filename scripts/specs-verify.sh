#!/bin/bash

mkdir -p docs/features

cucumber-js -f html:docs/features/test-result.html \
            -f json:docs/features/test-result.json \
            features/dev/europees-kiesrecht.feature \
            features/dev/gezagsverhouding.feature \
            features/dev/kind-velden.feature \
            features/dev/nationaliteit*.feature \
            features/dev/opschorting-bijhouding.feature \
            features/dev/ouder.feature \
            features/dev/partner.feature \
            features/dev/persoon-adressering-inonderzoek.feature \
            features/dev/uitsluiting-kiesrecht.feature \
            features/gba-dev/*.feature \
            features/aanhef.feature \
            features/aanschrijfwijze/**/*.feature \
            features/kinderen.feature \
            features/nationaliteit.feature \
            features/ouders.feature \
            features/verblijfstitel.feature \
            --tags "not @gba" --tags "not @skip-verify"
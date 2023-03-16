#!/bin/bash

mkdir -p docs/features

cucumber-js -f json:docs/features/test-result-autorisatie-gba.json \
            -f summary:docs/features/test-result-autorisatie-gba-summary.txt \
            features/bevragen/**/*-gba.feature \
            --tags "not @skip-verify" --tags "@autorisatie"

cucumber-js -f json:docs/features/test-result-protocollering-gba.json \
            -f summary:docs/features/test-result-protocollering-gba-summary.txt \
            features/bevragen/**/*-gba.feature \
            --tags "not @skip-verify" --tags "@protocollering"

cucumber-js -f json:docs/features/test-result-zoeken-en-raadplegen-gba.json \
            -f summary:docs/features/test-result-zoeken-en-raadplegen-gba-summary.txt \
            features/bevragen/raadpleeg-met-burgerservicenummer \
            features/bevragen/zoek-met-geslachtsnaam-en-geboortedatum \
            features/bevragen/zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving \
            features/bevragen/zoek-met-nummeraanduiding-identificatie \
            features/bevragen/zoek-met-postcode-en-huisnummer \
            features/bevragen/zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving \
            --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering"

cucumber-js -f json:docs/features/test-result-zoeken-en-raadplegen.json \
            -f summary:docs/features/test-result-zoeken-en-raadplegen-summary.txt \
            features/bevragen/raadpleeg-met-burgerservicenummer \
            features/bevragen/zoek-met-geslachtsnaam-en-geboortedatum \
            features/bevragen/zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving \
            features/bevragen/zoek-met-nummeraanduiding-identificatie \
            features/bevragen/zoek-met-postcode-en-huisnummer \
            features/bevragen/zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving \
            --tags "not @skip-verify" --tags "not @gba"

cucumber-js -f json:docs/features/test-result-persoon-beperkt-gba.json \
            -f summary:docs/features/test-result-persoon-beperkt-gba-summary.txt \
            features/bevragen/persoon-beperkt \
            --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering"

cucumber-js -f json:docs/features/test-result-persoon-beperkt.json \
            -f summary:docs/features/test-result-persoon-beperkt-summary.txt \
            features/bevragen/persoon-beperkt \
            --tags "not @skip-verify" --tags "not @gba"

cucumber-js -f json:docs/features/test-result-persoon-gba.json \
            -f summary:docs/features/test-result-persoon-gba-summary.txt \
            features/bevragen/*.feature \
            features/bevragen/persoon/*.feature \
            --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering"

cucumber-js -f json:docs/features/test-result-persoon.json \
            -f summary:docs/features/test-result-persoon-summary.txt \
            features/bevragen/*.feature \
            features/bevragen/persoon/*.feature \
            --tags "not @skip-verify" --tags "not @gba"

verify() {
    cucumber-js -f json:docs/features/test-result-persoon-$1-gba.json \
                -f summary:docs/features/test-result-persoon-$1-gba-summary.txt \
                features/bevragen/persoon/$1 \
                --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering"

    cucumber-js -f json:docs/features/test-result-persoon-$1.json \
                -f summary:docs/features/test-result-persoon-$1-summary.txt \
                features/bevragen/persoon/$1 \
                --tags "not @skip-verify" --tags "not @gba"
}

verify "adressering"
verify "europees-kiesrecht"
verify "geboorte"
verify "geheimhouding"
verify "gezagsverhouding"
verify "immigratie"
verify "kind"
verify "leeftijd"
verify "naam"
verify "nationaliteit"
verify "opschorting-bijhouding"
verify "ouder"
verify "overlijden"
verify "partner"
verify "rni"
verify "uitsluiting-kiesrecht"
verify "verblijfplaats"
verify "verblijfstitel"
verify "verificatie"

#!/bin/bash

mkdir -p docs/features

cucumber-js -f html:docs/features/test-result-autorisatie.html \
            -f json:docs/features/test-result-autorisatie.json \
            features/bevragen/**/*-gba.feature \
            --tags "not @skip-verify" --tags "@autorisatie"

cucumber-js -f html:docs/features/test-result-protocollering.html \
            -f json:docs/features/test-result-protocollering.json \
            features/bevragen/**/*-gba.feature \
            --tags "not @skip-verify" --tags "@protocollering"

cucumber-js -f html:docs/features/test-result-raadpleeg-en-zoek-gba.html \
            -f json:docs/features/test-result-raadpleeg-en-zoek-gba.json \
            features/bevragen/raadpleeg-met-burgerservicenummer \
            features/bevragen/zoek-met-geslachtsnaam-en-geboortedatum \
            features/bevragen/zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving \
            features/bevragen/zoek-met-nummeraanduiding-identificatie \
            features/bevragen/zoek-met-postcode-en-huisnummer \
            features/bevragen/zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving \
            --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering"

cucumber-js -f html:docs/features/test-result-raadpleeg-en-zoek.html \
            -f json:docs/features/test-result-raadpleeg-en-zoek.json \
            features/bevragen/raadpleeg-met-burgerservicenummer \
            features/bevragen/zoek-met-geslachtsnaam-en-geboortedatum \
            features/bevragen/zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving \
            features/bevragen/zoek-met-nummeraanduiding-identificatie \
            features/bevragen/zoek-met-postcode-en-huisnummer \
            features/bevragen/zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving \
            --tags "not @skip-verify" --tags "not @gba"

cucumber-js -f html:docs/features/test-result-persoon-beperkt-gba.html \
            -f json:docs/features/test-result-persoon-beperkt-gba.json \
            features/bevragen/persoon-beperkt \
            --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering"

cucumber-js -f html:docs/features/test-result-persoon-beperkt.html \
            -f json:docs/features/test-result-persoon-beperkt.json \
            features/bevragen/persoon-beperkt \
            --tags "not @skip-verify" --tags "not @gba"

cucumber-js -f html:docs/features/test-result-persoon-gba.html \
            -f json:docs/features/test-result-persoon-gba.json \
            features/bevragen/persoon \
            --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering"

cucumber-js -f html:docs/features/test-result-persoon.html \
            -f json:docs/features/test-result-persoon.json \
            features/bevragen/persoon/*.feature \
            features/bevragen/persoon/adressering \
            features/bevragen/persoon/europees-kiesrecht \
            features/bevragen/persoon/geboorte \
            features/bevragen/persoon/geheimhouding \
            features/bevragen/persoon/gezagsverhouding \
            features/bevragen/persoon/immigratie \
            features/bevragen/persoon/kind \
            features/bevragen/persoon/leeftijd \
            features/bevragen/persoon/naam \
            features/bevragen/persoon/nationaliteit \
            features/bevragen/persoon/opschorting-bijhouding \
            features/bevragen/persoon/ouder \
            features/bevragen/persoon/overlijden \
            features/bevragen/persoon/partner \
            features/bevragen/persoon/rni \
            features/bevragen/persoon/uitsluiting-kiesrecht \
            --tags "not @skip-verify" --tags "not @gba"

cucumber-js -f html:docs/features/test-result-persoon-verblijfplaats.html \
            -f json:docs/features/test-result-persoon-verblijfplaats.json \
            features/bevragen/persoon/verblijfplaats \
            --tags "not @skip-verify" --tags "not @gba"

cucumber-js -f html:docs/features/test-result-persoon-verblijfstitel.html \
            -f json:docs/features/test-result-persoon-verblijfstitel.json \
            features/bevragen/persoon/verblijfstitel \
            --tags "not @skip-verify" --tags "not @gba"

cucumber-js -f html:docs/features/test-result-persoon-verificatie.html \
            -f json:docs/features/test-result-persoon-verificatie.json \
            features/bevragen/persoon/verificatie \
            --tags "not @skip-verify" --tags "not @gba"

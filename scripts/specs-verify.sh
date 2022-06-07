#!/bin/bash

mkdir -p docs/features

cucumber-js -f html:docs/features/test-result.html \
            -f json:docs/features/test-result.json \
            features/dev/*.feature \
            features/aanhef.feature \
            features/datum.feature \
            features/fields-fout-cases.feature \
            features/fields.feature \
            features/gebruik_in_lopende_tekst.feature \
            features/immigratie.feature \
            features/leeftijd_bepaling.feature \
            features/nationaliteit.feature \
            features/onbekend_waardes.feature \
            features/verblijfplaats.feature \
            features/volledigeNaam.feature \
            features/voorletters.feature \
            features/zoek-met-bsn.feature \
            features/zoek-met-geslachtsnaam-geboortedatum.feature \
            features/zoek-met-geslachtsnaam-voornamen-gemeentevaninschrijving.feature \
            features/zoek-met-postcode-huisnummer.feature \
            features/zoek.feature \
            --tags "not @gba" --tags "not @skip-verify"
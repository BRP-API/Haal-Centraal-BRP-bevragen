#!/bin/bash

cucumber-js -f html:docs/features/test-result.html \
            -f json:docs/features/test-result.json \
            features/dev/*.feature \
            features/fields.feature \
            features/leeftijd_bepaling.feature \
            features/nationaliteit.feature \
            features/verblijfplaats.feature \
            features/volledigeNaam.feature \
            features/voorletters.feature \
            features/zoek-met-bsn.feature \
            features/zoek-met-geslachtsnaam-geboortedatum.feature \
            features/zoek-met-geslachtsnaam-voornamen-gemeentevaninschrijving.feature \
            features/zoek-met-postcode-huisnummer.feature \
            features/zoek.feature \
            --tags "not @gba" --tags "not @skip-verify"
# Personen bevragen

De BRP bevragen API biedt twee manieren om personen te bevragen:
- Zoeken van personen 
- Raadplegen van personen

## Zoeken van personen

Als de burgerservicenummer van de te bevragen personen niet bekend is, kan één van de volgende operaties worden gebruikt om de gewenste persoon te vinden:

- zoek met geslachtsnaam en geboortedatum
  - [overzicht](./zoek-met-geslachtsnaam-en-geboortedatum/overzicht.feature)
  - [fout cases](./zoek-met-geslachtsnaam-en-geboortedatum/fout-cases.feature)
- zoek met geslachtsnaam, voornamen en gemeente van inschrijving
  - [overzicht](./zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving/overzicht.feature)
  - [fout cases](./zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving/fout-cases.feature)
- zoek met postcode en huisnummer
  - [overzicht](./zoek-met-postcode-en-huisnummer/overzicht.feature)
  - [fout cases](./zoek-met-postcode-en-huisnummer/fout-cases.feature)
- zoek met straat, huisnummer en gemeente van inschrijving
  - [overzicht](./zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving/overzicht.feature)
  - [fout cases](./zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving/fout-cases.feature)
- zoek met nummeraanduiding identificatie
  - [overzicht](./zoek-met-nummeraanduiding-identificatie/overzicht.feature)
  - [fout cases](./zoek-met-nummeraanduiding-identificatie/fout-cases.feature)

Het resultaat van deze operaties is een PersoonBeperkt lijst.


## Raadplegen van personen

Als de burgerservicenummer van de te bevragen personen wel bekend is, kan de volgende operatie worden gebruikt om gegevens van de persoon te raadplegen:

- raadpleeg met burgerservicenummer
  - [overzicht](./raadpleeg-met-burgerservicenummer/overzicht.feature)
  - [fout cases](./raadpleeg-met-burgerservicenummer/fout-cases.feature)

Het resultaat van deze operaties is een Persoon lijst.

## Filteren van de velden van de gevonden personen

## Geen waarde, leeg object waarde en onbekend waarde

## Gegevens in onderzoek

## Persoon extensies

- leeftijd
- adressering

## PersoonBeperkt velden overzicht

## Persoon velden overzicht

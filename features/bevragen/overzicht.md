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

Het resultaat van deze operaties is een PersoonBeperkt lijst. Standaard bevat deze lijst alleen personen die in leven zijn. Om een overleden persoon te zoeken, moet de inclusiefOverledenPersonen parameter op true worden gezet. 

Voor overleden personen wordt altijd het indicatieOverleden veld geleverd. Zie de [indicatie overleden](../overlijden-indicatie-overleden.feature) feature voor meer informatie over dit veld.


## Raadplegen van personen

Als de burgerservicenummer van de te bevragen personen wel bekend is, kan de volgende operatie worden gebruikt om gegevens van de persoon te raadplegen:

- raadpleeg met burgerservicenummer
  - [overzicht](./raadpleeg-met-burgerservicenummer/overzicht.feature)
  - [fout cases](./raadpleeg-met-burgerservicenummer/fout-cases.feature)

Het resultaat van deze operaties is een Persoon lijst.

Bij een overleden persoon in het raadpleeg resultaat wordt altijd het indicatieOverleden veld geleverd.  Zie de [indicatie overleden](../overlijden-indicatie-overleden.feature) feature voor meer informatie over dit veld.

## Filteren van de velden van de gevonden personen

Bij elke bevraging moet de fields parameter worden gebruikt om aan te geven welke velden van een persoon geleverd moet worden. Dit is nodig ter bescherming van de privacy van de gevraagde personen en voor verduurzaming. Hoe minder velden er wordt gevraagd, hoe minder de server en het netwerk wordt belast.

De volgende velden hoeven niet met de fields parameter te worden gevraagd. Deze worden meegeleverd als de bijbehorende situatie van toepassing is

- geheimhoudingPersoonsgegevens
- indicatieOverleden
- inOnderzoek
- opschortingBijhouding
- rni

## Geen/null/false waarde, leeg object waarde en onbekend waarde

Om de payload van een response klein te houden, is er voor gekozen om onnodige waarden en hun veld niet te serialiseren. Deze waarden zijn:

- null. Voorbeeld: de gevraagde persoon heeft geen voorvoegsel en geen uitsluitingKiesrecht
- false. Voorbeeld: de gevraagde persoon heeft geen geheimhouding en de gevraagde velden zijn niet in onderzoek

Ook zorgt json deserialisatie libraries voor dat niet geleverde velden automatisch worden gezet naar hun standaard waarde.

## Gegevens in onderzoek

## Persoon extensies

- leeftijd
- adressering

## PersoonBeperkt velden overzicht

## Persoon velden overzicht

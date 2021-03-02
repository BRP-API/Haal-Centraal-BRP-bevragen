---
layout: page-with-side-nav
title: Haal Centraal BRP bevragingen
---

# Releasenotes Haal-Centraal-BRP-Bevragen

## Versie 1.3.0
- De property "aNummer" is toegevoegd aan "IngeschrevenPersoon".


## Versie 1.2.0

- De property "adellijkeTitelPredikaat" is verplaatst van "NaamPersoon" naar "Naam"
  Dit heeft als gevolg dat deze property nu ook onderdeel is van de resources "ouder", "kind" en "partner"
- De property "adellijkeTitelPredikaat" (boolean) is toegevoegd aan "NaamInOnderzoek". Gevolg is dat "adellijkeTitelPredikaat" ook is toegevoegd aan "inOnderzoek" van de naam in resources "ouder", "kind" en "partner".
- Toevoegen component "NaamPersoonInOnderzoek", waarmee boolean "aanduidingNaamGebruik" wordt toegevoegd aan inOnderzoek van de naam.


## Versie 1.1.0

- In de resource IngeschrevenPersoon zijn in de naam de properties "regelVoorafgaandAanAanschrijfwijze" en "adellijkeTitelPredikaat" toegevoegd
- Het document BRP-LO GBA mapping.xlsx is aangepast voor :
  - regelVoorafgaandAanAanschrijfwijze
  - adellijkeTitelPredikaat
  - nationaliteithistorie (ontbrak nog)
  - enkele correcties
- Enkele features zijn aangepast i.v.m de correcte aanschrijving bij personen met een gewijzigd geslacht of geslachts is onbekend (genderneutraal) :
  - Aanhef.feature
  - Aanschrijfwijze.feature

## Versie 1.0.0

Alhoewel er nog geen eerdere officiële versie van de Haal-Centraal-BRP-bevragen API als release is uitgebracht is de specificatie het afgelopen jaar redelijk stabiel geweest.
Voor het uitbrengen van release v1.0.0 is besloten om de nieuwe inzichten die het afgelopen jaar zijn opgedaan op te nemen. Hier een globaal (en niet limitatief) overzicht van wijzigingen die doorgevoerd zijn voordat v1.0.0 is uitgebracht. Enkele van deze wijzigingen zijn breaking ten opzichte van v0.9.0 .

We bieden nu ook SDK's aan met gegenereerde [plumbing-code](./code).
Daarnaast bieden we een[postman-collectie](./test) t.b.v. testen aan.

### Openapi.yaml:

- OperationId's zijn aangepast ivm code-generatie issues.
- Alle descriptions zijn omgezet naar markdown.
- Bij properties zijn de maxLength, minLength en (waar overbodig) de title weggehaald.
- Descriptions zijn aangepast om beter bij te gebruikersbeleving aan te sluiten, overbodige descriptions zijn verwijderd.
- De Historie-endpoints en de bijbehorende componenten zijn uit de specificatie verwijderd en worden in een aparte API opgenomen.
- Enkele parameternamen zijn aangepast vanwege consistentie met andere Haal-Centraal API's en/of de Design Decision om parameternamen in camelCase op te nemen
  - verblijfplaats__gemeentevaninschrijving  --> verblijfplaats__gemeenteVanInschrijving
  - verblijfplaats__naamopenbareruimte --> verblijfplaats__straat
  - verblijfplaats__identificatiecodenummeraanduiding --> verblijfplaats__nummeraanduidingIdentificatie
  - inclusiefoverledenpersonen --> inclusiefOverledenPersonen
- Enkele namen van schema-componenten zijn aangepast vanwege consistentie met andere Haal-Centraal API's
  - Hal-componenten die alleen _links bevatten zijn omgenoemd van xxxHal naar xxxHalBasis
  - Ouder_links --> OuderLinks
  - Kind_links --> KindLinks
  - Partner_links --> PartnerLinks
  - AangaanHuwelijkInOnderzoek --> AangaanHuwelijkPartnerschapInOnderzoek
  - IngeschrevenPersoon_links --> IngeschrevenPersoonLinks
  - IngeschrevenPersoon_embedded --> IngeschrevenPersoonEmbedded
- Schema-component Burgerservicenummer is verwijderd
- Schema-component BinnenlandsAdres is verwijderd
- Schema-component Verblijfbuitenland is verwijderd. Properties zijn opgenomen in Verblijfplaats.
- Verblijfplaats is aangepast door hergebruik van het BAG-adres
- Inline gedefinieerde objecten zijn nu als component gedefinieerd.
- Enkele propertynamen zijn aangepast vanwege consistentie met andere Haal-Centraal API's.
  - IngeschrevenPersoon.nationaliteit --> IngeschrevenPersoon.nationaliteiten
  - IngeschrevenPersoon.reisdocumenten --> IngeschrevenPersoon.reisdocumentnummers
  - Verblijfplaats.straatnaam --> Verblijfplaats.korteNaam
  - BinnenlandsAdres.openbareRuimteNaam --> Verblijfplaats.straat
  - BinnenlandsAdres.woonplaatsnaam --> Verblijfplaats.woonplaats
  - BinnenlandsAdres.identificatiecodeNummeraanduiding --> Verblijfplaats.nummeraanduidingIdentificatie  
  - Verblijfplaats.identificatiecodeAdresseerbaarObject --> Verblijfplaats.adresseerbaarObjectIdentificatie  
  - In de component verblijfplaatsInOnderzoek zijn de bovenstaande wijzigingen in property-namen ook doorgevoerd in de corresponderende booleans
  - IngeschrevenPersoon_Links.verblijfplaatsNummeraanduiding --> IngeschrevenPersoonLinks.adres


### Features:

In het algemeen is de testdata verwijderd uit de feature-files. De feature files hebben als doel om functioneel de werking te beschrijven.

- adres.feature is toegevoegd
- enum_waarden.feature is verwijderd
- expand.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- fields.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- foutafhandeling.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- fields_extensie. feature is toegevoegd
- geslachtswijzing.feature is aangepast.
- historie_links.feature is gewijzigd.
- links.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- nationaliteithistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- onvolledige_datum.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- overleden_personen.feature is gewijzigd.
- partnerhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- parametercombinaties.feature is gewijzigd.
- parametervalidatie.feature is gewijzigd.
- verblijfplaatshistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- verblijfstitelhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- wildcard.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)

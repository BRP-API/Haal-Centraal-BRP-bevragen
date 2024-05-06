---
layout: page-with-side-nav
title: Haal Centraal BRP Personen Bevragen
---

# Releasenotes Haal-Centraal BRP Personen Bevragen

## Versie 2.2.0

- gezagsrelaties van een persoon bevragen (met behulp van raadpleeg met burgerservicenummer)
- gezagsrelaties van de personen bevragen die op een adresseerbaar object staan ingeschreven (met behulp van zoek met adresseerbaar object)

Gebruik de [personen-mock](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/pkgs/container/personen-mock) om gezag lokaal uit te proberen

## Versie 2.1.0

- veld indicatieVastgesteldVerblijftNietOpAdres is toegevoegd aan: (pull request #1713)
  - verblijfplaats (binnenland en locatie)
  - adressering

## Versie 2.0.21

### Fixed

- Fields waarde 'naam.geslachtsnaam' resulteert in 500 internal server error (issue #1710)

## Versie 2.0.0

- de raadpleeg- en zoeken-endpoints zijn nu samengevoegd in 1 endpoint
- het request is gewijzigd van GET naar POST, waarbij alle parameters verplaatst zijn van de querystring in de url naar de requestbody
- requestbody is polymorf gedefinieerd, waarbij in parameter 'type' bepaalt welke parameters gebruikt mogen en moeten worden
- parameter 'fields' is verplicht (required)
- beperkingen voor string-parameters in de request body en string-velden in de response zijn aangescherpt met een reguliere expressie (pattern)
- in het antwoord zitten geen json-HAL elementen \_links en \_embedded
- in het antwoord is veld 'ingeschrevenPersonen' hernoemd naar 'personen'
- het antwoord op elke zoekvraag (elk request anders dan raadplegen op burgerservicenummer) bevat maximaal een beperkte set gegevens van de persoon
- veld 'reisdocumenten' is verwijderd
- alle datums zijn polymorf gedefinieerd: nieuw veld 'type' geeft aan welke velden voor de datum verwacht kunnen worden
- alle datums hebben nieuw veld 'langFormaat', waarmee de datum in volledig uitgeschreven formaat wordt geleverd, die direct aan eindgebruikers gepresenteerd kan worden
- alle enumeraties zijn omgezet naar Waardetabel type, met 'code' plus 'omschrijving'. Zie https://github.com/VNG-Realisatie/Haal-Centraal-BRP-tabellen-bevragen/blob/master/docs/tabelwaarden.csv voor mogelijke waarden
- veld 'geslachtsaanduiding' is hernoemd naar 'geslacht'
- groep 'kiesrecht' is gesplitst in 'uitsluitingKiesrecht' en 'europeesKiesrecht'
- ook afgeleide gegevens (zoals aanschrijfwijze en leeftijd) zijn opgenomen in 'inOnderzoek'
- naamvelden 'aanschrijfwijze', 'aanhef' en 'gebruikInLopendeTekst' zijn verplaatst naar groep 'adressering'
- adresregels zijn verplaatst van groep 'verblijfplaats' naar groep 'adressering'
- velden 'gemeenteVanInschrijving' en 'datumInschrijvingInGemeente' zijn verplaatst van groep 'verblijfplaats' naar het hoogste niveau ('personen')
- velden van de immigratie zijn verplaatst van groep 'verblijfplaats' naar groep 'immigratie'
- velden 'indicatieCurateleRegister' en 'indicatieGezagMinderjarige' zijn verplaatst van groep 'gezagsverhouding' naar het hoogste niveau ('personen')
- de adresvelden van een verblijfplaats zijn gegroepeerd in verblijfplaats groep 'verblijfadres'
- groep 'verblijfplaats' is polymorf gedefinieerd, waarbij nieuw veld 'type' aangeeft of het een binnenlands adres, locatie, buitenlands adres of onbekende verblijfplaats is
- groep 'nationaliteiten' is polymorf gedefinieerd, waarbij nieuw veld 'type' aangeeft of het een nationaliteit, bijzonder Nederlanderschap, staatloosheid of onbekende nationaliteit betreft
- wanneer er geen actuele partner is (zonder ontbinding van het huwelijk of partnerschap), wordt indien van toepassing het laatst ontbonden huwelijk of partnerschap geleverd, inclusief de datum van de ontbinding
- wanneer de persoonsgegevens zijn geregistreerd door een RNI deelnemer, worden gegevens daarover opgenomen in groep 'rni'
- wanneer voor een niet ingezetene (persoon in RNI) de gegevens zijn geverifieerd, worden gegevens daarover opgenomen in groep 'verificatie' 

## Versie 1.3.1
- Naambasis (exclusief in InOnderzoek) toegevoegd  i.v.m. specificatie issue m.b.t. dubbel gedefinieerde InOnderzoek. (Zie [850]({{ site.repoUrl }}/issues/850) )
- Foutief Example BSN aangepast

## Versie 1.3.0
- De property "aNummer" is toegevoegd aan "IngeschrevenPersoon".
- De gegevens van partners, ouders en kinderen zijn aan de resource "ingeschrevenPersoon" toegevoegd.
- De parameter "expand" is deprecated verklaard.
- De volgende endpoints zijn deprecated verklaard:
  - /ingeschrevenpersonen/{burgerservicenummer}/kinderen/{id}:
  - /ingeschrevenpersonen/{burgerservicenummer}/kinderen
  - /ingeschrevenpersonen/{burgerservicenummer}/ouders/{id}:
  - /ingeschrevenpersonen/{burgerservicenummer}/ouders:
  - /ingeschrevenpersonen/{burgerservicenummer}/partners/{id}:
  - /ingeschrevenpersonen/{burgerservicenummer}/partners:
- Bij de gegevensgroepen "ouder" , "partner" en "kind" is de property "geheimhoudingPersoonsgegevens" verwijderd en verplaatst naar de HAL-component (dit is een non-breaking wijziging om de deprecated functionaliteit ongewijzigd te laten.)
- Alle HAL-componenten voor ouders, partners en kinderen zijn deprecated verklaard.


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

Alhoewel er nog geen eerdere officiële versie van de Haal-Centraal BRP Personen Bevragen API als release is uitgebracht is de specificatie het afgelopen jaar redelijk stabiel geweest.
Voor het uitbrengen van release v1.0.0 is besloten om de nieuwe inzichten die het afgelopen jaar zijn opgedaan op te nemen. Hier een globaal (en niet limitatief) overzicht van wijzigingen die doorgevoerd zijn voordat v1.0.0 is uitgebracht. Enkele van deze wijzigingen zijn breaking ten opzichte van v0.9.0 .

We bieden een [postman-collectie]({{ site.masterBranchUrl }}/test) t.b.v. testen aan.

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
- nationaliteithistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- onvolledige_datum.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- overleden_personen.feature is gewijzigd.
- partnerhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- parametercombinaties.feature is gewijzigd.
- parametervalidatie.feature is gewijzigd.
- verblijfplaatshistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- verblijfstitelhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/tree/master/features)
- wildcard.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)

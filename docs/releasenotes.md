---
layout: page-with-side-nav
title: Haal Centraal BRP Personen Bevragen
---

# Releasenotes Haal-Centraal BRP Personen Bevragen

## Versie 2.6.0 (18 maart 2025)
- Zoeken op postcode en huisnummer is uitgebreid met de optionele parameter geslachtsnaam.
- Bij het bepalen van gezag voor een minderjarige met ongehuwde ouders wordt de geboortemoeder nu bepaald op basis van het geslacht van de ouders. De verwachting is dat het aantal uitspraken "gezag niet te bepalen" met tenminste 30% zal afnemen.
- Wanneer gegevens voor het bepalen van gezag in onderzoek staan wordt nu niet meer "gezag niet te bepalen" geleverd, maar wordt gezag geleverd met indicatie inOnderzoek.
- Bij gezamenlijk gezag wordt nu expliciet aangegeven wanneer het onbekend is wie de derde is die gezag heeft. Dit wordt aangegeven in veld "type".
- Enkele verbeteringen zijn aangebracht in de validatie van parameters.
- Enkele verbeteringen zijn aangebracht aan het bepalen van gezag over een minderjarige.

## Versie 2.5.0 (31 januari 2025)
-	Voorheen mochten er bij alle zoekopdrachten maximaal 10 personen worden gevonden. Bij zoeken op adres is dit nu uitgebreid naar maximaal 30 personen. 
-	Bij gezag wordt nu voor ouders en derden naast burgerservicenummer ook de naam geleverd. Voor minderjarigen wordt nu naast het burgerservicenummer naam en leeftijd geleverd.
-	Bij gezag wordt nu een toelichting geleverd wanneer over de minderjarige tijdelijk niemand gezag uitoefent.


## Versie 2.4.0 (6 januari 2025)
- Bij gezag type GezagNietTeBepalen wordt nu een toelichting gegeven.
- Bij gezag type GezagNietTeBepalen en TijdelijkGeenGezag werd voorheen alleen het type geleverd. Nu worden ook gegevens over de minderjarige gegeven.

## Versie 2.3.0 (20 september 2024)
- Nieuwe optionele parameter geboortedatum voor operatie ZoekMetPostcodeEnHuisnummer. Hiermee kan je het aantal resultaten beperken wanneer er veel personen op hetzelfde adres staan ingeschreven.
- Probleem opgelost zodat verblijfplaats en adressering ook worden geleverd wanneer een verblijfadres in Nederland is geregistreerd als 'verblijfplaats buitenland'.

## Versie 2.2.0 (29 april 2024)

- gezagsrelaties van een persoon bevragen (met behulp van raadpleeg met burgerservicenummer)
- gezagsrelaties van de personen bevragen die op een adresseerbaar object staan ingeschreven (met behulp van zoek met adresseerbaar object)
- de API levert vanaf nu ook “informatievragen” (bewerkte BRP gegevens)

Gebruik de [personen-mock](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/pkgs/container/personen-mock) om gezag lokaal uit te proberen

## Versie 2.1.0 (8 juni 2023)

- veld indicatieVastgesteldVerblijftNietOpAdres is toegevoegd aan: 
  - verblijfplaats (binnenland en locatie)
  - adressering

In deze versie is alleen de "BRP Personen proxy" gewijzigd.

## Versie 2.0.0 (1 juni 2023)

Wijzigingen ten opzichte van versie 1.3:
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

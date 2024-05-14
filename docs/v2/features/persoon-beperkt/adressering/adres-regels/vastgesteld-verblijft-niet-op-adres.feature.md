---
layout: page-with-side-nav
title: leveren 'indicatie vastgesteld verblijft niet op adres' veld bij het vragen van adresregel gegevens
---
#language: nl  


# Functionaliteit: leveren 'indicatie vastgesteld verblijft niet op adres' veld bij het vragen van adresregel gegevens


* __Als__ afnemer
Wil ik een indicatie krijgen bij het vragen van adresregel gegevens van een persoon als is vastgesteld dat de gevraagde persoon niet meer verblijft op het geregistreerde adres  
Zodat ik dit niet zelf hoef af te leiden uit de aanduiding in onderzoek waarde  

## Regel: aanduiding in onderzoek waarde '089999' wordt geleverd als indicatieVastgesteldVerblijftNietOpAdres adressering veld en alle geleverde adresregel velden zijn in onderzoek


### Scenario: gevraagde persoon verblijft niet meer op het geregistreerde adres en één of meerdere adresregel velden wordt gevraagd

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft de volgende gegevens

  | geslachtsnaam (02.40) | geboortedatum (03.10) |
  |-----------------------|-----------------------|
  | Maassen               | 19830526              |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
  |---------------------------------|--------------------------------|
  | 089999                          | 20020701                       |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10)       | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) |
  |----------------------|--------------------------|--------------------|------------------|--------------------|
  | 0518                 | Jonkheer van Riemsdijkln | 88                 | 2583XL           | Scheveningen       |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam          | waarde                                          |
  |---------------|-------------------------------------------------|
  | type          | ZoekMetGeslachtsnaamEnGeboortedatum             |
  | geslachtsnaam | Maassen                                         |
  | geboortedatum | 1983-05-26                                      |
  | fields        | adressering.adresregel1,adressering.adresregel2 |
* __Dan__ heeft de response een persoon met alleen de volgende 'adressering' gegevens

  | naam                                                       | waarde                      |
  |------------------------------------------------------------|-----------------------------|
  | adresregel1                                                | Jonkheer van Riemsdijkln 88 |
  | adresregel2                                                | 2583 XL  SCHEVENINGEN       |
  | indicatieVastgesteldVerblijftNietOpAdres                   | true                        |
  | inOnderzoek.adresregel1                                    | true                        |
  | inOnderzoek.adresregel2                                    | true                        |
  | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum                       |
  | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01                  |
  | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002                 |

### Scenario: gevraagde persoon verblijft niet meer op de geregistreerde locatie en één of meerdere adresregel velden wordt gevraagd

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft de volgende gegevens

  | geslachtsnaam (02.40) | geboortedatum (03.10) |
  |-----------------------|-----------------------|
  | Maassen               | 19830526              |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | gemeente van inschrijving (09.10) |
  |---------------------------------|--------------------------------|-----------------------------------|
  | 089999                          | 20020701                       | 0518                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | locatiebeschrijving (12.10)       |
  |----------------------|-----------------------------------|
  | 0518                 | Woonboot tegenover de Grote Sloot |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam          | waarde                                          |
  |---------------|-------------------------------------------------|
  | type          | ZoekMetGeslachtsnaamEnGeboortedatum             |
  | geslachtsnaam | Maassen                                         |
  | geboortedatum | 1983-05-26                                      |
  | fields        | adressering.adresregel1,adressering.adresregel2 |
* __Dan__ heeft de response een persoon met alleen de volgende 'adressering' gegevens

  | naam                                                       | waarde                            |
  |------------------------------------------------------------|-----------------------------------|
  | adresregel1                                                | Woonboot tegenover de Grote Sloot |
  | adresregel2                                                | 'S-GRAVENHAGE                     |
  | indicatieVastgesteldVerblijftNietOpAdres                   | true                              |
  | inOnderzoek.adresregel1                                    | true                              |
  | inOnderzoek.adresregel2                                    | true                              |
  | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum                             |
  | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01                        |
  | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002                       |


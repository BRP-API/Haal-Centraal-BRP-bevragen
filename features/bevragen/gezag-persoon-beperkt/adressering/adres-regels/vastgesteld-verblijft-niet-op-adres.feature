#language: nl

Functionaliteit: leveren 'indicatie vastgesteld verblijft niet op adres' veld bij het vragen van adresregel gegevens in gezag persoon beperkt

  Als afnemer
  Wil ik een indicatie krijgen bij het vragen van adresregel gegevens van een persoon als is vastgesteld dat de gevraagde persoon niet meer verblijft op het geregistreerde adres
  Zodat ik dit niet zelf hoef af te leiden uit de aanduiding in onderzoek waarde

  Regel: aanduiding in onderzoek waarde '089999' wordt geleverd als indicatieVastgesteldVerblijftNietOpAdres adressering veld en alle geleverde adresregel velden zijn in onderzoek

    Scenario: gevraagde persoon verblijft niet meer op het geregistreerde adres en één of meerdere adresregel velden wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 089999                          | 20020701                       |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | straatnaam (11.10)       | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | Jonkheer van Riemsdijkln | 88                 | 2583XL           | Scheveningen       | 0599010051001502                         |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                          |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie         |
      | adresseerbaarObjectIdentificatie | 0599010051001502                                |
      | fields                           | adressering.adresregel1,adressering.adresregel2 |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam                                                       | waarde                      |
      | adresregel1                                                | Jonkheer van Riemsdijkln 88 |
      | adresregel2                                                | 2583 XL  SCHEVENINGEN       |
      | indicatieVastgesteldVerblijftNietOpAdres                   | true                        |
      | inOnderzoek.adresregel1                                    | true                        |
      | inOnderzoek.adresregel2                                    | true                        |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        | Datum                       |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       | 2002-07-01                  |
      | inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat | 1 juli 2002                 |

#language: nl

@gba
Functionaliteit: leeftijd veld vragen met fields (gezag persoon beperkt)

    Scenario: persoon is niet overleden
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geboortedatum (03.10) |
      | 19500304              |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0599010051001502                         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | leeftijd                                |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam           | waarde   |
      | geboorte.datum | 19500304 |

  Regel: wanneer het leeftijd veld voor een persoon wordt gevraagd en de categorie persoon (01) heeft in onderzoek gegevens, dan worden deze ook geleverd

    Abstract Scenario: '<type>' is in onderzoek en leeftijd veld wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
      | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 19500304              | <aanduiding in onderzoek>       | 20020701                       |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0518                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0599010051001502                         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | leeftijd                                |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                                             | waarde                    |
      | geboorte.datum                                   | 19500304                  |
      | persoonInOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
      | persoonInOnderzoek.datumIngangOnderzoek          | 20020701                  |

      Voorbeelden:
      | aanduiding in onderzoek | type                            |
      | 010000                  | hele categorie persoon          |
      | 010100                  | hele groep identificatienummers |
      | 010120                  | burgerservicenummer             |
      | 010200                  | hele groep naam                 |
      | 010210                  | voornamen                       |
      | 010220                  | adellijke titel/predicaat       |
      | 010230                  | voorvoegsel                     |
      | 010240                  | geslachtsnaam                   |
      | 010300                  | hele groep geboorte             |
      | 010310                  | geboortedatum                   |
      | 010320                  | geboorteplaats                  |
      | 010330                  | geboorteland                    |
      | 010400                  | hele groep geslacht             |
      | 010410                  | geslachtsaanduiding             |
      | 016100                  | hele groep naam                 |
      | 016110                  | aanduiding naamgebruik          |

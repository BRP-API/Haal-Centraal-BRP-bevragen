#language: nl

@gba
Functionaliteit: leeftijd veld vragen met fields (persoon beperkt)

  Scenario: persoon is niet overleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19500304 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1950-03-04                          |
    | fields        | leeftijd                            |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam           | waarde   |
    | geboorte.datum | 19500304 |

  Scenario: persoon is overleden
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19500304 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
    | 20020701                 | 0518                      | 6030                    |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | O      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Maassen                             |
    | geboortedatum              | 1950-03-04                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | leeftijd                            |
    Dan heeft de response een persoon met alleen de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | O          |
    | reden.omschrijving | overlijden |
    En heeft de persoon de volgende 'geboorte' gegevens
    | naam  | waarde   |
    | datum | 19500304 |

Regel: wanneer het leeftijd veld voor een persoon wordt gevraagd en de categorie persoon (01) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: '<type>' is in onderzoek en leeftijd veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geslachtsnaam (02.40) | geboortedatum (03.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Maassen               | 19500304              | <aanduiding in onderzoek>       | 20020701                       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1950-03-04                          |
    | fields        | leeftijd                            |
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

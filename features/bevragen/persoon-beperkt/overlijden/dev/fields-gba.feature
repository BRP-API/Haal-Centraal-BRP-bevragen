#language: nl

@gba
Functionaliteit: Persoon: overlijden velden vragen met fields

  Abstract Scenario: 'datum overlijden (08.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20020701 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Maassen                             |
    | geboortedatum              | 1983-05-26                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | <fields>                            |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam  | waarde   |
    | datum | 20020701 |

    Voorbeelden:
    | fields                        |
    | overlijden                    |
    | overlijden.indicatieOverleden |
    | overlijden.datum              |
    | overlijden.datum.type         |
    | overlijden.datum.datum        |
    | overlijden.datum.langFormaat  |
    | overlijden.datum.jaar         |
    | overlijden.datum.maand        |
    | overlijden.datum.onbekend     |

  Abstract Scenario: '<type>' van een overlijden is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Maassen                             |
    | geboortedatum              | 1983-05-26                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | <fields>                            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
    En heeft de persoon de volgende 'overlijden' gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |
    | datum                                     | 20020701                  |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                            | type                      |
    | 060000                  | burgerservicenummer,overlijden                    | hele categorie overlijden |
    | 060800                  | burgerservicenummer,overlijden.indicatieOverleden | hele groep overlijden     |
    | 060810                  | burgerservicenummer,overlijden                    | datum overlijden          |
    | 060820                  | burgerservicenummer,overlijden.indicatieOverleden | plaats overlijden         |
    | 060830                  | burgerservicenummer                               | land overlijden           |

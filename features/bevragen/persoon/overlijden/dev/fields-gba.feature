#language: nl

Functionaliteit: Persoon: overlijden velden vragen met fields

  Abstract Scenario: 'datum overlijden (08.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20020701 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam  | waarde   |
    | datum | 20020701 |

    Voorbeelden:
    | fields                       |
    | overlijden.datum             |
    | overlijden.datum.type        |
    | overlijden.datum.datum       |
    | overlijden.datum.langFormaat |
    | overlijden.datum.jaar        |
    | overlijden.datum.maand       |
    | overlijden.datum.onbekend    |

  Abstract Scenario: '<type>' van een overlijden is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | aanduiding in onderzoek | fields                             | type                      |
    | 060000                  | overlijden                         | hele categorie overlijden |
    | 060800                  | overlijden.datum                   | hele groep overlijden     |
    | 060810                  | overlijden.plaats                  | datum overlijden          |
    | 060820                  | overlijden.land                    | plaats overlijden         |
    | 060830                  | overlijden.datum,overlijden.plaats | land overlijden           |

  Abstract Scenario: onbekend waarde voor <groep> <veld>
    Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'overlijden' gegevens
    | naam      | waarde |
    | <element> | 0000   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000139                             |
    | fields              | burgerservicenummer,overlijden.<veld> |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                           | waarde    |
    | burgerservicenummer            | 000000139 |
    | overlijden.<veld>.code         | 0000      |
    | overlijden.<veld>.omschrijving | Onbekend  |

    Voorbeelden:
    | veld   | element                   |
    | plaats | plaats overlijden (08.20) |
    | land   | land overlijden (08.30)   |

  Scenario: volledig onbekende overlijdensdatum
    Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'overlijden' gegevens
    | naam                      | waarde   |
    | datum overlijden (08.10)  | 00000000 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000358                            |
    | fields              | burgerservicenummer,overlijden.datum |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000358 |
    En heeft de persoon de volgende 'overlijden' gegevens
    | naam        | waarde   |
    | datum       | 00000000 |

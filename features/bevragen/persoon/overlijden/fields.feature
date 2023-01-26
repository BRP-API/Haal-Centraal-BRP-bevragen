#language: nl

Functionaliteit: Persoon: overlijden velden vragen met fields

  Abstract Scenario: 'datum overlijden (08.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde      |
    | indicatieOverleden | true        |
    | datum.type         | Datum       |
    | datum.datum        | 2002-07-01  |
    | datum.langFormaat  | 1 juli 2002 |

    Voorbeelden:
    | fields                       |
    | overlijden.datum             |
    | overlijden.datum.type        |
    | overlijden.datum.datum       |
    | overlijden.datum.langFormaat |
    | overlijden.datum.jaar        |
    | overlijden.datum.maand       |
    | overlijden.datum.onbekend    |

  Abstract Scenario: 'datum overlijden (08.10)' van het type '<type>' wordt gevraagd met field pad 'overlijden.datum'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) |
      | <GbaDatum>               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | overlijden.datum                |
      Dan heeft de response een persoon met de volgende 'overlijden' gegevens
      | naam               | waarde        |
      | indicatieOverleden | true          |
      | datum.type         | <type>        |
      | datum.datum        | <datum>       |
      | datum.jaar         | <jaar>        |
      | datum.maand        | <maand>       |
      | datum.onbekend     | <onbekend>    |
      | datum.langFormaat  | <langFormaat> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

  Abstract Scenario: 'plaats overlijden (08.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | plaats overlijden (08.20) |
    | 20200308                 | 0518                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                | waarde        |
    | indicatieOverleden  | true          |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |

    Voorbeelden:
    | fields                         |
    | overlijden.plaats              |
    | overlijden.plaats.code         |
    | overlijden.plaats.omschrijving |

  Abstract Scenario: 'land overlijden (08.30)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) | land overlijden (08.30) |
    | 20200308                 | 6014                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde                       |
    | indicatieOverleden | true                         |
    | land.code          | 6014                         |
    | land.omschrijving  | Verenigde Staten van Amerika |

    Voorbeelden:
    | fields                       |
    | overlijden.land              |
    | overlijden.land.code         |
    | overlijden.land.omschrijving |

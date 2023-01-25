#language: nl

Functionaliteit: Persoon: geboorte velden vragen met fields

  Abstract Scenario: 'geboortedatum (03.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 2002-07-01  |
    | datum.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                     |
    | geboorte.datum             |
    | geboorte.datum.type        |
    | geboorte.datum.datum       |
    | geboorte.datum.langFormaat |

  Abstract Scenario: 'geboortedatum (03.10)' van het type '<type>' wordt gevraagd met field pad 'geboorte.datum'
    Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende gegevens
    | naam                  | waarde     |
    | geboortedatum (03.10) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000140                       |
    | fields              | geboorte.datum                  |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde        |
    | datum.type        | <type>        |
    | datum.datum       | <datum>       |
    | datum.jaar        | <jaar>        |
    | datum.maand       | <maand>       |
    | datum.onbekend    | <onbekend>    |
    | datum.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
    | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

  Abstract Scenario: 'geboorteplaats (03.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0518   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam                | waarde        |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |

    Voorbeelden:
    | fields                       |
    | geboorte.plaats              |
    | geboorte.plaats.code         |
    | geboorte.plaats.omschrijving |

  Abstract Scenario: 'geboorteland (03.30)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                 | waarde |
    | geboorteland (03.30) | 6014   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

    Voorbeelden:
    | fields                     |
    | geboorte.land              |
    | geboorte.land.code         |
    | geboorte.land.omschrijving |

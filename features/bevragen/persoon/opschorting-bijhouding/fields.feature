#language: nl

Functionaliteit: Persoon: opschorting bijhouding velden vragen met fields

  Abstract Scenario: 'datum opschorting bijhouding (67.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde   |
    | datum opschorting bijhouding (67.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 2002-07-01  |
    | datum.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                                  |
    | opschortingBijhouding.datum             |
    | opschortingBijhouding.datum.type        |
    | opschortingBijhouding.datum.datum       |
    | opschortingBijhouding.datum.langFormaat |
    | opschortingBijhouding.datum.jaar        |
    | opschortingBijhouding.datum.maand       |
    | opschortingBijhouding.datum.onbekend    |

  Abstract Scenario: 'datum opschorting bijhouding (67.10)' van het type '<type>' wordt gevraagd met field pad 'opschortingBijhouding.datum'
    Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde     |
    | datum opschorting bijhouding (67.10) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000140                       |
    | fields              | opschortingBijhouding.datum     |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
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

  Abstract Scenario: 'reden opschorting bijhouding (67.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | O      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde     |
    | reden.code         | O          |
    | reden.omschrijving | overlijden |

    Voorbeelden:
    | fields                                   |
    | opschortingBijhouding.reden              |
    | opschortingBijhouding.reden.code         |
    | opschortingBijhouding.reden.omschrijving |

  Abstract Scenario: 'reden opschorting bijhouding (67.20)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                 | waarde |
    | reden opschorting bijhouding (67.20) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'opschortingBijhouding' gegevens
    | naam               | waarde   |
    | reden.code         | .        |
    | reden.omschrijving | onbekend |

    Voorbeelden:
    | fields                      |
    | opschortingBijhouding.reden |

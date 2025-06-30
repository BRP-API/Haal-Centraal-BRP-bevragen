#language: nl

Functionaliteit: Persoon: immigratie velden vragen met fields

  Abstract Scenario: 'land vanwaar ingeschreven (14.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 6014   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                 | waarde                       |
    | landVanwaarIngeschreven.code         | 6014                         |
    | landVanwaarIngeschreven.omschrijving | Verenigde Staten van Amerika |

    Voorbeelden:
    | fields                                          |
    | immigratie.landVanwaarIngeschreven              |
    | immigratie.landVanwaarIngeschreven.code         |
    | immigratie.landVanwaarIngeschreven.omschrijving |

  Scenario: 'land vanwaar ingeschreven (14.10)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon zonder 'immigratie' gegevens

    Voorbeelden:
    | fields                             |
    | immigratie.landVanwaarIngeschreven |

  Abstract Scenario: 'datum vestiging in nederland (14.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde   |
    | datum vestiging in Nederland (14.20) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                  | waarde      |
    | datumVestigingInNederland.type        | Datum       |
    | datumVestigingInNederland.datum       | 2002-07-01  |
    | datumVestigingInNederland.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                                           |
    | immigratie.datumVestigingInNederland             |
    | immigratie.datumVestigingInNederland.type        |
    | immigratie.datumVestigingInNederland.datum       |
    | immigratie.datumVestigingInNederland.langFormaat |
    | immigratie.datumVestigingInNederland.jaar        |
    | immigratie.datumVestigingInNederland.maand       |
    | immigratie.datumVestigingInNederland.onbekend    |

  Abstract Scenario: 'datum vestiging in nederland (14.20)' van het type '<type>' wordt gevraagd met field pad 'immigratie.datumVestigingInNederland'
    Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde     |
    | datum vestiging in Nederland (14.20) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000140                            |
    | fields              | immigratie.datumVestigingInNederland |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                  | waarde        |
    | datumVestigingInNederland.type        | <type>        |
    | datumVestigingInNederland.datum       | <datum>       |
    | datumVestigingInNederland.jaar        | <jaar>        |
    | datumVestigingInNederland.maand       | <maand>       |
    | datumVestigingInNederland.onbekend    | <onbekend>    |
    | datumVestigingInNederland.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
    | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

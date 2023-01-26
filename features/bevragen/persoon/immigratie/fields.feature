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
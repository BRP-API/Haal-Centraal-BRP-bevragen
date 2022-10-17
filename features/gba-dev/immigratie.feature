#language: nl

Functionaliteit: Immigratie

  Abstract Scenario: persoon heeft 'immigratie' veld: 'land vanwaar ingeschreven (14.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 6014   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | immigratie                      |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                 | waarde                       |
    | landVanwaarIngeschreven.code         | 6014                         |
    | landVanwaarIngeschreven.omschrijving | Verenigde Staten van Amerika |

  Abstract Scenario: 'immigratie' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | immigratie.inOnderzoek          |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |

  Abstract Scenario: landVanwaarIngeschreven is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                    |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    | land vanwaar ingeschreven (14.10) | 6014                      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000152                          |
    | fields              | immigratie.landVanwaarIngeschreven |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                 | waarde                       |
    | landVanwaarIngeschreven.code         | 6014                         |
    | landVanwaarIngeschreven.omschrijving | Verenigde Staten van Amerika |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |

  Scenario: persoon heeft land van waar ingeschreven onbekend
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 0000   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                          |
    | type                | RaadpleegMetBurgerservicenummer                                 |
    | burgerservicenummer | 000000152                                                       |
    | fields              | vanuitVerblijfplaatsOnbekend,indicatieVestigingVanuitBuitenland |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                 | waarde   |
    | landVanwaarIngeschreven.code         | 0000     |
    | landVanwaarIngeschreven.omschrijving | Onbekend |

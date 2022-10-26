#language: nl

Functionaliteit: Persoon: immigratie

  Abstract Scenario: persoon heeft 'immigratie' veld: 'land vanwaar ingeschreven (14.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 6014   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                 | waarde                       |
    | landVanwaarIngeschreven.code         | 6014                         |
    | landVanwaarIngeschreven.omschrijving | Verenigde Staten van Amerika |

    Voorbeelden:
    | field                                           |
    | immigratie.landVanwaarIngeschreven              |
    | immigratie.landVanwaarIngeschreven.code         |
    | immigratie.landVanwaarIngeschreven.omschrijving |

  Abstract Scenario: persoon heeft 'immigratie' datum veld: 'datum vestiging in nederland (14.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde   |
    | datum vestiging in Nederland (14.20) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                  | waarde      |
    | datumVestigingInNederland.type        | Datum       |
    | datumVestigingInNederland.datum       | 2002-07-01  |
    | datumVestigingInNederland.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | field                     |
    | datumVestigingInNederland |

  Abstract Scenario: 'immigratie' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | immigratie.inOnderzoek          |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                           | waarde                                            |
    | inOnderzoek.datumVestigingInNederland          | <datumVestigingInNederland in onderzoek>          |
    | inOnderzoek.landVanwaarIngeschreven            | <landVanwaarIngeschreven in onderzoek>            |
    | inOnderzoek.vanuitVerblijfplaatsOnbekend       | <vanuitVerblijfplaatsOnbekend in onderzoek>       |
    | inOnderzoek.indicatieVestigingVanuitBuitenland | <indicatieVestigingVanuitBuitenland in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type          | Datum                                             |
    | inOnderzoek.datumIngangOnderzoek.datum         | 2002-07-01                                        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat   | 1 juli 2002                                       |

    Voorbeelden:
    | gba in onderzoek waarde | landVanwaarIngeschreven in onderzoek | datumVestigingInNederland in onderzoek | indicatieVestigingVanuitBuitenland in onderzoek | vanuitVerblijfplaatsOnbekend in onderzoek |
    | 080000                  | true                                 | true                                   | true                                            | true                                      |
    | 081400                  | true                                 | true                                   | true                                            | true                                      |
    | 081410                  | true                                 |                                        | true                                            | true                                      |
    | 081420                  |                                      | true                                   |                                                 |                                           |

  Abstract Scenario: landVanwaarIngeschreven is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                    |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    | land vanwaar ingeschreven (14.10) | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000152                          |
    | fields              | immigratie.landVanwaarIngeschreven |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                         | waarde                       |
    | landVanwaarIngeschreven.code                 | 6014                         |
    | landVanwaarIngeschreven.omschrijving         | Verenigde Staten van Amerika |
    | inOnderzoek.landVanwaarIngeschreven          | true                         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081400                  |
    | 081410                  |

  Abstract Scenario: datumVestigingInNederland is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | datum vestiging in Nederland (14.20) | 20020101                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | immigratie.datumVestigingInNederland |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                         | waarde         |
    | datumVestigingInNederland.type               | Datum          |
    | datumVestigingInNederland.datum              | 2002-01-01     |
    | datumVestigingInNederland.langFormaat        | 1 januari 2002 |
    | inOnderzoek.datumVestigingInNederland        | true           |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081400                  |
    | 081420                  |

  Abstract Scenario: indicatieVestigingVanuitBuitenland is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                    |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    | land vanwaar ingeschreven (14.10) | 6014                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                        |
    | type                | RaadpleegMetBurgerservicenummer               |
    | burgerservicenummer | 000000152                                     |
    | fields              | immigratie.indicatieVestigingVanuitBuitenland |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                           | waarde      |
    | indicatieVestigingVanuitBuitenland             | true        |
    | inOnderzoek.indicatieVestigingVanuitBuitenland | true        |
    | inOnderzoek.datumIngangOnderzoek.type          | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum         | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat   | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081400                  |
    | 081410                  |

  Abstract Scenario: vanuitVerblijfplaatsOnbekend is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                    |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    | land vanwaar ingeschreven (14.10) | 0000                      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | immigratie.vanuitVerblijfplaatsOnbekend |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                         | waarde      |
    | vanuitVerblijfplaatsOnbekend                 | true        |
    | inOnderzoek.vanuitVerblijfplaatsOnbekend     | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081400                  |
    | 081410                  |

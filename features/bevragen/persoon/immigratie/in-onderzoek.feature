#language: nl

Functionaliteit: immigratie velden in onderzoek

  Abstract Scenario: '<type>' van een verblijfplaats is in onderzoek en alle immigratie velden worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | immigratie                      |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                                           | waarde                                  |
    | inOnderzoek.datumVestigingInNederland          | <datumVestigingInNederland io>          |
    | inOnderzoek.landVanwaarIngeschreven            | <landVanwaarIngeschreven io>            |
    | inOnderzoek.vanuitVerblijfplaatsOnbekend       | <vanuitVerblijfplaatsOnbekend io>       |
    | inOnderzoek.indicatieVestigingVanuitBuitenland | <indicatieVestigingVanuitBuitenland io> |
    | inOnderzoek.datumIngangOnderzoek.type          | Datum                                   |
    | inOnderzoek.datumIngangOnderzoek.datum         | 2002-07-01                              |
    | inOnderzoek.datumIngangOnderzoek.langFormaat   | 1 juli 2002                             |

    Voorbeelden:
    | aanduiding in onderzoek | landVanwaarIngeschreven io | datumVestigingInNederland io | indicatieVestigingVanuitBuitenland io | vanuitVerblijfplaatsOnbekend io | type                          |
    | 080000                  | true                       | true                         | true                                  | true                            | hele categorie verblijfplaats |
    | 081400                  | true                       | true                         | true                                  | true                            | hele groep immigratie         |
    | 081410                  | true                       |                              |                                       | true                            | land vanwaar ingeschreven     |
    | 081420                  |                            | true                         | true                                  |                                 | datum vestiging in Nederland  |

  Abstract Scenario: 'land vanwaar ingeschreven (14.10)' is in onderzoek en landVanwaarIngeschreven wordt gevraagd
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
    | gba in onderzoek waarde | type                          |
    | 080000                  | hele categorie verblijfplaats |
    | 081400                  | hele groep immigratie         |
    | 081410                  | land vanwaar ingeschreven     |

  Abstract Scenario: 'datum vestiging in Nederland (14.20)' is in onderzoek en datumVestigingInNederland wordt gevraagd
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
    | gba in onderzoek waarde | type                          |
    | 080000                  | hele categorie verblijfplaats |
    | 081400                  | hele groep immigratie         |
    | 081420                  | datum vestiging in Nederland  |

  Abstract Scenario: 'datum vestiging in Nederland (14.20)' is in onderzoek en indicatieVestigingVanuitBuitenland wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde                    |
    | aanduiding in onderzoek (83.10)      | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)       | 20020701                  |
    | datum vestiging in Nederland (14.20) | 20020101                  |
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
    | gba in onderzoek waarde | type                          |
    | 080000                  | hele categorie verblijfplaats |
    | 081400                  | hele groep immigratie         |
    | 081420                  | datum vestiging in Nederland  |

  Abstract Scenario: 'land vanwaar ingeschreven (14.10)' is in onderzoek en vanuitVerblijfplaatsOnbekend wordt gevraagd
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
    | gba in onderzoek waarde | type                          |
    | 080000                  | hele categorie verblijfplaats |
    | 081400                  | hele groep immigratie         |
    | 081410                  | land vanwaar ingeschreven     |

Regel: aanduiding in onderzoek waarde '089999' zet immigratie velden niet in onderzoek

  Scenario: gevraagde persoon verblijft niet meer op het geregistreerde adres en één of meerdere immigratie velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 089999   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | immigratie                      |
    Dan heeft de response een persoon zonder 'immigratie' gegevens

#language: nl

@post-assert
Functionaliteit: Immigratie

  Abstract Scenario: persoon heeft 'immigratie' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'immigratie' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | immigratie.<naam>               |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                           | naam                         | waarde |
    | land van waar ingeschreven (14.10) | landVanwaarIngeschreven.code | 6014   |

  Abstract Scenario: persoon heeft 'immigratie' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'immigratie' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | <naam>                          |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                             | gba waarde | naam                      | waarde     | lang formaat |
    | datum vestiging in nederland (14.20) | 20020701   | datumVestigingInNederland | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: 'immigratie' veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'immigratie' gegevens
    | naam                                     | waarde                    |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
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

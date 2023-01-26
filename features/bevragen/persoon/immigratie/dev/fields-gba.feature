#language: nl

Functionaliteit: GBA immigratie - vragen van velden met fields

  Abstract Scenario: 'land vanwaar ingeschreven (14.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 6014   |
    Als gba personen wordt gezocht met de volgende parameters
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
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'immigratie' gegevens
    | naam                      | waarde   |
    | datumVestigingInNederland | 20020701 |

    Voorbeelden:
    | fields                                           |
    | immigratie.datumVestigingInNederland             |
    | immigratie.datumVestigingInNederland.type        |
    | immigratie.datumVestigingInNederland.datum       |
    | immigratie.datumVestigingInNederland.langFormaat |
    | immigratie.datumVestigingInNederland.jaar        |
    | immigratie.datumVestigingInNederland.maand       |
    | immigratie.datumVestigingInNederland.onbekend    |

Rule: als één of meerdere immigratie velden van een verblijfplaats wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: '<type>' is in onderzoek en één of meerdere 'immigratie' velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |
    Voorbeelden:
    | aanduiding in onderzoek | fields                                        | type                          |
    | 080000                  | immigratie                                    | hele categorie verblijfplaats |
    | 081400                  | immigratie.landVanwaarIngeschreven            | hele groep immigratie         |
    | 081410                  | immigratie.datumVestigingInNederland          | land vanwaar ingeschreven     |
    | 081420                  | immigratie.indicatieVestigingVanuitBuitenland | datum vestiging in Nederland  |
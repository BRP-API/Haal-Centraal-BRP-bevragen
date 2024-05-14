#language: nl

@gba
Functionaliteit: immigratie velden vragen met fields

Regel: land vanwaar ingeschreven wordt geleverd bij field pad 'immigratie.landVanwaarIngeschreven' of 'immigratie.vanuitVerblijfplaatsOnbekend'

  Abstract Scenario: 'land vanwaar ingeschreven (14.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde   |
    | land vanwaar ingeschreven (14.10)    | 6014     |
    | datum vestiging in Nederland (14.20) | 20020701 |
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
    | immigratie.vanuitVerblijfplaatsOnbekend         |

  Scenario: onbekend waarde voor immigratie: land vanwaar ingeschreven (14.10)
    Gegeven de persoon met burgerservicenummer '000000243' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde |
    | land vanwaar ingeschreven (14.10) | 0000   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                 |
    | type                | RaadpleegMetBurgerservicenummer                        |
    | burgerservicenummer | 000000243                                              |
    | fields              | burgerservicenummer,immigratie.landVanwaarIngeschreven |
    Dan heeft de response een persoon met alleen de volgende gegevens
    | naam                                            | waarde    |
    | burgerservicenummer                             | 000000243 |
    | immigratie.landVanwaarIngeschreven.code         | 0000      |
    | immigratie.landVanwaarIngeschreven.omschrijving | Onbekend  |

Regel: wanneer voor de code geen bijbehorende waarde voorkomt in de tabel, wordt alleen de code geleverd

  Scenario: code voor land vanwaar ingeschreven (14.10) komt niet voor in de tabel Landen
    Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende 'verblijfplaats' gegevens
    | land vanwaar ingeschreven (14.10) |
    | 1234                              |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000255                          |
    | fields              | immigratie.landVanwaarIngeschreven |
    Dan heeft de response een persoon met alleen de volgende 'immigratie' gegevens
    | naam                         | waarde |
    | landVanwaarIngeschreven.code | 1234   |

Regel: datum vestiging in Nederland wordt geleverd bij field pad 'immigratie.datumVestigingInNederland' of 'immigratie.indicatieVestigingVanuitBuitenland'

  Abstract Scenario: 'datum vestiging in nederland (14.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde   |
    | land vanwaar ingeschreven (14.10)    | 6014     |
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
    | immigratie.indicatieVestigingVanuitBuitenland    |

Regel: als één of meerdere immigratie velden van een verblijfplaats wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

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

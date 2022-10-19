#language: nl

Functionaliteit: Persoon velden

  Abstract Scenario: persoon heeft veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <naam>                          |
    Dan heeft de response een persoon met de volgende gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam        | naam    | gba waarde | waarde     |
    | anummer (01.10) | aNummer | 1234567890 | 1234567890 |

  Abstract Scenario: persoon heeft veld: 'geslachtsaanduiding (04.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                        | waarde |
    | geslachtsaanduiding (04.10) | M      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                  | waarde         |
    | geslacht.code         | <code>         |
    | geslacht.omschrijving | <omschrijving> |

    Voorbeelden:
    | field                 | code | omschrijving |
    | geslacht              | M    | man          |
    | geslacht.code         | M    |              |
    | geslacht.omschrijving |      | man          |

  Abstract Scenario: persoon heeft veld: 'gemeente van inschrijving (09.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde       |
    | gemeente van inschrijving (09.10) | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                 | waarde         |
    | gemeenteVanInschrijving.code         | <code>         |
    | gemeenteVanInschrijving.omschrijving | <omschrijving> |

    Voorbeelden:
    | field                                | gba waarde | code | omschrijving |
    | gemeenteVanInschrijving              | 0344       | 0344 | Utrecht      |
    | gemeenteVanInschrijving.code         | 0518       | 0518 |              |
    | gemeenteVanInschrijving.omschrijving | 0599       |      | Rotterdam    |

  Abstract Scenario: persoon heeft veld: 'indicatie geheim (70.10)' met waarde <gba waarde>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde       |
    | indicatie geheim (70.10) | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geheimhoudingPersoonsgegevens   |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                          | waarde |
    | geheimhoudingPersoonsgegevens | true   |

    Voorbeelden:
    | gba waarde |
    | 1          |
    | 2          |
    | 3          |
    | 4          |
    | 5          |
    | 6          |
    | 7          |

  Scenario: persoon heeft veld: 'indicatie geheim (70.10)' met waarde 0
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geheimhoudingPersoonsgegevens   |
    Dan heeft de response een leeg persoon object

  Abstract Scenario: persoon heeft datum veld: 'datum eerste inschrijving GBA (68.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | naam                                  | waarde   |
    | datum eerste inschrijving GBA (68.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                   | waarde      |
    | datumEersteInschrijvingGBA.type        | Datum       |
    | datumEersteInschrijvingGBA.datum       | 2002-07-01  |
    | datumEersteInschrijvingGBA.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | field                                  |
    | datumEersteInschrijvingGBA             |
    | datumEersteInschrijvingGBA.type        |
    | datumEersteInschrijvingGBA.datum       |
    | datumEersteInschrijvingGBA.langFormaat |

  Abstract Scenario: persoon heeft datum veld: 'datum inschrijving in de gemeente (09.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde   |
    | datum inschrijving in de gemeente (09.20) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                    | waarde      |
    | datumInschrijvingInGemeente.type        | Datum       |
    | datumInschrijvingInGemeente.datum       | 2002-07-01  |
    | datumInschrijvingInGemeente.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | field                                   |
    | datumInschrijvingInGemeente             |
    | datumInschrijvingInGemeente.type        |
    | datumInschrijvingInGemeente.datum       |
    | datumInschrijvingInGemeente.langFormaat |

  Abstract Scenario: aanduiding gegevens in onderzoek persoon is gelijk aan <gba in onderzoek waarde>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | inOnderzoek                     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                | waarde                             |
    | inOnderzoek.burgerservicenummer                     | <burgerservicenummer in onderzoek> |
    | inOnderzoek.geslacht                                | <geslacht in onderzoek>            |
    | inOnderzoek.leeftijd                                | <leeftijd in onderzoek>            |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum                              |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01                         |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | burgerservicenummer in onderzoek | geslacht in onderzoek | leeftijd in onderzoek |
    | 010000                  | true                             | true                  | true                  |
    | 010100                  | true                             |                       |                       |
    | 010120                  | true                             |                       |                       |
    | 010300                  |                                  |                       | true                  |
    | 010310                  |                                  |                       | true                  |
    | 010400                  |                                  | true                  |                       |
    | 010410                  |                                  | true                  |                       |

  Abstract Scenario: 'gemeente van inschrijving (09.10)' en/of 'datum inschrijving in de gemeente (09.20)' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | inOnderzoek                     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                 | waarde                                     |
    | inOnderzoek.gemeenteVanInschrijving                  | <gemeenteVanInschrijving in onderzoek>     |
    | inOnderzoek.datumInschrijvingInGemeente              | <datumInschrijvingInGemeente in onderzoek> |
    | inOnderzoek.datumIngangOnderzoekGemeente.type        | Datum                                      |
    | inOnderzoek.datumIngangOnderzoekGemeente.datum       | 2002-07-01                                 |
    | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat | 1 juli 2002                                |

    Voorbeelden:
    | gba in onderzoek waarde | gemeenteVanInschrijving in onderzoek | datumInschrijvingInGemeente in onderzoek |
    | 080000                  | true                                 | true                                     |
    | 080900                  | true                                 | true                                     |
    | 080910                  | true                                 |                                          |
    | 080920                  |                                      | true                                     |

  Abstract Scenario: 'gemeente van inschrijving (09.10)' en/of 'datum inschrijving in de gemeente (09.20)' veld(en) van persoon is/zijn niet in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | inOnderzoek                     |
    Dan heeft de response een leeg persoon object

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081100                  |
    | 081200                  |
    | 081300                  |
    | 081400                  |
    | 088500                  |

  Abstract Scenario: burgerservicenummer is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                | waarde      |
    | burgerservicenummer                                 | 000000152   |
    | inOnderzoek.burgerservicenummer                     | true        |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010100                  |
    | 010120                  |

  Abstract Scenario: geslacht is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | geslachtsaanduiding (04.10)     | O                         |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                | waarde         |
    | geslacht.code                                       | <code>         |
    | geslacht.omschrijving                               | <omschrijving> |
    | inOnderzoek.geslacht                                | true           |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde | field                 | code | omschrijving |
    | 010000                  | geslacht              | O    | onbekend     |
    | 010400                  | geslacht.code         | O    |              |
    | 010410                  | geslacht.omschrijving |      | onbekend     |

  Abstract Scenario: gemeente van inschrijving is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                    |
    | gemeente van inschrijving (09.10) | 0518                      |
    | aanduiding in onderzoek (83.10)   | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)    | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                 | waarde         |
    | gemeenteVanInschrijving.code                         | <code>         |
    | gemeenteVanInschrijving.omschrijving                 | <omschrijving> |
    | inOnderzoek.gemeenteVanInschrijving                  | true           |
    | inOnderzoek.datumIngangOnderzoekGemeente.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoekGemeente.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat | 1 juli 2002    |
    Voorbeelden:
    | gba in onderzoek waarde | field                                | code | omschrijving  |
    | 080000                  | gemeenteVanInschrijving              | 0518 | 's-Gravenhage |
    | 080900                  | gemeenteVanInschrijving.code         | 0518 |               |
    | 080910                  | gemeenteVanInschrijving.omschrijving |      | 's-Gravenhage |

  Abstract Scenario: datum inschrijving in de gemeente is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | datum inschrijving in de gemeente (09.20) | 20020101                  |
    | aanduiding in onderzoek (83.10)           | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)            | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | datumInschrijvingInGemeente     |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                                 | waarde         |
    | datumInschrijvingInGemeente.type                     | Datum          |
    | datumInschrijvingInGemeente.datum                    | 2002-01-01     |
    | datumInschrijvingInGemeente.langFormaat              | 1 januari 2002 |
    | inOnderzoek.datumInschrijvingInGemeente              | true           |
    | inOnderzoek.datumIngangOnderzoekGemeente.type        | Datum          |
    | inOnderzoek.datumIngangOnderzoekGemeente.datum       | 2002-07-01     |
    | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat | 1 juli 2002    |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 080900                  |
    | 080920                  |

  Scenario: 'burgerservicenummer (01.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 010120   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon zonder gegevens

  Abstract Scenario: '<in onderzoek veld>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | <in onderzoek veld>             | <waarde>                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde | in onderzoek veld           | waarde | field   |
    | 010400                  | geslachtsaanduiding (04.10) | M      | aNummer |
    | 010410                  | geslachtsaanduiding (04.10) | V      | aNummer |

  Abstract Scenario: '<in onderzoek veld>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | <in onderzoek veld>             | <waarde>                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde | in onderzoek veld                         | waarde   | field                       |
    | 080910                  | gemeente van inschrijving (09.10)         | 0344     | datumInschrijvingInGemeente |
    | 080920                  | datum inschrijving in de gemeente (09.20) | 20020202 | gemeenteVanInschrijving     |

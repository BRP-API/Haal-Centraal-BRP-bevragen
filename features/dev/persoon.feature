#language: nl

Functionaliteit: Persoon

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
    | naam                                                | waarde      |
    | geslacht.code                                       | O           |
    | geslacht.omschrijving                               | onbekend    |
    | inOnderzoek.geslacht                                | true        |
    | inOnderzoek.datumIngangOnderzoekPersoon.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde | field                 |
    | 010000                  | geslacht              |
    | 010400                  | geslacht.code         |
    | 010410                  | geslacht.omschrijving |

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
    | naam                                                 | waarde        |
    | gemeenteVanInschrijving.code                         | 0518          |
    | gemeenteVanInschrijving.omschrijving                 | 's-Gravenhage |
    | inOnderzoek.gemeenteVanInschrijving                  | true          |
    | inOnderzoek.datumIngangOnderzoekGemeente.type        | Datum         |
    | inOnderzoek.datumIngangOnderzoekGemeente.datum       | 2002-07-01    |
    | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat | 1 juli 2002   |
    Voorbeelden:
    | gba in onderzoek waarde | field                                |
    | 080000                  | gemeenteVanInschrijving              |
    | 080900                  | gemeenteVanInschrijving.code         |
    | 080910                  | gemeenteVanInschrijving.omschrijving |

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

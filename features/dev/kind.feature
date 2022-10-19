#language: nl

Functionaliteit: Kind velden

  Abstract Scenario: kind heeft veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.burgerservicenummer    |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                    | naam                | waarde    |
    | burgerservicenummer (01.20) | burgerservicenummer | 123456789 |

  Abstract Scenario: kind velden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000013                 |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.inOnderzoek            |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam                                         | waarde                             |
    | inOnderzoek.burgerservicenummer              | <burgerservicenummer in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | burgerservicenummer in onderzoek |
    | 090000                  | true                             |
    | 090100                  | true                             |
    | 090120                  | true                             |

  Abstract Scenario: 'burgerservicenummer (01.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000013                 |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.burgerservicenummer    |
    Dan heeft de response een persoon met een 'kind' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | burgerservicenummer                          | 000000013   |
    | inOnderzoek.burgerservicenummer              | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090000                  |
    | 090100                  |
    | 090120                  |

  Abstract Scenario: 'burgerservicenummer (01.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                            | waarde                    |
    | burgerservicenummer (01.20)     | 000000013                 |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | kinderen.naam                   |
    Dan heeft de response een persoon met een 'kind' zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 090120                  |

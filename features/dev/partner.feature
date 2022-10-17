# language: nl

Functionaliteit: partner velden

  Abstract Scenario: partner heeft veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.<naam>                 |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                    | naam                | waarde    |
    | burgerservicenummer (01.20) | burgerservicenummer | 123456789 |

  Abstract Scenario: partner heeft veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam       | waarde |
    | <gba naam> | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.<naam>                 |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                | waarde         |
    | <naam>.code         | <code>         |
    | <naam>.omschrijving | <omschrijving> |

    Voorbeelden:
    | gba naam                    | naam             | code | omschrijving               |
    | geslachtsaanduiding (04.10) | geslacht         | O    | onbekend                   |
    | soort verbintenis (15.10)   | soortVerbintenis | P    | geregistreerd partnerschap |

  Abstract Scenario: partner heeft 'soort verbintenis (15.10)' veld met onbekend waarde
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                      | waarde |
    | soort verbintenis (15.10) | .      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.soortVerbintenis       |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

  Abstract Scenario: veld(en) van partner is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.inOnderzoek            |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde                             |
    | inOnderzoek.burgerservicenummer              | <burgerservicenummer in onderzoek> |
    | inOnderzoek.soortVerbintenis                 | <soort verbintenis in onderzoek>   |
    | inOnderzoek.geslacht                         | <geslacht in onderzoek>            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | burgerservicenummer in onderzoek | soort verbintenis in onderzoek | geslacht in onderzoek |
    | 050000                  | true                             | true                           | true                  |
    | 050100                  | true                             |                                |                       |
    | 050120                  | true                             |                                |                       |
    | 050400                  |                                  |                                | true                  |
    | 050410                  |                                  |                                | true                  |
    | 051500                  |                                  | true                           |                       |
    | 051510                  |                                  | true                           |                       |

  Abstract Scenario: 'burgerservicenummer (01.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | burgerservicenummer (01.20)     | 000000013                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.burgerservicenummer    |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | burgerservicenummer                          | 000000013   |
    | inOnderzoek.burgerservicenummer              | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050100                  |
    | 050120                  |

  Abstract Scenario: 'soort verbintenis (15.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | soort verbintenis (15.10)       | H                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.soortVerbintenis       |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | soortVerbintenis.code                        | H           |
    | soortVerbintenis.omschrijving                | huwelijk    |
    | inOnderzoek.soortVerbintenis                 | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 051500                  |
    | 051510                  |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsaanduiding (04.10)     | V                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geslacht               |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde      |
    | geslacht.code                                | V           |
    | geslacht.omschrijving                        | vrouw       |
    | inOnderzoek.geslacht                         | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050000                  |
    | 050400                  |
    | 050410                  |

  Abstract Scenario: 'burgerservicenummer (01.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | burgerservicenummer (01.20)     | 000000013                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.soortVerbintenis       |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050120                  |

  Abstract Scenario: 'soort verbintenis (15.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | soort verbintenis (15.10)       | H                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.geslacht               |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 051510                  |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geslachtsaanduiding (04.10)     | V                         |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | partners.burgerservicenummer    |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 050410                  |

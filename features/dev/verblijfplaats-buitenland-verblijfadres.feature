# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland -verblijfadres

  Abstract Scenario: persoon heeft 'verblijfplaats' veld: 'land adres buitenland (13.10)' met waarde ongelijk aan '0000'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | land adres buitenland (13.10) | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                   |
    | type                            | VerblijfplaatsBuitenland |
    | verblijfadres.land.code         | <code>                   |
    | verblijfadres.land.omschrijving | <omschrijving>           |

    Voorbeelden:
    | field                                          | code | omschrijving                 |
    | verblijfplaats.verblijfadres.land              | 5034 | Albanië                      |
    | verblijfplaats.verblijfadres.land.code         | 6014 | Verenigde Staten van Amerika |
    | verblijfplaats.verblijfadres.land.omschrijving | 9999 | Internationaal gebied        |

  Abstract Scenario: persoon heeft 'verblijfplaats buitenland' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde   |
    | land adres buitenland (13.10) | 6014     |
    | <gba naam>                    | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | verblijfadres.<naam> | <waarde>                 |

    Voorbeelden:
    | gba naam                         | naam   | waarde                      |
    | regel 1 adres buitenland (13.30) | regel1 | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | regel2 | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | regel3 | Selangor                    |

  Abstract Scenario: persoon heeft 'verblijfplaats buitenland' veld met onbekend waarde: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | <gba naam>                       | <waarde>                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba naam                      | naam | waarde |
    | land adres buitenland (13.10) | land | 0000   |

  Abstract Scenario: 'verblijfadres buitenland' veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 000000152                                |
    | fields              | verblijfplaats.verblijfadres.inOnderzoek |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                   |
    | type                                                       | VerblijfplaatsBuitenland |
    | verblijfadres.inOnderzoek.regel1                           | <regel1 in onderzoek>    |
    | verblijfadres.inOnderzoek.regel2                           | <regel2 in onderzoek>    |
    | verblijfadres.inOnderzoek.regel3                           | <regel3 in onderzoek>    |
    | verblijfadres.inOnderzoek.land                             | <land in onderzoek>      |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | gba in onderzoek waarde | regel1 in onderzoek | regel2 in onderzoek | regel3 in onderzoek | land in onderzoek |
    | 080000                  | true                | true                | true                | true              |
    | 081300                  | true                | true                | true                | true              |
    | 081310                  |                     |                     |                     | true              |
    | 081330                  | true                |                     |                     |                   |
    | 081340                  |                     | true                |                     |                   |
    | 081350                  |                     |                     | true                |                   |

  Abstract Scenario: 'regel 1 adres buitenland (13.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | aanduiding in onderzoek (83.10)  | <gba in onderzoek waarde>   |
    | datum ingang onderzoek (83.20)   | 20020701                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                      |
    | type                                                       | VerblijfplaatsBuitenland    |
    | verblijfadres.regel1                                       | 1600 Pennsylvania Avenue NW |
    | verblijfadres.inOnderzoek.regel1                           | true                        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081300                  |
    | 081330                  |

  Abstract Scenario: 'regel 2 adres buitenland (13.40)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                    |
    | land adres buitenland (13.10)    | 6014                      |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500      |
    | aanduiding in onderzoek (83.10)  | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)   | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel2 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                   |
    | type                                                       | VerblijfplaatsBuitenland |
    | verblijfadres.regel2                                       | Washington, DC 20500     |
    | verblijfadres.inOnderzoek.regel2                           | true                     |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081300                  |
    | 081340                  |

  Abstract Scenario: 'regel 3 adres buitenland (13.50)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                    |
    | land adres buitenland (13.10)    | 6014                      |
    | regel 3 adres buitenland (13.50) | Selangor                  |
    | aanduiding in onderzoek (83.10)  | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)   | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel3 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                   |
    | type                                                       | VerblijfplaatsBuitenland |
    | verblijfadres.regel3                                       | Selangor                 |
    | verblijfadres.inOnderzoek.regel3                           | true                     |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081300                  |
    | 081350                  |

  Abstract Scenario: 'land adres buitenland (13.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 000000152                         |
    | fields              | verblijfplaats.verblijfadres.land |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                       |
    | type                                                       | VerblijfplaatsBuitenland     |
    | verblijfadres.land.code                                    | 6014                         |
    | verblijfadres.land.omschrijving                            | Verenigde Staten van Amerika |
    | verblijfadres.inOnderzoek.land                             | true                         |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081300                  |
    | 081310                  |

  Abstract Scenario: 'regel 1 adres buitenland (13.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | aanduiding in onderzoek (83.10)  | <gba in onderzoek waarde>   |
    | datum ingang onderzoek (83.20)   | 20020701                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel2 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081330                  |

  Abstract Scenario: 'regel 2 adres buitenland (13.40)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                    |
    | land adres buitenland (13.10)    | 6014                      |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500      |
    | aanduiding in onderzoek (83.10)  | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)   | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel3 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081340                  |

  Abstract Scenario: 'regel 3 adres buitenland (13.50)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                    |
    | land adres buitenland (13.10)    | 6014                      |
    | regel 3 adres buitenland (13.50) | Selangor                  |
    | aanduiding in onderzoek (83.10)  | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)   | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081350                  |

  Abstract Scenario: 'land adres buitenland (13.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081310                  |

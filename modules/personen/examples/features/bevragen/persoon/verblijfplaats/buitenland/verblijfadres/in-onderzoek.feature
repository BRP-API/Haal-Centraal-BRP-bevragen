# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland - verblijfadres velden zijn in onderzoek

Regel: Het in onderzoek zijn van een veld en bijbehorende datumIngangOnderzoek worden geleverd als het betreffende veld wordt gevraagd

  Abstract Scenario: '<type>' is in onderzoek en alle verblijfadres velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | <type io>                |
    | inOnderzoek.datumIngangOnderzoek.type        | <datum type>             |
    | inOnderzoek.datumIngangOnderzoek.datum       | <datum>                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | <lang formaat>           |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde                       |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.regel1                           | <regel1 io>                  |
    | inOnderzoek.regel2                           | <regel2 io>                  |
    | inOnderzoek.regel3                           | <regel3 io>                  |
    | inOnderzoek.land                             | <land io>                    |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | aanduiding in onderzoek | type io | regel1 io | regel2 io | regel3 io | land io | datum type | datum      | lang formaat | type                          |
    | 080000                  | true    | true      | true      | true      | true    | Datum      | 2002-07-01 | 1 juli 2002  | hele categorie verblijfplaats |
    | 081300                  | true    | true      | true      | true      | true    | Datum      | 2002-07-01 | 1 juli 2002  | hele groep adres buitenland   |
    | 081310                  | true    |           |           |           | true    | Datum      | 2002-07-01 | 1 juli 2002  | land adres buitenland         |
    | 081330                  |         | true      |           |           |         |            |            |              | regel 1 adres buitenland      |
    | 081340                  |         |           | true      |           |         |            |            |              | regel 2 adres buitenland      |
    | 081350                  |         |           |           | true      |         |            |            |              | regel 3 adres buitenland      |

  Abstract Scenario: 'regel 1 adres buitenland (13.30)' is in onderzoek en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | <type io>                |
    | inOnderzoek.datumIngangOnderzoek.type        | <type>                   |
    | inOnderzoek.datumIngangOnderzoek.datum       | <datum>                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | <lang formaat>           |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.regel1                           | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type io | type  | datum      | lang formaat |
    | 080000                  | true    | Datum | 2002-07-01 | 1 juli 2002  |
    | 081300                  | true    | Datum | 2002-07-01 | 1 juli 2002  |
    | 081330                  |         |       |            |              |

  Abstract Scenario: 'regel 2 adres buitenland (13.40)' is in onderzoek en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel2 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | <type io>                |
    | inOnderzoek.datumIngangOnderzoek.type        | <type>                   |
    | inOnderzoek.datumIngangOnderzoek.datum       | <datum>                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | <lang formaat>           |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.regel2                           | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type io | type  | datum      | lang formaat |
    | 080000                  | true    | Datum | 2002-07-01 | 1 juli 2002  |
    | 081300                  | true    | Datum | 2002-07-01 | 1 juli 2002  |
    | 081340                  |         |       |            |              |

  Abstract Scenario: 'regel 3 adres buitenland (13.50)' is in onderzoek en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel3 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | <type io>                |
    | inOnderzoek.datumIngangOnderzoek.type        | <type>                   |
    | inOnderzoek.datumIngangOnderzoek.datum       | <datum>                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | <lang formaat>           |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.regel3                           | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | type io | type  | datum      | lang formaat |
    | 080000                  | true    | Datum | 2002-07-01 | 1 juli 2002  |
    | 081300                  | true    | Datum | 2002-07-01 | 1 juli 2002  |
    | 081350                  |         |       |            |              |

  Abstract Scenario: 'land adres buitenland (13.10)' is in onderzoek en wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 000000152                         |
    | fields              | verblijfplaats.verblijfadres.land |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | true                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde                       |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.land                             | true                         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | aanduiding in onderzoek |
    | 080000                  |
    | 081300                  |
    | 081310                  |

  Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                     | veld naam | gevraagde fields                    |
    | 081330                  | regel 1 adres buitenland | regel1    | verblijfplaats.verblijfadres.regel2 |
    | 081340                  | regel 2 adres buitenland | regel2    | verblijfplaats.verblijfadres.regel3 |
    | 081350                  | regel 3 adres buitenland | regel3    | verblijfplaats.verblijfadres.regel1 |

  Scenario: 'land adres buitenland (13.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | land adres buitenland (13.10)   | 6014     |
    | aanduiding in onderzoek (83.10) | 081310   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | true                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

Regel: 'type' veld van 'verblijfplaats buitenland' is in onderzoek als het identificerende gegeven van verblijfplaats buitenland ('land adres buitenland (13.10)') in onderzoek is

  Abstract Scenario: '<type>' veld is in onderzoek en regel1 wordt gevraagd
  
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | true                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde         |
    | inOnderzoek.regel1                           | <regel1 io>    |
    | inOnderzoek.datumIngangOnderzoek.type        | <datum type>   |
    | inOnderzoek.datumIngangOnderzoek.datum       | <datum>        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | <lang formaat> |

  Voorbeelden:
    | aanduiding in onderzoek | regel1 io | datum type | datum      | lang formaat | type                          |
    | 080000                  | true      | Datum      | 2002-07-01 | 1 juli 2002  | hele categorie verblijfplaats |
    | 081300                  | true      | Datum      | 2002-07-01 | 1 juli 2002  | hele groep adres buitenland   |

  Scenario: 'land adres buitenland' veld is in onderzoek en regel1 wordt gevraagd
  
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | 081310 |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                   |
    | type                                         | VerblijfplaatsBuitenland |
    | inOnderzoek.type                             | true                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

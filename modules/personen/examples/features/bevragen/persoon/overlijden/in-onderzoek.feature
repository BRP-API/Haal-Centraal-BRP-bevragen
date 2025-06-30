#language: nl

Functionaliteit: overlijden velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle overlijden velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 20020601                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | datum.type                                   | Datum       |
    | datum.datum                                  | 2002-06-01  |
    | datum.langFormaat                            | 1 juni 2002 |
    | inOnderzoek.datum                            | <datum io>  |
    | inOnderzoek.plaats                           | <plaats io> |
    | inOnderzoek.land                             | <land io>   |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | datum io | plaats io | land io | type                      |
    | 060000                  | true     | true      | true    | hele categorie overlijden |
    | 060800                  | true     | true      | true    | hele groep overlijden     |
    | 060810                  | true     |           |         | datum overlijden          |
    | 060820                  |          | true      |         | plaats overlijden         |
    | 060830                  |          |           | true    | land overlijden           |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 20020601                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.<field>              |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | datum.type                                   | Datum       |
    | datum.datum                                  | 2002-06-01  |
    | datum.langFormaat                            | 1 juni 2002 |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | field | type                      |
    | 060000                  | datum | hele categorie overlijden |
    | 060800                  | datum | hele groep overlijden     |
    | 060810                  | datum | datum overlijden          |

  Abstract Scenario: '<type>' is in onderzoek en '<field>' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 20020601                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.<field>              |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.<field>                          | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | aanduiding in onderzoek | field  | type                      |
    | 060000                  | plaats | hele categorie overlijden |
    | 060800                  | plaats | hele groep overlijden     |
    | 060820                  | plaats | plaats overlijden         |
    | 060000                  | land   | hele categorie overlijden |
    | 060800                  | land   | hele groep overlijden     |
    | 060830                  | land   | land overlijden           |

  Abstract Scenario: '<type>' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.<field>              |
    Dan heeft de response een persoon zonder 'overlijden' gegevens

    Voorbeelden:
    | aanduiding in onderzoek | field  | type              |
    | 060810                  | plaats | datum overlijden  |
    | 060820                  | land   | plaats overlijden |
    | 060830                  | datum  | land overlijden   |

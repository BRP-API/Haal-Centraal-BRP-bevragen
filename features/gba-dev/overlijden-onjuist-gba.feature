#language: nl

Functionaliteit: GBA Persoon: overlijden

  Scenario: persoon heeft 'overlijden' datum veld: 'datum overlijden (08.10)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                     | waarde   |
    | datum overlijden (08.10) | 20020701 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.datum                |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam  | waarde   |
    | datum | 20020701 |

  Abstract Scenario: persoon heeft 'overlijden' waardetabel veld: 'plaats overlijden (08.20)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                      | waarde |
    | plaats overlijden (08.20) | 0518   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                | waarde        |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |

    Voorbeelden:
    | field                          |
    | overlijden.plaats              |
    | overlijden.plaats.code         |
    | overlijden.plaats.omschrijving |

  Abstract Scenario: persoon heeft 'overlijden' waardetabel veld: 'land overlijden (08.30)'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                    | waarde |
    | land overlijden (08.30) | 6014   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam               | waarde                       |
    | land.code          | 6014                         |
    | land.omschrijving  | Verenigde Staten van Amerika |

    Voorbeelden:
    | field                        |
    | overlijden.land              |
    | overlijden.land.code         |
    | overlijden.land.omschrijving |

  Scenario: land en plaats zijn onbekend
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | plaats overlijden (08.20)       | 0000                      |
    | datum overlijden (08.10)        | 20021701                  |
    | land overlijden (08.30)         | 0000                      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                | waarde                       |
    | datum               | 20021701                     |



  Scenario: overlijden veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | datum overlijden (08.10)        | 19630405                  |
    | aanduiding in onderzoek (83.10) | 060830                    |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.inOnderzoek          |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                           | waarde   |
    | inOnderzoek.aanduidingGegevensInOnderzoek      | 060830   |
    | inOnderzoek.datumIngangOnderzoek               | 20020701 |

  Abstract Scenario: datum overlijden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 19630405                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.datum                |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde                    |
    | datum                                        | 19630405                  |
    | inOnderzoek.datumIngangOnderzoek             | 20020701                  |
    | inOnderzoek.aanduidingGegevensInOnderzoek    | <gba in onderzoek waarde> |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060000                  |
    | 060800                  |
    | 060810                  |

  Abstract Scenario: plaats overlijden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | plaats overlijden (08.20)       | 0518                      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.plaats               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde                    |
    | plaats.code                                  | 0518                      |
    | plaats.omschrijving                          | 's-Gravenhage             |
    | inOnderzoek.datumIngangOnderzoek             | 20020701                  |
    | inOnderzoek.aanduidingGegevensInOnderzoek    | <gba in onderzoek waarde> |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060000                  |
    | 060800                  |
    | 060820                  |

  Abstract Scenario: land overlijden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | land overlijden (08.30)         | 6014                      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.land                 |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde                       |
    | land.code                                    | 6014                         |
    | land.omschrijving                            | Verenigde Staten van Amerika |
    | inOnderzoek.datumIngangOnderzoek             | 20020701                     |
    | inOnderzoek.aanduidingGegevensInOnderzoek    | <gba in onderzoek waarde>    |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 060000                  |
    | 060800                  |
    | 060830                  |

  Scenario: datum overlijden is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | 060810                    |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum overlijden (08.10)        | 19630405                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.plaats               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datumIngangOnderzoek             | 20020701    |
    | inOnderzoek.aanduidingGegevensInOnderzoek    | 060810      |

  Scenario: plaats overlijden is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | 060820                    |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | plaats overlijden (08.20)       | 0518                      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.datum                |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datumIngangOnderzoek             | 20020701    |
    | inOnderzoek.aanduidingGegevensInOnderzoek    | 060820      |

  Scenario: land overlijden is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | 060830                    |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | land overlijden (08.30)         | 6014                      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden.plaats               |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                                         | waarde      |
    | inOnderzoek.datumIngangOnderzoek             | 20020701    |
    | inOnderzoek.aanduidingGegevensInOnderzoek    | 060830      |

  Rule: Onjuiste gegevens worden niet geleverd

  Scenario: land overlijden is onjuist en gecorrigeerd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
    | naam                            | waarde                    |
    | plaats overlijden (08.20)       | 0344                      |
    | datum overlijden (08.10)        | 20020701                  |
    | land overlijden (08.30)         | 5018                      |
    En het 'overlijden' is gecorrigeerd naar de volgende gegevens
    | naam                            | waarde                    |
    | plaats overlijden (08.20)       | 0344                      |
    | datum overlijden (08.10)        | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | overlijden                      |
    Dan heeft de response een persoon met de volgende 'overlijden' gegevens
    | naam                | waarde                       |
    | datum               | 20020701                     |
    | plaats.code         | 0344                         |
    | plaats.omschrijving | Utrecht                      |
